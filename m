Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AD8FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC59-0005qE-GZ; Wed, 29 Apr 2026 17:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC58-0005nU-5W
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC56-0003PZ-Q0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BK3c2W6DMmyWJuLoOeRh4eKpwnPSyzyiOLd1z1qjiBM=;
 b=doIe5oH21FxAPJr+PFFcX3rz4yJ+sDx8nszOFDNiJ+aTR7dYo2sYSV2hLNu6CRq+ZSGcOu
 VzslVfwab9cidfnPR9z369maPsEa3ZiFgdvw4D/euFr6a0uI2uOIzEWOmsegUuGjG0sGEj
 kUJKRg1coBCqBuu6AK0L+URT3FnCLaA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-68jPbWKXP_qLnpsjLx70mw-1; Wed,
 29 Apr 2026 17:04:24 -0400
X-MC-Unique: 68jPbWKXP_qLnpsjLx70mw-1
X-Mimecast-MFC-AGG-ID: 68jPbWKXP_qLnpsjLx70mw_1777496663
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3B8419560B5; Wed, 29 Apr 2026 21:04:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7D411800480; Wed, 29 Apr 2026 21:04:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:45 +0400
Subject: [PATCH v3 12/26] ui: move FONT_WIDTH/HEIGHT to vgafont.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-12-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=643;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n2GeqMeQQVy2zQA4Nr3GV7Ks0o8e625Vkmet5L8y+uQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILy7Y6vusiyAX44w7elLOWnF/mbhA7Elfsx
 sCDKsYVus6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5bD5EAClNgzL7i6zQ10uD66OmAO3ZoSVioHeJXdHotLVWsE5DnWtiVKMUdqnEBCNgs8jQNJTfxF
 60LSqhd13mShQMcbKtEUQHOfTH0ptRyOGyxwZoLjUhcusifzj57pi0lmEGT5lhby75AGPCT9t6o
 bMZ80awUIx1urYC/zLRE3tHgBl9w9pZ6noNTyY/W6goJoPhO278K7MdvKP+DFNvV1+YqbW/nbJ1
 RLP1cil0cgRfhaAK87C9LQG+amNw/o5r9KNe0MKfNGmj8kydKvERLMZmfvIh+CDt1mpDY1wP8+L
 xNJSLJBbXpKRZGyAiP5dRJiofiIE5C2SrpbktRJYeK0nEH4FZXgZp3ACFlu2zt33hdlLuQtwHY6
 SYY5Wv95pRYeHckxn9qc27xDI+SP6JS3Y2u+aG2c4Dy6DUw9703pKhMIOWiqxx2jhRxIsAIuOlz
 vMhpoii+NHuzHGQAClWw0Gi8K7hkgSrm7DPTJfXRyeXPBRYrbtnP3Z8mrk+UCpi1CB/xSNYrDJn
 zgbd7gb1fsORnKWK1HGHUpTat+qkwSG8xnrCktP3tfUnopExC4CYwmp9DGjbJNbLk/DokynAvVH
 munkor1eiI8sIrk46sYSCsnyfu7QiAem17t6bXNJm5qtZGtgY7+iOJWCudxdXJyIygWlfxHaU7e
 NZRTDOrKKk1Kg3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since those values are related to the VGA font, it make sense to move
them here.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index b9da9ddf30d..457d071c774 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -13,6 +13,7 @@
 #include "ui/console.h"
 #include "ui/vgafont.h"
 #include "ui/cp437.h"
+#include "ui/vgafont.h"
 
 #include "pixman.h"
 #include "trace.h"

-- 
2.54.0



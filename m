Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE81C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLO-0002V7-Fn; Tue, 25 Aug 2026 07:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLI-0002Hg-RU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLG-0005ss-Vy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQtibtTkqPOV+4busv/ixyk3PWldIZMUlgw3IT5bBGM=;
 b=UPr/ECULw+unjPmGUZkiZkI8koaEgNljwnwtoydrXQ250iII3oMRbbzQZsusVVhSxr0rB1
 oNXWpN/qg67RqbyaNzRrr7MyU3HmUIezYTaQTky5S4KVfFEnr99F1WjnxubqzR1KwRuuhG
 XRgI+jg5DC3TLKYsqcudoo3/41iGpqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-OxrFeqWKMO-6ePjwVYxjtA-1; Tue,
 25 Aug 2026 07:29:18 -0400
X-MC-Unique: OxrFeqWKMO-6ePjwVYxjtA-1
X-Mimecast-MFC-AGG-ID: OxrFeqWKMO-6ePjwVYxjtA_1787657357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BC101921EDE; Tue, 25 Aug 2026 11:29:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFB641800644; Tue, 25 Aug 2026 11:29:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:56 +0400
Subject: [GIT PULL 06/19] crypto: fix build against nettle >= 4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-6-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=885;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KM+m0Y823YuKZGWN8r5j0so3rITSfA8JzFB/G31XLLM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUauTyEh4C6/09ocGMqyoDpUJPbniVVTtQD
 ZRq+9VdT1uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5e7hD/9czqfbVIKEn57eoqPQfIgzLzzrVvWqX/DrVNCQSuXR5bOf+s4U7EUMNN+6H87gavJqIuR
 AcpAs+vpBbNrHrOs54skIKPaRurKyvJqvb1xyQiWCO7JVabATaKJU7WnFuqhcE9LOjqu8If4+UX
 bJ7kRIK1XI6GK6Ou4fvxvajFa5O6t2x7ZObubs4b5bsC8kY28JKHf52Zkk1bSLAqweuR792gDep
 TWYHxW1xM4f4OqK/5xTm+Ezqis4TLcyMOBVv7odwIWq85wNoL41V7/5GpaJ9mDEMG4o1+iMlJra
 PeQURyUYLvCAxy7bbNcqDF+AJZuAM1wUdJdBCTbt9eKSzU4dJECwFPTGHG+E6ohH8Zt2PsBuC1P
 rQxxVAT4loRA3hgGwcqseO/571KmpyvGHjYzXjHZTFPz2fF0Z0OM9ZsciIMJKUpTewp9ojtpZr4
 5wk5kmXb+3492iL2PpNl/mey54WWxCgPTd10mJ/31d0siTsV+xc6vBzwwlBec9Oe19we1RazslN
 iPwOoEcjCSHy3yRaNdkCpgWsAOJqwMe9Xv/pcRTKn0uIImAEXOKHHERYBDMBMrJLT528pUtBTKm
 nhrzRobzKc9y0GR9Pfp6LL5tLMzmNxAirdLleA2ZuT6JybxecqBCRMtH8vyigJBS+MjoWuQf+wW
 aAXPLl7JuXfnESg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

sha.h has been deprecated. It seems we can rely on sha1.h/sha2.h
since we depend on >= 3.7.3.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4184
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 crypto/hash-nettle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 53f68301efb5..2589bbf4c10e 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -24,7 +24,8 @@
 #include "crypto/hash.h"
 #include "hashpriv.h"
 #include <nettle/md5.h>
-#include <nettle/sha.h>
+#include <nettle/sha1.h>
+#include <nettle/sha2.h>
 #include <nettle/ripemd160.h>
 #ifdef CONFIG_CRYPTO_SM3
 #include <nettle/sm3.h>

-- 
2.55.0.543.g5ebe2ebe4ea8



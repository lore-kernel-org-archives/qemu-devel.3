Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E1CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8i-0000c2-Ep; Wed, 17 Jun 2026 11:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8X-0008Tn-Q7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8V-0004V4-7l
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPe0ZtgcgplBe9clL4K9XGe/1YuhoCFrRqqQUH4p+LM=;
 b=Qpxb6DNmj3r1jJSQIQRv0dB8h3kcQShkrPiztpsbWDjRB6oykrxy1IznHsXhO5443Ws1Fh
 AEcX+xzGudiiaRXTVeQSkBgR/OWQ8K9TveRF+XUj3ZX4aJkQvW4rAjZQ81o1uQvqarUJZT
 luI57xj1jRp03kctmnn3FUvW35jUpC8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-FBJB761lO_SScMQ8k4n2EA-1; Wed,
 17 Jun 2026 11:25:00 -0400
X-MC-Unique: FBJB761lO_SScMQ8k4n2EA-1
X-Mimecast-MFC-AGG-ID: FBJB761lO_SScMQ8k4n2EA_1781709899
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE3F1806C8F
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:24:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EB4E36918; Wed, 17 Jun 2026 15:24:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:14 +0400
Subject: [GIT PULL 17/27] hw/input/hid: use
 qemu_input_handler_set_leds_mask() for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-17-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=858;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eSz1oEtt5TSsU8DookHorgm0XH4U/qXJH5qx7l6b0+c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpguNebkFCOGrGX/i6R9qADK9MZbaZmcYne
 99Bov4Ulr6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5VyPEACDSEM8VooJx3Or9H+KDbjr8RPBbfjW9SKJwmbHAL3l8cstXlSjfIbAh/91mO6QAMSz8pS
 YYEQoyTrhIThQ7L3gxKcUMcnksCFMtdfdSJ7sLAJ3f7sfD43ZoPj8NaTTEK0ZA2VQAyrS3eZZ9j
 z6ZnLbVMgkcrqQA5WrsPVdJEchC4weeFdy8Bp3gVsb5okLcpJWu7sAQUNdTmUiKiQ01He3FjcGV
 n07joz846ddzsHrjxe9agdiyWOHg6ChZpyRE1H5Hx2mqaKs3/ViMOzi9CJ0M4BTERQEu7BScTaH
 K3DFJspt/GkSHHp6IhZCelnTKphkR2Bs3Ph97P/BqkM22VVFlQ6A5ImokWfXn9bEB+oe2LrfZ7e
 2MixNKBn2tmkuPlOOZ6RrHo//fMd87yywgBYuaTNy5j+IXq2TPpwwK94H4hqmkGRD5IQEpdSW/2
 O6fvYJkenryCa984Fzj9MlM8h1chwyjiQcLD7YYNRl7AtRdKWXf3KR7Lnxiq1aSpMJ0AfH3v+SJ
 UE8lgvQ9JSs2iSo9+gQ2M9b+bz5zd+PwpaqChfqWVO+aACn2MlJ6nHgpCsUjMxec+p/88/X7Nze
 VMUuV8XvQtC/NrNULVWuKm81trNf3i0qU0Jj5I6niAMc6bQvHaJ97ZQRg7wj1+XpSlAJ0tRJ1xz
 ehlp/+oPLz81pPw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 467ba8f14f3..0f28827554e 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "ui/input.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
 #include "migration/vmstate.h"
@@ -470,7 +471,7 @@ int hid_keyboard_write(HIDState *hs, uint8_t *buf, int len)
         if (hs->kbd.leds & 0x02) {
             ledstate |= QEMU_CAPS_LOCK_LED;
         }
-        kbd_put_ledstate(ledstate);
+        qemu_input_handler_set_leds_mask(hs->s, ledstate);
         return 1;
     }
     return 0;

-- 
2.54.0



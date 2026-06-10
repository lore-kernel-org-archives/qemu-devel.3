Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753C0CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGeI-0005Vt-Lz; Wed, 10 Jun 2026 06:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeH-0005Rf-6i
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGeF-0008Ax-Hi
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVwvbSd0OrB/pLvMzG/RW2SPdBdDyZxlIjg2PbK6wY=;
 b=PDv7ipq5fbQppuoZW5jWGKR/Bj3WLP95q5ZdSESHEBkX7AqdurpFpUhHQhDK93a0cZFca+
 dydUttFjykdIlr+7me+/1xrcxnKXIEb2mFng/leMI+006Kable02rUwf/jghiuQ0xdD7Gr
 eMfDXUq4k5MWcZOPjpcOJ4tKqpCX3w4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-F_5iGebrMhaM81t9i0-EiQ-1; Wed,
 10 Jun 2026 06:58:58 -0400
X-MC-Unique: F_5iGebrMhaM81t9i0-EiQ-1
X-Mimecast-MFC-AGG-ID: F_5iGebrMhaM81t9i0-EiQ_1781089137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F106618307E5; Wed, 10 Jun 2026 10:58:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B4A7C1954B09; Wed, 10 Jun 2026 10:58:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:56:59 +0400
Subject: [PATCH v2 17/22] hw/input/hid: use qemu_input_handler_set_led()
 for LED state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-17-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=788;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZtFjNPqtjzK8POC7BkT2jb6wYCgMKEiur3NINOMCbNk=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGopQwGjFcH8StruX19jshitWsYml9Gxb4n/wSm/oMk4ft9fY
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqKUMBAAoJENro4Ql1lpzl+OsQALQ9
 FlSMNTMdRm4NHLxChhLSD69SmsVWx3/m69cJFmFLRwE3nd+WDCCjyuqhn09jUxonVe5LekwkTPJ
 qXe/TQb4xnHGRiL250Emq6f/cSrVCTmdVDSwRyYEUW0R2C5XmJ7WtEAkhY1JoFk8LJf9KZ99yQU
 JaNqU1qU5/FsMzke+iFcco4wSEqKJSSD6qsLz/02MV/dX20/b1rWghIfdgu7KDhveWMdRx/5KLR
 rR8bjyBQL4C9V/rU7WIvRqKR1TNfEq92IhzZi6WGC9rw+t3kFvs/+v4JCoCFHkQmXDmgr1vnDcC
 18XLpZfCcxcNmYJPFwq1g7wifWBnVFZTx0O8HqBxw39xpxXjVv0254L/XvFDcUT5Fu2RapK+lDS
 1FMAsnL3Y9NFaqGsKirg2BEOlma7lJq3mQk9jBoAcqUoDL+QIO8vsvuFerY8ajO+W18jmq6+9fs
 Hi5vRjMkCxjYvikLDJNoxLZwJWse4N/EAdvMnCntDahUH4xUW094x79jiGQ/2hb3NzOm75KAWu3
 T53lPQqZVqGCHI+N8DnN80FI4i636yqmsieqqlmkBJHR/S6FbypKQ81LB37nsfPY/R2bfFnvVWb
 3n8rhCnx+lCPrpY9ta1QaHrbTwYFISHF3DDw80Dgi9NzW8pd56XM1FwmLtSLV6PSmka5T8lN2qe
 l9Azs
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/hid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 467ba8f14f3..d386e52585c 100644
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
+        qemu_input_handler_set_led(hs->s, ledstate);
         return 1;
     }
     return 0;

-- 
2.54.0



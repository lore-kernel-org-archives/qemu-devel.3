Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE32C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyzK-0002pD-U7; Tue, 13 Feb 2024 15:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyy1-0001em-Am
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxx-0001sI-OE
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPacf57cv+s+u41vQHu7kQi06cdjYXiQrL26bSu/Qfs=; b=K9ja7ZNs5XyTu0vHpEj1Kq99Ki
 fTGTVOzCekqHvbhEb8/qi3amU9FzC0gaPjR02e2SjGvxeVGbKg46CKx1E3XJsZWY9FVgG0ypWp0yh
 0OWIeKSW/YFznA3qmYte2SyKTJRR2lBP/ACZa7tVB2go3i7+cjL2lx1STtSRelGUhDhD9EhycvsOS
 uWpLpc28Cft0DkKQPtTzOQPEAsgkJLv6JjuXwfFNIf1MG8LnPC+LRHIIDCcW3dWBlZ2PFxqToVYiB
 oRfbaDZRke8OKe1tQcAfTJJGemftTfBB/5OYtZZzGXfqAhfO1Z++8YwdNcr7tcLzGBJ9EdfsTiNCY
 pU8095ieJgY78y2pWiSewCyjDRysVLSfCi7O6Cr0Pkz3ym38TRIKOL+BKjtFv96ZPlLUd8oeReSgq
 K2q1+KZZoUfBeNXsEhRcvQxZ4L3XEnQM0elHrtqhDye8b7zir9OIlJ9TjLMg8leHeiwuNICzacovP
 blQH3wiIzhAsGKrxHyZkyJkQM9tgMbXv5N/c19yaGArNLyTp72QY9rSDum6haFKGnwhRR4MnklRVI
 159fraE1UuR1U6sv4HRSGKP6QQvfAm3wpQ4iyybWyNudBQ4f6+aoSJW2l8Gx6+pjOYs8lGKv9XLpX
 yROX+3RiOomPyg8cduYhrwNawklObgHDa8ofxqMio=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyi7-0008m4-2Q; Tue, 13 Feb 2024 19:44:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:51 +0000
Message-Id: <20240213194052.1162753-88-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 87/88] esp.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The use of the DEFINE_TYPES() macro will soon be recommended over the use of
calling type_init() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240112125420.514425-88-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 04615d8b5f..b8762d5ee0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1549,14 +1549,6 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo sysbus_esp_info = {
-    .name          = TYPE_SYSBUS_ESP,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_init = sysbus_esp_init,
-    .instance_size = sizeof(SysBusESPState),
-    .class_init    = sysbus_esp_class_init,
-};
-
 static void esp_finalize(Object *obj)
 {
     ESPState *s = ESP(obj);
@@ -1582,19 +1574,22 @@ static void esp_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-static const TypeInfo esp_info = {
-    .name = TYPE_ESP,
-    .parent = TYPE_DEVICE,
-    .instance_init = esp_init,
-    .instance_finalize = esp_finalize,
-    .instance_size = sizeof(ESPState),
-    .class_init = esp_class_init,
+static const TypeInfo esp_info_types[] = {
+    {
+        .name          = TYPE_SYSBUS_ESP,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_init = sysbus_esp_init,
+        .instance_size = sizeof(SysBusESPState),
+        .class_init    = sysbus_esp_class_init,
+    },
+    {
+        .name = TYPE_ESP,
+        .parent = TYPE_DEVICE,
+        .instance_init = esp_init,
+        .instance_finalize = esp_finalize,
+        .instance_size = sizeof(ESPState),
+        .class_init = esp_class_init,
+    },
 };
 
-static void esp_register_types(void)
-{
-    type_register_static(&sysbus_esp_info);
-    type_register_static(&esp_info);
-}
-
-type_init(esp_register_types)
+DEFINE_TYPES(esp_info_types)
-- 
2.39.2



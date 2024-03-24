Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB73C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMN-0008Rt-QQ; Sun, 24 Mar 2024 15:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMM-0008Ez-A1
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMK-0005Nd-Qa
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UknKXcdUNSvY0ijF9Z/LnlJlCg6n6wA0k3it0IJ3DeE=; b=wt9K2ENog3UO7eTYcmDCTjp9fV
 EfCS9e0N0t/H8VGAHs9+y5iwyOiFPoy5NaXjudR+QhjnOhxrAO5aNiBS0/cNly0dYP9gr5V4Idvdh
 42lr1CyYzRi31tDnZQGtGQBjDwhDYxH5G+BlL7veoAIyHTYBCytGu84Uxy/vvGu68HCbzTzqP674C
 jeQeeWY7LApYvqTxuDwXTp0FLLHIOxnf0Xa//u+thQyDDMQ/Q5hHxYPuQwpB+/5wgcKC1XK6ZxmWw
 nCKxOW5StolVDLLWg2jfmkrEK1zScKRf7GNQiiHqBNtgulPPIMnnI5oZGy7bx7d2Gt+ESbLKNuJmF
 WaAi1QoUxqWlpK5+O9JRu5FCOKm4TS96IcykhEDsfsb/v6jpU92WL8vfTLd+fc10Y7Bysoet3nu+s
 h4/2Q8GNfhKFRPGDDx1Tm6asyPeASafiPq06+s+sF734HEhg67fT/Vu1cZ93lV5AxAXWpQ5soPfB2
 RK1XDzk95BjhWq7YvjsCYykuUfcqnwTlK33KDOUxkMNOIZdhm2OBW3W4AmY5W9Ru6Gk0B852RrlF/
 oTTRzoXQ6b8tRKejLI1/3iP/tmerNRagkKQnnDCXV/HaUmTJYYhBofEivh1V5HcEYZptad6wnob1T
 8KtUoV3WfW+Knlw6dzGiywo5xYhIxF+csNGXQs514=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLM-0000dj-0u; Sun, 24 Mar 2024 19:17:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:04 +0000
Message-Id: <20240324191707.623175-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 15/17] esp.c: update esp_fifo_{push,
 pop}() to call esp_update_drq()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This ensures that the DRQ line is always set correctly when reading/writing
single bytes to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6fd1a12f23..4895181ec1 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -170,10 +170,11 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
-        return;
+    } else {
+        fifo8_push(&s->fifo, val);
     }
 
-    fifo8_push(&s->fifo, val);
+    esp_update_drq(s);
 }
 
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
@@ -184,11 +185,16 @@ static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 
 static uint8_t esp_fifo_pop(ESPState *s)
 {
+    uint8_t val;
+
     if (fifo8_is_empty(&s->fifo)) {
-        return 0;
+        val = 0;
+    } else {
+        val = fifo8_pop(&s->fifo);
     }
 
-    return fifo8_pop(&s->fifo);
+    esp_update_drq(s);
+    return val;
 }
 
 static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
-- 
2.39.2



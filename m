Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DACC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz03-0003nL-2n; Tue, 13 Feb 2024 15:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyc-0002MC-GF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:00 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyya-0001wp-U1
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5tsbqbWziA7rxQL/rF+IBFUInDY6z+t7XYQwcNJxq7o=; b=cAVQkLfraRRfCbFOX+TjqpTnoR
 KsI7oT63jSRdy/QQpo3CAvnh2JIJQIOx3yykvI9UrzpxpD9/PRXz1Kc/t9onIv2HhkBmzUOxW60tL
 deKArZSqPQ+IweNpbVrtKrJ1rQvbVldxNc5+WS92D9yDvlzQHXJI6Xp9FWsuX94R6DlK1xxg8sDwL
 OzwyPXcfG40kX3KKqcdoPeB/NPoJMnn2Udpx8aS5zIgc8u9GJ5pIczoIIUOXvzwLKEZ8c9vOXOyRa
 idehMKlfzW06iEj4kF91TIemQ+lHpMM6pfdm6mOOYylgfBGVtbNDm7GqV61aSccSB/M5wtWPkWEYe
 K7KGy5DYVWYbqJiJ9G5FUMepFMrf1mLswH8Df0WohSQQMDbap2515rEObyyPAcxvvxR+Px1k4fEmc
 TSAxn1jGkIDvIUs1PiSYkYYMyIBJpdB1Bfjg3nYptEATv+pQmmkLZRaGebHLOFSORszgN/loTJcgI
 IDvIWVs2JoJC3rL+WheIuMFptWHdDk6uf0/VXaaNxG748ughlhGSraHAPDB5XCjPEmI0XMln2o8u7
 p+JduQ4qO7wG2pdGo3vvzgB9yHj/c6JuzxtDQUv6VU8JX5OfWNyUDqd5phvAg8MD2ui0wV6YtJ8m7
 6rxDoSxbwYgcTnyundKad8AbAzxnqDXLDiwDVIINI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhy-0008m4-5N; Tue, 13 Feb 2024 19:44:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:47 +0000
Message-Id: <20240213194052.1162753-84-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 83/88] esp.c: replace n variable with len in esp_do_nodma()
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

This brings esp_do_nodma() in line with esp_do_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-84-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 879e311bc4..73379a3c65 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -675,16 +675,16 @@ static void esp_do_nodma(ESPState *s)
 {
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
-    int n;
+    int len;
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
@@ -701,9 +701,9 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, 1);
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
@@ -718,9 +718,9 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* ATN remains asserted until FIFO empty */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
@@ -736,9 +736,9 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             cmdlen = fifo8_num_used(&s->cmdfifo);
             trace_esp_handle_ti_cmd(cmdlen);
@@ -754,7 +754,7 @@ static void esp_do_nodma(ESPState *s)
                  * service interrupt to indicate transfer complete. Otherwise
                  * defer until the next FIFO write.
                  */
-                if (n) {
+                if (len) {
                     /* Raise interrupt to indicate transfer complete */
                     s->rregs[ESP_RINTR] |= INTR_BS;
                     esp_raise_irq(s);
@@ -765,9 +765,9 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
             /* Copy FIFO into cmdfifo */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
             if (esp_cdb_length(s) && esp_cdb_length(s) ==
@@ -780,9 +780,9 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB: copy to cmdfifo and execute */
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
+            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = MIN(fifo8_num_free(&s->cmdfifo), len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
 
             do_cmd(s);
             break;
-- 
2.39.2



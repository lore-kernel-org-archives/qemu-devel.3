Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86270C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5QX-0006Cf-4a; Fri, 16 Feb 2024 16:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QT-0006BW-0s
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QQ-0005Oj-Eu
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lw8//lSc6Mq8MOSxXg0a/v6O5ctJELxo7DCvrAv0b7A=; b=wP+2Oc8K1TOdBWZnTI0VYzKSWc
 bwSv3FK+8A1tjXGPSCwy58191Wmkwbw4hrzrkcPQkWIyh2vbDbGiuVVNPbDqqcKhkYhGgXXWS9z61
 wi3ZX6r9F0Fld9lhFCppDLujMsxjIR6k0+i9uegweoHG24vvQQyoEUBsPNYEC8fTJIQ3HO9RTaATD
 +91i9wcsnyEdJFcoAFp385pVZXLfgmXnUOcInWBxvzB93ID7K2VeOjW2sz3AwK+fw3a9jJBb6eMVY
 KqvuyxxNte6wh75iKe3kD1jsiduTRP0hzWJtpm2XNwBVh65QOI6gfdJAV9Qa8s+9A8yTIOb6akRRR
 +U/U3rscBZs6JjTWkl1x2sjC65o3UGkv7D2tymyo9rao/WcYaKdd3pD2mn6VjcuJoouBXduvxx3FU
 uWnGuqnXvdghNxqgMgY+ozmNIPCbV9oDUD6L0HalPZinsFojMAMWR/ogJUDTG/9LUNt/mu9MPy0bE
 uBn1IZ0YlcEf/cdHz/y08VH3zlg4spGpojTxTasJhxJTNgIL87Vsw//XnOgAf4VjaYuHR1fQlXT/i
 8LTgviqLYZ1Zsc3QSzOHwx878Qatlqj6u3cWoxbLi09EFqkiTJMKtQr3U2jVVZCu35OF357xzdV7t
 2t8CzqiVCZ3p8A+vjXwd2nhfELJK4MvrD4qbEfRaY=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Ph-0000vT-JD; Fri, 16 Feb 2024 21:06:29 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:27 +0000
Message-Id: <20240216210633.1376066-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/13] esp.c: change esp_fifo_pop_buf() to take ESPState
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

Now that all users of esp_fifo_pop_buf() operate on the main FIFO there is no
need to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index fb2ceca36a..4d9220ab22 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -125,7 +125,7 @@ static uint8_t esp_fifo_pop(ESPState *s)
     return fifo8_pop(&s->fifo);
 }
 
-static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
+static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
 {
     const uint8_t *buf;
     uint32_t n, n2;
@@ -136,16 +136,16 @@ static uint32_t esp_fifo_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
     }
 
     len = maxlen;
-    buf = fifo8_pop_buf(fifo, len, &n);
+    buf = fifo8_pop_buf(&s->fifo, len, &n);
     if (dest) {
         memcpy(dest, buf, n);
     }
 
     /* Add FIFO wraparound if needed */
     len -= n;
-    len = MIN(len, fifo8_num_used(fifo));
+    len = MIN(len, fifo8_num_used(&s->fifo));
     if (len) {
-        buf = fifo8_pop_buf(fifo, len, &n2);
+        buf = fifo8_pop_buf(&s->fifo, len, &n2);
         if (dest) {
             memcpy(&dest[n], buf, n2);
         }
@@ -459,7 +459,7 @@ static void esp_do_dma(ESPState *s)
             s->dma_memory_read(s->dma_opaque, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             esp_raise_drq(s);
         }
@@ -515,7 +515,7 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_raise_drq(s);
@@ -549,7 +549,7 @@ static void esp_do_dma(ESPState *s)
                 /* Copy FIFO data to device */
                 len = MIN(s->async_len, ESP_FIFO_SZ);
                 len = MIN(len, fifo8_num_used(&s->fifo));
-                len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+                len = esp_fifo_pop_buf(s, s->async_buf, len);
                 esp_raise_drq(s);
             }
 
@@ -713,7 +713,7 @@ static void esp_nodma_ti_dataout(ESPState *s)
     }
     len = MIN(s->async_len, ESP_FIFO_SZ);
     len = MIN(len, fifo8_num_used(&s->fifo));
-    esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+    esp_fifo_pop_buf(s, s->async_buf, len);
     s->async_buf += len;
     s->async_len -= len;
     s->ti_size += len;
@@ -738,7 +738,7 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -757,7 +757,7 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            len = esp_fifo_pop_buf(s, buf, 1);
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -774,7 +774,7 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -792,7 +792,7 @@ static void esp_do_nodma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -821,7 +821,7 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
             /* Copy FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
@@ -836,7 +836,7 @@ static void esp_do_nodma(ESPState *s)
         case CMD_SEL:
         case CMD_SELATN:
             /* FIFO already contain entire CDB: copy to cmdfifo and execute */
-            len = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
-- 
2.39.2



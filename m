Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DB3C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhO-0003Zq-BW; Tue, 13 Feb 2024 14:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh2-00024C-S8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:49 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh1-0006YG-4E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=31Pv7/3D3sVU7lCfzBxymFeAjRw7ZoiBrks9lmvWPgo=; b=V1/vUDW0FQVf9fQ6rTAyXDgyFQ
 LUyen5KQPj2fdSaUqtwkHmrXyoGFXMfEMe6GD9V6RTBqJdfLldJ6LsQ+2bdhinAYbvVHKExM0Uw/S
 CEazaADs/9R69I5TgTQJyORUp3jSJl1kLccajQjJkQSYxx07yIZOaj/EYOhKknH90PzTPV/xBs1M1
 K5U9+27KAuE/CmCxnUUAprRN4nujm+HziS80Z2nvwBtBoqbz2qkrn9Rn8tnsFY/e7TyM+i+t7F/59
 rbVNSrWfGpg6qc1In4HiRc/GvPw47cWobn0r1EPtfcfecXabLCNnJk9Pl27HG6aIlAvo3OKiFZN9b
 8dYuwXdEuxmtF79T1doNVcvC4EXrFxu297B4R5hUFsypsmIeOC1ocUvd4YMr8Slc23u56BgH/bLfb
 2j7O4t0FMlxaAF+881+YjUA/HmWN9qmWOgUD6wa0HygB+obZ/U/umNv6+jpuS23Qw6oO6bcF+dbpM
 DTZFJSBC5o8mPo5PWJ5lMdfVxB9hkByMiJJI9YmEh2xUPfXGt/5m9ZT9yDk5UNEI3LJrlFlfM9A9y
 3xsNT8PLENFvrT+gE7DXNpxnf4QTWsNlTdYaV4h23ZVwh6nsYRK33j/iBh9qho5SGh98I+rw4wc95
 kTRAbLA5h1fi75YNOkOSZG4bsXmr0vkh4klj20Nsg=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg8-0008m4-TN; Tue, 13 Feb 2024 19:42:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:10 +0000
Message-Id: <20240213194052.1162753-47-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 46/88] esp.c: untangle MESSAGE OUT and COMMAND phase logic in
 esp_do_dma()
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

This makes it clearer that ATN is asserted until the end of the next TI command
in the MESSAGE OUT phase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-47-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1f7dff4ca6..2f54fd1285 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -629,6 +629,31 @@ static void esp_do_dma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
+        if (s->dma_memory_read) {
+            len = MIN(len, fifo8_num_free(&s->cmdfifo));
+            s->dma_memory_read(s->dma_opaque, buf, len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->cmdfifo_cdb_offset += len;
+        } else {
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+            s->cmdfifo_cdb_offset += n;
+        }
+
+        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+        esp_raise_drq(s);
+
+        /* ATN remains asserted until TC == 0 */
+        if (esp_get_tc(s) == 0) {
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSEQ] = SEQ_CD;
+            s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
+        }
+        break;
+
     case STAT_CD:
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_do_dma(cmdlen, len);
@@ -641,36 +666,15 @@ static void esp_do_dma(ESPState *s)
             n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
             n = MIN(fifo8_num_free(&s->cmdfifo), n);
             fifo8_push_all(&s->cmdfifo, buf, n);
-            esp_set_tc(s, esp_get_tc(s) - n);
 
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-
-            /* Ensure we have received complete command after SATN and stop */
-            if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
-                return;
-            }
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if (esp_get_phase(s) == STAT_CD) {
-            /* No command received */
-            if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-                return;
-            }
-
+        if (esp_get_tc(s) == 0) {
             /* Command has been received */
             do_cmd(s);
-        } else {
-            /*
-             * Extra message out bytes received: update cmdfifo_cdb_offset
-             * and then switch to command phase
-             */
-            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
         }
         break;
 
-- 
2.39.2



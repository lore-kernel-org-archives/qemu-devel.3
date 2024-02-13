Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E061C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhP-0003i8-5n; Tue, 13 Feb 2024 14:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh7-0002hh-JU
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:57 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh5-0006ZP-2r
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7p7DnWA6qnww2W25YEv6RDerIM7CBNg9Bc5riyx9NA=; b=N33j2mHOqpr6+v1Lc8TnhzJzev
 O+sKNHjfTx+YgiBWKC8nige0aWcgx7yxojN+rnRWe3P31YsQ3GINPVvuoyHXkjq90LTNDBRruAW2G
 wRDQnF5q01NUZiQmuSTtl6Y7tM5Yhk4aCnZr/XcsNcvEBqo8Ekwfw1yBb+695mBdmORK/7/0eOvr/
 jr+uKrwR1lMYZFZBuQyqSOJ8DIv7GYYlKDPA9dmNiXzGjGPF5s37Bgw7zB35PWZF3ifzLkwtZTp2d
 0NCf7qGBmyGGTHINxLD991asxp1ZsWMGhT7YbqMJqCYmVQLqcQoTd3LiLkbOs0an0TrBb08+QnzZm
 KJLd9HeNEXJFV3ky2QGa8+y4yPuNBa46//4eWPSEbubMK7fIR3cfEY+ievl9FTPsNiS8Pitfu6ewD
 ndrh2tYuB7WR/UoV5tlPd3HRAAOaBSR7tTqfELSXUchbZ/5OEvFdb4636F2YtkrM1i5fNvTpxZVgu
 rK6uA2SQ6fPl5+J/RzYZR6VmBrLUeD2hjF+IsgQJ5C39RjRPL4JJC4SZvlL0xT5ZTEMlZyasrH30X
 +qVGxneYEx6Vo5zQeVs5n6UPZHzxlz3ME4FrS2z67fjGkCCdlSq3Pf9rEVT1xFhEJiU0eWXzzuaY6
 THKvblzIsZUuHXj8KM7SjNI8/44e9rhLVi5cGwnRI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygC-0008m4-Fv; Tue, 13 Feb 2024 19:43:00 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:11 +0000
Message-Id: <20240213194052.1162753-48-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 47/88] esp.c: untangle MESSAGE OUT and COMMAND phase logic in
 do_dma_pdma_cb()
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
Message-Id: <20240112125420.514425-48-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 66 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 2f54fd1285..7ab195f884 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -536,36 +536,30 @@ static void do_dma_pdma_cb(ESPState *s)
 {
     uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
-    uint32_t n;
+    uint32_t n, cmdlen;
+
+    len = esp_get_tc(s);
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
-    case STAT_CD:
-        /* Copy FIFO into cmdfifo */
-        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-
-        /* Ensure we have received complete command after SATN and stop */
-        if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
-            return;
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
         }
 
-        s->ti_size = 0;
-        if (esp_get_phase(s) == STAT_CD) {
-            /* No command received */
-            if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-                return;
-            }
+        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+        esp_raise_drq(s);
 
-            /* Command has been received */
-            do_cmd(s);
-        } else {
-            /*
-             * Extra message out bytes received: update cmdfifo_cdb_offset
-             * and then switch to command phase
-             */
-            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
+        /* ATN remains asserted until TC == 0 */
+        if (esp_get_tc(s) == 0) {
             esp_set_phase(s, STAT_CD);
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
@@ -573,6 +567,30 @@ static void do_dma_pdma_cb(ESPState *s)
         }
         break;
 
+    case STAT_CD:
+        cmdlen = fifo8_num_used(&s->cmdfifo);
+        trace_esp_do_dma(cmdlen, len);
+        if (s->dma_memory_read) {
+            len = MIN(len, fifo8_num_free(&s->cmdfifo));
+            s->dma_memory_read(s->dma_opaque, buf, len);
+            fifo8_push_all(&s->cmdfifo, buf, len);
+            esp_set_tc(s, esp_get_tc(s) - len);
+        } else {
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
+            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
+            esp_raise_drq(s);
+        }
+        trace_esp_handle_ti_cmd(cmdlen);
+        s->ti_size = 0;
+        if (esp_get_tc(s) == 0) {
+            /* Command has been received */
+            do_cmd(s);
+        }
+        break;
+
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2



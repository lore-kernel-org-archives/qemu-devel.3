Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A667EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyyh-0002MR-4g; Tue, 13 Feb 2024 15:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxw-0001Xj-Oz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:25 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxu-0001s2-GE
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lTn4V1T64Cxftxgo+RVGj1lemtFejAQRM/dLtRcBqz0=; b=wmy0mDAPqfLqN/YEN2BO76UMzL
 QLh3JTR25Fa/SmTLrcYrtI+8k/TuHvaQQ7Sbv53HKsZXo57C9PXxcVnnHCnxjub+qC30zUSlrWRIH
 WDLoxIcYEJPJQsk1O4wv8Ce9XSCdJQAzXw6q8GdEELdw04Yz+wx1OEzw0q/xloewMYRrVpe1G3nV7
 nZE/o6WbGAjhsAfWx1zZ1qr1zRA4940tUscB/Hc3dMJcNvZeA3c8g1i7H9a919fNCw5Sy3kMKcvCe
 mZKWkrdyXzbVAy6oZRmpq+q+E+OMed9wzoC9w99W0oJlwWPV0ncGFMIx35ATe1qxxF98yulEy6+cJ
 JpQkBGdPDUS8S9l7yWOCI0WsZv/mDfwX6NMOSvCgAPhfsyQg+/w9CFEyrg/LtZ3SzvwQseQFhH4gG
 XuLyBoG6XM+0/x2Ce8kiz2JgsH6tvjq2uAOH8WYYts/suYkKQ7U64gDP2tPfYjvsM9pRT828sVoUv
 YyAtUiQgo3vRh7Esd0ZI/k7mmk7pLcGL4gKJch9qGt+WiPfi908AhsJXNr9B0kdZ18XQ+KRKhNc/s
 PAWHyr9J0aGh+gykLV550D+MTREnp78q2JP6jElNjBjGL137U4IYy1MrN0TxPS3jOQ+QmINWkGYLj
 lCPG9qUvRpwCNyoHE/dgtRElJ+9Sf49RJcZ9An11E=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygZ-0008m4-HG; Tue, 13 Feb 2024 19:43:23 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:17 +0000
Message-Id: <20240213194052.1162753-54-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 53/88] esp.c: replace do_dma_pdma_cb() with esp_do_dma()
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

Now that the DMA logic is identical between do_dma_pdma_cb() and esp_do_dma()
we can replace do_dma_pdma_cb() with esp_do_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-54-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 138 +-------------------------------------------------
 1 file changed, 1 insertion(+), 137 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 29e3869173..f69b2709fc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -491,141 +491,6 @@ static void esp_dma_ti_check(ESPState *s)
     }
 }
 
-static void do_dma_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_CMDFIFO_SZ];
-    int len;
-    uint32_t n, cmdlen;
-
-    len = esp_get_tc(s);
-
-    switch (esp_get_phase(s)) {
-    case STAT_MO:
-        if (s->dma_memory_read) {
-            len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-            s->cmdfifo_cdb_offset += len;
-        } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-            s->cmdfifo_cdb_offset += n;
-        }
-
-        esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
-        esp_raise_drq(s);
-
-        switch (s->rregs[ESP_CMD]) {
-        case CMD_SELATN | CMD_DMA:
-            if (fifo8_num_used(&s->cmdfifo) >= 1) {
-                /* First byte received, switch to command phase */
-                esp_set_phase(s, STAT_CD);
-                s->cmdfifo_cdb_offset = 1;
-
-                if (fifo8_num_used(&s->cmdfifo) > 1) {
-                    /* Process any additional command phase data */
-                    esp_do_dma(s);
-                }
-            }
-            break;
-
-        case CMD_SELATNS | CMD_DMA:
-            if (fifo8_num_used(&s->cmdfifo) == 1) {
-                /* First byte received, stop in message out phase */
-                esp_set_phase(s, STAT_CD);
-                s->cmdfifo_cdb_offset = 1;
-
-                /* Raise command completion interrupt */
-                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
-                esp_raise_irq(s);
-            }
-            break;
-
-        case CMD_TI | CMD_DMA:
-            /* ATN remains asserted until TC == 0 */
-            if (esp_get_tc(s) == 0) {
-                esp_set_phase(s, STAT_CD);
-                s->rregs[ESP_RSEQ] = SEQ_CD;
-                s->rregs[ESP_RINTR] |= INTR_BS;
-                esp_raise_irq(s);
-            }
-            break;
-        }
-        break;
-
-    case STAT_CD:
-        cmdlen = fifo8_num_used(&s->cmdfifo);
-        trace_esp_do_dma(cmdlen, len);
-        if (s->dma_memory_read) {
-            len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-        } else {
-            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-            n = MIN(fifo8_num_free(&s->cmdfifo), n);
-            fifo8_push_all(&s->cmdfifo, buf, n);
-
-            esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
-            esp_raise_drq(s);
-        }
-        trace_esp_handle_ti_cmd(cmdlen);
-        s->ti_size = 0;
-        if (esp_get_tc(s) == 0) {
-            /* Command has been received */
-            do_cmd(s);
-        }
-        break;
-
-    case STAT_DO:
-        if (!s->current_req) {
-            return;
-        }
-        /* Copy FIFO data to device */
-        len = MIN(s->async_len, ESP_FIFO_SZ);
-        len = MIN(len, fifo8_num_used(&s->fifo));
-        n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-        s->async_buf += n;
-        s->async_len -= n;
-        s->ti_size += n;
-
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            return;
-        }
-
-        esp_dma_ti_check(s);
-        break;
-
-    case STAT_DI:
-        if (!s->current_req) {
-            return;
-        }
-        /* Copy device data to FIFO */
-        len = MIN(s->async_len, esp_get_tc(s));
-        len = MIN(len, fifo8_num_free(&s->fifo));
-        fifo8_push_all(&s->fifo, s->async_buf, len);
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size -= len;
-        esp_set_tc(s, esp_get_tc(s) - len);
-
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            s->data_in_ready = false;
-            return;
-        }
-
-        esp_dma_ti_check(s);
-        break;
-    }
-}
-
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
@@ -669,7 +534,6 @@ static void esp_do_dma(ESPState *s)
         case CMD_SELATNS | CMD_DMA:
             if (fifo8_num_used(&s->cmdfifo) == 1) {
                 /* First byte received, stop in message out phase */
-                esp_set_phase(s, STAT_CD);
                 s->cmdfifo_cdb_offset = 1;
 
                 /* Raise command completion interrupt */
@@ -913,7 +777,7 @@ static void esp_pdma_cb(ESPState *s)
         write_response_pdma_cb(s);
         break;
     case DO_DMA_PDMA_CB:
-        do_dma_pdma_cb(s);
+        esp_do_dma(s);
         break;
     default:
         g_assert_not_reached();
-- 
2.39.2



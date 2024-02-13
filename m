Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB59C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyer-0002aK-U1; Tue, 13 Feb 2024 14:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyep-0002Y7-Qd
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyen-0006Gi-Sz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P9yi8vyd03plkgnTYwxxAM7QdMbpNlZtBZuZcPeGvCI=; b=whEOi8lvS/9c/+bjIcUMF0kGsb
 CJCKMktGZCRRvU/RdpAFKVeJ4imRwwMhMI9mAkX/E30Zor2JKZOQXk0ZtR8P/H9M0TJNxJ48V1HUj
 FUp13g+ve//zhAZWgsEwEIxWP+q31DTkNcD00PS3b+eEg2XEvVR2plkHpD74Go6e7YpWPt+iIIj+p
 aqZsMDhxZTGupEP2PjCLxx0VkgnyeMRCWApNzK4u5myeeYgpsHJCFKPig9byqHG+WIiLbSa+mHObb
 5LKDK+50lNCuP6w7Pgg52TmdHrLBMPdpOeOXtdNrsLwMzbY/UxK6KpOV3Qc9em1L61GZofvXgBCkF
 kYFHfAtr8bjaD0d5Jmr5j0VmbATX2D4a8rI8wgyCn2HFtQOeZoSCWwnFtwlldK6HAKQq5FsLWfbzv
 nBHGIQNLLeo+BNQTyTXavVBoWZV4Tp4sVn84UqXoxQ66yqBbjQdcONVcOBfmb2LRHrREzYMccZEia
 lnTxHQkpCB7gjGWGUsGJOTfhmEOCkwzxy3iqWcV0ohA1Nb9NOWmbE4fN770lR5WrTvU/kaXXgAXiP
 MV580gJZi0ePwlEbZjXZHYr0pIX3QyFeqKpgp+5zXWK51FOFk0RUJU343js6SQmTAFqTrIuUPPAxT
 I3hGshF5WPnETq9B/xZQfa0CTA9/tk6dhiTm7D0cQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZye8-0008m4-Pq; Tue, 13 Feb 2024 19:40:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:32 +0000
Message-Id: <20240213194052.1162753-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 08/88] esp.c: move command execution logic to new esp_run_cmd()
 function
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

This helps to simplify esp_reg_write() and potentially allows for a 2-level
deep FIFO to be implemented in future.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 177 ++++++++++++++++++++++++++------------------------
 1 file changed, 92 insertions(+), 85 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e717b2e216..fecfef7c89 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -980,6 +980,97 @@ static void parent_esp_reset(ESPState *s, int irq, int level)
     }
 }
 
+static void esp_run_cmd(ESPState *s)
+{
+    uint8_t cmd = s->rregs[ESP_CMD];
+
+    if (cmd & CMD_DMA) {
+        s->dma = 1;
+        /* Reload DMA counter.  */
+        if (esp_get_stc(s) == 0) {
+            esp_set_tc(s, 0x10000);
+        } else {
+            esp_set_tc(s, esp_get_stc(s));
+        }
+    } else {
+        s->dma = 0;
+    }
+    switch (cmd & CMD_CMD) {
+    case CMD_NOP:
+        trace_esp_mem_writeb_cmd_nop(cmd);
+        break;
+    case CMD_FLUSH:
+        trace_esp_mem_writeb_cmd_flush(cmd);
+        fifo8_reset(&s->fifo);
+        break;
+    case CMD_RESET:
+        trace_esp_mem_writeb_cmd_reset(cmd);
+        esp_soft_reset(s);
+        break;
+    case CMD_BUSRESET:
+        trace_esp_mem_writeb_cmd_bus_reset(cmd);
+        esp_bus_reset(s);
+        if (!(s->wregs[ESP_CFG1] & CFG1_RESREPT)) {
+            s->rregs[ESP_RINTR] |= INTR_RST;
+            esp_raise_irq(s);
+        }
+        break;
+    case CMD_TI:
+        trace_esp_mem_writeb_cmd_ti(cmd);
+        handle_ti(s);
+        break;
+    case CMD_ICCS:
+        trace_esp_mem_writeb_cmd_iccs(cmd);
+        write_response(s);
+        s->rregs[ESP_RINTR] |= INTR_FC;
+        s->rregs[ESP_RSTAT] |= STAT_MI;
+        break;
+    case CMD_MSGACC:
+        trace_esp_mem_writeb_cmd_msgacc(cmd);
+        s->rregs[ESP_RINTR] |= INTR_DC;
+        s->rregs[ESP_RSEQ] = 0;
+        s->rregs[ESP_RFLAGS] = 0;
+        esp_raise_irq(s);
+        break;
+    case CMD_PAD:
+        trace_esp_mem_writeb_cmd_pad(cmd);
+        s->rregs[ESP_RSTAT] = STAT_TC;
+        s->rregs[ESP_RINTR] |= INTR_FC;
+        s->rregs[ESP_RSEQ] = 0;
+        break;
+    case CMD_SATN:
+        trace_esp_mem_writeb_cmd_satn(cmd);
+        break;
+    case CMD_RSTATN:
+        trace_esp_mem_writeb_cmd_rstatn(cmd);
+        break;
+    case CMD_SEL:
+        trace_esp_mem_writeb_cmd_sel(cmd);
+        handle_s_without_atn(s);
+        break;
+    case CMD_SELATN:
+        trace_esp_mem_writeb_cmd_selatn(cmd);
+        handle_satn(s);
+        break;
+    case CMD_SELATNS:
+        trace_esp_mem_writeb_cmd_selatns(cmd);
+        handle_satn_stop(s);
+        break;
+    case CMD_ENSEL:
+        trace_esp_mem_writeb_cmd_ensel(cmd);
+        s->rregs[ESP_RINTR] = 0;
+        break;
+    case CMD_DISSEL:
+        trace_esp_mem_writeb_cmd_dissel(cmd);
+        s->rregs[ESP_RINTR] = 0;
+        esp_raise_irq(s);
+        break;
+    default:
+        trace_esp_error_unhandled_command(cmd);
+        break;
+    }
+}
+
 uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 {
     uint32_t val;
@@ -1076,91 +1167,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
-        if (val & CMD_DMA) {
-            s->dma = 1;
-            /* Reload DMA counter.  */
-            if (esp_get_stc(s) == 0) {
-                esp_set_tc(s, 0x10000);
-            } else {
-                esp_set_tc(s, esp_get_stc(s));
-            }
-        } else {
-            s->dma = 0;
-        }
-        switch (val & CMD_CMD) {
-        case CMD_NOP:
-            trace_esp_mem_writeb_cmd_nop(val);
-            break;
-        case CMD_FLUSH:
-            trace_esp_mem_writeb_cmd_flush(val);
-            fifo8_reset(&s->fifo);
-            break;
-        case CMD_RESET:
-            trace_esp_mem_writeb_cmd_reset(val);
-            esp_soft_reset(s);
-            break;
-        case CMD_BUSRESET:
-            trace_esp_mem_writeb_cmd_bus_reset(val);
-            esp_bus_reset(s);
-            if (!(s->wregs[ESP_CFG1] & CFG1_RESREPT)) {
-                s->rregs[ESP_RINTR] |= INTR_RST;
-                esp_raise_irq(s);
-            }
-            break;
-        case CMD_TI:
-            trace_esp_mem_writeb_cmd_ti(val);
-            handle_ti(s);
-            break;
-        case CMD_ICCS:
-            trace_esp_mem_writeb_cmd_iccs(val);
-            write_response(s);
-            s->rregs[ESP_RINTR] |= INTR_FC;
-            s->rregs[ESP_RSTAT] |= STAT_MI;
-            break;
-        case CMD_MSGACC:
-            trace_esp_mem_writeb_cmd_msgacc(val);
-            s->rregs[ESP_RINTR] |= INTR_DC;
-            s->rregs[ESP_RSEQ] = 0;
-            s->rregs[ESP_RFLAGS] = 0;
-            esp_raise_irq(s);
-            break;
-        case CMD_PAD:
-            trace_esp_mem_writeb_cmd_pad(val);
-            s->rregs[ESP_RSTAT] = STAT_TC;
-            s->rregs[ESP_RINTR] |= INTR_FC;
-            s->rregs[ESP_RSEQ] = 0;
-            break;
-        case CMD_SATN:
-            trace_esp_mem_writeb_cmd_satn(val);
-            break;
-        case CMD_RSTATN:
-            trace_esp_mem_writeb_cmd_rstatn(val);
-            break;
-        case CMD_SEL:
-            trace_esp_mem_writeb_cmd_sel(val);
-            handle_s_without_atn(s);
-            break;
-        case CMD_SELATN:
-            trace_esp_mem_writeb_cmd_selatn(val);
-            handle_satn(s);
-            break;
-        case CMD_SELATNS:
-            trace_esp_mem_writeb_cmd_selatns(val);
-            handle_satn_stop(s);
-            break;
-        case CMD_ENSEL:
-            trace_esp_mem_writeb_cmd_ensel(val);
-            s->rregs[ESP_RINTR] = 0;
-            break;
-        case CMD_DISSEL:
-            trace_esp_mem_writeb_cmd_dissel(val);
-            s->rregs[ESP_RINTR] = 0;
-            esp_raise_irq(s);
-            break;
-        default:
-            trace_esp_error_unhandled_command(val);
-            break;
-        }
+        esp_run_cmd(s);
         break;
     case ESP_WBUSID ... ESP_WSYNO:
         break;
-- 
2.39.2



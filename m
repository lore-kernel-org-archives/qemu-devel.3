Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4376C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0Q-0004PF-Qh; Tue, 13 Feb 2024 15:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzW-00037d-TN
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:56 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzU-00025q-06
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9+5sH1gn+fBcVBUOmEXdp10vT03mkKKkKC6r5FGwQIM=; b=Ba7nqoOuF8Bc6Ac/YqTnFOo9tX
 jEXNrF9St9By8VXLShS2NEn6KyWVQya4EFs2qboP3F8yzG6HbKDocy/BvDnDXbacUWL5kjpt8K3WH
 IsnzUQrIEll00j1Suh7NgdCCpWRtnK9xauLpPIAAU6ZitqzELDs40OsX3iUP7h7dcBgygNIj16MtO
 5X8t6o2zZG/sUQXr6qhy5Pfdp490tNND2b2W3WAhcyS8E9QvpBWLY9E6QlF3ECt5wLlHyg8mlFHK+
 ZKrONvGGzgdeyoqxb2Jk/4pPAhtIU1XHCtYzbGC/C31+mEMsGrv0tEhMh6lcd/L8Y3yLwACagBZaq
 WStdjlUTCRcx6o8FShjSwEHto0OYlFS7o4/dLHcYuHyOyK8p2NCMM14tVWKxAjWEIFG9PMk0ruIc4
 9k7bsyYZZ6K7wMRkQnYN33RhlHYwx/H4LTbTDc6dPHhP45VhGC7o7ho34QiUIqlMInMzGPGCzuCS0
 ezdQX6TLpXjl5qaKl/siOX74okxtD0FnEdNmiaksyNOH8z8kmCJUE6/kKy9J4Y7oMsttzdQ7vrUZE
 o4vdKuHjnatECYz7LPkPnjQ4tKqGlzfRGeB5uEp3UPCZQVsfNco9qAjDINCG7xAFhSpwTnpDsXx4Y
 Jb1/o5uexRQVFt9XGkb02rw1weDJsJ7AX4VbmKEGc=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhy-0008m4-Ib; Tue, 13 Feb 2024 19:44:50 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:48 +0000
Message-Id: <20240213194052.1162753-85-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 84/88] esp.c: implement DMA Transfer Pad command for DATA phases
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

The Transfer Pad command is used to either drop incoming FIFO data during the
DATA IN phase or generate a series of zero bytes in the FIFO during the DATA
OUT phase.

Implement the DMA Transfer Pad command for the DATA phases which is used by
the NeXTCube firmware in the DATA IN phase to ignore part of the incoming SCSI
data as it is copied into memory.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-85-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 97 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 73379a3c65..5583b3eb56 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -387,6 +387,15 @@ static void handle_satn_stop(ESPState *s)
     }
 }
 
+static void handle_pad(ESPState *s)
+{
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        esp_do_nodma(s);
+    }
+}
+
 static void write_response(ESPState *s)
 {
     trace_esp_write_response(s->status);
@@ -518,20 +527,38 @@ static void esp_do_dma(ESPState *s)
             len = s->async_len;
         }
 
-        if (s->dma_memory_read) {
-            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
-        } else {
-            /* Copy FIFO data to device */
-            len = MIN(s->async_len, ESP_FIFO_SZ);
-            len = MIN(len, fifo8_num_used(&s->fifo));
-            len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-            esp_raise_drq(s);
-        }
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_TI | CMD_DMA:
+            if (s->dma_memory_read) {
+                s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            } else {
+                /* Copy FIFO data to device */
+                len = MIN(s->async_len, ESP_FIFO_SZ);
+                len = MIN(len, fifo8_num_used(&s->fifo));
+                len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+                esp_raise_drq(s);
+            }
 
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size += len;
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+            break;
+
+        case CMD_PAD | CMD_DMA:
+            /* Copy TC zero bytes into the incoming stream */
+            if (!s->dma_memory_read) {
+                len = MIN(s->async_len, ESP_FIFO_SZ);
+                len = MIN(len, fifo8_num_free(&s->fifo));
+            }
+
+            memset(s->async_buf, 0, len);
+
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+            break;
+        }
 
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -554,19 +581,35 @@ static void esp_do_dma(ESPState *s)
             len = s->async_len;
         }
 
-        if (s->dma_memory_write) {
-            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
-        } else {
-            /* Copy device data to FIFO */
-            len = MIN(len, fifo8_num_free(&s->fifo));
-            fifo8_push_all(&s->fifo, s->async_buf, len);
-            esp_raise_drq(s);
-        }
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_TI | CMD_DMA:
+            if (s->dma_memory_write) {
+                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+            } else {
+                /* Copy device data to FIFO */
+                len = MIN(len, fifo8_num_free(&s->fifo));
+                fifo8_push_all(&s->fifo, s->async_buf, len);
+                esp_raise_drq(s);
+            }
+
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+            esp_set_tc(s, esp_get_tc(s) - len);
+            break;
+
+        case CMD_PAD | CMD_DMA:
+            /* Drop TC bytes from the incoming stream */
+            if (!s->dma_memory_write) {
+                len = MIN(len, fifo8_num_free(&s->fifo));
+            }
 
-        s->async_buf += len;
-        s->async_len -= len;
-        s->ti_size -= len;
-        esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+            esp_set_tc(s, esp_get_tc(s) - len);
+            break;
+        }
 
         if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
             /* If the guest underflows TC then terminate SCSI request */
@@ -1087,9 +1130,7 @@ static void esp_run_cmd(ESPState *s)
         break;
     case CMD_PAD:
         trace_esp_mem_writeb_cmd_pad(cmd);
-        s->rregs[ESP_RSTAT] = STAT_TC;
-        s->rregs[ESP_RINTR] |= INTR_FC;
-        s->rregs[ESP_RSEQ] = 0;
+        handle_pad(s);
         break;
     case CMD_SATN:
         trace_esp_mem_writeb_cmd_satn(cmd);
-- 
2.39.2



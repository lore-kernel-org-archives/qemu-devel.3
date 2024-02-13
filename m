Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEC1C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygC-00079f-1H; Tue, 13 Feb 2024 14:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg6-0006yI-Iw
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg5-0006Pk-0O
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kibjptY/wMmzUFXbCnZjWuBRPf2BC6ZaxFiieDa/v6k=; b=Q72zMpdeK6U2Vm5n1l8W8ZV07G
 OlOVLIWGhp/9FKlJ4ODCYvWie27zuXuulNs23GD7G1H3ZayYnMA3hlCdHv8DR+bQSgTZBWn31tUPg
 wAOUmEmNhIBLhE7PSSdz73Yrpdwfl+C1Zxz4AO+RyDAlMElEQp/dOOrBfJh1m1iPIX8juPZ9qlTA6
 v6fZGlpwpCKji/QczyBsskFnaNnjzjeSk/ubkLForphtdRd05aQ/gg8z0Te9Db5ZcgSAIDOGzr22s
 CsGiP4FCpaCR9haJyGImJx22Uq/GJkJK8rCwl27fvKMy7qLwtTudOIWutWeuluFZB3dhQQIrs6Q5W
 RWdJxtZ7nxcua3vYGs/AUR8MUWq8rF9RF6c8l1WmKQhNkuVnhsu57UKDt7it0RdwTMSRoXcFybpZt
 qjkuZGs2LxV4nSEoEnOROePfFkUoABriP73fMQBw8Z/pJ3eHOHp2gZFiXMDWRK29N5dJZuS9defIB
 XCSDQA7dv78Tk2uWE6YUuLfkprD9Uq5v89SoZXXyBaRD5waNJ2btaCqPlF4Djd58jhxr4SzRPF6ng
 t+mpTAkY4cm5J2A0Hh8j6NS3t5StSF3nkQTVf9Oa4y0X/EDyKKRmr+hvVsiQr4m8gSCkzV1CJsvzx
 NPHnJuHBR6q4GzUc8GGXux1yVrTN/lsOCpW9C/VBI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfB-0008m4-K3; Tue, 13 Feb 2024 19:41:57 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:52 +0000
Message-Id: <20240213194052.1162753-29-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 28/88] esp.c: consolidate async_len and TC == 0 checks in
 do_dma_pdma_cb() and esp_do_dma()
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

Ensure that the async_len checks for requesting data from the SCSI layer and
the TC == 0 checks to detect the end of the DMA transfer are consistent in both
do_dma_pdma_cb() and esp_do_dma(). In particular this involves adding the check
to see if the FIFO is at its low threshold since PDMA and mixed DMA and non-DMA
requests can leave data remaining in the FIFO.

At the same time update all the comments so that they are also consistent between
all similar code paths.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-29-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6b0811d3ce..f20026c3dc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -604,12 +604,13 @@ static void do_dma_pdma_cb(ESPState *s)
         s->async_len -= n;
         s->ti_size += n;
 
-        if (s->async_len == 0) {
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
             scsi_req_continue(s->current_req);
             return;
         }
 
-        if (esp_get_tc(s) == 0) {
+        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
             esp_lower_drq(s);
             esp_dma_done(s);
         }
@@ -706,24 +707,30 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size += len;
 
-            if (s->async_len == 0) {
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
-                /*
-                 * If there is still data to be read from the device then
-                 * complete the DMA operation immediately.  Otherwise defer
-                 * until the scsi layer has completed.
-                 */
                 return;
             }
 
-            if (esp_get_tc(s) == 0) {
-                /* Partially filled a scsi buffer. Complete immediately.  */
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
                 esp_dma_done(s);
                 esp_lower_drq(s);
             }
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
+
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+                esp_dma_done(s);
+                esp_lower_drq(s);
+            }
         }
     } else {
         if (s->dma_memory_write) {
@@ -734,13 +741,13 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
 
-            if (s->async_len == 0) {
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
                 return;
             }
 
-            if (esp_get_tc(s) == 0) {
-                /* Partially filled a scsi buffer. Complete immediately.  */
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
                 esp_dma_done(s);
                 esp_lower_drq(s);
             }
@@ -754,6 +761,17 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
+
+            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+                /* Defer until the scsi layer has completed */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
+            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+                esp_lower_drq(s);
+                esp_dma_done(s);
+            }
         }
     }
 }
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D259C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz02-0003n9-UF; Tue, 13 Feb 2024 15:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzF-0002rA-Ji
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:39 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzE-00025J-3T
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KXawe9fYSD+GPXaSvzemteq4Msk+Mi6Gp4c7C6r7U3s=; b=hS0lcz16meiLn6W3kGxtludZIr
 nzOmTy2Oq5/c3r5JHGpRP7WmLpDdjYWSbSwMNXx8q5OoYThDHunAQTKttB6z9LcuEEQeol6/ck6HM
 MyrL7lgiw2OR19bQsrN+0MCgIrwJuNvvm2Du81/cvkGtzI/52/ftprLvbu+0lMk4+hu6vPHnCWT6m
 xkkG3M8lzv7m/ee+Kq6xi/JCU/SE/QuL58Ap7FTGpWajY6lq/BdUMSMxRkj7REYhgTxkkHHe8WZf6
 FOFRPlptwH6Thy5BBJraiUATLgcj/VvXhZeVBaQw6mIOYLTfTO9R97F5E09UiKLvDYRR5gekUOLMg
 nBMMx0+5b8fXDDqNLoT4hEhTyxE4fnPmxIF+wDIwgexqA2bQAnSKTSm8u/V8j2c2lUGy1+TN0A9x8
 WK2SRn8QCgTc+Cl1+pNmhjK8m6QnYMcrlCHRwSTmaay/ZZgov74dH1w7jt/qgXKv6Poqv1tBYbIv6
 yfr9uRHGdvOOmk6j1uuQwA6ABDgKEzUhEhx4Go3BJmLYij+x4+/VJ+voxcXwTLvK4C1Vjejuhs459
 80r8ErxOPGPxbPOWVUMGjcVJremyocjltOW9UPAWLM/hipmtxJhraFSUOrwMHEkNfSVUpluq0IMXx
 KAP0RChioQ0EuGQNkc4pejaPGagzlhVFXylB0NVjg=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhP-0008m4-7w; Tue, 13 Feb 2024 19:44:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:36 +0000
Message-Id: <20240213194052.1162753-73-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 72/88] esp.c: handle TC underflow for DMA SCSI requests
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

Detect the case where the guest underflows TC by requesting a DMA transfer which
is larger than the available data. If this case is detected, immediately
complete the SCSI request and handle any remaining FIFO accesses in the STATUS
phase by raising INTR_BS once the FIFO is below the threshold.

Note that handling the premature SCSI bus phase change in the case of TC
underflow fixes booting EMILE on m68k once again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-73-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8ea100ee9c..a3e18bb3d7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -579,6 +579,12 @@ static void esp_do_dma(ESPState *s)
             s->async_len -= len;
             s->ti_size -= len;
 
+            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+                /* If the guest underflows TC then terminate SCSI request */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
                 /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
@@ -596,6 +602,12 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_raise_drq(s);
 
+            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+                /* If the guest underflows TC then terminate SCSI request */
+                scsi_req_continue(s->current_req);
+                return;
+            }
+
             if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
                 /* Defer until the scsi layer has completed */
                 scsi_req_continue(s->current_req);
@@ -630,6 +642,15 @@ static void esp_do_dma(ESPState *s)
                 }
             }
             break;
+
+        default:
+            /* Consume remaining data if the guest underflows TC */
+            if (fifo8_num_used(&s->fifo) < 2) {
+                s->rregs[ESP_RINTR] |= INTR_BS;
+                esp_raise_irq(s);
+                esp_lower_drq(s);
+            }
+            break;
         }
         break;
 
@@ -884,7 +905,9 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     esp_set_phase(s, STAT_ST);
     s->rregs[ESP_RINTR] |= INTR_BS;
     esp_raise_irq(s);
-    esp_lower_drq(s);
+
+    /* Ensure DRQ is set correctly for TC underflow or normal completion */
+    esp_dma_ti_check(s);
 
     if (s->current_req) {
         scsi_req_unref(s->current_req);
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2913EC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKhA-0006qs-2I; Fri, 11 Jul 2025 16:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdv-0003Jw-7x
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKdr-0003jZ-C3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+iLnFnSkF1ih5/T5mQynKA+eHeYjoDfaR/4447dv4kI=; b=SoiMInGzyWXsfXSgSkJzpSLJyW
 egF2VgrFd/CZPcrqmfnRbWnf7dV5hF5LXzho8rbvockRbjg13ggO+2OERSqULK/VYCJXNoO2q7pSV
 oRvOtpjWzZ7UL99P638movMvKWfNE7NWVkRRUe/TFjnaIrAiP4ya9mEwFKp5exCFbldeYpCIQSjvy
 Ue4OeZXJsD9sDv93MCASAoaI8T3WdexPgkZ1lXuqQxreo19iLAlz79x54MjGekLyp90f9x9AZ9bP+
 N7/uYX2osZxA2wo087Q31kdrZP/VFeR5ekWEGcxIqW5KjpNqwMe7QvuqsfIzMx61adVvDPasixHzk
 QaWcZG52RXEbP8IXdjRCK0/uxxJgCcfaGiWpoNmPAjFT1xySX9J1L1KalJRxuXp12N5Y4XvXIjQ19
 uyoW2qL8783EI59AGs2oZHRu/MuNAlpnoYHn9Wlpmlmn33s1rHcREXJBNfcdaWS/YSWhNu5ooJS09
 tig1omYUGAwVQLQHJP9a/z1ta7LSpaMmldXjQE0c1/QL2d28f3fG9SoxkHMs09O5LcXkZiYNKUxOT
 90yGQZDzE27drSaUuQR0ZAjs34YsywYjb7QLQo+2X/TW7IPMfxio1mPCITH2j7/sMtNYEg/Ed7rwk
 gvNMMN55pOmKNWaIIwUpljT/50wZ0LuB7SdRiM3SQ=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKcD-000Bmy-TH; Fri, 11 Jul 2025 21:45:06 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri, 11 Jul 2025 21:46:34 +0100
Message-Id: <20250711204636.542964-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 5/7] esp.c: only call dma_memory_write function if transfer
 length is non-zero
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

In the cases where mixed DMA/non-DMA transfers are used or no data is
available, it is possible for the calculated transfer length to be zero.
Only call the dma_memory_write function where the transfer length is
non-zero to avoid invoking the DMA engine for a zero length transfer
which can have side-effects (along with generating additional tracing
noise).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ec9fcbeddf..1c7bad8fc0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -631,7 +631,9 @@ static void esp_do_dma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI | CMD_DMA:
             if (s->dma_memory_write) {
-                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                if (len) {
+                    s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+                }
             } else {
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
@@ -681,6 +683,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = s->status;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
@@ -715,6 +718,7 @@ static void esp_do_dma(ESPState *s)
                 buf[0] = 0;
 
                 if (s->dma_memory_write) {
+                    /* Length already non-zero */
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
                     esp_fifo_push_buf(s, buf, len);
-- 
2.39.5



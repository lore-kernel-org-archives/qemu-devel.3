Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC24C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2p-00023b-Hs; Wed, 18 Jun 2025 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2h-00021q-FT
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2f-0003x9-8E
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ODP1MRazS6AOS88cqj6SB7nCEFi/Xtx3gNCTohx08Yk=; b=srWwUtvfEStcfoWHQxiavMtvhk
 H8MvknHU2VEebJKP38ZyRCFxPU7CUJ/f2HIfCcadxferkk4oFOxHD1Mae2ZqR0fj0DO/DKzKFqfdS
 6bMB/dQV/CHI94dEfz8TJdyVg2j3wEaqzZgYJURHtU7qhPQEkwOeP9Spt9iFSdi/JYj0b5QCwFrdj
 BBSfpT00wJd+FwVxvxFE0Gf6MELX6VenOGvyDMUKrdnbtmjlXc6l0CSiElpiHgmHU406+GeQPHtwh
 dBUckkP7+7Oruqn5A6zpbd5LeoXOZwWvvYY0l+iCdSqoQXSONk/Nn28qu9pmIuNo9jmQhAjLgsYCe
 9bClAVJxGW7ndmNbEu39aM9woRQZPOh6tSAtY06e+QdTkZxWqhXWorfNdAbSiDiJcijjde7Oc8hwf
 55j3xn/OvECK2G/8b+AXYqLgU4EQ3ReUyYPfcnO73MADn0d9Uxa8I7IOpmHSy5LOVL79juQKD6jlb
 pKXQetuOcSm9HxM0fQpKoV4RbncFDONc7Y/fHnf6YzSnDLjxYiMBM+Rl1XQVldmKIUyrPAKNQHIFi
 bB+XcQmKAtly4xJxDb8vg94EN6TeelZnpoGI9r+QuQGmuDH8q/ZVwfhibZDnwR7T0dpz1gJhpuBlC
 7eZnWLCbfoOW6aE4qatgPsSwuCFZQ9ZaH+brL0eeo=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm19-0007ok-EL; Wed, 18 Jun 2025 07:11:27 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:46 +0100
Message-Id: <20250618061249.743897-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 4/7] esp.c: only call dma_memory_read function if transfer
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
available, it is possible to for the calculated transfer length to be
zero. Only call the dma_memory_read function where the transfer length
is non-zero to avoid invoking the DMA engine for a zero length transfer
which can have side-effects (along with generating additional tracing
noise).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 62ba406149..ec9fcbeddf 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -487,8 +487,10 @@ static void esp_do_dma(ESPState *s)
     case STAT_MO:
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
+            if (len) {
+                s->dma_memory_read(s->dma_opaque, buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            }
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
@@ -541,9 +543,11 @@ static void esp_do_dma(ESPState *s)
         trace_esp_do_dma(cmdlen, len);
         if (s->dma_memory_read) {
             len = MIN(len, fifo8_num_free(&s->cmdfifo));
-            s->dma_memory_read(s->dma_opaque, buf, len);
-            fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_set_tc(s, esp_get_tc(s) - len);
+            if (len) {
+                s->dma_memory_read(s->dma_opaque, buf, len);
+                fifo8_push_all(&s->cmdfifo, buf, len);
+                esp_set_tc(s, esp_get_tc(s) - len);
+            }
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
@@ -572,8 +576,10 @@ static void esp_do_dma(ESPState *s)
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI | CMD_DMA:
             if (s->dma_memory_read) {
-                s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-                esp_set_tc(s, esp_get_tc(s) - len);
+                if (len) {
+                    s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+                    esp_set_tc(s, esp_get_tc(s) - len);
+                }
             } else {
                 /* Copy FIFO data to device */
                 len = MIN(s->async_len, ESP_FIFO_SZ);
-- 
2.39.5



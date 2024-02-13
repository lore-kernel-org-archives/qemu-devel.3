Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178E7C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0P-0004M7-LX; Tue, 13 Feb 2024 15:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz08-0003vC-Nt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz04-00029q-NZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DhTM4gDIDmfJQO7x8t9iO5PJ+w4+Q1a1WN+zHbtezaM=; b=SCAFyRYYoMOdpWm+SD2uSQQdsa
 BIJ6ibPpYpo7bHtIRF5mp8CMpHJoboGsPg6XCOmdtuENJVEtf8Eq/B/m+A7sh2TQvAqV/GzKbAkiB
 4J0rWOP6cnnLrM1RNpsL1qWFV4D38uxjPli9veHi6ESQYRSwhqLZGQlWB9REuZosXZyKDl2bc9Cau
 sd+4iFhLifJVZcIFdKY5wc8y8NsrEH/EygRYVq34Sxwfg1tVfVc4B3L7WIP2IVNsO4nt9pZ+sMkD4
 GwXTBVHDpMfvQQv6rJfyVINZ+ZYFuzj1BTxLErvBM2xXWKaRPLesUIdgPXhZv7CZbF+Z2SRObG6x3
 vCR0ianj2gVKJaQlj85MHBdLOqjvZyouTB/3jbgBBTahVRnBwGnp9oAdFkACJ8SUXPZ66caMGBP6s
 77skUdS/qwLvSjl7wqbuK9TqYjK2EczR7L2e3JjJ5VG+/cbP6TlszIuRzrTpJ3bJyRyHlu752OsT9
 EUXsg7Ws6WqeDV7geG+IsbT69w4WUNCXRzz48Ji4RgBL1vzvFHU/YQmO/YnMl8xFBM3U2NamF6Ap5
 ukIYKJM8ffSBolhZIK8HDA5iabRrDW1PUWAv3WcFI3UXjJ9JLN3qUU07sCzMluuTdedOT4QRYijUs
 +IP/FcOPbjMabJW2qgUG29k+9JO5ot9GRlPejwAPQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhe-0008m4-34; Tue, 13 Feb 2024 19:44:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:40 +0000
Message-Id: <20240213194052.1162753-77-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 76/88] esp.c: only transfer non-DMA COMMAND phase data for
 specific commands
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

The contents of the FIFO should only be copied to cmdfifo for ESP commands that
are sending data to the SCSI bus, which are the SEL_* commands and the TI
command. Otherwise any incoming data should be held in the FIFO as normal.

This fixes booting of really old 32-bit SPARC Linux kernels such as Aurelien's
debian_etch_sparc_small.qcow2 test image.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-77-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ca26415d5f..17e2db442c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -757,13 +757,13 @@ static void esp_do_nodma(ESPState *s)
         break;
 
     case STAT_CD:
-        /* Copy FIFO into cmdfifo */
-        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-
         switch (s->rregs[ESP_CMD]) {
         case CMD_TI:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             cmdlen = fifo8_num_used(&s->cmdfifo);
             trace_esp_handle_ti_cmd(cmdlen);
 
@@ -788,6 +788,11 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SEL | CMD_DMA:
         case CMD_SELATN | CMD_DMA:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
             if (esp_cdb_length(s) && esp_cdb_length(s) ==
                 fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
@@ -798,7 +803,11 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SEL:
         case CMD_SELATN:
-            /* FIFO already contain entire CDB */
+            /* FIFO already contain entire CDB: copy to cmdfifo and execute */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             do_cmd(s);
             break;
         }
-- 
2.39.2



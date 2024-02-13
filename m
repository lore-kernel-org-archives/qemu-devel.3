Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD3DC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0F-0003xT-FX; Tue, 13 Feb 2024 15:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyt-0002XF-OS
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyys-00023K-4S
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z8el69Zp6Nc98KrJ5/G461ogfL7GkfD2+gn9nmhlztg=; b=ZBIE8CCt8chDinu5JfusXy3sSh
 AvCoA+iEw0D4Xp+/DfOf4VOpcb6U2LyVaYXd55naB0i8UdpVHP4bihGfOkYPQGX/D6GfXNUQH8Mxd
 MCB8MJND2BzGl+wJ70JwoQc1bBfw2eOHYWpQvQ2Kbq4ynbyurVF5h5pUYau/YsFMnqTxGHkGrH7u7
 pJacq2oax6c6hngMD8JT+mgBg5eHUNHml+JVR+ikx50knn89hb1k7xP3XRRSe+0Wo9Sjt9FNl/gJR
 D/Jq9gfk6PI7A8VI4tDWSb+QS2h/R58Mek6EYLI6cHhQw8OA5rLmPulN5fFj0AhtcT9fhZCm6uF/3
 awCiOZBh1dBf4rHw9+Wzya+v0ObfFWzPPgemLfXKHQLMvscfqzbwU7FLxHOR+GaQcxs1T5piyu9m5
 S+HnhHC706nV++ISvc/KIXRJ4Gipgd0sXVESPJzAU88pybTNS8KFmqKSPb9ovSq3f9n4mtRVbjH/O
 UEX3u/aAwZRwNXaauGxNuhZMURY66quAF+5vpBGrGir1LZssNaJA2CUGlqsMkYcS90d4YnbPh789q
 7hjLFSXLpDybV6cGBJonRpOr4Jmj0WmlvvTbrG2ymflBl5wNyHAw3hbaxNsvxHJp+mkrbAKw48LbR
 4ZpcPcxUpigXN/YFZ9+XNU+pDXwZ/gm/6kzlnq9ZY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhi-0008m4-6A; Tue, 13 Feb 2024 19:44:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:41 +0000
Message-Id: <20240213194052.1162753-78-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 77/88] esp.c: only transfer non-DMA MESSAGE OUT phase data for
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

This fixes booting of NetBSD m68k under the Q800 machine once again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-78-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 17e2db442c..d63039af89 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -712,14 +712,13 @@ static void esp_do_nodma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
-        /* Copy FIFO into cmdfifo */
-        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-        s->cmdfifo_cdb_offset += n;
-
         switch (s->rregs[ESP_CMD]) {
         case CMD_SELATN:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, switch to command phase */
                 esp_set_phase(s, STAT_CD);
@@ -734,6 +733,11 @@ static void esp_do_nodma(ESPState *s)
             break;
 
         case CMD_SELATNS:
+            /* Copy one byte from FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, 1);
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
                 s->rregs[ESP_RSEQ] = SEQ_MO;
@@ -746,6 +750,11 @@ static void esp_do_nodma(ESPState *s)
             break;
 
         case CMD_TI:
+            /* Copy FIFO into cmdfifo */
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+
             /* ATN remains asserted until FIFO empty */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
             esp_set_phase(s, STAT_CD);
-- 
2.39.2



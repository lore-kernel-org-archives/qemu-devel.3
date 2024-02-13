Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ED5C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhM-00035V-7a; Tue, 13 Feb 2024 14:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhB-0002pa-DP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh8-0006dB-Qr
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ja7JRkqFqFJV0kPbamIs3T/PoZGNFQ6OhAooTnpxG2U=; b=Z20UO9taJFl8swF4D+W5c000Od
 oCAz3r497yW4HOlhpRm1V9cFQkweOwHbw/Uc2uTgvxKzvK5dyUi9Jmauf42S49P6Zeo5dPhCqfTp2
 YTqG51ZmklG6+z3aQ5UExZYQ4tHUacTyBbAF303YdA7fwWWjGdsn84Jz6Po3s291uLHKOS1s6Su2E
 bR+t5Z7Yi2K9qWSU1m703sB7ORIuinfUBblxFOdi7GiJhvMU953gjIcQ42GmjTGQa9gPH5VSza0uz
 jFk2g6An/5U9AKdiH7iNxHY3duJHJEAKrDYBFiFNO+0YE0RWtgX88/OXmfK6ILyJv5DEyQ6KZ1JIo
 5ioCdsYzw0I4bqt+jffwqyL3419sypkEckKkHburlOouO9M3Gki3GW5eoDQDEKlN1K2TXYCR6ptXE
 i8wITDSc2OffRgEtSU6sEd6hkqOpw5EVlvpZlK7m2s54l9+8MTsOD3tGrDRLidEQyy/wxGO8hxiAY
 PIBZUvbM3tF3ZHh+zTszZrBRJ566n/7IF+EBmyARUvL+2FZ+PopplTK/kIGV9tLoW39Ew2QCQNKSD
 9PTjkhBlzVcuTGezJ+tZv9pHaxZNxaARttbFzxxvfNjdqjMCj+6EwAQAeMe2ouj0hr/qhxqxOOmFW
 SHHug+SRRQjz0YYQSRQHLFcSsJLEKUX3rMkVHlhMI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygG-0008m4-J3; Tue, 13 Feb 2024 19:43:04 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:12 +0000
Message-Id: <20240213194052.1162753-49-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 48/88] esp.c: untangle MESSAGE OUT and COMMAND phase logic in
 esp_do_nodma()
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
Message-Id: <20240112125420.514425-49-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7ab195f884..81144ace83 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -801,6 +801,23 @@ static void esp_do_nodma(ESPState *s)
 
     switch (esp_get_phase(s)) {
     case STAT_MO:
+        /* Copy FIFO into cmdfifo */
+        n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+        n = MIN(fifo8_num_free(&s->cmdfifo), n);
+        fifo8_push_all(&s->cmdfifo, buf, n);
+        s->cmdfifo_cdb_offset += n;
+
+        /*
+         * Extra message out bytes received: update cmdfifo_cdb_offset
+         * and then switch to command phase
+         */
+        s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
+        esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_RSEQ] = SEQ_CD;
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+
     case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
@@ -810,25 +827,14 @@ static void esp_do_nodma(ESPState *s)
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if (esp_get_phase(s) == STAT_CD) {
-            /* No command received */
-            if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
-                return;
-            }
 
-            /* Command has been received */
-            do_cmd(s);
-        } else {
-            /*
-             * Extra message out bytes received: update cmdfifo_cdb_offset
-             * and then switch to command phase
-             */
-            s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSEQ] = SEQ_CD;
-            s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
+        /* No command received */
+        if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
+            return;
         }
+
+        /* Command has been received */
+        do_cmd(s);
         break;
 
     case STAT_DO:
-- 
2.39.2



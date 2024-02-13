Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AEBC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0n-0005CW-W8; Tue, 13 Feb 2024 15:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz0c-0004mF-Ee
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:04:03 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZz0P-0002DK-Vk
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O7NEKvkbj4MXy755AuslcZ73cjKfcA574sHWMKhGl18=; b=MNWsJ5Q3ymM6Sq4CX3NGrv86Mg
 6CVQUdDd2VwWEVlsQlwiwVod2D/XnryNEcmonnk6JQSqoXdZqmZeR0jJGEvLCq0g7Vvd34UpsMUjP
 Y+9ZaARs33D8L8a83W8EBNZwgaOjubygKXD2xJBu7UfVi+RRTfH2tF4tnIv+38FCfy474o7M/gjoF
 /h4cM7boLGV1mdlGKZCZlVW/S4ow+21fZuf+R3TkzdHgRAI9ze464LHnVdIPEh1JLsyR69shmDc/t
 OltvFSTMmq4g4Lu93zAsaGYZfK7SwFC49nbaVyNfeBauACGk2jsiYCs3ZQ9blIcJpup5XbB7g+DB7
 Jyz/kZxejcKZy5RAKLEcw8mC0yWJo2FDfSnE/J5+wvnLY5r5FOQeqxmbd8LIbXdZ2BdK0ntcr5B8w
 oTAVnqWLfIvz7R42tyFwixbaJH2Dl6gVk1FJH1GGc0HhBrVrcLaUg0d+T9wYlHlldNxXIjHZq/KPZ
 r+1iZ8ACsXP/k08cfovtOSYU8yEFoII73QtFWV4a7PM6Asf8zdcBeXeTjyeyJvTzRJRwjF02oIQg1
 KS+WwZLPPed/zPpAmW7Bs6nevb8GrXOBKe5rC9CGCkfLxX2qRtSpuDZOEVLcAdEO3fy3/FuNyE3Ch
 XRhgzL4dDP9GMj/zVnVDGDHtW88+Qxw3NQjWZQgwE=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygn-0008m4-4y; Tue, 13 Feb 2024 19:43:37 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:22 +0000
Message-Id: <20240213194052.1162753-59-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 58/88] esp.c: separate logic based upon ESP command in
 esp_command_complete()
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

The handling of the INTR_FC and INTR_BS bits is different depending upon the
last command executed by the ESP. Note that currently INTR_FC is managed
elsewhere, but that will change soon.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-59-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 73c723afcc..75538f5859 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -823,25 +823,27 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * Switch to status phase. For non-DMA transfers from the target the last
      * byte is still in the FIFO
      */
-    esp_set_phase(s, STAT_ST);
-    if (s->ti_size == 0) {
-        /*
-         * Transfer complete: force TC to zero just in case a TI command was
-         * requested for more data than the command returns (Solaris 8 does
-         * this)
-         */
-        esp_set_tc(s, 0);
-        esp_dma_ti_check(s);
-    } else {
+    s->ti_size = 0;
+
+    switch (s->rregs[ESP_CMD]) {
+    case CMD_SEL | CMD_DMA:
+    case CMD_SEL:
+    case CMD_SELATN | CMD_DMA:
+    case CMD_SELATN:
         /*
-         * Transfer truncated: raise INTR_BS to indicate early change of
-         * phase
+         * No data phase for sequencer command so raise deferred bus service
+         * interrupt
          */
         s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
-        s->ti_size = 0;
+        break;
     }
 
+    /* Raise bus service interrupt to indicate change to STATUS phase */
+    esp_set_phase(s, STAT_ST);
+    s->rregs[ESP_RINTR] |= INTR_BS;
+    esp_raise_irq(s);
+    esp_lower_drq(s);
+
     if (s->current_req) {
         scsi_req_unref(s->current_req);
         s->current_req = NULL;
-- 
2.39.2



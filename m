Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FA5C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz06-0003rz-NS; Tue, 13 Feb 2024 15:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyq-0002Tf-5J
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyo-0001xu-37
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2FAFcHNBlVLQuB2GKtdmyAj++mdJ98v5Jcq+mSJLpUg=; b=LlhKRo4zu0s5JcJ/MvAAh1HCvt
 gs1sZqZW3fcus8zw5cvF151odD6qW4pj21RuqjBDCFjz5iQe32ukkvmeTfJh2ufvSq1egZtA9FS2Y
 9Kg//8uYyDlmpfSD5k8kKhqyNVr3qhtAXWF3AJmiCbKfPB9bfF8wPkZsIJ+ljWRf7K30AI8o8wnkq
 JpN0WaClxFUxVw5tuqOQF0k5m1Vx3hbOqAjNllIEXECV6eInFl1oTAvAvMtsj0I66wOmqbEjdkCme
 +JVpdU52q7g8ZHNkgqclfEh1OjREOlU6QRSIMawyacqg3QxeuXl5XIhoAVOkh4Wqv0GBadJ/ramqt
 MgY9H9grJ5gdy0znlYc1VZ6YLdx+eOQ9N+2kFzxQrSSCDPg8TwxRb5Vyw5ZesEBJf6K2lp+PFxPuD
 HpSP4ocfF31ihs0MOV/FMdHaRCKkSLC8wXT2ErLsuNq63vuv6qRWq5o2NTQHIcVYDYuX64j1pkrxy
 D6NwUOczK6Pz4Uoh56N/6xHYPeZYaidpfzNJ3Q9sodjiCyQELDzhztIRrDzVpfG/T/IGYxd5jqL+1
 8+kyPgoC0V4kHvSceGHeWJmDp+n9DGVD+PiiEyGU2/SRUkGFSsw/nOdguyo0SZCNz+Cuyc3KApi/c
 eB6hIDC2tHTjGRgqTteLyigF+3EzvBbuEAKD0ot1Y=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh0-0008m4-IN; Tue, 13 Feb 2024 19:43:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:26 +0000
Message-Id: <20240213194052.1162753-63-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 62/88] esp.c: zero command register when TI command terminates
 due to phase change
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

This is the behaviour documented in the datasheet and allows the state machine
to correctly process multiple consecutive TI commands.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-63-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4c1ca63a57..ccb8ad4bae 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -519,6 +519,7 @@ static void esp_do_dma(ESPState *s)
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
                 esp_set_phase(s, STAT_CD);
+                s->rregs[ESP_CMD] = 0;
                 s->rregs[ESP_RSEQ] = SEQ_CD;
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
@@ -717,6 +718,7 @@ static void esp_do_nodma(ESPState *s)
          */
         s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
         esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_CMD] = 0;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
@@ -831,6 +833,11 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
          */
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         break;
+
+    case CMD_TI | CMD_DMA:
+    case CMD_TI:
+        s->rregs[ESP_CMD] = 0;
+        break;
     }
 
     /* Raise bus service interrupt to indicate change to STATUS phase */
@@ -885,6 +892,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * Bus service interrupt raised because of initial change to
              * DATA phase
              */
+            s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
             break;
         }
-- 
2.39.2



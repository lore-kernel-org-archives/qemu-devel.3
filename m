Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FCC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0B-0003uh-RR; Tue, 13 Feb 2024 15:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyy4-0001kr-7r
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyy2-0001sa-MO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DVjGUjdm8pNlCRfHncMDmo1GFwUsywzB/AtKRFCKdSk=; b=vcq6m5vZXrBszbAJvXhDLQAAA2
 wQ16r4kjHFsHMvr1WWZ4Xkmzq3GhncWaQneudH2aohooIogJLccOUCexNAFdrX5E2g58acYEH7+Pt
 dm3Y9m3q1ERpclV2ZzpxxhFgrrJyp/lftR2rGwt6L8gPlgFT/klQMx0Q7mK7U8rsRiOckXTgDQ1+9
 /GAVkp/u63BOMnapEN6hllROVedNOi9Cgo6MIkwq6OIIYBuAXbSM0TO40GrCKCMPq4uSq8Mwh0pZO
 9Q719erDwPOHN5Ww3QKLVVRpS90T8KPZqV/3dvoyEBf9yt/C27rn1YQJg6Q5Tz4GjiMOB49U/Llia
 EQfUW9Ut58LjDRiRdPZ+ZePWMI+oPf/tOQgdlelBw7kfnAYoVbOYqqRbWfWDUcIM+FPFQM5S/1q8Z
 V7paq1+xDY6icvuCNFkRUtE4qpa54jDVrfNKUqMLUlqTf641xnvb3ZzYcIVnipI2K36KXpg8jqDq7
 o3v3e0i2/rkGpEj5coJhargKYf9Hyt1AWfENrNZiTNbumHl5vnQ7JcJmaBtI2fA5iVCmSY/Oqs5am
 VQn+3xxGMnFxVW7arsK/9EGzIFnu49kMxwnNO+TF+bgoRdq4iKY0kOmplipI+bg0lDqtWjbZqNCWT
 PZz0GW/PcbVIdeVEGCp2noYTA89xd/BtLiUAcR1dk=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyi2-0008m4-Vb; Tue, 13 Feb 2024 19:44:54 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:50 +0000
Message-Id: <20240213194052.1162753-87-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 86/88] esp.c: keep track of the DRQ state during DMA
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

Currently the DRQ IRQ is updated every time DMA data is sent/received which
is both inefficient and causes excessive logging of the DRQ state. Add a
new drq_state bool that only updates the DRQ IRQ if its state changes.

This commit adds the new drq_state bool to the migration state: since the
version number has already been increased earlier in the series, there is
no need to repeat it again here. The DRQ IRQ is (currently) only used for
PDMA transfers which already have a migration break in this series so
there are no problems setting its value post-load.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-87-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 15 +++++++++++----
 include/hw/scsi/esp.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index fb68606f00..04615d8b5f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -62,14 +62,20 @@ static void esp_lower_irq(ESPState *s)
 
 static void esp_raise_drq(ESPState *s)
 {
-    qemu_irq_raise(s->drq_irq);
-    trace_esp_raise_drq();
+    if (!(s->drq_state)) {
+        qemu_irq_raise(s->drq_irq);
+        trace_esp_raise_drq();
+        s->drq_state = true;
+    }
 }
 
 static void esp_lower_drq(ESPState *s)
 {
-    qemu_irq_lower(s->drq_irq);
-    trace_esp_lower_drq();
+    if (s->drq_state) {
+        qemu_irq_lower(s->drq_irq);
+        trace_esp_lower_drq();
+        s->drq_state = false;
+    }
 }
 
 void esp_dma_enable(ESPState *s, int irq, int level)
@@ -1358,6 +1364,7 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT8_TEST(mig_ti_cmd, ESPState,
                            esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
+        VMSTATE_BOOL(drq_state, ESPState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index c6e8b64e20..533d856aa3 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -26,6 +26,7 @@ struct ESPState {
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
     qemu_irq drq_irq;
+    bool drq_state;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
-- 
2.39.2



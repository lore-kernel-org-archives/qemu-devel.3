Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D27CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3d-0005bo-RB; Thu, 04 Apr 2024 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3V-0005GJ-6P
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3S-00069v-UB
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VPZFc8W5AgIk75pSt/41qtRV5VCgvsi7Nq2/75/Z8vM=; b=iunFRHqWhs9JTro1yQw2x+8W+x
 hwYpz9LL/PspqYbfKwl10ef/Fxup93DV+3BkQcF3rtoK0M6G0cHNzGktryxu2iFed1ea/+50+XWeS
 gFrhi1PvQ1yGlxVGDbX2wsRQJ/nAkiop40Y09Ax29b4c5xko028cDBXXpUF2hh9GFqBuETbeKxgxL
 moRDR5IxmNzSouzqqvXTPWW3jxgAzBgeRniFvgOg3RveztCvCjbZPaszzFgis04SwPZiOmRUNLQku
 llAf5a+Iro7IA3T13dcAi1kV5n6gOuCMAwjsWF+BDynxVtvmEATIcxYkWN8XWkPHEPtvdM9kQGouh
 pA+6MktsMvdzGsA+3Bv9lPIczxid3CIRvm51fL9aQyAH7rbBtVLbZIS2NxvZ5kI7+EI38nfsMqtXF
 xS7nbgCKHPEhjTtixm4RrVrlJgtBvhYaK3IT6fw3lB+JDfKkGWdA+gnApKLqpTwRa3D2PewGzI1vm
 +xL+uGoH/0kqt5TWZGrNrx61mMDt4mJyrKs80E5XDCXlroYZqGrKml6PEETKr0lDD4ZU0VGoZy9Bs
 +12D4mP2HVJxNBmlOyGFQNrAHlKMD7ND7e3dGoBD/fiQtGsgFt/2VtJezr74SP9v6VFsnK+ei/j0I
 x3kTthPINI2mR2AcCAr8yVFvQ+TseemXvZ8/lnuy4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2K-000Bmt-Hd; Thu, 04 Apr 2024 15:25:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:38 +0100
Message-Id: <20240404142539.711134-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 16/17] esp.c: ensure esp_pdma_write() always calls
 esp_fifo_push()
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

This ensures that esp_update_drq() is called via esp_fifo_push() whenever the
host uses PDMA to transfer data to a SCSI device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-17-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4895181ec1..04dfd90090 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -282,14 +282,12 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
 {
     uint32_t dmalen = esp_get_tc(s);
 
-    if (dmalen == 0) {
-        return;
-    }
-
     esp_fifo_push(s, val);
 
-    dmalen--;
-    esp_set_tc(s, dmalen);
+    if (dmalen && s->drq_state) {
+        dmalen--;
+        esp_set_tc(s, dmalen);
+    }
 }
 
 static int esp_select(ESPState *s)
-- 
2.39.2



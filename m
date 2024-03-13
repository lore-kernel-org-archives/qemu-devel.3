Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED32C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKSI-0008WI-6t; Wed, 13 Mar 2024 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSH-0008Q7-Am
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSF-0002KI-Sp
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qqbagrYxG+I8+bUWxEwYLtlRwpjAZkn97vFKt6NO+uc=; b=TWu4nNCFzs/zSCmn73nhdkQ8Zc
 S7sXJu6rGsXm7iSW53hA2IlJ5AGMeqKuXVtq4NZodF726s+X5j+v6jHpMhJgMnKoylZpmCsoSZWss
 oDVfEtmuldiqrO7QCxpDwniKtJHNIyCjCC/BheaeXi/krcBHaY3Hotjey8vF04OLMrb2Q7cGQpqDh
 R9/2fA770x3DZYx5PXfs20MX9p7DSyMg8ZDHbjmGBIdsAiuYrt25UhRvZ5xCAi1htfAt0/ASyvsUt
 peKJzha6uBeVTjyFupn6Dp7Mp+BPc+ZkEKXu4V0ETVtxtc9P7yQHW0nanApLaCcilpxGq21zryolq
 jc2gI/ha1F+pHK0vhejjSlgGt+BSrMH8Ojr0YWl10QVk3aD1zJgMbBpRNRiPEpHqbQqT1XQ88+pxn
 Nr3d8drOqow0lXGuS7wL5RizBszehd5cIBKNDCxo7Mg6UoV6+rO4NbSu//oLvpHIdMvkXgMBH9ehf
 97UP/W4MnJ5LrbLYXmu9Zm0QYaKVegujefcbw0O2CFDYYUDOIlLXFaGjdwBYo+p4MBPDufMDXEw4P
 fU2OMpXt8Gpx4f7HgffDLHglZuX2gBQ6SmjoG55uqZ/Adg1PatgvV38XvXNM6DTKBdg7ExcVmDjeJ
 RTxgosJtRU6bhIj7PwKcXhOsp21EQceFPhfLWG4bY=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRP-000CUN-AY; Wed, 13 Mar 2024 08:58:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:06 +0000
Message-Id: <20240313085810.2655062-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/16] esp.c: move esp_set_phase() and esp_get_phase()
 towards the beginning of the file
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

This allows these functions to be used earlier in the file without needing a
separate forward declaration.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 05784b3f77..86145256ea 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -79,6 +79,24 @@ static void esp_lower_drq(ESPState *s)
     }
 }
 
+static const char *esp_phase_names[8] = {
+    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
+    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
+};
+
+static void esp_set_phase(ESPState *s, uint8_t phase)
+{
+    s->rregs[ESP_RSTAT] &= ~7;
+    s->rregs[ESP_RSTAT] |= phase;
+
+    trace_esp_set_phase(esp_phase_names[phase]);
+}
+
+static uint8_t esp_get_phase(ESPState *s)
+{
+    return s->rregs[ESP_RSTAT] & 7;
+}
+
 void esp_dma_enable(ESPState *s, int irq, int level)
 {
     if (level) {
@@ -195,24 +213,6 @@ static uint32_t esp_get_stc(ESPState *s)
     return dmalen;
 }
 
-static const char *esp_phase_names[8] = {
-    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
-    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
-};
-
-static void esp_set_phase(ESPState *s, uint8_t phase)
-{
-    s->rregs[ESP_RSTAT] &= ~7;
-    s->rregs[ESP_RSTAT] |= phase;
-
-    trace_esp_set_phase(esp_phase_names[phase]);
-}
-
-static uint8_t esp_get_phase(ESPState *s)
-{
-    return s->rregs[ESP_RSTAT] & 7;
-}
-
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
-- 
2.39.2



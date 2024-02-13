Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED49C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxk-00014r-3w; Tue, 13 Feb 2024 15:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxX-0000z9-23
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:54 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxR-0001n2-N0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9iDD6O2+jvA94mMNo3uokhjxaw5j/YMMMk4z58jg9zA=; b=hkJhKQjkfeEk6pDivbHOejEVto
 IV+rMN4qQZQsqTxNNqihK8CWjXYTvdIvhEHVMyVsHK4Pbci/509Ama6wSru8pRWku/iAK2O1qqp35
 tnxVT4p0e0bOOrssZhfRY3oBrO2WVvsClM9wFvyjHnwFM85gAiuANKEilQmw1CiBPGXF2WK//umKj
 3GTzVgEivz8lKngb52VTaZqCEZprK/1n/sUwGMaCmT4WLK4X3QnEJRfEtg/X2Yvqsd2M5epsGN+YZ
 rwMyB97J4MQZL/ANppoLPQnVmfJCAtkW0UG8zaDGcOXSXKYLd4DU7f6jzPE8hBfuISyHSkpQ0YPAE
 cBezeeBNI7K0R+r7CR8vcaXM4O4eLkXINKlyNIflGWinBo/GrdKDPMPmnRVReKwZ0XXS25KQmpaDe
 6ph7fXAfpIVvmBlLw2xyiq2mA8fLlXwLInNiJcUn+SPopa3whY5DBZozO18Zz7pdvYWeFy1HnKyoh
 6QOx6TlSLcP0A+DFVMHAhDa0vaNIVZyOWRNM6YLpBTwBru/lqg06u25fnvNXOL2LAw5OhjAopzA8P
 TI30d3dfsJCa7o+j522ZMbNMeQXjhS7Ot+gunx34d6HQQHcc0uTP6TBz8+z+E5ejDuOGBJRxtfAHu
 VpFKpLBJmvbLSex51uwlQqLrwUylbU48vMIqdX2z0=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygR-0008m4-QI; Tue, 13 Feb 2024 19:43:15 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:15 +0000
Message-Id: <20240213194052.1162753-52-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 51/88] esp.c: don't use get_cmd() for CMD_SEL DMA commands
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

This can now be done using the existing logic in esp_do_dma() and do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-52-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9f787d12a8..3cf8b2b4eb 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -396,8 +396,6 @@ static void handle_satn(ESPState *s)
 
 static void handle_s_without_atn(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_s_without_atn;
         return;
@@ -406,17 +404,17 @@ static void handle_s_without_atn(ESPState *s)
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
-    if (cmdlen > 0) {
-        s->cmdfifo_cdb_offset = 0;
-        do_cmd(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_CD);
+    s->rregs[ESP_RSEQ] = SEQ_CD;
+    s->cmdfifo_cdb_offset = 0;
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
+            do_cmd(s);
         }
-        /* Target present, but no cmd yet - switch to command phase */
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_set_phase(s, STAT_CD);
     }
 }
 
-- 
2.39.2



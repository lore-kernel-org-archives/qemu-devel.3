Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F59C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0N-0004E0-5a; Tue, 13 Feb 2024 15:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyw-0002Ym-Pj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyv-00023o-AE
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EA5YnaUP3gDHF5AaE9uZujarI/GD/Dg9Sof51XT/n9E=; b=HlRioVnoEYONPiOoQoc9nRxgJT
 70Fg7A6wb37KXLbD64BYULEbKAsdmhLIKfwJyjHEwpk7K2cmFTb6OtzdU4Oy1vlpm3abvbURR8cDn
 RwYnKTuZyQo+Q0GsdV3yd4DwW44Zpz2pdVQ1d9/i8yB/sHWPBfYETjJtWwyrU3gLswcNlpp4jyapm
 OHNIR9Jddujp0R5ak3/QCe3T6AuJQwS13hC4r/UEZj1aX57q+bEd3EzNZBZOojVjuISP43VmV7aIr
 /yBxWhOzvHWvC/fddrgFPwL2jmkPK+vUu1W13hhKfMbP2sDWBUiXu0asSfPbAPgnDqITTdmo4e4Wf
 EA+UNpaUPYGExmDnHkRxr68tiSjdX8NC3qjNES87Ymrd0Ua83iYpNy8dG1xxI3PqAsioFLEwfAwKp
 LHcq7xKYHg5yOyBjbeJbFCR79uqVleew++dhvH3vUhRvZd8Y75CcDUnnVexACR2RyVVisg9+4A5TY
 F7701FJ/Hm8IzrJWyzpUjUAmZmKtOABs8n0Dk2Tk9hUnATUP1zkLe/AxpJfmfQd/CcLb0/jM7ZujW
 y7TWHQ8lq5TBG+KHXebNxBZtd5WZMGuwnLO55p+LT2f/ZugeK0N5SO6T+7fZgpdX3L6nrHAeN7fy4
 cNZAufW9D+BCnAq3sB9fSioO4GBw0TaTwdeBWbzK4=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygd-0008m4-El; Tue, 13 Feb 2024 19:43:26 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:19 +0000
Message-Id: <20240213194052.1162753-56-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 55/88] esp.c: always use esp_do_dma() in pdma_cb()
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

There is now only a single implementation contained within esp_do_dma() so
call it directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-56-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c6e5ddd537..bdbdb209f7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -807,13 +807,7 @@ static void esp_do_nodma(ESPState *s)
 
 static void esp_pdma_cb(ESPState *s)
 {
-    switch (s->pdma_cb) {
-    case DO_DMA_PDMA_CB:
-        esp_do_dma(s);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    esp_do_dma(s);
 }
 
 void esp_command_complete(SCSIRequest *req, size_t resid)
-- 
2.39.2



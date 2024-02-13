Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86184C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyee-0002Px-LQ; Tue, 13 Feb 2024 14:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyec-0002PI-Jz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeb-0006FH-70
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eSyr3No0APEoI/lcC8TKsbyD63zHKLL4xNSL+PAfQpI=; b=nWDexq/kRZ1IaQVLpamz12kP85
 RVFt4LrnmJnUpGhP3iJuNldQ0CFU6h4IEMQGHrek31WAKiLeWJV2exRsWUhJX4TJM8ARR8Hya5Xv5
 68OUcsZ0IExwdemCd2G/8j7nyuPkWaTiCy/8+PrCU3SDO/TKeKYNgGF1FTet/V9k9muPGfGPilfFx
 EaOJuT+VVzF1C9FG6OLYs7DaWP0izNzcMu1MeTe51xhHyR17WFl20Y/xDjYIJqqHn9Ay3+fzFbJco
 zFMFTaaViutqzEpLRI7XZH7AwUMtChhTaIW0WwJA/uSwv5PSZojGzyQ8r2OeqgiofjZw32rX/Ntu8
 p2raoKvisSpDXQYC8EmeZ2JrSJUygvbShX8wD/UdExMfVVzRsWC/ZGA9jGxE0G7+9qQ60W0/NrYgt
 sYtRP5u3IFKm+SF7PCKHu3uUdnmPLN+hiGXc2pt98dQz8IsP4fvrpqvwhByG3zy2rdWrXFP1i3h08
 XTvT/Za7JHMylL/HiSPhNv0x6Qv3H3MnYLTCQd9GY1dsNqJScDz8SskPW0/jkzMHrCrc2hq+hOOFF
 JYD9nMzduS7B5XvkzfvvJwsTUw9CIVF3WFQOI8HId6RZMGf0YhCGcsMyCF0KJaoSAKkKN07BLBlfw
 wXHqssGYx8dW4+y67DZjLA9URMKdPeFy2s+Q9fIAY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyds-0008m4-DQ; Tue, 13 Feb 2024 19:40:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:28 +0000
Message-Id: <20240213194052.1162753-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/88] esp.c: remove FIFO clear from esp_select()
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

The FIFO contents should not be affected by performing SCSI target selection.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8d8f6a817a..89fce05e58 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -220,7 +220,6 @@ static int esp_select(ESPState *s)
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
 
     s->ti_size = 0;
-    fifo8_reset(&s->fifo);
 
     if (s->current_req) {
         /* Started a new command before the old one finished. Cancel it. */
-- 
2.39.2



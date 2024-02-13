Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1A5C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyg2-0006HJ-SI; Tue, 13 Feb 2024 14:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfz-0005xI-Sy
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:43 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfy-0006Om-7G
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wBIBZWuMiDoOYKRhjfAiD1yeByPTZKfzMJ5uBORyLnw=; b=nM1NfNAi351jd1iv+pSUaxIuv5
 lMAFvmHPHYd3tqlAU5mauh4ootjGTs1OBeVg+za9tYl0QJ1ii/IF8e0hk/aBmwUiEQUKygxgFylXz
 jwEJGM6DaTPGMd3EQDSS/ZoQp1+hVwXp0CTevkL/Blrb7RwshVq5+uZ4vn5MTNBSPEPGz6nLFf85v
 whwI0o7yip7Cnbqcdybp29VPPPcsg+l3mX+yV3vLB3G3wz7ul76ivJJDyUaDk9jFAzbCH4BUtKPFY
 BF4NHk8DccQx76VN6kVzF8tWsyybY8rfTisx53fusxYD1fn64VOSM4qz2hviS3TMWovtMbh/mLsxB
 Raby29bOm9Msj0u4l+OSXPVYIYlJxEaub4/jk/kBjHIiPdPafJKxq0qOGEC2eG4RyfGQUdjGzeFFj
 oI+F/XJtJwrP+oAF7pAqk9bA3CK18QFXmuhImA7wnoHbkxuUEfzCJyxgNuSRtaB2Rane+PHouN4n/
 7rmI18zMoZ8UDsrb9NRhltHekG9DMBda+qpOhGOiQKUlDT5Dy+p8mqXOEH9rkhj8jm3+bbtPUgTIB
 Ms2A7QfeWGgDTZVcOCOHun05Cm83wBCBdzboqHE/ICknoLB7hh55d74XM1CqJ2eZQkKn4aSITV4V0
 lvNQ+DAVlbqqd91PRbETrB1J0Mo9iesenbHm8ElC8=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyf5-0008m4-G1; Tue, 13 Feb 2024 19:41:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:50 +0000
Message-Id: <20240213194052.1162753-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 26/88] esp.c: remove unneeded if() check in esp_transfer_data()
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

The following ti_cmd checks ensure that only DMA and non-DMA TI commmands will
can call into the esp_do_dma() and esp_do_nodma() callbacks.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-27-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3db90c9ab7..96123c5f7d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -916,16 +916,13 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
         esp_raise_irq(s);
     }
 
-    if (s->ti_cmd == 0) {
-        /*
-         * Always perform the initial transfer upon reception of the next TI
-         * command to ensure the DMA/non-DMA status of the command is correct.
-         * It is not possible to use s->dma directly in the section below as
-         * some OSs send non-DMA NOP commands after a DMA transfer. Hence if the
-         * async data transfer is delayed then s->dma is set incorrectly.
-         */
-        return;
-    }
+    /*
+     * Always perform the initial transfer upon reception of the next TI
+     * command to ensure the DMA/non-DMA status of the command is correct.
+     * It is not possible to use s->dma directly in the section below as
+     * some OSs send non-DMA NOP commands after a DMA transfer. Hence if the
+     * async data transfer is delayed then s->dma is set incorrectly.
+     */
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
         if (dmalen) {
-- 
2.39.2



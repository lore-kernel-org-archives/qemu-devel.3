Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307F6C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0Z-0004hV-HU; Tue, 13 Feb 2024 15:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzm-0003Ot-K4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzk-000297-9c
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lCcVmtBwJiODyfDlYMr5RG6ZC3miM3ji9vFj9Uh7JIo=; b=I+tAnq0kHrHJlZDu6BVU2r1OuV
 cdCyxR7Nk4wKAHhM8C5NoHZXm8d4ce10UxCMJ8G0AXLuK7kGRjFRMEOAtNSPmNrrD4x1jc5nk3IM/
 eWtsdR0cwUDMaP6M/T2h3kvcjdQ9DjBu8wp0KmlYNIfhPw4HevsG2HC909vfK1EhRRnZd91XY/1UR
 jbGmy9FNEpsE6WeJlGnsMKzeJzdT6EZfpsk9EebxTMeiqiXBvDfTJdjC18l1a/fVjDphI4lxdvhIG
 1GHzoITUUTheESn4rN7h/ntyIQGlJgGhyIugybD3sBdCS8HS5ORIm949ruagesHAG2emY2//0Jd9R
 1ZjI0/xUV85sYh9+kDIhjzPKA8Dd0KY7Mig4ESnrG+yTUcs7qP9NGWm86j/mY6QSXDrqJsTreYKng
 ElGd2bwCvZZfeBxsgZuFNEbiAosVQC0TZFQSkYfTBGgTVtpY3Ald+TgGaPVFNbkx4q9EELOTGQ5hQ
 OIs/toDABKwp+2Oci+4+miRMxeQCIIumyjd0f6bCztebwGruVCnv6UmfU0QbVCXka0lQeP1MJ4Snq
 O8BvlVtWzBuPxfHQRVO8DBbbKo2FM9vCEnFEhUlQUObLPrUo4lEnSigfNSVM4323JEM3qyv5Ltx+R
 gQEuf09zK1nbBOUCUE9m/0lTI8Ch9ovk0+KhSf04E=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhx-0008m4-Rf; Tue, 13 Feb 2024 19:44:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:46 +0000
Message-Id: <20240213194052.1162753-83-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 82/88] esp.c: consolidate DMA and PDMA logic in STATUS and
 MESSAGE IN phases
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-83-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8ef6d203e0..879e311bc4 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -593,12 +593,11 @@ static void esp_do_dma(ESPState *s)
 
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 } else {
                     fifo8_push_all(&s->fifo, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 }
 
+                esp_set_tc(s, esp_get_tc(s) - len);
                 esp_set_phase(s, STAT_MI);
 
                 if (esp_get_tc(s) > 0) {
@@ -629,12 +628,12 @@ static void esp_do_dma(ESPState *s)
 
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 } else {
                     fifo8_push_all(&s->fifo, buf, len);
-                    esp_set_tc(s, esp_get_tc(s) - len);
                 }
 
+                esp_set_tc(s, esp_get_tc(s) - len);
+
                 /* Raise end of command interrupt */
                 s->rregs[ESP_RINTR] |= INTR_FC;
                 esp_raise_irq(s);
-- 
2.39.2



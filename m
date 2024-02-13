Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C5C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxl-000177-EN; Tue, 13 Feb 2024 15:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxQ-0000tp-Mu
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxM-0001le-4t
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/4b2qXYE5TasC3qTglGpRtlfM4iIhOd0YqVHhOTuUg=; b=FOVrJMCrwPIXzmG42lgsAJ5TZc
 7JvG9F6P1DkgxcGdDhXR9gZ94ad47IsIhNCyC8mT8+2d8rZtJnpXTV2gF66Hd2/gICVHYCBCJvYFy
 EaTVMLRGSA/CCo/1mffKpSG6dPRZe84DCLizU+oOnFMPk0SNf9KA/7UarozSBXFNHJH/TrLHKmths
 QsxS17GzuYXF4SmxttkaJQC2lu6z2vd1j0/PoULIs7QawUZyN2MaipxXhkbpbQJzqIXRD+tiVsaq2
 PlAsyh5zaBbl8h/NnijbvsAjOrab9s2Tn+yVd9VF+Dbk9ckYSI2rdQJtX1wTjjpEjpc2XkoUSyH3X
 p+dGddc1v6UJDPrqOnv6PwPEPOtVlM1I/cZ9cUMF8THIhWJzAFhKfMkQlLMXCxqWAMjygOpgB3fF3
 ARq8cjEEOShCnj4jwnAYKie83zddKo3YZNsnUxqkmwRMXRTVgbhEwsMIo3Lhut3O4peDg53Phjxeu
 3K25gmLfrlt0tYHl8GgzlzlzRIj7ngpwa1N/LsScNyH3OFMlw57/b13Tp+s4+jGhU/fl9HcyEyWUR
 DhNHRZ5s5KyUUnKlkDJZYz4dXZhTS3hXhtu+yLlA7IJM00BtP+8+nMrPQAuVjlv9Qy4wwQ4Hf7kqG
 OnPPmbKkVaN106G4mbuFT8kS2kWwRPJZ/0HD+SMHA=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhO-0008m4-KN; Tue, 13 Feb 2024 19:44:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:35 +0000
Message-Id: <20240213194052.1162753-72-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 71/88] esp.c: don't clear the SCSI phase when reading ESP_RINTR
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

According to the documentation ESP_RSTAT is cleared (except the STAT_TC bit)
when ESP_RINTR is read. This should not include the SCSI bus phase bits which
are currently live from the SCSI bus, otherwise the current SCSI phase is lost
when clearing an end-of-transfer interrupt.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-72-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 604fb9235d..8ea100ee9c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1128,7 +1128,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
         val = s->rregs[ESP_RINTR];
         s->rregs[ESP_RINTR] = 0;
         esp_lower_irq(s);
-        s->rregs[ESP_RSTAT] &= ~STAT_TC;
+        s->rregs[ESP_RSTAT] &= STAT_TC | 7;
         /*
          * According to the datasheet ESP_RSEQ should be cleared, but as the
          * emulation currently defers information transfers to the next TI
-- 
2.39.2



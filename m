Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E6C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhD-0002hg-Ta; Tue, 13 Feb 2024 14:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh1-0001rW-1w
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygy-0006XF-Oa
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jph3CVd/Fj+VABXOF8+TEldU+YdJgSoPah+PCOJK10w=; b=AQXBtAxG1xccolyIZu/VwS0fMS
 8R3Zc2unOPnQvxYErbBtUjdWWprrm8S9UDmLR4bB3zsViTb7ajB3VFxgSqNRokRVlPc+ig9n1QlfO
 IrydA/JlFSe+rdUwb4B8mpgBxUG1AN1BA6fVrbbYM+osm6O3GCgYBS2MHh/F1E5FGYLORb2cPsNXR
 Sio7YrTVahJbpuOXLCPZKaOhHetmeVL+57ey4Y0MkL4R97gy+mna6MX4818ICJ7T2hNQsm0HwYNzP
 VIs3s442ctXOIO/oqwYQZVBNcYQuA6JS3GWFJWt4tiQYyjRZy9h0nh8aI/La22Z+TV6DYQltoMDrk
 4cYJmT0FOOQuHvKWq4zmrsQK1lqTqKY64nlsQvOL1O7PKqBHxSxlKYX1xxeDMNeUCdzMZg34e571e
 +UDhr6WZkK1GUmdrzdh0lpuDqtPkiBe+/sGYoaxhAjSvw8APre8X1OA1HlPY+HPrt8/SSHMvPDYO3
 yFQGCKBXNyMbOwakz8D1mkt0ULcyuOEWOcCEsIdcHJVO1UpyD2OrFYo49WXiho3GNnfIzy0SlAM5I
 B77DJ/FS/PpyBFqZWi/W8+iGaa4rdSt30LbcEOW1tuYT/SIN2hzdzbcayQVCoT3zo7/UjqArTiNoN
 oaSQbaFaFVyOooFUMsv0OTvS5u/pIOFwI2L3seQCs=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg1-0008m4-Nu; Tue, 13 Feb 2024 19:42:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:08 +0000
Message-Id: <20240213194052.1162753-45-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 44/88] esp.c: convert esp_reg_write() do_cmd path to check for
 SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-45-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14759ada78..e679b1c39b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1207,7 +1207,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         break;
     case ESP_FIFO:
-        if (s->do_cmd) {
+        if (esp_get_phase(s) == STAT_MO || esp_get_phase(s) == STAT_CD) {
             if (!fifo8_is_full(&s->fifo)) {
                 esp_fifo_push(&s->fifo, val);
                 esp_fifo_push(&s->cmdfifo, fifo8_pop(&s->fifo));
-- 
2.39.2



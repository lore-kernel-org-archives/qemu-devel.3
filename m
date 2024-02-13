Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2ACC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyg6-0006vv-0l; Tue, 13 Feb 2024 14:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg1-0006GV-PB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg0-0006PJ-91
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rztxPF2KL8bBXmJOqN6I30ocrg/o4uM0EjWkKsf+Its=; b=iYTOdRchRnUgbERToQ1Z50ELyv
 jDEoEATzGWGCD2t2BKun9iVWI3uIj/5Ok9YLNlAiALbcYp5D5Lxj2/zTGJljyPUpKbRGn1ZJ1IB2p
 KYwVqpl38eH7op9qX9L6Xf1wwZNgzetNUtkAAOsWEYh9M/ECLBthHO0/PhH0woVr+FRNXuN5Ga+HX
 60G1jiLUD+x/I21M/SEgygPh77woRlTuvsFaEV/OiH/gkCASpVhGWZPnF/hbbSBPq1ioBMjfl9Ke4
 NGGde7NG52/OqBd7Yk+FVtnarMBpMqywfn4pADcCHYH3o7LgDqMKhiVAZ9ovsWezWIl6KgjaagERL
 6Pmyfgt6gE5xAfI0m+wViy9tl3tt+eEzgSO+dhkYsslrl2hHeUBdDP1Ixya2gYYI2TQL1/22KdiwR
 pl6LLqMTrIvhFm7eN6OyILuN5EfZisrq3Zkmu7Bin5XNZAiOzdDnN8L9WOxzdKpDOMGUivEY3Ypaf
 ZH9FpQygZHS8E4ZB1dqEpsZqkVOxDp6X2NWOEWKTN8SetKc4fltxf+SwiIvZtpoMYK9YN7dE+mZSM
 d9FPDJKNtv0bgzAESD3wh6SlnudFWyz1FJxvqlr5hs9UZFNUtneHkLKe5z9F1DnifqtVbfygYbM0p
 lYZKBV0bdwRIPujRFslTyWacH70xrG43Vo5t3luME=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyf9-0008m4-M3; Tue, 13 Feb 2024 19:41:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:51 +0000
Message-Id: <20240213194052.1162753-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 27/88] esp.c: update end of transfer logic at the end of
 esp_transfer_data()
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

Since esp_dma_done() is called in both cases, and ti_size cannot be zero
(otherwise esp_command_complete() would have been called instead), replace
the conditional logic with a single call to esp_dma_done().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-28-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 96123c5f7d..6b0811d3ce 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -925,16 +925,10 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
      */
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
-        if (dmalen) {
-            esp_do_dma(s);
-        } else if (s->ti_size <= 0) {
-            /*
-             * If this was the last part of a DMA transfer then the
-             * completion interrupt is deferred to here.
-             */
-            esp_dma_done(s);
-            esp_lower_drq(s);
-        }
+        /* When the SCSI layer returns more data, raise deferred INTR_BS */
+        esp_dma_done(s);
+
+        esp_do_dma(s);
     } else if (s->ti_cmd == CMD_TI) {
         esp_do_nodma(s);
     }
-- 
2.39.2



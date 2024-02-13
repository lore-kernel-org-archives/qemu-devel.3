Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6892BC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfm-0004TW-NO; Tue, 13 Feb 2024 14:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfa-0003pT-Tg
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfY-0006Ln-D4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Lwfrh1EvAiWa40uM3VENBzmpRMnletbaa8WGmra4kE=; b=VA0OfjvZ+i+opJQTovzFSdnGmk
 SBzcYpCDPDvfAkyJOlh9u8C0+5ejIaPrcS/URc4LGu8NFxRD4IQHhbLGentQ9pj6k2FfQ4SfoKXMQ
 5ZwgoQEwCiNegtITfnCTbQNKO23Az80al/7+3i2zT3kZDz+dkMe7HDv0wkCJQ2wm0AyyPt02u5Chp
 H9V0ROjBiqx8V9sP5lwVx2FxPI5lqSS2E4nAC+Zjyb2sBtnYoKM8Es6mwe39+3Um1dW37xJ3J/c11
 0q9tWsXmHZ4gry9CDt9ExTdCVsF6XHNaLm5Pb5S5yE95wVpTXcGOCYM0RkAxcNzrkbLmgNTOiZ6s5
 S+OsU1ialXqXyXDY5tjdV4FuzDkbAJYUHpn5l67pK6wKk5t8RaMR6Fabz850iDFirXKAqfE1+c22I
 ydw+e4vxc5cDiJCvcvCrPQGW+UnTrdGeNmxuZm16BxT/IxJlO7igxbKIXY0enb/CcWjJZ8elWiOqQ
 XcLNkcR1snRaDTKX7HfGWn/2/W4GvQVxIa+8sHCbQFK7GSquZsrX31FR/9iVjiVvhwLJwn0bYJNw+
 CUsHxGrbKTn/eFVO7CYq7UQejpNEUzUi/rjjlPUjxDE1oG5FCoimvijRE7j2uRIcCbZHGjmNXXD6i
 14/yQsyzuyFfqkpJVSLVzES1/IvGHaVy0dSMF+pOg=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeg-0008m4-2e; Tue, 13 Feb 2024 19:41:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:42 +0000
Message-Id: <20240213194052.1162753-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 18/88] esp.c: don't clear RFLAGS register when DMA is complete
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

The internal state of the ESP sequencer is not affected when raising an interrupt
to indicate the end of a DMA transfer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-19-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index a4a1f41a40..5b9c3f1e5e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -546,7 +546,6 @@ static void write_response(ESPState *s)
 static void esp_dma_done(ESPState *s)
 {
     s->rregs[ESP_RINTR] |= INTR_BS;
-    s->rregs[ESP_RFLAGS] = 0;
     esp_raise_irq(s);
 }
 
-- 
2.39.2



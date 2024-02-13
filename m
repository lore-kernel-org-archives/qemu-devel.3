Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C8BC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyh3-000279-FY; Tue, 13 Feb 2024 14:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygy-0001dN-O3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:44 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygw-0006X3-WD
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FQzD0zwlDAHBmJoAyYJ+3VSSgw7i9cg0yGepAyKd3Fg=; b=lPkPaZQrxf0fXrdu7phcFuXAp8
 2ST3k8bQDMGgX8M6Xj72CB1gD7B+YABBCrIcMBG9g0+u234JNOxcgwC9OEBH9N9pOGxuS0WlVShmP
 lYYjI8TWukhC5fSg8jo6A3gxzs83c+qWxKgNhM3RMia2RD+unQtU3P4rEFasDti40hR2q8iJxlHPy
 Ezgls3QRku4CcoqSxnATLFRz+r2SS1b30YFwmUnOGgUGNpPprMLVsqqYedqjM8fKEmbebNMC5bnrj
 5x0d47rYxtka2nVK4ePypLxgl4VIFbtw8/KeLHlkTYaA9L6AcV+JYU35ETZuMpluj3l2mKJhHUnpY
 k59A0UNF+afHOxLIssRXSZFnjDIn4yhAXm6OOPZdKsCd3Y8/YbbZ6wPrmFX16AY9d3WcLNsNwYw07
 oB+q2id1OBPdLAIigzihShOj8+LOuuuCtnnQf5siQ7tbK/WHx06Lvo4FucmzewQKsgFD6+ipOV9hu
 VkNeX71UYy/K3X+RTIgDAHc/PhYFthxGvAA2HuKQnSk+ApyheUsb8pNz00foGNSeN0OpRFnffAE1C
 lI0H8riQOBuqfpLCwwkOwQg8jOPJc5RYU+sJ57geYqn8W4XH9sS1W3ajBbvooTvhcu2jcP7soR3oe
 rgi2efiSWbuu1vOfvxG4OFVhvZa2joV9fysO+b89Y=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg1-0008m4-Al; Tue, 13 Feb 2024 19:42:45 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:07 +0000
Message-Id: <20240213194052.1162753-44-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 43/88] esp.c: convert esp_do_nodma() do_cmd path to check for
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
Message-Id: <20240112125420.514425-44-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b48e020689..14759ada78 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -787,7 +787,9 @@ static void esp_do_nodma(ESPState *s)
     uint32_t cmdlen;
     int len, n;
 
-    if (s->do_cmd) {
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
         n = MIN(fifo8_num_free(&s->cmdfifo), n);
@@ -816,10 +818,8 @@ static void esp_do_nodma(ESPState *s)
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
         }
-        return;
-    }
+        break;
 
-    switch (esp_get_phase(s)) {
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2



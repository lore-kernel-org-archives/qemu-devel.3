Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8396FD2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEf-00040E-9L; Wed, 23 Oct 2024 05:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEc-0003ay-O6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEb-0000dU-9p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=M4+AbyFd+V47Vor7a4c4MKuK0UJtVeO2xqGDORQ6zn0=; b=hQImOxIataCvVr7YsSPoHQea89
 9U+vQ9cf4N0I3J2+SuEo1cb/depQAEyxndylW/3iaHWzLBm32hFxrW71dZflae+CMocetckOd0a6r
 261dI+D9Sf+vfaoBTi9xQJ5WzELl77uUSjRLovdK7VLSpj8FaLcTP8pHwMcGwd/YyBZ13BHSejFDn
 DAtQAJLMvIVF/LwOst3hddI4al7HeycNUqjkSBpAd2GI7DTKtiDkuAAz/iSF61VI/luZ3qxmWPqVr
 WEbVKiTF2roUc4iGNnQbA6AW4Jnex+f0apY/POFlOnXdVN+kh/K4n2+eU3FU6bfBmFlC/UFBY7tY6
 Cn+cboosjj6LlPR5AyoHABzmL6ezCtBVfSB2tUJRBX0Ie6/ZY81iPRxI8UPlcKFISAOttdhSpIyeL
 jzNMJd+zFWvc5FTZfNFK+bf9+2c9znTXjSwOrhDUKkoakUgMhAIPmHocEZJbf69Gk3dXs7VMakCRl
 YWRrJKucdRP8YZOv7oqO4xxagsZkkGtMaFNw5KR5I099WOIKZVO4rkF8etuwJ/z9YLMbeSBEmHSRa
 O/uBsUS+HT0jLndZfDX7fCWKszHqRILaGHI2bo8+JJzZFlryTJKU+N29aPofX65AEGELiwkmUpD1n
 ynGCscceSl+XBjtRAS8XsCrg/oguGpPtlSFardZzQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XE3-0008EL-Cw; Wed, 23 Oct 2024 10:00:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:42 +0100
Message-Id: <20241023085852.1061031-27-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 26/36] next-cube: don't use rtc phase value of -1
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The rtc phase value of -1 is directly equivalent to using a phase value of 0 so
simplify the logic to use an initial rtc phase of 0.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 43b2c775c0..e4d0083eb0 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -265,9 +265,6 @@ static void next_scr2_rtc_update(NeXTPC *s)
 
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
-        if (rtc->phase == -1) {
-            rtc->phase = 0;
-        }
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
@@ -282,7 +279,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
         }
     } else {
         /* else end or abort */
-        rtc->phase = -1;
+        rtc->phase = 0;
         rtc->command = 0;
         rtc->value = 0;
     }
-- 
2.39.5



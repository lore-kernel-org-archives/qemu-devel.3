Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DBAE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfn-0001At-E0; Thu, 12 Dec 2024 06:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfl-00013u-Sl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:01 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfk-0007KF-B6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cVpyN2QQF0COaFyYV3s7+iWpKdYhCAUkUeEZFcdjpbU=; b=oB+j1sQecc7GQzneYXVTgATyAi
 3ppuQW97oWNGlkgZX78kn0418oHItUlQyDncyUmFXSKrDrYX6L+FsU0BDXT84OnLNIr9KAO6+GaU5
 63MAxHAnTBtcaAeo3hIw7BR9TRt1JUhT0kto8zSKyxjCFHo4SfGSvnISa7iNfjlvt7UsazNlzJaxw
 K0n1uifCzm2rGplXU5F2QGTkSg0GaOCLTqpPbdU6jjbwUJAtxl0sxzSeCq9QSSClr8mH+iMQjtU8j
 tC9Px0O0pQP5Gajnpde1V0czvRli22e/fs/Flfyf5/emTeFRanw8lHQ1WQPCiWMFIxzr+GqeGm/Qy
 O7h/3qoMFuIrZUWTHvaAmxNSOhxO3Z1vP1jLvamOuJLsM/re+doCMGiwxcvL3bP4+gTRmJG+GjC6p
 nYPrzWVKLwr3lcvY9m3Yom6/E9TB2vmZxPj7HobV30Y7lPzv9sxxyGp7fOcevNCk3qQSa5M9G22Xm
 5a+uhC/aPdbxbs4U71Pvv/XtOJqGXrTa1EmXxWvypTVg4XiFcYnNnn19J4nyo2BdTZ4yooQLpbp37
 L988zxjZ96S9Z3tppqNzYqRp+zHrjbQZu4O20TWo02nYQDVOXimw/a5ZLo0g7CB5mXKEQswGVm4lD
 V9UODhpV59FaFo9l+LyMuH2scuNRCC5FFolorrudQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhf0-00070a-Hm; Thu, 12 Dec 2024 11:47:18 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:10 +0000
Message-Id: <20241212114620.549285-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 24/34] next-cube: don't use rtc phase value of -1
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e13f46add2..9c91ee146a 100644
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



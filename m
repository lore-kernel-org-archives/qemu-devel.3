Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE483E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdM-0001Q3-7g; Sun, 22 Dec 2024 08:04:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaw-0006Gt-5h
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:16 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLau-0000qk-SQ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=G3UaWb5+AChTPvmSmD3mYqQ2bf9jXH9WodCr4bxG6tQ=; b=d1zjwuPXgo1TzK1D0qmE1jLfdC
 xxto+Lq/DjxAMv0gS1eqZ2K34qlN46qQNYSgbq+WUJocz1pACOmcutLtgHuts7ASmRpDrlysXGA9F
 1yX6dPnSzROvVw4lmHP9fSj1nSYpZAHyECCA6uJz9/x3eSNHo7Um1l6Dr50pju7WJEg3kzHGyhFcS
 PdzjFkXiG9PjCadQxaAtN7hbkK/1UKsEh3M55ektaWRDFzl19vdgeEhpORG36iSbWJiRKn8fSkw/X
 JGC84G1nqABhEL2+Q7b7VuVTzPUJbSzFRsPzYKE3DftY9Sueyz3z7CAQznSRVFb+bFORNFNOvtZKM
 yo0E0hXG31wDmglCN3hvfIAiKkz4aS2uclwXkA6WJj/94QyDkHiIMmEbgReSMM0OzSF75NYWTK3yE
 So60/tL9f8EZqH4olCk6P1GWVP2AeiaO28c4vUuB688Z2IwufpEA2zaMn1xBXo+p3we8qL5BZtExm
 GkyUe8MviqYj6EP3T0sYtdKn0HB3YXUaKjcZQiiwOK5bhy2vEOkC/05Ruv3b0uCx4p7dovW056c1g
 S2GN4PeZfJ5E41TnMaK1Wn5EQKj2i0QCrNkITfSG34tUhsxA1skufabTYbSOsdz3BM1CqXgyLdqhq
 R0pSGaNvvm9sPl4iyy3SHnesX/JDCuWrFr+NuLXtk=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLa6-0002L7-RY; Sun, 22 Dec 2024 13:01:19 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:03 +0000
Message-Id: <20241222130012.1013374-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 24/33] next-cube: don't use rtc phase value of -1
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
index 53acf0a1c7..9daf2207a5 100644
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



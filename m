Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FBC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAo94-0001UQ-IM; Sun, 27 Sep 2026 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAo92-0001UC-Be
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 08:38:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAo90-0005KG-Hc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 08:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=OJq8gY5uEKeVzGP0xxA6OJLaWRHzdv5n7yDZ/3Pxoo4=; b=taeuaQoR++tg7DEOh5J0DYu5A+
 ZNuCYKq2LpxtvWPKd0YMDnL4DbB0OwVko0X3Kl+YJfGqEImNdPFI2bH+ITlUb/j+I+YngbdZ7Ase2
 wufXOfTh4++vDICaiP5UQ/oy47oYh5XBVeot3c8ymswoD5UTPLkpXvXprRKf8qHZaFpKJ3D+ZWibR
 g5E9lkWJNB/U1j8mGDOsOZoW6/uEH3O24NQXm1xvHiP2+BOFXGJYGaq018Nm7EddFqWj3+5X1Aw6/
 l/HYGl7EALvzrrLmWgsMrVcIOQ5/p9sVpqy78pWh7Fkqv4EPlnBXdatssP2D1QiXtesVwuBeas2Dy
 7p91Q9RugKeLef4ylFAtVEbWEjq8Z18YCj5ive6QPfaVHXMXVfXJU/ir9wEL1DptMFh17KHKaXcQa
 7CyJE6iMFuh7rlkCUduCv5RwwBKonEA28Sub8B+VNsnw5lAKKOPCILDdbCUibbshawRK0xcLp6oX3
 Lj6KmU6oLFzmh0cHknyimM1ngKc37aY2Dq88rE3psbE4JI3BBcCXSB0kZjMYZc1c3/vSIfKcsuIJa
 VouQ2NT+ElSTJ7KSYKhRHrJVuKUdp3ev8z7WVP1PQpIRFRs8lxWebElhgnrXvT3SJDagIZenlQJu4
 tKxcmkIXypzpEJD+Nw5wIQZlKS1TLSgeGeftx2Mi0=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xAo8P-00G0GE-LK; Sun, 27 Sep 2026 13:37:37 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Date: Sun, 27 Sep 2026 13:36:47 +0100
Message-ID: <20260927123807.492352-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/i386/tcg: fix lea address calculation for CS register
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the effective address calculation was simplified in commit 55a15eb3504
("target/i386/tcg: simplify effective address calculation") the refactoring
accidentally introduced the ADDSEG() macro into the CS base address inclusion
test.

Fix the logic in gen_lea_v_seg_dest() to use CODE64() instead of ADDSEG() for
the CS base address inclusion test, and at the same time split it into a switch
statement to make the logic easier to follow.

Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/i386/tcg/translate.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 192cf43215e..2d3fffeab7b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -605,7 +605,25 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
         ovr_seg = def_seg;
     }
 
-    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
+    switch (ovr_seg) {
+    case R_DS:
+    case R_ES:
+    case R_SS:
+        has_base = ADDSEG(s);
+        break;
+    case R_CS:
+        has_base = !CODE64(s);
+        break;
+    case R_FS:
+    case R_GS:
+        has_base = true;
+        break;
+    default:
+        assert(ovr_seg < 0);
+        has_base = false;
+        break;
+    }
+
     easize = CODE64(s) ? MO_64 : MO_32;
 
     if (has_base) {
-- 
2.47.3



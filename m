Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB25CD98DC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVCJ-0000er-TK; Sat, 13 Jun 2026 16:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC9-0000LB-If; Sat, 13 Jun 2026 16:43:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC5-0005e7-8T; Sat, 13 Jun 2026 16:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382967; bh=OJlFeqPSPJI/9JHSpoI1kmMeeq87tuzghZZQuthmz0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZL3Z8903nsj+yIyTbtKI7RX0qYQwKDKynMUXLeZAgWdJ8Me6a5VT0ig1NSudmO94n
 u0rW0DVwOpjICFxzKJ/O7pCHmCtd1clXXbXPzY1uK0x62gnMISMBPM+9+8EyLFAfRp
 yz2/aHj5NaMr9NaD2Fbg5oErLySxKCJTCZ8FF9LgYhDyf4gAiXOO6xCnMo7Z7lmjhJ
 +3TEjzV5bJe6cQznLbjBUOyPSkv1iJOV4eO3DHchQsn7yXw7J4q/V6NCXQpMIsI7hm
 xC9LOMsDGmpLw/QEHKhyd8hvk9htACgfRC3D3n1ZiXtHJNJi/xFRkD/D8yrxRaL5U7
 VekYOSRo6XD9g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FD781B6F29;
 Sat, 13 Jun 2026 23:36:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6CD3D3CE972;
 Sat, 13 Jun 2026 23:36:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 70/72] fpu: Handle all rounding modes in
 partsN_uncanon_normal
Date: Sat, 13 Jun 2026 23:35:36 +0300
Message-ID: <20260613203542.1809153-70-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Missed float_round_nearest_even_max when recomputing round.

CC: qemu-stable@nongnu.org
Fixes: 72330260cdb ("softfloat: Add float_round_nearest_even_max")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260608190155.637067-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a6a1f92d5a2368882e9b6851b6ab8b9a56d71a8c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3c323c0cec..edfcbeb80b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -431,6 +431,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             /* Need to recompute round-to-even/round-to-odd. */
             switch (s->float_rounding_mode) {
             case float_round_nearest_even:
+            case float_round_nearest_even_max:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.47.3



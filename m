Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1907ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUgU-0004c3-Ma; Sat, 13 Jun 2026 16:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUgM-0004Im-Qt; Sat, 13 Jun 2026 16:10:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUgK-000359-WA; Sat, 13 Jun 2026 16:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381071; bh=74FjXEQfqoGSiytNTqpkUThHlv28JADau+k5i8/mkWc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gsOWJZfPHTfKZRylSGfRmr23Fo72Ent5ilXUoMk872lrIE2uiU/NcamBBvwPcdhOV
 t9kEUAAZ6wCqaQuxSWqudKzJlxhew9f9zl1fYgPYabDuCh4xcmX1D/tJqVo1xWTQ6n
 RQA1xhYgD/yVJYgxq1DXfT9yHaIvn2qtv77ejJWEDKI7CPVUNPGNZleFvBFSBebYjF
 V21rA3i3hYxHAOv7prThQaNTEqlzGeyf5ggoBZmBxaFkDSTW1+5Pe80uyvLqLSO6n0
 9E/IBJ66K2ndV5H1NgvA1dpbkAt5qAr8/bjfCDbGwD+CWCMhrPid9P8rrQ+hjVi0tW
 4pwdVmD4I5npQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 44B0D1B6EAB;
 Sat, 13 Jun 2026 23:04:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 966253CE905;
 Sat, 13 Jun 2026 23:04:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 59/61] fpu: Handle all rounding modes in
 partsN_uncanon_normal
Date: Sat, 13 Jun 2026 23:03:42 +0300
Message-ID: <20260613200411.1808021-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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
index 5e0438fc0b..6bbea3d138 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -375,6 +375,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             /* Need to recompute round-to-even/round-to-odd. */
             switch (s->float_rounding_mode) {
             case float_round_nearest_even:
+            case float_round_nearest_even_max:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.47.3



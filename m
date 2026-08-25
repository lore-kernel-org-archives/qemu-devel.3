Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11685C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn4K-0005PB-BS; Tue, 25 Aug 2026 05:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4G-0005Li-PH; Tue, 25 Aug 2026 05:03:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4F-0003BO-0R; Tue, 25 Aug 2026 05:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=Fa+LvK5q74YUlXE2c11mm+O2uVCpo2KXH4JztZyUEDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kih68lKXlpXs34MrBuFA3E1K4lTWPCu9V0WM3ngIQT31pmCBLCt9JDrU/TzwNn9Sc
 APpr2UM4Hih26lLNBLEZev6s3AQZGUZoYXAQUoDzIRSTESwuxg+409/LL6NjUh+IhF
 36GmPgH2by4ukuWPutIE2P1kZm/hRX8OHy8UDElT/qyVPHwTk1stIWmT7Iv4LPQwNU
 atu9JH/HZcVLseIlkw5pknj9vun5IQOFDO6+VKMlZxJ0Bb9+sEEGVVcLUOUftVd5HO
 aNEbu3jLeAb/7hi04wNl2szde39iNJZQBeZaM6kcKFG8DqLmVHmioohmLqge7UCQUr
 CJdGSf9kHWnLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6420B1CE3B6;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 507CA416178;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C66EB32555; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jan Mercl <0xjnml@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <17746591750@163.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 172/196] target/loongarch: check FPE before reading
 fcc in bceqz/bcnez
Date: Tue, 25 Aug 2026 12:01:29 +0300
Message-ID: <20260825090157.471948-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Jan Mercl <0xjnml@gmail.com>

gen_cz_bc() loads env->cf[cj] without CHECK_FPE, unlike every other
translator that touches an fcc register (trans_fcmp.c.inc and
trans_fmov.c.inc, for movcf2gr/movgr2cf/movcf2fr/movfr2cf/fsel).

A guest that manages the FPU lazily -- Linux clears CSR.EUEN.FPE in
lose_fpu() on every context switch -- relies on the next fcc access
raising a Floating-Point-Disabled exception so the kernel can restore
that task's fcc.  Because bceqz and bcnez never raise it, they branch on
the condition flag left behind by whichever task last owned the FPU.

Real Loongson hardware does raise the exception, so this is TCG-only.
It surfaces as Go binaries dying at startup in runtime.check() with
"fatal error: float64nan1" -- roughly one process start in a thousand
once the guest has more runnable tasks than vCPUs -- and in general as a
conditional branch silently taking the wrong path.

With four tasks each executing 5M bcnez on a 2-vCPU guest, master
mispredicts 89 of 20000000.  With this patch, 0 of 100000000 over five
runs; a Loongson-3C5000 is likewise 0 of 600000000.

CHECK_FPE is defined in trans_farith.c.inc, which translate.c includes
before trans_branch.c.inc, so it is already in scope.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4209
Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Mercl <0xjnml@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260819132422.5164-1-0xjnml@gmail.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit 215a4fc08f2aafce54c168cf41c64c79187430c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
index f94c1f37ab1..da077786585 100644
--- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -66,6 +66,8 @@ static bool gen_cz_bc(DisasContext *ctx, arg_c_offs *a, TCGCond cond)
     TCGv src1 = tcg_temp_new();
     TCGv src2 = tcg_constant_tl(0);
 
+    CHECK_FPE;
+
     tcg_gen_ld8u_tl(src1, tcg_env,
                     offsetof(CPULoongArchState, cf[a->cj]));
     gen_bc(ctx, src1, src2, a->offs, cond);
-- 
2.47.3



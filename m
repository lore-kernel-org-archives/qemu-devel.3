Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuALE-0007JU-CZ; Wed, 12 Aug 2026 10:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJL-0005P0-Qu; Wed, 12 Aug 2026 10:52:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAJJ-0006rA-CO; Wed, 12 Aug 2026 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=PmkIdGMi5q9MKaWrAcvueum/91re/bdNn6rqWC5RO0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fO5MNKGybt/TrAfdeWHL/kZDjfHRLnhFuR9WqehfcVyDzn4f2xRU5rDEetJ55jCMk
 zdD6LtD1tWGsgayZ38du1GRSQgwH8+h3XFfQeQxWJiB1PSCeX06fbWB2IerIsBBaB8
 idfJwLYXieQxalsrFT6ZChdN+RMakvmi1XrLpA4LQuQ2tbeAM2rTpTCRIxRYd0RhKo
 0HH/5AVTGiHmgrUwMPGYugDlJe1rDeIBKYmBzDBeaR/tgtdAIESaL4nv6C6n5ZQZjW
 92gxxgpGRaORCruw9e6cgFaOX42XEaJyb6MWgmgGoJcRBjjJZQfH7hVKDfQHlxIEAA
 1NkfmIGmWwfDA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 293371CA616;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83C89409D52;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E2F292F987; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 018/120] target/i386: helper_sysret(): Check that RCX
 contains a canonical address when emulating an Intel CPU
Date: Wed, 12 Aug 2026 17:48:01 +0300
Message-ID: <20260812144955.649205-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

Intel and AMD CPUs implement SYSRETQ instruction differently.
One of these differences is whether a canonicality check of the address that
will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs don't.

Currently, QEMU does not perform this check when emulating Intel CPUs.
This patch corrects this by implementing the canonlicality check on a new RIP
value from RCX and performing it only when emulating Intel CPUs.

Flags and segment registers' caches are updated only after checking the new RIP
value to ensure that CPU state is not modified in case the #GP(0) exception
is raised due to the check failure.

Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 14ce26e75513 ("x86_64 target support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3223
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Link: https://lore.kernel.org/r/20260608091815.31303-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 51aa3f3e05772c38cb6f6d8e79eca0f6afaaace0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac720119..d5c174b7fd7 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)
     selector = (env->star >> 48) & 0xffff;
 #ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
-        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
-                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
-                        NT_MASK);
         if (dflag == 2) {
+            uint64_t new_rip = env->regs[R_ECX];
+            if (IS_INTEL_CPU(env)) {
+                int shift = (get_pg_mode(env) & PG_MODE_LA57) ? 56 : 47;
+                int64_t sext = (int64_t)new_rip >> shift;
+                if (sext != 0 && sext != -1) {
+                    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+                }
+            }
             cpu_x86_load_seg_cache(env, R_CS, (selector + 16) | 3,
                                    0, 0xffffffff,
                                    DESC_G_MASK | DESC_P_MASK |
                                    DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                    DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
                                    DESC_L_MASK);
-            env->eip = env->regs[R_ECX];
+            env->eip = new_rip;
         } else {
             cpu_x86_load_seg_cache(env, R_CS, selector | 3,
                                    0, 0xffffffff,
@@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                DESC_W_MASK | DESC_A_MASK);
+
+        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
+                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
+                        NT_MASK);
     } else
 #endif
     {
-- 
2.47.3



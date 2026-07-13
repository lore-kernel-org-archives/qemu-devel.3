Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDBC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEiC-0000Ek-Ol; Mon, 13 Jul 2026 07:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi4-0008UJ-8k
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:28 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi1-00080r-Vf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=RuiDCDN
 XvJ7ewXGm8VFy+l4r6gHjMLne1t005d4DC1VRLQ8jzmNTR/eeC1u0yDnTCUeW+M+ia/Ygr
 EsoTnVKi0SduGYboZnoi5WS6fUkQWnldIfNOzUe86mk77wQCOq1ba/0Q8Pr09D91uM0s2Q
 bu3e4MGQZSZ/NAqrdI7Za5rdRavKKetfYkSOBSQ3WDJmefgXEznOFoCOrLYewMvhWWS/nN
 eLnRiaS2KAx9SVt/ctn3YMj9lLKQKZ/AjBK3JFKW8uMFyQdRBPEjmOTuLdD47fyBjMfalp
 34aQC8Cd6clu5MVs9UrOwrQ3YFeadOk0aJBEnExhyMPd96Hoq484SPg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=8
 EKocf+kGlaTuXdnno/LPGcAjHf3KPZivbjcNNvd8k4=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=HI+su3HKeUF6hz+zNLtksq55mtsOsQj7yZSOYzzc2c0Y2KKpTQg7gEW8gWynq4P0SdYR
 8dSWJn/G4PcFtcBL2c8xazDVSwuRYCbGzkv11rQi2sMT3hw9E7cXuBjugmbmvgYtW1jlDc
 0lAEMU4+ZM/l+NJpzWKqcOnfHMJjUNn0qyRHouSoWWwB67jyoJlRrmT0vG711Vpc9cTy/a
 bzarRjlFjY5KYFsR6DJbZjzHKvD6jWyGIr4iNQrDUacRiZlARzkyYHSo+dHV1nf7xiPeQT
 rxtuBSDG6t+Y9BKH/qmKzwF1N2VJj7iHS55riKsygLefy/bTLoxIfha9SsBwvbdg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=GjVJFMk5; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ffhMTbkc;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=8EKocf+k
 GlaTuXdnno/LPGcAjHf3KPZivbjcNNvd8k4=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=GjVJFMk5UiP5gvM5sMOS4WlzFXZOUEzfX3F
 PSTXe6o6JsxoK07LIrKCyH9mjU+jY+l49UNckCEAavMs1w5eNkQUT0f+OYgEJfr9QBqQaU
 bhF3LBBmyPgGvzX/swcyido7Mm65NIzBk/to3yllX1b3ScQQQFMNBcEXsEMe548k0uQ9dE
 QwJlF9IYYVPjUs49qsG6mfxcwOBspgHjmFmtJyduAbGqehVXURKtrihKFpOhrky88j7G+K
 S+trksvZ1rQ1eQNnZOMsubwVk7UoXu6AOBgCeIqvivSdWU9pp88ouFmTCFasAlLl7EJ6Dt
 9xxn4S386iYRHOOG9TFtxbhFtcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=8EKocf+kGlaTuXdnno/LPGcAjHf3KPZivbjcNNvd8k4=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ffhMTbkcUpp8gjVZTC
 NTC99IQcWtqIndexhAot1eedv1p5UGeWCwTezs4wGIrPipj/dqii+rKSL+UsOcruqZCA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 04e8c581
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:16 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id d2362b45;
 Mon, 13 Jul 2026 13:20:14 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 7/9] target/mips: accept Octeon PageMask encodings
Date: Mon, 13 Jul 2026 13:16:35 +0200
Message-ID: <20260713112004.4956-8-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Octeon firmware programs contiguous PageMask values that do not follow
the generic R4K even maskbits rule.

Keep the generic validation rule for other MIPS CPUs, while allowing
Octeon CPUs to use the contiguous masks accepted by hardware.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/tcg/system/cp0_helper.c | 15 ++++++++++-----
 target/mips/tcg/system/tlb_helper.c |  2 +-
 target/mips/tcg/tcg-internal.h      |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 1c23d2a525..40a41805fa 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -882,14 +882,19 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-uint32_t compute_pagemask(uint32_t val)
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32(val, CP0PM_MASK, 16);
+    uint32_t mask = val >> CP0PM_MASK;
     int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero, and maskbits even. */
-    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+    /*
+     * Generic R4K PageMask values use two mask bits per size step.
+     * Octeon accepts contiguous byte masks such as 0x003fffff for
+     * two 2 MiB pages.
+     */
+    if ((mask & (mask + 1)) == 0 &&
+        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
         return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
@@ -899,7 +904,7 @@ uint32_t compute_pagemask(uint32_t val)
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    env->CP0_PageMask = compute_pagemask(arg1);
+    env->CP0_PageMask = compute_pagemask(env, arg1);
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 4c0a25e622..ae805bff28 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -877,7 +877,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
+    pw_pagemask = compute_pagemask(env, pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f..66ae39551e 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -47,7 +47,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-uint32_t compute_pagemask(uint32_t val);
+uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25E8CCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 00:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBMY3-0006E5-02; Tue, 21 Oct 2025 20:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBMY1-0006Dj-Ce
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 20:17:49 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBMXy-0000W5-Om
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 20:17:49 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3c9975a3d6eso1271735fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761092264; x=1761697064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=63bijM+RyKfULurmcfUd1JATQGt+xLDjTNgaKx3DqBE=;
 b=yTJfbaKvBf8+aUJTuCA90y9l32l5a1b36k3DfKzOQYyvAM0peBcH7dlohnwsQNpXf0
 hYKCpinm5092WhNr1stiMpIr9VfNpx8KVZDnpq2Ijw/VFj1GhrA1P4nUMcCt6rzzedsC
 Z9cTU8EPNuLMp4wl1XP8cgB1QZbaOtzaMmQgxlO/7OHmM8n1V8XeamC7LdFOnFopVGU3
 N1OAizLRC6lMxXKpN5gFNHD8aqzO14jM2IkCoYGPmBan0KINbi4vSinoJYeROhNTowQm
 asNxOje5T8eQ1cKcUSw2HNVMjS98Xl6K4RjQAJVov7dfDarLajcgz3sWq7DP/MD3oYfN
 12/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761092264; x=1761697064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63bijM+RyKfULurmcfUd1JATQGt+xLDjTNgaKx3DqBE=;
 b=BtKZ8sSA08EMBvMw5nH3BmKP3DQmB+LwoLTIUU2SY/henCG3Hg/zl6m7y7W/2aTOtY
 YXJWwbCSoorOkcHtMS3HeUTVvhKJp7SZ9PA5RWg5B6ZiHuKhcVoKLRoLv5pCAHglGwF6
 mVY2e8NbGNLkn/Rt+fxDQQkCqSzVw7Wa34liwGiEWTtqrv5gq8CGxWhFf8Jc1qt1sQVg
 PSsP4o0dp0TIXV4A+vBhnaHHNS0o8AI4ZMorn4SJKEOEExPKglWrosrlgGNrr1FFvKFn
 S6xjP0odrxM2c73ZGNlr7usjaNkIjhxZzElioS+SQZYiNAr6vclPVBC8494By3EXzm15
 q4GA==
X-Gm-Message-State: AOJu0YzLSdXZVt2SKiZAMv+N5mhu/9YHs5t0wj+Ox3wwrLyQtPxwipm9
 wr7T2tP1pKEm0OcFpGStGOpYhBX0Hgs5LLFSbrKmwNLHe3qAufV3KXC8rfpGIS+2Qgjv6G587Xt
 xDrYY
X-Gm-Gg: ASbGncv1zvybCWyJhz5Sijc2tY3apPa8aNCi3iec7FWFh/MqARXErhvGyXGVkfNXc1I
 TrK68FWa+sSu7hKqU/SWIN8G7ssP4slwR7Qow3U15x5h0ZZVS/igg3XFIoCzqOUrzQsrVLwlCfA
 CFxHWZ0vo7EAc6SN9i1X+Gg2v5jVca3hG8vt7cHjhSHvT+fMU76mq2zn3eIRhCZsd4rCm+KgsRj
 DujhuHzeatH+M0Ca6xuqx5sLQ1f7Okw870lu2j7lHm0Chp/N2vC84c8MPMTK9ZWuYSZwME0+YAA
 H1vkTj5Ky3Qg6qMWJF/w1r2lUGfZpMbaYa+1A4hdBv/ghgYGABJhsW2D6Ft4aYpKgkGYICHavJs
 q3TUXF/Q3EF7PXs8btGDJ8p/EKIB6YZUZnC0zG800nNGFQCba8k5/qvBI9i3fWEEAprbryDXszJ
 nhWV8RCw==
X-Google-Smtp-Source: AGHT+IEOSSfGX359NjbE4gxKLob53AyrTclNq9c6Z8B3icMh81jq+kgbUZIc5oT8PjntutlelnESEg==
X-Received: by 2002:a05:6870:1f05:b0:3c9:83d4:db66 with SMTP id
 586e51a60fabf-3c98d1e2699mr8694000fac.48.1761092264446; 
 Tue, 21 Oct 2025 17:17:44 -0700 (PDT)
Received: from stoup.. ([50.194.179.134]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9aec66f50sm3516152fac.0.2025.10.21.17.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 17:17:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
Date: Tue, 21 Oct 2025 19:17:40 -0500
Message-ID: <20251022001741.222499-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

For Arm, we need 3 cases: (1) the alignment required when accessing
Normal memory, (2) the alignment required when accessing Device memory,
and (3) the atomicity of the access.

When we added TLB_CHECK_ALIGNED, we assumed that cases 2 and 3 were
identical, and thus used memop_atomicity_bits for TLB_CHECK_ALIGNED.

This is incorrect for multiple reasons, including that the atomicity
of the access is adjusted depending on whether or not we are executing
within a serial context.

For Arm, what is true is that there is an underlying alignment
requirement of the access, and for that access Normal memory
will support unalignement.

Introduce MO_ALIGN_TLB_ONLY to indicate that the alignment
specified in MO_AMASK only applies when the TLB entry has
TLB_CHECK_ALIGNED set; otherwise no alignment required.

Introduce memop_tlb_alignment_bits with an additional bool
argument that specifies whether TLB_CHECK_ALIGNED is set.
All other usage of memop_alignment_bits assumes it is not.

Remove memop_atomicity_bits as unused; it didn't properly
support MO_ATOM_SUBWORD anyway.

Update target/arm finalize_memop_atom to set MO_ALIGN_TLB_ONLY
when strict alignment isn't otherwise required.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3171
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

PS: There are a number of uses of align_mem for AdvSIMD, SVE and SME.
I have not re-familiarized myself with the effects of SCR.A and
Normal/Device memory for those cases.  I may well have missed something.

---
 include/exec/memop.h            | 43 +++++++++++++++------------------
 target/arm/tcg/translate.h      |  4 +--
 accel/tcg/cputlb.c              | 13 +---------
 target/arm/ptw.c                |  2 +-
 target/arm/tcg/translate-a64.c  | 10 +++-----
 target/arm/tcg/translate-neon.c |  2 +-
 tcg/tcg.c                       | 10 +++++---
 7 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index cf7da3362e..799b5b4221 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -72,6 +72,16 @@ typedef enum MemOp {
     MO_ALIGN_64 = 6 << MO_ASHIFT,
     MO_ALIGN    = MO_AMASK,
 
+    /*
+     * MO_ALIGN_TLB_ONLY:
+     * Apply MO_AMASK only along the TCG slow path if TLB_CHECK_ALIGNED
+     * is set; otherwise unaligned access is permitted.
+     * This is used by target/arm, where unaligned accesses are
+     * permitted for pages marked Normal but aligned accesses are
+     * required for pages marked Device.
+     */
+    MO_ALIGN_TLB_ONLY = 1 << 8,
+
     /*
      * MO_ATOM_* describes the atomicity requirements of the operation:
      * MO_ATOM_IFALIGN: the operation must be single-copy atomic if it
@@ -104,7 +114,7 @@ typedef enum MemOp {
      * size of the operation, if aligned.  This retains the behaviour
      * from before this field was introduced.
      */
-    MO_ATOM_SHIFT         = 8,
+    MO_ATOM_SHIFT         = 9,
     MO_ATOM_IFALIGN       = 0 << MO_ATOM_SHIFT,
     MO_ATOM_IFALIGN_PAIR  = 1 << MO_ATOM_SHIFT,
     MO_ATOM_WITHIN16      = 2 << MO_ATOM_SHIFT,
@@ -169,16 +179,16 @@ static inline MemOp size_memop(unsigned size)
 }
 
 /**
- * memop_alignment_bits:
+ * memop_tlb_alignment_bits:
  * @memop: MemOp value
  *
- * Extract the alignment size from the memop.
+ * Extract the alignment size for use with TLB_CHECK_ALIGNED.
  */
-static inline unsigned memop_alignment_bits(MemOp memop)
+static inline unsigned memop_tlb_alignment_bits(MemOp memop, bool tlb_check)
 {
     unsigned a = memop & MO_AMASK;
 
-    if (a == MO_UNALN) {
+    if (a == MO_UNALN || (!tlb_check && (memop & MO_ALIGN_TLB_ONLY))) {
         /* No alignment required.  */
         a = 0;
     } else if (a == MO_ALIGN) {
@@ -191,28 +201,15 @@ static inline unsigned memop_alignment_bits(MemOp memop)
     return a;
 }
 
-/*
- * memop_atomicity_bits:
+/**
+ * memop_alignment_bits:
  * @memop: MemOp value
  *
- * Extract the atomicity size from the memop.
+ * Extract the alignment size from the memop.
  */
-static inline unsigned memop_atomicity_bits(MemOp memop)
+static inline unsigned memop_alignment_bits(MemOp memop)
 {
-    unsigned size = memop & MO_SIZE;
-
-    switch (memop & MO_ATOM_MASK) {
-    case MO_ATOM_NONE:
-        size = MO_8;
-        break;
-    case MO_ATOM_IFALIGN_PAIR:
-    case MO_ATOM_WITHIN16_PAIR:
-        size = size ? size - 1 : 0;
-        break;
-    default:
-        break;
-    }
-    return size;
+    return memop_tlb_alignment_bits(memop, false);
 }
 
 #endif
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 9a85ea74db..b62104b4ae 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -744,8 +744,8 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
  */
 static inline MemOp finalize_memop_atom(DisasContext *s, MemOp opc, MemOp atom)
 {
-    if (s->align_mem && !(opc & MO_AMASK)) {
-        opc |= MO_ALIGN;
+    if (!(opc & MO_AMASK)) {
+        opc |= MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
     }
     return opc | atom | s->be_data;
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 631f1fe135..fd1606c856 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1668,18 +1668,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
 
     if (likely(!maybe_resized)) {
         /* Alignment has not been checked by tlb_fill_align. */
-        int a_bits = memop_alignment_bits(memop);
-
-        /*
-         * This alignment check differs from the one above, in that this is
-         * based on the atomicity of the operation. The intended use case is
-         * the ARM memory type field of each PTE, where access to pages with
-         * Device memory type require alignment.
-         */
-        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-            int at_bits = memop_atomicity_bits(memop);
-            a_bits = MAX(a_bits, at_bits);
-        }
+        int a_bits = memop_tlb_alignment_bits(memop, flags & TLB_CHECK_ALIGNED);
         if (unlikely(addr & ((1 << a_bits) - 1))) {
             cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
         }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d4386ede73..939215d096 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2351,7 +2351,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
      */
     if (device) {
-        unsigned a_bits = memop_atomicity_bits(memop);
+        unsigned a_bits = memop_tlb_alignment_bits(memop, true);
         if (address & ((1 << a_bits) - 1)) {
             fi->type = ARMFault_Alignment;
             goto do_fault;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3292d7cbfd..08b21d7dbf 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3691,9 +3691,8 @@ static bool trans_STP(DisasContext *s, arg_ldstpair *a)
      * In all cases, issue one operation with the correct atomicity.
      */
     mop = a->sz + 1;
-    if (s->align_mem) {
-        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
-    }
+    mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
+    mop |= (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
     mop = finalize_memop_pair(s, mop);
     if (a->sz == 2) {
         TCGv_i64 tmp = tcg_temp_new_i64();
@@ -3742,9 +3741,8 @@ static bool trans_LDP(DisasContext *s, arg_ldstpair *a)
      * since that reuses the most code below.
      */
     mop = a->sz + 1;
-    if (s->align_mem) {
-        mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
-    }
+    mop |= (a->sz == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
+    mop |= (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
     mop = finalize_memop_pair(s, mop);
     if (a->sz == 2) {
         int o2 = s->be_data == MO_LE ? 32 : 0;
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 844d2e29e4..e3c7d9217b 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -520,7 +520,7 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
     if (a->align) {
         align = pow2_align(a->align + 2); /* 4 ** a->align */
     } else {
-        align = s->align_mem ? MO_ALIGN : 0;
+        align = MO_ALIGN | (s->align_mem ? 0 : MO_ALIGN_TLB_ONLY);
     }
 
     /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 294762c283..fbf09f5c82 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3039,20 +3039,22 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_qemu_ld2:
             case INDEX_op_qemu_st2:
                 {
-                    const char *s_al, *s_op, *s_at;
+                    const char *s_al, *s_tlb, *s_op, *s_at;
                     MemOpIdx oi = op->args[k++];
                     MemOp mop = get_memop(oi);
                     unsigned ix = get_mmuidx(oi);
 
+                    s_tlb = mop & MO_ALIGN_TLB_ONLY ? "tlb+" : "";
                     s_al = alignment_name[(mop & MO_AMASK) >> MO_ASHIFT];
                     s_op = ldst_name[mop & (MO_BSWAP | MO_SSIZE)];
                     s_at = atom_name[(mop & MO_ATOM_MASK) >> MO_ATOM_SHIFT];
-                    mop &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE | MO_ATOM_MASK);
+                    mop &= ~(MO_AMASK | MO_BSWAP | MO_SSIZE |
+                             MO_ATOM_MASK | MO_ALIGN_TLB_ONLY);
 
                     /* If all fields are accounted for, print symbolically. */
                     if (!mop && s_al && s_op && s_at) {
-                        col += ne_fprintf(f, ",%s%s%s,%u",
-                                          s_at, s_al, s_op, ix);
+                        col += ne_fprintf(f, ",%s%s%s%s,%u",
+                                          s_at, s_al, s_tlb, s_op, ix);
                     } else {
                         mop = get_memop(oi);
                         col += ne_fprintf(f, ",$0x%x,%u", mop, ix);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B7CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnhe-0007V0-Ra; Fri, 31 Oct 2025 07:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhb-0007U9-5w
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:55 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhP-0005xM-Pd
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so548291266b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911617; x=1762516417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GU0Gskq9M+nEhWLhMqv07GFwmNCHtS491c2/qibObY8=;
 b=XBz6VtIMzjbsrY6/RXa+ydGqaoRgQKk4jsJUVm1DRRfVfkd2JqjqcImuBGJMwx3+cm
 9WvvcMtyl4qw17CIRdFy2AR8PyaCmW5HVgixPXp7A+otT0pUnxmKDbmp7kFCysPRI+DE
 ylB0X6qE2+/41tgM6eThEmteRjA7gvf5N7vWvPmCl5FKNCX9sECBr2RrOSl3snQcjATc
 SKGtIPpm9SZBi0nKpFWOSjWDvRapp6RPkMYtqff4rocL2oAsyWaR039cxQ8zCFgGJguR
 w1fsqxEDYTb1/1RYP5RGtzo7N1drC8igzdSIU6a1QCcjcUQqD265LdC13zIKoPxzldyW
 u0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911617; x=1762516417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GU0Gskq9M+nEhWLhMqv07GFwmNCHtS491c2/qibObY8=;
 b=Bhjj6p5r+uMLf/rJawa0sBN3Pq0rdBkP3i/hEhXg8uy53bKgZjZudETRQeG6LBlmJW
 JBDv6QhmDy7OEMBidx/LXrHFUBgh/Taa2zRkU+0hHBV6jtPdgl+e+ssEz7GGyDB8bx5B
 Ra0qKDJL0d906MBAzJxK4lmrxeNvmDzk9WBB+4GRtzra0H4SPg7K1C1uUkSJjN0sgH9B
 vOjMiwDTUepPz4lrs8RrjJ2IArDaDyG2i3tps4yWMEt43XGUM5XZ8RhAgT/JPtAXfm3o
 kvmT/dADSIA+RgprHOrWOa2n5z8anpDYHpbq1558G/erQWh19LeWS+yy6xfPOd1WPquy
 3lQQ==
X-Gm-Message-State: AOJu0Yyxc5UIFxjASSPV6IHD9DWNJE+Iwrd0oKBPytzaGF2RoTFy6e4b
 5I3MqZuIZnwHZyEGA1ti55MC5AgG1J8DZInZ/k5L7BUaaZcoz5VAAxrkeMjGSolFR7ndhb4laPm
 3U2q/+8M=
X-Gm-Gg: ASbGncvx7qO4KxtIpHotPjjs3W/VdbIonK5W9x5BHpd1zPvVtx3jiTDSrA28Y2zJmNp
 f/lLXQDD4AYCKufi+99Jweda7lfB7z5C4xkBfF8HejzuT3Oqi/iGkHJ9lqf0fz3n7lqMyfINDKJ
 JYmxXw1fblXni80I6heTf+j5Qz32eh57etJ4i5HSZA0XoopOE5trQVFX2AgcDi+y18sLNhEF41k
 QIAtE4qPxSa/NowXTLt8Cp2YJXhgQrns7zTITMXnOXZQiYl3AzD1Olh/S7bdLOx62i4w87siYjD
 /laGWFg2wl3TEx7waOxTEfvbZxLrMZgCT41X/UAmydtXC+qZRgP+kQqDVWQh3f84/kT77/t7wCF
 NAMa7/XkEO6XT2S/SvbiV6cB0O58HxjbZ1QF3ZhnDjAYPq33ElCrJMpO2EnPtV8iL2i+2Ee6Kii
 X0lfhN0FU9Xi5lZlgmMb5OfLQpJaabHRM3jlGU6zss
X-Google-Smtp-Source: AGHT+IGKiCuM5ESjgUwH6uI2oOkhTG4j1HcCwu++mPHCcFMMr6r+8s0GUNV45rmPuEx4piBUnxA7VQ==
X-Received: by 2002:a17:907:6088:b0:b4c:629b:aa67 with SMTP id
 a640c23a62f3a-b70522030bfmr679282466b.32.1761911617139; 
 Fri, 31 Oct 2025 04:53:37 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
Date: Fri, 31 Oct 2025 12:53:29 +0100
Message-ID: <20251031115334.368165-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
References: <20251031115334.368165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 23f6616811..2e6b149b2d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2352,7 +2352,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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



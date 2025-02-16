Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5761BC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyv-0000hP-8M; Sun, 16 Feb 2025 18:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwy-0004iF-5t
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:24 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnws-0006WR-PC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:23 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso5765182a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748076; x=1740352876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=932dlhZXY3WaUlTZzawBc1SaW0Eyc6UiDNVb9QR9API=;
 b=JgTCFMfJtmbCGGBdChSBuebkN86HtsLk5nI0IUjKelQ9anB17xpoJqMPZZ0oz3CNJ1
 eA8Lr1r5rBelLuaKl3EWU/eucyPO92MpCGalCK+TbkNX3z5P2mFG5rT/eDQNLV3eMSGp
 ORq1n2Ma01NfYm4KsxX/AVfl+IfpgCLm6+SL+PjNJ5vFJwPvQAsyei/W3wG4P0djwsmL
 74GVDDqhXqcUa5GP0H5LKBoGKfRfjNeZog5FmFo0wUpB3UVA68petf9LEXBMFTTX17bd
 Xqm/OpiOS5gKWoWcb/SROoA4OI+FSunA10lkZ6CWrwQHJtRCK5Ygr7lbexq0TPMXtkdH
 ZL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748076; x=1740352876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=932dlhZXY3WaUlTZzawBc1SaW0Eyc6UiDNVb9QR9API=;
 b=Wd+wpG87+ETa+XAHQH0h76jUyEkUirfu07E7VF+QYVfTCVE9ZcMUE97fqZOE8ikXQJ
 gpNw9sHoYzzlMP69o1DAL6qlIGsVnMYKdJhXF0B6T2DCkB9NgCK9LXWE/GzDsIT4z2hl
 aQsEqt8W/EugWdBhEroLDxJjK6ZNeDHH2A45wGl47p3di6Bu5Wq3xvP9wk1iXcypE1lh
 xaTsAujHoyQ7SD8nQz8b4EZUf3uab3Jj1k/fPC5bajlkwEdL3nsrmAepL5Hp0I+LFzwI
 NjlfRnsUvBawL2+i9B+pLptc4t6K80RrA2UoxpVggJYO84rr2pKV4KITKEGIyDrMbP+I
 ncYg==
X-Gm-Message-State: AOJu0YybNXvaMB3gdFAW1hZ9YWYS/5QxrNQR+5/locg1qhhzzC9W2Qfv
 7sgdjKhTOryXeKScsvjIOxuYFP2pJ+k+Kms7/32Sc4FhxMI9imN6KM1j3q2koWLe9mYUdWb+hwK
 u
X-Gm-Gg: ASbGncsUEVweIg9aziwhk+Hc0XkEMpQqZ9Ben1a7YBlgRX4O6YeaXZ7gHLPfYX/74uV
 iG/LdQA4/qyRC2g+1hz/jC9nDNSnfecYQVmWxv9tkqu3altRi56H74hkaLBEfNm4syuhaTBn3F/
 BrR+WfZgvjAPqxdikP4N2sWBV76EOW5dkz13y5XH5sNl4vVYCF0VcOAjbxPYLQ4OkDm4qUY9iRR
 5ASZUPPR1oPP51kyZr21RqLCJtyJbcHUfOhZqHlz26c0PU3PmW7A6l6fBLJ28o36Fo8P5uWjPuq
 baZZb9wtF4NPKDSEw5ad4+UqNcobiuG2PG0QY76VT+wV7FM=
X-Google-Smtp-Source: AGHT+IGfxaJt61qNlgbbG3Zd+VnsdzxvrLQGBwMpz5kS3IeDa8IU3YYbagpqYGTNq+q7/EeZc+F/7g==
X-Received: by 2002:a17:90b:5307:b0:2fa:4926:d18d with SMTP id
 98e67ed59e1d1-2fc0fa41221mr25214361a91.13.1739748075609; 
 Sun, 16 Feb 2025 15:21:15 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 158/162] tcg: Remove INDEX_op_qemu_st8_*
Date: Sun, 16 Feb 2025 15:10:07 -0800
Message-ID: <20250216231012.2808572-159-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

The i386 backend can now check TCGOP_FLAGS to select
the correct set of constraints.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 4 ----
 tcg/aarch64/tcg-target-has.h     | 1 -
 tcg/arm/tcg-target-has.h         | 1 -
 tcg/i386/tcg-target-con-str.h    | 2 +-
 tcg/i386/tcg-target-has.h        | 3 ---
 tcg/loongarch64/tcg-target-has.h | 3 ---
 tcg/mips/tcg-target-has.h        | 1 -
 tcg/ppc/tcg-target-has.h         | 2 --
 tcg/riscv/tcg-target-has.h       | 1 -
 tcg/s390x/tcg-target-has.h       | 1 -
 tcg/sparc64/tcg-target-has.h     | 1 -
 tcg/tci/tcg-target-has.h         | 2 --
 tcg/optimize.c                   | 1 -
 tcg/tcg-op-ldst.c                | 9 ++-------
 tcg/tcg.c                        | 4 ----
 docs/devel/tcg-ops.rst           | 6 ------
 tcg/i386/tcg-target.c.inc        | 9 ++++-----
 17 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a22433d8b5..0ce8332aab 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -133,10 +133,6 @@ DEF(qemu_ld_i64, DATA64_ARGS, 1, 1,
 DEF(qemu_st_i64, 0, DATA64_ARGS + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
-/* Only used by i386 to cope with stupid register constraints. */
-DEF(qemu_st8_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index b155e37639..69e83efb69 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -14,7 +14,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 187269e5bd..3bbbde5d59 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,7 +24,6 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 52142ab121..dbedff1f54 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -20,7 +20,7 @@ REGS('r', ALL_GENERAL_REGS)
 REGS('x', ALL_VECTOR_REGS)
 REGS('q', ALL_BYTEL_REGS)     /* regs that can be used as a byte operand */
 REGS('L', ALL_GENERAL_REGS & ~SOFTMMU_RESERVE_REGS)  /* qemu_ld/st */
-REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
+REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st MO_8 data */
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 628e736de7..42647fabbd 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -29,9 +29,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-#else
-#define TCG_TARGET_HAS_qemu_st8_i32     1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 9c118bd1f6..32abc6f457 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -9,9 +9,6 @@
 
 #include "host/cpuinfo.h"
 
-/* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extr_i64_i32     1
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d8f9f7beef..b9eb338528 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -46,7 +46,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index b978c91a62..81ec5aece7 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,8 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #endif
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 8cd099546f..aef10c2d9d 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,7 +10,6 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index c04cc4e377..0aeb5ba01a 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -30,7 +30,6 @@ extern uint64_t s390_facilities[3];
 
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32   0
-#define TCG_TARGET_HAS_qemu_st8_i32   0
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 #define TCG_TARGET_HAS_tst            1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d9f5ef3fc9..af6a949da3 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 497e8152b7..ab07ce1fcb 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,8 +7,6 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #endif /* TCG_TARGET_REG_BITS == 64 */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index cbc519624a..ba52a5de68 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3180,7 +3180,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_qemu_ld_i128:
             done = fold_qemu_ld_2reg(&ctx, op);
             break;
-        case INDEX_op_qemu_st8_i32:
         case INDEX_op_qemu_st_i32:
         case INDEX_op_qemu_st_i64:
         case INDEX_op_qemu_st_i128:
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index b0872d6637..0df8da7365 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -270,7 +270,6 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
-    TCGOpcode opc;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -293,12 +292,8 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
-        opc = INDEX_op_qemu_st8_i32;
-    } else {
-        opc = INDEX_op_qemu_st_i32;
-    }
-    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(INDEX_op_qemu_st_i32, TCG_TYPE_I32,
+             tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f752729f80..640efff4ba 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2438,9 +2438,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return true;
 
-    case INDEX_op_qemu_st8_i32:
-        return TCG_TARGET_HAS_qemu_st8_i32;
-
     case INDEX_op_qemu_ld_i128:
     case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
@@ -3012,7 +3009,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 break;
             case INDEX_op_qemu_ld_i32:
             case INDEX_op_qemu_st_i32:
-            case INDEX_op_qemu_st8_i32:
             case INDEX_op_qemu_ld_i64:
             case INDEX_op_qemu_st_i64:
             case INDEX_op_qemu_ld_i128:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 93bcc70639..b89b7569a2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -752,8 +752,6 @@ QEMU specific operations
 
        qemu_st_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
 
-       qemu_st8_i32 *t0*, *t1*, *flags*, *memidx*
-
      - | Load data at the guest address *t1* into *t0*, or store data in *t0* at guest
          address *t1*.  The _i32/_i64/_i128 size applies to the size of the input/output
          register *t0* only.  The address *t1* is always sized according to the guest,
@@ -771,10 +769,6 @@ QEMU specific operations
          64-bit memory access specified in *flags*.
        |
        | For qemu_ld/st_i128, these are only supported for a 64-bit host.
-       |
-       | For i386, qemu_st8_i32 is exactly like qemu_st_i32, except the size of
-         the memory operation is known to be 8-bit.  This allows the backend to
-         provide a different set of register constraints.
 
 
 Host vector operations
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index fc37ac0a04..7e896505ec 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2457,7 +2457,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* This is handled with constraints on INDEX_op_qemu_st8_i32. */
+        /* This is handled with constraints on INDEX_op_qemu_st_*_i32. */
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
                                  datalo, h.base, h.index, 0, h.ofs);
@@ -3568,7 +3568,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st8_i32:
         tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
@@ -4140,9 +4139,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I1(r, L);
 
     case INDEX_op_qemu_st_i32:
-        return C_O0_I2(L, L);
-    case INDEX_op_qemu_st8_i32:
-        return C_O0_I2(s, L);
+        return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
+                ? C_O0_I2(s, L)
+                : C_O0_I2(L, L));
 
     case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I1(r, r, L);
-- 
2.43.0



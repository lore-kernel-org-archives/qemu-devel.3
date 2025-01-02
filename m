Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E95E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPeq-0007iJ-CZ; Thu, 02 Jan 2025 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPec-0007Nm-VH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPea-0006F5-QP
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:42 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2165448243fso190620295ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841439; x=1736446239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SidusAM69/hGs1s6XFyJOAq2/z1ll/ZV/6JH5ao6ucY=;
 b=QFuv0LNiRP+g/WHt07rIVRF/NMt2VB9+QoK2G++34TRumOiu9dSsZPXctYQLw7rFYz
 1wDF3u8PtObLfRLe9Yfkm5kg3B2nHjXIFPaGofmumpzbXoob9irWWiikJLUowbeO7RCQ
 JY6/juiIhJHFavuUGgpfxIqoIguI6lUn/KWXoZ0VrbVcoNvB7jgI29QCCGO0We8R7Z5Y
 bklHSl7q93QSEmSZ7ce63n6PEtcliqCUPilWokzLgaBh5uEPs43kjGcGQwxz94C/Cq6g
 l+GcCl3gtj+T6Dq8TzZ8hIySXL3foGyZ5tuqQXwDP8g9nwoWwh7mUEYvnwA7cw9MDHiR
 qwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841439; x=1736446239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SidusAM69/hGs1s6XFyJOAq2/z1ll/ZV/6JH5ao6ucY=;
 b=NO8WTEfSjY9k25J9qeYrz1XxSb+BWTep0Xy4SG5B2X8OTxSQHLIhOa+/Vo+iUBl4dX
 hltP16T3AAuKAIvio5ik+kyWc1kZVUB5jXswrrZNZVj2PD3yC8zFH97Jxc+fKnvZtCqv
 3b1MGtaqxIxyQSwhlaxqkNNs8VwsXrAy6+qDDZipgZLsP857k74xf+ed6X6/ddl0Hagg
 HE50mOFlhLHIQ6gju2yAbA47an4z3qNG64CGGs0Wy/ewaoQ3rAv/yLhpzLWSdFa8/YGB
 pQkVqyVL8IZSX4Og898xn0ljr8audcI6cfKIgHzxLxfTVgxMNwExLWhO4h0tI5XQhNib
 rJaw==
X-Gm-Message-State: AOJu0Yzwryxf7wSxKaXdaEN/IofsoPBrA0TOe1aVenUR3FAu/WCMh3jA
 fD8yxYXfYfanPYCgJki8e+AiohJp1/71P7y5e9C7Z0oJ/wb5uhAOQu+k2CkftZb9Nt2EFpngS55
 y
X-Gm-Gg: ASbGnctg38smRkOIvzlwQCaKsyMTs8WjRSuJ81/dHLp+RC++EiGlGXaneghYtQE4XCM
 m2BSxtD/I/BDtBLaFWCX3A1qEqW1LF4otW7yox7il//9PIdwifa3YKJ5guSeIytouo9BaOwoK2z
 jEC6d1zrsIM/I1CkhdbOWbkA7i355wFdHZX3pxPRXQ4GsvNIoASdxQXYFP7ezcr5EgYw0nHDawu
 HfE/ai8ATpHMpcKDPMnG+UuMd87b3npydHEXbOpAytKtPa6nuRZitvwN5P0Gg==
X-Google-Smtp-Source: AGHT+IF2Btsuoi1KjOD6BtobviynAZH2EbKxwkFr/+zZtcFA/WVtHtpg1yyXC4DbhXlWhTm03hhgoA==
X-Received: by 2002:a05:6a21:3a4b:b0:1e4:8fdd:8c77 with SMTP id
 adf61e73a8af0-1e5e044db75mr79519676637.8.1735841439055; 
 Thu, 02 Jan 2025 10:10:39 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/73] tcg: Remove INDEX_op_qemu_st8_*_i32
Date: Thu,  2 Jan 2025 10:06:36 -0800
Message-ID: <20250102180654.1420056-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

We can now handle the awkward i686 register constraints
by examining the MemOpIdx operand to qemu_st_*_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  6 ------
 tcg/aarch64/tcg-target-has.h     |  2 --
 tcg/arm/tcg-target-has.h         |  1 -
 tcg/i386/tcg-target-con-str.h    |  2 +-
 tcg/i386/tcg-target-has.h        |  6 ------
 tcg/loongarch64/tcg-target-has.h |  1 -
 tcg/mips/tcg-target-has.h        |  1 -
 tcg/ppc/tcg-target-has.h         |  2 --
 tcg/riscv/tcg-target-has.h       |  1 -
 tcg/s390x/tcg-target-has.h       |  1 -
 tcg/sparc64/tcg-target-has.h     |  1 -
 tcg/tci/tcg-target-has.h         |  1 -
 tcg/optimize.c                   |  2 --
 tcg/tcg-op-ldst.c                | 14 +++-----------
 tcg/tcg.c                        |  6 ------
 tcg/i386/tcg-target.c.inc        | 25 +++++++++++++++++--------
 16 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index efe2db5343..706d2a9794 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -182,12 +182,6 @@ DEF(qemu_ld_a64_i64, DATA64_ARGS, DATA64_ARGS, 1,
 DEF(qemu_st_a64_i64, 0, DATA64_ARGS + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 
-/* Only used by i386 to cope with stupid register constraints. */
-DEF(qemu_st8_a32_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-DEF(qemu_st8_a64_i32, 0, 1 + DATA64_ARGS, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_a32_i128, 2, 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 75344c301d..1ce5e8da5b 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -37,8 +37,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
  * which requires writable pages.  We must defer to the helper for user-only,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 5ff32e96a4..2c8d25d60a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -48,7 +48,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64)
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 52142ab121..4ddc550f50 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -20,7 +20,7 @@ REGS('r', ALL_GENERAL_REGS)
 REGS('x', ALL_VECTOR_REGS)
 REGS('q', ALL_BYTEL_REGS)     /* regs that can be used as a byte operand */
 REGS('L', ALL_GENERAL_REGS & ~SOFTMMU_RESERVE_REGS)  /* qemu_ld/st */
-REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
+REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st_i32 byte data */
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 71277b3f28..61547a1269 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -49,12 +49,6 @@
 #define TCG_TARGET_HAS_not(T)           (T <= TCG_TYPE_REG || have_avx512vl)
 #define TCG_TARGET_HAS_orc(T)           (T >= TCG_TYPE_V64 && have_avx512vl)
 
-#if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-#else
-#define TCG_TARGET_HAS_qemu_st8_i32     1
-#endif
-
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
     (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index a141205322..9e47cf40d3 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -34,7 +34,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index f6ccba95e5..ee090724d9 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -63,7 +63,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           0
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 1247bc873c..348182e1e6 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -41,8 +41,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG || have_isa_2_07)
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 88c022256f..10e61edc45 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -34,7 +34,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           (T <= TCG_TYPE_REG && (cpuinfo & CPUINFO_ZBB))
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 56d452bc7d..123b359a31 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -52,7 +52,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_not(T)         (T >= TCG_TYPE_V64 || HAVE_FACILITY(MISC_INSN_EXT3))
 #define TCG_TARGET_HAS_orc(T)         (T >= TCG_TYPE_V64 ? HAVE_FACILITY(VECTOR_ENH1) : HAVE_FACILITY(MISC_INSN_EXT3))
 
-#define TCG_TARGET_HAS_qemu_st8_i32   0
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 #define TCG_TARGET_HAS_tst            1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index e81f2bbe30..7e654240ad 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -38,7 +38,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 796769c574..3df463521d 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -32,7 +32,6 @@
 #define TCG_TARGET_HAS_not(T)           1
 #define TCG_TARGET_HAS_orc(T)           1
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index c55ad116bc..c591f93090 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2914,8 +2914,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_qemu_ld_a64_i128:
             done = fold_qemu_ld_2reg(&ctx, op);
             break;
-        case INDEX_op_qemu_st8_a32_i32:
-        case INDEX_op_qemu_st8_a64_i32:
         case INDEX_op_qemu_st_a32_i32:
         case INDEX_op_qemu_st_a64_i32:
         case INDEX_op_qemu_st_a32_i64:
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 77271e0193..b954e7379c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -309,18 +309,10 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st8_a32_i32;
-        } else {
-            opc = INDEX_op_qemu_st8_a64_i32;
-        }
+    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+        opc = INDEX_op_qemu_st_a32_i32;
     } else {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            opc = INDEX_op_qemu_st_a32_i32;
-        } else {
-            opc = INDEX_op_qemu_st_a64_i32;
-        }
+        opc = INDEX_op_qemu_st_a64_i32;
     }
     gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ba01e0a580..e7bb7a4d69 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2159,10 +2159,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_qemu_st_a64_i64:
         return true;
 
-    case INDEX_op_qemu_st8_a32_i32:
-    case INDEX_op_qemu_st8_a64_i32:
-        return TCG_TARGET_HAS_qemu_st8_i32;
-
     case INDEX_op_qemu_ld_a32_i128:
     case INDEX_op_qemu_ld_a64_i128:
     case INDEX_op_qemu_st_a32_i128:
@@ -2840,8 +2836,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_qemu_ld_a64_i32:
             case INDEX_op_qemu_st_a32_i32:
             case INDEX_op_qemu_st_a64_i32:
-            case INDEX_op_qemu_st8_a32_i32:
-            case INDEX_op_qemu_st8_a64_i32:
             case INDEX_op_qemu_ld_a32_i64:
             case INDEX_op_qemu_ld_a64_i64:
             case INDEX_op_qemu_st_a32_i64:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 89b2eaf0cd..bee3e6b8c2 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2481,7 +2481,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* This is handled with constraints on INDEX_op_qemu_st8_i32. */
+        /* This is handled with constraints on INDEX_op_qemu_st_i32. */
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
                                  datalo, h.base, h.index, 0, h.ofs);
@@ -2934,14 +2934,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_qemu_st_a64_i32:
-    case INDEX_op_qemu_st8_a64_i32:
         if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_qemu_st(s, a0, -1, a1, a2, args[3], TCG_TYPE_I32);
             break;
         }
         /* fall through */
     case INDEX_op_qemu_st_a32_i32:
-    case INDEX_op_qemu_st8_a32_i32:
         tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_a32_i64:
@@ -3807,13 +3805,24 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O1_I2(r, L, L);
 
     case INDEX_op_qemu_st_a32_i32:
+        if (TCG_TARGET_REG_BITS == 32) {
+            MemOpIdx oi = op->args[2];
+            MemOp mop = get_memop(oi);
+            if ((mop & MO_SIZE) == MO_8) {
+                return C_O0_I2(s, L);
+            }
+        }
         return C_O0_I2(L, L);
     case INDEX_op_qemu_st_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L) : C_O0_I3(L, L, L);
-    case INDEX_op_qemu_st8_a32_i32:
-        return C_O0_I2(s, L);
-    case INDEX_op_qemu_st8_a64_i32:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(s, L) : C_O0_I3(s, L, L);
+        if (TCG_TARGET_REG_BITS == 32) {
+            MemOpIdx oi = op->args[3];
+            MemOp mop = get_memop(oi);
+            if ((mop & MO_SIZE) == MO_8) {
+                return C_O0_I3(s, L, L);
+            }
+            return C_O0_I3(L, L, L);
+        }
+        return C_O0_I2(L, L);
 
     case INDEX_op_qemu_ld_a32_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I1(r, r, L);
-- 
2.43.0



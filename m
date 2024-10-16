Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DD6D2A543
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kO-0002gx-Bj; Wed, 16 Oct 2024 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kL-0002ek-Dx
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kH-0003nw-Nq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso119145a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107104; x=1729711904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC9y0zX4FGXcxl44shwm/CevG9iZ9j82UlAnPEFCOs8=;
 b=L5pwnHTjI3Np4MogX9KhwfquPCs1Q3bWIAak1sn017koFqWBiBXuUsxbn+1C+4BF42
 XXsC/H5nFMMneOCDXJHWgKjuOeL6ltUVuTJKJGRcJfidIG0HD7TjKz5lchkTlC8JAOmI
 VpF3zRAKy8Kueom82mfjpSpz9Ry3nTWhbSsSIREdYN0fDLWZG2TtlzdQoGX/nS/kl4AB
 TB7l+IqrmW3hFpC6eDfLB4fp17m6OjsKs0JfxzyXRAdbqeuvqBdySsm90GlRaV8lRCwg
 A77OIJiU6BTAdqpEwhOzi4ONvAR5LkMYNl3NVZT5fY3dJ9B2Uy6e1eH8xsBcWcEgdyOC
 Nq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107104; x=1729711904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC9y0zX4FGXcxl44shwm/CevG9iZ9j82UlAnPEFCOs8=;
 b=ruxhPu7UJgtfZBkaXkmL6abaS5gTg6taQYMR9UuvbGkBzOUg7Wky8gov94A8XZdP3b
 9ikt1UX6Q1GfsZ2OoUJYdrtfKa79A9E69JEROJKkztFzs0rmPrXFgtTGobOTP0NGoWSd
 hViozjOrvz1SuedylI4f4y7HNdWIf42UUZ+NcIyvpZAURdrQNklu3McvP2PQwIAwJvvk
 GFQQpqQPJONV9JWrfJEhF5XKxMPayqhT3NkXVA11aZ+rxZMoYgePvEY2JVH3sr2qPMgh
 5cK0UTIL9E1nzBBHI/Qnr80mlSfNYB+poFUc8mJDu4Ooo/PNRyIhKXvc6/H9e4a1JSzN
 E/Fw==
X-Gm-Message-State: AOJu0YyU0+ELlqBM1ef0x2aNMfNIuLKrn8GgIVOB62kulX/kdWLYEIUe
 8nQmg/Mx5i09Z7soNi78nafMUNDumeG9ENjRnYNSxIe+q9W50Vbi52H0e/qUaQ2tdWXuGPQf1iM
 3
X-Google-Smtp-Source: AGHT+IFQ59OYjPP5Vsa4hjel3c5g6beQHqd4xfhV/i9egnJ3dnWKokjiSUfDZdyYywHjoGANxBTCLQ==
X-Received: by 2002:a17:90b:216:b0:2e2:b64e:f4f7 with SMTP id
 98e67ed59e1d1-2e3ab8bc7bcmr5617989a91.29.1729107104088; 
 Wed, 16 Oct 2024 12:31:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, Huang Shiyuan <swung0x48@outlook.com>,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 04/14] tcg/riscv: Add basic support for vector
Date: Wed, 16 Oct 2024 12:31:30 -0700
Message-ID: <20241016193140.2206352-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

From: Huang Shiyuan <swung0x48@outlook.com>

The RISC-V vector instruction set utilizes the LMUL field to group
multiple registers, enabling variable-length vector registers. This
implementation uses only the first register number of each group while
reserving the other register numbers within the group.

In TCG, each VEC_IR can have 3 types (TCG_TYPE_V64/128/256), and the
host runtime needs to adjust LMUL based on the type to use different
register groups.

This presents challenges for TCG's register allocation. Currently, we
avoid modifying the register allocation part of TCG and only expose the
minimum number of vector registers.

For example, when the host vlen is 64 bits and type is TCG_TYPE_V256, with
LMUL equal to 4, we use 4 vector registers as one register group. We can
use a maximum of 8 register groups, but the V0 register number is reserved
as a mask register, so we can effectively use at most 7 register groups.
Moreover, when type is smaller than TCG_TYPE_V256, only 7 registers are
forced to be used. This is because TCG cannot yet dynamically constrain
registers with type; likewise, when the host vlen is 128 bits and
TCG_TYPE_V256, we can use at most 15 registers.

There is not much pressure on vector register allocation in TCG now, so
using 7 registers is feasible and will not have a major impact on code
generation.

This patch:
1. Reserves vector register 0 for use as a mask register.
2. When using register groups, reserves the additional registers within
   each group.

Signed-off-by: Huang Shiyuan <swung0x48@outlook.com>
Co-authored-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Swung0x48 <swung0x48@outlook.com>
Message-ID: <20241007025700.47259-3-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h              |   6 +
 tcg/riscv/tcg-target-con-set.h |   2 +
 tcg/riscv/tcg-target-con-str.h |   1 +
 tcg/riscv/tcg-target.h         |  78 ++++---
 tcg/riscv/tcg-target.opc.h     |  12 +
 tcg/riscv/tcg-target.c.inc     | 414 ++++++++++++++++++++++++++++++---
 6 files changed, 442 insertions(+), 71 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 824fb3560d..a77ed12b9d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -521,6 +521,12 @@ struct TCGContext {
     struct qemu_plugin_insn *plugin_insn;
 #endif
 
+    /* For host-specific values. */
+#ifdef __riscv
+    MemOp riscv_cur_vsew;
+    TCGType riscv_cur_type;
+#endif
+
     GHashTable *const_table[TCG_TYPE_COUNT];
     TCGTempSet free_temps[TCG_TYPE_COUNT];
     TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index aac5ceee2b..d73a62b0f2 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -21,3 +21,5 @@ C_O1_I2(r, rZ, rZ)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
+C_O0_I2(v, r)
+C_O1_I1(v, r)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index d5c419dff1..b2b3211bcb 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -9,6 +9,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('v', ALL_VECTOR_REGS)
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 1a347eaf6e..12a7a37aaa 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -28,42 +28,28 @@
 #include "host/cpuinfo.h"
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 typedef enum {
-    TCG_REG_ZERO,
-    TCG_REG_RA,
-    TCG_REG_SP,
-    TCG_REG_GP,
-    TCG_REG_TP,
-    TCG_REG_T0,
-    TCG_REG_T1,
-    TCG_REG_T2,
-    TCG_REG_S0,
-    TCG_REG_S1,
-    TCG_REG_A0,
-    TCG_REG_A1,
-    TCG_REG_A2,
-    TCG_REG_A3,
-    TCG_REG_A4,
-    TCG_REG_A5,
-    TCG_REG_A6,
-    TCG_REG_A7,
-    TCG_REG_S2,
-    TCG_REG_S3,
-    TCG_REG_S4,
-    TCG_REG_S5,
-    TCG_REG_S6,
-    TCG_REG_S7,
-    TCG_REG_S8,
-    TCG_REG_S9,
-    TCG_REG_S10,
-    TCG_REG_S11,
-    TCG_REG_T3,
-    TCG_REG_T4,
-    TCG_REG_T5,
-    TCG_REG_T6,
+    TCG_REG_ZERO, TCG_REG_RA,  TCG_REG_SP,  TCG_REG_GP,
+    TCG_REG_TP,   TCG_REG_T0,  TCG_REG_T1,  TCG_REG_T2,
+    TCG_REG_S0,   TCG_REG_S1,  TCG_REG_A0,  TCG_REG_A1,
+    TCG_REG_A2,   TCG_REG_A3,  TCG_REG_A4,  TCG_REG_A5,
+    TCG_REG_A6,   TCG_REG_A7,  TCG_REG_S2,  TCG_REG_S3,
+    TCG_REG_S4,   TCG_REG_S5,  TCG_REG_S6,  TCG_REG_S7,
+    TCG_REG_S8,   TCG_REG_S9,  TCG_REG_S10, TCG_REG_S11,
+    TCG_REG_T3,   TCG_REG_T4,  TCG_REG_T5,  TCG_REG_T6,
+
+    /* RISC-V V Extension registers */
+    TCG_REG_V0,   TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,   TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,   TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12,  TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16,  TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20,  TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24,  TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28,  TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
 
     /* aliases */
     TCG_AREG0          = TCG_REG_S0,
@@ -156,6 +142,32 @@ typedef enum {
 
 #define TCG_TARGET_HAS_tst              0
 
+/* vector instructions */
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             0
+#define TCG_TARGET_HAS_v256             0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
+#define TCG_TARGET_HAS_tst_vec          0
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target.opc.h
new file mode 100644
index 0000000000..b80b39e1e5
--- /dev/null
+++ b/tcg/riscv/tcg-target.opc.h
@@ -0,0 +1,12 @@
+/*
+ * Copyright (c) C-SKY Microsystems Co., Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d334857226..38d71111c9 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -32,38 +32,14 @@
 
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "zero",
-    "ra",
-    "sp",
-    "gp",
-    "tp",
-    "t0",
-    "t1",
-    "t2",
-    "s0",
-    "s1",
-    "a0",
-    "a1",
-    "a2",
-    "a3",
-    "a4",
-    "a5",
-    "a6",
-    "a7",
-    "s2",
-    "s3",
-    "s4",
-    "s5",
-    "s6",
-    "s7",
-    "s8",
-    "s9",
-    "s10",
-    "s11",
-    "t3",
-    "t4",
-    "t5",
-    "t6"
+    "zero", "ra",  "sp",  "gp",  "tp",  "t0",  "t1",  "t2",
+    "s0",   "s1",  "a0",  "a1",  "a2",  "a3",  "a4",  "a5",
+    "a6",   "a7",  "s2",  "s3",  "s4",  "s5",  "s6",  "s7",
+    "s8",   "s9",  "s10", "s11", "t3",  "t4",  "t5",  "t6",
+    "v0",   "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",   "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16",  "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24",  "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -100,6 +76,16 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_A5,
     TCG_REG_A6,
     TCG_REG_A7,
+
+    /* Vector registers and TCG_REG_V0 reserved for mask. */
+    TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,  TCG_REG_V4,
+    TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,  TCG_REG_V8,
+    TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11, TCG_REG_V12,
+    TCG_REG_V13, TCG_REG_V14, TCG_REG_V15, TCG_REG_V16,
+    TCG_REG_V17, TCG_REG_V18, TCG_REG_V19, TCG_REG_V20,
+    TCG_REG_V21, TCG_REG_V22, TCG_REG_V23, TCG_REG_V24,
+    TCG_REG_V25, TCG_REG_V26, TCG_REG_V27, TCG_REG_V28,
+    TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -127,6 +113,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_J12  0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
+#define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
+#define ALL_DVECTOR_REG_GROUPS 0x5555555500000000
+#define ALL_QVECTOR_REG_GROUPS 0x1111111100000000
 
 #define sextreg  sextract64
 
@@ -176,6 +165,31 @@ static bool tcg_target_const_match(int64_t val, int ct,
  * RISC-V Base ISA opcodes (IM)
  */
 
+#define V_OPIVV (0x0 << 12)
+#define V_OPFVV (0x1 << 12)
+#define V_OPMVV (0x2 << 12)
+#define V_OPIVI (0x3 << 12)
+#define V_OPIVX (0x4 << 12)
+#define V_OPFVF (0x5 << 12)
+#define V_OPMVX (0x6 << 12)
+#define V_OPCFG (0x7 << 12)
+
+/* NF <= 7 && NF >= 0 */
+#define V_NF(x) (x << 29)
+#define V_UNIT_STRIDE (0x0 << 20)
+#define V_UNIT_STRIDE_WHOLE_REG (0x8 << 20)
+
+typedef enum {
+    VLMUL_M1 = 0, /* LMUL=1 */
+    VLMUL_M2,     /* LMUL=2 */
+    VLMUL_M4,     /* LMUL=4 */
+    VLMUL_M8,     /* LMUL=8 */
+    VLMUL_RESERVED,
+    VLMUL_MF8,    /* LMUL=1/8 */
+    VLMUL_MF4,    /* LMUL=1/4 */
+    VLMUL_MF2,    /* LMUL=1/2 */
+} RISCVVlmul;
+
 typedef enum {
     OPC_ADD = 0x33,
     OPC_ADDI = 0x13,
@@ -271,6 +285,30 @@ typedef enum {
     /* Zicond: integer conditional operations */
     OPC_CZERO_EQZ = 0x0e005033,
     OPC_CZERO_NEZ = 0x0e007033,
+
+    /* V: Vector extension 1.0 */
+    OPC_VSETVLI  = 0x57 | V_OPCFG,
+    OPC_VSETIVLI = 0xc0000057 | V_OPCFG,
+    OPC_VSETVL   = 0x80000057 | V_OPCFG,
+
+    OPC_VLE8_V  = 0x7 | V_UNIT_STRIDE,
+    OPC_VLE16_V = 0x5007 | V_UNIT_STRIDE,
+    OPC_VLE32_V = 0x6007 | V_UNIT_STRIDE,
+    OPC_VLE64_V = 0x7007 | V_UNIT_STRIDE,
+    OPC_VSE8_V  = 0x27 | V_UNIT_STRIDE,
+    OPC_VSE16_V = 0x5027 | V_UNIT_STRIDE,
+    OPC_VSE32_V = 0x6027 | V_UNIT_STRIDE,
+    OPC_VSE64_V = 0x7027 | V_UNIT_STRIDE,
+
+    OPC_VL1RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(0),
+    OPC_VL2RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
+    OPC_VL4RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
+    OPC_VL8RE64_V = 0x2007007 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
+
+    OPC_VS1R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(0),
+    OPC_VS2R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
+    OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
+    OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 } RISCVInsn;
 
 /*
@@ -363,6 +401,35 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+/* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
+
+static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
+                        TCGReg s2, bool vm)
+{
+    return opc | (d & 0x1f) << 7 | (s1 & 0x1f) << 15 |
+           (s2 & 0x1f) << 20 | (vm << 25);
+}
+
+/* Vector vtype */
+
+static uint32_t encode_vtype(bool vta, bool vma,
+                            MemOp vsew, RISCVVlmul vlmul)
+{
+    return vma << 7 | vta << 6 | vsew << 3 | vlmul;
+}
+
+static int32_t encode_vset(RISCVInsn opc, TCGReg rd,
+                           TCGArg rs1, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (vtype & 0x7ff) << 20;
+}
+
+static int32_t encode_vseti(RISCVInsn opc, TCGReg rd,
+                            uint32_t uimm, uint32_t vtype)
+{
+    return opc | (rd & 0x1f) << 7 | (uimm & 0x1f) << 15 | (vtype & 0x3ff) << 20;
+}
+
 /*
  * RISC-V instruction emitters
  */
@@ -475,6 +542,38 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     }
 }
 
+/*
+ * RISC-V vector instruction emitters
+ */
+
+typedef struct VsetCache {
+    uint32_t movi_insn;
+    uint32_t vset_insn;
+} VsetCache;
+
+static VsetCache riscv_vset_cache[3][4];
+
+static void set_vtype(TCGContext *s, TCGType type, MemOp vsew)
+{
+    const VsetCache *p = &riscv_vset_cache[type - TCG_TYPE_V64][vsew];
+
+    s->riscv_cur_type = type;
+    s->riscv_cur_vsew = vsew;
+
+    if (p->movi_insn) {
+        tcg_out32(s, p->movi_insn);
+    }
+    tcg_out32(s, p->vset_insn);
+}
+
+static MemOp set_vtype_len(TCGContext *s, TCGType type)
+{
+    if (type != s->riscv_cur_type) {
+        set_vtype(s, type, MO_64);
+    }
+    return s->riscv_cur_vsew;
+}
+
 /*
  * TCG intrinsics
  */
@@ -681,18 +780,101 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     }
 }
 
+static void tcg_out_vec_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
+                             TCGReg addr, intptr_t offset)
+{
+    tcg_debug_assert(data >= TCG_REG_V0);
+    tcg_debug_assert(addr < TCG_REG_V0);
+
+    if (offset) {
+        tcg_debug_assert(addr != TCG_REG_ZERO);
+        if (offset == sextreg(offset, 0, 12)) {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, offset);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
+            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, addr);
+        }
+        addr = TCG_REG_TMP0;
+    }
+    tcg_out32(s, encode_v(opc, data, addr, 0, true));
+}
+
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
-    tcg_out_ldst(s, insn, arg, arg1, arg2);
+    RISCVInsn insn;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_out_ldst(s, OPC_LW, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_out_ldst(s, OPC_LD, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        if (type >= riscv_lg2_vlenb) {
+            static const RISCVInsn whole_reg_ld[] = {
+                OPC_VL1RE64_V, OPC_VL2RE64_V, OPC_VL4RE64_V, OPC_VL8RE64_V
+            };
+            unsigned idx = type - riscv_lg2_vlenb;
+
+            tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
+            insn = whole_reg_ld[idx];
+        } else {
+            static const RISCVInsn unit_stride_ld[] = {
+                OPC_VLE8_V, OPC_VLE16_V, OPC_VLE32_V, OPC_VLE64_V
+            };
+            MemOp prev_vsew = set_vtype_len(s, type);
+
+            tcg_debug_assert(prev_vsew < ARRAY_SIZE(unit_stride_ld));
+            insn = unit_stride_ld[prev_vsew];
+        }
+        tcg_out_vec_ldst(s, insn, arg, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                        TCGReg arg1, intptr_t arg2)
 {
-    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SW : OPC_SD;
-    tcg_out_ldst(s, insn, arg, arg1, arg2);
+    RISCVInsn insn;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_out_ldst(s, OPC_SW, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_I64:
+        tcg_out_ldst(s, OPC_SD, arg, arg1, arg2);
+        break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        if (type >= riscv_lg2_vlenb) {
+            static const RISCVInsn whole_reg_st[] = {
+                OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V
+            };
+            unsigned idx = type - riscv_lg2_vlenb;
+
+            tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_st));
+            insn = whole_reg_st[idx];
+        } else {
+            static const RISCVInsn unit_stride_st[] = {
+                OPC_VSE8_V, OPC_VSE16_V, OPC_VSE32_V, OPC_VSE64_V
+            };
+            MemOp prev_vsew = set_vtype_len(s, type);
+
+            tcg_debug_assert(prev_vsew < ARRAY_SIZE(unit_stride_st));
+            insn = unit_stride_st[prev_vsew];
+        }
+        tcg_out_vec_ldst(s, insn, arg, arg1, arg2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
@@ -766,6 +948,23 @@ static void tcg_out_addsub2(TCGContext *s,
     }
 }
 
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                                   TCGReg dst, TCGReg src)
+{
+    return false;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, int64_t arg)
+{
+}
+
 static const struct {
     RISCVInsn op;
     bool swap;
@@ -1104,12 +1303,19 @@ static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
     }
 }
 
+static void init_setting_vtype(TCGContext *s)
+{
+    s->riscv_cur_type = TCG_TYPE_COUNT;
+}
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
     int ret;
 
+    init_setting_vtype(s);
+
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 20)) {
         /* short jump: -2097150 to 2097152 */
@@ -1247,6 +1453,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
+        init_setting_vtype(s);
+
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
@@ -1308,6 +1516,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
             ldst->oi = oi;
             ldst->addrlo_reg = addr_reg;
 
+            init_setting_vtype(s);
+
             /* We are expecting alignment max 7, so we can always use andi. */
             tcg_debug_assert(a_mask == sextreg(a_mask, 0, 12));
             tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_reg, a_mask);
@@ -1881,6 +2091,46 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg args[TCG_MAX_OP_ARGS],
+                           const int const_args[TCG_MAX_OP_ARGS])
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0, a1, a2;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+
+    switch (opc) {
+    case INDEX_op_ld_vec:
+        tcg_out_ld(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_st_vec:
+        tcg_out_st(s, type, a0, a1, a2);
+        break;
+    case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    g_assert_not_reached();
+}
+
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    default:
+        return 0;
+    }
+}
+
 static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 {
     switch (op) {
@@ -2020,6 +2270,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
+    case INDEX_op_st_vec:
+        return C_O0_I2(v, r);
+    case INDEX_op_ld_vec:
+        return C_O1_I1(v, r);
     default:
         g_assert_not_reached();
     }
@@ -2093,7 +2347,65 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
-    /* nothing to do */
+    init_setting_vtype(s);
+}
+
+static bool vtype_check(unsigned vtype)
+{
+    unsigned long tmp;
+
+    /* vsetvl tmp, zero, vtype */
+    asm(".insn r 0x57, 7, 0x40, %0, zero, %1" : "=r"(tmp) : "r"(vtype));
+    return tmp != 0;
+}
+
+static void probe_frac_lmul_1(TCGType type, MemOp vsew)
+{
+    VsetCache *p = &riscv_vset_cache[type - TCG_TYPE_V64][vsew];
+    unsigned avl = tcg_type_size(type) >> vsew;
+    int lmul = type - riscv_lg2_vlenb;
+    unsigned vtype = encode_vtype(true, true, vsew, lmul & 7);
+    bool lmul_eq_avl = true;
+
+    /* Guaranteed by Zve64x. */
+    assert(lmul < 3);
+
+    /*
+     * For LMUL < -3, the host vector size is so large that TYPE
+     * is smaller than the minimum 1/8 fraction.
+     *
+     * For other fractional LMUL settings, implementations must
+     * support SEW settings between SEW_MIN and LMUL * ELEN, inclusive.
+     * So if ELEN = 64, LMUL = 1/2, then SEW will support e8, e16, e32,
+     * but e64 may not be supported. In other words, the hardware only
+     * guarantees SEW_MIN <= SEW <= LMUL * ELEN.  Check.
+     */
+    if (lmul < 0 && (lmul < -3 || !vtype_check(vtype))) {
+        vtype = encode_vtype(true, true, vsew, VLMUL_M1);
+        lmul_eq_avl = false;
+    }
+
+    if (avl < 32) {
+        p->vset_insn = encode_vseti(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
+    } else if (lmul_eq_avl) {
+        /* rd != 0 and rs1 == 0 uses vlmax */
+        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
+    } else {
+        p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
+        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
+    }
+}
+
+static void probe_frac_lmul(void)
+{
+    /* Match riscv_lg2_vlenb to TCG_TYPE_V64. */
+    QEMU_BUILD_BUG_ON(TCG_TYPE_V64 != 3);
+
+    for (TCGType t = TCG_TYPE_V64; t <= TCG_TYPE_V256; t++) {
+        for (MemOp e = MO_8; e <= MO_64; e++) {
+            probe_frac_lmul_1(t, e);
+        }
+    }
 }
 
 static void tcg_target_init(TCGContext *s)
@@ -2101,7 +2413,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
-    tcg_target_call_clobber_regs = -1u;
+    tcg_target_call_clobber_regs = -1;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S1);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S2);
@@ -2123,6 +2435,32 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
+
+    if (cpuinfo & CPUINFO_ZVE64X) {
+        switch (riscv_lg2_vlenb) {
+        case TCG_TYPE_V64:
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_DVECTOR_REG_GROUPS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_QVECTOR_REG_GROUPS;
+            s->reserved_regs |= (~ALL_QVECTOR_REG_GROUPS & ALL_VECTOR_REGS);
+            break;
+        case TCG_TYPE_V128:
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_DVECTOR_REG_GROUPS;
+            s->reserved_regs |= (~ALL_DVECTOR_REG_GROUPS & ALL_VECTOR_REGS);
+            break;
+        default:
+            /* Guaranteed by Zve64x. */
+            tcg_debug_assert(riscv_lg2_vlenb >= TCG_TYPE_V256);
+            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
+            break;
+        }
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_V0);
+        probe_frac_lmul();
+    }
 }
 
 typedef struct {
-- 
2.43.0



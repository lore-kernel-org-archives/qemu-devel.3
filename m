Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB0AC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtTY-000199-Ay; Thu, 27 Jun 2024 14:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTR-00017u-MB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:03:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMtTO-0001Li-KO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:03:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-707040e3018so5698911a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719511433; x=1720116233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AX9ylv1erEuktvBeFNptQKlvwEwxi/3GoH2xuhP/ArI=;
 b=IIO7iMVnToUFvBd407vOVyVNp0avbXKunS2TebnfsQVD2Awckcxn5UmXhzj8Eqc1Wx
 LyZkDQUkJTlyhPhIsMKctGVi5lxHF42ySXngDsLJ6nPWRdhmDYu7THgeMAFPRSdFiK7U
 4gMpFDwlv9ehZm+4oUtrGNwuDVXj2nZ0Mm+W13C/rfcVis+2NuYE02/izD+ih9JwA2g+
 IbxzI9Sfp43rGLLJq0I1j8oC8/MKXw0M9dnwlJ8rS3KJwG0b/MvE3LxsdgL/V+AA7ivH
 wNcdmeQ1y1K8y4eKTH++lpH28b8ZGDezjbxIPE8JT0Aum7qGj5IbKW7/0TexPAQWGbKP
 HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719511433; x=1720116233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AX9ylv1erEuktvBeFNptQKlvwEwxi/3GoH2xuhP/ArI=;
 b=rkuS1pQztqa5l6oBPgco5X8gtATeEhfAcUf5hdOURW1bsfpD2cKeLRLPgN1KVu8Oca
 HIGKdxyBEI5rnvKt1GQeMc8sP1OieMUVHtC/sw0Joz7r4KiAFKNlkkSo5Z/Zl9ndd6fQ
 DWBOZedWyzuAvunX1jCbwoDsDw0yzll+JolVpz4SyEvgqaEnU63g4If4WGWNz6JUDTPd
 ZGJeIUw9UKnJ82sByfaHgDx240rvisggamhYy6tdMG2nDLM4As8laTDTgJGBKtR6UQS2
 hB4XNvtyZJ3nNa3gU4RepQSnWKIb0sNZep/TLvcjarvb3RnyDKq3/8ur3WT98KLwy5HH
 KQYQ==
X-Gm-Message-State: AOJu0Ywq7E6wHD9Om3eLOCV4tzkCQ2BLwglclt4mCIKitF+7K7J4vFmZ
 f8Eiq8XLP0lNhJfLxIfyfJf6CneVMK/7WMXPPkBbY1qVPh/elypY1QmLRb5YACZmdWcarsNtHCD
 V
X-Google-Smtp-Source: AGHT+IGs07nCraCsYIFDK8MlemkwC/vXBupQCJcGrXmN4SgBgYtFElwYQ9z8BnWNNtdioIuEAbnUBQ==
X-Received: by 2002:a05:6a20:3016:b0:1be:c551:b74a with SMTP id
 adf61e73a8af0-1bec551b9femr4738440637.59.1719511432866; 
 Thu, 27 Jun 2024 11:03:52 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ecf764sm2170b3a.106.2024.06.27.11.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 11:03:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: brad@comstyle.com, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/3] util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
Date: Thu, 27 Jun 2024 11:03:48 -0700
Message-Id: <20240627180350.128575-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627180350.128575-1-richard.henderson@linaro.org>
References: <20240627180350.128575-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move detection code out of tcg, similar to other hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/riscv/host/cpuinfo.h | 23 +++++++++
 tcg/riscv/tcg-target.h            | 46 ++++++++---------
 util/cpuinfo-riscv.c              | 85 +++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.c.inc        | 84 +++---------------------------
 util/meson.build                  |  2 +
 5 files changed, 139 insertions(+), 101 deletions(-)
 create mode 100644 host/include/riscv/host/cpuinfo.h
 create mode 100644 util/cpuinfo-riscv.c

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
new file mode 100644
index 0000000000..2b00660e36
--- /dev/null
+++ b/host/include/riscv/host/cpuinfo.h
@@ -0,0 +1,23 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for RISC-V.
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_ZBA             (1u << 1)
+#define CPUINFO_ZBB             (1u << 2)
+#define CPUINFO_ZICOND          (1u << 3)
+
+/* Initialized with a constructor. */
+extern unsigned cpuinfo;
+
+/*
+ * We cannot rely on constructor ordering, so other constructors must
+ * use the function interface rather than the variable above.
+ */
+unsigned cpuinfo_init(void);
+
+#endif /* HOST_CPUINFO_H */
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 2c1b680b93..1a347eaf6e 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -25,6 +25,8 @@
 #ifndef RISCV_TCG_TARGET_H
 #define RISCV_TCG_TARGET_H
 
+#include "host/cpuinfo.h"
+
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
@@ -80,18 +82,12 @@ typedef enum {
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
-#if defined(__riscv_arch_test) && defined(__riscv_zbb)
-# define have_zbb true
-#else
-extern bool have_zbb;
-#endif
-
 /* optional instructions */
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
-#define TCG_TARGET_HAS_rot_i32          have_zbb
+#define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -106,17 +102,17 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ext16s_i32       1
 #define TCG_TARGET_HAS_ext8u_i32        1
 #define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      have_zbb
-#define TCG_TARGET_HAS_bswap32_i32      have_zbb
+#define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         have_zbb
-#define TCG_TARGET_HAS_orc_i32          have_zbb
-#define TCG_TARGET_HAS_eqv_i32          have_zbb
+#define TCG_TARGET_HAS_andc_i32         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_orc_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_eqv_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          have_zbb
-#define TCG_TARGET_HAS_ctz_i32          have_zbb
-#define TCG_TARGET_HAS_ctpop_i32        have_zbb
+#define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
@@ -125,7 +121,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          have_zbb
+#define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
@@ -137,18 +133,18 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ext8u_i64        1
 #define TCG_TARGET_HAS_ext16u_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      have_zbb
-#define TCG_TARGET_HAS_bswap32_i64      have_zbb
-#define TCG_TARGET_HAS_bswap64_i64      have_zbb
+#define TCG_TARGET_HAS_bswap16_i64      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap32_i64      (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_andc_i64         have_zbb
-#define TCG_TARGET_HAS_orc_i64          have_zbb
-#define TCG_TARGET_HAS_eqv_i64          have_zbb
+#define TCG_TARGET_HAS_andc_i64         (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_orc_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_eqv_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          have_zbb
-#define TCG_TARGET_HAS_ctz_i64          have_zbb
-#define TCG_TARGET_HAS_ctpop_i64        have_zbb
+#define TCG_TARGET_HAS_clz_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctz_i64          (cpuinfo & CPUINFO_ZBB)
+#define TCG_TARGET_HAS_ctpop_i64        (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
new file mode 100644
index 0000000000..6b97100620
--- /dev/null
+++ b/util/cpuinfo-riscv.c
@@ -0,0 +1,85 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu identification for RISC-V.
+ */
+
+#include "qemu/osdep.h"
+#include "host/cpuinfo.h"
+
+unsigned cpuinfo;
+static volatile sig_atomic_t got_sigill;
+
+static void sigill_handler(int signo, siginfo_t *si, void *data)
+{
+    /* Skip the faulty instruction */
+    ucontext_t *uc = (ucontext_t *)data;
+    uc->uc_mcontext.__gregs[REG_PC] += 4;
+
+    got_sigill = 1;
+}
+
+/* Called both as constructor and (possibly) via other constructors. */
+unsigned __attribute__((constructor)) cpuinfo_init(void)
+{
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND;
+    unsigned info = cpuinfo;
+
+    if (info) {
+        return info;
+    }
+
+    /* Test for compile-time settings. */
+#if defined(__riscv_arch_test) && defined(__riscv_zba)
+    info |= CPUINFO_ZBA;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zbb)
+    info |= CPUINFO_ZBB;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zicond)
+    info |= CPUINFO_ZICOND;
+#endif
+    left &= ~info;
+
+    if (left) {
+        struct sigaction sa_old, sa_new;
+
+        memset(&sa_new, 0, sizeof(sa_new));
+        sa_new.sa_flags = SA_SIGINFO;
+        sa_new.sa_sigaction = sigill_handler;
+        sigaction(SIGILL, &sa_new, &sa_old);
+
+        if (left & CPUINFO_ZBA) {
+            /* Probe for Zba: add.uw zero,zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero"
+                         : : : "memory");
+            info |= !got_sigill * CPUINFO_ZBA;
+            left &= ~CPUINFO_ZBA;
+        }
+
+        if (left & CPUINFO_ZBB) {
+            /* Probe for Zba: andn zero,zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero"
+                         : : : "memory");
+            info |= !got_sigill * CPUINFO_ZBB;
+            left &= ~CPUINFO_ZBB;
+        }
+
+        if (left & CPUINFO_ZICOND) {
+            /* Probe for Zicond: czero.eqz zero,zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero"
+                         : : : "memory");
+            info |= !got_sigill * CPUINFO_ZICOND;
+            left &= ~CPUINFO_ZICOND;
+        }
+
+        sigaction(SIGILL, &sa_old, NULL);
+        assert(left == 0);
+    }
+
+    info |= CPUINFO_ALWAYS;
+    cpuinfo = info;
+    return info;
+}
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 639363039b..d334857226 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -113,20 +113,6 @@ static const int tcg_target_call_iarg_regs[] = {
     TCG_REG_A7,
 };
 
-#ifndef have_zbb
-bool have_zbb;
-#endif
-#if defined(__riscv_arch_test) && defined(__riscv_zba)
-# define have_zba true
-#else
-static bool have_zba;
-#endif
-#if defined(__riscv_arch_test) && defined(__riscv_zicond)
-# define have_zicond true
-#else
-static bool have_zicond;
-#endif
-
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 {
     tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
@@ -594,7 +580,7 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    if (have_zbb) {
+    if (cpuinfo & CPUINFO_ZBB) {
         tcg_out_opc_reg(s, OPC_ZEXT_H, ret, arg, TCG_REG_ZERO);
     } else {
         tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
@@ -604,7 +590,7 @@ static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    if (have_zba) {
+    if (cpuinfo & CPUINFO_ZBA) {
         tcg_out_opc_reg(s, OPC_ADD_UW, ret, arg, TCG_REG_ZERO);
     } else {
         tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
@@ -614,7 +600,7 @@ static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    if (have_zbb) {
+    if (cpuinfo & CPUINFO_ZBB) {
         tcg_out_opc_imm(s, OPC_SEXT_B, ret, arg, 0);
     } else {
         tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
@@ -624,7 +610,7 @@ static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    if (have_zbb) {
+    if (cpuinfo & CPUINFO_ZBB) {
         tcg_out_opc_imm(s, OPC_SEXT_H, ret, arg, 0);
     } else {
         tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
@@ -1080,7 +1066,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     int tmpflags;
     TCGReg t;
 
-    if (!have_zicond && (!c_cmp2 || cmp2 == 0)) {
+    if (!(cpuinfo & CPUINFO_ZICOND) && (!c_cmp2 || cmp2 == 0)) {
         tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
                             val1, c_val1, val2, c_val2);
         return;
@@ -1089,7 +1075,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     tmpflags = tcg_out_setcond_int(s, cond, TCG_REG_TMP0, cmp1, cmp2, c_cmp2);
     t = tmpflags & ~SETCOND_FLAGS;
 
-    if (have_zicond) {
+    if (cpuinfo & CPUINFO_ZICOND) {
         if (tmpflags & SETCOND_INV) {
             tcg_out_movcond_zicond(s, ret, t, val2, c_val2, val1, c_val1);
         } else {
@@ -1304,7 +1290,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         /* TLB Hit - translate address using addend.  */
         if (addr_type != TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
-        } else if (have_zba) {
+        } else if (cpuinfo & CPUINFO_ZBA) {
             tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0,
                             addr_reg, TCG_REG_TMP2);
         } else {
@@ -1335,7 +1321,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
             if (addr_type != TCG_TYPE_I32) {
                 tcg_out_opc_reg(s, OPC_ADD, base, addr_reg,
                                 TCG_GUEST_BASE_REG);
-            } else if (have_zba) {
+            } else if (cpuinfo & CPUINFO_ZBA) {
                 tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg,
                                 TCG_GUEST_BASE_REG);
             } else {
@@ -2110,62 +2096,8 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
-static volatile sig_atomic_t got_sigill;
-
-static void sigill_handler(int signo, siginfo_t *si, void *data)
-{
-    /* Skip the faulty instruction */
-    ucontext_t *uc = (ucontext_t *)data;
-    uc->uc_mcontext.__gregs[REG_PC] += 4;
-
-    got_sigill = 1;
-}
-
-static void tcg_target_detect_isa(void)
-{
-#if !defined(have_zba) || !defined(have_zbb) || !defined(have_zicond)
-    /*
-     * TODO: It is expected that this will be determinable via
-     * linux riscv_hwprobe syscall, not yet merged.
-     * In the meantime, test via sigill.
-     */
-
-    struct sigaction sa_old, sa_new;
-
-    memset(&sa_new, 0, sizeof(sa_new));
-    sa_new.sa_flags = SA_SIGINFO;
-    sa_new.sa_sigaction = sigill_handler;
-    sigaction(SIGILL, &sa_new, &sa_old);
-
-#ifndef have_zba
-    /* Probe for Zba: add.uw zero,zero,zero. */
-    got_sigill = 0;
-    asm volatile(".insn r 0x3b, 0, 0x04, zero, zero, zero" : : : "memory");
-    have_zba = !got_sigill;
-#endif
-
-#ifndef have_zbb
-    /* Probe for Zba: andn zero,zero,zero. */
-    got_sigill = 0;
-    asm volatile(".insn r 0x33, 7, 0x20, zero, zero, zero" : : : "memory");
-    have_zbb = !got_sigill;
-#endif
-
-#ifndef have_zicond
-    /* Probe for Zicond: czero.eqz zero,zero,zero. */
-    got_sigill = 0;
-    asm volatile(".insn r 0x33, 5, 0x07, zero, zero, zero" : : : "memory");
-    have_zicond = !got_sigill;
-#endif
-
-    sigaction(SIGILL, &sa_old, NULL);
-#endif
-}
-
 static void tcg_target_init(TCGContext *s)
 {
-    tcg_target_detect_isa();
-
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffff;
 
diff --git a/util/meson.build b/util/meson.build
index 72b505df11..5d8bef9891 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -127,4 +127,6 @@ elif cpu == 'loongarch64'
   util_ss.add(files('cpuinfo-loongarch.c'))
 elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
+elif cpu in ['riscv32', 'riscv64']
+  util_ss.add(files('cpuinfo-riscv.c'))
 endif
-- 
2.34.1



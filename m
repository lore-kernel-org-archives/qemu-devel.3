Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51212E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPba-00073y-AV; Thu, 02 Jan 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-0006ye-LP
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-00058Z-Uq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso154704755ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841228; x=1736446028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fjhu5a60KgXd1qs6t5/USpPzCii5GgdmaO/dn0QHLh0=;
 b=hqki2LkhkSzqr01ntmso8WAcVZVXatVJSAqdamDviW1mr3zFPwWgXgsddAKrNCSCvV
 lHODDrozdPSZTcn7JCWpj/YPb/3jKaGvdQ2KHapjxPGfK2p2GzM+gyoi3Gh2Gmo/lj/E
 Lmof26IwOu/E2Fygq8DtPD5dab5rSpnqsMLf+l3N23VDUF7Tz5BaINlU4ffst8QgMZBh
 p4c8r3DNoX2aSz7abCcxxlOUFGJb0MQqwkEzjjFlobgQTTI3uy8AMLlo1nLvSUPlLbc3
 PIjRbnOV3VF830ZWZQXkXjfgFB4gLOutwOIKPmlHbjEhtL+O5lcwW/opHyhrO+ygnTff
 AH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841228; x=1736446028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fjhu5a60KgXd1qs6t5/USpPzCii5GgdmaO/dn0QHLh0=;
 b=W04b1sltNC30KAUvjZ2khLxbQ+w3Ls3yxOczXwOZmuBRcTsai9a5aeR1YCwfolxbIG
 4DzjzNLo/i/AXuuC/kGh3Wvaq+LNMWDXXJhjtuNJC8HfpgofTE5U1cr7hpdkdaUEPUc9
 FLUrx8DFprebBbDQVusPndt4/Pz2dOEiW7qs3SS5eNrcTzeWMr0U/38KKT2yVkSKWSqG
 Gqa8Kxh4B0NT6y0ciWOMZb+afMlYpKzFPcLdp+4lstZl8HU8+mV2DDyxuYr9SKUGJUUE
 17681VOHcxmtUfTbXpx2lfI2r9D2PjDlW11QbYQQk1tjACvqrPKilVWyzmWK7ltslDnb
 pe2w==
X-Gm-Message-State: AOJu0Yyu8LmASzXPp6bWBh9qs5OD9w+PzTaHBG22S692UghesFAxBCHp
 PMBs75bse+R8ZigLPTa2Kw40+UDVwe73RuPE0y0IaSL8pZ/wiGYFmLNzHZUSOM0IIVVtk+BnaWg
 n
X-Gm-Gg: ASbGncsG7g2Z+rnaNx5dqMEaZ2rcDNHchmq2t026i6NuHAgc8nMVIOG2aJxUqO3GldK
 dNkeRwCTJKTr3pLidKVE7Y7b6aUM2JmOrfKHYf84jskA6cXxiutSBP374XM07AtQ/dpoGVvMbYu
 bC2amcIlJcWTuz55UWR4RFyA2ZRYSf7Gywe1kXwfRvCjJ7vXFVjExbb7x6lDT2ZI/C5x6U5Egtq
 NFJu3rrjYEqA5g1sQfbWRPT19Ta66jhYi7IFQ/mSx4TniuQo4RjQeU+jTIeTA==
X-Google-Smtp-Source: AGHT+IFvep///2p9CCRhyPNIZMABKLK9IjjCQEzpLxUiUlbK+UDx1n5nGcqYuvpzKk80UXLI7wlJcg==
X-Received: by 2002:a05:6a21:3189:b0:1e0:d632:b9e0 with SMTP id
 adf61e73a8af0-1e5e046fab8mr77311725637.13.1735841227527; 
 Thu, 02 Jan 2025 10:07:07 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/73] tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
 TCG_TARGET_NEED_POOL_LABELS
Date: Thu,  2 Jan 2025 10:05:55 -0800
Message-ID: <20250102180654.1420056-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Make these features unconditional, as they're used by most
tcg backends anyway.  Merge tcg-ldst.c.inc and tcg-pool.c.inc
into tcg.c and mark some of the functions unused, so that
when the features are not used we won't get Werrors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h                |   4 -
 tcg/aarch64/tcg-target.h         |   2 -
 tcg/arm/tcg-target.h             |   2 -
 tcg/i386/tcg-target.h            |   2 -
 tcg/loongarch64/tcg-target.h     |   2 -
 tcg/mips/tcg-target.h            |   2 -
 tcg/ppc/tcg-target.h             |   2 -
 tcg/riscv/tcg-target.h           |   3 -
 tcg/s390x/tcg-target.h           |   2 -
 tcg/sparc64/tcg-target.h         |   2 -
 tcg/tcg.c                        | 211 +++++++++++++++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     |   2 -
 tcg/arm/tcg-target.c.inc         |   2 -
 tcg/i386/tcg-target.c.inc        |   3 -
 tcg/loongarch64/tcg-target.c.inc |   9 +-
 tcg/mips/tcg-target.c.inc        |   3 -
 tcg/ppc/tcg-target.c.inc         |   2 -
 tcg/riscv/tcg-target.c.inc       |   3 -
 tcg/s390x/tcg-target.c.inc       |   2 -
 tcg/sparc64/tcg-target.c.inc     |   3 -
 tcg/tcg-ldst.c.inc               |  65 ----------
 tcg/tcg-pool.c.inc               | 162 ------------------------
 tcg/tci/tcg-target.c.inc         |  12 +-
 23 files changed, 216 insertions(+), 286 deletions(-)
 delete mode 100644 tcg/tcg-ldst.c.inc
 delete mode 100644 tcg/tcg-pool.c.inc

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a27b8d77e9..01605f30c7 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -494,12 +494,8 @@ struct TCGContext {
     CPUState *cpu;                      /* *_trans */
 
     /* These structures are private to tcg-target.c.inc.  */
-#ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_HEAD(, TCGLabelQemuLdst) ldst_labels;
-#endif
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
-#endif
 
     TCGLabel *exitreq_label;
 
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index cb24c0d276..d8ca52d32d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -157,7 +157,5 @@ typedef enum {
 #define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 8abf15aef4..7f6e24f861 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -145,7 +145,5 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index c81d509f1c..9961d8e757 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -227,7 +227,5 @@ typedef enum {
 #include "tcg/tcg-mo.h"
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 7811530c8a..3bc9aafaf2 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -189,6 +189,4 @@ typedef enum {
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-#define TCG_TARGET_NEED_LDST_LABELS
-
 #endif /* LOONGARCH_TCG_TARGET_H */
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index d9b9f6a965..db60eb7c1b 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -183,7 +183,5 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_tst              0
 
 #define TCG_TARGET_DEFAULT_MO           0
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 0b2171d38c..8291e0127d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -176,7 +176,5 @@ typedef enum {
 #define TCG_TARGET_HAS_tst_vec          0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index d23306738a..bfaa99ccdd 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -161,7 +161,4 @@ typedef enum {
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
-
 #endif
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 7e0bf687b9..223d3f6ca1 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -166,7 +166,5 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_tst_vec        0
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 0705308951..b560d43ed5 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -143,7 +143,5 @@ extern bool use_vis3_instructions;
 #define TCG_AREG0 TCG_REG_I0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_NEED_LDST_LABELS
-#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 657534c6a9..38c3c03591 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -75,6 +75,11 @@ static void tcg_target_init(TCGContext *s);
 static void tcg_target_qemu_prologue(TCGContext *s);
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend);
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
+
+typedef struct TCGLabelQemuLdst TCGLabelQemuLdst;
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
 
 /* The CIE and FDE header definitions will be common to all hosts.  */
 typedef struct {
@@ -99,7 +104,7 @@ typedef struct QEMU_PACKED {
     DebugFrameFDEHeader fde;
 } DebugFrameHeader;
 
-typedef struct TCGLabelQemuLdst {
+struct TCGLabelQemuLdst {
     bool is_ld;             /* qemu_ld: true, qemu_st: false */
     MemOpIdx oi;
     TCGType type;           /* result type of a load */
@@ -110,7 +115,7 @@ typedef struct TCGLabelQemuLdst {
     const tcg_insn_unit *raddr;   /* addr of the next IR of qemu_ld/st IR */
     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
     QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
-} TCGLabelQemuLdst;
+};
 
 static void tcg_register_jit_int(const void *buf, size_t size,
                                  const void *debug_frame,
@@ -184,9 +189,6 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece);
-#ifdef TCG_TARGET_NEED_LDST_LABELS
-static int tcg_out_ldst_finalize(TCGContext *s);
-#endif
 
 #ifndef CONFIG_USER_ONLY
 #define guest_base  ({ qemu_build_not_reached(); (uintptr_t)0; })
@@ -643,6 +645,197 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
     }
 }
 
+/*
+ * Allocate a new TCGLabelQemuLdst entry.
+ */
+
+__attribute__((unused))
+static TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
+{
+    TCGLabelQemuLdst *l = tcg_malloc(sizeof(*l));
+
+    memset(l, 0, sizeof(*l));
+    QSIMPLEQ_INSERT_TAIL(&s->ldst_labels, l, next);
+
+    return l;
+}
+
+/*
+ * Allocate new constant pool entries.
+ */
+
+typedef struct TCGLabelPoolData {
+    struct TCGLabelPoolData *next;
+    tcg_insn_unit *label;
+    intptr_t addend;
+    int rtype;
+    unsigned nlong;
+    tcg_target_ulong data[];
+} TCGLabelPoolData;
+
+static TCGLabelPoolData *new_pool_alloc(TCGContext *s, int nlong, int rtype,
+                                        tcg_insn_unit *label, intptr_t addend)
+{
+    TCGLabelPoolData *n = tcg_malloc(sizeof(TCGLabelPoolData)
+                                     + sizeof(tcg_target_ulong) * nlong);
+
+    n->label = label;
+    n->addend = addend;
+    n->rtype = rtype;
+    n->nlong = nlong;
+    return n;
+}
+
+static void new_pool_insert(TCGContext *s, TCGLabelPoolData *n)
+{
+    TCGLabelPoolData *i, **pp;
+    int nlong = n->nlong;
+
+    /* Insertion sort on the pool.  */
+    for (pp = &s->pool_labels; (i = *pp) != NULL; pp = &i->next) {
+        if (nlong > i->nlong) {
+            break;
+        }
+        if (nlong < i->nlong) {
+            continue;
+        }
+        if (memcmp(n->data, i->data, sizeof(tcg_target_ulong) * nlong) >= 0) {
+            break;
+        }
+    }
+    n->next = *pp;
+    *pp = n;
+}
+
+/* The "usual" for generic integer code.  */
+__attribute__((unused))
+static void new_pool_label(TCGContext *s, tcg_target_ulong d, int rtype,
+                           tcg_insn_unit *label, intptr_t addend)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 1, rtype, label, addend);
+    n->data[0] = d;
+    new_pool_insert(s, n);
+}
+
+/* For v64 or v128, depending on the host.  */
+__attribute__((unused))
+static void new_pool_l2(TCGContext *s, int rtype, tcg_insn_unit *label,
+                        intptr_t addend, tcg_target_ulong d0,
+                        tcg_target_ulong d1)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 2, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    new_pool_insert(s, n);
+}
+
+/* For v128 or v256, depending on the host.  */
+__attribute__((unused))
+static void new_pool_l4(TCGContext *s, int rtype, tcg_insn_unit *label,
+                        intptr_t addend, tcg_target_ulong d0,
+                        tcg_target_ulong d1, tcg_target_ulong d2,
+                        tcg_target_ulong d3)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 4, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    n->data[2] = d2;
+    n->data[3] = d3;
+    new_pool_insert(s, n);
+}
+
+/* For v256, for 32-bit host.  */
+__attribute__((unused))
+static void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
+                        intptr_t addend, tcg_target_ulong d0,
+                        tcg_target_ulong d1, tcg_target_ulong d2,
+                        tcg_target_ulong d3, tcg_target_ulong d4,
+                        tcg_target_ulong d5, tcg_target_ulong d6,
+                        tcg_target_ulong d7)
+{
+    TCGLabelPoolData *n = new_pool_alloc(s, 8, rtype, label, addend);
+    n->data[0] = d0;
+    n->data[1] = d1;
+    n->data[2] = d2;
+    n->data[3] = d3;
+    n->data[4] = d4;
+    n->data[5] = d5;
+    n->data[6] = d6;
+    n->data[7] = d7;
+    new_pool_insert(s, n);
+}
+
+/*
+ * Generate TB finalization at the end of block
+ */
+
+static int tcg_out_ldst_finalize(TCGContext *s)
+{
+    TCGLabelQemuLdst *lb;
+
+    /* qemu_ld/st slow paths */
+    QSIMPLEQ_FOREACH(lb, &s->ldst_labels, next) {
+        if (lb->is_ld
+            ? !tcg_out_qemu_ld_slow_path(s, lb)
+            : !tcg_out_qemu_st_slow_path(s, lb)) {
+            return -2;
+        }
+
+        /*
+         * Test for (pending) buffer overflow.  The assumption is that any
+         * one operation beginning below the high water mark cannot overrun
+         * the buffer completely.  Thus we can test for overflow after
+         * generating code without having to check during generation.
+         */
+        if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
+            return -1;
+        }
+    }
+    return 0;
+}
+
+static int tcg_out_pool_finalize(TCGContext *s)
+{
+    TCGLabelPoolData *p = s->pool_labels;
+    TCGLabelPoolData *l = NULL;
+    void *a;
+
+    if (p == NULL) {
+        return 0;
+    }
+
+    /*
+     * ??? Round up to qemu_icache_linesize, but then do not round
+     * again when allocating the next TranslationBlock structure.
+     */
+    a = (void *)ROUND_UP((uintptr_t)s->code_ptr,
+                         sizeof(tcg_target_ulong) * p->nlong);
+    tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
+    s->data_gen_ptr = a;
+
+    for (; p != NULL; p = p->next) {
+        size_t size = sizeof(tcg_target_ulong) * p->nlong;
+        uintptr_t value;
+
+        if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
+            if (unlikely(a > s->code_gen_highwater)) {
+                return -1;
+            }
+            memcpy(a, p->data, size);
+            a += size;
+            l = p;
+        }
+
+        value = (uintptr_t)tcg_splitwx_to_rx(a) - size;
+        if (!patch_reloc(p->label, p->rtype, value, p->addend)) {
+            return -2;
+        }
+    }
+
+    s->code_ptr = a;
+    return 0;
+}
+
 #define C_PFX1(P, A)                    P##A
 #define C_PFX2(P, A, B)                 P##A##_##B
 #define C_PFX3(P, A, B, C)              P##A##_##B##_##C
@@ -6221,12 +6414,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->code_ptr = s->code_buf;
     s->data_gen_ptr = NULL;
 
-#ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_INIT(&s->ldst_labels);
-#endif
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     s->pool_labels = NULL;
-#endif
 
     start_words = s->insn_start_words;
     s->gen_insn_data =
@@ -6306,18 +6495,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     s->gen_insn_end_off[num_insns] = tcg_current_code_size(s);
 
     /* Generate TB finalization at the end of block */
-#ifdef TCG_TARGET_NEED_LDST_LABELS
     i = tcg_out_ldst_finalize(s);
     if (i < 0) {
         return i;
     }
-#endif
-#ifdef TCG_TARGET_NEED_POOL_LABELS
     i = tcg_out_pool_finalize(s);
     if (i < 0) {
         return i;
     }
-#endif
     if (!tcg_resolve_relocs(s)) {
         return -2;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0b018d3247..d77d305f30 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -10,8 +10,6 @@
  * See the COPYING file in the top-level directory for details.
  */
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
 #include "qemu/bitops.h"
 
 /* Used for function call generation. */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index f0674f23a5..90ac80077f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -23,8 +23,6 @@
  */
 
 #include "elf.h"
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
 
 int arm_arch = __ARM_ARCH;
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index aaf6107284..167228a781 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -22,9 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
-
 /* Used for function call generation. */
 #define TCG_TARGET_STACK_ALIGN 16
 #if defined(_WIN64)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 8ae561bfc0..a273e7fce5 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -29,7 +29,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-ldst.c.inc"
 #include <asm/hwcap.h>
 
 /* used for function call generation */
@@ -2465,6 +2464,14 @@ static void tcg_out_tb_start(TCGContext *s)
     /* nothing to do */
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    for (int i = 0; i < count; ++i) {
+        /* Canonical nop is andi r0,r0,0 */
+        p[i] = OPC_ANDI;
+    }
+}
+
 static void tcg_target_init(TCGContext *s)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ed41cd7f1b..8857398893 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -24,9 +24,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
-
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
 #if _MIPS_SIM == _ABIO32
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9a11c26fd3..94997b126f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -23,8 +23,6 @@
  */
 
 #include "elf.h"
-#include "../tcg-pool.c.inc"
-#include "../tcg-ldst.c.inc"
 
 /*
  * Standardize on the _CALL_FOO symbols used by GCC:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 34402fee2a..7d1bba100a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -27,9 +27,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
-
 /* Used for function call generation. */
 #define TCG_REG_CALL_STACK              TCG_REG_SP
 #define TCG_TARGET_STACK_ALIGN          16
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index b1188525b2..fdf57c0b07 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -24,8 +24,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
 #include "elf.h"
 
 /* Used for function call generation. */
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index c9d105c35a..fe3e727399 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -27,9 +27,6 @@
 #error "unsupported code generation mode"
 #endif
 
-#include "../tcg-ldst.c.inc"
-#include "../tcg-pool.c.inc"
-
 /* Used for function call generation. */
 #define TCG_REG_CALL_STACK              TCG_REG_O6
 #define TCG_TARGET_STACK_BIAS           2047
diff --git a/tcg/tcg-ldst.c.inc b/tcg/tcg-ldst.c.inc
deleted file mode 100644
index ffada04af0..0000000000
--- a/tcg/tcg-ldst.c.inc
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * TCG Backend Data: load-store optimization only.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-/*
- * Generate TB finalization at the end of block
- */
-
-static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
-static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l);
-
-static int tcg_out_ldst_finalize(TCGContext *s)
-{
-    TCGLabelQemuLdst *lb;
-
-    /* qemu_ld/st slow paths */
-    QSIMPLEQ_FOREACH(lb, &s->ldst_labels, next) {
-        if (lb->is_ld
-            ? !tcg_out_qemu_ld_slow_path(s, lb)
-            : !tcg_out_qemu_st_slow_path(s, lb)) {
-            return -2;
-        }
-
-        /* Test for (pending) buffer overflow.  The assumption is that any
-           one operation beginning below the high water mark cannot overrun
-           the buffer completely.  Thus we can test for overflow after
-           generating code without having to check during generation.  */
-        if (unlikely((void *)s->code_ptr > s->code_gen_highwater)) {
-            return -1;
-        }
-    }
-    return 0;
-}
-
-/*
- * Allocate a new TCGLabelQemuLdst entry.
- */
-
-static inline TCGLabelQemuLdst *new_ldst_label(TCGContext *s)
-{
-    TCGLabelQemuLdst *l = tcg_malloc(sizeof(*l));
-
-    memset(l, 0, sizeof(*l));
-    QSIMPLEQ_INSERT_TAIL(&s->ldst_labels, l, next);
-
-    return l;
-}
diff --git a/tcg/tcg-pool.c.inc b/tcg/tcg-pool.c.inc
deleted file mode 100644
index 90c2e63b7f..0000000000
--- a/tcg/tcg-pool.c.inc
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * TCG Backend Data: constant pool.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-typedef struct TCGLabelPoolData {
-    struct TCGLabelPoolData *next;
-    tcg_insn_unit *label;
-    intptr_t addend;
-    int rtype;
-    unsigned nlong;
-    tcg_target_ulong data[];
-} TCGLabelPoolData;
-
-
-static TCGLabelPoolData *new_pool_alloc(TCGContext *s, int nlong, int rtype,
-                                        tcg_insn_unit *label, intptr_t addend)
-{
-    TCGLabelPoolData *n = tcg_malloc(sizeof(TCGLabelPoolData)
-                                     + sizeof(tcg_target_ulong) * nlong);
-
-    n->label = label;
-    n->addend = addend;
-    n->rtype = rtype;
-    n->nlong = nlong;
-    return n;
-}
-
-static void new_pool_insert(TCGContext *s, TCGLabelPoolData *n)
-{
-    TCGLabelPoolData *i, **pp;
-    int nlong = n->nlong;
-
-    /* Insertion sort on the pool.  */
-    for (pp = &s->pool_labels; (i = *pp) != NULL; pp = &i->next) {
-        if (nlong > i->nlong) {
-            break;
-        }
-        if (nlong < i->nlong) {
-            continue;
-        }
-        if (memcmp(n->data, i->data, sizeof(tcg_target_ulong) * nlong) >= 0) {
-            break;
-        }
-    }
-    n->next = *pp;
-    *pp = n;
-}
-
-/* The "usual" for generic integer code.  */
-static inline void new_pool_label(TCGContext *s, tcg_target_ulong d, int rtype,
-                                  tcg_insn_unit *label, intptr_t addend)
-{
-    TCGLabelPoolData *n = new_pool_alloc(s, 1, rtype, label, addend);
-    n->data[0] = d;
-    new_pool_insert(s, n);
-}
-
-/* For v64 or v128, depending on the host.  */
-static inline void new_pool_l2(TCGContext *s, int rtype, tcg_insn_unit *label,
-                               intptr_t addend, tcg_target_ulong d0,
-                               tcg_target_ulong d1)
-{
-    TCGLabelPoolData *n = new_pool_alloc(s, 2, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    new_pool_insert(s, n);
-}
-
-/* For v128 or v256, depending on the host.  */
-static inline void new_pool_l4(TCGContext *s, int rtype, tcg_insn_unit *label,
-                               intptr_t addend, tcg_target_ulong d0,
-                               tcg_target_ulong d1, tcg_target_ulong d2,
-                               tcg_target_ulong d3)
-{
-    TCGLabelPoolData *n = new_pool_alloc(s, 4, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    n->data[2] = d2;
-    n->data[3] = d3;
-    new_pool_insert(s, n);
-}
-
-/* For v256, for 32-bit host.  */
-static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
-                               intptr_t addend, tcg_target_ulong d0,
-                               tcg_target_ulong d1, tcg_target_ulong d2,
-                               tcg_target_ulong d3, tcg_target_ulong d4,
-                               tcg_target_ulong d5, tcg_target_ulong d6,
-                               tcg_target_ulong d7)
-{
-    TCGLabelPoolData *n = new_pool_alloc(s, 8, rtype, label, addend);
-    n->data[0] = d0;
-    n->data[1] = d1;
-    n->data[2] = d2;
-    n->data[3] = d3;
-    n->data[4] = d4;
-    n->data[5] = d5;
-    n->data[6] = d6;
-    n->data[7] = d7;
-    new_pool_insert(s, n);
-}
-
-/* To be provided by cpu/tcg-target.c.inc.  */
-static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
-
-static int tcg_out_pool_finalize(TCGContext *s)
-{
-    TCGLabelPoolData *p = s->pool_labels;
-    TCGLabelPoolData *l = NULL;
-    void *a;
-
-    if (p == NULL) {
-        return 0;
-    }
-
-    /* ??? Round up to qemu_icache_linesize, but then do not round
-       again when allocating the next TranslationBlock structure.  */
-    a = (void *)ROUND_UP((uintptr_t)s->code_ptr,
-                         sizeof(tcg_target_ulong) * p->nlong);
-    tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
-    s->data_gen_ptr = a;
-
-    for (; p != NULL; p = p->next) {
-        size_t size = sizeof(tcg_target_ulong) * p->nlong;
-        uintptr_t value;
-
-        if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
-            if (unlikely(a > s->code_gen_highwater)) {
-                return -1;
-            }
-            memcpy(a, p->data, size);
-            a += size;
-            l = p;
-        }
-
-        value = (uintptr_t)tcg_splitwx_to_rx(a) - size;
-        if (!patch_reloc(p->label, p->rtype, value, p->addend)) {
-            return -2;
-        }
-    }
-
-    s->code_ptr = a;
-    return 0;
-}
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e6c97e8153..5f88ca0537 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -22,8 +22,6 @@
  * THE SOFTWARE.
  */
 
-#include "../tcg-pool.c.inc"
-
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_STACK_ALIGN          8
@@ -979,3 +977,13 @@ bool tcg_target_has_memory_bswap(MemOp memop)
 {
     return true;
 }
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
-- 
2.43.0



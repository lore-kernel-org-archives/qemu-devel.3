Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F7E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XK-0000QF-Bm; Tue, 07 Jan 2025 03:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wr-0000Er-Mq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wo-0002ux-G6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:33 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216728b1836so201995245ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236889; x=1736841689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7UCZ2crHp+vU7e52+rgzcG+SiffvmY7gMAciNIacag=;
 b=JbP2Kak1YF7BrUFgI701vDfz6YmnP8WWvf3kZw20Xz/tMyK4cqVmgy6tC8fUO4Bc5x
 MkXSwNjY3uYvFJcEurCRhcskLDntx/736BCfJWDFav+G2PTMO0s4HJ3H25Q416E5Dtz9
 PlfiV5m0cWkiP6pmIWn5m8v1hYw+20gp5yucBf9TDQ7XGF2+rAXhHyYMM1rhaboW/0oH
 VApxhAyG5Tfrq9LHL8LN8pk+6IuIebRCVPQGY2TssYGMjorfMJur5WrE3+8O2/2AX56s
 l1AAhdjue9F3R5LyVJ4npK+rkRT0iYZ0DZtOf4c42wnYnqecUlAESp95DRGXAB+xkhGM
 5l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236889; x=1736841689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7UCZ2crHp+vU7e52+rgzcG+SiffvmY7gMAciNIacag=;
 b=imgPNjzFTExjATYOdsmShqneNwFwiX0jssIu1gtrA2Iepmnf49uj9qQwhfQ6eN7cGL
 3+mrfFrbyl12nBQgdryWzlEg8kAPkUMNRORggz4n+uoeghTHgrElMCc0xbil2Dl5pbE1
 oWzF+k/gNGfdXElRr3MPNH5NxTYEO5USlYVMHZSWJGWVXGJPEbNVAHvRVJNudU8RlSdP
 ApXKbut2XYYX9EQhBm1XGp6hMLIc/le7Y2QVJk6//2lp3wTnEDlROsp8MzVM5iV5nktB
 qco9rdWoaXyc/MMVOsQmecHFjEEyunKYsTp897199atIaOFLF/ttq99ExUIxi3SLB8Pr
 nvnQ==
X-Gm-Message-State: AOJu0YxibZihuHBL0wYMMphq1aQPsa1vX6n3wx+yLEP/q8oi+pVHmB3o
 /imqm1UI/6tgdsb9iqS7V3S0sjnKvxDXTLI0JRXU5VoEQapOKUYZruHIaG04KivJdcRYUB1h/ab
 j
X-Gm-Gg: ASbGnctEwBXyC84Ab00mv9/3IrDZS7hlmtvQ+axPCFm+MgisWhci0FAsCzLVSaJvfmS
 B34w1wpQvNhEJxo7TBpRgftR9Xj4KKsUDfkDRxXyFsnmhNiM5wDdoY1whr5WVIh9K9YAOeLKZ23
 aGSIK4JY5WAsQdIPDknTXHlHZcaUveoTWtCFp6UoG6qtjTfK6QCqL/0tMuo46T1zMu0+dcmZbfw
 bWWTsfpskuD9Z/VC/q8w+Nziyrb/NyUkUfGd+s/RYFHJkngDOaelsKlH34CAs58lz0McVOhRqr1
 HDdf6k7N68M15Kcx3Q==
X-Google-Smtp-Source: AGHT+IHj8UCZOQ3KwGycAyDV4QcdJj5rKshd28nhVIGVGkYzh/gsX5f+JG+fDvO4VQVCCkzcanJJ8w==
X-Received: by 2002:a17:902:e84d:b0:215:7ce4:57bc with SMTP id
 d9443c01a7336-219e6ea2386mr789606375ad.16.1736236889079; 
 Tue, 07 Jan 2025 00:01:29 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 14/81] tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
 TCG_TARGET_NEED_POOL_LABELS
Date: Tue,  7 Jan 2025 00:00:05 -0800
Message-ID: <20250107080112.1175095-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 3a80dc2053..041c4aa455 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -498,12 +498,8 @@ struct TCGContext {
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
index 6b318873ca..7f5d014973 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -66,6 +66,11 @@ static void tcg_target_init(TCGContext *s);
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
@@ -90,7 +95,7 @@ typedef struct QEMU_PACKED {
     DebugFrameFDEHeader fde;
 } DebugFrameHeader;
 
-typedef struct TCGLabelQemuLdst {
+struct TCGLabelQemuLdst {
     bool is_ld;             /* qemu_ld: true, qemu_st: false */
     MemOpIdx oi;
     TCGType type;           /* result type of a load */
@@ -101,7 +106,7 @@ typedef struct TCGLabelQemuLdst {
     const tcg_insn_unit *raddr;   /* addr of the next IR of qemu_ld/st IR */
     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
     QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
-} TCGLabelQemuLdst;
+};
 
 static void tcg_register_jit_int(const void *buf, size_t size,
                                  const void *debug_frame,
@@ -175,9 +180,6 @@ static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece);
-#ifdef TCG_TARGET_NEED_LDST_LABELS
-static int tcg_out_ldst_finalize(TCGContext *s);
-#endif
 
 #ifndef CONFIG_USER_ONLY
 #define guest_base  ({ qemu_build_not_reached(); (uintptr_t)0; })
@@ -634,6 +636,197 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
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
@@ -6204,12 +6397,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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
@@ -6290,18 +6479,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
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



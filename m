Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A294C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFj-0004CO-Tg; Sun, 04 Feb 2024 16:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFh-0003wO-4X
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFe-0003cg-Sn
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d93f2c3701so18201145ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082929; x=1707687729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+fCUcqxhvgu1RQeAIaBsUghOSepyBvOWmxuutmNswA=;
 b=jG4xeeXtwgjkap8i0kA7nbbV6NOQeQwCwiT5JmTvSSh828vQqlyzPBgOTAkfWpKTv/
 VfuoS3lzRCIXuAtDjy7tyyHED9mYdLwMg4AXhIB1eIwDpR8b5w/+LYHpp7gTt0q3NAJq
 iEYkJkAqiYo6Z8dwa5kfIJRmNS9Q5BbKXmKenPnqVgDXGUEV5de9BGAi39MNd79NwtuM
 kX2+/fZx9t7xZI8hpHh+BBYIKX3PjPeNyl+p8SP8ME2UfEcZOvSTf5E23nP6s9fGACPz
 xStjw1l+pq0uUZ2Dt/+t6WqWpRi9BVzVK8q+Rqu+OKyUqJtPO2ZM9wcoqkwXYRmApCJS
 +SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082929; x=1707687729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+fCUcqxhvgu1RQeAIaBsUghOSepyBvOWmxuutmNswA=;
 b=clnIVq+G62Uu57V2uTM4/32jQQQt68xO81GZR0FWjEmKc5ZVbObi8eo+yCSACyUg+K
 RlLzZvUuBdt9yGD6sKJepcM4Fra+m4v4dzjpgeYXIHLaHKuuWwp8IxpYknkqmBZENAmW
 a2oCHSugxrfpowoaEj0oL17ZzvJcdygmmxeptE3oJZWpsdjRR6uKZVZwg2FC+S/WUpcj
 CWprH4FHtVm5zfNq4mhLrbrJolPuIaRkv/5+Y19k9hOLiu8fToc4mwn/0WlOmsIjtZgB
 mjTS9BC1TE3+x/CsmV1Ryi8J1PEYy+HRn/hG83WBjwUsPnswjtWrIz7eVyxDOVO/uJ70
 QM1A==
X-Gm-Message-State: AOJu0Yz0CO5nr356WlfkZ5bqPdrmm4taUrS23RTaVIX1EwOqhfHKsJ4T
 V8l6h6XnHzwTsArf/IDUKMgKggvk6ptA0DXdMbDnk6z/YuKrAYx82JELBRj+NOtaW5EniFyW25j
 /a9A=
X-Google-Smtp-Source: AGHT+IEtNG0dAc4HbC3T7Alu33mk61FZiKeFg53ikQPVKLt61llJ3w3oBIaJf33gb4aMJ2a4QggwOw==
X-Received: by 2002:a17:902:c94b:b0:1d9:8e37:56d6 with SMTP id
 i11-20020a170902c94b00b001d98e3756d6mr4077106pla.40.1707082929563; 
 Sun, 04 Feb 2024 13:42:09 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/39] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:48 +1000
Message-Id: <20240204214052.5639-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |   2 +-
 tcg/ppc/tcg-target.c.inc | 122 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 60ce49e672..04a7aba4d3 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -143,7 +143,7 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /*
  * While technically Altivec could support V64, it has no 64-bit store
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 535ef2cbe7..7f3829beeb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -283,11 +283,15 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool mask_operand(uint32_t c, int *mb, int *me);
+static bool mask64_operand(uint64_t c, int *mb, int *me);
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t sval, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
     uint64_t uval = sval;
+    int mb, me;
 
     if (ct & TCG_CT_CONST) {
         return 1;
@@ -316,6 +320,17 @@ static bool tcg_target_const_match(int64_t sval, int ct,
         case TCG_COND_GTU:
             ct |= TCG_CT_CONST_U16;
             break;
+        case TCG_COND_TSTEQ:
+        case TCG_COND_TSTNE:
+            if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
+                return 1;
+            }
+            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
+                ? mask_operand(uval, &mb, &me)
+                : mask64_operand(uval << clz64(uval), &mb, &me)) {
+                return 1;
+            }
+            return 0;
         default:
             g_assert_not_reached();
         }
@@ -703,9 +718,11 @@ enum {
     CR_SO
 };
 
-static const uint32_t tcg_to_bc[] = {
+static const uint32_t tcg_to_bc[16] = {
     [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
     [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_TSTEQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_TSTNE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
     [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
     [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
     [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
@@ -717,9 +734,11 @@ static const uint32_t tcg_to_bc[] = {
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
-static const uint32_t tcg_to_isel[] = {
+static const uint32_t tcg_to_isel[16] = {
     [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
     [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_TSTEQ] = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_TSTNE] = ISEL | BC_(0, CR_EQ) | 1,
     [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
     [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
     [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
@@ -872,19 +891,31 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
-static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-                               int sh, int mb)
+static void tcg_out_rld_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                           int sh, int mb, bool rc)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     sh = SH(sh & 0x1f) | (((sh >> 5) & 1) << 1);
     mb = MB64((mb >> 5) | ((mb << 1) & 0x3f));
-    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb);
+    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb | rc);
 }
 
-static inline void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-                               int sh, int mb, int me)
+static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                        int sh, int mb)
 {
-    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me));
+    tcg_out_rld_rc(s, op, ra, rs, sh, mb, false);
+}
+
+static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                           int sh, int mb, int me, bool rc)
+{
+    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me) | rc);
+}
+
+static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                        int sh, int mb, int me)
+{
+    tcg_out_rlw_rc(s, op, ra, rs, sh, mb, me, false);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
@@ -1702,6 +1733,50 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+/*
+ * Set dest non-zero if and only if (arg1 & arg2) is non-zero.
+ * If RC, then also set RC0.
+ */
+static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
+                         bool const_arg2, TCGType type, bool rc)
+{
+    int mb, me;
+
+    if (!const_arg2) {
+        tcg_out32(s, AND | SAB(arg1, dest, arg2) | rc);
+        return;
+    }
+
+    if (type == TCG_TYPE_I32) {
+        arg2 = (uint32_t)arg2;
+    } else if (arg2 == (uint32_t)arg2) {
+        type = TCG_TYPE_I32;
+    }
+
+    if ((arg2 & ~0xffff) == 0) {
+        tcg_out32(s, ANDI | SAI(arg1, dest, arg2));
+        return;
+    }
+    if ((arg2 & ~0xffff0000ull) == 0) {
+        tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
+        if (mask_operand(arg2, &mb, &me)) {
+            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
+            return;
+        }
+    } else {
+        int sh = clz64(arg2);
+        if (mask64_operand(arg2 << sh, &mb, &me)) {
+            tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
+            return;
+        }
+    }
+    /* Constraints should satisfy this. */
+    g_assert_not_reached();
+}
+
 static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
                         int const_arg2, int cr, TCGType type)
 {
@@ -1736,6 +1811,12 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
         imm = 0;
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_debug_assert(cr == 0);
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, true);
+        return;
+
     case TCG_COND_LT:
     case TCG_COND_GE:
     case TCG_COND_LE:
@@ -1946,6 +2027,16 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         tcg_out_setcond_ne0(s, type, arg0, arg1, neg);
         break;
 
+    case TCG_COND_TSTEQ:
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, false);
+        tcg_out_setcond_eq0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
+    case TCG_COND_TSTNE:
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, false);
+        tcg_out_setcond_ne0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
     case TCG_COND_LE:
     case TCG_COND_LEU:
         inv = true;
@@ -2118,6 +2209,21 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (blconst) {
+            tcg_out_andi32(s, TCG_REG_R0, al, bl);
+        } else {
+            tcg_out32(s, AND | SAB(al, TCG_REG_R0, bl));
+        }
+        if (bhconst) {
+            tcg_out_andi32(s, TCG_REG_TMP1, ah, bh);
+        } else {
+            tcg_out32(s, AND | SAB(ah, TCG_REG_TMP1, bh));
+        }
+        tcg_out32(s, OR | SAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_TMP1) | 1);
+        break;
+
     case TCG_COND_LT:
     case TCG_COND_LE:
     case TCG_COND_GT:
-- 
2.34.1



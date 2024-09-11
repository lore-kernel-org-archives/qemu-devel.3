Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662ACEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYw-0003jZ-3A; Wed, 11 Sep 2024 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYe-0002ik-6X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:09 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYc-0003hC-92
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:07 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so57351a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073465; x=1726678265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSoJkCohCcuhNpwRCeBuz1dXYbMOq4iwACHfjeEE008=;
 b=X75XoWWYv88jEgYgadMb82WxpSoa0+NOONq6niD1vUimGFuxWomF6yce8wyJgFSY2T
 jezoYrTj/z3xMrBU87RdEb+NjHFIyZH7iUmdh12j/9LvGBi7L1CXB29jSWiQsxo4tv3a
 qOEMceLktnKJg8xWwKV+8UrK+b9tzLPYuMw/pDOWmuBrK54HkMuQtF2nxibcxBh7dsrD
 d6wocaUMTObDCx0nzpIDBaT8+YLCw3xWy0pQmCj9hck3yQYI8bW/wUR5XdT7Lcs5FpPO
 +W8vmyfLJLgSfi5SGqssDTxL4/iEGbNsd1FdiF4DfRhTfT5Wo315TDu9i3qlRaEmpb8k
 TbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073465; x=1726678265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSoJkCohCcuhNpwRCeBuz1dXYbMOq4iwACHfjeEE008=;
 b=GcDcjKt6LsaI0j3Bkv/uwIOsEfvTM25L0/yTdrArjeZkcNKbBChPgK1htTM/+0Nppj
 4UfZtFld/5huRuEZuNx6ylcgyoAY1A36Y3ohjbhtaoA9aE1EhXV36jcYZkDv/XkHfBpN
 /GrdyekDP95/VdskEaPwyjdLPu+AjxWI7v0lFNMzG6xLmAjo9g6RW5rKywSm41d7wY4W
 5IeyQWKwqEhUcfqN/zQEvTHzWY+nCXqVxRCKb7FmxxBvrmCjROknpQIZMQaVgNCrrDVQ
 CPrEUOuwFtkabkRrh2jj3DPEun2PruhQmbNyahBRZ1SNFomiq9GLwnkV10HXyG+AK7Fy
 0Osw==
X-Gm-Message-State: AOJu0YwjjhImpKdR7AauhJif04UKJbWV4+adSCNFOSAcIR0nbGzs/zGg
 u96wOjf5GUIXPvAXPpeeeOvMHFfeecelzyq7j5eS/ivcOJG/fk+kum4/ixB2S2dFtfwhvezCgEQ
 /
X-Google-Smtp-Source: AGHT+IFgmBX3Ndj1zySBA2n14pW77dWcU+KATd1FNACR29kzN9MvH3/pssIJxNyNJDpcuHu4x4EOrw==
X-Received: by 2002:a05:6a21:58d:b0:1cf:2aa3:1f94 with SMTP id
 adf61e73a8af0-1cf5e0f80c3mr6937155637.22.1726073464862; 
 Wed, 11 Sep 2024 09:51:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 17/18] tcg/s390x: Implement cmpsel_vec
Date: Wed, 11 Sep 2024 09:50:46 -0700
Message-ID: <20240911165047.1035764-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Do not allow cmpsel_vec to be expanded early, so that we can
make the correct decision wrt the sense of the comparison.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  1 +
 tcg/s390x/tcg-target.h         |  2 +-
 tcg/s390x/tcg-target.c.inc     | 40 ++++++++++++++++++----------------
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f75955eaa8..670089086d 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -38,6 +38,7 @@ C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
+C_O1_I4(v, v, v, v, v)
 C_O1_I4(r, r, ri, rI, r)
 C_O1_I4(r, r, rC, rI, r)
 C_O2_I1(o, m, r)
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 62ce9d792a..86aeca166f 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -162,7 +162,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sat_vec        0
 #define TCG_TARGET_HAS_minmax_vec     1
 #define TCG_TARGET_HAS_bitsel_vec     1
-#define TCG_TARGET_HAS_cmpsel_vec     0
+#define TCG_TARGET_HAS_cmpsel_vec     1
 #define TCG_TARGET_HAS_tst_vec        0
 
 /* used for function call generation */
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 23935fd0f0..e044168826 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -46,6 +46,7 @@
 
 /* A scratch register that may be be used throughout the backend.  */
 #define TCG_TMP0        TCG_REG_R1
+#define TCG_VEC_TMP0    TCG_REG_V31
 
 #define TCG_GUEST_BASE_REG TCG_REG_R13
 
@@ -2902,6 +2903,18 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
     }
 }
 
+static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
+                               TCGReg c1, TCGReg c2,
+                               TCGReg v3, TCGReg v4, TCGCond cond)
+{
+    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP0, c1, c2, cond)) {
+        TCGReg swap = v3;
+        v3 = v4;
+        v4 = swap;
+    }
+    tcg_out_insn(s, VRRe, VSEL, a0, v3, v4, TCG_VEC_TMP0);
+}
+
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            unsigned vecl, unsigned vece,
                            const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3022,6 +3035,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_cmp_vec:
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         break;
+    case INDEX_op_cmpsel_vec:
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        break;
 
     case INDEX_op_s390_vuph_vec:
         tcg_out_insn(s, VRRa, VUPH, a0, a1, vece);
@@ -3074,8 +3090,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_cmp_vec:
-        return 1;
     case INDEX_op_cmpsel_vec:
+        return 1;
     case INDEX_op_rotrv_vec:
         return -1;
     case INDEX_op_mul_vec:
@@ -3088,17 +3104,6 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
-                              TCGv_vec c1, TCGv_vec c2,
-                              TCGv_vec v3, TCGv_vec v4, TCGCond cond)
-{
-    TCGv_vec t = tcg_temp_new_vec(type);
-
-    tcg_gen_cmp_vec(cond, vece, t, c1, c2);
-    tcg_gen_bitsel_vec(vece, v0, t, v3, v4);
-    tcg_temp_free_vec(t);
-}
-
 static void expand_vec_sat(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGv_vec v2, TCGOpcode add_sub_opc)
 {
@@ -3140,7 +3145,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1, v2, v3, v4, t0;
+    TCGv_vec v0, v1, v2, t0;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
@@ -3148,12 +3153,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
 
     switch (opc) {
-    case INDEX_op_cmpsel_vec:
-        v3 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        v4 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-        expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
-        break;
-
     case INDEX_op_rotrv_vec:
         t0 = tcg_temp_new_vec(type);
         tcg_gen_neg_vec(vece, t0, v2);
@@ -3388,6 +3387,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(v, v, r);
     case INDEX_op_bitsel_vec:
         return C_O1_I3(v, v, v, v);
+    case INDEX_op_cmpsel_vec:
+        return C_O1_I4(v, v, v, v, v);
 
     default:
         g_assert_not_reached();
@@ -3512,6 +3513,7 @@ static void tcg_target_init(TCGContext *s)
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
     /* XXX many insns can't be used with R0, so we better avoid it for now */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
-- 
2.43.0



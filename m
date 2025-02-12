Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97C2C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3i7-0000FY-Ql; Tue, 11 Feb 2025 22:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hg-00009H-UD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hd-0001Zm-Q0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f6d264221so47784525ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331980; x=1739936780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CXJKgQdQFXq80m8+gtIBHT84M5rseemiIRXkZhV+xMo=;
 b=AOzk0TtcYOzWR8/coZovPTD9sv2571SHuOGmUcAHLBqnWUJqTixlghwsK3fZZWylY0
 AVSKNnaYbEQlvcpOHlpDj7vrEQU3q38KoTkJqr8upkrUHtqawWu7QFw+Qmf6IkJ7UoXj
 NkTrTLYbAoZp5+cBxujGHSY2pdPQj41ufHWU3dBwNHYFp2FAxXHF+J4VDAr0b/Dz7MrF
 oceKqzNGJbYwrOuIQQztVLi1iUtdCiGakTSWPTl7v/+iA6D4HJqM8zehF1RQi1N0pRVZ
 e/NjDMJ2aJol0puvFuE1larfbAVbiTWU4JV3a3+lIxl15bq31Wsr7jE9g1hx7B4SG9wl
 7zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331980; x=1739936780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXJKgQdQFXq80m8+gtIBHT84M5rseemiIRXkZhV+xMo=;
 b=pA07HB5iZhXmYaCQEjagYim/Lfa0qDabHfvmb0QUYq1DOlJhYTEi76Y9uu1SM9jUFL
 oj3WrhmayMsQbr6Jl1X8OOr6GMwtPBkmTBdcGP88HIRh/c6Yp2ar4EeF4GY/mS2J68qy
 V0IEi+W8/2qPl+JL4JVcY0zMwvti9sC74aVvbjzUWw7ChwmSa6tANQqpROkQ3Mf7rbZi
 skA6Aq4eQnY3UYiFd9YvJ7UD+F8SjqMXnnSixSHDSdxTPITpN3q58oKTryOdnFfMdAqR
 aK8tzxW2aYkX87I0wt3HVAICJujiLVxKCAB1+PHezYHC31SIme8Bp+PESjFGS9CMwyuf
 XjNw==
X-Gm-Message-State: AOJu0YyQEzN3qw9xVCniazt0h8rqjwJg519HEuywuNgjbhlfU8llLP8O
 PYLBiEu/RViJfhSbJ/1Ie6ptFLWzygDuJfeMmGj8xSgkfCjkb13+CoK5x4e9IhxVerCT4rtCJoA
 8
X-Gm-Gg: ASbGncsqJcfTLqL+fmC+f0hyCwwaUMMIRtVHTEhmhYSlglhN+s4sjOkYMRY7VrEBFkP
 zu9qrZz7+PcBJ7//P128J+J9Kg9R9/LjyGzvpSBejjFrUFDG4KXSEvBwVxFrybnV2N1chPK1wcT
 WCd+k6wi+whH7QIfgZh5Yir9bRmgOlXbAaGo6mxsw14mEI6Y3kNgbO7BrybiY71wE9PXe6Iw5vI
 iltx0PG7foAbLpBf3RCPmnrrpIf+UmHnyaJ15jOkJLpxuw60qHI8NISdXtxQBEzma/bkEPaWiWx
 oOAMFojMfrhE8f0tymz7/SaArXFtD5lu3ZBHrgRTuXzw4OA=
X-Google-Smtp-Source: AGHT+IExr2cWqDC72SsbTHEtU9VtU2UGLjVStNcGWSLSh5xzuj6RH05TBckaLIRR6LY8NyRmNbig4A==
X-Received: by 2002:a05:6a00:3d03:b0:730:8386:6078 with SMTP id
 d2e1a72fcca58-7322c0a2ec9mr2857582b3a.0.1739331979793; 
 Tue, 11 Feb 2025 19:46:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] tcg: Introduce the 'z' constraint for a hardware zero
 register
Date: Tue, 11 Feb 2025 19:46:12 -0800
Message-ID: <20250212034617.1079324-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
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

For loongarch, mips, riscv and sparc, a zero register is
available all the time.  For aarch64, register index 31
depends on context: sometimes it is the stack pointer,
and sometimes it is the zero register.

Introduce a new general-purpose constraint which maps 0
to TCG_REG_ZERO, if defined.  This differs from existing
constant constraints in that const_arg[*] is recorded as
false, indicating that the value is in a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            |  3 ++-
 tcg/aarch64/tcg-target.h     |  2 ++
 tcg/loongarch64/tcg-target.h |  2 ++
 tcg/mips/tcg-target.h        |  2 ++
 tcg/riscv/tcg-target.h       |  2 ++
 tcg/sparc64/tcg-target.h     |  3 ++-
 tcg/tcg.c                    | 29 ++++++++++++++++++++++-------
 docs/devel/tcg-ops.rst       |  4 +++-
 8 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 1d1d668f52..84d99508b6 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -713,7 +713,8 @@ void tb_target_set_jmp_target(const TranslationBlock *, int,
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
 
-#define TCG_CT_CONST  1 /* any constant of register size */
+#define TCG_CT_CONST      1  /* any constant of register size */
+#define TCG_CT_REG_ZERO   2  /* zero, in TCG_REG_ZERO */
 
 typedef struct TCGArgConstraint {
     unsigned ct : 16;
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 0dd6e1f069..3f3df5176d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -45,6 +45,8 @@ typedef enum {
     TCG_AREG0  = TCG_REG_X19,
 } TCGReg;
 
+#define TCG_REG_ZERO TCG_REG_XZR
+
 #define TCG_TARGET_NB_REGS 64
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 8533284631..6a206fb97e 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -85,4 +85,6 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_ZERO
+
 #endif /* LOONGARCH_TCG_TARGET_H */
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 3090acc4f5..bd4ca5f852 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,4 +70,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_ZERO
+
 #endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index db5f3d8b72..6dc77d944b 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -57,4 +57,6 @@ typedef enum {
     TCG_REG_TMP2       = TCG_REG_T4,
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_ZERO
+
 #endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index f7d75d5806..1b9adccd85 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -64,6 +64,7 @@ typedef enum {
     TCG_REG_I7,
 } TCGReg;
 
-#define TCG_AREG0 TCG_REG_I0
+#define TCG_AREG0     TCG_REG_I0
+#define TCG_REG_ZERO  TCG_REG_G0
 
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 57f72b78d4..dc640c6528 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3229,6 +3229,11 @@ static void process_constraint_sets(void)
                 case 'i':
                     args_ct[i].ct |= TCG_CT_CONST;
                     break;
+#ifdef TCG_REG_ZERO
+                case 'z':
+                    args_ct[i].ct |= TCG_CT_REG_ZERO;
+                    break;
+#endif
 
                 /* Include all of the target-specific constraints. */
 
@@ -5080,13 +5085,23 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         arg_ct = &args_ct[i];
         ts = arg_temp(arg);
 
-        if (ts->val_type == TEMP_VAL_CONST
-            && tcg_target_const_match(ts->val, arg_ct->ct, ts->type,
-                                      op_cond, TCGOP_VECE(op))) {
-            /* constant is OK for instruction */
-            const_args[i] = 1;
-            new_args[i] = ts->val;
-            continue;
+        if (ts->val_type == TEMP_VAL_CONST) {
+#ifdef TCG_REG_ZERO
+            if (ts->val == 0 && (arg_ct->ct & TCG_CT_REG_ZERO)) {
+                /* Hardware zero register: indicate register via non-const. */
+                const_args[i] = 0;
+                new_args[i] = TCG_REG_ZERO;
+                continue;
+            }
+#endif
+
+            if (tcg_target_const_match(ts->val, arg_ct->ct, ts->type,
+                                       op_cond, TCGOP_VECE(op))) {
+                /* constant is OK for instruction */
+                const_args[i] = 1;
+                new_args[i] = ts->val;
+                continue;
+            }
         }
 
         reg = ts->reg;
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6608a29376..75acb4bd32 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -927,7 +927,9 @@ operation uses a constant input constraint which does not allow all
 constants, it must also accept registers in order to have a fallback.
 The constraint '``i``' is defined generically to accept any constant.
 The constraint '``r``' is not defined generically, but is consistently
-used by each backend to indicate all registers.
+used by each backend to indicate all registers.  If ``TCG_REG_ZERO``
+is defined by the backend, the constraint '``z``' is defined generically
+map 0 to the hardware zero register.
 
 The movi_i32 and movi_i64 operations must accept any constants.
 
-- 
2.43.0



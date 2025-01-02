Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD3DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPes-0007q8-53; Thu, 02 Jan 2025 13:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeX-0007Io-0c
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeV-0006Dy-9D
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163bd70069so60167345ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841434; x=1736446234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HDOtIVzUuX4vneB5tQXFq3FPWBNtviMH9HO1FztH9is=;
 b=hAG6UEV1nVsClJzDENSgJItTj1qsifXasK32fUDA23+dbF3mGCH6gvpXrxGqS8eSw6
 LxzElpvASliDTKH5UEm6PR9mMj9Wdi28uUFaF7oxeV+axPT1+AGQDmkq3fZLPbCFzFKd
 T8PbXnAVyFta7yW3LC509igerMigCCBHsGdLMTA23+pBsG/ouAsUJm9NomFmWsqDpn1K
 0z2Vo9Is8WCku7K1gMFE7wThNQQGSUQemVihe1ooFxPwrLmOtAsvm0tmFphxGoC6ft8E
 P32DoUb9u/lrYILxGhhm1GucxPUC3ycOrxWXDjEi4xd5NnEq7UNkf7y6Syua3xqUVuAA
 xUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841434; x=1736446234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDOtIVzUuX4vneB5tQXFq3FPWBNtviMH9HO1FztH9is=;
 b=mcvvaz488woblOmZKMfcH3+lU9yk4VEnNGkX8uOqkPRzshcy1p9Nbsn38KfqqQ4p6r
 Cqeb773UUE6RA84cjT8rolPdj5AmroTOPt+HxOpCsV/Z+ybY9makxAlChSVQ/FupgAoK
 AJg7mjy0FTY24Lec0BxaPBeKH1rHi2TbBB/xtbRgIagfTYlxcpv1dSPCpIAs/ogx9OvO
 0hRoNL99FfzEqFaHZd5r145hE0XopjKREDxO6K5/Lwv7avVWSg+uubFH+fwxWH8D8Mj2
 nsesJ3oWxOZTrr/AeSj5LUJXMS54sIMk0kcCw0AJEeR1GDM61qX4IWpW/Xplsk0C2U0g
 VXlw==
X-Gm-Message-State: AOJu0YzIpoMpQQe0dX8xmuB92nBeEpd1fnvyvKTcSHWn8BluuW5J5pWx
 ULU81wbmryjrAKnY9o0xGhnXVHUDzsQ7dop4ize0mVwQOC+MY6mVKNlIq7bibCN+gXjmFSO4/LI
 1
X-Gm-Gg: ASbGnctp+rWtYPC/3y3/sP+D9O+sw9kmdjtyjnVRpauKDhl/zSVA0BobX+KWGJibx+U
 r/Ep0gNofm48iWUprxVRHNjb7gn9uy1RaNq27sxLXp5hdTFCHh8LssTOzKIedYt43VWTkbyHoQs
 g89RRmIWzQTY04kP2voBCdisnfZ+SeiNKCVqT261WfpTaYLMoUxdH5w9+rkDwvcDlvqUBxTuGHw
 qG0K6TRHrCf/DgRkJFIYtXKusO4TNCcA66pi1zeGFP6CvuIRtWSO0J6Irk39w==
X-Google-Smtp-Source: AGHT+IEfen4D2kEojGZ785yvVf4iux7vqn7/JeivsXqgqB5qpdy2BcTqVvz7qVpQHT5jaHv3/bODuw==
X-Received: by 2002:a05:6a20:12cb:b0:1e3:e836:8ad8 with SMTP id
 adf61e73a8af0-1e5e083eafcmr78348804637.38.1735841433901; 
 Thu, 02 Jan 2025 10:10:33 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/73] tcg: Remove args_ct from TCGOpDef
Date: Thu,  2 Jan 2025 10:06:30 -0800
Message-ID: <20250102180654.1420056-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Introduce a new function, opcode_args_ct, to look up
the argument set for an opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 -
 tcg/tcg-common.c  |  2 +-
 tcg/tcg.c         | 48 +++++++++++++++++++++++++++++++++--------------
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d589dbe02b..412d6d119c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -710,7 +710,6 @@ typedef struct TCGOpDef {
     const char *name;
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
-    const TCGArgConstraint *args_ct;
 } TCGOpDef;
 
 extern TCGOpDef tcg_op_defs[];
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index fadc33c3d1..0f30e5b3ec 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -28,7 +28,7 @@
 
 TCGOpDef tcg_op_defs[] = {
 #define DEF(s, oargs, iargs, cargs, flags) \
-         { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags, NULL },
+         { #s, oargs, iargs, cargs, iargs + oargs + cargs, flags },
 #include "tcg/tcg-opc.h"
 #undef DEF
 };
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 343da162a5..b8be62934c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3335,7 +3335,6 @@ static void process_op_defs(TCGContext *s)
         }
 
         if (def->flags & TCG_OPF_NOT_PRESENT) {
-            def->args_ct = empty_cts;
             continue;
         }
 
@@ -3351,11 +3350,26 @@ static void process_op_defs(TCGContext *s)
         tdefs = &constraint_sets[con_set];
         tcg_debug_assert(tdefs->nb_oargs == def->nb_oargs);
         tcg_debug_assert(tdefs->nb_iargs == def->nb_iargs);
-
-        def->args_ct = all_args_cts[con_set];
     }
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    TCGOpDef *def = &tcg_op_defs[op->opc];
+    unsigned con_set;
+
+    if (def->nb_iargs + def->nb_oargs == 0) {
+        return NULL;
+    }
+    if (def->flags & TCG_OPF_NOT_PRESENT) {
+        return empty_cts;
+    }
+
+    con_set = tcg_target_op_def(op->opc);
+    tcg_debug_assert(con_set < ARRAY_SIZE(constraint_sets));
+    return all_args_cts[con_set];
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op->args[idx]);
@@ -3823,6 +3837,7 @@ liveness_pass_1(TCGContext *s)
         TCGTemp *ts;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
+        const TCGArgConstraint *args_ct;
 
         switch (opc) {
         case INDEX_op_call:
@@ -4112,8 +4127,9 @@ liveness_pass_1(TCGContext *s)
                 break;
 
             default:
+                args_ct = opcode_args_ct(op);
                 for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
-                    const TCGArgConstraint *ct = &def->args_ct[i];
+                    const TCGArgConstraint *ct = &args_ct[i];
                     TCGRegSet set, *pset;
 
                     ts = arg_temp(op->args[i]);
@@ -4903,6 +4919,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
     TCGRegSet dup_out_regs, dup_in_regs;
+    const TCGArgConstraint *dup_args_ct;
     TCGTemp *its, *ots;
     TCGType itype, vtype;
     unsigned vece;
@@ -4929,8 +4946,9 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         return;
     }
 
-    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
-    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
+    dup_args_ct = opcode_args_ct(op);
+    dup_out_regs = dup_args_ct[0].regs;
+    dup_in_regs = dup_args_ct[1].regs;
 
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
@@ -5016,6 +5034,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     int i, k, nb_iargs, nb_oargs;
     TCGReg reg;
     TCGArg arg;
+    const TCGArgConstraint *args_ct;
     const TCGArgConstraint *arg_ct;
     TCGTemp *ts;
     TCGArg new_args[TCG_MAX_OP_ARGS];
@@ -5060,6 +5079,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
     }
 
+    args_ct = opcode_args_ct(op);
+
     /* satisfy input constraints */
     for (k = 0; k < nb_iargs; k++) {
         TCGRegSet i_preferred_regs, i_required_regs;
@@ -5067,9 +5088,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         TCGTemp *ts2;
         int i1, i2;
 
-        i = def->args_ct[nb_oargs + k].sort_index;
+        i = args_ct[nb_oargs + k].sort_index;
         arg = op->args[i];
-        arg_ct = &def->args_ct[i];
+        arg_ct = &args_ct[i];
         ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
@@ -5099,7 +5120,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                  * register and move it.
                  */
                 if (temp_readonly(ts) || !IS_DEAD_ARG(i)
-                    || def->args_ct[arg_ct->alias_index].newreg) {
+                    || args_ct[arg_ct->alias_index].newreg) {
                     allocate_new_reg = true;
                 } else if (ts->val_type == TEMP_VAL_REG) {
                     /*
@@ -5284,10 +5305,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
 
         /* satisfy the output constraints */
-        for(k = 0; k < nb_oargs; k++) {
-            i = def->args_ct[k].sort_index;
+        for (k = 0; k < nb_oargs; k++) {
+            i = args_ct[k].sort_index;
             arg = op->args[i];
-            arg_ct = &def->args_ct[i];
+            arg_ct = &args_ct[i];
             ts = arg_temp(arg);
 
             /* ENV should not be modified.  */
@@ -5401,8 +5422,7 @@ static bool tcg_reg_alloc_dup2(TCGContext *s, const TCGOp *op)
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
         TCGRegSet allocated_regs = s->reserved_regs;
-        TCGRegSet dup_out_regs =
-            tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
+        TCGRegSet dup_out_regs = opcode_args_ct(op)[0].regs;
         TCGReg oreg;
 
         /* Make sure to not spill the input registers. */
-- 
2.43.0



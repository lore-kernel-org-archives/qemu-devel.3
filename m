Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C5F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquS-0006tO-Qa; Thu, 23 Apr 2026 06:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqth-0006Sj-7m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtf-00026H-CL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so5143536f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938578; x=1777543378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tBdjRjEK2VHM/TQcuD55BbI0c9Tl7lLp8FbZsgY7OSc=;
 b=ZW2rQM7kORhk4Ic3Bzxh6cSMF08Bey8ZaRZzPDaAeVMTUGSN8tyyuqLQfgrGp4hbrl
 3CWAqEGi729+cSLzJL9m99ASCr9irhx0Q0spjzIrlOt/ydGm97aC+S8PnKWbIlaJfQlQ
 UPcX9/FmcRft3zpGhPZznUbJQEAap2clqUkctb9WkuYtFI3m6lA5r8wTmq7YIN1xxL1C
 1uRszyb/jdBeqI5nfDZBUvIaDP1tM2AnwKQhWOvbGlO7xd/bIkJYC7bdA0+i8e4jq0ZD
 DFoH+v+XaCmd+HzVtctKZyHhN1bnSkqBmCivAvFxDkraEPsr4tvsCOIkQc/FH1DASpI4
 H0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938578; x=1777543378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tBdjRjEK2VHM/TQcuD55BbI0c9Tl7lLp8FbZsgY7OSc=;
 b=dftYF14C/kzQAllXOIoHi47imY0NBjpG6QIjPWWqORyNNXXNEK+tMtQor2KGAOAZWt
 CnXYB0VViEsfQNCw/OhNXzB8vQhM60KKD0GAv588CRSv1tqonWLWfgN8jfIQpld5s3Bm
 eRXYILPHjdRnkhQr4BbdLAxWYaEepHE3NWnkcMNjdTM88TWSk2JReN0oFBCgvbfi3USn
 EqltiSrROmO+YrJl2VxrV+ybLk6dL9Blx0+4TLNsxPNTVQfDbGnIB3ziyG9aHvDvPzd7
 6IdfUwjOgAM8TgPc3JD1ryJJhrL0aC5sVUnJTT3Y6Gw7s31KLsAUaUt5Jy6Vtvmt+OIR
 KXKw==
X-Gm-Message-State: AOJu0YyYG7xt0Ur8JBRanYLhqYDm/QV4KZCmtvY3rQcdBRPthsztl62g
 7QpyFiL2XiQ9FkHla4H2hUsHxACeDCU3rE/kCBXyJTczSVqZ/FD/AioF8REHq/5wIYXWc6Lf/qh
 ChrHp
X-Gm-Gg: AeBDiesb8veFe7z66SEistrFjoCMm3fEd9r9+hx78FCETlhQErpsLwIiwNptcH0jY6V
 NXjTKQKQw2fbyzRZwFmMIzPT3gf/0XiAjQcQFWehuUNxBfEtcK/W5ZCmCsdslt4si9N4AKGMGpI
 tVIyUOMcmS3QH7jFq+DWDc/GE99Ls5TZPQClzxC8H1jyv/2rPPI/kbPbXEfUq9s5+d9m+PPmSU2
 i8AclK+qMfSCf8QtbdgJRnzjWKEsoBqq8qWrrCtony/Seg9Qr2iqi+4M5JwBUc69e8FAG0so9dK
 OfR7hj373QLObcKH3wA/P4jLMSpt6YVq7VIXMWTlBLvavGTlw9TUO4jbQ4ZLVCwM2WsY7Ymd/+Z
 +JUOTZAlxGT2z5o4KsWnpVlndcvwt1CwkdTy0Z+vLankefSsPLtarLTc26sr1YJcVkjZjG2G+Ji
 y1+oNPy7LGS4QKhtBH7oK+cFTZwmARsswv2IbrcKMtgCvNrMMN+OtByb8zyE5WY2r2fxmV7jccE
 ZlsfqLoJgGjtM8mtpJ8eJ6Ayr8DF8O+eM6Go34VTA==
X-Received: by 2002:a05:6000:2081:b0:43b:5022:7fa with SMTP id
 ffacd0b85a97d-43fe3db2e6emr40332811f8f.13.1776938577663; 
 Thu, 23 Apr 2026 03:02:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/59] target/arm/tcg/translate.c: replace TCGv with TCGv_va
Date: Thu, 23 Apr 2026 11:01:54 +0100
Message-ID: <20260423100229.2941820-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We know this file is for 32-bit runtime target, so we can set
TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
passed to translator_loop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260407222208.271838-16-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index fa4c7907dc..0b3b4ab86b 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,7 +22,8 @@
 
 #include "translate.h"
 #include "translate-a32.h"
-#include "tcg/tcg-op.h"
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-mem.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
@@ -910,14 +911,14 @@ MemOp pow2_align(unsigned i)
  * that the address argument is TCGv_i32 rather than TCGv.
  */
 
-static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
+static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 {
-    TCGv addr = tcg_temp_new();
-    tcg_gen_extu_i32_tl(addr, a32);
+    TCGv_va addr = tcgv_va_temp_new();
+    tcg_gen_mov_i32(addr, a32);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
-        tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
+        tcg_gen_xori_i32(addr, addr, 4 - (1 << (op & MO_SIZE)));
     }
     return addr;
 }
@@ -929,21 +930,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 void gen_aa32_ld_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_ld_i32(val, addr, index, opc);
 }
 
 void gen_aa32_st_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_st_i32(val, addr, index, opc);
 }
 
 void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     tcg_gen_qemu_ld_i64(val, addr, index, opc);
 
@@ -956,7 +957,7 @@ void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
 void gen_aa32_st_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (opc & MO_SIZE) == MO_64) {
@@ -2036,7 +2037,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
          * architecturally 64-bit access, but instead do a 64-bit access
          * using MO_BE if appropriate and then split the two halves.
          */
-        TCGv taddr = gen_aa32_addr(s, addr, opc);
+        TCGv_va taddr = gen_aa32_addr(s, addr, opc);
 
         tcg_gen_qemu_ld_i64(t64, taddr, get_mem_index(s), opc);
         tcg_gen_mov_i64(cpu_exclusive_val, t64);
@@ -2065,7 +2066,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
 {
     TCGv_i32 t0, t1, t2;
     TCGv_i64 extaddr;
-    TCGv taddr;
+    TCGv_va taddr;
     TCGLabel *done_label;
     TCGLabel *fail_label;
     MemOp opc = size | MO_ALIGN | s->be_data;
@@ -3792,7 +3793,7 @@ static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i64 t64 = tcg_temp_new_i64();
     TCGv_i32 tmp = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
@@ -3847,7 +3848,7 @@ static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i32 t1 = load_reg(s, rt);
     TCGv_i32 t2 = load_reg(s, rt2);
     TCGv_i64 t64 = tcg_temp_new_i64();
@@ -4068,7 +4069,7 @@ DO_LDST(STRH, store, MO_UW)
 static bool op_swp(DisasContext *s, arg_SWP *a, MemOp opc)
 {
     TCGv_i32 addr, tmp;
-    TCGv taddr;
+    TCGv_va taddr;
 
     opc |= s->be_data;
     addr = load_reg(s, a->rn);
-- 
2.43.0



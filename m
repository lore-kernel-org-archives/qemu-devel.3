Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7652C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R5U-0005XM-ET; Fri, 25 Apr 2025 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4N-0001x9-U0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4L-0000ro-6M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2264aefc45dso44702665ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618327; x=1746223127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZam8zvlmBF5wLCIC4qvKiP5PLAnO1vmy8AH+wCKeHs=;
 b=l6fa5WiOc/ckTCIQ94EcHUqTuVY6XOw5iel0aZuW8N5o+BoLPP1peSrVpApLEgXJQ0
 tJ2MFtIALyILzMA9DoIyyrQ9bDH+9msjGYIs/nU0u3tkaku38ljWRQ+SaPbyT4lWFsa+
 U0aVpcLal9Cggr30jQ5qfwiZ7diDoosb36K8MW4RPyWhDN33+D76r2/1ZAxh0CxgqwM1
 A+NPiLRyiKfMpfPqJ9nUHGmlSJorxxiycH5BZQiwDKW00otaQGwpqx9KjBBQkCyle3lw
 NvnZPylfTCbJ5baLBWf4rjX6aZj0Bkq1PRNwhkcHkz2/Lfl64kN2EPPf9nni6aF0GGZW
 xUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618327; x=1746223127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZam8zvlmBF5wLCIC4qvKiP5PLAnO1vmy8AH+wCKeHs=;
 b=caLeuPi6rYN5lvUkMuw7josgxslwqXnCKicYaEkKWGbOW0SjZjOjvFq2A+6iIklAsC
 3cyzZpEhemJxbBRzvwfN8QrSP3YzWMHyMQcTUXDfr2UKg87VgtRciVGW0OrAecNgJDT7
 0y/oTW6FFVazf3fSeLKo1LiGNV1M0KJXl/uHC7j/0eI+nsbQ1Z+Y+6cV2AxhYEPrMTy3
 4AjweG7YbIVJVe3auzbmO86ESXVYzPHG0LOS13Q4AUToo1grGzirKPr5kcy6zbhZDbK9
 GSfooMbfFfzKx9xQWLohGPPnrQ/PTSARa7lo3TzQLbllPF3qM6XEChs7i+HaHzghkFd2
 mqqQ==
X-Gm-Message-State: AOJu0YxRY0z3ePiC4JBbzn+Xn0ayLX45tzZ6YKXWUp9xktKHL6zLG65o
 QF3axqqGNdR468nRfSn08Cy285fruDCo9nwUWOoeeku2FQVdrZZRW6UIp5D+uRx8ulQTcY0fFTt
 2
X-Gm-Gg: ASbGnculJgotg2TCtuv5MhSZdCB4sE/bIbBF+HBYi5oEuOB+ITH0feBIHGRpPwxpJ/O
 9EoybeoDKIbaBnkebVXqfyst4glvzLeIp4eEmm0Yn0VdMLJBqkDQws4uVI7o1QB7qzqhIbEYm6G
 EpLOqDzPFlhmy+2GTETFd61j86jm1X/DoCc0gmcfO5/ydc2M9+UIbLR5SwmE1Sa/Bjj7JPTOK3z
 D0G1DMHZzSe0gbhTG5lwHpyO2Ww+dcw/VWJ52kO3upqPhMWAP1Sdf1gCSxBt22cfx3zQ8p4F0Ao
 uhmzo6SasxU9cNQWxhxG9eB6lwhuYxf5JQENhvbq/yqgeyMV8NhWTnDBUJCVxuW9fMmyPQRExG4
 =
X-Google-Smtp-Source: AGHT+IFbK63RoI+C659+LrFKctd7vhq7c6oyP/Z0R+UVo/RqvW9Oh9bDBwloz30u/dQ2v7oZCnAFXg==
X-Received: by 2002:a17:902:ec8b:b0:224:13a4:d61e with SMTP id
 d9443c01a7336-22dbf7472bbmr53661235ad.51.1745618327399; 
 Fri, 25 Apr 2025 14:58:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 067/159] tcg: Merge INDEX_op_clz_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:21 -0700
Message-ID: <20250425215454.886111-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 10 +++++-----
 tcg/tcg-op.c             | 22 ++++++++++------------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 25fd93eb28..ad1d193ef4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(clz, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
 
@@ -130,7 +130,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 97a566a617..d8d0e728aa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -503,10 +503,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
     case INDEX_op_nor_vec:
         return ~(x | y);
 
-    case INDEX_op_clz_i32:
-        return (uint32_t)x ? clz32(x) : y;
-
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x ? clz32(x) : y;
+        }
         return x ? clz64(x) : y;
 
     case INDEX_op_ctz_i32:
@@ -2898,7 +2898,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bswap64_i64:
             done = fold_bswap(&ctx, op);
             break;
-        CASE_OP_32_64(clz):
+        case INDEX_op_clz:
         CASE_OP_32_64(ctz):
             done = fold_count_zeros(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e1e57ff3f8..76e9efc655 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -723,9 +723,9 @@ void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
         tcg_gen_extu_i32_i64(t1, arg1);
@@ -770,8 +770,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_subi_i32(t, arg1, 1);
         tcg_gen_andc_i32(t, t, arg1);
         tcg_gen_ctpop_i32(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
-               tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
         t = tcg_temp_ebb_new_i32();
         tcg_gen_neg_i32(t, arg1);
         tcg_gen_and_i32(t, t, arg1);
@@ -803,8 +802,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0) ||
-        tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t, arg, 31);
         tcg_gen_xor_i32(t, t, arg);
@@ -2340,8 +2338,8 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
     } else {
         gen_helper_clz_i64(ret, arg1, arg2);
     }
@@ -2351,7 +2349,7 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     if (TCG_TARGET_REG_BITS == 32
         && arg2 <= 0xffffffffu
-        && tcg_op_supported(INDEX_op_clz_i32, TCG_TYPE_I32, 0)) {
+        && tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
         tcg_gen_addi_i32(t, t, 32);
@@ -2376,7 +2374,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_subi_i64(t, arg1, 1);
         tcg_gen_andc_i64(t, t, arg1);
         tcg_gen_ctpop_i64(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         t = tcg_temp_ebb_new_i64();
         tcg_gen_neg_i64(t, arg1);
         tcg_gen_and_i64(t, t, arg1);
@@ -2419,7 +2417,7 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (tcg_op_supported(INDEX_op_clz_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t, arg, 63);
         tcg_gen_xor_i64(t, t, arg);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e04d3adcec..71b0721fb5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1026,8 +1026,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_clz_i32, TCGOutOpBinary, outop_clz),
-    OUTOP(INDEX_op_clz_i64, TCGOutOpBinary, outop_clz),
+    OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
@@ -5402,8 +5401,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_clz_i32:
-    case INDEX_op_clz_i64:
+    case INDEX_op_clz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
diff --git a/tcg/tci.c b/tcg/tci.c
index 11b11ce642..7c2f2a524b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -733,7 +733,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
             break;
-        case INDEX_op_clz_i64:
+        case INDEX_op_clz:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
             break;
@@ -1052,6 +1052,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_clz:
     case INDEX_op_divs:
     case INDEX_op_divu:
     case INDEX_op_eqv:
@@ -1069,7 +1070,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
     case INDEX_op_tci_clz32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c3a6499d01..22f0432988 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -358,7 +358,7 @@ Logical
 
      - | *t0* = *t1* | ~\ *t2*
 
-   * - clz_i32/i64 *t0*, *t1*, *t2*
+   * - clz *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ? clz(*t1*) : *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ee7e6f15eb..0fd1f5510a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -633,7 +633,7 @@ static void tgen_clz(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_clz32
-                     : INDEX_op_clz_i64);
+                     : INDEX_op_clz);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0



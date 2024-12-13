Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9254FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XY-0007Lj-EW; Fri, 13 Dec 2024 12:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wz-0006tz-1F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Ww-0001Ty-8e
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-435004228c0so24457205e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111165; x=1734715965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sFYMlM2q6ifWyTSOYq7MTYvofuvINKuts8GiQDOUAdE=;
 b=ZR1R/NWGCiD9CdvH9FjKsWVd/EZ8nkkuPlcud5uDS9jzEu4gPUMMTOJUI+XTV63bXE
 HHane3TKZkp1sdE87i+JgwsZ64Rkk17S7vgm/Pb2nglPif2AcuXZwMWuF1NWizVvpdJl
 GepDoYSMLdxjUa5QCi3o16gbKASe3EoKHvDvpncsGQaL7L1/5+cGllv85o+UiAxoGCi4
 sQJitD+/rOqDpJtXfoXecHb5IUTgStGabQuyifdD1I2xGFKqPCq+uKUHY64zrfhOF474
 PExCaBbVirqAOE5SOVuFVvJSX1rpPhCMXLTdFgfQX0HSxIbiFhtB4s5mZ794GGgAs4fq
 FJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111165; x=1734715965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFYMlM2q6ifWyTSOYq7MTYvofuvINKuts8GiQDOUAdE=;
 b=XORMF2JB4G1/R0pPNsQ3gu0Af99cG8v65QhcJ+YNdXbVKDiQr24I8Egu+XNrDcIZu+
 7jDohFjX9DlmsBNUua+wp69VzCBfVpkSpmIuobkg46e6a+FXP/bUe5kZhT+CdfPGKcgw
 nYuvH7vYkURv8aUAfMyuBkISPVjyN09AfknP3TkyHcegeQpRHXjosiAQGZABBAyomhHs
 RIDb3j/dGGk3GkxMgprkVtWxxaaOE3J6xQ1nMF9B76fDfL26DOdTQOZIkY06XRlDes9k
 cmYWEYtPpjyhf7OnffRy2G6YX7NZAQD3HetxnHXZjiSgxOQK7KG3MQoBJQtDx1psE5Ky
 8ayA==
X-Gm-Message-State: AOJu0Ywv6TJrPXjqo9wpEaNlElRJXTIYLHOmMmEdXn6Woa8V5xDWFmMt
 aM8FAGIQ2N97BwVWZ35kHDEEwFGV1L9SjBNBiChGQWULvcWcGdARaASKLqzOzBAcJjME5XEUe+X
 K
X-Gm-Gg: ASbGncvDxRo7co2Z3ByYc8VU6rpX8RgCbCon/7cy/kobhJWWQK+RrW+FBiv8q9fZUi1
 usrfCuHUyHi+PGOikPm3bjyCaip0cVDxeMzLabJtdeq07MDqHBwq8hAV8EzvoecaB6zNO+moAcI
 vrPVXnJoHiEVmTgsDFMm5YnYA6QX4E0QCRixdb2RLb2c0S184uB6FmQk3jLrH/WulCYqTJBs/Dx
 59uGQuNZAstIV08j2BOkiZMqJ06z/v9Y1dUlvOOPKT87NMVFO2GXbG1fty3WQ==
X-Google-Smtp-Source: AGHT+IGh3ZEvKj5Vnx+IQGYzvyX7clRbII6+w0ra5WWQTWw9AV4k2ehy0jBaL+gozVBXzr9c9fw/lw==
X-Received: by 2002:a05:6000:1886:b0:385:fd31:ca23 with SMTP id
 ffacd0b85a97d-3888e0b877amr2941352f8f.40.1734111164694; 
 Fri, 13 Dec 2024 09:32:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/85] target/arm: Convert disas_add_sub_ext_reg to decodetree
Date: Fri, 13 Dec 2024 17:31:16 +0000
Message-Id: <20241213173229.3308926-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes ADD, SUB, ADDS, SUBS (extended register).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  9 +++++
 target/arm/tcg/translate-a64.c | 65 +++++++++++-----------------------
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8e2949d2361..05396945062 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -727,6 +727,15 @@ ANDS_r          . 11 01010 .. . ..... ...... ..... .....    @logic_shift
 
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
+
+&addsub_ext     rd rn rm sf sa st
+@addsub_ext     sf:1 .. ........ rm:5 st:3 sa:3 rn:5 rd:5   &addsub_ext
+
+ADD_ext         . 00 01011001 ..... ... ... ..... .....     @addsub_ext
+SUB_ext         . 10 01011001 ..... ... ... ..... .....     @addsub_ext
+ADDS_ext        . 01 01011001 ..... ... ... ..... .....     @addsub_ext
+SUBS_ext        . 11 01011001 ..... ... ... ..... .....     @addsub_ext
+
 # Add/subtract (carry)
 # Rotate right into flags
 # Evaluate into flags
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecc8899dd84..8f777875fe0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7864,57 +7864,27 @@ TRANS(AND_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, false)
 TRANS(ANDS_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, true)
 TRANS(EOR_r, do_logic_reg, a, tcg_gen_xor_i64, tcg_gen_eqv_i64, false)
 
-/*
- * Add/subtract (extended register)
- *
- *  31|30|29|28       24|23 22|21|20   16|15  13|12  10|9  5|4  0|
- * +--+--+--+-----------+-----+--+-------+------+------+----+----+
- * |sf|op| S| 0 1 0 1 1 | opt | 1|  Rm   |option| imm3 | Rn | Rd |
- * +--+--+--+-----------+-----+--+-------+------+------+----+----+
- *
- *  sf: 0 -> 32bit, 1 -> 64bit
- *  op: 0 -> add  , 1 -> sub
- *   S: 1 -> set flags
- * opt: 00
- * option: extension type (see DecodeRegExtend)
- * imm3: optional shift to Rm
- *
- * Rd = Rn + LSL(extend(Rm), amount)
- */
-static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
+static bool do_addsub_ext(DisasContext *s, arg_addsub_ext *a,
+                          bool sub_op, bool setflags)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm3 = extract32(insn, 10, 3);
-    int option = extract32(insn, 13, 3);
-    int rm = extract32(insn, 16, 5);
-    int opt = extract32(insn, 22, 2);
-    bool setflags = extract32(insn, 29, 1);
-    bool sub_op = extract32(insn, 30, 1);
-    bool sf = extract32(insn, 31, 1);
+    TCGv_i64 tcg_rm, tcg_rn, tcg_rd, tcg_result;
 
-    TCGv_i64 tcg_rm, tcg_rn; /* temps */
-    TCGv_i64 tcg_rd;
-    TCGv_i64 tcg_result;
-
-    if (imm3 > 4 || opt != 0) {
-        unallocated_encoding(s);
-        return;
+    if (a->sa > 4) {
+        return false;
     }
 
     /* non-flag setting ops may use SP */
     if (!setflags) {
-        tcg_rd = cpu_reg_sp(s, rd);
+        tcg_rd = cpu_reg_sp(s, a->rd);
     } else {
-        tcg_rd = cpu_reg(s, rd);
+        tcg_rd = cpu_reg(s, a->rd);
     }
-    tcg_rn = read_cpu_reg_sp(s, rn, sf);
+    tcg_rn = read_cpu_reg_sp(s, a->rn, a->sf);
 
-    tcg_rm = read_cpu_reg(s, rm, sf);
-    ext_and_shift_reg(tcg_rm, tcg_rm, option, imm3);
+    tcg_rm = read_cpu_reg(s, a->rm, a->sf);
+    ext_and_shift_reg(tcg_rm, tcg_rm, a->st, a->sa);
 
     tcg_result = tcg_temp_new_i64();
-
     if (!setflags) {
         if (sub_op) {
             tcg_gen_sub_i64(tcg_result, tcg_rn, tcg_rm);
@@ -7923,19 +7893,25 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
         }
     } else {
         if (sub_op) {
-            gen_sub_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_sub_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         } else {
-            gen_add_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_add_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         }
     }
 
-    if (sf) {
+    if (a->sf) {
         tcg_gen_mov_i64(tcg_rd, tcg_result);
     } else {
         tcg_gen_ext32u_i64(tcg_rd, tcg_result);
     }
+    return true;
 }
 
+TRANS(ADD_ext, do_addsub_ext, a, false, false)
+TRANS(SUB_ext, do_addsub_ext, a, true, false)
+TRANS(ADDS_ext, do_addsub_ext, a, false, true)
+TRANS(SUBS_ext, do_addsub_ext, a, true, true)
+
 /*
  * Add/subtract (shifted register)
  *
@@ -8374,8 +8350,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     if (!op1) {
         if (op2 & 8) {
             if (op2 & 1) {
-                /* Add/sub (extended register) */
-                disas_add_sub_ext_reg(s, insn);
+                goto do_unallocated;
             } else {
                 /* Add/sub (shifted register) */
                 disas_add_sub_reg(s, insn);
-- 
2.34.1



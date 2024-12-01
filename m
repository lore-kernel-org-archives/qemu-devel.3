Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2DFD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWq-0001LR-FO; Sun, 01 Dec 2024 10:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWm-0001IZ-66
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:28 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWk-0004A1-C9
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:27 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5f1e73033cbso1407049eaf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065585; x=1733670385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iriLwcxyVyeVT5mHrCfRAp1fipOzhQ4YyKJFEHU+3zo=;
 b=hMoUCre9tNhFuzX2alPjHjPLcHbZ3tcD8NZziNZhuG8nK6N+sE7qy1s2B+y+GfKGM8
 cg/Tkgt6o3eI4YMbPBM6eagLTzBE/VLKKkuHRU66Miiv/FpKFFfOVjvdpuB+iXGyGe7/
 tzHFPoCXSrZC5x6hAFS046yu2/XCdl4j7K0pb2bLU7eqMMqXB/uI/W7/uZIuu/avsZui
 8DLCdgUcdMDR2pJVmTXcKtf/dHQ2qJgED872bnZfVVUqOPa3ky0fLCCMYILznqeuk4lf
 J2clj2a5Wb4aOeB/UKqDVII4jYDzsu6BdOV/Kvuju5qL/cwb2GA0PBttctaMwOlJfmOL
 XbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065585; x=1733670385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iriLwcxyVyeVT5mHrCfRAp1fipOzhQ4YyKJFEHU+3zo=;
 b=w1eXxfg2gck8ypaMI4PzqJI7WaZ2yjSZdrbHW21A1w/9GrCjJGnZJ2PqCgCfqxs5Ld
 uT+ppouqRuFni46uACjJ/+D+QiotBTBYDIaFIV92wWMBofgyXwDtJ81ZTYIN63emT7Hh
 o9d75eFLeVMRsRLvGVYlj7hGCyqP6SMKBRy2651uSpVe/zpVqJ9oHKjx1cOl86aiZxS2
 D2AYdNW7uvQmoBSGkUuY8uVAqpJlAefZIhs6Ph3/mrmQ8AlEnItpMOBbTVwllaOscSNQ
 5PMLztjSiJ2jJqjuFsVtxm2ZirxqUWubofH0YjUFun7Q8iK6KRstli5BLvO7MKwsO1Pu
 kVnA==
X-Gm-Message-State: AOJu0YyAr0dmWw0ynuRwk6DNTpOELCm6hWv5+3RrbE/wYQTe+qMpGxoh
 y6IgNAdq5S/Ou7kSTDEBcv7PRDfOkWWuN7de4CZyQlsKeJO923JnQc5jcuvawHvRgC8duM0qnke
 VmYI=
X-Gm-Gg: ASbGncvWrvNQ3OfMJHuFS4DXwO2ceei8UKoCFFXGGlgek9LyTOPFhJzhOUfZPa5LfMh
 UbNxhvxnRG0ewl9BWdqXkEeDGjyEbuSTmzh6KsuRWZe1rcTgQetBFZeT7pGnVriiE/fMticzIC9
 w+qdd/fQSTy0nxzqfSFF9ox/D4CbOinIsXAE+jSk1UlDrzrKR/QTZYE7fbESpSPbCxHFsBRze4M
 cVaDi7VdHzR3zEyPpaWlFBieZyeXyxLboPAUYBqeXQZR0OKVdqyFk/Wo6AD9pmonTLcNUHdoB+P
 uJ5lrKEc37WmG3TO/isd04hPE0hk/DM9+JBX
X-Google-Smtp-Source: AGHT+IGvSJ2Km+HFqFpAav1RHkXuAVWylo8G7mfdzhruKMHNZdL+gDFnSm3LP5obSV9x45iridxtXQ==
X-Received: by 2002:a05:6830:348c:b0:718:9f3e:6bcb with SMTP id
 46e09a7af769-71d65c9f888mr15854279a34.10.1733065585062; 
 Sun, 01 Dec 2024 07:06:25 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/67] target/arm: Convert disas_add_sub_reg to decodetree
Date: Sun,  1 Dec 2024 09:05:12 -0600
Message-ID: <20241201150607.12812-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

This includes ADD, SUB, ADDS, SUBS (shifted register).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 64 ++++++++++------------------------
 target/arm/tcg/a64.decode      | 11 +++++-
 2 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8f777875fe..d570bbb696 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7912,47 +7912,22 @@ TRANS(SUB_ext, do_addsub_ext, a, true, false)
 TRANS(ADDS_ext, do_addsub_ext, a, false, true)
 TRANS(SUBS_ext, do_addsub_ext, a, true, true)
 
-/*
- * Add/subtract (shifted register)
- *
- *  31 30 29 28       24 23 22 21 20   16 15     10 9    5 4    0
- * +--+--+--+-----------+-----+--+-------+---------+------+------+
- * |sf|op| S| 0 1 0 1 1 |shift| 0|  Rm   |  imm6   |  Rn  |  Rd  |
- * +--+--+--+-----------+-----+--+-------+---------+------+------+
- *
- *    sf: 0 -> 32bit, 1 -> 64bit
- *    op: 0 -> add  , 1 -> sub
- *     S: 1 -> set flags
- * shift: 00 -> LSL, 01 -> LSR, 10 -> ASR, 11 -> RESERVED
- *  imm6: Shift amount to apply to Rm before the add/sub
- */
-static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
+static bool do_addsub_reg(DisasContext *s, arg_addsub_shift *a,
+                          bool sub_op, bool setflags)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 10, 6);
-    int rm = extract32(insn, 16, 5);
-    int shift_type = extract32(insn, 22, 2);
-    bool setflags = extract32(insn, 29, 1);
-    bool sub_op = extract32(insn, 30, 1);
-    bool sf = extract32(insn, 31, 1);
+    TCGv_i64 tcg_rd, tcg_rn, tcg_rm, tcg_result;
 
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn, tcg_rm;
-    TCGv_i64 tcg_result;
-
-    if ((shift_type == 3) || (!sf && (imm6 > 31))) {
-        unallocated_encoding(s);
-        return;
+    if (a->st == 3 || (!a->sf && (a->sa & 32))) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, sf);
-    tcg_rm = read_cpu_reg(s, rm, sf);
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_rn = read_cpu_reg(s, a->rn, a->sf);
+    tcg_rm = read_cpu_reg(s, a->rm, a->sf);
 
-    shift_reg_imm(tcg_rm, tcg_rm, sf, shift_type, imm6);
+    shift_reg_imm(tcg_rm, tcg_rm, a->sf, a->st, a->sa);
 
     tcg_result = tcg_temp_new_i64();
-
     if (!setflags) {
         if (sub_op) {
             tcg_gen_sub_i64(tcg_result, tcg_rn, tcg_rm);
@@ -7961,19 +7936,25 @@ static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
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
 
+TRANS(ADD_r, do_addsub_reg, a, false, false)
+TRANS(SUB_r, do_addsub_reg, a, true, false)
+TRANS(ADDS_r, do_addsub_reg, a, false, true)
+TRANS(SUBS_r, do_addsub_reg, a, true, true)
+
 /* Data-processing (3 source)
  *
  *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
@@ -8348,15 +8329,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     int op3 = extract32(insn, 10, 6);
 
     if (!op1) {
-        if (op2 & 8) {
-            if (op2 & 1) {
-                goto do_unallocated;
-            } else {
-                /* Add/sub (shifted register) */
-                disas_add_sub_reg(s, insn);
-            }
-            return;
-        }
         goto do_unallocated;
     }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b4ccad34fb..4d422a7191 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -718,7 +718,7 @@ XPACD           1 10 11010110 00001 010001 11111 rd:5
 # Logical (shifted reg)
 
 &logic_shift    rd rn rm sf sa st n
-@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5
+@logic_shift    sf:1 .. ..... st:2 n:1 rm:5 sa:6 rn:5 rd:5  &logic_shift
 
 AND_r           . 00 01010 .. . ..... ...... ..... .....  @logic_shift
 ORR_r           . 01 01010 .. . ..... ...... ..... .....  @logic_shift
@@ -726,6 +726,15 @@ EOR_r           . 10 01010 .. . ..... ...... ..... .....  @logic_shift
 ANDS_r          . 11 01010 .. . ..... ...... ..... .....  @logic_shift
 
 # Add/subtract (shifted reg)
+
+&addsub_shift    rd rn rm sf sa st
+@addsub_shift    sf:1 .. ..... st:2 . rm:5 sa:6 rn:5 rd:5  &addsub_shift
+
+ADD_r           . 00 01011 .. 0 ..... ...... ..... .....  @addsub_shift
+SUB_r           . 10 01011 .. 0 ..... ...... ..... .....  @addsub_shift
+ADDS_r          . 01 01011 .. 0 ..... ...... ..... .....  @addsub_shift
+SUBS_r          . 11 01011 .. 0 ..... ...... ..... .....  @addsub_shift
+
 # Add/subtract (extended reg)
 
 &addsub_ext     rd rn rm sf sa st
-- 
2.43.0



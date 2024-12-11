Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1582BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdk-0007LM-Nn; Wed, 11 Dec 2024 11:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcd-0004LT-5n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:35 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPca-0001G6-Uo
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:34 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46677ef6920so7777271cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934692; x=1734539492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Aqe7AiIYBOFmb8LLSvrb79BS28+QL4PQSesWGDIC9U=;
 b=K7O8tsv0T15jU39jSprH/C8K6wMHC3O3aa3pp2PyY4chDN8d9BVlpJTc5+tW3Gwll0
 NF+FLEwBambFDC8qXF6K6/irXCh8BLvu9DKWW/sw4jTYC+4yZ3FgQKc2OwYqCGjdNpv9
 co0/w/gw10/0UXlYEqqXrBAa+ylPm1O3DXOmWzy+E9Ja4uzninLRVsHsKkKxpMewRbJb
 X7ea/wtNOd0dNHH3cE96iXYHS7ZGwHm7+o8tXjYvwWjzgXA8ojShdPeBapEvScJHRpdf
 7TuWEAugGHoV6fKZgDnzf3CiyJaBVaL9s9c4KO+3hie8NDzvxXyOOGalZDP1JRai6cTq
 3bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934692; x=1734539492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Aqe7AiIYBOFmb8LLSvrb79BS28+QL4PQSesWGDIC9U=;
 b=XdZ9bfELgTQzt8aQfJwbhSEk2D67UJQ7L0z2ezghNtCEt8thUqfgq9GhMrIpUh/klN
 NABgTY+vmgHTLrAxbVwPhKZZHphIr+iWqM++6A+jjDROJtjklQBvgzaq9DHKdxz6FQIj
 bI0nHLa0O4eFY7JC0+EEYZV/xbQK3S+5eZKJszWydVb+cr7BeIRKIwfVr1cs/P5QsXHW
 KmjLzCkD6MO9kkLcMGlP/ZccrxdfObZqY58irFJzV687FmiWavgltklgtJLqjbR0l38f
 ex/nEvAtt3U9rVKcra71pc44YMx5mXnnWbo5AwXbfE7Cso+uO0pLqJ4lrA4CcHdJWEtg
 6IPA==
X-Gm-Message-State: AOJu0Ywx9/NeazGiwKbYhLHt4zKE6aHECvs6ELI8EgM6DO3DfAlbzRVQ
 Jm6e/3lzHwamNCr2XMpKnxxzC1V5C0dVh+8j6o+RQUOMg6dah/2x+OpFTpcGegHaAZ5iBH1e62f
 /9FCawr3e
X-Gm-Gg: ASbGncu4RgtOYJfIldmOJ8iX3n2+3vsGKmDjy6pECeX2bpnXgMIgnBWoqvfFQziX3o0
 v1pDLmSVDplLxkmeYBxOvpwvB6MKKwrayWRSfQCZ91bCc+2BQwKt5ti537pWrfzSDOXIndyuhk7
 4/DfRwSPfmW0LUPAFasLub49W9hhLMmUThuh+U+uvQLNB23+6gWZ2kB4cGREft+5amLt3EgbW0w
 40N8aeHsRKw/ThfdNGQBTl3vh3aUMub3rt/KcqjP+QtqHdmMVEYA0UQL83JkQ==
X-Google-Smtp-Source: AGHT+IHB7zorNESAoS4hqJfzNXWnmko4Bjc3E1uvt7930aP4knhU1ftoBYVlVA601hliMkflEbKBJQ==
X-Received: by 2002:ac8:5ad1:0:b0:465:2fba:71b5 with SMTP id
 d75a77b69052e-46789527242mr56873671cf.13.1733934691947; 
 Wed, 11 Dec 2024 08:31:31 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 12/69] target/arm: Convert disas_add_sub_ext_reg to
 decodetree
Date: Wed, 11 Dec 2024 10:29:39 -0600
Message-ID: <20241211163036.2297116-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

This includes ADD, SUB, ADDS, SUBS (extended register).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 65 +++++++++++-----------------------
 target/arm/tcg/a64.decode      |  9 +++++
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecc8899dd8..8f777875fe 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8e2949d236..0539694506 100644
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
-- 
2.43.0



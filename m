Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A28C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtB-0003Pc-DA; Tue, 07 May 2024 10:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsj-0003BP-Pc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4LsY-0001M6-PY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ee38966529so12455005ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092392; x=1715697192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T0/wwsmOrIFP2k0lfcZhLa1SDoLg5xmY78unAbAeB00=;
 b=kiBd4fz7dJnr7APi4uGHFIVCWk7EDt+/Wll62WpAWG1XwpCwVNKoCXfWWmUMA/+wva
 DQYEUs71DE337OmF5Y2+OUTbd2YmbVC4JCvNjVw2NkXWS5ZEk8mvrl7nzZTdQ19CV9D3
 MES7J3Igu9+DQXeycqGp89BkocsPLZvseuPNMmcghBPUPk6O/F9bJGpqRs80/btvgEbv
 tGX/eHB7u2icFheCd28Gru+mb9j8UbLei52uRVec/XklkZMvP/ka89zvdkcFmxHeL7sp
 571s9/29IAe31FkwiZ4vFT9EOttLkt/LPcQ85y89XIAfXnI7KhEU5wpYih9dsXscemJY
 AwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092392; x=1715697192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0/wwsmOrIFP2k0lfcZhLa1SDoLg5xmY78unAbAeB00=;
 b=boORFZYgIktUgDBZXBb0EriIt4Oo060fzWAKfojMnPYWzUvlcAg8E2daIEEBvQqpR5
 DMNw8ELDy+U/5K2qxAjrWecODxyR+QhU4OixUhUdBnzM+y+fOqErFpufJoXd9yzE50U+
 5qifalERZcVJsWnNs2TzFLi7kkX6TWOEK2uVnBcsgm0pgkNNku7ytOqLGCE/4p9oWOtC
 OvoEet8jQcyBT+6lCniQRAn7NbBNo4vvUefU8lFUK7uWl/YhS3a++bJzE2qICrruxhGE
 3WWBNUwUYByXsGbY6bfeCfmO0zh6+FwiLx6rEx/fc85oRu/P8RLbYh3txAaP4ONR3XNv
 W++A==
X-Gm-Message-State: AOJu0Yxxj2YwwF6PyQ5gZH7jZZi1kqAGTZtf3Dhj5U3MLYAq0CGJ0URS
 Y2QplZDDpExlbIyLDytpFXamL//T4IpmMEAYwmVx28lAfSFq2r0fH7AljZGiN4TaUs7DpQhKLfY
 L
X-Google-Smtp-Source: AGHT+IGZm1S2pNCyxFo/vgXiN2lLokX8duBkNY04YlhT35X7LlypaWahG9QsRSV1KnxRPtwUqrWTgA==
X-Received: by 2002:a17:902:654d:b0:1e8:7906:5be3 with SMTP id
 d9443c01a7336-1ee63167542mr34107525ad.18.1715092392442; 
 Tue, 07 May 2024 07:33:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] tcg/i386: Simplify immediate 8-bit logical vector shifts
Date: Tue,  7 May 2024 07:33:02 -0700
Message-Id: <20240507143309.5528-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

The x86 isa does not have this operation, so we need an expansion.
Use the same algorithm that we use for expanding this vector
operation with integers: perform the shift with a wider type
and then mask the bits that must be zero.

This reduces the instruction count from 5 to 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 61 +++++++++------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c6ba498623..6837c519b0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3769,49 +3769,20 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static void expand_vec_shi(TCGType type, unsigned vece, TCGOpcode opc,
+static void expand_vec_shi(TCGType type, unsigned vece, bool right,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
-    TCGv_vec t1, t2;
+    uint8_t mask;
 
     tcg_debug_assert(vece == MO_8);
-
-    t1 = tcg_temp_new_vec(type);
-    t2 = tcg_temp_new_vec(type);
-
-    /*
-     * Unpack to W, shift, and repack.  Tricky bits:
-     * (1) Use punpck*bw x,x to produce DDCCBBAA,
-     *     i.e. duplicate in other half of the 16-bit lane.
-     * (2) For right-shift, add 8 so that the high half of the lane
-     *     becomes zero.  For left-shift, and left-rotate, we must
-     *     shift up and down again.
-     * (3) Step 2 leaves high half zero such that PACKUSWB
-     *     (pack with unsigned saturation) does not modify
-     *     the quantity.
-     */
-    vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-              tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-    vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-              tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-
-    if (opc != INDEX_op_rotli_vec) {
-        imm += 8;
-    }
-    if (opc == INDEX_op_shri_vec) {
-        tcg_gen_shri_vec(MO_16, t1, t1, imm);
-        tcg_gen_shri_vec(MO_16, t2, t2, imm);
+    if (right) {
+        mask = 0xff >> imm;
+        tcg_gen_shri_vec(MO_16, v0, v1, imm);
     } else {
-        tcg_gen_shli_vec(MO_16, t1, t1, imm);
-        tcg_gen_shli_vec(MO_16, t2, t2, imm);
-        tcg_gen_shri_vec(MO_16, t1, t1, 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, 8);
+        mask = 0xff << imm;
+        tcg_gen_shli_vec(MO_16, v0, v1, imm);
     }
-
-    vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
-              tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t2);
+    tcg_gen_and_vec(MO_8, v0, v0, tcg_constant_vec(type, MO_8, mask));
 }
 
 static void expand_vec_sari(TCGType type, unsigned vece,
@@ -3821,7 +3792,7 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 
     switch (vece) {
     case MO_8:
-        /* Unpack to W, shift, and repack, as in expand_vec_shi.  */
+        /* Unpack to 16-bit, shift, and repack.  */
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
@@ -3874,12 +3845,7 @@ static void expand_vec_rotli(TCGType type, unsigned vece,
 {
     TCGv_vec t;
 
-    if (vece == MO_8) {
-        expand_vec_shi(type, vece, INDEX_op_rotli_vec, v0, v1, imm);
-        return;
-    }
-
-    if (have_avx512vbmi2) {
+    if (vece != MO_8 && have_avx512vbmi2) {
         vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
                   tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v1), imm);
         return;
@@ -4155,10 +4121,11 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 
     switch (opc) {
     case INDEX_op_shli_vec:
-    case INDEX_op_shri_vec:
-        expand_vec_shi(type, vece, opc, v0, v1, a2);
+        expand_vec_shi(type, vece, false, v0, v1, a2);
+        break;
+    case INDEX_op_shri_vec:
+        expand_vec_shi(type, vece, true, v0, v1, a2);
         break;
-
     case INDEX_op_sari_vec:
         expand_vec_sari(type, vece, v0, v1, a2);
         break;
-- 
2.34.1



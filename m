Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC920C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFU-0004xk-Pu; Fri, 04 Jul 2025 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFA-0002m7-0l
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF8-0006rW-3g
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453647147c6so9827645e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646388; x=1752251188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WblDLYF/Cbkd1WD9TY2HvCXMocgLzOeX/KpterAV7/I=;
 b=qGoL8Y+Tgh6AWq27/G8q0owrFs9hDi2nbDLaKzKOwb1iyHT0t3Q7xt3QXt3ROb9RcD
 78IQv+ooCeCVv/44cBju3ZT66uo7FwsNC1xGreYbZIgL+7bCW0hrr18VfwkDvd/VSEdS
 pZXbO5rZIO3nK8IqgSkDQZtfKa0aYk0TiRAQni6QXsJlsfFyqbOkXkJM+djSRdpt2zdz
 DkPvNjdHvFGfi8Uu7FwJnRJGEc4r2cQ6GLytQvlIoVRllMEEyPMurl8HzyrWqNFav/8U
 kEoYiLX8ERLrZFpzdPVgnWbhl9Z4Lll0PKhglOD9P5n+eIhpT0SmP/7t2RL1B8oxiTKk
 CtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646388; x=1752251188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WblDLYF/Cbkd1WD9TY2HvCXMocgLzOeX/KpterAV7/I=;
 b=dqxEZIlYp+TZMCa+GLd41NaJ61oAFel6Oc/oCHTAiTzuY4Mx1/DtnNfmD4YufcPtUP
 Afd1AjsljZi1bLVOsZiy2ECUzAghlAPuU4uzxJEw7zMHz6qt8ne0HewIQ1cYNcGC72T+
 iK3R4ijXgVqwlxnafSVGbpxzV1iko0UvcCoRRpSH9S8Q6R27k2ut1xJD4lruwxX4AoVs
 2ry2XWpkwb6ckihAVVsRlKPlXi6SYMzhxzaUf/oZ99iUrenG/tWGR83NUfNhRgTRcs07
 76snraDbC5JyNK8gbeu7dzJS72pJQIZmJNOo5A3uf5Pbt5ISL8zsCnLgNvTmz3k+IMWS
 Mv0A==
X-Gm-Message-State: AOJu0YynqZyta/oyiHcbEmdg177JgMiNLi7nc0RsjBwn4M0Q8D+1laLS
 6ZC20de/BBnPdAPzOfFbRbPYtGmZfh7XkyZ7o0ZXUjcYqJk8g+XKkg2I5sVXOz2mm2yZ4Y9ltsd
 7jyLF
X-Gm-Gg: ASbGncvKqXSo8WlwQ/1SAsOC/PjOujpfPfCDOZdL7Q/qQoAcKUwpfB1tEfcXPedCPsW
 7xadifYHXkF2XQD21OwH+0yt/mqFp4+b3JVM5WzOwkXSCUmjm+Pe1JwwNvfAQKRWKQsyYiKiDsf
 Bd1qXU2MDgsnuWF2+FW/9s/JnJZpiZmrD0vu1FThqWkOqByWH11H97DhCExGnOHud5a7nMnoCYs
 OCmGkkcYEyaZCgbzVu0WPhN0G8nF8MBMqW1tLZpE03b2+f9afSXSMBTToQIJMijlcnOWvbLB6XF
 RkfkqS38vLmRsxyDzxis6QzV0oZnv5r6tMxzZ4hbYFIDjtZPbkC/z4eiGpGwX/0HgHpr
X-Google-Smtp-Source: AGHT+IFHoW7/iXEQCwFQipqd4BpXeC2hBohQfmPOozDyPvJZrhuh3uLliMOPJiVLhD7EjUZ92MY/rg==
X-Received: by 2002:a05:6000:4714:b0:3a5:8d0b:600c with SMTP id
 ffacd0b85a97d-3b4964f368bmr3225741f8f.3.1751646388497; 
 Fri, 04 Jul 2025 09:26:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 090/119] target/arm: Implement SVE2p1 WHILE (predicate pair)
Date: Fri,  4 Jul 2025 17:24:30 +0100
Message-ID: <20250704162501.249138-91-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-79-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 +++
 target/arm/tcg/sve.decode      |  8 +++++++
 target/arm/tcg/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 14 ++++++++----
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 0b1b5887834..eac23e75b9b 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -941,6 +941,9 @@ DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve_while2l, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(sve_while2g, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+
 DEF_HELPER_FLAGS_4(sve_subri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c90d975ebf7..968b2a57e97 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -796,6 +796,14 @@ WHILE_gt        00100101 esz:2 1 rm:5 000 sf:1 u:1 0 rn:5 eq:1 rd:4  &while
 # SVE2 pointer conflict compare
 WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
 
+# SVE2.1 predicate pair
+%pd_pair        1:3 !function=times_2
+@while_pair     ........ esz:2 . rm:5 .... u:1 . rn:5 . ... eq:1 \
+                &while rd=%pd_pair sf=1
+
+WHILE_lt_pair   00100101 .. 1 ..... 0101 . 1 ..... 1 ... .  @while_pair
+WHILE_gt_pair   00100101 .. 1 ..... 0101 . 0 ..... 1 ... .  @while_pair
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b8f3fbb816c..30394f4880e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4139,6 +4139,26 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
+uint32_t HELPER(sve_while2l)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    count <<= esz;
+    memset(d, 0, 2 * sizeof(*d));
+    if (count <= oprbits) {
+        do_whilel(&d[0], esz_mask, count, oprbits);
+    } else {
+        do_whilel(&d[0], esz_mask, oprbits, oprbits);
+        do_whilel(&d[1], esz_mask, count - oprbits, oprbits);
+    }
+
+    return pred_count_test(2 * oprbits, count, false);
+}
+
 /* D must be cleared on entry. */
 static void do_whileg(ARMPredicateReg *d, uint64_t esz_mask,
                       uint32_t count, uint32_t oprbits)
@@ -4172,6 +4192,26 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, true);
 }
 
+uint32_t HELPER(sve_while2g)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    count <<= esz;
+    memset(d, 0, 2 * sizeof(*d));
+    if (count <= oprbits) {
+        do_whileg(&d[1], esz_mask, count, oprbits);
+    } else {
+        do_whilel(&d[1], esz_mask, oprbits, oprbits);
+        do_whileg(&d[0], esz_mask, count - oprbits, oprbits);
+    }
+
+    return pred_count_test(2 * oprbits, count, true);
+}
+
 /* Recursive reduction on a function;
  * C.f. the ARM ARM function ReducePredicated.
  *
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index cb60b533e9f..de6ffe75114 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3109,7 +3109,8 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 }
 
 typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
-static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
+static bool do_WHILE(DisasContext *s, arg_while *a,
+                     bool lt, int scale, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3164,7 +3165,7 @@ static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
         }
     }
 
-    tmax = tcg_constant_i64(vsz >> a->esz);
+    tmax = tcg_constant_i64((vsz << scale) >> a->esz);
     if (eq) {
         /* Equality means one more iteration.  */
         tcg_gen_addi_i64(t0, t0, 1);
@@ -3205,8 +3206,13 @@ static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
     return true;
 }
 
-TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, gen_helper_sve_whilel)
-TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, gen_helper_sve_whileg)
+TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, 0, gen_helper_sve_whilel)
+TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, 0, gen_helper_sve_whileg)
+
+TRANS_FEAT(WHILE_lt_pair, aa64_sme2_or_sve2p1, do_WHILE,
+           a, true, 1, gen_helper_sve_while2l)
+TRANS_FEAT(WHILE_gt_pair, aa64_sme2_or_sve2p1, do_WHILE,
+           a, false, 1, gen_helper_sve_while2g)
 
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
-- 
2.43.0



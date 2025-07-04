Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF4C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhT4-0000nn-Dp; Fri, 04 Jul 2025 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMF-0004pj-B1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:47 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMA-0008EG-LE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:43 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c09f8369cso380270a34.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639136; x=1752243936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEEu9uAFVYBdsgUoug4RC8XfISDvGXxH1AhvjO6N2iQ=;
 b=TcDn21v9hOR91EfTUx5SR5z1seuudEnuAXSvKpvycNqppp0E9dYSsDlv92N6OZ6+Cw
 TB+9akZMKmTucfKXmxLbujQwYOzAr5yx24hxjnpAQW/QwkBZ1dJxYJFoboSkeP2UrnFG
 jmCfz/6jB+CC9XwSOT6mHZGf9fJ9ySUI7SHfqgfCjb1/QeKdtc/EU2IlYsZzfUK1wm2N
 EMB97/PTT7GvtxRKzKjtXE8EVhZFbvI2O6DJPU4eMXVGSVk3hG4vngZYVA02HlVBJg9I
 MKSa5XlCjunZY456j2WXTAiuRmlgheWONSQ+APyiWWyMV3DyjWV7wenrcgy3XLJJ/64c
 1DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639136; x=1752243936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEEu9uAFVYBdsgUoug4RC8XfISDvGXxH1AhvjO6N2iQ=;
 b=H8UNfjWra7ezzXhVZ3yLoeaNVn8Omp/Hm+wWGWi3rYpVrEcljQlKxV1WYl9EG1ci7e
 U2u+QdPAWbpklYeu3GTpaZFZSZcCB5UMc7MDA9CbzPS+YYBNFxRVV4tf5DhRSTyiebCK
 HUw3E1tpXGSzw0sEV9U/4kzS33ewKuD9eLIB0s6GklELx8PhqQk1/vcyj8XfVfbSBXeO
 AzcqgQOG0WqiHuQIriQQ+2r9k+ZU4/SDJPboyq7KL7IKbv0umKPJFqk4m1t7VjLapVZq
 xKESbu1qj+dyT1DiWkVnxfgXPLRnx8OaXqoTzUqxviXOHNOPQjOwxoSfLtw02XmzPwAH
 mTlw==
X-Gm-Message-State: AOJu0YzQjhJ4CiNRVNNMNqVWIde/6bW7lv234L4RZhlV1tLykRYBg0ng
 O8ndOOuTZSgVEz1StRw2pQz7eHqpP5EwKoUZB2fnD51QtddXhyfFPrVTpduTjmc3Mk4guIVzXf4
 6kDfSmNY=
X-Gm-Gg: ASbGncudpMlvu7O87y+YGHuVNJ1KpSRGgsU1lJKPqUTHDb44I2T35ZwWTUxLdKIeGCT
 Hx77Aezz+/APKhgkE55YZAzaXSoRCKaq/3TzF//WAC/LqciYnCfuYgCQnL/6v5LipsbxGdICWdc
 jG6gsqCSJw2nrr24btxLIEYkVE7kw2qxFoOW2SuxwCoT8mgc8+HqXs6jl9EyFFfN2sdo88xA9ur
 UOvU+53sch1wDZbNbWAxGazCbZtwBXKTQqqHa3VsDHxdtXTh/E8BbadaEvLI7Vi3HoIDvIQGUZW
 ALf7G1dett9vU1zDguAQhWae+BfQATfaUVORJot0uffh/ktwe4Ohi2Y0qukTLEE3a902H+Eb3G+
 UWVrVptnSr+VPtZ70biE3hG8tBxH2n0nar/IJ43aj/FT0i09I6ZPfEfF4hLE=
X-Google-Smtp-Source: AGHT+IG+ItawP1c1bJEvGUSZFNLoGTiow0wr9WEqIIEls9p5wczfk5t0gTLlPQlh/jtPi1Dc5Xq5wg==
X-Received: by 2002:a05:6830:7190:b0:73a:6904:1b46 with SMTP id
 46e09a7af769-73ca48c9cb6mr1822689a34.8.1751639136186; 
 Fri, 04 Jul 2025 07:25:36 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 079/108] target/arm: Implement SVE2p1 WHILE (predicate as
 counter)
Date: Fri,  4 Jul 2025 08:20:42 -0600
Message-ID: <20250704142112.1018902-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 ++
 target/arm/tcg/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 22 ++++++++++----
 target/arm/tcg/sve.decode      | 11 +++++++
 4 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index eac23e75b9..74029c641b 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -944,6 +944,9 @@ DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_while2l, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_while2g, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve_whilecl, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(sve_whilecg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+
 DEF_HELPER_FLAGS_4(sve_subri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 30394f4880..713642d4c8 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4090,6 +4090,29 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+/* C.f. Arm pseudocode EncodePredCount */
+static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
+                                  uint32_t esz, bool invert)
+{
+    uint32_t pred;
+
+    if (count == 0) {
+        return 0;
+    }
+    if (invert) {
+        count = elements - count;
+    } else if (count == elements) {
+        count = 0;
+        invert = true;
+    }
+
+    pred = (count << 1) | 1;
+    pred <<= esz;
+    pred |= invert << 15;
+
+    return pred;
+}
+
 /* C.f. Arm pseudocode PredCountTest */
 static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
 {
@@ -4159,6 +4182,21 @@ uint32_t HELPER(sve_while2l)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(2 * oprbits, count, false);
 }
 
+uint32_t HELPER(sve_whilecl)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t pl = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t scale = FIELD_EX32(pred_desc, PREDDESC, DATA);
+    uint32_t vl = pl * 8;
+    uint32_t elements = (vl >> esz) << scale;
+    ARMPredicateReg *d = vd;
+
+    *d = (ARMPredicateReg) {
+        .p[0] = encode_pred_count(elements, count, esz, false)
+    };
+    return pred_count_test(elements, count, false);
+}
+
 /* D must be cleared on entry. */
 static void do_whileg(ARMPredicateReg *d, uint64_t esz_mask,
                       uint32_t count, uint32_t oprbits)
@@ -4212,6 +4250,21 @@ uint32_t HELPER(sve_while2g)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(2 * oprbits, count, true);
 }
 
+uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t pl = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t scale = FIELD_EX32(pred_desc, PREDDESC, DATA);
+    uint32_t vl = pl * 8;
+    uint32_t elements = (vl >> esz) << scale;
+    ARMPredicateReg *d = vd;
+
+    *d = (ARMPredicateReg) {
+        .p[0] = encode_pred_count(elements, count, esz, true)
+    };
+    return pred_count_test(elements, count, true);
+}
+
 /* Recursive reduction on a function;
  * C.f. the ARM ARM function ReducePredicated.
  *
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index de6ffe7511..c93dca224c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3110,7 +3110,7 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 
 typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
 static bool do_WHILE(DisasContext *s, arg_while *a,
-                     bool lt, int scale, gen_while_fn *fn)
+                     bool lt, int scale, int data, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3196,6 +3196,7 @@ static bool do_WHILE(DisasContext *s, arg_while *a,
 
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+    desc = FIELD_DP32(desc, PREDDESC, DATA, data);
 
     ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(ptr, tcg_env, pred_full_reg_offset(s, a->rd));
@@ -3206,13 +3207,24 @@ static bool do_WHILE(DisasContext *s, arg_while *a,
     return true;
 }
 
-TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, 0, gen_helper_sve_whilel)
-TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, 0, gen_helper_sve_whileg)
+TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE,
+           a, true, 0, 0, gen_helper_sve_whilel)
+TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE,
+           a, false, 0, 0, gen_helper_sve_whileg)
 
 TRANS_FEAT(WHILE_lt_pair, aa64_sme2_or_sve2p1, do_WHILE,
-           a, true, 1, gen_helper_sve_while2l)
+           a, true, 1, 0, gen_helper_sve_while2l)
 TRANS_FEAT(WHILE_gt_pair, aa64_sme2_or_sve2p1, do_WHILE,
-           a, false, 1, gen_helper_sve_while2g)
+           a, false, 1, 0, gen_helper_sve_while2g)
+
+TRANS_FEAT(WHILE_lt_cnt2, aa64_sme2_or_sve2p1, do_WHILE,
+           a, true, 1, 1, gen_helper_sve_whilecl)
+TRANS_FEAT(WHILE_lt_cnt4, aa64_sme2_or_sve2p1, do_WHILE,
+           a, true, 2, 2, gen_helper_sve_whilecl)
+TRANS_FEAT(WHILE_gt_cnt2, aa64_sme2_or_sve2p1, do_WHILE,
+           a, false, 1, 1, gen_helper_sve_whilecg)
+TRANS_FEAT(WHILE_gt_cnt4, aa64_sme2_or_sve2p1, do_WHILE,
+           a, false, 2, 2, gen_helper_sve_whilecg)
 
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 968b2a57e9..389a72d824 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -59,6 +59,8 @@
 
 %rn_ax2         6:4 !function=times_2
 
+%pnd            0:3 !function=plus_8
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
@@ -804,6 +806,15 @@ WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
 WHILE_lt_pair   00100101 .. 1 ..... 0101 . 1 ..... 1 ... .  @while_pair
 WHILE_gt_pair   00100101 .. 1 ..... 0101 . 0 ..... 1 ... .  @while_pair
 
+# SVE2.1 predicate as count
+@while_cnt      ........ esz:2 . rm:5 .... u:1 . rn:5 . eq:1 ... \
+                &while rd=%pnd sf=1
+
+WHILE_lt_cnt2   00100101 .. 1 ..... 0100 . 1 ..... 1 . ...  @while_cnt
+WHILE_lt_cnt4   00100101 .. 1 ..... 0110 . 1 ..... 1 . ...  @while_cnt
+WHILE_gt_cnt2   00100101 .. 1 ..... 0100 . 0 ..... 1 . ...  @while_cnt
+WHILE_gt_cnt4   00100101 .. 1 ..... 0110 . 0 ..... 1 . ...  @while_cnt
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
-- 
2.43.0



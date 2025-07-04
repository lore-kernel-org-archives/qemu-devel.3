Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B7C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGv-0000dv-AF; Fri, 04 Jul 2025 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFE-00034y-26
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF9-0006rp-5n
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so950944f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646390; x=1752251190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m48sV9gW34cerkTvGT9yo8EwWXs9OIOJjkLcYx4eJTo=;
 b=LXwaSge2YTTpnXYSjyarFrPa42VdaCDKZycPg9gt3D/wH4LbqxA+B6d85+sHqz3oOB
 1vc5vReURsW6vcd4L4gRs+TuYpkpJ9vpIe16/hfvd1K6wqoAwzXLM1g5Y1eqAkbn7rao
 UrNb6F3Lcp4R7awPdylQ6J34yySM6eo1JXWw4EBOFWa51EXIOHvVNNFTj5fgXb7wXMqP
 23fLzT3OetOqxx6nLe1Z9OhukxByLhxrJ/p8fQ6XNxnF3t08uKVRBYJqhDWBbYgHwhDQ
 B2F8QJI1XpwSIMsfX0E5zhbBpEyNvOT8vOQmFYWSCQ5VNqjvAe7w1eWCiNfZEVXcVsgz
 /K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646390; x=1752251190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m48sV9gW34cerkTvGT9yo8EwWXs9OIOJjkLcYx4eJTo=;
 b=Wj83cALZI0dt2lnMhARsV/f8EySj1RxywxrqdMaq8u0/ccWlrkH/OoymRQyqu+SthQ
 ET7ubbWCcJQGRx7TnRVWPMKsFLyjyB+vOmbxCutHZHAsDB9WgH4R/TG2TS5GCGBgjnpq
 a1Sws1yx1EFnS6+H4cqRpo5+VE3YVlrsi4FoADtkwJZFYUNeyL7ARaNmSKdYJGCgXnBj
 hRcFgPc7siklhYN4gIJfDOnW02S3cFlXtMeUsMj4R7ERohdIh5Jn1nMEOH1WWZUa29DF
 RcZEdvVpqTSpLP+cRJqYT2K+7N2cxsnODCgMo1TzxDe/4rx0sHffRbOxQsucRiZMlSfq
 MVGw==
X-Gm-Message-State: AOJu0YwAXev2U8EWWMyoJ4k7kKZQDYn/Oa6Q0qRnoW8tEZ9kLdheiE6V
 z4+W13Upoo+HPKOitzHhNezm1jp+uU9cOfk5QBy8OoTY/wHwpEPSnwSFw00y8rbj1lMAWwLXi0F
 gG9Vd
X-Gm-Gg: ASbGncs+ZOSh7cidd5lou4+jEDp/a1z3YJ3SihoKVB71yUULCUSvKHLLvcF4eACKc3m
 0J7kZszKas4FyK9Lp5LstO1rezzNjixikzLqVunSQ+jG750pBWRZKF/nwjtMb2tZEOF932g0eLQ
 Dt/8Rxb0U9Twg2xLxZV7erqJwDfuahiv19vBrERkeGX8Eqz/z1Utf89pvtbEefhxIYv8jjzP5P0
 yIfh5emiUadlMz3xDTPVnYlQgxvzsb+p8tPBtD7Ucpr4GG7z0CZbX+FkDwVIXxqmCxsLFyVVTEr
 ybqwd/upHaNIS7WH65ArtCa90yUYqJBB5Uoj3XQmc75v0RqjLf948FO6ghF20NrkER04
X-Google-Smtp-Source: AGHT+IHj8JJOZ2BHmJlQig0UNN8/4vb4/kogXYun+BxDEOe8/YWfh3hlLHqJ1Om+LkeApeew+9VoiQ==
X-Received: by 2002:a5d:5f50:0:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3b4964f4df6mr2724316f8f.5.1751646389665; 
 Fri, 04 Jul 2025 09:26:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 091/119] target/arm: Implement SVE2p1 WHILE (predicate as
 counter)
Date: Fri,  4 Jul 2025 17:24:31 +0100
Message-ID: <20250704162501.249138-92-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20250704142112.1018902-80-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 ++
 target/arm/tcg/sve.decode      | 11 +++++++
 target/arm/tcg/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 22 ++++++++++----
 4 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index eac23e75b9b..74029c641bb 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 968b2a57e97..389a72d8242 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 30394f4880e..713642d4c89 100644
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
index de6ffe75114..c93dca224ce 100644
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
-- 
2.43.0



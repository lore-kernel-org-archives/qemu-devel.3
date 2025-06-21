Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF0BC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83G-0005YQ-8E; Sat, 21 Jun 2025 19:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Z-00030Y-U3
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82X-0005Ex-In
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b31d8dd18cbso3210023a12.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550068; x=1751154868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Po7ui2Tn5JOW7Osl/wUvf33T7pYaJNFCyJOETEletY4=;
 b=yD030V+D7oSl/azDO0gBEc89nrtTX1zC4s0UQMpHJwbw8Tm3L7NL/x6KqXUBAwjlsk
 +TtBs3HYscDCvFV9MJh5gOlfkeLqNKs2CGnNh6o+xwIoK547xV0ImgAubSumcCBvS9vR
 /XjHPo94h3rN2RIX3Bi010W2oJMFWGOoexWrSsEjR5C6zuTzXl21wEpM4Ci6Oazpwq56
 xVdoFs+nx+o2Mr2CYj5AgTAzirra/upmQFXYRjOcfDJvibN9lUW++KGB2wrH7qOJZioI
 5Xn409O2bdfDoVHWE8CdI2UAXHIWPjFZHxRZFFKIWn4a5utvUPMKcyd3O7MEViWA9gX4
 83Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550068; x=1751154868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Po7ui2Tn5JOW7Osl/wUvf33T7pYaJNFCyJOETEletY4=;
 b=HG4LNlne6d2+YOzdCkF17scHOgzNtHaKCHp2kU8JOaNSw7M01WVlJ78Qz5HwezSiZP
 hIzH9r9tZc+y8Q7WvbN60LHZxVSwN6Yp9dBnnY5nxGH6pxNGvkloG6ZAtR720iSdlZ9/
 zwB1u5O5pl+upXrA2tVlqRTA2AVGaWPWlA3tluNQG831/tfXLuWoSvEay3OtiG43cyO+
 bkjmSH40kedUQqWA2iKHUacJjwMPiudNM88ebRjZWz7RPi+h3kyWkb5DcGSPrz6dqHe2
 cJB7iJ112BfzojbQ42cKua1syMwz59O+4nr1jDHhSHoVMUjPoZGgLUQw/ghKgg19xYku
 7IVA==
X-Gm-Message-State: AOJu0YyZ3hqauTWPNBSeho+n75s51QqNdgUeEkOx1/ZY2AwyZRQlEyuN
 qrYhq2qSn6OCnANbAD1pPkZNw45XLho0ma7mdg0FzdpNebqw8alsymlKJ0wwh3IFYKClN0NgIIo
 2T8XQpNU=
X-Gm-Gg: ASbGncv2RkMGe+1fqTPJE0YiHH0CvnNpmO3iholBbnCR7H0Y+Uha44AUNkW3qpOxE6w
 rxEPc859vSgx0oyIvRAgja/Tips09nG6JNcTUqcMlQ9KfqRnoNClu9b4OslQXrtBVQxUTyfLSMR
 mZ/PEHxHen+f+lVY0zOcmOjfdVxVklVxX4VKKeHCHq8qARAf2eHvcEOge7zjvIv6dGCcuEl6kLm
 3F77Je8yMb2EzF4a+cMmMWG1UOqTMtxHWK+YeTPwPqXkm+3BbeV2yb+884Z1ah5Cxc5KfM+3V2q
 eujin2RMvPEXaAXJB9iB7VaZpLM1iJJ8SQTnMbP88EK5Nva8suhY6WM8atEx+hHCQKx7b+wDAg8
 CltcXwf4LnJX3AEqqfkH8
X-Google-Smtp-Source: AGHT+IECQU/lrG1j5uihJH9SsZiVa8oMnl12B4zPOPaqjDLSDcHSPCGxW4VhM2Pgb0DamnwyZFGcig==
X-Received: by 2002:a05:6a21:348b:b0:220:103c:436c with SMTP id
 adf61e73a8af0-22026ec5114mr12585214637.24.1750550067907; 
 Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 077/101] target/arm: Implement SVE2p1 WHILE (predicate as
 counter)
Date: Sat, 21 Jun 2025 16:50:13 -0700
Message-ID: <20250621235037.74091-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 +++
 target/arm/tcg/sve_helper.c    | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 22 +++++++++++----
 target/arm/tcg/sve.decode      | 11 ++++++++
 4 files changed, 80 insertions(+), 5 deletions(-)

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
index 2beb012292..dfc3e5cabe 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4096,6 +4096,29 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
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
@@ -4179,6 +4202,19 @@ uint32_t HELPER(sve_while2l)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(2 * oprbits, count, false);
 }
 
+uint32_t HELPER(sve_whilecl)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t scale = FIELD_EX32(pred_desc, PREDDESC, DATA);
+    uint32_t elements = (oprsz >> esz) << scale;
+    ARMPredicateReg *d = vd;
+
+    do_zero(d, oprsz);
+    d->p[0] = encode_pred_count(elements, count, esz, false);
+    return pred_count_test(elements, count, false);
+}
+
 static void do_whileg(uint64_t *d, uint64_t esz_mask,
                       uint32_t count, uint32_t oprbits)
 {
@@ -4234,6 +4270,19 @@ uint32_t HELPER(sve_while2g)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(2 * oprbits, count, true);
 }
 
+uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t scale = FIELD_EX32(pred_desc, PREDDESC, DATA);
+    uint32_t elements = (oprsz >> esz) << scale;
+    ARMPredicateReg *d = vd;
+
+    do_zero(d, oprsz);
+    d->p[0] = encode_pred_count(elements, count, esz, true);
+    return pred_count_test(elements, count, true);
+}
+
 /* Recursive reduction on a function;
  * C.f. the ARM ARM function ReducePredicated.
  *
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c2a5b2f76f..3e82c1ed49 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3093,7 +3093,7 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 
 typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
 static bool do_WHILE(DisasContext *s, arg_while *a,
-                     bool lt, int scale, gen_while_fn *fn)
+                     bool lt, int scale, int data, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3179,6 +3179,7 @@ static bool do_WHILE(DisasContext *s, arg_while *a,
 
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+    desc = FIELD_DP32(desc, PREDDESC, DATA, data);
 
     ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(ptr, tcg_env, pred_full_reg_offset(s, a->rd));
@@ -3189,13 +3190,24 @@ static bool do_WHILE(DisasContext *s, arg_while *a,
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
index a919fe117b..fbc4487b06 100644
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



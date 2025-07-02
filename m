Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B7C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwnO-0000OS-GY; Wed, 02 Jul 2025 08:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjp-0004gM-Gc
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:59 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjZ-0002Cu-Dl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:56 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so4783660fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459920; x=1752064720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agWht1TtFZD9FvY9g9OkzAozp1ScoD+4OlrihO2XdT8=;
 b=JUOJRZ46QyjzHd6gStPvJp2JQU2PXMccEdCL+Av3UKJ/lC5LQXEsiLeVxruf1W+21V
 sJKvgLRPub+lJjSfIH5tLbThaXkzqyawUlEFmge1PmM2WOqQunzq/Dn3JgzV0OwgM69d
 EJQm+U0ijqJoU+CGGGIrB7u/KB2kkEgmh2WXEOAO5aFVS5B0WdBUqZg/LKBZ8sY79lw4
 mWD69ruCOJIp30bm++wQY6USNgtwwDcyWG1Ff/kgZmn7+SnGw31VWDllgyFGxePQAfPQ
 2NhSgaN8T45ZiWuUxkM+TSTVg+UvsXxke7xQtTXicA3IDz8JdwA4HdrfIZMe9CEv29YH
 7YLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459920; x=1752064720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agWht1TtFZD9FvY9g9OkzAozp1ScoD+4OlrihO2XdT8=;
 b=LI87Fgn3Yi5hDyqaebus25z4ClqpBuBaOE5Xs8J+iHMf3ZmUI/Am94WLVL47qLzTtu
 U2xO7wzi+VHfiLRCs5yDVrou4yDo4v5cSjWiiH5sRdJALb04muIQ+iFkRYlJuppQ+3po
 wVaWFMHNExJCrSSGmkuIe2Gy4NBNT7H3YeGu0CL5cLmV/9+3Mhfab2tHbAA4GKFUyQ7T
 unXQulv035GCt8pI24SwxkKpe2025DTdG5shKPP8adYPfo9ComFUTL7my8/CWDpYOk1Z
 Vo2WXcbNw+uIA7IWv8EFMSILkgGM13/976O1HVTFDYXccjopKCyW3m304pU6+LZ3qixa
 dL+w==
X-Gm-Message-State: AOJu0YwL13iN2ktVeAIk4TslKWQWZmU3vc3rvWQMUhvmZY6wfedXSl8E
 Cimrvjz2kAxJWula09JxK4Od0AOx1mfVZkr+CpcyWDcCGIPAX2M4gjYCv0Fx3I7hSGrJei8Va0g
 jGi96Rr0=
X-Gm-Gg: ASbGncurTyowiEqJj14J6NfI6RkAWKYkRx+x78dOwY/rklEYhtPtpNdlkU/LKlbjS6p
 8dd5YEhrV7X5MjfFT5vmXhyz43aE2TymyFmAV46b3P2CKafOM7xSjhNigljLHIdgL97p+cVixVj
 pmQfa0zYxL9CD5keh9yNo4D2NaS7lvF1FzETVk301BdV6peBNKYA6w+4fT43ItWQcjuzdM4Fydd
 luWzyODhkZ3rOXWexxOTjs95h/ao8iUURwOwSx2AowwoYg8XQ4Ro3fhkyHCWmpwwnhZ/h9xWeQo
 8XkPjBhgJ7xG8JC+SUQoREzWeG+1bFokumdsN+wj7Iw5qAuqkRS66dCxihBQmdRtK77WoA==
X-Google-Smtp-Source: AGHT+IFTe+PM98lOsComt1T05w5TXAmNTLqRLt9xf7ozLrixK7QW9DWE0Fi2WsK1HMtBlr8LcR6gOg==
X-Received: by 2002:a05:6871:a403:b0:2df:a9d0:1dc9 with SMTP id
 586e51a60fabf-2f5a8c677f6mr1813940fac.37.1751459919782; 
 Wed, 02 Jul 2025 05:38:39 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 68/97] target/arm: Implement SVE2p1 WHILE (predicate as
 counter)
Date: Wed,  2 Jul 2025 06:33:41 -0600
Message-ID: <20250702123410.761208-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 ++
 target/arm/tcg/sve_helper.c    | 51 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 22 +++++++++++----
 target/arm/tcg/sve.decode      | 11 ++++++++
 4 files changed, 82 insertions(+), 5 deletions(-)

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
index 2aec963f74..f5fbfb751e 100644
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
@@ -4164,6 +4187,20 @@ uint32_t HELPER(sve_while2l)(void *vd, uint32_t count, uint32_t pred_desc)
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
+    do_zero(d, pl);
+    d->p[0] = encode_pred_count(elements, count, esz, false);
+    return pred_count_test(elements, count, false);
+}
+
 static void do_whileg(uint64_t *d, uint64_t esz_mask,
                       uint32_t count, uint32_t oprbits)
 {
@@ -4218,6 +4255,20 @@ uint32_t HELPER(sve_while2g)(void *vd, uint32_t count, uint32_t pred_desc)
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
+    do_zero(d, pl);
+    d->p[0] = encode_pred_count(elements, count, esz, true);
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DBAC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT86U-0001Uq-BJ; Sat, 21 Jun 2025 19:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85g-0005wY-RS
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:45 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85d-0006ct-HI
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso1903727b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550260; x=1751155060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C1v9kq0leMs7Gn6emRF9KjUBx/QT3DDikw8TAmJ4Lyg=;
 b=M2aFuF9/4VQsMlqXPeezqj+qAYiNQAL/QRk1luZy1+ubAb/MaW5Cc2qyDfN6X44jEH
 uuq776C/IGv6A02d8x9NfIR8tJZnOeUZDparXBXHfLs902wdT77tVLRWCfuphnh1tzt/
 nfgH2gdAYpC/P9+y0GG6zxv7xXpM6ohyf57trvPDJzvfidekMF5/cOxYAIBCplX8LlTN
 tujQNAyc0sZCwIKHps8onC+vXiG0btwjF4Z7gqURDtwr35P96HrAgbe6HMELigwd+4dz
 GikPl2lifih8/ELpNvbjQDPP/Qo9NHIJYBLzK81k07Wv0FrVqkHYqhtwEBcFSv8o49CN
 rxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550260; x=1751155060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1v9kq0leMs7Gn6emRF9KjUBx/QT3DDikw8TAmJ4Lyg=;
 b=nBCpWrEgUHv8oV8uDQMjisNq3iLT0C0WMM0SnMhc4yQHaEd4nTWrShfhK/lqKOfqbg
 dTT1mBGUk4yKJuxDhn6cyHGmpIyJk7OGTVIZCw6zF5NyYozjVGRI2WVL6Fl6PHV5t9+w
 9FxT54GswE5F+7uB05KAnmntZ/qZi4xljwRXhpMfNVbDIGrel2SOVVxp0LWgteUibqhD
 Yb+ET3uUquBwr/C1QceQF/TmvLPhVzHlCsQqKJj56ofN2Ep9Xd+66PN/so3jArN4fz8A
 hejMNjUeQ4Drgq0LuAMqD/i47AcD+cFnvaS7zo6Ie3YFwlrChii/PL1h6UA0mtuz7ZVF
 uCQA==
X-Gm-Message-State: AOJu0YwEqdOqrQlw8UIfDmLPFSV1OMFP4P7eCg3m++0/W0DwbutkxaRz
 VTJU1VW4aDnpcBGfFbuQEbbQ5ghvpzQlgtjT2GYa4O33TF5An4cf8LuGPenA90GBqHBhpfpuyRF
 hpAH2/Dc=
X-Gm-Gg: ASbGncsV1qe2lfW+cG3UHGRGrIKVSuWSkTDntYXRtr2e73FwBqV6vkG73y1VdanAYT6
 CMYEoRjg1V1knW9sLCEI6mMixafi2nfUAPrBwMiohyWrhfDF1ro0QpCN8dF59cdV3WSbbBiD0nC
 3I1xPp70pexLe6awbQli0zQjsL/jadxm+6Lq+Fo2UvuAqy+TFQz7SbhfiVBnGSObVWIjUpSRkYk
 q2QGaLsPtufaZQjBDOwPXWnnrgzxvzyfeRGym4p6VDM6jVcSLltOoiGkqs8SReNITjjv9cIJ7Gn
 mMmff6Sv6SQNUWk4t2JeZAJG5xD7P5urdagct+NPYniykPQ2XrhI7N0wwdQsFt3qGopC9KzqS8O
 lGj4bp2iTc2SpddUpM2H4QbNEt1k2Y20=
X-Google-Smtp-Source: AGHT+IF+XTbmdSi7KUEQ92LSHKkGUW/I6IJXxfC5itXfEGi7jfD6WVnNZ5xfDcPLOiOFCE3NTYJylw==
X-Received: by 2002:a05:6a20:1595:b0:21f:994e:7355 with SMTP id
 adf61e73a8af0-22026debdb0mr13820200637.36.1750550259771; 
 Sat, 21 Jun 2025 16:57:39 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 095/101] target/arm: Implement {LD,
 ST}[234]Q for SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:31 -0700
Message-ID: <20250621235037.74091-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/arm/tcg/helper-sve.h    |  32 +++++++++
 target/arm/tcg/sve_helper.c    |   8 +++
 target/arm/tcg/translate-sve.c | 126 ++++++++++++++++++++++++---------
 target/arm/tcg/sve.decode      |  31 ++++++++
 4 files changed, 162 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 1999c4bb1f..ade76ff664 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1658,6 +1658,14 @@ DEF_HELPER_FLAGS_4(sve_ld2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bdu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1722,6 +1730,14 @@ DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1946,6 +1962,14 @@ DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1998,6 +2022,14 @@ DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st2qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st2qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4qq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 4bccc5b49c..65183692bc 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6744,6 +6744,10 @@ DO_LDN_2(2, dd, MO_64)
 DO_LDN_2(3, dd, MO_64)
 DO_LDN_2(4, dd, MO_64)
 
+DO_LDN_2(2, qq, MO_128)
+DO_LDN_2(3, qq, MO_128)
+DO_LDN_2(4, qq, MO_128)
+
 #undef DO_LDN_1
 #undef DO_LDN_2
 
@@ -7310,6 +7314,10 @@ DO_STN_2(4, dd, MO_64, MO_64)
 DO_STN_2(1, sq, MO_128, MO_32)
 DO_STN_2(1, dq, MO_128, MO_64)
 
+DO_STN_2(2, qq, MO_128, MO_128)
+DO_STN_2(3, qq, MO_128, MO_128)
+DO_STN_2(4, qq, MO_128, MO_128)
+
 #undef DO_STN_1
 #undef DO_STN_2
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1d045625dc..fe4bf6c57c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -89,7 +89,7 @@ static inline int expand_imm_sh8u(DisasContext *s, int x)
  */
 static inline int msz_dtype(DisasContext *s, int msz)
 {
-    static const uint8_t dtype[4] = { 0, 5, 10, 15 };
+    static const uint8_t dtype[5] = { 0, 5, 10, 15, 18 };
     return dtype[msz];
 }
 
@@ -4775,23 +4775,25 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a)
  */
 
 /* The memory mode of the dtype.  */
-static const MemOp dtype_mop[18] = {
+static const MemOp dtype_mop[19] = {
     MO_UB, MO_UB, MO_UB, MO_UB,
     MO_SL, MO_UW, MO_UW, MO_UW,
     MO_SW, MO_SW, MO_UL, MO_UL,
     MO_SB, MO_SB, MO_SB, MO_UQ,
-    MO_UL, MO_UQ,
+    /* Artificial values used by decode */
+    MO_UL, MO_UQ, MO_128
 };
 
 #define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
 
 /* The vector element size of dtype.  */
-static const uint8_t dtype_esz[18] = {
+static const uint8_t dtype_esz[19] = {
     0, 1, 2, 3,
     3, 1, 2, 3,
     3, 2, 2, 3,
     3, 2, 1, 3,
-    4, 4,
+    /* Artificial values used by decode */
+    4, 4, 4,
 };
 
 uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
@@ -4842,7 +4844,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
-static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
+static gen_helper_gvec_mem * const ldr_fns[2][2][19][4] = {
     { /* mte inactive, little-endian */
       { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
           gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
@@ -4870,6 +4872,8 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_le_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_le_r, NULL, NULL, NULL },
+        { NULL,                      gen_helper_sve_ld2qq_le_r,
+          gen_helper_sve_ld3qq_le_r, gen_helper_sve_ld4qq_le_r },
       },
 
       /* mte inactive, big-endian */
@@ -4899,6 +4903,8 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_be_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_be_r, NULL, NULL, NULL },
+        { NULL,                      gen_helper_sve_ld2qq_be_r,
+          gen_helper_sve_ld3qq_be_r, gen_helper_sve_ld4qq_be_r },
       },
     },
 
@@ -4937,6 +4943,10 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_le_r_mte, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_le_r_mte, NULL, NULL, NULL },
+        { NULL,
+          gen_helper_sve_ld2qq_le_r_mte,
+          gen_helper_sve_ld3qq_le_r_mte,
+          gen_helper_sve_ld4qq_le_r_mte },
       },
 
       /* mte active, big-endian */
@@ -4974,6 +4984,10 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
 
         { gen_helper_sve_ld1squ_be_r_mte, NULL, NULL, NULL },
         { gen_helper_sve_ld1dqu_be_r_mte, NULL, NULL, NULL },
+        { NULL,
+          gen_helper_sve_ld2qq_be_r_mte,
+          gen_helper_sve_ld3qq_be_r_mte,
+          gen_helper_sve_ld4qq_be_r_mte },
       },
     },
 };
@@ -4998,16 +5012,26 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
         return false;
     }
 
-    /* dtypes 16 and 17 are artificial, representing 128-bit element */
-    if (a->dtype < 16) {
+    /* dtypes 16-18 are artificial, representing 128-bit element */
+    switch (a->dtype) {
+    case 0 ... 15:
         if (!dc_isar_feature(aa64_sve, s)) {
             return false;
         }
-    } else {
+        break;
+    case 16: case 17:
         if (!dc_isar_feature(aa64_sve2p1, s)) {
             return false;
         }
         s->is_nonstreaming = true;
+        break;
+    case 18:
+        if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     if (sve_access_check(s)) {
@@ -5021,16 +5045,26 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
 
 static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    /* dtypes 16 and 17 are artificial, representing 128-bit element */
-    if (a->dtype < 16) {
+    /* dtypes 16-18 are artificial, representing 128-bit element */
+    switch (a->dtype) {
+    case 0 ... 15:
         if (!dc_isar_feature(aa64_sve, s)) {
             return false;
         }
-    } else {
+        break;
+    case 16: case 17:
         if (!dc_isar_feature(aa64_sve2p1, s)) {
             return false;
         }
         s->is_nonstreaming = true;
+        break;
+    case 18:
+        if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     if (sve_access_check(s)) {
@@ -5542,55 +5576,67 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1dd_be_r_mte,
               gen_helper_sve_st1dq_be_r_mte } } },
     };
-    static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
+    static gen_helper_gvec_mem * const fn_multiple[2][2][3][5] = {
         { { { gen_helper_sve_st2bb_r,
               gen_helper_sve_st2hh_le_r,
               gen_helper_sve_st2ss_le_r,
-              gen_helper_sve_st2dd_le_r },
+              gen_helper_sve_st2dd_le_r,
+              gen_helper_sve_st2qq_le_r },
             { gen_helper_sve_st3bb_r,
               gen_helper_sve_st3hh_le_r,
               gen_helper_sve_st3ss_le_r,
-              gen_helper_sve_st3dd_le_r },
+              gen_helper_sve_st3dd_le_r,
+              gen_helper_sve_st3qq_le_r },
             { gen_helper_sve_st4bb_r,
               gen_helper_sve_st4hh_le_r,
               gen_helper_sve_st4ss_le_r,
-              gen_helper_sve_st4dd_le_r } },
+              gen_helper_sve_st4dd_le_r,
+              gen_helper_sve_st4qq_le_r } },
           { { gen_helper_sve_st2bb_r,
               gen_helper_sve_st2hh_be_r,
               gen_helper_sve_st2ss_be_r,
-              gen_helper_sve_st2dd_be_r },
+              gen_helper_sve_st2dd_be_r,
+              gen_helper_sve_st2qq_be_r },
             { gen_helper_sve_st3bb_r,
               gen_helper_sve_st3hh_be_r,
               gen_helper_sve_st3ss_be_r,
-              gen_helper_sve_st3dd_be_r },
+              gen_helper_sve_st3dd_be_r,
+              gen_helper_sve_st3qq_be_r },
             { gen_helper_sve_st4bb_r,
               gen_helper_sve_st4hh_be_r,
               gen_helper_sve_st4ss_be_r,
-              gen_helper_sve_st4dd_be_r } } },
+              gen_helper_sve_st4dd_be_r,
+              gen_helper_sve_st4qq_be_r } } },
         { { { gen_helper_sve_st2bb_r_mte,
               gen_helper_sve_st2hh_le_r_mte,
               gen_helper_sve_st2ss_le_r_mte,
-              gen_helper_sve_st2dd_le_r_mte },
+              gen_helper_sve_st2dd_le_r_mte,
+              gen_helper_sve_st2qq_le_r_mte },
             { gen_helper_sve_st3bb_r_mte,
               gen_helper_sve_st3hh_le_r_mte,
               gen_helper_sve_st3ss_le_r_mte,
-              gen_helper_sve_st3dd_le_r_mte },
+              gen_helper_sve_st3dd_le_r_mte,
+              gen_helper_sve_st3qq_le_r_mte },
             { gen_helper_sve_st4bb_r_mte,
               gen_helper_sve_st4hh_le_r_mte,
               gen_helper_sve_st4ss_le_r_mte,
-              gen_helper_sve_st4dd_le_r_mte } },
+              gen_helper_sve_st4dd_le_r_mte,
+              gen_helper_sve_st4qq_le_r_mte } },
           { { gen_helper_sve_st2bb_r_mte,
               gen_helper_sve_st2hh_be_r_mte,
               gen_helper_sve_st2ss_be_r_mte,
-              gen_helper_sve_st2dd_be_r_mte },
+              gen_helper_sve_st2dd_be_r_mte,
+              gen_helper_sve_st2qq_be_r_mte },
             { gen_helper_sve_st3bb_r_mte,
               gen_helper_sve_st3hh_be_r_mte,
               gen_helper_sve_st3ss_be_r_mte,
-              gen_helper_sve_st3dd_be_r_mte },
+              gen_helper_sve_st3dd_be_r_mte,
+              gen_helper_sve_st3qq_be_r_mte },
             { gen_helper_sve_st4bb_r_mte,
               gen_helper_sve_st4hh_be_r_mte,
               gen_helper_sve_st4ss_be_r_mte,
-              gen_helper_sve_st4dd_be_r_mte } } },
+              gen_helper_sve_st4dd_be_r_mte,
+              gen_helper_sve_st4qq_be_r_mte } } },
     };
     gen_helper_gvec_mem *fn;
     int be = s->be_data == MO_BE;
@@ -5619,12 +5665,17 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
         }
         break;
     case MO_128:
-        assert(a->msz < a->esz);
-        assert(a->nreg == 0);
-        if (!dc_isar_feature(aa64_sve2p1, s)) {
-            return false;
+        if (a->nreg == 0) {
+            assert(a->msz < a->esz);
+            if (!dc_isar_feature(aa64_sve2p1, s)) {
+                return false;
+            }
+            s->is_nonstreaming = true;
+        } else {
+            if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+                return false;
+            }
         }
-        s->is_nonstreaming = true;
         break;
     default:
         g_assert_not_reached();
@@ -5651,12 +5702,17 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
         }
         break;
     case MO_128:
-        assert(a->msz < a->esz);
-        assert(a->nreg == 0);
-        if (!dc_isar_feature(aa64_sve2p1, s)) {
-            return false;
+        if (a->nreg == 0) {
+            assert(a->msz < a->esz);
+            if (!dc_isar_feature(aa64_sve2p1, s)) {
+                return false;
+            }
+            s->is_nonstreaming = true;
+        } else {
+            if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+                return false;
+            }
         }
-        s->is_nonstreaming = true;
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a8e9b8afec..f481f1479d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -229,6 +229,9 @@
 @rprr_load_dt   ....... dtype:4 rm:5 ... pg:3 rn:5 rd:5         &rprr_load
 @rpri_load_dt   ....... dtype:4 . imm:s4 ... pg:3 rn:5 rd:5     &rpri_load
 
+@rprr_load      ....... .... rm:5 ... pg:3 rn:5 rd:5            &rprr_load
+@rpri_load      ....... .... . imm:s4 ... pg:3 rn:5 rd:5        &rpri_load
+
 @rprr_load_msz  ....... .... rm:5 ... pg:3 rn:5 rd:5 \
                 &rprr_load dtype=%msz_dtype
 @rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
@@ -1267,12 +1270,26 @@ LDNF1_zpri      1010010 .... 1.... 101 ... ..... .....    @rpri_load_dt nreg=0
 # SVE load multiple structures (scalar plus scalar)
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zprr         1010010 .. nreg:2 ..... 110 ... ..... .....     @rprr_load_msz
+# LD[234]Q
+LD_zprr         1010010 01 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=1
+LD_zprr         1010010 10 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=2
+LD_zprr         1010010 11 01     ..... 100 ... ..... ..... \
+                @rprr_load dtype=18 nreg=3
 
 # SVE contiguous non-temporal load (scalar plus immediate)
 # LDNT1B, LDNT1H, LDNT1W, LDNT1D
 # SVE load multiple structures (scalar plus immediate)
 # LD2B, LD2H, LD2W, LD2D; etc.
 LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_load_msz
+# LD[234]Q
+LD_zpri         1010010 01 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=1
+LD_zpri         1010010 10 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=2
+LD_zpri         1010010 11 001 .... 111 ... ..... .....         \
+                @rpri_load dtype=18 nreg=3
 
 # SVE load and broadcast quadword (scalar plus scalar)
 LD1RQ_zprr      1010010 .. 00 ..... 000 ... ..... ..... \
@@ -1383,11 +1400,25 @@ ST_zprr         1110010 11 10     ..... 010 ... ..... ..... \
 # SVE store multiple structures (scalar plus immediate)      (nreg != 0)
 ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
                 @rpri_store msz=%size_23 esz=%size_23
+# ST[234]Q
+ST_zpri         11100100 01 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=1
+ST_zpri         11100100 10 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=2
+ST_zpri         11100100 11 00 .... 000 ... ..... ..... \
+                @rpri_store msz=4 esz=4 nreg=3
 
 # SVE contiguous non-temporal store (scalar plus scalar)     (nreg == 0)
 # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
 ST_zprr         1110010 .. nreg:2 ..... 011 ... ..... ..... \
                 @rprr_store msz=%size_23 esz=%size_23
+# ST[234]Q
+ST_zprr         11100100 01 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=1
+ST_zprr         11100100 10 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=2
+ST_zprr         11100100 11 1 ..... 000 ... ..... ..... \
+                @rprr_store msz=4 esz=4 nreg=3
 
 # SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
 # Require msz > 0 && msz <= esz.
-- 
2.43.0



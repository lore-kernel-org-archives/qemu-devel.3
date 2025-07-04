Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2085CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhU0-0002b0-Sl; Fri, 04 Jul 2025 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMD-0004pU-NF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:46 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM9-0008E1-CK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:41 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6114114daddso500762eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639135; x=1752243935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CY8GPK9LjD5vvFu1A4yXRIWcAh0FAk2ttUM/giYYY2o=;
 b=b2fr6xug8Yd8HH0LGuwEfGrc4BJsGrQvs9FcHyv2PPMJbR2/4a80civbXD7scPm4SW
 /+hVZX9mc6UC4OPAajRFFG7BjzUbs5cHYRCE/S793T/8FuCHvVPPHomnmk5pfv0pn+9X
 ReL17/wW9FQhbGRx092S0JpOKtWyNdyA3LyRXK9xM94LKp7j0uH1UdN2KeT+AfDQXn3G
 P+Wf2vGCekoMZrHc/0z5q43ckh/7OKprGyBZuwesef4fvB9VH43bZN/NiFWxaMW8vVys
 /M7QWCmhCFUH4PrnWClxAiyrrNDcP8VmGHP1hO76vCheXzhum31If+knfXIgSgivhx1h
 E8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639135; x=1752243935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CY8GPK9LjD5vvFu1A4yXRIWcAh0FAk2ttUM/giYYY2o=;
 b=BQk6sT0Y7rsN2t58ByBrMsF3XbvEd2ZoizmrFdWMi/88Xq4jMW+d8S8f1hz38kXKdN
 6xZQ3ivinGuQDko+b+dv+U1X88N61Mg7HClkWzvz8E2IViLXMUtcAodC+tD+S5UCtYum
 NYdRY8oxdojTNBaejN6zM5ezeICFsoHAkZ5Jp+hUTpz5Hmrt2OeAfsrjWaZTeBOXo9Zv
 afpHP0TR112vqEomEJAWMYBV6egiZWK6vJXJ2KNgvRdGP5iyuBcckiXckmz5/lYJPqvu
 PtorrHWuKwaLGtN2Z2ngSYfLTzfTtYQx8nhYbd0lmCZMjZ7vqXIbKjErKyvYOhQF16/a
 ytzg==
X-Gm-Message-State: AOJu0YwAf4ZfrEAQe8An/IwuXQ8QU10VFLT7koh8fJugWF/JKp4Hy3J8
 zMkE8RRUaDn8NzAt6/RR+GPoYL4shG+rdE5fhz2GxdQb15K98w440HVfFmgNx6DXTE00yNMgCQC
 CkgJl5L4=
X-Gm-Gg: ASbGncuFcwskF7f5v3CmMe/0tGVnlD0cM2bdAZX/zCKfqhhIXY2NUMB35quz64yrU/c
 24rpBpD0mVLfoR5fniH8kSi8HFPaEK7ZCMg+CwLrh2SS9VSr3Mj45vR+Q5I1XozzJj68X8FiLWx
 Yixs9ktPTjQTTHcv62TgLus2M560Kje1h7uQHbgJZLTjHY8bc7Fs5jFOgMRAPMr17EZiG5aFaOt
 Uw99sUcTFrzdUbRaX8XWgDkuU0xbOQi0+kF6AJ4o2zG6Bio1H64C3cc5nlNWjEcmJFfIC7FuT0K
 7OpFB1VycuN7fqbQPOSU+S6dZoc3VkU3UPfK9Pxz7RRtccZTX9T4D9iohzJIDKeNo6OsK0eFd/c
 Bjmu/3DSf8qfixzKKsrfV7O1C0RYbl9SNphxl9muDaDnIfarTm7zK80VbgyM=
X-Google-Smtp-Source: AGHT+IGJzOhDMr0P378vuCGmuxu4MVYz/oA/QT8Lv4kI1cc00b/uGQOcUAhyA7rAd/eO213HmC3/0Q==
X-Received: by 2002:a05:6820:1e82:b0:611:befc:38e5 with SMTP id
 006d021491bc7-6138fd6a38cmr2315074eaf.4.1751639135429; 
 Fri, 04 Jul 2025 07:25:35 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 078/108] target/arm: Implement SVE2p1 WHILE (predicate pair)
Date: Fri,  4 Jul 2025 08:20:41 -0600
Message-ID: <20250704142112.1018902-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 target/arm/tcg/helper-sve.h    |  3 +++
 target/arm/tcg/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 14 ++++++++----
 target/arm/tcg/sve.decode      |  8 +++++++
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 0b1b588783..eac23e75b9 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b8f3fbb816..30394f4880 100644
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
index cb60b533e9..de6ffe7511 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c90d975ebf..968b2a57e9 100644
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
-- 
2.43.0



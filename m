Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42C3C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFW6-0001Tv-JW; Tue, 21 Jul 2026 14:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUj-00010n-Sa
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUe-0006bO-8Z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:09 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so9293737a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659622; x=1785264422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yr0+1uE3XRnQmsAuDrDRgd/cXfa470Vk1jdP14xyfUA=;
 b=gw9X9uF96RvGGKSON7A6opiBJRAQ7MN4el7Ah+bTBy8OBH+rZwY+I2+8NJ4juoM9kc
 ku5Lo7phmgCYWR4OQIeRT3vPR0l7w3rNioLwu2jrswxg1XMTAoIlBzEDKZR9J+TKOIdT
 tsbKYvEQoE/lxaZk1Sb75cmFJ2INdDF0DwsLvVL4kcjXgpc3/N4AznY7vwQ6VEhWxKgr
 4uFu19+Y/QMWhsESl+uvz46p8fPWCNhxu/F0k3+SkercPh7x2i2fp1NqayKcrE03aME5
 +hItZTG+F9l4SMOJrMSZdeaHOQ1uPKn5TcjoW6OG0G70HWGW6KU6zL7fGIf7SgSNAKEH
 udZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659622; x=1785264422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yr0+1uE3XRnQmsAuDrDRgd/cXfa470Vk1jdP14xyfUA=;
 b=RTKtrAMSlocIWVy5Wtv8WMNH/LQibwv5cUJQ9BwER4YyDwfpV9lnDqsjx90OSIyNnF
 EtUsIZjIHFSlfyClRh9yBj6BVPrtdq0ZDZ0Zw++7LFvEwp4qOnQAadZUsAExJLaqNeum
 PUB5kEL2YUwnm+4kMEVWRstgt8sYZMNl1q2jvwz8rmlrqjk2OP6jY/jbCmxmkuc28Kt9
 /zclZwpflcfs+DSv4sGtANnJSNuZZFYSUuZKAgjACITL/apw/8RpnjzFGXMXXpmlN+of
 uyly5RsUbnp7D1eUGVo26tju8rXfI0ds90garSRjizeqh15STbJ5h6Wh8J8Y67RdvQ6x
 q9Zg==
X-Gm-Message-State: AOJu0Yw27WAudGvASoH8rvldY4uECWUC/Ma4pG0ds7NtVu/428pn8yR3
 9tsCqeG4jCgEgFlsOFmkktaS2UZO7iisWF9A3a9iWv2oHTC2KL4xgrlnV7mfIGMxitKqOs1V7I/
 vqmry
X-Gm-Gg: AR+sD116WX3RqfL8DGFovLthOHjWxosE5QbDFapW7okJ3ixFq4WX8XLfkbIiaLYP+AK
 uS7OvRnRLvGMhNevWyBiMht02E5XtKb8Ckw0fltlAHnkdSHNQOfLEF/07SKMY6htU8SHhJ4kBOU
 ZlgZyJmJHi9lkIH5zn7/0ocoQRt5m0KQJWAm5/1fjj+bKjEEvFHMiaMy5Fr7dQnKe+6q0tGOWEn
 VH+oexqd80tXsGzrz2vvoLym+6xDacvdtQsdBm0quM4tc8+wticNWzeQkI9/AlcLz0quE08ye4d
 aqHA3g6MfxtGe9bqJXBwDnyn+RpsfN2S03PfvewNnnF0zhF6J49lXP4v9CDOqfXt5PwnAqTDmiO
 QMMriqjwjqQ6gxqzV1jyBzkb99JfhQH3rU1Zc2FgV9yyRohjv0RKZsLr+MVDZ0x7HpivtVdmqL/
 y9OqSBqZU=
X-Received: by 2002:a17:90b:5905:b0:381:23d5:693f with SMTP id
 98e67ed59e1d1-38e4b534bedmr19326929a91.28.1784659622326; 
 Tue, 21 Jul 2026 11:47:02 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/20] target/arm: Remove DO_ZPZZ_FP_B16 from translate-sme.c
Date: Tue, 21 Jul 2026 11:46:38 -0700
Message-ID: <20260721184656.530230-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Expand the macro at each use site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 59 ++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff6032a07f..e77d017656 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4428,14 +4428,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-/* Similar, but for insns where sz == 0 encodes bfloat16 */
-#define DO_ZPZZ_FP_B16(NAME, FEAT, name) \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
-        gen_helper_##name##_b16, gen_helper_##name##_h,         \
-        gen_helper_##name##_s, gen_helper_##name##_d            \
-    };                                                          \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         gen_helper_##name##_b16, gen_helper_##name##_h,                 \
@@ -4449,13 +4441,54 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sme_or_sve, sve_fadd)
-DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sme_or_sve, sve_fsub)
-DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sme_or_sve, sve_fmul)
+static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
+    gen_helper_sve_fadd_b16,
+    gen_helper_sve_fadd_h,
+    gen_helper_sve_fadd_s,
+    gen_helper_sve_fadd_d
+};
+TRANS_FEAT(FADD_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fadd_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fsub_zpzz_fns[4] = {
+    gen_helper_sve_fsub_b16,
+    gen_helper_sve_fsub_h,
+    gen_helper_sve_fsub_s,
+    gen_helper_sve_fsub_d
+};
+TRANS_FEAT(FSUB_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fsub_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
+    gen_helper_sve_fmul_b16,
+    gen_helper_sve_fmul_h,
+    gen_helper_sve_fmul_s,
+    gen_helper_sve_fmul_d
+};
+TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmul_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
-DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sme_or_sve, sve_fminnum)
-DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sme_or_sve, sve_fmaxnum)
+
+static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
+    gen_helper_sve_fmaxnum_b16,
+    gen_helper_sve_fmaxnum_h,
+    gen_helper_sve_fmaxnum_s,
+    gen_helper_sve_fmaxnum_d
+};
+TRANS_FEAT(FMAXNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxnum_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
+    gen_helper_sve_fminnum_b16,
+    gen_helper_sve_fminnum_h,
+    gen_helper_sve_fminnum_s,
+    gen_helper_sve_fminnum_d
+};
+TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fminnum_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
 
 static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
-- 
2.43.0



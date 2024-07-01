Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86484C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa5-0003DZ-Ml; Mon, 01 Jul 2024 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0000iQ-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ3-0005R2-VO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso22213235e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850056; x=1720454856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgRYVkIIweHtjr+ZTjlTznMU791NJv4qRCbRXJ37zVc=;
 b=ldZU8eScDCM4Kj7jTLlhWVylDMjzxRFuCja9WnVHF+zWWpmB3AOYQIVbBa9nMUxXg+
 zPoWREWLBpC4DBPAYd+Jtz3T2dld10RnEpP3gfmExHnIVEH51yIFHP4JXgoVadzEv+5b
 bl4PVy7QsUIrBfVKYSQw/si8FTlf00A/6FnqvWuer6NN+nYX39q6+ct7c2WLcE3LsBGt
 MDc9JS9e7sZ1w8SA8S1beWArpl5pddHiXt0P4lrLLuPD78vfvjzMyx88piQ5MLcOKbwJ
 4oAyFo5fFtNStn75McmaP282S9V7EnOCSfO+II6kbKGssOfnFvSeB0lTQehUmBbMAEET
 LTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850056; x=1720454856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgRYVkIIweHtjr+ZTjlTznMU791NJv4qRCbRXJ37zVc=;
 b=E/XE2MtL3M6HYKu07vxw0ftWDScm5HFA7kDl8QoVAO2P8t7Nh6X1JOCufQGnwNAeBx
 RfumWVqEwrry5A1AwwE6cvlCejQ9iT6MHagsqjb6KlF0sufCIu+/RRvj4Myp1bqqFXju
 HToFFWzVQEKmI7R6P0xYV7iAQELJbo5d9q4ma7v3sCj9Adu/TlBxkaFN1DDkaIyZ/Ki3
 DNiep8Gl8ffHrfNkwwmYcGKTo4hqbMyZ14yvp/HlgpUo8riM1mLbY4DY+Deowqb2ukcA
 7hMvR286QMNkjcyanW8rWRo4HpDOsYHkpJbpYPSEHVsCgRJ9Mko0QHAetTkUWY2thwU8
 cKqg==
X-Gm-Message-State: AOJu0YyIqwbN/ZA/OoDdiy0PZHPfVjbn2TkwVsfq1Ih47X4I2qDLOxHA
 kGJXTFHgCI2Py6AP/EjdXh0iuCXf/+hID3eSW2eozI8ilvQW3YE+n9+n9d514J011AlVIcUray6
 8Y+c=
X-Google-Smtp-Source: AGHT+IEKBu085hkcqznFYDLd6HZpSPW35USDKxVidq97J6lpV41qFSGxiPE1KVBgAwVcNFKFr4m1Nw==
X-Received: by 2002:a05:600c:1793:b0:425:7ac6:9709 with SMTP id
 5b1f17b1804b1-4257ac698c2mr43048445e9.3.1719850056396; 
 Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/29] target/arm: Convert BFDOT to decodetree
Date: Mon,  1 Jul 2024 17:07:13 +0100
Message-Id: <20240701160729.1910763-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Message-id: 20240625183536.1672454-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 20 +++++---------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a0251f83cf..6819fd25873 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -950,6 +950,7 @@ SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
+BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
 
 ### Advanced SIMD scalar x indexed element
 
@@ -1029,6 +1030,7 @@ SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
 SUDOT_vi        0.00 1111 00 .. .... 1111 . 0 ..... .....   @qrrx_s
 USDOT_vi        0.00 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
+BFDOT_vi        0.00 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_s
 
 # Floating-point conditional select
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a658ca8769..0f44cd5aee5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5604,6 +5604,7 @@ static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
+TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -5942,6 +5943,8 @@ TRANS_FEAT(SUDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_sudot_idx_b)
 TRANS_FEAT(USDOT_vi, aa64_i8mm, do_dot_vector_idx, a,
            gen_helper_gvec_usdot_idx_b)
+TRANS_FEAT(BFDOT_vi, aa64_bf16, do_dot_vector_idx, a,
+           gen_helper_gvec_bfdot_idx)
 
 /*
  * Advanced SIMD scalar pairwise
@@ -10951,11 +10954,11 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         break;
     case 0x1f:
         switch (size) {
-        case 1: /* BFDOT */
         case 3: /* BFMLAL{B,T} */
             feature = dc_isar_feature(aa64_bf16, s);
             break;
         default:
+        case 1: /* BFDOT */
             unallocated_encoding(s);
             return;
         }
@@ -11036,9 +11039,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         return;
     case 0xf:
         switch (size) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfdot);
-            break;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, false, is_q,
                               gen_helper_gvec_bfmlal);
@@ -12053,13 +12053,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         break;
     case 0x0f:
         switch (size) {
-        case 1: /* BFDOT */
-            if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            size = MO_32;
-            break;
         case 3: /* BFMLAL{B,T} */
             if (is_scalar || !dc_isar_feature(aa64_bf16, s)) {
                 unallocated_encoding(s);
@@ -12070,6 +12063,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             break;
         default:
         case 0: /* SUDOT */
+        case 1: /* BFDOT */
         case 2: /* USDOT */
             unallocated_encoding(s);
             return;
@@ -12179,10 +12173,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     switch (16 * u + opcode) {
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
-        case 1: /* BFDOT */
-            gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                             gen_helper_gvec_bfdot_idx);
-            return;
         case 3: /* BFMLAL{B,T} */
             gen_gvec_op4_fpst(s, 1, rd, rn, rm, rd, 0, (index << 1) | is_q,
                               gen_helper_gvec_bfmlal_idx);
-- 
2.34.1



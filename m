Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5BEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg87I-0004BH-Dn; Thu, 06 Feb 2025 15:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83l-0007vL-Dz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:17 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83h-0001AP-Rv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:12 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9da2a7004so2119552a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872058; x=1739476858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUjKH3+SDXBjvgWKkf+9RI+hVAQ4Vq3op39/ZrATcMY=;
 b=jEUAfxUhzblcIyJs0nNfU8VbT8QpucKJF55cO/ZBK/YQfqmOis4W+WmftOLo654Ueq
 cX3+eML4H3fxQ1Q0ze+HNHb9KHK7Ajj4HUUMpWwguyk4kBm1seUPr4HI4T8VTyYRPqnR
 aRNviLQdC8xPQ4LZ67eDUh8slycoTOVJU85A0u2XR4BrbiV9czNzXTHpzbiNwEf2u3Rn
 Ex0qvG+BIt+2BKnDl8yYB3KZX10IwNUafc43DMEF5nKCNOF62XfChrA2QeolJPwUGoTx
 7GwSLCcrJnJWGMnoOnJhVnRCMaOL5YhmABsCnJv/OX9dKyBra31hFp/T4td9feuJLhKG
 4qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872058; x=1739476858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUjKH3+SDXBjvgWKkf+9RI+hVAQ4Vq3op39/ZrATcMY=;
 b=YdczkY0g1wwtx/cHQvUFA330+qtEu1NDf6pfc8i774ztZfmiIK76huqWeF1IcbfXKy
 Pq1AyG5OAV5DUCWExDpW97CggXqiYGNR3G56LhbVYnMo72pM7RTioTYfwGUyeQ6Xtcz9
 DK1FCeVv8sunqjvlEi+/DwaVyc/vrS3U8C7TOFEE+oVQ2BIEubY/UKgn6o+NRwfVHx/Z
 Xmp+xjYKFlYybRRcsGNHDqwUK1PArO30916V474Ct5LLZo23d+9nc3x16AASJjFGKDse
 LucKP9GNAwmVutJMGc+Kxt1QELziw0rc+2U9g38ludXcid2mSfFtLtOfRguKzpQgftty
 PxnQ==
X-Gm-Message-State: AOJu0Yx1Rdw5NDVsA/uuxWe4iEk7l/M44dduF/7TRvRYSsGZ7BqXUsdP
 PZTTFQnWNS1ODxqKeERfPSCEuG5KZEK0Av2ZiJCFWFrvRhLIK4hAF92EDMyAEZ1OERDLc1omC5f
 b
X-Gm-Gg: ASbGnctEGyR6ru//hvmJtznabh/TJRSgP34SarsWg0W1JgEdOJWUY+U8oaOvtzHl569
 gSf7AknlJ7UFdZXDGY8UGlCwzC0oyQ5B9MQJOAtQhSm+JSC3ZK0CVohRZ0ThUKp9S/vjTh78wTF
 n1+wxy9v13/tpk7jFaOI4PXdLBtiH5NmifT87KmLCSB+UOIFHodDO7ia6NFsqmZo/2OrHbFhd5H
 ion21ohV/gIvgsoIFO9cScCwvgyyIA7EJttWriPtei2/4ln61IOvhM3nhmVi7yIC5i/BcXilShY
 5NTFJan7zuoS3L986dQZuaOF3Fe7m9GwR9zeK6+G/EVhu0w=
X-Google-Smtp-Source: AGHT+IFY2cDUns9DACjSN4gX3SIk8yYC+Jty6ROpeYLOmhfEmPpDDu+IfX3003qz9Za0x6GB7dzEpg==
X-Received: by 2002:a17:90b:2bd1:b0:2ee:dcf6:1c77 with SMTP id
 98e67ed59e1d1-2fa2417731bmr592015a91.16.1738872057012; 
 Thu, 06 Feb 2025 12:00:57 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 54/61] target/arm: Implement SME2 SUNPK, UUNPK
Date: Thu,  6 Feb 2025 11:57:08 -0800
Message-ID: <20250206195715.2150758-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 target/arm/tcg/helper-sme.h    | 13 ++++++++++++
 target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++
 target/arm/tcg/sme.decode      | 18 ++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 7ae3fd172d..3d3eb393b3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -238,3 +238,16 @@ DEF_HELPER_FLAGS_3(sme2_sqcvtun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqcvtun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sunpk2_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk2_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index a9adc8589f..cf4f09dbc4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1676,6 +1676,44 @@ void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define UNPK(NAME, SREG, TW, TN, HW, HN)                        \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[SREG] __attribute__((uninitialized));  \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t n = oprsz / sizeof(TW);                              \
+    if ((vs - vd) < 2 * SREG * sizeof(ARMVectorReg)) {          \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    for (size_t r = 0; r < SREG; ++r) {                         \
+        TN *s = vs + r * sizeof(ARMVectorReg);                  \
+        for (size_t i = 0; i < 2; ++i) {                        \
+            TW *d = vd + (2 * r + i) * sizeof(ARMVectorReg);    \
+            for (size_t e = 0; e < n; ++e) {                    \
+                d[HW(e)] = s[i * n + HN(e)];                    \
+            }                                                   \
+        }                                                       \
+    }                                                           \
+}
+
+UNPK(sme2_sunpk2_bh, 1, int16_t, int8_t, H2, H1)
+UNPK(sme2_sunpk2_hs, 1, int32_t, int16_t, H4, H2)
+UNPK(sme2_sunpk2_sd, 1, int64_t, int32_t, H8, H4)
+
+UNPK(sme2_sunpk4_bh, 2, int16_t, int8_t, H2, H1)
+UNPK(sme2_sunpk4_hs, 2, int32_t, int16_t, H4, H2)
+UNPK(sme2_sunpk4_sd, 2, int64_t, int32_t, H8, H4)
+
+UNPK(sme2_uunpk2_bh, 1, uint16_t, uint8_t, H2, H1)
+UNPK(sme2_uunpk2_hs, 1, uint32_t, uint16_t, H4, H2)
+UNPK(sme2_uunpk2_sd, 1, uint64_t, uint32_t, H8, H4)
+
+UNPK(sme2_uunpk4_bh, 2, uint16_t, uint8_t, H2, H1)
+UNPK(sme2_uunpk4_hs, 2, uint32_t, uint16_t, H4, H2)
+UNPK(sme2_uunpk4_sd, 2, uint64_t, uint32_t, H8, H4)
+
+#undef UNPK
+
 /* Deinterleave and convert. */
 void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ec88a91cf1..9d7a10aa6b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1347,3 +1347,19 @@ TRANS_FEAT(SQCVTUN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_sb)
 TRANS_FEAT(SQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_dh)
 TRANS_FEAT(UQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_dh)
 TRANS_FEAT(SQCVTUN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_dh)
+
+TRANS_FEAT(SUNPK_2bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_bh)
+TRANS_FEAT(SUNPK_2hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_hs)
+TRANS_FEAT(SUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_sd)
+
+TRANS_FEAT(SUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_bh)
+TRANS_FEAT(SUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_hs)
+TRANS_FEAT(SUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_sd)
+
+TRANS_FEAT(UUNPK_2bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_bh)
+TRANS_FEAT(UUNPK_2hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_hs)
+TRANS_FEAT(UUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_sd)
+
+TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
+TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
+TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 491c6231ea..1da64c5258 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -733,6 +733,8 @@ FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
                 &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
 @zz_4x4         ........ ... ..... ...... .... . .....      \
                 &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
+@zz_4x2_n1      ........ ... ..... ...... .... . .....      \
+                &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -781,3 +783,19 @@ SQCVTUN_sb      11000001 011 10011 111000 ...10 .....       @zz_1x4
 SQCVTN_dh       11000001 101 10011 111000 ...10 .....       @zz_1x4
 UQCVTN_dh       11000001 101 10011 111000 ...11 .....       @zz_1x4
 SQCVTUN_dh      11000001 111 10011 111000 ...10 .....       @zz_1x4
+
+SUNPK_2bh       11000001 011 00101 111000 ..... ....0       @zz_2x1
+SUNPK_2hs       11000001 101 00101 111000 ..... ....0       @zz_2x1
+SUNPK_2sd       11000001 111 00101 111000 ..... ....0       @zz_2x1
+
+UUNPK_2bh       11000001 011 00101 111000 ..... ....1       @zz_2x1
+UUNPK_2hs       11000001 101 00101 111000 ..... ....1       @zz_2x1
+UUNPK_2sd       11000001 111 00101 111000 ..... ....1       @zz_2x1
+
+SUNPK_4bh       11000001 011 10101 111000 ....0 ...00       @zz_4x2_n1
+SUNPK_4hs       11000001 101 10101 111000 ....0 ...00       @zz_4x2_n1
+SUNPK_4sd       11000001 111 10101 111000 ....0 ...00       @zz_4x2_n1
+
+UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
+UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
+UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
-- 
2.43.0



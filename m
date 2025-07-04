Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5138C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFX-00056Y-4b; Fri, 04 Jul 2025 12:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF2-0002AK-Tu
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF0-0006p3-1n
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso508956f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646380; x=1752251180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tKJmOi8JIELs9nFIES4n77wMUkUOzcX9wYUgkpVU5JU=;
 b=VWnVW3YlAs1FR0lBHysmt6ooUSmon1qcc1RZSJGN6sRhSpTG6Fb/Vpmtj9qpj805HD
 Wpfttf2APs3gmcvnu3VjmZvOMf89Pzmh6u6Wd+jO6+aX9Ouq/pV/49voc0h5poW7XDWk
 d0ukle7IKK1nqv+Ul9zj/hClR+Phi2E5TBuxE50fw5/WQK1HpsClBVO8J3neGGfzIGCt
 yHFuWSPjt9l30JyWXdTgGWBdGbVYyiqHTgkxW3mkdwsvz4vNs0y9OFti/h2/OKwKGCb0
 Lkj7GuEK1H5mVwypUVEfH6pAc6C/gftCPHjxT1Iz784U4TANLIAI9nMQCItxxnjHX+6K
 AHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646380; x=1752251180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKJmOi8JIELs9nFIES4n77wMUkUOzcX9wYUgkpVU5JU=;
 b=Wio7W3nIKyBsbzhdJ0cmNcLKlV7SlaSWzZ8yn7HWAJHhqEIxhQF9q/3kQBKsu+YFVY
 RAHpjWTs7m7GfsGqMyCpAXETln85nV2oo/FMBgFPSenJHyLt+ouHZhXDzoFW96UUf4qW
 v7IhhOTzTdTfiiC5O3ubCiOFqVyYNCKKwdhJuhlL5imAzM12mNMLlqDj/z+DcRhosSnU
 PmYLauA7RGQ5c9pbJeyijVSv7bqc+mOnyFoisJDasKVZc70KxZ89TuFAa+xgVb4nsC6b
 3lJRLPzk/DWRNQYVSaaRK8EfTmvFCt9UqvsfMshFRzEySwqBtmKnCrz459n6cz4yiXD1
 o8qQ==
X-Gm-Message-State: AOJu0YxzvDEyW8nReU9811C2utlmc/XSZNKnheIFHlnmrzkLUm0AsxlO
 0GRZKcVTQBgGbn8brozogp3tLm+eYtl9bCVWL7TtqIk9l5J5wdef7vpN3UbkRQU/Tf0boWOpTDg
 EbFc3
X-Gm-Gg: ASbGncsFM7a0hfASJO/KxHJj5HIn2VtcxAKs3Hyb0ycoRhA8/tZobcuKEh1ppyNz4Sj
 CYUmRmxFzIcu2/zJMk5zgxylQAPnkuARGmlCMiYavRMOvfw6JH6hp4NJyXgLayKIoOHFPeYDeII
 3Qh0MGgKAIT8FaIMjHFgR9lw1/mK6IaVafRfihblobhpQg84c5odSiIMrR6rcDeihnFJxY1jOqy
 aQT/Srk8PNYu5AbAtpQx3H0uQy31AECFmc1VowXn692SrUqyAAiUnNycGS1/OFMnSKwOK5IkJ4g
 rXH3ZCarK4NFVlth+RQyRp5X82uMbX/C401okwaP0kNGzK9/OZvUvYCxg2fq3IMgt2Q3
X-Google-Smtp-Source: AGHT+IGr818dYk9+Lt8mE8hc0jSs+bnzrTEJDa3ZyWQwaSlb48dJmHqDhjc7GvvcVVDvh5HpS4ODjQ==
X-Received: by 2002:a05:6000:40cb:b0:3a4:d939:62f8 with SMTP id
 ffacd0b85a97d-3b4964f1ddcmr2689933f8f.32.1751646379645; 
 Fri, 04 Jul 2025 09:26:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 080/119] target/arm: Implement FCLAMP for SME2, SVE2p1
Date: Fri,  4 Jul 2025 17:24:20 +0100
Message-ID: <20250704162501.249138-81-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

This is the single vector version within SVE decode space.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-69-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index f808362f239..dcfc40ef44b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1721,3 +1721,5 @@ PSEL            00100101 .1 1 000 .. 01 .... 0 .... 0 ....  \
 
 SCLAMP          01000100 .. 0 ..... 110000 ..... .....          @rda_rn_rm
 UCLAMP          01000100 .. 0 ..... 110001 ..... .....          @rda_rn_rm
+
+FCLAMP          01100100 .. 1 ..... 001001 ..... .....          @rda_rn_rm
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff70bf27b01..210a029ab84 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7428,6 +7428,28 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
 
 TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
+static bool trans_FCLAMP(DisasContext *s, arg_FCLAMP *a)
+{
+    static gen_helper_gvec_3_ptr * const fn[] = {
+        gen_helper_sme2_bfclamp,
+        gen_helper_sme2_fclamp_h,
+        gen_helper_sme2_fclamp_s,
+        gen_helper_sme2_fclamp_d,
+    };
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8
+        ? !dc_isar_feature(aa64_sve_b16b16, s)
+        : !dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+
+    /* So far we never optimize rda with MOVPRFX */
+    assert(a->rd == a->ra);
+    return gen_gvec_fpst_zzz(s, fn[a->esz], a->rd, a->rn, a->rm, 1,
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
 TRANS_FEAT(UQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
-- 
2.43.0



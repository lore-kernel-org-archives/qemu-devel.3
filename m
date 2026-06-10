Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB82CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYP-0002UW-2u; Wed, 10 Jun 2026 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYM-0002Mt-7o
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYK-00063S-0l
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so5233945f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107994; x=1781712794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NrVJ1CeHR9aQEAVmbZLegBXwlMGEjAblXfa+SdHQK5w=;
 b=swaCCy8jmq/lpLwt6G8+FYkTW1dUdIP2scbfazJxADRfL9tWFReJAITtFH4gHeLY8E
 T1tDBWcnswwa7va/7Zk60tYIu1XKhN0+91ZOZ3NLhnaGXUgUr6fc0e3P7QSsfj9gMvln
 D/b8+Si4l+iBTgWpd6P7sJJ7SZdeJP8lFb5hY8Le2JILLuLTiLMAIe3cPrg8QiaOQFrr
 xldlppBBuvvDnhTlxGO86sLx39SAr71nuIrySwnhZR/ln5TqJu/XHXIQcTgfHmiP5Prv
 e/2NO3+SryBKpaXNxFG0e72Plwp18RFvx1cjbaJZ51QiW0nVQHJDXdNi+GCxyF+cjfkz
 X60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107994; x=1781712794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NrVJ1CeHR9aQEAVmbZLegBXwlMGEjAblXfa+SdHQK5w=;
 b=HV5LxOGOg7uZRLL+g6mD95x87rvziWKvGc+jBlVkJBQsBBKwMznYFTbt8YmEyCmqtu
 aZuBfqdOCwYdj55monqgWufisn5Sz9oMATT4zotcZ4wteDS9QH35MPxsajNBauNDjZo2
 ecTEbr0U/0Nk1BH1QTh94cwtj7a5MlITTt/zkgd+5n2b1YY/HJDjqfr6Y1+Fj7UWmiJm
 +9Ctt35x5P+ID1lPcOJt3eFuc8/iyBDltMO5DDzeHx9g/YBHpC3hG4IcOEXZTgvjfQRC
 AkdJWEkWjUn5ebwtDL95heWZ7SdF/WHswKr1ZGnnH7F0QAYMmlEk6+0Oh76arCv/jI9P
 bRPw==
X-Gm-Message-State: AOJu0YyUtEi2Xgjm3tdnjOZVaXclyr2tlWrDsLaO1NfPfGQvLlkUkVZM
 9RMqBoEuasLNWKhpc6yfYOxOFEnj2oTkLCF8V6SXFMhr47oT7K/18HT8+nK3f6pv0S+f6Xwa9DU
 hodcR
X-Gm-Gg: Acq92OHsk+kIEQz8sQKIAeewysZygujja2oxl3evH9We+l3tmFq1emdF48UzgD79QmA
 cbIBbtKhiwjEFWjQ5WT9M1f6cYpgEgcTYnsgoqfW+oUEsp5LNFjykA4YQuDLrlmb3DgY0M/VJ98
 uqN59M+bPedrEOazwccTPnCXwF8uZqo0nRdQMptX2ZB0jhM6iHpKQ4UFa1IFO8x0/K7DflKp7TX
 qq9TeJQMDtvy56fmk3Tifg/x6tnLp8ByGlOamTjeDL41+8S/GJakdQtUhcKjL9AFd8hpVjFi/3r
 PXAvRgtzwcDChTrkosuSpmP7GMJPMYO/y0O3gG2rlBv+dZrTS4vwJ+JfaOTq0UojpXkqBShhOqR
 d6TEOkBCG0ZASKch50/1BMN7jsntIjeLNy0WCIEMiVJCBaGQaIdzqbKaXPS+dunQxktyVEbcbSi
 79FCcVE3S0rr4xZZ4MRQPPW2Tuqfo2ezVPmIe+GxUi0DmegIlywJpLWJMUqXCXSQzSBjmGI4aKj
 l07Jm9pTHjgH9yzLy9cjzV5BubBOV2IONu08/5N1ew=
X-Received: by 2002:adf:fb85:0:b0:45e:e44b:312b with SMTP id
 ffacd0b85a97d-460305061a9mr31376678f8f.18.1781107994469; 
 Wed, 10 Jun 2026 09:13:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/71] target/arm: Implement MOVT (vector to table)
Date: Wed, 10 Jun 2026 17:11:43 +0100
Message-ID: <20260610161202.2235298-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/translate-sme.c | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f85368a002..db1bdb4786 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1595,6 +1595,11 @@ static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
+static inline bool isar_feature_aa64_sme_lutv2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, LUTv2);
+}
+
 static inline bool isar_feature_aa64_sme2(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) != 0;
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 2b9e41a75a..339de72b8a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -141,6 +141,8 @@ MOVAZ_zt4       11000000 11 00011 0 v:1 .. 00110 za:3 zr:3 00 \
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
 MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
 
+MOVT_ztz        1100 0000 0100 1111 00 off:2 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za off v:bool st:bool
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 76bbacfb6e..c4bede2ae3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -391,6 +391,24 @@ static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
 TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
 TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
 
+static bool trans_MOVT_ztz(DisasContext *s, arg_MOVT_ztz *a)
+{
+    if (!dc_isar_feature(aa64_sme_lutv2, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int tsize = MIN(svl, 64);
+        int offset = (a->off % (64 / tsize)) * tsize;
+
+        tcg_gen_gvec_mov(MO_64,
+                         offsetof(CPUARMState, za_state.zt0) + offset,
+                         vec_full_reg_offset(s, a->rt), tsize,
+                         offset ? tsize : 64);
+    }
+    return true;
+}
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i64);
-- 
2.43.0



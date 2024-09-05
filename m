Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4496ECD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC75-0001Yr-Gx; Thu, 05 Sep 2024 09:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6x-00015b-UK
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6q-0001iq-WA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bb81e795bso5947345e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541265; x=1726146065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2ZZJRnDQpXVmhxlb1bFCeHBKJRVNNn9/NPG2id8LS9Y=;
 b=qfLd2VjIE7ZTP5fNxapQbXQ9QqzzPiU2bCuCV43bGMTdNy/n5He5DqAACB/H8Q1riW
 q9dE43sJidrpkkfy1MLvtZR+nVi/V3tj2sQwaYGbvnz/5mSzqp6x901uERMtoe6prDzL
 /mSUc7SkgDmQQN94fK5ouLGgLCN3+X3WutgSInMgCRSPpGsnS2aT3x5KHIjNqcQL6ODB
 L4GnstSj1D7xD4Vn0RswgDh3FAz+SIi9pzkKLrd0UHyLowSYZ+kPIc72ZLvOBXi7H9Ry
 dDEivhwBYYqF6NnI8zadjKqEZRCMnIonTK9UQIzUznyaH3+EVuUQ1rSb2eSdRoBZirpv
 XAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541265; x=1726146065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZZJRnDQpXVmhxlb1bFCeHBKJRVNNn9/NPG2id8LS9Y=;
 b=fW7Ink3Xm0DfxZ0wfshv1pd7dZvh2fgzOZSHP4HpvkArBnROOlHF4CdeqA+Iix5VpG
 upQLrWekYz3KTu/r0F0XFvUp1Jg2QwpLmYInN226y6zDjt7InzOoAIwU3eSzr5K8tWLX
 scbf18929VeLLkpUr3lUfSELkHtrLkGRaj/xcyhqAl0OQ0LyywhAJjQ34rX+CMvYzeC6
 +bomupHSSCphurtpRe7QIadBaZv2Y/fKhR/w0ixW5cIOJpS657R1F2Ah0mlg1wZGY++m
 8wrHuq16JKFFEV5Vcn0XyCE8aY0Nb3ig2YyUoDVXjtdfaok3dYJvftvN/FbrzdtPZ61H
 2Gsw==
X-Gm-Message-State: AOJu0YxHrg7uMt9xz1JtdUBp0NPtewELCzog5ai1wwQXgk+l89mg7p/6
 mZNiC0TyQ7Sp/ipD56UrE+9FMyzO4d40k1SSlLUbpQfo1FRMJ4/WsBZCGIGodrLEZ1yhN5GPTiT
 M
X-Google-Smtp-Source: AGHT+IFQHXvMmrMcW2AQanenYTlFFswQYJGrHC0MGiBIAgghKEziYZL2qkiA2Yq2EryZaWrhrKTtCQ==
X-Received: by 2002:a05:6000:cce:b0:371:8cc3:3995 with SMTP id
 ffacd0b85a97d-374a95c344fmr13547082f8f.34.1725541264492; 
 Thu, 05 Sep 2024 06:01:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/25] target/arm: Pass env pointer through to sme_bfmopa helper
Date: Thu,  5 Sep 2024 14:00:37 +0100
Message-Id: <20240905130100.298768-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To implement the FEAT_EBF16 semantics, we are going to need
the CPUARMState env pointer in every helper function which calls
bfdotadd().

Pass the env pointer through from generated code to the sme_bfmopa
helper. (We'll add the code that uses it when we've adjusted
all the helpers to have access to the env pointer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 4 ++--
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index d22bf9d21b0..59ecaa15485 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -126,8 +126,8 @@ DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(sme_bfmopa, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_umopa_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 02106809ce1..289ffabbfbe 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1079,8 +1079,8 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
-void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
-                        void *vpm, uint32_t desc)
+void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
+                        void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ae42ddef7b3..3ceb32e8bd9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -363,7 +363,7 @@ TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
 /* TODO: FEAT_EBF16 */
-TRANS_FEAT(BFMOPA, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_bfmopa)
+TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
-- 
2.34.1



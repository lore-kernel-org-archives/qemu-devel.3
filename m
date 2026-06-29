Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E911C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAib-00029f-2W; Mon, 29 Jun 2026 08:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfz-00073E-Vq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:24 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfy-0007bF-CA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:23 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c127a694ccbso53867666b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734481; x=1783339281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UieAOkcCm4++Nv0pwychI8mLwpbs12/8vlMvEYuNlpk=;
 b=MrtiszwGMWi5qurKIcRtv20++SPEFs/LEinGLFnFe6uSmtdI1kJ9dVtS9QuQ0qPswe
 +3Qv9FBsHdjuRGoobVUV3PtylHe3v5tTz/2wTNzvBMfwr+3fpCip3ZdZejXSq1zs8VhH
 jdIqb1P3vw4atSqXqE101NeJS+qbrBAzKLnw/1r8LfXkC1dyXzBqkHmyifYb0/4fiUhb
 AwnzybF83coO+sTKnKP5stWLnsHFHRDYSfihE2HghCbMHmDHmSYxrN/KznSdAj0VuxBg
 B4gpheH0Ijh2A/EcChuAXgT0tPJoRWeRZeewXb5roJPajnF2DjTLjYJSuti5elMQsRG8
 s78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734481; x=1783339281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UieAOkcCm4++Nv0pwychI8mLwpbs12/8vlMvEYuNlpk=;
 b=rKLr2ZZikPXFp2dFxsKDdh01qqm/z6S0Dcbkus6ObzuZTxb5aR1c7dy1YoX5PSOMHl
 Q2B8ZQTHE/btxFE+4VHQPSR+OoFk0WGDn1WqZ0qvPaRBhWVNFt2uH7Hi8w49GE4EMJmf
 8LA3hMaOqg/ujuqAF7eQs3W6X1TGHmbVcxb/Rg+N4b3xvQZgHRY3xYAODIaqF2Zoe8zy
 xHeWg9HiKwxBy02Bcp8hIWkOrbu6Fym1IKWTI5GlIWRdzXFIV/dGh8XyvEujz3YKZYGe
 kXLRj8wQOU4jwlI0Dpy0SpOjJr8iRGOuLtKsCBhnFZRBts3n0nD7AJPjxLq+B7en0+7/
 pNBw==
X-Gm-Message-State: AOJu0YzE0o3F//dZeLqcUEg5zZXXKjkkQN98CSu9GOszXDlmbEZt6l4E
 hzOGWZUp8iLwqEee2khlZn3p2qd7CRU+aLiJ9BFZ/2ArZqaRLBfj/dQN6nvNCiawEc/iD7VB4og
 4mppP
X-Gm-Gg: AfdE7ckMe8SpstRk1kQESkJbQUvoGWZoa9RkgyJXiNQ3fT1Sda6tGJwhc2rqPhBCUHs
 J3oVTC+u/3UZLvjntGN1YwQ8+6J2QBCliiW4qEQJaKI9dkWA2Ofl5aUGauJ7pX+RBBHXV7mbs8h
 /5bIQP7K6b926o+Ea0C0OYS6vo4/C9fVIhnkTt6kcFelRFLOWQmO8t3HZH+1saGRPzIfSEAq3xH
 URyv1ogBUgJh2fI5uc2X1xqVoKJ2d4Z8Q1+YnVJsfhw2uJNrf8NRtGpqMe0neUdXqU5h/YigRk2
 XKXKYF4KC9xJfDiIZ0/vO9GCk7K8wPd8TYL7u3ZaShpXXUny2LlvA/mQrzVTC7F3niAGI/m4of3
 m7ULi42o2avdBZpC36lmqqR2j1xaLYoOOYMyAePYTe+F+HtP4gbXrJXT8FepFYhX28TLj9PhATq
 kZxpfDfUK4jcQWiWlRl+rH9WMW4oPTWN84FcS6H6qVGbLsJW3BeJ/5n+T/z7qudcbiLYtDzweFQ
 Qobf1U9F0idR/OPBbFTl46SJiXqSJQF
X-Received: by 2002:a17:906:209c:b0:c12:1c1f:debf with SMTP id
 a640c23a62f3a-c121c1ff012mr474444766b.2.1782734480037; 
 Mon, 29 Jun 2026 05:01:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/54] target/arm: Enable FADD/FSUB (half-precision) with
 FEAT_SME_F8F16
Date: Mon, 29 Jun 2026 13:00:22 +0100
Message-ID: <20260629120032.1645265-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

These two instructions can be enabled with either
FEAT_SME_F8F16 or FEAT_SME_F16F16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: fix && vs || mixup in feature function]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      | 11 +++++++++++
 target/arm/tcg/translate-sme.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2e4f22f193..98102d75bf 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1610,6 +1610,11 @@ static inline bool isar_feature_aa64_sme_f8f32(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F32);
 }
 
+static inline bool isar_feature_aa64_sme_f8f16(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F16);
+}
+
 static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F16F16);
@@ -1781,6 +1786,12 @@ isar_feature_aa64_sme2_or_sve2_lut(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_lut(id);
 }
 
+static inline bool
+isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_f16f16(id) || isar_feature_aa64_sme_f8f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a79b0a9b80..b8dde80c20 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1335,9 +1335,9 @@ static bool do_faddsub(DisasContext *s, arg_az_n *a, ARMFPStatusFlavour fpst,
     return true;
 }
 
-TRANS_FEAT(FADD_nn_h, aa64_sme_f16f16, do_faddsub, a,
+TRANS_FEAT(FADD_nn_h, aa64_sme_f16f16_or_f8f16, do_faddsub, a,
            FPST_ZA_F16, gen_helper_gvec_fadd_h)
-TRANS_FEAT(FSUB_nn_h, aa64_sme_f16f16, do_faddsub, a,
+TRANS_FEAT(FSUB_nn_h, aa64_sme_f16f16_or_f8f16, do_faddsub, a,
            FPST_ZA_F16, gen_helper_gvec_fsub_h)
 
 TRANS_FEAT(FADD_nn_s, aa64_sme2, do_faddsub, a,
-- 
2.43.0



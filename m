Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A342C52D1D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJu-00040S-C1; Tue, 30 Jul 2024 12:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJt-0003un-Ar
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJp-0000IB-Ni
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso28659385e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355400; x=1722960200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YvH6WF9jz8JWZCJ6bAYBpoQtH4MHX55fT9yLfRYRxQ0=;
 b=tBoJxOSjlchtr6RiHaQrtYT5kCfBX190aoHaeTmTRf0jMySmOIBHiqZHXzaV93CYvc
 O0UpFSuVCaEQ4ZV3fLFDNx2Hmx1a+byyrUSSdqzuCUS8uIoxIDU2utEAAq7934qWDY24
 Uyi93+m4m4qhffoAvmjZWw96EFest6GuYFlSYVzfWxRfMHZXQ/D+zkCYSoFx6tSmEVyx
 VNuhnglhdlp6cBKjE8iwW36EL7K1WPs+/6XowHXr92MaxKtg8YEpCsQbQhnzVvS2P93e
 99W4FQIKU8Yxf9ozBoy1ml7eKOIF37jImK0jWhD2eE+mVioKsRZH7xa4l1eYvBbmrxtA
 gjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355400; x=1722960200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvH6WF9jz8JWZCJ6bAYBpoQtH4MHX55fT9yLfRYRxQ0=;
 b=tqpfSIc8bjREn+i/hA82PHNcrlfAwr4G1spfz3wxMcCeR3XUS5WoAjdeFqccN4+WkJ
 yfgPNzwlvcMyXURl6HPQj2btKTphSayTziq9LkA75nwBX4V3witBipH6PokvlRMA50Tx
 FnlOiF5j31N7h4OnJKO+c1azmzBLBCWYU4G8phe1CG//a+aGdoShs999JV/a53iKG/6d
 ycrq7fYA6NaWBhxNLgQWToZrxB0fkLpayW00D9KgSjLddrptyVRNa1kAJHfgNSgS4KBZ
 ogBsZgZSKluUDPKGJX+6VJEt78rkxd3vIKNiQ+1958NfZeIOwUwOmXG2eTNPE22DE8/K
 Ho2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWpCN8wBkAahk7a0hdHSpYIcCIQeX6znOAgL6bbFJyWohYox9ic/nEDPRyQ7lKfx/Yt8s2MiXwXl7ULkgso0e7/0qOQUU=
X-Gm-Message-State: AOJu0Yyh+DoSI9lNR14ZCmJq3W0Ew1KFvfORg41FP39voJgeT0McoXkd
 cUmR852bvxwKkGMMrtJNaHJfIAENXkUEZ6tObY6PXVAJ1LYUzjL7Z+prPe32oyM=
X-Google-Smtp-Source: AGHT+IGYhz9kqyaSvfR2zovEJceiSkgICxZwUH2z03g45TT6Hmt+XK3vQS9Sl/hXCjx2oD+RzdYXrA==
X-Received: by 2002:a5d:45cb:0:b0:368:4634:c419 with SMTP id
 ffacd0b85a97d-36b5d09e40emr6824079f8f.58.1722355399934; 
 Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 8/8] target/arm: Enable FEAT_EBF16 in the "max" CPU
Date: Tue, 30 Jul 2024 17:03:06 +0100
Message-Id: <20240730160306.2959745-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Now that we've implemented the required behaviour for FEAT_EBF16, we
can enable it for the "max" CPU type, list it in our documentation,
and delete a TODO comment about it being missing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  | 1 +
 target/arm/tcg/cpu64.c         | 4 ++--
 target/arm/tcg/translate-sme.c | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3ab6e726679..35f52a54b1c 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -45,6 +45,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
 - FEAT_EL1 (Support for execution at EL1)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fe232eb3069..79258a7c928 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1160,7 +1160,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* FEAT_FRINTTS */
     t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* FEAT_SB */
     t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* FEAT_SPECRES */
-    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 1);     /* FEAT_BF16 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     cpu->isar.id_aa64isar1 = t;
@@ -1244,7 +1244,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
     t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 1);  /* FEAT_BF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
     t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index bcb502feb05..760c200e622 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -354,7 +354,6 @@ TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
-/* TODO: FEAT_EBF16 */
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
-- 
2.34.1



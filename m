Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE6E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbF4-000825-Sd; Tue, 17 Dec 2024 12:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEu-0007ye-R4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEk-0006FA-TW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso39278295e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455996; x=1735060796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIsdRzKm+ByvBvhJev1IO97UStfTz7DGh4fQwjH2ayA=;
 b=X2UFeK06VsV4ryyr83kNc3SxGJqPwKgAQWNfL/B0mBxJMYl5+3QaX8ryvfr3AkpQ1p
 PhgEMWonM3BnawcJgW+fwaRYhVkd6o9xoUR1Bo3MLD7I/fsXAdcyexcKl5lO7ZtYnkio
 2ivueqrrn2oeHC1Ra6QqSURffFSL10xMsHBJagapRn0eZ4WZT01Y8vJ2EVHaN3AdyWUG
 FPpd/RVc1Y6cLkZ5u+fU8eZTNWEUnKzeSvwaHWgDSQzXltO3+F+zAzL9wuxAENCZXf9e
 s4F8lLQgai/sKVZbIaS9FoezijHiQ+h0gKWZ//dBigtEA1Ul/pokkE/68G5zTdtCivFU
 qd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455996; x=1735060796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIsdRzKm+ByvBvhJev1IO97UStfTz7DGh4fQwjH2ayA=;
 b=Je+5PfJ4x05nzSXmlgCviJYDw1/VCDc7KUdOONOtR5fAly+gFTzlwCBKULmSX4OXFR
 3pz80gHiOaSXzfFXJ5rmpGukbWE8rcRuOjUpcaTrflUO1Oo7pK8/Mk4buwITKlFkU8QF
 d/oqnCHtwZDEukXL3WApbTHtetqeVbgZSVMQr9r/HJufIDWIQ8UhPDUF8Gqu9Ues5d0l
 lPGuMjdq+5XAKLahT8KJe+zxh3+zhVXV+EJ4dG1IrLMdcNgT2k/YQAPJXk1+0EsoFM1D
 Dbp0jIe9IrcpZxq9SBW9DKV603/3fd0kt4B9Th41MwsCVGgVIVKmrqOK4aOuN6G/k5ZQ
 8FYw==
X-Gm-Message-State: AOJu0Yy8ucXl1vaf5YeSrMFqrHunUWrANaNyQ5cUMsNuAAMoAHxN0UNU
 8XRM1SeNsC/MFYVdzOE6STP05NazxNUsub90vxRV4iOH1Wb7mBl5TuJ4mngU7haQQsVmtmdV1X8
 J
X-Gm-Gg: ASbGncsO083wSZlNnrpIy/LoPWFX7raxFwA66Ch0rwhATvaU/CFCSIobB+CBRY0mUhd
 wUIB2noTB10TgXZJnFAIDYk4axKuDc5/mTUYaZfYOVCKGdPMQF+4HUKddDx8zxdo9AutQ6my9rg
 BetJ/hixuSGIyPquNid5tvx9jDD3Erm1VgTeZSO9JtgpxBgTrlC5k97cwW9lZDWHT32l3dLhzC6
 ksEs48Ln04iVIHEGHwfA17a3kZhW7S7PfNLJj32KWkN9zyAq3p6EmRhzIJGi1g=
X-Google-Smtp-Source: AGHT+IF2wdnkc1MS54NKx7ZbrFv+s/drmIed8ql3BOKz/rUVH4frdVKkQ33b7w2HWAi4xQ56zeft4Q==
X-Received: by 2002:a05:6000:1ac8:b0:385:ef39:6ce9 with SMTP id
 ffacd0b85a97d-388e461193cmr62073f8f.21.1734455996152; 
 Tue, 17 Dec 2024 09:19:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] target/arm: Enable FEAT_XS for the max cpu
Date: Tue, 17 Dec 2024 17:19:34 +0000
Message-Id: <20241217171937.3899947-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add FEAT_XS feature report value in max cpu's ID_AA64ISAR1 sys register.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211144440.2700268-6-peter.maydell@linaro.org
[PMM: Add entry for FEAT_XS to documentation]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 38534dcdd32..60176d08597 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -154,6 +154,7 @@ the following architecture extensions:
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_WFxT (WFE and WFI instructions with timeout)
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
+- FEAT_XS (XS attribute)
 
 For information on the specifics of these extensions, please refer
 to the `Arm Architecture Reference Manual for A-profile architecture
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 67c110f0211..93573ceeb1a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1163,6 +1163,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
-- 
2.34.1



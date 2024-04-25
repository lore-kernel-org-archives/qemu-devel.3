Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC4BC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWO-0001z9-To; Thu, 25 Apr 2024 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWK-0001wl-IW
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWI-0006xK-BY
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso757299f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041600; x=1714646400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D6sUqMTkg3AZ/EzB3wSEo9MXBvR+VUgJR/HaUz5GIjY=;
 b=EW3Vt0S/Fi0dAqid9SXUDrJnwyZgZ9OZLEmiD8P9X/mfgkl2Tv9LUTJqpVwFPX9z39
 5ytdfRR0x6Wi5aT2VXUrwFCYf8bKW6gAOPKrlXqmw6p0ft2QQMzyHeSrVKRVUyWduV86
 QnfKRncs66yGu+QldaA7x9riIOzH4OTpd7sA7yXnF9DAXnRjql6TFQBuLA1HDYnWUB7q
 Fw0/6rBTuawejhQM+HztYT/kt4Vw4K39zgysP+4Sq8XMh0qIB1K2J/Mx7Jvk2H12UG9B
 wqAZY/W2cZRcJQ9UD8UBd524OVgMHJ9/yaSFjFfGcLgcDTZlMmCKAiXQIhjrk1Q3qkLk
 1+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041600; x=1714646400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6sUqMTkg3AZ/EzB3wSEo9MXBvR+VUgJR/HaUz5GIjY=;
 b=nAnzBscGa+wgDadqZV6GQpuox43+GP7/e38Hmt5xA8euLvA5jnhVuHhLLGTQDqI7OT
 jqwCW9Y9pPnGsMZVuaPpQQkSIKRbMBnH/GbipxIXmroucCVoecbJ+mJjXiuNTMUPw15p
 dRgikdvJX95o7Mzpcvxnk7SdEkdWDhfFuN4Pf6y0zEH542nkpmoJTCG9+Dupzyz0mtBC
 idG8K/WzXLSiFIU5hC83EGXWxDACH+6+02VyRKPpQpB71L4xnCckv1HSEDE4CSNf6AAA
 jY2JteMCWM5c2MbmsOF3nICfPkiruvN716/wkMIAeNc8Zl4RSSGde0njK6QYPgdEU3jj
 tUTQ==
X-Gm-Message-State: AOJu0YxC62g1ziaUdqgOCWXHu3WnaXwqL2wDxVNF1BeumDWcZs3OJWZT
 Qh4n14o/psDNWMI9KlNYogJbYqoQqPS7z8kHTQcqHxXcPHmYv6ltFR3C2j/f9qX/NMlD8IWG/52
 b
X-Google-Smtp-Source: AGHT+IHs92x3xf+ZTwwh0pG9Iug+PY7yk3F6/MmszFduc/R3keQYh/GpRWG3fVGG6Tjg/arGMzDjNg==
X-Received: by 2002:adf:f1c4:0:b0:34a:5663:40b with SMTP id
 z4-20020adff1c4000000b0034a5663040bmr4464045wro.3.1714041600512; 
 Thu, 25 Apr 2024 03:40:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/37] target/arm: Handle HCR_EL2 accesses for bits introduced
 with FEAT_NMI
Date: Thu, 25 Apr 2024 11:39:22 +0100
Message-Id: <20240425103958.3237225-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

FEAT_NMI defines another three new bits in HCRX_EL2: TALLINT, HCRX_VINMI and
HCRX_VFNMI. When the feature is enabled, allow these bits to be written in
HCRX_EL2.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-2-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/helper.c       | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e5758d9fbc8..b300d0446d8 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -681,6 +681,11 @@ static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, SME) != 0;
 }
 
+static inline bool isar_feature_aa64_nmi(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, NMI) != 0;
+}
+
 static inline bool isar_feature_aa64_tgran4_lpa2(const ARMISARegisters *id)
 {
     return FIELD_SEX64(id->id_aa64mmfr0, ID_AA64MMFR0, TGRAN4) >= 1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a620481d7cf..7a25ea65c9a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6187,13 +6187,19 @@ bool el_is_in_host(CPUARMState *env, int el)
 static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
+    ARMCPU *cpu = env_archcpu(env);
     uint64_t valid_mask = 0;
 
     /* FEAT_MOPS adds MSCEn and MCE2 */
-    if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_mops, cpu)) {
         valid_mask |= HCRX_MSCEN | HCRX_MCE2;
     }
 
+    /* FEAT_NMI adds TALLINT, VINMI and VFNMI */
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        valid_mask |= HCRX_TALLINT | HCRX_VINMI | HCRX_VFNMI;
+    }
+
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
 }
-- 
2.34.1



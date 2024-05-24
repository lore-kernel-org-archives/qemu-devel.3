Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F2FC25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeE5-0006MT-CY; Fri, 24 May 2024 19:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE3-0006Ln-PT
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE1-0005eH-66
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6818e31e5baso1189941a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592884; x=1717197684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrL1JsoHB9ONacMQPzWVRwN8hE48sjAIXUCgFRSOVZo=;
 b=L8m4dH8Yk+n2M/JR2gY2fb7wD9BWHwJGNn3atDGlLpsz14yj+iLvl0IcVClMKbKi5j
 KL41odVxkoDDxErDYRf4DYG+FcAgYvSGE3G8IfcHLkITnzAVY7G8AvaoEcJ1rymS6oek
 xpTxiP+HUE9TZ/e4e+/WwV3OPD8+4X9nclRnAXSiMT6+66MjtqnvFErjtE5ScJyZH33X
 1nUKnI1uKS7r7SSncJXR314V9kyz7adIWq2fTgQ+tFJCJW957HdCRxXKl5VSONorPFAP
 LM9w8IhH7IiF2wvpj2pH8StcOOTA4eaKv5bLYm+MCJ0X9rUpyCBQm4kUtz348AEbpRFN
 f1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592884; x=1717197684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrL1JsoHB9ONacMQPzWVRwN8hE48sjAIXUCgFRSOVZo=;
 b=CsPP84ZGwCt29OJgJL2OhieeRV0aA6reClsf5Nmljf9BY0XGY/2gYcdnTnytBqm6da
 flY0gufovRsQkgN2v+F4IluKUl50AAoWhYWc6zqZnItafav6PCSZMK7KTSpPEO4ieLWm
 uw0UfC4cbO/3ilvfSa5LUCnHwPvhOThllaVcvMULr+xLB3m+UvXDLSnACK2eN+ZH+KmV
 uYoFdnmdeJLjU2dB0ak6w+Tni3dnuaqDUB8CxudhSZWSkXGhaKlM7ESTDlwSiC2Q+QyD
 YANMO0fxbtnDaKM84ekg/dzduMHsGqMRg8ei7A1NKSvvkQxIOG9MOJ034ZwN+aCIT9dn
 TDjA==
X-Gm-Message-State: AOJu0YwgWb6Lbg4lgoR3y6YxwGOuMoHlom0UC1OeJUnjXV2dG7DMqqZl
 BmP6ZOo/Zjd9Cbx4Mo57opDhlbGWjYgLhecld2GLKS4MzKDfsSxn7fThQDCMh82eGc1tZu2E8Wu
 t
X-Google-Smtp-Source: AGHT+IGWwp9aMCQNgDzMcO8U2sycq6R87MVgOF8kpteMfiv/i46vDT7l1kt2uo5g8Wl7APQHlUufdg==
X-Received: by 2002:a17:902:e5cb:b0:1ed:7cdf:f331 with SMTP id
 d9443c01a7336-1f449903c29mr44738935ad.68.1716592883758; 
 Fri, 24 May 2024 16:21:23 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 01/67] target/arm: Add neoverse-n1 to qemu-arm (DO NOT
 MERGE)
Date: Fri, 24 May 2024 16:20:15 -0700
Message-Id: <20240524232121.284515-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Hack, because there should be a better way to do this without
duplicating code between cpu32.c and cpu64.c.  Hack, because
qemu-arm crashes without ARM_FEATURE_AARCH64 disabled.

Needed in order to compare RISU results with aarch64.ci.qemu.org.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu32.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bdd82d912a..6ee055c78b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -978,6 +978,78 @@ static void arm_max_initfn(Object *obj)
 }
 #endif /* !TARGET_AARCH64 */
 
+#ifdef CONFIG_USER_ONLY
+static void aarch64_neoverse_n1_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cpu->dtb_compatible = "arm,neoverse-n1";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
+    // set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by B2.4 AArch64 registers by functional group */
+    cpu->clidr = 0x82000023;
+    cpu->ctr = 0x8444c004;
+    cpu->dcz_blocksize = 4;
+    cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
+    cpu->isar.id_aa64isar0 = 0x0000100010211120ull;
+    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
+    cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
+    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
+    cpu->isar.id_aa64pfr0  = 0x1100000010111112ull; /* GIC filled in later */
+    cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
+    cpu->id_afr0       = 0x00000000;
+    cpu->isar.id_dfr0  = 0x04010088;
+    cpu->isar.id_isar0 = 0x02101110;
+    cpu->isar.id_isar1 = 0x13112111;
+    cpu->isar.id_isar2 = 0x21232042;
+    cpu->isar.id_isar3 = 0x01112131;
+    cpu->isar.id_isar4 = 0x00010142;
+    cpu->isar.id_isar5 = 0x01011121;
+    cpu->isar.id_isar6 = 0x00000010;
+    cpu->isar.id_mmfr0 = 0x10201105;
+    cpu->isar.id_mmfr1 = 0x40000000;
+    cpu->isar.id_mmfr2 = 0x01260000;
+    cpu->isar.id_mmfr3 = 0x02122211;
+    cpu->isar.id_mmfr4 = 0x00021110;
+    cpu->isar.id_pfr0  = 0x10010131;
+    cpu->isar.id_pfr1  = 0x00010000; /* GIC filled in later */
+    cpu->isar.id_pfr2  = 0x00000011;
+    cpu->midr = 0x414fd0c1;          /* r4p1 */
+    cpu->revidr = 0;
+
+    /* From B2.23 CCSIDR_EL1 */
+    cpu->ccsidr[0] = 0x701fe01a; /* 64KB L1 dcache */
+    cpu->ccsidr[1] = 0x201fe01a; /* 64KB L1 icache */
+    cpu->ccsidr[2] = 0x70ffe03a; /* 1MB L2 cache */
+
+    /* From B2.98 SCTLR_EL3 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /* From B4.23 ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    cpu->gic_pribits = 5;
+
+    /* From B5.1 AdvSIMD AArch64 register summary */
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x13211111;
+    cpu->isar.mvfr2 = 0x00000043;
+
+    /* From D5.1 AArch64 PMU register summary */
+    cpu->isar.reset_pmcr_el0 = 0x410c3000;
+}
+#endif /* CONFIG_USER_ONLY */
+
 static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "arm926",      .initfn = arm926_initfn },
     { .name = "arm946",      .initfn = arm946_initfn },
@@ -1018,6 +1090,7 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
 #ifdef CONFIG_USER_ONLY
+    { .name = "neoverse-n1", .initfn = aarch64_neoverse_n1_initfn },
     { .name = "any",         .initfn = arm_max_initfn },
 #endif
 };
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B61810ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CV-0007SB-L2; Fri, 27 Mar 2026 07:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CJ-00077B-PK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CI-0008Ph-33
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b5bded412so1432698f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610269; x=1775215069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaZgT662lqVLo8fysFL+JEr5ubuoSNMh8uSkamaRExg=;
 b=k0qFlTXq0JI0W3DtmsX2HkmtGlqEk5nC9F5KlKj48lToq27+bAqz0nixOW14YbcC43
 UUJ9/0ZiZ7nSqd6NHNDplRE/6n4zU9w+4L9THHqTziSkZWGn/8veQgT70AezSqH9UBQt
 18HH8vCgCNDbqAne2cBEl8nkQWs/L0MPpR1c4iddU7Y2eX0ku4waLTbutpHR3iKZDHiy
 rZEMQfnoCxbmSLeldb84fj2DoGUjCcEOLufUVkapVEAmxCAfEUnBTWLoCbMDcda4lgxX
 hMI7uFj7gl4aKFsVInIyPuBpzBJAQPjknOvatb8u3cDWc4n5Cdq5F4xGK6Gy6l9DDFws
 GgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610269; x=1775215069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UaZgT662lqVLo8fysFL+JEr5ubuoSNMh8uSkamaRExg=;
 b=PHYxbH0XDAthGKLiqFxEw48BXzyrKwqDQFF2cbe+iiW0ASHdI0nW4v7UyvU7VqusmC
 FB5j51C/ugN2tTBgSm0ayILee9us5BmmyPNmrjSkF84t6t8dAIzW2yeRbbhjN4eJ6cbd
 n3lVvefEulOXZcHN7bNbYDCr7QgswJEIpp1ndmjyeDZMO/SZdOLr/NdUqslIaA8G5Knv
 TNEgiVuzd2QjwIg2c3jjmPggYdJaV8NTCnwZfUDgiIG1lcMyp0QzLst8dDWhgDuW9Txa
 uXQjPJZKLzWzukc/ttPi5JjVsRYLgyLAD3wXK2mBhsmmMEStsIIkYEtBaAr4CCUrx4mY
 TJiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdSwC4LcIS3Ks3WoRlqYbDjUAUCx5NXBcLHPszPPHdHQIVW7kvdgSCRUF6s0OSLuDbpcvh1snOKqA5@nongnu.org
X-Gm-Message-State: AOJu0YzDG523NoTyFiDIMqnvdgXBAyC41nhoX8upin/9faRI6+mBSWXI
 XaYn3yz1/cdVag59Uax6DrqWUxSj/eRfE7Fl108F5BGbuKACgaJH2zr9uINaelrDzxg=
X-Gm-Gg: ATEYQzzaw7rfap3xq2vi6FEUbFDPsBrP1DwEvpwUJW+YesQZgBUr447zW7IksW9GfJO
 RwpzW/oKG8Togmc4DsyxLw7DD2PqQlPQxD+KQQojCWPIVp62gSwZ3dUtsho2KDrG9bYDDqJ+ODu
 0CUIZTJki4LL7kpwyqCsYLaNmg6i6Zb0XC402UCpJktmRdRAFogMDjdA0n4Zh6W0CDqMXfjpJEt
 c+UNidWRQgnhRKS09kiNDIFp78GJ9FxE+9fzYNwhAOXdbSBpGxHFRnmwDZ3NrL5t/Fh7GJ3tLGV
 NmLB9L2Hg9lDmwsZo9w1zyPsZBI9gjWdL3ELC5w7l/aY0m144RPTmd8/CWo9fXAcGRz6oC/G0jo
 j4/S7lYKz4MDBR31FmML8mv3cRgpqgFpHmXnCZs29da/MBRYNMJKQ0vg+juCX7q7rlVKLVCA7fc
 N2HgxBHPzd8twH6wwY5IGxpmK80gk5Id+/pY8llR5gxTi0cp347BKFnJve2wkbGpH7S40hN0KeB
 K3n+nM+CPDXoph2aFN4sz4VnCfN6zQ=
X-Received: by 2002:a5d:5f96:0:b0:43b:93af:43d8 with SMTP id
 ffacd0b85a97d-43b9e76bb16mr3163975f8f.0.1774610268593; 
 Fri, 27 Mar 2026 04:17:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 49/65] target/arm: GICv5 cpuif: Implement GIC CDEOI
Date: Fri, 27 Mar 2026 11:16:44 +0000
Message-ID: <20260327111700.795099-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Implement the GIC CDEOI instruction, which performs a "priority
drop", clearing the highest set bit in the APR register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/tcg/gicv5-cpuif.c | 21 +++++++++++++++++++++
 target/arm/tcg/trace-events  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 09870e0b09..0974637c92 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -554,6 +554,22 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return hppi.intid | R_GICR_CDIA_VALID_MASK;
 }
 
+static void gic_cdeoi_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    /*
+     * Perform Priority Drop in the current interrupt domain.
+     * This is just clearing the lowest set bit in the APR.
+     */
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+    uint64_t *apr = &env->gicv5_cpuif.icc_apr[domain];
+
+    trace_gicv5_cdeoi(domain);
+
+    /* clear lowest bit, doing nothing if already zero */
+    *apr &= *apr - 1;
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -606,6 +622,11 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdrcfg_write,
     },
+    {   .name = "GIC_CDEOI", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 7,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdeoi_write,
+    },
     {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/target/arm/tcg/trace-events b/target/arm/tcg/trace-events
index 13e15cfcfc..fcb3106a96 100644
--- a/target/arm/tcg/trace-events
+++ b/target/arm/tcg/trace-events
@@ -5,3 +5,4 @@
 gicv5_recalc_ppi_hppi(int domain, uint32_t id, uint8_t prio) "domain %d new PPI HPPI id 0x%x prio %u"
 gicv5_gicr_cdia_fail(int domain, const char *reason) "domain %d CDIA attempt failed: %s"
 gicv5_gicr_cdia(int domain, uint32_t id) "domain %d CDIA acknowledge of interrupt 0x%x"
+gicv5_cdeoi(int domain) "domain %d CDEOI performing priority drop"
-- 
2.43.0



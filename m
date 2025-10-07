Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591B0CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R1-000689-KQ; Tue, 07 Oct 2025 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qb-0005pm-DW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QJ-0002Ia-AA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4892325f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846328; x=1760451128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwQ7dF2D5NalzDhCdRGQlVTp8HgEcdaiq/9rMuXGS7g=;
 b=FB7Z8KruStuNKLKjUkUv0kSVa4MJm9XXjuO/VpFJGuVce2iTRuOYe8hHZKkxdYxCfQ
 1sx6SCOI4LYlyODobgxHKuHHsYGn7cq3vfPTWXxnvN/Cwf/jh7dVuMgy2ac5UJP50vTR
 77/LSSfQwznTR9kyzlMuJ7eBWVS8vz3xPX0LOQa/85FtEo84fxIvSWMJALm9wuhmefZz
 ydK6/pnB53HbVXDluaeZzc7WKNFz7BTNQAHkEZBGl5IakzWQyT53yE/B3TS7tTaeGiox
 QhxQ9pSNyzBlSeELaZoKUSi1fQNbGNqAsbkepuRlXeOoGPysFeotbzzV/I3ROLVDI6tl
 31vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846328; x=1760451128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwQ7dF2D5NalzDhCdRGQlVTp8HgEcdaiq/9rMuXGS7g=;
 b=Bt4ozTnZf+CmjGbHaB/64m/sCZkJR3+L+STs/yJv3bxafcKNOCneRdS4942jyuxB4u
 wBgYzbE21HMns9JSsDOBBa5E+CbL1DMZem48KOfj+f24IeE3+tLn2AB3w9P7kK3sSZ4/
 4QhkZZkeYGggLfQ5PlaJ6DX85hN26kth1sa9CWu7YdLAQdF0HXdS3rdIw25GvShk6DHd
 F51QE8KuZsKGvlEeA+syMktMc82SK0U3ylZgrx/rJstUKgXW0IZWjupb/lIdjE7CUirc
 +y5bKMRmUnaZY/6c1ndpWAzwYUcNhOpKYM4h3h/0nIrCbxR8UiX3NHyyUznFQqHfnc/4
 hI2Q==
X-Gm-Message-State: AOJu0YzFUIl1/KwNLHfbueV8ERj9rWsMR/mGPUChGC4y4kt21ERpZ/SR
 SpVenWWYMlxvAfzZfebkX3+LDYGUc34mrKd3ETqLXWcLOxBPbj5ezkm+60UnctSK7cRMF8d3zhL
 E0UPR
X-Gm-Gg: ASbGncv3HcsuL5sJb+BTmTRGhwZ683K4ev6pwt5FYnOxR8grsyXaLOkCBzlp2VqAToJ
 wNEUFFBPG8YnJD3G1/fdNDrIL0BaPw5S7XwtdU73hLRfHa1W1KhCNQpjnt9WII3/LPf/HuiiEYj
 8lPTV48GfpwX01+ol9RThFOkXkuupkNp1VAeLy6v/bAaipYq+H8ExZH1Nd6k0N5QxHdycC/O88X
 hmMC73OZUIJZKSJkgup/lPGhtmZDuIOzdXP2OkCJ0PlFVqNjlfsqCTHv6Gh36Y8BuOqypwhysko
 SCTf/R21O4ej+RM0nAIxQ7rX+MrkteVj86S5oFi+qWvky+gsGHC8VTwpoULj9FH4otagKzvQ3G0
 YoOamPx4jj8PExa/PJkTk8yGT+SGFGn2BaiGGinQNq7DsVz9GPtmAfxlp
X-Google-Smtp-Source: AGHT+IEL9qk9Cd535nWhadRrMVCH3VYAbiKhGkV6ojUPeWK0Zpo3P/VCq3MRvCUYMaYLkSUIEC7hfA==
X-Received: by 2002:a05:6000:4210:b0:425:75ce:9f5f with SMTP id
 ffacd0b85a97d-42575ce9fcdmr6680134f8f.48.1759846328128; 
 Tue, 07 Oct 2025 07:12:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/62] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Date: Tue,  7 Oct 2025 15:11:00 +0100
Message-ID: <20251007141123.3239867-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add support for the ARM Cortex-A78AE CPU.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-40-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index abef6a246e8..90b6c0ebb0e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -406,6 +406,79 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x410b3000;
 }
 
+static void aarch64_a78ae_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+
+    cpu->dtb_compatible = "arm,cortex-a78ae";
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_NEON);
+    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    set_feature(&cpu->env, ARM_FEATURE_EL2);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+
+    /* Ordered by 3.2.4 AArch64 registers by functional group */
+    SET_IDREG(isar, CLIDR, 0x82000023);
+    cpu->ctr = 0x9444c004;
+    cpu->dcz_blocksize = 4;
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
+    SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
+    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000100001011ull);
+    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
+    SET_IDREG(isar, ID_AFR0, 0x00000000);
+    SET_IDREG(isar, ID_DFR0, 0x04010088);
+    SET_IDREG(isar, ID_ISAR0, 0x02101110);
+    SET_IDREG(isar, ID_ISAR1, 0x13112111);
+    SET_IDREG(isar, ID_ISAR2, 0x21232042);
+    SET_IDREG(isar, ID_ISAR3, 0x01112131);
+    SET_IDREG(isar, ID_ISAR4, 0x00010142);
+    SET_IDREG(isar, ID_ISAR5, 0x01011121);
+    SET_IDREG(isar, ID_ISAR6, 0x00000010);
+    SET_IDREG(isar, ID_MMFR0, 0x10201105);
+    SET_IDREG(isar, ID_MMFR1, 0x40000000);
+    SET_IDREG(isar, ID_MMFR2, 0x01260000);
+    SET_IDREG(isar, ID_MMFR3, 0x02122211);
+    SET_IDREG(isar, ID_MMFR4, 0x00021110);
+    SET_IDREG(isar, ID_PFR0, 0x10010131);
+    SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
+    SET_IDREG(isar, ID_PFR2, 0x00000011);
+    cpu->midr = 0x410fd423;          /* r0p3 */
+    cpu->revidr = 0;
+
+    /* From 3.2.33 CCSIDR_EL1 */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+
+    /* From 3.2.118 SCTLR_EL3 */
+    cpu->reset_sctlr = 0x30c50838;
+
+    /* From 3.4.23 ICH_VTR_EL2 */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
+    /* From 3.4.8 ICC_CTLR_EL3 */
+    cpu->gic_pribits = 5;
+
+    /* From 3.5.1 AdvSIMD AArch64 register summary */
+    cpu->isar.mvfr0 = 0x10110222;
+    cpu->isar.mvfr1 = 0x13211111;
+    cpu->isar.mvfr2 = 0x00000043;
+
+    /* From 5.5.1 AArch64 PMU register summary */
+    cpu->isar.reset_pmcr_el0 = 0x41223000;
+}
+
 static void aarch64_a64fx_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1321,6 +1394,11 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a55",         .initfn = aarch64_a55_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "cortex-a76",         .initfn = aarch64_a76_initfn },
+    /*
+     * The Cortex-A78AE differs slightly from the plain Cortex-A78. We don't
+     * currently model the latter.
+     */
+    { .name = "cortex-a78ae",       .initfn = aarch64_a78ae_initfn },
     { .name = "cortex-a710",        .initfn = aarch64_a710_initfn },
     { .name = "a64fx",              .initfn = aarch64_a64fx_initfn },
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
-- 
2.43.0



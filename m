Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546A9EC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKb-0002Ft-38; Mon, 23 Feb 2026 12:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKZ-00029M-3W
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKW-0000Cg-Uu
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48375f10628so29376405e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866163; x=1772470963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F/dI1qFmZ1RsBVXqA0SGOU0duWbHv0A4HX6TOb0/aiw=;
 b=a2s1EFy9to+CR0rhLUtOz9XtH/nS0nsUo0e9P64+jFBvPmo6rIuDlKxzlTCT+YKhw1
 4tSkJ93rWI/kNCHQzpAjKUT8h9h+C4LMN5o49Vnjz91niuGc9svQicDTyIxm81ofgfjY
 EpDax5y2WkNnH8EodSZG8Yjvq5c0uu6lLPgQm88LEUUP0l++XlsFW/J/J/nYKSoO+8uN
 O397bdNeKHIXPWFTS+WyY6bkw3lMyd31f0b2ax7rBMfMKtAbUAbO1hfL1mr3JdkdY4gt
 D+SFJqAiNvP2GIrPCGloy0Jz78CgYTIUjUvO8UpooI6BFX9rLwhG3KmzptZtOSPtcrjd
 XZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866163; x=1772470963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F/dI1qFmZ1RsBVXqA0SGOU0duWbHv0A4HX6TOb0/aiw=;
 b=rUonMGHmagNQABMQD3RGNGk9WSm6ejMCckBvJMB+3lxkgyVcC4nuU3duGrxFklHDHu
 ORn8+Ga/5c/QVdeAiP6F2353IcCciiCiMjC2GjwmUXu5t4JtuhvhMe1AbM2Vsqsnult4
 gMHF1yyEFeYVGjaLrV812hkP7Gp4/K0OgOrgdRNpdCC2XcCLiH38FyDkKJAJzkPFyC8y
 vXCiLChX3SL1v6Jq56h9cCS9R56GF2j4IXNkJkqEzFNA992t0TWRUMDc8UtsO3Wa4hX3
 zVlMHDbLUc1i1mbMzGFYSAbm8efS6q/m6BpdSP7yX28rQieX12yx9SmgNGeNKx2M/Wet
 JN9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwHHmfNzP0oCMnPVLLKkz99lz9hkzKnNiZHweyFBW7/tHWyWwfLgTeWStL1h/uWSRUO3pkZ+XFf6Zi@nongnu.org
X-Gm-Message-State: AOJu0Yx/iamZUKeTaz6cezgvVKWND0pkfM0OhatWWveX/EwPqiVamnxv
 qYZrthlYkkuJMf/6LbSQAiZSAqO6z44VsRnZKqU3iCX0lzjd762E+n0S0RTFdq7QNsk=
X-Gm-Gg: AZuq6aIeitblKXxE21/ddorwrAwxZRXti7dqIMFawnU4+ANLknaoxn0ES0jtr+1Vqgu
 huWyCFv03WI5C/d3TCZgwhycE8jD2Wf84c3M6boQwNa5VP/2N5K8kPnwI/9UpYujwlKbe1j1WyT
 XdD9qxPE4VwcYaZjQGsCaZGDCoshGDYIH5ta9oWnVqtg3oDFVMxGM3cwk3fgYko4lHt7gTOovU/
 BjJ/7eW0y7IER3XvTXm0OuPcoPMReHzMH6mH3N+cz3O7BWtWCElunME0eoQxxi2rgwP0sjxW3ub
 MuMJ+rmFQXxLG67JoEkYfU4wgKW1YvUxZSxbdomNPuSXMlOv9c5S5wXiksspYLYWo9zualQzaiu
 B2rg5u5doQBBA3nccS/bCWeshqS1wgp0Y61/SsJfCpH/qwR/CFavcGAM06WllpM3F/39BMmWhxO
 PmHPc7EsSb5pznujuH0bwFip0kNl0dbzuhQNoLacEK22e/0I4qUHp+0m1m0VAapzlyQIXcQGSei
 QzdgLn86TeWp2hhvNNBLNKT4EbWHFw=
X-Received: by 2002:a05:600c:638d:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-483a95f5a62mr142636435e9.29.1771866163326; 
 Mon, 23 Feb 2026 09:02:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 25/65] target/arm: GICv5 cpuif: Implement GIC CDRCFG and
 ICC_ICSR_EL1
Date: Mon, 23 Feb 2026 17:01:32 +0000
Message-ID: <20260223170212.441276-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Implement the GIC CDRCFG system instruction, which asks the IRS for
the configuration of an interrupt, and the system register
ICC_ICSR_EL1 which is where the answer is placed for the guest to
read it.

We mark ICC_ICSR_EL1 as ARM_CP_NO_RAW, because we do not want to have
this migrated as part of the generic "system register" migration
arrays.  Instead we will do migration via a GICv5 cpuif vmstate
section.  This is necessary because some of the cpuif registers are
banked by interrupt domain and so need special handling to migrate
the data in all the banks; it's also how we handle the gicv3 cpuif
registers.  (We expect that KVM also will expose the cpuif registers
via GIC-specific ioctls rather than as generic sysregs.) We'll mark
all the GICv5 sysregs as NO_RAW.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  5 +++++
 target/arm/tcg/gicv5-cpuif.c | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 16de0ebfa8..1fdfd91ba4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -597,6 +597,11 @@ typedef struct CPUArchState {
         uint64_t vmecid_a_el2;
     } cp15;
 
+    struct {
+        /* GICv5 CPU interface data */
+        uint64_t icc_icsr_el1;
+    } gicv5_cpuif;
+
     struct {
         /* M profile has up to 4 stack pointers:
          * a Main Stack Pointer and a Process Stack Pointer for each
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index c426e045d9..4420a44c71 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -35,6 +35,9 @@ FIELD(GIC_CDHM, ID, 0, 24)
 FIELD(GIC_CDHM, TYPE, 29, 3)
 FIELD(GIC_CDHM, HM, 32, 1)
 
+FIELD(GIC_CDRCFG, ID, 0, 24)
+FIELD(GIC_CDRCFG, TYPE, 29, 3)
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -134,6 +137,19 @@ static void gic_cdpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_pending(gic, id, pending, domain, type, virtual);
 }
 
+static void gic_cdrcfg_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDRCFG, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDRCFG, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    env->gicv5_cpuif.icc_icsr_el1 =
+        gicv5_request_config(gic, id, domain, type, virtual);
+}
+
 static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
@@ -194,11 +210,22 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdpend_write,
     },
+    {   .name = "GIC_CDRCFG", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 5,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdrcfg_write,
+    },
     {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdhm_write,
     },
+    {   .name = "ICC_ICSR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 4,
+        .access = PL1_RW, .type = ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.icc_icsr_el1),
+        .resetvalue = 0,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067BB10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C4-0006oV-6a; Fri, 27 Mar 2026 07:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C2-0006m2-2y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bw-0007yS-KD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo1387511f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610247; x=1775215047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AGUas74GiCe8W5uPOS1WFnAMWVY4ggcPmMUN6MKkgw=;
 b=nYZ9uouyMvABc3pPucNaB78MYSGpP6SwZAVJDO73E5C3CNiazekLX+F++116eyHm0Q
 wXtQzsTFcTFhEm15yCXJFFdCv6h4lYjN7sYIkgDRtQQK6RizipEQqEDRWz1e50rke89c
 8fNAhW4KtdkA8UnXFKja8kg9rdOOs6bw13aoMEdatHv9/VOQDjr9Q5kqR8u5Ug4tELlO
 IawMPgm4snmFSPaKtnfrzyLqcXWezQsneJ7TNPSzjM3Ky5n4RKpGRg8Q/CLOYRHmJCW+
 plQftz2SJLVWAcj2g6YrkKEq5rcG2VjbJk4ja9axk8YQ+irjMQsHIKB6eIUP5Ea2i7zh
 GiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610247; x=1775215047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8AGUas74GiCe8W5uPOS1WFnAMWVY4ggcPmMUN6MKkgw=;
 b=F/DLSCsFFHD+O8eDh2kN0sHposhujaK+GWBPCpUB9wCgmdgKVBmmPaaTzNV805l8+0
 +wPHoHwyIK9WMHphn+RyUokb3x67joLxoOsnb+MvrlF1WJFPlxLdNoCGIEmOw8zIqpFZ
 Mr67bcknSR4FyeCv8Q9Rd4VcpIt/lFuqFvTTfB86+vmEJNTrW7+w622DBjA1PFmfABKz
 gc1/53YJs+Ci+cAoWmZ9fCfVBgkIrqrX3v5CB0Ag6QvrFDcemLmbtGvUFjr2OAwmFRZu
 MgK0eqvDBmuxN71o4swmHIe9VSTwLFSSk7njGEMHaYM/zbeNZY+gUW0Q0htSryqTPl1Z
 wlRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBdoesLpqMCiZyI3+4guuHK+nKpCxKvrxg3R2UENel1lVCL9eDLF9qWrpeHmZIHaCE9ZEXg48e5fKs@nongnu.org
X-Gm-Message-State: AOJu0YwlagyIg0YE2P68ph2Fv8WnY68d+MJvwtgtS0dzkq05gyRjEuzo
 JbRcNAN9vvT/WRIkbRvs+/fkxtQ/2d9WDcZisjlJNqg2dmEYRqi52qGVsXBXwevshJE=
X-Gm-Gg: ATEYQzyL3bbSlN3vIWAogttD0CG0eUMUjAYjweROSAXS6IaEps46nE+hhNIvJYiJi93
 /IhNhzugtMxcku1ux5ra099QGUyKH2sRbmIHLVMfvJHVqSJ1t5M4tP3Tj7Di59VgKzHCm/mAu0T
 Fw0P/V1MMP5IiYcsRGmdwz8Ybz3zaUsnyE9R+S9mUGBtCTL/thk/zRu2FSZmWGSqoaFUVdB9q8d
 D7ZTCV3GIluZ2sk7ECunjWORnxA335UMW4xQ/2yO2FwM+DHvlnhe5pCyJPiamYFzCbxcoKmxWEJ
 2WmJxYh6TMUvlr0hqkSDuOjfKbiOlziqwXbEnbIZF/1gLymhzIwVcoXmJ1PCmmJ7Jsx8xI9fMWR
 BJOWgww3GLWjcalZlLfDowZmCl6oagLj4UeZd+w2crY9YnR8F6OYKQEAE+UPndRiVhaphawpoM2
 aHNCgb7YH5NMvi0UMC9f1w3QYHSvgAtq+WEkh7NgMaFDnrWltuQg1+H6OQzge6JO16rNS9bxIyv
 am5w5veBhT82wZlmAowbJrWD6/aP6c=
X-Received: by 2002:a05:6000:2282:b0:43b:4ef0:e17 with SMTP id
 ffacd0b85a97d-43b9e98139bmr3611466f8f.7.1774610246850; 
 Fri, 27 Mar 2026 04:17:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 26/65] target/arm: GICv5 cpuif: Implement GIC CDRCFG and
 ICC_ICSR_EL1
Date: Fri, 27 Mar 2026 11:16:21 +0000
Message-ID: <20260327111700.795099-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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
index 0c4349f8a7..8cf09791c1 100644
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



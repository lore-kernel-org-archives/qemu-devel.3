Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94444CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11X-0003qH-Vx; Thu, 07 May 2026 11:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11V-0003j1-Rw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11U-0003tH-3G
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso6533755e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169142; x=1778773942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RgyBHbgnTuAZMgct0W7kYb5/6ElaDq/A+vKEA2nxgy4=;
 b=p6h3bOF2V5Pep6b0D6V8YNB34YKEtt4UsuwpWk8o92HQAl8GS6S08xMPvICswCOO9d
 8q6JEJmiDYQ6+cwSG0SWDKoFWHp4PpAZ4C1VBpMFOdgXfqMR1UWkfpOE95qatnrCVGf+
 /g+4oNnjfsYfKvHXmazMEAnCPfJBrTT4bGRmijQ3yR3tmHfxqlNT+MoQeQqx2hElERg2
 psIp4lfJrCb2BMe2OmxYlPOdwC5HhReLXDCXQkId6CuXs6ev2nAmgS8XIFc3fHmtm6ne
 prpxFNuafkGJy7ZQrAqcJO+/rN+gK5Kwn0/XRLa7xjR36guDxZh2k/fjT+6OiqcC5izg
 INbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169142; x=1778773942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RgyBHbgnTuAZMgct0W7kYb5/6ElaDq/A+vKEA2nxgy4=;
 b=iuVvj91UESfPk5FwMDEopEXX5Sfnn7Yfz0ayqpxQdC06bt8mckoZ95/4dw77OoFIbr
 tH2WvcKjT/c1kJOQzv6rZu8j+zniEwQCOyiWYTp1J4NTNJZq27ApXcb7uSmPwGP6HDGC
 mIQ73SsnFaG0QNekNaYDzsWYahxCZxmsWZabPlekYOWI4SMp2BlFB9cw8rU5Nd+Ys6cS
 PIX0oe7LrPI71raheN/uNp/TESop1oCq+uyfmCdKI6Bs3qvJUKnXeKrWqUdHpyoIuLPD
 0qGDv5GzwUpj0tZvmGkuwdJ2lom5ZkmGIv4jQ24FRixi13guceJYqkG5vdPdqIqPBXqh
 mAlw==
X-Gm-Message-State: AOJu0YwIu1lQ/H0lowEflQr5SM6bR3gAGLY7yXgMiYzJ9Vk2Utwhoeko
 jTTRjkEAyx5wW9ut6snKRsPiS/T90GPlyOvVCvGlSumbeBfD8We+61V/ubuXXT9S3ebJvPcC32k
 1eTLl
X-Gm-Gg: AeBDievNmvzaF8muay+YiRd50P7nbsu4vR0mCZbR5o0gm7aUOjmlAl6QG7dAkEyDyc6
 Fp4xdEZu967VyP20t4B1e+fqh2U+L4FyXXpDDeVru/fRfKF+o9oLSo7A6S+hpajmCK3ik8QYfYI
 JfQT4TAcPYzNGALy8w5oObjEBrW6tq/b67FaOW91So2eZAT4CV6a+cyRgWYZPZHkNNLDppk9dnu
 2HnNQU/qAEburvLf8XnXOAdTViAjWW1WOE0h4XnTBhq1+XCokLeJhXdid29dOPVBvBNPp7U+hjd
 nZ7SRgUZR5Tyi2xFD8+MmgBIrFUkuN2fN8TxEqnJCtxNOh56yoGbVfuYkJzV2xFPBtFlb98FbpL
 Pdywf4GFyLhGmPcneKr4kzNouxx3b6G3d+dwp4Z6BRTZL1gct8PH0j13V9DUBaeOFrbpocCsrhb
 acnQZo89nS1kd/sSzxd+tvpqnPPZzMYYj8WgW/7D7HiHhejJlq/iqyZ/tblF+9TQMtvNSmy1IGF
 WEtJnkdqp+cE38OG3NrQupKYVlKWPM/yYWoKftJsw==
X-Received: by 2002:a05:600c:c4a3:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48e51f258damr136003175e9.9.1778169142294; 
 Thu, 07 May 2026 08:52:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/67] target/arm: GICv5 cpuif: Implement GIC CDRCFG and
 ICC_ICSR_EL1
Date: Thu,  7 May 2026 16:51:13 +0100
Message-ID: <20260507155154.1886557-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20260327111700.795099-27-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  5 +++++
 target/arm/tcg/gicv5-cpuif.c | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 91cb2b87f0..aa89b457b9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -596,6 +596,11 @@ typedef struct CPUArchState {
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSq-0005bO-7j; Fri, 01 Aug 2025 13:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3G-0002fh-IN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3D-0000yF-Gs
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so945536f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063525; x=1754668325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFU7cdermEBfIRmFJJXvXqdeDCykmx7B9ltL/jtSxbA=;
 b=Dn8Uz44xfOIag/zdF51esOD8GPY2uHznBMA7N3VZxSXzG/oaZJaBRW5rXIEBt272jf
 mAa3Y8oFto0Tps5dusiMYQHNSnnDcnrpXlc9a4Gm08YIBEb8c8TFca8mnU6+uKP3mVTY
 qolSAMIrr1NkS68tCSdpq/DMdg3iSQhG0GH81/ES6UYwr3bKNpHmsjF9kH6ismG/YevI
 ByTxWWey4qcTtBRxwgf+302dChglRHtvYqTynKQEM0/OPmlNXMx7Mf7YlWlEppe9d3pt
 XS8Rrm3mmbU8z75xc1DrI+itEK4c8QSljndKbIUChZ/GwIPkDGDNQoSKtqq7yxtIaR2N
 QVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063525; x=1754668325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFU7cdermEBfIRmFJJXvXqdeDCykmx7B9ltL/jtSxbA=;
 b=I5XuVZ2Ow8ta/0sBlPEW91MbbHuQ673OnJo8RbgRYi2xKJIDHRlkvUnVJT2Ep0Twnt
 z17mCE+iGIK/ig+eLPD05V+4jOcfI+NrRQQQZenXBJjLaLjNTAXlPqE8YQUnq6B4HGKd
 KJxk7tCxo75gzC4eFTc7FDK0WkS4PoRTm+MEG34SJ2zd+a4WCeTnojH2J+9GKrr8nsUL
 cln/KzqHEpuSR5cNAeGe3BApVqkZLPdxF7DAtpx8g2E5ORF7/mQQEHiXZQ80gWdRITjD
 4o38QmvA/FCvFiRe/MiW9Y5WRX58b9lS3owFzgfiJZ2R/1nlvuQJmuxRyaHQzJQZuyH8
 v8Ug==
X-Gm-Message-State: AOJu0YxCXP24Y/huFfYjIp8UVqccmog+oaS7gDO3GJ16MG2tHhbP/JG/
 3M55eKWAf1bDns4PK3Nw98q+i/x5SQxb7B3wXlapQBPspiVvN/TXlUry16Y7dXVGw+0mIte9LwS
 eNcfr
X-Gm-Gg: ASbGnctkgCJRlfm2fyZvLj+A3N1YmMwzej+eKy0levywncVw7jFe4n2ioss/e26+DK1
 JRwzAzWDofmHoqUpJvOWEXU0WkY+z4rgrPkT+szfVfxV3unaQyGMM+44GdtL2ngANfBdnPr9s/H
 TtFpYk024Cpos6gjA6wWAWmcl//z4g4EydSpTiJk9wqvqrCN8dB0jfz5hztvNhMvZUvajvdF69W
 LU2WFkRfKg6E8r9aXqZn4D9j+SX4vaoY0DlWwYqU1UbeMFOvHh8XP+NO0gpWIIelOzamGpl6vuX
 8rzktc+ZS/MFnkAIWwtaJdGoN+wYOYIPbKXASmxDB7n4d60TxNoB+hUBq25LAfCNW7JnrSIdM2j
 2/TcLkIO/SanMK7CWd+d1TAHhTdNEW0jHZ2j379k=
X-Google-Smtp-Source: AGHT+IE06JguCyTKTyKVaW5yE0VjvWfMOvfZ8F4AR9cwKd1ZrLGsjqDXEumtQqaUquLK2gfS5Y6LIQ==
X-Received: by 2002:a5d:5850:0:b0:3b8:d79a:6a53 with SMTP id
 ffacd0b85a97d-3b8d94708dfmr251589f8f.23.1754063525343; 
 Fri, 01 Aug 2025 08:52:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
Date: Fri,  1 Aug 2025 16:51:52 +0100
Message-ID: <20250801155159.400947-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Alex Richardson <alexrichardson@google.com>

In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
PMCCNTR was added. In QEMU we forgot to implement this, so only
provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
sysreg for AArch64, adding the 64-bit AArch32 version is easy.

We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
in the ARMv8 architecture. This is consistent with how we
handle the existing PMCCNTR support, where we always implement
it for all v7 CPUs. This is arguably something we should
clean up so it is gated on ARM_FEATURE_PMU and/or an ID
register check for the relevant PMU version, but we should
do that as its own tidyup rather than being inconsistent between
this PMCCNTR accessor and the others.

Since the register name is the same as the 32-bit PMCCNTR, we set
ARM_CP_NO_GDB on the 32-bit one to avoid generating an invalid GDB XML.

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Note for potential backporting:
 * this code in cpregs-pmu.c will be in helper.c on stable
   branches that don't have commit ae2086426d37

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Richardson <alexrichardson@google.com>
Message-id: 20250725170136.145116-1-alexrichardson@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs-pmu.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 0f295b1376c..9c4431c18ba 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -1067,11 +1067,6 @@ static const ARMCPRegInfo v7_pm_reginfo[] = {
       .fgt = FGT_PMSELR_EL0,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
       .writefn = pmselr_write, .raw_writefn = raw_write, },
-    { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
-      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
-      .fgt = FGT_PMCCNTR_EL0,
-      .readfn = pmccntr_read, .writefn = pmccntr_write32,
-      .accessfn = pmreg_access_ccntr },
     { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 0,
       .access = PL0_RW, .accessfn = pmreg_access_ccntr,
@@ -1211,6 +1206,23 @@ void define_pm_cpregs(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &pmcr);
         define_one_arm_cp_reg(cpu, &pmcr64);
         define_arm_cp_regs(cpu, v7_pm_reginfo);
+        /*
+         * 32-bit AArch32 PMCCNTR. We don't expose this to GDB if the
+         * new-in-v8 PMUv3 64-bit AArch32 PMCCNTR register is implemented
+         * (as that will provide the GDB user's view of "PMCCNTR").
+         */
+        ARMCPRegInfo pmccntr = {
+            .name = "PMCCNTR",
+            .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
+            .access = PL0_RW, .accessfn = pmreg_access_ccntr,
+            .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
+            .fgt = FGT_PMCCNTR_EL0,
+            .readfn = pmccntr_read, .writefn = pmccntr_write32,
+        };
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            pmccntr.type |= ARM_CP_NO_GDB;
+        }
+        define_one_arm_cp_reg(cpu, &pmccntr);
 
         for (unsigned i = 0, pmcrn = pmu_num_counters(env); i < pmcrn; i++) {
             g_autofree char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
@@ -1276,6 +1288,13 @@ void define_pm_cpregs(ARMCPU *cpu)
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
               .fgt = FGT_PMCEIDN_EL0,
               .resetvalue = cpu->pmceid1 },
+            /* AArch32 64-bit PMCCNTR view: added in PMUv3 with Armv8 */
+            { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .crm = 9, .opc1 = 0,
+              .access = PL0_RW, .accessfn = pmreg_access_ccntr, .resetvalue = 0,
+              .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+              .fgt = FGT_PMCCNTR_EL0, .readfn = pmccntr_read,
+              .writefn = pmccntr_write,  },
         };
         define_arm_cp_regs(cpu, v8_pm_reginfo);
     }
-- 
2.43.0



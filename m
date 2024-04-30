Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62863C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfK-0002Y4-30; Tue, 30 Apr 2024 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf4-0002Ot-La
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qew-0005cL-95
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b7a26326eso35504325e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495727; x=1715100527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EicQ/uN3TXAQIq8jK5susffL3tHL9yIq4ZmNUswR4uA=;
 b=PxeEydKljkJzLRygze4nOmshAvz/DjOL0jDWYZmwMJjdlNYWY2YkEa87AnPHh+wOPy
 e9wHE+d2vEDgNFqRPIqVd8kOI0YTcyYXI1Z0XurYUhQ1Pg7OEHlDxulrdUrhuNB7zqA1
 uWS/p8g5xKwjRo2ZxxbkRXcNWm3hmdu+2T864Y4aTflf1Gbd95nIduFOFv20EWNB1L1+
 ++twQp/QtEAtPQfnkURB5eh2sm6/LHXIBRUr+u9FY2D2FvF4/KgTyVQ/Q9VQY4YVW8FW
 SI3B8oqRJMCVTrNcjzWa3kseyYk/fxFKo9aD5YfRzy6WYyT/mFDeRYir2rEUmjMx01u8
 bh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495727; x=1715100527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EicQ/uN3TXAQIq8jK5susffL3tHL9yIq4ZmNUswR4uA=;
 b=JhM1lk8xlLLY2Xngle5f982gU/lgYfLh+oCo0fcLeauGgEW6DmLVp0DYMWv8tL6+bV
 XDycY8lupjBmPE2rkLgyPOt5/i7jV9AYC21S6CgvjnVHcZYUfrCp+ReXWSMRGngb/ZoM
 iv/jsqDNyONfNh88ClqYH7ZtlCMUOAVy06xXtQ9f9Tz97StJDmGk/9/FHlJOvpPncTKn
 KGaHy5Ex0x6K6ia1uPlrb4YFFHYVzsQPTa3lWm7dHhU7Qbn7ML8OI/jPnEWE+2zD3oir
 8P/VSO1TAJ24xBmkGkckUYygyJQzzQExryFREn9ONO+lFLZ2VmPhEfrEaGrA0YE+S0AI
 w2jg==
X-Gm-Message-State: AOJu0Yxe5vR+FY0azNZ+wvcyqQGdapwfAznnmSEVrB5xlJnYJ5tQ8tNX
 oirzBkZtd7MroMV8bFBxo36vG70fALRS1zngs1gqgLy4f1nHAHo5l9Ml933q2gvvQfFfTx0SAyL
 D
X-Google-Smtp-Source: AGHT+IEF3JhZHczV1AksrXYBkLpCJx7HX7k3HhCEkSC14TvIyptVfeONEpfvYj/Y/3w/cx0V5Z00iA==
X-Received: by 2002:a05:600c:4f4b:b0:41a:f936:5326 with SMTP id
 m11-20020a05600c4f4b00b0041af9365326mr80447wmq.15.1714495727599; 
 Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] target/arm: Implement ID_AA64MMFR3_EL1
Date: Tue, 30 Apr 2024 17:48:28 +0100
Message-Id: <20240430164842.4074734-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Newer versions of the Arm ARM (e.g.  rev K.a) now define fields for
ID_AA64MMFR3_EL1.  Implement this register, so that we can set the
fields if we need to.  There's no behaviour change here since we
don't currently set the register value to non-zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240418152004.2106516-5-peter.maydell@linaro.org
---
 target/arm/cpu.h     | 17 +++++++++++++++++
 target/arm/helper.c  |  6 ++++--
 target/arm/hvf/hvf.c |  2 ++
 target/arm/kvm.c     |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 17efc5d565a..1f90590f937 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1011,6 +1011,7 @@ struct ArchCPU {
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
         uint64_t id_aa64mmfr2;
+        uint64_t id_aa64mmfr3;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
         uint64_t id_aa64zfr0;
@@ -2206,6 +2207,22 @@ FIELD(ID_AA64MMFR2, BBM, 52, 4)
 FIELD(ID_AA64MMFR2, EVT, 56, 4)
 FIELD(ID_AA64MMFR2, E0PD, 60, 4)
 
+FIELD(ID_AA64MMFR3, TCRX, 0, 4)
+FIELD(ID_AA64MMFR3, SCTLRX, 4, 4)
+FIELD(ID_AA64MMFR3, S1PIE, 8, 4)
+FIELD(ID_AA64MMFR3, S2PIE, 12, 4)
+FIELD(ID_AA64MMFR3, S1POE, 16, 4)
+FIELD(ID_AA64MMFR3, S2POE, 20, 4)
+FIELD(ID_AA64MMFR3, AIE, 24, 4)
+FIELD(ID_AA64MMFR3, MEC, 28, 4)
+FIELD(ID_AA64MMFR3, D128, 32, 4)
+FIELD(ID_AA64MMFR3, D128_2, 36, 4)
+FIELD(ID_AA64MMFR3, SNERR, 40, 4)
+FIELD(ID_AA64MMFR3, ANERR, 44, 4)
+FIELD(ID_AA64MMFR3, SDERR, 52, 4)
+FIELD(ID_AA64MMFR3, ADERR, 56, 4)
+FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b224826fbb..bb0e1baf628 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9004,11 +9004,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr2 },
-            { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64mmfr3 },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -9165,6 +9165,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .exported_bits = R_ID_AA64MMFR1_AFP_MASK },
             { .name = "ID_AA64MMFR2_EL1",
               .exported_bits = R_ID_AA64MMFR2_AT_MASK },
+            { .name = "ID_AA64MMFR3_EL1",
+              .exported_bits = 0 },
             { .name = "ID_AA64MMFR*_EL1_RESERVED",
               .is_glob = true },
             { .name = "ID_AA64DFR0_EL1",
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8e942f89b35..08d0757438c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -497,6 +497,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
 #endif
     { HV_SYS_REG_ID_AA64MMFR1_EL1, HVF_SYSREG(0, 7, 3, 0, 1) },
     { HV_SYS_REG_ID_AA64MMFR2_EL1, HVF_SYSREG(0, 7, 3, 0, 2) },
+    /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
 
     { HV_SYS_REG_MDSCR_EL1, HVF_SYSREG(0, 2, 2, 0, 2) },
     { HV_SYS_REG_SCTLR_EL1, HVF_SYSREG(1, 0, 3, 0, 0) },
@@ -855,6 +856,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
         { HV_SYS_REG_ID_AA64MMFR2_EL1, &host_isar.id_aa64mmfr2 },
+        /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
     };
     hv_vcpu_t fd;
     hv_return_t r = HV_SUCCESS;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 21ebbf3b8f8..7cf5cf31dec 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -331,6 +331,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr3,
+                              ARM64_SYS_REG(3, 0, 0, 7, 3));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.34.1



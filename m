Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06189C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSR-0005Y3-83; Tue, 01 Jul 2025 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSL-0005SH-31
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0003Om-9J
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so49885855e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389652; x=1751994452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=woNG226mYLpY0jKWxUwCaex2A1BTO3B77V+A/DKKFPY=;
 b=maaAkhbbtA2G8umxGA1OuS0dtB8PQhIxcQjR6YDCPrU+6xuqKfF+C7OjBzF8Pmfbtq
 4qNpOVf3iTEdI+P3GC/vgSamRj9aERnX8gfycpvXbdfEiw6+3fw8PRp3wfxAMRG4Y81u
 ZPIbluGobEPnmHZfBXuKMyoC66b6JSi9P6adcqXRpeQQO+WsIEx4WgxevV1djizeyRC6
 q5UuiHrw4KsvefTrE7mdyPqrDIeNzY4i4l1UeYf6ogB1dCVHEnt0535G5Zs4rOP+gUF1
 p3hSLLxwhkL0D6/7f6c4jE2JyzANGYLLNAXUjxBXzzx+5ptUQINSc8YNO3sjdaE0ECd8
 sJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389652; x=1751994452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woNG226mYLpY0jKWxUwCaex2A1BTO3B77V+A/DKKFPY=;
 b=DZMN8pNcPWeEkqJcCAI8ElT5ier8x38f4WAUZDgZbpQcLRCoOH0bbx5Vf8XeC828jf
 BrkB3FbnXFGvm2mj1EYmsquBsyw567breq1EyqCu2qYtuRgE5kSx833c+3qO9DdX3wsG
 tBIkD6ENPI7ftfUa6nbEuyBTC7v0ouC6mXXM2UnzTEM1iTw0FHgSrUSGsdaNtiQpmwN9
 t6EVZFlG0jzxodjND+oaDD5PeCk7vKe8wrN8W/MPvYGBVpCx1x/iQduSbN+okPv8k4SB
 +OoSP/Bra5s9ZkY9bSr4+fa35SZrDueCvuungT658MMHIMK28CjeHi3TKl5WHNg1weLO
 9Pwg==
X-Gm-Message-State: AOJu0YwSmJbKRugH8r7P4FIm1+IC4AQr76JLtuc7rqpq9TfReNZgAB0i
 z0POuDMVW3xXNN9i3iVjAGoTmdVV+nrnggQJj8HkcytBB8gJx5BXN4E3wg1qQ9hcTFnvc9p8SEp
 bB5MB
X-Gm-Gg: ASbGncvmfhysARNPPI+Cd9aK7y/uGE3irsyipY46dIWFZLFh7Z0jz61j//CWgBrWAqM
 Fu+h4u8XZZ7RsKC5q4PoOnMXTjp7znuTWVlgiVjvTKH0SLDcfgfItIhA2ilZWRCldinVZ0uy8to
 4Vwzgcr04W50F+QVIlkPmmoIdI2+NyUwIDJWmU5Ss+qBdDIHFMU4dJLJ9ZRggBPpBr5PGTWN8Us
 OlEdkenDUH6A3RcJBmoPBvMGojyay99R9M4piVSfQyfqOnAV1ab8gfL6knx1TVriQwnWE8pMh+9
 sjDZkWzbhkk7Kh0CwgIntvzeIAwGYukgMZ4SLa/2+lwkYYaBPeuJGGJexiyLb3GlfL7FdvrBj1c
 a+zM=
X-Google-Smtp-Source: AGHT+IF9RoNLL4F6UD4Z4oPn+eFxoIQcZgBXCsXnEvE4OEwGFL3EPShqk050bKkgPm9moHhjSDxJRw==
X-Received: by 2002:a05:600c:4685:b0:450:cff7:62f9 with SMTP id
 5b1f17b1804b1-4538ee56520mr177226415e9.22.1751389652065; 
 Tue, 01 Jul 2025 10:07:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/43] arm/cpu: Store aa64smfr0 into the idregs array
Date: Tue,  1 Jul 2025 18:06:45 +0100
Message-ID: <20250701170720.4072660-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-8-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 6 +++---
 target/arm/cpu.h          | 1 -
 target/arm/cpu64.c        | 7 ++-----
 target/arm/helper.c       | 2 +-
 target/arm/kvm.c          | 3 +--
 target/arm/tcg/cpu64.c    | 4 ++--
 6 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 9517e8a74c8..051ed7b8847 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -979,17 +979,17 @@ static inline bool isar_feature_aa64_sve_f64mm(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_sme_f64f64(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, F64F64);
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F64F64);
 }
 
 static inline bool isar_feature_aa64_sme_i16i64(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, I16I64) == 0xf;
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, I16I64) == 0xf;
 }
 
 static inline bool isar_feature_aa64_sme_fa64(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64smfr0, ID_AA64SMFR0, FA64);
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, FA64);
 }
 
 /*
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c7935377c6f..1083ae7623b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,7 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64smfr0;
         uint64_t reset_pmcr_el0;
         uint64_t idregs[NUM_ID_IDX];
     } isar;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a215ba8b479..0f938155d28 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -328,7 +328,7 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 
     if (vq_map == 0) {
         if (!cpu_isar_feature(aa64_sme, cpu)) {
-            cpu->isar.id_aa64smfr0 = 0;
+            SET_IDREG(&cpu->isar, ID_AA64SMFR0, 0);
             return;
         }
 
@@ -381,11 +381,8 @@ static bool cpu_arm_get_sme_fa64(Object *obj, Error **errp)
 static void cpu_arm_set_sme_fa64(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    uint64_t t;
 
-    t = cpu->isar.id_aa64smfr0;
-    t = FIELD_DP64(t, ID_AA64SMFR0, FA64, value);
-    cpu->isar.id_aa64smfr0 = t;
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64SMFR0, FA64, value);
 }
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2ac132c1db8..39729d3a8d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7948,7 +7948,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64smfr0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64SMFR0)},
             { .name = "ID_AA64PFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 479e5860e02..87368558614 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -314,8 +314,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err = 0;
     } else {
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64PFR1_EL1_IDX);
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
-                              ARM64_SYS_REG(3, 0, 0, 4, 5));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64SMFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR0_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64DFR1_EL1_IDX);
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 7e18d31a253..80a99ab025d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1267,7 +1267,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     SET_IDREG(isar, ID_AA64DFR0, t);
 
-    t = cpu->isar.id_aa64smfr0;
+    t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
@@ -1275,7 +1275,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
-    cpu->isar.id_aa64smfr0 = t;
+    SET_IDREG(isar, ID_AA64SMFR0, t);
 
     /* Replicate the same data to the 32-bit id registers.  */
     aa32_max_features(cpu);
-- 
2.43.0



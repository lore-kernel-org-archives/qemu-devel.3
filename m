Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3803EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRXJ-00078P-L5; Thu, 27 Aug 2026 00:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXH-000785-K8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXF-0006TN-0H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d58efc7356so20400635ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804175; x=1788408975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8fVuO7QFobOaYWyxa9ruyag/nbjeuTU+JhVLHb50t1A=;
 b=mE6Gbt1k8k4ugvMy9ELc2gF9wMifV89YPX4sJ+rrdwi4Uf3B4W8PMgqjmUjoK+2xqY
 HUdZErhM/xCzDdtw6plowilZwkZwYzW3TCAU5ruI/uoYheBh7UDzjTcMEyc4YjzSSx8d
 bI30JDZKtahP4dqwnLA5wqeWE9+FWCdrZt8dOjKXlpwmR6wydf7fk6+VULbXVnu5Tvn5
 V2JE/SRz10GH8qCORzM14CZiLG4xqbHvq3Ys+iiBhVf/awrpPr3Qgrqnw17SKO19jqDt
 3uRZK2pzUQPZ3/haIztTD+I6DTSV3eKbQTdlpQy4MaAaKtPWt5aRN8HYPz1+IlJtE7LB
 0HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804175; x=1788408975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8fVuO7QFobOaYWyxa9ruyag/nbjeuTU+JhVLHb50t1A=;
 b=oylpfaKzFdw6o/gDwuWkqcbN0uzL+ovI9kUeCW0XoUd7GywBZyqsW/CI8DnalR9T0L
 oM1AlbWevfJbQaAVhQ1mo1QokARrzweclFsInKrnpN0V2xxEB4GwRvz16IZBxvkc7XHV
 qggPYalzchEE/XlFnV49pfG0dHyk05a2GfRuTgvWZLPfAPJ6CWhH4VnCOa3UAAIO0QQh
 UlIYLB/s/eTzDTqstkytelf31SjVs0kew+ZOP4CuDhf74vHZ8o1rM44OwShbB3JvE5XW
 iHJzyw92hi9h4lA9LMakOW+F9nKu4bdQlUf58tK2WIwoHoR1CwsVRrrniOPnZ4BqSqoc
 bJcw==
X-Gm-Message-State: AFuF++kd2cHZfmP/dWiXw3k3S4oQ697SQjYJ7RXXeYAaRD/18B+IiM+4
 NVKw19j6kOc6Yuxs3I/iOAOimJi17gXDHwnJd1XDvHj2QeMPxr/OSVXq6wbNzorle0nsBEl+eGe
 FakPB
X-Gm-Gg: AR+sD13qznUcrVG1rlCRe5MEB4B4ymp7mRSktADG+5867/iHpZ6sw+MUmdkIpwOjOmu
 s89r4ucBJIgwRbHnJM7gN2NgcAXOZAhhbgOtZBKDsUmU5Uf8sWQwpxPJZOPAPC3ReS3muLZi+un
 3m/XqTPLIzE/aevLl8k4bTPQjmGOox2pTm/gYlGhZCjG36+p8q9eGgvIP5aBH/LXOBzjLhmPWJs
 zp9uMkEIRh826hVrNL2XRq17qra8r1NumSLYmfKpbPeCaixqVevm4+glZS7N9Tf+4FTr/9aN+pm
 qSAv+evJCyAIxR6onqSvgA4mpv0Kp2EdbujdIvbt8kyIQbHjAWiz5daHDfVbcou2oYqRoGipCt6
 8EK7jI+0AhV7daRBI0dneeJk/Wa0QvOcw5PAFlcLGyz5AI1/LL/YDKLn9Wh5eXPiOOC+fLJKAzQ
 J1YkaqQ/MVKQTV52EmGIBZ/uCKTwymayCVaZqHGJ6n7uIO98PWFUafncnAS+kAO29HbEGshNVBj
 zLpGLzkfujx1vDbUyIZFvy1b6vw
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-3966d83231cmr25945473a91.13.1787804175334; 
 Wed, 26 Aug 2026 21:16:15 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d81682sm969597a91.7.2026.08.26.21.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:16:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v4 6/6] target/arm: Separate cpu types max-v8 and max-v9
Date: Wed, 26 Aug 2026 21:15:57 -0700
Message-ID: <20260827041557.775080-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827041557.775080-1-richard.henderson@linaro.org>
References: <20260827041557.775080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Do not include v9-only features in "max-v8".
Do not include the prohibited v8 features in "max-v9".
In aarch64 tcg mode, define "max" as "max-v9".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h        |   3 +-
 target/arm/cpu-max.c          |   2 +-
 target/arm/tcg/cpu-max-v8.c   |   2 +-
 target/arm/tcg/cpu64.c        | 160 ++++++++++++++++++++++------------
 target/arm/tcg/stubs32.c      |   7 +-
 docs/system/arm/emulation.rst |  13 ++-
 6 files changed, 128 insertions(+), 59 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc7d5ad6f2c..1775835ad50 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1809,7 +1809,8 @@ void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
-void aarch64_max_tcg_initfn(Object *obj);
+void aarch64_max_v8_tcg_initfn(Object *obj);
+void aarch64_max_v9_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 9ed45c8764f..739500a04fc 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -110,7 +110,7 @@ static void cpu_max_initfn(Object *obj)
         if (!aarch64_enabled) {
             aarch32_max_v8_tcg_initfn(obj);
         } else {
-            aarch64_max_tcg_initfn(obj);
+            aarch64_max_v9_tcg_initfn(obj);
         }
         return;
     }
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 55f8c341423..65f851f2006 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -123,7 +123,7 @@ static void cpu_max_v8_register_type(void)
 {
     static const ARMCPUInfo max_v8[2] = {
         { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
-        { .name = "max-v8", .initfn = aarch64_max_tcg_initfn }
+        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
     };
     arm_cpu_register(&max_v8[target_aarch64()]);
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index d44a8221c8b..251c4b3cf60 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1166,11 +1166,10 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 }
 
 /*
- * -cpu max: a CPU with as many features enabled as our emulation supports.
- * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
- * this only needs to handle 64 bits.
+ * -cpu max-v8: an ARMv8 CPU with as many features enabled as
+ * our emulation supports.
  */
-void aarch64_max_tcg_initfn(Object *obj)
+void aarch64_max_v8_tcg_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
@@ -1244,7 +1243,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* v8.0: FEAT_SHA1 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* v8.1: FEAT_SHA512 */
     t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* v8.0: FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* v8.0: FEAT_LSE */
     t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* v8.0: FEAT_RDM */
     t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* v8.1: FEAT_SHA3 */
     t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* v8.1: FEAT_SM3 */
@@ -1277,16 +1276,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* v8.7: FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* v8.7: FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* v8.6: FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
-    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* v8.7: FEAT_CSSC */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* v8.8: FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-    t = GET_IDREG(isar, ID_AA64ISAR3);
-    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
-    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
-    SET_IDREG(isar, ID_AA64ISAR3, t);
-
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* v8.2: FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* v8.2: FEAT_FP16 */
@@ -1308,17 +1301,14 @@ void aarch64_max_tcg_initfn(Object *obj)
      */
     t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* v8.5: FEAT_MTE3 */
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* v8.3: FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* v8.4: FEAT_RNG_TRAP */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* v8.0: FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* v8.7: FEAT_NMI */
-    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
     /* v8.7: FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
-    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* v8.7: FEAT_MTE_TAGGED_FAR */
     t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1); /* v8.7: FEAT_MTE_STORE_ONLY */
     t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);   /* v8.7: FEAT_MTE_PERM */
@@ -1368,25 +1358,14 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);     /* v8.0: FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);   /* v8.0: FEAT_SCTLR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* v8.2: FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* v8.8: FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* v8.8: FEAT_S2PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* v8.8: FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-    t = GET_IDREG(isar, ID_AA64MMFR4);
-    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
-    SET_IDREG(isar, ID_AA64MMFR4, t);
-
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* v8.2: FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
     t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* v8.1: FEAT_I8MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* v8.2: FEAT_F32MM */
     t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* v8.2: FEAT_F64MM */
@@ -1398,6 +1377,106 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* v8.5: FEAT_HPMN0 */
     SET_IDREG(isar, ID_AA64DFR0, t);
 
+    /* Replicate the same data to the 32-bit id registers.  */
+    aa32_max_features(cpu);
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * For usermode -cpu max we can use a larger and more efficient DCZ
+     * blocksize since we don't have to follow what the hardware does.
+     */
+    cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
+    set_dczid_bs(cpu, 7); /*  512 bytes */
+#endif
+
+    /* v8.2: FEAT_SVE */
+    cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
+    aarch64_add_sve_properties(OBJECT(cpu));
+    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32",
+                        cpu_max_get_sve_max_vq, cpu_max_set_sve_max_vq,
+                        NULL, NULL);
+
+    /* v8.2: FEAT_PAuth2 */
+    aarch64_add_pauth_properties(OBJECT(cpu));
+
+    /* v8.4: FEAT_MTE2 */
+    cpu->gm_blocksize = 6;  /*  256 bytes */
+
+    /* v8.6: FEAT_LPA2 */
+    qdev_property_add_static(DEVICE(cpu), &arm_cpu_lpa2_property);
+}
+
+/*
+ * -cpu max-v9: an ARMv9 CPU with as many features enabled as
+ * our emulation supports.
+ */
+void aarch64_max_v9_tcg_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+    uint64_t t;
+
+    /* Armv9.0 is based on a minimum of Armv8.5. */
+    aarch64_max_v8_tcg_initfn(obj);
+
+    /*
+     * Armv9.0 does not support AArch32 except at EL0,
+     * therefore indicate EL1 through EL3 are AArch64-only.
+     */
+    t = GET_IDREG(isar, ID_AA64PFR0);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL1, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL2, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL3, 1);
+    SET_IDREG(isar, ID_AA64PFR0, t);
+
+    /* v9.0 prohibits FEAT_DoubleLock. */
+    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
+    FIELD_DP64_IDREG(isar, ID_AA64PFR0, RAS, 1);
+    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);
+
+    /*
+     * Below, note the revision from which the feature is OPTIONAL.
+     */
+    t = GET_IDREG(isar, ID_AA64ISAR0);
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    SET_IDREG(isar, ID_AA64ISAR0, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR2);
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    SET_IDREG(isar, ID_AA64ISAR2, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR1);
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
+    SET_IDREG(isar, ID_AA64PFR1, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
+    SET_IDREG(isar, ID_AA64MMFR3, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
+    t = GET_IDREG(isar, ID_AA64ZFR0);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
+    SET_IDREG(isar, ID_AA64ZFR0, t);
+
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* v9.4: FEAT_SME_MOP4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* v9.4: FEAT_SME_TMOP */
@@ -1434,43 +1513,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* v9.2: FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
-    /* Replicate the same data to the 32-bit id registers.  */
-    aa32_max_features(cpu);
-
-#ifdef CONFIG_USER_ONLY
-    /*
-     * For usermode -cpu max we can use a larger and more efficient DCZ
-     * blocksize since we don't have to follow what the hardware does.
-     */
-    cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-    set_dczid_bs(cpu, 7); /*  512 bytes */
-#endif
-
-    /* v8.4: FEAT_MTE2 */
-    cpu->gm_blocksize = 6;  /*  256 bytes */
-
-    /* v8.2: FEAT_SVE */
-    cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
-    aarch64_add_sve_properties(obj);
-    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
-                        cpu_max_set_sve_max_vq, NULL, NULL);
-
     /* v9.2: FEAT_SME */
     cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
     aarch64_add_sme_properties(obj);
 
-    /* v8.2: FEAT_PAuth2 */
-    aarch64_add_pauth_properties(obj);
-
     /* v9.1: FEAT_RME */
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
 
     /* v9.4: FEAT_RME_GPC2 */
     object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
-
-    /* v8.6: FEAT_LPA2 */
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
 
 static const ARMCPUInfo aarch64_cpus[] = {
@@ -1488,7 +1540,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
-    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_v9_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index 78f819ef6ff..af0911a24c3 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -28,7 +28,12 @@ void aarch64_host_initfn(Object *obj)
     g_assert_not_reached();
 }
 
-void aarch64_max_tcg_initfn(Object *obj)
+void aarch64_max_v8_tcg_initfn(Object *obj)
+{
+    g_assert_not_reached();
+}
+
+void aarch64_max_v9_tcg_initfn(Object *obj)
 {
     g_assert_not_reached();
 }
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index cc42db9e0b7..ff02435975b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -230,7 +230,18 @@ to the `Arm Architecture Reference Manual for A-profile architecture
 When a specific named CPU is being emulated, only those features which
 are present in hardware for that CPU are emulated. (If a feature is
 not in the list above then it is not supported, even if the real
-hardware should have it.) The ``max`` CPU enables all features.
+hardware should have it.)
+
+The ``max-v8`` CPU enables all of the listed Armv8-A architecture
+extensions but none of the Armv9-A architecture extensions.
+
+The ``max-v9`` CPU enables all of the listed extensions except for
+those that are prohibited by the Armv9-A architecture: FEAT_AA32EL1,
+FEAT_AA32EL2, FEAT_AA32EL3, and FEAT_DoubleLock.
+
+The ``max`` CPU is an alias for ``max-v9`` under AArch64 TCG emulation,
+an alias for ``max-v8`` under AArch32 TCG emulation, or an alias
+for ``host`` under hardware virtualization.
 
 R-profile CPU architecture support
 ==================================
-- 
2.53.0



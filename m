Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78D9C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYgc-0004tL-Be; Tue, 17 Jun 2025 11:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYQ3-00053x-0r
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uRYPz-0005UU-65
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750174810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyTIbEgXbuwezVRjKEXc/iUv2dNBEkkug7tRZcwCmow=;
 b=RJRZJodCvDmJf//Pr6rJRLT6lytKkqd+UsCa4kS0sNGHh3ZqEQlFETtuu3+7YJG0twSl1C
 KAThzx3/VRTp+NT8v/Q4t/zk/y1JHZGEisxxQ0lVle2BDNVg5dBbQPVpfmT8FNQ5C10l00
 4Vh5Wyj98TDWohix/wfKJclK1GXQcFU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-CHcTlNWXPMCEdlJBwVXYCw-1; Tue,
 17 Jun 2025 11:40:06 -0400
X-MC-Unique: CHcTlNWXPMCEdlJBwVXYCw-1
X-Mimecast-MFC-AGG-ID: CHcTlNWXPMCEdlJBwVXYCw_1750174805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6788B19560AA; Tue, 17 Jun 2025 15:40:04 +0000 (UTC)
Received: from gondolin.str.redhat.com (pixel-6a.str.redhat.com
 [10.33.192.205])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1571180045B; Tue, 17 Jun 2025 15:39:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v8 03/14] arm/cpu: Store aa64isar1/2 into the idregs array
Date: Tue, 17 Jun 2025 17:39:20 +0200
Message-ID: <20250617153931.1330449-4-cohuck@redhat.com>
In-Reply-To: <20250617153931.1330449-1-cohuck@redhat.com>
References: <20250617153931.1330449-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/arm/cpu-features.h | 44 +++++++++++++++++++--------------------
 target/arm/cpu.c          | 13 ++++--------
 target/arm/cpu.h          |  2 --
 target/arm/cpu64.c        |  9 ++++----
 target/arm/helper.c       |  4 ++--
 target/arm/hvf/hvf.c      |  2 +-
 target/arm/kvm.c          |  6 ++----
 target/arm/tcg/cpu64.c    | 24 ++++++++++-----------
 8 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6a47f1a6d222..43c9695be0d0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -468,17 +468,17 @@ static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, JSCVT) != 0;
 }
 
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, FCMA) != 0;
 }
 
 static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, XS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, XS) != 0;
 }
 
 /*
@@ -502,9 +502,9 @@ isar_feature_pauth_feature(const ARMISARegisters *id)
      * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
      * and the other two must be zero.  Thus we may avoid conditionals.
      */
-    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
-            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
-            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
+    return (FIELD_EX64_IDREG(id, ID_AA64ISAR1, APA) |
+            FIELD_EX64_IDREG(id, ID_AA64ISAR1, API) |
+            FIELD_EX64_IDREG(id, ID_AA64ISAR2, APA3));
 }
 
 static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
@@ -522,7 +522,7 @@ static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
      * Return true if pauth is enabled with the architected QARMA5 algorithm.
      * QEMU will always enable or disable both APA and GPA.
      */
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, APA) != 0;
 }
 
 static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
@@ -531,77 +531,77 @@ static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
      * Return true if pauth is enabled with the architected QARMA3 algorithm.
      * QEMU will always enable or disable both APA3 and GPA3.
      */
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, APA3) != 0;
 }
 
 static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, SB) != 0;
 }
 
 static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, SPECRES) != 0;
 }
 
 static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, FRINTTS) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, DPB) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, DPB) >= 2;
 }
 
 static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, BF16) != 0;
 }
 
 static inline bool isar_feature_aa64_ebf16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) > 1;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, BF16) > 1;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, LRCPC) != 0;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, LRCPC) >= 2;
 }
 
 static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, I8MM) != 0;
 }
 
 static inline bool isar_feature_aa64_wfxt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, WFXT) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, WFXT) >= 2;
 }
 
 static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, BC) != 0;
 }
 
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
 }
 
 static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, RPRES);
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
 }
 
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f033411b5dad..2777de729445 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2123,9 +2123,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        t = cpu->isar.id_aa64isar1;
-        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
-        cpu->isar.id_aa64isar1 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64ISAR1, JSCVT, 0);
 
         t = cpu->isar.id_aa64pfr0;
         t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
@@ -2178,11 +2176,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
         SET_IDREG(isar, ID_AA64ISAR0, t);
 
-        t = cpu->isar.id_aa64isar1;
+        t = GET_IDREG(isar, ID_AA64ISAR1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 0);
-        cpu->isar.id_aa64isar1 = t;
+        SET_IDREG(isar, ID_AA64ISAR1, t);
 
         t = cpu->isar.id_aa64pfr0;
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
@@ -2218,14 +2216,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
-        uint64_t t;
         uint32_t u;
 
         FIELD_DP64_IDREG(isar, ID_AA64ISAR0, FHM, 0);
 
-        t = cpu->isar.id_aa64isar1;
-        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
-        cpu->isar.id_aa64isar1 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64ISAR1, FRINTTS, 0);
 
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7b5c7a4abc7e..b81bc46966f5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,8 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64isar1;
-        uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c105fcc4ea57..e2b25b004311 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -502,6 +502,7 @@ void aarch64_add_sme_properties(Object *obj)
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
+    ARMISARegisters *isar = &cpu->isar;
     uint64_t isar1, isar2;
 
     /*
@@ -512,13 +513,13 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
      *
      * Begin by disabling all fields.
      */
-    isar1 = cpu->isar.id_aa64isar1;
+    isar1 = GET_IDREG(isar, ID_AA64ISAR1);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 0);
 
-    isar2 = cpu->isar.id_aa64isar2;
+    isar2 = GET_IDREG(isar, ID_AA64ISAR2);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
@@ -580,8 +581,8 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
         }
     }
 
-    cpu->isar.id_aa64isar1 = isar1;
-    cpu->isar.id_aa64isar2 = isar2;
+    SET_IDREG(isar, ID_AA64ISAR1, isar1);
+    SET_IDREG(isar, ID_AA64ISAR2, isar2);
 }
 
 static const Property arm_cpu_pauth_property =
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2457c8853c60..2caaa49b91f9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8008,12 +8008,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar1 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR1)},
             { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar2 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5d25260c5c36..7554282410f1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -868,7 +868,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
+        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bd33b0f656ed..6fa5bdff42a2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -323,10 +323,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
-                              ARM64_SYS_REG(3, 0, 0, 6, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
-                              ARM64_SYS_REG(3, 0, 0, 6, 2));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR2_EL1_IDX);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ed681ee08b0d..917502647246 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -68,7 +68,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64isar1 = 0;
+    SET_IDREG(isar, ID_AA64ISAR1, 0);
     cpu->isar.id_aa64mmfr0 = 0x00101122;
     cpu->isar.id_aa64mmfr1 = 0;
     cpu->clidr = 0x0a200023;
@@ -224,7 +224,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -357,7 +357,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -437,7 +437,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64mmfr1 = 0x0000000011212100;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000000010211120);
-    cpu->isar.id_aa64isar1 = 0x0000000000010001;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000010001);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
     cpu->clidr = 0x0000000080000023;
     /* 64KB L1 dcache */
@@ -605,7 +605,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -684,7 +684,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
     cpu->isar.id_aa64dfr1 = 0x00000000;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
@@ -933,7 +933,7 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
-    cpu->isar.id_aa64isar1 = 0x0010111101211052ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0010111101211052ull);
     cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
@@ -1035,7 +1035,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0011111101211052ull);
     cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x1221011112101011ull;
@@ -1160,7 +1160,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR0, t);
 
-    t = cpu->isar.id_aa64isar1;
+    t = GET_IDREG(isar, ID_AA64ISAR1);
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
     t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
@@ -1174,14 +1174,14 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
-    cpu->isar.id_aa64isar1 = t;
+    SET_IDREG(isar, ID_AA64ISAR1, t);
 
-    t = cpu->isar.id_aa64isar2;
+    t = GET_IDREG(isar, ID_AA64ISAR2);
     t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    cpu->isar.id_aa64isar2 = t;
+    SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = cpu->isar.id_aa64pfr0;
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
-- 
2.49.0



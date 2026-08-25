Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F23C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDH-0003wH-6k; Tue, 25 Aug 2026 18:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCv-0003N6-Jm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:26 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCt-0001T6-UW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so478315a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695282; x=1788300082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Yc9MuHh9PbC3Ytohig4KatF9izBef0JRQCyKKLS8VY=;
 b=cPxLDaV2XREnd3/SXkTsKzB1On/pewTnfIvotv1CeZ2B/kLkS5/VIKZxKXlhN1Z0aw
 oDc3/YHwFiuehB0JR4BMMtk+cAsausrPs7FhAskppg3WIZjX2oOFe834pOUPDctufVVI
 YHnztWz08F0X8gzQEmbCQ6p9IDvC7L1VoItnmV8F3vUhvA3mnzNwvnWYL9LaTO4IJRAY
 6E/KXxTt8p41XUrrrLDA7TExnfEp01owgTSmZ0AR2nqLu5ZWKwFiO+1rBdXMfX5lpMuy
 dEEZqOmI1B6Iwc/pQhF/tRacsBwxL/DzhpqlOkVGr/ppGZ7dVwqFkrpn5vaTAa7KNDbw
 lElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695282; x=1788300082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Yc9MuHh9PbC3Ytohig4KatF9izBef0JRQCyKKLS8VY=;
 b=XSmtMt7AG1yl2Lh5INjVITkrVqCbb+wdZi2Zv9lXg1S66SmLatkcmQwgpSTNbDfFmp
 RFcreZmbI20YN36eAgEy7H7+x92kGDhvr9WHaBS6zCxhsGDT1g/VC3DY1CcgZeLq41qF
 fu43wWSvDr+GRe18OtqKt4eFnvxfFhCEdk3aDcSdah3T8R0XsYYV61PAeDl3WNm/3ikL
 mXnH6rlaXYkfxRDkBTdWDzfPpdupj60WSS4Nn8hFlxijVXT7FbHEFngatQ42Hbgc/RTf
 w1qseU9V3ygLl2zCA70GdKDXW6o7w7TypYih5nq84panRJGrRICDKvIlRmXcIgVQdiTm
 WraA==
X-Gm-Message-State: AFuF++n7y0S5E9X3oyAlKsJfac0v9MOJnwa2Td4BhblWACR/v/QsmNaf
 D0eMVJogVTvxuB4neDZPdRls6CvyxedZrZQH2YKIjtA0PD6WNzuKDWUhqnGvzmO2KeQ=
X-Gm-Gg: AR+sD11VVFwJQPoj6BI+RGp+ynYr/NLBT5krRtC8WpSv3P2Q8gnbsBcifF4/MzCEmBy
 xpdXklLoLnlT1PsiW1NjKBXctRfhO/GvlqZA6o+UbMIhTp/ISMzL72pN9Sl0uSWEJsTx6EE3K8q
 lehiXBQ7OpgDbs4NsAF9uTmHskRLJ1vR5NgOnzVmU+ru9sJyg4CwmqEegiCxajb3r8OmOn2yaGJ
 fu6GpkhX+zC8uhu+3+61NQhhyNTGuVd7buqRsAh8qZdaqMo2oAkhdY4C+GTquor5l3tZvJ1Kc9A
 5sZNqdP9c3L2X6plk8UaCd8grsEAt0PmmjHeu7JHU/jA2jxR/O2GmpBZTinAM00gZ+Sr1WJOOo3
 QL5m0WadwmNTFlkPKxcS7dBx7BLIT+B7Rr5EKYABrpiEd7s8jSnIpIzGSiyYRbHC5HH0TbczrcY
 5QFiyV0KStejoCUYQsTua59xZ+ilrPFulOj4dvrqpF0FnV9cZvi7BuYSb5zvj4nW6AqZM+j4R/L
 TUgbdB+kOsZs90=
X-Received: by 2002:a17:90b:4d88:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-3966d36e327mr4349485a91.1.1787695281998; 
 Tue, 25 Aug 2026 15:01:21 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:21 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 08/24] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
Date: Tue, 25 Aug 2026 16:00:45 -0600
Message-ID: <20260825220101.3443954-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1acbd885bf4e..c02845486aa9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -331,7 +331,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -636,7 +636,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -667,11 +667,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
@@ -1910,7 +1910,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25610C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVm-0001KU-Ub; Tue, 07 Jul 2026 18:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVl-0001Jq-IT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:29 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVj-00048w-ST
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:29 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so47203a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464206; x=1784069006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Hja6qHGPQODpxQ8LqX3XJ4cmNcTjvVv4dMZ2DbbCzg=;
 b=EzxeLIpzj3uV3ofwOWi+JVWrGYk2yqT2IpRGZBWsYEUExy42YdjJPkMji5pHJyICVE
 2VOTuT2F4SLRkT3dOgZtePM7CZ4jh5MLC1EMhmszeb5fjWxRAGirMaNAvEEEkNp0/oJj
 hy5bBXXCdH+1ycXDp8Ol6y4KjsY7a+/UAgKTRpyqqRbC+2RZZ5hJo16zQprScMa47uo3
 v00PnBQXT3ZAUfNKwZpN95fMV9IwmL4czN4RMixukhVATCvXqthyj7CwpBt3aBfBifah
 BirLEFBsWRRLsZURUGirT1XBiWOlepxnO4o1CsE4IZfRJDRgyclwxmfTpbNwHSDIekvb
 UPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464206; x=1784069006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Hja6qHGPQODpxQ8LqX3XJ4cmNcTjvVv4dMZ2DbbCzg=;
 b=qbR39iSnjmH+useRG3G8ko4dwFngaBY7HlBGsck/fgqUQMfeY2SbOMfk9ey6dO+A+h
 tcznYFn+weFCSyIZrDzs+xG9l747cp+HA1D/Xe5YAtzOYGhmua5DjCtdN3pKP7qqoYCt
 LYzkAAOXYqmVf4SYn1wt2M3EvzXzXI9IQw2hl7nM7704objEUZ169QpMOQZU2aIUiah2
 1TpMEtLLq7sdtEdK/uMESYSIIa7hHipBOqHRIr/7cXb7T7BLpGroypG8z+elTfpjkURl
 0j/qNvxxYb1ZvR8UKXYy5cLFF/E+Dvfl87O7nLZbrxQSTLc0WpbSUMipo4dbVHPmZFeT
 hi4w==
X-Gm-Message-State: AOJu0YyoKMXJKVJEcugBZkRXRqLp2OMjiaG3UVff2m82ipoknaOFIQxd
 OfVQ1lx1BvQQbDEf/XdrjEUJUYTK+DIjSr8QlTwJVb+FE6PskLOcTJ73r/Gqws+044E=
X-Gm-Gg: AfdE7ckDU0vWJNXMxFrVbE6zzlhNhSNhdjiN2LTxUk2p2HO6uktwzxtP0ZgSGR10cko
 IW9LzAjJW1dsqiHOOmn/3fSQpbwhdH5BPq1fnbBrywSOje92FVEYsPLuYffZ1MvZtjKTNzOiz2v
 fYsCRkw1bVy6eO//H0cG8JI6T4hyq0iki6J8lneg7J5PNQGgpe7WYxFof1CnWYgosuwSQnmg5HF
 eYr3rOSkjuP3U1Vr+tSetNFkzTFMHOkGZHE49+jME61j5muu+hxDJMCErH5tdyxT+iBiVGMglnt
 f3vjJ2KVtrRbO3iydLb8FQ0f4C4la7Zw6Ji+/AYveZ0zmXoB3FTJvnfaqUEYq7YJppHr+5xVzMQ
 3fG7xNOQ+zf3aJMOAlaScKCoTyUKLyAjhhbw70Hp7cp/JsMdmlOSy+qXPzI9Kx4bmceIbjICYK0
 1EyK9lNSm8bibYJiX9gUFqMoGB1IqDolmmhOg+06250uRgDb53rg==
X-Received: by 2002:a17:90b:3808:b0:37f:9cdf:f037 with SMTP id
 98e67ed59e1d1-387572b3d9fmr6146459a91.26.1783464206246; 
 Tue, 07 Jul 2026 15:43:26 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:25 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 08/25] target/arm/kvm: Use kvm_vm_check_extension() where
 necessary
Date: Tue,  7 Jul 2026 16:42:49 -0600
Message-ID: <20260707224306.1202330-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1031.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6aa1cd04e484..c69b5310c184 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -328,7 +328,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -654,11 +654,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -1905,7 +1905,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0



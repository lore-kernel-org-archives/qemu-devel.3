Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF1CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEPf-0005hx-La; Thu, 01 Oct 2026 06:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xCEPJ-0005di-SW; Thu, 01 Oct 2026 06:52:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xCEPI-0002Pa-8v; Thu, 01 Oct 2026 06:52:57 -0400
Received: from localhost (unknown [131.107.1.165])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3006520B716D;
 Thu,  1 Oct 2026 03:52:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3006520B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790851921;
 bh=/GxhITBh1+jKbAWn25Pdnou1UmhxhK/tBbYd1+mXE2s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KN5U3oK5AYXpqcQiIdtekLnpDZ1BQTHr6uVccQxoS/rCH64TX+GrJnqYRNbkqCyR0
 yTo+Zm2xP4vEUF+TKr4GaebpLpuR6p27cB0dKGiFcSXRzhrCgQqRr5cqeKtUII5GR6
 zchHrV02Mt3fQKg+x36J10FcA7GIuAACnPXJBigA=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 01 Oct 2026 10:52:51 +0000
Subject: [PATCH v6 06/14] target/arm: convert host CPU feature ifdef ladder
 to runtime checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-mshv_accel_arm64_supp-v6-6-aefe5e76a0e3@linux.microsoft.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Replace the compile-time #if/#elif preprocessor ladder in
aarch64_host_initfn() with runtime calls and add mshv_enabled() to it.
This ensures the correct accelerator is selected at runtime when
multiple accelerators are compiled in.

Add CONFIG_MSHV to the aarch64_cpus[] guard so that mshv accelerator can
register the "host" CPU type.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 target/arm/cpu64.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dcd0d698b3..a9e346049d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -811,17 +811,21 @@ void aarch64_host_initfn(Object *obj)
     }
 #endif
 
+    if (mshv_enabled()) {
+        mshv_arm_set_cpu_features_from_host(cpu);
+    } else if (kvm_enabled()) {
 #if defined(CONFIG_KVM)
-    kvm_arm_set_cpreg_mig_tolerances(cpu);
-    kvm_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_sve_properties(obj);
-#elif defined(CONFIG_HVF)
-    hvf_arm_set_cpu_features_from_host(cpu);
-#elif defined(CONFIG_WHPX)
-    whpx_arm_set_cpu_features_from_host(cpu);
-#else
-    g_assert_not_reached();
+        kvm_arm_set_cpreg_mig_tolerances(cpu);
 #endif
+        kvm_arm_set_cpu_features_from_host(cpu);
+        aarch64_add_sve_properties(obj);
+    } else if (hvf_enabled()) {
+        hvf_arm_set_cpu_features_from_host(cpu);
+    } else if (whpx_enabled()) {
+        whpx_arm_set_cpu_features_from_host(cpu);
+    } else {
+        g_assert_not_reached();
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
     }
@@ -830,7 +834,8 @@ void aarch64_host_initfn(Object *obj)
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || \
+    defined(CONFIG_WHPX) || defined(CONFIG_MSHV)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };

-- 
2.45.4



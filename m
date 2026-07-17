Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFD9C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfnA-0005qC-Gd; Fri, 17 Jul 2026 06:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn8-0005oL-Es; Fri, 17 Jul 2026 06:27:38 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wkfn6-0000P7-R8; Fri, 17 Jul 2026 06:27:38 -0400
Received: from localhost (unknown [131.107.159.8])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9EB6220B716F;
 Fri, 17 Jul 2026 03:27:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EB6220B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784284044;
 bh=W5oTxHBqK2JiDAiHbkwJlqTOiYpl5s4zdpxfycSZFpU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PEYbGo/XFiwcT18RD0+IuwjC7JwznKIEfRLgprSMLlbr6sHVVtTY0lcWcuzoz05wQ
 8/AlDMhDx5ylN2IEDt/aUDHfZvX/hJaVgPHhY2gK12Fh9yiN7GAS7FLDwKxHxbygMK
 4Wdb71oPcad2Mw23sJfuJhDQHa9zJfLBc6z0f7Mo=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Fri, 17 Jul 2026 10:27:20 +0000
Subject: [PATCH v5 05/13] target/arm: convert host CPU feature ifdef ladder
 to runtime checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mshv_accel_arm64_supp-v5-5-ef07d4c6b337@linux.microsoft.com>
References: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
In-Reply-To: <20260717-mshv_accel_arm64_supp-v5-0-ef07d4c6b337@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
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
index 2816735577..9724c9475d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -802,17 +802,21 @@ void aarch64_host_initfn(Object *obj)
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
@@ -821,7 +825,8 @@ void aarch64_host_initfn(Object *obj)
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



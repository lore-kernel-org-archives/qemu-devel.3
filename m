Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14C2C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVza-00073R-C3; Tue, 01 Jul 2025 04:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzW-0006y6-8Q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:24 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzO-000778-An
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751357114; x=1782893114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cduq3IksxQAC1VaVQiBD1YTkVkSCxY9jre/WCsJuYD8=;
 b=hAxDiOYSj32q7CBOgNxTj8VmsAsENm6ASbQA4YIGi6kdg0MslflOl9va
 N8dFGphjjjDrbezQncu06VyCdneiFdvDZDqOlbrxKNuMLt1ejljShGz9S
 utDze6aF1yRfBwL2Luqhr0Eoxoj0xFGf36RLGE5gOaYg2ZugRuMLYZTcr
 UTBmpyIFFDfDcmhq9DfNjojekO7kv5EtaeVtkJMnSJmzUvNYvQuLYrPEa
 AsTACBa4bVXtJrqov/d2GbevbGK1GhsOa68QkA6Sibwxdrd+0m4wWleRr
 jwurQmQSzAXufRBQzu0e/tbV9MXfnmdJ1ozpK7bRWqScSiGVDOTJjETAI w==;
X-CSE-ConnectionGUID: uginMejkTuKXj6i5HFzg+A==
X-CSE-MsgGUID: R0k2pgxLRbWdcDz98OkYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64207667"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="64207667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 01:05:09 -0700
X-CSE-ConnectionGUID: 6zcu2EBoSsGltzjPAzgytw==
X-CSE-MsgGUID: bCCNEiCAT/inlNIGP6ywDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="157726517"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2025 01:05:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 1/2] i386/cpu: Rename host_cpu_instance_init() to
 apply_host_vendor()
Date: Tue,  1 Jul 2025 15:57:37 +0800
Message-ID: <20250701075738.3451873-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701075738.3451873-1-xiaoyao.li@intel.com>
References: <20250701075738.3451873-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The name of host_cpu_instance_init is really confusing. It misleads
people to think it as the .instance_init() callback of "host" x86 cpu
type.

Rename it to match what it does and move the xcc->model check to
callers since it's better to let host-cpu.c concentrate only on the host
related functionalities.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/host-cpu.c    | 12 ++++--------
 target/i386/host-cpu.h    |  2 +-
 target/i386/hvf/hvf-cpu.c |  5 ++++-
 target/i386/kvm/kvm-cpu.c |  4 ++--
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 383c42d4ae3d..c86b8227b974 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -127,16 +127,12 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
     }
 }
 
-void host_cpu_instance_init(X86CPU *cpu)
+void apply_host_vendor(X86CPU *cpu)
 {
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
+    char vendor[CPUID_VENDOR_SZ + 1];
 
-    if (xcc->model) {
-        char vendor[CPUID_VENDOR_SZ + 1];
-
-        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
-        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
-    }
+    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
 }
 
 void host_cpu_max_instance_init(X86CPU *cpu)
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index b97ec01c9bec..779f0f2f4123 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -11,7 +11,7 @@
 #define HOST_CPU_H
 
 uint32_t host_cpu_phys_bits(void);
-void host_cpu_instance_init(X86CPU *cpu);
+void apply_host_vendor(X86CPU *cpu);
 void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index dfdda701268e..16647482aba0 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -61,8 +61,11 @@ static void hvf_cpu_xsave_init(void)
 static void hvf_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
-    host_cpu_instance_init(cpu);
+    if (xcc->model) {
+        apply_host_vendor(cpu);
+    }
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6df92dc6d703..99e4357d5efe 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -202,9 +202,9 @@ static void kvm_cpu_instance_init(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
-    host_cpu_instance_init(cpu);
-
     if (xcc->model) {
+        apply_host_vendor(cpu);
+
         /* only applies to builtin_x86_defs cpus */
         if (!kvm_irqchip_in_kernel()) {
             x86_cpu_change_kvm_default("x2apic", "off");
-- 
2.43.0



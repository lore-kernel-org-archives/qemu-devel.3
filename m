Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03AD1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DEH-0001uu-NZ; Tue, 05 Nov 2024 01:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDT-0000MC-5S
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:39:03 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DDR-0001vj-9W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788741; x=1762324741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nkZUZZFxnGCMa4wnPLMg+4QnO1QTfXvDpRrYii+EGk0=;
 b=kjIASGDBiB3jX6OEp8se78ITLHZ+/0e2zkI/YYKtxoyvOhJE/qKFIsFs
 YTL2BU8VUMEyNDbF3YEg2IDyn+DCetbwr8m1I7IFn/L+DKtrZUpJ84Z7e
 kf446b6mC/bJDnsMU6b6J29TBChTmcfYpkWgyLBOgvhBj0wfvfbAFi8so
 EJC1j5m35r6/EWIFDViF7z8FeUV3jLoT371klREQg/90NTNVIGDramkZF
 YwgSSwH3TVWmTUrybILrdkINttMDbEZpv2PC0ejE8hk+xy2U/4JVv6pej
 /yycUmedsxQCm4D4j8uu9jubi+iRH3QPZnsJch166fLFLhjoVx4/6ohvL Q==;
X-CSE-ConnectionGUID: IKnvWhBVS/qAtC3vwurVLw==
X-CSE-MsgGUID: YSPcJQOlQumSJaBQXKYDng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689700"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689700"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:38:49 -0800
X-CSE-ConnectionGUID: tBqCUn3tQC6VO3jLGAIGQg==
X-CSE-MsgGUID: Ion8spsGRbqXdvTLwF6aBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83989310"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:38:44 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 34/60] i386/tdx: implement tdx_cpu_realizefn()
Date: Tue,  5 Nov 2024 01:23:42 -0500
Message-Id: <20241105062408.3533704-35-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

For TDX guest, KVM doesn't allow phys_bits configuration and the
phys_bits can only be native/host value.

Add the logic to set cpu->phys_bits to host value when user doesn't
give a explicit one and error out when user desires a different one
than host value.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - new patches;
---
 target/i386/host-cpu.c |  2 +-
 target/i386/host-cpu.h |  1 +
 target/i386/kvm/tdx.c  | 17 +++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 03b9d1b169a5..e2c59e5ae288 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -15,7 +15,7 @@
 #include "sysemu/sysemu.h"
 
 /* Note: Only safe for use on x86(-64) hosts */
-static uint32_t host_cpu_phys_bits(void)
+uint32_t host_cpu_phys_bits(void)
 {
     uint32_t eax;
     uint32_t host_phys_bits;
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 6a9bc918baa4..b97ec01c9bec 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -10,6 +10,7 @@
 #ifndef HOST_CPU_H
 #define HOST_CPU_H
 
+uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
 void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 61fb1f184149..289722a129ce 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -23,6 +23,8 @@
 
 #include <linux/kvm_para.h>
 
+#include "cpu.h"
+#include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf.h"
@@ -389,6 +391,20 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
 }
 
+static void tdx_cpu_realizefn(X86ConfidentialGuest *cg, CPUState *cs,
+                              Error **errp)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    uint32_t host_phys_bits = host_cpu_phys_bits();
+
+    if (!cpu->phys_bits) {
+        cpu->phys_bits = host_phys_bits;
+    } else if (cpu->phys_bits != host_phys_bits) {
+        error_setg(errp, "TDX only supports host physical bits (%u)",
+                   host_phys_bits);
+    }
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -733,4 +749,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
+    x86_klass->cpu_realizefn = tdx_cpu_realizefn;
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BEC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 08:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVza-00073V-N4; Tue, 01 Jul 2025 04:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzX-0006yc-9E
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:24 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uWVzQ-00077Q-5J
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 04:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751357116; x=1782893116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zgVef8PXCOEZLq4b5Nb/XEgfTFV+XNRW5z9Pm3zorKA=;
 b=Db1DgMNkoCE5hDoxUoPNc4BZiz4NCEoTUjl8hc5x1hgOciZsoWXLlIM1
 zmWNSh22YNyq5niDyrkXpOOJYAfsh02VzMc5RVHyboO1B+u/AZ+OHFg2q
 DtMCxoOJLgbYMdQal+J8dfkpdI9sv30vDxhWJu7od6ELD9JU5Vzr+SaNO
 GHJ+8/VD/AkrekMtavd1f1d33ijC9kkNS3tws0N3E9OyZA3toiA5TwmZl
 rN9Q7dnXzNFprgwyzFCUYlZst0TQKn6vZwgeWX1hTj1NXTZaqsDvQQ7Gx
 +hyRgsouK/2srY/pyLaaF+GiWMPhrNxcAnzmZlwad9crKumTPqyiJTlL1 Q==;
X-CSE-ConnectionGUID: mi7VZDepTImVPaiIyrQQCQ==
X-CSE-MsgGUID: gnTvrf28S8i1cVvXeNRwTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64207693"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="64207693"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 01:05:11 -0700
X-CSE-ConnectionGUID: RaOqEOfRS7iE4eioSnp+pQ==
X-CSE-MsgGUID: bVPFPDRFTo+jhhDEwnI62w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="157726524"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2025 01:05:09 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 2/2] i386/cpu: Move the implementation of is_host_cpu_intel()
 host-cpu.c
Date: Tue,  1 Jul 2025 15:57:38 +0800
Message-ID: <20250701075738.3451873-3-xiaoyao.li@intel.com>
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

It's more proper to put is_host_cpu_intel() in host-cpu.c instead of
vmsr_energy.c.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/host-cpu.c        | 9 +++++++++
 target/i386/host-cpu.h        | 1 +
 target/i386/kvm/vmsr_energy.c | 9 ---------
 target/i386/kvm/vmsr_energy.h | 1 -
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index c86b8227b974..6a88be8714c1 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -156,6 +156,15 @@ void host_cpu_max_instance_init(X86CPU *cpu)
                             &error_abort);
 }
 
+bool is_host_cpu_intel(void)
+{
+    char vendor[CPUID_VENDOR_SZ + 1];
+
+    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
+
+    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
+}
+
 static void host_cpu_class_init(ObjectClass *oc, const void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 779f0f2f4123..78086a0b0164 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -17,4 +17,5 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
 void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
+bool is_host_cpu_intel(void);
 #endif /* HOST_CPU_H */
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index d6aad5246b66..58ce3df53a3e 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -27,15 +27,6 @@ char *vmsr_compute_default_paths(void)
     return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
 }
 
-bool is_host_cpu_intel(void)
-{
-    char vendor[CPUID_VENDOR_SZ + 1];
-
-    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
-
-    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
-}
-
 int is_rapl_enabled(void)
 {
     const char *path = "/sys/class/powercap/intel-rapl/enabled";
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
index 16cc1f4814f6..151bcbd64239 100644
--- a/target/i386/kvm/vmsr_energy.h
+++ b/target/i386/kvm/vmsr_energy.h
@@ -94,6 +94,5 @@ double vmsr_get_ratio(uint64_t e_delta,
                       unsigned long long delta_ticks,
                       unsigned int maxticks);
 void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState *ms);
-bool is_host_cpu_intel(void);
 int is_rapl_enabled(void);
 #endif /* VMSR_ENERGY_H */
-- 
2.43.0



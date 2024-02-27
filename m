Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05D8C54E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuYz-0004m4-DP; Tue, 27 Feb 2024 05:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuYp-0004Rq-Jx
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:19:44 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuYm-00039H-LE
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709029180; x=1740565180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PJPFMih2ppMXNU8hF0bfjALdTNkZHH3RQgQUk5bZa78=;
 b=fSX9Y7ZY86voDCz7PwSGuP8T0K3f+ZRu9LktYpghTFsLfvBWqfjIbqQO
 e/SGxtdebui+n7w3KEM3dpF0pR/BKeFKTGuEuHJjbd94Z/VEuE5jTBhOa
 xrsBMIMRijs+V9jsxvHlDEjpRXGHQzZctUfCmZkmwfMt/4d/MUUfh89ay
 5Gi6V27jOT5KrJq6HxYLmOF2DPlPx3vV6e3uNZ8nYQU1y4cq0frogANPp
 ALwBZpKdl0+xi6BsxFu/Y321W9oskrB6rdWDtWg6AkErDyEG0LTnCZ+FU
 9IEOL/LnNjmDHkL/Wf55fiNblo5bi2hyfO3NMYQsUFfYlwR139y0K91bC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6310292"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6310292"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 02:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6954817"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2024 02:19:29 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
Subject: [PATCH v9 08/21] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Date: Tue, 27 Feb 2024 18:32:18 +0800
Message-Id: <20240227103231.1556302-9-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In cpu_x86_cpuid(), there are many variables in representing the cpu
topology, e.g., topo_info, cs->nr_cores and cs->nr_threads.

Since the names of cs->nr_cores/cs->nr_threads does not accurately
represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
to confusion and mistakes.

And the structure X86CPUTopoInfo names its members clearly, thus the
variable "topo_info" should be preferred.

In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
replace env->dies with topo_info.dies_per_pkg as well.

Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Changes since v8:
 * Add Philippe's reviewed-by tag.

Changes since v7:
 * Renamed cpus_per_pkg to threads_per_pkg. (Xiaoyao)
 * Dropped Michael/Babu's Acked/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.
 * Added Xiaoyao's Reviewed tag.

Changes since v3:
 * Fixed typo. (Babu)

Changes since v1:
 * Extracted cores_per_socket from the code block and use it as a local
   variable for cpu_x86_cpuid(). (Yanan)
 * Removed vcpus_per_socket variable and use cpus_per_pkg directly.
   (Yanan)
 * Replaced env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
---
 target/i386/cpu.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index df56c7a449c8..d115fc7002ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6017,11 +6017,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
+    uint32_t cores_per_pkg;
+    uint32_t threads_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
     topo_info.threads_per_core = cs->nr_threads;
 
+    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
+    threads_per_pkg = cores_per_pkg * topo_info.threads_per_core;
+
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
@@ -6057,8 +6062,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        if (threads_per_pkg > 1) {
+            *ebx |= threads_per_pkg << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
@@ -6098,15 +6103,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
-                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
-                if (cs->nr_cores > 1) {
+
+                if (cores_per_pkg > 1) {
                     addressable_cores_width = apicid_pkg_offset(&topo_info) -
                                               apicid_core_offset(&topo_info);
 
                     *eax &= ~0xFC000000;
                     *eax |= ((1 << addressable_cores_width) - 1) << 26;
                 }
-                if (host_vcpus_per_cache > vcpus_per_socket) {
+                if (host_vcpus_per_cache > threads_per_pkg) {
                     /* Share the cache at package level. */
                     addressable_threads_width = apicid_pkg_offset(&topo_info);
 
@@ -6252,12 +6257,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
-            *ebx = cs->nr_threads;
+            *ebx = topo_info.threads_per_core;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = threads_per_pkg;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         default:
@@ -6277,7 +6282,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (env->nr_dies < 2) {
+        if (topo_info.dies_per_pkg < 2) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -6287,7 +6292,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
-            *ebx = cs->nr_threads;
+            *ebx = topo_info.threads_per_core;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
@@ -6297,7 +6302,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = threads_per_pkg;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
         default:
@@ -6525,7 +6530,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
          * discards multiple thread information if it is set.
          * So don't set it here for Intel to make Linux guests happy.
          */
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (threads_per_pkg > 1) {
             if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
                 env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
                 env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
@@ -6591,7 +6596,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
+        if (threads_per_pkg > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
@@ -6599,7 +6604,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
             *ecx = (apicid_pkg_offset(&topo_info) << 12) |
-                   ((cs->nr_cores * cs->nr_threads) - 1);
+                   (threads_per_pkg - 1);
         } else {
             *ecx = 0;
         }
-- 
2.34.1



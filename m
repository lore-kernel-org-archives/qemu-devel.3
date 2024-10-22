Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C4FD2C550
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3F3f-0005iT-I7; Tue, 22 Oct 2024 09:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3b-0005bm-7Y; Tue, 22 Oct 2024 09:36:19 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3Y-0000Bw-Tr; Tue, 22 Oct 2024 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729604177; x=1761140177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rfk8ITGJI1L5Cei1tN2GoDq9qTCt0wMD3MSKGrYw9Os=;
 b=iYhI7JW+CV5d0t6fGSTSjdC4tZqaH/LFrVkGDqjLBdC94GWatFnn19z8
 vvq3SYoW9XdMnCLHNdq7t6FiJcDLY1apYoPUAc622+ycRQOzlq2bydqCK
 SgufDlgjipgClzHzuOq0ldUmMSFPnHSm2fKktqNSmNJG44t8UKbtgdOku
 q5XnQCBXqEmuim8ElrbdVnbi4DOlkuPnJD6+ItKG8LRnlgyXTCcswVr1D
 qbawPqPjvkOR7VPIxtNOM3VN3XzTWmrSe3UdGURtBlZn8DmISg8utRUaR
 7O2+r8qFS4/nwboovm3W6czlskvOlQdc1z4ieEUcTQnFIb+4pObKpT3iy A==;
X-CSE-ConnectionGUID: MsvkN1lbTEWRyhPTn6lv3Q==
X-CSE-MsgGUID: 9DszuNZsRsqM5fRxpgS1gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46603605"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46603605"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:36:10 -0700
X-CSE-ConnectionGUID: pTHKGFXAR5+ONseAbwlpxA==
X-CSE-MsgGUID: 3qo7ZV6NTTmPwm6Pv4ReyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79782232"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 06:36:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 1/9] i386/cpu: Don't enumerate the "invalid" CPU topology
 level
Date: Tue, 22 Oct 2024 21:51:43 +0800
Message-Id: <20241022135151.2052198-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022135151.2052198-1-zhao1.liu@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the follow-up change, the CPU topology enumeration will be moved to
QAPI. And considerring "invalid" should not be exposed to QAPI as an
unsettable item, so, as a preparation for future changes, remove
"invalid" level from the current CPU topology enumeration structure
and define it by a macro instead.

Due to the removal of the enumeration of "invalid", bit 0 of
CPUX86State.avail_cpu_topo bitmap will no longer correspond to "invalid"
level, but will start at the SMT level. Therefore, to honor this change,
update the encoding rule for CPUID[0x1F].

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Tested by the following cases to ensure 0x1f's behavior hasn't
changed:
  -smp cpus=24,sockets=2,dies=3,modules=2,cores=2,threads=1
  -smp cpus=24,sockets=2,dies=1,modules=3,cores=2,threads=2
  -smp cpus=24,sockets=2,modules=3,cores=2,threads=2
  -smp cpus=24,sockets=2,dies=3,modules=1,cores=2,threads=2
  -smp cpus=24,sockets=2,dies=3,cores=2,threads=2
---
Changes since Patch v3:
  * Now commit to stop exposing "invalid" enumeration in QAPI. (Daniel)
---
 include/hw/i386/topology.h |  3 ++-
 target/i386/cpu.c          | 13 ++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index dff49fce1154..48b43edc5a90 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -62,6 +62,8 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
+#define CPU_TOPO_LEVEL_INVALID CPU_TOPO_LEVEL_MAX
+
 /*
  * CPUTopoLevel is the general i386 topology hierarchical representation,
  * ordered by increasing hierarchical relationship.
@@ -69,7 +71,6 @@ typedef struct X86CPUTopoInfo {
  * or AMD (CPUID[0x80000026]).
  */
 enum CPUTopoLevel {
-    CPU_TOPO_LEVEL_INVALID,
     CPU_TOPO_LEVEL_SMT,
     CPU_TOPO_LEVEL_CORE,
     CPU_TOPO_LEVEL_MODULE,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032eaa..638de9c29c4c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -367,20 +367,21 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
                                 uint32_t *ecx, uint32_t *edx)
 {
     X86CPU *cpu = env_archcpu(env);
-    unsigned long level, next_level;
+    unsigned long level, base_level, next_level;
     uint32_t num_threads_next_level, offset_next_level;
 
-    assert(count + 1 < CPU_TOPO_LEVEL_MAX);
+    assert(count <= CPU_TOPO_LEVEL_PACKAGE);
 
     /*
      * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
-     * The search starts from bit 1 (CPU_TOPO_LEVEL_INVALID + 1).
+     * The search starts from bit 0 (CPU_TOPO_LEVEL_SMT).
      */
-    level = CPU_TOPO_LEVEL_INVALID;
+    level = CPU_TOPO_LEVEL_SMT;
+    base_level = level;
     for (int i = 0; i <= count; i++) {
         level = find_next_bit(env->avail_cpu_topo,
                               CPU_TOPO_LEVEL_PACKAGE,
-                              level + 1);
+                              base_level);
 
         /*
          * CPUID[0x1f] doesn't explicitly encode the package level,
@@ -391,6 +392,8 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
             level = CPU_TOPO_LEVEL_INVALID;
             break;
         }
+        /* Search the next level. */
+        base_level = level + 1;
     }
 
     if (level == CPU_TOPO_LEVEL_INVALID) {
-- 
2.34.1



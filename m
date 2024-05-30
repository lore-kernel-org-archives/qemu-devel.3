Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E15C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcaU-0002up-BD; Thu, 30 May 2024 06:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcaR-0002tG-I7; Thu, 30 May 2024 06:00:43 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCcaP-0003QW-LC; Thu, 30 May 2024 06:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717063242; x=1748599242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OUEY1PzrLtaJGQxKv2sq6ylcBSILR8gNfsV/1RqA31Y=;
 b=A5rybuJWzNRnTV4OFFOG2oEd3UeaPnk8Gr43tz8Rc+HhaZufI+v2/a9g
 eoGyoERBh39EbXTcDR/CylqZFErZW4ETg1IKlnRIVJfwfGNCklyRvzrSK
 sKMTPTsOZlRHrOzmw3YqbwHzepe9KyPGvfQTClas98pRwXzK2QPbx9q4m
 qa1OiOZZNbnp7xwG3JJ1kvSmPqjkJIJbevQDPfk0QMnyzD5pUZl4lGRZ9
 DPcwTM60XFH7e1p+sB+ryo97caAR5IGImiOffNIHZTQnmdJUk61kSaPRm
 uejr1SxusKBJ0FpFp+0kfEBqoFbQD+gmLlXj4egR+m0MgEtHA7lBBnG+c g==;
X-CSE-ConnectionGUID: 0nEufemsTwmF052ahnqMYg==
X-CSE-MsgGUID: UaNu9W5BTJWyBjbaU5QXzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="31032450"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="31032450"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 03:00:37 -0700
X-CSE-ConnectionGUID: TKXLj6QZRxOqLu9u46k3EQ==
X-CSE-MsgGUID: dl3u8jibTlSRrNV7RvOg9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="35705007"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 30 May 2024 03:00:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
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
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 2/7] hw/core: Define cache topology for machine
Date: Thu, 30 May 2024 18:15:34 +0800
Message-Id: <20240530101539.768484-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530101539.768484-1-zhao1.liu@intel.com>
References: <20240530101539.768484-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Define the cache topology based on CPU topology level for two reasons:

1. In practice, a cache will always be bound to the CPU container
   (either private in the CPU container or shared among multiple
   containers), and CPU container is often expressed in terms of CPU
   topology level.
2. The x86's cache-related CPUIDs encode cache topology based on APIC
   ID's CPU topology layout. And the ACPI PPTT table that ARM/RISCV
   relies on also requires CPU containers to help indicate the private
   shared hierarchy of the cache. Therefore, for SMP systems, it is
   natural to use the CPU topology hierarchy directly in QEMU to define
   the cache topology.

Currently, separated L1 cache (L1 data cache and L1 instruction cache)
with unified higher-level cache (e.g., unified L2 and L3 caches), is the
most common cache architectures.

Therefore, define the topology for L1 D-cache, L1 I-cache, L2 cache and
L3 cache in machine as the basic cache topology support.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c   |  5 +++++
 include/hw/boards.h | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8087026b45da..e31d0f3cb4b0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1175,6 +1175,11 @@ static void machine_initfn(Object *obj)
     ms->smp.cores = 1;
     ms->smp.threads = 1;
 
+    ms->smp_cache.l1d = CPU_TOPO_LEVEL_INVALID;
+    ms->smp_cache.l1i = CPU_TOPO_LEVEL_INVALID;
+    ms->smp_cache.l2 = CPU_TOPO_LEVEL_INVALID;
+    ms->smp_cache.l3 = CPU_TOPO_LEVEL_INVALID;
+
     machine_copy_boot_config(ms, &(BootConfiguration){ 0 });
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index c1737f2a5736..e70b2a1bdca2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -10,6 +10,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "hw/core/cpu-topology.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
@@ -145,6 +146,12 @@ typedef struct {
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
  * @modules_supported - whether modules are supported by the machine
+ * @l1_separated_cache_supported - whether l1 data and instruction cache
+ *                                 topology are supported by the machine
+ * @l2_unified_cache_supported - whether l2 unified cache topology are
+ *                               supported by the machine
+ * @l3_unified_cache_supported - whether l3 unified cache topology are
+ *                               supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -154,6 +161,9 @@ typedef struct {
     bool books_supported;
     bool drawers_supported;
     bool modules_supported;
+    bool l1_separated_cache_supported;
+    bool l2_unified_cache_supported;
+    bool l3_unified_cache_supported;
 } SMPCompatProps;
 
 /**
@@ -359,6 +369,20 @@ typedef struct CPUTopology {
     unsigned int max_cpus;
 } CPUTopology;
 
+/**
+ * CPUTopology:
+ * @l1d: the CPU topology hierarchy the L1 data cache is shared at.
+ * @l1i: the CPU topology hierarchy the L1 instruction cache is shared at.
+ * @l2: the CPU topology hierarchy the L2 (unified) cache is shared at.
+ * @l3: the CPU topology hierarchy the L3 (unified) cache is shared at.
+ */
+typedef struct CacheTopology {
+    CPUTopoLevel l1d;
+    CPUTopoLevel l1i;
+    CPUTopoLevel l2;
+    CPUTopoLevel l3;
+} CacheTopology;
+
 /**
  * MachineState:
  */
@@ -410,6 +434,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     CPUTopology smp;
+    CacheTopology smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
-- 
2.34.1



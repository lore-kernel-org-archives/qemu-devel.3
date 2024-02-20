Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A50C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMAY-0000jc-Pd; Tue, 20 Feb 2024 04:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAW-0000il-Mp; Tue, 20 Feb 2024 04:12:04 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAU-0003Nd-Sg; Tue, 20 Feb 2024 04:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708420323; x=1739956323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZUUAxB4sXVe45cGLGYGHp6RoRiuaOzKNjOeO96oXZvg=;
 b=k4xJPgy5morXTuYWqX+3yCo26JSMJ2CSPXRKvuR+TfbMwLcg/r8YV7jC
 mMrbArsoNrXfn1f/yuZWKF6kbLm1Nt+TLRbmf0l50BwwUm8gdfP95iZZg
 vyW54xLTxyemlyn/fYqdm1zTq3aAa0yF8XO4cpMBTFojMqRFkOZdQ0ymg
 953C8sh98VZ3W8WK2QM5rHQFZ4OfbSF2ju1VUzmxpWh0zDiHzswwcVk83
 ozpJjDAb2AjFR1N400Ch58Sj7nQdqLr5IVHJ/roJbCocyHORusaPCtppL
 XUfunMTUwS5oYNNriic4sBJhFM2tGf9DeAQoBKJTy5F3oq72IPLRIRBgy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2374984"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2374984"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 01:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5012944"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 01:11:55 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
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
Subject: [RFC 3/8] hw/core: Define cache topology for machine
Date: Tue, 20 Feb 2024 17:24:59 +0800
Message-Id: <20240220092504.726064-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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
index b3199c710194..426f71770a84 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1163,6 +1163,11 @@ static void machine_initfn(Object *obj)
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
index e63dec919da2..8558b88aea52 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -10,6 +10,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "hw/core/cpu-topology.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
@@ -144,6 +145,12 @@ typedef struct {
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
@@ -153,6 +160,9 @@ typedef struct {
     bool books_supported;
     bool drawers_supported;
     bool modules_supported;
+    bool l1_separated_cache_supported;
+    bool l2_unified_cache_supported;
+    bool l3_unified_cache_supported;
 } SMPCompatProps;
 
 /**
@@ -358,6 +368,20 @@ typedef struct CPUTopology {
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
@@ -408,6 +432,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     CPUTopology smp;
+    CacheTopology smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
-- 
2.34.1



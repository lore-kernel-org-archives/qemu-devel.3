Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69316D2C552
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3F3s-0005wq-Vi; Tue, 22 Oct 2024 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3q-0005tq-GX; Tue, 22 Oct 2024 09:36:34 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3g-0000DU-VI; Tue, 22 Oct 2024 09:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729604185; x=1761140185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UxShiMoLv5ztumoy5EWz7J8OcY/aVPzZnSshl0fwQyY=;
 b=ILJ4Vk62x8Ku+tB0GKBuWu+bafcXZsA4ViSA7JYJKAiDfkfetm22IDhI
 KhIBeCJc/G85fFX4CDCiTvVBjKKA5GQblur77QaViL/3ZC2Ic73ljW+RE
 m3JQAvhklF2HecgNVgIb8aweiutaUqq7f33jPl2AINys+8YVx+VWU2xaP
 8j1bpcsVmOFSxv9nIihMflu3n03t89fLXS6g2iSEZo4ZsVtL5ZfJ/VizL
 Dbunwqe2sXEZJQEMXfvqJWukWMxpeVvIt1rwf4ACrHUPvaYw93f5RGp4z
 9pTy4Iq8VHUjOlvuqLLY3UWIttGdy35Cl/Nytnrodd4nTBEHCCsyhES+k A==;
X-CSE-ConnectionGUID: OWjnstixR160BcV5kN8ppg==
X-CSE-MsgGUID: G2Xu7WqoQsq1umCaKMnDQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46603671"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46603671"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:36:22 -0700
X-CSE-ConnectionGUID: nugYYcSVQbC7Rdl5GFbc9g==
X-CSE-MsgGUID: LnksyR5YTVerAb/ci842ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79782308"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 06:36:17 -0700
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
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v4 3/9] qapi/qom: Define cache enumeration and properties for
 machine
Date: Tue, 22 Oct 2024 21:51:45 +0800
Message-Id: <20241022135151.2052198-4-zhao1.liu@intel.com>
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

The x86 and ARM need to allow user to configure cache properties
(current only topology):
 * For x86, the default cache topology model (of max/host CPU) does not
   always match the Host's real physical cache topology. Performance can
   increase when the configured virtual topology is closer to the
   physical topology than a default topology would be.
 * For ARM, QEMU can't get the cache topology information from the CPU
   registers, then user configuration is necessary. Additionally, the
   cache information is also needed for MPAM emulation (for TCG) to
   build the right PPTT.

Define smp-cache related enumeration and properties in QAPI, so that
user could configure cache properties for SMP system through -machine in
the subsequent patch.

Cache enumeration (CacheLevelAndType) is implemented as the combination
of cache level (level 1/2/3) and cache type (data/instruction/unified).

Currently, separated L1 cache (L1 data cache and L1 instruction cache)
with unified higher-level cache (e.g., unified L2 and L3 caches), is the
most common cache architectures.

Therefore, enumerate the L1 D-cache, L1 I-cache, L2 cache and L3 cache
with smp-cache object to add the basic cache topology support. Other
kinds of caches (e.g., L1 unified or L2/L3 separated caches) can be
added directly into CacheLevelAndType if necessary.

Cache properties (SmpCacheProperties) currently only contains cache
topology information, and other cache properties can be added in it
if necessary.

Note, define cache topology based on CPU topology level with two
reasons:

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

With smp-cache QAPI support, add smp cache topology for machine by
parsing the smp-cache object list.

Also add the helper to access/update cache topology level of machine.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Suggested by credit:
 * Referred to Daniel's suggestion to introduce cache object list.
---
Changes since Patch v3:
 * Dropped "invalid" level check since now we don't enumerate it in
   QAPI. (Daniel)
 * Added a helper to update MachineState.smp_cache (
   machine_set_cache_topo_level).
---
 hw/core/machine-smp.c    | 37 +++++++++++++++++++++++++++++
 hw/core/machine.c        | 44 +++++++++++++++++++++++++++++++++++
 include/hw/boards.h      | 12 ++++++++++
 qapi/machine-common.json | 50 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 5d8d7edcbd3f..c6d90cd6d413 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -261,6 +261,31 @@ void machine_parse_smp_config(MachineState *ms,
     }
 }
 
+bool machine_parse_smp_cache(MachineState *ms,
+                             const SmpCachePropertiesList *caches,
+                             Error **errp)
+{
+    const SmpCachePropertiesList *node;
+    DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
+
+    for (node = caches; node; node = node->next) {
+        /* Prohibit users from repeating settings. */
+        if (test_bit(node->value->cache, caches_bitmap)) {
+            error_setg(errp,
+                       "Invalid cache properties: %s. "
+                       "The cache properties are duplicated",
+                       CacheLevelAndType_str(node->value->cache));
+            return false;
+        }
+
+        machine_set_cache_topo_level(ms, node->value->cache,
+                                     node->value->topology);
+        set_bit(node->value->cache, caches_bitmap);
+    }
+
+    return true;
+}
+
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
 {
     return ms->smp.cores * ms->smp.modules * ms->smp.clusters * ms->smp.dies;
@@ -270,3 +295,15 @@ unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
 {
     return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
 }
+
+CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
+                                              CacheLevelAndType cache)
+{
+    return ms->smp_cache.props[cache].topology;
+}
+
+void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
+                                  CpuTopologyLevel level)
+{
+    ms->smp_cache.props[cache].topology = level;
+}
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17ebac1..518beb9f883a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -932,6 +932,40 @@ static void machine_set_smp(Object *obj, Visitor *v, const char *name,
     machine_parse_smp_config(ms, config, errp);
 }
 
+static void machine_get_smp_cache(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+    SmpCache *cache = &ms->smp_cache;
+    SmpCachePropertiesList *head = NULL;
+    SmpCachePropertiesList **tail = &head;
+
+    for (int i = 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
+        SmpCacheProperties *node = g_new(SmpCacheProperties, 1);
+
+        node->cache = cache->props[i].cache;
+        node->topology = cache->props[i].topology;
+        QAPI_LIST_APPEND(tail, node);
+    }
+
+    visit_type_SmpCachePropertiesList(v, name, &head, errp);
+    qapi_free_SmpCachePropertiesList(head);
+}
+
+static void machine_set_smp_cache(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+    SmpCachePropertiesList *caches;
+
+    if (!visit_type_SmpCachePropertiesList(v, name, &caches, errp)) {
+        return;
+    }
+
+    machine_parse_smp_cache(ms, caches, errp);
+    qapi_free_SmpCachePropertiesList(caches);
+}
+
 static void machine_get_boot(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -1057,6 +1091,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "smp",
         "CPU topology");
 
+    object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
+        machine_get_smp_cache, machine_set_smp_cache, NULL, NULL);
+    object_class_property_set_description(oc, "smp-cache",
+        "Cache properties list for SMP machine");
+
     object_class_property_add(oc, "phandle-start", "int",
         machine_get_phandle_start, machine_set_phandle_start,
         NULL, NULL);
@@ -1195,6 +1234,11 @@ static void machine_initfn(Object *obj)
     ms->smp.cores = 1;
     ms->smp.threads = 1;
 
+    for (int i = 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
+        ms->smp_cache.props[i].cache = (CacheLevelAndType)i;
+        ms->smp_cache.props[i].topology = CPU_TOPOLOGY_LEVEL_DEFAULT;
+    }
+
     machine_copy_boot_config(ms, &(BootConfiguration){ 0 });
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baab3..f7591d54a3d3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -44,8 +44,15 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
+bool machine_parse_smp_cache(MachineState *ms,
+                             const SmpCachePropertiesList *caches,
+                             Error **errp);
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
 unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
+CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
+                                              CacheLevelAndType cache);
+void machine_set_cache_topo_level(MachineState *ms, CacheLevelAndType cache,
+                                  CpuTopologyLevel level);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 /**
@@ -369,6 +376,10 @@ typedef struct CpuTopology {
     unsigned int max_cpus;
 } CpuTopology;
 
+typedef struct SmpCache {
+    SmpCacheProperties props[CACHE_LEVEL_AND_TYPE__MAX];
+} SmpCache;
+
 /**
  * MachineState:
  */
@@ -419,6 +430,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
+    SmpCache smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 1a5687fb99fc..298e51f373a3 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -60,3 +60,53 @@
 { 'enum': 'CpuTopologyLevel',
   'data': [ 'thread', 'core', 'module', 'cluster', 'die',
             'socket', 'book', 'drawer', 'default' ] }
+
+##
+# @CacheLevelAndType:
+#
+# Caches a system may have.  The enumeration value here is the
+# combination of cache level and cache type.
+#
+# @l1d: L1 data cache.
+#
+# @l1i: L1 instruction cache.
+#
+# @l2: L2 (unified) cache.
+#
+# @l3: L3 (unified) cache
+#
+# Since: 9.2
+##
+{ 'enum': 'CacheLevelAndType',
+  'data': [ 'l1d', 'l1i', 'l2', 'l3' ] }
+
+##
+# @SmpCacheProperties:
+#
+# Cache information for SMP system.
+#
+# @cache: Cache name, which is the combination of cache level
+#     and cache type.
+#
+# @topology: Cache topology level.  It accepts the CPU topology
+#     enumeration as the parameter, i.e., CPUs in the same
+#     topology container share the same cache.
+#
+# Since: 9.2
+##
+{ 'struct': 'SmpCacheProperties',
+  'data': {
+  'cache': 'CacheLevelAndType',
+  'topology': 'CpuTopologyLevel' } }
+
+##
+# @SmpCachePropertiesWrapper:
+#
+# List wrapper of SmpCacheProperties.
+#
+# @caches: the list of SmpCacheProperties.
+#
+# Since 9.2
+##
+{ 'struct': 'SmpCachePropertiesWrapper',
+  'data': { 'caches': ['SmpCacheProperties'] } }
-- 
2.34.1



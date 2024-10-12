Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15F5CF2565
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 10:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szZMj-0003qF-FU; Sat, 12 Oct 2024 06:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szZMh-0003pi-In; Sat, 12 Oct 2024 06:28:51 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szZMf-0007EI-Qq; Sat, 12 Oct 2024 06:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728728930; x=1760264930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J9p7Tdz/CDqM2wDqm/4H38Zb2VvdiGGpmWwRSF8KKYc=;
 b=TJCg3mzyIFTA4jWOwvoHeh/ToeW3OAJ6edCeWc94IDadbQRu3wH+DL1g
 XvNq/XSOubbNSUouTQGvEt14PznecV4YrV53t1Jp8YAiwj02AtxqWj1Vr
 0QycBvAC4j5hyCD+lqhcSlXLRIQ0vithM0dOiqr0FyRjD3GrXPhbYVkP6
 6Cy/eZGI+ZBi+zReKs7Wj3YtNhcKWu7VdSb8u9Ehqr9/cCsy1PEJDQlV5
 etljNtOsYKjxdu0CvU0StJF7XRUAzDScy7Bs2qqqn8g/WT0dkJWCrBp1s
 Bu/6Jo2wQcxTn6TgNf6W2kPdM4SEZXX/kQ9s7ATQyFuMQwqsCDFVCRAgp g==;
X-CSE-ConnectionGUID: UvxqGWOYSXKFUbFwkvWufQ==
X-CSE-MsgGUID: 9cSbaW7kRKagSVyr0rE//Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45634880"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="45634880"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 03:28:48 -0700
X-CSE-ConnectionGUID: 8jua+y5vSJuF4yaj4EUEng==
X-CSE-MsgGUID: 7F/JJOcZQjWrB5yLRjPEeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="77050845"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 12 Oct 2024 03:28:43 -0700
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
Subject: [PATCH v3 3/7] hw/core: Check smp cache topology support for machine
Date: Sat, 12 Oct 2024 18:44:25 +0800
Message-Id: <20241012104429.1048908-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012104429.1048908-1-zhao1.liu@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add cache_supported flags in SMPCompatProps to allow machines to
configure various caches support.

And check the compatibility of the cache properties with the
machine support in machine_parse_smp_cache().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v2:
 * Polished the comment of "default" level check. (Jonathan)
 * Reduced short line wrap. (Jonathan)

Changes since Patch v1:
 * Dropped machine_check_smp_cache_support() and did the check when
   -machine parses smp-cache in machine_parse_smp_cache().

Changes since RFC v2:
 * Split as a separate commit to just include compatibility checking and
   topology checking.
 * Allow setting "default" topology level even though the cache
   isn't supported by machine. (Daniel)
---
 hw/core/machine-smp.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  3 ++
 2 files changed, 78 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 1ce7be902e6e..f3edbded2e7b 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -261,10 +261,47 @@ void machine_parse_smp_config(MachineState *ms,
     }
 }
 
+static bool machine_check_topo_support(MachineState *ms,
+                                       CpuTopologyLevel topo,
+                                       Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if ((topo == CPU_TOPOLOGY_LEVEL_MODULE && !mc->smp_props.modules_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_CLUSTER && !mc->smp_props.clusters_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_DIE && !mc->smp_props.dies_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_BOOK && !mc->smp_props.books_supported) ||
+        (topo == CPU_TOPOLOGY_LEVEL_DRAWER && !mc->smp_props.drawers_supported)) {
+        error_setg(errp,
+                   "Invalid topology level: %s. "
+                   "The topology level is not supported by this machine",
+                   CpuTopologyLevel_str(topo));
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * When both cache1 and cache2 are configured with specific topology levels
+ * (not default level), is cache1's topology level higher than cache2?
+ */
+static bool smp_cache_topo_cmp(const SmpCache *smp_cache,
+                               CacheLevelAndType cache1,
+                               CacheLevelAndType cache2)
+{
+    if (smp_cache->props[cache1].topology != CPU_TOPOLOGY_LEVEL_DEFAULT &&
+        smp_cache->props[cache1].topology > smp_cache->props[cache2].topology) {
+        return true;
+    }
+    return false;
+}
+
 bool machine_parse_smp_cache(MachineState *ms,
                              const SmpCachePropertiesList *caches,
                              Error **errp)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     const SmpCachePropertiesList *node;
     DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
 
@@ -292,6 +329,44 @@ bool machine_parse_smp_cache(MachineState *ms,
         set_bit(node->value->cache, caches_bitmap);
     }
 
+    for (int i = 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
+        const SmpCacheProperties *props = &ms->smp_cache.props[i];
+
+        /*
+         * Reject non "default" topology level if the cache isn't
+         * supported by the machine.
+         */
+        if (props->topology != CPU_TOPOLOGY_LEVEL_DEFAULT &&
+            !mc->smp_props.cache_supported[props->cache]) {
+            error_setg(errp,
+                       "%s cache topology not supported by this machine",
+                       CacheLevelAndType_str(node->value->cache));
+            return false;
+        }
+
+        if (!machine_check_topo_support(ms, props->topology, errp)) {
+            return false;
+        }
+    }
+
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1D,
+                           CACHE_LEVEL_AND_TYPE_L2) ||
+        smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L1I,
+                           CACHE_LEVEL_AND_TYPE_L2)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L2 cache topology level shouldn't be lower than L1 cache");
+        return false;
+    }
+
+    if (smp_cache_topo_cmp(&ms->smp_cache, CACHE_LEVEL_AND_TYPE_L2,
+                           CACHE_LEVEL_AND_TYPE_L3)) {
+        error_setg(errp,
+                   "Invalid smp cache topology. "
+                   "L3 cache topology level shouldn't be lower than L2 cache");
+        return false;
+    }
+
     return true;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 0729066e353a..e4a1035e3fa1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -151,6 +151,8 @@ typedef struct {
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
  * @modules_supported - whether modules are supported by the machine
+ * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
+ *                    supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -160,6 +162,7 @@ typedef struct {
     bool books_supported;
     bool drawers_supported;
     bool modules_supported;
+    bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
 } SMPCompatProps;
 
 /**
-- 
2.34.1



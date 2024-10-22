Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE1D2C550
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3F3s-0005wt-W3; Tue, 22 Oct 2024 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3r-0005v5-B7; Tue, 22 Oct 2024 09:36:35 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3p-0000Dy-Iy; Tue, 22 Oct 2024 09:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729604193; x=1761140193;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v5TiGfpxtPYi3dX2SWWuKk9xXE8fMz5ejTsMCeSkh9w=;
 b=l0vxAzCZXLLxOWfFp7GMu0ocF2J1S2wpn6NZKOQVmVOztzC8jR8mosJE
 q/cMJUoQIITV5sJMrbk7eXmfMlP9wJ+3IU8pewBrg6IAq9vQa0v7FTdWh
 AU9/jDRDbVXjyAAooqcSGuBUlOutn5ZPsqGnciD4GqXFBRFNgIFxr1pZe
 SejVCr4efhl4ElDsOBpNyfMoM69anY6I6gTSI/h1oCRyRp6FKYWzvg+Tk
 AsDXa9+3IYYqSe/S3NyPVzMyHNIZCqSNxcXEiQKsp3hl/EmdABEg6qach
 TZI0hAPaZqR7q3iLkDI0UZzk3CeV95F/xLbCkiYXQWaLM32sgLoWNooBa g==;
X-CSE-ConnectionGUID: aLi2xKP2T4mI2msCy1M7GQ==
X-CSE-MsgGUID: 5DX9TALoTcuPLRtqGUL9UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46603682"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46603682"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:36:28 -0700
X-CSE-ConnectionGUID: bbz1toxaTLeTW4jo0tZrGw==
X-CSE-MsgGUID: kKpqBDGMQhmbIvVHDl74SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79782373"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 06:36:23 -0700
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
Subject: [PATCH v4 4/9] hw/core: Check smp cache topology support for machine
Date: Tue, 22 Oct 2024 21:51:46 +0800
Message-Id: <20241022135151.2052198-5-zhao1.liu@intel.com>
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

Add cache_supported flags in SMPCompatProps to allow machines to
configure various caches support.

And check the compatibility of the cache properties with the
machine support in machine_parse_smp_cache().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v3:
 * Dropped cache level check because if some fields is marked as
   default, then we can't guarentee the hierarchies are correct.
   (Daniel)
---
 hw/core/machine-smp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index c6d90cd6d413..ebb7a134a7be 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -261,10 +261,32 @@ void machine_parse_smp_config(MachineState *ms,
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
 bool machine_parse_smp_cache(MachineState *ms,
                              const SmpCachePropertiesList *caches,
                              Error **errp)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     const SmpCachePropertiesList *node;
     DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
 
@@ -283,6 +305,25 @@ bool machine_parse_smp_cache(MachineState *ms,
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
     return true;
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f7591d54a3d3..3d6cb5acd6c7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -153,6 +153,8 @@ typedef struct {
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
  * @modules_supported - whether modules are supported by the machine
+ * @cache_supported - whether cache (l1d, l1i, l2 and l3) configuration are
+ *                    supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -162,6 +164,7 @@ typedef struct {
     bool books_supported;
     bool drawers_supported;
     bool modules_supported;
+    bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
 } SMPCompatProps;
 
 /**
-- 
2.34.1



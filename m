Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A99C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCiQ-0004IY-MM; Wed, 03 Jul 2024 23:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCiN-0004G5-QB; Wed, 03 Jul 2024 23:00:55 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPCiM-0003xS-3g; Wed, 03 Jul 2024 23:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720062054; x=1751598054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O2y+4W7xDQI5Ehrauiwct9/OVeYocKJKMH4u39+XG9I=;
 b=BnSROBXNpjhR31sCzG7B7fnbTJcuedD2sHZLx9s5fupqr17eWLrQvx3z
 F+UOIaAuQ+EVQfYegWUoVMIETw1jTTHB8Q2x2JS01r9M0bIW1CpuZg2yM
 x3IHK+ZlZo8MXhQ7E1Pts9D3YcyyEYUQQlgUaK6+e5yWXpvYpkR5wKI+F
 0NUvMX+kIY9f6pZKiJuVNBHm56S6gh3iVS1joPvVIIQ1/8SgGIOCFDK0J
 8VqGxBTvTN2p7zCJPUn8bHox9j/XOSYH1C8xY6T8hhPNuPluULmKQdCdi
 LTKsIs4fBaR5kUc8x4B7RbSD3WM+mk9nZ+0pTIc0/GqkR6bLLdY3QQrTg w==;
X-CSE-ConnectionGUID: Q3u6i+pLTv2190uI0+3MEA==
X-CSE-MsgGUID: ql6Buj0JTwqNGae5/csNAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39838113"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="39838113"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 20:00:51 -0700
X-CSE-ConnectionGUID: /7A5MSBTTam4dTB6DCKBFg==
X-CSE-MsgGUID: azFKFs3BSMWR4qbPeaPRsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51052203"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jul 2024 20:00:43 -0700
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
Subject: [PATCH 3/8] hw/core: Add smp cache topology for machine
Date: Thu,  4 Jul 2024 11:15:58 +0800
Message-Id: <20240704031603.1744546-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704031603.1744546-1-zhao1.liu@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

With smp-cache object support, add smp cache topology for machine by
linking the smp-cache object.

Also add a helper to access cache topology level.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC v2:
 * Linked machine's smp_cache to smp-cache object instead of a builtin
   structure. This is to get around the fact that the keyval format of
   -machine can't support JSON.
 * Wrapped the cache topology level access into a helper.
---
 hw/core/machine-smp.c | 6 ++++++
 hw/core/machine.c     | 9 +++++++++
 include/hw/boards.h   | 5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 5d8d7edcbd3f..88a73743eb1c 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -270,3 +270,9 @@ unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
 {
     return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
 }
+
+CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
+                                              SMPCacheName cache)
+{
+    return ms->smp_cache->props[cache].topo;
+}
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21fc1..09ef9fcd4a0b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1045,6 +1045,15 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "smp",
         "CPU topology");
 
+    /* TODO: Implement check() method based on machine support. */
+    object_class_property_add_link(oc, "smp-cache",
+                                   TYPE_SMP_CACHE,
+                                   offsetof(MachineState, smp_cache),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "smp-cache",
+        "SMP cache property");
+
     object_class_property_add(oc, "phandle-start", "int",
         machine_get_phandle_start, machine_set_phandle_start,
         NULL, NULL);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef6f18f2c1a7..56fa252cfcd2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -6,10 +6,10 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/blockdev.h"
-#include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "hw/core/smp-cache.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
@@ -45,6 +45,8 @@ void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
 unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
+CpuTopologyLevel machine_get_cache_topo_level(const MachineState *ms,
+                                              SMPCacheName cache);
 void machine_memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
 
 /**
@@ -409,6 +411,7 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
+    SMPCache *smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
-- 
2.34.1



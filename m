Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA9CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9d-0000S4-P3; Thu, 19 Sep 2024 01:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9F-0006nx-ER; Thu, 19 Sep 2024 01:56:17 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA9B-0007OB-ER; Thu, 19 Sep 2024 01:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725370; x=1758261370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8gzS+6OwF3KgPtXFuFeQ8LrUaVl5pHIgZpajPFYb5x4=;
 b=h3Im7bv2EHfLdDhltP7L0t1tPH7Ra6ml1YT+vOUjuAwiBqRDN8uylbK+
 BUQoUzNoXDshpYxjaQEHkNy4uKjW/G3VHh06S+YjRmNyKhNebgKDGTON3
 nPjB4Ok23H4t4A5b8h4r0lYor8re+ZJNhgxcKKUDyikCwhcPJBHNCWCqZ
 1BljRLqzm+4osR318dyY34ZVzoVMkqTch9Dz9YzvmTQgIH2IHfO+DCcZp
 XqOx8Ke6tQdzWdXlytdiY5PK4XhSp+VJc3MZthl6G91nz5q2C/XLbyKQf
 LV1aOMZFb3J9GjEYcxEHigy8M2twYMCFGLXBTrbLVX/PffqrK5Pbs9sGX A==;
X-CSE-ConnectionGUID: iQi8/n3aQAmvtP76TWeTYw==
X-CSE-MsgGUID: 1efk/sxpQ0ucijSw7Ks4lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813607"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813607"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:56:07 -0700
X-CSE-ConnectionGUID: gUHshS+6Qa+f/5DU/ygquA==
X-CSE-MsgGUID: cvkL99LVRG6pb7HnWQ57VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418731"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:56:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 06/12] hw/cpu: Constrain CPU topology tree with max_limit
Date: Thu, 19 Sep 2024 14:11:22 +0800
Message-Id: <20240919061128.769139-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Apply max_limit to CPU topology and prevent the number of topology
devices from exceeding the max limitation configured by user.

Additionally, ensure that CPUs created from the CLI via custom topology
meet at least the requirements of smp.cpus. This guarantees that custom
topology will always have CPUs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c         |  4 ++++
 hw/cpu/cpu-slot.c         | 32 ++++++++++++++++++++++++++++++++
 include/hw/cpu/cpu-slot.h |  1 +
 include/hw/qdev-core.h    |  5 +++++
 4 files changed, 42 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index dedabd75c825..54fca9eb7265 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1684,6 +1684,10 @@ void machine_run_board_post_init(MachineState *machine, Error **errp)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
+    if (!machine_validate_topo_tree(machine, errp)) {
+        return;
+    }
+
     if (machine_class->post_init) {
         machine_class->post_init(machine);
     }
diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
index 2d16a2729501..f2b9c412926f 100644
--- a/hw/cpu/cpu-slot.c
+++ b/hw/cpu/cpu-slot.c
@@ -47,6 +47,7 @@ static void cpu_slot_device_realize(DeviceListener *listener,
 {
     CPUSlot *slot = container_of(listener, CPUSlot, listener);
     CPUTopoState *topo;
+    int max_children;
 
     if (!object_dynamic_cast(OBJECT(dev), TYPE_CPU_TOPO)) {
         return;
@@ -54,6 +55,13 @@ static void cpu_slot_device_realize(DeviceListener *listener,
 
     topo = CPU_TOPO(dev);
     cpu_slot_add_topo_info(slot, topo);
+
+    if (dev->parent_bus) {
+        max_children = slot->stat.entries[GET_CPU_TOPO_LEVEL(topo)].max_limit;
+        if (dev->parent_bus->num_children == max_children) {
+            qbus_mark_full(dev->parent_bus);
+        }
+    }
 }
 
 static void cpu_slot_del_topo_info(CPUSlot *slot, CPUTopoState *topo)
@@ -79,6 +87,10 @@ static void cpu_slot_device_unrealize(DeviceListener *listener,
 
     topo = CPU_TOPO(dev);
     cpu_slot_del_topo_info(slot, topo);
+
+    if (dev->parent_bus) {
+        qbus_mask_full(dev->parent_bus);
+    }
 }
 
 DeviceListener cpu_slot_device_listener = {
@@ -443,3 +455,23 @@ bool machine_parse_custom_topo_config(MachineState *ms,
 
     return true;
 }
+
+bool machine_validate_topo_tree(MachineState *ms, Error **errp)
+{
+    int cpus;
+
+    if (!ms->topo || !ms->topo->custom_topo_enabled) {
+        return true;
+    }
+
+    cpus = ms->topo->stat.entries[CPU_TOPOLOGY_LEVEL_THREAD].total_instances;
+    if (cpus < ms->smp.cpus) {
+        error_setg(errp, "machine requires at least %d online CPUs, "
+                   "but currently only %d CPUs",
+                   ms->smp.cpus, cpus);
+        return false;
+    }
+
+    /* TODO: Add checks for other levels to honor more -smp parameters. */
+    return true;
+}
diff --git a/include/hw/cpu/cpu-slot.h b/include/hw/cpu/cpu-slot.h
index 8d7e35aa1851..f56a0b08dca4 100644
--- a/include/hw/cpu/cpu-slot.h
+++ b/include/hw/cpu/cpu-slot.h
@@ -84,5 +84,6 @@ int get_max_topo_by_level(const MachineState *ms, CpuTopologyLevel level);
 bool machine_parse_custom_topo_config(MachineState *ms,
                                       const SMPConfiguration *config,
                                       Error **errp);
+bool machine_validate_topo_tree(MachineState *ms, Error **errp);
 
 #endif /* CPU_SLOT_H */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ddcaa329e3ec..3f2117e08774 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1063,6 +1063,11 @@ static inline void qbus_mark_full(BusState *bus)
     bus->full = true;
 }
 
+static inline void qbus_mask_full(BusState *bus)
+{
+    bus->full = false;
+}
+
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
-- 
2.34.1



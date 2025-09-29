Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67376CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34nD-0001Rs-Tf; Sun, 28 Sep 2025 23:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34nB-0001RW-Mo
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:13 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34n0-0007ec-1g
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759117382; x=1790653382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=67h9qXjiSwvEVuq3BHmAymmqQ+nXldCTegdpSnU/NhE=;
 b=KA1zKStLc7YvObq0Fn4OAdvCp5QNGrqXWR2mIbpK2W57my5ZPlEZY+MG
 hcH8rTNoksc0Ds84YKhnwb2co4aLjFwwfig+W0fVYbQzjnLT3JhBatWFO
 Q1/o5jaboi6v1795l0UGRwc2EREHaPgFAAA8OfT1zuPNQDFx1fsL19QEe
 6dvvNI15skQNP1TdTqsZoRJ+51nUYK0AP6NaxGcIfV1Jfc5Jrfq3Ex3Rj
 hbbOvZva2Vgm9OEChxymxh72Q8/XXVk5zenftbTzCPHmBM+d2KZKIkLH2
 z5QglupqoglSCJeZVX/lSpwjjPIZqLpTJHR4EgHndxoaPlYo9OYvFlteX w==;
X-CSE-ConnectionGUID: vCq3WRowTvKsf+tGk/XyHQ==
X-CSE-MsgGUID: SPXXfgyzTZ6VkzzCwhRcGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64989297"
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="64989297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:53 -0700
X-CSE-ConnectionGUID: 12amySd8Rj+HlKBGuFRQBQ==
X-CSE-MsgGUID: M9l4AD8BQ/uEIGNhY+fsUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="178865063"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/3] intel_iommu: Simplify caching mode check with VFIO
 device
Date: Sun, 28 Sep 2025 23:42:05 -0400
Message-ID: <20250929034206.439266-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250929034206.439266-1-zhenzhong.duan@intel.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In early days, we have different tricks to ensure caching-mode=on with VFIO
device:

28cf553afe ("intel_iommu: Sanity check vfio-pci config on machine init done")
c6cbc29d36 ("pc/q35: Disallow vfio-pci hotplug without VT-d caching mode")

There is also a patch of same purpose but for VDPA device:

b8d78277c0 ("intel-iommu: fail MAP notifier without caching mode")

Because without caching mode, MAP notifier won't work correctly since guest
won't send IOTLB update event when it establishes new mappings in the I/O page
tables.

Now with host IOMMU device interface between VFIO and vIOMMU, we can simplify
first two commits above with a small check in set_iommu_device(). This also
works for future IOMMUFD backed VDPA implementation which may also need caching
mode on. But for legacy VDPA we still need commit b8d78277c0 as it doesn't
use host IOMMU device interface.

For coldplug VFIO device:

  qemu-system-x86_64: -device vfio-pci,host=0000:3b:00.0,id=hostdev3,bus=root0,iommufd=iommufd0: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.

For hotplug VFIO device:

  if "iommu=off" is configured in guest,
    Error: vfio 0000:3b:00.0: Failed to set vIOMMU: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.
  else
    Error: vfio 0000:3b:00.0: memory listener initialization failed: Region vtd-00.0-dmar: device 01.00.0 requires caching mode: Operation not supported

The specialty for hotplug is due to the check in commit b8d78277c0 happen before
the check in set_iommu_device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 40 ++++++----------------------------------
 hw/i386/pc.c          | 20 --------------------
 2 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f04300022e..c634121514 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -85,13 +85,6 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
-static void vtd_panic_require_caching_mode(void)
-{
-    error_report("We need to set caching-mode=on for intel-iommu to enable "
-                 "device assignment with IOMMU protection.");
-    exit(1);
-}
-
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -4378,6 +4371,12 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 
     assert(hiod);
 
+    if (!s->caching_mode) {
+        error_setg(errp, "Device assignment is not allowed without enabling "
+                   "caching-mode=on for Intel IOMMU.");
+        return false;
+    }
+
     vtd_iommu_lock(s);
 
     if (g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
@@ -4910,32 +4909,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     return true;
 }
 
-static int vtd_machine_done_notify_one(Object *child, void *unused)
-{
-    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
-
-    /*
-     * We hard-coded here because vfio-pci is the only special case
-     * here.  Let's be more elegant in the future when we can, but so
-     * far there seems to be no better way.
-     */
-    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
-        vtd_panic_require_caching_mode();
-    }
-
-    return 0;
-}
-
-static void vtd_machine_done_hook(Notifier *notifier, void *unused)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   vtd_machine_done_notify_one, NULL);
-}
-
-static Notifier vtd_machine_done_notify = {
-    .notify = vtd_machine_done_hook,
-};
-
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -4990,7 +4963,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
-    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
 static void vtd_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bc048a6d13..01cd9a67db 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1720,25 +1720,6 @@ static void pc_machine_wakeup(MachineState *machine)
     cpu_synchronize_all_post_reset();
 }
 
-static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
-{
-    X86IOMMUState *iommu = x86_iommu_get_default();
-    IntelIOMMUState *intel_iommu;
-
-    if (iommu &&
-        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
-        object_dynamic_cast((Object *)dev, "vfio-pci")) {
-        intel_iommu = INTEL_IOMMU_DEVICE(iommu);
-        if (!intel_iommu->caching_mode) {
-            error_setg(errp, "Device assignment is not allowed without "
-                       "enabling caching-mode=on for Intel IOMMU.");
-            return false;
-        }
-    }
-
-    return true;
-}
-
 static void pc_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1758,7 +1739,6 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-    mc->hotplug_allowed = pc_hotplug_allowed;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CDCC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfcRN-0006Ij-Ar; Fri, 03 Jul 2026 07:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyanarayana.k.v.p@intel.com>)
 id 1wfbqo-0006h8-JI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:14:30 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyanarayana.k.v.p@intel.com>)
 id 1wfbqm-0002t6-Qa
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 07:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783077268; x=1814613268;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5oq3h0wAuSdjvI+aiUhD//734EhYHcUFlqvOLdEstWI=;
 b=mLL4RMRsu2p26eivKYPAzw+nlJAsIf1kph1AdNnyfW2sMhFEwjzCssYP
 lG8DIAkE2RJ1UwRvdygl8+/WOQrqYFufe1gMRRojby+IFOkrfOQMFp12t
 mZ92aovrcFMpPt32pcGUtJW3LaC5WHGglYNwfaniOIgSnJRZ6U98IO7Bp
 9gtG4gyViNltV8ISCIgho1bP6mq/fCsJUk5mfKoIUQMs3041QwWi9WLNd
 48fY9PYFGJ7BQSeOZvp5yVEaPzatnnUwYwgDwUHlW3gfwLz9FlkWzmISX
 yMuWdTp8h4qYvh+uf9erqdvGayoB+raBW3ys1YsQSUQITG02+JGpJa7nu Q==;
X-CSE-ConnectionGUID: uLCNKLl/T+CC7qh19BVCvg==
X-CSE-MsgGUID: ziEGeCxVQK+39lsztFRy1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101251120"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101251120"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:14:28 -0700
X-CSE-ConnectionGUID: UDTM+zDBS/GIE9Rjmsxywg==
X-CSE-MsgGUID: KgzJml9RRSOiTv0FohR6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="283181207"
Received: from gsd-build.iind.intel.com ([10.190.229.141])
 by orviesa002.jf.intel.com with ESMTP; 03 Jul 2026 04:14:25 -0700
From: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
To: qemu-devel@nongnu.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC 1/1] vfio/pci: Forward AER errors to guest optionally
Date: Fri,  3 Jul 2026 11:13:59 +0000
Message-ID: <20260703111357.3206071-4-satyanarayana.k.v.p@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
References: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=satyanarayana.k.v.p@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:52:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently QEMU unconditionally stops VM upon receiving any unrecoverable
error from the device. This prevents recovery of the device within the
guest.

Upon receiving the AER error from device, an error is injected to guest if
the device supports AER. If the device does not support AER, check whether
the upstream PCIe bridge supports it and forward the error to the bridge.

The error forward is gated with an optional extension parameter and can be
enabled with

-device vfio-pci,host=<BDF>,...,x-forward-aer=on

Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.h |  1 +
 2 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..1913d18ff5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2628,6 +2628,14 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
             }
             break;
+        case PCI_EXT_CAP_ID_ERR:
+            if (pcie_aer_init(pdev, cap_ver, next, size, &err) < 0) {
+                warn_report_err(err);
+                err = NULL;
+                /* Mark capability as absent on failure to initialize */
+                pdev->exp.aer_cap = 0;
+            }
+            break;
         /*
          * VFIO kernel does not expose the PASID CAP today. We may synthesize
          * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
@@ -3124,26 +3132,68 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
     g_free(vdev->msix);
 }
 
-static void vfio_err_notifier_handler(void *opaque)
+static void vfio_err_notify_guest(VFIOPCIDevice *vdev)
 {
-    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    PCIDevice *pbridge_dev;
+    PCIEAERErr aer_err = {
+        .status = PCI_ERR_UNC_MALF_TLP,
+        .flags = 0,
+    };
+    int ret;
 
-    if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
-        return;
+    if (!vdev->forward_aer) {
+        error_report("%s(%s)"
+                     "Unrecoverable error detected and could not notify guest. "
+                     "Please collect any data possible and then kill the guest",
+                     __func__, vdev->vbasedev.name);
+        goto vm_stop_out;
     }
 
     /*
-     * TBD. Retrieve the error details and decide what action
-     * needs to be taken. One of the actions could be to pass
-     * the error to the guest and have the guest driver recover
-     * from the error. This requires that PCIe capabilities be
-     * exposed to the guest. For now, we just terminate the
-     * guest to contain the error.
+     * If the device does not have AER capability and still configured to
+     * forward error to guest, try to find a PCIe bridge with AER capability and
+     * forward the error to it. If neither the device nor the PCIe bridge supports
+     * AER, the VM is immediately stopped when the error is reported.
      */
+    if (!pdev->exp.aer_cap) {
+        pbridge_dev = pci_bridge_get_device(pci_get_bus(pdev));
+        if (pbridge_dev && pbridge_dev->exp.aer_cap) {
+            warn_report("Forwarding error to PCIe bridge due to lack of AER capability on device");
+            pdev = pbridge_dev;
+        } else {
+            error_report("%s(%s) No AER capable device is found, stopping VM",
+                         __func__, vdev->vbasedev.name);
+            goto vm_stop_out;
+        }
+    }
+
+    aer_err.source_id = pci_requester_id(pdev);
+
+    ret = pcie_aer_inject_error(pdev, &aer_err);
+    if (ret < 0) {
+        error_report("%s(%s): AER injection failed (%d)", __func__, vdev->vbasedev.name, ret);
+        goto vm_stop_out;
+    }
 
-    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
+    return;
 
+vm_stop_out:
     vm_stop(RUN_STATE_INTERNAL_ERROR);
+    return;
+}
+
+static void vfio_err_notifier_handler(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+
+    if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
+        return;
+    }
+
+    error_report("%s(%s) Unrecoverable error detected for the device",
+                 __func__, vdev->vbasedev.name);
+    vfio_err_notify_guest(vdev);
 }
 
 /*
@@ -3624,6 +3674,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (pdev->exp.aer_cap) {
+        pcie_aer_exit(pdev);
+    }
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(pdev, NULL);
@@ -3815,6 +3868,7 @@ static const Property vfio_pci_properties[] = {
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
+    DEFINE_PROP_BOOL("x-forward-aer", VFIOPCIDevice, forward_aer, false),
 };
 
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
@@ -3973,6 +4027,10 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "a vIOMMU. A value of 0 (default) places the capability at the "
                                           "end of the extended configuration space. The offset must be "
                                           "4-byte aligned and within the PCIe extended configuration space");
+    object_class_property_set_description(klass,
+                                          "x-forward-aer",
+                                          "Forward Advanced Error Reporting (AER) events to the guest "
+                                          "with generic error status");
 }
 
 static const TypeInfo vfio_pci_info = {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..b1d19c4c9e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool forward_aer;
     uint16_t vpasid_cap_offset;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFBBC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul8UW-0001R3-5x; Sun, 10 Aug 2025 12:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UK-0001Kq-W7
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UI-0008KO-In
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754841692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y56OvP8QXsdCrvduvRA0S/V8V388ocqCaHPAyJifZeA=;
 b=QEm8vKMdbmSrGdWq8S62Qp8ksOGggLS8NcIybTG51Th/ABiU909R4u8acIcP3RdbVWas0o
 KtiSavdmpPoZfMfA99eAX376OFu1OVXeWFuXY4kRT6FaEsOM4Y+Uw2a1yXuLLIcib9t863
 EjAnYj+/6WMvCxMB1U7VDJZS65VJalE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302--BfO44H6P32khF25K4iY0Q-1; Sun,
 10 Aug 2025 12:01:29 -0400
X-MC-Unique: -BfO44H6P32khF25K4iY0Q-1
X-Mimecast-MFC-AGG-ID: -BfO44H6P32khF25K4iY0Q_1754841688
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EA141956089; Sun, 10 Aug 2025 16:01:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7869A3001455; Sun, 10 Aug 2025 16:01:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/3] vfio/pci: preserve pending interrupts
Date: Sun, 10 Aug 2025 18:01:17 +0200
Message-ID: <20250810160118.450430-3-clg@redhat.com>
In-Reply-To: <20250810160118.450430-1-clg@redhat.com>
References: <20250810160118.450430-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

cpr-transfer may lose a VFIO interrupt because the KVM instance is
destroyed and recreated.  If an interrupt arrives in the middle, it is
dropped.  To fix, stop pending new interrupts during cpr save, and pick
up the pieces.  In more detail:

Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD to
deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
After this call, interrupts fall back to the kernel vfio_msihandler, which
writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
eventfd.  When the route is re-established in new QEMU, the kernel tests
the eventfd and injects an interrupt to KVM if necessary.

Deassign INTx in a similar manner.  For both MSI and INTx, remove the
eventfd handler so old QEMU does not consume an event.

If an interrupt was already pended to KVM prior to the completion of
kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
state to userland prior to saving it in vmstate.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1752689169-233452-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h              |  1 +
 include/hw/vfio/vfio-cpr.h |  6 +++
 hw/vfio/cpr.c              | 91 ++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c              |  2 +
 4 files changed, 100 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2b564baf88640a4fe2e78b5ec4c4eb3ba3141357..810a842f4a153d4bcc924a6984c6dae58e1e69dd 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -188,6 +188,7 @@ struct VFIOPCIDevice {
     bool skip_vsc_check;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
+    VFIOPCICPR cpr;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 80ad20d2169086052b66d0df526406b8de7985d4..d37daffbc5b3d2bb65b60967c227df54d24437f7 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
     uint32_t ioas_id;
 } VFIODeviceCPR;
 
+typedef struct VFIOPCICPR {
+    NotifierWithReturn transfer_notifier;
+} VFIOPCICPR;
+
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
 void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
@@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
 extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 void vfio_cpr_add_kvm_notifier(void);
+void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
+void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
 
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index ade7ff745dc26e13712dbdafda38e1875a016505..a831243e0207112a9357d7d718bd915a26411e06 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -200,3 +200,94 @@ void vfio_cpr_add_kvm_notifier(void)
                                     MIG_MODE_CPR_TRANSFER);
     }
 }
+
+static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
+                                  EventNotifier *rn, int virq, bool enable)
+{
+    if (enable) {
+        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
+    } else {
+        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
+    }
+}
+
+static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool enable)
+{
+    const char *op = (enable ? "enable" : "disable");
+    PCIDevice *pdev = &vdev->pdev;
+    int i, nr_vectors, ret = 0;
+
+    if (msix_enabled(pdev)) {
+        nr_vectors = vdev->msix->entries;
+
+    } else if (msi_enabled(pdev)) {
+        nr_vectors = msi_nr_vectors_allocated(pdev);
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        ret = set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
+                                     &vdev->intx.unmask, vdev->intx.route.irq,
+                                     enable);
+        if (ret) {
+            error_setg_errno(errp, -ret, "failed to %s INTx irq %d",
+                             op, vdev->intx.route.irq);
+            return ret;
+        }
+        vfio_pci_intx_set_handler(vdev, enable);
+        return ret;
+
+    } else {
+        return 0;
+    }
+
+    for (i = 0; i < nr_vectors; i++) {
+        VFIOMSIVector *vector = &vdev->msi_vectors[i];
+        if (vector->use) {
+            ret = set_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
+                                         NULL, vector->virq, enable);
+            if (ret) {
+                error_setg_errno(errp, -ret,
+                                 "failed to %s msi vector %d virq %d",
+                                 op, i, vector->virq);
+                return ret;
+            }
+            vfio_pci_msi_set_handler(vdev, i, enable);
+        }
+    }
+
+    return ret;
+}
+
+/*
+ * When CPR starts, detach IRQs from the VFIO device so future interrupts
+ * are posted to kvm_interrupt, which is preserved in new QEMU.  Interrupts
+ * that were already posted to the old KVM instance, but not delivered to the
+ * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM instance
+ * in new QEMU.
+ *
+ * If CPR fails, reattach the IRQs.
+ */
+static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
+                                 MigrationEvent *e, Error **errp)
+{
+    VFIOPCIDevice *vdev =
+        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
+
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+        return vfio_cpr_set_msi_virq(vdev, errp, false);
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        return vfio_cpr_set_msi_virq(vdev, errp, true);
+    }
+    return 0;
+}
+
+void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
+{
+    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
+                                vfio_cpr_pci_notifier,
+                                MIG_MODE_CPR_TRANSFER);
+}
+
+void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
+{
+    migration_remove_notifier(&vdev->cpr.transfer_notifier);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4cd6894ca81731258ad10a5f9f894289e671a3db..d5ea4a5a8341c10abbcd1d3892b6add01efbd880 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3001,6 +3001,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+    vfio_cpr_pci_unregister_device(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
     /*
@@ -3480,6 +3481,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     vfio_pci_register_err_notifier(vdev);
     vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
+    vfio_cpr_pci_register_device(vdev);
 
     return;
 
-- 
2.50.1



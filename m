Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A7C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3e-0007mP-MD; Fri, 04 Jul 2025 04:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3X-0007hN-3o
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3V-0000GG-83
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTQINngnlTpKUr4ol5peoe6ICu1vlPCG0vUoKUmVS0g=;
 b=EFvBquZBRCs7Hyq3o4d0unoe4KTnjKxdB8B3gUWI8b/HFp0IcAHg+4d4FfJv0QbQZGcCRK
 VrJt7tJbgmcSnHcBSZSgeYw49hGcZh1jlx1ri/c0zxpqyJ3kognGf2vNPRB7sJ4n3G0rS+
 rYxvL7yq58RtVX3vptwQhvuduIREIlw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-n6rQRszkPsy0OWhNLYBjGQ-1; Fri,
 04 Jul 2025 04:45:58 -0400
X-MC-Unique: n6rQRszkPsy0OWhNLYBjGQ-1
X-Mimecast-MFC-AGG-ID: n6rQRszkPsy0OWhNLYBjGQ_1751618757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D5F31955ECF; Fri,  4 Jul 2025 08:45:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D807419560A7; Fri,  4 Jul 2025 08:45:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/27] migration: close kvm after cpr
Date: Fri,  4 Jul 2025 10:45:10 +0200
Message-ID: <20250704084528.1412959-10-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

cpr-transfer breaks vfio network connectivity to and from the guest, and
the host system log shows:
  irq bypass consumer (token 00000000a03c32e5) registration fails: -16
which is EBUSY.  This occurs because KVM descriptors are still open in
the old QEMU process.  Close them.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h    |  2 ++
 include/hw/vfio/vfio-device.h |  2 ++
 include/system/kvm.h          |  1 +
 accel/kvm/kvm-all.c           | 32 ++++++++++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c          |  2 ++
 hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
 hw/vfio/helpers.c             | 11 +++++++++++
 7 files changed, 71 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index f21578da3cb3611e04260f458e77aca6f48036fe..d37acc4a0a0ae1f6f38d8322fb9681227221fd09 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -63,4 +63,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
 
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 
+void vfio_cpr_add_kvm_notifier(void);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index c616652ee72265c637cb5136fdffb4444639e0b7..f503837ccc6936b730a7752ca092da5acba1806f 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
+
+void vfio_kvm_device_close(void);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d26f24a48fc107d80683710939679e8e98b..4896a3c9c59e90bb0bea35407fa969884f6920ec 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
+void kvm_close(void);
 
 /**
  * kvm_arm_supports_user_irq
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8685f865cf7b49c6f02b80f6cb011b..81418546177c8eb99932900902cd3890f45c02bb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
 
+    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
+    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+        s->coalesced_mmio_ring = NULL;
+    }
+
     ret = munmap(cpu->kvm_run, mmap_size);
     if (ret < 0) {
         goto err;
     }
+    cpu->kvm_run = NULL;
 
     if (cpu->kvm_dirty_gfns) {
         ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
         if (ret < 0) {
             goto err;
         }
+        cpu->kvm_dirty_gfns = NULL;
     }
 
     kvm_park_vcpu(cpu);
@@ -608,6 +615,31 @@ err:
     return ret;
 }
 
+void kvm_close(void)
+{
+    CPUState *cpu;
+
+    if (!kvm_state || kvm_state->fd == -1) {
+        return;
+    }
+
+    CPU_FOREACH(cpu) {
+        cpu_remove_sync(cpu);
+        close(cpu->kvm_fd);
+        cpu->kvm_fd = -1;
+        close(cpu->kvm_vcpu_stats_fd);
+        cpu->kvm_vcpu_stats_fd = -1;
+    }
+
+    if (kvm_state && kvm_state->fd != -1) {
+        close(kvm_state->vmfd);
+        kvm_state->vmfd = -1;
+        close(kvm_state->fd);
+        kvm_state->fd = -1;
+    }
+    kvm_state = NULL;
+}
+
 /*
  * dirty pages logging control
  */
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 1216717546ca13d6f33e802777aa69ab4d59ecba..553b203e9b60b3a08159e2224a887b4d76162428 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -179,6 +179,8 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
                                          MIG_MODE_CPR_TRANSFER, -1) == 0;
     }
 
+    vfio_cpr_add_kvm_notifier();
+
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
     migration_add_notifier_mode(&container->cpr.transfer_notifier,
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index f5555cabe72a817c000a1359bc7fd318c6aff4c1..0e903cdd2f7071a363eecd4ec8784b6f9c8f7e1d 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -190,3 +190,24 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static NotifierWithReturn kvm_close_notifier;
+
+static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
+                                       MigrationEvent *e,
+                                       Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        vfio_kvm_device_close();
+    }
+    return 0;
+}
+
+void vfio_cpr_add_kvm_notifier(void)
+{
+    if (!kvm_close_notifier.notify) {
+        migration_add_notifier_mode(&kvm_close_notifier,
+                                    vfio_cpr_kvm_close_notifier,
+                                    MIG_MODE_CPR_TRANSFER);
+    }
+}
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index d0dbab1d17132743ea5f5ed0f25701436be11945..9a5f62154554e1df36545b8c315b9ae25534d0fb 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -117,6 +117,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 int vfio_kvm_device_fd = -1;
 #endif
 
+void vfio_kvm_device_close(void)
+{
+#ifdef CONFIG_KVM
+    kvm_close();
+    if (vfio_kvm_device_fd != -1) {
+        close(vfio_kvm_device_fd);
+        vfio_kvm_device_fd = -1;
+    }
+#endif
+}
+
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
-- 
2.50.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8F0C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMlV-0000Du-Q7; Tue, 06 Aug 2024 12:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbMl0-0007tF-CV
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbMkx-0002sY-NE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722960591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnbO6kuJu3hizLoW0f2WIUYUWVbA1Rmh6M86L5U6hDc=;
 b=gjwBIERYcJPF0/aUB5zwNPZfYRbWXaIB1UbWZAY9wNN4zJYON3efrldBUatzczhY23/CMS
 ISQm4MX5yAQCbQq7wtQp8QmrhS+DBsE8vpTbrJDqoJzejvC63T9op6o+gHPW13Dy7C91vo
 1sWePOS0J43WH/pjySZzgtttaElGKxY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-eLKX5hhbMDuY8W2NOaHjRA-1; Tue,
 06 Aug 2024 12:08:06 -0400
X-MC-Unique: eLKX5hhbMDuY8W2NOaHjRA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897091955D54; Tue,  6 Aug 2024 16:08:05 +0000 (UTC)
Received: from rh-jmarcin.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3877C1955D42; Tue,  6 Aug 2024 16:08:03 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/4] virtio-mem: Implement Resettable interface instead of
 using LegacyReset
Date: Tue,  6 Aug 2024 18:07:53 +0200
Message-ID: <20240806160756.182524-4-jmarcin@redhat.com>
In-Reply-To: <20240806160756.182524-1-jmarcin@redhat.com>
References: <20240806160756.182524-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LegacyReset does not pass ResetType to the reset callback method, which
the new Resettable interface uses. Due to this, virtio-mem cannot use
the new RESET_TYPE_WAKEUP to skip reset during wake-up from a suspended
state.

This patch adds the Resettable interface to the VirtioMemClass interface
list, implements the necessary methods and replaces
qemu_[un]register_reset() calls with qemu_[un]register_resettable().

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 hw/virtio/virtio-mem.c         | 39 ++++++++++++++++++++++------------
 include/hw/virtio/virtio-mem.h |  4 ++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ef64bf1b4a..4f2fd7dc2e 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -895,18 +895,6 @@ static int virtio_mem_validate_features(VirtIODevice *vdev)
     return 0;
 }
 
-static void virtio_mem_system_reset(void *opaque)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(opaque);
-
-    /*
-     * During usual resets, we will unplug all memory and shrink the usable
-     * region size. This is, however, not possible in all scenarios. Then,
-     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
-     */
-    virtio_mem_unplug_all(vmem);
-}
-
 static void virtio_mem_prepare_mr(VirtIOMEM *vmem)
 {
     const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
@@ -1123,7 +1111,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         vmstate_register_any(VMSTATE_IF(vmem),
                              &vmstate_virtio_mem_device_early, vmem);
     }
-    qemu_register_reset(virtio_mem_system_reset, vmem);
+    qemu_register_resettable(OBJECT(vmem));
 
     /*
      * Set ourselves as RamDiscardManager before the plug handler maps the
@@ -1143,7 +1131,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
      * found via an address space anymore. Unset ourselves.
      */
     memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
-    qemu_unregister_reset(virtio_mem_system_reset, vmem);
+    qemu_unregister_resettable(OBJECT(vmem));
     if (vmem->early_migration) {
         vmstate_unregister(VMSTATE_IF(vmem), &vmstate_virtio_mem_device_early,
                            vmem);
@@ -1843,12 +1831,31 @@ static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
     }
 }
 
+static ResettableState *virtio_mem_get_reset_state(Object *obj)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(obj);
+    return &vmem->reset_state;
+}
+
+static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(obj);
+
+    /*
+     * During usual resets, we will unplug all memory and shrink the usable
+     * region size. This is, however, not possible in all scenarios. Then,
+     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
+     */
+    virtio_mem_unplug_all(vmem);
+}
+
 static void virtio_mem_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOMEMClass *vmc = VIRTIO_MEM_CLASS(klass);
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
     dc->vmsd = &vmstate_virtio_mem;
@@ -1875,6 +1882,9 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     rdmc->replay_discarded = virtio_mem_rdm_replay_discarded;
     rdmc->register_listener = virtio_mem_rdm_register_listener;
     rdmc->unregister_listener = virtio_mem_rdm_unregister_listener;
+
+    rc->get_state = virtio_mem_get_reset_state;
+    rc->phases.hold = virtio_mem_system_reset_hold;
 }
 
 static const TypeInfo virtio_mem_info = {
@@ -1887,6 +1897,7 @@ static const TypeInfo virtio_mem_info = {
     .class_size = sizeof(VirtIOMEMClass),
     .interfaces = (InterfaceInfo[]) {
         { TYPE_RAM_DISCARD_MANAGER },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     },
 };
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 5f5b02b8f9..79f197216b 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -13,6 +13,7 @@
 #ifndef HW_VIRTIO_MEM_H
 #define HW_VIRTIO_MEM_H
 
+#include "hw/resettable.h"
 #include "standard-headers/linux/virtio_mem.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/qapi-types-misc.h"
@@ -115,6 +116,9 @@ struct VirtIOMEM {
 
     /* listeners to notify on plug/unplug activity. */
     QLIST_HEAD(, RamDiscardListener) rdl_list;
+
+    /* State of the resettable container */
+    ResettableState reset_state;
 };
 
 struct VirtIOMEMClass {
-- 
2.45.2



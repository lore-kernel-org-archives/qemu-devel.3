Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56587FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSm-0003f5-Lu; Mon, 04 May 2026 08:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSk-0003UQ-H6
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSg-000748-2a
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koi1KP51vf/Ga4Ls+tWs7FtQt712xO7gXsJ5W6hoFOE=;
 b=ZvJtQeyj1hpJz/e9VJtedHod95tu9s4dDVzTVrHnnYGne0fvuTFQHB9A+nuAmtONEfMCeL
 ygb8MOHPMmEf6zHRISWHxEnZihCQtM542jJUlBEZf/2zKC71JSlprThYID+1Tv0G5l5am5
 4JDf0AeYHsLe6ZfAGE7G+Kob1k/pqao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-TdogUoPEN2qgHKEqtgp9SA-1; Mon,
 04 May 2026 08:31:44 -0400
X-MC-Unique: TdogUoPEN2qgHKEqtgp9SA-1
X-Mimecast-MFC-AGG-ID: TdogUoPEN2qgHKEqtgp9SA_1777897903
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7783918005B0
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 798361800480; Mon,  4 May 2026 12:31:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:19 +0400
Subject: [PATCH v4 13/13] RFC: hw/virtio: start virtio-mem guest_memfd
 regions as shared
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5397;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Sglwch19SlDhieIy7v8NKzFebPUh8jiaqmn97KAMqkA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZ7iSydRn4tnMpCKZx6qgL9HWw9EuAsHQg0
 HH10rJGqnGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5dk3EACjZPWwZC8B3cJMyKxMcUMmQy0YNx14stgrPvprUl4+cVEoxnswi5oWaOaT4fwbRjxsNAz
 PwUZRSLe7x5eIa7jWpiw4Y5mtBb8RbP/ewzY54GiHoNuOO3NuVkYyaO1EnG/twDuPlWr/2HiurP
 3zTu//1zgS7tAoqRYpcyw14+36FMZsXgSrYY2W3vK9GtSF5UDMvFNIQ5iBEF4jGIIfeFIW00LRA
 vGGrFIZoHT0yBRHiomaqAELvanSAx6qsTEW4/EIsfMtsTYrVSp6mUBXb2LjUarwJjRyztHPzaz4
 +NsTvhihTTSJnQoY0q6wyQ5j2teI6BOPtEJ2GU81WeIOPeGj2B7fJskOVp9GjMxsPW+4n3APHpq
 JVbLR8wolmtuBY7PrRJvm4nb6K1POznnlRiRJ4zNu6lUsaD09si3qLgkRsHyUCLtZ7qkjdOni8Q
 yLc7pesz+N8GypKF5SaGRYuTh3on2Zy1BEogbxESSIXO/vHXcoeTj9FhB18iW8LS4nwp7aMLbzO
 oPNCW2MUTqZlCHIYAK48xX5ZWbK2lmoe1cXW82AmJtcuXsLTeMxCmyeJed6gNKUjjENgarm1yh7
 HHI+VqIN6Ce2Rhtja9zemEvUN3aQfLfo+N2AVh3vSEgz6UhZPf42UTeOd7hQaJ1OFUcBHS0SFJ9
 A2/ooSOkBOw7kEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

In TDX guests, virtio-mem plug/unplug/re-plug fails because
kvm_set_phys_mem() unconditionally sets KVM memory attributes to
PRIVATE for all guest_memfd regions. On re-plug, the PRIVATE->PRIVATE
transition is a no-op, so KVM doesn't re-AUG pages and the guest's
TDG.MEM.PAGE.ACCEPT fails.

Implement the "start-shared" approach: virtio-mem memory starts with
shared KVM attributes. The guest converts shared->private on plug (via
set_memory_encrypted -> MapGPA + ACCEPT), and back to shared on unplug
(via set_memory_decrypted). This ensures every plug triggers a real
SHARED->PRIVATE transition, causing KVM to AUG fresh pages.

Add RAM_GUEST_MEMFD_START_SHARED flag and set it during virtio-mem
realize for guest_memfd-backed regions. Use
ram_block_attributes_state_change() to properly update the attributes
bitmap through the API. Skip setting PRIVATE in kvm_set_phys_mem()
when the flag is set. On unplug, explicitly reset KVM attributes to
shared on the host side to handle the case where the guest skips
set_memory_decrypted().

See also virtio-comment "[PATCH RFC] virtio-mem: add shared/private memory property details".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/memory.h |  6 ++++++
 accel/kvm/kvm-all.c     |  3 ++-
 hw/virtio/virtio-mem.c  | 27 ++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 28a75dac4ae..9dbf67efe50 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -277,6 +277,12 @@ typedef struct IOMMUTLBEvent {
  */
 #define RAM_PRIVATE (1 << 13)
 
+/*
+ * RAM with guest_memfd that should start with shared KVM memory
+ * attributes. The guest converts to private on use.
+ */
+#define RAM_GUEST_MEMFD_START_SHARED (1 << 14)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 97463a683f4..c034e74c8e5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1737,7 +1737,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        if (memory_region_has_guest_memfd(mr) &&
+            !(mr->ram_block->flags & RAM_GUEST_MEMFD_START_SHARED)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 35e03ed7599..b46efe21126 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -19,6 +19,7 @@
 #include "system/memory.h"
 #include "system/numa.h"
 #include "system/system.h"
+#include "system/kvm.h"
 #include "system/ramblock.h"
 #include "system/reset.h"
 #include "system/runstate.h"
@@ -479,6 +480,11 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         if (vmem->dynamic_memslots) {
             virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
         }
+        if (rb->flags & RAM_GUEST_MEMFD_START_SHARED) {
+            kvm_set_memory_attributes_shared(start_gpa, size);
+            ram_block_attributes_state_change(rb->attributes,
+                                              offset, size, false);
+        }
         return 0;
     }
 
@@ -606,10 +612,12 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
     RAMBlock *rb = vmem->memdev->mr.ram_block;
 
     if (vmem->size) {
+        uint64_t used = qemu_ram_get_used_length(rb);
+
         if (virtio_mem_is_busy()) {
             return -EBUSY;
         }
-        if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
+        if (ram_block_discard_range(rb, 0, used)) {
             return -EBUSY;
         }
         virtio_mem_notify_unplug_all(vmem);
@@ -622,6 +630,11 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         if (vmem->dynamic_memslots) {
             virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
         }
+        if (rb->flags & RAM_GUEST_MEMFD_START_SHARED) {
+            kvm_set_memory_attributes_shared(vmem->addr, used);
+            ram_block_attributes_state_change(rb->attributes,
+                                              0, used, false);
+        }
     }
 
     trace_virtio_mem_unplugged_all();
@@ -859,6 +872,18 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     rb = vmem->memdev->mr.ram_block;
     page_size = qemu_ram_pagesize(rb);
 
+    /*
+     * For CoCo VMs with guest_memfd, use the "start-shared" model:
+     * memory starts as shared and the guest converts to private on
+     * plug.
+     */
+    if (rb->flags & RAM_GUEST_MEMFD) {
+        rb->flags |= RAM_GUEST_MEMFD_START_SHARED;
+        ram_block_attributes_state_change(rb->attributes, 0,
+                                          qemu_ram_get_used_length(rb),
+                                          false);
+    }
+
     if (virtio_mem_has_legacy_guests()) {
         switch (vmem->unplugged_inaccessible) {
         case ON_OFF_AUTO_AUTO:

-- 
2.54.0



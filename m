Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA1AEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58s-00074T-OH; Tue, 10 Sep 2024 13:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58q-0006va-3i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58o-0006R1-8Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76s1XbThi25DI/WfFTNV4gn3SVd304dQvKR/FcJRkBE=;
 b=Cp5nsTfPoIWT+xTk9bE06TUZctCGvMKJ73bEC1otg2yWt8PoIK/J68iDy8pwb5s5Mi0rYH
 DuU086HOoynEYJkdmFPTPtD2ZKni9CoFSh8hKLamUymDfm7Pja3rrKQ995hgnDp0LTu2YJ
 1JI87NAm5cdDQYgFUlG1+A+4ZZWcGUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-ngDbFHKKPDeRlhZL7lg41A-1; Tue,
 10 Sep 2024 13:58:58 -0400
X-MC-Unique: ngDbFHKKPDeRlhZL7lg41A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4F31956048; Tue, 10 Sep 2024 17:58:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B61B19560AD; Tue, 10 Sep 2024 17:58:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 08/14] s390x/s390-stattrib-kvm: prepare memory devices and
 sparse memory layouts
Date: Tue, 10 Sep 2024 19:58:03 +0200
Message-ID: <20240910175809.2135596-9-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

With memory devices, we will have storage attributes for memory that
exceeds the initial ram size. Further, we can easily have memory holes,
for which there (currently) are no storage attributes.

In particular, with memory holes, KVM_S390_SET_CMMA_BITS will fail to set
some storage attributes.

So let's do it like we handle storage keys migration, relying on
guest_phys_blocks_append(). However, in contrast to storage key
migration, we will handle it on the migration destination.

This is a preparation for virtio-mem support. Note that ever since the
"early migration" feature was added (x-early-migration), the state
of device blocks (plugged/unplugged) is migrated early such that
guest_phys_blocks_append() will properly consider all currently plugged
memory blocks and skip any unplugged ones.

In the future, we should try getting rid of the large temporary buffer
and also not send any attributes for any memory holes, just so they
get ignored on the destination.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 63 +++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index eeaa811098..1f1bd507b5 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -15,6 +15,7 @@
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/memory_mapping.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
@@ -84,8 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
                                         uint8_t *values)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
+    unsigned long max = s390_get_memory_limit() / TARGET_PAGE_SIZE;
 
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attributes");
@@ -103,39 +103,56 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
 static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
-    /* We do not need to reach the maximum buffer size allowed */
-    unsigned long cx, len = KVM_S390_SKEYS_MAX / 2;
+    unsigned long max = s390_get_memory_limit() / TARGET_PAGE_SIZE;
+    unsigned long start_gfn, end_gfn, pages;
+    GuestPhysBlockList guest_phys_blocks;
+    GuestPhysBlock *block;
     int r;
     struct kvm_s390_cmma_log clog = {
         .flags = 0,
         .mask = ~0ULL,
     };
 
-    if (sas->incoming_buffer) {
-        for (cx = 0; cx + len <= max; cx += len) {
-            clog.start_gfn = cx;
-            clog.count = len;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
-            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
-            if (r) {
-                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
-                return;
-            }
-        }
-        if (cx < max) {
-            clog.start_gfn = cx;
-            clog.count = max - cx;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
+    if (!sas->incoming_buffer) {
+        return;
+    }
+    guest_phys_blocks_init(&guest_phys_blocks);
+    guest_phys_blocks_append(&guest_phys_blocks);
+
+    QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
+        assert(QEMU_IS_ALIGNED(block->target_start, TARGET_PAGE_SIZE));
+        assert(QEMU_IS_ALIGNED(block->target_end, TARGET_PAGE_SIZE));
+
+        start_gfn = block->target_start / TARGET_PAGE_SIZE;
+        end_gfn = block->target_end / TARGET_PAGE_SIZE;
+
+        while (start_gfn < end_gfn) {
+            /* Don't exceed the maximum buffer size. */
+            pages = MIN(end_gfn - start_gfn, KVM_S390_SKEYS_MAX / 2);
+
+            /*
+             * If we ever get guest physical memory beyond the configured
+             * memory limit, something went very wrong.
+             */
+            assert(start_gfn + pages <= max);
+
+            clog.start_gfn = start_gfn;
+            clog.count = pages;
+            clog.values = (uint64_t)(sas->incoming_buffer + start_gfn);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+                goto out;
             }
+
+            start_gfn += pages;
         }
-        g_free(sas->incoming_buffer);
-        sas->incoming_buffer = NULL;
     }
+
+out:
+    guest_phys_blocks_free(&guest_phys_blocks);
+    g_free(sas->incoming_buffer);
+    sas->incoming_buffer = NULL;
 }
 
 static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
-- 
2.46.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4F8C87FD2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 08:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujClo-00015h-QE; Tue, 05 Aug 2025 04:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ujClm-0000sa-JC
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 04:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ujClj-0003KC-Bq
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754381492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TG+dvuhjObn1I7up7lAk09jZ20tc8t7wneFZXUwWzjM=;
 b=Z7xXwJ9c+Hl0UqhobAvGCHcgPCVLc/qiJQ50Ecp0Ci2aA6y3bjTmNMmCkMOTEM5Wpd/+aT
 4Spfnd+MimqdwopRewyLm9JFv4aFaANbm/DY49+GMRwBuLeEZhvC5hnlhWvCA4L5JogN41
 d1AxM0scMAAZQ1VrnLtcOQMCfsbFKo0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-iKw_Gnl_M6-iMzsZxRHhDg-1; Tue,
 05 Aug 2025 04:11:30 -0400
X-MC-Unique: iKw_Gnl_M6-iMzsZxRHhDg-1
X-Mimecast-MFC-AGG-ID: iKw_Gnl_M6-iMzsZxRHhDg_1754381489
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8811D1936D8C; Tue,  5 Aug 2025 08:11:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 849281956094; Tue,  5 Aug 2025 08:11:25 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com, pbonzini@redhat.com,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC v2] memory.c: improve refcounting for RAM vs MMIO regions
Date: Tue,  5 Aug 2025 10:11:23 +0200
Message-ID: <20250805081123.137064-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

v1->v2:
- Added documentation
- Explained the reasoning in the commit message

In the last version of the SHMEM MAP/UNMAP [1] Stefan
raised a concern [2] about dynamically creating and
destroying memory regions and their lifecycle [3].

After some discussion, David Hildenbrand proposed
to detect RAM regions and handle refcounting differently.
I tried to extend the reasoning in the commit message
below. If I wrote any innacuracies, please keep me
honest. I hope we can gather some feedback with
this RFC patch before sending it for inclusion.

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
[2] https://patchwork.ozlabs.org/comment/3528600/
[3] https://www.qemu.org/docs/master/devel/memory.html#region-lifecycle

---

Memory region lifecycle documentation discourages
creating or destroying memory regions dynamically
during a device's lifetime. The main concern here
is that "it may be in use by a device or CPU".
This means that a memory region could outlive its
owner.

However, this concern seems to revolve around
the fact that MMIO callbacks will most likely
access data that belong to the owner. Dynamically
removing/destroying the owner will result in buggy
behaviour. On the other hand, RAM regions do not
have this problematic behaviour as they reference
themselves. Recognizing non-MMIO MRs and handling
ref_count appropiately could clear/relax (for RAM
regions specifically) the initial concern stated
in the documentation.

This patch enhances memory_region_ref() and memory_region_unref()
to handle RAM and MMIO memory regions differently, improving
reference counting semantics.

RAM regions now reference/unreference the memory region object
itself, while MMIO continue to reference/unreference the owner
device as before.

An additional qtest has been added to stress the memory
lifecycle. All tests pass as these changes keep backward
compatibility (prior behaviour is kept for MMIO regions).

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 docs/devel/memory.rst      | 24 +++++++++++++-----
 system/memory.c            | 28 +++++++++++++++++----
 tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 57fb2aec76..9c428e82ff 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -143,11 +143,15 @@ Region lifecycle
 ----------------
 
 A region is created by one of the memory_region_init*() functions and
-attached to an object, which acts as its owner or parent.  QEMU ensures
-that the owner object remains alive as long as the region is visible to
-the guest, or as long as the region is in use by a virtual CPU or another
-device.  For example, the owner object will not die between an
-address_space_map operation and the corresponding address_space_unmap.
+attached to an object, which acts as its owner or parent.
+
+For MMIO regions, QEMU ensures that the owner object remains alive as
+long as the region is visible to the guest, or as long as the region is in
+use by a virtual CPU or another device.  For example, the owner object will
+not die between an address_space_map operation and the corresponding
+address_space_unmap. For RAM regions, the region itself is kept alive
+rather than the owner, since RAM regions are self-contained data objects
+that manage their own lifecycle.
 
 After creation, a region can be added to an address space or a
 container with memory_region_add_subregion(), and removed using
@@ -174,7 +178,8 @@ callback.  The dynamically allocated data structure that contains the
 memory region then should obviously be freed in the instance_finalize
 callback as well.
 
-If you break this rule, the following situation can happen:
+If you break this rule, the following situation can happen for MMIO
+regions:
 
 - the memory region's owner had a reference taken via memory_region_ref
   (for example by address_space_map)
@@ -184,6 +189,13 @@ If you break this rule, the following situation can happen:
 - when address_space_unmap is called, the reference to the memory region's
   owner is leaked.
 
+Note that memory_region_ref() and memory_region_unref() handle different
+region types appropriately: MMIO regions reference their owner device
+(since MMIO callbacks access owner data), while RAM regions reference
+themselves (since they are self-contained). Regions without owners, such
+as system memory containers and I/O address spaces, skip reference
+counting entirely as they exist for the machine's lifetime.
+
 
 There is an exception to the above rule: it is okay to call
 object_unparent at any time for an alias or a container region.  It is
diff --git a/system/memory.c b/system/memory.c
index 5646547940..1592293be7 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1826,6 +1826,17 @@ Object *memory_region_owner(MemoryRegion *mr)
 
 void memory_region_ref(MemoryRegion *mr)
 {
+    /* Regions without an owner are considered static. */
+    if (!mr || !mr->owner) {
+        return;
+    }
+    if (mr->ram) {
+        /* RAM regions are self-contained data objects, so we ref/unref
+         * the memory region itself rather than its owner.
+         */
+        object_ref(OBJECT(mr));
+        return;
+    }
     /* MMIO callbacks most likely will access data that belongs
      * to the owner, hence the need to ref/unref the owner whenever
      * the memory region is in use.
@@ -1836,16 +1847,23 @@ void memory_region_ref(MemoryRegion *mr)
      * Memory regions without an owner are supposed to never go away;
      * we do not ref/unref them because it slows down DMA sensibly.
      */
-    if (mr && mr->owner) {
-        object_ref(mr->owner);
-    }
+    object_ref(mr->owner);
 }
 
 void memory_region_unref(MemoryRegion *mr)
 {
-    if (mr && mr->owner) {
-        object_unref(mr->owner);
+    /* Regions without an owner are considered static. */
+    if (!mr || !mr->owner) {
+        return;
+    }
+    if (mr->ram) {
+        /* RAM regions are self-contained data objects, so we ref/unref
+         * the memory region itself rather than its owner.
+         */
+        object_unref(OBJECT(mr));
+        return;
     }
+    object_unref(mr->owner);
 }
 
 uint64_t memory_region_size(MemoryRegion *mr)
diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index fb45fdeb07..44f712e9ae 100644
--- a/tests/qtest/ivshmem-test.c
+++ b/tests/qtest/ivshmem-test.c
@@ -194,6 +194,55 @@ static void test_ivshmem_single(void)
     cleanup_vm(s);
 }
 
+static void test_memory_region_lifecycle(void)
+{
+    /* Device creation triggers memory region mapping (calls ref) */
+    IVState state1, state2;
+    uint32_t test_data, read_data;
+    int i;
+
+    setup_vm(&state1);
+
+    /* Basic verification that device works */
+    test_data = 0x12345678;
+    write_mem(&state1, 0, &test_data, sizeof(test_data));
+    read_mem(&state1, 0, &read_data, sizeof(read_data));
+    g_assert_cmpuint(read_data, ==, test_data);
+
+    /* Multiple devices stress test memory region ref counting */
+    setup_vm(&state2);
+
+    /* Verify both devices work independently */
+    test_data = 0xDEADBEEF;
+    write_mem(&state2, 4, &test_data, sizeof(test_data));
+    read_mem(&state2, 4, &read_data, sizeof(read_data));
+    g_assert_cmpuint(read_data, ==, test_data);
+
+    /* Device destruction triggers memory region unmapping (calls unref) */
+    cleanup_vm(&state1);
+
+    /* Verify remaining device still works after first device cleanup */
+    read_mem(&state2, 4, &read_data, sizeof(read_data));
+    g_assert_cmpuint(read_data, ==, test_data);
+
+    /* Final cleanup */
+    cleanup_vm(&state2);
+
+    /* Quick lifecycle stress test - multiple create/destroy cycles */
+    for (i = 0; i < 5; i++) {
+        IVState temp_state;
+        setup_vm(&temp_state);
+
+        /* Quick test to ensure device works */
+        test_data = 0x1000 + i;
+        write_mem(&temp_state, 0, &test_data, sizeof(test_data));
+        read_mem(&temp_state, 0, &read_data, sizeof(read_data));
+        g_assert_cmpuint(read_data, ==, test_data);
+
+        cleanup_vm(&temp_state);
+    }
+}
+
 static void test_ivshmem_pair(void)
 {
     IVState state1, state2, *s1, *s2;
@@ -503,6 +552,7 @@ int main(int argc, char **argv)
     tmpserver = g_strconcat(tmpdir, "/server", NULL);
 
     qtest_add_func("/ivshmem/single", test_ivshmem_single);
+    qtest_add_func("/ivshmem/memory-lifecycle", test_memory_region_lifecycle);
     qtest_add_func("/ivshmem/hotplug", test_ivshmem_hotplug);
     qtest_add_func("/ivshmem/memdev", test_ivshmem_memdev);
     if (g_test_slow()) {
-- 
2.49.0



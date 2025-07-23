Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1CDC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYS3-0005sZ-Gb; Wed, 23 Jul 2025 08:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYRz-0005qr-7P
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYRu-0006ER-Jh
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753273189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Aq4nwzr5Fnj4rdKWdq+ouYC6a5Qy0PycDLnmVny5IM=;
 b=fzPFhAik0NTU5sYgqoiWE0PU7qrsPhejrajpYDU/Bf2PaQWI6kl/Pzwx5X8601AuXMTi3e
 DAvzlpHMkb5UvIIwbCIQJ0lqhE67YLzdNKm4dPTLuwX0dz9oKojLL5ixkjf6PRHS3mKtdF
 IqbUd2ovgwaDKJ5VOq9QLc7DqWQYD1w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-9GR5vGGdPWKS6cAAROskqw-1; Wed,
 23 Jul 2025 08:19:45 -0400
X-MC-Unique: 9GR5vGGdPWKS6cAAROskqw-1
X-Mimecast-MFC-AGG-ID: 9GR5vGGdPWKS6cAAROskqw_1753273184
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73C0918001DA; Wed, 23 Jul 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.33.245])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01FED19560AF; Wed, 23 Jul 2025 12:19:38 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
Date: Wed, 23 Jul 2025 14:19:20 +0200
Message-ID: <20250723121920.1184928-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the last version of the SHMEM MAP/UNMAP [1] there was a
comment [2] from Stefan about the lifecycle of the memory
regions.

After some discussion, David Hildenbrand proposed
to detect RAM regions and handle refcounting differently
to clear the initial concern. This RFC patch is
meant for gathering feedback from others
(i.e., Paolo Bonzini and Peter Xu).

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=460121
[2] https://patchwork.ozlabs.org/comment/3528600/

---

This patch enhances memory_region_ref() and memory_region_unref()
to handle RAM and MMIO memory regions differently, improving
reference counting semantics.

RAM regions now reference/unreference the memory region object
itself, while MMIO continue to reference/unreference the owner
device as before.

An additional qtest has been added to stress the memory
lifecycle. All tests pass as these changes keep backward
compatibility (prior behaviour is kept for MMIO regions).

Signed-off-by: David Hildenbrand <david@redhat.com >
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 system/memory.c            | 22 +++++++++++++----
 tests/qtest/ivshmem-test.c | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 5646547940..48ab6e5592 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1826,6 +1826,14 @@ Object *memory_region_owner(MemoryRegion *mr)
 
 void memory_region_ref(MemoryRegion *mr)
 {
+    /* Regions without an owner are considered static. */
+    if (!mr || !mr->owner) {
+        return;
+    }
+    if (mr->ram) {
+        object_ref(OBJECT(mr));
+        return;
+    }
     /* MMIO callbacks most likely will access data that belongs
      * to the owner, hence the need to ref/unref the owner whenever
      * the memory region is in use.
@@ -1836,16 +1844,20 @@ void memory_region_ref(MemoryRegion *mr)
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



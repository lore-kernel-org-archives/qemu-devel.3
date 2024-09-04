Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22706CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvUu-0005WL-1H; Wed, 04 Sep 2024 15:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUq-0005L3-OB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUj-0006G0-T9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725477405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRaK3NDkX894rdbbAWVtU1HJEYTF42LMEEkHrDMJyWI=;
 b=fSfSik4+0Xd4UjK3ca7LpMbGR/s9mszLv89muFd7Wrf6wIjmmran+R7xY0GjzDWNrw2XPk
 CkOTXUJbyVyD3LuExEA7Yq5bFASBuJQcq5ZSPWmlXgMYw2TnJIRtyn3Yu6bSwFrlJRAmix
 O44lS4OcmOt2SydM8BtI4NLJpowNdhc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-NKzfACFoN66O7A0b-4o6MA-1; Wed, 04 Sep 2024 15:16:44 -0400
X-MC-Unique: NKzfACFoN66O7A0b-4o6MA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a8110f90a2so949741985a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725477403; x=1726082203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRaK3NDkX894rdbbAWVtU1HJEYTF42LMEEkHrDMJyWI=;
 b=bxnSWisF0e63XfdP9p5i0UvTbhaNKf0MJHT3i6sntRHumXz/1GP1UZ/+OHcTVeocoI
 PytK7dEuk03iqBNYDhMFgzO8HZMQhqDhfp7/xpQUmgrGjxp2tvl+YWozQ+foCnOQeVoc
 NQdBjICJ8xhUWlnpaIVR7JbS0ik91lot64olPIXsxS0G5Q3xYBnzr5rLr8/C5yPHup65
 YHeQyzmbnvd/yqDtiWR7iMmfSLGIu82Ho7UDly6TenLPqnlsEvNn/pQDy9OfLldDefVn
 KOZv2CLsa14ekJObpfEt7cFxai4NkjeMa2N/mme1oSw3aJBCV1dW0v2CX5sRC7Gadifp
 t2hw==
X-Gm-Message-State: AOJu0Yzt5TV19MfX/PHhYOkeLmrY6q58zj2ImTgrmbaocnbJx5pERq4c
 jS1bJezh6NRhID02CPPwhxwuS+cJwB2zVYTrSEamQysMDHW5VT6HRdOptoDnYmMla2tywU9ZioJ
 dF2ChZC5SYF1x/gI5Z03DHdzgc8eSj0kH2mVS5+PXy7nc39tC0SBN89lCghdMRN6ciF6WPpOJUH
 OrfLmA8/oMMIoK9aaytaH5y3lrWr68+7EhWY6D
X-Received: by 2002:a05:620a:472c:b0:7a2:e11:9e9d with SMTP id
 af79cd13be357-7a902f2a1a9mr1665962285a.50.1725477403369; 
 Wed, 04 Sep 2024 12:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUwPIKEIUFWy2p7Ak+gtle8F0GMy2l0SRg0tHNFkJJl9WvCVRhESU2t707K/ZYUXvJOyzNsw==
X-Received: by 2002:a05:620a:472c:b0:7a2:e11:9e9d with SMTP id
 af79cd13be357-7a902f2a1a9mr1665958485a.50.1725477402890; 
 Wed, 04 Sep 2024 12:16:42 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef250d2sm10260285a.15.2024.09.04.12.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 12:16:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>
Subject: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
Date: Wed,  4 Sep 2024 15:16:34 -0400
Message-ID: <20240904191635.3045606-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904191635.3045606-1-peterx@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
was a separate discussion, however during that I found a regression of
dirty sync slowness when profiling.

Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
statically allocated to be the max supported by the kernel.  However after
Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
the max supported memslots reported now grows to some number large enough
so that it may not be wise to always statically allocate with the max
reported.

What's worse, QEMU kvm code still walks all the allocated memslots entries
to do any form of lookups.  It can drastically slow down all memslot
operations because each of such loop can run over 32K times on the new
kernels.

Fix this issue by making the memslots to be allocated dynamically.

Here the initial size was set to 16 because it should cover the basic VM
usages, so that the hope is the majority VM use case may not even need to
grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
it'll consume 9 memslots), however not too large to waste memory.

There can also be even better way to address this, but so far this is the
simplest and should be already better even than before we grow the max
supported memslots.  For example, in the case of above issue when VFIO was
attached on a 32GB system, there are only ~10 memslots used.  So it could
be good enough as of now.

In the above VFIO context, measurement shows that the precopy dirty sync
shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
to any KVM enabled VM even without VFIO.

Reported-by: Zhiyi Guo <zhguo@redhat.com>
Tested-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 87 +++++++++++++++++++++++++++++++++-------
 accel/kvm/trace-events   |  1 +
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index e5de43619e..e67b2e5a68 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -46,6 +46,7 @@ typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
     unsigned int nr_used_slots;
+    unsigned int nr_slots_allocated;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e408dbb753..0d379606e4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -71,6 +71,8 @@
 
 /* Default max allowed memslots if kernel reported nothing */
 #define  KVM_MEMSLOTS_NUM_MAX_DEFAULT                       32
+/* Default num of memslots to be allocated when VM starts */
+#define  KVM_MEMSLOTS_NUM_ALLOC_DEFAULT                     16
 
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
@@ -168,6 +170,52 @@ void kvm_resample_fd_notify(int gsi)
     }
 }
 
+/**
+ * kvm_slots_grow(): Grow the slots[] array in the KVMMemoryListener
+ *
+ * @kml: The KVMMemoryListener* to grow the slots[] array
+ * @nr_slots_new: The new size of slots[] array
+ *
+ * Returns: True if the array grows larger, false otherwise.
+ */
+static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
+{
+    unsigned int i, cur = kml->nr_slots_allocated;
+    KVMSlot *slots;
+
+    if (nr_slots_new > kvm_state->nr_slots_max) {
+        nr_slots_new = kvm_state->nr_slots_max;
+    }
+
+    if (cur >= nr_slots_new) {
+        /* Big enough, no need to grow, or we reached max */
+        return false;
+    }
+
+    if (cur == 0) {
+        slots = g_new0(KVMSlot, nr_slots_new);
+    } else {
+        assert(kml->slots);
+        slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
+        /*
+         * g_renew() doesn't initialize extended buffers, however kvm
+         * memslots require fields to be zero-initialized. E.g. pointers,
+         * memory_size field, etc.
+         */
+        memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
+    }
+
+    for (i = cur; i < nr_slots_new; i++) {
+        slots[i].slot = i;
+    }
+
+    kml->slots = slots;
+    kml->nr_slots_allocated = nr_slots_new;
+    trace_kvm_slots_grow(cur, nr_slots_new);
+
+    return true;
+}
+
 unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -196,15 +244,20 @@ unsigned int kvm_get_free_memslots(void)
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
-    KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots_max; i++) {
+retry:
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         if (kml->slots[i].memory_size == 0) {
             return &kml->slots[i];
         }
     }
 
+    /* If no free slots, try to grow first by doubling */
+    if (kvm_slots_grow(kml, kml->nr_slots_allocated * 2)) {
+        goto retry;
+    }
+
     return NULL;
 }
 
@@ -225,10 +278,9 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
                                          hwaddr start_addr,
                                          hwaddr size)
 {
-    KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots_max; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (start_addr == mem->start_addr && size == mem->memory_size) {
@@ -270,7 +322,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     int i, ret = 0;
 
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots_max; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
@@ -1074,7 +1126,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock();
 
-    for (i = 0; i < s->nr_slots_max; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         /* Discard slots that are empty or do not overlap the section */
         if (!mem->memory_size ||
@@ -1722,12 +1774,8 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
     /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
     kvm_dirty_ring_flush();
 
-    /*
-     * TODO: make this faster when nr_slots_max is big while there are
-     * only a few used slots (small VMs).
-     */
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots_max; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_slot_sync_dirty_pages(mem);
@@ -1842,12 +1890,9 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 {
     int i;
 
-    kml->slots = g_new0(KVMSlot, s->nr_slots_max);
     kml->as_id = as_id;
 
-    for (i = 0; i < s->nr_slots_max; i++) {
-        kml->slots[i].slot = i;
-    }
+    kvm_slots_grow(kml, KVM_MEMSLOTS_NUM_ALLOC_DEFAULT);
 
     QSIMPLEQ_INIT(&kml->transaction_add);
     QSIMPLEQ_INIT(&kml->transaction_del);
@@ -2464,6 +2509,18 @@ static int kvm_init(MachineState *ms)
         s->nr_slots_max = KVM_MEMSLOTS_NUM_MAX_DEFAULT;
     }
 
+    /*
+     * A VM will at least require a few memslots to work, or it can even
+     * fail to boot.  Make sure the supported value is always at least
+     * larger than what we will initially allocate.
+     */
+    if (s->nr_slots_max < KVM_MEMSLOTS_NUM_ALLOC_DEFAULT) {
+        ret = -EINVAL;
+        fprintf(stderr, "KVM max supported number of slots (%d) too small\n",
+                s->nr_slots_max);
+        goto err;
+    }
+
     s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
     if (s->nr_as <= 1) {
         s->nr_as = 1;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 37626c1ac5..ad2ae6fca5 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -36,3 +36,4 @@ kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
 kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
 kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
+kvm_slots_grow(unsigned int old, unsigned int new) "%u -> %u"
-- 
2.45.0



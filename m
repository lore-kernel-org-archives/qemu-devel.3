Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36024CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0O-0002Tx-71; Wed, 30 Sep 2026 11:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0G-0002Sh-Bq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0D-0000gO-CL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0D/I8J3LUwWZpGiIfgIGNPj1aa/cXIqgnPtn4aAiB4=;
 b=JpMddp/xGiFW13jiSITamJriJLmLUdZFsvvr2QvpynU7JfdAJFzyIexZ4xDaEL0pP3yvGB
 9KCt57Gm3h/utcBI4sQ3ljgF1BhVGmubkEN7m3oXja1aw35B1f0y6XQNgQeEBnS03ClCcY
 8fx+mBSOJv+pM8/QfERscAl/+XPp9CM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-1EO9ZqrrMHSPGrW2y3qphQ-1; Wed, 30 Sep 2026 11:13:44 -0400
X-MC-Unique: 1EO9ZqrrMHSPGrW2y3qphQ-1
X-Mimecast-MFC-AGG-ID: 1EO9ZqrrMHSPGrW2y3qphQ_1790781224
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6741d08bf9cso6323717d50.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781224; x=1791386024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0D/I8J3LUwWZpGiIfgIGNPj1aa/cXIqgnPtn4aAiB4=;
 b=koKYeQBC5sQdf92Ceq7j03OAZYcizdol4JAvL9wM22et0vvwRCe+VZv5Yrrw9MepVS
 q2zQO7+STZQatIqPhPfaSfW2dmadT3pEmfRuPuxZtEOWwplJjsxc9SOqADJLC+kuwR4q
 RoQ+VbsCAGleqDkxHeIPSsXTc3TnurExgAJ2MwyREISeX/FkZwgDJy7NhZZ+2ZUmzCks
 1Grf1ZFg93Rmn3vU9waTKLd8yhvlMoiNziVIAK/9GY0850yXlSKfiezzUtAVnL1/0a/f
 qpoTf1TQOdHlM1maHqqaEHow0fC5Qf2ALZPvP5/+o3rJxud+5u1/v/V5P0cbv3dE7ZJX
 d1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781224; x=1791386024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0D/I8J3LUwWZpGiIfgIGNPj1aa/cXIqgnPtn4aAiB4=;
 b=G5spFMZW7ueOR3jZuha0EQCx6z5QqrlneefTe7EetIvungna5eSnZSHRJGyNqkFe7b
 /XrZkm+XJZ60K5oC/0TBybQWaiGuFdAMQ9zRKJYAbMRGwekCxgzKrSVm9XQQM+yaM2gU
 pVItrfkayRj5NQc0Cc0Hbs1e6xLE71ajdJa2ZRJPzHmBbsvoOpv+3+t1II5XCADtmEzr
 cXZrlrOKEu6EaTs84ueEg3kQMBLr9AW9RamtIVF5THBWnAwUVvbY5YFUmXY/bAy9uVkJ
 +EmXU09t1cSyHEl0Wt8Nis4p/GezKHHi7bi5iOn5Gdrztp1Gdoe+rvEL8lUhsNWBk0Xa
 elbg==
X-Gm-Message-State: AFq9FYL/8vVJxDweYq/t5YTpj6eknUcm2o5pxIN+HQFXnPSWltbk1JEB
 EGSd0JfSQKB8h9xNjpTsAZzYvdNSjjMTg8RRIAlVJDlYbjJSOlbBAbgBaMr3ncF6FAH8gUUuv3b
 wrNTG3mK/CF5IDbSZsu0PNvuiOOscli600Q6O9heLl7MdNmAfYcAwgRlhiCzUGqum5leCO4ec44
 g91pFBtvz02ugqqLmBcmOXjMSylLQTFRjK1WrTXbj4
X-Gm-Gg: AYBFou0BAUNOZWZx3IR8+kLJ0NTEL7I4opzQkPE2PEhWT/14+WzS9740DoOV+6Pyp0t
 zItxi93SOHcN22utvy5E5/jXRyRd++dKEJENfyP3wHSNGcOdpFIiuAfaHFRVol180OI/r499L2e
 imgZT2stW4gSMvoNUk5+6sUE138QBNP6BNr5poKuZch+MXW9bwfSTdhYbG+k4OjxVJ30ax4JVvn
 O1gqhAhujqw73in3nN8epOmz99sjFHSca/ydyAC/q6iaHICdEOV6yU7fDXQgSMoCYYGe9+O7LWL
 BdON02PagRK7JYdpXOdJgpqyGj8B7j/zHPBb78I8J4D9Uvkc1mI8rE7U3MmwltruPho14KU=
X-Received: by 2002:a05:690e:12c4:b0:676:8b46:d3e6 with SMTP id
 956f58d0204a3-6768b46ddefmr642157d50.63.1790781223978; 
 Wed, 30 Sep 2026 08:13:43 -0700 (PDT)
X-Received: by 2002:a05:690e:12c4:b0:676:8b46:d3e6 with SMTP id
 956f58d0204a3-6768b46ddefmr642132d50.63.1790781223287; 
 Wed, 30 Sep 2026 08:13:43 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a881aba3sm1829356d6.2.2026.09.30.08.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Roth <michael.roth@amd.com>, David Hildenbrand <david@kernel.org>
Subject: [PULL 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Wed, 30 Sep 2026 11:13:29 -0400
Message-ID: <20260930151340.2817042-2-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

With the mmap support of guest memfd, KVM allows userspace to create
guest memfd serving as normal non-private memory for X86 DEFAULT VM.
However, KVM doesn't support private memory attribute for X86 DEFAULT
VM.

Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
requires guest_memfd to serve as private memory.

This allows QEMU to create guest memfd with mmap to serve as the memory
backend for X86 DEFAULT VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-2-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/kvm.h   | 1 +
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 system/physmem.c       | 9 +++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 714b8c7b01..d29624034c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -551,6 +551,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..cdc7554082 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1627,6 +1627,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
     return kvm_set_memory_attributes(start, size, 0);
 }
 
+bool kvm_private_memory_attribute_supported(void)
+{
+    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -3058,8 +3063,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 32b4b07403..3d34e3b99d 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -143,3 +143,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/system/physmem.c b/system/physmem.c
index bd5f41cb02..1b3f327ed5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2192,6 +2192,15 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       "KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA705CF3979
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLlzx-00033g-Lq; Wed, 19 Nov 2025 12:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzh-000311-Oe
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzd-0004NQ-UE
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tl+z1WmVvwbjP9MF6m9chbVRsv74+2tGN5jEc9dOxpg=;
 b=QOfb7itdCPiQpLbHnEQXPVhd674lVCvyKyn3myoTDk2DtjtSG0Zv2v27IT8UrUKFjPYAjd
 PdHjp4yK7u4VoHOWP0aYuD5TzEqjvexhMXqInXlh927Mb1Xc1ZYCINjK29tFpHo7Oz9qaY
 pEQTecWwmwRO+j3mQtUOEwvEjqi1bMo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-s-yznHTSNd-QEVUdNhtlzQ-1; Wed, 19 Nov 2025 12:29:19 -0500
X-MC-Unique: s-yznHTSNd-QEVUdNhtlzQ-1
X-Mimecast-MFC-AGG-ID: s-yznHTSNd-QEVUdNhtlzQ_1763573358
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2657cfcdaso878253985a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573358; x=1764178158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl+z1WmVvwbjP9MF6m9chbVRsv74+2tGN5jEc9dOxpg=;
 b=jIg1ghQBiihTF8izzEd0Kjy4YXTRd+vTpuFNearEoyxuF5w4W/GmocZZZb4F9nU8XU
 W+U1P4h9WQ+SnEFQxUUEDFkEZy/UtnmNJ6ozzxMQU4fC8MOwAiXNygFFVYz5GBle+8iI
 8xr6vyIl4zEE59mBIUPZ622SVMyaIim0tPW9ZxzHmS2U5orKqaXfo3EFfEkyF2iR0HwI
 mDlsDTZCXHdWs+2B5mZBGLKXfdqRVS3P48zbyuWfk90fxUpfHz/yPDyaQvaBb0bbrIyr
 L7W89HZ2FEF8p2UiHZhYHGb2ugTa31drBPZkvN6MDGEyx1VYQXRbCunBj66VUFBI9eZp
 e0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573358; x=1764178158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tl+z1WmVvwbjP9MF6m9chbVRsv74+2tGN5jEc9dOxpg=;
 b=nwxfm1Ed0vrrRPU9Umx2ynXWncrjCQ4wMIrxrQax3GkFjHvqDUUAUEVX4iTD5PJPl6
 15gHYSJNEwBzW0GBqm7OXlr6E1AA0etUHoO7bLM1wmQcv6GWULLQQXYet607//x2o6zb
 Qn0PJrtOSAw+MTASFlpjS7U936GnJhpdLe0l+MoSjHr69x7Ctb8X24hGNj0wWkhHPUvr
 tajk8xaE0ZN6JG04kAznMli57rztqkHq/KqvsvKe5ydm4ngpXW96ZTaTkEhjImjst3Q+
 OePWFtHg4KyQWAIQ+yplFiP2RWTsrP16BawxRHQadv6hZowzMZ8ZD5ZSJ+lUNNa8jzKJ
 blcw==
X-Gm-Message-State: AOJu0YyijVHpXI4EWf4YSCj8F+n6QCc+Cmv+jUUCLhZzjbDumk6377Re
 1CZObgNCp//nZUWTCxN8ftrtXESwhnH2hXoJEihUcccmQrFgIUYtqmvjAXdvXI5whnIbcUXzGkp
 DEGXF9d6CAZBNLl1S50e8wGRHysYAeFDDYObKmJSlb2ygPV6h0NmfjojvWKMmd+SHw/aJ0IJSIF
 wmABQ9uF1xUmN8GW16Q42+eH/v7Aiculessuh83Q==
X-Gm-Gg: ASbGncttts7yi532kR376+7fW6FndQIUhtXWtfGWiECAbxNvlW+vaFgCv/swlo3sUER
 86RQy7lwL7Jq8oqHWY8fiZh0HTrEvf0zC9DF6dkbn0vzpGO+ytlfFPiROaEUJmd+SldMM6ZqINJ
 vx8D4KZzcP917xEmteWOgI0WcB+DvWf2uEROx3KKwqKojtSQx8BszyLsYcBCUYGxDTKmxE5+mHi
 gaT0qjmW4lVVW9qXe0SGU22LLVrHIV8D1R9tRfvNX+dSD9V5CnuXq6AQysFDLNKHfM/CSYAORrB
 wGMHmc6pKdELLkm5u4mWfJkkpwhvFOEfqGUwuO/2S2SHD5pvbC76H5ib0BHmCY+GM6Osr/SpfG/
 c
X-Received: by 2002:a05:620a:471e:b0:84e:2544:6be7 with SMTP id
 af79cd13be357-8b3274877d7mr20979785a.65.1763573357886; 
 Wed, 19 Nov 2025 09:29:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0dCicOW7ZH0EJiH5b+RgwwToqHtj/BVHiLjetambiYT5JhkX1gSIIyRSfLzhDViP4ubU54A==
X-Received: by 2002:a05:620a:471e:b0:84e:2544:6be7 with SMTP id
 af79cd13be357-8b3274877d7mr20974585a.65.1763573357212; 
 Wed, 19 Nov 2025 09:29:17 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 1/9] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Wed, 19 Nov 2025 12:29:05 -0500
Message-ID: <20251119172913.577392-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

With the mmap support of guest memfd, KVM allows usersapce to create
guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
However, KVM doesn't support private memory attriute for X86 DEFAULT
VM.

Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
requires guest_memfd to serve as private memory.

This allows QMEU to create guest memfd with mmap to serve as the memory
backend for X86 DEFAULT VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/kvm.h   | 1 +
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 system/physmem.c       | 8 ++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044..b5811c90f1 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9254ae654..96c194ce54 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
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
@@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba97..73f04eb589 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..3555d2f6f7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       " KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.50.1



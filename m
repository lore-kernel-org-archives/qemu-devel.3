Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11002CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X6-0006Y3-J8; Thu, 23 Oct 2025 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X4-0006XP-0e
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0X2-0003Da-4Y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+2r7MuA6OG87fdVMOc0DGwzybnlDA/AOjyEzzWkuQU=;
 b=M6gMVNAzyhPVQevBJMPvwXgMxKEOawQUJikXPwTpva0mqiSBl58PNUjLBIpcSqyauTiMGg
 WzmyId41HJHXIFPDoymvhmPrfmSfQIPiRSaHABjgvY4ZhXem8RxJ0321QwwqRcSdZIZ2hH
 6ZS1ya+RcS8Kxk7cUHWOu20ggAh6KMQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-7bevD59KNVSlsCNeug6HTw-1; Thu, 23 Oct 2025 14:59:25 -0400
X-MC-Unique: 7bevD59KNVSlsCNeug6HTw-1
X-Mimecast-MFC-AGG-ID: 7bevD59KNVSlsCNeug6HTw_1761245965
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-890f1090e81so341656585a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245964; x=1761850764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+2r7MuA6OG87fdVMOc0DGwzybnlDA/AOjyEzzWkuQU=;
 b=ejDh4hOCqDu8xfuz4nEEphf3BYL4R5XYY04LOf+05FTWEnOcu7xrFGs46VIoun+t6H
 vt3KH3L7yazg80iCkvKygZV1C5Oi+yzCohUVbWYPrX6nXC7CYPyAUBzaOWxunfOemPvr
 DYtbabANqZ5UH+2OT2LnjMLxqTtt4J6Bhk9zeLBj4ICwVP0ckgl7r92zeYgvsZYIssiZ
 ShX6bJ/IDmBg1T08XAkvTnzluhhVmVpJZqFkpMlbZlGDUnwcCcrWLdZY3NRgYAUf35rr
 uj4gbUf6s9oKhYJ76gvJ/x72Mo3dKCvR/hKUOGgnTvr5hfbNTUs4sSHxlu805I1cOAZ0
 3GEw==
X-Gm-Message-State: AOJu0YxDH0kdoVryu3FcdDg+TH2MA82FJSe8zAdPo8SPqKY49HR/Lfqi
 gQyoBCVz5lqLZ8DPVtrYTutJ1mTAjXWV9chOEGXcB16DiOzQDi+h00zgs9QrCecVHNkq0bFWAjq
 sU7tZuQCZSPk1+7iy/YLukhiHrSLr1d3wC1HpF34Zw6PqSbDLFy2pkSoF2jO1czuP1+y/Mk3SFM
 EgOQ+HSfe7P0Z1P5VXdiIpasAM1Aw61OO7qCElZg==
X-Gm-Gg: ASbGnctfRVeQ2v0Pf7y/M9xJAi7AAN/t1NHuf1VGTuCHS87YtaZhHGmWkZitKn7kV3q
 RhqzBo+ZBMtWnd6GAwJDgIs+TclRcIOIG118VWNlA2vjKo5B57Xfv6r90jTKOsdHLVWqsmUlM9j
 PJOJ8Jpicq8/erQ+C2tzxVEG0M466Vx9wEOKzHCwrWx7PiFAa3LaC4NOLiY3E7gtggfn8bCnWrp
 l0mhoymYYkHoRwD6hEdix5lJbdEEsFrd9d/NyShVTZgodLJ65HhlSnzkWMrRZFNg+CUhra+0JBu
 lX/G2wk3oP9oQD1feGflmAzKETX4j7EvcN7FtQR3MrvTN4/GdEF+1hseg4HVBDzd
X-Received: by 2002:a05:620a:1a8f:b0:891:b6a0:e5a0 with SMTP id
 af79cd13be357-891b6a0ea70mr2621714285a.45.1761245964347; 
 Thu, 23 Oct 2025 11:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+6c23nrFjW6XD74agtX7hTw4prNuPB7Q96hvWgAMBJ7tZ5C5THcnbfSeAM7s92C2jl+3bnA==
X-Received: by 2002:a05:620a:1a8f:b0:891:b6a0:e5a0 with SMTP id
 af79cd13be357-891b6a0ea70mr2621709485a.45.1761245963803; 
 Thu, 23 Oct 2025 11:59:23 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 5/8] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Thu, 23 Oct 2025 14:59:10 -0400
Message-ID: <20251023185913.2923322-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251023185913.2923322-1-peterx@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rename the function with "_private" suffix, to show that it returns true
only if it has an internal guest-memfd to back private pages (rather than
in-place guest-memfd).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 6 +++---
 accel/kvm/kvm-all.c     | 6 +++---
 system/memory.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 2c1a5e06b4..4428701a9f 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1823,14 +1823,14 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
 bool memory_region_is_protected(MemoryRegion *mr);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ * memory_region_has_guest_memfd_private: check whether a memory region has
+ *     guest_memfd associated
  *
  * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(MemoryRegion *mr);
+bool memory_region_has_guest_memfd_private(MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 48a8f6424f..6521648ce9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -666,7 +666,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
-    if (memory_region_has_guest_memfd(mr)) {
+    if (memory_region_has_guest_memfd_private(mr)) {
         assert(kvm_guest_memfd_supported);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
@@ -1610,7 +1610,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        if (memory_region_has_guest_memfd_private(mr)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
@@ -3096,7 +3096,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         return ret;
     }
 
-    if (!memory_region_has_guest_memfd(mr)) {
+    if (!memory_region_has_guest_memfd_private(mr)) {
         /*
          * Because vMMIO region must be shared, guest TD may convert vMMIO
          * region to shared explicitly.  Don't complain such case.  See
diff --git a/system/memory.c b/system/memory.c
index 006b03ce1c..5f05e5d73e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1897,7 +1897,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
-bool memory_region_has_guest_memfd(MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd >= 0;
 }
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423D8CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0W-0002YI-MB; Wed, 30 Sep 2026 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0L-0002Tl-Ki
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0J-0000hN-Nb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+/Uh5MYYSNZUM3uVjI0Pna/C+eoWM439GTWlhwfHBc=;
 b=StOtWEk6uiDARr/0y2n/VNG0EKPTL4syGk0RH8ZB3XRWgTanvrb8cY36K3X6j33UJ+/yaF
 Rix0wsA75els6nFkHOsOvhLH3ESpCx+dN8GfR+AGewZK+hsQsp6SlKBfEczZwnTgBhb3uq
 RzNI/T4NHtCyVJuF3WFimzuHeBjcf+c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-2AKykEAgNp6HE8wVjMkihg-1; Wed, 30 Sep 2026 11:13:53 -0400
X-MC-Unique: 2AKykEAgNp6HE8wVjMkihg-1
X-Mimecast-MFC-AGG-ID: 2AKykEAgNp6HE8wVjMkihg_1790781233
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a183a0e93so1167463885a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781233; x=1791386033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+/Uh5MYYSNZUM3uVjI0Pna/C+eoWM439GTWlhwfHBc=;
 b=GytH7VXsSPg/xH2wQlrC6lm9BUT3Ip7GCVeQtqWGamgYJZ/2ScV1Rx/iYLKhqciB/e
 U7VyZYewj4/wtcOl5SDRJiirlr90YlL5IsbttQ6MQueBwIMTsRg63Iq8eKGc7G/tiscJ
 mTBrL7DBJQHN86DXnFvNW7y4RW1xAvIKXS0q/navxi1ys4buvZq88bcIXCOmYygOGuH2
 ZNap+F68ExdRIFwkbTt2tp35hHJtJAZk82Udf4Xr3K8lJfeosF07JUbf+gORA1UInTne
 WKBoYCLaJfN11SZsw7ovqCRsTXUyCIsBXCGwuL8sC7+aE7pIJi4caqr8V3NcJV/a8cQT
 WhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781233; x=1791386033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+/Uh5MYYSNZUM3uVjI0Pna/C+eoWM439GTWlhwfHBc=;
 b=Zasbi/p8SSv4mvBdu5y/prAYMzJP70d3JNKjgBWmkLCVHSJdKt6ECsPMA0WJYLEO4Y
 vorP+yraJtrsMKVCrv3xwpz/zRDCNfHaWlowm6FagYDALq0iI80beWJsHBeE055BusuT
 IP+UoDcw6c2uEQtMh+RbGQo2kPIBoYttSyxPiubk5e3RWHyi9VthK70jrn0Czo61dHaz
 ETCe3TfywXjXM9FpRRF+d+/mK3ILgadSvqhFb++p/cZ6x738cRtj7Ms9+eCgG9R2mr/e
 AopyqWBUDJKKWDY+q1pcLvcP68Zi93Ev9tjngry/ploKTzYU+j97UG4KxgjnKzDqZL8J
 +4Cw==
X-Gm-Message-State: AFuF++kNNcqtr57DldA5JHgRTLgcDecE9O0BfG+1LNpqDcoRKywdoeBd
 LtRqvmD2kewJGLAI8NqjAm2mgjGs8s6URKdFcSSLwx+Df13vxv3zSnMSTUntuT8pJKfGCnWUAGC
 ItcOmHGfp6iYhCvDdIew6bD/Db7G7qQA1gVp7bsJQuHFboSO6Be+50zrUdlYbyGk7FM0V7m6Emr
 MEScM27SqufG37/4WTLUjygtOlDMbL1nGxDAR/0Ik6
X-Gm-Gg: AYBFou2Ns8l3mcnIBx6T1M3TtOY20lbODjNReLT9ATIRqhPvvwmx6DFHF7cZYpkfawe
 TABRshxhUKwGwmTgMKb/S166IuoKuzIo3OsmIydFtqTmXp7H18jwlxFB9J6G+of8C3z8DyZpdlF
 mOMd6O9s31cKfu5P/keAHIdODzuk0O7aB6546kq32+inTczKhhv2hHN+RDqXBSlbbkRoG2fFOAI
 O9kn8wxM7O7Osh1GE2+3bkhYrWp6yVsNhdnPWMv6DTVC2+TIne8qA6oUWd8y3asuoeyeGy/GY0T
 TO9b8IsvgqiL7yiF6HPCwe4tmKN6W8UoHaN49slYwp4m9fSnCqzmtXEx1dhQSFG4sJosLHc=
X-Received: by 2002:a05:620a:4889:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93ca979091amr280166085a.25.1790781232662; 
 Wed, 30 Sep 2026 08:13:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4889:b0:939:c1d4:e2e1 with SMTP id
 af79cd13be357-93ca979091amr280160785a.25.1790781232111; 
 Wed, 30 Sep 2026 08:13:52 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca7eb02casm139847185a.5.2026.09.30.08.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Wed, 30 Sep 2026 11:13:34 -0400
Message-ID: <20260930151340.2817042-7-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rename the function with "_private" suffix, to show that it returns true
only if it has an internal guest-memfd to back private pages (rather than
fully shared guest-memfd).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-7-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 4 ++--
 accel/kvm/kvm-all.c     | 6 +++---
 system/memory.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 932072c631..96ab920e7d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1507,7 +1507,7 @@ bool memory_region_skip_iommu_map(const MemoryRegion *mr);
 void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has
+ * memory_region_has_guest_memfd_private: check whether a memory region has
  *     guest_memfd_private associated
  *
  * Returns %true if a memory region's ram_block has valid guest_memfd_private
@@ -1515,7 +1515,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(const MemoryRegion *mr);
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a29b1d7a3c..db52bb9ffb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -792,7 +792,7 @@ static int kvm_mem_flags(MemoryRegion *mr)
     if (readonly && kvm_readonly_mem_allowed) {
         flags |= KVM_MEM_READONLY;
     }
-    if (memory_region_has_guest_memfd(mr)) {
+    if (memory_region_has_guest_memfd_private(mr)) {
         assert(kvm_guest_memfd_supported);
         flags |= KVM_MEM_GUEST_MEMFD;
     }
@@ -1741,7 +1741,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        if (memory_region_has_guest_memfd_private(mr)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
@@ -3372,7 +3372,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         return ret;
     }
 
-    if (!memory_region_has_guest_memfd(mr)) {
+    if (!memory_region_has_guest_memfd_private(mr)) {
         /*
          * Because vMMIO region must be shared, guest TD may convert vMMIO
          * region to shared explicitly.  Don't complain such case.  See
diff --git a/system/memory.c b/system/memory.c
index 96e42beb2e..fa0a2cf563 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1778,7 +1778,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
     mr->ram_device_skip_iommu_map = skip;
 }
 
-bool memory_region_has_guest_memfd(const MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
-- 
2.55.0



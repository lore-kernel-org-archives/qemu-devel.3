Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791CCCF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm01-00035V-Bn; Wed, 19 Nov 2025 12:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzk-000317-0u
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzg-0004O8-8h
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woCcmK5foYk7Lz5yBYA0XL2QOL9NnX0jkIYkMd3rgxE=;
 b=ZOH5+ZlbxzOy+Mbm9CytcOTsA6cUZxZ5Qqan+BruvwrcBAUQU0oOaoOqe+32Vh24mlB/rx
 1owTeqOb8s59v01C1sF3jnak/JL89FQLVy7EgxKkRjekH3OAYRV36sLYmHB/KyWNrE9Ixj
 7gAU+ukOIDtqi884pKWFGbJuHWFMrBc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-y8KNzaneMF2xiv24g9vY3A-1; Wed, 19 Nov 2025 12:29:22 -0500
X-MC-Unique: y8KNzaneMF2xiv24g9vY3A-1
X-Mimecast-MFC-AGG-ID: y8KNzaneMF2xiv24g9vY3A_1763573361
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b24a25cff5so1968055085a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573361; x=1764178161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woCcmK5foYk7Lz5yBYA0XL2QOL9NnX0jkIYkMd3rgxE=;
 b=LTCnxZIjmKLpx1N5XzKqS+EHnx8k8MOPbQ00itQwibDJV2pR0diZSMd7KvgTALw9dX
 GdhAxBFfDYsqDyocfSshTVWET5Sa6cZLZFqxVJb0z0RubQs5od82PGlq2KLx9SHtxXv/
 iZ2k2t3Ggn2+kcz4J0cRRmexXIGk54C5G0esri6fGxf6wJTpymZsz0kigfjXkdK4yRIs
 DUvjfYAI//rN0IPEYoOeaYG1999pIxQTYv8Gh7Mw4vdLfwZ3mfUdtRlUcufKlZ+hRXFf
 eNUywzN992MOpiTI6nafMnNeilfjWesvsuHCE4WoptQksbIJsrB3H0Uz+DUeB2t1O4wn
 zTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573361; x=1764178161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woCcmK5foYk7Lz5yBYA0XL2QOL9NnX0jkIYkMd3rgxE=;
 b=k84lUizQBXSB8mMta8iD5S1bsmw2IPS+hW7T6H/MbncEXKvXBlCCFcdgKUocVyHMeK
 IC302WoOayWCXobLhdHyK93ooSmCtbjkiOPX5R8d+CgJRFx6rKdNg1P1x+y8oQo4GJUS
 2PG/6fIlOtB0klXoWgFcL7VTOwMRCUqwAWKwtmFOxyFzSFfZeVIY07Thdw1/tGDLJE++
 hcbI77wTMFtiqMrfl6hxtOzTWB5zgFfKlM/R6xgLO6w/AzLaVITDmvM2aqM6hKbxYiHj
 5p/0fKns+DpP3dlhDAvVLNTCHuFIC3Bi6PwVWOjIzTPuFneEodWNoOeOaXdOOVJhZPYL
 sqSQ==
X-Gm-Message-State: AOJu0YyPEfj+XMHZLsj82iHMa7EZL+R5x66Jx4PYd0jH84Ti+g5sPj1Q
 BwF2z2OwjX8LctSH5ziM2i8zYcOJWAxq1WakmqZOimhtvUonCn01qz/SFSIt0ZqJksOu3Vu/u3Y
 XsNkwp1Zy5mjV3GfOjoTZU5tt9uLLbWhug2+XYOdYn7QW/HOVJPvseTH2qf1G6bWFe7pBENn53J
 coShYWGOH0itbiGKOKWSpgWyxm4e4295dKmDkuGw==
X-Gm-Gg: ASbGncuEUYrLxlWWRqJYNJcX43daybH2o0zGoBgygsXc+r94PGNkOQms092u9Cv2lZ5
 U37Zq5CFZ7ZQA+gEB0vehdsait7vBGQkp1+DVRKebqNP5RQ2gkMN2VixSWBnaI1KynIxsX4hduy
 TCa9Ns+CwEE4dFG33bd7MJSGGbaL11nU73ONtwFEy3v4cxbjPhO5aLMSAoZZmSjzSCmthAfmUd3
 aA5Xen6oFqe1H1CAVsK/38u/70x99J/XzlLHDqUSqohIGPqeAJoOit+5bBHHWVTLWO/7cEj9cyL
 gwfAqvioT78Yk4Wly2MH4dYdTqAsG778N6oZQoFkmAyfD725AFyw9Rlb+bWsPzGMq8Bu6+YBYzO
 N
X-Received: by 2002:a05:620a:444a:b0:8b2:7679:4d2d with SMTP id
 af79cd13be357-8b32749fd9fmr19639385a.63.1763573360966; 
 Wed, 19 Nov 2025 09:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzTPICTCv+VqEihJpe2V98/7Wrln/9b6c1IqXOfd1Zwu4qLJuFYpkhAQABO1aG9oA1m4Iyig==
X-Received: by 2002:a05:620a:444a:b0:8b2:7679:4d2d with SMTP id
 af79cd13be357-8b32749fd9fmr19635485a.63.1763573360452; 
 Wed, 19 Nov 2025 09:29:20 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 4/9] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Wed, 19 Nov 2025 12:29:08 -0500
Message-ID: <20251119172913.577392-5-peterx@redhat.com>
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
index f477014126..320315f50c 100644
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
@@ -1615,7 +1615,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
 
-        if (memory_region_has_guest_memfd(mr)) {
+        if (memory_region_has_guest_memfd_private(mr)) {
             err = kvm_set_memory_attributes_private(start_addr, slot_size);
             if (err) {
                 error_report("%s: failed to set memory attribute private: %s",
@@ -3101,7 +3101,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         return ret;
     }
 
-    if (!memory_region_has_guest_memfd(mr)) {
+    if (!memory_region_has_guest_memfd_private(mr)) {
         /*
          * Because vMMIO region must be shared, guest TD may convert vMMIO
          * region to shared explicitly.  Don't complain such case.  See
diff --git a/system/memory.c b/system/memory.c
index 81b7bff42d..15964160ee 100644
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



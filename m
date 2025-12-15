Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3ED5B86E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYM-0006EQ-Dd; Mon, 15 Dec 2025 15:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYJ-0006Ar-MM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYI-0005kt-0c
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZwiaCu3Ephp0x1hYM6njn6cQ5FWzr55+DbUEhACNdI=;
 b=bXR5O2sLd1o+/G2V1oPstsEsUdZQxJZhwaRx5CY+Viv3diGI8JFpn67q7xeQmwl1zyX7gF
 neRxZxEerc9cJPgM+hJICTdCX5KYbKHsUPFayZoRKdoUuG2YWrekDKEPyAjH2tPZLPGHne
 ru0lPPNXgHoTJvHuOQLO3sNbMjvnr0w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-10_nRFDjOBSJUNYKVny2Dg-1; Mon, 15 Dec 2025 15:52:16 -0500
X-MC-Unique: 10_nRFDjOBSJUNYKVny2Dg-1
X-Mimecast-MFC-AGG-ID: 10_nRFDjOBSJUNYKVny2Dg_1765831936
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed74ab4172so85753321cf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831935; x=1766436735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZwiaCu3Ephp0x1hYM6njn6cQ5FWzr55+DbUEhACNdI=;
 b=bxk9w277+jryfz8jKUUG7iZsHcSh/bGcdfpXqhDkxVPjvPFMC9cD7kLdPoS1x7GZ8B
 Rb551YtdTLLrmPyZYkUDdMbn9o5whImGvyixKoN2clWbHq711WyEyM1tDXEivAzkCppS
 sJUyaHw4MP90opDJZXeBCUweB/S86dOMXX3GJK8Ld5fO7lvCkOQV3SsNs3Uu6gCcjGgO
 S6WnkNyUGHp2apMbpwF0vp3CG/gFWzvhWj5TM1WmuLs6kxqFWKMu3IXQRF3rhVWTkWQF
 W5xA+9ECvFVStzA1qPRdE4qovDMv2pu7NJLiwvyuivtcar6/5Miiaz/ijj9Q4Lzs966B
 wwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831935; x=1766436735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tZwiaCu3Ephp0x1hYM6njn6cQ5FWzr55+DbUEhACNdI=;
 b=J48l5n33Ckx2fmsLOg15hAByVhITSOK5GwwWXdAdeK8w5dfKElOMe49ZjeTHkckeuM
 cFXwVyOxuTWc/kJsKxFmrVNfGTI51xyj+aAeL4PXKthjLJD82aYe5E0mWXzr2DjxcAZG
 dilJxw0U1acD5QueMVUFIo8FCkATjTf9CgJ+SxOqeXSCgsgNGpA+updwwaLeCggeBcYr
 2TOWx2nFLpPddIY671DlAdCRsJ/YH+3tSMeU87EWCITINYHln/q1vJAU8CQ2SL4T2E7U
 QZmzPEyDEWro9Pk7JrDy6+qIh2YBxJPYR1idMCTGdyhKBbLIHCY0xQmpJbqW6GJ8U7TX
 sHAw==
X-Gm-Message-State: AOJu0YxxG8flLW+B9JhL1dIOCQKYWEM4k35Fo0Ypva/D6/S4JZn8gu0d
 8hrVjA2cT2W7HnU9R0ozpIAcANWYFDwUFbBsSYZ8lQx34OqRFDNu0io+09Zkm/H/gJYZqJ+623+
 oUAaWe9vqIxM26qfFsSwhMxolkcqpNUrNZMH7H4FCU4/8D4Us1nMqWhed2PbK3g/6NEl/UeYe4O
 y7irjNm0bPQ29kvWa0AiJlYJyW8x1Zzvy2C5s/xA==
X-Gm-Gg: AY/fxX5uw6HBrhxnR6Fx2pzzKE4X2rFL7ewExNvrs4IizURLNhA/s/n5S1x7KSVpPsT
 F3fyLG1PHTfukf02H/ro/jcFxPpA87TqZPjAqA56UUHIs/nLift67SWqUAh5F69dOe928j2w/yL
 Z2l1fPAR9eyNfISH/UiwIzsrYJCBW1pL0peku/NWnf+uCeqHl9taQKYpCmkiBgbq7Bu6M/QLMjH
 +ygMmaQ4hMKkdUemO4DRBgk7Ggic/g0H/D/7Bcl3SC87e3a5ls3h00l1Zg1cpL5XEpjg6Vk/Z5p
 ISXX1x1yKHZV9HaJPyr9X0kd0JB+kYurFDnMOG/WP04J462L7GQfOG8ZNWx5daF1VuKZ0vOjKcO
 m
X-Received: by 2002:ac8:5c88:0:b0:4ee:4a3a:bd11 with SMTP id
 d75a77b69052e-4f1d05ee877mr184845531cf.64.1765831935382; 
 Mon, 15 Dec 2025 12:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQNDrxVpZTIDg7mxEgJ8B01SY5Cs6tEA5719BpaKhoUFpyRp4u1mLJQobHYI5ViiyFwUJAsA==
X-Received: by 2002:ac8:5c88:0:b0:4ee:4a3a:bd11 with SMTP id
 d75a77b69052e-4f1d05ee877mr184845131cf.64.1765831934805; 
 Mon, 15 Dec 2025 12:52:14 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 06/12] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Date: Mon, 15 Dec 2025 15:51:57 -0500
Message-ID: <20251215205203.1185099-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
fully shared guest-memfd).

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 4 ++--
 accel/kvm/kvm-all.c     | 6 +++---
 system/memory.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1f49f9a0ff..9b58303bb8 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1823,7 +1823,7 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
 bool memory_region_is_protected(MemoryRegion *mr);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has
+ * memory_region_has_guest_memfd_private: check whether a memory region has
  *     guest_memfd_private associated
  *
  * Returns %true if a memory region's ram_block has guest_memfd_private
@@ -1831,7 +1831,7 @@ bool memory_region_is_protected(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(MemoryRegion *mr);
+bool memory_region_has_guest_memfd_private(MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1126b6f477..0b7ce5a9dd 100644
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
index e8c6d484e6..d70968c966 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1897,7 +1897,7 @@ bool memory_region_is_protected(MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
-bool memory_region_has_guest_memfd(MemoryRegion *mr)
+bool memory_region_has_guest_memfd_private(MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
-- 
2.50.1



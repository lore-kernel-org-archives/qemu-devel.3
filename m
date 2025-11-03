Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D57CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lW-0000yQ-7q; Mon, 03 Nov 2025 16:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lU-0000y3-MF
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lJ-0005Hc-LX
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6q2Mc0njNr3TWUKu7QBTNvu5m4/u/rY7x+4Ecu4W44=;
 b=U9vl9WBZfmwQYQWJbwU/uRlKIu1eNulXCf293T7F9EWut2KW1eyC2Qw5CYKsCw1UAz1nCp
 SBwhOtPfH9r7TKukilKo+ARnqzJXTyPTd5yAfW7OxLgjARawMaH4rq6iepJp51kO2BJgWp
 0cJ3lvZQkAjxRE0qM6Rnps9MkXDvW1U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-urqA6ZyZOYeYtMcVKVKcEQ-1; Mon, 03 Nov 2025 16:06:46 -0500
X-MC-Unique: urqA6ZyZOYeYtMcVKVKcEQ-1
X-Mimecast-MFC-AGG-ID: urqA6ZyZOYeYtMcVKVKcEQ_1762204005
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ecf1b7686cso185871131cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204005; x=1762808805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6q2Mc0njNr3TWUKu7QBTNvu5m4/u/rY7x+4Ecu4W44=;
 b=F/hPvq/T1AtBHr6c/uoodGUvB8OxKopnBClOsEbnHpQ02nncBD1/b1R2EmG8NQGrla
 KiJYhejqgaQ2WRNEOiPuxtYCKR/7dCkKJk+pQWCNEOBd4643D9fvfukxJjlE0NDTdF3B
 BjAku6RCm1uNggjo78mnpVAkk7DBGaeeXUeyTjgkkHBU/QdpsJG0kxJa2uxQeEiiAKU+
 nkjjZG8kiBMfQuMtKtQlReGbuSSlir9q5+9Ytd3wn4mLfFRwrHQ8/w1fffoU1Gc+G/zT
 C1d8S8SsgWWT4JpAm3TO9SNegzoC/A7sY3G8rjEJnoGUSSHYrvc7AH7vNl25C665onHO
 ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204005; x=1762808805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6q2Mc0njNr3TWUKu7QBTNvu5m4/u/rY7x+4Ecu4W44=;
 b=aH68YSjoILZXCNJhlloXNN8f5swjmPkHK5m+eASUdC5ylZJIT2ZQ1otmbOKdGaqsCi
 Syqu3HvQgkFw/QwcGlcraSC+Sbicsbin0paQwOBfKdDPdMvqm91MmDobMZ2nRkv1trjQ
 rfzrRf4ab/0K9aW3w3XmEu7STiAvJHm8eErDGCj9lfZjVNCxFUOQ2k4oafpIrhXBbaNT
 0NGYOw7QQUVT/Tw3/NksSAlKUCbaN+E/v6DrWZRpyymCHE6wrUDpywAHBf6QVsr8Rrg7
 +TtpXVXOY+K0SbN4TJ5zB3daIioNJ70+GmuzPQVXq+6SO89evf39ImGV38jcaMDlZd68
 a5eg==
X-Gm-Message-State: AOJu0YyCAZ03o5ZQRixc344OQc2AZJ6MpqRsW+cGBlOSbiQK69gIdYQ8
 4I0tok0nMD/IAWLtw6lFZQAZdpAFVLFnmXTdInxeQIQlUr4CjHJZ3ZA1oHgbja7BsvEkR4tLLWE
 sOInwSkdzSMODiXsudoWZ5xROuI5h/drKv3DInxFavov9P/WzvongYru1IiAoYJGDdyQ8J3SP5F
 adzmr5/Mt+V/3VKxhJ0xPJH8lLP/AKclimW8/vRA==
X-Gm-Gg: ASbGncuVLnoTP9pcj/jm9JmkZ2k5X2ZoVio3NVffiT51Ocd7euLSn+o2KdWdn+Q57BD
 2mxRtHOh8MdYg+yZnS5hazD080u3FGhAccjWA04asFAZ7nD4n8/o697iTyTxV8LjD2WAZ8y1n2H
 xtRJswdpQy4LCRpa6L62kvkdbz/qgVcBa40jqNFhmTAaZFNsel6EhacDWyuxwXh/p4ErUFbODSy
 +A32kyt7DjktbSao8e19R8tNSvUzmI0KY70q+agqt9R+4ad6Pj/1YLgOPLzkzHNKi/6rmGsc5vt
 IzdvZL+3nh9jQvePhx8xPw1/un6MOuevIeAZ3myTMxypd7xTay/1J/deWqtePBJR
X-Received: by 2002:ac8:5fd0:0:b0:4ec:fc9a:1802 with SMTP id
 d75a77b69052e-4ed60df079amr11088211cf.42.1762204004681; 
 Mon, 03 Nov 2025 13:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmfcajXDTtdGJKrir4F1nkVfRWq+xN8FnIIugLW0uFFIglb9+VEUWYO4j1IZ+AIGTMRqRbzw==
X-Received: by 2002:ac8:5fd0:0:b0:4ec:fc9a:1802 with SMTP id
 d75a77b69052e-4ed60df079amr11087361cf.42.1762204004108; 
 Mon, 03 Nov 2025 13:06:44 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:42 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 11/36] ram-block-attributes: fix interaction with hugetlb
 memory backends
Date: Mon,  3 Nov 2025 16:06:00 -0500
Message-ID: <20251103210625.3689448-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

Currently, CoCo VMs can perform conversion at the base page granularity,
which is the granularity that has to be tracked. In relevant setups, the
target page size is assumed to be equal to the host page size, thus
fixing the block size to the host page size.

However, since private memory and shared memory have different backend
at present, users can specify shared memory with a hugetlbfs backend
while private memory with guest_memfd backend only supports 4K page
size. In this scenario, ram_block->page_size is different from the host
page size which will trigger an assertion when retrieving the block
size.

To address this, return the host page size directly to relax the
restriction. This changes fixes a regression of using hugetlbfs backend
for shared memory within CoCo VMs, with or without VFIO devices' presence.

Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20251023095526.48365-2-chenyi.qiang@intel.com
[peterx: fix subject, per david]
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ram-block-attributes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 68e8a02703..a7579de5b4 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -22,16 +22,14 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
                                           { })
 
 static size_t
-ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
+ram_block_attributes_get_block_size(void)
 {
     /*
      * Because page conversion could be manipulated in the size of at least 4K
      * or 4K aligned, Use the host page size as the granularity to track the
      * memory attribute.
      */
-    g_assert(attr && attr->ram_block);
-    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
-    return attr->ram_block->page_size;
+    return qemu_real_host_page_size();
 }
 
 
@@ -40,7 +38,7 @@ ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
                                       const MemoryRegionSection *section)
 {
     const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     const uint64_t first_bit = section->offset_within_region / block_size;
     const uint64_t last_bit =
         first_bit + int128_get64(section->size) / block_size - 1;
@@ -81,7 +79,7 @@ ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
 {
     unsigned long first_bit, last_bit;
     uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     int ret = 0;
 
     first_bit = section->offset_within_region / block_size;
@@ -122,7 +120,7 @@ ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
 {
     unsigned long first_bit, last_bit;
     uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     int ret = 0;
 
     first_bit = section->offset_within_region / block_size;
@@ -163,7 +161,7 @@ ram_block_attributes_rdm_get_min_granularity(const RamDiscardManager *rdm,
     const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
 
     g_assert(mr == attr->ram_block->mr);
-    return ram_block_attributes_get_block_size(attr);
+    return ram_block_attributes_get_block_size();
 }
 
 static void
@@ -265,7 +263,7 @@ ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
     g_assert(mr);
 
     uint64_t region_size = memory_region_size(mr);
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
 
     if (!QEMU_IS_ALIGNED(offset, block_size) ||
         !QEMU_IS_ALIGNED(size, block_size)) {
@@ -322,7 +320,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
                                       uint64_t offset, uint64_t size,
                                       bool to_discard)
 {
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     const unsigned long first_bit = offset / block_size;
     const unsigned long nbits = size / block_size;
     const unsigned long last_bit = first_bit + nbits - 1;
-- 
2.50.1



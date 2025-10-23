Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEDCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs2t-0007ao-H5; Thu, 23 Oct 2025 05:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2q-0007a7-PN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2n-0002aO-Cz
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761213342; x=1792749342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ilhu01+hhVRRt4YbOjEcY+/EsGcv7tZF3vd2A5ikFKk=;
 b=frsAKRacoSmKJRWxwxlmXKzGyYs8wpEzs4+KZymicoPwOeZtX2KVe/Rz
 NFOcrEVRdTrGRipFZIpLkBvYnH9t6uaMEOxLljeUFLrWk8RQ+NdHeGb9X
 hHge52YnLgtuwBwh7Ktxel3bfzTEMngQvPfHkg4oS1ddvB/Kj0KgJ5LYX
 MTIiunAzW39xEqhoyF1sJhUFK1rT+fmuqfL160KTq1ICT71uAcPLSw67P
 pKQBML7l4Ytgm/MBAQsZuw8BjixTbA5kLNL70oOtQiyHHmbllAePsgCup
 MS7HNxOY/e5OcCZ04SzYp28YR/o5pySM+Y5+wHrsjkvm8R6pTXiaESIkX Q==;
X-CSE-ConnectionGUID: mKAe4LTkSNqb7OuQh6QBAA==
X-CSE-MsgGUID: CHz/0R2dRSWxRmGPzj4whw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74816144"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="74816144"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:38 -0700
X-CSE-ConnectionGUID: KcgZbXVxRraOLTtdhXkBjQ==
X-CSE-MsgGUID: vBIosCMaSkGZlcdIup1NoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="183289329"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:35 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 Gao Chao <chao.gao@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH v2 1/2] ram-block-attributes: Avoid the overkill of shared
 memory with hugetlbfs backend
Date: Thu, 23 Oct 2025 17:55:24 +0800
Message-ID: <20251023095526.48365-2-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023095526.48365-1-chenyi.qiang@intel.com>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
Changes in v2:
  - Modify the commit message
  - Remove the argument in ram_block_attributes_get_block_size()
---
 system/ram-block-attributes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 68e8a027032..a7579de5b46 100644
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
2.43.5



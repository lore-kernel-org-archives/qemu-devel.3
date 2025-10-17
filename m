Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE692CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fcD-0006vz-6p; Fri, 17 Oct 2025 04:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1v9fcB-0006v7-6y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:15:07 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1v9fc7-0008Md-B8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760688903; x=1792224903;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3BtdrjH53h57EMuz6JijtOp83I0cYTzE17aQ/+sFB6E=;
 b=WR3m5Yjx9c03MGeZ8i/IqogyQDYKZvXR5ZhkAOhix0Uy8efxvAzjGSl9
 BKQ9VCPOv7Tc1Vnvqxhd52WfFqBLSkK+Cfgi33Q2aVHJfXxLTjcRoUU/5
 lt1qg73wzu8eoyve+RA6Zye8vvLVQqGDOmeATzjzaYcB9RHnVB2fYrlt7
 nM3d36BMzM+dBbRtQUiK4optk9NTQOMxwHze0DkA6OlTzQI2ClO23Py2m
 nhTo2RZggmR5U/aLeuL4lVzUQroXV6yx0yURpPwzudY664ChxE/+KHhb0
 VT78F9CYYoZWghpmSjnzPZiyClwBNS/uvnQi26pLQ+jLICQUXw0N1rUAw g==;
X-CSE-ConnectionGUID: f4CdzqXIQoi8H18atdL43g==
X-CSE-MsgGUID: 6L4L4+nySo+NHtL5WjR21w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62985451"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62985451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:14:57 -0700
X-CSE-ConnectionGUID: I3YEi5hQR+esvjdODUAYCQ==
X-CSE-MsgGUID: kY3H/arGSAuZjyNS4MMwxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="206385268"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:14:55 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 Gao Chao <chao.gao@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH] ram-block-attributes: Avoid the overkill of shared memory
 with hugetlbfs backend
Date: Fri, 17 Oct 2025 16:14:23 +0800
Message-ID: <20251017081445.175342-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently, private memory and shared memory have different backend in
CoCo VMs. It is possible for users to specify the shared memory with
hugetlbfs backend while private memory with guest_memfd backend only
supports 4K page size. In this case, ram_block->page_size is different
from the host page size which will trigger the assertion when getting
block size. Relax the restriction to allow shared memory to use
hugetlbfs backend.

Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 system/ram-block-attributes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 68e8a027032..0f39ccf9090 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
      * Because page conversion could be manipulated in the size of at least 4K
      * or 4K aligned, Use the host page size as the granularity to track the
      * memory attribute.
+     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
+     * is different from host page size. So it is not appropriate to use
+     * ram_block->page_size here.
      */
-    g_assert(attr && attr->ram_block);
-    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
-    return attr->ram_block->page_size;
+    return qemu_real_host_page_size();
 }
 
 
-- 
2.43.5



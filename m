Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8BFCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs2u-0007b5-1P; Thu, 23 Oct 2025 05:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2q-0007a6-VC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2n-0002ae-OK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761213342; x=1792749342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lCfgcNtqBjjYhsMzChuyOJ9bb2S/Jnq3H/kqqntBhvc=;
 b=KzM2NO1807m8C3s9MfYiZglYfJ0vfoJGktgCwpexbonP5eut+7LUZw8S
 C79sj19nmQ+MQLEhsSI/8Hf0bsoqSHuAQFVxIjxiuZPXrzhKA7ux6kvt7
 1ccWU7wunbNbZRLvXUSefmF3Y4JYNrblVXp1NjjA6/7MTki5wqgwxnNtt
 upgUoS+5fYJY79CYNPh8ffPOsymGmjuQVrsdRbEcOTg+JCt647x7HY1Y2
 tlQSo97n9+P8727qWXyOt2CmrQLe2Gbea3w2S6vH7/fIyIEpDdoXEmu4P
 HUJYBWjAysI3MnwogRtXVgI5jRr474aEdjpoSpIP0DSB7cXpo32Rr7+G/ g==;
X-CSE-ConnectionGUID: NFxvpe4oTxS7S2Hshv02hw==
X-CSE-MsgGUID: nFMeyHJCTSyJdxVBxXesbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74816152"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="74816152"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:40 -0700
X-CSE-ConnectionGUID: PL7ZqBclSkuvGbEaNb3oNA==
X-CSE-MsgGUID: NIqN/sbOSlu0koTEL+ky2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="183289359"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:38 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 Gao Chao <chao.gao@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH v2 2/2] ram-block-attributes: Unify the retrieval of the block
 size
Date: Thu, 23 Oct 2025 17:55:25 +0800
Message-ID: <20251023095526.48365-3-chenyi.qiang@intel.com>
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

There's an existing helper function designed to obtain the block size.
Modify ram_block_attribute_create() to use this function for
consistency.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v2:
  - Newly added.
---
 system/ram-block-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index a7579de5b46..cf8f5f41966 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
 {
-    const int block_size  = qemu_real_host_page_size();
+    const int block_size  = ram_block_attributes_get_block_size();
     RamBlockAttributes *attr;
     MemoryRegion *mr = ram_block->mr;
 
-- 
2.43.5



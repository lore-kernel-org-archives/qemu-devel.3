Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0590CC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwLa-0003fT-Em; Mon, 17 Feb 2025 03:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLP-0003NR-IH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:12 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tjwLN-00016Q-HP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739780349; x=1771316349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E5Ngw7fVDUDC+t1CAmd5+sTvqe9bA5/nLMHz0pQXMco=;
 b=Iq9wxP/T2WX7P4qibw9sMwOQLSkHo+sz60PDMMeTugtiGZa4pL62Sczl
 EU4bxdx1wlAFu4hL8YR30/amx7KUQ6o6RYyK3OUMsKztT2z4kjk7Jtr09
 uztR3FkHDXCQa6nDOJJ2iwC8eKLnuSbMbCvwO8+ZOtWb+9B05kC+7UoG3
 +VBxVturt1awWGJXFcoEvkcXsUS1e5PDFAo361aEZ8+qwVE7PC60T3gZO
 v6J0KUBTQjjO2B2oAauJFd/6YSxfo9L/rAAfbHSleYnWoP2coxa1QdEGf
 aBRlX9+4DVUX9WqtbHXmoy3Ty++9tw5P4s62RvlKHoiD5kzeFAxoAEg0e w==;
X-CSE-ConnectionGUID: vEqp5VWzQ8OipB15yttzqQ==
X-CSE-MsgGUID: aLFJXWmoSWOUyWYzOeasmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="50669014"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="50669014"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:19:07 -0800
X-CSE-ConnectionGUID: 3PtVm0eITQy1Op+8wtRspw==
X-CSE-MsgGUID: 20dN3Mz6Qqm1GqR+j0/lpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118690267"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 00:19:05 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v2 6/6] RAMBlock: Make guest_memfd require coordinate discard
Date: Mon, 17 Feb 2025 16:18:25 +0800
Message-ID: <20250217081833.21568-7-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217081833.21568-1-chenyi.qiang@intel.com>
References: <20250217081833.21568-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

As guest_memfd is now managed by memory_attribute_manager with
RamDiscardManager, only block uncoordinated discard.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v2:
    - Change the ram_block_discard_require(false) to
      ram_block_coordinated_discard_require(false).
---
 system/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 0ed394c5d2..a30cdd43ee 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1872,7 +1872,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
-        ret = ram_block_discard_require(true);
+        ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
@@ -1892,7 +1892,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             error_setg(errp, "Failed to realize memory attribute manager");
             object_unref(OBJECT(new_block->memory_attribute_manager));
             close(new_block->guest_memfd);
-            ram_block_discard_require(false);
+            ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2152,7 +2152,7 @@ static void reclaim_ramblock(RAMBlock *block)
         memory_attribute_manager_unrealize(block->memory_attribute_manager);
         object_unref(OBJECT(block->memory_attribute_manager));
         close(block->guest_memfd);
-        ram_block_discard_require(false);
+        ram_block_coordinated_discard_require(false);
     }
 
     g_free(block);
-- 
2.43.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 14:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umYs1-0004Az-Hw; Thu, 14 Aug 2025 10:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umYrz-0004AS-DI
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:23:55 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umYrt-0003Ct-L8
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 10:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755181430; x=1786717430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hbATJmh33hiD2jm2Ul61SMq1SjQEEQHmzjo3F5wj3Eo=;
 b=VMzmxFYOfFhhAQGR4LfR7F3+k9SQA8o+rmQ14N4PCNppsLz8clBDTZvw
 VspqhdlJ1oowollTLZE7PLCXgGPEmVL+LsaAAn3MPTkIyTkRzLulBSsrw
 9lnxQFQ2zMDxUdHHIHykgiraCRd+XEmelj6A5FySSJZGdr3uYKuN75pZe
 v78vA+plVUTylLhaK00XO4GafndpRw+ZoV7m3prPtMOSTt7HbsPYOW/2U
 xNlgObTPIYe1N3UbMq6Q/xcmgELbHCuLvYRMy6pFzekzcijcU2Y7ZOgGt
 0armCkOeIY1tZzhNrRXNAQjfdBWqXdeKZtB7fDLkH6iux3MXEgRF1ROlj w==;
X-CSE-ConnectionGUID: 1ojXyEu7RcOVMAXWcf1LTw==
X-CSE-MsgGUID: hhrE1Zd4R5GAmejC+NsnoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57406085"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="57406085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 07:23:47 -0700
X-CSE-ConnectionGUID: 7aecShlRTZWQ9zzH8EhPiw==
X-CSE-MsgGUID: S8eelrQ5TamTQbjnjuAVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="197625240"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa001.fm.intel.com with ESMTP; 14 Aug 2025 07:23:45 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] x86/loader: Rectify the address of setup_data
Date: Thu, 14 Aug 2025 22:14:06 +0800
Message-ID: <20250814141406.2371767-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.94, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 214191f6b574 ("x86/loader: read complete kernel") changed the
semantics of kernel_size from the piggyback kernel to the whole kernel
file, which leads to the setup_data_offset contains setup_size and leads
to wrong address of setup_data being written in header[0x250].

Fix it by minusing setup_size.

Fixes: 214191f6b574 ("x86/loader: read complete kernel")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be64d67b..127b85eb02cc 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -935,7 +935,7 @@ void x86_load_linux(X86MachineState *x86ms,
         kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
         kernel = g_realloc(kernel, kernel_size);
 
-        stq_le_p(header + 0x250, prot_addr + setup_data_offset);
+        stq_le_p(header + 0x250, prot_addr + setup_data_offset - setup_size);
 
         setup_data = (struct setup_data *)(kernel + setup_data_offset);
         setup_data->next = 0;
-- 
2.43.0



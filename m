Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D23CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nCH-0006VF-WC; Sun, 28 Sep 2025 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nCF-0006UO-4C
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:55 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC8-00044H-Lw
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049749; x=1790585749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kPLupQPAUBUcNZDsIGDQVNkPtYijna1nTxTrWEhgc4I=;
 b=mX4TshKd3GFuU01vdwwvGRDTy+NyqBXvfKLeg6F3P20kNYplQDKs2D7e
 pflVGcnMNMR/daHwOL/KwG9kUAqVz9BnpVq7Yq7GSy3TLB3qe8J6n1709
 c0pUvxIREgQgepEsFGdenlQM+KVDpH4y+M9E7aBNfTu/Meums8pHt9fba
 RNM4GupWJgrunw0zGw6dkB2jpF35YLzcpmAW+8VWfb6/6JSZ0SBBvHdbx
 L/iv1FoCsXOzmXfF54m7x90CQWQcQhqUJDTbv1rpbF5jwI6tkUm+v9lp/
 Dw0BdGfSqld9TjlhOqYjkCjzVZzWV2Ew1t641MvFBmiVVC3DEAzqwvxp1 g==;
X-CSE-ConnectionGUID: 5IXCqz8JRJChPZHJbjrgaQ==
X-CSE-MsgGUID: uNC98ggHQeapacoNgGd3VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167447"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:28 -0700
X-CSE-ConnectionGUID: Pw3ed5hcTn+pDadMFJaZNg==
X-CSE-MsgGUID: bXU8akrsSMKkdwdkaEJEGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810823"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
Date: Sun, 28 Sep 2025 04:54:32 -0400
Message-ID: <20250928085432.40107-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

After CPR transfer, source QEMU closes kvm fd and sets kvm_state to NULL,
"query-balloon" will check kvm_state->sync_mmu and trigger NULL pointer
reference.

We don't need to NULL kvm_state as all states in kvm_state aren't released
actually. Just closing kvm fd is enough so we could still query states
through "query_*" qmp command.

Opportunistically drop an unnecessary check in kvm_close().

Fixes: 7ed0919119b0 ("migration: close kvm after cpr")
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 accel/kvm/kvm-all.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 23fd491441..b4c717290d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -639,13 +639,10 @@ void kvm_close(void)
         cpu->kvm_vcpu_stats_fd = -1;
     }
 
-    if (kvm_state && kvm_state->fd != -1) {
-        close(kvm_state->vmfd);
-        kvm_state->vmfd = -1;
-        close(kvm_state->fd);
-        kvm_state->fd = -1;
-    }
-    kvm_state = NULL;
+    close(kvm_state->vmfd);
+    kvm_state->vmfd = -1;
+    close(kvm_state->fd);
+    kvm_state->fd = -1;
 }
 
 /*
-- 
2.47.1



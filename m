Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB5CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nCC-0006UL-V9; Sun, 28 Sep 2025 04:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC9-0006TF-Gy
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:49 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC2-00044v-DZ
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049742; x=1790585742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fbTVzACek9P6n49RRFyo1a5o1MnuIxGtUd4h5/5M0a0=;
 b=HNtGufGH7nQgaksPs9L2+FzrNgUrBMfmRkS62CWPLRjWXbZ2D0kvBFMt
 lbhz445hLSslgpRB/zBOOkwady1xOGBJHuHGtAFUdEDP63VwpKiX3Ji8y
 5nX4OXL33VxB+L8U4LRL9Sz4D24oWbu+fHNCwepexiwoHdF2fhCrFL81g
 CE2ogiaj7xqyEcHYHNU8r2TuTFAROxnjV8vvEEkVL9Ip1Zy621pLPSkfu
 Eltm1ynCxEliZna3nloVvUP8cwUUCIMBHoBJb4ifKnz6jkWXIq/NTFoCr
 22wHicRwUQad96Zmtt5c8mVKgrBZcpFj+3fvFoOYjOW9m0WeS46kHdUrl Q==;
X-CSE-ConnectionGUID: tv+s5JGHQneRdYCe0A9UhQ==
X-CSE-MsgGUID: GvNbzYc3S46yRCGDtg2g+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167442"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167442"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:26 -0700
X-CSE-ConnectionGUID: CdLddlw4SJaxES6pJdIpgA==
X-CSE-MsgGUID: X8ml7fg4QmKMt7yblE/5qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810818"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 5/6] accel/kvm: Fix an erroneous check on
 coalesced_mmio_ring
Date: Sun, 28 Sep 2025 04:54:31 -0400
Message-ID: <20250928085432.40107-6-zhenzhong.duan@intel.com>
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

According to KVM uAPI, coalesced mmio page is KVM_COALESCED_MMIO_PAGE_OFFSET
offset from kvm_run pages. For x86 it's 2 pages offset, for arm it's 1 page
offset currently. We shouldn't presume it's hardcoded 1 page or else
coalesced_mmio_ring will not be cleared in do_kvm_destroy_vcpu() in x86.

Fixes: 7ed0919119b0 ("migration: close kvm after cpr")
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9060599cd7..23fd491441 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -523,7 +523,8 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
     }
 
     /* If I am the CPU that created coalesced_mmio_ring, then discard it */
-    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
+    if (s->coalesced_mmio_ring ==
+           (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE) {
         s->coalesced_mmio_ring = NULL;
     }
 
-- 
2.47.1



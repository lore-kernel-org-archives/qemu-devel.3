Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421A1D711D5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgIl-0004Qt-8P; Mon, 22 Dec 2025 08:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilia.levi@intel.com>)
 id 1vXf97-00049S-2F
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 07:36:18 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilia.levi@intel.com>)
 id 1vXf95-0005Jv-Cz
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 07:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766406975; x=1797942975;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WoMOrUD2vAq1ygcqGgmS4vdjupPItaJVV+TmW4x3ahw=;
 b=l6IIoBm9VKMbDFlXAFG6mROkz2oYWhVETLOcXhWmg/Yzf5lcceYNnAX2
 4y2CBQvWTkhSAmGWvNpuWJCNixEX08M9SPV7eOc65Ej+gnS1pyebcivDS
 6T0rLRM389luh3pQePhnBC4F4wpJV/isZ5RCnWpy4r5ngLzwDinR9ol2C
 UZWmTi3G8G0KK/8ZPfprfJNN1p6Io3jtGfGnjrv3mij8odzUXl3R9WqL4
 eBQOYd1pD4Oa9t8G2SYRd8uBwt2FrX2s3vdETwCj2+bzHwBNjEqMsBNHw
 jXPVBJ7t7ZduQLtiF/UAn1p9SCg5sWJxBAESyhKpN4lrrmhIJrB5mx0S0 A==;
X-CSE-ConnectionGUID: c1EFMP1ySl6320DoUkLHRQ==
X-CSE-MsgGUID: li9gRZCKQZuICFvk/mihtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68142495"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="68142495"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 04:36:11 -0800
X-CSE-ConnectionGUID: nznnjNdYSBO+n+jMz0rwSQ==
X-CSE-MsgGUID: nNzqNKY4TO+Aeln6ekrynA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; d="scan'208";a="200408065"
Received: from unknown (HELO ilevi-mobl.intel.com) ([10.13.220.47])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2025 04:36:09 -0800
From: Ilia Levi <ilia.levi@intel.com>
To: qemu-devel@nongnu.org
Cc: ilia.levi@intel.com, jeuk20.kim@samsung.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 0/2] hw/ufs: Fix mcq completion queue wraparound
Date: Mon, 22 Dec 2025 14:35:57 +0200
Message-ID: <20251222123559.3387-1-ilia.levi@intel.com>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=ilia.levi@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:50:02 -0500
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

Currently the completion queue processing routine in UFS does not check
whether there is available space. This can cause CQ entries to be discarded
and overwritten. This series include a fix for the issue based on how NVMe
processes completions. It also includes a test to illustrate the issue.

Before applying the fix, the test will fail with:
ERROR:../tests/qtest/ufs-test.c:801:ufstest_mcq_cq_wraparound:
assertion failed (completed == num_requests): (0 == 32)

Ilia Levi (2):
  hw/ufs: Fix mcq completion queue wraparound
  tests/qtest/ufs-test: Add test for mcq completion queue wraparound

 hw/ufs/ufs.c           |  20 ++++++-
 hw/ufs/ufs.h           |   9 +++
 tests/qtest/ufs-test.c | 125 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 1 deletion(-)

-- 
2.49.1



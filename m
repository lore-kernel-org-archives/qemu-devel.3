Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45027CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs2s-0007aT-9u; Thu, 23 Oct 2025 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2q-0007a5-9A
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vBs2n-0002aE-Cx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761213342; x=1792749342;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ruxTiv2jIOEsdbtlLX6koyoiKrF5v2KnWI/pq1yP37s=;
 b=Zicaj8rputTNCScvyUXT+jiW9kpkFb3dB2o1NCVnOGwSnL6CIF5z4x4P
 FqhXi+S4/P8JVjP/dU0Tl7Qzks43aDg3oI9ZVWJK//aACjLd1XFYefl1+
 KPiXE1yrSaj4ZA6DmGRlukvEJdLZFd0Oc4ktAv98fgTn+l7ykW6V62X7L
 54PIAXFsx7M9B+bdb72+P4xJJHmphJ3WAA89PgrxUlQNQc9YSQ4aiKCT8
 H8ubHahZY2mdkW8Tp6XSBuhs+nfq3n9X24mFCihM2BiGz1smwgCIeITwg
 0lou3KFEjdVdiI++VxR/GghnPzfbXij+G8yWefrzFYmORQoEIuynQww1b Q==;
X-CSE-ConnectionGUID: uGP5xi4/RRGF1l9Ecq5eRg==
X-CSE-MsgGUID: 9vp2NV3bSWusY1Fof8lvqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74816139"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="74816139"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:35 -0700
X-CSE-ConnectionGUID: VXgrEjIjS1+uWw19CVJR9w==
X-CSE-MsgGUID: hntjpy+aRguPXURhb4t40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="183289320"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 02:55:33 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 Gao Chao <chao.gao@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v2 0/2] Fix a regression with hugetlbfs for shared memory in
 CoCo VMs
Date: Thu, 23 Oct 2025 17:55:23 +0800
Message-ID: <20251023095526.48365-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
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

In CoCo VMs, although the hugepage for private memory is not supported yet, Users
can still specify hugetlbfs backend for shared memory. However, due to the
recent changes of ram-block-attributes, it triggers an assertion failure when
getting the block size because the page size of ram_block is different from the
host page size. This patch series fixes this regression and clean up the code to
unify the retrieval of block size.

Chenyi Qiang (2):
  ram-block-attributes: Avoid the overkill of shared memory with
    hugetlbfs backend
  ram-block-attributes: Unify the retrieval of the block size

 system/ram-block-attributes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

-- 
2.43.5



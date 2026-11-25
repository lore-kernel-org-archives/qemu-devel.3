Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30B606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nk5wTM5X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8d3-0003HT-0Z; Wed, 25 Nov 2026 03:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8cz-0003Gn-9R
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:21 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xW8cx-0003hS-0V
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795596319; x=1827132319;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BTXAqlh3DMfZ74VRU0uu5zp16p59E4748FW+X3MHtUE=;
 b=nk5wTM5XxsCmpEiqp2ClggF9tC2O3S/i9mxoZZCgLFKzXvJqgmOYbbLQ
 GInKMDxdrGLo48y4FD6iApu4DbrXw2IMEi/egO8HmeE/7zY8H3AHaN/VJ
 vH9hV2KoYi1q6t2HFVGo0D260nBFt5UmqClaN5mMZ0nEyJHNnA8SGI+gX
 v7pOKRVBEzebRMxgzqzvCE8xyzgtLIr50JUl2sL8QFMChifBbdeqiPiaW
 Bky5u5gZ+xHHLSFWoc8KEwiSi/Rfji29okT5tmK+/I785pNtPs72XCjOV
 ENv4PxMEnSYUgLicJqiRgluxbp40671g/Ov2xOM1G5lRETTTfTESFSevi w==;
X-CSE-ConnectionGUID: Q3tjhWQGTvysL8tTJ8MUUw==
X-CSE-MsgGUID: nB95Y+pwQVGi9vvPzbTAbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4481093"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4481093"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:27 -0800
X-CSE-ConnectionGUID: 35yzR9nTRYuOole5fjPdAQ==
X-CSE-MsgGUID: 9dQaaXjWSzmqsu2FlIzMdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12091446"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 00:41:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] Fix hostmem fd leaks on allocation failure
Date: Wed, 25 Nov 2026 16:41:05 +0800
Message-ID: <20261125084108.1849966-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series fixes a fd leak when initializing hostmem-memfd, hostmem-shm,
and hostmem-epc backends.

If memory_region_init_ram_from_fd() fails during allocation, the RAM
block doesn't take ownership of the fd. Since the cleanup path relies
on qemu_ram_free() to close the fd, and we don't hit that on this
failure path, the fd simply leaks.

Also, for memfd and shm, the dead fd stays untracked in the CPR
registry. If we try to recreate the backend later, QEMU will try to
reuse that stale fd number instead of opening a new one.

Fix this by deleting the CPR entry and closing the fd on the failure paths.

Thanks,
Zhenzhong


Zhenzhong Duan (3):
  hostmem-memfd: close fd and untrack CPR on failure
  hostmem-shm: close fd and untrack CPR on failure
  hostmem-epc: fix fd leak on allocation failure

 backends/hostmem-epc.c   | 10 ++++++++--
 backends/hostmem-memfd.c | 14 ++++++++++++--
 backends/hostmem-shm.c   | 15 ++++++++++++---
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE18E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 09:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNq8T-0006Z4-S9; Wed, 18 Dec 2024 04:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8S-0006YH-GK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:28 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tNq8P-0001m2-88
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734513265; x=1766049265;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KwXXJzMCRS5GwtSEsZeuB8+Dtclfj96cO6pi3g/yz4Q=;
 b=O7OSsioYSou5Xe1MPCnaiXleAy+qVeOet0ICom307316nXZV0Iyq/KQ/
 L53UfGcPwTNKEYANrxucgwofp0jN0xUHpDsnCyFIQzGB4A13IgCs7B0Ir
 Abjlo7nBd10npvCh4oJ2hscPkixZDuwY0VkevZiLNfnZ4f+WIBtppDhvE
 PdtbnRUnxwTz3dQNhUUUIJXdajyKH+D7jPnrT40sBOeE566IbI0qjMAj1
 80Bk6025EgCITEMKYTh+T4G5mzyq8d8OAAEEpdwDPCZUSAoCEsT/MyaQH
 gA00d226p8uWakSlXlGZsSTUih60IvdRuvPLBQiSkvFDvLd6/vvM90qn5 g==;
X-CSE-ConnectionGUID: efyjvocpQmezC7lXt0+7DQ==
X-CSE-MsgGUID: dCN2bDtNSrqyDIqd0RJrJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="38654620"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="38654620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 01:14:16 -0800
X-CSE-ConnectionGUID: yT7LsxflRU28iBM0+Kt4XA==
X-CSE-MsgGUID: Lzi8FpezTE6jfNrw3OF34w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="97659813"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa007.fm.intel.com with ESMTP; 18 Dec 2024 01:14:14 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, jason.zeng@intel.com,
 yichen.wang@bytedance.com
Subject: [PATCH 0/3] bugfixes for migration using compression methods
Date: Wed, 18 Dec 2024 17:14:10 +0800
Message-ID: <20241218091413.140396-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
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

This set of patches is used to fix the bugs of incorrect migration
memory data when compression is enabled.

The method to reproduce this bug is as follows
1. Run "stress-ng --class memory --all 1" in the source side, the
stress-ng tool comes from https://github.com/ColinIanKing/stress-ng.git

2. Enable the multifd compression methods and start migration
   e.g. migrate_set_parameter multifd-compression qpl

3. The guest kernel will crash automatically or crash at shutdown after
   the migration is complete

The root cause of the bugs and the solutions are described in detail in
the patch.

My verification method as follows
1. Start the VM and run the stess-ng test command on the source side.
2. Start the VM with "-S" parameter on the target side, it is
   used to pause the vCPUs after migration.
3. After the migration is successful, use the dump-guest-memory command
   to export the memory data of the source and target VMs respectively.
4. Use "cmp -l source_memory target_memory" to verify memory data.

Yuan Liu (3):
  multifd: bugfix for migration using compression methods
  multifd: bugfix for incorrect migration data with QPL compression
  multifd: bugfix for incorrect migration data with qatzip compression

 migration/multifd-nocomp.c | 3 +--
 migration/multifd-qatzip.c | 1 +
 migration/multifd-qpl.c    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0



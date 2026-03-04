Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C0DEFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqki-0005NL-Qq; Wed, 04 Mar 2026 13:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkf-0005MJ-NH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:18 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkc-0004QO-JN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648115; x=1804184115;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N0SHoLljF/MCoB389ZwqutDCaAw1GwpReyOAlqS5GW8=;
 b=TQwvdaZxyAzym8tUPfMvl5BL0NqvgqN02PHN4lvlL/f+J/34I9SFpySe
 zq95cT9RXZQ+iZ/ZdTW7BsXEnl8H5zrg1yX6WbQEqDwHx5aygKP+pVV5T
 qG/u8yIupYCewXcD92UqCm0Q5eUMTmRdOUQdwDXSAeWrrTu5r8NvOXBef
 WgXg3aokGzaGsQ22P7Klm4I1jS643fwZwN0mavhylx0yiOHuDuqtoqKVw
 1oYbVC37DWgUWnim8O6wqNMLUDMZDwMPUA2iequhbIqcAc6pDY6WjdRlX
 pcSRxGzqvRWGxtpU0MLmkpXbDipyFPESmMLTRQ2WF45tnLyb6cdFXWTgI g==;
X-CSE-ConnectionGUID: STWvSLWPS3WnLn872aX1MQ==
X-CSE-MsgGUID: VxESqifrTVOsRa2dlXhnqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909263"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909263"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:02 -0800
X-CSE-ConnectionGUID: g2Lg8O2sRgWzUlux0pcPqg==
X-CSE-MsgGUID: eb69BEjESYqikboFM3I7fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542758"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:01 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 00/13] target/i386: Misc PMU fixes and enabling
Date: Wed,  4 Mar 2026 10:06:59 -0800
Message-ID: <20260304180713.360471-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series contains a set of fixes, cleanups, and improvements in
target/i386 PMU: legacy PEBS, Topdown metrics, and generic MSR
handling.

The patches are grouped into a single series for review convenience.
Some of them are not tightly coupled and can be reviewed and applied
individually.

For example, the PEBS-related changes could be a separate series, and
the Topdown metrics patch could be separate.  However, they touch
closely related PMU and MSR code paths, and keeping them together here
makes review easier and helps avoid potential merge conflicts.

Patch series overview:
Patches 1-6: Miscellaneous PMU/MSR fixes and cleanups.
Patches 7-8, 11–12: Complete legacy PEBS support in QEMU.
Patches 9-10: Refactoring in preparation for pebs-fmt support.
Patch 13: Add Topdown metrics feature support.

The KVM patch series for Topdown metrics support:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t

Changes since v2:
- Add new patch 13/13 to support Topdown metrics.
- Separate the adjustment of maximum PMU counters to patch 4/13, in
  order not to bump PMU migration version_id twice.
- Re-base on top of most recent mainline QEMU: d8a9d97317d0
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR in patch 2/13.
- Do not support pebs-fmt=0.
- Fix the vmstate name of msr_ds_pebs.
- Misc fixes and cleanup.

Changes since v1:
- Add two new patches to clean up and refactor LBR format handling.
- Introduce a new pebs-fmt command-line option.
- Add a patch to avoid exposing PEBS capabilities when not enabled.
- Trivial fixes and cleanups.

v1: https://lore.kernel.org/qemu-devel/20260117011053.80723-1-zide.chen@intel.com/
v2: https://lore.kernel.org/qemu-devel/20260128231003.268981-1-zide.chen@intel.com/T/#t

Dapeng Mi (4):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSRs
  target/i386: Support full-width writes for perf counters
  target/i386: Add get/set/migrate support for legacy PEBS MSRs
  target/i386: Add Topdown metrics feature support

Zide Chen (9):
  target/i386: Disable unsupported BTS for guest
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Adjust maximum number of PMU counters
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls
  target/i386: Make some PEBS features user-visible
  target/i386: Clean up LBR format handling
  target/i386: Refactor LBR format handling
  target/i386: Add pebs-fmt CPU option
  target/i386: Clean up Intel Debug Store feature dependencies

 target/i386/cpu.c         | 140 ++++++++++++++++++++---------
 target/i386/cpu.h         |  42 ++++++---
 target/i386/kvm/kvm-cpu.c |   3 +
 target/i386/kvm/kvm.c     | 179 +++++++++++++++++++++++++++++++-------
 target/i386/machine.c     |  54 ++++++++++--
 5 files changed, 328 insertions(+), 90 deletions(-)

-- 
2.53.0



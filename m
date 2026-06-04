Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBFCD6E55
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyNo-0001Qk-5C; Wed, 03 Jun 2026 23:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNn-0001Qa-25
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:35 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNk-0007rh-Ka
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780542273; x=1812078273;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SsU12Cc1lmr58sWFD3Tq8cy68WtLDRSM/iuRPaEwHhI=;
 b=C7BunP7wIqMvGIkj5eFkffi3SE5rGrdXt0+rXlEF2FE8Se+Q/R/dcc1B
 /jAaFwUeCEzF5N9tjAfAPwFexlJA+lDP8VpDzipFhnB6eRJKCFWROt4f9
 ryNrpYlb8uZ6MNGOjV0zTdBmJ22P3ZrA0R/bjoNm5herL5MRsfUqmmsCp
 UnILm8cKrctsXdLdMp9O2rJg86rbcIilfh8J14bxwceMAJs3r6fIt9vsD
 f3H+qszrZRP1f+slIFtW2K12rklQwQVsSY6sIHqpoezQd9WANoukyPYtj
 EKptIZIV/ANq5M6BgyKrWN0G75AnS9mVyG2k6kjTo3wmLsPu1vYhgM0KI g==;
X-CSE-ConnectionGUID: iuDVMJobRxuQdfwruwvIfg==
X-CSE-MsgGUID: NOLluxtkSMqw2dDVrCPhpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399618"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="80399618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
X-CSE-ConnectionGUID: v8FxMUj5R66shtns7kjqFQ==
X-CSE-MsgGUID: MR5E26xSTHGPjHGYs66sqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="241915835"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:27 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 0/6] target/i386: Misc PMU fixes and enabling
Date: Wed,  3 Jun 2026 19:55:40 -0700
Message-ID: <20260604025546.19378-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
target/i386 PMU and MSR handling, including Topdown metrics support.

This version drops some patches that raised more questions in earlier
reviews in order to reduce scope and speed up review and integration.

Patch series overview:
Patches 1-5: Miscellaneous PMU/MSR fixes and cleanups.
Patch 6: Add Topdown metrics feature support.

The KVM patch series for Topdown metrics support:
https://lore.kernel.org/kvm/20260226230606.146532-1-zide.chen@intel.com/T/#t

Changes in v4:
- Drop PEBS-related patches to reduce scope and accelerate merging.
- Drop disbale BTS support patch.
- Reorder and renumber remaining patches (now 6 total).
- Add defensive assert in kvm_init_msrs() in patch 5.

Changes in v3:
- Add new patch 13/13 to support Topdown metrics.
- Separate the adjustment of maximum PMU counters to patch 4/13, in
  order not to bump PMU migration version_id twice.
- Re-base on top of most recent mainline QEMU: d8a9d97317d0
- Remove MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR in patch 2/13.
- Do not support pebs-fmt=0.
- Fix the vmstate name of msr_ds_pebs.
- Misc fixes and cleanup.

Changes in v2:
- Add two new patches to clean up and refactor LBR format handling.
- Introduce a new pebs-fmt command-line option.
- Add a patch to avoid exposing PEBS capabilities when not enabled.
- Trivial fixes and cleanups.

v3: https://lore.kernel.org/qemu-devel/20260304180713.360471-1-zide.chen@intel.com/
v2: https://lore.kernel.org/qemu-devel/20260128231003.268981-1-zide.chen@intel.com/
v1: https://lore.kernel.org/qemu-devel/20260117011053.80723-1-zide.chen@intel.com/

Dapeng Mi (3):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSRs
  target/i386: Support full-width writes for perf counters
  target/i386: Add Topdown metrics feature support

Zide Chen (3):
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Adjust maximum number of PMU counters
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls

 target/i386/cpu.c     |  11 ++--
 target/i386/cpu.h     |  17 +++--
 target/i386/kvm/kvm.c | 150 +++++++++++++++++++++++++++++++++---------
 target/i386/machine.c |  32 +++++++--
 4 files changed, 161 insertions(+), 49 deletions(-)

-- 
2.54.0



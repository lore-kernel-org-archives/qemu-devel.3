Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419DD46C0F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnB-0008Iz-5l; Wed, 28 Jan 2026 18:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEn9-0008GY-P0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:43 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEn6-0001ih-Np
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642261; x=1801178261;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gku6ATXVmNaAWbvDHzX9sEE21VzxY5sWy4J0/A/R56M=;
 b=DUoERo9f3HfJaflJySE5NGz9JUvfQXmBYy1Odw5cKuxBVqqpMVk2pzuY
 s709sfVn6e2A7X43+9+Yqzdj7A5qubTSQz6apVHCyLYH+KB1kkvGQFyT8
 dSr0ESEO695OPpVo39DSoieSEW5XUC74mLQBVKAkDX1XMpXUBlT0Ya6zL
 v3rfxpv2VcV7dHxYk3ZxTgBsX9Sb9sKZVHOtPW/zJF/KljkekKYu2kklF
 dEEdSQtypWtEghehx707tTqX4X+WKKb4iLzZ9UhaW5vx9BqaPfCAfSyKc
 5MeyMg3mVFgFxKeSdk/IXqZtsDmFW9HWpWB1bzyOV2geCWPE0p+CiwpMs w==;
X-CSE-ConnectionGUID: MAfpQUiUTduz8VUheFsWKA==
X-CSE-MsgGUID: y8pt9ssMQgWJqMYBHmpffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462307"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462307"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:37 -0800
X-CSE-ConnectionGUID: 0d9s5027QpCpyH0E/PDyLw==
X-CSE-MsgGUID: vkpbL/btRZGQR82jzvLBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001757"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:36 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 00/11] target/i386: Misc PMU, PEBS,
 and MSR fixes and improvements
Date: Wed, 28 Jan 2026 15:09:37 -0800
Message-ID: <20260128231003.268981-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
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
target/i386 related to PMU, legacy PEBS, and MSR handling.

The patches are grouped into a single series for review convenience.
Smoe of them are not tightly coupled and can be reviewed and applied
individually.

Technically, the PEBS-related changes could be split into a separate
series.  However, they touch closely related PMU and MSR code paths,
and keeping them together here makes review easier and helps avoid
potential merge conflicts.

Patch series overview:
Patches 1–5: Miscellaneous PMU/MSR fixes and cleanups.
Patches 8–9: Refactoring in preparation for pebs-fmt support.
Patches 6–7, 10–11: Complete legacy PEBS support in QEMU.

Changes since v1:
- Add two new patches to clean up and refactor LBR format handling.
- Introduce a new pebs-fmt command-line option.
- Add a patch to avoid exposing PEBS capabilities when not enabled.
- Trivial fixes and cleanups.

Dapeng Mi (3):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSR
  target/i386: Support full-width writes for perf counters
  target/i386: Save/Restore DS based PEBS specfic MSRs

Zide Chen (8):
  target/i386: Disable unsupported BTS for guest
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls
  target/i386: Make some PEBS features user-visible
  target/i386: Clean up LBR format handling
  target/i386: Refactor LBR format handling
  target/i386: Add pebs-fmt CPU option
  target/i386: Disable guest PEBS capability when not enabled

 target/i386/cpu.c         | 130 ++++++++++++++++++++----------
 target/i386/cpu.h         |  29 ++++++-
 target/i386/kvm/kvm-cpu.c |   3 +
 target/i386/kvm/kvm.c     | 163 +++++++++++++++++++++++++++++++-------
 target/i386/machine.c     |  35 ++++++--
 5 files changed, 281 insertions(+), 79 deletions(-)

-- 
2.52.0



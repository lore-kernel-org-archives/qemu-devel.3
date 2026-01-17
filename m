Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAFAC9830F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 01:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vguxK-0004oI-Q1; Fri, 16 Jan 2026 20:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vguxC-0004mV-1a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:14 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgux9-00077n-D8
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 20:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768612691; x=1800148691;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w7jOopBKAsOvzRXrsvabqYkwvIVcHNW6Lo4RVZLUNCw=;
 b=DBqn/9siW8n1zLpnuEVJJf2Vdu9FO+GA10O++XD8Bc2P0e9gtAqM13VY
 z77kfl0PPeXel6ol5El3/Tcj/mU+Te+NQmzc8RQ2lzcZs0Obrs0CGwdLZ
 8vN+YRBVTumuwAwDKjr4Jr18dxpkqvIWrIClkSe9qHmj9lqVTHGp6+qKq
 y5uU1Zw2AgCcT0wptJm9YkEXwX2O9iwYIYIU3gH9p3GDGoXUa5gxPyKLG
 ng/2kwutrgiPhXJ07Q54aE4E566+X6FwyN/F232Kvqr0J04Z7aiKRD2w/
 JMLpNkHDDlWbX5hK1TOGzA83O5mifPcOCLckyrJ5yLNIrTbUEMRjB3d1g Q==;
X-CSE-ConnectionGUID: nUO49pnPTv2iIK+ptce8rA==
X-CSE-MsgGUID: EXy4XWGDQq2f0R3LRe11EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69131145"
X-IronPort-AV: E=Sophos;i="6.21,232,1763452800"; d="scan'208";a="69131145"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:07 -0800
X-CSE-ConnectionGUID: GiPwZMx5TkueL1hlMkFzwg==
X-CSE-MsgGUID: OGVleIAPSyCX3IVDb2McVg==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 17:18:06 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: xiaoyao.li@intel.com, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 0/7] target/i386: Misc PMU, PEBS,
 and MSR fixes and improvements
Date: Fri, 16 Jan 2026 17:10:46 -0800
Message-ID: <20260117011053.80723-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zide.chen@intel.com;
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

This series contains a set of mostly independent fixes and small
improvements in target/i386 related to PMU, PEBS, and MSR handling.

The patches are grouped into a single series for review convenience;
they are not tightly coupled and can be applied individually.

Dapeng Mi (3):
  target/i386: Don't save/restore PERF_GLOBAL_OVF_CTRL MSR
  target/i386: Support full-width writes for perf counters
  target/i386: Save/Restore DS based PEBS specfic MSRs

Zide Chen (4):
  target/i386: Disable unsupported BTS for guest
  target/i386: Gate enable_pmu on kvm_enabled()
  target/i386: Make some PEBS features user-visible
  target/i386: Increase MSR_BUF_SIZE and split KVM_[GET/SET]_MSRS calls

 target/i386/cpu.c     |  15 ++--
 target/i386/cpu.h     |  20 +++++-
 target/i386/kvm/kvm.c | 162 +++++++++++++++++++++++++++++++++++-------
 target/i386/machine.c |  35 +++++++--
 4 files changed, 191 insertions(+), 41 deletions(-)

-- 
2.52.0



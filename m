Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E54D3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaQO-0001i1-NP; Thu, 11 Dec 2025 01:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQM-0001gg-CL
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:14 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQJ-00065P-PA
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435512; x=1796971512;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tsw5t+Ji+q9rUQAu29JiPo8AKxg5zcGSfYSkL5PtPKQ=;
 b=hzzYfLytTlK5LvAMVoMV2f3uESuCfpv7iUh5G48igDLKJVgrF55m9DQE
 zpaGS2YhbDzyCGqpx7qGinGquBrL2A1ktJd2KUw1uSrm10heT4QXDV3gY
 U0SRECdup7kP1jIMaIodFm9wOqRqt2yHmyrZrI8WJAlfYLbL2NCRTXlXF
 ydMLZg0sA7xP117F7BA1ZydlnxrArdBFsguU11YNoZxhbOVs+xveuZ6Xz
 Ni6wV4TZzYxMTR7XOw/mGx1B25CryS2KzIhDHJtutufdgsWS8KB+1bO1Q
 6mUZRZZzvKR7TQeOgAVf4vIPtqT6g7RadiJtXy99aCG68W5I56HOeH4Jc w==;
X-CSE-ConnectionGUID: tQkb7afpT+m46VYP/Lv9lQ==
X-CSE-MsgGUID: 3BQwYlRtQTiR6ACHszCNPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584415"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584415"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:09 -0800
X-CSE-ConnectionGUID: zjWLogr3R+ekPbc4O2nGaw==
X-CSE-MsgGUID: oeVQQGVCQqaN10bhDO6xag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196494885"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:05 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/9] i386/cpu: Support APX for KVM
Date: Thu, 11 Dec 2025 15:09:33 +0800
Message-Id: <20251211070942.3612547-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

Hi,

This series adds APX (Advanced Performance Extensions) support in QEMU
to enable APX in Guest based on KVM (RFC v1 [1]).

This series is based on CET v5:

https://lore.kernel.org/qemu-devel/20251211060801.3600039-1-zhao1.liu@intel.com/

And you can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/commits/i386-all-for-dmr-v2.1-12-10-2025

Compared with v1 [2], v2 adds:
 * HMP support ("print" & "info registers").
 * gdbstub support.

Thanks for your review!


Overview
========

Intel Advanced Performance Extensions (Intel APX) expands the Intel 64
instruction set architecture with access to more registers (16
additional general-purpose registers (GPRs) R16–R31) and adds various
new features that improve general-purpose performance. The extensions
are designed to provide efficient performance gains across a variety of
workloads without significantly increasing silicon area or power
consumption of the core.

APX spec link (rev.07) is:
https://cdrdv2.intel.com/v1/dl/getContent/861610

At QEMU side, the enabling work mainly includes three parts:

1. save/restore/migrate the xstate of APX.
   * APX xstate is a user xstate, but it reuses MPX xstate area in
     un-compacted XSAVE buffer.
   * To address this, QEMU will reject both APX and MPX if their CPUID
     feature bits are set at the same (in Patch 1).

2. add related CPUIDs support in feature words.

3. debug support, including HMP & gdbstub.


Change Log
==========

Changes sicne v1:
 * Expend current GPR array (CPUX86State.regs) to 32 elements instead of
   a new array.
 * HMP support ("print" & "info registers").
 * gdbstub support.

[1]: KVM RFC: https://lore.kernel.org/kvm/20251110180131.28264-1-chang.seok.bae@intel.com/
[2]: QEMU APX v1: https://lore.kernel.org/qemu-devel/20251118065817.835017-1-zhao1.liu@intel.com/

Thanks and Best Regards,
Zhao
---
Zhao Liu (6):
  i386/machine: Use VMSTATE_UINTTL_SUB_ARRAY for vmstate of
    CPUX86State.regs
  i386/gdbstub: Add APX support for gdbstub
  i386/cpu-dump: Dump entended GPRs for APX supported guest
  i386/monitor: Support EGPRs in hmp_print
  i386/cpu: Support APX CPUIDs
  i386/cpu: Mark APX xstate as migratable

Zide Chen (3):
  i386/cpu: Add APX EGPRs into xsave area
  i386/cpu: Cache EGPRs in CPUX86State
  i386/cpu: Add APX migration support

 configs/targets/x86_64-softmmu.mak |  2 +-
 gdb-xml/i386-64bit-apx.xml         | 26 +++++++++++
 include/migration/cpu.h            |  4 ++
 target/i386/cpu-dump.c             | 30 +++++++++++--
 target/i386/cpu.c                  | 68 ++++++++++++++++++++++++++++-
 target/i386/cpu.h                  | 48 +++++++++++++++++++--
 target/i386/gdbstub.c              | 69 +++++++++++++++++++++++++++++-
 target/i386/machine.c              | 27 +++++++++++-
 target/i386/monitor.c              | 16 +++++++
 target/i386/xsave_helper.c         | 16 +++++++
 10 files changed, 293 insertions(+), 13 deletions(-)
 create mode 100644 gdb-xml/i386-64bit-apx.xml

-- 
2.34.1



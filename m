Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F295CC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoE-0003E6-RK; Mon, 14 Apr 2025 10:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko5-0003Ch-H4; Mon, 14 Apr 2025 10:29:06 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko3-00064c-DK; Mon, 14 Apr 2025 10:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640943; x=1776176943;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Tkq5C7A+TylEhKr7ELqlYoPD6JH68FRFSyOsxjwL5Ak=;
 b=EBGkphLZYaFrwWl2OqMR3vaE5IM1Y6AX/LjuPJ8+TimhTLKrsU8FSS0N
 2ri+hB3ZuwgTO97WYxkA9VP44J03BkQmOyG86xNstJjuNt1hLd1g8MoOZ
 R68sjTfz2W65hSN6ClayHbMjGI8nriER+Fni+lErLl7yHNSD0x3vYfS8e
 h4+op06ltlLRaB32HYNTvFS4YVFeVHARkF3fG06tOUcDAOvxqTNgNVptr
 ZaLIFaUY4VyLopgmzXlO9zxKhqaXqm/Xht2UhnsdsIa/pLkIP4EwttNMY
 Rv9TyJH4/ITlfYNgL2mHlSc9swIXzvml8lsBoj2CHwC3dqV9z2aAcbnZn g==;
X-CSE-ConnectionGUID: 7A1R2LjeS4C5T8Fp0STTiQ==
X-CSE-MsgGUID: gLEzc4EXR56v0mxsbon7qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501824"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501824"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:28:57 -0700
X-CSE-ConnectionGUID: /KE91WqwSdCqk2EbMpfOxg==
X-CSE-MsgGUID: /x52C4R8Rw6IiGqTM7Pdiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606050"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:28:56 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/9] rust/hpet: Initial support for migration
Date: Mon, 14 Apr 2025 22:49:34 +0800
Message-Id: <20250414144943.1112885-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

Hi all,

This series add the *initial* support for HPET migration.

This is *initial* because the current migration implementation
introduces multiple *unsafe* callbacks (please refer Patch 8).

Before the vmstate builder, one possible cleanup approach is to wrap
callbacks in the vmstate binding using a method similar to the
vmstate_exist_fn macro.

However, this approach would also create a lot of repetitive code (since
vmstate has so many callbacks: pre_load, post_load, pre_save, post_save,
needed and dev_unplug_pending). Although it would be cleaner, it would
somewhat deviate from the path of the vmstate builder.

Therefore, firstly focus on completing the functionality of HPET, and
those current unsafe callbacks can at least clearly indicate the needed
functionality of vmstate. The next step is to consider refactoring
vmstate to move towards the vmstate builder direction.

Test this series with 3 migration cases:
 * q35 (Rust HPET) -> q35 (Rust HPET)
 * q35 (Rust HPET) -> q35 (C HPET)
 * q35 (C HPET) -> q35 (Rust HPET)

Thanks and Best Regards,
Zhao
---
Zhao Liu (9):
  rust/vmstate: Support field_exists check in vmstate_struct macro
  rust/vmstate: Support varray's num field wrapped in BqlCell
  rust/vmstate_test: Test varray with num field wrapped in BqlCell
  rust/vmstate_test: Fix typo in
    test_vmstate_macro_array_of_pointer_wrapped()
  rust/timer: Define NANOSECONDS_PER_SECOND binding as u64
  rust/hpet: convert num_timers to u8 type
  rust/hpet: convert HPETTimer index to u8 type
  rust/hpet: Support migration
  rust/hpet: Fix a clippy error

 docs/devel/rust.rst                  |   3 +-
 rust/hw/timer/hpet/src/hpet.rs       | 189 ++++++++++++++++++++++++---
 rust/qemu-api/src/assertions.rs      |  30 ++++-
 rust/qemu-api/src/cell.rs            |  23 ++++
 rust/qemu-api/src/timer.rs           |   2 +
 rust/qemu-api/src/vmstate.rs         |  67 +++++-----
 rust/qemu-api/tests/vmstate_tests.rs |  45 +++++--
 7 files changed, 294 insertions(+), 65 deletions(-)

-- 
2.34.1



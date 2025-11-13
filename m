Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED796CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPI-0004xh-0b; Wed, 12 Nov 2025 23:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOl-0004jQ-FI; Wed, 12 Nov 2025 23:57:38 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOi-0001c6-E0; Wed, 12 Nov 2025 23:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009848; x=1794545848;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z0jYZkVqhwfntwsjsHs2N/NJKGYapCAZFN4qvzCE/qg=;
 b=jc6hJAl2DAmr0W21Gey3wBiMcOPPP0tFjtBKUno2LMfC+PnWNPr8IY1Z
 bW17GNDKNVi7IjPekAXWlKo29SF5lENEqFM/eDteSYZ4M+WrcLCT8Ois1
 hbBG1qOZTE3UtAsN5r1oO2yvdByXDJKgKYDv2dA7FtTm+xPC55ZpbVIbV
 27y0JZRemomkhxB7eSnYInAdTnLdPiNxuWsjozqsO64nYusk+0okt2k75
 +VLUboCYEklSy8CXV2Nx66IIi2r+lO6481EaSSzhR+8P1Z8Dm4zaUoBTY
 Ysz4h1CEoYa5rN0VtkoUMYD378UQZx3V4QUkZ6My1daZ4qxSrnfs8HHiP w==;
X-CSE-ConnectionGUID: Vm9MuYMVSRiIsyxcZ0a+FQ==
X-CSE-MsgGUID: e7oahj/RRfGL0B61dm6SzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682056"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682056"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:23 -0800
X-CSE-ConnectionGUID: 6kMSflpcQ+i4F3zX7OZ3rQ==
X-CSE-MsgGUID: FiBZj2+ITAS/4yJM3aOM3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663220"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:20 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/22] rust/hpet: Move towards lockless IO, partly
Date: Thu, 13 Nov 2025 13:19:15 +0800
Message-Id: <20251113051937.4017675-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

This series tries to (partly) synchronize the lockless IO of the C HPET
to Rust HPET, and deploy Migratable<>/ToMigrationState to HPET.

It's "partly" because this series only uses Mutex<> to protect registers
and doesn't add SeqLock.

This series is based on master branch at the commit 9febfa94b69b ("Merge
tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging"). And
you can also find the code here:

https://gitlab.com/zhao.liu/qemu/-/tree/rust-hpet-refactor-v1-11-11-2025

Thanks for your review!


Overview
========

1. Replacing BqlRefCell<single register> with Mutex<HPETregisters>
------------------------------------------------------------------

In fact, the most part of this series is to convert
BqlCell<single register> to BqlRefCell<HPETRegisters>. The difference
between the two includes:
 * BqlCell<> is used for quick access but BqlRefCell<> would involve
   the reference with bigger scope.
 * BqlRefCell<> doesn't allow multiple borrowing, which requires to take
   care about lifetime management.
 * Placing all registers in HPETRegisters makes it more complex to
   justify reference lifetime.

However, once the conversion is complete, we only need to borrow
BqlRefCell<> once during MMIO read/write operations. This makes replacing
BqlRefCell<> with Mutex<> a straightforward way.

And to address BQL context issue during lockless IO (like commit
d99041a20328 ("hpet: guard IRQ handling with BQL")), this series
introduce BqlGuard to provide BQL context by hand.

But there's "difference": Rust HPET has stronger BQL guarantees and it
uses BqlCell<> and BqlRefCell<> for many fields of HPETState, so that
Rust HPET needs to provide BQL context for more cases that C HPET (which
just guards IRQ handling). More details, please review Patch 22.


2. Leverage Migartable<> and ToMigrationState
---------------------------------------------

This series uses Migratable<> twice:
 * Patch 20 applies Migratable<> for BqlRefCell<>.
 * Patch 21 applies Migratable<> for Mutex<>.

Migrable<> and ToMigrationState work well at the above cases.

But there's one thing still missing (I just remember this when I'm writng
this cover letter):
 * ToMigrationState for Timer

The timer's ToMigrationState would be added in v2 or in a seperate
patch.


Open Question
=============

I'm still a bit unsure - can we provide a property option to control
whether ToMigrationState automatically generates VMState, for simple
case without version/subsection consideration?

In this series, I implemented VMState for HPETTimerRegistersMigration
and HPETRegistersMigration by hand. But doing such thing by hand for the
generated struts seems not natural enough.


Thanks and Best Regards,
Zhao
---
Zhao Liu (22):
  rust/migration: Add Sync implementation for Migratable<>
  rust/migration: Fix missing name in the VMSD of Migratable<>
  rust/migration: Check name field in VMStateDescriptionBuilder
  rust/bql: Add BqlGuard to provide BQL context
  rust/bql: Ensure BQL locked early at BqlRefCell borrowing
  rust/memory: Add enable_lockless_io binding
  rust/hpet: Reduce unnecessary mutable self argument
  rust/hpet: Rename HPETRegister to DecodedRegister
  rust/hpet: Rename decoded "reg" enumeration to "target"
  rust/hpet: Abstract HPETTimerRegisters struct
  rust/hpet: Make timer register accessors as methods of
    HPETTimerRegisters
  rust/hpet: Abstract HPETRegisters struct
  rust/hpet: Make global register accessors as methods of HPETRegisters
  rust/hpet: Borrow HPETState.regs once in HPETState::post_load()
  rust/hpet: Explicitly initialize complex fields in init()
  rust/hpet: Pass &BqlRefCell<HPETRegisters> as argument during MMIO
    access
  rust/hpet: Maintain HPETTimerRegisters in HPETRegisters
  rust/hpet: Borrow BqlRefCell<HPETRegisters> at top level
  rust/hpet: Rename hpet_regs variables to regs
  rust/hpet: Apply Migratable<> wrapper and ToMigrationState for
    HPETRegisters
  rust/hpet: Replace BqlRefCell<HPETRegisters> with Mutex<HPETRegisters>
  rust/hpet: Enable lockless IO

 include/qemu/main-loop.h         |  22 +-
 rust/bql/src/cell.rs             |  16 +-
 rust/bql/src/lib.rs              | 101 ++++-
 rust/hw/timer/hpet/src/device.rs | 638 +++++++++++++++++++------------
 rust/migration/src/migratable.rs |   7 +
 rust/migration/src/vmstate.rs    |  15 +-
 rust/system/src/memory.rs        |  15 +-
 stubs/iothread-lock.c            |  11 +
 system/cpus.c                    |  10 +
 9 files changed, 583 insertions(+), 252 deletions(-)

-- 
2.34.1



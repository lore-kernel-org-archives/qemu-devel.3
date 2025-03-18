Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAACFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWHT-00088b-5Z; Tue, 18 Mar 2025 08:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWGz-0007oT-JB; Tue, 18 Mar 2025 08:42:27 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuWGr-0002wP-RZ; Tue, 18 Mar 2025 08:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301734; x=1773837734;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4d9ubvjBKtJnXxx5Pf4CLDwpYdsXtVVs3mHKgRh7YZM=;
 b=WY5v5xh1mk6znm1Y3sP3ofG/qgihLX6LedjM070eHCCjUVK2elr0TX2G
 1RNqLh0mNJPRMeX6XEv94ki7zzs9P3nNc8tg5wQvU0Mz/zXtPOtvLu7zN
 s2HXWeqxj2Nmee0s46g5/9ILvLywQdf97bhH52Fk9+j2b29OAt/9+OI07
 K2OrhkhhApP4HvTbsLoyCRkrc16vNopU6OUessHcnNandRypI+Tfrfx0u
 /DB7W0rsfEFTfdT1nyS4ei2luq1f1+Js0F40ddLOhBmqnwV1TedDKZNed
 NRDMqf2MOFQOQUWPeYHzijArxHk1VqmySV8t5YyuGUiwt82PjdjEqFvyC w==;
X-CSE-ConnectionGUID: Seo4XURyQfa7FMKjYfvsoQ==
X-CSE-MsgGUID: VFf2fGTLSICx7mi5ttme9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54824549"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54824549"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:42:08 -0700
X-CSE-ConnectionGUID: ULLgGLqeTJqaA5DVEHdX1w==
X-CSE-MsgGUID: GRs/FqpVS3Gu5VroIvBvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121980396"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 05:42:06 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 00/15] rust/vmstate: Clean up, fix, enhance & test
Date: Tue, 18 Mar 2025 21:02:04 +0800
Message-Id: <20250318130219.1799170-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

This is my v3, based on aa90f1161bb17 ("Merge tag 'migration-20250314-pull
-request' of https://gitlab.com/farosas/qemu into staging") at master
branch.

Compared with v2:
 * the patch 10 drops `with_exist_check()` and `with_validate_flag()`.
 * patch 15 is newly added to clen up VMStateFlags in vmstate_clock
   (which is inspired by setting flags in vmstate_validate).


Patch Summary
=============

Patch 1-9: Clean up & fix for vmstate_of & vmstate_struct, where the
           issues are catched by unit tests.

Patch 10: Add vmstate_validate support, and vmstate_validate can accept
          safe "test" callback.

Patch 11-14: Add unit test to cover as much as possible cases to be
             compatible with C version macros.

             * Note while in principle Rust's vmstate pattern doesn't
               have to match the C version, the C vmstate macros are
               rich enough to cover as much logic as possible. So
               checking against the C version is the most effective way
               to detect the error.


Change Log
==========

Changes since v2:
 * Drop `with_exist_check()` and `with_validate_flag()`.
 * Clean up incomplete crate path of VMStateFlags in vmstate_clock.

Changes since v1:
 * Drop the patch about prefix separator ", " before [0 .. num] in
   vmstate macros.
 * Drop the pacth which changed "vmsd" to "ident" type in macros.
 * Drop the pacth about adding "version" argument.
 * Add a `with_exist_check()` method to help add callback in future.
 * Drop addr_of & public VMStateFlags API in unit test.
 * Clean up TODO comment.

Best Regards,
Zhao
---
Zhao Liu (15):
  rust/vmstate: Remove unnecessary unsafe
  rust/vmstate: Fix num_offset in vmstate macros
  rust/vmstate: Fix num field when varray flags are set
  rust/vmstate: Fix size field of VMStateField with VMS_ARRAY_OF_POINTER
    flag
  rust/vmstate: Fix type check for varray in vmstate_struct
  rust/vmstate: Fix "cannot infer type" error in vmstate_struct
  rust/vmstate: Fix unnecessary VMState bound of with_varray_flag()
  rust/vmstate: Relax array check when build varray in vmstate_struct
  rust/vmstate: Re-implement VMState trait for timer binding
  rust/vmstate: Support vmstate_validate
  rust/vmstate: Add unit test for vmstate_of macro
  rust/vmstate: Add unit test for vmstate_{of|struct} macro
  rust/vmstate: Add unit test for pointer case
  rust/vmstate: Add unit test for vmstate_validate
  rust/vmstate: Include complete crate path of VMStateFlags in
    vmstate_clock

 rust/hw/char/pl011/src/device_class.rs |   8 +-
 rust/qemu-api/meson.build              |   5 +-
 rust/qemu-api/src/assertions.rs        |  15 +
 rust/qemu-api/src/vmstate.rs           | 100 ++++--
 rust/qemu-api/tests/tests.rs           |   2 +
 rust/qemu-api/tests/vmstate_tests.rs   | 447 +++++++++++++++++++++++++
 6 files changed, 554 insertions(+), 23 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs

-- 
2.34.1



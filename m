Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C77C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 08:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuS4Q-0002jJ-SJ; Tue, 18 Mar 2025 04:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4C-0002ht-VF; Tue, 18 Mar 2025 04:12:53 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuS4A-0001JW-1Z; Tue, 18 Mar 2025 04:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742285570; x=1773821570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vQ22IbeqGqgEuiOA8Ibr+hZ1zuP30vfgWZrjHFcXJGI=;
 b=AswWfbKRiVmhtVJIBR1TOssrnGYek81sfVWpAa0kTAsPyy1O9jGHmHc4
 gr5gU6cTbzS0g/nB7ilec2xmWKel8TP2ThZGlajR4U3AvND0MsZIOt+21
 gArEw3tJzEw8kTdHu8enwlDm7TtMEVLrElpf+E+7Bmu9EUCaKL83tX25Y
 +aYTKQqJ2j3UGgKws8I2lXYnDeBhdO47Kpmz3KgCQynSTDd2fkTupoSyi
 X7Xqii0HML04aaxDQiCTGg8CuODk/1UEOmou/g06wA3zeDHQIEx3mJ9/A
 apqIQya3M9m/TvVrnGk3A/rdaGwrqZJGIkk3ZTqo5/Z27yikcNouW7Wwd g==;
X-CSE-ConnectionGUID: KQ+enW0XShGZnEEYqqCf/A==
X-CSE-MsgGUID: rQdVXS6gRv6HQz4n4nOYdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53621535"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="53621535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 01:12:44 -0700
X-CSE-ConnectionGUID: 4AqzYwhuQ1+TuPquUja+Ow==
X-CSE-MsgGUID: Jcr6P0bYR7OJaqoKWta5uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="127363181"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 18 Mar 2025 01:12:42 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 00/14] rust/vmstate: Clean up, fix, enhance & test
Date: Tue, 18 Mar 2025 16:32:34 +0800
Message-Id: <20250318083248.1402990-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

Hi,

This series is in preparation for HPET migration support (in particular,
to support varray and vmstate_validate), and it also cleans up and fixes
the current vmstate. 


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
Zhao Liu (14):
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

 rust/qemu-api/meson.build            |   5 +-
 rust/qemu-api/src/assertions.rs      |  15 +
 rust/qemu-api/src/vmstate.rs         | 115 +++++--
 rust/qemu-api/tests/tests.rs         |   2 +
 rust/qemu-api/tests/vmstate_tests.rs | 447 +++++++++++++++++++++++++++
 5 files changed, 564 insertions(+), 20 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs

-- 
2.34.1



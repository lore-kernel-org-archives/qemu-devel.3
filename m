Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C9C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBq2-0004wC-7Y; Mon, 17 Mar 2025 10:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpZ-0004t3-Ly; Mon, 17 Mar 2025 10:52:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuBpT-00061l-7L; Mon, 17 Mar 2025 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742223155; x=1773759155;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tr9KXqWXTFbi+fhP6Oqcqc/5/iFNVmNQtrnI2XO+0QE=;
 b=WfreJ6JTxWNKWDFD/dVjNuWIjowUS9NRsPuhKWSnPOcEO0k5735vYGmr
 mnYrvMOdNPGO9NAyECzCZiFwzA6PFknjSrMJi7DKbGNXh9aLhInsfCnoj
 rcBQMuFvhLJWTt35zCL2e514yN1D+Xu4qiAqP92RU7AiVQJQk2awS6MBt
 9f3WuszC9kzI8Ajz8usiEK4Vetef89ZhkAMSfBX6SsfF3Sv6Tsr4vZ2BI
 sFx0dSsdcJkNOzd4hAoeII9xKpjha+Gna0uLaId9xkGpP5+dIAnyuFVUq
 dd/Xo+dedo4amRBghtdR+Azm3Z6M/JB6jTWUBhUr12DPyE6MHmlo66qd/ g==;
X-CSE-ConnectionGUID: xubZBg+yT0C03h+kayCp+w==
X-CSE-MsgGUID: KpKk+xdwQHuct3ArwJSoRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54694583"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="54694583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 07:52:27 -0700
X-CSE-ConnectionGUID: bh1SWcCnR++hngrhq54BFA==
X-CSE-MsgGUID: paUMgtstT8KPwKrHNYLabA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; d="scan'208";a="126988480"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 17 Mar 2025 07:52:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/17] rust/vmstate: Clean up, fix, enhance & test
Date: Mon, 17 Mar 2025 23:12:19 +0800
Message-Id: <20250317151236.536673-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
the current vmstate! However, there is still the gap from being a ‘stable’
vmstate.


Patch Summary
=============

Patch 1-11: Clean up & fix for vmstate_of & vmstate_struct, where the
            issues are catched by unit tests.

Patch 12,13: Add versioned vmstate and vmstate_validate support, and
             vmstate_validate can accept safe "test" callback.

Patch 13-17: Add unit test to cover as much as possible cases to be
             compatible with C version macros.

             * Note while in principle Rust's vmstate pattern doesn't
               have to match the C version, the C vmstate macros are
               rich enough to cover as much logic as possible. So
               checking against the C version is the most effective way
               to detect the error.

With unit tests, the 2 vmstate gaps that come to mind right now are:

 * `test` parameter in vmstate_of/vmstate_struct. I think there's not
   too much difficulty, since referring to vmstate_validate makes it
   straightforward...

 * pointer to `struct`. assert_field_type() can't aware a inner type of
   the pointer. We may need another trait (different from
   impl_vmstate_pointer). Or, we may need to use the new
   vmstate_struct_ptr macro. But I haven't tried it in details yet.


Thoughts about 'stable' vmstate
===============================

To make vmstate 'stable', I think one key point is to make vmstate
related things accept "safe" callbacks.

vmstate_validate (and future `test` parameters) has achieved this. But
VMStateDescription hasn't and it has the following callbacks:
    int (*pre_load)(void *opaque);
    int (*post_load)(void *opaque, int version_id);
    int (*pre_save)(void *opaque);
    int (*post_save)(void *opaque);
    bool (*needed)(void *opaque);
    bool (*dev_unplug_pending)(void *opaque);

I find there would be 2 options to address this:

1. introduce macros (like vmstate_validate) to accept "safe" callback.
   For example,

static VMSTATE_HPET: VMStateDescription = VMStateDescription {
    name: c_str!("hpet").as_ptr(),
    version_id: 2,
    minimum_version_id: 1,
    pre_save: pre_save!(hpet_pre_save), // the pre_save macro will convert "safe" hpet_pre_save() to C style callback.
    post_load: post_load!(hpet_post_load), // ditto
    fields: vmstate_fields! {
        vmstate_of!(HPETState, config),
        vmstate_of!(HPETState, int_status),
        vmstate_of!(HPETState, counter),
        vmstate_of!(HPETState, num_timers, version = 2),
        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
        vmstate_struct!(HPETState, timers, [0 .. num_timers], VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, version = 0),
    },
    subsections: vmstate_subsections! {
        VMSTATE_HPET_RTC_IRQ_LEVEL,
        VMSTATE_HPET_OFFSET,
    },
    ..Zeroable::ZERO
};

2. introduce VMStateDescriptionBuilder (like MemoryRegionOpsBuilder) and
   use the call chain to accept callbacks and initialize VMStateField.


About these 2 options, which one do you like?


Best Regards,
Zhao
---
Zhao Liu (17):
  rust/vmstate: Remove unnecessary unsafe
  rust/vmstate: Fix num_offset in vmstate macros
  rust/vmstate: Add a prefix separator ", " for the array field in
    vmstate macros
  rust/vmstate: Use ident instead of expr to parse vmsd in
    vmstate_struct macro
  rust/vmstate: Fix num field when varray flags are set
  rust/vmstate: Fix size field of VMStateField with VMS_ARRAY_OF_POINTER
    flag
  rust/vmstate: Fix type check for varray in vmstate_struct
  rust/vmstate: Fix "cannot infer type" error in vmstate_struct
  rust/vmstate: Fix unnecessary VMState bound of with_varray_flag()
  rust/vmstate: Relax array check when build varray in vmstate_struct
  rust/vmstate: Re-implement VMState trait for timer binding
  rust/vmstate: Support version field in vmstate macros
  rust/vmstate: Support vmstate_validate
  rust/vmstate: Add unit test for vmstate_of macro
  rust/vmstate: Add unit test for vmstate_{of|struct} macro
  rust/vmstate: Add unit test for pointer case
  rust/vmstate: Add unit test for vmstate_validate

 rust/hw/char/pl011/src/device_class.rs |   2 +-
 rust/qemu-api/meson.build              |   5 +-
 rust/qemu-api/src/assertions.rs        |  15 +
 rust/qemu-api/src/vmstate.rs           | 110 ++++--
 rust/qemu-api/tests/tests.rs           |   2 +
 rust/qemu-api/tests/vmstate_tests.rs   | 467 +++++++++++++++++++++++++
 6 files changed, 575 insertions(+), 26 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs

-- 
2.34.1



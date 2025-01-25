Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44874C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLD-0008G5-LA; Sat, 25 Jan 2025 07:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKy-0008BN-EE; Sat, 25 Jan 2025 07:32:34 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKu-0005Sx-FU; Sat, 25 Jan 2025 07:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808348; x=1769344348;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Vw3DPDk7yXG96ajtH5APT+Gn4anrRg7yp4EIgT40gLc=;
 b=fqVhOnhmyXrUp4BMglywQTy/SeIuv1jBSdRWTXBgomK7lH2sN21n/Eus
 BhWcixZj2GB/P0YaiO+hRe3o87Tou4fdLsax4iG9Uz5ogOX7zl+KG4CWg
 3FDxtSVzsrGcAs0zjACdnmXb/uSW+ubjAtisf/1YWDGlIlWdFcWXxocNb
 pAF9vD/tMj8+gYdg9wO3Rp7XCGke8LI2JrZ4abN9NASYaziwboSBt/Vq2
 kecjO3I9CsvvX7kORxAYwV4EFZLpUaSZbauwSDXDJfbM96D0T+h4c/fkT
 lmsMnk60Xb1OW+tnZmnNTAfoatXKflXU8mbMyixSDVnzlmU9Po8fUhviL Q==;
X-CSE-ConnectionGUID: IDCvDUYcSaOpO73pJZcUeg==
X-CSE-MsgGUID: cXEz84CxSZiPK1e5HfSCtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434691"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434691"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:24 -0800
X-CSE-ConnectionGUID: DTEv25hJTv6qgPK6L6o7dQ==
X-CSE-MsgGUID: Q4o5AbouRgaGGdCI1o76IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897634"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:21 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 00/10] rust: Add HPET timer device
Date: Sat, 25 Jan 2025 20:51:27 +0800
Message-Id: <20250125125137.1223277-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi folks,

This is Rust HPET normal patch series, and you can find the previous RFC
at [1].

This series is based on Paolo's rust-next branch at the commit
441f501bc611 ("rust: bindings for MemoryRegionOps") along with 2
seperate patches:

* https://lore.kernel.org/qemu-devel/20241205203721.347233-1-pbonzini@redhat.com/
* https://lore.kernel.org/qemu-devel/20250121140121.84550-1-zhao1.liu@intel.com/

Overall, HPET in Rust maintains the same logic as the original C
version, adhering to the Intel IA PC-HPET spec v1.0a [2]. While keeping
the logic unchanged, it attempts to keep up with the current development
progress of Rust for QEMU, leveraging the latest and ongoing Rust binding
updates as much as possible, such as BqlCell / BqlRefCell, qom & qdev
enhancements, irq binding, and more.

*** This series further utilizes bitops, callback, memory, and Resettable
bindings compared to the RFC. ***

Additionally, it introduces new bindings, including gpio_{in|out},
memattrs, and timer.

What surprised me was that while working on this version of the patch, I
clearly felt the improvements in Rust QOM and QAPI. They are much more
user-friendly in many ways. :-) Almost everything related with API has
been simplified a lot!

(At the end of this cover letter, I briefly talked about my thoughts as
I was once again faced with the choice between BqlCell and BqlRefCell.)


Welcome your comments and feedback!


Introduction
============

.
│ 
...
└── timer
    ├── hpet
    │   ├── Cargo.toml
    │   ├── meson.build
    │   └── src
    │       ├── fw_cfg.rs
    │       ├── hpet.rs
    │       ├── lib.rs
    ├── Kconfig
    └── meson.build


HPET emulation contains 2 parts:
 * HPET device emulation:
   - hpet.rs:
     It includes basic operations for the HPET timer and HPET state
     (which actually represents the HPET timer block).

     Here, similar to the C implementation, it directly defines the
     registers and bit shifts as const variables, without a complete
     register space structure.

     And, it implements various QEMU qdev/qom required traits for the
     HPETState.

 * Global HPET firmwrie configuration:
   - fw_cfg.rs
     In the C code, there is a variable hpet_fw_cfg (old name: hpet_cfg)
     used to configure the number of HPET timer blocks and the basic
     HPET firmware configuration. It is defined in .c file and is
     referenced as extern in the .h file.

     For the Rust HPET, fw_cfg.rs also implementes hpet_fw_cfg so that
     the .h file can still reference it.


Next Work
=========

* vmstate support.
  - Utilize the recent vmstate improvement.


Additional Experience
=====================

PL011 provides a pattern to group all registers in one BqlRefCell
instead of multiple BqlCells.

I also tried to leverage this design to HPET, but it didn't fit very
well with this issue:
 * HPETState abstracts many helpers to check register bit and tell
   caller about the state, e.g., is_legacy_mode(),
   is_timer_int_active(), etc.
   
   But this also means these helpers can't be used in BqlRefCell::
   borrow_mut() context again, otherwise, they would cause the runtime
   bql check panic.

 - Some cases are easy to fix, i.e, use borrow_mut to modify the
   registers after the helpers' call.

 - Some cases would by tricky, like memory write callback, since it has
   complex logic and it's hard to decouple register changes from the
   reset logic as clearly as PL011 does. 

   The fix for this case is either to avoid using register helpers
   again in the borrow_mut context of write(), or to use BqlCell
   instead of BqlRefCell to get finer-grained access control to avoid
   refactoring code logic.

   I chose the latter.


So I think this might be a practical lesson that the choice of BqlCell
and BqlRefCell is also indeed related to code logic: If the code logic
is too complex to decouple borrow() and borrow_mut() (and the compiler
doesn't check this, only the runtime's panic_already_borrowed() will
complains!) , then BqlCell should be chosen. Because fine-grained access
is easier to control and avoid errors. :-)

[1]: https://lore.kernel.org/qemu-devel/20241205060714.256270-1-zhao1.liu@intel.com/
[2]: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/software-developers-hpet-spec-1-0a.pdf

Thanks and Best Rgards,
Zhao
---
Zhao Liu (10):
  i386/fw_cfg: move hpet_cfg definition to hpet.c
  rust/qdev: add the macro to define bit property
  rust/irq: Add a helper to convert [InterruptSource] to [*mut IRQState]
  rust: add bindings for gpio_{in|out} initialization
  rust: add bindings for memattrs
  rust: add bindings for timer
  rust/timer/hpet: define hpet_cfg
  rust/timer/hpet: add basic HPET timer and HPETState
  rust/timer/hpet: add qom and qdev APIs support
  i386: enable rust hpet for pc when rust is enabled

 configs/devices/i386-softmmu/default.mak |   1 +
 hw/i386/fw_cfg.c                         |   6 +-
 hw/i386/pc.c                             |   2 +-
 hw/timer/Kconfig                         |   6 +-
 hw/timer/hpet.c                          |  14 +-
 include/hw/timer/hpet.h                  |   2 +-
 meson.build                              |   7 +
 rust/Cargo.lock                          |   8 +
 rust/Cargo.toml                          |   1 +
 rust/hw/Kconfig                          |   1 +
 rust/hw/meson.build                      |   1 +
 rust/hw/timer/Kconfig                    |   2 +
 rust/hw/timer/hpet/Cargo.toml            |  14 +
 rust/hw/timer/hpet/meson.build           |  18 +
 rust/hw/timer/hpet/src/fw_cfg.rs         |  85 +++
 rust/hw/timer/hpet/src/hpet.rs           | 900 +++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs            |  18 +
 rust/hw/timer/meson.build                |   1 +
 rust/qemu-api/meson.build                |   1 +
 rust/qemu-api/src/irq.rs                 |  18 +-
 rust/qemu-api/src/lib.rs                 |   1 +
 rust/qemu-api/src/memory.rs              |  16 +-
 rust/qemu-api/src/qdev.rs                |  49 +-
 rust/qemu-api/src/timer.rs               |  92 +++
 rust/qemu-api/src/zeroable.rs            |   7 +-
 rust/wrapper.h                           |   3 +
 tests/qtest/meson.build                  |   3 +-
 27 files changed, 1252 insertions(+), 25 deletions(-)
 create mode 100644 rust/hw/timer/Kconfig
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/hpet.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/meson.build
 create mode 100644 rust/qemu-api/src/timer.rs

-- 
2.34.1



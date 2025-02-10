Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6575FC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJjq-00005r-FV; Sun, 09 Feb 2025 21:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjn-000052-QH; Sun, 09 Feb 2025 21:41:32 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjl-00087T-Ee; Sun, 09 Feb 2025 21:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155289; x=1770691289;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Bhvn9P3OVdK6MCLTZFEyCeNu+b6OtofVuWnjBFpu38=;
 b=it1Yp1PkaXr28Um2m8uF3BCcIQUGVHeV2QVhS64y8O+9eyPM0ly0efVh
 JtPe/P9SyRr0XurXtV3HGtesIsR/vkY3Atl0zCntZLLTEWAuNhuXHQ6Qx
 HRCnt2IyorhK1uTgy/Bc6dMMWyukTdMKlUyHrjJieDGCqnxAliHASU1Vp
 grgTDVoEtrb+U6GUzzcQLN8uOkJFOaqZ2xthUoClNJ0flERfncTI6bR0H
 bPqMsLMIoh0kTUXBjuq/6iXojvk2OdsLxFomukPVUvoEl+d2LW9/T0K7p
 HgH4UsqekyEMRV1NOoYki2Q+ocg5bl2Ymc8TFWLzmm8JreVPMJkjQdpQb w==;
X-CSE-ConnectionGUID: j+JpRMh/Qiethoaf5n6o4g==
X-CSE-MsgGUID: QozZ+gjIQZS8L2nIpwdQvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351228"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:24 -0800
X-CSE-ConnectionGUID: 0Y7EAuuKRgyaXdUkLfx0tg==
X-CSE-MsgGUID: zMS077icQmSTix4iFrcgWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938194"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:21 -0800
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
Subject: [PATCH v2 00/10] rust: Add HPET timer device
Date: Mon, 10 Feb 2025 11:00:41 +0800
Message-Id: <20250210030051.2562726-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

Hi folks,

This is Rust HPET normal patch series, and you can find the previous RFC
at [1].

This series is based on Paolo's rust-next branch at the commit
43c0ef3bfb3b ("rust: vmstate: remove redundant link targets") along with
another 2 more seperate patches:

* https://lore.kernel.org/qemu-devel/20241205203721.347233-1-pbonzini@redhat.com/
* https://lore.kernel.org/qemu-devel/20250121140121.84550-1-zhao1.liu@intel.com/

Overall, HPET in Rust maintains the same logic as the original C
version, adhering to the Intel IA PC-HPET spec v1.0a [2]. While keeping
the logic unchanged, it attempts to keep up with the current development
progress of Rust for QEMU, leveraging the latest and ongoing Rust binding
updates as much as possible, such as BqlCell / BqlRefCell, qom & qdev
enhancements, irq binding, and more.

Additionally, it introduces new bindings, including gpio_{in|out},
memattrs, and timer.

Welcome your comments and feedback!


TODOs
=====

* Add more documentations for new bindings and HPET.
* Live migration support for HPET.
* address-spaces binding (for address_space_memory, address_space_stl_le).


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


Change Log
==========

Main changes since Patch v1:
 * Reimplement InterruptSource::slice_as_ptr() by dereferring `slice[0]`.
 * Ensure the callback parameter of input GPIO/timer is not none.
 * Use Timer/TimerListGroup in Rust code instead of QEMUTimer/
   QEMUTimerListGroup.
 * Add MS/US/NS wrappers.
 * Enable workspace's lint configurations in hpet's Cargo.toml.
 * Add rust_version in Cargo.toml.
 * Fix complaints from cargo (+nightly) doc/clippy/fmt (v1.84.0).
 * Do `addr & !4` in timer's register read and write.
 * Mask the timer N's register address with 0x1F (timer_and_addr()).
 * Drop HPETClass.
 * Fix a memory leak issue by not destroying the timer instance in
   HPETTimer::del_timer().


[1]: https://lore.kernel.org/qemu-devel/20250125125137.1223277-1-zhao1.liu@intel.com/
[2]: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/software-developers-hpet-spec-1-0a.pdf

Thanks and Best Rgards,
Zhao
---
Zhao Liu (10):
  i386/fw_cfg: move hpet_cfg definition to hpet.c
  rust/qdev: add the macro to define bit property
  rust/irq: Add a helper to convert [InterruptSource] to pointer
  rust: add bindings for gpio_{in|out} initialization
  rust: add bindings for memattrs
  rust: add bindings for timer
  rust/timer/hpet: define hpet_fw_cfg
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
 rust/hw/timer/hpet/Cargo.toml            |  18 +
 rust/hw/timer/hpet/meson.build           |  18 +
 rust/hw/timer/hpet/src/fw_cfg.rs         |  78 ++
 rust/hw/timer/hpet/src/hpet.rs           | 890 +++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs            |  18 +
 rust/hw/timer/meson.build                |   1 +
 rust/qemu-api/meson.build                |   1 +
 rust/qemu-api/src/irq.rs                 |   5 +
 rust/qemu-api/src/lib.rs                 |   1 +
 rust/qemu-api/src/memory.rs              |  16 +-
 rust/qemu-api/src/qdev.rs                |  59 +-
 rust/qemu-api/src/timer.rs               |  98 +++
 rust/qemu-api/src/zeroable.rs            |   7 +-
 rust/wrapper.h                           |   3 +
 tests/qtest/meson.build                  |   3 +-
 27 files changed, 1245 insertions(+), 22 deletions(-)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A57DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4jr-00069w-Vf; Thu, 05 Dec 2024 00:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jp-00069b-Ng; Thu, 05 Dec 2024 00:49:22 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jm-000770-Um; Thu, 05 Dec 2024 00:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377759; x=1764913759;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VhzUZ6jZBgqnxewvepsdwueTg63rvFqQCjdd3/pH/jk=;
 b=Gq05RCWWA3bXfRxIOKtq3vNnSfxMd3JSHpKJiyrRcHymmWrPPZ53EGLr
 J1jB2camQ7oi7/MI43GaEOOcfab5lsXWg+z9Aiyfv+4aFkQebf/tbEFjC
 qImrd5cdsprwtzmIFKGsBjeQ1rgWMA1aBuYXIFAY8CVa0a1/j3aphs6ii
 2SniQn9oMqDYrvCM9JW4Ui8X4WIK0JmCnm1ZsegaJzOQgDx5oBbZzsAwR
 XOvUKB+aUF9cYWTTZJwNqxc/3mq6c8LH6swPMZHcCkaD5SPpO8yW2nhjZ
 HX51brRuy3iLUsAWIzhDvl476ZWs+G1ETvScda9l0GNYehFMXZ4SjRL1L Q==;
X-CSE-ConnectionGUID: O+IU/rxvT7GPPMt25PXkTw==
X-CSE-MsgGUID: +81MkhraTyaaLSCePGURpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815593"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:14 -0800
X-CSE-ConnectionGUID: 0XBqSQZJQFKadthVSyXY+A==
X-CSE-MsgGUID: KG+1qN0dSrONg6tJcGbavQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94454939"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:11 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 00/13] rust: Reinvent the wheel for HPET timer in Rust
Date: Thu,  5 Dec 2024 14:07:01 +0800
Message-Id: <20241205060714.256270-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

After making empty promises for many months, I have finally written the
Rust version of HPET :-) I'm also very grateful for the help from Paolo,
Manos, and Junjie!

Overall, HPET in Rust maintains the same logic as the original C
version, adhering to the IA-HPET spec v1.0a [1]. While keeping the logic
unchanged, it attempts to keep up with the current development progress
of Rust for QEMU, leveraging the latest and ongoing Rust binding updates
as much as possible, such as BqlCell / BqlRefCell, qom & qdev
enhancements, irq binding, and more. Additionally, it introduces new
bindings, including gpio_{in|out}, bitops, memattrs, and timer. Finally,
based on Paolo's suggestion, the vmstate part is temporarily on hold.

Welcome your comments and feedback!


(Next, I will introduce the structure of the code, the current gaps, and
share my verbose personal experience of writing a QEMU device in Rust.)


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
    │       └── qdev.rs
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

     My goal is to reduce unsafe code in this file as much as possible,
     especifically, try to eliminate the unsafe code brought by FFI.

   - qdev.rs:
     Here, it implements various QEMU qdev/qom required traits for the
     HPET state and try to exclude the detailed HPET state operations to
     the hpet.rs file above.

 * Global HPET firmwrie configuration:
   - fw_cfg.rs
     In the C code, there is a variable hpet_fw_cfg (old name: hpet_cfg)
     used to configure the number of HPET timer blocks and the basic
     HPET firmware configuration. It is defined in .c file and is
     referenced as extern in the .h file.

     For the Rust HPET, fw_cfg.rs also implementes hpet_fw_cfg so that
     the .h file can still reference it.

     Specifically, I wrapped it in BqlCell, which ensures the safety of
     Rust device access. Additionally, because BqlCell does not change
     the memory layout, it does not disrupt access from C code.


Current Gaps
============

* Proper bindings for MemoryRegionOps, which needs to wrap the ram
  read/write callbacks.
  - I think it shouldn't be complicated because qom/qdev already
    provides good examples.

* vmstate support.
  - vmstate code for HPET is actually ready, but it will be pending (and
    maybe re-writing) until the vmstate infra gets cleaned up.

* Error handling.
  - Now HPET just use panic and println to replace error_setg and
    warn_report.

* Trace support.
  - No trace for now.


Experience and Considerations in Rust Device
============================================

BqlCell/BqlRefCell
------------------

Paolo provided a very useful Cell wrapper to operate the device under
the protection of BQL. So I tried to wrap as much as possible fields of
HPETState into BqlCell/BqlRefCell, and it works well :-). 

Anything that needs to be modified within a callback should be protected
by BqlCell/BqlRefCell.

Based on this, I am also considering how the opaque parameter in certain
callbacks should interact with BQL cells. In the timer binding (patch 
7), I think the opaque parameter accepted by the timer callback should
be placed in a BQL cell. However, considering generality, I did not make
further changes and only passed BqlRefCell<HPETTimer> as the opaque
parameter in the HPET code.

Furthermore, is it possible in the future to wrap the entire state
within a BQL cell? This could save the effort of wrapping many state
members individually when state becomes very huge and complex.


QDEV Property
-------------

To support bit type property, I added another macro variant (in patch 8)
to allow bitnr parameter. However, I think this lacks scalability.

In qdev-properties.h, it is clear that the PropertyInfo of a property is
bound to its type. Previously, Junjie and I attempted to do the same in
Rust by binding PropertyInfo to the type, thereby avoiding the need to
specify too many parameters in the macro definitions:

https://lore.kernel.org/qemu-devel/20241017143245.1248589-1-zhao1.liu@intel.com/

However, unfortunately, it was missed. I am not sure if this is the
right direction, but perhaps I can pick it up again?


MEMTXATTRS_UNSPECIFIED
----------------------

MEMTXATTRS_UNSPECIFIED is another global variable. Since it is
immutable, BQL cell is not needed.

But MemTxAttrs is a structure with bitfields, and the bindings generated
by bindgen can only be modified through methods. Therefore, it is
necessary to introduce lazy to initialize MEMTXATTRS_UNSPECIFIED in a
const context (patch 6).


Cycle Reference
---------------

A common pattern in QEMU devices is that a sub-member of the state
contains a pointer to the state itself.

For HPETState, it maintains a HPETTimer array, and each HPETTimer also
has the pointer to parent HPETState. So there's the cycle reference
issue.

The common way to address this is to use RefCell<Weak<>> [2], but in
practice, I found it's difficult to be applied in device code. The
device instance is not created in Rust side, and there's only init()
method to initialize created device instance. This way, it's hard to be
compatible with the pattern of creating weak references (at least I
failed).

Then, I chose NonNull to address this issue, as recommended by the
author of NonNull and the standard collections [3].

Though NonNull is used for "covariant" and even its document mentions:

> This is often the correct thing to use when building data structures
> using raw pointers, but is ultimately more dangerous to use because of
> its additional properties. If you’re not sure if you should use
> NonNull<T>, just use *mut T!

But I feel that the usage of NonNull has been greatly expanded, for
example, to ensure non-null pointers in FFI case. Additionally, in cases
of cyclic references, using NonNull for encapsulation also appears safer
and more elegant.


Public and Private in QOM State
-------------------------------

I recently asked on the mailing list [4] about the reason for using
"<public>"/"<private>" comments in QOM structures. Peter, Junjie, and
Balaton provided some explanations and feedback (thank you all).

It seems to be more of a historical issue where QOM did not handle the
public and private access very well. However, Peter and Igor (in the
discussion about LoongArch hotplug) advised me that it is best to use
properties to access QOM members from the outside.

Therefore, I believe that in Rust devices, QOM members should also be
kept private or at most `pub(crate)`. This is also why I tried to avoid
using direct `pub` in HPET.


[1]: https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/software-developers-hpet-spec-1-0a.pdf
[2]: https://doc.rust-lang.org/book/ch15-06-reference-cycles.html
[3]: https://rust-unofficial.github.io/too-many-lists/sixth-variance.html
[4]: https://lore.kernel.org/qemu-devel/ZxPZ5oUDRcVroh7o@intel.com/
---
Paolo Bonzini (2):
  bql: check that the BQL is not dropped within marked sections
  rust: cell: add BQL-enforcing RefCell variant

Zhao Liu (11):
  rust/cell: add get_mut() method for BqlCell
  rust: add bindings for gpio_{in|out} initialization
  rust: add a bit operation binding for deposit64
  rust: add bindings for memattrs
  rust: add bindings for timer
  rust/qdev: add the macro to define bit property
  i386/fw_cfg: move hpet_cfg definition to hpet.c
  rust/timer/hpet: define hpet_fw_cfg
  rust/timer/hpet: add basic HPET timer & state
  rust/timer/hpet: add qdev APIs support
  i386: enable rust hpet for pc when rust is enabled

 hw/i386/Kconfig                               |   2 +
 hw/i386/fw_cfg.c                              |   4 +-
 hw/timer/Kconfig                              |   1 -
 hw/timer/hpet.c                               |  16 +-
 include/hw/timer/hpet.h                       |   2 +-
 include/qemu/main-loop.h                      |  15 +
 rust/Cargo.lock                               |  15 +
 rust/Cargo.toml                               |   1 +
 rust/hw/Kconfig                               |   1 +
 rust/hw/meson.build                           |   1 +
 rust/hw/timer/Kconfig                         |   2 +
 rust/hw/timer/hpet/Cargo.toml                 |  14 +
 rust/hw/timer/hpet/meson.build                |  18 +
 rust/hw/timer/hpet/src/fw_cfg.rs              |  86 ++
 rust/hw/timer/hpet/src/hpet.rs                | 860 ++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs                 |  21 +
 rust/hw/timer/hpet/src/qdev.rs                | 133 +++
 rust/hw/timer/meson.build                     |   1 +
 rust/qemu-api/Cargo.toml                      |   4 +-
 rust/qemu-api/meson.build                     |  14 +-
 rust/qemu-api/src/bitops.rs                   |  11 +
 rust/qemu-api/src/cell.rs                     | 571 +++++++++++-
 rust/qemu-api/src/lib.rs                      |   3 +
 rust/qemu-api/src/memattrs.rs                 |  21 +
 rust/qemu-api/src/qdev.rs                     |  67 +-
 rust/qemu-api/src/timer.rs                    | 123 +++
 rust/wrapper.h                                |   3 +
 scripts/archive-source.sh                     |   2 +-
 scripts/make-release                          |   2 +-
 stubs/iothread-lock.c                         |  15 +
 subprojects/.gitignore                        |   1 +
 subprojects/once_cell-1.20-rs.wrap            |   7 +
 .../once_cell-1.20-rs/meson.build             |  23 +
 system/cpus.c                                 |  15 +
 34 files changed, 2046 insertions(+), 29 deletions(-)
 create mode 100644 rust/hw/timer/Kconfig
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/hpet.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/hpet/src/qdev.rs
 create mode 100644 rust/hw/timer/meson.build
 create mode 100644 rust/qemu-api/src/bitops.rs
 create mode 100644 rust/qemu-api/src/memattrs.rs
 create mode 100644 rust/qemu-api/src/timer.rs
 create mode 100644 subprojects/once_cell-1.20-rs.wrap
 create mode 100644 subprojects/packagefiles/once_cell-1.20-rs/meson.build

-- 
2.34.1



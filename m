Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EF3CAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 10:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzCA6-00076M-2x; Thu, 18 Sep 2025 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzCA0-000739-IY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzC9v-0003Bd-Uj
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 06:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758192393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pG6FDYY+XjyRhR6Sr35V3gIHW4EJJnVFRyQLl/o4k7w=;
 b=QgoRlb/rhuZHbACZrdY4ZUezmJOF4cs06h/J0ku3Gncpyfe10jTr+RXIeOBpGTebGEStr0
 GCWoHvr17Be7P5B+Ao+HrTNdmI4EebaVdvywtliB8DYyS+LyptcQKN4frU/8rXJxT3OS4w
 0D5VSHfAxBU/crgcMRjlgOZQvPPjrq8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-ieyWUeRcNFuKZRPPoqwxrg-1; Thu,
 18 Sep 2025 06:46:28 -0400
X-MC-Unique: ieyWUeRcNFuKZRPPoqwxrg-1
X-Mimecast-MFC-AGG-ID: ieyWUeRcNFuKZRPPoqwxrg_1758192387
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5437F1800451
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 10:46:27 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.32.245])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3129E30002C8
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 10:46:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/60] CPU, Rust, x86 changes for 2025-09-13
Date: Thu, 18 Sep 2025 12:46:23 +0200
Message-ID: <20250918104624.441820-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2e66fb24a0ca9750df0d1d5b35197ff89c4bbd46:

  Merge tag 'pull-misc-20250916' of https://gitlab.com/rth7680/qemu into staging (2025-09-16 10:10:51 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 00c0911c68e5bd664de1a261b74c390f4c0be83d:

  accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid (2025-09-17 19:01:57 +0200)

----------------------------------------------------------------
* cpu-exec: more cleanups to CPU loop exits
* python: bump bundled Meson to 1.9.0
* rust: require Rust 1.83.0
* rust: temporarily remove from Ubuntu CI
* rust: vmstate: convert to use builder pattern
* rust: split "qemu-api" crate
* rust: rename qemu_api_macros -> qemu_macros
* rust: re-export qemu macros from other crates
* x86: fix functional test failure for Xen emulation
* x86: cleanups
----------------------------------------------------------------

v1->v2: dropped "i386/kvm: Get X86MachineState in kvm_arch_init() without the cast check"

Igor Mammedov (1):
      hpet: guard IRQ handling with BQL

Manos Pitsidianakis (1):
      rust: add qdev Device derive macro

Marc-André Lureau (22):
      docs/rust: update msrv
      rust: remove unused global qemu "allocator"
      rust: add workspace authors
      rust: move vmstate_clock!() to qdev module
      rust: move VMState handling to QOM module
      rust: move Cell vmstate impl
      rust: split Rust-only "common" crate
      rust: make build.rs generic over various ./rust/projects
      rust: split "util" crate
      rust: split "migration" crate
      rust: split "bql" crate
      rust: split "qom" crate
      rust: split "chardev" crate
      rust: split "system" crate
      rust: split "hwcore" crate
      rust: rename qemu_api_macros -> qemu_macros
      rust/hpet: drop now unneeded qemu_api dep
      rust/pl011: drop dependency on qemu_api
      rust: repurpose qemu_api -> tests
      rust: re-export qemu_macros internal helper in "bits"
      rust: re-export qemu macros from common/qom/hwcore
      docs: update rust.rst

Paolo Bonzini (28):
      target/ppc: limit cpu_interrupt_exittb to system emulation
      target/sparc: limit cpu_check_irqs to system emulation
      target/i386: limit a20 to system emulation
      target-arm: remove uses of cpu_interrupt() for user-mode emulation
      user-exec: remove cpu_interrupt() stub
      treewide: clear bits of cs->interrupt_request with cpu_reset_interrupt()
      cpu-common: use atomic access for interrupt_request
      cpus: document that qemu_cpu_kick() can be used for BQL-less operation
      accel: use store_release/load_acquire for cross-thread exit_request
      accel: use atomic accesses for exit_request
      accel/tcg: create a thread-kick function for TCG
      accel/tcg: inline cpu_exit()
      cpus: remove TCG-ism from cpu_exit()
      cpus: properly kick CPUs out of inner execution loop
      treewide: rename qemu_wait_io_event/qemu_wait_io_event_common
      bsd-user, linux-user: introduce qemu_process_cpu_events
      cpus: clear exit_request in qemu_process_cpu_events
      accel: make all calls to qemu_process_cpu_events look the same
      tcg/user: do not set exit_request gratuitously
      ci: temporarily remove rust from Ubuntu
      configure: bump Meson to 1.9.0 for use with Rust
      meson, cargo: require Rust 1.83.0
      rust: add missing const markers for MSRV==1.83.0
      rust: use inline const expressions
      rust: vmstate: use const_refs_to_static
      rust: qdev: const_refs_to_static
      rust: meson: remove unnecessary complication in device crates
      rust: do not inline do_init_io

Xiaoyao Li (7):
      i386/cpu: Enable SMM cpu address space under KVM
      target/i386: Define enum X86ASIdx for x86's address spaces
      multiboot: Fix the split lock
      i386/kvm: Drop KVM_CAP_X86_SMM check in kvm_arch_init()
      accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and KVM_CAP_USER_MEMORY2 on VM
      accel/kvm: Zero out mem explicitly in kvm_set_user_memory_region()
      accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid

Zhao Liu (1):
      rust: vmstate: convert to use builder pattern

 MAINTAINERS                                        |  12 +-
 docs/about/build-platforms.rst                     |  15 +-
 docs/devel/rust.rst                                |  93 ++--
 docs/devel/tcg-icount.rst                          |   2 +-
 configure                                          |   4 +-
 meson.build                                        |  10 +-
 accel/tcg/tcg-accel-ops-mttcg.h                    |   3 -
 accel/tcg/tcg-accel-ops.h                          |   1 +
 bsd-user/aarch64/target_arch_cpu.h                 |   2 +-
 bsd-user/arm/target_arch_cpu.h                     |   2 +-
 bsd-user/i386/target_arch_cpu.h                    |   2 +-
 bsd-user/riscv/target_arch_cpu.h                   |   2 +-
 bsd-user/x86_64/target_arch_cpu.h                  |   2 +-
 include/hw/core/cpu.h                              |  22 +-
 include/system/cpus.h                              |   3 +-
 rust/bql/wrapper.h                                 |  27 ++
 rust/chardev/wrapper.h                             |  28 ++
 rust/hw/char/pl011/wrapper.h                       |  51 ++
 rust/hw/core/wrapper.h                             |  32 ++
 rust/{qemu-api => migration}/wrapper.h             |  20 -
 rust/qom/wrapper.h                                 |  27 ++
 rust/system/wrapper.h                              |  29 ++
 rust/util/wrapper.h                                |  32 ++
 target/arm/internals.h                             |   5 +
 target/i386/cpu.h                                  |   5 +
 accel/dummy-cpus.c                                 |   2 +-
 accel/hvf/hvf-accel-ops.c                          |   2 +-
 accel/kvm/kvm-accel-ops.c                          |   3 +-
 accel/kvm/kvm-all.c                                |  32 +-
 accel/tcg/cpu-exec.c                               |  34 +-
 accel/tcg/tcg-accel-ops-mttcg.c                    |  12 +-
 accel/tcg/tcg-accel-ops-rr.c                       |  55 ++-
 accel/tcg/tcg-accel-ops.c                          |   4 +-
 accel/tcg/user-exec.c                              |  11 +-
 bsd-user/main.c                                    |   5 -
 cpu-common.c                                       |   3 +-
 hw/core/cpu-common.c                               |  19 +-
 hw/core/cpu-system.c                               |   2 +-
 hw/ppc/ppc.c                                       |   2 +
 hw/ppc/spapr_hcall.c                               |   7 +-
 hw/ppc/spapr_rtas.c                                |   2 +-
 hw/timer/hpet.c                                    |   8 +
 linux-user/aarch64/cpu_loop.c                      |   2 +-
 linux-user/alpha/cpu_loop.c                        |   2 +-
 linux-user/arm/cpu_loop.c                          |   2 +-
 linux-user/hexagon/cpu_loop.c                      |   2 +-
 linux-user/hppa/cpu_loop.c                         |   2 +-
 linux-user/i386/cpu_loop.c                         |   2 +-
 linux-user/loongarch64/cpu_loop.c                  |   2 +-
 linux-user/m68k/cpu_loop.c                         |   2 +-
 linux-user/main.c                                  |   5 -
 linux-user/microblaze/cpu_loop.c                   |   2 +-
 linux-user/mips/cpu_loop.c                         |   2 +-
 linux-user/openrisc/cpu_loop.c                     |   2 +-
 linux-user/ppc/cpu_loop.c                          |   2 +-
 linux-user/riscv/cpu_loop.c                        |   2 +-
 linux-user/s390x/cpu_loop.c                        |   2 +-
 linux-user/sh4/cpu_loop.c                          |   2 +-
 linux-user/sparc/cpu_loop.c                        |   2 +-
 linux-user/xtensa/cpu_loop.c                       |   2 +-
 replay/replay-events.c                             |   3 +-
 system/cpu-timers.c                                |   6 +-
 system/cpus.c                                      |  15 +-
 system/physmem.c                                   |   5 -
 target/arm/cpu-irq.c                               | 381 +++++++++++++++
 target/arm/cpu.c                                   | 370 ---------------
 target/arm/el2-stubs.c                             |  37 ++
 target/arm/helper.c                                |   4 +
 target/arm/tcg/mte_helper.c                        |   2 +-
 target/avr/helper.c                                |   4 +-
 target/i386/helper.c                               |   2 +
 target/i386/hvf/x86hvf.c                           |   8 +-
 target/i386/kvm/hyperv.c                           |   1 -
 target/i386/kvm/kvm-cpu.c                          |  10 +
 target/i386/kvm/kvm.c                              |  30 +-
 target/i386/nvmm/nvmm-accel-ops.c                  |   8 +-
 target/i386/nvmm/nvmm-all.c                        |  19 +-
 target/i386/tcg/system/seg_helper.c                |  13 +-
 target/i386/tcg/system/svm_helper.c                |   2 +-
 target/i386/tcg/system/tcg-cpu.c                   |   4 +-
 target/i386/whpx/whpx-accel-ops.c                  |   6 +-
 target/i386/whpx/whpx-all.c                        |  23 +-
 target/openrisc/sys_helper.c                       |   2 +-
 target/ppc/helper_regs.c                           |   2 +
 target/rx/helper.c                                 |   4 +-
 target/s390x/tcg/excp_helper.c                     |   2 +-
 target/sparc/int32_helper.c                        |   2 +
 target/sparc/int64_helper.c                        |   2 +
 .gitlab-ci.d/buildtest.yml                         |   4 +-
 clippy.toml                                        |   2 +-
 pc-bios/multiboot_dma.bin                          | Bin 1024 -> 1024 bytes
 pc-bios/optionrom/multiboot.S                      |   2 +-
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.8.1-py3-none-any.whl         | Bin 1013001 -> 0 bytes
 python/wheels/meson-1.9.0-py3-none-any.whl         | Bin 0 -> 1029634 bytes
 pythondeps.toml                                    |   4 +-
 rust/Cargo.lock                                    | 125 ++++-
 rust/Cargo.toml                                    |  19 +-
 .../src/bindings.rs => bindings/src/lib.rs}        |  12 +-
 rust/bits/Cargo.toml                               |   2 +-
 rust/bits/meson.build                              |   2 +-
 rust/bits/src/lib.rs                               |  13 +-
 rust/bql/Cargo.toml                                |  23 +
 rust/bql/build.rs                                  |   1 +
 rust/bql/meson.build                               |  52 +++
 rust/bql/src/bindings.rs                           |  25 +
 rust/{qemu-api => bql}/src/cell.rs                 | 336 ++-----------
 rust/bql/src/lib.rs                                |  29 ++
 rust/chardev/Cargo.toml                            |  23 +
 rust/chardev/build.rs                              |   1 +
 rust/chardev/meson.build                           |  41 ++
 rust/chardev/src/bindings.rs                       |  36 ++
 rust/{qemu-api => chardev}/src/chardev.rs          |  25 +-
 rust/chardev/src/lib.rs                            |   6 +
 rust/common/Cargo.toml                             |  20 +
 rust/common/meson.build                            |  34 ++
 rust/{qemu-api => common}/src/assertions.rs        |  24 +-
 rust/{qemu-api => common}/src/bitops.rs            |   1 -
 rust/{qemu-api => common}/src/callbacks.rs         |  37 +-
 rust/{qemu-api => common}/src/errno.rs             |  19 +-
 rust/common/src/lib.rs                             |  22 +
 rust/common/src/opaque.rs                          | 236 ++++++++++
 rust/{qemu-api => common}/src/uninit.rs            |   8 +-
 rust/common/src/zeroable.rs                        |  18 +
 rust/hw/char/pl011/Cargo.toml                      |  10 +-
 rust/hw/char/pl011/build.rs                        |   1 +
 rust/hw/char/pl011/meson.build                     |  39 +-
 rust/hw/char/pl011/src/bindings.rs                 |  27 ++
 rust/hw/char/pl011/src/device.rs                   | 195 ++++----
 rust/hw/char/pl011/src/lib.rs                      |   1 +
 rust/hw/char/pl011/src/registers.rs                |   4 +-
 rust/hw/core/Cargo.toml                            |  26 ++
 rust/hw/core/build.rs                              |   1 +
 rust/hw/core/meson.build                           |  80 ++++
 rust/hw/core/src/bindings.rs                       |  41 ++
 rust/{qemu-api => hw/core}/src/irq.rs              |  16 +-
 rust/hw/core/src/lib.rs                            |  15 +
 rust/{qemu-api => hw/core}/src/qdev.rs             | 111 +++--
 rust/{qemu-api => hw/core}/src/sysbus.rs           |  24 +-
 rust/{qemu-api => hw/core}/tests/tests.rs          |  52 +--
 rust/hw/timer/hpet/Cargo.toml                      |   9 +-
 rust/hw/timer/hpet/meson.build                     |  12 +-
 rust/hw/timer/hpet/src/device.rs                   | 227 ++++-----
 rust/hw/timer/hpet/src/fw_cfg.rs                   |   6 +-
 rust/meson.build                                   |  15 +-
 rust/migration/Cargo.toml                          |  20 +
 rust/migration/build.rs                            |   1 +
 rust/migration/meson.build                         |  53 +++
 rust/migration/src/bindings.rs                     |  48 ++
 rust/migration/src/lib.rs                          |   6 +
 rust/{qemu-api => migration}/src/vmstate.rs        | 519 +++++++++++++--------
 rust/qemu-api/.gitignore                           |   2 -
 rust/qemu-api/README.md                            |  19 -
 rust/qemu-api/meson.build                          | 114 -----
 rust/qemu-api/src/lib.rs                           | 174 -------
 rust/qemu-api/src/prelude.rs                       |  31 --
 rust/qemu-api/src/zeroable.rs                      |  37 --
 rust/{qemu-api-macros => qemu-macros}/Cargo.toml   |   2 +-
 rust/{qemu-api-macros => qemu-macros}/meson.build  |  10 +-
 rust/{qemu-api-macros => qemu-macros}/src/bits.rs  |   0
 rust/{qemu-api-macros => qemu-macros}/src/lib.rs   | 170 ++++++-
 rust/{qemu-api-macros => qemu-macros}/src/tests.rs | 115 ++++-
 rust/qom/Cargo.toml                                |  23 +
 rust/qom/build.rs                                  |   1 +
 rust/qom/meson.build                               |  43 ++
 rust/qom/src/bindings.rs                           |  25 +
 rust/qom/src/lib.rs                                |  13 +
 rust/qom/src/prelude.rs                            |  12 +
 rust/{qemu-api => qom}/src/qom.rs                  |  31 +-
 rust/system/Cargo.toml                             |  21 +
 rust/system/build.rs                               |   1 +
 rust/system/meson.build                            |  42 ++
 rust/system/src/bindings.rs                        |  41 ++
 rust/system/src/lib.rs                             |   6 +
 rust/{qemu-api => system}/src/memory.rs            |  21 +-
 rust/tests/Cargo.toml                              |  26 ++
 rust/tests/meson.build                             |  14 +
 rust/{qemu-api => tests}/tests/vmstate_tests.rs    | 160 ++++---
 rust/{qemu-api => util}/Cargo.toml                 |  14 +-
 rust/{qemu-api => util}/build.rs                   |  10 +-
 rust/util/meson.build                              |  55 +++
 rust/util/src/bindings.rs                          |  25 +
 rust/{qemu-api => util}/src/error.rs               |   6 +-
 rust/util/src/lib.rs                               |   9 +
 rust/{qemu-api => util}/src/log.rs                 |  16 +-
 rust/{qemu-api => util}/src/module.rs              |   2 +-
 rust/{qemu-api => util}/src/timer.rs               |  16 +-
 target/arm/meson.build                             |   2 +
 188 files changed, 3558 insertions(+), 2156 deletions(-)
 create mode 100644 rust/bql/wrapper.h
 create mode 100644 rust/chardev/wrapper.h
 create mode 100644 rust/hw/char/pl011/wrapper.h
 create mode 100644 rust/hw/core/wrapper.h
 rename rust/{qemu-api => migration}/wrapper.h (77%)
 create mode 100644 rust/qom/wrapper.h
 create mode 100644 rust/system/wrapper.h
 create mode 100644 rust/util/wrapper.h
 create mode 100644 target/arm/cpu-irq.c
 create mode 100644 target/arm/el2-stubs.c
 delete mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.9.0-py3-none-any.whl
 rename rust/{qemu-api/src/bindings.rs => bindings/src/lib.rs} (89%)
 create mode 100644 rust/bql/Cargo.toml
 create mode 120000 rust/bql/build.rs
 create mode 100644 rust/bql/meson.build
 create mode 100644 rust/bql/src/bindings.rs
 rename rust/{qemu-api => bql}/src/cell.rs (70%)
 create mode 100644 rust/bql/src/lib.rs
 create mode 100644 rust/chardev/Cargo.toml
 create mode 120000 rust/chardev/build.rs
 create mode 100644 rust/chardev/meson.build
 create mode 100644 rust/chardev/src/bindings.rs
 rename rust/{qemu-api => chardev}/src/chardev.rs (94%)
 create mode 100644 rust/chardev/src/lib.rs
 create mode 100644 rust/common/Cargo.toml
 create mode 100644 rust/common/meson.build
 rename rust/{qemu-api => common}/src/assertions.rs (86%)
 rename rust/{qemu-api => common}/src/bitops.rs (98%)
 rename rust/{qemu-api => common}/src/callbacks.rs (85%)
 rename rust/{qemu-api => common}/src/errno.rs (96%)
 create mode 100644 rust/common/src/lib.rs
 create mode 100644 rust/common/src/opaque.rs
 rename rust/{qemu-api => common}/src/uninit.rs (91%)
 create mode 100644 rust/common/src/zeroable.rs
 create mode 120000 rust/hw/char/pl011/build.rs
 create mode 100644 rust/hw/char/pl011/src/bindings.rs
 create mode 100644 rust/hw/core/Cargo.toml
 create mode 120000 rust/hw/core/build.rs
 create mode 100644 rust/hw/core/meson.build
 create mode 100644 rust/hw/core/src/bindings.rs
 rename rust/{qemu-api => hw/core}/src/irq.rs (93%)
 create mode 100644 rust/hw/core/src/lib.rs
 rename rust/{qemu-api => hw/core}/src/qdev.rs (82%)
 rename rust/{qemu-api => hw/core}/src/sysbus.rs (90%)
 rename rust/{qemu-api => hw/core}/tests/tests.rs (78%)
 create mode 100644 rust/migration/Cargo.toml
 create mode 120000 rust/migration/build.rs
 create mode 100644 rust/migration/meson.build
 create mode 100644 rust/migration/src/bindings.rs
 create mode 100644 rust/migration/src/lib.rs
 rename rust/{qemu-api => migration}/src/vmstate.rs (61%)
 delete mode 100644 rust/qemu-api/.gitignore
 delete mode 100644 rust/qemu-api/README.md
 delete mode 100644 rust/qemu-api/meson.build
 delete mode 100644 rust/qemu-api/src/lib.rs
 delete mode 100644 rust/qemu-api/src/prelude.rs
 delete mode 100644 rust/qemu-api/src/zeroable.rs
 rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
 rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
 rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
 rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (54%)
 rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (50%)
 create mode 100644 rust/qom/Cargo.toml
 create mode 120000 rust/qom/build.rs
 create mode 100644 rust/qom/meson.build
 create mode 100644 rust/qom/src/bindings.rs
 create mode 100644 rust/qom/src/lib.rs
 create mode 100644 rust/qom/src/prelude.rs
 rename rust/{qemu-api => qom}/src/qom.rs (97%)
 create mode 100644 rust/system/Cargo.toml
 create mode 120000 rust/system/build.rs
 create mode 100644 rust/system/meson.build
 create mode 100644 rust/system/src/bindings.rs
 create mode 100644 rust/system/src/lib.rs
 rename rust/{qemu-api => system}/src/memory.rs (90%)
 create mode 100644 rust/tests/Cargo.toml
 create mode 100644 rust/tests/meson.build
 rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (78%)
 rename rust/{qemu-api => util}/Cargo.toml (55%)
 rename rust/{qemu-api => util}/build.rs (81%)
 create mode 100644 rust/util/meson.build
 create mode 100644 rust/util/src/bindings.rs
 rename rust/{qemu-api => util}/src/error.rs (98%)
 create mode 100644 rust/util/src/lib.rs
 rename rust/{qemu-api => util}/src/log.rs (93%)
 rename rust/{qemu-api => util}/src/module.rs (97%)
 rename rust/{qemu-api => util}/src/timer.rs (91%)
-- 
2.51.0



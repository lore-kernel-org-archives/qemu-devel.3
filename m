Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34406C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHmS-0004CC-F2; Tue, 23 Apr 2024 11:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmR-0004BA-53
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmO-0008IU-HX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713884995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yKEqjS+EypEDjvG4eTO/tmLT1FZt3HVQ+HZbY6dK4cU=;
 b=G6n6h0c6fPyWgxJ+AghVwgGbuf7C2hfTZAYyXHcYfR95nxfxgpmrMfuUOK99C6ELCVS7Hm
 TQ6f8oFNqlVEQYwJC+M0YV7sBC8XJE4Gh1WA6wSdeU4v2VBqJ/cCGnKPaqU02Jl9VMErUU
 lR9VwhoZo8CqpZhJQSV1Y0l/uK1EIKg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-vtuDGoh-MtWeNej6Aw-tow-1; Tue,
 23 Apr 2024 11:09:53 -0400
X-MC-Unique: vtuDGoh-MtWeNej6Aw-tow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7735638116F9
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:09:53 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7DA6200E290
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:09:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/63] First batch of i386 and build system patch for QEMU 9.1
Date: Tue, 23 Apr 2024 17:08:48 +0200
Message-ID: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 62dbe54c24dbf77051bafe1039c31ddc8f37602d:

  Update version for v9.0.0-rc4 release (2024-04-16 18:06:15 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 254fade7854a6b3d5b7c54a4ca74c25bb928da14:

  target/i386/translate.c: always write 32-bits for SGDT and SIDT (2024-04-23 16:08:50 +0200)

----------------------------------------------------------------
* cleanups for stubs
* do not link pixman automatically into all targets
* optimize computation of VGA dirty memory region
* kvm: use configs/ definition to conditionalize debug support
* hw: Add compat machines for 9.1
* target/i386: add guest-phys-bits cpu property
* target/i386: Introduce Icelake-Server-v7 and SierraForest models
* target/i386: Export RFDS bit to guests
* q35: SMM ranges cleanups
* target/i386: basic support for confidential guests
* linux-headers: update headers
* target/i386: SEV: use KVM_SEV_INIT2 if possible
* kvm: Introduce support for memory_attributes
* RAMBlock: Add support of KVM private guest memfd
* Consolidate use of warn_report_once()
* pythondeps.toml: warn about updates needed to docs/requirements.txt
* target/i386: always write 32-bits for SGDT and SIDT

----------------------------------------------------------------
Chao Peng (2):
      kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
      kvm: handle KVM_EXIT_MEMORY_FAULT

Gerd Hoffmann (2):
      target/i386: add guest-phys-bits cpu property
      kvm: add support for guest physical bits

Isaku Yamahata (4):
      pci-host/q35: Move PAM initialization above SMRAM initialization
      q35: Introduce smm_ranges property for q35-pci-host
      kvm/tdx: Don't complain when converting vMMIO region to shared
      kvm/tdx: Ignore memory conversion to shared of unassigned region

Mark Cave-Ayland (1):
      target/i386/translate.c: always write 32-bits for SGDT and SIDT

Michael Roth (4):
      scripts/update-linux-headers: Add setup_data.h to import list
      scripts/update-linux-headers: Add bits.h to file imports
      i386/sev: Add 'legacy-vm-type' parameter for SEV guest objects
      hw/i386/sev: Use legacy SEV VM types for older machine types

Paolo Bonzini (28):
      meson: do not link pixman automatically into all targets
      tests: only build plugins if TCG is enabled
      tests/unit: match some unit tests to corresponding feature switches
      yank: only build if needed
      hw/core: Move system emulation files to system_ss
      stubs: remove obsolete stubs
      hw/usb: move stubs out of stubs/
      hw/virtio: move stubs out of stubs/
      semihosting: move stubs out of stubs/
      ramfb: move stubs out of stubs/
      memory-device: move stubs out of stubs/
      colo: move stubs out of stubs/
      stubs: split record/replay stubs further
      stubs: include stubs only if needed
      stubs: move monitor_fdsets_cleanup with other fdset stubs
      vga: optimize computation of dirty memory region
      vga: move dirty memory region code together
      kvm: use configs/ definition to conditionalize debug support
      hw: Add compat machines for 9.1
      linux-headers: update to current kvm/next
      runstate: skip initial CPU reset if reset is not actually possible
      KVM: track whether guest state is encrypted
      KVM: remove kvm_arch_cpu_check_are_resettable
      target/i386: introduce x86-confidential-guest
      target/i386: Implement mc->kvm_type() to get VM type
      target/i386: SEV: use KVM_SEV_INIT2 if possible
      RAMBlock: make guest_memfd require uncoordinated discard
      pythondeps.toml: warn about updates needed to docs/requirements.txt

Pawan Gupta (1):
      target/i386: Export RFDS bit to guests

Philippe Mathieu-Daudé (3):
      ebpf: Restrict to system emulation
      util/qemu-config: Extract QMP commands to qemu-config-qmp.c
      hw: Include minimal source set in user emulation build

Sean Christopherson (1):
      i386/kvm: Move architectural CPUID leaf generation to separate helper

Tao Su (1):
      target/i386: Add new CPU model SierraForest

Xiaoyao Li (11):
      hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not disabled
      confidential guest support: Add kvm_init() and kvm_reset() in class
      i386/sev: Switch to use confidential_guest_kvm_init()
      ppc/pef: switch to use confidential_guest_kvm_init/reset()
      s390: Switch to use confidential_guest_kvm_init()
      trace/kvm: Split address space and slot id in trace_kvm_set_user_memory()
      kvm: Introduce support for memory_attributes
      RAMBlock: Add support of KVM private guest memfd
      kvm/memory: Make memory type private by default if it has guest memfd backend
      HostMem: Add mechanism to opt in kvm guest memfd via MachineState
      physmem: Introduce ram_block_discard_guest_memfd_range()

Zhao Liu (4):
      target/i386/host-cpu: Consolidate the use of warn_report_once()
      target/i386/cpu: Consolidate the use of warn_report_once()
      target/i386/cpu: Merge the warning and error messages for AMD HT check
      accel/tcg/icount-common: Consolidate the use of warn_report_once()

Zhenzhong Duan (1):
      target/i386: Introduce Icelake-Server-v7 to enable TSX

 docs/requirements.txt                              |   3 +
 configs/targets/aarch64-softmmu.mak                |   1 +
 configs/targets/i386-softmmu.mak                   |   1 +
 configs/targets/ppc-softmmu.mak                    |   1 +
 configs/targets/ppc64-softmmu.mak                  |   1 +
 configs/targets/s390x-softmmu.mak                  |   1 +
 configs/targets/x86_64-softmmu.mak                 |   1 +
 meson.build                                        |   8 +-
 qapi/qom.json                                      |  11 +-
 include/exec/confidential-guest-support.h          |  34 +-
 include/exec/cpu-common.h                          |   2 +
 include/exec/memory.h                              |  20 +-
 include/exec/ram_addr.h                            |   2 +-
 include/exec/ramblock.h                            |   1 +
 include/hw/boards.h                                |   5 +
 include/hw/i386/pc.h                               |   4 +
 include/hw/pci-host/q35.h                          |   1 +
 include/hw/ppc/pef.h                               |  17 -
 include/qemu/config-file.h                         |   3 +
 include/standard-headers/asm-x86/bootparam.h       |  17 +-
 include/standard-headers/asm-x86/kvm_para.h        |   3 +-
 include/standard-headers/asm-x86/setup_data.h      |  83 +++
 include/standard-headers/linux/ethtool.h           |  48 ++
 include/standard-headers/linux/fuse.h              |  39 +-
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/virtio_gpu.h        |   2 +
 include/standard-headers/linux/virtio_pci.h        |  10 +-
 include/standard-headers/linux/virtio_snd.h        | 154 +++++
 include/sysemu/hostmem.h                           |   1 +
 include/sysemu/kvm.h                               |  22 +-
 include/sysemu/kvm_int.h                           |   5 +-
 include/sysemu/sysemu.h                            |   2 -
 linux-headers/asm-arm64/kvm.h                      |  15 +-
 linux-headers/asm-arm64/sve_context.h              |  11 +
 linux-headers/asm-generic/bitsperlong.h            |   4 +
 linux-headers/asm-loongarch/kvm.h                  |   2 -
 linux-headers/asm-mips/kvm.h                       |   2 -
 linux-headers/asm-powerpc/kvm.h                    |  45 +-
 linux-headers/asm-riscv/kvm.h                      |   3 +-
 linux-headers/asm-s390/kvm.h                       | 315 +++++++++-
 linux-headers/asm-x86/kvm.h                        | 328 +++++++++-
 linux-headers/linux/bits.h                         |  15 +
 linux-headers/linux/kvm.h                          | 689 +--------------------
 linux-headers/linux/psp-sev.h                      |  59 ++
 linux-headers/linux/vhost.h                        |   7 +
 target/i386/confidential-guest.h                   |  59 ++
 target/i386/cpu.h                                  |   8 +
 target/i386/kvm/kvm_i386.h                         |   2 +
 target/i386/sev.h                                  |   2 -
 target/s390x/kvm/pv.h                              |  14 -
 accel/kvm/kvm-accel-ops.c                          |   6 +-
 accel/kvm/kvm-all.c                                | 274 +++++++-
 accel/stubs/kvm-stub.c                             |   5 +
 accel/tcg/icount-common.c                          |   6 +-
 backends/hostmem-file.c                            |   1 +
 backends/hostmem-memfd.c                           |   1 +
 backends/hostmem-ram.c                             |   1 +
 backends/hostmem.c                                 |   1 +
 hw/arm/virt.c                                      |  11 +-
 hw/core/machine.c                                  |   8 +
 stubs/ramfb.c => hw/display/ramfb-stubs.c          |   0
 hw/display/vga.c                                   |  32 +-
 hw/i386/acpi-common.c                              |   4 +-
 hw/i386/pc.c                                       |   6 +
 hw/i386/pc_piix.c                                  |  17 +-
 hw/i386/pc_q35.c                                   |  16 +-
 hw/i386/x86.c                                      |  19 +-
 hw/m68k/virt.c                                     |  11 +-
 .../mem/memory-device-stubs.c                      |   0
 hw/pci-host/q35.c                                  |  61 +-
 hw/ppc/pef.c                                       |   9 +-
 hw/ppc/spapr.c                                     |  27 +-
 hw/s390x/s390-virtio-ccw.c                         |  19 +-
 stubs/usb-dev-stub.c => hw/usb/bus-stub.c          |   5 -
 .../virtio-md-pci.c => hw/virtio/virtio-md-stubs.c |   0
 stubs/colo.c => migration/colo-stubs.c             |   0
 monitor/qemu-config-qmp.c                          | 206 ++++++
 stubs/colo-compare.c => net/colo-stubs.c           |   0
 stubs/semihost-all.c => semihosting/stubs-all.c    |   0
 stubs/semihost.c => semihosting/stubs-system.c     |   0
 stubs/fdset.c                                      |   6 +
 {hw/core => stubs}/hotplug-stubs.c                 |   0
 stubs/isa-bus.c                                    |   7 -
 stubs/module-opts.c                                |   2 -
 stubs/monitor-core.c                               |   6 -
 stubs/{monitor.c => monitor-internal.c}            |   5 -
 stubs/pci-bus.c                                    |   7 -
 stubs/qdev.c                                       |   6 -
 stubs/qtest.c                                      |  10 -
 stubs/replay-mode.c                                |   4 +
 stubs/replay.c                                     |   2 -
 system/memory.c                                    |   5 +
 system/physmem.c                                   |  65 +-
 system/runstate.c                                  |  15 +-
 target/arm/kvm.c                                   |   5 -
 target/i386/confidential-guest.c                   |  33 +
 target/i386/cpu.c                                  | 175 +++++-
 target/i386/host-cpu.c                             |  11 +-
 target/i386/kvm/kvm-cpu.c                          |  50 +-
 target/i386/kvm/kvm.c                              | 510 ++++++++-------
 target/i386/kvm/sev-stub.c                         |  21 -
 target/i386/sev.c                                  | 178 ++++--
 target/i386/tcg/translate.c                        |  14 +-
 target/loongarch/kvm/kvm.c                         |   5 -
 target/mips/kvm.c                                  |   5 -
 target/ppc/kvm.c                                   |   5 -
 target/riscv/kvm/kvm-cpu.c                         |   5 -
 target/s390x/kvm/kvm.c                             |   5 -
 target/s390x/kvm/pv.c                              |  10 +-
 util/qemu-config.c                                 | 204 +-----
 accel/kvm/trace-events                             |   4 +-
 ebpf/meson.build                                   |   2 +-
 hw/core/meson.build                                |  14 +-
 hw/display/meson.build                             |   2 +-
 hw/mem/meson.build                                 |   1 +
 hw/usb/meson.build                                 |   2 +-
 hw/virtio/meson.build                              |   2 +
 migration/meson.build                              |   2 +
 monitor/meson.build                                |   1 +
 net/meson.build                                    |   2 +
 pythondeps.toml                                    |   1 +
 scripts/update-linux-headers.sh                    |   8 +-
 semihosting/meson.build                            |   3 +
 stubs/meson.build                                  | 133 ++--
 target/i386/kvm/meson.build                        |   2 -
 target/i386/meson.build                            |   2 +-
 tests/meson.build                                  |   2 +-
 tests/unit/meson.build                             |  12 +-
 util/meson.build                                   |   2 +-
 129 files changed, 2786 insertions(+), 1617 deletions(-)
 delete mode 100644 include/hw/ppc/pef.h
 create mode 100644 include/standard-headers/asm-x86/setup_data.h
 create mode 100644 linux-headers/linux/bits.h
 create mode 100644 target/i386/confidential-guest.h
 rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)
 rename stubs/memory_device.c => hw/mem/memory-device-stubs.c (100%)
 rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (83%)
 rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)
 rename stubs/colo.c => migration/colo-stubs.c (100%)
 create mode 100644 monitor/qemu-config-qmp.c
 rename stubs/colo-compare.c => net/colo-stubs.c (100%)
 rename stubs/semihost-all.c => semihosting/stubs-all.c (100%)
 rename stubs/semihost.c => semihosting/stubs-system.c (100%)
 rename {hw/core => stubs}/hotplug-stubs.c (100%)
 delete mode 100644 stubs/isa-bus.c
 delete mode 100644 stubs/module-opts.c
 rename stubs/{monitor.c => monitor-internal.c} (79%)
 delete mode 100644 stubs/pci-bus.c
 create mode 100644 stubs/replay-mode.c
 create mode 100644 target/i386/confidential-guest.c
 delete mode 100644 target/i386/kvm/sev-stub.c
-- 
2.44.0



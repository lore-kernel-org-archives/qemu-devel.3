Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9389C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIE-0002O6-AW; Tue, 22 Apr 2025 15:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIB-0002MV-2P
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI6-00068u-J3
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2241053582dso78222485ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350101; x=1745954901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RbkAB3Ra9ETjR8C9lem/rOyZIOayJI2w4JjyVOmIcKw=;
 b=SkjK1HqVJOxDon3eVgic5Q2F3L9RcqCR6alsHvr0/7/eYeQwocDk2qjJ5M+yiNwOC4
 QHCJbSx43L6K3BQQgnwF0cKk0vdzS/sLGWh3CqEv5ApNYd/mICTPzu/dNEJ+Ay1PspyP
 tqIjAfz6Uc1iiEfHDCKjLELllu6y4uLU/uTdhqcukZXvnl2DCkTwS4SXM6o5qEanzMTj
 +cTSs14O2ENt11mNhOn0Ch9wBakq0EBnbXIJixMox4zUmjOmyVtNYFmw7R5NnhDF2WPw
 g9vDEwe4QIvETsTvqfSYcTV/UIJQmBE63CeoxFz0nZTnHvYvpLPPaQNcTVo+Mu/Wt57o
 7x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350101; x=1745954901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbkAB3Ra9ETjR8C9lem/rOyZIOayJI2w4JjyVOmIcKw=;
 b=s80jABzGBdKNLNMpaV4yHp0uyfybGfhGPp+fGg54WyiyS+Orw9C8tLH4YPNSwPgjIz
 baFi0PtjshvQ8W2lhzeeApD6F8zY9N/MR5SV0AhIJUowp/3XrTLcsrt+JUbMU7Pd7zva
 RQm4xcAO3krD+ko0cGjvlkSxgeCa45Nzik99YTnLc9BZ85KS+kWa9lX9rgjzGli0+eDx
 V7wegARGW6O9unPN5slfavvwKN1kujBkD/bSRbzAlnCaK2x9gs+EIRp28TEvetKZCktO
 l9Rxiik8YZ9tAsvD1eYbFKb53gEHZx1TFwK6tXuj4L4iVJasPc8qJwphjM2l/T22ENiT
 5rZw==
X-Gm-Message-State: AOJu0YzslR99CXYu/UlgR1UmJ43NQDqJSW0HJjGURNhQ9T+Rjc5C4QU0
 7+v38NhDRzaMC3j93koED0uKKNYRYf3EestYULmJUa1aEGLYk3CbxkbOMeSSFgAbJcACeijz5GT
 Z
X-Gm-Gg: ASbGncvKPOQ0Uf+cjuT+lDUpAaMpdD9xkf3QznwX1+2STGNSEycvFHWX8+4apumGIID
 dQdS5t9SYp8d8FNxm8CnT+gPVlXACQ3uYvl3eNpvYKu4pGUr5gE2vAId8HvirfZCSksAtvcb4Uy
 cWt0mpV/Z+uveLvug8XhSCaIvlaEWsg5NrRHDs2OtF3Nnj0IHyYA+dLPadqnUnZXAAFlYgIpmY/
 NVlj5dfgUkWw9sF6jWcimtYAUJP6jJQEppEjPFgMDNhDZbZlnkZeH2TQbPJrMKro85XBKKs3YR0
 ZSKgMR282QYor1I8lUTKsdBpNc/X0HG55EbfYkxUezJU4Jqam7+81piGReq9FAi0eFiGstlMR6Q
 k9xY+bjvlww==
X-Google-Smtp-Source: AGHT+IH39iSC09G+8MQpHrAzeK4ZFr/X/52i8PGSysRT9MhnFnU+qcdLGoEQ0NX4ddmiogrhRxxCLg==
X-Received: by 2002:a17:90b:2e48:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-3087bbc8c4dmr20291431a91.32.1745350100251; 
 Tue, 22 Apr 2025 12:28:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 000/147] single-binary patch queue
Date: Tue, 22 Apr 2025 12:25:49 -0700
Message-ID: <20250422192819.302784-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Based-on: 20250325224403.4011975-1-richard.henderson@linaro.org
("[PATCH v2 00/11] target/avr: Increase page size")

This is an omnibus collection of many patch sets that work toward
single-binary compilation, and mostly touch accel/tcg or associated
headers in some way.  They've come from so many different places,
I apologize if I have missed any r-b.

The patches for which I have not collected reviews are:
  0030-accel-tcg-Use-cpu_ld-_code_mmu-in-translator.c.patch
  0047-semihosting-Assert-is_user-in-user-only-semihosting_.patch
  0048-include-exec-Split-out-watchpoint.h.patch
  0056-include-exec-Split-out-icount.h.patch
  0057-include-exec-Protect-icount_enabled-from-poisoned-sy.patch
  0063-accel-tcg-Fix-argument-types-of-tlb_reset_dirty.patch
  0064-accel-tcg-Pass-CPUTLBEntryFull-to-tlb_reset_dirty_ra.patch
  0065-accel-tcg-Rebuild-full-flags-in-tlb_reset_dirty_rang.patch
  0066-include-exec-Move-TLB_MMIO-TLB_DISCARD_WRITE-to-slow.patch
  0140-tcg-Pass-max_threads-not-max_cpus-to-tcg_init.patch
  0142-accel-tcg-Remove-mttcg_enabled.patch
  0144-accel-tcg-Move-mttcg-warning-to-tcg_init_machine.patch

This is all on
  https://gitlab.com/rth7680/qemu.git tcg-next


r~


Philippe Mathieu-Daudé (46):
  accel/tcg: Remove unnecesary inclusion of memory-internal.h in
    cputlb.c
  exec: Restrict memory-internal.h to system/
  target/rx: Fix copy/paste typo (riscv -> rx)
  hw/core/cpu: Update CPUClass::mmu_index docstring
  accel/tcg: Introduce TCGCPUOps::mmu_index() callback
  target/alpha: Restrict SoftMMU mmu_index() to TCG
  target/arm: Restrict SoftMMU mmu_index() to TCG
  target/avr: Restrict SoftMMU mmu_index() to TCG
  target/hppa: Restrict SoftMMU mmu_index() to TCG
  target/i386: Remove unused cpu_(ldub, stb)_kernel macros
  target/i386: Restrict cpu_mmu_index_kernel() to TCG
  target/i386: Restrict SoftMMU mmu_index() to TCG
  target/loongarch: Restrict SoftMMU mmu_index() to TCG
  target/m68k: Restrict SoftMMU mmu_index() to TCG
  target/microblaze: Restrict SoftMMU mmu_index() to TCG
  target/mips: Restrict SoftMMU mmu_index() to TCG
  target/openrisc: Restrict SoftMMU mmu_index() to TCG
  target/ppc: Restrict SoftMMU mmu_index() to TCG
  target/riscv: Restrict SoftMMU mmu_index() to TCG
  target/rx: Restrict SoftMMU mmu_index() to TCG
  target/s390x: Restrict SoftMMU mmu_index() to TCG
  target/sh4: Restrict SoftMMU mmu_index() to TCG
  target/sparc: Restrict SoftMMU mmu_index() to TCG
  target/tricore: Restrict SoftMMU mmu_index() to TCG
  target/xtensa: Restrict SoftMMU mmu_index() to TCG
  hw/core/cpu: Remove CPUClass::mmu_index()
  target/riscv: Do not expose rv128 CPU on user mode emulation
  tcg: Include missing 'cpu.h' in translate-all.c
  tcg: Declare TARGET_INSN_START_EXTRA_WORDS in 'cpu-param.h'
  tcg: Always define TARGET_INSN_START_EXTRA_WORDS
  exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
  exec: Restrict 'cpu_ldst.h' to accel/tcg/
  exec: Do not include 'accel/tcg/cpu-ldst.h' in 'exec-all.h'
  tcg: Always define TCG_GUEST_DEFAULT_MO
  tcg: Simplify tcg_req_mo() macro
  tcg: Define guest_default_memory_order in TCGCPUOps
  tcg: Remove use of TCG_GUEST_DEFAULT_MO in tb_gen_code()
  tcg: Propagate CPUState argument to cpu_req_mo()
  tcg: Have tcg_req_mo() use TCGCPUOps::guest_default_memory_order
  tcg: Remove the TCG_GUEST_DEFAULT_MO definition globally
  tcg: Move cpu_req_mo() macro to target-agnostic 'backend-ldst.h'
  tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
  tcg: Convert TCGState::mttcg_enabled to TriState
  target/riscv: Remove AccelCPUClass::cpu_class_init need
  target/i386: Remove AccelCPUClass::cpu_class_init need
  tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field

Pierrick Bouvier (43):
  exec/tswap: target code can use TARGET_BIG_ENDIAN instead of
    target_words_bigendian()
  exec/tswap: implement {ld,st}.*_p as functions instead of macros
  exec/memory_ldst: extract memory_ldst declarations from cpu-all.h
  exec/memory_ldst_phys: extract memory_ldst_phys declarations from
    cpu-all.h
  exec/memory.h: make devend_memop "target defines" agnostic
  codebase: prepare to remove cpu.h from exec/exec-all.h
  exec/exec-all: remove dependency on cpu.h
  exec/memory-internal: remove dependency on cpu.h
  exec/ram_addr: remove dependency on cpu.h
  system/kvm: make kvm_flush_coalesced_mmio_buffer() accessible for
    common code
  exec/ram_addr: call xen_hvm_modified_memory only if xen is enabled
  hw/xen: add stubs for various functions
  system/xen: remove inline stubs
  system/physmem: compilation unit is now common to all targets
  include/exec/memory: extract devend_big_endian from devend_memop
  include/exec/memory: move devend functions to memory-internal.h
  system/memory: make compilation unit common
  system/ioport: make compilation unit common
  exec/cpu-all: extract tlb flags defines to exec/tlb-flags.h
  exec/cpu-all: move cpu_copy to linux-user/qemu.h
  include/exec/cpu-all: move compile time check for CPUArchState to
    cpu-target.c
  exec/cpu-all: remove system/memory include
  exec/cpu-all: remove exec/page-protection include
  exec/cpu-all: remove tswap include
  exec/cpu-all: remove exec/cpu-interrupt include
  accel/tcg: fix missing includes for TCG_GUEST_DEFAULT_MO
  accel/tcg: fix missing includes for TARGET_HAS_PRECISE_SMC
  exec/cpu-all: remove cpu include
  exec/cpu-all: remove exec/target_page include
  exec/cpu-all: transfer exec/cpu-common include to cpu.h headers
  exec/cpu-all: remove this header
  accel/kvm: move KVM_HAVE_MCE_INJECTION define to kvm-all.c
  exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
  target/arm/cpu: always define kvm related registers
  target/arm/cpu: flags2 is always uint64_t
  target/arm/cpu: define same set of registers for aarch32 and aarch64
  target/arm/cpu: remove inline stubs for aarch32 emulation
  meson: add common hw files
  hw/arm/boot: make compilation unit hw common
  hw/arm/digic_boards: prepare compilation unit to be common
  hw/arm/xlnx-zynqmp: prepare compilation unit to be common
  hw/arm/xlnx-versal: prepare compilation unit to be common
  hw/arm: make most of the compilation units common

Richard Henderson (58):
  accel/tcg: Build user-exec-stub.c once
  accel/tcg: Build plugin-gen.c once
  accel/tcg: Fix cpu_ld*_code_mmu for user mode
  include/exec: Use vaddr for *_mmu guest memory access routines
  include/exec: Split out cpu-ldst-common.h
  include/exec: Split out accel/tcg/cpu-mmu-index.h
  include/exec: Inline *_mmuidx_ra memory operations
  include/exec: Inline *_data_ra memory operations
  include/exec: Inline *_data memory operations
  include/exec: Inline *_code memory operations
  accel/tcg: Perform aligned atomic reads in translator_ld
  accel/tcg: Use cpu_ld*_code_mmu in translator.c
  accel/tcg: Implement translator_ld*_end
  accel/tcg: Remove mmap_lock/unlock from watchpoint.c
  include/exec: Split out mmap-lock.h
  include/system: Move exec/memory.h to system/memory.h
  include/system: Move exec/address-spaces.h to system/address-spaces.h
  include/system: Move exec/ioport.h to system/ioport.h
  include/system: Move exec/ram_addr.h to system/ram_addr.h
  include/system: Move exec/ramblock.h to system/ramblock.h
  meson: Introduce top-level libuser_ss and libsystem_ss
  gdbstub: Move syscalls.c out of common_ss
  accel/tcg: Use libuser_ss and libsystem_ss
  target/mips: Restrict semihosting tests to system mode
  target/xtensa: Restrict semihosting tests to system mode
  semihosting: Move user-only implementation out-of-line
  semihosting: Assert is_user in user-only semihosting_enabled
  include/exec: Split out watchpoint.h
  hw/core: Move unconditional files to libsystem_ss, libuser_ss
  system: Move most files to libsystem_ss
  plugins: Move api.c, core.c to libuser_ss, libsystem_ss
  include/exec: Drop ifndef CONFIG_USER_ONLY from cpu-common.h
  include/hw/core: Drop ifndef CONFIG_USER_ONLY from cpu.h
  include/hw/intc: Remove ifndef CONFIG_USER_ONLY from armv7m_nvic.h
  include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in css.h
  include/exec: Split out icount.h
  include/exec: Protect icount_enabled from poisoned symbols
  include/system: Remove ifndef CONFIG_USER_ONLY in qtest.h
  include/qemu: Remove ifndef CONFIG_USER_ONLY from accel.h
  target/riscv: Remove ifndef CONFIG_USER_ONLY from cpu_cfg.h
  meson: Only allow CONFIG_USER_ONLY from certain source sets
  accel/tcg: Fix argument types of tlb_reset_dirty
  accel/tcg: Pass CPUTLBEntryFull to tlb_reset_dirty_range_locked
  accel/tcg: Rebuild full flags in tlb_reset_dirty_range_locked
  include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags
  include/exec: Move tb_{,set_}page_addr[01] to translation-block.h
  accel/tcg: Move get_page_addr_code* declarations
  accel/tcg: Remove page_protect
  accel/tcg: Remove cpu-all.h, exec-all.h from tb-internal.h
  target/hexagon: Implement TCGCPUOps.mmu_index
  accel/tcg: Build translator.c twice
  accel/tcg: Split out tlb-bounds.h
  include/exec: Redefine tlb-flags with absolute values
  page-vary: Move and rename qemu_target_page_bits_min
  page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
  tcg: Pass max_threads not max_cpus to tcg_init
  accel/tcg: Remove mttcg_enabled
  accel/tcg: Move mttcg warning to tcg_init_machine

 accel/tcg/atomic_template.h                 |  16 +-
 accel/tcg/backend-ldst.h                    |  41 ++
 accel/tcg/internal-common.h                 |  34 ++
 accel/tcg/internal-target.h                 |  37 +-
 accel/tcg/tb-hash.h                         |   1 +
 accel/tcg/tb-internal.h                     |  38 +-
 accel/tcg/tlb-bounds.h                      |  32 ++
 bsd-user/bsd-mem.h                          |   1 +
 bsd-user/qemu.h                             |   2 +-
 hw/arm/strongarm.h                          |   2 +-
 hw/display/apple-gfx.h                      |   2 +-
 hw/display/framebuffer.h                    |   2 +-
 hw/display/vga_int.h                        |   4 +-
 hw/hyperv/hv-balloon-our_range_memslots.h   |   2 +-
 hw/intc/ioapic_internal.h                   |   2 +-
 hw/net/i82596.h                             |   4 +-
 hw/net/pcnet.h                              |   2 +-
 hw/s390x/ipl.h                              |   4 +-
 hw/tpm/tpm_ppi.h                            |   2 +-
 hw/usb/hcd-uhci.h                           |   2 +-
 hw/vfio/pci.h                               |   2 +-
 hw/virtio/vhost-iova-tree.h                 |   2 +-
 include/accel/tcg/cpu-ldst-common.h         | 122 +++++
 include/accel/tcg/cpu-ldst.h                | 563 ++++++++++++++++++++
 include/accel/tcg/cpu-mmu-index.h           |  42 ++
 include/accel/tcg/cpu-ops.h                 |  19 +
 include/exec/cpu-all.h                      | 176 ------
 include/exec/cpu-common.h                   |  26 -
 include/exec/cpu-defs.h                     |  10 +-
 include/exec/cpu_ldst.h                     | 372 -------------
 include/exec/cputlb.h                       |   2 +-
 include/exec/exec-all.h                     |  87 ---
 include/exec/icount.h                       |  76 +++
 include/exec/mmap-lock.h                    |  33 ++
 include/exec/page-protection.h              |  22 -
 include/exec/page-vary.h                    |   9 +
 include/exec/poison.h                       |  10 +-
 include/exec/target_page.h                  |   2 -
 include/exec/tlb-flags.h                    |  86 +++
 include/exec/translation-block.h            |  50 ++
 include/exec/translator.h                   |  50 +-
 include/exec/tswap.h                        |  81 ++-
 include/exec/watchpoint.h                   |  41 ++
 include/hw/acpi/acpi.h                      |   2 +-
 include/hw/acpi/ich9_tco.h                  |   2 +-
 include/hw/arm/fsl-imx25.h                  |   2 +-
 include/hw/arm/fsl-imx31.h                  |   2 +-
 include/hw/arm/fsl-imx6.h                   |   2 +-
 include/hw/arm/fsl-imx6ul.h                 |   2 +-
 include/hw/arm/omap.h                       |   2 +-
 include/hw/arm/stm32l4x5_soc.h              |   2 +-
 include/hw/boards.h                         |   2 +-
 include/hw/char/parallel-isa.h              |   2 +-
 include/hw/char/parallel.h                  |   2 +-
 include/hw/char/riscv_htif.h                |   2 +-
 include/hw/char/serial-mm.h                 |   2 +-
 include/hw/char/serial.h                    |   2 +-
 include/hw/core/cpu.h                       |  54 +-
 include/hw/display/macfb.h                  |   2 +-
 include/hw/dma/i8257.h                      |   2 +-
 include/hw/fsi/aspeed_apb2opb.h             |   2 +-
 include/hw/fsi/cfam.h                       |   2 +-
 include/hw/fsi/fsi-master.h                 |   2 +-
 include/hw/fsi/fsi.h                        |   2 +-
 include/hw/fsi/lbus.h                       |   2 +-
 include/hw/gpio/npcm7xx_gpio.h              |   2 +-
 include/hw/hw.h                             |   4 -
 include/hw/i2c/npcm7xx_smbus.h              |   2 +-
 include/hw/i2c/pm_smbus.h                   |   2 +-
 include/hw/i386/apic_internal.h             |   2 +-
 include/hw/i386/x86.h                       |   2 +-
 include/hw/ide/ahci.h                       |   2 +-
 include/hw/ide/ide-bus.h                    |   2 +-
 include/hw/intc/armv7m_nvic.h               |  14 -
 include/hw/ipmi/ipmi.h                      |   2 +-
 include/hw/isa/apm.h                        |   2 +-
 include/hw/isa/isa.h                        |   4 +-
 include/hw/m68k/q800.h                      |   2 +-
 include/hw/mem/npcm7xx_mc.h                 |   2 +-
 include/hw/mem/pc-dimm.h                    |   2 +-
 include/hw/mips/mips.h                      |   2 +-
 include/hw/misc/auxbus.h                    |   2 +-
 include/hw/misc/ivshmem-flat.h              |   2 +-
 include/hw/misc/lasi.h                      |   2 +-
 include/hw/misc/mac_via.h                   |   2 +-
 include/hw/misc/npcm7xx_mft.h               |   2 +-
 include/hw/misc/npcm_clk.h                  |   2 +-
 include/hw/misc/npcm_gcr.h                  |   2 +-
 include/hw/misc/pvpanic.h                   |   2 +-
 include/hw/net/dp8393x.h                    |   2 +-
 include/hw/net/msf2-emac.h                  |   2 +-
 include/hw/nubus/nubus.h                    |   2 +-
 include/hw/nvram/mac_nvram.h                |   2 +-
 include/hw/nvram/npcm7xx_otp.h              |   2 +-
 include/hw/pci-host/fsl_imx8m_phy.h         |   2 +-
 include/hw/pci-host/pam.h                   |   2 +-
 include/hw/pci-host/remote.h                |   2 +-
 include/hw/pci/pci.h                        |   2 +-
 include/hw/pci/pcie_host.h                  |   2 +-
 include/hw/pci/shpc.h                       |   2 +-
 include/hw/ppc/mac_dbdma.h                  |   2 +-
 include/hw/ppc/pnv_lpc.h                    |   2 +-
 include/hw/ppc/pnv_occ.h                    |   2 +-
 include/hw/ppc/pnv_sbe.h                    |   2 +-
 include/hw/ppc/pnv_xscom.h                  |   2 +-
 include/hw/ppc/ppc4xx.h                     |   2 +-
 include/hw/ppc/vof.h                        |   4 +-
 include/hw/ppc/xics.h                       |   2 +-
 include/hw/register.h                       |   2 +-
 include/hw/remote/proxy-memory-listener.h   |   2 +-
 include/hw/s390x/css.h                      |   2 -
 include/hw/sh4/sh_intc.h                    |   2 +-
 include/hw/southbridge/ich9.h               |   2 +-
 include/hw/sysbus.h                         |   2 +-
 include/hw/timer/npcm7xx_timer.h            |   2 +-
 include/hw/tricore/triboard.h               |   2 +-
 include/hw/tricore/tricore.h                |   2 +-
 include/hw/usb.h                            |   2 +-
 include/hw/vfio/vfio-common.h               |   2 +-
 include/hw/vfio/vfio-container-base.h       |   2 +-
 include/hw/virtio/vhost-backend.h           |   2 +-
 include/hw/virtio/vhost.h                   |   2 +-
 include/hw/virtio/virtio.h                  |   2 +-
 include/hw/xen/xen-pvh-common.h             |   2 +-
 include/hw/xtensa/mx_pic.h                  |   2 +-
 include/qemu/accel.h                        |  10 +-
 include/qemu/bswap.h                        |   2 +-
 include/qemu/iova-tree.h                    |   2 +-
 include/qemu/reserved-region.h              |   2 +-
 include/semihosting/semihost.h              |  29 +-
 include/{exec => system}/address-spaces.h   |   8 +-
 include/system/confidential-guest-support.h |   4 -
 include/system/cpu-timers.h                 |  58 --
 include/system/dma.h                        |   4 +-
 include/system/hostmem.h                    |   2 +-
 include/{exec => system}/ioport.h           |   8 +-
 include/system/kvm.h                        |   6 +-
 include/system/kvm_int.h                    |   2 +-
 include/{exec => system}/memory.h           |  38 +-
 include/system/qtest.h                      |   2 -
 include/{exec => system}/ram_addr.h         |  20 +-
 include/{exec => system}/ramblock.h         |   9 +-
 include/system/replay.h                     |   4 -
 include/system/tcg.h                        |   8 +
 include/system/vhost-user-backend.h         |   2 +-
 include/system/xen-mapcache.h               |  41 --
 include/system/xen.h                        |  25 +-
 include/tcg/insn-start-words.h              |   6 +-
 include/tcg/startup.h                       |   6 +-
 include/tcg/tcg-op.h                        |   3 +-
 include/user/page-protection.h              |   1 -
 linux-user/qemu.h                           |   5 +-
 migration/rdma.h                            |   2 +-
 rust/wrapper.h                              |   4 +-
 {include/exec => system}/memory-internal.h  |  27 +-
 target/alpha/cpu-param.h                    |   4 +-
 target/alpha/cpu.h                          |   4 +-
 target/arm/cpu-param.h                      |  11 +-
 target/arm/cpu.h                            |  46 +-
 target/arm/internals.h                      |   2 +
 target/arm/tcg/sve_ldst_internal.h          |   2 +-
 target/avr/cpu-param.h                      |   2 +-
 target/avr/cpu.h                            |   6 +-
 target/hexagon/cpu-param.h                  |   2 +
 target/hexagon/cpu.h                        |   3 +-
 target/hppa/cpu-param.h                     |   8 +-
 target/hppa/cpu.h                           |   7 +-
 target/i386/cpu-param.h                     |   3 +-
 target/i386/cpu.h                           |  10 +-
 target/i386/hvf/vmx.h                       |   3 +-
 target/i386/tcg/seg_helper.h                |  10 +-
 target/i386/tcg/tcg-cpu.h                   |   6 +
 target/loongarch/cpu-param.h                |   2 +-
 target/loongarch/cpu.h                      |   6 +-
 target/m68k/cpu-param.h                     |   2 +
 target/m68k/cpu.h                           |   6 +-
 target/microblaze/cpu-param.h               |   3 +-
 target/microblaze/cpu.h                     |   6 +-
 target/mips/cpu-param.h                     |   2 +-
 target/mips/cpu.h                           |   8 +-
 target/openrisc/cpu-param.h                 |   2 +-
 target/openrisc/cpu.h                       |   6 +-
 target/ppc/cpu-param.h                      |   3 +-
 target/ppc/cpu.h                            |   4 +-
 target/ppc/helper_regs.h                    |   2 +
 target/ppc/mmu-hash32.h                     |   2 +
 target/ppc/mmu-hash64.h                     |   2 +
 target/riscv/cpu-param.h                    |  10 +-
 target/riscv/cpu.h                          |  10 +-
 target/riscv/cpu_cfg.h                      |   2 -
 target/riscv/tcg/tcg-cpu.h                  |   2 +
 target/rx/cpu-param.h                       |   2 +
 target/rx/cpu.h                             |   4 +-
 target/s390x/cpu-param.h                    |   6 +-
 target/s390x/cpu.h                          |   6 +-
 target/sh4/cpu-param.h                      |   2 +
 target/sh4/cpu.h                            |   6 +-
 target/sparc/cpu-param.h                    |  23 +-
 target/sparc/cpu.h                          |   5 +-
 target/tricore/cpu-param.h                  |   2 +
 target/tricore/cpu.h                        |   3 +-
 target/xtensa/cpu-param.h                   |   3 +-
 target/xtensa/cpu.h                         |   4 +-
 tcg/tcg-internal.h                          |   2 +-
 accel/hvf/hvf-accel-ops.c                   |   2 +-
 accel/kvm/kvm-all.c                         |   9 +-
 accel/tcg/cpu-exec.c                        |   8 +-
 accel/tcg/cputlb.c                          |  98 ++--
 accel/tcg/icount-common.c                   |   2 +-
 accel/tcg/monitor.c                         |   1 +
 accel/tcg/plugin-gen.c                      |  13 +-
 accel/tcg/tb-maint.c                        |   3 +
 accel/tcg/tcg-accel-ops-icount.c            |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c             |   2 +-
 accel/tcg/tcg-accel-ops-rr.c                |   2 +-
 accel/tcg/tcg-accel-ops.c                   |   3 +-
 accel/tcg/tcg-all.c                         |  98 ++--
 accel/tcg/translate-all.c                   |  14 +-
 accel/tcg/translator.c                      | 135 +++--
 accel/tcg/user-exec.c                       | 116 +---
 accel/tcg/watchpoint.c                      |   3 -
 backends/tpm/tpm_util.c                     |   2 +-
 block/blkio.c                               |   4 +-
 bsd-user/mmap.c                             |   1 +
 cpu-target.c                                |   7 +
 disas/disas-mon.c                           |   2 +-
 hw/acpi/erst.c                              |   4 +-
 hw/alpha/dp264.c                            |   1 +
 hw/alpha/typhoon.c                          |   1 +
 hw/arm/aspeed_ast10x0.c                     |   2 +-
 hw/arm/bananapi_m2u.c                       |   2 +-
 hw/arm/boot.c                               |   2 +
 hw/arm/collie.c                             |   2 +-
 hw/arm/digic_boards.c                       |   2 +-
 hw/arm/exynos4_boards.c                     |   2 +-
 hw/arm/fsl-imx31.c                          |   2 +-
 hw/arm/fsl-imx8mp.c                         |   2 +-
 hw/arm/imx8mp-evk.c                         |   2 +-
 hw/arm/integratorcp.c                       |   2 +-
 hw/arm/kzm.c                                |   2 +-
 hw/arm/microbit.c                           |   2 +-
 hw/arm/mps2-tz.c                            |   2 +-
 hw/arm/mps2.c                               |   2 +-
 hw/arm/mps3r.c                              |   2 +-
 hw/arm/msf2-soc.c                           |   2 +-
 hw/arm/msf2-som.c                           |   2 +-
 hw/arm/musca.c                              |   2 +-
 hw/arm/omap1.c                              |   2 +-
 hw/arm/omap_sx1.c                           |   2 +-
 hw/arm/orangepi.c                           |   2 +-
 hw/arm/smmuv3.c                             |   1 +
 hw/arm/stellaris.c                          |   2 +-
 hw/arm/stm32f100_soc.c                      |   2 +-
 hw/arm/stm32f205_soc.c                      |   2 +-
 hw/arm/stm32f405_soc.c                      |   2 +-
 hw/arm/stm32l4x5_soc.c                      |   2 +-
 hw/arm/xlnx-versal.c                        |   2 -
 hw/arm/xlnx-zynqmp.c                        |   2 -
 hw/avr/atmega.c                             |   5 +-
 hw/block/fdc-isa.c                          |   2 +-
 hw/block/fdc-sysbus.c                       |   2 +-
 hw/char/goldfish_tty.c                      |   2 +-
 hw/char/omap_uart.c                         |   2 +-
 hw/char/riscv_htif.c                        |   2 +-
 hw/core/cpu-system.c                        |   4 +-
 hw/core/loader-fit.c                        |   2 +-
 hw/core/loader.c                            |   2 +-
 hw/core/null-machine.c                      |   2 +-
 hw/core/ptimer.c                            |   2 +-
 hw/core/sysbus.c                            |   2 +-
 hw/display/edid-region.c                    |   2 +-
 hw/display/virtio-gpu-udmabuf.c             |   2 +-
 hw/dma/rc4030.c                             |   2 +-
 hw/hppa/machine.c                           |   1 +
 hw/hyperv/hv-balloon.c                      |   4 +-
 hw/hyperv/hyperv.c                          |   6 +-
 hw/hyperv/syndbg.c                          |   1 +
 hw/hyperv/vmbus.c                           |   1 +
 hw/i386/acpi-common.c                       |   2 +-
 hw/i386/acpi-microvm.c                      |   2 +-
 hw/i386/kvm/xen_evtchn.c                    |   2 +-
 hw/i386/kvm/xen_gnttab.c                    |   2 +-
 hw/i386/kvm/xen_overlay.c                   |   2 +-
 hw/i386/multiboot.c                         |   1 +
 hw/i386/pc.c                                |   1 +
 hw/i386/pc_piix.c                           |   2 +-
 hw/i386/pc_sysfw_ovmf.c                     |   1 +
 hw/i386/sgx-epc.c                           |   2 +-
 hw/i386/sgx.c                               |   2 +-
 hw/i386/vapic.c                             |   3 +-
 hw/ide/ahci-sysbus.c                        |   2 +-
 hw/input/lasips2.c                          |   2 +-
 hw/intc/loongarch_extioi.c                  |   2 +-
 hw/intc/mips_gic.c                          |   2 +-
 hw/intc/ompic.c                             |   2 +-
 hw/intc/riscv_aplic.c                       |   2 +-
 hw/intc/riscv_imsic.c                       |   2 +-
 hw/loongarch/virt.c                         |   3 +-
 hw/m68k/next-cube.c                         |   1 +
 hw/m68k/q800.c                              |   1 +
 hw/m68k/virt.c                              |   1 +
 hw/mem/memory-device.c                      |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c         |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c    |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c             |   2 +-
 hw/mips/mipssim.c                           |   2 +-
 hw/misc/allwinner-h3-dramc.c                |   2 +-
 hw/misc/allwinner-r40-dramc.c               |   2 +-
 hw/misc/ivshmem-flat.c                      |   2 +-
 hw/misc/mac_via.c                           |   2 +-
 hw/net/i82596.c                             |   2 +-
 hw/net/ne2000.c                             |   2 +-
 hw/nvram/fw_cfg.c                           |   2 +-
 hw/openrisc/boot.c                          |   1 +
 hw/openrisc/openrisc_sim.c                  |   2 +-
 hw/openrisc/virt.c                          |   2 +-
 hw/pci-bridge/pci_bridge_dev.c              |   2 +-
 hw/pci-host/astro.c                         |   1 +
 hw/pci-host/mv64361.c                       |   2 +-
 hw/pci-host/remote.c                        |   2 +-
 hw/ppc/e500.c                               |   1 +
 hw/ppc/mac_newworld.c                       |   1 +
 hw/ppc/mac_oldworld.c                       |   1 +
 hw/ppc/pegasos2.c                           |   2 +-
 hw/ppc/pnv_homer.c                          |   2 +-
 hw/ppc/pnv_psi.c                            |   2 +-
 hw/ppc/ppc.c                                |   1 +
 hw/ppc/ppc4xx_sdram.c                       |   2 +-
 hw/ppc/ppc_booke.c                          |   1 +
 hw/ppc/prep.c                               |   1 +
 hw/ppc/prep_systemio.c                      |   2 +-
 hw/ppc/rs6000_mc.c                          |   2 +-
 hw/ppc/sam460ex.c                           |   2 +-
 hw/ppc/spapr.c                              |   2 +-
 hw/ppc/spapr_caps.c                         |   2 +-
 hw/ppc/spapr_hcall.c                        |   1 +
 hw/ppc/spapr_nested.c                       |   1 +
 hw/ppc/spapr_ovec.c                         |   3 +-
 hw/ppc/spapr_pci.c                          |   2 +-
 hw/ppc/vof.c                                |   2 +-
 hw/remote/iommu.c                           |   4 +-
 hw/remote/machine.c                         |   2 +-
 hw/remote/memory.c                          |   2 +-
 hw/remote/proxy-memory-listener.c           |   4 +-
 hw/remote/vfio-user-obj.c                   |   2 +-
 hw/riscv/microblaze-v-generic.c             |   2 +-
 hw/riscv/opentitan.c                        |   2 +-
 hw/riscv/riscv-iommu-pci.c                  |   1 +
 hw/riscv/riscv-iommu.c                      |   1 +
 hw/riscv/shakti_c.c                         |   2 +-
 hw/s390x/css.c                              |   2 +-
 hw/s390x/s390-pci-bus.c                     |   1 +
 hw/s390x/s390-pci-inst.c                    |   3 +-
 hw/s390x/s390-skeys.c                       |   3 +-
 hw/s390x/s390-stattrib-kvm.c                |   2 +-
 hw/s390x/s390-stattrib.c                    |   2 +-
 hw/s390x/s390-virtio-ccw.c                  |   2 +-
 hw/s390x/virtio-ccw.c                       |   2 +-
 hw/sh4/sh7750.c                             |   1 +
 hw/sparc/sun4m.c                            |   1 +
 hw/sparc/sun4m_iommu.c                      |   2 +-
 hw/sparc64/sun4u.c                          |   1 +
 hw/sparc64/sun4u_iommu.c                    |   2 +-
 hw/timer/hpet.c                             |   2 +-
 hw/timer/sh_timer.c                         |   2 +-
 hw/tpm/tpm_crb.c                            |   2 +-
 hw/vfio/ap.c                                |   2 +-
 hw/vfio/ccw.c                               |   2 +-
 hw/vfio/common.c                            |   7 +-
 hw/vfio/container.c                         |   6 +-
 hw/vfio/platform.c                          |   4 +-
 hw/vfio/spapr.c                             |   4 +-
 hw/virtio/vhost-user.c                      |   2 +-
 hw/virtio/vhost-vdpa.c                      |   2 +-
 hw/virtio/virtio-balloon.c                  |   2 +-
 hw/virtio/virtio-bus.c                      |   2 +-
 hw/virtio/virtio-mem.c                      |   2 +-
 hw/xen/xen_stubs.c                          |  51 ++
 hw/xtensa/pic_cpu.c                         |   1 +
 hw/xtensa/sim.c                             |   2 +-
 hw/xtensa/virt.c                            |   2 +-
 hw/xtensa/xtensa_memory.c                   |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 linux-user/arm/cpu_loop.c                   |   1 +
 linux-user/elfload.c                        |   1 +
 linux-user/flatload.c                       |   1 +
 linux-user/mmap.c                           |   1 +
 linux-user/syscall.c                        |   1 +
 migration/dirtyrate.c                       |   4 +-
 migration/file.c                            |   2 +-
 migration/multifd-nocomp.c                  |   2 +-
 migration/multifd-qatzip.c                  |   2 +-
 migration/multifd-qpl.c                     |   2 +-
 migration/multifd-uadk.c                    |   2 +-
 migration/multifd-zero-page.c               |   2 +-
 migration/multifd-zlib.c                    |   2 +-
 migration/multifd-zstd.c                    |   2 +-
 migration/multifd.c                         |   2 +-
 migration/postcopy-ram.c                    |   2 +-
 migration/ram.c                             |   2 +-
 migration/rdma.c                            |   2 +-
 migration/savevm.c                          |   8 +-
 monitor/hmp-cmds-target.c                   |   5 +-
 monitor/hmp-cmds.c                          |   4 +-
 page-target.c                               |   5 -
 page-vary-target.c                          |  48 +-
 replay/replay.c                             |   2 +-
 semihosting/stubs-all.c                     |   6 +
 semihosting/stubs-system.c                  |   6 -
 semihosting/uaccess.c                       |   4 +-
 semihosting/user.c                          |  21 +
 stubs/icount.c                              |   2 +-
 stubs/ram-block.c                           |   2 +-
 system/cpu-timers.c                         |   1 +
 system/dirtylimit.c                         |   2 +-
 system/dma-helpers.c                        |   2 +-
 system/ioport.c                             |   7 +-
 system/memory.c                             |  27 +-
 system/memory_mapping.c                     |   4 +-
 system/physmem.c                            |   9 +-
 system/qtest.c                              |   4 +-
 system/vl.c                                 |   1 +
 system/watchpoint.c                         |   1 +
 target/alpha/cpu.c                          |   7 +-
 target/alpha/helper.c                       |   2 +
 target/alpha/mem_helper.c                   |   2 +-
 target/alpha/translate.c                    |   1 +
 target/arm/cpu.c                            |  18 +-
 target/arm/debug_helper.c                   |   1 +
 target/arm/gdbstub64.c                      |   4 +
 target/arm/helper.c                         |   8 +
 target/arm/hvf/hvf.c                        |   3 +-
 target/arm/kvm.c                            |   2 +-
 target/arm/ptw.c                            |   2 +
 target/arm/tcg/cpu-v7m.c                    |   5 +
 target/arm/tcg/helper-a64.c                 |   4 +-
 target/arm/tcg/hflags.c                     |   4 +-
 target/arm/tcg/m_helper.c                   |   2 +-
 target/arm/tcg/mte_helper.c                 |   5 +-
 target/arm/tcg/mve_helper.c                 |   2 +-
 target/arm/tcg/op_helper.c                  |   3 +-
 target/arm/tcg/pauth_helper.c               |   2 +-
 target/arm/tcg/sme_helper.c                 |   2 +-
 target/arm/tcg/sve_helper.c                 |   3 +
 target/arm/tcg/tlb-insns.c                  |   1 +
 target/arm/tcg/translate-a64.c              |   2 +-
 target/arm/tcg/translate.c                  |   1 +
 target/avr/cpu.c                            |   6 +-
 target/avr/helper.c                         |   3 +-
 target/avr/translate.c                      |   1 +
 target/hexagon/cpu.c                        |   9 +
 target/hexagon/op_helper.c                  |   2 +-
 target/hexagon/translate.c                  |   2 +-
 target/hppa/cpu.c                           |  12 +-
 target/hppa/mem_helper.c                    |   2 +
 target/hppa/op_helper.c                     |   2 +-
 target/hppa/translate.c                     |   1 +
 target/i386/arch_memory_mapping.c           |   1 +
 target/i386/cpu-apic.c                      |   2 +-
 target/i386/cpu.c                           |  41 +-
 target/i386/helper.c                        |   2 +
 target/i386/kvm/hyperv.c                    |   1 +
 target/i386/kvm/kvm.c                       |   1 +
 target/i386/kvm/xen-emu.c                   |   3 +-
 target/i386/machine.c                       |   2 +-
 target/i386/nvmm/nvmm-all.c                 |   4 +-
 target/i386/sev.c                           |   3 +-
 target/i386/tcg/access.c                    |   3 +-
 target/i386/tcg/fpu_helper.c                |   2 +-
 target/i386/tcg/mem_helper.c                |   2 +-
 target/i386/tcg/mpx_helper.c                |   3 +-
 target/i386/tcg/seg_helper.c                |  19 +-
 target/i386/tcg/system/bpt_helper.c         |   1 +
 target/i386/tcg/system/excp_helper.c        |   5 +-
 target/i386/tcg/system/misc_helper.c        |   5 +-
 target/i386/tcg/system/seg_helper.c         |   2 +-
 target/i386/tcg/system/svm_helper.c         |   2 +-
 target/i386/tcg/system/tcg-cpu.c            |   3 +-
 target/i386/tcg/tcg-cpu.c                   |  39 +-
 target/i386/tcg/translate.c                 |   2 +
 target/i386/tcg/user/seg_helper.c           |   2 +-
 target/i386/whpx/whpx-all.c                 |   4 +-
 target/i386/xsave_helper.c                  |   1 +
 target/loongarch/cpu.c                      |   7 +-
 target/loongarch/cpu_helper.c               |   2 +
 target/loongarch/kvm/kvm.c                  |   2 +-
 target/loongarch/tcg/csr_helper.c           |   2 +-
 target/loongarch/tcg/fpu_helper.c           |   2 +-
 target/loongarch/tcg/iocsr_helper.c         |   2 +-
 target/loongarch/tcg/op_helper.c            |   2 +-
 target/loongarch/tcg/tlb_helper.c           |   3 +-
 target/loongarch/tcg/translate.c            |   1 +
 target/m68k/cpu.c                           |   6 +-
 target/m68k/fpu_helper.c                    |   2 +-
 target/m68k/helper.c                        |   2 +
 target/m68k/op_helper.c                     |   2 +-
 target/m68k/translate.c                     |   1 +
 target/microblaze/cpu.c                     |   8 +-
 target/microblaze/helper.c                  |   2 +
 target/microblaze/mmu.c                     |   2 +
 target/microblaze/op_helper.c               |   2 +-
 target/microblaze/translate.c               |   3 +-
 target/mips/cpu.c                           |  23 +-
 target/mips/tcg/ldst_helper.c               |   2 +-
 target/mips/tcg/msa_helper.c                |   3 +-
 target/mips/tcg/system/cp0_helper.c         |   1 +
 target/mips/tcg/system/tlb_helper.c         |   3 +-
 target/mips/tcg/translate.c                 |   1 +
 target/openrisc/cpu.c                       |   5 +-
 target/openrisc/mmu.c                       |   1 +
 target/openrisc/sys_helper.c                |   1 +
 target/openrisc/translate.c                 |   3 +-
 target/ppc/cpu.c                            |   1 +
 target/ppc/cpu_init.c                       |  16 +-
 target/ppc/excp_helper.c                    |   1 +
 target/ppc/kvm.c                            |   2 +-
 target/ppc/mem_helper.c                     |   3 +-
 target/ppc/mmu-book3s-v3.c                  |   1 +
 target/ppc/mmu-hash32.c                     |   1 +
 target/ppc/mmu-hash64.c                     |   1 +
 target/ppc/mmu-radix64.c                    |   1 +
 target/ppc/mmu_common.c                     |   1 +
 target/ppc/mmu_helper.c                     |   3 +-
 target/ppc/tcg-excp_helper.c                |   3 +-
 target/ppc/translate.c                      |   1 +
 target/riscv/bitmanip_helper.c              |   2 +-
 target/riscv/cpu.c                          |  19 +-
 target/riscv/cpu_helper.c                   |   4 +-
 target/riscv/csr.c                          |   2 +-
 target/riscv/debug.c                        |   2 +
 target/riscv/kvm/kvm-cpu.c                  |   2 +-
 target/riscv/machine.c                      |   2 +-
 target/riscv/op_helper.c                    |   3 +-
 target/riscv/pmp.c                          |   1 +
 target/riscv/pmu.c                          |   2 +-
 target/riscv/tcg/tcg-cpu.c                  |  32 +-
 target/riscv/translate.c                    |   2 +-
 target/riscv/vector_helper.c                |   5 +-
 target/riscv/zce_helper.c                   |   2 +-
 target/rx/cpu.c                             |   9 +-
 target/rx/helper.c                          |   2 +-
 target/rx/op_helper.c                       |   2 +-
 target/s390x/cpu.c                          |  19 +-
 target/s390x/helper.c                       |   2 +
 target/s390x/ioinst.c                       |   1 +
 target/s390x/kvm/kvm.c                      |   2 +-
 target/s390x/mmu_helper.c                   |   3 +-
 target/s390x/sigp.c                         |   2 +-
 target/s390x/tcg/crypto_helper.c            |   2 +-
 target/s390x/tcg/excp_helper.c              |   4 +-
 target/s390x/tcg/int_helper.c               |   2 +-
 target/s390x/tcg/mem_helper.c               |   4 +-
 target/s390x/tcg/misc_helper.c              |   3 +-
 target/s390x/tcg/vec_helper.c               |   2 +-
 target/sh4/cpu.c                            |   6 +-
 target/sh4/helper.c                         |   1 +
 target/sh4/op_helper.c                      |   2 +-
 target/sh4/translate.c                      |   1 +
 target/sparc/cpu.c                          |  27 +-
 target/sparc/int32_helper.c                 |   2 +-
 target/sparc/ldst_helper.c                  |   4 +-
 target/sparc/mmu_helper.c                   |   4 +
 target/sparc/translate.c                    |   1 +
 target/tricore/cpu.c                        |   5 +-
 target/tricore/helper.c                     |   2 +
 target/tricore/op_helper.c                  |   2 +-
 target/tricore/translate.c                  |   3 +-
 target/xtensa/cpu.c                         |   8 +-
 target/xtensa/dbg_helper.c                  |   3 +-
 target/xtensa/helper.c                      |   1 +
 target/xtensa/mmu_helper.c                  |   3 +
 target/xtensa/op_helper.c                   |   1 +
 target/xtensa/translate.c                   |  25 +-
 target/xtensa/xtensa-semi.c                 |   1 +
 tcg/region.c                                |  27 +-
 tcg/tcg-op-ldst.c                           |   2 +-
 tcg/tcg.c                                   |  14 +-
 tests/qtest/fuzz/generic_fuzz.c             |   4 +-
 tests/qtest/fuzz/qos_fuzz.c                 |   2 +-
 tests/qtest/fuzz/qtest_wrappers.c           |   2 +-
 tests/unit/test-resv-mem.c                  |   2 +-
 ui/console.c                                |   2 +-
 util/async.c                                |   2 +-
 util/main-loop.c                            |   1 +
 util/qemu-timer.c                           |   1 +
 util/vfio-helpers.c                         |   2 +-
 MAINTAINERS                                 |  10 +-
 accel/tcg/ldst_common.c.inc                 | 335 +-----------
 accel/tcg/meson.build                       |  27 +-
 configs/targets/aarch64-softmmu.mak         |   1 -
 configs/targets/alpha-softmmu.mak           |   1 -
 configs/targets/arm-softmmu.mak             |   1 -
 configs/targets/hppa-softmmu.mak            |   1 -
 configs/targets/i386-softmmu.mak            |   1 -
 configs/targets/loongarch64-softmmu.mak     |   1 -
 configs/targets/microblaze-softmmu.mak      |   1 -
 configs/targets/microblazeel-softmmu.mak    |   1 -
 configs/targets/mips-softmmu.mak            |   1 -
 configs/targets/mipsel-softmmu.mak          |   1 -
 configs/targets/or1k-softmmu.mak            |   1 -
 configs/targets/ppc64-softmmu.mak           |   1 -
 configs/targets/riscv32-softmmu.mak         |   1 -
 configs/targets/riscv64-softmmu.mak         |   1 -
 configs/targets/s390x-softmmu.mak           |   1 -
 configs/targets/sparc-softmmu.mak           |   1 -
 configs/targets/sparc64-softmmu.mak         |   1 -
 configs/targets/x86_64-softmmu.mak          |   1 -
 configs/targets/xtensa-softmmu.mak          |   1 -
 configs/targets/xtensaeb-softmmu.mak        |   1 -
 docs/devel/memory.rst                       |   2 +-
 docs/devel/multi-thread-tcg.rst             |   6 +-
 gdbstub/meson.build                         |  36 +-
 hw/arm/meson.build                          | 117 ++--
 hw/core/meson.build                         |   4 +-
 hw/display/apple-gfx.m                      |   2 +-
 hw/xen/meson.build                          |   3 +
 include/exec/memory_ldst.h.inc              |   4 -
 include/exec/memory_ldst_phys.h.inc         |   5 +-
 meson.build                                 |  61 ++-
 plugins/meson.build                         |   5 +-
 scripts/analyze-inclusions                  |   2 +-
 semihosting/meson.build                     |   5 +-
 system/meson.build                          |  13 +-
 tcg/meson.build                             |  23 +-
 624 files changed, 2845 insertions(+), 2613 deletions(-)
 create mode 100644 accel/tcg/backend-ldst.h
 create mode 100644 accel/tcg/tlb-bounds.h
 create mode 100644 include/accel/tcg/cpu-ldst-common.h
 create mode 100644 include/accel/tcg/cpu-ldst.h
 create mode 100644 include/accel/tcg/cpu-mmu-index.h
 delete mode 100644 include/exec/cpu-all.h
 delete mode 100644 include/exec/cpu_ldst.h
 create mode 100644 include/exec/icount.h
 create mode 100644 include/exec/mmap-lock.h
 create mode 100644 include/exec/tlb-flags.h
 create mode 100644 include/exec/watchpoint.h
 rename include/{exec => system}/address-spaces.h (89%)
 rename include/{exec => system}/ioport.h (96%)
 rename include/{exec => system}/memory.h (99%)
 rename include/{exec => system}/ram_addr.h (98%)
 rename include/{exec => system}/ramblock.h (96%)
 rename {include/exec => system}/memory-internal.h (69%)
 create mode 100644 hw/xen/xen_stubs.c
 create mode 100644 semihosting/user.c

-- 
2.43.0



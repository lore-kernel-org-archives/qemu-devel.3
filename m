Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EDAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffV-0005mu-AR; Fri, 20 Dec 2024 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffT-0005mc-Pu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffP-0006E4-RI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:15:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso22634815e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711354; x=1735316154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JncZ6BL5z5/berqdM2J3gA+nZ6823bOaL8ZJEcWwaio=;
 b=OWTiS8VIky99+sndwG74O5Fr60+ZrEa6UDkFw0RxdA0eYcrR1pfenqWqkC8qp7VXV2
 zKdqmYK/Y03ClCkE42U2gbvivelwdJRwMVXGGc+v2G0Jki80kk9U8YJPtkGmgQuRM37t
 OKFqFAkxqLh6QLjc/HQkc8ZGkfBtUUq4ZIzPbspfJNL4AC1e9o3LtbfhFzvTTKrii9lx
 zufqsBxknIQOU+MqLQvjP1baaCMVMoY90CPybr/3HY/a6ofNRfT4DdQGocF7JOCnHsw3
 QeRrpgknabMYS6DGwAIcv/XpNaI+lG2vTopyfuE1m2p3y/8SZz3WEQxORUMSP25jZ3gn
 YQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711354; x=1735316154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JncZ6BL5z5/berqdM2J3gA+nZ6823bOaL8ZJEcWwaio=;
 b=U0DNWPgT9iI2o3SBwguMQPqxUxlLsMAUIV+gw2GggZzLjxAHyxa9G8QAL+HZuhPvgU
 6Xea5menrp+gUTMBoBOgmBGDHPXT8x6BvI4jg+kiMHyy2WfcJfy9DPGZ105uA28jtcLt
 MAzyAGnCwejTz1b7iuI4lYmmKdCoLVtwW5ws4TI/2jJWzDCTSlhIiEK8xUSwtxHdLtV7
 65QAvah7QUsklaFt1K2g3X4pc22F76CVrcoAotu5miNh7lvfj8MqMlgd3JX4wHKMVm1o
 gbYOJMTedFdiMB3Il1qh+j2+vH0Jwv1CLzpwH4gEcbHzCqCH6VvEIL7MIIZHVSpQ2ths
 unrQ==
X-Gm-Message-State: AOJu0YwRCljGjfAfbGaSXneFjkfR9He6cQx7YdDgMJB/6bCrdsu0nNA8
 X32N/t89GgKOwD8z7/G6gYAET75+6ry2N50r9JY3T7Qf4AElsTjRfFW3kS50DP9Rf+ytg7Bo4tv
 b
X-Gm-Gg: ASbGncvMCbxs251v8uMFWEpQB38z8XIT5GU91QXqB9mbwOsadxI5z3vMAsFqlATpiYj
 o4xVo/ks+r9N6Ig+UnJOVLIHcGYU0zWtNxJNgN2RiEnsj10wGbIBNxCdP7xL6FCNg15jn0tZIx4
 ep9RHfFoHDfXkhvRy4hlkpyku/Q4xD5Xb+P6VMnQRqRTCwat+bXUY3f0JJc2J/dnR3fVaNCa5Os
 TIxx3jvIH9zpY6fhPXGt+kZjq39Pxbs7Koop9mzpSHbxxkIZ2ICdTeahj7lMqGtubYzEs2ko6I=
X-Google-Smtp-Source: AGHT+IHVmrW71tKsRXCe/kpLiugNyLEl5gENzwmLOMwb1+1FaT4L3LVYoiz7Lna1R1KSrwdLu7cU/w==
X-Received: by 2002:a05:6000:186d:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38a221fa022mr4367023f8f.33.1734711353296; 
 Fri, 20 Dec 2024 08:15:53 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm4333070f8f.37.2024.12.20.08.15.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:15:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/59] Accel & exec patches for 2024-12-20
Date: Fri, 20 Dec 2024 17:14:51 +0100
Message-ID: <20241220161551.89317-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 3e9793ab01904144c204589811e0e879109a9713:

  Merge tag 'qga-pull-2024-12-18' of https://github.com/kostyanf14/qemu into staging (2024-12-18 20:24:59 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/exec-20241220

for you to fetch changes up to fc479101f5837dce6f6ebec6241388d6c1915597:

  util/qemu-timer: fix indentation (2024-12-20 17:14:33 +0100)

----------------------------------------------------------------
Accel & Exec patch queue

- Ignore writes to CNTP_CTL_EL0 on HVF ARM (Alexander)
- Add '-d invalid_mem' logging option (Zoltan)
- Create QOM containers explicitly (Peter)
- Rename sysemu/ -> system/ (Philippe)
- Re-orderning of include/exec/ headers (Philippe)
  Move a lot of declarations from these legacy mixed bag headers:
    . "exec/cpu-all.h"
    . "exec/cpu-common.h"
    . "exec/cpu-defs.h"
    . "exec/exec-all.h"
    . "exec/translate-all"
  to these more specific ones:
    . "exec/page-protection.h"
    . "exec/translation-block.h"
    . "user/cpu_loop.h"
    . "user/guest-host.h"
    . "user/page-protection.h"

----------------------------------------------------------------

Alex Bennée (1):
  util/qemu-timer: fix indentation

Alexander Graf (1):
  hvf: arm: Ignore writes to CNTP_CTL_EL0

Anton Johansson (1):
  target/sparc: Uninline cpu_get_tb_cpu_state()

BALATON Zoltan (1):
  log: Add separate debug option for logging invalid memory accesses

Peter Xu (7):
  qom: Add TYPE_CONTAINER macro
  qom: New object_property_add_new_container()
  tests: Fix test-qdev-global-props on anonymous qdev realize()
  tests: Explicitly create containers in test_qom_partial_path()
  ppc/e500: Avoid abuse of container_get()
  hw/ppc: Explicitly create the drc container
  qom: Create system containers explicitly

Philippe Mathieu-Daudé (48):
  target/i386/sev: Reduce system specific declarations
  include: Rename sysemu/ -> system/
  system: Move 'exec/confidential-guest-support.h' to system/
  tcg/tci: Include missing 'disas/dis-asm.h' header
  accel/tcg: Include missing 'exec/tswap.h' header in translator.c
  accel/tcg: Have tlb_vaddr_to_host() use vaddr type
  exec/cpu-all: Include missing 'exec/cpu-defs.h' header
  exec/cpu-defs: Remove unnecessary headers
  exec/translation-block: Include missing 'exec/vaddr.h' header
  linux-user/aarch64: Include missing 'user/abitypes.h' header
  user: Introduce 'user/guest-host.h' header
  target/arm/cpu: Restrict cpu_untagged_addr() to user emulation
  target/arm/mte: Restrict 'exec/ram_addr.h' to system emulation
  exec/ram_addr: Include missing 'exec/hwaddr.h' and 'exec/cpu-common.h'
  include: Include missing 'qemu/clang-tsa.h' header
  accel/tcg: Declare mmap_[un]lock() in 'exec/page-protection.h'
  accel/tcg: Use tb_page_addr_t type in page_unprotect()
  accel/tcg: Move page_[un]protect() to 'user/page-protection.h'
  system: Remove unnecessary 'exec/translate-all.h' include
  accel/tcg: Move 'exec/translate-all.h' -> 'tb-internal.h'
  accel/tcg: Un-inline log_pc()
  accel/tcg: Move TranslationBlock declarations to 'tb-internal.h'
  accel/tcg: Really restrict cpu_io_recompile() to system emulation
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (1/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (2/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (3/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (4/4)
  user: Forward declare target_cpu_copy_regs structure
  user: Move 'linux-user/cpu_loop-common.h' -> 'user/cpu_loop.h'
  user: Declare cpu_loop() once in 'user/cpu_loop.h'
  user: Move various declarations out of 'exec/exec-all.h'
  target/loongarch: Declare loongarch_cpu_dump_state() locally
  target/sparc: Move sparc_restore_state_to_opc() to cpu.c
  exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is always
    defined
  accel/tcg: Declare cpu_loop_exit_requested() in 'exec/cpu-common.h'
  exec/translation-block: Include missing 'qemu/atomic.h' header
  qemu/coroutine: Include missing 'qemu/atomic.h' header
  accel/tcg: Restrict curr_cflags() declaration to 'internal-common.h'
  accel/tcg: Move tcg_cflags_has/set() to 'exec/translation-block.h'
  accel/tcg: Include missing 'exec/translation-block.h' header
  accel/tcg: Un-inline translator_is_same_page()
  target/xtensa: Remove tswap() calls in semihosting simcall() helper
  target/mips: Remove tswap() calls in semihosting uhi_fstat_cb()
  target/mips: Drop left-over comment about Jazz machine
  hw/xen: Remove unnecessary 'exec/cpu-common.h' header
  system/numa: Remove unnecessary 'exec/cpu-common.h' header
  system/accel-ops: Remove unnecessary 'exec/cpu-common.h' header
  meson: Do not define CONFIG_DEVICES on user emulation

 MAINTAINERS                                   |  76 +++++------
 docs/specs/tpm.rst                            |   8 +-
 meson.build                                   |   3 +-
 accel/kvm/kvm-cpus.h                          |   2 +-
 accel/tcg/internal-common.h                   |   3 +
 accel/tcg/internal-target.h                   |  48 +------
 accel/tcg/tb-hash.h                           |   1 +
 accel/tcg/tb-internal.h                       |  53 ++++++++
 accel/tcg/tcg-accel-ops.h                     |   2 +-
 backends/tpm/tpm_int.h                        |   2 +-
 block/coroutines.h                            |   2 +-
 block/export/virtio-blk-handler.h             |   2 +-
 bsd-user/aarch64/target_arch_cpu.h            |   2 +-
 bsd-user/arm/target_arch_cpu.h                |   2 +-
 bsd-user/bsd-mem.h                            |   1 +
 bsd-user/i386/target_arch_cpu.h               |   2 +-
 bsd-user/qemu.h                               |   3 +-
 bsd-user/riscv/target_arch_cpu.h              |   2 +-
 bsd-user/x86_64/target_arch_cpu.h             |   2 +-
 dump/win_dump.h                               |   2 +-
 hw/acpi/hmat.h                                |   2 +-
 hw/block/dataplane/xen-block.h                |   2 +-
 hw/tpm/tpm_prop.h                             |   2 +-
 hw/tpm/tpm_tis.h                              |   2 +-
 hw/usb/hcd-dwc2.h                             |   2 +-
 hw/usb/hcd-ehci.h                             |   2 +-
 hw/usb/hcd-ohci.h                             |   2 +-
 hw/usb/hcd-xhci.h                             |   2 +-
 hw/vfio/pci.h                                 |   2 +-
 include/block/block_int-common.h              |   1 +
 include/exec/cpu-all.h                        | 119 +-----------------
 include/exec/cpu-common.h                     |  24 +++-
 include/exec/cpu-defs.h                       |   8 --
 include/exec/cpu_ldst.h                       |  50 +-------
 include/exec/exec-all.h                       |  89 +------------
 include/exec/page-protection.h                |  24 ++++
 include/exec/ram_addr.h                       |   7 +-
 include/exec/translate-all.h                  |  33 -----
 include/exec/translation-block.h              |   5 +
 include/exec/translator.h                     |  15 ++-
 include/hw/acpi/tpm.h                         |   2 +-
 include/hw/arm/allwinner-a10.h                |   2 +-
 include/hw/arm/allwinner-h3.h                 |   2 +-
 include/hw/arm/allwinner-r40.h                |   2 +-
 include/hw/arm/virt.h                         |   2 +-
 include/hw/boards.h                           |   4 +-
 include/hw/core/sysemu-cpu-ops.h              |   6 +-
 include/hw/dma/xlnx-zdma.h                    |   2 +-
 include/hw/dma/xlnx_dpdma.h                   |   2 +-
 include/hw/hyperv/vmbus.h                     |   4 +-
 include/hw/i386/hostmem-epc.h                 |   2 +-
 include/hw/ide/ide-dev.h                      |   2 +-
 include/hw/isa/superio.h                      |   2 +-
 include/hw/nvram/fw_cfg.h                     |   2 +-
 include/hw/nvram/xlnx-bbram.h                 |   2 +-
 include/hw/nvram/xlnx-efuse.h                 |   2 +-
 include/hw/pci/pci.h                          |   4 +-
 include/hw/ppc/mac_dbdma.h                    |   2 +-
 include/hw/ppc/spapr.h                        |   2 +-
 include/hw/ppc/spapr_drc.h                    |   2 +-
 include/hw/ppc/spapr_vio.h                    |   2 +-
 include/hw/ppc/xive.h                         |   2 +-
 include/hw/riscv/numa.h                       |   2 +-
 include/hw/s390x/css.h                        |   2 +-
 include/hw/s390x/s390-pci-inst.h              |   2 +-
 include/hw/tricore/triboard.h                 |   2 +-
 include/hw/vfio/vfio-common.h                 |   6 +-
 include/hw/virtio/virtio-balloon.h            |   2 +-
 include/hw/virtio/virtio-blk.h                |   6 +-
 include/hw/virtio/virtio-crypto.h             |   4 +-
 include/hw/virtio/virtio-gpu.h                |   2 +-
 include/hw/virtio/virtio-input.h              |   2 +-
 include/hw/virtio/virtio-iommu.h              |   2 +-
 include/hw/virtio/virtio-mem.h                |   2 +-
 include/hw/virtio/virtio-rng.h                |   2 +-
 include/hw/virtio/virtio-scsi.h               |   2 +-
 include/hw/xen/xen-block.h                    |   2 +-
 include/hw/xen/xen-hvm-common.h               |   8 +-
 include/hw/xen/xen.h                          |   2 -
 include/qemu/coroutine.h                      |   1 +
 include/qemu/log.h                            |   1 +
 include/qemu/main-loop.h                      |   2 +-
 include/qemu/osdep.h                          |   8 +-
 include/qom/object.h                          |  13 ++
 include/{sysemu => system}/accel-blocker.h    |   2 +-
 include/{sysemu => system}/accel-ops.h        |   2 +-
 include/{sysemu => system}/arch_init.h        |   0
 include/{sysemu => system}/balloon.h          |   0
 .../{sysemu => system}/block-backend-common.h |   0
 .../block-backend-global-state.h              |   0
 include/{sysemu => system}/block-backend-io.h |   0
 include/{sysemu => system}/block-backend.h    |   0
 .../{sysemu => system}/block-ram-registrar.h  |   0
 include/{sysemu => system}/blockdev.h         |   0
 .../confidential-guest-support.h              |   6 +-
 include/{sysemu => system}/cpu-throttle.h     |   6 +-
 .../{sysemu => system}/cpu-timers-internal.h  |   0
 include/{sysemu => system}/cpu-timers.h       |   6 +-
 include/{sysemu => system}/cpus.h             |   2 +-
 .../{sysemu => system}/cryptodev-vhost-user.h |   2 +-
 include/{sysemu => system}/cryptodev-vhost.h  |   2 +-
 include/{sysemu => system}/cryptodev.h        |   0
 include/{sysemu => system}/device_tree.h      |   0
 include/{sysemu => system}/dirtylimit.h       |   0
 include/{sysemu => system}/dirtyrate.h        |   0
 include/{sysemu => system}/dma.h              |   0
 include/{sysemu => system}/dump-arch.h        |   0
 include/{sysemu => system}/dump.h             |   4 +-
 include/{sysemu => system}/event-loop-base.h  |   0
 .../{sysemu => system}/host_iommu_device.h    |   0
 include/{sysemu => system}/hostmem.h          |   6 +-
 include/{sysemu => system}/hvf.h              |   0
 include/{sysemu => system}/hvf_int.h          |   0
 include/{sysemu => system}/hw_accel.h         |   8 +-
 include/{sysemu => system}/iommufd.h          |   6 +-
 include/{sysemu => system}/iothread.h         |   2 +-
 include/{sysemu => system}/kvm.h              |   0
 include/{sysemu => system}/kvm_int.h          |   2 +-
 include/{sysemu => system}/kvm_xen.h          |   6 +-
 include/{sysemu => system}/memory_mapping.h   |   0
 include/{sysemu => system}/numa.h             |   5 +-
 include/{sysemu => system}/nvmm.h             |   0
 include/{sysemu => system}/os-posix.h         |   0
 include/{sysemu => system}/os-win32.h         |   0
 include/{sysemu => system}/qtest.h            |   0
 include/{sysemu => system}/replay.h           |   4 +-
 include/{sysemu => system}/reset.h            |   4 +-
 include/{sysemu => system}/rng-random.h       |   0
 include/{sysemu => system}/rng.h              |   0
 include/{sysemu => system}/rtc.h              |   4 +-
 include/{sysemu => system}/runstate-action.h  |   0
 include/{sysemu => system}/runstate.h         |   4 +-
 include/{sysemu => system}/seccomp.h          |   0
 include/{sysemu => system}/spdm-socket.h      |   0
 include/{sysemu => system}/stats.h            |   0
 include/{sysemu/sysemu.h => system/system.h}  |   4 +-
 include/{sysemu => system}/tcg.h              |   4 +-
 include/{sysemu => system}/tpm.h              |   0
 include/{sysemu => system}/tpm_backend.h      |   2 +-
 include/{sysemu => system}/tpm_util.h         |   8 +-
 .../{sysemu => system}/vhost-user-backend.h   |   0
 include/{sysemu => system}/watchdog.h         |   0
 include/{sysemu => system}/whpx.h             |   0
 include/{sysemu => system}/xen-mapcache.h     |   2 +-
 include/{sysemu => system}/xen.h              |   6 +-
 include/user/cpu_loop.h                       |  90 +++++++++++++
 include/user/guest-host.h                     |  87 +++++++++++++
 include/user/page-protection.h                |  99 +++++++++++++++
 linux-user/aarch64/mte_user_helper.h          |   2 +
 linux-user/cpu_loop-common.h                  |  31 -----
 linux-user/qemu.h                             |   1 +
 linux-user/user-internals.h                   |   1 -
 migration/dirtyrate.h                         |   2 +-
 migration/migration.h                         |   2 +-
 monitor/monitor-internal.h                    |   2 +-
 nbd/nbd-internal.h                            |   2 +-
 rust/wrapper.h                                |   2 +-
 target/arm/cpu.h                              |   5 +-
 target/arm/kvm_arm.h                          |   2 +-
 target/arm/tcg/translate.h                    |   1 +
 target/i386/confidential-guest.h              |   2 +-
 target/i386/cpu-internal.h                    |   2 +-
 target/i386/cpu.h                             |   2 +-
 target/i386/hvf/vmx.h                         |   4 +-
 target/i386/kvm/hyperv.h                      |   2 +-
 target/i386/kvm/kvm_i386.h                    |   2 +-
 target/i386/nvmm/nvmm-accel-ops.h             |   2 +-
 target/i386/sev.h                             |  29 +++--
 target/i386/whpx/whpx-accel-ops.h             |   2 +-
 target/loongarch/internals.h                  |   2 -
 target/mips/helper.h                          |   2 +-
 target/ppc/kvm_ppc.h                          |   2 +-
 target/s390x/kvm/pv.h                         |   2 +-
 target/s390x/s390x-internal.h                 |   6 +-
 target/sparc/cpu.h                            |  43 +------
 target/sparc/translate.h                      |  17 +++
 tests/qtest/tpm-emu.h                         |   2 +-
 ...ysemu_helper.h.inc => system_helper.h.inc} |   2 +-
 accel/accel-blocker.c                         |   2 +-
 accel/accel-system.c                          |   2 +-
 accel/dummy-cpus.c                            |   2 +-
 accel/hvf/hvf-accel-ops.c                     |   8 +-
 accel/hvf/hvf-all.c                           |   4 +-
 accel/kvm/kvm-accel-ops.c                     |   8 +-
 accel/kvm/kvm-all.c                           |  16 +--
 accel/qtest/qtest.c                           |   4 +-
 accel/stubs/kvm-stub.c                        |   2 +-
 accel/stubs/xen-stub.c                        |   2 +-
 accel/tcg/cpu-exec-common.c                   |   4 +-
 accel/tcg/cpu-exec.c                          |  22 +++-
 accel/tcg/cputlb.c                            |   5 +-
 accel/tcg/icount-common.c                     |  12 +-
 accel/tcg/monitor.c                           |   6 +-
 accel/tcg/tb-maint.c                          |   8 +-
 accel/tcg/tcg-accel-ops-icount.c              |   4 +-
 accel/tcg/tcg-accel-ops-mttcg.c               |   6 +-
 accel/tcg/tcg-accel-ops-rr.c                  |   6 +-
 accel/tcg/tcg-accel-ops.c                     |   7 +-
 accel/tcg/tcg-all.c                           |   4 +-
 accel/tcg/translate-all.c                     |  10 +-
 accel/tcg/translator.c                        |   9 +-
 accel/tcg/user-exec.c                         |   6 +-
 accel/tcg/watchpoint.c                        |   9 +-
 accel/xen/xen-all.c                           |   6 +-
 audio/audio.c                                 |   6 +-
 backends/confidential-guest-support.c         |   2 +-
 backends/cryptodev-builtin.c                  |   2 +-
 backends/cryptodev-lkcf.c                     |   2 +-
 backends/cryptodev-vhost-user.c               |   4 +-
 backends/cryptodev-vhost.c                    |   4 +-
 backends/cryptodev.c                          |   4 +-
 backends/host_iommu_device.c                  |   2 +-
 backends/hostmem-epc.c                        |   2 +-
 backends/hostmem-file.c                       |   2 +-
 backends/hostmem-memfd.c                      |   2 +-
 backends/hostmem-ram.c                        |   2 +-
 backends/hostmem-shm.c                        |   2 +-
 backends/hostmem.c                            |   2 +-
 backends/iommufd.c                            |   2 +-
 backends/rng-builtin.c                        |   4 +-
 backends/rng-egd.c                            |   2 +-
 backends/rng-random.c                         |   4 +-
 backends/rng.c                                |   2 +-
 backends/spdm-socket.c                        |   2 +-
 backends/tpm/tpm_backend.c                    |   4 +-
 backends/tpm/tpm_emulator.c                   |   6 +-
 backends/tpm/tpm_passthrough.c                |   4 +-
 backends/tpm/tpm_util.c                       |   4 +-
 backends/vhost-user.c                         |   4 +-
 block.c                                       |   2 +-
 block/accounting.c                            |   2 +-
 block/backup.c                                |   2 +-
 block/blkdebug.c                              |   2 +-
 block/blkio.c                                 |   2 +-
 block/blkreplay.c                             |   2 +-
 block/block-backend.c                         |   8 +-
 block/block-copy.c                            |   2 +-
 block/block-ram-registrar.c                   |   4 +-
 block/commit.c                                |   2 +-
 block/copy-before-write.c                     |   2 +-
 block/create.c                                |   1 +
 block/crypto.c                                |   2 +-
 block/export/export.c                         |   4 +-
 block/export/fuse.c                           |   2 +-
 block/io.c                                    |   4 +-
 block/io_uring.c                              |   2 +-
 block/iscsi.c                                 |   4 +-
 block/linux-aio.c                             |   2 +-
 block/mirror.c                                |   2 +-
 block/monitor/block-hmp-cmds.c                |   6 +-
 block/nfs.c                                   |   2 +-
 block/null.c                                  |   2 +-
 block/nvme.c                                  |   4 +-
 block/parallels.c                             |   2 +-
 block/{qapi-sysemu.c => qapi-system.c}        |   4 +-
 block/qapi.c                                  |   2 +-
 block/qcow.c                                  |   2 +-
 block/qcow2-snapshot.c                        |   2 +-
 block/qcow2.c                                 |   2 +-
 block/qed.c                                   |   2 +-
 block/rbd.c                                   |   2 +-
 block/replication.c                           |   2 +-
 block/snapshot-access.c                       |   2 +-
 block/snapshot.c                              |   2 +-
 block/stream.c                                |   2 +-
 block/throttle-groups.c                       |   4 +-
 block/vdi.c                                   |   2 +-
 block/vhdx.c                                  |   2 +-
 block/vmdk.c                                  |   2 +-
 block/vpc.c                                   |   2 +-
 blockdev-nbd.c                                |   4 +-
 blockdev.c                                    |  12 +-
 blockjob.c                                    |   2 +-
 bsd-user/main.c                               |   1 +
 bsd-user/mmap.c                               |   1 +
 bsd-user/signal.c                             |   2 +
 chardev/char-fe.c                             |   2 +-
 chardev/char-mux.c                            |   2 +-
 chardev/char.c                                |   2 +-
 cpu-common.c                                  |   2 +-
 cpu-target.c                                  |   7 +-
 dump/dump.c                                   |   6 +-
 dump/win_dump.c                               |   2 +-
 event-loop-base.c                             |   2 +-
 gdbstub/gdbstub.c                             |   4 +-
 gdbstub/syscalls.c                            |   2 +-
 gdbstub/system.c                              |   6 +-
 hw/9pfs/9p-synth.c                            |   2 +-
 hw/9pfs/virtio-9p-device.c                    |   2 +-
 hw/acpi/aml-build.c                           |   2 +-
 hw/acpi/core.c                                |   2 +-
 hw/acpi/cpu.c                                 |   2 +-
 hw/acpi/erst.c                                |   2 +-
 hw/acpi/generic_event_device.c                |   2 +-
 hw/acpi/hmat.c                                |   2 +-
 hw/acpi/ich9.c                                |   4 +-
 hw/acpi/ich9_tco.c                            |   2 +-
 hw/acpi/piix4.c                               |   6 +-
 hw/acpi/vmgenid.c                             |   2 +-
 hw/arm/allwinner-a10.c                        |   2 +-
 hw/arm/allwinner-h3.c                         |   2 +-
 hw/arm/allwinner-r40.c                        |   2 +-
 hw/arm/armv7m.c                               |   2 +-
 hw/arm/aspeed.c                               |   6 +-
 hw/arm/aspeed_ast10x0.c                       |   2 +-
 hw/arm/aspeed_ast2400.c                       |   2 +-
 hw/arm/aspeed_ast2600.c                       |   2 +-
 hw/arm/aspeed_ast27x0.c                       |   2 +-
 hw/arm/bcm2835_peripherals.c                  |   2 +-
 hw/arm/boot.c                                 |  12 +-
 hw/arm/digic.c                                |   2 +-
 hw/arm/digic_boards.c                         |   2 +-
 hw/arm/exynos4210.c                           |   4 +-
 hw/arm/fby35.c                                |   4 +-
 hw/arm/fsl-imx25.c                            |   2 +-
 hw/arm/fsl-imx31.c                            |   2 +-
 hw/arm/fsl-imx6.c                             |   2 +-
 hw/arm/fsl-imx6ul.c                           |   2 +-
 hw/arm/fsl-imx7.c                             |   2 +-
 hw/arm/highbank.c                             |   4 +-
 hw/arm/imx25_pdk.c                            |   2 +-
 hw/arm/integratorcp.c                         |   4 +-
 hw/arm/kzm.c                                  |   4 +-
 hw/arm/mcimx6ul-evk.c                         |   2 +-
 hw/arm/mcimx7d-sabre.c                        |   2 +-
 hw/arm/microbit.c                             |   2 +-
 hw/arm/mps2-tz.c                              |   4 +-
 hw/arm/mps2.c                                 |   2 +-
 hw/arm/mps3r.c                                |   2 +-
 hw/arm/msf2-soc.c                             |   2 +-
 hw/arm/musca.c                                |   2 +-
 hw/arm/musicpal.c                             |   8 +-
 hw/arm/npcm7xx.c                              |   2 +-
 hw/arm/npcm7xx_boards.c                       |   6 +-
 hw/arm/omap1.c                                |  12 +-
 hw/arm/omap_sx1.c                             |   2 +-
 hw/arm/raspi4b.c                              |   2 +-
 hw/arm/realview.c                             |   2 +-
 hw/arm/sabrelite.c                            |   2 +-
 hw/arm/sbsa-ref.c                             |  10 +-
 hw/arm/stellaris.c                            |   4 +-
 hw/arm/stm32f100_soc.c                        |   2 +-
 hw/arm/stm32f205_soc.c                        |   2 +-
 hw/arm/stm32f405_soc.c                        |   2 +-
 hw/arm/stm32l4x5_soc.c                        |   2 +-
 hw/arm/strongarm.c                            |   4 +-
 hw/arm/versatilepb.c                          |   2 +-
 hw/arm/vexpress.c                             |   4 +-
 hw/arm/virt-acpi-build.c                      |   6 +-
 hw/arm/virt.c                                 |  16 +--
 hw/arm/xen-pvh.c                              |   2 +-
 hw/arm/xen-stubs.c                            |   2 +-
 hw/arm/xilinx_zynq.c                          |   4 +-
 hw/arm/xlnx-versal-virt.c                     |   2 +-
 hw/arm/xlnx-versal.c                          |   4 +-
 hw/arm/xlnx-zcu102.c                          |   2 +-
 hw/arm/xlnx-zynqmp.c                          |   4 +-
 hw/audio/ac97.c                               |   2 +-
 hw/audio/es1370.c                             |   2 +-
 hw/audio/intel-hda.c                          |   2 +-
 hw/audio/virtio-snd.c                         |   2 +-
 hw/avr/atmega.c                               |   2 +-
 hw/block/block.c                              |   4 +-
 hw/block/dataplane/xen-block.c                |   4 +-
 hw/block/fdc-isa.c                            |   6 +-
 hw/block/fdc.c                                |   6 +-
 hw/block/hd-geometry.c                        |   2 +-
 hw/block/m25p80.c                             |   2 +-
 hw/block/nand.c                               |   2 +-
 hw/block/pflash_cfi01.c                       |   6 +-
 hw/block/pflash_cfi02.c                       |   2 +-
 hw/block/swim.c                               |   2 +-
 hw/block/vhost-user-blk.c                     |   4 +-
 hw/block/virtio-blk.c                         |   8 +-
 hw/block/xen-block.c                          |   6 +-
 hw/char/goldfish_tty.c                        |   2 +-
 hw/char/parallel-isa.c                        |   2 +-
 hw/char/parallel.c                            |   4 +-
 hw/char/riscv_htif.c                          |   4 +-
 hw/char/serial-isa.c                          |   2 +-
 hw/char/serial.c                              |   4 +-
 hw/char/xen_console.c                         |   2 +-
 hw/core/clock.c                               |   2 +-
 hw/core/cpu-common.c                          |   4 +-
 hw/core/{cpu-sysemu.c => cpu-system.c}        |   2 +-
 hw/core/generic-loader.c                      |   4 +-
 hw/core/guest-loader.c                        |   4 +-
 hw/core/loader-fit.c                          |   2 +-
 hw/core/loader.c                              |   6 +-
 hw/core/machine-hmp-cmds.c                    |   2 +-
 hw/core/machine-qmp-cmds.c                    |  10 +-
 hw/core/machine.c                             |  19 ++-
 hw/core/numa.c                                |   6 +-
 hw/core/ptimer.c                              |   4 +-
 hw/core/qdev-properties-system.c              |   4 +-
 hw/core/reset.c                               |   2 +-
 hw/core/sysbus-fdt.c                          |   4 +-
 hw/core/vm-change-state-handler.c             |   2 +-
 hw/cpu/a15mpcore.c                            |   2 +-
 hw/cxl/cxl-host.c                             |   2 +-
 hw/cxl/cxl-mailbox-utils.c                    |   2 +-
 hw/display/cirrus_vga.c                       |   2 +-
 hw/display/qxl-render.c                       |   2 +-
 hw/display/qxl.c                              |   2 +-
 hw/display/ramfb.c                            |   2 +-
 hw/display/vga.c                              |   2 +-
 hw/display/virtio-gpu-gl.c                    |   2 +-
 hw/display/virtio-gpu-udmabuf.c               |   2 +-
 hw/display/virtio-gpu.c                       |   6 +-
 hw/display/xenfb.c                            |   2 +-
 hw/dma/pl330.c                                |   2 +-
 hw/dma/sifive_pdma.c                          |   2 +-
 hw/dma/sparc32_dma.c                          |   2 +-
 hw/dma/xilinx_axidma.c                        |   2 +-
 hw/dma/xlnx-zynq-devcfg.c                     |   2 +-
 hw/dma/xlnx_csu_dma.c                         |   2 +-
 hw/gpio/gpio_pwr.c                            |   2 +-
 hw/hppa/machine.c                             |   8 +-
 hw/hyperv/hv-balloon.c                        |   6 +-
 hw/hyperv/hyperv.c                            |   2 +-
 hw/i386/acpi-build.c                          |   8 +-
 hw/i386/fw_cfg.c                              |   2 +-
 hw/i386/intel_iommu.c                         |   6 +-
 hw/i386/kvm/apic.c                            |   4 +-
 hw/i386/kvm/clock.c                           |   6 +-
 hw/i386/kvm/i8254.c                           |   4 +-
 hw/i386/kvm/i8259.c                           |   2 +-
 hw/i386/kvm/ioapic.c                          |   2 +-
 hw/i386/kvm/xen_evtchn.c                      |   4 +-
 hw/i386/kvm/xen_gnttab.c                      |   4 +-
 hw/i386/kvm/xen_overlay.c                     |   4 +-
 hw/i386/kvm/xen_primary_console.c             |   4 +-
 hw/i386/kvm/xen_xenstore.c                    |   4 +-
 hw/i386/microvm-dt.c                          |   2 +-
 hw/i386/microvm.c                             |  10 +-
 hw/i386/multiboot.c                           |   2 +-
 hw/i386/nitro_enclave.c                       |   2 +-
 hw/i386/pc.c                                  |   8 +-
 hw/i386/pc_piix.c                             |   8 +-
 hw/i386/pc_q35.c                              |   6 +-
 hw/i386/pc_sysfw.c                            |   6 +-
 hw/i386/port92.c                              |   2 +-
 hw/i386/sgx.c                                 |   4 +-
 hw/i386/vapic.c                               |  10 +-
 hw/i386/vmport.c                              |   6 +-
 hw/i386/x86-common.c                          |   6 +-
 hw/i386/x86-cpu.c                             |   6 +-
 hw/i386/x86-iommu.c                           |   2 +-
 hw/i386/x86.c                                 |   4 +-
 hw/i386/xen/xen-pvh.c                         |   2 +-
 hw/i386/xen/xen_platform.c                    |   4 +-
 hw/ide/ahci-allwinner.c                       |   2 +-
 hw/ide/ahci.c                                 |   4 +-
 hw/ide/atapi.c                                |   2 +-
 hw/ide/cmd646.c                               |   4 +-
 hw/ide/core.c                                 |  12 +-
 hw/ide/ich.c                                  |   2 +-
 hw/ide/ide-bus.c                              |   6 +-
 hw/ide/ide-dev.c                              |   6 +-
 hw/ide/isa.c                                  |   2 +-
 hw/ide/macio.c                                |   4 +-
 hw/ide/mmio.c                                 |   2 +-
 hw/ide/pci.c                                  |   2 +-
 hw/ide/via.c                                  |   2 +-
 hw/input/pckbd.c                              |   4 +-
 hw/input/ps2.c                                |   4 +-
 hw/intc/apic.c                                |   2 +-
 hw/intc/apic_common.c                         |   2 +-
 hw/intc/arm_gic.c                             |   4 +-
 hw/intc/arm_gic_common.c                      |   2 +-
 hw/intc/arm_gic_kvm.c                         |   2 +-
 hw/intc/arm_gicv2m.c                          |   2 +-
 hw/intc/arm_gicv3_common.c                    |   2 +-
 hw/intc/arm_gicv3_cpuif.c                     |   4 +-
 hw/intc/arm_gicv3_its_common.c                |   2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   4 +-
 hw/intc/arm_gicv3_kvm.c                       |   4 +-
 hw/intc/armv7m_nvic.c                         |   4 +-
 hw/intc/ioapic.c                              |   4 +-
 hw/intc/mips_gic.c                            |   4 +-
 hw/intc/openpic_kvm.c                         |   2 +-
 hw/intc/pnv_xive.c                            |   6 +-
 hw/intc/pnv_xive2.c                           |   8 +-
 hw/intc/riscv_aplic.c                         |   4 +-
 hw/intc/riscv_imsic.c                         |   4 +-
 hw/intc/s390_flic_kvm.c                       |   2 +-
 hw/intc/sifive_plic.c                         |   2 +-
 hw/intc/spapr_xive.c                          |   4 +-
 hw/intc/spapr_xive_kvm.c                      |   6 +-
 hw/intc/xics.c                                |   4 +-
 hw/intc/xics_kvm.c                            |   2 +-
 hw/intc/xive.c                                |   6 +-
 hw/intc/xive2.c                               |   4 +-
 hw/ipmi/ipmi.c                                |   2 +-
 hw/ipmi/ipmi_bmc_sim.c                        |   2 +-
 hw/isa/isa-bus.c                              |   2 +-
 hw/isa/isa-superio.c                          |   2 +-
 hw/isa/lpc_ich9.c                             |   4 +-
 hw/isa/piix.c                                 |   2 +-
 hw/loongarch/acpi-build.c                     |   6 +-
 hw/loongarch/boot.c                           |   4 +-
 hw/loongarch/fw_cfg.c                         |   2 +-
 hw/loongarch/virt.c                           |  20 +--
 hw/m68k/an5206.c                              |   2 +-
 hw/m68k/mcf5206.c                             |   2 +-
 hw/m68k/mcf5208.c                             |   4 +-
 hw/m68k/next-cube.c                           |   4 +-
 hw/m68k/q800.c                                |   8 +-
 hw/m68k/virt.c                                |   8 +-
 hw/mem/cxl_type3.c                            |   4 +-
 hw/mem/memory-device.c                        |   2 +-
 hw/mem/nvdimm.c                               |   2 +-
 hw/mem/pc-dimm.c                              |   4 +-
 hw/mem/sparse-mem.c                           |   2 +-
 hw/microblaze/boot.c                          |   4 +-
 hw/microblaze/petalogix_ml605_mmu.c           |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   2 +-
 hw/mips/boston.c                              |  10 +-
 hw/mips/cps.c                                 |   4 +-
 hw/mips/fuloong2e.c                           |   6 +-
 hw/mips/jazz.c                                |   6 +-
 hw/mips/loongson3_virt.c                      |   8 +-
 hw/mips/malta.c                               |   8 +-
 hw/mips/mips_int.c                            |   2 +-
 hw/mips/mipssim.c                             |   6 +-
 hw/misc/arm_sysctl.c                          |   2 +-
 hw/misc/bcm2835_powermgt.c                    |   2 +-
 hw/misc/bcm2835_property.c                    |   2 +-
 hw/misc/debugexit.c                           |   2 +-
 hw/misc/exynos4210_pmu.c                      |   2 +-
 hw/misc/imx7_snvs.c                           |   6 +-
 hw/misc/iotkit-sysctl.c                       |   2 +-
 hw/misc/ivshmem.c                             |   4 +-
 hw/misc/lasi.c                                |   4 +-
 hw/misc/mac_via.c                             |   6 +-
 hw/misc/macio/cuda.c                          |   4 +-
 hw/misc/macio/mac_dbdma.c                     |   2 +-
 hw/misc/macio/pmu.c                           |   4 +-
 hw/misc/npcm7xx_clk.c                         |   2 +-
 hw/misc/pci-testdev.c                         |   2 +-
 hw/misc/pvpanic-isa.c                         |   2 +-
 hw/misc/pvpanic-pci.c                         |   2 +-
 hw/misc/pvpanic.c                             |   2 +-
 hw/misc/sbsa_ec.c                             |   2 +-
 hw/misc/sifive_e_aon.c                        |   2 +-
 hw/misc/sifive_test.c                         |   4 +-
 hw/misc/sifive_u_otp.c                        |   4 +-
 hw/misc/slavio_misc.c                         |   2 +-
 hw/misc/virt_ctrl.c                           |   2 +-
 hw/misc/vmcoreinfo.c                          |   2 +-
 hw/misc/zynq_slcr.c                           |   2 +-
 hw/net/allwinner-sun8i-emac.c                 |   2 +-
 hw/net/cadence_gem.c                          |   2 +-
 hw/net/e1000.c                                |   4 +-
 hw/net/e1000e.c                               |   2 +-
 hw/net/e1000e_core.c                          |   2 +-
 hw/net/eepro100.c                             |   6 +-
 hw/net/ftgmac100.c                            |   2 +-
 hw/net/igb.c                                  |   2 +-
 hw/net/igb_core.c                             |   2 +-
 hw/net/imx_fec.c                              |   2 +-
 hw/net/lance.c                                |   2 +-
 hw/net/lasi_i82596.c                          |   2 +-
 hw/net/mv88w8618_eth.c                        |   2 +-
 hw/net/ne2000-isa.c                           |   2 +-
 hw/net/ne2000-pci.c                           |   2 +-
 hw/net/npcm7xx_emc.c                          |   2 +-
 hw/net/npcm_gmac.c                            |   2 +-
 hw/net/pcnet-pci.c                            |   4 +-
 hw/net/rtl8139.c                              |   4 +-
 hw/net/spapr_llan.c                           |   2 +-
 hw/net/sungem.c                               |   2 +-
 hw/net/sunhme.c                               |   2 +-
 hw/net/tulip.c                                |   2 +-
 hw/net/virtio-net.c                           |   6 +-
 hw/net/vmxnet3.c                              |   2 +-
 hw/nvme/ctrl.c                                |   8 +-
 hw/nvme/dif.c                                 |   2 +-
 hw/nvme/ns.c                                  |   4 +-
 hw/nvram/chrp_nvram.c                         |   2 +-
 hw/nvram/eeprom_at24c.c                       |   2 +-
 hw/nvram/fw_cfg.c                             |   6 +-
 hw/nvram/mac_nvram.c                          |   2 +-
 hw/nvram/spapr_nvram.c                        |   8 +-
 hw/nvram/xlnx-bbram.c                         |   2 +-
 hw/nvram/xlnx-efuse.c                         |   2 +-
 hw/openrisc/boot.c                            |   6 +-
 hw/openrisc/cputimer.c                        |   2 +-
 hw/openrisc/openrisc_sim.c                    |   8 +-
 hw/openrisc/virt.c                            |   8 +-
 hw/pci-bridge/pci_expander_bridge.c           |   2 +-
 hw/pci-host/bonito.c                          |   2 +-
 hw/pci-host/pnv_phb.c                         |   2 +-
 hw/pci-host/pnv_phb3.c                        |   2 +-
 hw/pci-host/pnv_phb3_msi.c                    |   2 +-
 hw/pci-host/pnv_phb4_pec.c                    |   2 +-
 hw/pci-host/ppc4xx_pci.c                      |   2 +-
 hw/pci-host/ppce500.c                         |   4 +-
 hw/pci-host/sabre.c                           |   2 +-
 hw/pci/msi.c                                  |   2 +-
 hw/pci/msix.c                                 |   2 +-
 hw/pci/pci.c                                  |   6 +-
 hw/ppc/amigaone.c                             |   4 +-
 hw/ppc/e500.c                                 |  12 +-
 hw/ppc/e500plat.c                             |   4 +-
 hw/ppc/mac_newworld.c                         |   6 +-
 hw/ppc/mac_oldworld.c                         |   6 +-
 hw/ppc/mpc8544_guts.c                         |   2 +-
 hw/ppc/mpc8544ds.c                            |   2 +-
 hw/ppc/pef.c                                  |   4 +-
 hw/ppc/pegasos2.c                             |  10 +-
 hw/ppc/pnv.c                                  |  16 +--
 hw/ppc/pnv_chiptod.c                          |   2 +-
 hw/ppc/pnv_core.c                             |   2 +-
 hw/ppc/pnv_homer.c                            |   2 +-
 hw/ppc/pnv_i2c.c                              |   2 +-
 hw/ppc/pnv_pnor.c                             |   4 +-
 hw/ppc/pnv_psi.c                              |   2 +-
 hw/ppc/pnv_xscom.c                            |   2 +-
 hw/ppc/ppc.c                                  |   8 +-
 hw/ppc/ppc405_boards.c                        |   6 +-
 hw/ppc/ppc405_uc.c                            |   4 +-
 hw/ppc/ppc440_bamboo.c                        |   8 +-
 hw/ppc/ppc440_uc.c                            |   2 +-
 hw/ppc/ppc_booke.c                            |   4 +-
 hw/ppc/ppce500_spin.c                         |   2 +-
 hw/ppc/prep.c                                 |   4 +-
 hw/ppc/prep_systemio.c                        |   2 +-
 hw/ppc/sam460ex.c                             |  10 +-
 hw/ppc/spapr.c                                |  22 ++--
 hw/ppc/spapr_caps.c                           |   4 +-
 hw/ppc/spapr_cpu_core.c                       |  10 +-
 hw/ppc/spapr_drc.c                            |  33 +++--
 hw/ppc/spapr_events.c                         |   4 +-
 hw/ppc/spapr_hcall.c                          |   6 +-
 hw/ppc/spapr_iommu.c                          |   4 +-
 hw/ppc/spapr_irq.c                            |   2 +-
 hw/ppc/spapr_pci.c                            |   8 +-
 hw/ppc/spapr_rng.c                            |   4 +-
 hw/ppc/spapr_rtas.c                           |  12 +-
 hw/ppc/spapr_rtc.c                            |   4 +-
 hw/ppc/spapr_tpm_proxy.c                      |   2 +-
 hw/ppc/spapr_vio.c                            |   4 +-
 hw/ppc/spapr_vof.c                            |   2 +-
 hw/ppc/virtex_ml507.c                         |   6 +-
 hw/ppc/vof.c                                  |   2 +-
 hw/remote/message.c                           |   4 +-
 hw/remote/mpqemu-link.c                       |   2 +-
 hw/remote/proxy.c                             |   2 +-
 hw/remote/remote-obj.c                        |   2 +-
 hw/remote/vfio-user-obj.c                     |   4 +-
 hw/riscv/boot.c                               |   8 +-
 hw/riscv/microchip_pfsoc.c                    |   4 +-
 hw/riscv/numa.c                               |   2 +-
 hw/riscv/opentitan.c                          |   2 +-
 hw/riscv/riscv_hart.c                         |   2 +-
 hw/riscv/shakti_c.c                           |   2 +-
 hw/riscv/sifive_e.c                           |   2 +-
 hw/riscv/sifive_u.c                           |   6 +-
 hw/riscv/spike.c                              |   4 +-
 hw/riscv/virt-acpi-build.c                    |   2 +-
 hw/riscv/virt.c                               |  12 +-
 hw/rtc/allwinner-rtc.c                        |   2 +-
 hw/rtc/aspeed_rtc.c                           |   2 +-
 hw/rtc/ds1338.c                               |   2 +-
 hw/rtc/exynos4210_rtc.c                       |   2 +-
 hw/rtc/goldfish_rtc.c                         |   4 +-
 hw/rtc/ls7a_rtc.c                             |   4 +-
 hw/rtc/m41t80.c                               |   2 +-
 hw/rtc/m48t59.c                               |   8 +-
 hw/rtc/mc146818rtc.c                          |  10 +-
 hw/rtc/pl031.c                                |   4 +-
 hw/rtc/xlnx-zynqmp-rtc.c                      |   4 +-
 hw/rx/rx-gdbsim.c                             |   6 +-
 hw/rx/rx62n.c                                 |   2 +-
 hw/s390x/ipl.c                                |   6 +-
 hw/s390x/s390-ccw.c                           |   2 +-
 hw/s390x/s390-pci-bus.c                       |   4 +-
 hw/s390x/s390-pci-inst.c                      |   2 +-
 hw/s390x/s390-skeys-kvm.c                     |   2 +-
 hw/s390x/s390-skeys.c                         |   4 +-
 hw/s390x/s390-stattrib-kvm.c                  |   2 +-
 hw/s390x/s390-virtio-ccw.c                    |   8 +-
 hw/s390x/sclpcpu.c                            |   2 +-
 hw/s390x/sclpquiesce.c                        |   2 +-
 hw/s390x/tod-kvm.c                            |   2 +-
 hw/s390x/tod-tcg.c                            |   2 +-
 hw/s390x/tod.c                                |   6 +-
 hw/s390x/virtio-ccw.c                         |   4 +-
 hw/scsi/lsi53c895a.c                          |   2 +-
 hw/scsi/megasas.c                             |   6 +-
 hw/scsi/mptendian.c                           |   2 +-
 hw/scsi/mptsas.c                              |   2 +-
 hw/scsi/scsi-bus.c                            |  10 +-
 hw/scsi/scsi-disk.c                           |  10 +-
 hw/scsi/scsi-generic.c                        |   2 +-
 hw/scsi/vhost-scsi.c                          |   2 +-
 hw/scsi/vhost-user-scsi.c                     |   2 +-
 hw/scsi/virtio-scsi-dataplane.c               |   2 +-
 hw/scsi/virtio-scsi.c                         |   4 +-
 hw/sd/allwinner-sdhost.c                      |   4 +-
 hw/sd/bcm2835_sdhost.c                        |   2 +-
 hw/sd/pl181.c                                 |   2 +-
 hw/sd/sd.c                                    |   2 +-
 hw/sd/sdhci.c                                 |   2 +-
 hw/sd/ssi-sd.c                                |   2 +-
 hw/sh4/r2d.c                                  |   6 +-
 hw/sh4/sh7750.c                               |   2 +-
 hw/smbios/smbios.c                            |   2 +-
 hw/smbios/smbios_legacy.c                     |   2 +-
 hw/sparc/leon3.c                              |   6 +-
 hw/sparc/sun4m.c                              |   6 +-
 hw/sparc64/niagara.c                          |   6 +-
 hw/sparc64/sparc64.c                          |   2 +-
 hw/sparc64/sun4u.c                            |   4 +-
 hw/ssi/xilinx_spips.c                         |   2 +-
 hw/timer/a9gtimer.c                           |   2 +-
 hw/timer/pxa2xx_timer.c                       |   4 +-
 hw/tpm/tpm_crb.c                              |   8 +-
 hw/tpm/tpm_ppi.c                              |   2 +-
 hw/tpm/tpm_spapr.c                            |   4 +-
 hw/tpm/tpm_tis_common.c                       |   4 +-
 hw/ufs/lu.c                                   |   2 +-
 hw/usb/bus-stub.c                             |   2 +-
 hw/usb/bus.c                                  |   2 +-
 hw/usb/dev-network.c                          |   2 +-
 hw/usb/dev-storage-classic.c                  |   4 +-
 hw/usb/hcd-ehci.c                             |   2 +-
 hw/usb/hcd-uhci.c                             |   2 +-
 hw/usb/host-libusb.c                          |   4 +-
 hw/usb/libhw.c                                |   2 +-
 hw/usb/redirect.c                             |   4 +-
 hw/vfio/ap.c                                  |   2 +-
 hw/vfio/ccw.c                                 |   2 +-
 hw/vfio/common.c                              |   8 +-
 hw/vfio/container.c                           |   2 +-
 hw/vfio/cpr.c                                 |   2 +-
 hw/vfio/iommufd.c                             |   4 +-
 hw/vfio/migration.c                           |   2 +-
 hw/vfio/pci.c                                 |   6 +-
 hw/vfio/platform.c                            |   4 +-
 hw/vfio/spapr.c                               |   2 +-
 hw/virtio/vdpa-dev.c                          |   4 +-
 hw/virtio/vhost-user-fs.c                     |   2 +-
 hw/virtio/vhost-user-scsi-pci.c               |   2 +-
 hw/virtio/vhost-user.c                        |   6 +-
 hw/virtio/vhost.c                             |   2 +-
 hw/virtio/virtio-balloon.c                    |   2 +-
 hw/virtio/virtio-crypto.c                     |   2 +-
 hw/virtio/virtio-iommu.c                      |   6 +-
 hw/virtio/virtio-mem.c                        |   8 +-
 hw/virtio/virtio-mmio.c                       |   4 +-
 hw/virtio/virtio-pci.c                        |   4 +-
 hw/virtio/virtio-pmem.c                       |   2 +-
 hw/virtio/virtio-rng.c                        |   4 +-
 hw/virtio/virtio.c                            |   4 +-
 hw/watchdog/allwinner-wdt.c                   |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |   2 +-
 hw/watchdog/sbsa_gwdt.c                       |   4 +-
 hw/watchdog/watchdog.c                        |   4 +-
 hw/watchdog/wdt_aspeed.c                      |   2 +-
 hw/watchdog/wdt_diag288.c                     |   4 +-
 hw/watchdog/wdt_i6300esb.c                    |   2 +-
 hw/watchdog/wdt_ib700.c                       |   2 +-
 hw/watchdog/wdt_imx2.c                        |   2 +-
 hw/xen/xen-bus.c                              |   2 +-
 hw/xen/xen-mapcache.c                         |   4 +-
 hw/xen/xen-pvh-common.c                       |   6 +-
 hw/xen/xen_devconfig.c                        |   4 +-
 hw/xenpv/xen_machine_pv.c                     |   4 +-
 hw/xtensa/sim.c                               |   4 +-
 hw/xtensa/virt.c                              |   2 +-
 hw/xtensa/xtfpga.c                            |   8 +-
 iothread.c                                    |   4 +-
 linux-user/aarch64/cpu_loop.c                 |   4 +-
 linux-user/alpha/cpu_loop.c                   |   4 +-
 linux-user/arm/cpu_loop.c                     |   5 +-
 linux-user/elfload.c                          |   3 +-
 linux-user/flatload.c                         |   1 +
 linux-user/hexagon/cpu_loop.c                 |   4 +-
 linux-user/hppa/cpu_loop.c                    |   4 +-
 linux-user/i386/cpu_loop.c                    |   4 +-
 linux-user/loongarch64/cpu_loop.c             |   4 +-
 linux-user/m68k/cpu_loop.c                    |   4 +-
 linux-user/main.c                             |   3 +-
 linux-user/microblaze/cpu_loop.c              |   4 +-
 linux-user/mips/cpu_loop.c                    |   4 +-
 linux-user/mmap.c                             |   2 +
 linux-user/openrisc/cpu_loop.c                |   4 +-
 linux-user/ppc/cpu_loop.c                     |   4 +-
 linux-user/riscv/cpu_loop.c                   |   4 +-
 linux-user/s390x/cpu_loop.c                   |   4 +-
 linux-user/sh4/cpu_loop.c                     |   4 +-
 linux-user/signal.c                           |   2 +
 linux-user/sparc/cpu_loop.c                   |   4 +-
 linux-user/syscall.c                          |   4 +-
 linux-user/xtensa/cpu_loop.c                  |   4 +-
 migration/block-dirty-bitmap.c                |   4 +-
 migration/colo.c                              |   6 +-
 migration/cpu-throttle.c                      |   4 +-
 migration/dirtyrate.c                         |   4 +-
 migration/global_state.c                      |   2 +-
 migration/migration-hmp-cmds.c                |   4 +-
 migration/migration.c                         |  14 +--
 migration/multifd.c                           |   2 +-
 migration/options.c                           |   4 +-
 migration/postcopy-ram.c                      |   2 +-
 migration/ram.c                               |   8 +-
 migration/savevm.c                            |  12 +-
 monitor/fds.c                                 |   2 +-
 monitor/hmp-cmds-target.c                     |   2 +-
 monitor/hmp-cmds.c                            |   2 +-
 monitor/hmp-target.c                          |   2 +-
 monitor/hmp.c                                 |   2 +-
 monitor/monitor.c                             |   2 +-
 monitor/qmp-cmds-control.c                    |   2 +-
 monitor/qmp-cmds.c                            |  10 +-
 net/colo-compare.c                            |   2 +-
 net/dump.c                                    |   2 +-
 net/filter-replay.c                           |   2 +-
 net/hub.c                                     |   2 +-
 net/net.c                                     |   2 +-
 net/slirp.c                                   |   2 +-
 net/tap.c                                     |   2 +-
 os-posix.c                                    |   2 +-
 os-win32.c                                    |   2 +-
 plugins/api.c                                 |   1 +
 qemu-img.c                                    |   2 +-
 qemu-io-cmds.c                                |   2 +-
 qemu-io.c                                     |   2 +-
 qemu-nbd.c                                    |   4 +-
 qom/container.c                               |  16 ++-
 qom/object.c                                  |  26 +++-
 replay/replay-audio.c                         |   2 +-
 replay/replay-char.c                          |   2 +-
 replay/replay-debugging.c                     |   4 +-
 replay/replay-events.c                        |   2 +-
 replay/replay-input.c                         |   2 +-
 replay/replay-internal.c                      |   4 +-
 replay/replay-net.c                           |   2 +-
 replay/replay-random.c                        |   2 +-
 replay/replay-snapshot.c                      |   2 +-
 replay/replay-time.c                          |   2 +-
 replay/replay.c                               |   8 +-
 replay/stubs-system.c                         |   2 +-
 stats/stats-qmp-cmds.c                        |   2 +-
 storage-daemon/qemu-storage-daemon.c          |   2 +-
 stubs/blk-commit-all.c                        |   2 +-
 stubs/change-state-handler.c                  |   2 +-
 stubs/cpu-get-clock.c                         |   2 +-
 stubs/cpu-synchronize-state.c                 |   2 +-
 stubs/cpus-virtual-clock.c                    |   2 +-
 stubs/dump.c                                  |   2 +-
 stubs/get-vm-name.c                           |   2 +-
 stubs/icount.c                                |   2 +-
 stubs/qemu-timer-notify-cb.c                  |   2 +-
 stubs/qtest.c                                 |   2 +-
 stubs/replay-mode.c                           |   2 +-
 stubs/replay-tools.c                          |   2 +-
 stubs/runstate-check.c                        |   2 +-
 stubs/vm-stop.c                               |   2 +-
 system/arch_init.c                            |   2 +-
 system/balloon.c                              |   4 +-
 system/bootdevice.c                           |   4 +-
 system/cpu-timers.c                           |  10 +-
 system/cpus.c                                 |  12 +-
 system/device_tree.c                          |   2 +-
 system/dirtylimit.c                           |   6 +-
 system/dma-helpers.c                          |   6 +-
 system/globals.c                              |   4 +-
 system/main.c                                 |   2 +-
 system/memory.c                               |  12 +-
 system/memory_mapping.c                       |   2 +-
 system/physmem.c                              |  22 ++--
 system/qdev-monitor.c                         |   6 +-
 system/qemu-seccomp.c                         |   2 +-
 system/qtest.c                                |   6 +-
 system/rtc.c                                  |   6 +-
 system/runstate-action.c                      |   4 +-
 system/runstate.c                             |  16 +--
 system/tpm.c                                  |   4 +-
 system/vl.c                                   |  56 ++++++---
 target/alpha/cpu.c                            |   1 +
 target/alpha/sys_helper.c                     |   4 +-
 target/alpha/translate.c                      |   3 +-
 target/arm/arch_dump.c                        |   2 +-
 target/arm/arm-powerctl.c                     |   2 +-
 target/arm/cpu.c                              |   7 +-
 target/arm/cpu64.c                            |   8 +-
 target/arm/debug_helper.c                     |   2 +-
 target/arm/gdbstub.c                          |   2 +-
 target/arm/helper.c                           |   8 +-
 target/arm/hvf/hvf.c                          |  19 ++-
 target/arm/kvm.c                              |   8 +-
 target/arm/machine.c                          |   4 +-
 target/arm/tcg/helper-a64.c                   |   4 +
 target/arm/tcg/mte_helper.c                   |   5 +
 target/arm/tcg/psci.c                         |   2 +-
 target/arm/tcg/sve_helper.c                   |   3 +
 target/avr/cpu.c                              |   1 +
 target/avr/translate.c                        |   1 +
 target/hexagon/cpu.c                          |   1 +
 target/hppa/cpu.c                             |   1 +
 target/hppa/op_helper.c                       |   3 +
 target/hppa/sys_helper.c                      |   4 +-
 target/hppa/translate.c                       |   1 +
 target/i386/arch_dump.c                       |   4 +-
 target/i386/arch_memory_mapping.c             |   2 +-
 target/i386/cpu-apic.c                        |   6 +-
 target/i386/{cpu-sysemu.c => cpu-system.c}    |   2 +-
 target/i386/cpu.c                             |   5 +-
 target/i386/helper.c                          |   5 +-
 target/i386/host-cpu.c                        |   2 +-
 target/i386/hvf/hvf-cpu.c                     |   4 +-
 target/i386/hvf/hvf.c                         |   8 +-
 target/i386/hvf/x86_cpuid.c                   |   2 +-
 target/i386/hvf/x86_task.c                    |   2 +-
 target/i386/hvf/x86hvf.c                      |   2 +-
 target/i386/kvm/kvm-cpu.c                     |   2 +-
 target/i386/kvm/kvm.c                         |   8 +-
 target/i386/kvm/xen-emu.c                     |   6 +-
 target/i386/machine.c                         |   6 +-
 target/i386/nvmm/nvmm-accel-ops.c             |   6 +-
 target/i386/nvmm/nvmm-all.c                   |   6 +-
 .../{sev-sysemu-stub.c => sev-system-stub.c}  |   0
 target/i386/sev.c                             |   6 +-
 target/i386/tcg/excp_helper.c                 |   2 +-
 .../i386/tcg/{sysemu => system}/bpt_helper.c  |   2 +-
 .../i386/tcg/{sysemu => system}/excp_helper.c |   2 +-
 .../i386/tcg/{sysemu => system}/fpu_helper.c  |   2 +-
 .../i386/tcg/{sysemu => system}/misc_helper.c |   2 +-
 .../i386/tcg/{sysemu => system}/seg_helper.c  |   2 +-
 .../i386/tcg/{sysemu => system}/smm_helper.c  |   2 +-
 .../i386/tcg/{sysemu => system}/svm_helper.c  |   2 +-
 target/i386/tcg/{sysemu => system}/tcg-cpu.c  |   4 +-
 target/i386/tcg/tcg-cpu.c                     |   1 +
 target/i386/tcg/translate.c                   |   9 +-
 target/i386/whpx/whpx-accel-ops.c             |   6 +-
 target/i386/whpx/whpx-all.c                   |   6 +-
 target/i386/whpx/whpx-apic.c                  |   4 +-
 target/loongarch/arch_dump.c                  |   2 +-
 target/loongarch/cpu.c                        |  11 +-
 target/loongarch/kvm/kvm.c                    |   8 +-
 target/loongarch/machine.c                    |   2 +-
 target/m68k/translate.c                       |   1 +
 target/microblaze/cpu.c                       |   1 +
 target/microblaze/translate.c                 |   1 +
 target/mips/cpu.c                             |   8 +-
 target/mips/kvm.c                             |   6 +-
 target/mips/{sysemu => system}/addr.c         |   0
 target/mips/{sysemu => system}/cp0.c          |   0
 target/mips/{sysemu => system}/cp0_timer.c    |   2 +-
 target/mips/{sysemu => system}/machine.c      |   0
 .../mips/{sysemu => system}/mips-qmp-cmds.c   |   0
 target/mips/{sysemu => system}/physaddr.c     |   0
 target/mips/tcg/exception.c                   |   1 +
 .../mips/tcg/{sysemu => system}/cp0_helper.c  |   0
 .../mips/tcg/{sysemu => system}/lcsr_helper.c |   0
 .../mips/tcg/{sysemu => system}/mips-semi.c   |  43 +++++--
 .../tcg/{sysemu => system}/semihosting-stub.c |   0
 .../tcg/{sysemu => system}/special_helper.c   |   1 +
 .../mips/tcg/{sysemu => system}/tlb_helper.c  |   0
 target/mips/tcg/translate.c                   |   2 +-
 target/openrisc/cpu.c                         |   1 +
 target/openrisc/translate.c                   |   1 +
 target/ppc/arch_dump.c                        |   4 +-
 target/ppc/compat.c                           |   6 +-
 target/ppc/cpu.c                              |   2 +-
 target/ppc/cpu_init.c                         |   6 +-
 target/ppc/excp_helper.c                      |   6 +-
 target/ppc/helper_regs.c                      |   4 +-
 target/ppc/kvm.c                              |  14 +--
 target/ppc/machine.c                          |   6 +-
 target/ppc/mmu-hash32.c                       |   2 +-
 target/ppc/mmu-hash64.c                       |   2 +-
 target/ppc/mmu-radix64.c                      |   2 +-
 target/ppc/mmu_common.c                       |   2 +-
 target/ppc/mmu_helper.c                       |   2 +-
 target/ppc/translate.c                        |   1 +
 target/riscv/arch_dump.c                      |   2 +-
 target/riscv/cpu.c                            |   6 +-
 target/riscv/cpu_helper.c                     |   2 +-
 target/riscv/csr.c                            |   2 +-
 target/riscv/debug.c                          |   2 +-
 target/riscv/kvm/kvm-cpu.c                    |   8 +-
 target/riscv/machine.c                        |   4 +-
 target/riscv/pmu.c                            |   4 +-
 target/riscv/riscv-qmp-cmds.c                 |   4 +-
 target/riscv/tcg/tcg-cpu.c                    |   1 +
 target/riscv/translate.c                      |   5 +-
 target/rx/cpu.c                               |   1 +
 target/rx/translate.c                         |   1 +
 target/s390x/arch_dump.c                      |   2 +-
 target/s390x/cpu-dump.c                       |   2 +-
 target/s390x/{cpu-sysemu.c => cpu-system.c}   |  18 +--
 target/s390x/cpu.c                            |  14 +--
 target/s390x/cpu_models.c                     |   6 +-
 ...pu_models_sysemu.c => cpu_models_system.c} |   4 +-
 target/s390x/diag.c                           |   4 +-
 target/s390x/gdbstub.c                        |   4 +-
 target/s390x/helper.c                         |   6 +-
 target/s390x/interrupt.c                      |   4 +-
 target/s390x/kvm/kvm.c                        |  10 +-
 target/s390x/kvm/pv.c                         |   6 +-
 target/s390x/machine.c                        |   4 +-
 target/s390x/mmu_helper.c                     |   4 +-
 target/s390x/sigp.c                           |   6 +-
 target/s390x/tcg/mem_helper.c                 |   5 +-
 target/s390x/tcg/misc_helper.c                |   4 +-
 target/s390x/tcg/translate.c                  |   5 +-
 target/sh4/cpu.c                              |   1 +
 target/sh4/helper.c                           |   2 +-
 target/sh4/translate.c                        |   1 +
 target/sparc/cpu.c                            |  63 ++++++++++
 target/sparc/int32_helper.c                   |   2 +-
 target/sparc/ldst_helper.c                    |   3 +
 target/sparc/translate.c                      |  32 +----
 target/tricore/cpu.c                          |   1 +
 target/tricore/translate.c                    |   1 +
 target/xtensa/translate.c                     |   1 +
 target/xtensa/xtensa-semi.c                   |  15 +--
 tcg/tci.c                                     |   1 +
 tests/qtest/fuzz/fuzz.c                       |   6 +-
 tests/qtest/vhost-user-test.c                 |   2 +-
 tests/unit/check-qom-proplist.c               |   2 +-
 tests/unit/test-bdrv-drain.c                  |   3 +-
 tests/unit/test-bdrv-graph-mod.c              |   2 +-
 tests/unit/test-block-backend.c               |   2 +-
 tests/unit/test-block-iothread.c              |   3 +-
 tests/unit/test-blockjob-txn.c                |   2 +-
 tests/unit/test-blockjob.c                    |   2 +-
 tests/unit/test-char.c                        |   2 +-
 tests/unit/test-image-locking.c               |   2 +-
 tests/unit/test-qdev-global-props.c           |  22 ++++
 tests/unit/test-replication.c                 |   2 +-
 tests/unit/test-seccomp.c                     |   2 +-
 tests/unit/test-throttle.c                    |   2 +-
 tests/unit/test-timed-average.c               |   2 +-
 tests/unit/test-yank.c                        |   2 +-
 ui/curses.c                                   |   2 +-
 ui/dbus-clipboard.c                           |   2 +-
 ui/dbus-listener.c                            |   2 +-
 ui/dbus.c                                     |   2 +-
 ui/egl-helpers.c                              |   2 +-
 ui/gtk-egl.c                                  |   2 +-
 ui/gtk-gl-area.c                              |   2 +-
 ui/gtk.c                                      |   4 +-
 ui/input-barrier.c                            |   2 +-
 ui/input-linux.c                              |   2 +-
 ui/input.c                                    |   6 +-
 ui/sdl2.c                                     |   6 +-
 ui/spice-app.c                                |   2 +-
 ui/spice-core.c                               |   4 +-
 ui/vnc.c                                      |   4 +-
 ui/win32-kbd-hook.c                           |   2 +-
 util/async.c                                  |   2 +-
 util/log.c                                    |   2 +
 util/main-loop.c                              |   4 +-
 util/oslib-posix.c                            |   2 +-
 util/qemu-thread-posix.c                      |   1 +
 util/qemu-timer.c                             |   8 +-
 crypto/akcipher-gcrypt.c.inc                  |   2 +-
 crypto/akcipher-nettle.c.inc                  |   2 +-
 block/meson.build                             |   6 +-
 hw/core/meson.build                           |   2 +-
 net/vmnet-common.m                            |   2 +-
 scripts/clean-includes                        |   6 +-
 .../codeconverter/test_regexps.py             |   4 +-
 scripts/coverity-scan/COMPONENTS.md           |   4 +-
 target/i386/meson.build                       |   5 +-
 target/i386/tcg/meson.build                   |   2 +-
 .../i386/tcg/{sysemu => system}/meson.build   |   0
 target/mips/meson.build                       |   2 +-
 target/mips/{sysemu => system}/meson.build    |   0
 target/mips/tcg/meson.build                   |   2 +-
 .../mips/tcg/{sysemu => system}/meson.build   |   0
 target/s390x/meson.build                      |   4 +-
 target/s390x/trace-events                     |   2 +-
 ui/cocoa.m                                    |  10 +-
 1079 files changed, 2572 insertions(+), 2309 deletions(-)
 create mode 100644 accel/tcg/tb-internal.h
 delete mode 100644 include/exec/translate-all.h
 rename include/{sysemu => system}/accel-blocker.h (98%)
 rename include/{sysemu => system}/accel-ops.h (98%)
 rename include/{sysemu => system}/arch_init.h (100%)
 rename include/{sysemu => system}/balloon.h (100%)
 rename include/{sysemu => system}/block-backend-common.h (100%)
 rename include/{sysemu => system}/block-backend-global-state.h (100%)
 rename include/{sysemu => system}/block-backend-io.h (100%)
 rename include/{sysemu => system}/block-backend.h (100%)
 rename include/{sysemu => system}/block-ram-registrar.h (100%)
 rename include/{sysemu => system}/blockdev.h (100%)
 rename include/{exec => system}/confidential-guest-support.h (96%)
 rename include/{sysemu => system}/cpu-throttle.h (95%)
 rename include/{sysemu => system}/cpu-timers-internal.h (100%)
 rename include/{sysemu => system}/cpu-timers.h (96%)
 rename include/{sysemu => system}/cpus.h (97%)
 rename include/{sysemu => system}/cryptodev-vhost-user.h (97%)
 rename include/{sysemu => system}/cryptodev-vhost.h (99%)
 rename include/{sysemu => system}/cryptodev.h (100%)
 rename include/{sysemu => system}/device_tree.h (100%)
 rename include/{sysemu => system}/dirtylimit.h (100%)
 rename include/{sysemu => system}/dirtyrate.h (100%)
 rename include/{sysemu => system}/dma.h (100%)
 rename include/{sysemu => system}/dump-arch.h (100%)
 rename include/{sysemu => system}/dump.h (99%)
 rename include/{sysemu => system}/event-loop-base.h (100%)
 rename include/{sysemu => system}/host_iommu_device.h (100%)
 rename include/{sysemu => system}/hostmem.h (97%)
 rename include/{sysemu => system}/hvf.h (100%)
 rename include/{sysemu => system}/hvf_int.h (100%)
 rename include/{sysemu => system}/hw_accel.h (83%)
 rename include/{sysemu => system}/iommufd.h (96%)
 rename include/{sysemu => system}/iothread.h (97%)
 rename include/{sysemu => system}/kvm.h (100%)
 rename include/{sysemu => system}/kvm_int.h (99%)
 rename include/{sysemu => system}/kvm_xen.h (93%)
 rename include/{sysemu => system}/memory_mapping.h (100%)
 rename include/{sysemu => system}/numa.h (97%)
 rename include/{sysemu => system}/nvmm.h (100%)
 rename include/{sysemu => system}/os-posix.h (100%)
 rename include/{sysemu => system}/os-win32.h (100%)
 rename include/{sysemu => system}/qtest.h (100%)
 rename include/{sysemu => system}/replay.h (99%)
 rename include/{sysemu => system}/reset.h (98%)
 rename include/{sysemu => system}/rng-random.h (100%)
 rename include/{sysemu => system}/rng.h (100%)
 rename include/{sysemu => system}/rtc.h (98%)
 rename include/{sysemu => system}/runstate-action.h (100%)
 rename include/{sysemu => system}/runstate.h (98%)
 rename include/{sysemu => system}/seccomp.h (100%)
 rename include/{sysemu => system}/spdm-socket.h (100%)
 rename include/{sysemu => system}/stats.h (100%)
 rename include/{sysemu/sysemu.h => system/system.h} (99%)
 rename include/{sysemu => system}/tcg.h (88%)
 rename include/{sysemu => system}/tpm.h (100%)
 rename include/{sysemu => system}/tpm_backend.h (99%)
 rename include/{sysemu => system}/tpm_util.h (94%)
 rename include/{sysemu => system}/vhost-user-backend.h (100%)
 rename include/{sysemu => system}/watchdog.h (100%)
 rename include/{sysemu => system}/whpx.h (100%)
 rename include/{sysemu => system}/xen-mapcache.h (98%)
 rename include/{sysemu => system}/xen.h (92%)
 create mode 100644 include/user/cpu_loop.h
 create mode 100644 include/user/guest-host.h
 create mode 100644 include/user/page-protection.h
 delete mode 100644 linux-user/cpu_loop-common.h
 create mode 100644 target/sparc/translate.h
 rename target/mips/tcg/{sysemu_helper.h.inc => system_helper.h.inc} (99%)
 rename block/{qapi-sysemu.c => qapi-system.c} (99%)
 rename hw/core/{cpu-sysemu.c => cpu-system.c} (98%)
 rename target/i386/{cpu-sysemu.c => cpu-system.c} (99%)
 rename target/i386/{sev-sysemu-stub.c => sev-system-stub.c} (100%)
 rename target/i386/tcg/{sysemu => system}/bpt_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/excp_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/fpu_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/misc_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/seg_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/smm_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/svm_helper.c (99%)
 rename target/i386/tcg/{sysemu => system}/tcg-cpu.c (96%)
 rename target/mips/{sysemu => system}/addr.c (100%)
 rename target/mips/{sysemu => system}/cp0.c (100%)
 rename target/mips/{sysemu => system}/cp0_timer.c (99%)
 rename target/mips/{sysemu => system}/machine.c (100%)
 rename target/mips/{sysemu => system}/mips-qmp-cmds.c (100%)
 rename target/mips/{sysemu => system}/physaddr.c (100%)
 rename target/mips/tcg/{sysemu => system}/cp0_helper.c (100%)
 rename target/mips/tcg/{sysemu => system}/lcsr_helper.c (100%)
 rename target/mips/tcg/{sysemu => system}/mips-semi.c (84%)
 rename target/mips/tcg/{sysemu => system}/semihosting-stub.c (100%)
 rename target/mips/tcg/{sysemu => system}/special_helper.c (99%)
 rename target/mips/tcg/{sysemu => system}/tlb_helper.c (100%)
 rename target/s390x/{cpu-sysemu.c => cpu-system.c} (96%)
 rename target/s390x/{cpu_models_sysemu.c => cpu_models_system.c} (99%)
 rename target/i386/tcg/{sysemu => system}/meson.build (100%)
 rename target/mips/{sysemu => system}/meson.build (100%)
 rename target/mips/tcg/{sysemu => system}/meson.build (100%)

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E38C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visgD-0002Rg-5X; Thu, 22 Jan 2026 06:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgB-0002RC-4R
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:16:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visg8-0001D2-8N
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:16:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo9261755e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080602; x=1769685402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PMqN6lkh7yPZGXejYyNoGzoSMyNa3bSDLCOnAEkDrLk=;
 b=sj/y1e/FKcXMI88MeoYKI75dJoSK98dMi8JoKNQtBhBphnMDSDozEdRm2f6vQy2vPA
 5OMy0LUdGjHHE30wmbW9WqCY/NZ1+E0mbZPFgyA5pfl2QOCo5QUuFTegCRBoUZbxsGE2
 v4FIH2H1qH+uDRjxChq4HkClGOdAHGLhQlvAz5zrg0mVfpnIMvlOXtOeB8s+0J+LsmLX
 k5vX5FzfYy9gW/71tsfndANGCGd9CVKXTFrqM0tR3T0CzmQb4+rl457BMloYs5YGqVyJ
 PNOBXHFK1RtElk/5ZkIxfNyPOLqNBMrYHv44bV799UIvOv/UhifBx7rRnnvhA+OkVZUd
 hfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080602; x=1769685402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMqN6lkh7yPZGXejYyNoGzoSMyNa3bSDLCOnAEkDrLk=;
 b=MeIddPu38eDXZljmW5dBX/AG5q8YamH6T5V8sz7DU5sekGPGuTICCLqwzchx+fxbIq
 ko7BdJmjkmO84cRIq+qnShyTYiW4SlVU5f3pfSJoT8pLFEuAbMqzLmO2iz8AJs73/mIa
 Zy5oz0ig62W2kNoPBY7oMChS/y/YccviB/2aYL8SoW/evHgNGcVxR8HRVWwPJJLe6K72
 lM5SVbRoO+FQA3Q4V1F37UdhbT18zhnnthT6i+MqjihZN0BU7N5Fn7EVSkMOIxUxFEQV
 l+AKyWSW6GQ1kVh35J3Fvrw3/ZOQ0tUyQHA3Y5+BKpcxkkiEo9aXLNU2wTmhoVwVLEr7
 2L6A==
X-Gm-Message-State: AOJu0YyvXEAQFa446asOjSZeWD2Bf5VFBNR9NtuttY84M4saGH02Wl7J
 8x0hUGdGAIuHZEMsoikmb62D0MQjkjz4lOrk6LkQ8j9ZPr28G9B9Epf1UKgZEnjh4q6Qcox8x4c
 sPYtgQxM=
X-Gm-Gg: AZuq6aJWpJPlN36g/RYUEo5ncKHAm8qVEK/f24tjKa2p3cP+VgRTL76l2P+B9k9XAut
 0NVmr+MxLwHl0H6aSb1U5rFzYb5FnxkX9ZsvmJXHFg7thQOrQDaqd0RM6U2O6VXxe0gpwZPefdw
 QXoySiiB6pRzEVTm3FyDc6mGlSsuxMdjbkI8PsTMMsjQXCxuvgQWl/UC+yU123E34YlUSbAomnE
 0MrYl0hhOWO+8zFj/NPKIJdNkoxaAYfm36pm2uPd/pN4qxLuhNAXTcadDpCiJSOiu2fwM0dV+MM
 e0/39wrUOpdA1y8icaiJpYpD5R2/G+3+Jtr0ADrYU4JUVUG7MbO1WKm/kJ5jjEu+KSANYHJ5KdV
 r1UflOMGIL0+14nnpvEOljhCZk8/Z1nCwksp90QYCWv10ohZzn9VruKogTxMRhR55uS4+rGRUhL
 J/zGwWK98ljPdaB+YwjZ901J0yccBEdkMaTr2EJt1m/H3w/yk4a5RB6dMpVao6
X-Received: by 2002:a05:600c:8710:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-4801eb142famr282451095e9.33.1769080601429; 
 Thu, 22 Jan 2026 03:16:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cc278sm57319845e9.12.2026.01.22.03.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:16:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/37] Memory API patches for 2026-01-22
Date: Thu, 22 Jan 2026 12:16:33 +0100
Message-ID: <20260122111639.32346-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/memory-api-20260122

for you to fetch changes up to 1280ec826e98342db4e7c35daf7680d09121bde6:

  cpus: Allocate maximum number of ASes supported by the arch (2026-01-22 10:48:46 +0100)

----------------------------------------------------------------
Memory API patches

- Use explicit endianness for cpu_ld/st_data*() on some targets
- Reduce 'qemu/bswap.h' uses
- Introduce ldm_p/stm_p (MemOp) load/store helpers
- Allow restricting the legacy 'native-endian' APIs
- Forbid various targets to use legacy native endianness APIs
- Simplify cpu_address_space_init() API
----------------------------------------------------------------

Deliberately ignored checkpatch.pl errors:

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #314: FILE: system/memory_ldst.c.inc:448:
 +#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #182: FILE: system/memory_ldst.c.inc:97:
 +                                                    DEVICE_NATIVE_ENDIAN);

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #332: FILE: system/memory_ldst.c.inc:171:
 +                                             DEVICE_NATIVE_ENDIAN);

 ERROR: DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead
 #34: FILE: include/system/memory.h:31:
 +    DEVICE_NATIVE_ENDIAN = 0,

False negative:

  WARNING: added, moved or deleted file(s):

    dump/win_dump-stubs.c
    dump/win_dump-x86.c
    dump/Kconfig

  Does MAINTAINERS need updating?

Gustavo Romero (3):
  target/arm: Initialize AS 0 first
  target/i386: Add a _MAX sentinel to X86ASIdx enum
  target/arm: Add a _MAX sentinel to ARMASIdx enum

Philippe Mathieu-Daudé (34):
  target/i386: Use little-endian variant of cpu_ld/st_data*()
  target/riscv: Use little-endian variant of cpu_ld/st_data*() for
    vector
  target/m68k: Use big-endian variant of cpu_ld/st_data*()
  target/sparc: Use big-endian variant of cpu_ld/st_data*()
  target/sh4: Replace cpu_stl_data() call in OCBI helper
  target/ppc: Simplify endianness handling in Altivec opcodes
  bswap: Include missing 'qemu/bswap.h' header
  bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
  bswap: Remove unnecessary 'qemu/bswap.h'
  system/memory: Introduce ldm_p() and stm_p() load/store helpers
  system/memory: Define address_space_ldst[W] endian variants via
    template
  system/memory: Define address_space_ldst[L] endian variants via
    template
  system/memory: Define address_space_ldst[Q] endian variants via
    template
  system/memory: Factor address_space_ldst[M]_internal() helper out
  system/memory: Pass device_endian argument as MemOp bit
  system/memory: Use ldm_p() and stm_p() helpers
  system/memory: Directly call address_space_ldst[M]_internal() helper
  system: Allow restricting the legacy ld/st_phys() 'native-endian' API
  system: Allow restricting legacy address_space_ldst() native-endian
    API
  system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
  system: Allow restricting the legacy translator_ld() 'native-endian'
    API
  system: Allow restricting the legacy tswap() 'native-endian' API
  system: Allow restricting the legacy MO_TE* 'native-endian'
    definitions
  system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
  configs/targets: Forbid Hexagon to use legacy native endianness API
  configs/targets: Forbid HPPA to use legacy native endianness APIs
  configs/targets: Forbid LoongArch to use legacy native endianness APIs
  configs/targets: Forbid OpenRISC to use legacy native endianness APIs
  configs/targets: Forbid TriCore to use legacy native endianness API
  configs/targets: Forbid Renesas RX to use legacy native endianness API
  configs/targets: Forbid s390x to use legacy native endianness APIs
  dump: Abort in create_win_dump() on non-x86 guests
  dump: Build stubs once for non-x86 targets
  cpus: Allocate maximum number of ASes supported by the arch

 MAINTAINERS                                  |   1 +
 configs/targets/hexagon-linux-user.mak       |   1 +
 configs/targets/hppa-linux-user.mak          |   1 +
 configs/targets/hppa-softmmu.mak             |   1 +
 configs/targets/loongarch64-linux-user.mak   |   1 +
 configs/targets/loongarch64-softmmu.mak      |   1 +
 configs/targets/or1k-linux-user.mak          |   1 +
 configs/targets/or1k-softmmu.mak             |   1 +
 configs/targets/rx-softmmu.mak               |   1 +
 configs/targets/s390x-linux-user.mak         |   1 +
 configs/targets/s390x-softmmu.mak            |   1 +
 configs/targets/tricore-softmmu.mak          |   1 +
 block/qcow2.h                                |   1 +
 include/accel/tcg/cpu-ldst.h                 |   2 +
 include/exec/cpu-common.h                    |   4 -
 include/exec/memop.h                         |   4 +
 include/exec/translator.h                    |   5 +-
 include/exec/tswap.h                         |   3 +
 include/hw/core/cpu.h                        |   7 +-
 include/qemu/bswap.h                         |  72 +++
 include/qemu/host-utils.h                    |   1 -
 include/qemu/int128.h                        |   2 -
 include/system/memory.h                      |   8 +-
 include/system/memory_cached.h               |   2 +
 system/memory-internal.h                     |   2 +
 target/arm/cpu.h                             |   1 +
 target/i386/cpu.h                            |   1 +
 target/i386/ops_sse.h                        |  12 +-
 target/i386/tcg/seg_helper.h                 |  12 +-
 include/system/memory_ldst.h.inc             |  52 +--
 include/system/memory_ldst_endian.h.inc      |  33 ++
 include/system/memory_ldst_phys.h.inc        | 113 +----
 include/system/memory_ldst_phys_endian.h.inc |  57 +++
 audio/audio.c                                |   1 +
 block/blklogwrites.c                         |   1 +
 block/export/vduse-blk.c                     |   1 +
 block/export/vhost-user-blk-server.c         |   1 +
 block/export/virtio-blk-handler.c            |   1 +
 block/parallels-ext.c                        |   1 +
 dump/win_dump-stubs.c                        |  21 +
 dump/{win_dump.c => win_dump-x86.c}          |  20 +-
 hw/9pfs/9p-local.c                           |   1 +
 hw/block/cdrom.c                             |   1 +
 hw/block/hd-geometry.c                       |   1 +
 hw/core/cpu-common.c                         |   1 -
 hw/core/cpu-system.c                         |   2 +-
 hw/net/can/ctucan_core.c                     |   1 +
 hw/nvram/xlnx-efuse.c                        |   1 +
 hw/scsi/scsi-generic.c                       |   1 +
 hw/sd/sd.c                                   |   1 +
 hw/sd/ssi-sd.c                               |   1 +
 linux-user/vm86.c                            |   4 +-
 net/l2tpv3.c                                 |   1 +
 qga/commands-linux.c                         |   1 +
 scsi/pr-manager-helper.c                     |   1 +
 system/cpus.c                                |   1 -
 system/physmem.c                             |   8 +-
 target/arm/cpu.c                             |  13 +-
 target/arm/tcg/arith_helper.c                |   1 +
 target/i386/cpu.c                            |   1 +
 target/i386/kvm/kvm-cpu.c                    |   1 -
 target/i386/tcg/mem_helper.c                 |   8 +-
 target/i386/tcg/mpx_helper.c                 |  28 +-
 target/i386/tcg/seg_helper.c                 |  16 +-
 target/i386/tcg/system/excp_helper.c         |   8 +-
 target/i386/tcg/system/svm_helper.c          |  69 +--
 target/i386/tcg/system/tcg-cpu.c             |   1 -
 target/m68k/fpu_helper.c                     |  12 +-
 target/m68k/op_helper.c                      |  91 ++--
 target/ppc/mem_helper.c                      |  31 +-
 target/riscv/vector_helper.c                 |  12 +-
 target/sh4/op_helper.c                       |   5 +-
 target/sparc/ldst_helper.c                   |   6 +-
 tests/qtest/acpi-utils.c                     |   1 +
 tests/qtest/ahci-test.c                      |   2 +-
 tests/qtest/aspeed-hace-utils.c              |   1 +
 tests/qtest/bios-tables-test.c               |   1 +
 tests/qtest/libqos/ahci.c                    |   2 +-
 tests/qtest/libqos/generic-pcihost.c         |   2 +-
 tests/qtest/libqos/igb.c                     |   1 +
 tests/qtest/libqos/pci-spapr.c               |   2 +-
 tests/qtest/libqos/virtio-9p-client.c        |   1 +
 tests/qtest/migration/framework.c            |   1 +
 tests/qtest/npcm7xx_emc-test.c               |   1 +
 tests/qtest/tpm-emu.c                        |   1 +
 tests/qtest/ufs-test.c                       |   1 +
 tests/qtest/vmgenid-test.c                   |   1 +
 tests/unit/test-hbitmap.c                    |   1 +
 util/bitmap.c                                |   1 +
 util/hbitmap.c                               |   2 +-
 system/memory_ldst.c.inc                     | 449 ++-----------------
 system/memory_ldst_endian.c.inc              |  70 +++
 Kconfig                                      |   1 +
 dump/Kconfig                                 |   6 +
 dump/meson.build                             |   3 +-
 scripts/make-config-poison.sh                |   1 +
 96 files changed, 566 insertions(+), 769 deletions(-)
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 system/memory_ldst_endian.c.inc
 create mode 100644 dump/Kconfig

-- 
2.52.0



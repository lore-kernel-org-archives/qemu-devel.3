Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9894C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy9ni-0007P3-JP; Sun, 23 Aug 2026 11:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9nd-0007Np-Ls
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:07:53 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wy9nZ-0008Et-CK
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:07:53 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso2555462a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787497666; x=1788102466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rl3Ci7OZX6aBpxGKWeFuniwc0kLF7yJe6HIaEkuGg4U=;
 b=pz3y32tm+VZXE+fClue6pg5twC8Wu/gaxcrN0i6Kze5S0C411x946+3LBlPCtgbV3T
 VBWEJ3/6kzEmOw9jJ1UQ0+L0A2b+v5sOZoN1C51tyP5AnOkYWrIGSiAefT8WKWr1sT8V
 lc3Gwcb+wPrQ5K6vCcsMaoh4+acLTE1HzwQYGwCCHeK1oU7TgAdtPjEodlcATquEnX/U
 ZW3QztcBZkAuXOdA2Li/UeuFf97iQPgNdQWLvery/YajHoP7S2UdNfq8FkPQ/V0tc0UA
 KE+rOjV4AEhxPbCvJx/SS7YGK0N4Wc4uRrMot1V30q/ZSzXsYvPAAKCmMrS1SD/O6Ihp
 TgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497666; x=1788102466;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rl3Ci7OZX6aBpxGKWeFuniwc0kLF7yJe6HIaEkuGg4U=;
 b=b2qdAVf56X82o8VbeGKvx+it2yTthDzZyQvrG5VyrqpIHVGZBzqEZUMzsoiehscS/X
 8VqYHSbvs1zBMIglRnMdNL1+/FbDCrXizwOcdRK7dfcN3jWWWgIEe4Ed6fLaRLXsV4DK
 yLR26UMsBPEzKrD25RFOpkcCbwg4BhcQq9c0Mkk1XXfODGThf1CbV4Ujt3fAeKQh2Sa8
 7WVp4RRS8lLVTD0FMb7utoKVfRG7acrKzzawbu1I62SP8+6gDygevy7NPP7xC0NNu4BG
 nxJzH3MNx4bPmwLmLeGS4SiUc/mllp2TC39D1LmVypp34X0fn+bKTRdR+uVjJWXHOHwi
 PA2Q==
X-Gm-Message-State: AFuF++nsYy15m6ir4fQeWu/XtvbcBa4BLG/vjMxDpKFzpPiy961hdSGN
 rvaamIjj5Zcz8RXmjtlHaX3Qa0OPe54Cyge7t07nNm+4oQTCe2Pr++wDRNR3Rm6xiIA=
X-Gm-Gg: AR+sD111Y3vdsM+CnN1UheF8s7zkfiHNfIfeo9+owZybI+7I/ysCDHVy8AoytOHRIdQ
 KFZZeucHgJqOKHwRq/Pl5SSFFTrIHzHmWXn5qbs8zLYjQ1aGibNxZVz1YMguJto1DiTKN5GVqCh
 +WVX6usdDFFcbGNSfPkztNnz14tnyVsuEzoAXIf8q6wJDeMBi/bFpGXbS/x94ZAQGMRL6w2FGvg
 tfxTfUzpkrT4jnlq/oeXVgTTnRX+hVflJsmFFXjHZIhSkBsSZUskEShIIdg8MCHomjM56Gz+zc9
 CG66A0NtCtLssL/8jXcNQLt5S8/G1uRQNWTeWz5q6nS91Qw+nn8K6GyUuA5ilgDcn4wubpSo17A
 FZjPZt6xbypDep9T9tiEwSf6ZQrZO2CRSnBUb022fsdxO0otbEHWZDtCwKhVlWUbWqX2Helnmyx
 jEKCURLcGzTd79fLyYG15kF5a95oiEOzZxdB/lGtYFGZavQbEgL7A7U4Ic/xxq74/RoT11ItP71
 et1sU+dXEGscT3PzNFCAg==
X-Received: by 2002:a17:90b:3b4d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-395c39b1750mr32759887a91.10.1787497665915; 
 Sun, 23 Aug 2026 08:07:45 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1418619d6ecsm16024511c88.14.2026.08.23.08.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:07:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
Date: Sun, 23 Aug 2026 23:07:18 +0800
Message-ID: <20260823150731.896-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series produces one qemu-system binary that can run ARM (32 and 64)
and RISC-V (32 and 64, little- and big-endian TargetInfo). It follows
Pierrick Bouvier's merged series "single-binary: implement dynamic
filtering for machine types":

  https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com/

That work added TYPE_TARGET_SPECIFIC so machines can be filtered per
target in one process. This series uniquifies remaining per-target C
symbols and QOM names, selects TargetInfo at runtime, and links ARM
plus RISC-V into qemu-system.

A combined link cannot keep C symbols or QOM type names that were unique
only because each qemu-system-$arch was a separate binary. The first
patches remove those collisions:

- TYPE_ACCEL_CPU is a single abstract accel-cpu parent, registered once
  next to TYPE_ACCEL. Leaf names still encode the CPU type so
  accel_init_cpu_interfaces() can look up "<accel>-accel-"
  CPU_RESOLVING_TYPE.
- ARM and RISC-V virt QOM names become arm-virt and riscv-virt. The
  boards keep -machine virt via mc->alias after the selected target is
  applied.
- virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an arch
  prefix so the combined link does not need meson -D name mangling.
  LoongArch virt_acpi_setup is renamed in the same pass.

Target selection then has to work with more than one TargetInfo in the
process:

- Register target-info-<name>-le and -be from one system
  target-info-def.c unit, sharing arch fields. is_default follows
  TARGET_BIG_ENDIAN so riscv/arm stay LE and ppc/s390x stay BE when
  -target is omitted.
- Parse -target before TargetInfo is fixed. Tokens are target_name or
  target_name-be / -le. When -target is omitted, infer the token from
  the program basename (strip .exe, longest registered suffix, drop a
  trailing w for Windows GUI binaries).
- Combined binaries cannot keep one global C symbol per arch for
  query-cpu-definitions, dump notes, or Angel semihosting. Those
  handlers move onto a process-wide TargetCpuOps table.

The last patch builds qemu-system (and qemu-systemw on Windows) from
aarch64 common/system objects plus RISC-V arch objects, and installs
qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks so argv[0] still
selects TargetInfo.

Examples:

  qemu-system -target aarch64 -M virt ...
  qemu-system-riscv64 -M virt ...

A basename that matches no registered token falls through to the unique
default. A combined binary with no suffix requires -target when more
than one default TargetInfo is registered.

Based-on: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>

Yonggang Luo (12):
  accel: use a shared TYPE_ACCEL_CPU parent
  hw/riscv/virt: use unique QOM name and target filter
  hw/arm/virt: use unique QOM name and target filter
  hw/arm/virt: prefix ACPI helpers with arm_virt_
  hw/riscv/virt: prefix ACPI helpers with riscv_virt_
  hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
  target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
  target/riscv: seed cfg.big_endian from TargetInfo
  target-info: register le and be TargetInfo variants
  target-info: add -target and program-name selection
  target-info: dispatch CPU QMP, dump, and Angel semihosting
  meson: link ARM and RISC-V into qemu-system

 MAINTAINERS                                   |   1 -
 accel/accel-common.c                          |  21 +-
 hw/arm/virt-acpi-build.c                      |   4 +-
 hw/arm/virt.c                                 |  14 +-
 hw/core/cpu-system.c                          |  23 +++
 hw/core/machine-qmp-cmds.c                    |  26 +++
 hw/loongarch/virt-acpi-build.c                |   6 +-
 hw/loongarch/virt.c                           |   2 +-
 hw/riscv/virt-acpi-build.c                    |   2 +-
 hw/riscv/virt.c                               |  12 +-
 include/accel/accel-cpu-target.h              |   3 +-
 include/accel/accel-cpu.h                     |   2 +
 include/hw/arm/virt.h                         |   6 +-
 include/hw/loongarch/virt.h                   |   2 +-
 include/hw/riscv/virt.h                       |   6 +-
 include/qemu/target-info-impl.h               |   6 +
 include/qemu/target-info-init.h               |  29 ++-
 include/qemu/target-info-qom.h                |  51 ++++-
 include/semihosting/common-semi.h             |  56 +++++-
 meson.build                                   | 156 ++++++++++++++-
 qemu-options.hx                               |  13 ++
 stubs/dump.c                                  |  27 ---
 stubs/meson.build                             |   2 -
 stubs/qmp-cpu.c                               |  21 --
 system/vl.c                                   |  28 ++-
 target-info-def.c                             |  61 ++++--
 target-info-qom.c                             | 180 +++++++++++++++++-
 target-info.c                                 |  32 ++++
 target/arm/arch_dump.c                        |   8 +-
 target/arm/arm-qmp-cmds.c                     |  15 +-
 target/arm/common-semi-target.c               |  23 ++-
 target/arm/meson.build                        |   7 +-
 target/i386/arch_dump.c                       |   8 +-
 target/i386/cpu-system.c                      |  12 +-
 target/i386/cpu.c                             |   6 +-
 target/loongarch/arch_dump.c                  |   8 +-
 target/loongarch/loongarch-qmp-cmds.c         |  15 +-
 target/mips/system/mips-qmp-cmds.c            |  15 +-
 target/ppc/arch_dump.c                        |   8 +-
 target/ppc/ppc-qmp-cmds.c                     |  15 +-
 target/riscv/arch_dump.c                      |   8 +-
 target/riscv/common-semi-target.c             |  25 ++-
 target/riscv/cpu.c                            |  10 +
 target/riscv/helper.h                         |   6 +-
 target/riscv/meson.build                      |   4 +-
 target/riscv/riscv-qmp-cmds.c                 |  15 +-
 target/riscv/tcg/bitmanip_helper.c            |   4 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |   2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |   4 +-
 target/riscv/tcg/op_helper.c                  |   2 +-
 target/s390x/arch_dump.c                      |   8 +-
 target/s390x/cpu_models_system.c              |  15 +-
 tests/qtest/fuzz/fuzz.c                       |   2 +-
 53 files changed, 809 insertions(+), 228 deletions(-)
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/qmp-cpu.c

-- 
2.52.0.windows.1



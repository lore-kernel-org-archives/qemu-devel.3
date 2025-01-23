Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D1C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6s4-00061T-81; Thu, 23 Jan 2025 18:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6s2-00060d-NW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6rz-0003ou-54
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso10331415e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675857; x=1738280657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SrJqTercMM7Oiv7TI6NgScSjNQ/Q43/m4EWNljCwQJg=;
 b=t3MYesDsGnrH3gGJe0ZQ0os3VY5n05M8xIFoC1B7D4X3sfM8GhhhlP+f9rkzeSu2Im
 KssfjgynuCCE/nv7kG4fh3O/1gWg9gWK4okSRALRza0CyFN+1nSHPxDhJYcvHQJ5uVzz
 fXipSF+E3GsheWtgKdvUSfFpVCGlIpgcDSQhWEmqITDvBePhgxHTrqNJuJmJ/q9K3YwF
 //ayKAd93hkN+1dGreq6mXqswgrN81e4oz45Qqn5ZeFVcUPrJ6CMUnvOcyhxXBatOGY4
 Zfu63QXbviaG4qE5ASTeWMxx327WwRKD1uYdZBLXafPR89rXSal38gc4hZtjAHhod9OQ
 zVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675857; x=1738280657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SrJqTercMM7Oiv7TI6NgScSjNQ/Q43/m4EWNljCwQJg=;
 b=auCBNAMhDMTqaPGk/KX0LGDsPLanb+gn7Wf2Q1XV5TGBwwIEm0ImHYKhg+QIAlQ6Fw
 aOSIcTbRFMHkeTFYiQ6m/DwtzO8LWrI5IuET8sPGhNYKAHA8/BDiZhvxTJN/EzAwEM3x
 lMdxxmSxY4GEaDdmVIxVfd3eT7zCUJxbKR7uKTF4EJkBxZHNoW/bsQVOnvl1Efj2MgBQ
 2Il/bNzTBOWofOQbLaXhVEbmMULCa79CJ1m/W6x7s3NQ2vkJfvjjOBz2GyqmymqmFtb8
 dhGN56EfAfCZtyogULki+TZJSWcVAwdTECZjui+zhq7loyp0AJkiq582e9RDDmkArv3h
 uNJA==
X-Gm-Message-State: AOJu0YxI8ur1jbliJskn8CUFzHBW9t2H+n0pDRcgHShZ59y+qW/bR3cK
 hcv8G9mXbYeM2M+whx3HwI1/fEbd9OvrApSE05aunObpG2FANdYBHskxjWkhDFUQ1OLqTQtrcLf
 SO24=
X-Gm-Gg: ASbGncvVzazp9CKDQh9JQ832NwcX47GA0jwIQImEUPoSWEgY0UKxYuH3Edv3axDx245
 VS5PieDE25XCg7PRYZWOujqzRzJ9q4aZqn+yAZVL/BIvIWR4FA26G5o3r1bmjPqKgIe0o5eUaZ9
 CL0TiIg9kgdLokpQ4eM6SoitxAF+PdvKQcD2uvGdE2tjwFoS2SfjrKUbSkG5NDYjPFtrsSgJqFU
 ZsLW52viVCgVhQEiWRrwU3VyTzCszTQfeChLUvVjL85r/NED1jIcsWRw85Cc5xaGC+we+tesN6X
 n4Shz/v9kWmOLQUcPD18egL3nim8fUJq1ABC0e5niaTgh/0ev9U8bKQISkVjiYTIlA==
X-Google-Smtp-Source: AGHT+IGBiB8E0eTSoI28+V9cp1gWnvQIF0NcnM5MrTMqS5rNZ7M1PFDJt5j8Or2lR2bn/A8RFfyqaQ==
X-Received: by 2002:a05:600c:a09:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-438913f86dcmr267594425e9.18.1737675857123; 
 Thu, 23 Jan 2025 15:44:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c098sm6544235e9.31.2025.01.23.15.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/20] accel: Simplify cpu-target.c (omnibus)
Date: Fri, 24 Jan 2025 00:43:54 +0100
Message-ID: <20250123234415.59850-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Yet another cleanup series before respining the "extract TCG
fields from CPUState" series. Before that, we try to clarify
a bit the code around CPU creation. Target specific code is
reduced further. Some intermixed User/System is separated,
making maintenance simpler IMHO. Since my local branch is
quite big, I tried to group here all the generic patches.

Regards,

Phil.

Based-on: <20250123215609.30432-1-philmd@linaro.org>
  "target/ppc: Move TCG code from excp_helper.c to tcg-excp_helper.c"

Philippe Mathieu-Daudé (20):
  qemu/compiler: Absorb 'clang-tsa.h'
  user: Extract common MMAP API to 'user/mmap.h'
  gdbstub: Check for TCG before calling tb_flush()
  cpus: Cache CPUClass early in instance_init() handler
  cpus: Keep default fields initialization in cpu_common_initfn()
  accel/kvm: Remove unused 'system/cpus.h' header in kvm-cpus.h
  accel/tcg: Build tcg_flags helpers as common code
  accel/tcg: Restrict tlb_init() / destroy() to TCG
  accel/tcg: Restrict 'icount_align_option' global to TCG
  accel/tcg: Rename 'hw/core/tcg-cpu-ops.h' -> 'accel/tcg/cpu-ops.h'
  accel: Rename 'hw/core/accel-cpu.h' -> 'accel/accel-cpu-target.h'
  accel/accel-cpu-target.h: Include missing 'cpu.h' header
  accel: Forward-declare AccelOpsClass in 'qemu/typedefs.h'
  accel/tcg: Move cpu_memory_rw_debug() user implementation to
    user-exec.c
  cpus: Fix style in cpu-target.c
  cpus: Restrict cpu_common_post_load() code to TCG
  cpus: Have cpu_class_init_props() per user / system emulation
  cpus: Have cpu_exec_initfn() per user / system emulation
  cpus: Register VMState per user / system emulation
  cpus: Build cpu_exec_[un]realizefn() methods once

 MAINTAINERS                                   |   4 +-
 accel/kvm/kvm-cpus.h                          |   2 -
 accel/tcg/internal-common.h                   |  13 +
 bsd-user/qemu.h                               |  13 +-
 .../accel-cpu.h => accel/accel-cpu-target.h}  |   7 +-
 .../tcg-cpu-ops.h => accel/tcg/cpu-ops.h}     |   0
 include/block/block_int-common.h              |   1 -
 include/block/graph-lock.h                    |   2 -
 include/exec/exec-all.h                       |  16 -
 include/exec/page-protection.h                |   2 -
 include/hw/core/cpu.h                         |   2 +
 include/qemu/clang-tsa.h                      | 114 -------
 include/qemu/compiler.h                       |  87 +++++
 include/qemu/thread.h                         |   1 -
 include/qemu/typedefs.h                       |   1 +
 include/system/accel-ops.h                    |   1 -
 include/system/cpus.h                         |   4 -
 include/user/mmap.h                           |  32 ++
 linux-user/user-mmap.h                        |  19 +-
 accel/accel-system.c                          |   1 +
 accel/accel-target.c                          |   2 +-
 accel/hvf/hvf-accel-ops.c                     |   1 +
 accel/kvm/kvm-accel-ops.c                     |   1 +
 accel/qtest/qtest.c                           |   1 +
 accel/stubs/tcg-stub.c                        |   4 -
 accel/tcg/cpu-exec-common.c                   |  34 +-
 accel/tcg/cpu-exec.c                          |  37 +--
 accel/tcg/cputlb.c                            |   2 +-
 accel/tcg/icount-common.c                     |   2 +
 accel/tcg/monitor.c                           |   1 -
 accel/tcg/tcg-accel-ops.c                     |   1 +
 accel/tcg/translate-all.c                     |   3 +-
 accel/tcg/user-exec-stub.c                    |  11 +
 accel/tcg/user-exec.c                         |  94 +++++-
 accel/tcg/watchpoint.c                        |   2 +-
 accel/xen/xen-all.c                           |   1 +
 block/create.c                                |   1 -
 bsd-user/signal.c                             |   2 +-
 cpu-common.c                                  |   1 -
 cpu-target.c                                  | 314 +-----------------
 gdbstub/system.c                              |   6 +-
 hw/core/cpu-common.c                          |  31 ++
 hw/core/cpu-system.c                          | 170 ++++++++++
 hw/core/cpu-user.c                            |  44 +++
 hw/mips/jazz.c                                |   2 +-
 linux-user/signal.c                           |   2 +-
 system/cpus.c                                 |   1 +
 system/globals.c                              |   1 -
 system/physmem.c                              |   2 +-
 target/alpha/cpu.c                            |   2 +-
 target/arm/cpu.c                              |   2 +-
 target/arm/tcg/cpu-v7m.c                      |   2 +-
 target/arm/tcg/cpu32.c                        |   2 +-
 target/arm/tcg/mte_helper.c                   |   2 +-
 target/arm/tcg/sve_helper.c                   |   2 +-
 target/avr/cpu.c                              |   2 +-
 target/avr/helper.c                           |   2 +-
 target/hexagon/cpu.c                          |   2 +-
 target/hppa/cpu.c                             |   2 +-
 target/i386/hvf/hvf-cpu.c                     |   2 +-
 target/i386/kvm/kvm-cpu.c                     |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c             |   1 +
 target/i386/tcg/tcg-cpu.c                     |   4 +-
 target/i386/whpx/whpx-accel-ops.c             |   1 +
 target/loongarch/cpu.c                        |   2 +-
 target/m68k/cpu.c                             |   2 +-
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.c                             |   2 +-
 target/openrisc/cpu.c                         |   2 +-
 target/ppc/cpu_init.c                         |   2 +-
 target/ppc/kvm.c                              |   2 +-
 target/riscv/kvm/kvm-cpu.c                    |   2 +-
 target/riscv/tcg/tcg-cpu.c                    |   4 +-
 target/rx/cpu.c                               |   2 +-
 target/s390x/cpu.c                            |   2 +-
 target/s390x/tcg/mem_helper.c                 |   2 +-
 target/sh4/cpu.c                              |   2 +-
 target/sparc/cpu.c                            |   2 +-
 target/tricore/cpu.c                          |   2 +-
 target/xtensa/cpu.c                           |   2 +-
 tests/unit/test-bdrv-drain.c                  |   1 -
 tests/unit/test-block-iothread.c              |   1 -
 util/qemu-thread-posix.c                      |   1 -
 hw/core/meson.build                           |   5 +-
 84 files changed, 590 insertions(+), 578 deletions(-)
 rename include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} (92%)
 rename include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} (100%)
 delete mode 100644 include/qemu/clang-tsa.h
 create mode 100644 include/user/mmap.h
 create mode 100644 hw/core/cpu-user.c

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46784C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA13-0007ZA-0P; Wed, 17 Apr 2024 14:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA10-0007YX-Re
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA0y-0003Fl-Tp
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-418c1920313so391125e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378490; x=1713983290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sWgSPH0hB6hapED0PhGZRLsWFamg6B2t+4058UGzGJE=;
 b=Su6he3NxALWSBgnlLd467zX4j44/ZwlIBuuGt1QIkiXV7KtjbBr4EnayiplqCOnbHR
 3RPfG5Yqfqrx5e1nmtsM87ntkYpBXQ7ypKaGtloJQy7BWgs5qWGcjdYh8ES07njlFBUm
 WB0vvOKSFAKKhn8I+0m+KO/nUHj+4kyWZ05UUuiPF1/+tTb4bMW3OSQRzEyAmYhMV4K8
 BfiNdO2zp4wzf59aRy4ZD2EvK9P6+E8dCHBu95LoUwBHNuS6L8smdSWf3tC1amEHaY34
 tKVseaRKssyL4/rYmjwK7dTcXcLyZSuZsZRngQrveK0/HvcvJ5T3REIsXatq5S/E661k
 L+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378490; x=1713983290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWgSPH0hB6hapED0PhGZRLsWFamg6B2t+4058UGzGJE=;
 b=UcEG8GlMkr8J2t3lfX7/hB7LAxUyYnom1690c2xrURg+6lkszLV3/u4EnFI5tTVeVn
 pxH9PDmdt6h4Bq8ne8rjs5wAHD6rbiKHvEtmNh4dOG2lY0SrgumxqRTYCTvRdL2RK6rJ
 SisQO3Xn4DP2HlmwZwQ+IfcFZzh5QDHqYG1ELpzDAzUD4vZfZjPbup+ZvUG4/gn/VeuN
 Jq964kfF5HUE519oxFiJ4q037HO03Lmjae7n6UTfOIforN1fRZvUZhqCSFhciKyyLx6V
 dfmUIFWKT1i9t0z9LSSHCzh9c9oLxixiFou4hzthGtxvMpDyjdSEVWZ74BRKHz+Q/FtJ
 ERNA==
X-Gm-Message-State: AOJu0YzCxcdj0PV8LtMO+Q0CjSOXm2GvA3R4Kkxq1VuomKc7O7fE9oL7
 LR2aAY5Fzow2ToHLYh3RKyF2sirfdz9W5vJfDvv7tN8aljlZnPmoXA89t59IppCqiEHdJxNqopY
 m
X-Google-Smtp-Source: AGHT+IESd5MD9GKpjwqBpmP9YsYJeC9Sf5YALfjV+IUjt029IVx4QzTjqUV9LN8qAcprnT5K4wDUDA==
X-Received: by 2002:a05:600c:3554:b0:418:d626:30e4 with SMTP id
 i20-20020a05600c355400b00418d62630e4mr344479wmq.3.1713378490065; 
 Wed, 17 Apr 2024 11:28:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a05600c46cf00b00416e2c8b290sm3786826wmo.1.2024.04.17.11.28.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/21] exec/next for 9.1
Date: Wed, 17 Apr 2024 20:27:45 +0200
Message-ID: <20240417182806.69446-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi,

This series contains the patches I'm going to send in
a pull request once the final 9.0 tag is out. Sending
now since I'll post another series based on it.

Also available here for convenience:
https://gitlab.com/philmd/qemu/-/commits/exec-next

Regards,

Phil.

Philippe Mathieu-Daudé (21):
  gdbstub: Simplify #ifdef'ry in helpers.h
  hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
  exec: Rename NEED_CPU_H -> COMPILING_PER_TARGET
  exec: Include 'cpu.h' before validating CPUArchState placement
  exec: Expose 'target_page.h' API to user emulation
  target: Define TCG_GUEST_DEFAULT_MO in 'cpu-param.h'
  accel: Include missing 'exec/cpu_ldst.h' header
  gdbstub: Include missing 'hw/core/cpu.h' header
  semihosting/uaccess: Avoid including 'cpu.h'
  semihosting/guestfd: Remove unused 'semihosting/uaccess.h' header
  exec/cpu-all: Reduce 'qemu/rcu.h' header inclusion
  target/ppc/excp_helper: Avoid 'abi_ptr' in system emulation
  accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
  target/i386: Include missing 'exec/exec-all.h' header
  accel/tcg: Include missing 'hw/core/cpu.h' header
  exec/cpu-all: Remove unused 'qemu/thread.h' header
  exec/cpu-all: Remove unused tswapls() definitions
  exec: Declare target_words_bigendian() in 'exec/tswap.h'
  exec: Move [b]tswapl() declarations to 'exec/user/tswap-target.h'
  exec/user: Do not include 'cpu.h' in 'abitypes.h'
  exec: Declare abi_ptr type in its own 'abi_ptr.h' header

 MAINTAINERS                        |  1 +
 meson.build                        |  6 ++--
 accel/tcg/user-retaddr.h           | 28 +++++++++++++++++++
 bsd-user/freebsd/target_os_elf.h   |  1 +
 bsd-user/freebsd/target_os_stack.h |  1 +
 bsd-user/netbsd/target_os_elf.h    |  1 +
 bsd-user/openbsd/target_os_elf.h   |  1 +
 include/exec/abi_ptr.h             | 33 ++++++++++++++++++++++
 include/exec/cpu-all.h             | 13 +--------
 include/exec/cpu-defs.h            |  2 +-
 include/exec/cpu_ldst.h            | 45 ++++--------------------------
 include/exec/exec-all.h            |  1 +
 include/exec/helper-head.h         |  4 +--
 include/exec/memop.h               |  4 +--
 include/exec/memory.h              |  4 +--
 include/exec/ram_addr.h            |  1 +
 include/exec/translator.h          |  5 +++-
 include/exec/tswap.h               | 16 +++++++++--
 include/exec/user/abitypes.h       |  8 +++++-
 include/gdbstub/helpers.h          |  9 +++---
 include/hw/core/cpu.h              | 15 ++--------
 include/hw/core/tcg-cpu-ops.h      |  3 --
 include/qemu/osdep.h               |  2 +-
 include/semihosting/uaccess.h      |  2 +-
 include/sysemu/hvf.h               |  8 +++---
 include/sysemu/kvm.h               |  6 ++--
 include/sysemu/nvmm.h              |  4 +--
 include/sysemu/whpx.h              |  4 +--
 include/sysemu/xen.h               |  4 +--
 include/user/tswap-target.h        | 22 +++++++++++++++
 target/alpha/cpu-param.h           |  3 ++
 target/alpha/cpu.h                 |  3 --
 target/arm/cpu-param.h             |  8 ++++--
 target/arm/cpu.h                   |  3 --
 target/arm/kvm-consts.h            |  4 +--
 target/avr/cpu-param.h             |  2 ++
 target/avr/cpu.h                   |  2 --
 target/hppa/cpu-param.h            |  8 ++++++
 target/hppa/cpu.h                  |  6 ----
 target/i386/cpu-param.h            |  3 ++
 target/i386/cpu.h                  |  3 --
 target/loongarch/cpu-param.h       |  2 ++
 target/loongarch/cpu.h             |  2 --
 target/microblaze/cpu-param.h      |  3 ++
 target/microblaze/cpu.h            |  3 --
 target/mips/cpu-param.h            |  2 ++
 target/mips/cpu.h                  |  2 --
 target/openrisc/cpu-param.h        |  2 ++
 target/openrisc/cpu.h              |  2 --
 target/ppc/cpu-param.h             |  2 ++
 target/ppc/cpu.h                   |  2 --
 target/riscv/cpu-param.h           |  2 ++
 target/riscv/cpu.h                 |  2 --
 target/s390x/cpu-param.h           |  6 ++++
 target/s390x/cpu.h                 |  3 --
 target/sparc/cpu-param.h           | 23 +++++++++++++++
 target/sparc/cpu.h                 | 23 ---------------
 target/xtensa/cpu-param.h          |  3 ++
 target/xtensa/cpu.h                |  3 --
 accel/tcg/cpu-exec.c               |  3 ++
 accel/tcg/tcg-accel-ops.c          |  2 ++
 accel/tcg/translator.c             |  1 +
 accel/tcg/user-exec.c              |  1 +
 bsd-user/signal.c                  |  1 +
 bsd-user/strace.c                  |  1 +
 cpu-target.c                       |  1 +
 disas/disas.c                      |  1 +
 gdbstub/gdbstub.c                  |  1 +
 hw/audio/virtio-snd.c              |  2 +-
 hw/core/cpu-sysemu.c               |  2 +-
 hw/core/generic-loader.c           |  2 +-
 hw/display/vga.c                   |  2 +-
 hw/virtio/virtio.c                 |  1 +
 linux-user/elfload.c               |  1 +
 linux-user/i386/signal.c           |  1 +
 linux-user/ppc/signal.c            |  1 +
 page-target.c                      | 44 +++++++++++++++++++++++++++++
 semihosting/guestfd.c              |  5 +---
 system/physmem.c                   | 30 --------------------
 target/hexagon/translate.c         |  1 +
 target/i386/tcg/fpu_helper.c       |  1 +
 target/microblaze/cpu.c            |  1 +
 target/microblaze/translate.c      |  1 +
 target/nios2/translate.c           |  1 +
 target/ppc/excp_helper.c           |  2 +-
 target/target-common.c             | 10 -------
 scripts/analyze-inclusions         |  6 ++--
 target/meson.build                 |  2 --
 88 files changed, 293 insertions(+), 221 deletions(-)
 create mode 100644 accel/tcg/user-retaddr.h
 create mode 100644 include/exec/abi_ptr.h
 create mode 100644 include/user/tswap-target.h
 create mode 100644 page-target.c
 delete mode 100644 target/target-common.c

-- 
2.41.0



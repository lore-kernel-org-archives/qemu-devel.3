Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC15D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibO-000504-5T; Thu, 08 Jan 2026 00:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibM-0004zU-Bp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:28 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibJ-0005GX-RL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:28 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34e90f7b49cso1791364a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850224; x=1768455024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CEdaanuN4O4Pp+xNlzIUSei8+BxLkgpOOD9e/ocjqHM=;
 b=rafslRZsk7zUDlqpH8wDenKoOWqMJiTC1+AFoZG442OM7tuv94inThgritxK0gc5FZ
 ovz2JfWEsDld06eGDMa86fXI0UEkF4067sssIDdfOn3OStrlfiWFadvdRYJ4FsISJuHV
 Njyi62dSuw8ddggQW1vZBh5crVUWgA8ALkHeibKjaaDJXrdeUaGoOFo3FO/zj/WlkBQ5
 qIlGYfNq+MQX+VM0bGwZbCwzqRL5Ml0cLtPkr+h29c/1w+SWpYnUIudHAvvZhnfHRMr1
 QxWy2FkkFK5lWoBeVgBpT56upZZBvRFQsBKFC4f2p2Je8JCv+hRI1CRHouMaD+moSmAA
 0X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850224; x=1768455024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEdaanuN4O4Pp+xNlzIUSei8+BxLkgpOOD9e/ocjqHM=;
 b=PdfJdyizyXCoxnwFVYYSN5usI0zH7t8a9WbY0ZfaU95QdggG4Tf5btCjDHzCRMVpP/
 vH4XmEHr0GPIialm5uoQO/epMVzJeN4vtsn4/rYefUtriipuo4nMhIVn+OJaL5dH5fAZ
 ZM74sobimjWwpIqqOg8km4AnxISRITC7dnFtoTzGYGNMy2wAe4tGxc5cT9CkEPKKGbwl
 LNxE6GYpOhMgQrvKybxQYJUzgDZ4xYmDj3kHWn4LsFNqyfqYZjA50A3nHR/OYa1Wt/b1
 ucIK89XgN39M0glFfRIL2MpO46gOfy8guBbYCvrZaHrTt4tM5FzwIErJzsG5hvpJgZP5
 A0Jg==
X-Gm-Message-State: AOJu0YyaXT4pMCHyt3cwbvuPyi8VjHXInx5y80DswBIhq0TvjM3HE6yx
 L5+8EuFfH8mbgOw7LvEMu6kRxgWvHjDI8+/Vpun+OBI3kWNxUK3ykJiwfo9nTeRQmWHE/p7vsV4
 JVTUwfmU=
X-Gm-Gg: AY/fxX4tMo+NsQ9lmuP74MOv9o/GAyhPxCBJtrHAbYMouKyeLwqtdek/3BQsUKsmA1l
 6NF9NZbUJICR+ugyIcOSJp4XSPwSpOybxwA1FOUGOPAOe2c4n4etfQLDSvG+P5MteZ63CoO4yBe
 xcSuXkGu0PdMGwjwhlcV4yVyFAyoOuSPEmXjHJjioUGjOPPP2q3T91+PA3FbdNhRgvQTLzFt9zM
 vxGzce+mPyj1iti/CUmtLxBf98TUDNeaLaEhoihwK8JcFAn/XVeI6sWFAusSR1yER0xK1EMJMzu
 5aFIQsoal9zfvEh+USrxQALb9oFGbYe/Ee1ZI0+XTLWh4cSsx6nN+34i473p/CEIMtCGUxAERj2
 9ipiVmYkyMZulSgH4x5tkOq/lD/KEOF7FJTpvXuhG6NwdIRcAjRhm0RYJvGaUBFmMjF79crFPDA
 oRIMouwFjvp81xpPtNog==
X-Google-Smtp-Source: AGHT+IFeNlDSxydkCq8RbNrIq7Toc1rU/tbl8p1t5JohHSIRgh0JcoYqoJj+pXj5UEXDvQhlDK/uCw==
X-Received: by 2002:a17:90b:5643:b0:343:a631:28a8 with SMTP id
 98e67ed59e1d1-34f68cf39e6mr4829890a91.37.1767850223917; 
 Wed, 07 Jan 2026 21:30:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/50] Remove 32-bit host support
Date: Thu,  8 Jan 2026 16:29:28 +1100
Message-ID: <20260108053018.626690-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Long has it been threatened, but here we are at last.

32-bit host support was deprecated with the 10.0 release, and so
with the 11.0 release we may remove it.  Phil already did some
cleanup in 10.2, removing support for mips32 and ppc32 within tcg.

With a net -7302 in the diffstat, I think the motivations are clear,
even if half of that was tcg/arm/.


r~


Richard Henderson (50):
  gitlab: Remove 32-bit host testing
  meson: Reject 32-bit hosts
  *: Remove arm host support
  bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
  *: Remove __i386__ tests
  *: Remove i386 host support
  host/include/x86_64/bufferiszero: Remove no SSE2 fallback
  meson: Remove cpu == x86 tests
  *: Remove ppc host support
  tcg/i386: Remove TCG_TARGET_REG_BITS tests
  tcg/x86_64: Rename from i386
  tcg/ppc64: Rename from ppc
  meson: Drop host_arch rename for mips64
  meson: Drop host_arch rename for riscv64
  meson: Remove cpu == riscv32 tests
  tcg: Make TCG_TARGET_REG_BITS common
  tcg: Replace TCG_TARGET_REG_BITS / 8
  *: Drop TCG_TARGET_REG_BITS test for prefer_i64
  tcg: Remove INDEX_op_brcond2_i32
  tcg: Remove INDEX_op_setcond2_i32
  tcg: Remove INDEX_op_dup2_vec
  tcg/tci: Drop TCG_TARGET_REG_BITS tests
  tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
  tcg: Drop TCG_TARGET_REG_BITS test in region.c
  tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op.c
  tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
  tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-ldst.c
  tcg: Drop TCG_TARGET_REG_BITS tests in tcg.c
  tcg: Drop TCG_TARGET_REG_BITS tests in tcg-internal.h
  tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
  include/tcg: Drop TCG_TARGET_REG_BITS tests
  target/i386/tcg: Drop TCG_TARGET_REG_BITS test
  target/riscv: Drop TCG_TARGET_REG_BITS test
  accel/tcg/runtime: Remove 64-bit shift helpers
  accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
  tcg: Unconditionally define atomic64 helpers
  accel/tcg: Drop CONFIG_ATOMIC64 checks from ldst_atomicicy.c.inc
  accel/tcg: Drop CONFIG_ATOMIC64 test from translator.c
  linux-user/arm: Drop CONFIG_ATOMIC64 test
  linux-user/hppa: Drop CONFIG_ATOMIC64 test
  target/arm: Drop CONFIG_ATOMIC64 tests
  target/hppa: Drop CONFIG_ATOMIC64 test
  target/m68k: Drop CONFIG_ATOMIC64 tests
  target/s390x: Drop CONFIG_ATOMIC64 tests
  migration: Drop use of Stat64
  block: Drop use of Stat64
  util: Remove stats64
  include/qemu/atomic: Drop qatomic_{read,set}_[iu]64
  meson: Remove CONFIG_ATOMIC64
  include/qemu/atomic: Drop aligned_{u}int64_t

 accel/tcg/atomic_template.h                   |    4 +-
 accel/tcg/tcg-runtime.h                       |   23 -
 bsd-user/syscall_defs.h                       |    2 +-
 host/include/i386/host/cpuinfo.h              |   41 -
 host/include/i386/host/crypto/aes-round.h     |  152 -
 host/include/i386/host/crypto/clmul.h         |   29 -
 host/include/ppc/host/cpuinfo.h               |   30 -
 host/include/ppc/host/crypto/aes-round.h      |  182 -
 host/include/ppc64/host/cpuinfo.h             |   31 +-
 host/include/ppc64/host/crypto/aes-round.h    |  183 +-
 .../include/{riscv => riscv64}/host/cpuinfo.h |    0
 host/include/x86_64/host/cpuinfo.h            |   42 +-
 host/include/x86_64/host/crypto/aes-round.h   |  153 +-
 host/include/x86_64/host/crypto/clmul.h       |   30 +-
 include/accel/tcg/cpu-ldst-common.h           |    9 -
 include/block/block_int-common.h              |    3 +-
 include/qemu/atomic.h                         |   39 +-
 include/qemu/cacheflush.h                     |    2 +-
 include/qemu/osdep.h                          |    6 +-
 include/qemu/processor.h                      |    2 +-
 include/qemu/stats64.h                        |  199 -
 include/qemu/timer.h                          |    9 -
 include/system/cpu-timers-internal.h          |    2 +-
 include/tcg/helper-info.h                     |    2 +-
 .../tcg/target-reg-bits.h                     |    8 +-
 include/tcg/tcg-op.h                          |    9 +-
 include/tcg/tcg-opc.h                         |    9 +-
 include/tcg/tcg.h                             |   29 +-
 linux-user/include/host/arm/host-signal.h     |   43 -
 linux-user/include/host/i386/host-signal.h    |   38 -
 .../host/{mips => mips64}/host-signal.h       |    0
 linux-user/include/host/ppc/host-signal.h     |   39 -
 .../host/{riscv => riscv64}/host-signal.h     |    0
 migration/migration-stats.h                   |   36 +-
 tcg/aarch64/tcg-target-reg-bits.h             |   12 -
 tcg/arm/tcg-target-con-set.h                  |   47 -
 tcg/arm/tcg-target-con-str.h                  |   26 -
 tcg/arm/tcg-target-has.h                      |   73 -
 tcg/arm/tcg-target-mo.h                       |   13 -
 tcg/arm/tcg-target-reg-bits.h                 |   12 -
 tcg/arm/tcg-target.h                          |   73 -
 tcg/i386/tcg-target-reg-bits.h                |   16 -
 tcg/loongarch64/tcg-target-reg-bits.h         |   21 -
 tcg/mips/tcg-target-reg-bits.h                |   16 -
 tcg/{mips => mips64}/tcg-target-con-set.h     |    0
 tcg/{mips => mips64}/tcg-target-con-str.h     |    0
 tcg/{mips => mips64}/tcg-target-has.h         |    0
 tcg/{mips => mips64}/tcg-target-mo.h          |    0
 tcg/{mips => mips64}/tcg-target.h             |    0
 tcg/{ppc => ppc64}/tcg-target-con-set.h       |    0
 tcg/{ppc => ppc64}/tcg-target-con-str.h       |    0
 tcg/{ppc => ppc64}/tcg-target-has.h           |    0
 tcg/{ppc => ppc64}/tcg-target-mo.h            |    0
 tcg/{ppc => ppc64}/tcg-target.h               |    0
 tcg/riscv/tcg-target-reg-bits.h               |   19 -
 tcg/{riscv => riscv64}/tcg-target-con-set.h   |    0
 tcg/{riscv => riscv64}/tcg-target-con-str.h   |    0
 tcg/{riscv => riscv64}/tcg-target-has.h       |    0
 tcg/{riscv => riscv64}/tcg-target-mo.h        |    0
 tcg/{riscv => riscv64}/tcg-target.h           |    0
 tcg/s390x/tcg-target-reg-bits.h               |   17 -
 tcg/sparc64/tcg-target-reg-bits.h             |   12 -
 tcg/tcg-has.h                                 |    5 -
 tcg/tcg-internal.h                            |   21 +-
 tcg/tci/tcg-target-has.h                      |    2 -
 tcg/tci/tcg-target-mo.h                       |    2 +-
 tcg/tci/tcg-target-reg-bits.h                 |   18 -
 tcg/{i386 => x86_64}/tcg-target-con-set.h     |    0
 tcg/{i386 => x86_64}/tcg-target-con-str.h     |    0
 tcg/{i386 => x86_64}/tcg-target-has.h         |    8 +-
 tcg/{i386 => x86_64}/tcg-target-mo.h          |    0
 tcg/{i386 => x86_64}/tcg-target.h             |   13 +-
 accel/kvm/kvm-all.c                           |    2 +-
 accel/qtest/qtest.c                           |    4 +-
 accel/tcg/cputlb.c                            |   37 +-
 accel/tcg/icount-common.c                     |   25 +-
 accel/tcg/tcg-runtime.c                       |   15 -
 accel/tcg/translator.c                        |    4 +-
 accel/tcg/user-exec.c                         |    2 -
 block/io.c                                    |   10 +-
 block/qapi.c                                  |    2 +-
 disas/disas-host.c                            |    9 -
 hw/display/xenfb.c                            |   10 +-
 hw/virtio/virtio-mem.c                        |    2 +-
 linux-user/arm/cpu_loop.c                     |   19 +-
 linux-user/hppa/cpu_loop.c                    |   14 +-
 linux-user/mmap.c                             |    2 +-
 linux-user/syscall.c                          |    9 -
 migration/cpu-throttle.c                      |    4 +-
 migration/migration-stats.c                   |   16 +-
 migration/migration.c                         |   24 +-
 migration/multifd-nocomp.c                    |    2 +-
 migration/multifd-zero-page.c                 |    4 +-
 migration/multifd.c                           |   12 +-
 migration/qemu-file.c                         |    6 +-
 migration/ram.c                               |   30 +-
 migration/rdma.c                              |    8 +-
 system/dirtylimit.c                           |    2 +-
 target/arm/ptw.c                              |   18 +-
 target/arm/tcg/gengvec.c                      |   32 +-
 target/arm/tcg/gengvec64.c                    |    4 +-
 target/arm/tcg/translate-sve.c                |   26 +-
 target/hppa/op_helper.c                       |    6 +-
 target/i386/cpu.c                             |   10 -
 target/m68k/op_helper.c                       |    7 +-
 target/s390x/tcg/mem_helper.c                 |    7 -
 tcg/optimize.c                                |  322 --
 tcg/region.c                                  |   12 -
 tcg/tcg-op-gvec.c                             |  113 +-
 tcg/tcg-op-ldst.c                             |  130 +-
 tcg/tcg-op-vec.c                              |   14 +-
 tcg/tcg-op.c                                  |  765 +---
 tcg/tcg.c                                     |  376 +-
 tcg/tci.c                                     |   73 +-
 tests/unit/test-rcu-list.c                    |   17 +-
 util/atomic64.c                               |   85 -
 util/cacheflush.c                             |    4 +-
 util/qsp.c                                    |   12 +-
 util/stats64.c                                |  148 -
 .gitlab-ci.d/buildtest-template.yml           |   27 -
 .gitlab-ci.d/buildtest.yml                    |    9 -
 .gitlab-ci.d/container-cross.yml              |   17 -
 .gitlab-ci.d/containers.yml                   |    3 -
 .gitlab-ci.d/crossbuilds.yml                  |   45 -
 MAINTAINERS                                   |   16 +-
 accel/tcg/atomic_common.c.inc                 |   32 -
 accel/tcg/ldst_atomicity.c.inc                |  149 +-
 common-user/host/arm/safe-syscall.inc.S       |  108 -
 common-user/host/i386/safe-syscall.inc.S      |  127 -
 .../host/{mips => mips64}/safe-syscall.inc.S  |    0
 common-user/host/ppc/safe-syscall.inc.S       |  107 -
 .../{riscv => riscv64}/safe-syscall.inc.S     |    0
 configure                                     |   47 +-
 docs/about/deprecated.rst                     |   29 -
 docs/about/removed-features.rst               |    6 +
 docs/devel/tcg-ops.rst                        |   32 +-
 host/include/i386/host/bufferiszero.c.inc     |  125 -
 host/include/x86_64/host/bufferiszero.c.inc   |  121 +-
 meson.build                                   |  101 +-
 target/i386/tcg/emit.c.inc                    |   39 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |   56 +-
 tcg/arm/tcg-target-opc.h.inc                  |   16 -
 tcg/arm/tcg-target.c.inc                      | 3489 -----------------
 tcg/loongarch64/tcg-target.c.inc              |    4 +-
 tcg/{mips => mips64}/tcg-target-opc.h.inc     |    0
 tcg/{mips => mips64}/tcg-target.c.inc         |    0
 tcg/{ppc => ppc64}/tcg-target-opc.h.inc       |    0
 tcg/{ppc => ppc64}/tcg-target.c.inc           |    2 +-
 tcg/{riscv => riscv64}/tcg-target-opc.h.inc   |    0
 tcg/{riscv => riscv64}/tcg-target.c.inc       |    4 +-
 tcg/tci/tcg-target.c.inc                      |   84 +-
 tcg/{i386 => x86_64}/tcg-target-opc.h.inc     |    0
 tcg/{i386 => x86_64}/tcg-target.c.inc         |  552 +--
 util/meson.build                              |    4 -
 154 files changed, 1158 insertions(+), 8460 deletions(-)
 delete mode 100644 host/include/i386/host/cpuinfo.h
 delete mode 100644 host/include/i386/host/crypto/aes-round.h
 delete mode 100644 host/include/i386/host/crypto/clmul.h
 delete mode 100644 host/include/ppc/host/cpuinfo.h
 delete mode 100644 host/include/ppc/host/crypto/aes-round.h
 rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
 delete mode 100644 include/qemu/stats64.h
 rename tcg/ppc/tcg-target-reg-bits.h => include/tcg/target-reg-bits.h (71%)
 delete mode 100644 linux-user/include/host/arm/host-signal.h
 delete mode 100644 linux-user/include/host/i386/host-signal.h
 rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
 delete mode 100644 linux-user/include/host/ppc/host-signal.h
 rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
 delete mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/arm/tcg-target-con-set.h
 delete mode 100644 tcg/arm/tcg-target-con-str.h
 delete mode 100644 tcg/arm/tcg-target-has.h
 delete mode 100644 tcg/arm/tcg-target-mo.h
 delete mode 100644 tcg/arm/tcg-target-reg-bits.h
 delete mode 100644 tcg/arm/tcg-target.h
 delete mode 100644 tcg/i386/tcg-target-reg-bits.h
 delete mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 delete mode 100644 tcg/mips/tcg-target-reg-bits.h
 rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
 rename tcg/{mips => mips64}/tcg-target-has.h (100%)
 rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
 rename tcg/{mips => mips64}/tcg-target.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
 rename tcg/{ppc => ppc64}/tcg-target.h (100%)
 delete mode 100644 tcg/riscv/tcg-target-reg-bits.h
 rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
 rename tcg/{riscv => riscv64}/tcg-target.h (100%)
 delete mode 100644 tcg/s390x/tcg-target-reg-bits.h
 delete mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 delete mode 100644 tcg/tci/tcg-target-reg-bits.h
 rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target-has.h (92%)
 rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
 rename tcg/{i386 => x86_64}/tcg-target.h (86%)
 delete mode 100644 util/atomic64.c
 delete mode 100644 util/stats64.c
 delete mode 100644 common-user/host/arm/safe-syscall.inc.S
 delete mode 100644 common-user/host/i386/safe-syscall.inc.S
 rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
 delete mode 100644 common-user/host/ppc/safe-syscall.inc.S
 rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
 delete mode 100644 host/include/i386/host/bufferiszero.c.inc
 delete mode 100644 tcg/arm/tcg-target-opc.h.inc
 delete mode 100644 tcg/arm/tcg-target.c.inc
 rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
 rename tcg/{mips => mips64}/tcg-target.c.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
 rename tcg/{ppc => ppc64}/tcg-target.c.inc (99%)
 rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
 rename tcg/{riscv => riscv64}/tcg-target.c.inc (99%)
 rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
 rename tcg/{i386 => x86_64}/tcg-target.c.inc (89%)

-- 
2.43.0



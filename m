Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84658CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmWA-00077h-Rg; Wed, 20 May 2026 15:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmW9-00077U-7x
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:23:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmW6-0001fp-Sc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:23:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so2251969f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305021; x=1779909821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3aKzUQBJ++2IalTesb088AmEVGKGkK8xIJ0h17wPv1s=;
 b=iwpETKeyMT+WzCFoE8ACuFZmzkLunM9ITMJ49zBIxTW1fZe/sc2Sh9fRkqHhcZRBBx
 R7nIxBU+/5Rq3Arshe3GeHb1xMB6pKoZrZChiKTZMca35brT2hcNzS/b3MKZxIrpaohH
 798yAbjaxhgPSLlHeUcm1oSv2fvyIKf7CpKJ8MOmKq8mMxp33iVhz6uwlNujxVseZL1O
 rze8LsrZBnCybes2N8kh3PKtM8RAdz4XNI6eT2/2K7wqwFL8aVdEgZ3VwR53cwmcT7s7
 6DHyHcX55z+V9MDwqacbpQfPb15LMTAKkGzfL8P7KaA3LQv5XBiGzT7ghpWRVsMSzxhM
 i6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305021; x=1779909821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aKzUQBJ++2IalTesb088AmEVGKGkK8xIJ0h17wPv1s=;
 b=oMymFatz9RbjDpDHGUKMYTQY8ndHykwPAbKHQR3e0MucWSCo6ciHb9rSIi2BHPDFIQ
 81uG3klR7oxb9ZPAECyK2ES26CW6jCmMzZk2kQtH9dagnfUxyMmEaTZB7T+VbA/vVbjm
 K3wSt2ZfTLbrCMU+tntrptdsUrJmfM+hzWsF7SZEYA8hwLRuD2ItunrBVctP3JYHuocq
 axGciKeZtpk6YK6hvhl19x3RMysB89DnBx4xEECiFNt+gnxBm+e+fnhGW1p3OzJScK3t
 jh5ViO2TNrbDPLY/1dWrbHufUqEgQMTBDHUHEpYn6a8HmGuJX5pJK/M9Hlhd1IP0ch6Z
 9pEg==
X-Gm-Message-State: AOJu0Yw3hz5KDBoxPN9WFXdzpBQhSHTATE4yAbVDpL71zWJKbgsH4KhL
 M+R+YMf6+Kz1J52VMosaIL6ZXgxe/RowJqcf9w0GZoIXzOtgQCShISM6WtlmuKy6XEMvAvVOP66
 nY/s1lPY=
X-Gm-Gg: Acq92OF5XB2ILfhA7XxAuhFBiyNHEgCxJBIjcB/nzHgJJWqK7qFQs36fFQ6Kzw8n+HE
 eL6RNqd88S7orlqKkejbgbGBANee7R7PRQ5YywXpb2/sy+tPUsYsx43Bf5139FkUW926BPq2nKY
 72PphAzg6oBM588BK896ZP2WRbshKZKoAHC2JGvsXQlV6UT3toN1gXa9Jl004s+eiICD/rq5850
 6h1emcpFglR0GBBLfQgu6lgMPJpmVqFjpurBmDUU4Sk0iNTJ8wXBv7cX50gNhx0x+NkyG5aNEup
 F9+mAEzFEgXYDU2vnwrifOy92z3xKslNGOi8RaGtZnQaSRRHUWRF5OXGu8LUuyVogwDHL3IoLIH
 91nMIRopVKKdwHJ++uWEg8DU2J1Nbm6ZgbnBnAh3RJP9DVWEWEFrtq9KQEHrgc2tfTFe9vTLVFe
 fcSlHRdR3GKp8wee/oSHs6ahcYsOXRGff54aDZXJXYSBCbFhqwYJ2D9MFKQNmg4MtGZs5IW6gJ
X-Received: by 2002:a5d:5648:0:b0:45e:6594:261a with SMTP id
 ffacd0b85a97d-45e659427c8mr25594879f8f.35.1779305020579; 
 Wed, 20 May 2026 12:23:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39806sm55087388f8f.9.2026.05.20.12.23.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:23:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/33] MIPS patches for 2026-05-20
Date: Wed, 20 May 2026 21:23:05 +0200
Message-ID: <20260520192338.40036-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a1b:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-05-19 15:23:10 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20260520

for you to fetch changes up to 2f3eee6bda6190d3acacfeb11fd1b723e08c5a2c:

  target/mips: add Octeon LA* atomic instructions (2026-05-20 21:22:56 +0200)

----------------------------------------------------------------
MIPS patches queue

- Remove support for MIPS host
- Avoid Coverity complaint in gic_write (CID 1547545)
- Add various Octeon integer, multiplier, indexed memory, atomic instructions
----------------------------------------------------------------

James Hilliard (23):
  linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
  linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
  linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
  target/mips: expose Octeon68XX floating-point support
  tests/tcg/mips: add Octeon instruction smoke test
  target/mips: fix Octeon arithmetic destination handling
  target/mips: drop Octeon zero-register fast paths
  target/mips: split Octeon SEQ/SNE decode
  target/mips: split Octeon SEQI/SNEI decode
  target/mips: add Octeon LBX instruction
  target/mips: add Octeon LHUX instruction
  target/mips: add Octeon LWUX instruction
  target/mips: add Octeon SAA instruction
  target/mips: add Octeon SAAD instruction
  target/mips: add Octeon ZCB and ZCBT instructions
  target/mips: add Octeon multiplier state
  target/mips: add Octeon MTM instructions
  target/mips: add Octeon MTP instructions
  target/mips: add Octeon VMULU instruction
  target/mips: add Octeon VMM0 instruction
  target/mips: add Octeon V3MULU instruction
  target/mips: add Octeon QMAC instructions
  target/mips: add Octeon LA* atomic instructions

Peter Maydell (1):
  hw/intc/mips_gic: Avoid Coverity complaint in VP writes

Philippe Mathieu-Daudé (8):
  docker: Remove LegacyKeyValueFormat warnings in non-generated files
  docker: Remove LegacyKeyValueFormat warnings in generated files
  buildsys: Remove MIPS cross containers
  buildsys: Remove support for MIPS hosts
  hw/mips: Include missing 'cpu.h' header
  buildsys: Remove MIPS KVM
  buildsys: Remove MIPS TCG backend
  tcg: Introduce tcg_zero_i128()

Richard Henderson (1):
  tcg: Introduce tcg_gen_addN_i64

 MAINTAINERS                                   |   17 +-
 docs/about/deprecated.rst                     |    8 -
 docs/about/removed-features.rst               |    6 +
 docs/system/target-mips.rst                   |    2 -
 configure                                     |   20 -
 meson.build                                   |   12 +-
 include/qemu/timer.h                          |   30 -
 include/tcg/tcg-op-common.h                   |    3 +
 include/user/thunk.h                          |    2 +-
 linux-user/include/host/mips64/host-signal.h  |   75 -
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 target/mips/cpu.h                             |   16 +
 target/mips/kvm_mips.h                        |   28 -
 target/mips/tcg/translate.h                   |    2 +
 tcg/mips64/tcg-target-con-set.h               |   30 -
 tcg/mips64/tcg-target-con-str.h               |   20 -
 tcg/mips64/tcg-target-has.h                   |   69 -
 tcg/mips64/tcg-target-mo.h                    |   13 -
 tcg/mips64/tcg-target.h                       |   75 -
 tcg/mips64/tcg-target-opc.h.inc               |    1 -
 target/mips/tcg/octeon.decode                 |   54 +-
 hw/intc/mips_gic.c                            |   21 +-
 hw/mips/loongson3_virt.c                      |   67 +-
 hw/mips/malta.c                               |    1 -
 hw/mips/mips_int.c                            |    7 +-
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mmap.c                             |    2 +-
 linux-user/syscall.c                          |   56 +
 target/arm/tcg/translate-a64.c                |    5 +-
 target/mips/cpu.c                             |   15 +-
 target/mips/kvm.c                             | 1283 --------
 target/mips/system/cp0_timer.c                |   12 +-
 target/mips/system/machine.c                  |   33 +
 target/mips/system/physaddr.c                 |    1 -
 target/mips/tcg/octeon_translate.c            |  380 ++-
 target/mips/tcg/translate.c                   |   24 +-
 tcg/tcg-op.c                                  |   52 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  204 ++
 util/cacheflush.c                             |   16 -
 target/mips/cpu-defs.c.inc                    |   10 +-
 tcg/mips64/tcg-target.c.inc                   | 2605 -----------------
 tests/lcitool/refresh                         |   24 +-
 tests/docker/dockerfiles/alpine.docker        |    2 +-
 tests/docker/dockerfiles/centos9.docker       |    2 +-
 .../dockerfiles/debian-all-test-cross.docker  |   10 +-
 .../dockerfiles/debian-amd64-cross.docker     |    2 +-
 .../dockerfiles/debian-arm64-cross.docker     |    2 +-
 .../dockerfiles/debian-armhf-cross.docker     |    2 +-
 .../dockerfiles/debian-hexagon-cross.docker   |   14 +-
 .../dockerfiles/debian-i686-cross.docker      |    2 +-
 .../dockerfiles/debian-loongarch-cross.docker |   10 +-
 .../dockerfiles/debian-mips64el-cross.docker  |  186 --
 .../dockerfiles/debian-mipsel-cross.docker    |  186 --
 .../dockerfiles/debian-ppc64el-cross.docker   |    2 +-
 .../dockerfiles/debian-riscv64-cross.docker   |    2 +-
 .../dockerfiles/debian-s390x-cross.docker     |    2 +-
 .../dockerfiles/debian-tricore-cross.docker   |    6 +-
 .../dockerfiles/debian-xtensa-cross.docker    |    8 +-
 tests/docker/dockerfiles/debian.docker        |    2 +-
 .../dockerfiles/fedora-rust-nightly.docker    |    2 +-
 .../dockerfiles/fedora-win64-cross.docker     |    2 +-
 tests/docker/dockerfiles/fedora.docker        |    2 +-
 tests/docker/dockerfiles/opensuse-leap.docker |    2 +-
 tests/docker/dockerfiles/python.docker        |    5 +-
 .gitlab-ci.d/container-cross.yml              |    6 -
 .gitlab-ci.d/containers.yml                   |    1 -
 .gitlab-ci.d/crossbuilds.yml                  |   22 -
 common-user/host/mips64/safe-syscall.inc.S    |  114 -
 scripts/coverity-scan/coverity-scan.docker    |   12 +-
 scripts/git.orderfile                         |    4 +
 target/mips/meson.build                       |    6 +-
 tests/docker/Makefile.include                 |    1 -
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 75 files changed, 924 insertions(+), 5035 deletions(-)
 delete mode 100644 linux-user/include/host/mips64/host-signal.h
 delete mode 100644 target/mips/kvm_mips.h
 delete mode 100644 tcg/mips64/tcg-target-con-set.h
 delete mode 100644 tcg/mips64/tcg-target-con-str.h
 delete mode 100644 tcg/mips64/tcg-target-has.h
 delete mode 100644 tcg/mips64/tcg-target-mo.h
 delete mode 100644 tcg/mips64/tcg-target.h
 delete mode 100644 tcg/mips64/tcg-target-opc.h.inc
 delete mode 100644 target/mips/kvm.c
 create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
 delete mode 100644 tcg/mips64/tcg-target.c.inc
 delete mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
 delete mode 100644 common-user/host/mips64/safe-syscall.inc.S
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target

-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CB8CD484D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr7I-0007uR-U9; Wed, 04 Sep 2024 10:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7G-0007fi-K7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7D-00056x-QP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so2804255f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460569; x=1726065369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E/S7lY5SBAd8a2iaJpm0mHkbHj8XSpE0/3M4ufpmcbw=;
 b=m2GPB9Aav5WeuAS6UkOEeRaiDR5GZh9oYRvEXFe702KV9pv9L4EswkuJ1dn1lsQuRl
 XE+kVlA5ztfs+KUc35OCNBdvew3C6++Yz3ZzfyOMi9gLt1pd7N7K+ByHO8XBRH4NY5oZ
 99jmhhHVstgboLTamzPYVQ+wKbBs7udK3CfnvVJblxSjyKT9pZ15CAOrMQB9zVBt4asQ
 aRr6lWpchGWOZ2G3hY/uxjL1WKXHtKpggfwpMwVVCQIiNHnTzQeivvSrHjjO0aO/tL8o
 2LzwMSaEp13pOLJM2b8oS2pYUYXa6lXeVJhPyl2Clv4nv/VBsfwbboh2jRxIqhveNMhC
 9QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460569; x=1726065369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/S7lY5SBAd8a2iaJpm0mHkbHj8XSpE0/3M4ufpmcbw=;
 b=mH8glG0AnBInkMga5ElEVNS2bG9SHZPqk3hu2nmhZB8sSUJWzon/IjUfm7eNZSNFR4
 lsO9Rq9NBz/r3LNkuUZ99vYSxuwIxPU80VhwsDKCAvRD4t1VZPQTIi9XXEu6PTlQjEr9
 35mt20GTFUP/Nx3ZXcpEz+bYdCYMMZCDtiHOx5vjmvDsfgwfliaID+GCMdrU53Eap3NT
 6iyf0mFjqAuJCpyEe59ejQvePzYCM4SD/ajLPg/gOfKEvcKcBs0O+UKa5XZ4g8kngLsZ
 ZOL9tudoF2H8pt+x8dcYWyPrIru50nVpOewUB6FvQcZ1bSRyBZPERpS/9LXWqBTlzaJR
 2cZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuH6YhihQC1Ws7xU2hMJXxLBeVEDVjSdpUNkGlfLlVwDBgcz+tLN9J/E4tohHiCVCbU5xLPUfjlJdk@nongnu.org
X-Gm-Message-State: AOJu0YxLLebYv293J69lnSMpEp5FTxuaIh0ehUpAhPndXs7/NnJdIga7
 +Nq2W1kyDJXrSdM/Y8+8vLO/t8tQ89vxwBkw7e8APgDoOCGzOyByKozHqY7D2Ig=
X-Google-Smtp-Source: AGHT+IFwJaGaBgQq9OFSE9Bdtfl4ZI57Ov+Pl6BWr5NLgJWuc6WLcIZeRm60YUrHxcGzc5xGz0CBLQ==
X-Received: by 2002:adf:f0ca:0:b0:374:c847:86d with SMTP id
 ffacd0b85a97d-374c8470b7cmr7024069f8f.16.1725460569147; 
 Wed, 04 Sep 2024 07:36:09 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374ccab8a76sm7739839f8f.99.2024.09.04.07.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:36:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/15] target/cris: Remove the deprecated CRIS target
Date: Wed,  4 Sep 2024 16:35:48 +0200
Message-ID: <20240904143603.52934-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v1:
- Split in smaller patches (pm215)o

The CRIS target is deprecated since v9.0 (commit
c7bbef40234 "docs: mark CRIS support as deprecated").

Remove:
- Buildsys / CI infra
- User emulation
- System emulation (axis-dev88 machine and ETRAX devices)
- Tests

Philippe Mathieu-Daudé (15):
  tests/tcg: Remove CRIS libc test files
  tests/tcg: Remove CRIS bare test files
  buildsys: Remove CRIS cross container
  linux-user: Remove support for CRIS target
  hw/cris: Remove the axis-dev88 machine
  hw/cris: Remove image loader helper
  hw/intc: Remove TYPE_ETRAX_FS_PIC device
  hw/char: Remove TYPE_ETRAX_FS_SERIAL device
  hw/net: Remove TYPE_ETRAX_FS_ETH device
  hw/dma: Remove ETRAX_FS DMA device
  hw/timer: Remove TYPE_ETRAX_FS_TIMER device
  system: Remove support for CRIS target
  target/cris: Remove the deprecated CRIS target
  disas: Remove CRIS disassembler
  seccomp: Remove check for CRIS host

 MAINTAINERS                                   |   17 -
 docs/about/deprecated.rst                     |    8 -
 docs/about/emulation.rst                      |    4 -
 docs/about/removed-features.rst               |    7 +
 docs/user/main.rst                            |    4 -
 configure                                     |    4 -
 configs/devices/cris-softmmu/default.mak      |    4 -
 configs/targets/cris-linux-user.mak           |    1 -
 configs/targets/cris-softmmu.mak              |    1 -
 meson.build                                   |    1 -
 qapi/machine.json                             |    2 +-
 hw/cris/boot.h                                |   16 -
 include/disas/dis-asm.h                       |    6 -
 include/exec/poison.h                         |    2 -
 include/hw/cris/etraxfs.h                     |   54 -
 include/hw/cris/etraxfs_dma.h                 |   36 -
 include/sysemu/arch_init.h                    |    1 -
 include/user/abitypes.h                       |    7 -
 linux-user/cris/sockbits.h                    |    1 -
 linux-user/cris/syscall_nr.h                  |  367 --
 linux-user/cris/target_cpu.h                  |   45 -
 linux-user/cris/target_elf.h                  |   14 -
 linux-user/cris/target_errno_defs.h           |    7 -
 linux-user/cris/target_fcntl.h                |   11 -
 linux-user/cris/target_mman.h                 |   13 -
 linux-user/cris/target_prctl.h                |    1 -
 linux-user/cris/target_proc.h                 |    1 -
 linux-user/cris/target_resource.h             |    1 -
 linux-user/cris/target_signal.h               |    9 -
 linux-user/cris/target_structs.h              |    1 -
 linux-user/cris/target_syscall.h              |   46 -
 linux-user/cris/termbits.h                    |  225 --
 linux-user/syscall_defs.h                     |    7 +-
 target/cris/cpu-param.h                       |   16 -
 target/cris/cpu-qom.h                         |   32 -
 target/cris/cpu.h                             |  286 --
 target/cris/crisv10-decode.h                  |  112 -
 target/cris/crisv32-decode.h                  |  133 -
 target/cris/helper.h                          |   23 -
 target/cris/mmu.h                             |   22 -
 target/cris/opcode-cris.h                     |  355 --
 tests/tcg/cris/libc/crisutils.h               |   76 -
 tests/tcg/cris/libc/sys.h                     |   18 -
 disas/cris.c                                  | 2863 ---------------
 hw/char/etraxfs_ser.c                         |  267 --
 hw/cris/axis_dev88.c                          |  351 --
 hw/cris/boot.c                                |  102 -
 hw/dma/etraxfs_dma.c                          |  781 ----
 hw/intc/etraxfs_pic.c                         |  172 -
 hw/net/etraxfs_eth.c                          |  688 ----
 hw/timer/etraxfs_timer.c                      |  407 ---
 linux-user/cris/cpu_loop.c                    |   95 -
 linux-user/cris/signal.c                      |  194 -
 linux-user/elfload.c                          |   15 -
 linux-user/syscall.c                          |   10 +-
 system/qemu-seccomp.c                         |    2 +-
 target/cris/cpu.c                             |  323 --
 target/cris/gdbstub.c                         |  127 -
 target/cris/helper.c                          |  287 --
 target/cris/machine.c                         |   93 -
 target/cris/mmu.c                             |  356 --
 target/cris/op_helper.c                       |  580 ---
 target/cris/translate.c                       | 3252 -----------------
 tests/qtest/machine-none-test.c               |    1 -
 tests/tcg/cris/bare/sys.c                     |   63 -
 tests/tcg/cris/libc/check_abs.c               |   40 -
 tests/tcg/cris/libc/check_addc.c              |   58 -
 tests/tcg/cris/libc/check_addcm.c             |   85 -
 tests/tcg/cris/libc/check_addo.c              |  125 -
 tests/tcg/cris/libc/check_addoq.c             |   44 -
 tests/tcg/cris/libc/check_bound.c             |  142 -
 tests/tcg/cris/libc/check_ftag.c              |   37 -
 .../cris/libc/check_gcctorture_pr28634-1.c    |   15 -
 .../tcg/cris/libc/check_gcctorture_pr28634.c  |   15 -
 .../tcg/cris/libc/check_glibc_kernelversion.c |  116 -
 tests/tcg/cris/libc/check_hello.c             |    7 -
 tests/tcg/cris/libc/check_int64.c             |   47 -
 tests/tcg/cris/libc/check_lz.c                |   49 -
 tests/tcg/cris/libc/check_mapbrk.c            |   39 -
 tests/tcg/cris/libc/check_mmap1.c             |   48 -
 tests/tcg/cris/libc/check_mmap2.c             |   48 -
 tests/tcg/cris/libc/check_mmap3.c             |   33 -
 tests/tcg/cris/libc/check_moveq.c             |   51 -
 tests/tcg/cris/libc/check_openpf1.c           |   38 -
 tests/tcg/cris/libc/check_openpf2.c           |   16 -
 tests/tcg/cris/libc/check_openpf3.c           |   49 -
 tests/tcg/cris/libc/check_openpf5.c           |   56 -
 tests/tcg/cris/libc/check_settls1.c           |   45 -
 tests/tcg/cris/libc/check_sigalrm.c           |   26 -
 tests/tcg/cris/libc/check_stat1.c             |   16 -
 tests/tcg/cris/libc/check_stat2.c             |   20 -
 tests/tcg/cris/libc/check_stat3.c             |   25 -
 tests/tcg/cris/libc/check_stat4.c             |   27 -
 tests/tcg/cris/libc/check_swap.c              |   76 -
 tests/tcg/cris/libc/check_time2.c             |   18 -
 fpu/softfloat-specialize.c.inc                |    4 +-
 target/cris/translate_v10.c.inc               | 1262 -------
 .gitlab-ci.d/buildtest.yml                    |    2 +-
 .gitlab-ci.d/container-cross.yml              |    5 -
 .gitlab-ci.d/crossbuild-template.yml          |    4 +-
 disas/meson.build                             |    1 -
 hw/Kconfig                                    |    1 -
 hw/char/meson.build                           |    1 -
 hw/cris/Kconfig                               |   11 -
 hw/cris/meson.build                           |    5 -
 hw/dma/meson.build                            |    1 -
 hw/intc/meson.build                           |    1 -
 hw/meson.build                                |    1 -
 hw/net/meson.build                            |    1 -
 hw/net/trace-events                           |    5 -
 hw/timer/meson.build                          |    1 -
 scripts/coverity-scan/COMPONENTS.md           |    3 -
 scripts/probe-gdb-support.py                  |    1 -
 target/Kconfig                                |    1 -
 target/cris/Kconfig                           |    2 -
 target/cris/meson.build                       |   17 -
 target/meson.build                            |    1 -
 tests/data/qobject/qdict.txt                  |    6 -
 tests/docker/Makefile.include                 |    1 -
 .../dockerfiles/fedora-cris-cross.docker      |   14 -
 tests/tcg/cris/.gdbinit                       |   11 -
 tests/tcg/cris/Makefile.target                |   62 -
 tests/tcg/cris/README                         |    1 -
 tests/tcg/cris/bare/check_addcv17.s           |   65 -
 tests/tcg/cris/bare/check_addi.s              |   57 -
 tests/tcg/cris/bare/check_addiv32.s           |   62 -
 tests/tcg/cris/bare/check_addm.s              |   96 -
 tests/tcg/cris/bare/check_addq.s              |   47 -
 tests/tcg/cris/bare/check_addr.s              |   96 -
 tests/tcg/cris/bare/check_addxc.s             |   91 -
 tests/tcg/cris/bare/check_addxm.s             |  106 -
 tests/tcg/cris/bare/check_addxr.s             |   96 -
 tests/tcg/cris/bare/check_andc.s              |   80 -
 tests/tcg/cris/bare/check_andm.s              |   90 -
 tests/tcg/cris/bare/check_andq.s              |   46 -
 tests/tcg/cris/bare/check_andr.s              |   95 -
 tests/tcg/cris/bare/check_asr.s               |  230 --
 tests/tcg/cris/bare/check_ba.s                |   93 -
 tests/tcg/cris/bare/check_bas.s               |  102 -
 tests/tcg/cris/bare/check_bcc.s               |  197 -
 tests/tcg/cris/bare/check_boundc.s            |  101 -
 tests/tcg/cris/bare/check_boundr.s            |  125 -
 tests/tcg/cris/bare/check_btst.s              |   96 -
 tests/tcg/cris/bare/check_clearfv32.s         |   19 -
 tests/tcg/cris/bare/check_clrjmp1.s           |   36 -
 tests/tcg/cris/bare/check_cmp-2.s             |   15 -
 tests/tcg/cris/bare/check_cmpc.s              |   86 -
 tests/tcg/cris/bare/check_cmpm.s              |   96 -
 tests/tcg/cris/bare/check_cmpq.s              |   75 -
 tests/tcg/cris/bare/check_cmpr.s              |  102 -
 tests/tcg/cris/bare/check_cmpxc.s             |   92 -
 tests/tcg/cris/bare/check_cmpxm.s             |  106 -
 tests/tcg/cris/bare/check_dstep.s             |   42 -
 tests/tcg/cris/bare/check_jsr.s               |   85 -
 tests/tcg/cris/bare/check_lapc.s              |   78 -
 tests/tcg/cris/bare/check_lsl.s               |  217 --
 tests/tcg/cris/bare/check_lsr.s               |  218 --
 tests/tcg/cris/bare/check_mcp.s               |   49 -
 tests/tcg/cris/bare/check_movdelsr1.s         |   33 -
 tests/tcg/cris/bare/check_movecr.s            |   37 -
 tests/tcg/cris/bare/check_movei.s             |   50 -
 tests/tcg/cris/bare/check_movemr.s            |   78 -
 tests/tcg/cris/bare/check_movemrv32.s         |   96 -
 tests/tcg/cris/bare/check_mover.s             |   28 -
 tests/tcg/cris/bare/check_moverm.s            |   45 -
 tests/tcg/cris/bare/check_movmp.s             |  131 -
 tests/tcg/cris/bare/check_movpmv32.s          |   35 -
 tests/tcg/cris/bare/check_movpr.s             |   28 -
 tests/tcg/cris/bare/check_movprv32.s          |   21 -
 tests/tcg/cris/bare/check_movscr.s            |   29 -
 tests/tcg/cris/bare/check_movsm.s             |   44 -
 tests/tcg/cris/bare/check_movsr.s             |   46 -
 tests/tcg/cris/bare/check_movucr.s            |   33 -
 tests/tcg/cris/bare/check_movum.s             |   40 -
 tests/tcg/cris/bare/check_movur.s             |   45 -
 tests/tcg/cris/bare/check_mulv32.s            |   51 -
 tests/tcg/cris/bare/check_mulx.s              |  257 --
 tests/tcg/cris/bare/check_neg.s               |  104 -
 tests/tcg/cris/bare/check_not.s               |   31 -
 tests/tcg/cris/bare/check_orc.s               |   71 -
 tests/tcg/cris/bare/check_orm.s               |   75 -
 tests/tcg/cris/bare/check_orq.s               |   41 -
 tests/tcg/cris/bare/check_orr.s               |   84 -
 tests/tcg/cris/bare/check_ret.s               |   25 -
 tests/tcg/cris/bare/check_scc.s               |   95 -
 tests/tcg/cris/bare/check_subc.s              |   87 -
 tests/tcg/cris/bare/check_subm.s              |   96 -
 tests/tcg/cris/bare/check_subq.s              |   52 -
 tests/tcg/cris/bare/check_subr.s              |  102 -
 tests/tcg/cris/bare/check_xarith.s            |   72 -
 tests/tcg/cris/bare/crt.s                     |   13 -
 tests/tcg/cris/bare/testutils.inc             |  117 -
 192 files changed, 18 insertions(+), 21324 deletions(-)
 delete mode 100644 configs/devices/cris-softmmu/default.mak
 delete mode 100644 configs/targets/cris-linux-user.mak
 delete mode 100644 configs/targets/cris-softmmu.mak
 delete mode 100644 hw/cris/boot.h
 delete mode 100644 include/hw/cris/etraxfs.h
 delete mode 100644 include/hw/cris/etraxfs_dma.h
 delete mode 100644 linux-user/cris/sockbits.h
 delete mode 100644 linux-user/cris/syscall_nr.h
 delete mode 100644 linux-user/cris/target_cpu.h
 delete mode 100644 linux-user/cris/target_elf.h
 delete mode 100644 linux-user/cris/target_errno_defs.h
 delete mode 100644 linux-user/cris/target_fcntl.h
 delete mode 100644 linux-user/cris/target_mman.h
 delete mode 100644 linux-user/cris/target_prctl.h
 delete mode 100644 linux-user/cris/target_proc.h
 delete mode 100644 linux-user/cris/target_resource.h
 delete mode 100644 linux-user/cris/target_signal.h
 delete mode 100644 linux-user/cris/target_structs.h
 delete mode 100644 linux-user/cris/target_syscall.h
 delete mode 100644 linux-user/cris/termbits.h
 delete mode 100644 target/cris/cpu-param.h
 delete mode 100644 target/cris/cpu-qom.h
 delete mode 100644 target/cris/cpu.h
 delete mode 100644 target/cris/crisv10-decode.h
 delete mode 100644 target/cris/crisv32-decode.h
 delete mode 100644 target/cris/helper.h
 delete mode 100644 target/cris/mmu.h
 delete mode 100644 target/cris/opcode-cris.h
 delete mode 100644 tests/tcg/cris/libc/crisutils.h
 delete mode 100644 tests/tcg/cris/libc/sys.h
 delete mode 100644 disas/cris.c
 delete mode 100644 hw/char/etraxfs_ser.c
 delete mode 100644 hw/cris/axis_dev88.c
 delete mode 100644 hw/cris/boot.c
 delete mode 100644 hw/dma/etraxfs_dma.c
 delete mode 100644 hw/intc/etraxfs_pic.c
 delete mode 100644 hw/net/etraxfs_eth.c
 delete mode 100644 hw/timer/etraxfs_timer.c
 delete mode 100644 linux-user/cris/cpu_loop.c
 delete mode 100644 linux-user/cris/signal.c
 delete mode 100644 target/cris/cpu.c
 delete mode 100644 target/cris/gdbstub.c
 delete mode 100644 target/cris/helper.c
 delete mode 100644 target/cris/machine.c
 delete mode 100644 target/cris/mmu.c
 delete mode 100644 target/cris/op_helper.c
 delete mode 100644 target/cris/translate.c
 delete mode 100644 tests/tcg/cris/bare/sys.c
 delete mode 100644 tests/tcg/cris/libc/check_abs.c
 delete mode 100644 tests/tcg/cris/libc/check_addc.c
 delete mode 100644 tests/tcg/cris/libc/check_addcm.c
 delete mode 100644 tests/tcg/cris/libc/check_addo.c
 delete mode 100644 tests/tcg/cris/libc/check_addoq.c
 delete mode 100644 tests/tcg/cris/libc/check_bound.c
 delete mode 100644 tests/tcg/cris/libc/check_ftag.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634.c
 delete mode 100644 tests/tcg/cris/libc/check_glibc_kernelversion.c
 delete mode 100644 tests/tcg/cris/libc/check_hello.c
 delete mode 100644 tests/tcg/cris/libc/check_int64.c
 delete mode 100644 tests/tcg/cris/libc/check_lz.c
 delete mode 100644 tests/tcg/cris/libc/check_mapbrk.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap1.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap2.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap3.c
 delete mode 100644 tests/tcg/cris/libc/check_moveq.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf1.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf2.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf3.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf5.c
 delete mode 100644 tests/tcg/cris/libc/check_settls1.c
 delete mode 100644 tests/tcg/cris/libc/check_sigalrm.c
 delete mode 100644 tests/tcg/cris/libc/check_stat1.c
 delete mode 100644 tests/tcg/cris/libc/check_stat2.c
 delete mode 100644 tests/tcg/cris/libc/check_stat3.c
 delete mode 100644 tests/tcg/cris/libc/check_stat4.c
 delete mode 100644 tests/tcg/cris/libc/check_swap.c
 delete mode 100644 tests/tcg/cris/libc/check_time2.c
 delete mode 100644 target/cris/translate_v10.c.inc
 delete mode 100644 hw/cris/Kconfig
 delete mode 100644 hw/cris/meson.build
 delete mode 100644 target/cris/Kconfig
 delete mode 100644 target/cris/meson.build
 delete mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker
 delete mode 100644 tests/tcg/cris/.gdbinit
 delete mode 100644 tests/tcg/cris/Makefile.target
 delete mode 100644 tests/tcg/cris/README
 delete mode 100644 tests/tcg/cris/bare/check_addcv17.s
 delete mode 100644 tests/tcg/cris/bare/check_addi.s
 delete mode 100644 tests/tcg/cris/bare/check_addiv32.s
 delete mode 100644 tests/tcg/cris/bare/check_addm.s
 delete mode 100644 tests/tcg/cris/bare/check_addq.s
 delete mode 100644 tests/tcg/cris/bare/check_addr.s
 delete mode 100644 tests/tcg/cris/bare/check_addxc.s
 delete mode 100644 tests/tcg/cris/bare/check_addxm.s
 delete mode 100644 tests/tcg/cris/bare/check_addxr.s
 delete mode 100644 tests/tcg/cris/bare/check_andc.s
 delete mode 100644 tests/tcg/cris/bare/check_andm.s
 delete mode 100644 tests/tcg/cris/bare/check_andq.s
 delete mode 100644 tests/tcg/cris/bare/check_andr.s
 delete mode 100644 tests/tcg/cris/bare/check_asr.s
 delete mode 100644 tests/tcg/cris/bare/check_ba.s
 delete mode 100644 tests/tcg/cris/bare/check_bas.s
 delete mode 100644 tests/tcg/cris/bare/check_bcc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundr.s
 delete mode 100644 tests/tcg/cris/bare/check_btst.s
 delete mode 100644 tests/tcg/cris/bare/check_clearfv32.s
 delete mode 100644 tests/tcg/cris/bare/check_clrjmp1.s
 delete mode 100644 tests/tcg/cris/bare/check_cmp-2.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpm.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpq.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpr.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxm.s
 delete mode 100644 tests/tcg/cris/bare/check_dstep.s
 delete mode 100644 tests/tcg/cris/bare/check_jsr.s
 delete mode 100644 tests/tcg/cris/bare/check_lapc.s
 delete mode 100644 tests/tcg/cris/bare/check_lsl.s
 delete mode 100644 tests/tcg/cris/bare/check_lsr.s
 delete mode 100644 tests/tcg/cris/bare/check_mcp.s
 delete mode 100644 tests/tcg/cris/bare/check_movdelsr1.s
 delete mode 100644 tests/tcg/cris/bare/check_movecr.s
 delete mode 100644 tests/tcg/cris/bare/check_movei.s
 delete mode 100644 tests/tcg/cris/bare/check_movemr.s
 delete mode 100644 tests/tcg/cris/bare/check_movemrv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mover.s
 delete mode 100644 tests/tcg/cris/bare/check_moverm.s
 delete mode 100644 tests/tcg/cris/bare/check_movmp.s
 delete mode 100644 tests/tcg/cris/bare/check_movpmv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movpr.s
 delete mode 100644 tests/tcg/cris/bare/check_movprv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movscr.s
 delete mode 100644 tests/tcg/cris/bare/check_movsm.s
 delete mode 100644 tests/tcg/cris/bare/check_movsr.s
 delete mode 100644 tests/tcg/cris/bare/check_movucr.s
 delete mode 100644 tests/tcg/cris/bare/check_movum.s
 delete mode 100644 tests/tcg/cris/bare/check_movur.s
 delete mode 100644 tests/tcg/cris/bare/check_mulv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mulx.s
 delete mode 100644 tests/tcg/cris/bare/check_neg.s
 delete mode 100644 tests/tcg/cris/bare/check_not.s
 delete mode 100644 tests/tcg/cris/bare/check_orc.s
 delete mode 100644 tests/tcg/cris/bare/check_orm.s
 delete mode 100644 tests/tcg/cris/bare/check_orq.s
 delete mode 100644 tests/tcg/cris/bare/check_orr.s
 delete mode 100644 tests/tcg/cris/bare/check_ret.s
 delete mode 100644 tests/tcg/cris/bare/check_scc.s
 delete mode 100644 tests/tcg/cris/bare/check_subc.s
 delete mode 100644 tests/tcg/cris/bare/check_subm.s
 delete mode 100644 tests/tcg/cris/bare/check_subq.s
 delete mode 100644 tests/tcg/cris/bare/check_subr.s
 delete mode 100644 tests/tcg/cris/bare/check_xarith.s
 delete mode 100644 tests/tcg/cris/bare/crt.s
 delete mode 100644 tests/tcg/cris/bare/testutils.inc

-- 
2.45.2



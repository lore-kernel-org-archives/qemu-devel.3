Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A74CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPT-000632-L3; Wed, 06 May 2026 22:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPR-00062Z-RA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:17 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPP-0007aO-C0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:17 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dea20cf21aso352229a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120653; x=1778725453;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7F3BOhUWnj/0BE/eogouAdJfE7DJesDgdVpNbGkpLSE=;
 b=FkI332r7ppkPn157oD3VexcUrTEeSKCN4e9x7T9PXtoqcx7b1Tcc6hQ/byB4LVpRO0
 wPMvGATDnC+09oCbGnieVJGzFGdB2fRndxMm1IKtte5G10Z7VF3DjbB+Ey4D5wJ6dKRR
 fcneM4wa3WOORSaO9ciNnmkmVfzns13/byPjLek4p6lb+sIss18//QuCuTf9mfdtqQf6
 pn6e2ucg+c7GHXdygYn0u0mNDZf3aVoW4kTTLPBF6LR+Qy/vqQvnA9CVB8grP5S8DjAp
 QESOa6Ntm4jDdlpPHEvauTytq7jMWK8sGmntaQVAAbhF057tq1SicT90mP8whotDC3aI
 JsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120653; x=1778725453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7F3BOhUWnj/0BE/eogouAdJfE7DJesDgdVpNbGkpLSE=;
 b=rLMxUnbyfwvFENGygBrFehky63sY73J0iYzceGwIMWmg234VDYhlZcPZyF/3cn7Ys3
 x3VxL6a78M6M0Cv/zLoafQH09VMtRxzgduXShBUpoLi2b1AkqTXNRK9m4GrbfsUr5VKc
 MmfsVgZNnzbhP/G8pUi07zD0ODJSpqUNXNzXyc35f3bjrmu/iKblZGPmSvbOWkk+61MH
 6tnmrqg25sJGE1VPKXjj2DRjFx4/BihEx2DCh//McN+aQ6cYsfoaGnACzdq1KfvFRKm3
 yGE1ssWpCdK38XUbMb21IRfQrAizn3LrhMtJzVKMpq59zEY+XFxTkO/Tb5fOJ1oEwWN8
 oA3g==
X-Gm-Message-State: AOJu0YzLHrrz1gYLb0I66xy8gO9/dbjmcrqjmN9fSZijpa51xQTpdI3L
 cAHVCVzGOUiSPFPpk6uoo0gnIRmFMbvDeGuLvSguodZOX1+0adUQ8pJsAyoXrA1gipcq9lGV+DK
 lfnC24W0=
X-Gm-Gg: AeBDievJjA8GNb04c0iN/KKAUWOgzW8DJMsFJjaceArAvOVgM6oSYji1LihXNVxTgVo
 A5P/JTzoxStEIW9yrSwOQPc74aCKclvwTazCVe2CtdN3jMyeLYF/fRp2Agzd3CT0tnxL+tm7bv2
 7IqSWS3MCfjZ7T2wqIps1aH6CfYBAYFXKbCqW/5TUEYwMBvxLO3PLPssOroF23YgmP14xL/k9kj
 0ZpYky8JRzxxrz5ni3Zxwhi2+dTDbuK8GotWm7l2PIzeiMnmHSfS1HQ9Me05YWhF0XOakct6/B8
 bjnXEOCx01tdC5sz+7h7Yia/D6zODQkyvQepZCi8XQDD/8qxKD4bcLZiDM+69/qfZRTGEu9ROqh
 iyNZZXznLJN7784APhp1LYwsZqPQEekyslIG+TtgA/EcrdChsbUt9R0waeRs/1jG9GEtzIVsRz1
 NYNOLblUmFKbsMClQ7qbF7
X-Received: by 2002:a05:6820:2017:b0:696:1f5a:9bf0 with SMTP id
 006d021491bc7-69998cca75amr3265099eaf.15.1778120652936; 
 Wed, 06 May 2026 19:24:12 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:11 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 00/25] bsd-user May 2026 pull request
Date: Wed,  6 May 2026 20:21:54 -0600
Message-ID: <20260507022219.44171-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Three patch series were reviewed during the code freeze and are finally ready to
head into the tree.

(1) Use SPDX identifiers in most places. This makes it easier for me to upstream
since I can do almost all of the files in the forked tree and not have it be an
issue each time I add a new file.

(2) Per discussions in the review, copy thunk.c to bsd-user from linux-user. We
will use this in the third set of patches, ioctls. All that changed is the
copyright header. This file has style problems, but fixing them would be a worse
problem than the style issues since we share it with linux-user and want to
track changes there. In the future we may actually share, but for now this was
the compromise.

(3) All the ioctls that bsd-user supports in FreeBSD. This uses the thunk.c code
to translate back and forth between host and target. A number of pedantic
changes were made against the blitz branch upstream and were discovered or
highlighted by claude code.

I used claude to extract all the ioctl code from the blitz branch for
upstreaming. I had it review the code and fixed the problems it found (though
one was a false positive). I've not tagged these as Assisted-by: since that part
of our policy is in flux. No creative output of claude was applied here, though
it also suggested the commit messages (that I rewrote in large part, but
vestiges of the original remain). To be clear: Claude didn't write any of
the actual code.

Stacey Son (19):
  bsd-user: ioctl: add common definitions
  bsd-user: Add FreeBSD tty ioctl definitions
  bsd-user: Add FreeBSD file I/O ioctl definitions
  bsd-user: Add FreeBSD socket ioctl definitions
  bsd-user: Add FreeBSD cryptodev ioctl definitions
  bsd-user: Add FreeBSD disk ioctl definitions
  bsd-user: Add FreeBSD IPv6 ioctl definitions
  bsd-user: Add FreeBSD ioctl type definitions
  bsd-user: Add FreeBSD ioctl command table
  bsd-user: Add bsd-ioctl.h header
  bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
  bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
  bsd-user: Add log_unsupported_ioctl function
  bsd-user: Add do_ioctl_unsupported function
  bsd-user: Add target_to_host_sockaddr_in6 function
  bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
  bsd-user: Add do_bsd_ioctl main function
  bsd-user: Add init_bsd_ioctl function
  bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build

Warner Losh (6):
  bsd-user: Switch to SPDX-License-Expression
  bsd-user: Add syscall header generator for FreeBSD
  bsd-user: Delete sbrk and sstk system calls.
  bsd-user: Create os-syscall.h
  bsd-user: Switch to generated syscall_nr.h
  bsd-user: Copy linux-user/thunk.c to bsd-user

 bsd-user/aarch64/signal.c               |  15 +-
 bsd-user/aarch64/target_arch.h          |  16 +-
 bsd-user/aarch64/target_arch_cpu.c      |  15 +-
 bsd-user/aarch64/target_arch_cpu.h      |  18 +-
 bsd-user/aarch64/target_arch_elf.h      |  14 +-
 bsd-user/aarch64/target_arch_reg.h      |  19 +-
 bsd-user/aarch64/target_arch_signal.h   |  16 +-
 bsd-user/aarch64/target_arch_sigtramp.h |  16 +-
 bsd-user/aarch64/target_arch_sysarch.h  |  16 +-
 bsd-user/aarch64/target_arch_thread.h   |  16 +-
 bsd-user/aarch64/target_arch_vmparam.h  |  16 +-
 bsd-user/aarch64/target_syscall.h       |  16 +-
 bsd-user/arm/signal.c                   |  18 +-
 bsd-user/arm/target_arch.h              |  16 +-
 bsd-user/arm/target_arch_cpu.c          |  18 +-
 bsd-user/arm/target_arch_cpu.h          |  18 +-
 bsd-user/arm/target_arch_elf.h          |  18 +-
 bsd-user/arm/target_arch_reg.h          |  18 +-
 bsd-user/arm/target_arch_signal.h       |  18 +-
 bsd-user/arm/target_arch_sigtramp.h     |  18 +-
 bsd-user/arm/target_arch_sysarch.h      |  18 +-
 bsd-user/arm/target_arch_thread.h       |  18 +-
 bsd-user/arm/target_arch_vmparam.h      |  18 +-
 bsd-user/arm/target_syscall.h           |  18 +-
 bsd-user/bsd-file.h                     |  18 +-
 bsd-user/bsd-ioctl.c                    | 436 ++++++++++++++++++++
 bsd-user/bsd-ioctl.h                    |  14 +
 bsd-user/bsd-mem.c                      |  17 +-
 bsd-user/bsd-mem.h                      |  30 +-
 bsd-user/bsd-proc.c                     |  17 +-
 bsd-user/bsd-proc.h                     |  17 +-
 bsd-user/freebsd/meson.build            |  10 +-
 bsd-user/freebsd/os-ioctl-cmds.h        | 149 +++++++
 bsd-user/freebsd/os-ioctl-cryptodev.h   |  84 ++++
 bsd-user/freebsd/os-ioctl-disk.h        |  52 +++
 bsd-user/freebsd/os-ioctl-filio.h       |  34 ++
 bsd-user/freebsd/os-ioctl-in6_var.h     | 226 +++++++++++
 bsd-user/freebsd/os-ioctl-ioccom.h      |  43 ++
 bsd-user/freebsd/os-ioctl-sockio.h      | 246 +++++++++++
 bsd-user/freebsd/os-ioctl-ttycom.h      | 239 +++++++++++
 bsd-user/freebsd/os-ioctl-types.h       | 109 +++++
 bsd-user/freebsd/os-misc.h              |  18 +-
 bsd-user/freebsd/os-proc.c              |  17 +-
 bsd-user/freebsd/os-proc.h              |  18 +-
 bsd-user/freebsd/os-stat.c              |  17 +-
 bsd-user/freebsd/os-stat.h              |  18 +-
 bsd-user/freebsd/os-strace.h            |  19 +-
 bsd-user/freebsd/os-syscall.c           |  17 +-
 bsd-user/freebsd/os-syscall.h           |  21 +
 bsd-user/freebsd/scripts/syscallhdr.sh  |   9 +
 bsd-user/freebsd/strace.list            |   4 +
 bsd-user/freebsd/syscall_nr.h           | 515 ------------------------
 bsd-user/freebsd/target_os_elf.h        |  18 +-
 bsd-user/freebsd/target_os_siginfo.h    |  18 +-
 bsd-user/freebsd/target_os_signal.h     |   7 +
 bsd-user/freebsd/target_os_stack.h      |  18 +-
 bsd-user/freebsd/target_os_thread.h     |  18 +-
 bsd-user/freebsd/target_os_user.h       |  18 +-
 bsd-user/freebsd/target_os_vmparam.h    |  18 +-
 bsd-user/i386/signal.c                  |  17 +-
 bsd-user/i386/target_arch.h             |  16 +-
 bsd-user/i386/target_arch_cpu.c         |  17 +-
 bsd-user/i386/target_arch_cpu.h         |  17 +-
 bsd-user/i386/target_arch_elf.h         |  18 +-
 bsd-user/i386/target_arch_reg.h         |  19 +-
 bsd-user/i386/target_arch_signal.h      |  16 +-
 bsd-user/i386/target_arch_sigtramp.h    |  16 +-
 bsd-user/i386/target_arch_sysarch.h     |  18 +-
 bsd-user/i386/target_arch_thread.h      |  18 +-
 bsd-user/i386/target_arch_vmparam.h     |  18 +-
 bsd-user/i386/target_syscall.h          |  16 +-
 bsd-user/meson.build                    |   2 +
 bsd-user/qemu-bsd.h                     |  18 +-
 bsd-user/syscall_defs.h                 |  50 +--
 bsd-user/thunk.c                        | 470 +++++++++++++++++++++
 bsd-user/x86_64/signal.c                |  16 +-
 bsd-user/x86_64/target_arch.h           |  16 +-
 bsd-user/x86_64/target_arch_cpu.c       |  17 +-
 bsd-user/x86_64/target_arch_cpu.h       |  17 +-
 bsd-user/x86_64/target_arch_elf.h       |  18 +-
 bsd-user/x86_64/target_arch_reg.h       |  19 +-
 bsd-user/x86_64/target_arch_signal.h    |  17 +-
 bsd-user/x86_64/target_arch_sigtramp.h  |  17 +-
 bsd-user/x86_64/target_arch_sysarch.h   |  17 +-
 bsd-user/x86_64/target_arch_thread.h    |  18 +-
 bsd-user/x86_64/target_arch_vmparam.h   |  18 +-
 bsd-user/x86_64/target_syscall.h        |  16 +-
 87 files changed, 2362 insertions(+), 1526 deletions(-)
 create mode 100644 bsd-user/bsd-ioctl.c
 create mode 100644 bsd-user/bsd-ioctl.h
 create mode 100644 bsd-user/freebsd/os-ioctl-cmds.h
 create mode 100644 bsd-user/freebsd/os-ioctl-cryptodev.h
 create mode 100644 bsd-user/freebsd/os-ioctl-disk.h
 create mode 100644 bsd-user/freebsd/os-ioctl-filio.h
 create mode 100644 bsd-user/freebsd/os-ioctl-in6_var.h
 create mode 100644 bsd-user/freebsd/os-ioctl-ioccom.h
 create mode 100644 bsd-user/freebsd/os-ioctl-sockio.h
 create mode 100644 bsd-user/freebsd/os-ioctl-ttycom.h
 create mode 100644 bsd-user/freebsd/os-ioctl-types.h
 create mode 100644 bsd-user/freebsd/os-syscall.h
 create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh
 delete mode 100644 bsd-user/freebsd/syscall_nr.h
 create mode 100644 bsd-user/thunk.c

-- 
2.52.0



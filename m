Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60F8D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumo-0000w3-T9; Sun, 01 Mar 2026 23:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumn-0000vf-Km
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:37 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwuml-0006n4-0U
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:37 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c4cacf78so1921952a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425292; x=1773030092;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ko20EekI/m+RoITROeczWokDWmxx93iSU5zZS6F6Of4=;
 b=TLSdK/o2swN7OWAp0jm5fe0AZ/eQrFpk0+dwU9jBF3WKJCG/fy2dnLCg5MW7mdLnnF
 7Ty1Ws8LHRbD9Br7mfvC/wKIjA8843ZR0oJEWDZTOEKl4nGqG/11x0LeBB+z3xP7Axki
 KGK4oGNtvbe6ZNItZLl/vtX9sm1kKnMGf9p+aXCj+BEj+jW8bCJQQSXcRmmw1jRlwaqC
 3RGOi1PoOGz1EP7wbEIl9T6WdBrZ79/kndbIBHTqTqqiCdWhyASbiDsxoQeo6Dlqb93i
 9ZhlQ+3LKLE43oqO5uOY9USKZH3sp0qoDMm2dvEF9GwBejOjLuEkaJ5nEB2BDua8E+Ek
 EVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425292; x=1773030092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko20EekI/m+RoITROeczWokDWmxx93iSU5zZS6F6Of4=;
 b=giymckxXg97OmD/iNzuT+XSDn2erb1SqGM1WaC/6f9HkDtLJnHRwyPsADsKszmO7IT
 D1THcsvsdq22nmUrE8mzJqjkxymiGNMRHtoltz9qCoxRtlPgxbKGBki2eIiyMtKJiao2
 JxDanIVSS2kQDrAbBumIA3n6sO5i/lhX7uwfhwpPoaQLw49p5jOS6DiRLOCTyHeTJalB
 wagyS9BMG0zywK/Hm1sNPwxgBPVa+JyXyM9cYMCzQr2mIXVjZoF8vsLZKfx7WOjGWjpY
 05B7YtV2ujLBaAL1rVMFJ/o/y+sjowkWT25PN8ACItxlch0QLfHW6IAriOsE6eij08qq
 /85w==
X-Gm-Message-State: AOJu0Yx4PsEjin7CiW6vZBTq+rtfpnUXo6uEcJgbxJaqgBeZB53LGs5l
 rGuGgnrCtcovArw5iPf/uFuJuypTSaUrLXM0Q2r0zeje+GFOUCBR3I5je2+x+PtmkhonOPWz+vF
 Nlnfc
X-Gm-Gg: ATEYQzxGC1J2gtN0e34ukEI/6D+n7G4sx8PfQZQFkk4/TJC51NftwOSpM86z5DdxqBb
 pN5HWYAnqpeVCKT7BWeXJV6gjghjKdrtBcCGkqXYvovqqge3sl7Df+H76hX7QfFhoCVIOHGG52+
 i3ZqlhfC/8U43osREZsGP9jLm2irpR9Ms7bUJRRsxV7lOEOm5/cL6qrWAbGgGv5SOhkB50rQ9pr
 u0qFReDcUMMV0ur7FhzLGXj8hEaEg99OYmitLW4q5t2aFHHdmABb3ZLwAUIW4eTeHRgUmr33Lqg
 QtYG580bZPnkiH80sT6/Qm1Rjmbz6YnpfhDQKKbJV8yueq1QHRY3a97P/lKLzmqnqdqmcLO7Xj8
 Z5wn8EXy4U2t6MVHN7KVwVdOqAYNMNl6HKlOKybX5lzAvc3MWjCjg9uchtLe/RuFGJHyT0brHL7
 TFS/VIxgPEbQ==
X-Received: by 2002:a05:6870:e2c9:b0:404:383f:56bb with SMTP id
 586e51a60fabf-4162704249bmr6113268fac.35.1772425292563; 
 Sun, 01 Mar 2026 20:21:32 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:32 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PULL 00/27] Bsd user 2026q1 upstream patches
Date: Sun,  1 Mar 2026 21:20:48 -0700
Message-ID: <20260302042115.83410-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:

  Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)

are available in the Git repository at:

  ssh://git@github.com/bsdimp/qemu.git tags/bsd-user-2026q1-upstream-pull-request

for you to fetch changes up to f0f6eae80fbdfb6943fc5d701118e78f2346818f:

  bsd-user: update aarch64-bsd-user.mak gdb XML list (2026-03-01 20:50:11 -0700)

----------------------------------------------------------------
git-publish --base upstream/master --pull --to qemu-devel@nongnu.org --no-check-url

bsd-user: Upstream for 11.0

This combines several batch streams that:
(1) Upstream the bsd-misc.c system calls:
    quoatctl, reboot, getdtablesize, uuidgen, semget, semop, semctl, msgctl
(2) common-user drop __linux__ ifdef
(3) Remove NetBSD and OpenBSD specific code for bsd-user (hasn't built in years)
(4) Fix inotify issues on FreeBSD 15
(5) Fix issues with gdb on aarch64

All of thse have been reviewed, and the only problems with the check patch line
length and about added files.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmmlD6EACgkQbBzRKH2w
EQANZw//edwiQF/H+07EBKdZNF/QJsBwsH5OwHh/rgyq6OPUHWtu00gxNDFd/e/D
O+FisLvDbNa9v2es1RX0lDzdgXRwi2LRIc4tMW3ifEjK7Jj8np09tfWkghwc2u9Z
RShNxlCHfg/lTFkkm5wbHEpl1W1sImcLhYSLdoXAdUhK8lQOoUiFYOtg9s6xq6LH
3NHH4roY+HQE2zpK6gY45BsD1Fi3qdg5VNwTHkvcducdC5jjXnJ1UikL48zM72An
LK8EqQfGx06RVkPgPyxTeUjniJj9SyixZjBD8YzqlmhSCt3RD4e0V+5/wd8YlPpI
dBaYqzLSfft+vtJEqUyds/SilMHqf2brvJ9e2chwIqBlghxPb9GpPjHASDqk1/t8
+ckFaOtdtamw0H8JFp1ixzFn7WLvUp3jpQJbSzZxmKwC0hZCxl/aXFKcq+gDg3k5
1wt/su+1zfb1Qjp8M8tKHLWy2/aXT/yY7IeWAk2hpOel3e4L9pDU6bsgQMz4kOE8
WO6GHDu2YA688EArVL8ErTkKw04+mGdTMmjqrF00O/MWnW8LNKNTHIHaxWtCfXVv
mHSUyHt94CoDtScwCdLmyZslHiO0XgUFhnK+EPd+sHyaAPu2uH6ezfFMRF8F1vs8
WXsOnZArDg+r02PnltEjbIEOJ8t+tYTZqZ/3IKn2Gecixqhqdmc=
=yPBa
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Siva Mahadevan (1):
  bsd-user: update aarch64-bsd-user.mak gdb XML list

Stacey Son (17):
  bsd-user: Add host_to_target_uuid for uuidgen(2)
  bsd-user: Add target_to_host_semarray for semaphore operations
  bsd-user: Add host_to_target_semarray for semaphore operations
  bsd-user: Add target_to_host_semid_ds for semctl(2)
  bsd-user: Add host_to_target_semid_ds for semctl(2)
  bsd-user: Add target_to_host_msqid_ds for msgctl(2)
  bsd-user: Add host_to_target_msqid_ds for msgctl(2)
  bsd-user: Add do_bsd_quotactl, do_bsd_reboot and do_bsd_getdtablesize
  bsd-user: Add do_bsd_uuidgen implementation
  bsd-user: Add do_bsd_semget implementation
  bsd-user: Add do_bsd_semop implementation
  bsd-user: Add do_bsd___semctl implementation
  bsd-user: Add do_bsd_msgctl implementation
  bsd-user: Add message queue implementations
  bsd-user: Implement System V semaphore calls
  bsd-user: Add System V message queue syscalls
  bsd-user: Add miscellaneous BSD syscall implementations

Warner Losh (9):
  freebsd: FreeBSD 15 has native inotify
  bsd-user: Remove OpenBSD-specific code
  bsd-user: Remove NetBSD-specific code
  common-user: Drop __linux__ around .note.GNU-stack
  bsd-user: Add target_semid_ds and target_msqid_ds structures
  bsd-user: Add target_uuid structure for uuidgen syscall
  bsd-user: Add function declarations for bsd-misc.c conversions
  bsd-user: Add semaphore operation constants and structures
  bsd-user: Add bsd-misc.c to build

 bsd-user/bsd-misc.c                  | 192 ++++++++++++++
 bsd-user/bsd-misc.h                  | 366 ++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c        |  52 ++++
 bsd-user/meson.build                 |   1 +
 bsd-user/netbsd/host-os.h            |  25 --
 bsd-user/netbsd/os-strace.h          |   1 -
 bsd-user/netbsd/strace.list          | 145 -----------
 bsd-user/netbsd/syscall_nr.h         | 373 ---------------------------
 bsd-user/netbsd/target_os_elf.h      | 148 -----------
 bsd-user/netbsd/target_os_siginfo.h  |  82 ------
 bsd-user/netbsd/target_os_signal.h   |  69 -----
 bsd-user/netbsd/target_os_stack.h    |  56 ----
 bsd-user/netbsd/target_os_thread.h   |  25 --
 bsd-user/openbsd/host-os.h           |  25 --
 bsd-user/openbsd/os-strace.h         |   1 -
 bsd-user/openbsd/strace.list         | 187 --------------
 bsd-user/openbsd/syscall_nr.h        | 225 ----------------
 bsd-user/openbsd/target_os_elf.h     | 148 -----------
 bsd-user/openbsd/target_os_siginfo.h |  82 ------
 bsd-user/openbsd/target_os_signal.h  |  69 -----
 bsd-user/openbsd/target_os_stack.h   |  56 ----
 bsd-user/openbsd/target_os_thread.h  |  25 --
 bsd-user/qemu-bsd.h                  |  15 ++
 bsd-user/qemu.h                      |  16 --
 bsd-user/strace.c                    |  34 ---
 bsd-user/syscall_defs.h              |  93 +++++--
 common-user/safe-syscall.S           |   2 +-
 configs/targets/aarch64-bsd-user.mak |   2 +-
 meson.build                          |  14 +-
 util/meson.build                     |   6 +-
 30 files changed, 704 insertions(+), 1831 deletions(-)
 create mode 100644 bsd-user/bsd-misc.c
 create mode 100644 bsd-user/bsd-misc.h
 delete mode 100644 bsd-user/netbsd/host-os.h
 delete mode 100644 bsd-user/netbsd/os-strace.h
 delete mode 100644 bsd-user/netbsd/strace.list
 delete mode 100644 bsd-user/netbsd/syscall_nr.h
 delete mode 100644 bsd-user/netbsd/target_os_elf.h
 delete mode 100644 bsd-user/netbsd/target_os_siginfo.h
 delete mode 100644 bsd-user/netbsd/target_os_signal.h
 delete mode 100644 bsd-user/netbsd/target_os_stack.h
 delete mode 100644 bsd-user/netbsd/target_os_thread.h
 delete mode 100644 bsd-user/openbsd/host-os.h
 delete mode 100644 bsd-user/openbsd/os-strace.h
 delete mode 100644 bsd-user/openbsd/strace.list
 delete mode 100644 bsd-user/openbsd/syscall_nr.h
 delete mode 100644 bsd-user/openbsd/target_os_elf.h
 delete mode 100644 bsd-user/openbsd/target_os_siginfo.h
 delete mode 100644 bsd-user/openbsd/target_os_signal.h
 delete mode 100644 bsd-user/openbsd/target_os_stack.h
 delete mode 100644 bsd-user/openbsd/target_os_thread.h

-- 
2.52.0



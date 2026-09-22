Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E85C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964N-0000wD-P1; Tue, 22 Sep 2026 15:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963Z-0000Xl-3F
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:38 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963W-0002Nn-Nx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:32 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a2ffee6so139336b6e.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104888; x=1790709688;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uNMOSXVtgc3pzLgkp96faXEoBkmyDPv6fjUHRCgcx+8=;
 b=vQV4rGu2YwcTyqeu9ICTBPj3DcyPHIR9o59vbMWugN3V3/45qRN+6C9A077VmSiB8N
 S0hmYgPzXvWjBWpXgMNK1zoxNJdbodI4LKgCiITe6hoB9c0IsRYfv4hXJvlbCE9jJaoE
 BbjtWQbtx82EG4n4W9BrzaMWdMenq20o5p24FiHlDMifX31+5qJPn3269c9EmDqyVTur
 96VM6OIz9ctY2Fhs35CaBEAF/mE5i6PIjP2HGqL3ejM6oxAA3fzrAEpkv3HucbV63cJz
 djBvpIBCnsc/Ilsq7W8r+F3S2x3LmwVZWFkCQt4+PreTRq9o91Ed0m1OCBPg5KEPmYu/
 gOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104888; x=1790709688;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uNMOSXVtgc3pzLgkp96faXEoBkmyDPv6fjUHRCgcx+8=;
 b=QZIpxH1D4CQxD11y8tYhXGgJmoNbFs406lbLiWB/sSSst5KocguPyldSwHfwlo+jE3
 GKectX7QCNz426y4MJ8CQu+y5/XIatqO6WKxcox6CZN51xQ2JdarVDbWoQ4+dLQi4rDC
 lrSTMvFzGGV/3ff1EBA7HVDvFNYHVZRseE5YOFLMRhUikImIVr3SljeXsszOsc/gPU3K
 oBjIgVIviDCqsbEBGjfym9mXvilYOEMy5k2gRbVJRx92m17jjo8FzmxflbuOIPHXubtW
 PRhQtP/CrhDXfMmqZAvyuaUN8TMKmdpn7rlC5QrhxW0E86OMPNSQrSAmnKovak/cTlQt
 yp+g==
X-Gm-Message-State: AFuF++k8/MBGgAxVCIazZZe4sD2UdipW5kWNrj50VSn+MBX8H+2/N9Ii
 tQYfzav2g2jP9kHx164DsZD8iRrzxex7rGS5d6q86+5ZYlK8y/r9oUbVQvTURBXTxSGQ4T1oQlW
 CzOFTjVs=
X-Gm-Gg: AYBFou2D3Lo4HxwOV5S7wG/MrnmwuWJO/sZg/k/eonT9Gq4zvfVhjgUzPt1mIsH5/U4
 dFNWZ4qc97sAZ0ebVF2doKVoXV91aoukef0VafUHjmRgTZ2ePrdgojAl2+7BKBNtlKGgdlVAoI1
 YMarHwgg1FJamGN6Glha7SKqEDiYU9q/ncT3lCIkFNdBPZlj811wFsdN7tjK2Dz6AINkOb2M0Sd
 ljW+AcAV50IeezkqEYkmmGXuaDVGM6N++Ak1b8uoDQyL2nv3lE+B7//nxkzkK2M8IsavycfeSMZ
 6xiItv3FUOccJ2wPIDP0no1I3a4biR3Ul3cAsNhQigBwrEFer5GDPp6lmo/RUHzHyrrG6B208DU
 HsgKaQ7DazC8X7nhTcS9MT/TG7fESSrcpPuAM4quwZy28vQKL8A9+X7Mv5hbzvGtvOo/RN1djLC
 aHLhaT/UcCvWR6f/j+fjcWSVdQyTbhJAmWTLYypF7FnfzV8Ekll/W2QMwTOy8jgC95uZj0
X-Received: by 2002:a05:6820:1612:b0:6cd:3ffc:64d4 with SMTP id
 006d021491bc7-6d2d2b1fbc2mr346862eaf.79.1790104887601; 
 Tue, 22 Sep 2026 12:21:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PULL 00/11] Bsd user 2026q3 patches
Date: Tue, 22 Sep 2026 13:20:58 -0600
Message-ID: <20260922192109.98467-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:

  Merge tag 'qom-qdev-20260922' of https://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu-from-official.git tags/bsd-user-2026q3-pull-request

for you to fetch changes up to c79adb04654bba3e505e5332b90b7ca2c639b044:

  bsd-user: Remove host-os.h (2026-09-22 13:07:11 -0600)

----------------------------------------------------------------
bsd-user: misc fixes

Catch up with a number of trivial differences between master and blitz branch:

 - HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always defined
 - Drop support for FreeBSD 12
 - Flag shared memory as needing atomics
 - Initialize per-arch child registers
 - mmap fix for flags from long ago
 - Move tb_flush stuff to begin_parallel_context
 - Implement exterrctl(2)
 - Implement sigfastblock
 - Eliminate unused regs arg in load_elf_binary
 - #ifdef sockopt that aren't in 14
 - Remove host-os.h
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQJPBAABCgA5FiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmqy1REbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEGwc0Sh9sBEAQroQAJMmYV/REl8PlyGlqiD9
uNLEiXTkO8erWUA33LbNxvbWi9oltoOHpyEF9u1i45vKChyV6SszGt9P9ev5MHjJ
VEJTjeWnb0Nq/J+fS3cnxACJS234PEDOVcoVumj7/RyvLNO+lFdYv50ZsOpfEqYJ
Pgkl/V0uyyLx4U3pWm5prxud0rt1fQMrJXoX1gnlJt55BOjLRc6iqHzTm/PIsnnE
5VU7o+FWZXJo5jGNiaBsHJHdji6fX8VJc6Ot1m1rw4nFt0RhyrB6bCaPINLz3jjm
j9gBfZNLhRG1rSyQkLBKITOV3mGgKaGTE2FsMQg/zx8j3fDuX4iht5DRtCUQwKST
LQQOYD5WO/fFvFyoC8HVKV4+WHiaM2cyIRR1ANRR8aSRV7tFP4H4p8WdmsBKWJ+R
mws2GMC4DgkDfELKpB1oVmLnLOvMB0+hFYY3LIsXVd4ytxAuSYGf+M2OCnaVBLxv
Wlv51RaX8vIW4E3qSPOIAhbQxdptRHFGlpj9LYfArsf4nKbXCor5+sWHQfGuWAKY
2JvaZvV5c6pJBFn9gfX5Jpa6JukrfmXfmrbiDm2tYmWFo0YbSkpXnnBfC+WPZ1DV
H3SoA8uuJNKO/p5/jcdiIshCeo3U2QAQeHjPmR3Pj5iDR3ZE0aiQbc1WUcucyXqS
TWhd1Ob6d6T5N/J0xGqwRiKr
=xgLW
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Rick Richard (1):
  bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are always

Warner Losh (10):
  bsd-user: Drop support for FreeBSD 12
  bsd-user: Flag shared memory as needing atomics
  bsd-user: Initialize per-arch child registers
  bsd-user: Fix crazy bug with mmap
  bsd-user: Move tb_flush stuff to begin_parallel_context
  bsd-user: Implement exterrctl(2)
  bsd-user: Implement sigfastblock
  bsd-user: Eliminate unused regs arg in load_elf_binary
  bsd-user: #ifdef sockopt that aren't in 14
  bsd-user: Remove host-os.h

 bsd-user/bsd-file.h               |  43 +++++------
 bsd-user/bsd-mem.h                |   8 ++
 bsd-user/bsdload.c                |   2 +-
 bsd-user/elfload.c                |   3 +-
 bsd-user/freebsd/host-os.h        |  25 ------
 bsd-user/freebsd/os-misc.h        | 121 +++++++++++++++++-------------
 bsd-user/freebsd/os-sockopt.h     |   2 +
 bsd-user/freebsd/os-syscall.c     |  11 +++
 bsd-user/freebsd/os-thread.c      |   9 +--
 bsd-user/freebsd/os-thread.h      |  13 +++-
 bsd-user/freebsd/target_os_user.h |   5 --
 bsd-user/main.c                   |   2 -
 bsd-user/mmap.c                   |  26 +++++--
 bsd-user/qemu.h                   |  21 +++++-
 bsd-user/syscall_defs.h           |   9 ++-
 15 files changed, 175 insertions(+), 125 deletions(-)
 delete mode 100644 bsd-user/freebsd/host-os.h

-- 
2.55.0



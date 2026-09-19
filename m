Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C357C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yEt-0002l4-LX; Sat, 19 Sep 2026 12:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEl-0002kM-8G
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:28 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEj-00086Q-1G
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:27 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bc475ffcf6so809662eaf.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836503; x=1790441303;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7lB1+7btwxyBVuXCNR9un9F7lJLAjSla84MCAwtJbj8=;
 b=AQQOM/eJ9W8+W67b4wC5lwJBXzUEjTkmdKiKzNOyKDwgL+G+yZW8WRhc8xNDWFCUtM
 2oMmR/hYIVxTsQAO8O/qC0YKMuXy1M0t3ejEHj7C0If1kisuTyvR3aGhBlNpnfMkD4JM
 a4lY06iYZ3A8ia2KyfhWwFmD+xph1oFli4OYe2rZ0FsgT6el1XLDMcEam82Q4N/aSGAH
 v3sCXMK0XggiVCwd1la1mMoMC9mQFpXeno/sEuZ+D2jPrP5u8FbsFg1EN+8MhstvD4K3
 3i2CFe8AWzOi5GlkdnZV1kIMKv/D32JlJpgd/vTlev3leQUbo8mnBjG13fcyrNXtIVBL
 4zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836503; x=1790441303;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7lB1+7btwxyBVuXCNR9un9F7lJLAjSla84MCAwtJbj8=;
 b=DmoiBk5ljfcDy9zwfuQUPicRJpRkC+5jafaPYUxox2VerwBRsYpkO98kp4NL74ybKG
 EWnnflYfgwsTzv8sdFDlysy8nT3M8uohjlGfznMpmfPacjss5JsKC1LXsky7pYp0sudV
 fA3p5+WA+N/QmxNJMdQGXjaD81quiuGl5ASTxte9K4YkuiciykaDFCO9jjUl77Fen8JQ
 EQBo28MGsXfQDiRGMRzK39mf3aRuEC4SV0DtVo1fawpNaXDlEuzXmUiBnlYr/kHQhtpV
 rtc+r1lS+PTJ7LnGR5IgP4h8JNevZ76UbX21bDnl1Nlj45bWhmRpwNdA7JCIGPX9sAt3
 Ev2w==
X-Gm-Message-State: AFuF++lLxa/1JW2lIV79/ZbPn6UB/kg9WTQLNfBSMODnlPxH0oYmn/xC
 IMIQWflGBgpy/mlpk2offJL5LC/XnA8Mq8KBCpYc7rGAGjAj/NfiUBOwdfVA8rTj/u1JirQtz5R
 376kxOnw=
X-Gm-Gg: AYBFou0DW8ShzHDdTwM2kNXn+6c0inVeZmbxFZH4FdycuoqN0gjxIqbc4/ZKwb2W4k+
 MIxt9o6osqkSfpJGuWOEgW7hWZhScO6i+Es2tqFoOui7WdnUlctpHwe55Wp870WXVSTdhxktDZa
 cXAh9uxos+Kbyb8/FXBGhd7nvlBo2W3XbYmtzvcD2nUpqFdANlUbbzkcp6jjYtE7KpKmF6yTLRX
 bLEZ8kChbJsHy7M1y6V2kwxMRvFS/I+lXPBJ5y72A0Bm1jIHf0VtOoJIsg9LGt9hFUC3tY9lJad
 QmT1we/f/bCG4MKp3OYMnhxUeXGCmlZErDY08jDfw0Vnnz6TqW9TOJ3P3x/UROopCBBgfGNfgNr
 8tgu7j12YGqxb7lb2pKvnzpAavA9r4dAy/g01U9WuwkjBVaqKixJoap4K7WkVeaeMbWbhGXAYxA
 ybvUS3CuDODMrYXRLAWQGUzInnazOSa7rqx9Y+tCWFgoX23SJOiO4DnuUKTQ==
X-Received: by 2002:a05:6820:6ae3:b0:6c7:af50:b2f4 with SMTP id
 006d021491bc7-6ca9a027107mr5403301eaf.11.1789836502864; 
 Sat, 19 Sep 2026 09:48:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PULL 00/41] Misc 2026q2 v4 patches
Date: Sat, 19 Sep 2026 10:47:28 -0600
Message-ID: <20260919164810.70151-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:

  Merge tag 'pull-ufs-20260918' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-09-17 15:18:09 -1000)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu-from-official.git tags/misc-2026q2-v4-pull-request

for you to fetch changes up to cec065d3f2e9b67bb2b4beaf03df07c45429fecf:

  bsd-user Update random_seed on thread creation (2026-09-19 10:35:35 -0600)

----------------------------------------------------------------
Misc 2026q2 v4 patches

V2: Fix build on FreeBSD 14

bsd-user: Upstream most of the remaining system calls

Upstream the file, thread, socket and remaining signal system calls (too
numerous to list here).
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQJPBAABCgA5FiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmquvKUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwzAAoJEGwc0Sh9sBEA0oMP/RIw/W+c+r0Gki0fejuk
ysGI0BI9fpUc2y/1ZuDDODKFgkFjeFlWgrC1jbd+zvbe3ZtZ6nlrhwwWc8F47XCs
VSHTQR5JkazC+WMdBDbWvjDpoxl3c3XHVx/l/gd8p+QUsRM9nf0LSK7jSfyrsI7g
SO+7MTeYvFOlqee4vVre6ZcfbdL6Nbl+08BcS6T4uRKqudN09xF6dbS5cEltMVc6
HM/mWq+KNf+cZxbUw9X1ZJeWzBJzn4VL9iDm4P1KdkR5T2uNqVN+TLY1QTy5FvJ8
xJsPx4Mxr/uI2lBBtnSGiVydMsdDRY5z0c/gKO8vCjvr3wNQDaKokavnPkNNqGIl
WGe2d0RTM7+giWHKrx/wj5DhYtHyhPf3+OVduPPqWHkuFY0fP2GT4roNp2F1ygc+
BfW5Fxv3z12D2+DmuG81I5y3XZ/BMM1aG6aqlizix5uWoDPPFcMSrVFHsET20rey
Tn9Q3RdDEDvWpbUjWeKF2SPugjI0U8yynmU08lR3Piu9GjB5KlQ9gLpgMU4cfTa2
oM9hupTKjPqKPaMsxfooplfD8zOkSRU1AadWylZ8s98TbkyP8nn/VT2jM0riUwKZ
U1ZgpCh7Qw3geLjEH6lx/TgwCXA61XjRL4msDN9eY+J95x4ETtIzdytDpnRM6mqm
lbtqoP8P7ZH7A4nFdyI9UsCy
=jBg1
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Warner Losh (41):
  bsd-user: Upstream most of the remaining system calls
  bsd-user: Rename cpu_env to env throughout bsd-user
  bsd-user: Fix copy direciton in preadv
  bsd-user: Add bsd-signal.h with sigaction through sigreturn
  bsd-user: Add signal shims sigwait through kill and os-signal.h
  bsd-user: Add signal system call dispatch
  bsd-user: move sys/shm.h lines
  bsd-user: Remove mmap defines
  bsd-user: Use target_suseconds_t
  bsd-user: Move sys/uuid.h defines
  bsd-user: Fix realpathat for FreeBSD 15.0 and newer
  bsd-user: Add os-file.h with chflagsat, close_range, and more
  bsd-user: Add poll, poll2, lseek, pipe, and swap system call shims
  bsd-user: Add FreeBSD socket helpers and sockaddr conversion
  bsd-user: Add bsd-socket.h with bind through getsockname
  bsd-user: Add socket shims socketpair through shutdown
  bsd-user: Commit the generated os-sockopt.h files
  bsd-user: Implement both getsockopt and setsockopt
  bsd-user: Add FreeBSD socket system calls
  bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg
  bsd-user: Add socket system call dispatch
  bsd-user: Add os-time.h with clock and time-of-day functions
  bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
  bsd-user: Add select, pselect, and ppoll to os-time.h
  bsd-user: Add kqueue and kevent functions to os-time.h
  bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
  bsd-user: Add os-time.c and time-related type definitions
  bsd-user: Add time system call dispatch
  bsd-user: Add cpu_copy and make init_task_state non-static
  bsd-user: Add os-thread.h with thr and context functions
  bsd-user: Add do_freebsd__umtx_op to os-thread.h
  bsd-user: Add thread system call dispatch
  bsd-user: Add os-extattr.h with file and fd extattr functions
  bsd-user: Add link and list extattr functions to os-extattr.h
  bsd-user: Add ACL system call shims to os-extattr.h
  bsd-user: Add os-extattr.c with ACL conversion functions
  bsd-user: Add extended attribute and ACL system call dispatch
  bsd-user: Add scheduler and cpuset functions to os-misc.h
  bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
  bsd-user: Move qemu_guest_random_seed_main to same as linux-user
  bsd-user Update random_seed on thread creation

 bsd-user/aarch64/target.h     |    2 +-
 bsd-user/arm/target.h         |    2 +-
 bsd-user/bsd-file.h           |  168 +++-
 bsd-user/bsd-mem.h            |    4 +-
 bsd-user/bsd-proc.h           |   26 +-
 bsd-user/bsd-signal.h         |  231 +++++
 bsd-user/bsd-socket.c         |   98 ++
 bsd-user/bsd-socket.h         |  283 ++++++
 bsd-user/freebsd/meson.build  |    8 +-
 bsd-user/freebsd/os-extattr.c |  118 +++
 bsd-user/freebsd/os-extattr.h |  661 +++++++++++++
 bsd-user/freebsd/os-file.h    |  129 +++
 bsd-user/freebsd/os-misc.h    |  466 ++++++++-
 bsd-user/freebsd/os-proc.c    |    4 +-
 bsd-user/freebsd/os-proc.h    |   26 +-
 bsd-user/freebsd/os-signal.h  |   20 +
 bsd-user/freebsd/os-socket.c  |  239 +++++
 bsd-user/freebsd/os-socket.h  |  428 +++++++++
 bsd-user/freebsd/os-sockopt.h |  318 +++++++
 bsd-user/freebsd/os-stat.h    |    8 +-
 bsd-user/freebsd/os-sys.c     |    4 +-
 bsd-user/freebsd/os-syscall.c |  790 ++++++++++++++--
 bsd-user/freebsd/os-thread.c  | 1684 +++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h  |  596 ++++++++++++
 bsd-user/freebsd/os-time.c    |  347 +++++++
 bsd-user/freebsd/os-time.h    |  989 +++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |   48 +
 bsd-user/i386/target.h        |    2 +-
 bsd-user/main.c               |   38 +-
 bsd-user/meson.build          |    1 +
 bsd-user/qemu-bsd.h           |    8 +
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  449 +++++++--
 bsd-user/x86_64/target.h      |    2 +-
 37 files changed, 8112 insertions(+), 206 deletions(-)
 create mode 100644 bsd-user/bsd-signal.h
 create mode 100644 bsd-user/bsd-socket.c
 create mode 100644 bsd-user/bsd-socket.h
 create mode 100644 bsd-user/freebsd/os-extattr.c
 create mode 100644 bsd-user/freebsd/os-extattr.h
 create mode 100644 bsd-user/freebsd/os-file.h
 create mode 100644 bsd-user/freebsd/os-signal.h
 create mode 100644 bsd-user/freebsd/os-socket.c
 create mode 100644 bsd-user/freebsd/os-socket.h
 create mode 100644 bsd-user/freebsd/os-sockopt.h
 create mode 100644 bsd-user/freebsd/os-thread.c
 create mode 100644 bsd-user/freebsd/os-thread.h
 create mode 100644 bsd-user/freebsd/os-time.c
 create mode 100644 bsd-user/freebsd/os-time.h

-- 
2.55.0



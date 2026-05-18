Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556E1CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VF-0000Ke-Gi; Mon, 18 May 2026 17:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VE-0000KT-OI
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:56 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VB-0000Pe-VQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:56 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dea1272943so1383242a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139671; x=1779744471;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nnhGkjhJhIxMNrk7HX8kqHm9bUO+A29vVzEdtNqg9kY=;
 b=WfoY2gysNfhs/6TvvOuCrocLZBKXSXWnR4ByjWcbcy+0Qam5l2unBxfZuO6zlnyywr
 IeMC1MHh9+pK4zm7uCEbd9SmrTAwJ88HoeKO9r4qw6Ky1PWbYupyC4zj/diXXvJ2wF89
 uql6dThyto6trCKqYzxwPXDSvgTPLaX2te9FH0mDeUVEjzCB/kDgFnQIZfv4W2wJQyLF
 Uh5I3A6f/uOQOCltRhs2fI8B0+AfjM/PbarP/LRjw3297tGl5I4+8kHDEWBY2s6LUiAw
 HSLqrLM7IpuSCQDimYx/FK1ZE0aUESbk5dBuSup4G2phG2cJVzPDbR+ZyjOKDs/dBeQZ
 G3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139671; x=1779744471;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnhGkjhJhIxMNrk7HX8kqHm9bUO+A29vVzEdtNqg9kY=;
 b=odjoN2AQD/cZ85PPOP75l/MMTEroblcK/PqUK78ZklFlxQiUI/qvPQ6N+F31G87+gj
 zGtn3kW/nHH5GBzTOszf7fI+rbI8XGEnsaLRU9vR/NKGXYZ6x3HYPqu1K6cgygU7zIOk
 v15iLt/u4jmjP01DK1UvDrzhk4NiYybu/gTqqXrxmZmagBXzL6bx/Qz0yNwiFBcfqinh
 LEpIhmdu59PP7K26Wyo0KyClYoUQMdJzBtU1jQ0q8NdfE8QAdxHFgE5pNpce1z0aivz2
 Lomr+wqtkbLfGB3rM3MlMhWdcoW+dqKGrMesoG+R4DaKhPFWYc7uGrVVCpbyPa32SHxC
 12xg==
X-Gm-Message-State: AOJu0YyNiyKNrQa9JMq8DkrT2qEZyBmG4FmdXMmQ2tSVCA9Xmk57CJYD
 rsYoo+29Y5DA14xJQd/DHmNGgdLPCumADaMm+Xeo80nmUaXzYHuaP2OZuJbvJhZERUU=
X-Gm-Gg: Acq92OH9ilBW5fHuiMcOXiMzOvYYktQFXrk7rfh2N2eIomldvBMdHvHu6hGmOMzMLID
 mobwe+RFbre9IVhtiZyVoZO/vo1YzdtZGp3/EUd8qHzSavDcCPBDklhL0RzyVrx+gVqJwoTfJFF
 8Z0DgY+be74+5c8P19Z6tfW9JEKa6Ql9e+iYUZqHPEhAV999uZi8en6k1caNX4XFuXajYpjIBUu
 ECUjFydZ/jhmbB3M0levhLBTUiL5LWxGkaPkhkyfALxKUWw/JrdrInQFdb0YjOdiAz6AWKCMuaH
 VOblZNJ9zkuB9KcCJrKI4uLup0ptaI3YR+3x8kLdK9XJtdiemUadLjX3MDzHAsXDTcj8cmu+VGN
 FIyKGn1rRq1PSgM+tSgdjnkX/zTz4agF4CL0OzeLTsAhU41C2l6bu1sCPWKiyWuY8CHSZPfX4QB
 QTm/f8ZkDLutU32rVvDfHTS32vafIqzaQ=
X-Received: by 2002:a05:6830:8c6:b0:7e5:68ca:8856 with SMTP id
 46e09a7af769-7e568ca8bb2mr5748240a34.26.1779139671495; 
 Mon, 18 May 2026 14:27:51 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system calls
Date: Mon, 18 May 2026 15:27:18 -0600
Message-Id: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaEC2oC/1XMyw6CMBCF4Vchs7amF6rGle9hWAylyCxKsWMaD
 em7W4gbl/9JzrcC+0Se4dqskHwmpjjX0IcG3ITzwwsaaoOW+iStbEUgdmKrpxZocTQKnTQaoT6
 W5Ed679q9qz0Rv2L67HhW2/pzlP1zshJS2NZcHLaq12e89TxQWI4uBuhKKV8deh1IpwAAAA==
X-Change-ID: 20260504-misc-2026q2-a5af31ac032a
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7821; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=88W5uf0b5g2tqtCx5dD5a7Ls7KPqn3QSCAYglgrrVaA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4Q/vG0h3479lepzYMFgGXsSgMJz9yRSvdpKP
 EvtvUrasE2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguEPwAKCRBsHNEofbAR
 AK6ND/0SrbYcvK85hERlXncvnhfVv8Iy2fxJSd0JIqjEbRwde63QiAc2bPcndcnkGl7r7jLyKrH
 izPUiOFrdfB59u83BMmHEMkPfb+OdvmP/5Brif4NWcPvC1dYqy48U/aBVKM2LVaBK5zzW631G0E
 Y7ODopUG5SQ5+q1Ph6RhLmNMuoG6v/RLs3iUQSZQ9MpES3I9Gu8vM/7kRwMfGtWE+kxnLg6PwG8
 hDr1DoJ2qYawWhfDteJdBJ7DEBS5QrVbVQoX9yHrlr3obH7CiOkY74L/cJd1eu8J4ZWDPz6d5OS
 nhepXWIaWiZ4CzaMSXb0Tz3yguLix9z4+oZjSt2tiGcSesybfCnfxr1YhEPzwzsz33MnFpFEW77
 qBYT8gZ9Q3kTDLNnUsmMKlEEdCRA1B6nNuTb85W/rZ48urbqYBZukfJ04voAtB7iiId3S6HQ7zF
 U/iRbrxMb4TD/KnzLGTw83+5/e/M+eb/Dl8Y7Jzr2BllJy2C0CftH3wHqiFi2G3BN46U3/XrBj+
 xmFGR0JIJEDGjR39fU8YiTNoit6YWU/qEJEeitx9nSdAwXYet08O/gD9Ga17zioxr3fM6FXVw09
 68xl5F1GiOvIk1ojcOEI3dx6wCPCDFVKQyUqvD3Dx1n8yd8vD6dJfhnHR0eiSm4ETHo5+cdQNKj
 awJX2j2lmk1GoBg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
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

Upstream the file, thread, socket and remaining signal system calls (too
numerous to list here).

This series is an ambitous use of claude to help me upstream all the
remaining system calls. I've batched them together in what I think are
reasonable chunks, and had claude do the grunt work of copying the code
over and attributing the commits from our complex branching history. The
chopping up was a bit arbitrary, but I think it's good. The commit
messages may be a little weak, but may also be OK. I've also double
checked the style and made fixes upstream for them as well. Claude also
reviewed all these changes and found a few bugs that I've fixed. I've
personally read through them all and haven't found anything glaring. I
fixed all the bugs that were found, in most cases differently than
claude's suggestions.

I've added 'Assisted-by: Claude...' to all these commits to reflect my
leaning on Claude so hard. This use falls within the 'non-creative' use
that the Qemu project has said is OK. If that's not the right thing to
do, I can remove them.

This leaves sysctl translation, the powerpc architecture support,
coredumps and a transition to 'truss' based system call tracing. With
these changes applied we'er down from a high of about 30k lines of diffs
to only 5k (not counting genereted, but checked in files in blitz). The
changes are 8k, so maybe a bit ambitious from that perspective as well.

There's a few lines over 80 that I've not cleaned up. Let me know if
that's a problem. The other warnings are about adding files, and there's
no new MAINTAINERS entry needed. And the 'arch dependent defines should
be avoided' are needed to cope with different FreeBSD build systems
having different system calls.

Note, this is called out below too, but in v2 I've folded back all the
fixes based on some out-of-band feedback I recieved to do this the
normal way and the qemu project isn't interested in the fixes to fixes.

This is a big experiment, in many ways, for me, so I'm interested in
whatever feedback you may have to make things better in the future.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v2:
- don't write offsets on errors for copy_file_range
- pipe2: Check the raw system call value directly
- setsockopt: Check target_to_host_ip_mreq return value
- <several places>: Check return value of host_to_target_sockaddr
- do_bsd_setsockopt: Read in the socket option
- ntp_gettime: write back time on non-errors, not just 0
- do_freebsd_sigtimedwait check t2h_freebsd_timespec return
- do_freebsd_swapcontext writing incorrectly, readonly data (0 to user_unlock)
- do_thr_set_name needs get_errno()
- Have ntp_adjtime write back the structure
- kevent_freebsd11 no need to explicitly mask, datatypes do this for us
- do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
- target_to_host_sigevent is read-only, so pass 0 in unlock_user
- target_to_host_ip_mreq needs tswap32 for int32_t
- use get_errno on kenv return values to report errors better
- kevent: only copy the number of events returns, not whole buffer
- Copy tolerance field of timex
- freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct
- Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
- Fixed additional missing unlock in freebsd_rw_rdlock and freebsd_rw_wrlock in !_UMTX_OPTIMIZED
- Squashed all the bug commit back to the appropriate earleir patch
- Link to v1: https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com

---
Warner Losh (37):
      bsd-user: catchup to locking / mapping routines in bsd-misc.
      bsd-user: Rename cpu_env to env throughout bsd-user
      bsd-user: Add bsd-signal.h with sigaction through sigreturn
      bsd-user: Add signal shims sigwait through kill and os-signal.h
      bsd-user: Add signal system call dispatch
      bsd-user: Add poll, lseek, pipe, and swap system call shims
      bsd-user: Add os-file.h with pipe2, chflagsat, close_range, and more
      bsd-user: Add file operation system call dispatch
      bsd-user: Add bsd-socket.h with bind through getsockname
      bsd-user: Add socket shims socketpair through shutdown
      bsd-user: Add os-socket.h with sendrecvmsg and message structures
      bsd-user: Add do_bsd_setsockopt and socket option definitions
      bsd-user: Add do_bsd_getsockopt
      bsd-user: Add FreeBSD socket helpers and sockaddr conversion
      bsd-user: Add os-socket.c with cmsg conversion functions
      bsd-user: Add socket system call dispatch
      bsd-user: Add os-time.h with clock and time-of-day functions
      bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
      bsd-user: Add select, pselect, and ppoll to os-time.h
      bsd-user: Add kqueue and kevent functions to os-time.h
      bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
      bsd-user: Add os-time.c and time-related type definitions
      bsd-user: Add time system call dispatch
      bsd-user: Add thread, umtx, and ACL type definitions
      bsd-user: Add cpu_copy and make init_task_state non-static
      bsd-user: Add os-thread.h with thr and context functions
      bsd-user: Add do_freebsd__umtx_op to os-thread.h
      bsd-user: Add os-thread.c with umtx, mutex, and thread creation
      bsd-user: Add thread system call dispatch
      bsd-user: Add os-extattr.h with file and fd extattr functions
      bsd-user: Add link and list extattr functions to os-extattr.h
      bsd-user: Add ACL system call shims to os-extattr.h
      bsd-user: Add os-extattr.c with ACL conversion functions
      bsd-user: Add extended attribute and ACL system call dispatch
      bsd-user: Add scheduler and cpuset functions to os-misc.h
      bsd-user: Add kmod, posix, and misc functions to os-misc.h
      bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch

 bsd-user/aarch64/target.h     |    2 +-
 bsd-user/arm/target.h         |    2 +-
 bsd-user/bsd-file.h           |  164 +++-
 bsd-user/bsd-mem.h            |    4 +-
 bsd-user/bsd-proc.h           |   24 +-
 bsd-user/bsd-signal.h         |  231 ++++++
 bsd-user/bsd-socket.c         |   98 +++
 bsd-user/bsd-socket.h         |  283 +++++++
 bsd-user/freebsd/meson.build  |    8 +-
 bsd-user/freebsd/os-extattr.c |  116 +++
 bsd-user/freebsd/os-extattr.h |  662 ++++++++++++++++
 bsd-user/freebsd/os-file.h    |  129 ++++
 bsd-user/freebsd/os-misc.h    |  470 +++++++++++-
 bsd-user/freebsd/os-proc.c    |    4 +-
 bsd-user/freebsd/os-proc.h    |   26 +-
 bsd-user/freebsd/os-signal.h  |   20 +
 bsd-user/freebsd/os-socket.c  |  234 ++++++
 bsd-user/freebsd/os-socket.h  |  770 +++++++++++++++++++
 bsd-user/freebsd/os-stat.h    |    8 +-
 bsd-user/freebsd/os-sys.c     |    4 +-
 bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
 bsd-user/freebsd/os-thread.c  | 1682 +++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
 bsd-user/freebsd/os-time.c    |  346 +++++++++
 bsd-user/freebsd/os-time.h    |  983 ++++++++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |   48 ++
 bsd-user/i386/target.h        |    2 +-
 bsd-user/main.c               |   32 +-
 bsd-user/meson.build          |    1 +
 bsd-user/qemu-bsd.h           |   26 +
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  458 +++++++++--
 bsd-user/x86_64/target.h      |    2 +-
 36 files changed, 8150 insertions(+), 196 deletions(-)
---
base-commit: edcc429e9e41a8e0e415dcdab6aa52ad17ef8889
change-id: 20260504-misc-2026q2-a5af31ac032a

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



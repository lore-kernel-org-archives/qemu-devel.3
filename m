Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C46CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gq-0002tx-KL; Sun, 21 Jun 2026 00:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gn-0002sf-6f
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:45 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gj-00050z-61
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:43 -0400
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-6a0fbef9ea9so231993eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015697; x=1782620497;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dASRJVuF7/tJEDimKvlKtBP59ojpjIQ9cFdbVAW0rmw=;
 b=sXaGyjTgUfpAFMfqGYiWEwoezdbLnNUGkfc4RclED5bnl/apWOwyvdkklxOSAdQinZ
 oyh6aBWoQOYmwogu5f2gFp8VI2RYUfFqZ+PAFoYYkhjT6VeES/TTk0GhMHE+CvwwSbM0
 AU5QHN9coytIa0gvEwkRUuyF78fHNq8L0PApAgN3s1nWx0ZfBKAP++Pz7OLhQGGDX12k
 nnhFAZJ1nR0UNdokEzEynMarGL9E3p2st0R47ABbI6uIGgU8zShlh8KZS530b31+8Rtm
 kAimL3u1vEqYt8LCidI9bx95WxaSi3oa+8tObAhYVjyeW15NGaJTwxU6CtcAFie8RslW
 HO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015697; x=1782620497;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dASRJVuF7/tJEDimKvlKtBP59ojpjIQ9cFdbVAW0rmw=;
 b=MK+BVzwhjMX01rOJVTLFnDhl/F7tQADKST8onjyhMWqHTf1diA8cMBUxruy/Yq5p+D
 uHHGo9YxA2SiYpO+v1yVRn5nDz5mUqLM4boPnCtIgf4lVukY3nUgd96BxNS4LCWwF9ph
 e69KsunsBTXhLmASzgTwargg24jY8burdLIdCCqLwLv697Yi4autu1yKZfaoeiN27Ac+
 KZM2ImEAY6xwXYLUbSqXsEF4y74prstUung2VMdrF0l6smMJ+f6d7oN6v7NyZR7bGF8D
 0jShiMWfS8m0PZzd+PjU4pawHUquFFa5yoPsSVE1/9pK1plO16Or7Qtp72Rgqb4GF84J
 rtmg==
X-Gm-Message-State: AOJu0YwqlwOosTHp3AUX8MnB1X9RtoJWO+pQ8M0Hw2P0ceBnXVMjFj+x
 yRNFcOKLTNwyu2r5iZ1IwoiUjled3gLxpG6o+Y+31r1892F60a+Ft53gpSU27FXAT5E=
X-Gm-Gg: AfdE7ckA2y4IzYApqwmieWtmMX1WQZPKO0L+2pCZCU78+pn86hlNrlth55BiCzDNWRT
 7earilKHL+5YVZyGu4ul0W38l9wXAU6x9ZBcAR97NIFzmzPrziRX7ZdSVp0ZXuNNGuCtVHRTvLo
 awPxcPshfaba11VvxA535ChAYnkzOIxQR+AO05Mm2P9xmDWi6+UO+vgjEQS8sk8h9gWt4KHba17
 4rd4RRCfCOe7Y1CdjiEyjmMOap6lnUuItgBtpqsF8g4o97jqQD4c0Dq0KZ8rGE0Np6IKbqzejcK
 JKWHQMqrf3EqxHZ26oHgv3aHtpAj/F8PRA1pPM3eIw1jp5XF87MZN9To0EIifLxqFmELMKoQaR3
 YIIE45OD6NgzE7m6r4GyxxVxMdt6fQagzSF/M8uAW8+6KVvqg0pYzsM7w1TsFYuowkO5NPCVneu
 A=
X-Received: by 2002:a05:6820:81c3:b0:69e:5e75:e620 with SMTP id
 006d021491bc7-6a0ddeac2c6mr6852045eaf.12.1782015697007; 
 Sat, 20 Jun 2026 21:21:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 00/40] bsd-user: Upstream most of the remaining system calls
Date: Sat, 20 Jun 2026 22:19:47 -0600
Message-Id: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRmN2oC/1WMyw6CMBAAf4Xs2ZrutkXiyf8wHkopsgderWk0h
 H+3EA9ynElmFog+sI9wLRYIPnHkccigTgW4zg5PL7jJDCSplEZq0XN0YqOZhDW2VWidVGQhF1P
 wLb/32/2RueP4GsNnnyfc7O+D5vBJKKQwWlXOaqzpYm91bLifzm7sYRsl+o+rY0w5Lh2Wrde6U
 hIP8bquX6h2pqbkAAAA
X-Change-ID: 20260504-misc-2026q2-a5af31ac032a
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10224; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=rcOfkRz7Fin49GTNLaBBJhhkrCG+CXI/+ucLotJXiYE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2ZxdyTsYARIN/GUeCO+MOnN72rUsjSOr4IPY
 8PgBuDIJamJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmcQAKCRBsHNEofbAR
 ABVEEADftw725zV32Zp1xm7HyvIiFbEB+IIE+PYgc+PTj2DD6l/DodKfyQDs4yQ27/U8yKW0K2u
 Wl80swotXR0gVaOP4NpH30flM/N/UxaYZLL85PBRXjsnFvEkQVvBh6irDsV4Z4R3513xZiQJ1Ho
 F73RLvquclwXRaKfocCMSqlKqqTmnzhgkGTd13gY/O93zC2Clzb8mN/pEcyia9aZ41suNgFWgQy
 kFMI86NBabbqq1lqv/EYihQz/2qbc8qKLLn+5tk3Dd6uIL08jl5/3brNhMZxIMkLeA34GtDcDN5
 flpJ6P62ULWCzKEmeOJRRNIgkOU1J9qnQtF+UAALWQj62MdjF3qHOhW90h1OoLtvoxOCOa6AhrB
 HrfsFb7Hnj2LSTgsGiwJdaPE/QtE73tlm88qkQHwSMTmA0nV4xGx8/JlE7LbEom6Q0473kJ0IvS
 LuKO78/gnczfW1S/xn+kWRSOVvByZRi6G+JWUeugVKadYyqgAKFqryF4digArg5OfnJUAdmE0Yw
 6spiata4IJ65WGxZ3faGaI0CIch6dyf9O6XoocV2noPZ5biFd4iPyAnP2puSy0mdo1OpMCH+U/d
 0jmPo2P9Qn+2x/QmhDEnonsXW0hUr2gPl1hEEuHRN2U5QX0FUMepfJQbjqX0vuNsrba/LET1EFi
 ld+ooHBqP/Cjcrg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c44;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc44.google.com
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

Note that in v3 I've added a rather long generated file. I generated it
automatically looking at the type annocations in FreeBSD on the socket
options in comments. I had to augment the annotations, so I can't just
generate it within the build from the installed headers until it's
merged from head and then merges to stable branches and then waiting for
a release on each of them (6-9 months given FreeBSD's release schedule).
Also note: there's a couple left over issues from v2, so if I've not
taken care of them all, please gently remind me if you think action
is still needed after my comments before.

And in v3 I've added some random_seed fixes for fork/new threads
since we're upstreaming those files. These should be correct now,
but I'm looking for the correction.

This is a big experiment, in many ways, for me, so I'm interested in
whatever feedback you may have to make things better in the future.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v3:
- refactor get/setsockopt, including new generated file
- add random_seed fixes to fork
- move adding of .c files to meson.build to where we add the file.
- Fix acl bounds checking
- Fix indentation and other misc nits
- copy_to/from_user needs to be abi_long
- Fix toggling of the _ at the end of BSD_PROC_H
- Fix leak in error paths in do_freebsd_ktimer_create
- Don't write back on ktimer_gettime errors
- Be more careful about EINTR returns
- do_freebsd_ntp_adjtime needs to return failures from h2t_freebsd_timex
- do_freebsd_ktimer_gettime shouldn't writeback on error
- t2h_freebsd_umtx_time needs to unlock_user on error path
- Prefer abi_long for all pointers in extattr
- Remove accidentally duplicated prototypes.
- Don't writeback the eventlist, we're just reading it
- Add missing 'do' to the macro
- Byte swap sival_ptr in convertion
- Add missing get_errno call to safe___umtx_op
- Don't write back if getsockopt fails
- Write back correct number of bytes for do_bsd_recvfrom
- Loop through cnt, not maxcnt for acl conversion
- Fix getsockopt size computation
- Return ret, not errno, since do_freebsd_new_thr doesn't touch errno
- Fixed off by one in connectat: we need the bug compat fix here too
- Fixed error in preadv: copy params backwards
- Link to v2: https://lore.kernel.org/qemu-devel/20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com

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
Warner Losh (40):
      bsd-user: catchup to locking / mapping routines in bsd-misc.
      bsd-user: Rename cpu_env to env throughout bsd-user
      bsd-user: Fix copy direciton in preadv
      bsd-user: Remove accidentally duplicated prototypes.
      bsd-user: Add bsd-signal.h with sigaction through sigreturn
      bsd-user: Add signal shims sigwait through kill and os-signal.h
      bsd-user: Add signal system call dispatch
      bsd-user: Add poll, lseek, pipe, and swap system call shims
      bsd-user: Add os-file.h with pipe2, chflagsat, close_range, and more
      bsd-user: Add file operation system call dispatch
      bsd-user: Add bsd-socket.h with bind through getsockname
      bsd-user: Add socket shims socketpair through shutdown
      bsd-user: Add os-socket.h with sendrecvmsg and message structures
      bsd-user: Commit the generated os-sockopt.h files
      bsd-user: Implement both getsockopt and setsockopt
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
      bsd-user: Add thread system call dispatch
      bsd-user: Add os-extattr.h with file and fd extattr functions
      bsd-user: Add link and list extattr functions to os-extattr.h
      bsd-user: Add ACL system call shims to os-extattr.h
      bsd-user: Add os-extattr.c with ACL conversion functions
      bsd-user: Add extended attribute and ACL system call dispatch
      bsd-user: Add scheduler and cpuset functions to os-misc.h
      bsd-user: Add kmod, posix, and misc functions to os-misc.h
      bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
      bsd-user: Move qemu_guest_random_seed_main to same as linux-user
      bsd-user Update random_seed on thread creation

 bsd-user/aarch64/target.h     |    2 +-
 bsd-user/arm/target.h         |    2 +-
 bsd-user/bsd-file.h           |  168 +++-
 bsd-user/bsd-mem.h            |    4 +-
 bsd-user/bsd-proc.h           |   26 +-
 bsd-user/bsd-signal.h         |  231 ++++++
 bsd-user/bsd-socket.c         |   98 +++
 bsd-user/bsd-socket.h         |  283 +++++++
 bsd-user/freebsd/meson.build  |    8 +-
 bsd-user/freebsd/os-extattr.c |  118 +++
 bsd-user/freebsd/os-extattr.h |  661 ++++++++++++++++
 bsd-user/freebsd/os-file.h    |  129 ++++
 bsd-user/freebsd/os-misc.h    |  466 +++++++++++-
 bsd-user/freebsd/os-proc.c    |    4 +-
 bsd-user/freebsd/os-proc.h    |   26 +-
 bsd-user/freebsd/os-signal.h  |   20 +
 bsd-user/freebsd/os-socket.c  |  239 ++++++
 bsd-user/freebsd/os-socket.h  |  429 +++++++++++
 bsd-user/freebsd/os-sockopt.h |  316 ++++++++
 bsd-user/freebsd/os-stat.h    |    8 +-
 bsd-user/freebsd/os-sys.c     |    4 +-
 bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
 bsd-user/freebsd/os-thread.c  | 1684 +++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
 bsd-user/freebsd/os-time.c    |  347 +++++++++
 bsd-user/freebsd/os-time.h    |  989 ++++++++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |   48 ++
 bsd-user/i386/target.h        |    2 +-
 bsd-user/main.c               |   38 +-
 bsd-user/meson.build          |    1 +
 bsd-user/qemu-bsd.h           |   53 +-
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  458 +++++++++--
 bsd-user/x86_64/target.h      |    2 +-
 37 files changed, 8161 insertions(+), 210 deletions(-)
---
base-commit: 3b50303f9563a42538a1fd5c0ea7f952e23016e1
change-id: 20260504-misc-2026q2-a5af31ac032a

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E43C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgQ-0001oE-57; Tue, 18 Aug 2026 19:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgO-0001nc-CE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgL-0005Bt-CU
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:28 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7f3ece23165so324287a34.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097443; x=1787702243;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vDzbWax6ejw0HlRC5cXJ6Ial9QpACKadKoRXkQg2aaw=;
 b=wN5tC+SPCYe+kzV/DKWSrl0uZa1vMCa1MJq9OlF7GnL5tnsLk6jLrs/unNVPrkA5c2
 7eH6W7R8X/Nxl87Bf95ExuVST1tGj3P0hCvf9YQqP2n0eMzaCfxEFlOdrvu43VRvQEBg
 9v50714z/rGqhIlcPOJXWtRy1L81dQDa4O596Q9gMVWVakxBMNMhv1MJ6RL3s2WOCJm2
 hfGchrAXh5v3hkYC3irxgHUzbpvokVnstm5BBiM2iypVLt2P+GCIcWGncaivFbUefx1Y
 aztm5euCQ7sLKNOuxDr6gzGkcRhY5xxi8yodVSVJpry5jXnCUBi9hPoelK4tNfgUYtly
 v7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097443; x=1787702243;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vDzbWax6ejw0HlRC5cXJ6Ial9QpACKadKoRXkQg2aaw=;
 b=MYl9Q7BxFDpnIFqBgqTA8IfeS/FM74qcn8e24Lg4lTG+i7ya59yVaHfyV50KcCuP1N
 JlzPEn8Z/diHFDwszQm76Th0acfmrxy4M14JsAQUaHQBHAdwsfXTBS3O9WJ2PJwgZOx/
 9Y9QQ2biw5jTg8J5jaagLRL4dK0gGp2RvjsCvdfBhxQb90dz6W8kkGX56OHNIa2jD3tz
 YdbgcYBDec76KoN49wRVXfDGRbiRLSZyBEAPg8hZkxnKHb0V15pwRYswrI6Cz0op1MW/
 mssMmeN8N0nEMUSSWjs1TmStUpAhuQ/eJ03mLS2uXoiOcmsCOsWAFsC9sC5LeQxZhR/D
 s/Eg==
X-Gm-Message-State: AOJu0Yz/vV6iyZkXFM6l8MtWMKABojrvobDzR/Cj1hRWP1GVH56KrXNJ
 6Sw0/db9urtoF0tpzmM0JZyy/bkGhxVk/EwNv87FKhsctWF3XeH0QEGfbTnFVORBGhc=
X-Gm-Gg: AR+sD13cTgjOpBP4FjnmBnIKKyIiVMl9Q323mJa3M2bu/+n3N8HAsv1nev0hOmpubhS
 29Lb47jZ7jyQAYvLJm5+eF5EsHrnQ29IGbcjNIq998VkwzZ3FOtUw9nfcPJkJfkgkHn+/jvLCkq
 p+bUzL/qYwOjUKEumTuTnqXkQICLE1KDvUx3RsvPoygQYzCuE5NUBU+6aFffsS8YTQpciBhVJ2d
 /J9YfkFnngy1CDwjf33DWMyu2owX/aMeAQoHJ9ZKNd4PEKkVsifbiMhdw9f2nsuulSCMNOmLdNt
 sUiRLPfKgkVkewczRhgn6i5EIE3a9htCPMPdatlXNYGE0T1exQM0kZc0FVHz6B5tmGxotK848YI
 HbCXJRbMYzR6etrzLLrQ/IBC58RrMadTfFcd6lqBy2K7y2Z7yvf1GWxqqYKojlCrL9+MA3djqzL
 IbqGMrtq5NKacgI5W1JJop9cJ+w2piWZeMVO7gCNkj7RWEJTpA8kTzmK3isA==
X-Received: by 2002:a05:6808:1918:b0:4a4:c12:46f6 with SMTP id
 5614622812f47-4b2bc8855a9mr449576b6e.2.1787097442858; 
 Tue, 18 Aug 2026 16:57:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v4 00/40] bsd-user: Upstream most of the remaining system calls
Date: Tue, 18 Aug 2026 17:55:53 -0600
Message-Id: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvxhGoC/2XNywrCMBCF4VeRrI0kk4vFle8hLqa52Cx6MZGgl
 L67aRE0uDwD3z8zSS4Gl8hpN5PockhhHMqQ+x0xHQ43R4MtmwADzRSTtA/J0HXdgaJCLzgaJgB
 JEVN0Pjy32uVadhfSY4yvLZ75ev10uKo6mVNGlRSNQclbOOK5TTb008GMPVlDGX5xU2MoWBuuv
 ZOyEYz/YfHFGliNRcFeGwcCbWNt/XlZljdzuUyTIQEAAA==
X-Change-ID: 20260504-misc-2026q2-a5af31ac032a
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11090; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=qqIyJ7MeI4iQBQMOF83O7alI/1djli3btMc3XjhnOqI=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEXm6s02HvOn04A0ZH3vEt4cyml4lJtPB8t9
 4QMwcG7baeJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxFxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBZfw/+OdEHKeTHZ1qJZHy/Cn3z0hSYYlFgH6e
 7/VJlKK8ZpalDqQA/JXCwFucFK4cNgBbznOLjZ4cgWB3eDbIHV+T10kk207kvEkqbVsvUBirlLI
 m68gBya8/frD41uRHG1e9766huP3ay2zGrO4/x/kuNxaQ2622F3f4kS7rGiVjd4rmWEcFbabw1V
 qhlstJblX5j2Qk/HyvYStTRnaB6cwey96DKWYZl/KsIW5Q0vRCTdm85ZsxRwrf78AU1XxL/0TSj
 je3hPGr12hUDRKgYch1E9v6BGaGSL4auOa350HxSmEzvwaF8W6VHEeQC4tPCokx0EA5cFMxnj7o
 0MX8Ho0IBdHhYJcsK5JM4lVCxEZv9osCeUVrSzOyx/xVVi6X3UwTsJxgsantJQQfJaCL9Mq1ga8
 mvlj6Rpw2tvSgkCjECselLK2M3dLDQMymT451qoVBI6EK+MIr/ytRjAGH7kzoT1boAJ/IMtiZi8
 eCEreEoytOFRnbx9cNjpVsQ1iakuDk1NE4gFH1aJWdREbjvcq0ubSpSGfTEQQjVOl9SKOW6MAJv
 MvKm4MDqsmLcB9q+Nc+W6MHq8kxbWY8zG/0S7R5u8OF8cCaEpss0BaO21hRKwaBnRjUAuoV6GkB
 1DPd/lhuRdnSctv3CP7CJypK9V/yfubFCLMhmMieGTx1XR/SIfOI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

In v4, I've rebased to post 11.1.0 master, and fixed the issues that
were highlighted in the last review. Some comments I rejected, for now,
since they were refactoring code that's hard to test. I've also juggled
many patch hunks between revisions so they all compile w/o warnings.

I've created annotation in FreeBSD to allow us, in the future, to
generate os-sockopt.h from the installed headers. It will take a while
for that to work its way into all the supported releases, so in the mean
time I'm committing the generated os-sockopt.h file. I've ignored the
too-long-line warnings and errors for this file because there's no
reason for this file to conform to style.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v4:
- Fix the rebase errors in v3.
- Rebase to post 11.1.0.
- Fix overly large chunking with syscalls-defs.h by breaking it up
- Tweak syscalls-defs.h with an eye toward diff reduction to blitz
- Break out realpath fix
- Various chunks shuffled to make each patch compile w/o warnings
- better get/setsockopt implementaiton
- Link to v3: https://lore.kernel.org/qemu-devel/20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com

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
 bsd-user/freebsd/os-socket.h  |  428 +++++++++++
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
 bsd-user/qemu-bsd.h           |    8 +
 bsd-user/qemu.h               |   48 +-
 bsd-user/riscv/target.h       |    2 +-
 bsd-user/signal-common.h      |    4 +
 bsd-user/signal.c             |   67 ++
 bsd-user/syscall_defs.h       |  449 +++++++++--
 bsd-user/x86_64/target.h      |    2 +-
 37 files changed, 8110 insertions(+), 206 deletions(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260504-misc-2026q2-a5af31ac032a

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581E0C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLxP-0005v5-Pg; Wed, 26 Aug 2026 18:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wzLxM-0005uw-Su
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:18:52 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wzLxI-0000OA-9E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:18:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1007308a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787782725; cv=none;
 d=google.com; s=arc-20260327;
 b=CwI4QbEa7K6teyoeX93b/CGHrURw0vXo2DllVXjU5nKu7lCa/M4qpuWs+/NEgbEe6+
 nNHmnYKXPKUx5pbJLzuRCwedK/Xjq1xSEed5Ud6saTPoBLM/4IrN9UjpoPlNhKAi3J2n
 vnl1Pf+CywYLlcWjFceKPVWdNSDbIUXbRDG4J+EtDmkIE8CpCHaMToMtIecEAMYlYfGH
 YiOv7G8uP5CSlmiB+yb+k0VhhvOmCnUMSrp/Tly8lBu1pqskUhv2ShJ4Cd/aNr3u2Lxl
 wt5hgDPw8iEG0GBcPZ8sNM2vh1z77JoEE0ARNV25oQcPs0Hd45O9+8z0TvQJnqiYGMJP
 xJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pazCzgnz/BolSPcW4/0eV+WHf9UYgIIbs8A9+wb+Rmo=;
 fh=Zb6draePAoDpRZqj1uLkIq0LGB3ii0JBn/cgwcUXnl8=;
 b=Yz6WvhYk26FuXQVSpbp+M1Vdbk+J7mCJ4NjWXNWdLIvCGSYH7+opfptI7z3nBmO49X
 cB73/65LCwhY/cHCN1C9rXwVDSxhOPI3AwTvUt0ZRaDNeblNQO+6eZbEVrpt7v8RRy+F
 +ixwznLqh236U3lr1xggnqvIyJgw4KPXMwBxdPzQ/WNKRZQWXJo9Qxxvzpu8IOiRlwXB
 udDtSfXXpE0l74EmhAudRynSYTjxG+u/HceKqxolPH2nXM+OaGzwiCd05e/M/cfPbOqs
 ewxm1qOt+V9ZRzCJVjwUVMiczOk3uV37pfN03takCRx6g5rhdJjJ5/CyM/5b44AW1fms
 /nQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787782725; x=1788387525;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pazCzgnz/BolSPcW4/0eV+WHf9UYgIIbs8A9+wb+Rmo=;
 b=BfHXF7EfSO0q3EPHyR4+swWBYmAp1i4M/aGy32peMGSK0HyT8xCj//SyAY+7FJthlY
 TUudcdfQ5HRtE3J35vWV1NrLrB+wmXDEdhtHcAzrlnnyHo3e+iMXfBaMmAdrBrMaUDSv
 JPqRkrOEB/VwaNbPrlGGYB+nXTfNchDLq8lqf7UFizIFEhiCo/hGNReHgpaA9/Iu8Eii
 f4fOlnv+HyA2NPGDsYe84imhtSP2VF+/cXAyBNbefhXzNz5SqWUlsPdSBhrsXX0ZKTtQ
 ZgMqV9I8A1i+RpEbRqPQzJtdc8T5xYKt3KLM56b7MiAdGyWVpE44zD4gm/+cA7hSJ4Qk
 hmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782725; x=1788387525;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pazCzgnz/BolSPcW4/0eV+WHf9UYgIIbs8A9+wb+Rmo=;
 b=aowBAIGfWEWHrQYydMJp4+rd9zlvbGuo4eZMlh8WPe7LUkFrChWdtGxwJ3i1nuNjfi
 uUpKq0MZZkAdRhyx17YSfPknXj5zaIaYPFxrnCEFF7Ze4FMG9jgCkgVN2/QTxC9oTS71
 dMy1bwOzGqiOiLATK8xnbADyC701b1JUgHZxnZRARr0WcOGJL9PGasbuGyMu9ckWV0v+
 qWXcT2kuj8tEJRrQJe+AogIn+ET8x8eaPutDyl0bwfmiV4c4CYAYYdMd1xgJpo9Lnz3M
 yoUbTFmGH8eXcD+pUMeV0Ksd2XBs01VpMJlfZdnNAaJixh5EPEjdTKlut2DEci5jLv4i
 GuOA==
X-Gm-Message-State: AFuF++nFs30CH7cEyPFjXAH10mU7BFSLkhX/Ye6tfwhTH5d4927AU0xs
 sBJyYpSZj1m39eDHyS65jkdvGl0dHBTeOEM9A0wRcjjLFirApGi+v5vFpW/H36S3Td08x9VJBMY
 Ns817Ou9PaB7dtsL3YH3XlA2dVgvFzjSc7GnADha01tgYfvjfXM4R+ypY/Q==
X-Gm-Gg: AR+sD13xdx1Ik5PyBSemYDacnmsIrMLH1OiZeiBnK2F3LRwMnGUqcKOtbtxWVd4E/C/
 oip1eL/sE1o6dHetiKAccIL7etjQ9jxVftPhvb4VzMOP9pL0WbPn3VhCMGkMPK180jwjyXtGHLO
 4ZRP6u91onvL/Jq0jtceQAjuKycFG9HBmnKpAWgmyOuu27Tdlnrrwwm+ZSlorK9mt4C2gk7hT+2
 q+VxEht7wUt/CKiuhOo4TXd1B8ryFQJqC0/8H7yh4GxQdwYKDCbyOAB24wbfrhd+4MGf/iH88Aq
 P1gwZumrRtoXNH8pPDQ6vBs4IYq/VZIWxqnE4RkGvCbI
X-Received: by 2002:a17:90a:dfd0:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3966d3a8f3amr22309615a91.8.1787782725298; Wed, 26 Aug 2026
 15:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 26 Aug 2026 16:18:34 -0600
X-Gm-Features: AcwNN1WKcH2BQ-SIVmn-o8un79htZ8AKWpNtv_vJWlSZpuAygL_SEfIpWtZEVXA
Message-ID: <CANCZdfo9q2uO-WiJwT-=GSr1AwY_q0hMOLgtrO3ht5SriHc29A@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] bsd-user: Upstream most of the remaining system
 calls
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Stacey Son <sson@freebsd.org>, Richard Henderson <richard.henderson@linaro.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Michal Meloun <mmel@freebsd.org>, Sean Bruno <sbruno@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000004706210659fa9a79"
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004706210659fa9a79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First off, I'd like to express my appreciations for the reviews so far on
this this series. Thank you!

I have a process question. All the hunks in this series have a 'Acked-by'
or 'Reviewed-by' but many lack the former. The 'Acked-by' was made by a
linux-user maintainer, for which I'm thankful. I've not seen that situation
in the past, however. Can I submit a pull request for these now? Or after a
'last call' timeout? or ???? What do other people do in this situation?

My sense is that I should send the pull request next Monday unless I hear a
different process is needed, but this situation is new to me. Hopefully we
can finish the upstremaing and get down to finding problems this year...

Warner

P.S. Here's the reviews if people want to take a look

5ba005f276 bsd-user: Move qemu_guest_random_seed_main to same as linux-user
88c18b67bd bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
4ae84b60a1 bsd-user: Add scheduler and cpuset functions to os-misc.h
a98b79dfe7 bsd-user: Add extended attribute and ACL system call dispatch
9bbf55515f bsd-user: Add os-extattr.c with ACL conversion functions
fe9d66a6ec bsd-user: Add ACL system call shims to os-extattr.h
82064bbab0 bsd-user: Add link and list extattr functions to os-extattr.h
75e914ff07 bsd-user: Add os-extattr.h with file and fd extattr functions
67cd851633 bsd-user: Add thread system call dispatch
3fd3341c72 bsd-user: Add do_freebsd__umtx_op to os-thread.h
b575132a65 bsd-user: Add os-thread.h with thr and context functions
93bd8d0a5d bsd-user: Add os-time.c and time-related type definitions
8e416aaed4 bsd-user: Add kqueue and kevent functions to os-time.h
49de927cc2 bsd-user: Add select, pselect, and ppoll to os-time.h
f531e09821 bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
b81c83d983 bsd-user: Implement both getsockopt and setsockopt
d41005b6ab bsd-user: Commit the generated os-sockopt.h files


On Tue, Aug 18, 2026 at 5:57=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

> Upstream the file, thread, socket and remaining signal system calls (too
> numerous to list here).
>
> This series is an ambitous use of claude to help me upstream all the
> remaining system calls. I've batched them together in what I think are
> reasonable chunks, and had claude do the grunt work of copying the code
> over and attributing the commits from our complex branching history. The
> chopping up was a bit arbitrary, but I think it's good. The commit
> messages may be a little weak, but may also be OK. I've also double
> checked the style and made fixes upstream for them as well. Claude also
> reviewed all these changes and found a few bugs that I've fixed. I've
> personally read through them all and haven't found anything glaring. I
> fixed all the bugs that were found, in most cases differently than
> claude's suggestions.
>
> I've added 'Assisted-by: Claude...' to all these commits to reflect my
> leaning on Claude so hard. This use falls within the 'non-creative' use
> that the Qemu project has said is OK. If that's not the right thing to
> do, I can remove them.
>
> This leaves sysctl translation, the powerpc architecture support,
> coredumps and a transition to 'truss' based system call tracing. With
> these changes applied we'er down from a high of about 30k lines of diffs
> to only 5k (not counting genereted, but checked in files in blitz). The
> changes are 8k, so maybe a bit ambitious from that perspective as well.
>
> There's a few lines over 80 that I've not cleaned up. Let me know if
> that's a problem. The other warnings are about adding files, and there's
> no new MAINTAINERS entry needed. And the 'arch dependent defines should
> be avoided' are needed to cope with different FreeBSD build systems
> having different system calls.
>
> Note, this is called out below too, but in v2 I've folded back all the
> fixes based on some out-of-band feedback I recieved to do this the
> normal way and the qemu project isn't interested in the fixes to fixes.
>
> Note that in v3 I've added a rather long generated file. I generated it
> automatically looking at the type annocations in FreeBSD on the socket
> options in comments. I had to augment the annotations, so I can't just
> generate it within the build from the installed headers until it's
> merged from head and then merges to stable branches and then waiting for
> a release on each of them (6-9 months given FreeBSD's release schedule).
> Also note: there's a couple left over issues from v2, so if I've not
> taken care of them all, please gently remind me if you think action
> is still needed after my comments before.
>
> And in v3 I've added some random_seed fixes for fork/new threads
> since we're upstreaming those files. These should be correct now,
> but I'm looking for the correction.
>
> In v4, I've rebased to post 11.1.0 master, and fixed the issues that
> were highlighted in the last review. Some comments I rejected, for now,
> since they were refactoring code that's hard to test. I've also juggled
> many patch hunks between revisions so they all compile w/o warnings.
>
> I've created annotation in FreeBSD to allow us, in the future, to
> generate os-sockopt.h from the installed headers. It will take a while
> for that to work its way into all the supported releases, so in the mean
> time I'm committing the generated os-sockopt.h file. I've ignored the
> too-long-line warnings and errors for this file because there's no
> reason for this file to conform to style.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Changes in v4:
> - Fix the rebase errors in v3.
> - Rebase to post 11.1.0.
> - Fix overly large chunking with syscalls-defs.h by breaking it up
> - Tweak syscalls-defs.h with an eye toward diff reduction to blitz
> - Break out realpath fix
> - Various chunks shuffled to make each patch compile w/o warnings
> - better get/setsockopt implementaiton
> - Link to v3:
> https://lore.kernel.org/qemu-devel/20260620-misc-2026q2-v3-0-f6ce23ad8dda=
@bsdimp.com
>
> Changes in v3:
> - refactor get/setsockopt, including new generated file
> - add random_seed fixes to fork
> - move adding of .c files to meson.build to where we add the file.
> - Fix acl bounds checking
> - Fix indentation and other misc nits
> - copy_to/from_user needs to be abi_long
> - Fix toggling of the _ at the end of BSD_PROC_H
> - Fix leak in error paths in do_freebsd_ktimer_create
> - Don't write back on ktimer_gettime errors
> - Be more careful about EINTR returns
> - do_freebsd_ntp_adjtime needs to return failures from h2t_freebsd_timex
> - do_freebsd_ktimer_gettime shouldn't writeback on error
> - t2h_freebsd_umtx_time needs to unlock_user on error path
> - Prefer abi_long for all pointers in extattr
> - Remove accidentally duplicated prototypes.
> - Don't writeback the eventlist, we're just reading it
> - Add missing 'do' to the macro
> - Byte swap sival_ptr in convertion
> - Add missing get_errno call to safe___umtx_op
> - Don't write back if getsockopt fails
> - Write back correct number of bytes for do_bsd_recvfrom
> - Loop through cnt, not maxcnt for acl conversion
> - Fix getsockopt size computation
> - Return ret, not errno, since do_freebsd_new_thr doesn't touch errno
> - Fixed off by one in connectat: we need the bug compat fix here too
> - Fixed error in preadv: copy params backwards
> - Link to v2:
> https://lore.kernel.org/qemu-devel/20260518-misc-2026q2-v2-0-6c16fe448301=
@bsdimp.com
>
> Changes in v2:
> - don't write offsets on errors for copy_file_range
> - pipe2: Check the raw system call value directly
> - setsockopt: Check target_to_host_ip_mreq return value
> - <several places>: Check return value of host_to_target_sockaddr
> - do_bsd_setsockopt: Read in the socket option
> - ntp_gettime: write back time on non-errors, not just 0
> - do_freebsd_sigtimedwait check t2h_freebsd_timespec return
> - do_freebsd_swapcontext writing incorrectly, readonly data (0 to
> user_unlock)
> - do_thr_set_name needs get_errno()
> - Have ntp_adjtime write back the structure
> - kevent_freebsd11 no need to explicitly mask, datatypes do this for us
> - do_freebsd_setcontext just reads the mcontext, 0 in unlock_user
> - target_to_host_sigevent is read-only, so pass 0 in unlock_user
> - target_to_host_ip_mreq needs tswap32 for int32_t
> - use get_errno on kenv return values to report errors better
> - kevent: only copy the number of events returns, not whole buffer
> - Copy tolerance field of timex
> - freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct
> - Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED
> - Fixed additional missing unlock in freebsd_rw_rdlock and
> freebsd_rw_wrlock in !_UMTX_OPTIMIZED
> - Squashed all the bug commit back to the appropriate earleir patch
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a=
@bsdimp.com
>
> ---
> Warner Losh (40):
>       bsd-user: Rename cpu_env to env throughout bsd-user
>       bsd-user: Fix copy direciton in preadv
>       bsd-user: Add bsd-signal.h with sigaction through sigreturn
>       bsd-user: Add signal shims sigwait through kill and os-signal.h
>       bsd-user: Add signal system call dispatch
>       bsd-user: move sys/shm.h lines
>       bsd-user: Remove mmap defines
>       bsd-user: Use target_suseconds_t
>       bsd-user: Move sys/uuid.h defines
>       bsd-user: Fix realpathat for FreeBSD 15.0 and newer
>       bsd-user: Add os-file.h with chflagsat, close_range, and more
>       bsd-user: Add poll, poll2, lseek, pipe, and swap system call shims
>       bsd-user: Add FreeBSD socket helpers and sockaddr conversion
>       bsd-user: Add bsd-socket.h with bind through getsockname
>       bsd-user: Add socket shims socketpair through shutdown
>       bsd-user: Commit the generated os-sockopt.h files
>       bsd-user: Implement both getsockopt and setsockopt
>       bsd-user: Add FreeBSD socket system calls
>       bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg
>       bsd-user: Add socket system call dispatch
>       bsd-user: Add os-time.h with clock and time-of-day functions
>       bsd-user: Add utimes, futimes, and ktimer functions to os-time.h
>       bsd-user: Add select, pselect, and ppoll to os-time.h
>       bsd-user: Add kqueue and kevent functions to os-time.h
>       bsd-user: Add sigtimedwait, itimer, and futimens to os-time.h
>       bsd-user: Add os-time.c and time-related type definitions
>       bsd-user: Add time system call dispatch
>       bsd-user: Add cpu_copy and make init_task_state non-static
>       bsd-user: Add os-thread.h with thr and context functions
>       bsd-user: Add do_freebsd__umtx_op to os-thread.h
>       bsd-user: Add thread system call dispatch
>       bsd-user: Add os-extattr.h with file and fd extattr functions
>       bsd-user: Add link and list extattr functions to os-extattr.h
>       bsd-user: Add ACL system call shims to os-extattr.h
>       bsd-user: Add os-extattr.c with ACL conversion functions
>       bsd-user: Add extended attribute and ACL system call dispatch
>       bsd-user: Add scheduler and cpuset functions to os-misc.h
>       bsd-user: Add scheduler, cpuset, kmod, and misc syscall dispatch
>       bsd-user: Move qemu_guest_random_seed_main to same as linux-user
>       bsd-user Update random_seed on thread creation
>
>  bsd-user/aarch64/target.h     |    2 +-
>  bsd-user/arm/target.h         |    2 +-
>  bsd-user/bsd-file.h           |  168 +++-
>  bsd-user/bsd-mem.h            |    4 +-
>  bsd-user/bsd-proc.h           |   26 +-
>  bsd-user/bsd-signal.h         |  231 ++++++
>  bsd-user/bsd-socket.c         |   98 +++
>  bsd-user/bsd-socket.h         |  283 +++++++
>  bsd-user/freebsd/meson.build  |    8 +-
>  bsd-user/freebsd/os-extattr.c |  118 +++
>  bsd-user/freebsd/os-extattr.h |  661 ++++++++++++++++
>  bsd-user/freebsd/os-file.h    |  129 ++++
>  bsd-user/freebsd/os-misc.h    |  466 +++++++++++-
>  bsd-user/freebsd/os-proc.c    |    4 +-
>  bsd-user/freebsd/os-proc.h    |   26 +-
>  bsd-user/freebsd/os-signal.h  |   20 +
>  bsd-user/freebsd/os-socket.c  |  239 ++++++
>  bsd-user/freebsd/os-socket.h  |  428 +++++++++++
>  bsd-user/freebsd/os-sockopt.h |  316 ++++++++
>  bsd-user/freebsd/os-stat.h    |    8 +-
>  bsd-user/freebsd/os-sys.c     |    4 +-
>  bsd-user/freebsd/os-syscall.c |  790 +++++++++++++++++--
>  bsd-user/freebsd/os-thread.c  | 1684
> +++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-thread.h  |  596 +++++++++++++++
>  bsd-user/freebsd/os-time.c    |  347 +++++++++
>  bsd-user/freebsd/os-time.h    |  989 ++++++++++++++++++++++++
>  bsd-user/freebsd/qemu-os.h    |   48 ++
>  bsd-user/i386/target.h        |    2 +-
>  bsd-user/main.c               |   38 +-
>  bsd-user/meson.build          |    1 +
>  bsd-user/qemu-bsd.h           |    8 +
>  bsd-user/qemu.h               |   48 +-
>  bsd-user/riscv/target.h       |    2 +-
>  bsd-user/signal-common.h      |    4 +
>  bsd-user/signal.c             |   67 ++
>  bsd-user/syscall_defs.h       |  449 +++++++++--
>  bsd-user/x86_64/target.h      |    2 +-
>  37 files changed, 8110 insertions(+), 206 deletions(-)
> ---
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> change-id: 20260504-misc-2026q2-a5af31ac032a
>
> Best regards,
> --
> Warner Losh <imp@bsdimp.com>
>
>

--0000000000004706210659fa9a79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">First off, I&#39;d like to express my appreciations for th=
e reviews so far on this this series. Thank you!<div><br></div><div>I have =
a process question. All the hunks in this series have a &#39;Acked-by&#39; =
or &#39;Reviewed-by&#39; but many lack the former. The &#39;Acked-by&#39; w=
as made by a linux-user maintainer, for which I&#39;m thankful. I&#39;ve no=
t seen that situation in the past, however. Can I submit a pull request for=
 these now? Or after a &#39;last call&#39; timeout? or ???? What do other p=
eople do in this situation?</div><div><br></div><div>My sense is that I sho=
uld send the pull request next Monday unless I hear a different process is =
needed, but this situation is new to me. Hopefully we can finish the upstre=
maing and get down to finding problems this=C2=A0year...</div><div><br></di=
v><div>Warner</div><div><br></div><div>P.S. Here&#39;s the reviews if peopl=
e want to take a look</div><div><br></div><div>5ba005f276 bsd-user: Move qe=
mu_guest_random_seed_main to same as linux-user<br>88c18b67bd bsd-user: Add=
 scheduler, cpuset, kmod, and misc syscall dispatch<br>4ae84b60a1 bsd-user:=
 Add scheduler and cpuset functions to os-misc.h<br>a98b79dfe7 bsd-user: Ad=
d extended attribute and ACL system call dispatch<br>9bbf55515f bsd-user: A=
dd os-extattr.c with ACL conversion functions<br>fe9d66a6ec bsd-user: Add A=
CL system call shims to os-extattr.h<br>82064bbab0 bsd-user: Add link and l=
ist extattr functions to os-extattr.h<br>75e914ff07 bsd-user: Add os-extatt=
r.h with file and fd extattr functions<br>67cd851633 bsd-user: Add thread s=
ystem call dispatch<br>3fd3341c72 bsd-user: Add do_freebsd__umtx_op to os-t=
hread.h<br>b575132a65 bsd-user: Add os-thread.h with thr and context functi=
ons<br>93bd8d0a5d bsd-user: Add os-time.c and time-related type definitions=
<br>8e416aaed4 bsd-user: Add kqueue and kevent functions to os-time.h<br>49=
de927cc2 bsd-user: Add select, pselect, and ppoll to os-time.h<br>f531e0982=
1 bsd-user: Add utimes, futimes, and ktimer functions to os-time.h<br>b81c8=
3d983 bsd-user: Implement both getsockopt and setsockopt<br>d41005b6ab bsd-=
user: Commit the generated os-sockopt.h files</div><div><br></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Aug 18, 2026 at 5:57=E2=80=AFPM Warner Losh &lt;<a hre=
f=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Upstream the file, thread, socket=
 and remaining signal system calls (too<br>
numerous to list here).<br>
<br>
This series is an ambitous use of claude to help me upstream all the<br>
remaining system calls. I&#39;ve batched them together in what I think are<=
br>
reasonable chunks, and had claude do the grunt work of copying the code<br>
over and attributing the commits from our complex branching history. The<br=
>
chopping up was a bit arbitrary, but I think it&#39;s good. The commit<br>
messages may be a little weak, but may also be OK. I&#39;ve also double<br>
checked the style and made fixes upstream for them as well. Claude also<br>
reviewed all these changes and found a few bugs that I&#39;ve fixed. I&#39;=
ve<br>
personally read through them all and haven&#39;t found anything glaring. I<=
br>
fixed all the bugs that were found, in most cases differently than<br>
claude&#39;s suggestions.<br>
<br>
I&#39;ve added &#39;Assisted-by: Claude...&#39; to all these commits to ref=
lect my<br>
leaning on Claude so hard. This use falls within the &#39;non-creative&#39;=
 use<br>
that the Qemu project has said is OK. If that&#39;s not the right thing to<=
br>
do, I can remove them.<br>
<br>
This leaves sysctl translation, the powerpc architecture support,<br>
coredumps and a transition to &#39;truss&#39; based system call tracing. Wi=
th<br>
these changes applied we&#39;er down from a high of about 30k lines of diff=
s<br>
to only 5k (not counting genereted, but checked in files in blitz). The<br>
changes are 8k, so maybe a bit ambitious from that perspective as well.<br>
<br>
There&#39;s a few lines over 80 that I&#39;ve not cleaned up. Let me know i=
f<br>
that&#39;s a problem. The other warnings are about adding files, and there&=
#39;s<br>
no new MAINTAINERS entry needed. And the &#39;arch dependent defines should=
<br>
be avoided&#39; are needed to cope with different FreeBSD build systems<br>
having different system calls.<br>
<br>
Note, this is called out below too, but in v2 I&#39;ve folded back all the<=
br>
fixes based on some out-of-band feedback I recieved to do this the<br>
normal way and the qemu project isn&#39;t interested in the fixes to fixes.=
<br>
<br>
Note that in v3 I&#39;ve added a rather long generated file. I generated it=
<br>
automatically looking at the type annocations in FreeBSD on the socket<br>
options in comments. I had to augment the annotations, so I can&#39;t just<=
br>
generate it within the build from the installed headers until it&#39;s<br>
merged from head and then merges to stable branches and then waiting for<br=
>
a release on each of them (6-9 months given FreeBSD&#39;s release schedule)=
.<br>
Also note: there&#39;s a couple left over issues from v2, so if I&#39;ve no=
t<br>
taken care of them all, please gently remind me if you think action<br>
is still needed after my comments before.<br>
<br>
And in v3 I&#39;ve added some random_seed fixes for fork/new threads<br>
since we&#39;re upstreaming those files. These should be correct now,<br>
but I&#39;m looking for the correction.<br>
<br>
In v4, I&#39;ve rebased to post 11.1.0 master, and fixed the issues that<br=
>
were highlighted in the last review. Some comments I rejected, for now,<br>
since they were refactoring code that&#39;s hard to test. I&#39;ve also jug=
gled<br>
many patch hunks between revisions so they all compile w/o warnings.<br>
<br>
I&#39;ve created annotation in FreeBSD to allow us, in the future, to<br>
generate os-sockopt.h from the installed headers. It will take a while<br>
for that to work its way into all the supported releases, so in the mean<br=
>
time I&#39;m committing the generated os-sockopt.h file. I&#39;ve ignored t=
he<br>
too-long-line warnings and errors for this file because there&#39;s no<br>
reason for this file to conform to style.<br>
<br>
Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"=
_blank">imp@bsdimp.com</a>&gt;<br>
---<br>
Changes in v4:<br>
- Fix the rebase errors in v3.<br>
- Rebase to post 11.1.0.<br>
- Fix overly large chunking with syscalls-defs.h by breaking it up<br>
- Tweak syscalls-defs.h with an eye toward diff reduction to blitz<br>
- Break out realpath fix<br>
- Various chunks shuffled to make each patch compile w/o warnings<br>
- better get/setsockopt implementaiton<br>
- Link to v3: <a href=3D"https://lore.kernel.org/qemu-devel/20260620-misc-2=
026q2-v3-0-f6ce23ad8dda@bsdimp.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/qemu-devel/20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsd=
imp.com</a><br>
<br>
Changes in v3:<br>
- refactor get/setsockopt, including new generated file<br>
- add random_seed fixes to fork<br>
- move adding of .c files to meson.build to where we add the file.<br>
- Fix acl bounds checking<br>
- Fix indentation and other misc nits<br>
- copy_to/from_user needs to be abi_long<br>
- Fix toggling of the _ at the end of BSD_PROC_H<br>
- Fix leak in error paths in do_freebsd_ktimer_create<br>
- Don&#39;t write back on ktimer_gettime errors<br>
- Be more careful about EINTR returns<br>
- do_freebsd_ntp_adjtime needs to return failures from h2t_freebsd_timex<br=
>
- do_freebsd_ktimer_gettime shouldn&#39;t writeback on error<br>
- t2h_freebsd_umtx_time needs to unlock_user on error path<br>
- Prefer abi_long for all pointers in extattr<br>
- Remove accidentally duplicated prototypes.<br>
- Don&#39;t writeback the eventlist, we&#39;re just reading it<br>
- Add missing &#39;do&#39; to the macro<br>
- Byte swap sival_ptr in convertion<br>
- Add missing get_errno call to safe___umtx_op<br>
- Don&#39;t write back if getsockopt fails<br>
- Write back correct number of bytes for do_bsd_recvfrom<br>
- Loop through cnt, not maxcnt for acl conversion<br>
- Fix getsockopt size computation<br>
- Return ret, not errno, since do_freebsd_new_thr doesn&#39;t touch errno<b=
r>
- Fixed off by one in connectat: we need the bug compat fix here too<br>
- Fixed error in preadv: copy params backwards<br>
- Link to v2: <a href=3D"https://lore.kernel.org/qemu-devel/20260518-misc-2=
026q2-v2-0-6c16fe448301@bsdimp.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/qemu-devel/20260518-misc-2026q2-v2-0-6c16fe448301@bsd=
imp.com</a><br>
<br>
Changes in v2:<br>
- don&#39;t write offsets on errors for copy_file_range<br>
- pipe2: Check the raw system call value directly<br>
- setsockopt: Check target_to_host_ip_mreq return value<br>
- &lt;several places&gt;: Check return value of host_to_target_sockaddr<br>
- do_bsd_setsockopt: Read in the socket option<br>
- ntp_gettime: write back time on non-errors, not just 0<br>
- do_freebsd_sigtimedwait check t2h_freebsd_timespec return<br>
- do_freebsd_swapcontext writing incorrectly, readonly data (0 to user_unlo=
ck)<br>
- do_thr_set_name needs get_errno()<br>
- Have ntp_adjtime write back the structure<br>
- kevent_freebsd11 no need to explicitly mask, datatypes do this for us<br>
- do_freebsd_setcontext just reads the mcontext, 0 in unlock_user<br>
- target_to_host_sigevent is read-only, so pass 0 in unlock_user<br>
- target_to_host_ip_mreq needs tswap32 for int32_t<br>
- use get_errno on kenv return values to report errors better<br>
- kevent: only copy the number of events returns, not whole buffer<br>
- Copy tolerance field of timex<br>
- freebsd_umtx_sem_wake use VERIFY_READ instead of write to read struct<br>
- Avoid double g2h_untagged mistakes in !_UMTX_OPTIMIZED<br>
- Fixed additional missing unlock in freebsd_rw_rdlock and freebsd_rw_wrloc=
k in !_UMTX_OPTIMIZED<br>
- Squashed all the bug commit back to the appropriate earleir patch<br>
- Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260515-misc-2=
026q2-v1-0-5438ca41b27a@bsdimp.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/qemu-devel/20260515-misc-2026q2-v1-0-5438ca41b27a@bsd=
imp.com</a><br>
<br>
---<br>
Warner Losh (40):<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Rename cpu_env to env throughout bsd-user<br=
>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Fix copy direciton in preadv<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add bsd-signal.h with sigaction through sigr=
eturn<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add signal shims sigwait through kill and os=
-signal.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add signal system call dispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: move sys/shm.h lines<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Remove mmap defines<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Use target_suseconds_t<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Move sys/uuid.h defines<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Fix realpathat for FreeBSD 15.0 and newer<br=
>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-file.h with chflagsat, close_range, a=
nd more<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add poll, poll2, lseek, pipe, and swap syste=
m call shims<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add FreeBSD socket helpers and sockaddr conv=
ersion<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add bsd-socket.h with bind through getsockna=
me<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add socket shims socketpair through shutdown=
<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Commit the generated os-sockopt.h files<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Implement both getsockopt and setsockopt<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add FreeBSD socket system calls<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg=
<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add socket system call dispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-time.h with clock and time-of-day fun=
ctions<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add utimes, futimes, and ktimer functions to=
 os-time.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add select, pselect, and ppoll to os-time.h<=
br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add kqueue and kevent functions to os-time.h=
<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add sigtimedwait, itimer, and futimens to os=
-time.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-time.c and time-related type definiti=
ons<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add time system call dispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add cpu_copy and make init_task_state non-st=
atic<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-thread.h with thr and context functio=
ns<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add do_freebsd__umtx_op to os-thread.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add thread system call dispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-extattr.h with file and fd extattr fu=
nctions<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add link and list extattr functions to os-ex=
tattr.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add ACL system call shims to os-extattr.h<br=
>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add os-extattr.c with ACL conversion functio=
ns<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add extended attribute and ACL system call d=
ispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add scheduler and cpuset functions to os-mis=
c.h<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Add scheduler, cpuset, kmod, and misc syscal=
l dispatch<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user: Move qemu_guest_random_seed_main to same as =
linux-user<br>
=C2=A0 =C2=A0 =C2=A0 bsd-user Update random_seed on thread creation<br>
<br>
=C2=A0bsd-user/aarch64/target.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
=C2=A0bsd-user/arm/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
 2 +-<br>
=C2=A0bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
68 +++-<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 4 +-<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A026 +-<br>
=C2=A0bsd-user/bsd-signal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 231 ++=
++++<br>
=C2=A0bsd-user/bsd-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
98 +++<br>
=C2=A0bsd-user/bsd-socket.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 283 ++=
+++++<br>
=C2=A0bsd-user/freebsd/meson.build=C2=A0 |=C2=A0 =C2=A0 8 +-<br>
=C2=A0bsd-user/freebsd/os-extattr.c |=C2=A0 118 +++<br>
=C2=A0bsd-user/freebsd/os-extattr.h |=C2=A0 661 ++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-file.h=C2=A0 =C2=A0 |=C2=A0 129 ++++<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 |=C2=A0 466 +++++++++++-<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 |=C2=A0 =C2=A026 +-<br>
=C2=A0bsd-user/freebsd/os-signal.h=C2=A0 |=C2=A0 =C2=A020 +<br>
=C2=A0bsd-user/freebsd/os-socket.c=C2=A0 |=C2=A0 239 ++++++<br>
=C2=A0bsd-user/freebsd/os-socket.h=C2=A0 |=C2=A0 428 +++++++++++<br>
=C2=A0bsd-user/freebsd/os-sockopt.h |=C2=A0 316 ++++++++<br>
=C2=A0bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 +-<br>
=C2=A0bsd-user/freebsd/os-sys.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +-<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 790 +++++++++++++++++--<br>
=C2=A0bsd-user/freebsd/os-thread.c=C2=A0 | 1684 +++++++++++++++++++++++++++=
++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-thread.h=C2=A0 |=C2=A0 596 +++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-time.c=C2=A0 =C2=A0 |=C2=A0 347 +++++++++<br>
=C2=A0bsd-user/freebsd/os-time.h=C2=A0 =C2=A0 |=C2=A0 989 +++++++++++++++++=
+++++++<br>
=C2=A0bsd-user/freebsd/qemu-os.h=C2=A0 =C2=A0 |=C2=A0 =C2=A048 ++<br>
=C2=A0bsd-user/i386/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-=
<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A038 +-<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
 1 +<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 8 +<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A048 +-<br>
=C2=A0bsd-user/riscv/target.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-=
<br>
=C2=A0bsd-user/signal-common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +<br>
=C2=A0bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A067 ++<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 449 +++++++=
++--<br>
=C2=A0bsd-user/x86_64/target.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A037 files changed, 8110 insertions(+), 206 deletions(-)<br>
---<br>
base-commit: fa19879df1658f96ac07365fca8835b7decd6995<br>
change-id: 20260504-misc-2026q2-a5af31ac032a<br>
<br>
Best regards,<br>
-- <br>
Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsd=
imp.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000004706210659fa9a79--


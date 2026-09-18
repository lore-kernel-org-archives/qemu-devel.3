Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36C3C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Q9x-0005IZ-Lp; Fri, 18 Sep 2026 00:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9v-0005IA-B3
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:11 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9s-00048t-NH
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:11 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0c89e34so161521a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705507; x=1790310307;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J/h3STy+hIoD9XGwPI5r+WxUjiLVU9Cwz+/LY5vQ0V0=;
 b=s5k894mQ586K0nmvAlRKP/EEdZcUde+YBn/4uBPgyqWc9k2wf5g1WUQCzn1uykYXy0
 U5qlMhaxszg4P3/Dm+J7FQRsYEk6Oz06siKtfeGIiGawq0sDj6Xdkhj6HiD/Yzt6tIya
 i8OjjFAktkn5OCR7F3aqm7i9n5PqIE0baDV8XSmV5VH/d4xJbPxT4HZ9faJG8HXgTtDR
 qLz4yg0s/d4v9HJmUCT/KIOhLVfKI1HweeZKGkDM7s5xCiaAC9PDyFEPdHfOy34+ud8Z
 UGkAwv2aagTYQ2dlMXG79n2idHA60cVOx9xscekws0/IdXdDjiXsTJrICXGqHzr75HRB
 B2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705507; x=1790310307;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J/h3STy+hIoD9XGwPI5r+WxUjiLVU9Cwz+/LY5vQ0V0=;
 b=YD8FVfFvrw/mDXe53KDZvwU8F6CrMw4P4p/PmhBEXCnzsoNmYjVtHaaSkLGegX4GbK
 XQy1iyrLzkQKapDDQvUpAtpKvcAaub5Yf40ggosfyrDOJ91lrnboM0mjCfGHLgjBAKRc
 APjiC+ZagEW3U+qRTC+NfghEOUQohZtRLZDErtf71Q9GTuZfQGp9pBNpunVT3fqvbw8d
 PDKIkMejjCzBO3itbGXpOv1yi6s+IBuPVe1Y+Fy8ZtRNXX7S+px8FW3UZ49z120DoKqJ
 EQUjvC/O7DIj0yUiQvFqdLvtWRylJUpIY+n9XEQTECvBa0mjyxTm4UKthTzbhV9cwrOE
 7nMg==
X-Gm-Message-State: AFuF++neRSyDogl0SaQr0EMjpFGJvQMJndYeLx8aOtSOtAhrI48+xNzP
 O6dbPskgbiNxE5++MRBEhlHd3zdnt10VYDNGuH4RC2KZRp4YvANexVVASiH7Ao4F5Qg2jKVtV1o
 33LWPRBk=
X-Gm-Gg: AYBFou37lMFUugHAwM+y4uf5KLg9GB/k0wha5S1UqoP9HvgxrORHbg9nptrBSE6GkPY
 QZjMtPRFpTc/xZhb2YbmSN4zx6ryfmkEmBXjHutc8ZGOF5MMmenUSSxHFVEIXr7EZ74NvnVVJM2
 EFlgwpgxafy0D0MYuCIbIbNLiQg2bZnZkYH8LtQRmb9ol5CHhPHi6Aoo6H8q9mCEHwNNc4naYhu
 e7GLfwCaQMVBZjBb+k6/gHGeDpr+QVEpAoDJhGbtNqRVxoxGDrbEc/zaxHXhYT4eGUSUFn2+uS+
 mjgSY8b9/S8NI3wVC+neuMZ0mi2k439zilYCqVQeCxJwlmHWJAhkjcW9l28v5vCIIa/vRQdBKjN
 fgBp2ORq8U4C2z2NmvGWJc/4KrD4GiHtwlWQoXX1sUVPrKTCRBOwfqX0rFfFdONs7ovU8GZ+bsa
 rOulrLqVVhgR9VnbmHcYd1V225vQwIDjlYzoM6r58DYo6Jc5PUkoFaPDaFHAA=
X-Received: by 2002:a05:6830:3886:b0:803:c56c:2b1a with SMTP id
 46e09a7af769-80de37f1c55mr1645958a34.26.1789705507457; 
 Thu, 17 Sep 2026 21:25:07 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 01/41] bsd-user: Upstream most of the remaining system calls
Date: Thu, 17 Sep 2026 22:23:42 -0600
Message-ID: <20260918042422.38713-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>

---
Changes in v5:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v4: https://lore.kernel.org/qemu-devel/20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com

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

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 5,
    "change-id": "20260504-misc-2026q2-a5af31ac032a",
    "prefixes": [],
    "history": {
      "v1": [
        "20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com"
      ],
      "v2": [
        "20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com"
      ],
      "v3": [
        "20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com"
      ],
      "v4": [
        "20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com"
      ]
    }
  }
}
-- 
2.55.0



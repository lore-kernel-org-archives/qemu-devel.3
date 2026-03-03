Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D0EDA68D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSoi-0003Cw-0a; Tue, 03 Mar 2026 11:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxSoO-000365-RQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:41:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxSoK-00063j-HO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:41:32 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ae41544dcfso34987255ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:41:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772556087; cv=none;
 d=google.com; s=arc-20240605;
 b=YnWNVgCUpD8cu9ZdV4/GnCeIbLLhQneKRfjFxjlavvLLrNMn5WZNAlsaPPMV2PwdRV
 ymbelrffzgyqE0/v2CIM/1xkiGbBQltfJ9hiunbLwGC4I/RQpDlCc9vL64yyRwX/+A1P
 /QcPySHkSFhmlLXJyRpHcnfkW0XPr9f/jQiUQH4jABVL7qM6hoxRo4VFUxR+VJ51AH5p
 L8nwoZ0XXs982Ti0j0waHyauICPDViEBfYi/4kjD5A11LVEH4dHkofCwDVRZVY/K2C3b
 A+z37jTvgD3H2zCzG7JKeFsM/lR5zhLooH6cg+toMW5MlO9QL4q/uXJv4wWB3iGzCxHN
 Nx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SFk8fwAfvL+kthCCnRLNbDQA+y1RQt0DLkKQjfGpyg8=;
 fh=KkqdRGywlxv5Wj5V57PCt4gBJ9IszloNFP2Ks13LaQA=;
 b=frbpVXGfo/5jExo/qjAsvEhuDCm6PswUFUH0XgO2OeDs8+iA75dt2iKmCTUFpmK2Er
 4FhWvsUKX4imcZxOoNOVZ+XEBcqK4++t3Y3hthjrEGqwKFg36jjAdT9o0lV1T8ZzSQv/
 UtB/bZyCsu6jzMBxeXIUgbjkTe/oEIbw5eXKSpkUmlTjcKqpib80f98xZ4kFzCzJgxAo
 LANj271FlM9j/+ZqVgcHHOw9Yi0HHRoyAmfC1lLdfl2/tzPwENDMGGKkbWh1faamLt8p
 al35LBE/MrfA+kmFrgng+1XEvHL+OgmEbNFr5lrZhdtp2/B8eFKIKJ//5mumMnWQG7lJ
 jfnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772556087; x=1773160887;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SFk8fwAfvL+kthCCnRLNbDQA+y1RQt0DLkKQjfGpyg8=;
 b=bdBmLOSyDSYFcdaTFIgDCyNpN1NgdCfYPguKlFzgEUS/UMZkc+jfPSg5CUAO70DVXM
 zWmP00b0GpMOwO0lDhPuArMs/H4L7Sift410xMErYjAAlFqeHwpRIL7TJkw0voKSlFOw
 dzep01aXj48LTE66GNw+Pgdt6zL8sv5NhOTbkU21E941ToE6U9+lSLpQagFU3fw8dbgs
 wLwYLQHCXDWQBH/T84db9WtvVSREz6ijBLnxMJuZuXDVJXz+64VrXoIkHX8dbEeigXh9
 0mjXjLHsUODmG3tvO1bqdqRQD7/HSnBdsHYX6S1ySNLrTUXEEG5x144k+cnujewYPQSf
 5/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772556087; x=1773160887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFk8fwAfvL+kthCCnRLNbDQA+y1RQt0DLkKQjfGpyg8=;
 b=rmQXqhYbpDVKhgJj8inlNQkJP3hxfcDU91328dI765wenXQDwCwi8+9CYFq15ZrU+g
 tSs83EdPYqA/p6GiD5nbVTf7n/ZfFV0RMeOFHqloZYcnK/pGtn7l4vq69szDxHrjYqYT
 SPRxEONkhX5h+978ekb7ZR5S0foRe2bG+TCW1UJasH8tX8fDxeEs8fL3MwH3UAgRyMyp
 9UJJXNN0pXAnN3QdYdQs4pTqq26mPbm2AyBKJgUZ1e9ScTfaP5udxyOaql8BIRi8tI7L
 vzg2xaaVyC915O5ynjJnaAMPrWCa5mO21v4Oez/dkxEczCuFUY1k0yvflvL7OUNxBC6G
 QheQ==
X-Gm-Message-State: AOJu0YzjHlUayPb8epbe7Ggooza3+S+My9grYiBPbLA/Y/yeqDVso6OI
 2M0JWBL0jtirFyUf3I3XfwN1gCuTXrBHvzUcoTwAItjyCy19rENQRzQRs0DmNHXOt2fAvI/X0Aq
 v0okLRU1tBrUbnfhJZHJQ8AQ3vmnut5nwZ6tqS0OUEQ==
X-Gm-Gg: ATEYQzw4Eos66ONqJIJbUkcg+rrDJrU0H79TxzDESwlhC6wTHeh9hGeBGbuR7mE3Rlf
 76Zi75yRUSsJgFF34Tbob8QU60n7fvt3YoKMvATqGBtMQrBZyb74X3/hQek3oSJ8knO78u7Y24E
 cMVO5DaQKO4jGZFFml+2PZA0fADE0DwyPa1k9wip4NV9UaFmq+EkeqTFKSFY4MD96jZNOtHktX7
 CBS8NfGs1WXo6oriHOVCcsqFeOM4pYGDtNrBeuTFSMLMe4uYwoRC8Y+i3/0YBfq2izSjymIaHMw
 Z+io7dU=
X-Received: by 2002:a17:902:f709:b0:2ae:5b64:12e3 with SMTP id
 d9443c01a7336-2ae5b641569mr60668565ad.41.1772556086461; Tue, 03 Mar 2026
 08:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
 <aaahAbpycKhDzfbL@redhat.com>
 <CANCZdfoxESrbaUbXWo9g2jfaqsgaWbpNxg5CGd3xgf0MRMDMcw@mail.gmail.com>
 <aabZkCD-MkApTpD4@redhat.com>
In-Reply-To: <aabZkCD-MkApTpD4@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 3 Mar 2026 09:41:15 -0700
X-Gm-Features: AaiRm53SAQB_D3X6sTlNQMgj4gRl27cIzlpo1U1RWaNZkf7TS7o3W4FuY6Au2DM
Message-ID: <CANCZdfrgcpVN+MzNCCkVTFa8-Y2G-ajwqJHk4K0OuKvzot=Qeg@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Switch to SPDX-License-Expression
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e0d3b4064c215f07"
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62b.google.com
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

--000000000000e0d3b4064c215f07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK. I'm top posting on purpose.

This request expands what I'm trying to do too much, in ways I think are
unfair. The original authors didn't ask for a copyright line and we're
hopelessly inconsistent about it in the tree. I'm not fixing that problem
here. I'm sorry, but that's potentially a huge ask. I went through them all
and found a couple with no author at all (a much bigger problem, but not my
problem today) and a couple where Fabreise was included. I'll drop those
for simplicity.

The deeper analysis turns a 10-minute project into an hours-long, detailed
analysis. I don't have time for it, and the analysis likely won't produce
better results because the rest of the tree has similar problems regardless
of how we mark the source. And it seems to stand on too fine a point since
the Linux kernel already set a much stronger precedent than I'm doing here.
What I'm doing here is legally defensible and the hours-long analysis won't
produce anything more defensible. The suggested analysis is, at best,
incomplete since (a) authorship in this part of the tree is sloppy at times
and (b) it doesn't consider the out-of-tree history, which sometimes
produces different results with `git blame`. It's turtles all the way down
here. And I've also gotten mixed messages in the past when I tried to
attribute authorship for code I copied from linux-user in the past, so I
lack a good set of criteria to do the analysis.

I tried to highlight that these were old files in the [PATCH v4 00/24]
bsd-user: Upstream misc system calls (System V IPC, reboot, etc) series,
but I was still requested to add the SPDX headers instead since they were
truly "new files." So I'm doing them all to avoid that in the future. Since
I don't want arguments and when I push back I get inconsistent results for
simimlar situations.

I'm trying to not let my irritation show through too much, but I'm only 10k
lines into 40k of upstreaming and these side trips are slowing things down
too much. I appreciate the reviews that have found bugs in the code, but
I'm struggling with requests like this. I really need to limit the scope of
what I take on because there's a lot left to do and I'm doing it in my
spare time.

So does that sound like a good plan? Or what should I do?

Warner

P.S. Sorry if my frustration is showing through too much...

On Tue, Mar 3, 2026 at 5:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Tue, Mar 03, 2026 at 05:17:15AM -0700, Warner Losh wrote:
> > On Tue, Mar 3, 2026 at 1:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
> > wrote:
> >
> > > On Mon, Mar 02, 2026 at 09:46:06PM -0700, Warner Losh wrote:
> > > > Switch all the files over to using SPDX. This also corrects various
> > > > small errors in the form of the copyright messages. It adds
> copyright to
> > > > those files that lack it. There's no functional change.
> > > >
> > > > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > > > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > > > ---
> > > > Since I'll be upstreaming more files from bsd-user, and since qemu
> now
> > > > requires SPDX and prohibits boilerplate, this will make it easier.
> I've
> > > > converted all the relevant bits in bsd-user upstream.
> > >
> > > Note, QEMU / checkpatch.pl only requires SDPX on *newly* authored
> files.
> > > Existing code files, or new files whose content is copied from an
> > > existing file (either inside or outside QEMU git) are exempt from thi=
s
> > > and in fact required to be left without SPDX.
> > >
> > > The reasoning is that there is some uncertainty about the legality of
> > > removing license header text from existing files due to the GPL claus=
e
> > > 1 which says
> > >
> > >   "keep intact all the notices that refer to this License and
> > >    to the absence of any warranty;"
> > >
> > > I interpret that to mean we can not remove license header text from
> > > files unless the person doing the removal is the exclusive copyright
> > > holder, or has got recorded permission from all copyright holders
> > > that apply to each file changed.
> > >
> > > It is confusing for people because Linux removed all their GPL header
> > > text in favour of SPDX, but never provided any clear explanation of
> > > why they considered that to be acceptable from the GPL compliance POV=
.
> > >
> >
> > So I have Stacey's permission to do this, and he's the only actual
> copyright
> > holder on these files. If I messed up on any, specifically, please let =
me
> > know.
> > That's why I included his signed-off-by: he signed off on it and that
> he's
> > legally able to make the change.
>
> None of that was explained in the commit message, hence why I'm
> raising this as review feedback.
>
> As a sanity check I did the following to list number of contributors
> besides yourself & Stacey:
>
> $ for f in $(awk '{print $1}' <  filelist.txt) ; do echo -n "$f: " ; git
> log $f | grep ^Author |grep -v Stacey | grep -v Warner | sort | uniq | wc
> -l ; done
> bsd-user/aarch64/signal.c: 0
> bsd-user/aarch64/target_arch.h: 0
> bsd-user/aarch64/target_arch_cpu.c: 0
> bsd-user/aarch64/target_arch_cpu.h: 2
> bsd-user/aarch64/target_arch_elf.h: 1
> bsd-user/aarch64/target_arch_reg.h: 0
> bsd-user/aarch64/target_arch_signal.h: 0
> bsd-user/aarch64/target_arch_sigtramp.h: 0
> bsd-user/aarch64/target_arch_sysarch.h: 0
> bsd-user/aarch64/target_arch_thread.h: 0
> bsd-user/aarch64/target_arch_vmparam.h: 0
> bsd-user/aarch64/target_syscall.h: 0
> bsd-user/arm/signal.c: 1
> bsd-user/arm/target_arch.h: 2
> bsd-user/arm/target_arch_cpu.c: 1
> bsd-user/arm/target_arch_cpu.h: 3
> bsd-user/arm/target_arch_elf.h: 3
> bsd-user/arm/target_arch_reg.h: 1
> bsd-user/arm/target_arch_signal.h: 1
> bsd-user/arm/target_arch_sigtramp.h: 1
> bsd-user/arm/target_arch_sysarch.h: 1
> bsd-user/arm/target_arch_thread.h: 1
> bsd-user/arm/target_arch_vmparam.h: 1
> bsd-user/arm/target_syscall.h: 1
> bsd-user/bsd-file.h: 3
> bsd-user/bsd-mem.c: 1
> bsd-user/bsd-mem.h: 5
> bsd-user/bsd-proc.c: 2
> bsd-user/bsd-proc.h: 4
> bsd-user/bsdload.c: 5
> bsd-user/elfload.c: 21
> bsd-user/freebsd/os-misc.h: 2
> bsd-user/freebsd/os-proc.c: 3
> bsd-user/freebsd/os-proc.h: 3
> bsd-user/freebsd/os-stat.c: 1
> bsd-user/freebsd/os-stat.h: 3
> bsd-user/freebsd/os-strace.h: 0
> bsd-user/freebsd/target_os_elf.h: 2
> bsd-user/freebsd/target_os_siginfo.h: 2
> bsd-user/freebsd/target_os_stack.h: 3
> bsd-user/freebsd/target_os_thread.h: 1
> bsd-user/freebsd/target_os_user.h: 2
> bsd-user/freebsd/target_os_vmparam.h: 1
> bsd-user/i386/signal.c: 1
> bsd-user/i386/target_arch.h: 1
> bsd-user/i386/target_arch_cpu.c: 2
> bsd-user/i386/target_arch_cpu.h: 3
> bsd-user/i386/target_arch_elf.h: 2
> bsd-user/i386/target_arch_reg.h: 1
> bsd-user/i386/target_arch_signal.h: 0
> bsd-user/i386/target_arch_sigtramp.h: 1
> bsd-user/i386/target_arch_sysarch.h: 1
> bsd-user/i386/target_arch_thread.h: 1
> bsd-user/i386/target_arch_vmparam.h: 1
> bsd-user/i386/target_syscall.h: 2
> bsd-user/main.c: 47
> bsd-user/mmap.c: 14
> bsd-user/qemu-bsd.h: 1
> bsd-user/qemu.h: 24
> bsd-user/signal.c: 14
> bsd-user/strace.c: 6
> bsd-user/syscall_defs.h: 8
> bsd-user/x86_64/signal.c: 1
> bsd-user/x86_64/target_arch.h: 1
> bsd-user/x86_64/target_arch_cpu.c: 2
> bsd-user/x86_64/target_arch_cpu.h: 3
> bsd-user/x86_64/target_arch_elf.h: 2
> bsd-user/x86_64/target_arch_reg.h: 1
> bsd-user/x86_64/target_arch_signal.h: 1
> bsd-user/x86_64/target_arch_sigtramp.h: 1
> bsd-user/x86_64/target_arch_sysarch.h: 1
> bsd-user/x86_64/target_arch_thread.h: 2
> bsd-user/x86_64/target_arch_vmparam.h: 1
> bsd-user/x86_64/target_syscall.h: 3
>
>
> I checked a few of the cases where only 1/2/3 other authors are
> listed, the changes they made appear to be trivial and could be
> considered non-copyrightable. So converting most of the files
> is probably OK with just yourself & Stacey's agreement.
>
> The big notable exceptions appear to be many of the files directly
> in the bsd-user/ directory, as opposed to sub-dirs, which still
> contain code dating back to the original impl of bsd-user.
>
> > Also, I did this to reduce friction in upstreaming bsd-user which has
> been
> > going on for 6ish years now. The SPDX rule is one more thing that slows
> > that down. Rather than get an exception to the rule, I brought everythi=
ng
> > into compliance so it isn't yet another issue that takes more time
> because
> > I forgot to do it for a specific patch series. The more issues I have t=
o
> > have
> > on my checklist, the more the works are gummed up and the slower the
> > progress is. We still have somethign like ~30k lines to go last I
> checked.
>
> >
> > Also, these files have also been out of tree for over a decade. The new
> > rule forces me to do what you're complaining about the Linux tree doing=
:
> > remove GPL markings to get it into your tree. Well which is it?  Either
> it's
> > wrong and I shouldn't have to do it for the old files.  Or what I've do=
ne
> > is proper since it's uniform. Your tree is just an arbitrary repo of
> these
> > files, and isn't special in any meaningful way. So I'm in a no-win
> situation
> > here by your argument.
>
> The checkpatch.pl script warnings indicate that SDPX is only required
> on newly added files, and also states that this does not apply if
> copying from existing code.  If you've suggestions on how we can improve
> the contributor docs or checkpatch script messages to better explain this
> please feel free to say
>
> > Also, when I talk about a burdensome and cumbersome upstreaming process=
,
> > this is yet another example. An arbitrary rule that causes friction, bu=
t
> > provides
> > no actual benefit. It's like the style rules: I have to arbitrarily
> > reformat code that
> > is like that in linux-user because this is "new code". So I spend a fai=
r
> > amount of
> > time fetching different stones to obey the rules, but since now the cod=
e
> is
> > different
> > it becomes harder to track linux-user or to ever converge them. Change
> for
> > the
> > sake of compliance with an arbitrary rule that doesn't apply elsewhere
> (for
> > whatever
> > reason) is one of the death by a thousand cuts I, and others doing this
> > work, have
> > been suffering for far too long. It's in large measure why things aren'=
t
> > further along:
> > it steals what little time I have for this and it demotivates further
> work
> > for a while.
>
> There's always a tradeoff in these areas between having project standards
> and the burden that places on contributors to comply with the standards.
> It can't really be a total free-for-all in a project of the scale that
> QEMU is. In addition, caution around license compliance is a key factor
> for QEMU, as a critical infrastructure component underpinning a huge
> ecosystem of projects and activities.
>
> I agree that the style formatting rules in particular are quite painful
> because we never fix historic code to comply with the stated style. Most
> other projects would enforce code style unconditionally across the code
> base. I would very much like that situation to change.
>
> > So, having said that, is there any specific objection to anything I've
> > done? Given
> > Stacey's explicit blessing of this change (you'll recall from the patch
> > series I just did
> > I waited until I had contacted him before I changing it there), did I
> mess
> > up anywhere?
>
> Two simple changes from my pov:
>
>  * Remove the changes to the files that have copyrightable code from
>    people besides yourself & Stacey. This looks to be mostly the older
>    files in the root bsd-user/ directory
>
>  * Mention in the commit message that this change is being made only
>    to files where yourself & Stacey are the copyright holders.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000e0d3b4064c215f07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK. I&#39;m top posting on purpose.<div><br></div><div>Thi=
s request expands what I&#39;m trying to do too much, in ways I think are u=
nfair. The original authors didn&#39;t ask for a copyright line and we&#39;=
re hopelessly inconsistent about it in the tree. I&#39;m not fixing that pr=
oblem here. I&#39;m sorry, but that&#39;s potentially a huge ask. I went th=
rough them all and found a couple with no author at all (a much bigger prob=
lem, but not my problem today) and a couple where Fabreise was included. I&=
#39;ll drop those for simplicity.</div><div><br></div><div>The deeper analy=
sis turns a 10-minute project into an hours-long, detailed analysis. I don&=
#39;t have time for it, and the analysis likely won&#39;t produce better re=
sults because the rest of the tree has similar=C2=A0problems regardless of =
how we mark the source. And it seems to stand on too fine a point since the=
 Linux kernel already set a much stronger precedent=C2=A0than I&#39;m doing=
 here. What I&#39;m doing here is legally defensible and the hours-long ana=
lysis won&#39;t produce anything more defensible. The suggested analysis is=
, at best, incomplete since (a) authorship in this part of the tree is slop=
py at times and (b) it doesn&#39;t consider the out-of-tree history, which =
sometimes produces different results with `git blame`. It&#39;s turtles all=
 the way down here. And I&#39;ve also gotten mixed messages in the past whe=
n I tried to attribute authorship for code I copied from linux-user in the =
past, so I lack a good set of criteria to do the analysis.</div><div><br></=
div><div>I tried to highlight that these were old files in the [PATCH v4 00=
/24] bsd-user: Upstream misc system calls (System V IPC, reboot, etc) serie=
s, but I was still requested to add the SPDX headers instead since they wer=
e truly &quot;new files.&quot; So I&#39;m doing them all to avoid that in t=
he future. Since I don&#39;t want arguments and when I push back I get inco=
nsistent results for simimlar situations.</div><div><br></div><div>I&#39;m =
trying to not let my irritation show through too much, but I&#39;m only 10k=
 lines into 40k of upstreaming and these side trips are slowing things down=
 too much. I appreciate the reviews that have found bugs in the code, but I=
&#39;m struggling with requests like this. I really need to limit the scope=
 of what I take on because there&#39;s a lot left to do and I&#39;m doing i=
t in my spare time.</div><div><br></div><div>So does that sound like a good=
 plan? Or what should I do?</div><div><br></div><div>Warner</div><div><br><=
/div><div>P.S. Sorry if my frustration is showing through too much...</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Mar 3, 2026 at 5:52=E2=80=AFAM Daniel P. Berr=
ang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Tue, Mar 03, 2026 at 05:17:15AM -0700, Warner Losh wrote:<br>
&gt; On Tue, Mar 3, 2026 at 1:51=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a =
href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Mar 02, 2026 at 09:46:06PM -0700, Warner Losh wrote:<br>
&gt; &gt; &gt; Switch all the files over to using SPDX. This also corrects =
various<br>
&gt; &gt; &gt; small errors in the form of the copyright messages. It adds =
copyright to<br>
&gt; &gt; &gt; those files that lack it. There&#39;s no functional change.<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; &gt; &gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com" target=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; Since I&#39;ll be upstreaming more files from bsd-user, and =
since qemu now<br>
&gt; &gt; &gt; requires SPDX and prohibits boilerplate, this will make it e=
asier. I&#39;ve<br>
&gt; &gt; &gt; converted all the relevant bits in bsd-user upstream.<br>
&gt; &gt;<br>
&gt; &gt; Note, QEMU / <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" =
target=3D"_blank">checkpatch.pl</a> only requires SDPX on *newly* authored =
files.<br>
&gt; &gt; Existing code files, or new files whose content is copied from an=
<br>
&gt; &gt; existing file (either inside or outside QEMU git) are exempt from=
 this<br>
&gt; &gt; and in fact required to be left without SPDX.<br>
&gt; &gt;<br>
&gt; &gt; The reasoning is that there is some uncertainty about the legalit=
y of<br>
&gt; &gt; removing license header text from existing files due to the GPL c=
lause<br>
&gt; &gt; 1 which says<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0&quot;keep intact all the notices that refer to this =
License and<br>
&gt; &gt;=C2=A0 =C2=A0 to the absence of any warranty;&quot;<br>
&gt; &gt;<br>
&gt; &gt; I interpret that to mean we can not remove license header text fr=
om<br>
&gt; &gt; files unless the person doing the removal is the exclusive copyri=
ght<br>
&gt; &gt; holder, or has got recorded permission from all copyright holders=
<br>
&gt; &gt; that apply to each file changed.<br>
&gt; &gt;<br>
&gt; &gt; It is confusing for people because Linux removed all their GPL he=
ader<br>
&gt; &gt; text in favour of SPDX, but never provided any clear explanation =
of<br>
&gt; &gt; why they considered that to be acceptable from the GPL compliance=
 POV.<br>
&gt; &gt;<br>
&gt; <br>
&gt; So I have Stacey&#39;s permission to do this, and he&#39;s the only ac=
tual copyright<br>
&gt; holder on these files. If I messed up on any, specifically, please let=
 me<br>
&gt; know.<br>
&gt; That&#39;s why I included his signed-off-by: he signed off on it and t=
hat he&#39;s<br>
&gt; legally able to make the change.<br>
<br>
None of that was explained in the commit message, hence why I&#39;m<br>
raising this as review feedback.<br>
<br>
As a sanity check I did the following to list number of contributors<br>
besides yourself &amp; Stacey:<br>
<br>
$ for f in $(awk &#39;{print $1}&#39; &lt;=C2=A0 filelist.txt) ; do echo -n=
 &quot;$f: &quot; ; git log $f | grep ^Author |grep -v Stacey | grep -v War=
ner | sort | uniq | wc -l ; done<br>
bsd-user/aarch64/signal.c: 0<br>
bsd-user/aarch64/target_arch.h: 0<br>
bsd-user/aarch64/target_arch_cpu.c: 0<br>
bsd-user/aarch64/target_arch_cpu.h: 2<br>
bsd-user/aarch64/target_arch_elf.h: 1<br>
bsd-user/aarch64/target_arch_reg.h: 0<br>
bsd-user/aarch64/target_arch_signal.h: 0<br>
bsd-user/aarch64/target_arch_sigtramp.h: 0<br>
bsd-user/aarch64/target_arch_sysarch.h: 0<br>
bsd-user/aarch64/target_arch_thread.h: 0<br>
bsd-user/aarch64/target_arch_vmparam.h: 0<br>
bsd-user/aarch64/target_syscall.h: 0<br>
bsd-user/arm/signal.c: 1<br>
bsd-user/arm/target_arch.h: 2<br>
bsd-user/arm/target_arch_cpu.c: 1<br>
bsd-user/arm/target_arch_cpu.h: 3<br>
bsd-user/arm/target_arch_elf.h: 3<br>
bsd-user/arm/target_arch_reg.h: 1<br>
bsd-user/arm/target_arch_signal.h: 1<br>
bsd-user/arm/target_arch_sigtramp.h: 1<br>
bsd-user/arm/target_arch_sysarch.h: 1<br>
bsd-user/arm/target_arch_thread.h: 1<br>
bsd-user/arm/target_arch_vmparam.h: 1<br>
bsd-user/arm/target_syscall.h: 1<br>
bsd-user/bsd-file.h: 3<br>
bsd-user/bsd-mem.c: 1<br>
bsd-user/bsd-mem.h: 5<br>
bsd-user/bsd-proc.c: 2<br>
bsd-user/bsd-proc.h: 4<br>
bsd-user/bsdload.c: 5<br>
bsd-user/elfload.c: 21<br>
bsd-user/freebsd/os-misc.h: 2<br>
bsd-user/freebsd/os-proc.c: 3<br>
bsd-user/freebsd/os-proc.h: 3<br>
bsd-user/freebsd/os-stat.c: 1<br>
bsd-user/freebsd/os-stat.h: 3<br>
bsd-user/freebsd/os-strace.h: 0<br>
bsd-user/freebsd/target_os_elf.h: 2<br>
bsd-user/freebsd/target_os_siginfo.h: 2<br>
bsd-user/freebsd/target_os_stack.h: 3<br>
bsd-user/freebsd/target_os_thread.h: 1<br>
bsd-user/freebsd/target_os_user.h: 2<br>
bsd-user/freebsd/target_os_vmparam.h: 1<br>
bsd-user/i386/signal.c: 1<br>
bsd-user/i386/target_arch.h: 1<br>
bsd-user/i386/target_arch_cpu.c: 2<br>
bsd-user/i386/target_arch_cpu.h: 3<br>
bsd-user/i386/target_arch_elf.h: 2<br>
bsd-user/i386/target_arch_reg.h: 1<br>
bsd-user/i386/target_arch_signal.h: 0<br>
bsd-user/i386/target_arch_sigtramp.h: 1<br>
bsd-user/i386/target_arch_sysarch.h: 1<br>
bsd-user/i386/target_arch_thread.h: 1<br>
bsd-user/i386/target_arch_vmparam.h: 1<br>
bsd-user/i386/target_syscall.h: 2<br>
bsd-user/main.c: 47<br>
bsd-user/mmap.c: 14<br>
bsd-user/qemu-bsd.h: 1<br>
bsd-user/qemu.h: 24<br>
bsd-user/signal.c: 14<br>
bsd-user/strace.c: 6<br>
bsd-user/syscall_defs.h: 8<br>
bsd-user/x86_64/signal.c: 1<br>
bsd-user/x86_64/target_arch.h: 1<br>
bsd-user/x86_64/target_arch_cpu.c: 2<br>
bsd-user/x86_64/target_arch_cpu.h: 3<br>
bsd-user/x86_64/target_arch_elf.h: 2<br>
bsd-user/x86_64/target_arch_reg.h: 1<br>
bsd-user/x86_64/target_arch_signal.h: 1<br>
bsd-user/x86_64/target_arch_sigtramp.h: 1<br>
bsd-user/x86_64/target_arch_sysarch.h: 1<br>
bsd-user/x86_64/target_arch_thread.h: 2<br>
bsd-user/x86_64/target_arch_vmparam.h: 1<br>
bsd-user/x86_64/target_syscall.h: 3<br>
<br>
<br>
I checked a few of the cases where only 1/2/3 other authors are<br>
listed, the changes they made appear to be trivial and could be<br>
considered non-copyrightable. So converting most of the files<br>
is probably OK with just yourself &amp; Stacey&#39;s agreement.<br>
<br>
The big notable exceptions appear to be many of the files directly<br>
in the bsd-user/ directory, as opposed to sub-dirs, which still<br>
contain code dating back to the original impl of bsd-user.<br>
<br>
&gt; Also, I did this to reduce friction in upstreaming bsd-user which has =
been<br>
&gt; going on for 6ish years now. The SPDX rule is one more thing that slow=
s<br>
&gt; that down. Rather than get an exception to the rule, I brought everyth=
ing<br>
&gt; into compliance so it isn&#39;t yet another issue that takes more time=
 because<br>
&gt; I forgot to do it for a specific patch series. The more issues I have =
to<br>
&gt; have<br>
&gt; on my checklist, the more the works are gummed up and the slower the<b=
r>
&gt; progress is. We still have somethign like ~30k lines to go last I chec=
ked.<br>
<br>
&gt; <br>
&gt; Also, these files have also been out of tree for over a decade. The ne=
w<br>
&gt; rule forces me to do what you&#39;re complaining about the Linux tree =
doing:<br>
&gt; remove GPL markings to get it into your tree. Well which is it?=C2=A0 =
Either it&#39;s<br>
&gt; wrong and I shouldn&#39;t have to do it for the old files.=C2=A0 Or wh=
at I&#39;ve done<br>
&gt; is proper since it&#39;s uniform. Your tree is just an arbitrary repo =
of these<br>
&gt; files, and isn&#39;t special in any meaningful way. So I&#39;m in a no=
-win situation<br>
&gt; here by your argument.<br>
<br>
The <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blank">c=
heckpatch.pl</a> script warnings indicate that SDPX is only required<br>
on newly added files, and also states that this does not apply if<br>
copying from existing code.=C2=A0 If you&#39;ve suggestions on how we can i=
mprove<br>
the contributor docs or checkpatch script messages to better explain this<b=
r>
please feel free to say<br>
<br>
&gt; Also, when I talk about a burdensome and cumbersome upstreaming proces=
s,<br>
&gt; this is yet another example. An arbitrary rule that causes friction, b=
ut<br>
&gt; provides<br>
&gt; no actual benefit. It&#39;s like the style rules: I have to arbitraril=
y<br>
&gt; reformat code that<br>
&gt; is like that in linux-user because this is &quot;new code&quot;. So I =
spend a fair<br>
&gt; amount of<br>
&gt; time fetching different stones to obey the rules, but since now the co=
de is<br>
&gt; different<br>
&gt; it becomes harder to track linux-user or to ever converge them. Change=
 for<br>
&gt; the<br>
&gt; sake of compliance with an arbitrary rule that doesn&#39;t apply elsew=
here (for<br>
&gt; whatever<br>
&gt; reason) is one of the death by a thousand cuts I, and others doing thi=
s<br>
&gt; work, have<br>
&gt; been suffering for far too long. It&#39;s in large measure why things =
aren&#39;t<br>
&gt; further along:<br>
&gt; it steals what little time I have for this and it demotivates further =
work<br>
&gt; for a while.<br>
<br>
There&#39;s always a tradeoff in these areas between having project standar=
ds<br>
and the burden that places on contributors to comply with the standards.<br=
>
It can&#39;t really be a total free-for-all in a project of the scale that<=
br>
QEMU is. In addition, caution around license compliance is a key factor<br>
for QEMU, as a critical infrastructure component underpinning a huge<br>
ecosystem of projects and activities.<br>
<br>
I agree that the style formatting rules in particular are quite painful<br>
because we never fix historic code to comply with the stated style. Most<br=
>
other projects would enforce code style unconditionally across the code<br>
base. I would very much like that situation to change.<br>
<br>
&gt; So, having said that, is there any specific objection to anything I&#3=
9;ve<br>
&gt; done? Given<br>
&gt; Stacey&#39;s explicit blessing of this change (you&#39;ll recall from =
the patch<br>
&gt; series I just did<br>
&gt; I waited until I had contacted him before I changing it there), did I =
mess<br>
&gt; up anywhere?<br>
<br>
Two simple changes from my pov:<br>
<br>
=C2=A0* Remove the changes to the files that have copyrightable code from<b=
r>
=C2=A0 =C2=A0people besides yourself &amp; Stacey. This looks to be mostly =
the older<br>
=C2=A0 =C2=A0files in the root bsd-user/ directory<br>
<br>
=C2=A0* Mention in the commit message that this change is being made only<b=
r>
=C2=A0 =C2=A0to files where yourself &amp; Stacey are the copyright holders=
.<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div>

--000000000000e0d3b4064c215f07--


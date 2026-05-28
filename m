Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CC7CD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 02:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSQ2b-0007jt-4W; Wed, 27 May 2026 22:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSQ2Z-0007j3-7V
 for qemu-devel@nongnu.org; Wed, 27 May 2026 22:00:07 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wSQ2X-0000Ge-2V
 for qemu-devel@nongnu.org; Wed, 27 May 2026 22:00:06 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1492346066b.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 19:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779933603; cv=none;
 d=google.com; s=arc-20240605;
 b=Edv1u4PJBZkLNWbyhDfGfotCAq4oLapMnFTz+eO0KLLRN9owXEuW117W7Gwsbb/V2y
 3w35PAU8tzwZ64azP9O8TOscsLroVs9HNMzXJxQnGTh2G5S4PgHicKLVJ9FDrpRCj0bR
 7sTplJmJ4tKAcEmrYc3mebak0ofm8KJqPUPq3gEYzwHv5ftPEpAsmYJgQxFflnTiBOSg
 9eAwzXwDuGUojNCCdj4yrsvl7dLT6ukgkNKDNBu3RJQBjzQqrz8mshz7c7ZbZ/pcygfX
 tl//cvvcxuHB12ODbRF0kbNVB/7pglk1us0uYtWCVx8lk2LORrAeYF5kQ5A6ulubHwlC
 CJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iuN8Pn1F0wvE7GkGH4IOq92GUCol8AEANNIVCeUnObA=;
 fh=0uZxpXRfyPaEqSUA07ry6ynzselFJynURhWxksT+t/g=;
 b=lQkZCEUSGufW8Wvi0Y87OpgSHMwPH1KesQxKCYU5aUtxm7bkZTtZCGbV0LsOdPhRAO
 Xj0lljqUZGYXy3GjnmCpl77lADGweljbnrYttd2aF7lFU+ji2340XrKKBs+mSqm3VCPv
 GyXeX3KrAfM9Uhomka/lqIL6H1vY4OzKwDlCyt5yQp+ItneGngvMleXKzuHQrG1zGGwO
 Uy5smFWgxIIebb223AwyXruiah5UxrxxQ5mssB6YXZ5mBAQoaqAt9tvf+Na4H+EZtnUQ
 DDuhRPEH6j5dxmW/82zSMtfFTZKclRLdDZCDH3mVbJY8qtWnDrMSfAlFBlPPsf0yDp4/
 z2BQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779933603; x=1780538403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuN8Pn1F0wvE7GkGH4IOq92GUCol8AEANNIVCeUnObA=;
 b=XexRvZkEsbx7RTpI7yhiJGrFJKMNa87IJQkR0aBB7HrG1dTayiHmZ+52ynLpxLIZix
 /FvSYYzOh4rfbtOzS4610fTzPWsWXDFotv3RIsALA1S/xkYMZ6H9fgs5UNZQ0HQdv4MD
 PK2eli8F7xVaN6wf2v/3M/GLgM56iI5VGgspN+P6VrB5Qk8Z43ltf2TWzPeMJH9r94vM
 bhu2vHce8bPF3oCloUm9cOo+Z/BAWCMYNk8RMwzV25T0J23gK9eF/FIrbGOisYuybZry
 E5FZpt0KPGr15n+I9+Zxwa1xdYg25eOzFe+fSrQIIN+MIcQarRAUU3rWgmEgm4j+uMcn
 shQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779933603; x=1780538403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iuN8Pn1F0wvE7GkGH4IOq92GUCol8AEANNIVCeUnObA=;
 b=RwyMF3gI9VM+DqbI9QdBwKrVym39/hhMWae0MdidP9bC2p1e1hidWSFuyGlWZz15wu
 ykHj4wvHYMuGiAUUXW01NlazahMY84yRGPO8LNjJEVFaRdTVgHHVk4/AU1av4um69LCs
 Wkih1bbeLJ/hOk6ZtqV4XDu0RtFDDFTwuaGG/CNsDbMxXRwJ8+DCP4GXgU9/UC5dbDWI
 PLPp1vspSLRFoyioo89ViDZbi65mEz9mnQN5FAd8DxR6rMgGDhjUdgTvq+gxjz0pe7zd
 nfSeA31rMweOmSSYTxw44O4XFebBPIVqBwDci3VEvW2pGeqEYDD226s09lp6UnTfpmGs
 W8wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bf8Or+OkL9/xOL8UwVkBSwqJdT/w3nJGnKpz5nF96gj7yJjbwuCDAK3IVkStfmIsTkDQIv2N770LJ@nongnu.org
X-Gm-Message-State: AOJu0YxaVxt3xcp7btwnCDVoBHJr1qZy3kfILHUBvJCEeT3XCZJEbVHJ
 FpN26u2yZowrBuPxz+Qtdyx9mlmjOAanpWxlm01bVmTPyxJQ7A7g+2tUewm9x75tXVNq2PLyfzk
 rFpmkt3RQ3efMMrZrzq6Gbn+D0YDyZAs=
X-Gm-Gg: Acq92OHFh/WGLG9VFj4dQrGdQG/NOUqwav/frrOuzPVewuNrb2Zo6mxKgUi5BVl8O2h
 JOhY6Qz6c6Pb9oYr+cnsrQwPwD5/LuFYUnfX9GAW01osQcq5nsYy5obR+fV04W1TtzEJ/xvrVqt
 tIGKuZwn8VjSqVewaPVf/wAx29B+KIvuGFyHOFEaUR+7wiV5RmPIB0lTOuahWeoy0GWTn34DQtB
 gv+yRIX8hqVnW6VNS7FX+V9siNuG22vtuvov2kkDk+zNRrUi3ScSptADOdOe3lvXtUGJCI77qFJ
 C9mJXDgnkxdcPaqbrw93QnZQLIHb+rcgLu27jSVshaBH5+vd
X-Received: by 2002:a17:907:1df0:b0:bd5:156d:835a with SMTP id
 a640c23a62f3a-bdd260d4e2emr1169090766b.41.1779933602790; Wed, 27 May 2026
 19:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
 <CANCZdfp4OQEoOQk5v0B+n8GaOb1a=FiLjLy9jGG9G_AWY79xNA@mail.gmail.com>
In-Reply-To: <CANCZdfp4OQEoOQk5v0B+n8GaOb1a=FiLjLy9jGG9G_AWY79xNA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 May 2026 11:59:35 +1000
X-Gm-Features: AVHnY4KrXsmmkCCWP3blLkfkacQDCLA6cDP5oG7Di6Qg8eji51xXroong9De6mA
Message-ID: <CAKmqyKM8yQ7mDRv6anW-7QSjKcgwxj-RoVikJWV0xuT+CgJDFg@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Warner Losh <imp@bsdimp.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 28, 2026 at 12:21=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote=
:
>
>
>
> On Wed, May 27, 2026 at 4:54=E2=80=AFAM Alistair Francis <alistair23@gmai=
l.com> wrote:
>>
>> On Wed, May 27, 2026 at 8:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>> >
>> > On 5/27/26 10:41, Kevin Wolf wrote:
>> > > Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
>> > >> The QEMU Project currently may accept limited uses of AI that produ=
ce
>> > >> high quality patches that are limited in the creative content added=
.
>> > >> While maintainers will ultimately decide, changes like the followin=
g
>> > >> fall within this policy
>> > >> 1. Fixing obvious warnings in the obvious ways suggested by the too=
l
>> > >> 2. Tree wide API changes, and other similar mechanical changes done
>> > >>     today with perl/python/sed/coccinelle
>> > >
>> > > As I said in the paragraph you quoted below, I don't think we should
>> > > encourage using AI for tasks that a deterministic tool could do.
>> >
>> > In some cases such a tool does not exist.  Much to my surprise, there =
is
>> > no tool to do static type inference on Python code, but AI is very goo=
d
>> > at doing it.
>> >
>> > > Letting AI perform the change directly instead may be an acceptable
>> > > shortcut for a one-man hobby project that nobody else will ever look=
 at,
>> > > but in the context of a community project like QEMU in which your
>> > > changes have to be reviewed and understood by others, it matters a l=
ot
>> > > that the output of the tool is reproducible. Otherwise, you're creat=
ing
>> > > unnecessary work for others, and that isn't acceptable.
>> >
>> > When applicable, going through coccinelle (with the aid of AI if neede=
d!
>> > is indeed a good middle ground as it helps reviewers for large changes=
.
>> > If you have many slightly different but easily separated changes (e.g.
>> > you can split the patch by struct field), it may make things worse.
>> >
>> > Its also worth noting that in other cases even sed or coccinelle, whil=
e
>> > deterministic, cannot produce 100% of the patch.
>> >
>> > > So maybe we should even explicitly mention a recommendation like the
>> > > following:
>> > >
>> > >      If you can use a deterministic tool, don't use AI instead. If y=
ou
>> > >      don't know how to use the deterministic tool, use the AI to tel=
l you
>> > >      how to use it instead of trying to replace it.
>> >
>> > I like it.
>> >
>> > >> 3. Limited, small changes to fix bugs or add a small new feature wh=
ose
>> > >>     scope is less than about 100 lines and the originator can expla=
in
>> > >>     them all or the meta issues about the patch.
>> > >
>> > > Not sure if mentioning a number of lines is wise. 100 lines can be
>> > > mostly boilerplate and simple sequential code or they can be a deepl=
y
>> > > nested complex algorithm.
>> >
>> > I'd put the threshold at 20-50 at most.
>> >
>> > > I think I would see more use in a tag like (better name welcome):
>> > >
>> > >     AI-used-for: [code|tests|docs|commit message]...
>> >
>> > I like this *a lot*.  No need for free advertisement, but some
>> > traceability is useful.
>> >
>> > For tools such as sed or coccinelle, having the exact script in the
>> > patch or commit message useful.  Plus, the execution of the script mor=
e
>> > or lesss delimits the commit by itself (or 90%+ of it).  For LLMs it's=
 a
>> > bit less clear cut because separating docs makes little sense.  And th=
e
>> > exact model is pointless, it will be obsolete in 6 months and provide =
no
>> > useful information.
>> >
>> > So, something like:
>> >
>> > ------------------- 8< -------------------
>> > Use of AI-generated content
>> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >
>> > The QEMU project currently allows using AI/LLM tools to produce patche=
s
>> > in scenarios with limited creative content:
>> >
>> > Mechanical changes
>> >    If you can use a deterministic tool or a script, don't use AI inste=
ad.
>> >    If you don't know how to do the change deterministically, you may
>> >    ask the AI for help, rather than having it stand in for the tools.
>> >
>> > Small bug fixes
>> >    These should be limited to 20 lines of code or less, not including
>> >    tests.  You are still expected to understand and explain your chang=
es
>> >    and the rationale behind them.
>>
>> Coming back to Peter's earlier comments and the Zig policy, one thing
>> we have in RISC-V is people are running AI tools against QEMU and the
>> RISC-V spec to identify places where we don't meet the spec. They then
>> write patches and submit them upstream. The patches appear human
>> written, so have been accepted.
>
>
> I have a checklist for bsd-user changes that checks the common mistakes
> around the lock_user family of interfaces. I've generated patches from
> what claude found, but claude's patches were generally identical to
> what I produced.
>
>>
>> A lot of the bugs found are corner cases that people aren't actually
>> hitting. From my use of AI review systems in the past, they do tend to
>> be very nit-picky. So it's not too hard to catch issues that users
>> won't actually hit and fix them. It's a valid fix, but easy to
>> inundate reviewers. If this process was entirely run by an LLM it
>> could be way too much.
>
>
> My experience is that claude found 150 or so "bugs". All were "legit" in
> the sense the APIs were used wrong, but maybe 10 were actual critical
> bugs that explained some, but not all, of the mysterious hangs we see.

Yeah, that's exactly what I don't want, someone drive by sending all
150 "legit" bug fix patches.

> My worry has been one of testing: how do I test it all? Or do I continue
> to use the 'just build thousands of packages' as the acid test?
>
>>
>> So maybe we should add something here about don't send large numbers
>> of "small bug fix" patches. So someone doesn't point an AI at QEMU and
>> a spec and generate huge numbers of patches, all of which are just
>> small bug fixes.
>
>
> Wouldn't this concern fall under the general requirement to not send more
> than a manageable number of patches at a time (like 50)? Or do you think
> a lower number is warranted?

I could see someone reading the proposed wording and then sending one
20 line patch, then another, then another, then another, then another,
then another and then more. All while only sending "small patches",
but the ability to generate a large number.

It's not clear to me at least from the proposed wording that we should
discourage that.

Alistair


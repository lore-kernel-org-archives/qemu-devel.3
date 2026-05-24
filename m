Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104DCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 18:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRDXW-0003L1-RG; Sun, 24 May 2026 14:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRDXQ-0003KH-By
 for qemu-devel@nongnu.org; Sun, 24 May 2026 14:27:00 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRDXM-0003OB-Q5
 for qemu-devel@nongnu.org; Sun, 24 May 2026 14:27:00 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so10296291a91.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 11:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779647214; cv=none;
 d=google.com; s=arc-20240605;
 b=Nq8uoRgVTu7J6Nya6IwXfc8XmyOikN+6mFlJn7/RMrU/49XkxsiscDLzFfoEiPabBM
 nvRlI4O5EBDZJmpxl70Mxi1ITCtJqlKq15ewF1Z0G/0751jrAAkDEkQGtKmmnnPy/NiJ
 0wwEPbERNNqju2BhHgMhcD0m162ZO4GWa4KMefL+eaUN1SfucXrd6o/HydnDnrFEJ7SU
 sWpmEt+Yo7bixSw89DiMk9btsnmSgR0CTDq+hpjYz0Dtb+nWz6XG2El8mHDKCpPyNYEX
 E1UMI0jFQAXEjLoRoGVtEOSCIxZ1LDYEiIDLJazQckZN0qlMMH00vuITkQ+3Ywi5RERp
 xZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QTlCGstd3Tpt5Q3cFRMzyAJdfKPbZXLbZ55PiwvoBLI=;
 fh=jXmOQb7RZE7DROJf4DO76BITqoZzEiYYpifozHxev1c=;
 b=TdI/1Q/UTisU7F1qIIGAULBcxEEH8CjHracUQBccfYS57hbWwnlJMOdXgdhI8H+0q+
 Gew48JkAYtSsYkty2kSBKp+nry6tSLzxW/Jx3mjAZnKxyF3TIsO8psoU5ixIuDG3XCX5
 UPhfz/4BgdsBMrN3yNhjQB6gRULOREpjerY1Wstc+rYi8In+bP/IHJgeujBUvEwK1ewr
 9DJ3SVJf5g84K6s4ffN+TsvSaZSRUK3qNDWsVmxbPJGhd5dU8+VQZRAEHGtOXmjCPwkf
 NRTYXr9WGJuIOX/CyGeJlhsQf/hhJeDhFd3Jx22WJkdbsZD0muCLF0Qxsabh77NN3G5s
 y93Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779647214; x=1780252014;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QTlCGstd3Tpt5Q3cFRMzyAJdfKPbZXLbZ55PiwvoBLI=;
 b=mvW1vtyVwg7mhrk4ibks3nlcNqwaXRzsdSym9IqME+NGj9pNnOvV9bNp3AbrVuZdMq
 bliPyq0jJtQDbIcAzHkwq95z5/QdpEb9lKdruxW1XV0z4n1XWl9bMe9d0wVCEnd2D3Lz
 spKuI3EqtW6fqIL4e4PrWwpbf0PbWX7fhZwSXa3Xsfftn+3LLNBafJgZ/zjg0ga0B/2v
 gzXDwi5ZpH40V0t62rDq1kKZ9Pcj9RUWw08OB8wGJ7hQNoHmmcKKI8lu3GBHaPz2px6m
 E9KZHariMWKXDeHy/Nrt7Xfib1A9IzpM61wkDpmeawd4131b/9Rw3PsX+Ls062TyQKse
 NR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779647214; x=1780252014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTlCGstd3Tpt5Q3cFRMzyAJdfKPbZXLbZ55PiwvoBLI=;
 b=VY4+cXwltPOhPTuFIwk/KOLXjnlEYvgeuOYQIf6YmoU07MIJ/0fviOB4vwEgl8DLkk
 7+oFmlPY60uWhi9wqopavwFivEp5XESGAqprBah0J291eV0xEZd4QCKBQ/+6Gaxkn4iB
 6xwI99DS/odnEHyOPVlHBtXKZWBzFkMJrnjLcOddxVhFLbUpPm6YpoSgRM11D0zBFMz9
 MwgdkVOiZGwhn9O2ILUIWE0YF5+BGzcPye7b/blt6fXhvQXVItkh2e9WZRZ1YljyEXxl
 Ng2jiSsuOcAKtGQNEYwj1ncBmhfYogxzm4TNDs/5xGAkNxHxgtB4wEuiClhaCRmnIsXg
 dUVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YK/jJUN1HWNnqWhTMPjJn5kFuCNICjADF+hmUgqJjGv3kjcHv9aca4nPRzCZ6aFzakz4nKLBX57hZ@nongnu.org
X-Gm-Message-State: AOJu0YwNY7hJm9yCJ/jld8ZVB/2L/CfrPJzlWwcok+tvzFk+rwiK2uZF
 +0qHOx63ZC5Uu3VvfSzd1ZZu1p1hvaMd0MoC2cl0xGCKyzJ9IGSGwGJmDRLs/4ztz15nREKabYB
 ZlwGpGb4+i/78/x5U7CDJI+XFLdb6lWB5PLeFsQ35XQ==
X-Gm-Gg: Acq92OEF0Jr66zTxzGfMI3drMR6dIHpONCxKgP8ta7AQhacKODuP+oXXNjnUCypMjZp
 cqmzwdE7nkTBNyHzLdcVNDQcfWH2uoBvQsdFegr9a3JtdK0o1IlAJI34xYU+fjzqXu6snoA+Sed
 TXeNa1qLdLRP+V+QfsGBLJw6EZan0ph7zXCSXufrOW0h5evv9vIk1+w+QEfhK3te4wyql+T6Cdm
 wtcYxi44ZTSX0Pi9samW1Mxwt4TexfnU4A7ep59pEGdBeSQprtYjt/+APwkomAs0j9d/qb5OeMg
 lKNXeGYg/alWggXl3yKO7unTFSjO+R4jhTy+yaV6OxfKSg==
X-Received: by 2002:a17:90b:5845:b0:35d:a861:36de with SMTP id
 98e67ed59e1d1-36a67654fd0mr11598771a91.24.1779647213981; Sun, 24 May 2026
 11:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
In-Reply-To: <87v7ccd9eh.fsf@draig.linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 24 May 2026 12:26:43 -0600
X-Gm-Features: AVHnY4IszO2B69GuAiuxWYkHBpd8CAufRPp2OdpPwBHldpY6KGElf_AO-rxZuGU
Message-ID: <CANCZdfoEWBxjMXof7fPLnwL6=KfWys=fNg4tP8b+pFuhZZd-dg@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: multipart/alternative; boundary="00000000000003e54506529468c7"
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102c.google.com
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

--00000000000003e54506529468c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 11:08=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
> > So, I had to reject a perfectly reasonable patch:
> >
> https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ion=
os.com/
> > just because of a tool used to make it.
> >
> >
> >       How contributors could comply with DCO terms (b) or (c) for the
> output of AI
> >       content generators commonly available today is unclear.  The QEMU
> project is
> >       not willing or able to accept the legal risks of non-compliance.
>
> In the linked case the LLM is basically doing a glorified search and
> replace. There seems to be no danger of accidentally regurgitating any
> training data which is where the worry about inadvertent copyright
> infringement comes from.
>

Yes. The LLM copying code thing is so two years ago. LLMs don't do
this anymore. They are just glorified pattern matchers, and generate
based on the patterns they know. While there may be a tiny risk here,
there's a greater risk today from humans doing this w/o attribution.


> That said in my experience generally any code that does come out from
> these tools tends to match the local code style and patterns pretty
> well. As a general purpose boilerplate generator they are probably
> better than a lot of people at this point.
>
> There has been some case law now that says LLM output could be
> un-copyrightable depending on how involved the user was in the iteration
> of the code. I suspect there is still more to come.
>

So let's be clear here, because it matters. The output of LLMs is in the
public domain because there's not a human author. Why would that matter?
I ask because there's large parts of the linux kernel that cannot enjoy
copyright
protection because they are mere facts (like tables of register writes to
initialize
a device). That doesn't stop the author from including the public domain
code into
the linux kernel (or FreeBSD or whatever). There are elements that can be
protected
by copyright and elements that can't. However, it's perfect acceptable to
include public domain material in your copyrighted works. Adding LLM
generated
code, assuming it's unmodified, would be just that. Just like Disney did
with a
zillion movies. And most of the time when I use LLM output, I modify it a
bit
to be better. The LLM generation is close, but not quite right. It really
is a so-so
junior engineer that's a bit too keen on following rules.

But anyway, the public domain aspect doesn't matter for us. Either there's
no
copyright, in which case people can copy it w/o a license. Or there is, and
we grant
one that's very permissive in what it allows. Folding the public domain
code into
projects is a time-honored tradition. Why would LLMs change this dynamic?


> >
> >
> > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> > published this piece:
> >
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-na=
vigating-legal-issues
> >
> >
> > Saying, in particular "
> >       We understand this concern, but the DCO has never
> >       been interpreted to require that every line of a contribution mus=
t
> be
> >       the personal creative expression of the contributor or another
> human
> >       developer.
> > "
> >
> > I propose adopting linux's rules instead:
> > https://docs.kernel.org/process/coding-assistants.html
> >
> > which boils down to attribution.
>
> attribution and *ownership*. I think the key point of the policy is to
> make the actual engineer signing the DCO the responsible one for
> generating, testing and validating the code. It is strongly trying to
> suggest that vibe-coded slop isn't wanted.
>

But the DCO is correct here. If I take public domain code, and hack
it I can still legitimately do a SOB.

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

So if I use LLM, and change it even a little, it's created in part by me.
And
if it's public domain, I have the right to submit it under any license I
like.
And the parts I created, I absolutely have the right to copyright and
contribute
under any terms I like. There's no new ground here.


> I still have concerns about the quality of the code and the
> "understanding" these models have. They can generate very convincing
> rationales for their decisions but they also are prone to being
> over-verbose and over-complicating the solutions. They have a tendency
> to chase down rabbit holes in the code and get lost while making wilder
> and more invasive changes to try and get things working.
>

Yes. One of the reasons that submitters need to explain (or be able to)
every line and justify it in a debate in the context of the larger project.
Though that's no different than today: we get submissions of varying
quality from people that have varing degrees of competence. The code
review process is supposed to set a minimum floor for code quality.
LLMs are no different: the originator has to be able to justify and explain
things here.


> That said for personal scripts or random experiments the ability to
> quickly get to a PoC is pretty great.
>
> I think there is also scope for using LLMs for things that aren't
> directly writing code:
>
>   - code review
>   - investigation
>   - generating test cases
>   - polishing documentation
>
> and I wonder if we should spend some more time investigating the
> performance and pitfalls of LLMs before we open the flood gates to the
> code.
>

I wouldn't open the floodgates. I would however expect the policy to
understand
that llm assist in generating code produces results that meet the minimum
quality expectations. But also understand that these tools can be a firehos=
e
of information that's hard to filter. The problem with LLMs has always been
one
of verification. It takes a lot of time to know if they are right. Often
times a lot more
time than the traditional submission because LLM generated pull requests
that I've
seen in FreeBSD tend to be super verbose, with all kinds of irrelevant
detail
thrown in. And yet, the underlying changes are at least "close enough to
review".
We're struggling in that sister open source project on how to cope,
honestly,
and caution is likely called for, but bans when there's a sliding scale of
LLM
use likely aren't.

In my bsd-user upstreaming, Claude has been great at code review, and at
suggesting changes. I often do a change and then ask claude how it would
fix the issue. Quite often they are the same thing. And claude is good abou=
t
reviewing my fix for the issue. I'm sure, though, it's missing a lot of
bigger
picture things, but that's what I'm for.

So maybe a good middle ground might be to allow claude for things that
are low risk:
- Things sed or coccinelle  can do
- Minor bug fixes with human written commit messages
- Minor feature tweaks (say < 200 lines)
- All things test an CI (well, maybe not that wide, but much wider in the
CI space)
- Generation of tools that build the system, though with extra vetting
- other grunt tasks (like my upstreaming stuff, but I'm sure there's other
areas that don't involve generation of large amounts of creative works).
Coupled with a strong requirement for quality and standing behind the
patch. Maybe with extra scrutiny in the reviews (though, the reviews
I've gotten for bsd-user, while quite useful, have been tougher than
I've seen in many other places).

I like Linux's rules, generally, though we can have the door less open.
It's one reason I added the Assisted-by: claude lines in my bsd-user
reivews. Claude did the grunt work of git blame and slicing and dicing
the patches (which it got mostly right, after feedback, I have some
work to do to re-slice a few things). It also reviewed and I fixed
several real issues, as well as a bunch of "logical" issues where
I used host instaed of target things or vice versa.

Warner


> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--00000000000003e54506529468c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 24,=
 2026 at 11:08=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">&quot;Michael S. Tsirkin&quot; &lt;<a h=
ref=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; writ=
es:<br>
<br>
&gt; So, I had to reject a perfectly reasonable patch:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/20260320193746.242704-1-=
jinpu.wang@ionos.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/</a><br>
&gt; just because of a tool used to make it.<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0How contributors could comply with DCO terms=
 (b) or (c) for the output of AI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0content generators commonly available today =
is unclear.=C2=A0 The QEMU project is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0not willing or able to accept the legal risk=
s of non-compliance.<br>
<br>
In the linked case the LLM is basically doing a glorified search and<br>
replace. There seems to be no danger of accidentally regurgitating any<br>
training data which is where the worry about inadvertent copyright<br>
infringement comes from.<br></blockquote><div><br></div><div>Yes. The LLM c=
opying code thing is so two years ago. LLMs don&#39;t do</div><div>this any=
more. They are just glorified pattern matchers, and generate</div><div>base=
d on the patterns they know. While there may be a tiny risk here,</div><div=
>there&#39;s a greater risk today from humans doing this w/o attribution.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
That said in my experience generally any code that does come out from<br>
these tools tends to match the local code style and patterns pretty<br>
well. As a general purpose boilerplate generator they are probably<br>
better than a lot of people at this point.<br>
<br>
There has been some case law now that says LLM output could be<br>
un-copyrightable depending on how involved the user was in the iteration<br=
>
of the code. I suspect there is still more to come.<br></blockquote><div><b=
r></div><div>So let&#39;s be clear here, because it matters. The output of =
LLMs is in the</div><div>public domain because there&#39;s not a human auth=
or. Why would that matter?</div><div>I ask because there&#39;s large parts =
of the linux kernel that cannot enjoy copyright</div><div>protection becaus=
e they are mere facts (like tables of register writes to initialize</div><d=
iv>a device). That doesn&#39;t stop the author from including the public do=
main code into</div><div>the linux kernel (or FreeBSD or whatever). There a=
re elements that can be protected</div><div>by copyright and elements that =
can&#39;t. However, it&#39;s perfect acceptable to</div><div>include public=
 domain material in your copyrighted works. Adding LLM generated</div><div>=
code, assuming it&#39;s unmodified, would be just that. Just like Disney di=
d with a</div><div>zillion movies. And most of the time when I use LLM outp=
ut, I modify it a bit</div><div>to be better. The LLM generation is close, =
but not quite right. It really is a so-so</div><div>junior engineer that&#3=
9;s a bit too keen on following rules.</div><div><br></div><div>But anyway,=
 the public domain aspect doesn&#39;t matter for us. Either there&#39;s no<=
/div><div>copyright, in which case people can copy it w/o a license. Or the=
re is, and we grant</div><div>one that&#39;s very permissive in what it all=
ows. Folding the public domain code into</div><div>projects is a time-honor=
ed tradition. Why would LLMs change this dynamic?</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt; But, since this was written, Red Hat&#39;s Richard Fontana and Chris W=
right<br>
&gt; published this piece:<br>
&gt; <a href=3D"https://www.redhat.com/en/blog/ai-assisted-development-and-=
open-source-navigating-legal-issues" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navig=
ating-legal-issues</a><br>
&gt;<br>
&gt;<br>
&gt; Saying, in particular &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0We understand this concern, but the DCO has =
never<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0been interpreted to require that every line =
of a contribution must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the personal creative expression of the cont=
ributor or another human<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0developer. <br>
&gt; &quot;<br>
&gt;<br>
&gt; I propose adopting linux&#39;s rules instead:<br>
&gt; <a href=3D"https://docs.kernel.org/process/coding-assistants.html" rel=
=3D"noreferrer" target=3D"_blank">https://docs.kernel.org/process/coding-as=
sistants.html</a><br>
&gt;<br>
&gt; which boils down to attribution.<br>
<br>
attribution and *ownership*. I think the key point of the policy is to<br>
make the actual engineer signing the DCO the responsible one for<br>
generating, testing and validating the code. It is strongly trying to<br>
suggest that vibe-coded slop isn&#39;t wanted.<br></blockquote><div><br></d=
iv><div>But the DCO is correct here. If I take public domain code, and hack=
</div><div>it I can still legitimately do a SOB.</div><div><br></div><div><=
pre style=3D"color:rgb(0,0,0)">(a) The contribution was created in whole or=
 in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or
</pre></div><div>So if I use LLM, and change it even a little, it&#39;s cre=
ated in part by me. And</div><div>if it&#39;s public domain, I have the rig=
ht to submit it under any license I like.</div><div>And the parts I created=
, I absolutely have the right to copyright and contribute</div><div>under a=
ny terms I like. There&#39;s no new ground here.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
I still have concerns about the quality of the code and the<br>
&quot;understanding&quot; these models have. They can generate very convinc=
ing<br>
rationales for their decisions but they also are prone to being<br>
over-verbose and over-complicating the solutions. They have a tendency<br>
to chase down rabbit holes in the code and get lost while making wilder<br>
and more invasive changes to try and get things working.<br></blockquote><d=
iv><br></div><div>Yes. One of the reasons that submitters need to explain (=
or be able to)</div><div>every line and justify it in a debate in the conte=
xt of the larger project.</div><div>Though that&#39;s no different than tod=
ay: we get submissions of varying</div><div>quality from people that have v=
aring degrees of competence. The code</div><div>review process is supposed =
to set a minimum floor for code quality.</div><div>LLMs are no different: t=
he originator has to be able to justify and explain</div><div>things here.=
=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
That said for personal scripts or random experiments the ability to<br>
quickly get to a PoC is pretty great.<br>
<br>
I think there is also scope for using LLMs for things that aren&#39;t<br>
directly writing code:<br>
<br>
=C2=A0 - code review<br>
=C2=A0 - investigation<br>
=C2=A0 - generating test cases<br>
=C2=A0 - polishing documentation<br>
<br>
and I wonder if we should spend some more time investigating the<br>
performance and pitfalls of LLMs before we open the flood gates to the<br>
code.<br></blockquote><div><br></div><div>I wouldn&#39;t open the floodgate=
s. I would however expect the policy to understand</div><div>that llm assis=
t in generating code produces results that meet the minimum</div><div>quali=
ty expectations. But also understand that these tools can be a firehose</di=
v><div>of information that&#39;s hard to filter. The problem with LLMs has =
always been one</div><div>of verification. It takes a lot of time to know i=
f they are right. Often times a lot more</div><div>time than the traditiona=
l submission because LLM generated pull requests that I&#39;ve</div><div>se=
en in FreeBSD tend to be super verbose, with all kinds of irrelevant detail=
</div><div>thrown in. And yet, the underlying changes are at least &quot;cl=
ose enough to review&quot;.</div><div>We&#39;re struggling in that sister o=
pen source project on how to cope, honestly,</div><div>and caution is likel=
y called for, but bans when there&#39;s a sliding scale of LLM</div><div>us=
e likely aren&#39;t.</div><div><br></div><div>In my bsd-user upstreaming, C=
laude has been great at code review, and at</div><div>suggesting changes. I=
 often do a change and then ask claude how it would</div><div>fix the issue=
. Quite often they are the same thing. And claude is good about</div><div>r=
eviewing my fix for the issue. I&#39;m sure, though, it&#39;s missing a lot=
 of bigger</div><div>picture things, but that&#39;s what I&#39;m for.</div>=
<div><br></div><div>So maybe a good middle ground might be to allow claude =
for things that</div><div>are low risk:</div><div>- Things sed or coccinell=
e=C2=A0 can do</div><div>- Minor bug fixes with human written commit messag=
es</div><div>- Minor feature tweaks (say &lt; 200 lines)</div><div>- All th=
ings test an CI (well, maybe not that wide, but much wider in the CI space)=
</div><div>- Generation of tools that build the system, though with extra v=
etting</div><div>- other grunt tasks (like my upstreaming stuff, but I&#39;=
m sure there&#39;s other</div><div>areas that don&#39;t involve generation =
of large amounts of creative works).</div><div>Coupled with a strong requir=
ement for quality and standing behind the</div><div>patch. Maybe with extra=
 scrutiny in the reviews (though, the reviews</div><div>I&#39;ve gotten for=
 bsd-user, while quite useful, have been tougher than</div><div>I&#39;ve se=
en in many other places).</div><div><br></div><div>I like Linux&#39;s rules=
, generally, though we can have the door less open.</div><div>It&#39;s one =
reason I added the Assisted-by: claude lines in my bsd-user</div><div>reive=
ws. Claude did the grunt work of git blame and slicing and dicing</div><div=
>the patches (which it got mostly right, after feedback, I have some</div><=
div>work to do to re-slice a few things). It also reviewed and I fixed</div=
><div>several real issues, as well as a bunch of &quot;logical&quot; issues=
 where</div><div>I used host instaed of target things or vice versa.</div><=
div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--00000000000003e54506529468c7--


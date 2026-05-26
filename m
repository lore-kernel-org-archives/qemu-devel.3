Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366ECCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxpB-00013K-FC; Tue, 26 May 2026 15:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRxp9-00010I-Mr
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:52:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRxp5-0001xb-NC
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:52:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8173b2af32so8517611a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779825137; cv=none;
 d=google.com; s=arc-20240605;
 b=SHrEC5JX5pQF088XBWWb3wQ90QIgJFp52WNNGTvbN6J3EVOJTNRG0KQZwnZnfNjT83
 qPhA26fG41dmRSBxXvUEl22SMWyGutBZ8xqIQ7jPO1Swqg1LX5aK0OlwZXSejV7Mdfba
 pYvFu+Bb5RhUHgah3k+a3oQJbCKY1AtPxIbbkzRAcVgmkT2tjny8y2b5D9rStgU1sj+9
 qQ7dComFyys8YUxIFQo/EUz7t0DjX0KUIrR5xWZbTJ3PeP2CLstPSXMKKzbUZ7qT+VGa
 9EDGrtBGnjITN6oLdKUr4vHg/iaRH8R5NuY3O3oHWEum8TfhFOzGTPLzx2mrnQ5pr/0H
 Himw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q+RSwEONK+xZJKpi3tEUIHh36LL02VTNr6K07I6DOa0=;
 fh=LWUv3yUHY/tCaWYkmExoPDTeEOFCJ//muXNznv9stkM=;
 b=j2mFHk5fLY7KETHGGNWJ1iBJ6wbXZ8AEMbxSx17/Z9rd2m5VLlb012cu5RzPW8dtVs
 wO5Dnpw26WL0nNWfed0BTjPtuP0/rJbnvDb92xEnmw4LHkYlXGKaQ40dK0VmaonzhpB1
 +vPfQZCa4txwbRbNEAxsKQms/jp3LJUEOu3IVREeKdGM6Do1IoPCrIAuVy02NXhIublV
 okXD3l4Y5XIFEq3SBVifUTdUkaDOVMpwpSVtwvpI1ADZQWxpe3sdBfXDrZSNCnCs293q
 Rn/wYQMCN68e1iq2gxEKW2i57ZWCMcWYqUfrY2zGSTY4vo/C5rj/PLFiINVHJQeewHPO
 MUSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779825137; x=1780429937;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q+RSwEONK+xZJKpi3tEUIHh36LL02VTNr6K07I6DOa0=;
 b=ghxOuNkVnMMa4CwGVX3hVKjYoGB7omy0wzo0cE5gwIKagTWTCJjboDX15M51yti2N2
 Mf8sDBXL8ojln7swcK2bmXmxqshav62HPNO2vOy1y1IpzyCe95R2wXTsftHfi6LkCDg4
 7/Mc/O9ba8Wv3emnBvN//l2t8PW60mk90hW/oaqUhLLp3Ssm3+QHYB6WF6w1rbSf9MEM
 5p4viXEGpBfxY9GG7B74hvQ5vdPUwJxcgAzT0gvohxepxs299Dle2dKQnE8AzMqMYbhR
 /m8tQx+S4OgU9qGVRdH5+aNRMpX1/CaS8kUTNIwQjn+X3SRGsCK+KA3DJEVp2kT5XZz8
 ALTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779825137; x=1780429937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+RSwEONK+xZJKpi3tEUIHh36LL02VTNr6K07I6DOa0=;
 b=qVo2WXbmK+VwnfWNRr7c8BDNqzg4loCZvl4H22UdE/XD257m+lGyY1eyhQDa8ReC81
 kYcT3q5+PCfLDnl2xagDFHhJOjNJJ8HDbtXqLm5y77+WjubCM01vPkNJqqhm7//romrM
 kZ8ew7YuqeVR0cwPwirQIRERTXuHnmr29NpZdvzeWWMnUvdcT2DpUzqPEXKSXXnSo6oi
 OnDDleEP4u6QYbrUyiQ2586EBQjHYkpF1lv/rVXQr3Ce7IMUMd2yN2gUBvzL3t4nqW6o
 Y/IwPWMFZv8WcwMOZCzUawMMX37lX+YhYXLOQuOOtlBGdtw74DSdTUQLHH8xy8NEfTXF
 wZZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aRu29j7hhrwNr03T8TxFdSepG0S1TJcevjD5vXKqyKASx4qPc6jKSz+qBm9D6MTlg5ivBs0/QXGzm@nongnu.org
X-Gm-Message-State: AOJu0Yzp4F+RtIbzSkCy1uaGqQ2LY2suc59mN/358QsbM+5V8wAFBF6Q
 5fz+Xwct+yNxdDs5uO8U+I6CBjUMkOEMzmb4ixFRiv5X6HJYehP1G3tuvNFR5SLHiPUvZd3WVLS
 dWlciKv/KXO3O4vYeiM48CDOo5aqru2MXozH70W0qkA==
X-Gm-Gg: Acq92OEevqTg3skrQ5tg+zsOJKmC6jSBFelOm1F4QhtzF/ed9dzoFg7Ynhxp3AKKeiy
 iHTOmKsDeR7PwtXnYtNHbgchLenE1XWCj/XAANWZXaX1KS6vI8TAYPQl17edKDIZqsi4veAI3Pf
 n5HU9HMCreeRGgdpBiOYR245RM61yCGrogB0rwpq7EWc6+HQ/UHeuAARa44wKxdoCgx1d2jy9gG
 KbbrIdEV1pS/fx9meVNn7vSaRdfDYeRSoZuZTvCCSl2XPdDz8UN4d+XCmnZtk8dwjCWsowIjur7
 r+P1Ti5OyGmU+HMfsA==
X-Received: by 2002:a05:6a21:3a87:b0:398:89b6:1b41 with SMTP id
 adf61e73a8af0-3b328ecee16mr20179298637.32.1779825137116; Tue, 26 May 2026
 12:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260526152526-mutt-send-email-mst@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 May 2026 13:52:05 -0600
X-Gm-Features: AVHnY4J-1spQazIqCIvX0ZPYd9NAuZctIQrlzwUeTtvZBrREwcBR1DiiGQ_KyD0
Message-ID: <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000f7ab70652bdd5d6"
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x536.google.com
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

--0000000000000f7ab70652bdd5d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Tue, May 26, 2026 at 08:59:55PM +0200, Kevin Wolf wrote:
> > Am 26.05.2026 um 20:03 hat Michael S. Tsirkin geschrieben:
> > > On Tue, May 26, 2026 at 07:43:35PM +0200, Kevin Wolf wrote:
> > > > Am 24.05.2026 um 14:42 hat Michael S. Tsirkin geschrieben:
> > > > > So, I had to reject a perfectly reasonable patch:
> > > > >
> https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ion=
os.com/
> > > > > just because of a tool used to make it.
> > > > >
> > > > >
> > > > >         How contributors could comply with DCO terms (b) or (c)
> for the output of AI
> > > > >         content generators commonly available today is unclear.
> The QEMU project is
> > > > >         not willing or able to accept the legal risks of
> non-compliance.
> > > > >
> > > > >
> > > > > But, since this was written, Red Hat's Richard Fontana and Chris
> Wright
> > > > > published this piece:
> > > > >
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-na=
vigating-legal-issues
> > > > >
> > > > >
> > > > > Saying, in particular "
> > > > >         We understand this concern, but the DCO has never
> > > > >         been interpreted to require that every line of a
> contribution must be
> > > > >         the personal creative expression of the contributor or
> another human
> > > > >         developer.
> > > > > "
> > > >
> > > > I never found that blog post particularly convincing, especially
> because
> > > > they acknowledge a concern:
> > > >
> > > >     There are two versions of this concern. The first is practical:
> that
> > > >     an AI tool could covertly insert excerpts of proprietary (or
> > > >     license-incompatible) code into an open source project,
> potentially
> > > >     creating legal risk for maintainers and users. The second is
> broader
> > > >     and more philosophical: that large language models, trained on
> vast
> > > >     amounts of open source software, are essentially misappropriati=
ng
> > > >     the community=E2=80=99s work, producing outputs stripped of the
> obligations
> > > >     that open source licenses require.
> > > >
> > > >     We think these concerns deserve to be taken seriously.
> > > >
> > > > The second one is essentially what I understood the QEMU policy to =
be
> > > > about. Unfortunately, the blog post then goes on to only ever deal
> with
> > > > the first one and ignore the second one that seems more relevant fo=
r
> us.
> > > >
> > > > So yes, the DCO isn't about "personal creative expression" or
> whatever
> > > > (and nobody suggested it is, this is a strawman), but it's about
> whether
> > > > the submitter has the legal rights to submit the code. And that's
> > > > exactly the question we decided we don't want to take a risk on.
> > > >
> > > >
> > > > So if that part isn't helpful, what has changed since we introduced
> the
> > > > AI policy? It's a few points:
> > > >
> > > > 1. While AI has been in use for a while now, we haven't seen projec=
ts
> > > >    accepting AI generated code/content get into big trouble. While =
it
> > > >    could still happen in the future, it might be an indication that
> the
> > > >    probability of the risk hitting us is not that high.
> > > >
> > > > 2. The useful part of the blog post is that it tells us that Red Ha=
t
> > > >    considers the risk acceptable. This can inform our assessment of
> the
> > > >    risks, though of course there might be a significant difference =
in
> > > >    the impact of the risk for a company with a legal department and
> an
> > > >    open source community consisting mainly of developers acting as
> > > >    individuals.
> > > >
> > > >    I think it's obvious that if the QEMU project gets involved in a
> > > >    legal case, we have a problem (at the very least long lasting
> > > >    distraction from actual work on QEMU), even if we didn't do
> anything
> > > >    wrong and a good lawyer would easily win the case.
> > > >
> > > > 3. It was easy to just outright ban AI while its results were usual=
ly
> > > >    not really usable anyway. This has changed meanwhile, so it's mu=
ch
> > > >    harder to maintain an absolute ban.
> > > >
> > > >    It's not really the best use of my time to look at the idea in
> > > >    AI-generated test cases and then rewrite them from scratch so I
> can
> > > >    actually submit them. (On the other hand, I think my rewritten
> > > >    submissions were always better and more maintainable than what A=
I
> > > >    produced initially, so there's that.)
> > > >
> > > > So while my perspective is a lot more nuanced than yours, I do see =
a
> > > > shift in the balance and was actually thinking of suggesting a
> change of
> > > > the policy myself.
> > > >
> > > > What I was thinking of was allowing AI-generated content in places
> where
> > > > it's at least easy to revert if there is ever a problem with it:
> Tests,
> > > > documentation etc., but not core code that lots of other things
> depend
> > > > on and that will have evolved a lot when we notice a problem and fo=
r
> > > > which throwing away is simply not an option.
> > >
> > > OK. what about trivial changes? Using AI as a better sed?
> >
> > The above is just what I was thinking of suggesting myself. I didn't
> > mean to imply that I'm opposed to anything else, but just thought I'd
> > post it as an example of fairly obvious things we could allow.
> >
> > Of course, it also shows my own pain points. I don't see that much use
> > in it for generating code for QEMU proper, because these changes tend t=
o
> > be few lines and I have an opinion on each of the lines - tests are the
> > opposite, lots of boilerplate and I don't care much how elegant they
> > are because nothing else will build on them anyway.
> >
> > So yes, trivial patches is another obvious starting point. The challeng=
e
> > there is defining the line where a patch stops being trivial. So I'm no=
t
> > completely sure if making this distinction in a policy is a good idea;
> > maybe practically speaking it has to be all or nothing in terms of
> > creativity (for lack of a better word).
>
> Let the maintainers decide?
>
> Or we can enumerate things:
> - fixing tool (compiler/checkpatch/smatch) errors/warnings in obvious way=
s
> (e.g. suggested by the
>   tools itself, such as initializing an uninitialized variable)
> - propagating API changes (e.g. rebasing a patch after an API change)
> - anything that could be done by a perl/sed/coccinelle script
> - adding or fixing code comments
>

Those are good examples. Perhaps the following words are good place to star=
t
to frame what I've seen expressed here:

The QEMU Project currently may accept limited uses of AI that produce high
quality patches that are limited in the creative content added. While
maintainers
will ultimately decide, changes like the following fall within this policy
1. Fixing obvious warnings in the obvious ways suggested by the tool
2. Tree wide API changes, and other similar mechanical changes done today
with
     perl/python/sed/coccinelle
3. Limited, small changes to fix bugs or add a small new feature whose
scope is
    less than about 100 lines and the originator can explain them all or
the meta
    issues about the patch.
Maintainers are free to accept or reject changes outside these guidelines,
but
please check with the maintainers before sending to keep the load from AI
content
to something they can manage. Large and Very Large patches, especailly
ones that have not been deeply analyised and tested by humans, should be
avoided.

Though maybe the list of 'exceptions' needs work. But the basic framing is
that we will accept some, high quality patches. Maintainers have some
discression
for larger pieces to a point, and we still don't want to drown in AI slop.

Warner


>
> > As an aside, personally, I'm not convinced that AI can be a "better
> > sed". If it's really about mechanical changes, I think the resulting
> > patch is much more reviewable if the agent doesn't modify the code, but
> > just generate the sed command line or the Coccinelle patch and that is
> > included in the commit message. Reviewers can then just review that and
> > then reproduce the result themselves for comparison. This is impossible
> > with AI prompts and agents do tend to forget an instance of something t=
o
> > replace here and there, so you do have to review the result carefully.
> >
> > But none of these "better sed" problems need to handled in an AI policy=
.
> > If a patch is hard to review, the maintainer will already reject it on
> > those grounds.
>
> Absolutely.
>
> > > > > I propose adopting linux's rules instead:
> > > > > https://docs.kernel.org/process/coding-assistants.html
> > > > >
> > > > > which boils down to attribution.
> > > >
> > > > What would we actually do with the detailed information? Why do we
> care
> > > > which model was used? Is this helpful commit metadata or is it just
> free
> > > > advertising for a handful of companies?
> > >
> > > I presume, if a specific model is somehow declared "contaminated" so =
we
> > > can locate its output?
> >
> > Contaminated in what respect?
> >
> > Quality? Might be because of malicious intentions or just because the
> > model happens to be bad at a specific question. Review and testing must
> > be able to catch quality problems. I don't think this is different from
> > any other contributions.
> >
> > Copyright? If so, then we're back to "can you really sign the DCO?"
> >
> > Something completely different?
> >
> > > > I think I would see more use in a tag like (better name welcome):
> > > >
> > > >     AI-used-for: [code|tests|docs|commit message]...
> > > >
> > > > Kevin
> > >
> > > I surely don't mind.
> >
> > Great. Let's see what others think.
> >
> > Kevin
>
>
>

--0000000000000f7ab70652bdd5d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 26,=
 2026 at 1:32=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redha=
t.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Tue, May 26, 2026 at 08:59:55PM +0200, Kevin Wolf w=
rote:<br>
&gt; Am 26.05.2026 um 20:03 hat Michael S. Tsirkin geschrieben:<br>
&gt; &gt; On Tue, May 26, 2026 at 07:43:35PM +0200, Kevin Wolf wrote:<br>
&gt; &gt; &gt; Am 24.05.2026 um 14:42 hat Michael S. Tsirkin geschrieben:<b=
r>
&gt; &gt; &gt; &gt; So, I had to reject a perfectly reasonable patch:<br>
&gt; &gt; &gt; &gt; <a href=3D"https://lore.kernel.org/qemu-devel/202603201=
93746.242704-1-jinpu.wang@ionos.com/" rel=3D"noreferrer" target=3D"_blank">=
https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos=
.com/</a><br>
&gt; &gt; &gt; &gt; just because of a tool used to make it.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0How contributors could=
 comply with DCO terms (b) or (c) for the output of AI<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0content generators com=
monly available today is unclear.=C2=A0 The QEMU project is<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not willing or able to=
 accept the legal risks of non-compliance.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; But, since this was written, Red Hat&#39;s Richard Font=
ana and Chris Wright<br>
&gt; &gt; &gt; &gt; published this piece:<br>
&gt; &gt; &gt; &gt; <a href=3D"https://www.redhat.com/en/blog/ai-assisted-d=
evelopment-and-open-source-navigating-legal-issues" rel=3D"noreferrer" targ=
et=3D"_blank">https://www.redhat.com/en/blog/ai-assisted-development-and-op=
en-source-navigating-legal-issues</a><br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Saying, in particular &quot;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We understand this con=
cern, but the DCO has never<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0been interpreted to re=
quire that every line of a contribution must be<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the personal creative =
expression of the contributor or another human<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0developer. <br>
&gt; &gt; &gt; &gt; &quot;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I never found that blog post particularly convincing, especi=
ally because<br>
&gt; &gt; &gt; they acknowledge a concern:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0There are two versions of this concern. T=
he first is practical: that<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0an AI tool could covertly insert excerpts=
 of proprietary (or<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0license-incompatible) code into an open s=
ource project, potentially<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0creating legal risk for maintainers and u=
sers. The second is broader<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0and more philosophical: that large langua=
ge models, trained on vast<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0amounts of open source software, are esse=
ntially misappropriating<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0the community=E2=80=99s work, producing o=
utputs stripped of the obligations<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0that open source licenses require.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0We think these concerns deserve to be tak=
en seriously.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The second one is essentially what I understood the QEMU pol=
icy to be<br>
&gt; &gt; &gt; about. Unfortunately, the blog post then goes on to only eve=
r deal with<br>
&gt; &gt; &gt; the first one and ignore the second one that seems more rele=
vant for us.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; So yes, the DCO isn&#39;t about &quot;personal creative expr=
ession&quot; or whatever<br>
&gt; &gt; &gt; (and nobody suggested it is, this is a strawman), but it&#39=
;s about whether<br>
&gt; &gt; &gt; the submitter has the legal rights to submit the code. And t=
hat&#39;s<br>
&gt; &gt; &gt; exactly the question we decided we don&#39;t want to take a =
risk on.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; So if that part isn&#39;t helpful, what has changed since we=
 introduced the<br>
&gt; &gt; &gt; AI policy? It&#39;s a few points:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 1. While AI has been in use for a while now, we haven&#39;t =
seen projects<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 accepting AI generated code/content get into bi=
g trouble. While it<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 could still happen in the future, it might be a=
n indication that the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 probability of the risk hitting us is not that =
high.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 2. The useful part of the blog post is that it tells us that=
 Red Hat<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 considers the risk acceptable. This can inform =
our assessment of the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 risks, though of course there might be a signif=
icant difference in<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 the impact of the risk for a company with a leg=
al department and an<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 open source community consisting mainly of deve=
lopers acting as<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 individuals.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 I think it&#39;s obvious that if the QEMU proje=
ct gets involved in a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 legal case, we have a problem (at the very leas=
t long lasting<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 distraction from actual work on QEMU), even if =
we didn&#39;t do anything<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 wrong and a good lawyer would easily win the ca=
se.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 3. It was easy to just outright ban AI while its results wer=
e usually<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 not really usable anyway. This has changed mean=
while, so it&#39;s much<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 harder to maintain an absolute ban.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 It&#39;s not really the best use of my time to =
look at the idea in<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 AI-generated test cases and then rewrite them f=
rom scratch so I can<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 actually submit them. (On the other hand, I thi=
nk my rewritten<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 submissions were always better and more maintai=
nable than what AI<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 produced initially, so there&#39;s that.)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; So while my perspective is a lot more nuanced than yours, I =
do see a<br>
&gt; &gt; &gt; shift in the balance and was actually thinking of suggesting=
 a change of<br>
&gt; &gt; &gt; the policy myself.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; What I was thinking of was allowing AI-generated content in =
places where<br>
&gt; &gt; &gt; it&#39;s at least easy to revert if there is ever a problem =
with it: Tests,<br>
&gt; &gt; &gt; documentation etc., but not core code that lots of other thi=
ngs depend<br>
&gt; &gt; &gt; on and that will have evolved a lot when we notice a problem=
 and for<br>
&gt; &gt; &gt; which throwing away is simply not an option.<br>
&gt; &gt; <br>
&gt; &gt; OK. what about trivial changes? Using AI as a better sed?<br>
&gt; <br>
&gt; The above is just what I was thinking of suggesting myself. I didn&#39=
;t<br>
&gt; mean to imply that I&#39;m opposed to anything else, but just thought =
I&#39;d<br>
&gt; post it as an example of fairly obvious things we could allow.<br>
&gt; <br>
&gt; Of course, it also shows my own pain points. I don&#39;t see that much=
 use<br>
&gt; in it for generating code for QEMU proper, because these changes tend =
to<br>
&gt; be few lines and I have an opinion on each of the lines - tests are th=
e<br>
&gt; opposite, lots of boilerplate and I don&#39;t care much how elegant th=
ey<br>
&gt; are because nothing else will build on them anyway.<br>
&gt; <br>
&gt; So yes, trivial patches is another obvious starting point. The challen=
ge<br>
&gt; there is defining the line where a patch stops being trivial. So I&#39=
;m not<br>
&gt; completely sure if making this distinction in a policy is a good idea;=
<br>
&gt; maybe practically speaking it has to be all or nothing in terms of<br>
&gt; creativity (for lack of a better word).<br>
<br>
Let the maintainers decide?<br>
<br>
Or we can enumerate things:<br>
- fixing tool (compiler/checkpatch/smatch) errors/warnings in obvious ways =
(e.g. suggested by the<br>
=C2=A0 tools itself, such as initializing an uninitialized variable)<br>
- propagating API changes (e.g. rebasing a patch after an API change)<br>
- anything that could be done by a perl/sed/coccinelle script<br>
- adding or fixing code comments<br></blockquote><div><br></div><div>Those =
are good examples. Perhaps the following words are good place to start</div=
><div>to frame what I&#39;ve seen expressed here:</div><div><br></div><div>=
The QEMU Project currently may accept limited uses of AI that produce high<=
/div><div>quality patches that are limited in the creative content added. W=
hile maintainers</div><div>will ultimately decide, changes like the followi=
ng fall within this policy</div><div>1. Fixing obvious warnings in the obvi=
ous ways suggested by the tool</div><div>2. Tree wide API changes, and othe=
r similar mechanical changes done today with</div><div>=C2=A0 =C2=A0 =C2=A0=
perl/python/sed/coccinelle</div><div>3. Limited, small changes to fix bugs =
or add a small new feature whose scope is</div><div>=C2=A0 =C2=A0 less than=
 about 100 lines and the originator can explain them all or the meta</div><=
div>=C2=A0 =C2=A0 issues about the patch.</div><div>Maintainers are free to=
 accept or reject changes outside these guidelines, but</div><div>please ch=
eck with the maintainers before sending to keep the load from AI content</d=
iv><div>to something they can manage. Large and Very Large patches, especai=
lly</div><div>ones that have not been deeply analyised and tested by humans=
, should be</div><div>avoided.</div><div><br></div><div>Though maybe the li=
st of &#39;exceptions&#39; needs work. But the basic framing is</div><div>t=
hat we will accept some, high quality patches. Maintainers have some discre=
ssion</div><div>for larger pieces to a point, and we still don&#39;t want t=
o drown in AI slop.</div><div><br></div><div>Warner</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; As an aside, personally, I&#39;m not convinced that AI can be a &quot;=
better<br>
&gt; sed&quot;. If it&#39;s really about mechanical changes, I think the re=
sulting<br>
&gt; patch is much more reviewable if the agent doesn&#39;t modify the code=
, but<br>
&gt; just generate the sed command line or the Coccinelle patch and that is=
<br>
&gt; included in the commit message. Reviewers can then just review that an=
d<br>
&gt; then reproduce the result themselves for comparison. This is impossibl=
e<br>
&gt; with AI prompts and agents do tend to forget an instance of something =
to<br>
&gt; replace here and there, so you do have to review the result carefully.=
<br>
&gt; <br>
&gt; But none of these &quot;better sed&quot; problems need to handled in a=
n AI policy.<br>
&gt; If a patch is hard to review, the maintainer will already reject it on=
<br>
&gt; those grounds.<br>
<br>
Absolutely.<br>
<br>
&gt; &gt; &gt; &gt; I propose adopting linux&#39;s rules instead:<br>
&gt; &gt; &gt; &gt; <a href=3D"https://docs.kernel.org/process/coding-assis=
tants.html" rel=3D"noreferrer" target=3D"_blank">https://docs.kernel.org/pr=
ocess/coding-assistants.html</a><br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; which boils down to attribution.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; What would we actually do with the detailed information? Why=
 do we care<br>
&gt; &gt; &gt; which model was used? Is this helpful commit metadata or is =
it just free<br>
&gt; &gt; &gt; advertising for a handful of companies?<br>
&gt; &gt; <br>
&gt; &gt; I presume, if a specific model is somehow declared &quot;contamin=
ated&quot; so we<br>
&gt; &gt; can locate its output?<br>
&gt; <br>
&gt; Contaminated in what respect?<br>
&gt; <br>
&gt; Quality? Might be because of malicious intentions or just because the<=
br>
&gt; model happens to be bad at a specific question. Review and testing mus=
t<br>
&gt; be able to catch quality problems. I don&#39;t think this is different=
 from<br>
&gt; any other contributions.<br>
&gt; <br>
&gt; Copyright? If so, then we&#39;re back to &quot;can you really sign the=
 DCO?&quot;<br>
&gt; <br>
&gt; Something completely different?<br>
&gt; <br>
&gt; &gt; &gt; I think I would see more use in a tag like (better name welc=
ome):<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0AI-used-for: [code|tests|docs|commit mess=
age]...<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Kevin<br>
&gt; &gt; <br>
&gt; &gt; I surely don&#39;t mind.<br>
&gt; <br>
&gt; Great. Let&#39;s see what others think.<br>
&gt; <br>
&gt; Kevin<br>
<br>
<br>
</blockquote></div></div>

--0000000000000f7ab70652bdd5d6--


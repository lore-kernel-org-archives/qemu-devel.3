Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A6DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHj4-0004yc-QR; Wed, 27 May 2026 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHj0-0004y9-Kc
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:07:22 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHix-00066v-4B
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:07:22 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36b7b7b7a80so12266a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779901637; cv=none;
 d=google.com; s=arc-20240605;
 b=SDyQyKx2dNBIoomCDSsE/ckHSu+/xQi3IuE8YXXwPBzeYhWJd0T/E2PbD5tuqE/QyJ
 ctNSp85CkHk1RyYBm//MyLCdATAomHgJXZXNH/WXCGs5u9jBzJkB+IAeHa9DULuuICox
 nHtbaPvroaj+KT3tZ0NT/QrfBY5WDHV8qVQOrLicLQcPbLZJHO+3Otbo8VBQzus/97OL
 B19E1AnjvyKD3JPX2pHD7ptTDEO0t8OW6Ldf3F9GDUKKovboRQkdfDR+M2vuQyml969G
 WTY0Fw3YM2PsydFoDBvSgdXigIIS75NIxww1zV2JnqkGukg6TWT7O9VKL8oyp7uVETGo
 4L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AEE7RcDVkKpNar46FzDsTga373FF9qa2aqMFuRqa/j0=;
 fh=NzSkcYxtTj2V/K3h2+va8OaIo+GdpBd8DI/5k6FypA8=;
 b=Df7b1l+dn1+2AMCSv8iHJeko7YGEM77tUnxO9FzFFVkd7vhvEphik2s5UzllGKH5TZ
 cOuFB9puyouC5I+jSKCxTZk1pkbA4EzsH9CvEnqKV8Q6vb/7tvN3HjejhaveWHdK5fVY
 OMYYlaERsNduRJ8VeogsmPRCZnGqfGXILvs3G/ZEz2V8r9TPD2EfSDzNYXzUuB1yLu+t
 3a/tomX3oRmMk2+smlq7la1yK5kewdk4H7eJhyj3reaB5WbRmWZM8jWb03+Kc9x55c8k
 +oE6as4wC3nFpQh4YuH5a0iiEItgYk8rvfhKttMVixTpFxKSffTGCjx6fUWFDySTuxGP
 2O+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779901637; x=1780506437;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AEE7RcDVkKpNar46FzDsTga373FF9qa2aqMFuRqa/j0=;
 b=B8Q/7555uUJL91GzrKHO6rsHuIY4rsfuD3N/Z+Ytp/ocA4B2X/wNY+yIu3fi+Eued+
 BqzSBHeREqJn4gwg6gbV04zeFXHt33Jq4BR1bDB2rYGZMEiWpZdy/fWw+QcFpMCN9Qri
 xKbJ9uAHVpjQ0YojeDGnkpnPymdafPk2n76AXyY4NPyLqGftGacmvb07/v3l7yOzej4S
 a5vHMC61JfLtZ2wPjkjFiqKldcMRTvW/fEecUtG620jrSog+jGIsPFar9YCzVXrjJDi1
 rvlxuh2HfNeeX8UTaPKZjhXtF7PA/BSk6Baa7XLd9ZArSVodsE0uzrT1zq9HddHrrec1
 ATvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779901637; x=1780506437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEE7RcDVkKpNar46FzDsTga373FF9qa2aqMFuRqa/j0=;
 b=hY+AWZOKvhZoZ+a1WFGhv+VvgaSIbIKYwzWYs9q/6GMw5fjxVppQCpblb1DuQZxhqA
 APTyMMYVnf3IMWEBXu8AzY/5z7sjuW8rqoc98RKzwxy53Us6mE95bLUq0p5iTdodc4Fm
 oCOEBYvJPb0YxJnjO9EIjplp4orDhbF4Ocid+JGHxB3C5jXwtzjWKbltXbJqwPuK4WnW
 gASMGawUkx8+9h8Hb2Pd30g0Xcme9JVICaqDxfpw5UBoX4sknd8uYzZyrkAnc+orEF3O
 38mXufbNgwbfWBmlB6EuIuBDkkOz5fCWDu223Zxe76AtIJW9HPJCLZT9e9RamzCYoEZ9
 7pew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tF8FuXb0F4Q8qkhwsB3ppgrClUWlZNSsf/njNDmeIXEtljEFTkNBuF2Pyy2b696SEEE5fhIIvYF45@nongnu.org
X-Gm-Message-State: AOJu0YxAf0QH0GSyzejao9qfZvNG1BbysCtdKqLoB9eMpJfy7Xk1883N
 64EYzZwpaAtKb7ty2kSUp/gcJxfjvsPjWcBk14aCxvnYwTSBwoHhKbu9iB7Jw03fo/Hvfyy0s5R
 HnnjT/49+s+MBcm39O6gNe5IpUov62DRn1p4BjpSV+Q==
X-Gm-Gg: Acq92OExmW897gFGbq4vMapx57MuAoqijTsHPIMuQ9/5b5Om11bJsUPMEgzEAZ4sM2n
 sdkMhNFDkLhcS12cZvpNGCnmgkkT+ms9Pz+uKy4eB4mVMwK+kqTu2frXB5ThWUa744ByRyJz3EM
 7sfp9xEHIv7mLMfvdHMJ/sDfB933miwVgxU04gPYOQc9Q9owcjvm594jCEJj3WXWhUACz4/FAde
 fAD6xxyTgOtRNpgQ0YcfZ0axZFq5NbWeEdCuOw62z9PfJHtbEjjriZ5h8WbKK+6hPYeGT+CMQIL
 1B0rkjI=
X-Received: by 2002:a17:903:1b0f:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2beb085f72emr221063335ad.13.1779901637349; Wed, 27 May 2026
 10:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com> <20260527123942-mutt-send-email-mst@kernel.org>
 <ahcgxpvXFoPE0C-X@redhat.com>
In-Reply-To: <ahcgxpvXFoPE0C-X@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 27 May 2026 11:07:04 -0600
X-Gm-Features: AVHnY4L9Ykupwz5H8fHbzXiD3C4-zbyWtnzcX24VGArR4OmpIlC57NsPGVXoAy4
Message-ID: <CANCZdfph97VOhQ4xRHrRUAVpuJJDRCYT8zXNu9MWRcXM5PS==A@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d462260652cfa48a"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
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

--000000000000d462260652cfa48a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:50=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:

> Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:
> > On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> > > Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > > > On Wed, May 27, 2026 at 4:01=E2=80=AFAM Paolo Bonzini <pbonzini@red=
hat.com>
> wrote:
> > > > > Commit messages for AI-assisted changes
> > > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > >
> > > > > When AI/LLM tools produce or substantively shape your patch, add =
an
> > > > > ``AI-used-for:`` trailer.  The text of the trailer could be one o=
r
> more
> > > > > of ``code``, ``tests``, ``docs``, ``research``, possibly followed
> by an
> > > > > explanation in parentheses::
> > > > >
> > > > >      AI-used-for: tests, docs
> > > > >      AI-used-for: code
> > > > >      AI-used-for: code (refactoring)
> > > > >      AI-used-for: code (prototype)
> > > > >      AI-used-for: research
> > > > >
> > > > > The trailer is intended as a clarification of your DCO obligation=
s
> as
> > > > > well as to guide reviewers.  It is not intended for minimal
> presence
> > > > > such as autocomplete or asking for a pre-review of the patch, and
> it
> > > > > does not remove your responsibility to understand the changes tha=
t
> you
> > > > > are submitting.
> > > >
> > > > Why invent something new here when Assisted-by: is used elsewhere
> > > > and is likely more familiar to other users.
> > >
> > > Because Assisted-by: gives different information, which at least to m=
e
> > > isn't really interesting at all. It's much more interesting to me if
> the
> > > code I'm looking at is generated, or if you only generated the tests.
> >
> > I personally am interested to know which models work better than others=
.
> > Contributions are about reputation not just code.  I'll learn which
> > models produce better output, just like I learn to trust specific
> > contributors better.
>
> You don't see how well the model worked. What you see is filtered by the
> submitter, and the policy we're discussing is specifically made to make
> sure that bad results never reach the list.
>

You actually do. Bad results will 100% hit the list. Guaranteed. No policy
will stop that. Having the right tag, like the model used, will help train
reviewers
which ones work and which ones don't for their subset of the tree.


> Even for things that do reach the list, Assisted-by: doesn't tell you
> how much of the submission is AI-generated and it also doesn't tell you
> if it's "I used model X and a simple prompt gave me the perfect result
> in the first attempt" or "I used model X and it took me two days of back
> and forth and eventually I just rewrote most of it, but there are a few
> AI-generated lines left".
>

I covered that in my bsd-user cover letter. But in that case I used it
mostly
to move the code from upstream with proper attribution (yes, deterministic
tools could do that, but I wasted a week on trying to write them years ago
and AI is just "move this over" for me now). But then, after I started, I
had
Claude reivew them in thee style of reivews I'd gotten in the past, so it
developed a checklist to do the reviews and at first I had those separate
since they were a joint effort (mostly Claude finding the issue which was
obvious to fix, but I had it re-review my fixes and/or suggest its own). I
merged them after advice that said basically "do what you do for human
reviews: fold them back" so I did that in subsequent reviews.

Also, I've started seeing claude generated submissions for FreeBSD
pull requests. I recognize its style since I've interacted with it so much.
I also recognize other, unknown to me, styles that have different quirks
that I know Claude doesn't do, but that other models do do. I wish I
had the raw data to know which AI tools and models were used since
that cues me to look for certain things (with claude it tends to be it's
insane insistance for printf'ing what's going on to an annoying degree).
And there people have been trying to sneak things in since a preliminary
"no ai" policy leaked out that was never formally approved. I have to
guess at it.


> So what you should trust is the contributor, not an Assisted-by: tag.
>

You should use both to form your opinion. It's not an either-or situation.
I've had conversations with the AI contributors in FreeBSD about how
they use it and tend to ask more questions at review than when AI isn't
used. Knowing what AI was used will help me delve into different things
that I might not otherwise poke at since I know the quirks of at least
a couple tools by now.

Warner

--000000000000d462260652cfa48a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 10:50=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com=
">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben=
:<br>
&gt; On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:<br>
&gt; &gt; Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:<br>
&gt; &gt; &gt; On Wed, May 27, 2026 at 4:01=E2=80=AFAM Paolo Bonzini &lt;<a=
 href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com<=
/a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; Commit messages for AI-assisted changes<br>
&gt; &gt; &gt; &gt; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; When AI/LLM tools produce or substantively shape your p=
atch, add an<br>
&gt; &gt; &gt; &gt; ``AI-used-for:`` trailer.=C2=A0 The text of the trailer=
 could be one or more<br>
&gt; &gt; &gt; &gt; of ``code``, ``tests``, ``docs``, ``research``, possibl=
y followed by an<br>
&gt; &gt; &gt; &gt; explanation in parentheses::<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: tests, docs<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (refactoring)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (prototype)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: research<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The trailer is intended as a clarification of your DCO =
obligations as<br>
&gt; &gt; &gt; &gt; well as to guide reviewers.=C2=A0 It is not intended fo=
r minimal presence<br>
&gt; &gt; &gt; &gt; such as autocomplete or asking for a pre-review of the =
patch, and it<br>
&gt; &gt; &gt; &gt; does not remove your responsibility to understand the c=
hanges that you<br>
&gt; &gt; &gt; &gt; are submitting.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Why invent something new here when Assisted-by: is used else=
where<br>
&gt; &gt; &gt; and is likely more familiar to other users.<br>
&gt; &gt; <br>
&gt; &gt; Because Assisted-by: gives different information, which at least =
to me<br>
&gt; &gt; isn&#39;t really interesting at all. It&#39;s much more interesti=
ng to me if the<br>
&gt; &gt; code I&#39;m looking at is generated, or if you only generated th=
e tests.<br>
&gt; <br>
&gt; I personally am interested to know which models work better than other=
s.<br>
&gt; Contributions are about reputation not just code.=C2=A0 I&#39;ll learn=
 which<br>
&gt; models produce better output, just like I learn to trust specific<br>
&gt; contributors better.<br>
<br>
You don&#39;t see how well the model worked. What you see is filtered by th=
e<br>
submitter, and the policy we&#39;re discussing is specifically made to make=
<br>
sure that bad results never reach the list.<br></blockquote><div><br></div>=
<div>You actually do. Bad results will 100% hit the list. Guaranteed. No po=
licy</div><div>will stop that. Having the right tag, like the model used, w=
ill help train reviewers</div><div>which ones work and which ones don&#39;t=
 for their subset of the tree.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Even for things that do reach the list, Assisted-by: doesn&#39;t tell you<b=
r>
how much of the submission is AI-generated and it also doesn&#39;t tell you=
<br>
if it&#39;s &quot;I used model X and a simple prompt gave me the perfect re=
sult<br>
in the first attempt&quot; or &quot;I used model X and it took me two days =
of back<br>
and forth and eventually I just rewrote most of it, but there are a few<br>
AI-generated lines left&quot;.<br></blockquote><div><br></div><div>I covere=
d that in my bsd-user cover letter. But in that case I used it mostly</div>=
<div>to move the code from upstream with proper attribution (yes, determini=
stic</div><div>tools could do that, but I wasted a week on trying to write =
them years ago</div><div>and AI is just &quot;move this over&quot; for me n=
ow). But then, after I started, I had</div><div>Claude reivew them in thee =
style of reivews I&#39;d gotten in the past, so it</div><div>developed a ch=
ecklist to do the reviews and at first I had those separate</div><div>since=
 they were a joint effort (mostly Claude finding the issue which was</div><=
div>obvious to fix, but I had it re-review my fixes and/or suggest its own)=
. I</div><div>merged them after advice that said basically=C2=A0&quot;do wh=
at you do for human</div><div>reviews: fold them back&quot; so I did that i=
n subsequent reviews.</div><div><br></div><div>Also, I&#39;ve started seein=
g claude generated submissions for FreeBSD</div><div>pull requests. I recog=
nize its style since I&#39;ve interacted with it so much.</div><div>I also =
recognize other, unknown to me, styles that have different quirks</div><div=
>that I know Claude doesn&#39;t do, but that other models do do. I wish I</=
div><div>had the raw data to know which AI tools and models were used since=
</div><div>that cues me to look for certain things (with claude it tends to=
 be it&#39;s</div><div>insane insistance for printf&#39;ing what&#39;s goin=
g on to an annoying degree).</div><div>And there people have been trying to=
 sneak things in since a preliminary</div><div>&quot;no ai&quot; policy lea=
ked out that was never formally approved.=C2=A0I have to</div><div>guess at=
 it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">So what you should trust is the contributor, not an Assisted-by: tag.<br>=
</blockquote><div><br></div><div>You should use both to form your opinion. =
It&#39;s not an either-or situation.</div><div>I&#39;ve had conversations w=
ith the AI contributors in FreeBSD about how</div><div>they use it and tend=
 to ask more questions at review than when AI isn&#39;t</div><div>used. Kno=
wing what AI was used will help me delve into different things</div><div>th=
at I might not otherwise poke at since I know the quirks of at least</div><=
div>a couple tools by now.</div><div><br></div><div>Warner</div></div></div=
>

--000000000000d462260652cfa48a--


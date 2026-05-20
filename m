Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1556BCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlep-00018M-OM; Wed, 20 May 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wPlej-0000p9-0P
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:28:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wPlee-0002zh-Vz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:28:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b788a98557so31839645ad.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301707; cv=none;
 d=google.com; s=arc-20240605;
 b=kFOdpUyW7ulTcOq+FAxshrAHLJ+VUx5IMLSKdjTnLMP5ZlAlse7SN89dCair+9tQ4F
 LN6O6VJ3xF3RgXYM0AOr9AAoLh/7Xm7+MU95m93Sgz9MYAQe4t2YAoDlStMkcb8KlDnc
 62JFgsl0/R51Uqxsepb1Af9oUGxXR8rdOKmru9HI0qWSdq19Te6TPE5yX6ER0bKJ5Xym
 VA+UFX7bHn7aOEjKpR3+oFyaRHADFot76uohW3bHxQaYGrB/rH1O9+zothbQG9fv4YaD
 sZITsOefGcslYhEckpJVzXC+e6MS07IebOFQy8XQ3O5WuLL8cfza6kgd97B59+xKAbL+
 4e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X2nS6Mf9AMFbKlkO+qjUbpnOrPAKUIj6B5fGO5h/zXw=;
 fh=XhnfqtWfhfK4m+ju2+zP7nYmY5BqHAzlJLKRILJ2Qx0=;
 b=dI0iB+4Nf5/Gok2g+ZK5zBeXNZTYFhgKhi5H1OIBCAb+Xqv6JJ+qe1CYFKYGAKSKnJ
 WnpefANvv6TmRnRraQkZTBUXJSA8OCaFIVCJB62Im8pwynp+Y5LyZMftSjO/FNa9b6cX
 l8sz9bP//HviCddauAHV90IXjX51LCt3r9CA/W5sVL5b0tX/Fb1mt/g3PoXFdNLKmOuL
 WMeUKM50attp97c1+GGVszU7kLzVSKC/wf3xh+0Wuu55Cl+z1mYiMrVOa4Ullbo9u4Ko
 8chc3uzUjd4sy8BBNzC4zoMTozJnCDg3B/FrGBTo9tFFHzx0tbEFOxKrdzdhiS2QAW7f
 cSmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779301707; x=1779906507;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2nS6Mf9AMFbKlkO+qjUbpnOrPAKUIj6B5fGO5h/zXw=;
 b=uqsL1kPsvJLSwa8JR18vxG/CohKSvWZ3GAImF5mbWXoUG6AMVDb3EjvC3NvGyNuCq2
 gT1KI39utXN7wxIYHPiI3+eCn/c2dXxFnDOgB97ZG9A0f2krzYMiQZ7kzUearOssCKXN
 o8NgQglhy37gT68oAg63Q9pWdPzvqfzeEDWBTzdZYmwSFBn1SydJSBIhJTogwwjJsWQ0
 Zy8vT6ajxsTjFAsHOkWnrEt1rBsRLDrferZV0l/+5k89IdcMAyz2PzIg9SJEvFc2HFLc
 ypi3JpDyWSwrIGcAOG3Z5UFwqeabFggu2V19azFTOnWm1E+Hwjz7SsreAYI99qxHojor
 VY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301707; x=1779906507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2nS6Mf9AMFbKlkO+qjUbpnOrPAKUIj6B5fGO5h/zXw=;
 b=qjxzh7xbY5QzuwaayBRthhbY4tmUnh+5+zVbHkDDENxAYkWQHNF22zF1iXi+2l4Ch6
 DH6GZUMXpFi6DwUU97DmCa76yGzyCRwjgh8bvWpf31u3MtvCv7c3T59+hYo/cqwkEoSs
 MbFmdO0yHLPFmj7Rttv84MHPsDzVGL5maXb8Aix1zJrSin5jUYrhQBDZUA5DbN3UkhNk
 FTJgVVZLCcmtJ+n18AsGj1uQQ+/tHwczm8Gxk2f+wkk1FuZAWrdaYe/Dyp7U2dtNLT5A
 LjwhhnnxLOpX3KboI6NCncBImaRZOaQ8KysvOJQSleOP0qZMSXWN/CdG3bP4L+QC+Gz0
 Br5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VJk3eM9iXmhI50lSz8tLqOzDbtSrrT7MCW7Ck4t6+QJIeeDulBY4B/dIAakuOXhT77cRDJntkR6s5@nongnu.org
X-Gm-Message-State: AOJu0YyX1J3UA3jIDQGSELdN+dIvBQpVrQb/wbnB3LVK9QfLyqmzbH/2
 PyEd7Vi3zSEqeRk1mFc8AorAhD57TLC/qTyDlPS6gGKClx5FumzEk+rUx0mD7kSqVZz34HTni+2
 Xy3viKIheXYu4/JQqr5eAMZoGZwX3u4yZHwx0hcsU8nQ9aHiPYP1OS5I=
X-Gm-Gg: Acq92OFBMmUd1pTbvaQc4/Ey+i46GbZamNo0SeRHYapmlfJWxpebSk2Z4nCDvwG3MpF
 QL0BLp0NPlBduzoynl52znDij7p4mpB6TMOghkqnblPx54+4rAoRo7kr3ApgYCprAIofceTDDL5
 NuU/5Kyx1hxHppQyJba6H3cM9zDCEsj1lx8W8WPfJbN/V6OuRHiUqrOWVApE2M1XpMQn1q1LZOA
 eQhC5UgaOnHHpt8vdtq8w0cTAU4uBEVKDrDvNaQZOj3+dYumgh7EKbD8q5XEyBjvSkkrLtJdN2T
 pKSIYdvCsvbDxpSe5A==
X-Received: by 2002:a17:902:f9d0:b0:2bd:6cab:860 with SMTP id
 d9443c01a7336-2bd7e93b25emr179924005ad.28.1779301706888; Wed, 20 May 2026
 11:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
 <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
 <ag3xwssG6KZecv0o@redhat.com>
In-Reply-To: <ag3xwssG6KZecv0o@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 May 2026 12:28:15 -0600
X-Gm-Features: AVHnY4KU6YzO-kSWCZ9u6NNpAcWt2ff332OCk_KCLqMXy5ezm65lnx7gLVTdcBY
Message-ID: <CANCZdfr5Fs+Wgdo32u6acqu08YOo9tQ-hUWe8EbxRvgxcEoGfQ@mail.gmail.com>
Subject: Re: RFC: GitLab issues for security disclosures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003005e6065243f685"
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62f.google.com
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

--0000000000003005e6065243f685
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:40=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Wed, May 20, 2026 at 12:33:16PM -0500, Pierrick Bouvier wrote:
> > On 5/20/2026 10:09 AM, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:
> > >> Hi Daniel,
> > >>
> > >> On 5/19/2026 9:26 AM, Daniel P. Berrang=C3=A9 wrote:
> > >>> The qemu-security mailing list was created several years back now a=
nd
> > >>> traditionally saw 1-2 disclosures a month at worst. This was
> manageable.
> > >>>
> > >>> Since approx March 1st, the new normal is to see as many as 20
> disclosures
> > >>> in one single day, more than 200 in total now. This is unsustainabl=
e.
> > >>> I was thinking we needed more people on qemu-security to triage, bu=
t
> IMHO
> > >>> this won't really fix the problem.
> > >>>
> > >>
> > >> Considering the increase in number of issues, would that be possible
> to
> > >> make stricter rules about what is expected?
> > >>
> > >> For instance, asking for a working exploit and optionally a VM image=
 +
> > >> instructions to reproduce it. I am not expert on the topic, but what=
 I
> > >> see is that if we have this, all duplicates would be eliminated at
> once.
> > >
> > > With the new crop of AI assisted disclosures there is absolutely no
> > > lack of data provided.
> > >
> > > Most come with reproducible exploits, detailed descriptions and
> analysis,
> > > and more - everything you could conceivably need to triage the
> disclosure.
> > > Reading and interpreting this takes significant mental effort and
> there's
> > > too much data to quickly/easily eliminate dupes.
> > >
> >
> > Maybe we need to "standardize" this part then.
> > Or do something like asking a (GitLab) CI pipeline to be written to
> > expose the issue. If we can just run this with a specific qemu
> > remote/branch, it becomes trivial to rerun it when fixes are pushed.
> >
> > It definitely does not solve the original scaling issue, but maybe can
> > help to absorb it, and spend time where it's useful: writing and
> > upstreaming a fix, and check it "broke" the exploit.
> >
> > >>> This needs an issue tracker to cope with & email is not an issue
> tracker.
> > >>> We faked an issue tracker with a shared spreadsheet to prevent us
> drowning
> > >>> these past few months, but this is still not sustainable & probably
> won't
> > >>> ever be.
> > >>>
> > >>
> > >> Overall, you're right.
> > >> However, changing the tool won't solve the number of issues sent, an=
d
> > >> for that, something additional is needed.
> > >
> > > I don't expect there to be any change in submission rate. The proposa=
l
> > > is based on the expectation that the submission rate will continue at
> > > a high level for a long time. Primarily the goal is to reduce the
> > > tracking and triage work overhead and to eliminate/reduce single pers=
on
> > > bottlenecks in the process
> > >
> > >> I wonder also what is the percentage of duplicates there is from wha=
t
> > >> you observed in the last 2 months. Any rough idea of the number?
> > >
> > > Definitely at least 10%, probably closer to 15%.
> > >
> >
> > Ok, interesting number, thanks. I was expecting much more, but I'm
> > biased having heard Linus this morning talk about this for Linux kernel=
.
>
> I expect the dupes to increase over time as more people run the
> same analysis across QEMU, especially given that most of the bugs
> are not yet fixed.
>

So this isn't security related, but I think it's informative. I started
upstreaming
a large amount (8k lines) of bsd-user code in March. Claude did the moving
and author chasing. Then I asked claude to review that code, and refined
the reviews into a checklist. I iterated for 6 weeks or so, on and off, and
I wound up fixing 100 "bugs," 10 of which were 'real' the rest were logical
or only if certain options were enabled. I went ahead and fixed them all
since CONFIG_REMAP_DEBUG should have a chance of working and
it's useful to be careful between host arch values and target arch values,
even if we know they are the same. But it takes a while to come up with
these, and has an annoying habit of reporting no more than 8-12 on any
run and always seems to find something new (sometimes a new critical
thing).

But I just stopped running the reviews after a while. The details likely
don't matter...  I just did another review, and claude found more, so
that suggests that even with this flood, we're still in the sampling phase
and we'll see dupes, but we won't hit bottom for quite some time since
I think my experience is at least suggestive about what to expect.

But all this suggests that we're going to have a huge volume of reports,
most of which will be mediocre in terms of effect, even if they come
with big mountains of data. AI produces the data in this regard
very well, but is crap for know what's a real problem and what
isn't.

Warner

P.S. For "yucks" I asked claude to review my code again, and it
flagged 20 more things. Most of which look at least semi-legit,
though claude has about a high false positive hit rate when it
found the 100 bugs, it flagged about 125 or so.

--0000000000003005e6065243f685
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20,=
 2026 at 11:40=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, May 20, 2026 at 12:33:16PM -05=
00, Pierrick Bouvier wrote:<br>
&gt; On 5/20/2026 10:09 AM, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; &gt; On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:=
<br>
&gt; &gt;&gt; Hi Daniel,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 5/19/2026 9:26 AM, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; &gt;&gt;&gt; The qemu-security mailing list was created several years =
back now and<br>
&gt; &gt;&gt;&gt; traditionally saw 1-2 disclosures a month at worst. This =
was manageable.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Since approx March 1st, the new normal is to see as many =
as 20 disclosures<br>
&gt; &gt;&gt;&gt; in one single day, more than 200 in total now. This is un=
sustainable.<br>
&gt; &gt;&gt;&gt; I was thinking we needed more people on qemu-security to =
triage, but IMHO<br>
&gt; &gt;&gt;&gt; this won&#39;t really fix the problem.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Considering the increase in number of issues, would that be p=
ossible to<br>
&gt; &gt;&gt; make stricter rules about what is expected?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; For instance, asking for a working exploit and optionally a V=
M image +<br>
&gt; &gt;&gt; instructions to reproduce it. I am not expert on the topic, b=
ut what I<br>
&gt; &gt;&gt; see is that if we have this, all duplicates would be eliminat=
ed at once.<br>
&gt; &gt; <br>
&gt; &gt; With the new crop of AI assisted disclosures there is absolutely =
no<br>
&gt; &gt; lack of data provided.<br>
&gt; &gt; <br>
&gt; &gt; Most come with reproducible exploits, detailed descriptions and a=
nalysis,<br>
&gt; &gt; and more - everything you could conceivably need to triage the di=
sclosure.<br>
&gt; &gt; Reading and interpreting this takes significant mental effort and=
 there&#39;s<br>
&gt; &gt; too much data to quickly/easily eliminate dupes.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Maybe we need to &quot;standardize&quot; this part then.<br>
&gt; Or do something like asking a (GitLab) CI pipeline to be written to<br=
>
&gt; expose the issue. If we can just run this with a specific qemu<br>
&gt; remote/branch, it becomes trivial to rerun it when fixes are pushed.<b=
r>
&gt; <br>
&gt; It definitely does not solve the original scaling issue, but maybe can=
<br>
&gt; help to absorb it, and spend time where it&#39;s useful: writing and<b=
r>
&gt; upstreaming a fix, and check it &quot;broke&quot; the exploit.<br>
&gt; <br>
&gt; &gt;&gt;&gt; This needs an issue tracker to cope with &amp; email is n=
ot an issue tracker.<br>
&gt; &gt;&gt;&gt; We faked an issue tracker with a shared spreadsheet to pr=
event us drowning<br>
&gt; &gt;&gt;&gt; these past few months, but this is still not sustainable =
&amp; probably won&#39;t<br>
&gt; &gt;&gt;&gt; ever be.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Overall, you&#39;re right.<br>
&gt; &gt;&gt; However, changing the tool won&#39;t solve the number of issu=
es sent, and<br>
&gt; &gt;&gt; for that, something additional is needed.<br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t expect there to be any change in submission rate. The=
 proposal<br>
&gt; &gt; is based on the expectation that the submission rate will continu=
e at<br>
&gt; &gt; a high level for a long time. Primarily the goal is to reduce the=
<br>
&gt; &gt; tracking and triage work overhead and to eliminate/reduce single =
person<br>
&gt; &gt; bottlenecks in the process<br>
&gt; &gt; <br>
&gt; &gt;&gt; I wonder also what is the percentage of duplicates there is f=
rom what<br>
&gt; &gt;&gt; you observed in the last 2 months. Any rough idea of the numb=
er?<br>
&gt; &gt; <br>
&gt; &gt; Definitely at least 10%, probably closer to 15%.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok, interesting number, thanks. I was expecting much more, but I&#39;m=
<br>
&gt; biased having heard Linus this morning talk about this for Linux kerne=
l.<br>
<br>
I expect the dupes to increase over time as more people run the<br>
same analysis across QEMU, especially given that most of the bugs<br>
are not yet fixed.<br></blockquote><div><br></div><div>So this isn&#39;t se=
curity related, but I think it&#39;s informative. I started upstreaming</di=
v><div>a large amount (8k lines) of bsd-user code in March. Claude did the =
moving</div><div>and author chasing. Then I asked claude to review that cod=
e, and refined</div><div>the reviews into a checklist. I iterated for 6 wee=
ks or=C2=A0so, on and off, and</div><div>I wound up fixing 100 &quot;bugs,&=
quot; 10 of which were &#39;real&#39; the=C2=A0rest were logical</div><div>=
or only if certain options were enabled. I went ahead and fixed them all</d=
iv><div>since CONFIG_REMAP_DEBUG should have a chance of working and</div><=
div>it&#39;s useful to be careful between host arch values and target arch =
values,</div><div>even if we know they are the same. But it takes a while t=
o come up with</div><div>these, and has an annoying habit of reporting no m=
ore than 8-12 on any</div><div>run and always seems to find something new (=
sometimes a new critical</div><div>thing).<br><br>But I just stopped runnin=
g the reviews after a while.<span style=3D"background-color:rgba(232,242,25=
5,0.996)">=C2=A0The details likely</span></div><div><span style=3D"backgrou=
nd-color:rgba(232,242,255,0.996)">don&#39;t matter...=C2=A0 I just did anot=
her review, and claude found more, so</span></div><div><span style=3D"backg=
round-color:rgba(232,242,255,0.996)">that suggests that even with this floo=
d, we&#39;re still in the sampling phase</span></div><div><span style=3D"ba=
ckground-color:rgba(232,242,255,0.996)">and we&#39;ll see dupes, but we won=
&#39;t hit bottom for quite some time since</span></div><div><span style=3D=
"background-color:rgba(232,242,255,0.996)">I think my experience is at leas=
t suggestive about what to expect.</span></div><div><span style=3D"backgrou=
nd-color:rgba(232,242,255,0.996)"><br></span></div><div><span style=3D"back=
ground-color:rgba(232,242,255,0.996)">But all this suggests that we&#39;re =
going to have a huge volume of reports,</span></div><div><span style=3D"bac=
kground-color:rgba(232,242,255,0.996)">most of which will be mediocre in te=
rms of effect, even if they come</span></div><div><span style=3D"background=
-color:rgba(232,242,255,0.996)">with big mountains of data. AI produces the=
 data in this regard</span></div><div><span style=3D"background-color:rgba(=
232,242,255,0.996)">very well, but is crap for know what&#39;s a real probl=
em and what</span></div><div><span style=3D"background-color:rgba(232,242,2=
55,0.996)">isn&#39;t.</span></div><div><span style=3D"background-color:rgba=
(232,242,255,0.996)"><br></span></div><div><span style=3D"background-color:=
rgba(232,242,255,0.996)">Warner</span></div><div><span style=3D"background-=
color:rgba(232,242,255,0.996)"><br></span></div><div><span style=3D"backgro=
und-color:rgba(232,242,255,0.996)">P.S. For &quot;yucks&quot; I asked claud=
e to review my code again, and it</span></div><div><span style=3D"backgroun=
d-color:rgba(232,242,255,0.996)">flagged 20 more things. Most of which look=
 at least semi-legit,</span></div><div><span style=3D"background-color:rgba=
(232,242,255,0.996)">though claude has about a high false positive hit rate=
 when it<br>found the 100 bugs, it flagged about 125 or so.</span></div></d=
iv></div>

--0000000000003005e6065243f685--


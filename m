Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59EECEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdYE-0008LG-PA; Tue, 01 Oct 2024 10:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1svdYB-0008KF-UM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1svdY3-0001sF-Mj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e06b72f3e7so2881435b6e.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727791698; x=1728396498;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ca41LdwP1qn5WuxH129pqss0eix1UOVLUPxgJJC1VNk=;
 b=DkWJebuLm83pThs4gmfWfkKW1RlCyeY+fs3P2Ix6k9uM1mtYJ6sm6pO18I3NrdUesA
 0nnG+nSiNBk37cv30kzD3QFcaetWLL8TtdD1B+u8YzwpsOFQl1PWj1TlXSEHOGlgrVLF
 iLOwhTWJULtWDVWJELYYRHOYtpEIv0hicgJDINHSw6csvZvn++1CfDZhHeQYWebPYJtZ
 eEwjA/F/0smNuVzdS1LThvsCVxOKjm9nO4GNoLAXWAh74saje19cktsmN1eNxhncxAZd
 3D9jLoHo6W3FecaBjPP4MqEtBEjG0IVsYkYrmEO1k1P1fcJfiy0HBvPimscwbYgXhn0s
 SNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727791698; x=1728396498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ca41LdwP1qn5WuxH129pqss0eix1UOVLUPxgJJC1VNk=;
 b=GOWN6eaR5F3WPJEfbs51xvOi/5g62oz4fkvxryLUq31Sad7xqXJPjfwFV4gGi0UWbO
 hvHujDmAcUyBQpgc67uoJEEJLxYvNmYMBvLW3M3RWCsbyBdve87jZRFiGqLYuGod8nLC
 yjaCLOeke2AaDXrRr4BcIR7T8/Wz91us0yrI9/thcObx4GG4Ca22yXrA3AGJFKqF161E
 b4aFD7jpP31+0t0WAKrJskaUnBga8uzLGKd6pGM3gvaAY0eybXBxDkCKe609dLS/kH+z
 SjWVMe00l7MHryiWMFiu+ovXLa/aWa21gkCSXel6bN2+BRUBgt/EC/H04vuv44mZn38o
 4dJw==
X-Gm-Message-State: AOJu0Yw70MkXi9bDQt7wyxbRTL8mKCuGn0sgMVFQ4Sa3JDS/KoOK6Qu7
 8U3qF0vTE/TWr5LoANdiM0bS/OzVpsAFYO8rx7nldv+yz2bITo2OWLZFJUZwQ6OXsJHVnfbNHdM
 Sc8Iv9yPsPxYvDXRKU5kETX6RAFaes098PuYugCZS7bsvuLhjegpTmZH3
X-Google-Smtp-Source: AGHT+IGtwoMvOusFGM0YHh7TJ/27dtkzD4cJRMd1H0zdaoydrPHaB4xsbyfxgMRMYkoJWZaxrarwdLtFzS9p3ypzc/8=
X-Received: by 2002:a05:6870:c986:b0:278:2d12:9ef5 with SMTP id
 586e51a60fabf-2876e4069f9mr769637fac.11.1727749150343; Mon, 30 Sep 2024
 19:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727630000.git.yong.huang@smartx.com>
 <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
 <ZvsORXZDZodSrzO-@x1n>
In-Reply-To: <ZvsORXZDZodSrzO-@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 1 Oct 2024 10:18:54 +0800
Message-ID: <CAK9dgmZ7M30xXahBUKEkmQ2ZkWoF=DA=pb8XF_=YVM9xF2zcJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] migration: Support responsive CPU throttle
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005e232a062360f28f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005e232a062360f28f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:47=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Mon, Sep 30, 2024 at 01:14:28AM +0800, yong.huang@smartx.com wrote:
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > Currently, the convergence algorithm determines that the migration
> > cannot converge according to the following principle:
> > The dirty pages generated in current iteration exceed a specific
> > percentage (throttle-trigger-threshold, 50 by default) of the number
> > of transmissions. Let's refer to this criteria as the "dirty rate".
> > If this criteria is met more than or equal to twice
> > (dirty_rate_high_cnt >=3D 2), the throttle percentage increased.
> >
> > In most cases, above implementation is appropriate. However, for a
> > VM with high memory overload, each iteration is time-consuming.
> > The VM's computing performance may be throttled at a high percentage
> > and last for a long time due to the repeated confirmation behavior.
> > Which may be intolerable for some computationally sensitive software
> > in the VM.
> >
> > As the comment mentioned in the migration_trigger_throttle function,
> > in order to avoid erroneous detection, the original algorithm confirms
> > the criteria repeatedly. Put differently, the criteria does not need
> > to be validated again once the detection is more reliable.
> >
> > In the refinement, in order to make the detection more accurate, we
> > introduce another criteria, called the "dirty ratio" to determine
> > the migration convergence. The "dirty ratio" is the ratio of
> > bytes_xfer_period and bytes_dirty_period. When the algorithm
> > repeatedly detects that the "dirty ratio" of current sync is lower
> > than the previous, the algorithm determines that the migration cannot
> > converge. For the "dirty rate" and "dirty ratio", if one of the two
> > criteria is met, the penalty percentage would be increased. This
> > makes CPU throttle more responsively and therefor saves the time of
> > the entire iteration and therefore reduces the time of VM performance
> > degradation.
> >
> > In conclusion, this refinement significantly reduces the processing
> > time required for the throttle percentage step to its maximum while
> > the VM is under a high memory load.
>
> I'm a bit lost on why this patch 2-3 is still needed if patch 1 works.
> Wouldn't that greatly increase the chance of throttle code being inovked
> already?  Why we still need this?
>

Indeed, if we are considering how to increase the change of throttle.
Patch 1 is sufficient, and I'm not insisting.

If we are talking about how to detect the migration convergence, this
patch, IMHO, is still helpful. Anyway, it depends on your judgment. :)


>
> Thanks,
>
> --
> Peter Xu
>
>
Yong

--=20
Best regards

--0000000000005e232a062360f28f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 202=
4 at 4:47=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pete=
rx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">On Mon, Sep 30, 2024=
 at 01:14:28AM +0800, <a href=3D"mailto:yong.huang@smartx.com" target=3D"_b=
lank">yong.huang@smartx.com</a> wrote:<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; <br>
&gt; Currently, the convergence algorithm determines that the migration<br>
&gt; cannot converge according to the following principle:<br>
&gt; The dirty pages generated in current iteration exceed a specific<br>
&gt; percentage (throttle-trigger-threshold, 50 by default) of the number<b=
r>
&gt; of transmissions. Let&#39;s refer to this criteria as the &quot;dirty =
rate&quot;.<br>
&gt; If this criteria is met more than or equal to twice<br>
&gt; (dirty_rate_high_cnt &gt;=3D 2), the throttle percentage increased.<br=
>
&gt; <br>
&gt; In most cases, above implementation is appropriate. However, for a<br>
&gt; VM with high memory overload, each iteration is time-consuming.<br>
&gt; The VM&#39;s computing performance may be throttled at a high percenta=
ge<br>
&gt; and last for a long time due to the repeated confirmation behavior.<br=
>
&gt; Which may be intolerable for some computationally sensitive software<b=
r>
&gt; in the VM.<br>
&gt; <br>
&gt; As the comment mentioned in the migration_trigger_throttle function,<b=
r>
&gt; in order to avoid erroneous detection, the original algorithm confirms=
<br>
&gt; the criteria repeatedly. Put differently, the criteria does not need<b=
r>
&gt; to be validated again once the detection is more reliable.<br>
&gt; <br>
&gt; In the refinement, in order to make the detection more accurate, we<br=
>
&gt; introduce another criteria, called the &quot;dirty ratio&quot; to dete=
rmine<br>
&gt; the migration convergence. The &quot;dirty ratio&quot; is the ratio of=
<br>
&gt; bytes_xfer_period and bytes_dirty_period. When the algorithm<br>
&gt; repeatedly detects that the &quot;dirty ratio&quot; of current sync is=
 lower<br>
&gt; than the previous, the algorithm determines that the migration cannot<=
br>
&gt; converge. For the &quot;dirty rate&quot; and &quot;dirty ratio&quot;, =
if one of the two<br>
&gt; criteria is met, the penalty percentage would be increased. This<br>
&gt; makes CPU throttle more responsively and therefor saves the time of<br=
>
&gt; the entire iteration and therefore reduces the time of VM performance<=
br>
&gt; degradation.<br>
&gt; <br>
&gt; In conclusion, this refinement significantly reduces the processing<br=
>
&gt; time required for the throttle percentage step to its maximum while<br=
>
&gt; the VM is under a high memory load.<br>
<br>
I&#39;m a bit lost on why this patch 2-3 is still needed if patch 1 works.<=
br>
Wouldn&#39;t that greatly increase the chance of throttle code being inovke=
d<br>
already?=C2=A0 Why we still need this?<br></blockquote><div><br></div><div>=
<div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gm=
ail_default">Indeed, if we are considering how to increase the change of th=
rottle.</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif=
" class=3D"gmail_default"><span style=3D"color:rgb(0,0,0)">Patch 1 is suffi=
cient, and I&#39;m not insisting.</span><br></div></div><div style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><span =
style=3D"color:rgb(0,0,0)"><br></span></div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><span style=3D"col=
or:rgb(0,0,0)">If we are talking about how to detect the migration converge=
nce, this</span></div><div style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif" class=3D"gmail_default"><font color=3D"#000000"><span style=3D"c=
aret-color: rgb(0, 0, 0);">patch, IMHO, is still helpful. Anyway, it depend=
s on your judgment. :)</span></font></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"=
>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><br></div>=
<span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--0000000000005e232a062360f28f--


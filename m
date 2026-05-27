Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9BCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHZP-0001ZA-Gv; Wed, 27 May 2026 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHZN-0001YX-P7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:57:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSHZL-0005fe-9d
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:57:25 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso8730827a91.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779901041; cv=none;
 d=google.com; s=arc-20240605;
 b=X18SfktELCON3gXfrrVZVman0pgnv7tJaz8NcDp8wD+0rnB8bXGbkknT93W323Lr/y
 fAExrgX6F1Hy+XXyQ7EhqlZeZUcvWqUJR+egeVbcFfP6vKfJjlCyXP58hX7S2YpMtxic
 P+Erja4w942VMWICp+yQZI5pwnOREjgXaL3ChymkbgntqBBvs1gbT8vOG2jWQkWgVtYg
 YQttE07uQUHlR4IbNOy3C3X9B2Q0JRCVelRiyQs9x+/skhFIRsZoE1WtNr8DeGvY/PuN
 0vw4e++QEMvr/SDUfAcuF1LAUgwM/lU0a8/9deaOC91/S9FzWLs3txSs+5CCqwMpkt2A
 COiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qCnISHlQuiGGEZaD1SIoc1SBMiprb6FDEoNofKEFb0Y=;
 fh=uMj/EDvKn0qVlTxfKNuaGPRxI4BH9UBT26RGBxfyfDQ=;
 b=FMdKG1PWCQGuHlZUG5W4pXbwkrQz9G0IEgAkOcQP3qXVVlrHT+sHS7+OGfdQINmUf1
 hdZePZyXlVsHsUy1XG4NYd8AIIpnig8hroJDMkZtV5lZl/AIZoDQ4ZOU+9T0biqxI+yG
 1Hj1hodPjjc8WXVCew7EcTFMiYrv+sOekIssnwekB4eoh0ujJpZzoej6iTDhN1dSnp2g
 O42ki6eGwDLYrSEVrGfIycGqlJWeTpxCk87sPsprdOdWw5fuJIw/4esLG+M4jOo+bGDJ
 TxvckiP+TGylgH3VPzRQBkOPeu0mgl7x6IwbL4w5I2GbUWXfyrC2NBo3NdTQ1mu66PBL
 Bsww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779901041; x=1780505841;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qCnISHlQuiGGEZaD1SIoc1SBMiprb6FDEoNofKEFb0Y=;
 b=uPQH/EO7J6bqgqk30MnLZ/unrfnZHURj1z3fWoFLzsQPGqRofIrTWKfSJyK4ShxcOu
 vTHIfJu5imcP/i54tVEyvdm/9mPEztcsyOYkbfveWGz/MlUXan50g8NEyZ3qNwapg3Js
 K80P58FQ8CgU25/h7xZQ2RLDkcBDHWhOEYqaaOzdAaCLIidCLIl+WxdGz4kpFGpYEiem
 XHPDcFGYG+B2trwPJIa5sGTJVBTMhOy4ns+/eNJLkzEAGk871fTCWUOJOWpOouHYLRkx
 NqnsJ8omYiUXCGnBTpdKOAydPIE10mz2ZofzOvWa2yBu1Rypaa7FLQ0DaC/RZsElt5Dq
 DE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779901041; x=1780505841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCnISHlQuiGGEZaD1SIoc1SBMiprb6FDEoNofKEFb0Y=;
 b=osY9DWqyP8ixxAZwvx9vrQ1gc4Kamo1jNO58Dc/6n604wU2qisf2f95UB6IbMhBCNp
 wOWBnJXoRrs4YYNOt0AgQa6O38v9ceIs0Upr/1Aha5vqsdPmXImcrGBLLwadMGtHT7AT
 tXx6siuzUT5IIlWijp2TrS/dbZ9J2pYSiks9GFzw1VE5ul+k+7rliIqjmu78mK5zP9M8
 lY/Wb/NzESw8gyIcPwXRJZ0c1TxtlOpKXPqLT/em90/hKZizsrNLNPSqy9+IB6n+axNx
 P2mzmDM9uTT2ZQt9p1A70n3cooaXpOUWPfwc5uaoZWYgTd2pxUK3YRWW2g7ZnfpqNIll
 JgRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qmOKfDpqmUlinQH8yWLZEsMqv26/Oyl1Y1P4oUyIXzPVjR7hHEN6YWW6LTN5GOVgw5oJSaA1OU5v3@nongnu.org
X-Gm-Message-State: AOJu0Yy2npTs9bMV0lsjPwuGOs8b2ND80dlR4PqpkAsKDfB8iTyqDz2z
 2IsT1Q0F/Z0aI47w2lZ9i0SyRmwh7h9nbRE+G25FbJyHcPzJu6Fjv/sMvXGvn7SQVYI3KMV40Iq
 63BsmUTUkIMqew0c311DKG8NethWPLzizv2EKweOrb4+ouCBP2gA6oSk=
X-Gm-Gg: Acq92OGuGqX8dT//t8obT6uM20RgYWgOQoFi4daSkzTlfszsfdZ4HPz9/241rpv/r+T
 2912Pdz9Sew2gbpwG4zH8FCxjEKj/HZ04WZSb5kXDku8pDz3EwdyrKA0QxhrVd4QIKspmErAcZ2
 AUOX5KusGW3nYfzX2VxyUVWZS0n8WHEieg6qdkrA8xPKO66sS9s7xpG35CIMuP/GVK4Ok5IdkKr
 pTcLexPE1hDLR3GJZ9V6E2yQP/3lNB2P6N8sY0UroSDVISorTqStg/g1cbzdhOEbj9b3FZh4KhV
 JzhJdQUOBO61OGu1Xw==
X-Received: by 2002:a17:90b:4d10:b0:368:3830:a8bd with SMTP id
 98e67ed59e1d1-36a476e8096mr22374113a91.7.1779901041405; Wed, 27 May 2026
 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <8416cfdf-b9a6-427c-8118-fd2ed7661f2e@redhat.com>
 <20260527124115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260527124115-mutt-send-email-mst@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 27 May 2026 10:57:09 -0600
X-Gm-Features: AVHnY4Lj1VPTAGmDzNh30XwTdINL8-JNiZ4jjY4rwjsE1p3MJtns4ZrEK_OG95s
Message-ID: <CANCZdfqSEzhjE5Ts+B3hL3GSmT0vw_Q=t_-4BkYugOUNR4_+XA@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004f01a20652cf81e7"
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102b.google.com
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

--0000000000004f01a20652cf81e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:

> On Wed, May 27, 2026 at 06:05:47PM +0200, Paolo Bonzini wrote:
> > On 5/27/26 16:14, Warner Losh wrote:
> > > Why invent something new here when Assisted-by: is used elsewhere
> > > and is likely more familiar to other users.
> >
> > Because Assisted-by was invented by AI companies to get free
> advertisement.
>
> Jonathan Corbet is in the pocket of AI companies? Or Sasha Levin?
> https://lore.kernel.org/lkml/20251223122110.2496946-1-sashal@kernel.org/
> https://lore.kernel.org/lkml/877bqtlzug.fsf@trenco.lwn.net/


Yea. Assisted-by was not invented by AI companies. That's just rubbish.

See https://github.com/anthropics/claude-code/issues/36105 for the open
issue with Claude.

> (It's not just me; see
> > https://akselmo.dev/posts/stop-advertising-in-your-commits/ for an
> example).
>
> Does not impress me as being either super informed or super
> professional.
>

Yea, seems crazy.


> > Also, it does not answer any interesting question.
>
> It does for me - I will learn which models are more likely to produce
> bad slop.
>

Same. I can tell the difference in the degree of slop between the different
models
and have sometimes selected the older one over the newer one because it doe=
s
a better job.


> > Not using it is also a good way to sieve people who didn't bother to re=
ad
> > the policy, now that I think about it.
>
> In my experience, AI tools add "Co-developed-by:" tags by default. One
> has to read the policy to add Assisted-by.
>

Co-authored-by: you mean? That's what claude adds for me. I had to take
extra effort to add the new Assisted-by: to my patch review.

Warner

--0000000000004f01a20652cf81e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 10:48=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redh=
at.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Wed, May 27, 2026 at 06:05:47PM +0200, Paolo Bonzi=
ni wrote:<br>
&gt; On 5/27/26 16:14, Warner Losh wrote:<br>
&gt; &gt; Why invent something new here when Assisted-by: is used elsewhere=
<br>
&gt; &gt; and is likely more familiar to other users.<br>
&gt; <br>
&gt; Because Assisted-by was invented by AI companies to get free advertise=
ment.<br>
<br>
Jonathan Corbet is in the pocket of AI companies? Or Sasha Levin?<br>
<a href=3D"https://lore.kernel.org/lkml/20251223122110.2496946-1-sashal@ker=
nel.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/lkml=
/20251223122110.2496946-1-sashal@kernel.org/</a><br>
<a href=3D"https://lore.kernel.org/lkml/877bqtlzug.fsf@trenco.lwn.net/" rel=
=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/lkml/877bqtlzug.f=
sf@trenco.lwn.net/</a></blockquote><div><br></div><div>Yea. Assisted-by was=
 not invented by AI companies. That&#39;s just rubbish.</div><div><br></div=
><div>See=C2=A0<a href=3D"https://github.com/anthropics/claude-code/issues/=
36105">https://github.com/anthropics/claude-code/issues/36105</a> for the=
=C2=A0open</div><div>issue with Claude.</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; (It&#39;s not just me; see<br>
&gt; <a href=3D"https://akselmo.dev/posts/stop-advertising-in-your-commits/=
" rel=3D"noreferrer" target=3D"_blank">https://akselmo.dev/posts/stop-adver=
tising-in-your-commits/</a> for an example).<br>
<br>
Does not impress me as being either super informed or super<br>
professional.<br></blockquote><div><br></div><div>Yea, seems crazy.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Also, it does not answer any interesting question.<br>
<br>
It does for me - I will learn which models are more likely to produce<br>
bad slop.<br></blockquote><div><br></div><div>Same. I can tell the differen=
ce in the degree of slop between the different models</div><div>and have so=
metimes selected the older one over the newer one because it does</div><div=
>a better job.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; Not using it is also a good way to sieve people who didn&#39;t bother =
to read<br>
&gt; the policy, now that I think about it.<br>
<br>
In my experience, AI tools add &quot;Co-developed-by:&quot; tags by default=
. One<br>
has to read the policy to add Assisted-by.<br></blockquote><div><br></div><=
div>Co-authored-by: you mean? That&#39;s what claude adds for me. I had to =
take</div><div>extra effort to add the new Assisted-by: to my patch review.=
=C2=A0</div><div><br></div><div>Warner</div><div><br></div></div></div>

--0000000000004f01a20652cf81e7--


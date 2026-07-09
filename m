Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15CAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrho-0001xV-7r; Thu, 09 Jul 2026 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1whrhl-0001wl-JS
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:34:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1whrhi-0002Qb-ER
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:34:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c96bfabc8d4so16404a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783614864; cv=none;
 d=google.com; s=arc-20260327;
 b=hx/7+TBB+31sxqD4yqiw+xbjoIWJB1C012GGLKBGX4cgcKP1vMzlr0/ArTDFzYPVr+
 j+p/yvI/zw/uktH3TzmR1xeT29iVMDrW3uqibdz6c3mg0i7e6vtwK4b53mqRwSresocn
 +FCnYoD4fi+iDClMHPCybNOOo/kpBNbrGzOWAAgdJzrTtQ14is6jP1i6xGqXGwbA+Fpz
 ZAD2/qcspC4dJi75fney8PYKaOxuYtFQSLCr1A3k6Vwmcdwax1qSnU5wlMHuf7VrkB//
 DO8BraTYnu/xDCb36nzds0AaiMFJ1LGMIOUAfyXWbMs7y0I8o7zpy1ubvh6ND1n2Md2k
 6fAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tZObtXCxq1IqweCNoPbt3vR7DYLpFzeHVZjVsGyLDr4=;
 fh=qP5P6nRPmdJwm7PSkiJb32HWv9QA2D9UJKO0aXjQoCY=;
 b=mpfADCQZaryrmUTnd/pJaKTMZNhVS47Jm5KXMjp8VTmRlxi22xzww2UH09ccyDDI3W
 yB36b3NW5/JSbjSu2ZeD/XmYaRX1tBHLbqIjyKy2OV8uPU7i6Vp+XnkSQs187dif5asQ
 Zqqq+n+OLBJltd6oImh8MHeHQrOl66Xu4q1mAKo0yGCfDNDU+P4ynQIfyNPlq4ADM+jY
 Bp1e+JtmA++FsLFX0loVq1iy9n+HtocYqurGN3horyZcue5rTyC0UyktBIoJfDEWY+mc
 NgfMlyR8Bt0GuCSt5zEYUVCUR2lY6FeXQWX8nHw+9Tw978zO7Ac4Mnyz3HGHFQU3sYTW
 PCmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1783614864; x=1784219664;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tZObtXCxq1IqweCNoPbt3vR7DYLpFzeHVZjVsGyLDr4=;
 b=CHYRUA1PzaZ+NGCgESQvh57JdV9dBUbFOqxyGPOAAFDmCk1haG2BOm3qHxs7P4f938
 3l0/SQcAh8ra1YrcrxeNTRVQtkZVxLJkrIk/nmFRmov+9MtMCmLx5jaqr1rUB9xP5/dk
 EKG397MdiMOJba9T4HBzkC0VHuM/5pD/ojnJhtlMN0HHpCI3agxWTa67aMpC8HXWlMQz
 yMeOVxawfnbS0y3NkB/Ev53xa6fDVF91EfC0LKke3oAzMtlOiagrZ1RC3zNFij3Ave+B
 0JG5xtSONie0JW888B2pBBvIl5rn80ju4oYpUCNH+hSDL4fHc2RgJzjkhfjscD1yS4B1
 yolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614864; x=1784219664;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tZObtXCxq1IqweCNoPbt3vR7DYLpFzeHVZjVsGyLDr4=;
 b=X7EwjhUZJEbFt2vIsSD0h4GfCQihrqMdrpb07z4Vp8+qsl8EgY2dXpb7Cfc4NIGz6X
 Lz5G8B7Tp/NWqlMotf6jUfruY4X5yha9aEXLcziyNk5lfnfQrtbO9I4lVoAoryASL4px
 cEs+6SKQUjCZZDH1VGGb2MQPGP4kmCg3ZyVOXFxaoT4C5W71LxSujb+xMN6dyU6FV1em
 nAbXi9oKX8OU1mDmX96oMKbswPHlIf7ykK0TL5JE/6CtP7SuKSJueBakICJdgnyX8npp
 CqKmTtZ90h+CNm1Mzd8vHmz9azdXwOPzil9ZkvDDD1DF1J2ieg1iH27nhqL7TnJlS6kM
 Rz3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4WWOBeXvEgDhPOAeXnfmAYZvNJ4R6Ww6Bn3ehfJi+AjkBDFDNvmDbhX/cYCgJleWHWQURRn5JsnX+@nongnu.org
X-Gm-Message-State: AOJu0Yy0nkt/xfQ78buxujp5xicdaNqh0Hwz1aS5taAgTGk4LRo2nwpg
 +zhiVudTi/pHb3s09OHGoIYL6UdfU0wvrNWgTGMGa2C7gKCoc23zD2421yXIKDsQew7YV9r4vj7
 4u4+7IpP6xtgmsL6l8ebZDmMrSCLd9FCHAG/L/SDXbQ==
X-Gm-Gg: AfdE7cknF6rJlM7nfS719K5Lp6973c630+FPpEVrqC0M4CSwc7m74APrtRJ48Pf2U/5
 z7icNF6DhlyIpKApe22DjDKIQI9DIgTpKr9HheRI0hT6cC3DCyd0TpF3z5UWUXXBqYm+pwSEj7X
 9p0UUYBKDbzh2+3z+w21DmjUdpOVe5uua0jn+kryDi2PedhNpiGCiWxwHGySoZeuk/MVwgdNGi6
 sfFM6xTKHFIjOgh5EDpBosXh15/baQutu1n+08DaIDNOWLOOILiPeb7GQ3i8W5x5EBHTjcU
X-Received: by 2002:a05:6a21:3393:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3c0bcfb89ddmr11259624637.23.1783614864086; Thu, 09 Jul 2026
 09:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
 <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
 <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
In-Reply-To: <CAEqNhNZqEFz9oh2jY7EDx_ZWBgzTVstQjtZL4O3xSbK7LRwBZg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 9 Jul 2026 10:34:12 -0600
X-Gm-Features: AVVi8CdQCqkBrUzjW7lV_uom7ZHSaDLOmj_vbhT4eub63UjuaF5qquTVkWXdDCA
Message-ID: <CANCZdfrksU3BvrHEgiJinsNWrgx_gGxyS4AzybChKUwfXkOuuw@mail.gmail.com>
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Brian Cain <bcain@quicinc.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="00000000000063e4460656303271"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52d.google.com
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

--00000000000063e4460656303271
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> On Thu, Jul 9, 2026 at 2:51=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Wed, Jul 1, 2026 at 10:21=E2=80=AFPM Brian Cain <brian.cain@oss.qual=
comm.com>
> wrote:
> > > On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
> > > > On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain <bcain@quicinc.c=
om>
> wrote:
> > > >> I'm working on upstreaming support for hexagon system emulation an=
d
> it'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify
> booting OSs like Linux.
> > > >>
> > > >> To that end, I think the initial step in the process is to mirror
> the repo in the qemu-project?
> https://github.com/qualcomm/hexagon-hypervisor/ is where the code is
> hosted now.  And once that is done I suppose I would add QEMU patches to
> add the build process and build output into roms/.  Can one of you do tha=
t
> mirror step or suggest how I can do it?
> > > > Hi Brian,
> > > > I have created a mirror of the stable branch here:
> > > > https://gitlab.com/qemu-project/hexagon-hypervisor
> > > >
> > > > Please take a look and let me know if you need any changes.
> > >
> > >
> > > Excellent, thanks!
> > >
> > >
> > > I have a feeling that the 'stable' branch of this repo was a 'good
> > > intention' that does not have a process by which it gets updated.  I'=
ve
> > > asked the maintainers if they plan to keep this branch active or prun=
e
> > > it.  And I'll ask if they can generate a tag/release that we could us=
e
> > > as a basis.
> >
> > Hi Brian,
> > Would you like me to change the mirroring configuration to follow
> > "master" instead of "stable"?
>
> Yes, please do.
>
> > > What's the process by which we update our fork?  It has an automated
> > > mirror process driven by gitlab?  What if we need changes that
> > > can't/won't be upstreamed - can we make those locally?  I don't yet
> have
> > > any plans to make local changes, just want to understand how the
> process
> > > works.
> >
> > GitLab automatically mirrors the upstream repo.
> >
> > It's possible to change the repo configuration to act as a fork where
> > you can push downstream-only patches, but at the moment it acts purely
> > as a mirror. There is only 1 repo I'm aware of where it was necessary
> > to do this. Usually it's possible to get patches upstream. Please let
> > me know in case you need downstream-only patches and we can set it up
> > (this should be a last resort).
>
> Agreed - I expect we'll be able to upstream the changes required.
>

Long term forks are an enormous pain. At most one should use the fork as a
staging
area in advance of upstreaming...

Warner

--00000000000063e4460656303271
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, =
2026 at 10:32=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Thu, Jul 9, 2026 at 2:51=E2=80=AF=
AM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"_bla=
nk">stefanha@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Jul 1, 2026 at 10:21=E2=80=AFPM Brian Cain &lt;<a href=3D"mail=
to:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.c=
om</a>&gt; wrote:<br>
&gt; &gt; On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:<br>
&gt; &gt; &gt; On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain &lt;<a hr=
ef=3D"mailto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;=
 wrote:<br>
&gt; &gt; &gt;&gt; I&#39;m working on upstreaming support for hexagon syste=
m emulation and it&#39;d be useful to add the h2 vmm to QEMU&#39;s roms/ in=
 order to simplify booting OSs like Linux.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; To that end, I think the initial step in the process is =
to mirror the repo in the qemu-project?=C2=A0 <a href=3D"https://github.com=
/qualcomm/hexagon-hypervisor/" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/qualcomm/hexagon-hypervisor/</a> is where the code is hosted no=
w.=C2=A0 And once that is done I suppose I would add QEMU patches to add th=
e build process and build output into roms/.=C2=A0 Can one of you do that m=
irror step or suggest how I can do it?<br>
&gt; &gt; &gt; Hi Brian,<br>
&gt; &gt; &gt; I have created a mirror of the stable branch here:<br>
&gt; &gt; &gt; <a href=3D"https://gitlab.com/qemu-project/hexagon-hyperviso=
r" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/hex=
agon-hypervisor</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please take a look and let me know if you need any changes.<=
br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Excellent, thanks!<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I have a feeling that the &#39;stable&#39; branch of this repo wa=
s a &#39;good<br>
&gt; &gt; intention&#39; that does not have a process by which it gets upda=
ted.=C2=A0 I&#39;ve<br>
&gt; &gt; asked the maintainers if they plan to keep this branch active or =
prune<br>
&gt; &gt; it.=C2=A0 And I&#39;ll ask if they can generate a tag/release tha=
t we could use<br>
&gt; &gt; as a basis.<br>
&gt;<br>
&gt; Hi Brian,<br>
&gt; Would you like me to change the mirroring configuration to follow<br>
&gt; &quot;master&quot; instead of &quot;stable&quot;?<br>
<br>
Yes, please do.<br>
<br>
&gt; &gt; What&#39;s the process by which we update our fork?=C2=A0 It has =
an automated<br>
&gt; &gt; mirror process driven by gitlab?=C2=A0 What if we need changes th=
at<br>
&gt; &gt; can&#39;t/won&#39;t be upstreamed - can we make those locally?=C2=
=A0 I don&#39;t yet have<br>
&gt; &gt; any plans to make local changes, just want to understand how the =
process<br>
&gt; &gt; works.<br>
&gt;<br>
&gt; GitLab automatically mirrors the upstream repo.<br>
&gt;<br>
&gt; It&#39;s possible to change the repo configuration to act as a fork wh=
ere<br>
&gt; you can push downstream-only patches, but at the moment it acts purely=
<br>
&gt; as a mirror. There is only 1 repo I&#39;m aware of where it was necess=
ary<br>
&gt; to do this. Usually it&#39;s possible to get patches upstream. Please =
let<br>
&gt; me know in case you need downstream-only patches and we can set it up<=
br>
&gt; (this should be a last resort).<br>
<br>
Agreed - I expect we&#39;ll be able to upstream the changes required.<br></=
blockquote><div><br></div><div>Long term forks are an enormous pain. At mos=
t one should use the fork as a staging</div><div>area in advance of upstrea=
ming...</div><div><br></div><div>Warner=C2=A0</div></div></div>

--00000000000063e4460656303271--


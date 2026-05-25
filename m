Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B1ACD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 17:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRZGd-0003Xa-Es; Mon, 25 May 2026 13:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRZGa-0003XC-SZ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:39:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRZGY-0001PY-8v
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:39:04 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36aa4ae1f11so1124399a91.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 10:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779730740; cv=none;
 d=google.com; s=arc-20240605;
 b=cA5QWueUvQqY/FRSgODKf0Lt4NIirHDGGlCocjKiyJLsceePn8oj7Y3h8VxEo02o5n
 f3TNb5cqNQFSb2z+YhqYdYG0Mcs8RrYnM1eYavP+K82CJyBNJax1yEO2iGWeuwADkXjX
 fEbYl5pAw5STZAOd4pzLKVoWgQeA7F9zrvz1BpjL8Dzxu4swfk2I4n31Nds6ONyMw/ZA
 oKt6cIFk+Zl+YB6XWVn0QbmfCF8bGkORrSTY2hUnD+f6REITzmIOBzT+quUfkOI1bQ6u
 wMjoTLGZo+loxXbarN2MnGyL7JB2YTkfDVioh9TROmDbusp+v1oFYC5WpaZXoi2Lv0js
 cnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IAKYL26wcUgr+pmddtPtFRBhdgsROCUt334piaPIZww=;
 fh=II3zEG97Ou1nLpLRMV5vTgO13i998QrAniEuWozIk4o=;
 b=BgbDqxz+L/bCUWyHS6jSbS/j2i09c0sAEvIGw+247T2p+B1j4eojf70L/WZPxtC569
 GXRZD1qGIP+OiNatqFyUkxwHLU3h1rhYDfmWwh+UetUvK7Y9kfTo/1ULM/T/LnsvTCtU
 EUANhJkYOql+qj3VWrsRxp04TpgvjCEMzg53pdTCnyxTAukedsCB00SMeqHrqs7kNmqM
 9ee0xynvTBQXl+n3fS9S1vGTUZa7aY/AsXMse2RoAVosW2QUC9DDGajFe1ht7RBaCoz5
 X+D09hs2IRlBPV/P6fRTh2iX/5pvKkgf13/6IbTgm6goYdSpbFOUumJvTixHgEBdG9oa
 79/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779730740; x=1780335540;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IAKYL26wcUgr+pmddtPtFRBhdgsROCUt334piaPIZww=;
 b=fD6CRaPRlQGaWMnog+1upYZcmlgLNCAvBOIwNoe76gtJ37XyxS9v/4d4AytlTxK9nA
 nNFk299mVXfdMyXQ4aN7wviZwCagj2Ewx7Fp1vRHtsJS/zECFwkZOOeqjbWTLshqrHo/
 ZfixekzsLYmGYCVTDLnFm3nntRSPLJqAncU9ak069bEa+sPhuSutLARS1TrsBNyZXwgg
 JZRBmH9SCH9ioJsjX/Q4+RBsEaV4RvOSsaMS6RjjVoibO9iZJJZ9TPcjwhWZjym7k3Yj
 t5YarejGX6nAB2eG7cSiYkEoTLMZlnyM7xReCaqAqWcVlqsMfreWocRajSrV0lB75mcS
 Yjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779730740; x=1780335540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAKYL26wcUgr+pmddtPtFRBhdgsROCUt334piaPIZww=;
 b=XVVDc6d5iCVh+PG+wVEsjdJl2wQrljIBG/09OHCrT14sFkamjIujVR9Shc3hX7S8HD
 NKEKYEsha56BUzLfUlXweLrqLAazQELRNGUDflU7Xvz1tPzg+3M3D9zE+UaM49jl+Uu2
 BZg4b3THtYl69pAEnHauxn27EPR8yByHt/EDWhI7nOD2C0Imp5iht/mw1qVGlWVSbHn9
 Ws/cKQj/sBg+YzaP29hLLHj/l8qqRyAn/8BXEyK6nYHobSBZUENqmqhpU8EjA/BVfAoK
 kWjuo5Sa7Il4x355GmXusdaZpuTe1+jasLVv0V/MVQNB5DGrI4ifJ/MratgjPfKUNpjv
 i2lQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GzOtphww8MGpFC56RnnNMAqPRKmaCNVIxHKd4amu+5yRAnnM0v2gY8rqecu4kd9C49Pc3TXbna74u@nongnu.org
X-Gm-Message-State: AOJu0YxILIdb9mxRvCpfQtKjSUTqgbG51t8eDqhTQsgWRqui6q1xr+r5
 sUC2bU83/oXOEfAdE157auoHcUB3uw4xLurgzMk6/qxh0hZAo10srR2/uuDxuekt2QtOIk7EmYd
 60MVqoEvGdDtj5Lum2PqcgvdfM2yblWvIXdP0qLQdzD3baK4e4O21SQw=
X-Gm-Gg: Acq92OFhX3YhA9vnP4pBPFYFDI5UOt9YqQk5qguxLjqkkjXqIWTTcHFRRvmROvoAPXa
 jHS5CvMsqOA+zpxeqyWLCf8Y/ss6La5Fik+fYcUwg33IZCWviUAnfz7VefKAkB6OR8126tNMI7Z
 RnuTYRM+syDm91JKb6nirAaSDdXqe8DNYzwlbnYf89BaO+eLrNZt/YkdIhu4toCGzNEBbatBU33
 BFk+amlMHruTjwpCGyCfeoVHXyBwPuusr4bzrYYVGrY6qmXxnmSlwHKzChFkncjW8tWNGi/FZRB
 k33zEyrhOCTJrw3JbJvBDiHCPWi3ACN+DThCrJtMO+mraUQo
X-Received: by 2002:a17:903:17cc:b0:2bd:4b8c:fd30 with SMTP id
 d9443c01a7336-2beb085c6ebmr167973815ad.41.1779730740200; Mon, 25 May 2026
 10:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
In-Reply-To: <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 May 2026 11:38:49 -0600
X-Gm-Features: AVHnY4KejkLuqB7Vsagv0SmNk46695P37BFV93D0eLn_Kf7DM-o5o0v4Mvd6MRs
Message-ID: <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000090d61f0652a7dac9"
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

--00000000000090d61f0652a7dac9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:41=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

>
>
> On Mon, May 25, 2026, 11:12 Warner Losh <imp@bsdimp.com> wrote:
>
>>
>>
>> On Mon, May 25, 2026, 8:36=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>>
>>> On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmai=
l.com>
>>> wrote:
>>> > If you have a FreeBSD build host available, you could install
>>> > gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBS=
D
>>> > build jobs to your runner.
>>>
>>> QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of
>>> disk space available.
>>>
>>> The following images are available:
>>> - FreeBSD 14.1
>>> - FreeBSD 14.2 (ufs)
>>> - FreeBSD 14.2 (zfs)
>>>
>>> I can provision the machine for you via remote console access and add
>>> your ssh key. After initially giving you access, you would become the
>>> maintainer of the VM and responsible for keeping it updated and
>>> connected to QEMU's GitLab CI.
>>>
>>> If you would like to do this, please send me your ssh public key and
>>> choice of FreeBSD image from the list above.
>>>
>>
>> Where does that list come from? Those are older versions of FreeBSD by
>> now...
>>
>
> These images are available in OSUOSL's OpenStack instance where the VM is
> located.
>
> If you can upgrade in place from FreeBSD 14 to something newer without
> requiring console access, then that might be the simplest solution.
>
> Otherwise I can upload a custom image (for QEMU's i440fx machine type wit=
h
> virtio devices) if you send me a URL to the image.
>

If this is a EFI boot, then there's no problem upgrading the ZFS image in
place: I just make a new boot environment (or enable it from scratch). This
doesn't need console access and if I totally mess it up, I can start over
from the base image :). But I can script it.

I may have to get in touch with the OSUOSL folks to see what it would take
to update their image collection. It would be good for me in the long run.
FreeBSD is likely well known enough of a name we could get some resources
from them.

I've not setup a gitlab runner, but I see we have a gitlab runner port. Is
there a current setup with FreeBSD as a gitlab runner? Ideally, we'd be
running -current that we update from time to time and then do the builds
using the OCI containers FreeBSD now produces for 14 and 15. I even have
Containerfile files for 14 and 15 I put together to compile-test bsd-user
if we wanted to expand the gitlab stuff. I've wanted to do more than
compile testing + basic booting for a while now... I also have scripts that
create bootable images (for system testing) which coincidentally have an
itermediate directory that we could copy the qemu-*-static files into and
use a a jail for bsd-user testing.

Warner

--00000000000090d61f0652a7dac9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25,=
 2026 at 10:41=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gm=
ail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"auto"><br><br><div class=3D"gmail_qu=
ote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25, 202=
6, 11:12 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank=
">imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25, 2026, 8:36=E2=80=AFAM =
Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" rel=3D"noreferrer=
" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Mon, May 25, 2026 at 10:01=E2=80=
=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br>
&gt; If you have a FreeBSD build host available, you could install<br>
&gt; gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD=
<br>
&gt; build jobs to your runner.<br>
<br>
QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of<br>
disk space available.<br>
<br>
The following images are available:<br>
- FreeBSD 14.1<br>
- FreeBSD 14.2 (ufs)<br>
- FreeBSD 14.2 (zfs)<br>
<br>
I can provision the machine for you via remote console access and add<br>
your ssh key. After initially giving you access, you would become the<br>
maintainer of the VM and responsible for keeping it updated and<br>
connected to QEMU&#39;s GitLab CI.<br>
<br>
If you would like to do this, please send me your ssh public key and<br>
choice of FreeBSD image from the list above.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Where does that list come from?=
 Those are older versions of FreeBSD by now...</div></div></blockquote></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">These images are available =
in OSUOSL&#39;s OpenStack instance where the VM is located.=C2=A0</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">If you can upgrade in place from =
FreeBSD 14 to something newer without requiring console access, then that m=
ight be the simplest solution.=C2=A0</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Otherwise I can upload a custom image (for QEMU&#39;s i440fx m=
achine type with virtio devices) if you send me a URL to the image.</div></=
div></blockquote><div><br></div><div>If this is a EFI boot, then there&#39;=
s no problem upgrading the ZFS image in place: I just make a new boot envir=
onment (or enable it from scratch). This doesn&#39;t need console access an=
d if I totally mess it up, I can start over from the base image :). But I c=
an script it.</div><div><br></div><div>I may have to get in touch with the =
OSUOSL folks to see what it would take to update their image collection.=C2=
=A0It would be good for me in the long run. FreeBSD is likely well known en=
ough of a name we could get some resources from them.</div><div><br></div><=
div>I&#39;ve not setup a gitlab runner, but I see we have a gitlab runner p=
ort. Is there a current setup with FreeBSD as a gitlab runner? Ideally, we&=
#39;d be running -current that we update from time to time and then do the =
builds using the OCI containers FreeBSD now produces for 14 and 15. I even =
have Containerfile files for 14 and 15 I put together to compile-test bsd-u=
ser if we wanted to expand the gitlab stuff. I&#39;ve wanted to do more tha=
n compile testing=C2=A0+ basic booting for a while now... I also have scrip=
ts that create bootable images (for system testing) which coincidentally ha=
ve an itermediate directory that we could copy the qemu-*-static files into=
 and use a a jail for bsd-user testing.</div><div><br></div><div>Warner</di=
v></div></div>

--00000000000090d61f0652a7dac9--


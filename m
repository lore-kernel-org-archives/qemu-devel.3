Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FB8C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9mt-0000s2-HZ; Sat, 21 Jun 2025 21:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uT9mo-0000rd-7I
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:22 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uT9mm-0004MS-3s
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-31332cff2d5so2110841a91.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1750556778; x=1751161578;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xCN9vwQasCmRiDHHnCGjMl4W3dWRMRm47fgSiB8rV2A=;
 b=XJymWeuvdFCAkfj1OhPs8dr0BhfsA91pubggi0AEDCgezakxxnaoEindC1mMOHHcJh
 42Va18xnrhbdWxuTua+3u4LG+3PmZaR4fhAlApCcNgZFT/yi/UsY9lR+xe9fx06c3W/K
 EabmB3jfdiGMwMntCLeC9dxJ0J0wayFtgVHfo/F2VqCNAGwAjRTHVpgkZtNwEC8aJk5x
 TgdSO/Phu02+i2Y/8a5456z34XWsxZwjJy4jzNyvcrfy5gB0y3HZjxaTb196MulsMQ6g
 ZffIoRXylKoB2dmSAw3/pueWYsW06eS8sYoiBog0MNwonl6kwc9Skt5pCy4sfUa7hvmu
 Q3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556778; x=1751161578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xCN9vwQasCmRiDHHnCGjMl4W3dWRMRm47fgSiB8rV2A=;
 b=WuGDmoc50BBxNG46UKyhdzEvpaBMrQy35RCipGOtrJEcQVRVWf42gcQGdMZc/24umO
 3Va8J6QtGzC517hKkcKOTEhTNllaR+btpvsAxTds7KfrLd3kwBXaJsA3WEhHF1wZHQfm
 gSDSlyG9pRZMlFpgh01xn+NgySIDcT33ujveHB2VOWblcOELlzKNeSjw96fE0UGVtcMa
 k0M2NjtQ4KRuMQEtJm3eRmzlyMsR044CvwizrY0rM1RjM+EWM+IgzIU+9Dr1+vmaArpk
 XHh3SMwNnDLi8ux0B9fq24tSSpEwA3bndFhcpfWu8p/WFlsPyW64pedNt8vwOW5ReN3j
 tl0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVloDL6hgiCWpVy1Vigov+SnNBMnu8zHMit8E7QAai1VhGbwSJ/5fyajpD+MmAIkadcxX4pZIlb95cP@nongnu.org
X-Gm-Message-State: AOJu0YyB0sXUL5fsAdIENS1uUCgJypW6i4dRrXfx74ZKZQ0OiEw51zK3
 z5CjVMvChzLGnT47/ZZvl9QaQQHR0kb8u8zIV+4PfJPazp2M9jbhKFwgEpMXP35BcRcz0w/YbBG
 StMj+Z4Xd5YhHVRoBPkuNN21CFQdWqmYK/a4ZAP3fjjFsAeYfsyxKPGE=
X-Gm-Gg: ASbGncs2L6bo5mLeGUHPe1K6DNyLCW3TfaYxWuIm35QaLa1+dtX+zcjT5BM+JtS3vnC
 1+ixPfG9K+90jBvc/jvXxdAWk9McOacqgK26Asb/NujqVZ+25k+/RYPdYUSVMYF2i6jzSyvIZZ8
 tZDBa6lUMWOOP3e7+xSr7yST60itbQQiJwQnDDBHErCifoe1CDcmKB+OcdJ73NOugvKKx6B3HHo
 WWx
X-Google-Smtp-Source: AGHT+IG2knrDrVyx9RKKXz0+NpBntJ6swEVpgJ621QmI58ci/5C+0u/vsSpD4VMM9SrFnHTuh7EnQskuyQ9obPXfj9s=
X-Received: by 2002:a17:90b:3c4f:b0:311:b0d3:865 with SMTP id
 98e67ed59e1d1-3159d8fd0f2mr11340876a91.32.1750556778072; Sat, 21 Jun 2025
 18:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
In-Reply-To: <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 21 Jun 2025 19:46:06 -0600
X-Gm-Features: AX0GCFv4JB9yYCNl3yLCsiUNfhXwMbWMBNx_Yl9PmLgYTFr6Qvn3WxWOFdWgfUc
Message-ID: <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ea9f1006381f427f"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
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

--000000000000ea9f1006381f427f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:

> On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om>
> wrote:
>
> (I forgot to CC qemu-devel)
>
> >
> > Hi,
> > This might only be temporary, but the CI is getting HTTP 404 Not Found
> > for the following URL:
> >
> https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/FreeB=
SD-14.1-RELEASE-arm64-aarch64-bootonly.iso
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
> >
> > Stefan
>

Time to bump the version to 14.3.

Warner

>

--000000000000ea9f1006381f427f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jun 21, 2025, 6:01=E2=80=
=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sat, Jun =
21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>&gt; =
wrote:<br>
<br>
(I forgot to CC qemu-devel)<br>
<br>
&gt;<br>
&gt; Hi,<br>
&gt; This might only be temporary, but the CI is getting HTTP 404 Not Found=
<br>
&gt; for the following URL:<br>
&gt; <a href=3D"https://download.freebsd.org/releases/arm64/aarch64/ISO-IMA=
GES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://download.freebsd.org/releases/arm64/=
aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso</a>=
<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L84=
8" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-=
project/qemu/-/jobs/10424901718#L848</a><br>
&gt;<br>
&gt; Stefan<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Time to bump the version to 14.3.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Warner=C2=A0</div><div dir=3D"auto"><div class=3D"gmai=
l_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000ea9f1006381f427f--


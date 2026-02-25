Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ED1F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5EZ-0007Zg-N0; Tue, 24 Feb 2026 22:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vv5EW-0007ZS-TL
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:06:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vv5EU-0002Dj-VF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:06:40 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso41816825ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771988796; cv=none;
 d=google.com; s=arc-20240605;
 b=Sxfxm2wQvmjjbROpJ3FNx8UqjC3zsB9GzowO77WdenLOSOu0YjvJUmfka9J19rHWuo
 17W3nRmM+xJKRcDIGm2qtliqTcwRx4RcO+4xiC5VOCKH+cfdQp8TF/IJRQh2dmPxTuOx
 tI7RHHhbLGS73wsX+8anze92AUO906QoW+rsYU8nC/ff0YTKyXje1YwGQcnl2UQ1QeW/
 qZ+YfewIAprSCmJD9OSa7kC/v5o7byBF2PKwAsIRe5EpakjyyvON68zavqUK1AdBrOiM
 HU79D0xURKR9dsDYr+NdFmNpGrBf5hxQWwh5ChnHVU7gZmTM1xzraXf2wG9YmK1ASnZu
 eRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qs3ZCfUNubDEIPG/ZDzJhHpm36qXteQLxPK9Yg0S0U8=;
 fh=wiQ9LKYLGlwsKiPE0m+1ZHo5Z9ETxN9Xu1VI76kzwng=;
 b=IywQzmWeaT4yhwPKXaV6IZ1uIg2SmroBXzkH+bWPi9M83Ifj42arkSLVV+GJl7uNUO
 Tiubiy+FilMjCUh+YHQyTjT1OFPrku1Rde5+9jbjV0yRin3wlcJJtB4moE8zyB3rbhe/
 Hdk7dSqHUr7mg7KSS4knW1oZVSiUhXnBm+ZK/uhT38qMwXxbreiWOXsMwz6tCF/vPcQe
 ZB10YCLy4jXoETjmwokdAUEPhHz9If5FlNHkJ6zsPF3odDUgLKOWcDkbPfDWK4koLwKe
 PaM9m+S3Lj3+QWT4u5XRsrtzaNtrE+2WbD9NcZ3n5p77lsWb/4UPoVW7zGYmD0dMLtHW
 mcug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771988796; x=1772593596;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qs3ZCfUNubDEIPG/ZDzJhHpm36qXteQLxPK9Yg0S0U8=;
 b=EueatKnXwvVP1R79umVNzXroKCeFg0P9ScVs3Ye/X/alij/Vd9qTakWXQYX5ZX1NMa
 m1EX3RuhVNO5sP5f1bvCtxMTfooW4G3hlExm6/lMPExo1KbeYAl4uf2FhZEJWEvhMxrn
 kpT7Hcxc6eHT4V/GFIDXK0Fa+uLcHzeMIb4uT5P3GjRzU1x026A9dZD20WEUQoRoByi5
 ko7+lxq9da6FB3ccRQar1dAnJ73kbneGm/UKlpqaJaF25dP0PqldHuMdws60cF8Ys6FC
 /4i6VvP8Zxa1YmPZnPf/R7U/oXp80UAXcE/5PEMp1L0lduTWf0pnFe4bWHPKSzzCTjQI
 3vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771988796; x=1772593596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qs3ZCfUNubDEIPG/ZDzJhHpm36qXteQLxPK9Yg0S0U8=;
 b=bqFLHJzHSm3EsLPQjnyp4RQW5kLAVMvKS22Ra03A9JaMBq7/qphnYkDtBWShoStS86
 vurJSUrbN1W5xwFdyUtCH+WFDzdFYx6BlIZk0JbJV/k2RzZu1Tteg2lgL5m7iQCsMkqf
 M/UpoOt3EnI0mcPC88ZLAymQ7bIBedfUmNI1jDB/2s4KNe64HEUxKNMmjb+Vnhq3ITa4
 WVMJAOzcjFTv8UpslFKCl1zFCGNgTdxs3jk56rmJADO9KKUGHi76EJWKB+iBWdk7rR18
 1Qj006Ra6IL/AcopwoWcFFNcOfKjqMudcOo5ru5snNGcdK9st9scBFnW7a2ocmnNeVt4
 9PGw==
X-Gm-Message-State: AOJu0YwtEuALAfgp2U6AQoT1v+V+jk4268CIPMaFjiE2ulnbPdKl4VzA
 KeFU1zG8ULj5Y+SO/cW1A/wMchrD+PJgTxZP1l6pwmg/UKIbXcgUvbT4dNUkUiR7sXLletUtUOw
 gDo9DWi7SFM2dV05awLIyqr5A24zPKEFFpF9/zAzzXA==
X-Gm-Gg: ATEYQzwtZLI1EkHVH5RnzSp8vgxE/9tgUtFkD2ImaYD/wFDetOX7OYnCHkNeNVOSdQe
 vK9sI1ezk5W9p5zuEwY7NLAY+GfhmXIZRXD9O05F5bHyDnEsDy3zWiZPxccN9qfUeXpBKeUvSUp
 szCUFKNmungb4trjVBhI8dbhboXyvZN/QBp19Huk6qFWci3GNd1kpjAcTllXVTYqbicgshbPnCn
 4SLbh6WctRKBOW6rQoWBxpUf7sQ+zHqYcTag/kj2nCD2KugmfRPRrkEkEeuAlAtbQ6cfGGaBaRw
 skmr+BxtXLzWfCwDpD3RW8wx5r6eSPiCYlR1uEj9yP895XYe
X-Received: by 2002:a17:902:cf4b:b0:2ad:6e0c:6210 with SMTP id
 d9443c01a7336-2add140994dmr9063035ad.56.1771988795996; Tue, 24 Feb 2026
 19:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-22-8ee5ae17056f@bsdimp.com>
 <CALH631kA4Ww_9TP=1wH5Xvr9766kakngc3tKM48vAhVHA4i9vw@mail.gmail.com>
In-Reply-To: <CALH631kA4Ww_9TP=1wH5Xvr9766kakngc3tKM48vAhVHA4i9vw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 20:06:24 -0700
X-Gm-Features: AaiRm51M7zM-gIQjq7TWnkYEdwiDP-CfB4XNpLmPRpDvNiMubSjTqzOcTH5QIOA
Message-ID: <CANCZdfq9kVDt-pf=DKs51b7ZqUp7iO_RCGyaHVmyPcT7haPBGA@mail.gmail.com>
Subject: Re: [PATCH v4 22/24] bsd-user: Implement System V semaphore calls
To: Gleb Popov <arrowd@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000bb4bb3064b9d4abe"
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x631.google.com
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

--000000000000bb4bb3064b9d4abe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026, 8:45=E2=80=AFAM Gleb Popov <arrowd@freebsd.org> wrote=
:

> On Tue, Feb 24, 2026 at 5:42=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrot=
e:
> >
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Wire up semget(2) and semop(2) syscalls to get System V semaphore
> > implementation, as well the undocumented __semctl used to implement the
> > bits of the interface in libc.
>
> semctl(2) seems to be documented since FreeBSD 2.2
>

But __semctl is what actually implemented the system calls with a different
interface...

Warner

>

--000000000000bb4bb3064b9d4abe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24, 2026, 8:45=E2=80=
=AFAM Gleb Popov &lt;<a href=3D"mailto:arrowd@freebsd.org">arrowd@freebsd.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Feb 24, 2=
026 at 5:42=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" ta=
rget=3D"_blank" rel=3D"noreferrer">imp@bsdimp.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt;<br>
&gt; Wire up semget(2) and semop(2) syscalls to get System V semaphore<br>
&gt; implementation, as well the undocumented __semctl used to implement th=
e<br>
&gt; bits of the interface in libc.<br>
<br>
semctl(2) seems to be documented since FreeBSD 2.2<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">But __semctl is what actu=
ally implemented the system calls with a different interface...</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000bb4bb3064b9d4abe--


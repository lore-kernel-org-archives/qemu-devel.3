Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE8CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWyw-0004w2-RY; Mon, 25 May 2026 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRWyu-0004vi-65
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:12:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRWyr-0003aj-Up
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:12:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so6508992a91.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721956; cv=none;
 d=google.com; s=arc-20240605;
 b=DJhk5cJa3Raj2vucUPqilIk93Uk8q/jv9e9yWuR1k53K8JE2sE8wHhgWgsggTwAQE9
 2hwGlZxizXDAl/+HvAVgdzGp5RHqj1eSgexECmgNzBDYGQj+y2LSKLKhOm7COPtFWv7I
 JzK2Gv8oCwqo6FHtNoqZFCy76wAxwk2TSvTSuPLH/J8VPsa5CX4itY4PvtGi7OlJgMWg
 oPrHx2160q+BbTM+NWh+a3mL8G9R/g4hIqK8Jh1WDri4sLneSYZh/MvNS/xpWotAvqIQ
 AliFdd68yStj14XX9GlJFq9aEdby1FizZce9INyNXKo+rHK+YnTeaPJbLgMvdibAawx6
 XVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZKUAwDshkc4Ng/iZ7fbGxGCOttU27D6ke+4uQavtQtU=;
 fh=DCouXjhqaX4HPdvk19UT1l4g31qS8/wfcdUDqYT6hjg=;
 b=B1jmnV5bxfhxW4ch69cePJLeT5oWORX9RDyuseRH9NNH3nLVi1nxaLv1tFyNkyWdkg
 qZaRK63mhxBxQUY38E51GSdtMl6RLQeBiJ39+OoFnty+yk8sR/URL2Mv55lfiIOU6hiM
 xJ6LgrODpB5M3TZnZZBC9t5APoAgq3Eo1m8gEz9LekmcsCMlo5hVvMaPcT9u5x+qmeTy
 y+tOpHLOE25xTzdRp/nh2Oxm/fJGK7jh1opCMvj8TzxXWRFdBy9hOoljvJrULhchhKzA
 Xg2O9VJ2uk65AKc501xbEo9/lYlMV34AaHL6LPXy2UfB6iuq+/lBCwPUO7flE99gmBda
 mRcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779721956; x=1780326756;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKUAwDshkc4Ng/iZ7fbGxGCOttU27D6ke+4uQavtQtU=;
 b=jydjpxAs3ZxyCHucefKo4vQowPckc8OFSj+WS0u1UvjqM+v4snMRu6I96l5etNPRN1
 XUUyVnKtSerQpnUw0xlVTZd1opTGkf5jvz0pIUp1hHpq0L1KD40hnEZ+9RnkxYEBL0oP
 DdiDt3GXr9ngCqBX8ZCdroMQw54Q7UhfHxSti+ySYyjAqlLCww3snGngxNQ2MHvgunJc
 kpOUwUpv+b+GiSaDuCQGmp9mwvfzu7Zf1rqOrd0/9OySGvfHGL7J5SyR4NUUU4caTK/o
 l+eXW2XQR1aZlRKmlIUiZwvXGBHhHVaqGw4ot2hiTemDO/mB+YtTQjZghuPB6DuozO8m
 B3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721956; x=1780326756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKUAwDshkc4Ng/iZ7fbGxGCOttU27D6ke+4uQavtQtU=;
 b=OtMVbw5nxAcyeaJweRYP8FAUEDHzvjYLCp5kJaxYG3lxJNigaTMjdrSy7tF43iOM+B
 RsN25VNpgtHT7WXb6k/HyM3+YKHkOimBmKxAlKfAZxizo4N4uCumwrch9vxzKaJRGS9M
 NVF69LE3LwYWjEQ/YCtmzGPn4Qfv832jtW3Hov9vTmOjZab/+u1PdfDFuG2cnFvukZng
 96XU+b3MUCLKMuG+/wYU2VRzS4bVkKqbDT2sdMr58Q6fq+2J9ONbWuYjjZv3WtZN0nKu
 s0OMyBHlcQYxKwgAN82HCtMH6nr70kr8rY9oQRKTkGb0CI9N3JsZkwTln4IiRtZI6oKn
 cnVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IOI8GLKaZ7ELnTB/cpJ9Pr3mfZ9/YplYU4fO/xKhQcQd4Lqd5LTzCoLVMBU+MUFHPbuGIlNSs8paK@nongnu.org
X-Gm-Message-State: AOJu0YzNyaB/mfL9hZj2/oR8TRBofux/Ds4tC6DjJSAg2HVCZeXtJ/Yz
 Zr2j+zlZcrl5J43Cw3NxVilVbzya7C7zlcVliyFhdqID7qD/amkRXFj6dfH9OZ6+5CV0nEORM8h
 hiZjSt7oLkUNlXTmY6iC9bFnDh3cifadQ0bg1NwC1IA==
X-Gm-Gg: Acq92OGtFRV0kmkVzrx09HkbzLeZdYELsehcQGFO4Iv7g57C96Ou8yF85GTz+HHawA5
 U/5YPdtbJUeXOnl6xnbcvcfOwG4ES+MNHzNYXCxYasDkAkYANKg/SHinRBeWiT0ZYig7RrbW4Qe
 +Z2UwUUfuWVlDYtIWjNUgLMWMIVk5OqA9Cfw7FxB/gR8aseUz2EDDTfDGUGj0KXpPyGxxu4ZXcA
 NrsFJSnvoaq02icPSdsYaKSZUJt+XXkzHm+ly5jzGXEa05wDfe1UX1Vl673Ag+4nZRnFOV1td7e
 FSFKLhNLU/Hz3D1ALcWYGGBhE7XD8IUpcUPrQYXr
X-Received: by 2002:a17:90b:4e84:b0:369:747b:48b8 with SMTP id
 98e67ed59e1d1-36a67734201mr15250183a91.8.1779721955839; Mon, 25 May 2026
 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
In-Reply-To: <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 May 2026 09:12:24 -0600
X-Gm-Features: AVHnY4LmVvJjfZ71FRKdu1AjVh_NEWMFkIRDWj1HCY29ZJTGNco3zvET7nF5f_M
Message-ID: <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fa20ce0652a5ce9f"
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

--000000000000fa20ce0652a5ce9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026, 8:36=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:

> On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com>
> wrote:
> > If you have a FreeBSD build host available, you could install
> > gitlab-runner on it and I can configure GitLab CI to send QEMU FreeBSD
> > build jobs to your runner.
>
> QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of
> disk space available.
>
> The following images are available:
> - FreeBSD 14.1
> - FreeBSD 14.2 (ufs)
> - FreeBSD 14.2 (zfs)
>
> I can provision the machine for you via remote console access and add
> your ssh key. After initially giving you access, you would become the
> maintainer of the VM and responsible for keeping it updated and
> connected to QEMU's GitLab CI.
>
> If you would like to do this, please send me your ssh public key and
> choice of FreeBSD image from the list above.
>

Where does that list come from? Those are older versions of FreeBSD by
now...

Warner

>

--000000000000fa20ce0652a5ce9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25, 2026, 8:36=E2=80=
=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com">stefanha@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, May =
25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">stefanha@gmail.com</a>&gt;=
 wrote:<br>
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
 Those are older versions of FreeBSD by now...</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Warner</div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fa20ce0652a5ce9f--


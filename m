Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE974C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkhRV-0008D5-VZ; Wed, 19 Feb 2025 05:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tkhRO-0008Co-Q8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:36:31 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tkhRL-0002aY-Uw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:36:30 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4be625c5365so897551137.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1739961386; x=1740566186;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4TxyzCvxl07ys2f5dIwWOx4N5ZsttGRWJQNf7pQrob4=;
 b=nUMIWoYU2yL27Y2Fw/SKU2qVmYVSx5ogcDmMssQOtp9oe7kB9jHlgwv8Qv8yXuMCN0
 SUis0eBsWydkLKDrz9xEoTXLab90h4XOAjMbWOwXw7nZVQ+koIrNHq0IIxee0nLVPZgV
 qQ7dSJ4MFq+kutaHMFFYWv7fcEuf4B4KFhqlrgJHFpUAfmkFyHO32gstOufAfbh6MWq3
 0JfP254gumiZlfuXLNY7kC5A5SH5rMd5TKIm3azEkA9IQ017iYrsPhDytyp4gpfai7B7
 TUbBc2KtM9SwHcyMp631PU/dNysma1jzDu+zFN/L9tKFT3+ptfxVnTAxmzjoIGEuz5eO
 MvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739961386; x=1740566186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4TxyzCvxl07ys2f5dIwWOx4N5ZsttGRWJQNf7pQrob4=;
 b=WIMetq+5+38sjWL4/UHBd3nBHDd4IyQHVz7ZLGiTPMxDghYCcHbghf/jdo9N8EWrYs
 FKH31Qn7eFSrScJQSKvz1o1JONhqfCO/tmPoOb4fh3pNNQGupi5tqZlXkVlCe/0Hwzd+
 xc0dqZ3L687Ab3q+wgPNHWR7RTf8jyYgsKCYaj3pHrN2WfG2d6bd4m6zwGWybwKYC1DB
 fyyKPJHaO1Tx3u1T/DhFDmQsUvfr97vq1lq+XcyRlG88cuSz1nI0K/TRbKqUZJhcP2fo
 ++otNCNqCHiFwJj+PoB6yeClwXh2DBUrF/l38iRRhYIEG7NdS2NDFmboufggdKa7WHvF
 PsnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdZjMqHT3Fx3kTP+Fs/2Qx1BFvKIILlRlm90dL43/JjWSJN6itzKZZvAjpyEgZP/evXI6S+FNjvURn@nongnu.org
X-Gm-Message-State: AOJu0Yzs8MiArY9HVMnUiVMRJ5aeiomWa2EsES75kKMXXetT68xguqa1
 dqemCRSYG3hE0PzlCkIE/QYL5bF7ezBxvaZKI4U8GB6eqa/zXmtzrQq0JeyhBTBN/cyKfWXGZPU
 otUIV7Mx2IPWSuuQiJ9aXHqJ1YnVzPgPro4oe
X-Gm-Gg: ASbGnctIGcO2tOz/hAankzq/v/uLEgr2ME/KUWukww+dguodVoa+8UkQ/JfPky3ytsG
 CffBF2rmRHqzVQMRJE0n5K+rVMPsib3o2fANMD2VgQ7b8s+RUREYWKkgnKuq4WnPLXSnNv8yk
X-Google-Smtp-Source: AGHT+IEIVV2kw6eCViLOxoRWk3jpAGTObcOaV9UPUPxYTy58PkIMJdV+J+VsE1Hpy2sXw0tsnJplaYmHc4k/LsRsfQ0=
X-Received: by 2002:a05:6102:2b8e:b0:4be:3320:aa08 with SMTP id
 ada2fe7eead31-4be3320aad2mr9197782137.11.1739961386147; Wed, 19 Feb 2025
 02:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20250212112958.38023-1-philmd@linaro.org>
 <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
 <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
 <CABgObfaq2m42tBUAmskSXm-fR6zKDtApAsR4rYYqg8dnMq+Bog@mail.gmail.com>
In-Reply-To: <CABgObfaq2m42tBUAmskSXm-fR6zKDtApAsR4rYYqg8dnMq+Bog@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 19 Feb 2025 11:36:14 +0100
X-Gm-Features: AWEUYZkKBQvjoBJudNsUw-psw3OEysc6o3cyFBGBjjKSfdS9xgmjVXPFRCbJlJk
Message-ID: <CAAibmn3MvZtng=4vAGx6yNfMkM+u_HRbT0CAA6WhdbTtLDE5xQ@mail.gmail.com>
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000583b83062e7c5461"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e31;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000583b83062e7c5461
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 at 11:28, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Feb 18, 2025 at 3:55=E2=80=AFPM Phil Dennis-Jordan <phil@philjord=
an.eu>
> wrote:
> > It is not cross-architecture. So, the PVG guest drivers with x86-64
> macOS don't
> > give useful results with the aarch64 macOS host PVG framework. (I
> suspect a
> > mismatch in texture memory layout and perhaps some other data format
> issues
> > Apple's GPUs use a "swizzled" memory layout, whereas Intel/AMD/NVIDIA's
> do not.)
>
> Thanks, that helps.
>
> > In summary, hw/display/apple-gfx-mmio.m has a hard dependency on aarch6=
4
> *host*
> > systems, and both apple-gfx device variants only make sense when host
> arch matches
> > guest arch. (Unless you're a developer attempting to find a workaround
> to the
> > incompatibility.)  I'm very much not a Meson expert, so this was my bes=
t
> attempt at
> > encoding these facts in the build system. (And nobody suggested anythin=
g
> better during
> > review.)
>
> I'll find a way to do that, thanks. I also would prefer to add
> --enable/--disable-pvg; I
> can take care of that, but I just need to know...


>> Either way, the Kconfig file does not need "depends on AARCH64" and it
> >> should have just
> >>
> >>      depends on MAC_PVG
> >>
> >> with an "imply" somewhere in hw/arm/Kconfig.
>
> ... which boards should enable MAC_PVG_MMIO? Is it only VIRT, or somethin=
g
> else?


I doubt anyone will be able to use it productively with virt, but I am
regularly surprised by people's creativity.

The intended target machine is vmapple, which is the only known way to run
aarch64 macOS guests. The PVG patches were part of that series, the PCI
variant is useful independently of it though; Philippe said at one point
early Jan/late Dec he was going to merge the rest of the patch series
containing that machine type, but there were some question marks about the
software GICv3 dependency and HVF I believe. I'll try to rebase that series
and re-post it in the next few days - I've been too busy with another
project to stay on top of chasing that down, but I'd really like to get it
done for 10.0.

Phil

--000000000000583b83062e7c5461
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, 19 Feb 2025 at 11:28, Paolo Bo=
nzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue,=
 Feb 18, 2025 at 3:55=E2=80=AFPM Phil Dennis-Jordan &lt;<a href=3D"mailto:p=
hil@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br>
&gt; It is not cross-architecture. So, the PVG guest drivers with x86-64 ma=
cOS don&#39;t<br>
&gt; give useful results with the aarch64 macOS host PVG framework. (I susp=
ect a<br>
&gt; mismatch in texture memory layout and perhaps some other data format i=
ssues<br>
&gt; Apple&#39;s GPUs use a &quot;swizzled&quot; memory layout, whereas Int=
el/AMD/NVIDIA&#39;s do not.)<br>
<br>
Thanks, that helps.<br>
<br>
&gt; In summary, hw/display/apple-gfx-mmio.m has a hard dependency on aarch=
64 *host*<br>
&gt; systems, and both apple-gfx device variants only make sense when host =
arch matches<br>
&gt; guest arch. (Unless you&#39;re a developer attempting to find a workar=
ound to the<br>
&gt; incompatibility.)=C2=A0 I&#39;m very much not a Meson expert, so this =
was my best attempt at<br>
&gt; encoding these facts in the build system. (And nobody suggested anythi=
ng better during<br>
&gt; review.)<br>
<br>
I&#39;ll find a way to do that, thanks. I also would prefer to add<br>
--enable/--disable-pvg; I<br>
can take care of that, but I just need to know...</blockquote><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; Either way, the Kconfig file does not need &quot;depends on AARCH6=
4&quot; and it<br>
&gt;&gt; should have just<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 depends on MAC_PVG<br>
&gt;&gt;<br>
&gt;&gt; with an &quot;imply&quot; somewhere in hw/arm/Kconfig.<br>
<br>
... which boards should enable MAC_PVG_MMIO? Is it only VIRT, or something<=
br>
else?</blockquote><div><br></div><div>I doubt anyone will be able to use it=
 productively with virt, but I am regularly surprised by people&#39;s creat=
ivity.</div><div><br></div><div>The intended target machine is vmapple, whi=
ch is the only known way to run aarch64 macOS guests. The PVG patches were =
part of that series, the PCI variant is useful independently of it though; =
Philippe said at one point early Jan/late Dec he was going to merge the res=
t of the patch series containing that machine type, but there were some que=
stion marks about the software GICv3 dependency and HVF I believe. I&#39;ll=
 try to rebase that series and re-post it in the next few days - I&#39;ve b=
een too busy with another project to stay on top of chasing that down, but =
I&#39;d really like to get it done for 10.0.</div><div><br></div><div>Phil<=
/div><div><br></div></div></div>

--000000000000583b83062e7c5461--


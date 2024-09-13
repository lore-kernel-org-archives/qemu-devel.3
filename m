Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0875FC6172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 22:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spEeh-0006NA-9Q; Fri, 13 Sep 2024 18:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1spEef-0006MC-GP; Fri, 13 Sep 2024 18:20:41 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1spEed-0003t0-7Q; Fri, 13 Sep 2024 18:20:41 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82cec47242eso120757839f.0; 
 Fri, 13 Sep 2024 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726266037; x=1726870837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YDsGym9b/QXE3ReyOcWEB4cWbs8H3bfnKyC0IsIimlc=;
 b=fxi9A0WJrQafBYNkvTbFl0VnDdZ8h2xbYTWRu+UGb88cDH2NpeX1YSItAQSSSKwA5t
 ugUNt7o86t6HTXyoU+93+2pS5MieaxD3rfo82FUrnKfzGvT63OOQcC74R4leY0L1Gg5G
 eI7pncsvA4KuwbHG6J0ezSCyrS15BpEcTnUiSSEJYrzDNo97/IhkT3zaug6WrVD18mww
 nX6gb0gimF5C7mA3NzacEbNlmcKpgxCoBlDwA3JB0Rc+yT45o/OBAh67oErtj9eLOaYz
 GyhO/TmSR8sIbjtCo/xUnqb6S8NiZHrDgNlr8xwRsdEkpR3eq7lrODO7kpwwi9lefcE2
 4VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726266037; x=1726870837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YDsGym9b/QXE3ReyOcWEB4cWbs8H3bfnKyC0IsIimlc=;
 b=RsWv7fktkgh5zwTYTR/VDQDIcpXTNfoczpwJSGvzcBqrecAviSP8XLojQRI5BJF8B7
 JGHRPzCTHLUeGZkJvPJROkE/KZ1CZkaHpFGPAL1sMiEzR0Et2WKIa6lgHBPaR8iRtFgh
 6ffGk22DyCT67xIwSzDxRYfD2Fcadl+SW+byoiVmeYxLTREGvBXhvfVNyEspdT0hcZIx
 ApTtlUL1frdSReLOHFW5RjCCtcGsoAXhavQR3VvmQZqusSX3MynXeG8sh27jHF2xmqcx
 JSg+j4KYUq2KDtqAFgH+F6dA+refRTQ3FLYIRhtUREnc/ZAS7oYqytXkx+b60ltvX0rW
 SM1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlYbIidFS7chi33kE1QZ39+hyCFHaG4yfOSFPUwKnFc10jjG+U+ZYWbKVD34+C06Sm/cxOJTyGzw==@nongnu.org,
 AJvYcCXIUklwyQGojDi811az/3MjAkpdB5oNq/gPm/zGtMCvdRDd5QfU3wVt77QhElBAjLV31v7Bzh7Z6Vl77A==@nongnu.org
X-Gm-Message-State: AOJu0YxVrBIgBmdtFiZ8noryfwKkJ8Bp/JE/sj3zDGa08J5z2tYlKR5C
 rBfKESm4dxI8dl6EzHEp+rjOv/X17OiABnDT6HvB+fZ4Rgz45LDNlhjPtT2PHHucRBs1j1ZN6Lh
 wi1D/2pRf9/KpKSP249VXP6bpNFc=
X-Google-Smtp-Source: AGHT+IFsl9ilmQFtQ0JJ0Zhnw+PDnBjUUcFGFuaDPqmRnlQlArn2rE49cTvMR7m0fwbF0nJKGrc5eZzcbihxaKCR3s8=
X-Received: by 2002:a05:6e02:3603:b0:39f:6f6c:90ba with SMTP id
 e9e14a558f8ab-3a08461c414mr51086715ab.6.1726266036956; Fri, 13 Sep 2024
 15:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <85f61ad3-da14-43f7-983c-62053ce0cfa6@roeck-us.net>
 <xgwmp3mjq2vhhwgbkbjr76o3yejkbm2ke7ybfes7xbafmpha53@pihh3myr7h7o>
In-Reply-To: <xgwmp3mjq2vhhwgbkbjr76o3yejkbm2ke7ybfes7xbafmpha53@pihh3myr7h7o>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 14 Sep 2024 00:20:25 +0200
Message-ID: <CAPan3WoqwDaDt8W8vZ7RatL_mjnY_aCA0=REQq=B7ZEebhYAig@mail.gmail.com>
Subject: Re: qemu emulation for USB ports of Allwinner H3
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ebb720062207a1e7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ebb720062207a1e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Guenter, Gerd,

Thanks for bringing up the question. To be honest I do not know a lot about
USB internals.
When adding the orangepi-pc board emulation, it seemed fairly easy to add
it, but apart from a few basic tests, I did not use the USB functionality
extensively.

I do own the actual Orange Pi PC board hardware, so I downloaded the
'Orangepipc_2.0.8_ubuntu_bionic_server_linux5.4.65.7z' image from the
official page to test:
http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-a=
nd-support/Orange-Pi-PC.html

After booting that image from an SD card with a serial console, this is the
output from the same 'lsusb' command:

root@orangepipc:~# lsusb
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 009 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
root@orangepipc:~# uname -a
Linux orangepipc 5.4.65-sunxi #2.0.8 SMP Mon Oct 26 10:20:38 CST 2020
armv7l armv7l armv7l GNU/Linux
root@orangepipc:~# cat /etc/lsb-release
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D18.04
DISTRIB_CODENAME=3Dbionic
DISTRIB_DESCRIPTION=3D"Ubuntu 18.04.5 LTS"

It does look like the same output compared to what we see under Qemu. But
I'm not very sure if this confirms we are emulating correctly or not.

Regards,
Niek

On Mon, Sep 9, 2024 at 11:33=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> w=
rote:

> On Sun, Sep 08, 2024 at 11:36:18AM GMT, Guenter Roeck wrote:
> > Hi,
> >
> > the Allwinner H3 USB port qemu emulation creates separate USB ports
> > for its EHCI and OHCI controllers, resulting in a total of 8 USB ports.
> > From the orangepi-pc emulation:
> >
> > # lsusb
> > Bus 005 Device 001: ID 1d6b:0002
> > Bus 003 Device 001: ID 1d6b:0002
> > Bus 001 Device 001: ID 1d6b:0002
> > Bus 008 Device 001: ID 1d6b:0002
> > Bus 006 Device 001: ID 1d6b:0001
> > Bus 004 Device 001: ID 1d6b:0001
> > Bus 002 Device 001: ID 1d6b:0002
> > Bus 009 Device 001: ID 1d6b:0001
> > Bus 007 Device 001: ID 1d6b:0001
> >
> > The SoC supports EHCI companion interfaces, and my understanding is tha=
t
> > it only has four physical USB ports. Does the real hardware instantiate
> > separate EHCI and OHCI interfaces (for a total of 8 USB ports), or does
> it
> > use the companion functionality ?
>
> Well, on the guest side you'll see 8 ports even when using the companion
> functionality.  Each physical usb port has one ehci port (used when you
> plug in usb 2.0+ devices) and one ohci port (used when you plug in usb
> 1.1 devices).
>
> The main difference is on the qemu backend side.  When using the
> companion functionality you have a single qemu usb bus accepting both
> 1.1 and 2.0+ devices.  When not using the companion functionality you
> have one usb bus accepting 2.0+ devices and another usb bus accepting
> usb 1.1 devices ...
>
> The guest-visible difference is an per-port bit in ehci registers which
> controls whenever ehci or the companion manages the device plugged in.
> This bit exists for backward compatibility (guests without ehci driver
> can manage all devices via ohci, with usb 2.0+ devices being downgraded
> to 1.1 compatibility mode then).
>
> > If the real hardware only instantiates four USB ports (or, in other
> words,
> > if it utilizes EHCI companion functionality), would it make sense to
> > reflect that in qemu ?
>
> Yes.
>
> take care,
>   Gerd
>
>

--=20
Niek Linnenbank

--000000000000ebb720062207a1e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Guenter, Gerd,</div><div><br></div><div>Thanks =
for bringing up the question. To be honest I do not know a lot about USB in=
ternals.</div><div>When adding the orangepi-pc board emulation, it seemed f=
airly easy to add it, but apart from a few basic tests, I did not use the U=
SB functionality extensively.</div><div><br></div><div>I do own the actual =
Orange Pi PC board hardware, so I downloaded the &#39;Orangepipc_2.0.8_ubun=
tu_bionic_server_linux5.4.65.7z&#39; image from the official page to test:<=
br></div><div><a href=3D"http://www.orangepi.org/html/hardWare/computerAndM=
icrocontrollers/service-and-support/Orange-Pi-PC.html">http://www.orangepi.=
org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi=
-PC.html</a></div><div><br></div><div>After booting that image from an SD c=
ard with a serial console, this is the output from the same &#39;lsusb&#39;=
 command:<br></div><div><br></div><div>root@orangepipc:~# lsusb<br>Bus 008 =
Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub<br>Bus 005 Device 00=
1: ID 1d6b:0002 Linux Foundation 2.0 root hub<br>Bus 007 Device 001: ID 1d6=
b:0001 Linux Foundation 1.1 root hub<br>Bus 004 Device 001: ID 1d6b:0002 Li=
nux Foundation 2.0 root hub<br>Bus 006 Device 001: ID 1d6b:0001 Linux Found=
ation 1.1 root hub<br>Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0=
 root hub<br>Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub=
<br>Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub<br>Bus 0=
09 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub<br>root@orangepip=
c:~# uname -a<br>Linux orangepipc 5.4.65-sunxi #2.0.8 SMP Mon Oct 26 10:20:=
38 CST 2020 armv7l armv7l armv7l GNU/Linux<br>root@orangepipc:~# cat /etc/l=
sb-release <br>DISTRIB_ID=3DUbuntu<br>DISTRIB_RELEASE=3D18.04<br>DISTRIB_CO=
DENAME=3Dbionic<br>DISTRIB_DESCRIPTION=3D&quot;Ubuntu 18.04.5 LTS&quot;</di=
v><div><br></div><div>It does look like the same output compared to what we=
 see under Qemu. But I&#39;m not very sure if this confirms we are emulatin=
g correctly or not.</div><div><br></div><div>Regards,</div><div>Niek<br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Sep 9, 2024 at 11:33=E2=80=AFAM Gerd Hoffmann &lt;<a href=3D"mailto:kr=
axel@redhat.com">kraxel@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Sun, Sep 08, 2024 at 11:36:18AM GMT, G=
uenter Roeck wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; the Allwinner H3 USB port qemu emulation creates separate USB ports<br=
>
&gt; for its EHCI and OHCI controllers, resulting in a total of 8 USB ports=
.<br>
&gt; From the orangepi-pc emulation:<br>
&gt; <br>
&gt; # lsusb<br>
&gt; Bus 005 Device 001: ID 1d6b:0002<br>
&gt; Bus 003 Device 001: ID 1d6b:0002<br>
&gt; Bus 001 Device 001: ID 1d6b:0002<br>
&gt; Bus 008 Device 001: ID 1d6b:0002<br>
&gt; Bus 006 Device 001: ID 1d6b:0001<br>
&gt; Bus 004 Device 001: ID 1d6b:0001<br>
&gt; Bus 002 Device 001: ID 1d6b:0002<br>
&gt; Bus 009 Device 001: ID 1d6b:0001<br>
&gt; Bus 007 Device 001: ID 1d6b:0001<br>
&gt; <br>
&gt; The SoC supports EHCI companion interfaces, and my understanding is th=
at<br>
&gt; it only has four physical USB ports. Does the real hardware instantiat=
e<br>
&gt; separate EHCI and OHCI interfaces (for a total of 8 USB ports), or doe=
s it<br>
&gt; use the companion functionality ?<br>
<br>
Well, on the guest side you&#39;ll see 8 ports even when using the companio=
n<br>
functionality.=C2=A0 Each physical usb port has one ehci port (used when yo=
u<br>
plug in usb 2.0+ devices) and one ohci port (used when you plug in usb<br>
1.1 devices).<br>
<br>
The main difference is on the qemu backend side.=C2=A0 When using the<br>
companion functionality you have a single qemu usb bus accepting both<br>
1.1 and 2.0+ devices.=C2=A0 When not using the companion functionality you<=
br>
have one usb bus accepting 2.0+ devices and another usb bus accepting<br>
usb 1.1 devices ...<br>
<br>
The guest-visible difference is an per-port bit in ehci registers which<br>
controls whenever ehci or the companion manages the device plugged in.<br>
This bit exists for backward compatibility (guests without ehci driver<br>
can manage all devices via ohci, with usb 2.0+ devices being downgraded<br>
to 1.1 compatibility mode then).<br>
<br>
&gt; If the real hardware only instantiates four USB ports (or, in other wo=
rds,<br>
&gt; if it utilizes EHCI companion functionality), would it make sense to<b=
r>
&gt; reflect that in qemu ?<br>
<br>
Yes.<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000ebb720062207a1e7--


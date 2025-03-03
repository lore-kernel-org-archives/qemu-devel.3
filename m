Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B51C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zp-0003yt-Nx; Mon, 03 Mar 2025 12:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hab.gallagher@gmail.com>)
 id 1tp9yM-0001iC-4A; Mon, 03 Mar 2025 12:53:01 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hab.gallagher@gmail.com>)
 id 1tp9yJ-0000LF-0B; Mon, 03 Mar 2025 12:52:57 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30bb184ab24so16008951fa.0; 
 Mon, 03 Mar 2025 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024372; x=1741629172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y2d8EGI5EMy3FPuvp50FQJXJaB0MwfWmvEavs3LGDaI=;
 b=XOPM1CD7o0ET0o/LMf6XgCABzBoucu3hYrtTOJBeoSPRwloEXB4ZIEasdIbTbD/AKW
 5/HaalxugvbusPe8S2vKF7fKKefaiF0rYgaPgcs3Ru3Igj0Q2Z0CHAY01xLYvakIH16f
 sePtZ4MU2Reptypse00dYTb3g0xeCruS4Hb9ENBiZzI6zyyjW52j2tcPGI38Nr2w7WpQ
 18HRXMOPB8FeaZVEnUN0S5CDi2RuH9Ra8lmF+ROSLllVGUpf51gbnWvXJlITE2AA3FDT
 vOkgWglCeeGc1fwe/fTCfJNLtbp/WY0cd8Mkhn8DqV0O2Z81uaEnXUe5WvWYSrO86427
 xdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024372; x=1741629172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2d8EGI5EMy3FPuvp50FQJXJaB0MwfWmvEavs3LGDaI=;
 b=AJDbPrlu5VzvJS1oGoFmkGLb55XpHwRdDt3uM7uvp7lsD453tVN3JMjHCyga7llipo
 jZEFn3aUG28yTR9SHGQrRZqhv9m0608KdF5og/xQEc9UPCPPojCBy8tGfANj027Tz/R3
 BBNysBiTIEdz3S2Njvv2uuPVr8pnmLSRWPpZMvk6Y+Ef1hAj7s1870ORYqQ9YIpYw04V
 Nt4xq/+sA0vA299YB7dN2+t1+dixuO75bpTPw2Yx9mkW/zccSPg6ftVAfRoKcl3Kv6V/
 1P7SCYj/1trhrgvLYW/X0TwDghY3YXd9nAyDfNcGhhPJLlgCUReOZYp6y5IU4UakRyXl
 T4UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQetNZSbObn7TuV/iOv1av6yR/NAwKlMbV0FFIj4WNxxjV3QZrAHTVqCiTFd7ZEiSDKH4ZJvS1Eb8=@nongnu.org,
 AJvYcCWHD/xkt0m+XWFpC59QAx0AG/2vX3eZeEPG3IB32HacM9qEUQFSrdjYuTVhxgOLl1klrYVV8FzmE5u6@nongnu.org
X-Gm-Message-State: AOJu0YyFTTLAVDnFopu+fmttcrXbsz+lDm/ADvTI4tiw87JUwfuVVAv7
 VU/EKrOUdEDYTNaKWYjI0zlQdhAKF321waHBr6pPlGVtIrzBR27alBkgisuzv+KdExEyoklN+ZN
 mpCq4yTpjewNpotK8j4My/x+ROa4=
X-Gm-Gg: ASbGncvsocITn42ua/i7ZzHUKkXBksv/iTBKcCKSCJRvMrp8+huN+pUm1DuLIqN7utO
 bCTJjl04UP0fsFbPl3rlMiAVo1eyR65trcj3WhkDFGEape0mvAH5OjIXJ1DLj53b0gwJNjApmYq
 2ocastYovQ7zNB4eSpLNVvCsd4TR58BgQOig7Ic0L/E/cNBd6kq3hfWyRlgA==
X-Google-Smtp-Source: AGHT+IGK2hLzv5R1K/vUtRv6ozssUo6/ejGB2J9YMNvg7xy6pkQzfxVrF0WjabiE/x1ItBDFJTAbPPvJxZUklwqD35o=
X-Received: by 2002:a05:651c:210c:b0:30b:c36c:ba9f with SMTP id
 38308e7fff4ca-30bc36cbd5dmr12322111fa.14.1741024372100; Mon, 03 Mar 2025
 09:52:52 -0800 (PST)
MIME-Version: 1.0
References: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
 <0f927835-62e6-a2a8-7de0-262657edb638@eik.bme.hu>
 <CABLmASFQby0KpR646Vp=7JGsw40_2cvW-gFa49f2G3iMCAz14A@mail.gmail.com>
 <85e1dcb9-f0d7-6ed2-6370-30cd8f31a604@eik.bme.hu>
In-Reply-To: <85e1dcb9-f0d7-6ed2-6370-30cd8f31a604@eik.bme.hu>
From: Hab Gallagher <hab.gallagher@gmail.com>
Date: Mon, 3 Mar 2025 09:52:40 -0800
X-Gm-Features: AQ5f1JqC9jLht4ckwJB0_Oz_RNRpDWnQslJ-9RHBB_mj7ZMzb0f-3eH0mzkw2OE
Message-ID: <CANDMsCpVVsXihocUmKNQr4VFmjk57MjHh=_rx0Hbfny1wZ74aQ@mail.gmail.com>
Subject: Re: Adding gamma support to QemuMacDrivers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e969f062f73d3bb"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=hab.gallagher@gmail.com; helo=mail-lj1-x230.google.com
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

--0000000000003e969f062f73d3bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> That driver is for a VGA device which I think does not support gamma in
> hardware. QEMU emulates the hardware so if it does not support gamma then
> there's no place to add it in QEMU. Therefore if you want to emulate gamm=
a
> on VGA this should be done within the guest driver but that may be slower=
.
> How does this work on real hardware? What graphics device is used there
> and does that support gamma in hardware? Maybe that graphics device needs
> to be emulated instead?


For understanding the MacOS side of things, I have been consulting
https://developer.apple.com/library/archive/documentation/Hardware/DeviceMa=
nagers/pci_srvcs/pci_cards_drivers/Designing_PCI_Cards_Drivers.pdf

To reduce visible flashes resulting from color table changes, the SetGamma
> routine works in conjunction with the SetEntries control routine on index=
ed
> devices. The SetGamma routine first loads new gamma correction data into
> the
> driver=E2=80=99s private storage; the next SetEntries control call applie=
s the
> gamma
> correction as it changes the CLUT. SetGamma calls are always followed by
> SetEntries control calls on indexed devices.
>


For direct devices, the SetGamma routine first sets up the gamma correction
> data
> table. Next, it synthesizes a black-to-white linear ramp color table.
> Finally, it
> applies the new gamma correction to the color table and sets the data
> directly in
> the hardware.


As far as I can tell, the documentation is implying that somewhere between
the driver and the physical hardware, *something* must keep track of the
gamma table (even if indirectly by subsequently applying it to the palette
table) to map the raw framebuffer data to gamma-corrected colors.


> Perhaps this is also of interest:
> https://github.com/SolraBizna/mac_qfb_driver
> The nubus declaration rom supports gamma correction.


This is very much of interest! Thank you. I am hoping to continue to use
the mac99 machine type, but this code is a useful reference.

The most basic support requires cscGetGamma and cscSetGamma to at least
return success:
https://github.com/cebix/macemu/commit/2676e1bd134703d888788c682fb56e07b5cf=
56a9
The patch to SheepShaver was small because most of the functionality was
already present, albeit dead code.

Surprisingly, github can't deal with CR line endings, so I can't (easily)
link to some of the code to cite it:
https://github.com/ozbenh/QemuMacDrivers/blob/master/shared/MacDriverUtils.=
c

Once the gamma table is saved, it's "applied" by cscSetEntries to combine a
color palette and gamma table into the "real" color. QemuMacDrivers does
not seem to keep track of the palette at all, sending it upstream to the
driver by calling this function in a loop:

OSStatus QemuVga_SetColorEntry(UInt32 index, RGBColor *color)
{
VgaWriteB(0x3c8, index);
VgaWriteB(0x3c9, color->red >> 8);
VgaWriteB(0x3c9, color->green >> 8);
VgaWriteB(0x3c9, color->blue >> 8);
return noErr;
}

VgaWriteB seems to be doing MMIO to write those values upstream.

Similarly, mac_qfb_driver seems to use MMIO to write back both the palette
table and the gamma table to the driver, saving neither one in emulated
driver state:
https://github.com/SolraBizna/mac_qfb_driver/blob/e78ba4ccd08d254a10bad7c13=
d90810b17dbfd87/src/control.cc#L48-L62

I'm not sure where either driver's MMIO is received on the qemu end. At
least in SheepShaver, that gamma table is indeed used in the cscSetEntries
handler to create the true color mapping handed to its video driver:
https://github.com/cebix/macemu/blob/96e512bd6376e78a2869f16dcc8a9028bce5ee=
72/SheepShaver/src/video.cpp#L299-L320

If mac_qfb_driver is, as indicated in its README, able to interoperate with
an unpatched qemu, that makes me think that *potentially* qemu itself
doesn't need to be patched, depending on what qemu-side code any driver is
sending its MMIO to.

I have an article on AmigaOS gfx here:
> https://codeberg.org/qmiga/pages/wiki/AmigaOSGfx
> that discusses similar issue and most of it may be applicable to MacOS
> too. There's also a DeveloperTips link with some QEMU getting started
> links that may help you. I have started an ati-vga emulation that could d=
o
> all this and more but it's quite complex and I could take some help with
> it. Maybe that could be interesting to you as well as these ATI chips wer=
e
> used on real Macs so MacOS has support for it. I also have an article
> linked from the above about that.


I'm continuing to read this now.

Thanks already, y'all.

--0000000000003e969f062f73d3bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Tha=
t driver is for a VGA device which I think does not support gamma in<br>har=
dware. QEMU emulates the hardware so if it does not support gamma then<br>t=
here&#39;s no place to add it in QEMU. Therefore if you want to emulate gam=
ma<br>on VGA this should be done within the guest driver but that may be sl=
ower.<br>How does this work on real hardware? What graphics device is used =
there<br>and does that support gamma in hardware? Maybe that graphics devic=
e needs<br>to be emulated instead?</blockquote><div><div><br class=3D"gmail=
-Apple-interchange-newline">For understanding the MacOS side of things, I h=
ave been consulting=C2=A0<a href=3D"https://developer.apple.com/library/arc=
hive/documentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/Desi=
gning_PCI_Cards_Drivers.pdf">https://developer.apple.com/library/archive/do=
cumentation/Hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/Designing_P=
CI_Cards_Drivers.pdf</a></div></div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">To reduce visible flashes resulting from color ta=
ble changes, the SetGamma<br>routine works in conjunction with the SetEntri=
es control routine on indexed<br>devices. The SetGamma routine first loads =
new gamma correction data into the<br>driver=E2=80=99s private storage; the=
 next SetEntries control call applies the gamma<br>correction as it changes=
 the CLUT. SetGamma calls are always followed by<br>SetEntries control call=
s on indexed devices.<br></blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">For direct devices, the SetGamma routine first sets up the gamma cor=
rection data<br>table. Next, it synthesizes a black-to-white linear ramp co=
lor table. Finally, it<br>applies the new gamma correction to the color tab=
le and sets the data directly in<br>the hardware.</blockquote><div><br></di=
v><div>As far as I can tell, the documentation is implying that somewhere b=
etween the driver and the physical hardware, *something* must keep track of=
 the gamma table (even if indirectly by subsequently applying it to the pal=
ette table) to map the raw framebuffer data to gamma-corrected colors.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Perhaps=
 this is also of interest:=C2=A0<a href=3D"https://github.com/SolraBizna/ma=
c_qfb_driver" target=3D"_blank">https://github.com/SolraBizna/mac_qfb_drive=
r<br></a>The nubus declaration rom supports gamma correction.</blockquote><=
div><br></div><div>This is very much of interest! Thank you. I am hoping to=
 continue to use the mac99 machine type, but this code is a useful referenc=
e.=C2=A0</div></div><div><br></div><div>The most basic support requires=C2=
=A0cscGetGamma and cscSetGamma to at least return success:=C2=A0<a href=3D"=
https://github.com/cebix/macemu/commit/2676e1bd134703d888788c682fb56e07b5cf=
56a9">https://github.com/cebix/macemu/commit/2676e1bd134703d888788c682fb56e=
07b5cf56a9</a></div><div>The patch to SheepShaver was small because most of=
 the functionality was already present, albeit dead code.</div><div><br></d=
iv><div>Surprisingly, github can&#39;t deal with CR line endings, so I can&=
#39;t (easily) link to some of the code to cite it:=C2=A0<a href=3D"https:/=
/github.com/ozbenh/QemuMacDrivers/blob/master/shared/MacDriverUtils.c">http=
s://github.com/ozbenh/QemuMacDrivers/blob/master/shared/MacDriverUtils.c</a=
></div><div><br></div><div>Once the gamma table is saved, it&#39;s &quot;ap=
plied&quot; by cscSetEntries to combine a color palette and gamma table int=
o the &quot;real&quot; color. QemuMacDrivers does not seem to keep track of=
 the palette at all, sending it upstream to the driver by calling this func=
tion in a loop:</div><div><br></div><div>OSStatus QemuVga_SetColorEntry(UIn=
t32 index, RGBColor *color)<br>{<br>VgaWriteB(0x3c8, index);<br>	VgaWriteB(=
0x3c9, color-&gt;red &gt;&gt; 8);<br>	VgaWriteB(0x3c9, color-&gt;green &gt;=
&gt; 8);<br>	VgaWriteB(0x3c9, color-&gt;blue &gt;&gt; 8);<br>	return noErr;=
<br>}</div><div><br></div><div>VgaWriteB seems to be doing MMIO to write th=
ose values upstream.=C2=A0</div><div><br></div><div>Similarly, mac_qfb_driv=
er seems to use MMIO to write back both the palette table and the gamma tab=
le to the driver, saving neither one in emulated driver state: <a href=3D"h=
ttps://github.com/SolraBizna/mac_qfb_driver/blob/e78ba4ccd08d254a10bad7c13d=
90810b17dbfd87/src/control.cc#L48-L62">https://github.com/SolraBizna/mac_qf=
b_driver/blob/e78ba4ccd08d254a10bad7c13d90810b17dbfd87/src/control.cc#L48-L=
62</a></div><div><br></div><div>I&#39;m not sure where either driver&#39;s =
MMIO is received on the qemu end. At least in SheepShaver, that gamma table=
 is indeed used in the cscSetEntries handler to create the true color mappi=
ng handed to its video driver:=C2=A0<a href=3D"https://github.com/cebix/mac=
emu/blob/96e512bd6376e78a2869f16dcc8a9028bce5ee72/SheepShaver/src/video.cpp=
#L299-L320">https://github.com/cebix/macemu/blob/96e512bd6376e78a2869f16dcc=
8a9028bce5ee72/SheepShaver/src/video.cpp#L299-L320</a></div><div><br></div>=
<div>If mac_qfb_driver is, as indicated in its README, able to interoperate=
 with an unpatched qemu, that makes me think that *potentially* qemu itself=
 doesn&#39;t need to be patched, depending on what qemu-side code any drive=
r is sending its MMIO to.</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">I have an article on AmigaOS gfx here:<br><a href=3D"h=
ttps://codeberg.org/qmiga/pages/wiki/AmigaOSGfx" rel=3D"noreferrer" target=
=3D"_blank">https://codeberg.org/qmiga/pages/wiki/AmigaOSGfx<br></a>that di=
scusses similar issue and most of it may be applicable to MacOS<br>too. The=
re&#39;s also a DeveloperTips link with some QEMU getting started<br>links =
that may help you. I have started an ati-vga emulation that could do<br>all=
 this and more but it&#39;s quite complex and I could take some help with<b=
r>it. Maybe that could be interesting to you as well as these ATI chips wer=
e<br>used on real Macs so MacOS has support for it. I also have an article<=
br>linked from the above about that.</blockquote><div><br></div><div>I&#39;=
m continuing to read this now.</div><div><br></div><div>Thanks already, y&#=
39;all.</div></div>

--0000000000003e969f062f73d3bb--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FA2CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUi0-00081T-TY; Tue, 02 Sep 2025 13:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utUhz-00080S-1m
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:22:15 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utUhw-0001RA-MU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:22:14 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32b4c6a2a98so512274a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756833731; x=1757438531;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QIrFORNZ5HQgBOchgVb/0yWhMe1VCx0EgnadlSlithU=;
 b=MF3g6hekKjZLMe1gscUnSd/9xS/K/HPbzv/vNMexlqODlbIzYCVRmypXHGEcgKlirS
 xJncawmJYfSr1NoJIqUumJgJ3PKWu5DSFOwCPbefOE3jCi8pLMjukguyxJ3tdaKm+5xJ
 8Vggx+TdfvgpIr0SVcfeFkTVv83Ey5aapyDCWoB18/by9MJRK/eN7gDtUDDAypvk5CJK
 g8LHIzQV8nXaHAgr6OYzuody8QDwgOikGj0Xnl/RT/CMLEXT3uQ3azhbWPN6EL9Kzrcs
 0leah+Y/8q8EwMbeNwM0ZSepVM1TW0Q11LQaDznPP1Py/5oxSYBoERCwyMAP4NSF4raI
 7SsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756833731; x=1757438531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QIrFORNZ5HQgBOchgVb/0yWhMe1VCx0EgnadlSlithU=;
 b=hmfzjFrRjbPdx4CF1r9I/YYV7+MFv53sGoeBAgMabxI7AY4L4rU/5ZU1Yh5o7wORgJ
 ++rsU9CCP8QewNFsotKM06tqsbOW0bmsxAMnkUFv0vGNfdS/y5qtGcGt7eTERxkAJFOn
 ODOqA0SyZvYBviol9fRRkz6EZDgRVVKTAsTCVfs8pSYiCslnyw6+WWJRDdYZzhKuUoq+
 dOt9CvRQ4qHVMbutxfBvBp1+XU1dG/d6MDTkWxZ3HkgnX4lFfeyyzhLx0S0HTVxBkV5F
 mClH8hZoHcl+z5gq27neDtWq0OxFHjFk9/b8DV4wF8FT0WzZzRFK4/5vtjxI+Ca/r88V
 YwpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRV+Sik+NzuOQC4ZQv6t3HaOXi2obdLOUtGvFHvKxJKGVpzTrTqapw2dINR+UyDRXc+y2IgQVi73fW@nongnu.org
X-Gm-Message-State: AOJu0YwNMZ2PN8UUsOWWwmwtvcoxr8GLGOvusHQy2ZfaFb36watyH5+y
 XbzVE077fBa0xVmrV0NKAI+o4UWNhOiGWX7/ovw+DrdxUMoZrC9+G91b7cJerxjORPWjKo7ufn8
 2o070CPQ1RUdd094LZZ4HhTlyu3x0+OYTBVWzzDlLVg==
X-Gm-Gg: ASbGncvPuSSt4HM007PKYFKQnn06rApanKM21UfwIKp4qV59E3YVPJlNj000a3n4z0B
 8r2k+Z4eqwAI65MjRgcemO4OeFsSD9K1VmbjRYXjr561ysBsqt49/fcp1OzA1kHdFN7AVjZyQv2
 PZ6RUdfvwzNT+8gg4IVfquFmwAVAvRRs2O4ApBXhQZuVBN+FQk4uxF1vOx8fAlBrNHsj11Ray/X
 FhLCDH3CcqG+0AEuBj9E58NicD3cGSV7XoX6sEbXmsc93VAzfR5hOS3qoXC
X-Google-Smtp-Source: AGHT+IFh/Ju1YhPaExMlFbCKF4lAbzjRPoWc7hoWouns8LVQw8SP1HnZaVHsluqR3ddYUzCHRwDksJ9v8dOCO8G5r18=
X-Received: by 2002:a17:90b:4e88:b0:327:e9f4:4de5 with SMTP id
 98e67ed59e1d1-328156c95bdmr14729097a91.23.1756833731070; Tue, 02 Sep 2025
 10:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
 <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
 <CANCZdfprQZTVskt-EPgT-ALMO3HU-akdcw+yZ5=9Cmu1F00etQ@mail.gmail.com>
 <85b059c1-4a08-447b-a908-8af6b22d06c3@siemens.com>
In-Reply-To: <85b059c1-4a08-447b-a908-8af6b22d06c3@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 11:22:00 -0600
X-Gm-Features: Ac12FXz3pp2z279QdU9aub8LMwKhahYp7zeKCkSRSPLGMjLq25SI29GeTXuvh0o
Message-ID: <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 Alexander Bulekov <alxndr@bu.edu>
Content-Type: multipart/alternative; boundary="0000000000007868a1063dd4ba4b"
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

--0000000000007868a1063dd4ba4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:18=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 02.09.25 19:07, Warner Losh wrote:
> >
> >
> > On Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbbe <jlu@pengutronix=
.de
> > <mailto:jlu@pengutronix.de>> wrote:
> >
> >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
> >     > > > I expect us to be safe and able to deal with non-pow2 regions
> >     if we use
> >     > > > QEMUSGList from the "system/dma.h" API. But this is a rework
> >     nobody had
> >     > > > time to do so far.
> >     > >
> >     > > We have to tell two things apart: partitions sizes on the one
> >     side and
> >     > > backing storage sizes. The partitions sizes are (to my reading)
> >     clearly
> >     > > defined in the spec, and the user partition (alone!) has to be
> >     power of
> >     > > 2. The boot and RPMB partitions are multiples of 128K. The sum
> >     of them
> >     > > all is nowhere limited to power of 2 or even only multiples of
> 128K.
> >     > >
> >     >
> >     > Re-reading the part of the device capacity, the rules are more
> >     complex:
> >     >  - power of two up to 2 GB
> >     >  - multiple of 512 bytes beyond that
> >     >
> >     > So that power-of-two enforcement was and still is likely too
> strict.
> >
> >
> > It is. Version 0 (and MMC) cards had the capacity encoded like so:
> >                 m =3D mmc_get_bits(raw_csd, 128, 62, 12);
> >                 e =3D mmc_get_bits(raw_csd, 128, 47, 3);
> >                 csd->capacity =3D ((1 + m) << (e + 2)) * csd->read_bl_l=
en;
> > so any card less than 2GB (well, technically 4GB, but 4GB version 0
> > cards were
> > rare and broke some stacks... I have one and I love it on my embedded
> > ARM board
> > that can't do version 1 cards). Version 1 cards encoded it like:
> >                 csd->capacity =3D ((uint64_t)mmc_get_bits(raw_csd, 128,
> > 48, 22) +
> >                     1) * 512 * 1024;
> > So it's a multiple of 512k. These are also called 'high capacity' cards=
.
> >
> > Version 4 introduces an extended CSD, which had a pure sector count in
> > the EXT CSD. I think this
> > is only for MMC cards. And also the partition information.
> >
> >
> >     > But I still see no indication, neither in the existing eMMC code
> >     of QEMU
> >     > nor the spec, that the boot and RPMB partition sizes are included
> >     in that.
> >
> >     Correct. Non-power-of-two sizes are very common for real eMMCs.
> >     Taking a random
> >     one from our lab:
> >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
> >     [    1.228055]  mmcblk1: p1 p2 p3 p4
> >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
> >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
> >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB, chardev
> (244:0)
> >
> >     For eMMCs using MLC NAND, you can also configure part of the user
> >     data area to
> >     be pSLC (pseudo single level cell), which changes the available
> >     capacity (after
> >     a required power cycle).
> >
> >
> > Yes. Extended partitions are a feature of version 4 cards, so don't hav=
e
> > power-of-2 limits since they are a pure sector count in the ext_csd.
> >
>
> JESD84-B51A (eMMC 5.1A):
>
> "The C_SIZE parameter is used to compute the device capacity for devices
> up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for details on
> calculating densities greater than 2 GB."
>
> So I would now continue to enforce power-of-2 for 2G (including) cards,
> and relax to multiples of 512 for larger ones.
>

It's a multiple of 512k unless the card has a ext_csd, in which case it's a
multiple of 512.

Warner

--0000000000007868a1063dd4ba4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 11:18=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemen=
s.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 02.09.25 19:07, Warner Losh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbbe &lt;<a href=3D"=
mailto:jlu@pengutronix.de" target=3D"_blank">jlu@pengutronix.de</a><br>
&gt; &lt;mailto:<a href=3D"mailto:jlu@pengutronix.de" target=3D"_blank">jlu=
@pengutronix.de</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; I expect us to be safe and able to d=
eal with non-pow2 regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0if we use<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; QEMUSGList from the &quot;system/dma=
.h&quot; API. But this is a rework<br>
&gt;=C2=A0 =C2=A0 =C2=A0nobody had<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; time to do so far.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; We have to tell two things apart: partiti=
ons sizes on the one<br>
&gt;=C2=A0 =C2=A0 =C2=A0side and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; backing storage sizes. The partitions siz=
es are (to my reading)<br>
&gt;=C2=A0 =C2=A0 =C2=A0clearly<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; defined in the spec, and the user partiti=
on (alone!) has to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0power of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 2. The boot and RPMB partitions are multi=
ples of 128K. The sum<br>
&gt;=C2=A0 =C2=A0 =C2=A0of them<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; all is nowhere limited to power of 2 or e=
ven only multiples of 128K.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Re-reading the part of the device capacity, th=
e rules are more<br>
&gt;=C2=A0 =C2=A0 =C2=A0complex:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0- power of two up to 2 GB<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0- multiple of 512 bytes beyond that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So that power-of-two enforcement was and still=
 is likely too strict.<br>
&gt; <br>
&gt; <br>
&gt; It is. Version 0 (and MMC) cards had the capacity encoded like so:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D mmc_get_=
bits(raw_csd, 128, 62, 12);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D mmc_get_=
bits(raw_csd, 128, 47, 3);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capaci=
ty =3D ((1 + m) &lt;&lt; (e + 2)) * csd-&gt;read_bl_len;<br>
&gt; so any card less than 2GB (well, technically 4GB, but 4GB version 0<br=
>
&gt; cards were<br>
&gt; rare and broke some stacks... I have one and I love it on=C2=A0my embe=
dded<br>
&gt; ARM board<br>
&gt; that can&#39;t do version 1 cards). Version 1 cards encoded it like:<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capaci=
ty =3D ((uint64_t)mmc_get_bits(raw_csd, 128,<br>
&gt; 48, 22) +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
1) * 512 * 1024;<br>
&gt; So it&#39;s a multiple of 512k. These are also called &#39;high capaci=
ty&#39; cards.<br>
&gt; <br>
&gt; Version 4 introduces an extended CSD, which had a=C2=A0pure sector cou=
nt in<br>
&gt; the EXT CSD. I think this<br>
&gt; is only for MMC cards. And also the partition information.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; But I still see no indication, neither in the =
existing eMMC code<br>
&gt;=C2=A0 =C2=A0 =C2=A0of QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; nor the spec, that the boot and RPMB partition=
 sizes are included<br>
&gt;=C2=A0 =C2=A0 =C2=A0in that.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Correct. Non-power-of-two sizes are very common for=
 real eMMCs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Taking a random<br>
&gt;=C2=A0 =C2=A0 =C2=A0one from our lab:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.220588] mmcblk1: mmc1:0001 S0J56X =
14.8 GiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.228055]=C2=A0 mmcblk1: p1 p2 p3 p4=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.230375] mmcblk1boot0: mmc1:0001 S0=
J56X 31.5 MiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.233651] mmcblk1boot1: mmc1:0001 S0=
J56X 31.5 MiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.236682] mmcblk1rpmb: mmc1:0001 S0J=
56X 4.00 MiB, chardev (244:0)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0For eMMCs using MLC NAND, you can also configure pa=
rt of the user<br>
&gt;=C2=A0 =C2=A0 =C2=A0data area to<br>
&gt;=C2=A0 =C2=A0 =C2=A0be pSLC (pseudo single level cell), which changes t=
he available<br>
&gt;=C2=A0 =C2=A0 =C2=A0capacity (after<br>
&gt;=C2=A0 =C2=A0 =C2=A0a required power cycle).<br>
&gt; <br>
&gt; <br>
&gt; Yes. Extended partitions are a feature of version 4 cards, so don&#39;=
t have<br>
&gt; power-of-2 limits since they are a pure sector count in the ext_csd.<b=
r>
&gt; <br>
<br>
JESD84-B51A (eMMC 5.1A):<br>
<br>
&quot;The C_SIZE parameter is used to compute the device capacity for devic=
es<br>
up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for details on<br>
calculating densities greater than 2 GB.&quot;<br>
<br>
So I would now continue to enforce power-of-2 for 2G (including) cards,<br>
and relax to multiples of 512 for larger ones.<br></blockquote><div><br></d=
iv><div>It&#39;s a multiple of 512k unless the card has a ext_csd, in which=
 case it&#39;s a multiple of 512.</div><div><br></div><div>Warner=C2=A0</di=
v></div></div>

--0000000000007868a1063dd4ba4b--


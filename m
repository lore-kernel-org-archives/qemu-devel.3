Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B7FCA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 18:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVQM-0002HI-D4; Tue, 02 Sep 2025 14:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVQ7-0002Eu-Sj
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:07:51 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVQ3-0005HL-RV
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 14:07:51 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-329b76008c6so1728111a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756836466; x=1757441266;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tclwGQepTIosel6n+IgolE/j+Ot6crMlSXslZehC8M0=;
 b=Lf4i+6GYBsIbybf8hAzsuXjB5Xi1nuQHtAHn/qk04TNSZOrUiuWBwI4IQt3k9JutBQ
 GZEcF1rZgJz2KlMFlxCsNynecrQnYescn0usHMuff3ECdj7fqI+k2dK3PeW6hPTanWrI
 Ssau/J9wj8i3n+bGRSe60loanzt2Rm713c/B4gB83aW4vKM1sfLje/jq7yIcVYhIBUpE
 RDssmCWDKh00eOXuIX1837zVpN804zPusNyWvR3pX3az9A9LzhwC81JwKhKJVyj8XamP
 XcEDjCQEVECRFcKA0saROkL+srT69H2SPKPkLbUpuQX745C8dqkOAUPnF2flAk4CYXRD
 8+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756836466; x=1757441266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tclwGQepTIosel6n+IgolE/j+Ot6crMlSXslZehC8M0=;
 b=DKEF8/h0r2IEqs1yyct4PxiCxXk5itN7LrB1oxTzwX/SxmH/420NIKkIiCcd2hA8Ol
 BwrHX1/Ze3MTFK5vVntKFnsFx4O+B/FCXupXk9y7K7G+DVIjOCClt8yWvoHDt1Q4AP/p
 uzvhHYZS3aSs/aJmWAa57Xo8Dv4VnJbM3p7tZ++MONI981qPENwWrz5kvIdmaXduUwur
 LTaHd+lpugmaxO5NSfT/FmUh5jXpDLZpzasyjNPB0qar4ZhdzyJ6UwrGafF0LyfGTvs3
 USYhMjs+0D7L2WvA+fXfkg38w/O/YvtMwwgwDhaZqEQzmtc4DRKN7/YuGBIVtmf8IMah
 S/EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNp8isIThOUqREPBZNAMvNSly2txo5xMcd2v9mqFnmK7ltJ5AvU31Q0ABUgFZFKgHDfr7P/wEuxfIZ@nongnu.org
X-Gm-Message-State: AOJu0Yz7D9VPQgcc2opk/r3gE6HjCxOHNzwH5zrU/iqvDBLurJ1VuwYV
 +AHSHQw7GdEovoJxwUZkCAgRnzWKsiW7SF3OoNZHW0IiyljhrjzmM6F8cgxNNC06OPXSO0k+UCn
 mBQHVGiwKUxoJnn+rIoCKdanA0qQNb1h37ZHIShn+KQ==
X-Gm-Gg: ASbGncueCTGDfE1brpu6JPGD75ZrJFoiZ71WYv8CdqhqcQI/Z/G63ap6rUAOOewwG9p
 yrdHvurQRUMntQFLxCkLQnyE9EKlKLB+vwWrvuMDDVULOZrRUqaouwG+MeogHwnl3rF+lm83Twb
 K5m0KS+3y5ucwedLRFHr8f2qutCs9rtxjou0kNfb6xSGHnGHCHa6ZLm2RmAyBuWHDT28pLeufyJ
 ftLvLZ24Y7eYhx54G0MFoTgwr4d8wcnkPnh4lE=
X-Google-Smtp-Source: AGHT+IF7Dm11y94KBEJIb695AFVR5M3T3V4XPmqufuaULlatu1EFtTA8sjM/pmGqPLAJ0jugagwb4lzzSz1nFR4fEaY=
X-Received: by 2002:a17:90b:1d92:b0:327:e21c:dd6 with SMTP id
 98e67ed59e1d1-328156bac32mr16237558a91.23.1756836465519; Tue, 02 Sep 2025
 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1756706188.git.jan.kiszka@siemens.com>
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
 <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
 <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
 <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
 <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
 <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
 <84b6866f-e36f-4794-81f2-52c2f8c37355@linaro.org>
In-Reply-To: <84b6866f-e36f-4794-81f2-52c2f8c37355@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 12:07:33 -0600
X-Gm-Features: Ac12FXy42QAVVkF3LO3_XqD1SznN9X0egFYtMk1ArPaEwXsmmivg_P7keKTdhYc
Message-ID: <CANCZdfrnvWNL1oYmHSENRX7PS=ovtdmdu5RGgBPknydDNDdTKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 Alexander Bulekov <alxndr@bu.edu>
Content-Type: multipart/alternative; boundary="00000000000074d98b063dd55d05"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--00000000000074d98b063dd55d05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 2/9/25 19:53, Jan Kiszka wrote:
> > On 02.09.25 19:48, Warner Losh wrote:
> >>
> >>
> >> On Tue, Sep 2, 2025 at 11:37=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens=
.com
> >> <mailto:jan.kiszka@siemens.com>> wrote:
> >>
> >>      On 02.09.25 19:30, Warner Losh wrote:
> >>      >
> >>      >
> >>      > On Tue, Sep 2, 2025 at 11:22=E2=80=AFAM Warner Losh <imp@bsdimp=
.com
> >>      <mailto:imp@bsdimp.com>
> >>      > <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>> wrote:
> >>      >
> >>      >
> >>      >
> >>      >     On Tue, Sep 2, 2025 at 11:18=E2=80=AFAM Jan Kiszka
> >>      <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> >>      >     <mailto:jan.kiszka@siemens.com
> >>      <mailto:jan.kiszka@siemens.com>>> wrote:
> >>      >
> >>      >         On 02.09.25 19:07, Warner Losh wrote:
> >>      >         >
> >>      >         >
> >>      >         > On Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbb=
e
> >>      <jlu@pengutronix.de <mailto:jlu@pengutronix.de>
> >>      >         <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>
> >>      >         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de=
>
> >>      <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>>> wrote:
> >>      >         >
> >>      >         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka
> wrote:
> >>      >         >     > > > I expect us to be safe and able to deal wit=
h
> non-
> >>      >         pow2 regions
> >>      >         >     if we use
> >>      >         >     > > > QEMUSGList from the "system/dma.h" API. But
> >>      this is
> >>      >         a rework
> >>      >         >     nobody had
> >>      >         >     > > > time to do so far.
> >>      >         >     > >
> >>      >         >     > > We have to tell two things apart: partitions
> >>      sizes on
> >>      >         the one
> >>      >         >     side and
> >>      >         >     > > backing storage sizes. The partitions sizes a=
re
> >>      (to my
> >>      >         reading)
> >>      >         >     clearly
> >>      >         >     > > defined in the spec, and the user partition
> (alone!)
> >>      >         has to be
> >>      >         >     power of
> >>      >         >     > > 2. The boot and RPMB partitions are multiples
> of
> >>      128K.
> >>      >         The sum
> >>      >         >     of them
> >>      >         >     > > all is nowhere limited to power of 2 or even
> only
> >>      >         multiples of 128K.
> >>      >         >     > >
> >>      >         >     >
> >>      >         >     > Re-reading the part of the device capacity, the
> rules
> >>      >         are more
> >>      >         >     complex:
> >>      >         >     >  - power of two up to 2 GB
> >>      >         >     >  - multiple of 512 bytes beyond that
> >>      >         >     >
> >>      >         >     > So that power-of-two enforcement was and still =
is
> >>      likely
> >>      >         too strict.
> >>      >         >
> >>      >         >
> >>      >         > It is. Version 0 (and MMC) cards had the capacity
> >>      encoded like so:
> >>      >         >                 m =3D mmc_get_bits(raw_csd, 128, 62, =
12);
> >>      >         >                 e =3D mmc_get_bits(raw_csd, 128, 47, =
3);
> >>      >         >                 csd->capacity =3D ((1 + m) << (e + 2)=
) *
> csd-
> >>      >         >read_bl_len;
> >>      >         > so any card less than 2GB (well, technically 4GB, but
> 4GB
> >>      >         version 0
> >>      >         > cards were
> >>      >         > rare and broke some stacks... I have one and I love i=
t
> on my
> >>      >         embedded
> >>      >         > ARM board
> >>      >         > that can't do version 1 cards). Version 1 cards encod=
ed
> >>      it like:
> >>      >         >                 csd->capacity =3D
> >>      >         ((uint64_t)mmc_get_bits(raw_csd, 128,
> >>      >         > 48, 22) +
> >>      >         >                     1) * 512 * 1024;
> >>      >         > So it's a multiple of 512k. These are also called 'hi=
gh
> >>      >         capacity' cards.
> >>      >         >
> >>      >         > Version 4 introduces an extended CSD, which had a pur=
e
> >>      sector
> >>      >         count in
> >>      >         > the EXT CSD. I think this
> >>      >         > is only for MMC cards. And also the partition
> information.
> >>      >         >
> >>      >         >
> >>      >         >     > But I still see no indication, neither in the
> existing
> >>      >         eMMC code
> >>      >         >     of QEMU
> >>      >         >     > nor the spec, that the boot and RPMB partition
> >>      sizes are
> >>      >         included
> >>      >         >     in that.
> >>      >         >
> >>      >         >     Correct. Non-power-of-two sizes are very common
> for real
> >>      >         eMMCs.
> >>      >         >     Taking a random
> >>      >         >     one from our lab:
> >>      >         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
> >>      >         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
> >>      >         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.=
5
> MiB
> >>      >         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.=
5
> MiB
> >>      >         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00
> MiB,
> >>      >         chardev (244:0)
> >>      >         >
> >>      >         >     For eMMCs using MLC NAND, you can also configure
> part of
> >>      >         the user
> >>      >         >     data area to
> >>      >         >     be pSLC (pseudo single level cell), which changes
> the
> >>      >         available
> >>      >         >     capacity (after
> >>      >         >     a required power cycle).
> >>      >         >
> >>      >         >
> >>      >         > Yes. Extended partitions are a feature of version 4
> >>      cards, so
> >>      >         don't have
> >>      >         > power-of-2 limits since they are a pure sector count
> in the
> >>      >         ext_csd.
> >>      >         >
> >>      >
> >>      >         JESD84-B51A (eMMC 5.1A):
> >>      >
> >>      >         "The C_SIZE parameter is used to compute the device
> >>      capacity for
> >>      >         devices
> >>      >         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] =
,
> for
> >>      >         details on
> >>      >         calculating densities greater than 2 GB."
> >>      >
> >>      >         So I would now continue to enforce power-of-2 for 2G
> >>      (including)
> >>      >         cards,
> >>      >         and relax to multiples of 512 for larger ones.
> >>      >
> >>      >
> >>      >     It's a multiple of 512k unless the card has a ext_csd, in
> >>      which case
> >>      >     it's a multiple of 512.
> >>      >
> >>      >
> >>      > More completely, this is from MMC 4.0 and newer. Extended
> Capacity SD
> >>      > cards report this in units of 512k bytes for all cards > 2GiB.
> >>      >
> >>
> >>      I'm not sure which spec version you are referring to, but
> JESD84-A441
> >>      and JESD84-B51A mention nothing about 512K, rather "Device densit=
y
> =3D
> >>      SEC_COUNT x 512B". And these are the specs we very likely need to
> follow
> >>      here.
> >>
> >>
> >> You are right that this is in the MMC spec. However, the SD spec is
> >> controlling for SD cards.
> >>
> >> SD Specifications Part 1 Physical Layer Simplified Specification Versi=
on
> >> 9.10
> >> December 1, 2023
> >>
> >> Section 5.3 describes the CSD. Version 1.0 (which I'd called version 0
> >> in an earlier email because of its encoding) is the 2GB rule. Version
> >
> > < 2G or <=3D 2G? For eMMC, it is <=3D.
> >
> >> 2.0 and 3.0 encode it as 512k count (from 5.3.3):
> >>
> >> C_SIZE
> >> This field is expanded to 28 bits and can indicate up to 128 TBytes.
> >>
> >> This parameter is used to calculate the user data area capacity in the
> >> SD memory card (note that size of the protected area is zero for SDUC
> >> card). The user data area capacity is calculated from C_SIZE as follow=
s:
> >>
> >> memory capacity =3D (C_SIZE+1) * 512KByte
> >>
> >> The Minimum user area size of SDUC Card is 4,294,968,320 sectors
> >> (2TB+0.5MB).
> >> The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h
> >> (4194304). The Maximum user area size of SDUC Card is 274,877,906,944
> >> sectors (128TB).
> >> The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh
> >> (268435455).
> >>
> >> So SD cards are yet again gratuitously different than MMC cards.
>
> FTR so far QEMU only models SD spec v2.00 and v3.01, and eMMC spec 4.3.
>

IIRC (I can't find the old copies of the spec I used), the SD Spec 2.0
introduced the 512k thing with its new CSD for cards larger than 2GiB. I
had to retrofit my stack, which I'd written to the SD 1.0 spec for it.
Later versions (I'm not sure which ones) expanded the field size to what I
aquoted. eMMC introduced EXT_CSD in version 4.0, which has the 512 byte
restriction and also partitions (since MMC didn't introduce a new CSD like
SD did). The successor eMMC spec is what Jan was quoting.

Warner

--00000000000074d98b063dd55d05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 11:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 2/9/25 19:53, Jan Kiszka wrote:<br>
&gt; On 02.09.25 19:48, Warner Losh wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Sep 2, 2025 at 11:37=E2=80=AFAM Jan Kiszka &lt;<a href=3D"=
mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a>=
<br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_bl=
ank">jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 On 02.09.25 19:30, Warner Losh wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Tue, Sep 2, 2025 at 11:22=E2=80=AFAM W=
arner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdi=
mp.com</a><br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:imp@bsdimp.com" t=
arget=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:imp@bsdimp.c=
om" target=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=3D"mailto:imp@b=
sdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;&gt; wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 2, 2025 at=
 11:18=E2=80=AFAM Jan Kiszka<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jan.kiszka@siemens.com" =
target=3D"_blank">jan.kiszka@siemens.com</a> &lt;mailto:<a href=3D"mailto:j=
an.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"=
mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a>=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jan.kiszka@siemen=
s.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt;&gt; wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 02.09=
.25 19:07, Warner Losh wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On =
Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbbe<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:jlu@pengutronix.de" targ=
et=3D"_blank">jlu@pengutronix.de</a> &lt;mailto:<a href=3D"mailto:jlu@pengu=
tronix.de" target=3D"_blank">jlu@pengutronix.de</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mail=
to:<a href=3D"mailto:jlu@pengutronix.de" target=3D"_blank">jlu@pengutronix.=
de</a> &lt;mailto:<a href=3D"mailto:jlu@pengutronix.de" target=3D"_blank">j=
lu@pengutronix.de</a>&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &lt=
;mailto:<a href=3D"mailto:jlu@pengutronix.de" target=3D"_blank">jlu@pengutr=
onix.de</a> &lt;mailto:<a href=3D"mailto:jlu@pengutronix.de" target=3D"_bla=
nk">jlu@pengutronix.de</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jlu@pengutronix.d=
e" target=3D"_blank">jlu@pengutronix.de</a> &lt;mailto:<a href=3D"mailto:jl=
u@pengutronix.de" target=3D"_blank">jlu@pengutronix.de</a>&gt;&gt;&gt;&gt; =
wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; I expect us to be safe and able to deal wit=
h non-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pow2 reg=
ions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0if we use<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; QEMUSGList from the &quot;system/dma.h&quot=
; API. But<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 this is<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a rework=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0nobody had<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; time to do so far.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; We have to tell two things apart: partitions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sizes on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the one<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0side and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; backing storage sizes. The partitions sizes are<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 (to my<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reading)=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0clearly<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; defined in the spec, and the user partition (alo=
ne!)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has to b=
e<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0power of<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; 2. The boot and RPMB partitions are multiples of=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 128K.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The sum<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0of them<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; all is nowhere limited to power of 2 or even onl=
y<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multiple=
s of 128K.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; Re-reading the part of the device capacity, the rules=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are more=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0complex:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; =C2=A0- power of two up to 2 GB<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; =C2=A0- multiple of 512 bytes beyond that<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; So that power-of-two enforcement was and still is<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 likely<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0too stri=
ct.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; It =
is. Version 0 (and MMC) cards had the capacity<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 encoded like so:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D mmc_get_bits(raw=
_csd, 128, 62, 12);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D mmc_get_bits(raw=
_csd, 128, 47, 3);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capacity =3D (=
(1 + m) &lt;&lt; (e + 2)) * csd-<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;read=
_bl_len;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; so =
any card less than 2GB (well, technically 4GB, but 4GB<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =
0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; car=
ds were<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; rar=
e and broke some stacks... I have one and I love it on=C2=A0my<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0embedded=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ARM=
 board<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; tha=
t can&#39;t do version 1 cards). Version 1 cards encoded<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 it like:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capacity =3D<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((uint64=
_t)mmc_get_bits(raw_csd, 128,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 48,=
 22) +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1) * 512=
 * 1024;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; So =
it&#39;s a multiple of 512k. These are also called &#39;high<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capacity=
&#39; cards.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Ver=
sion 4 introduces an extended CSD, which had a=C2=A0pure<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sector<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count in=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; the=
 EXT CSD. I think this<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; is =
only for MMC cards. And also the partition information.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; But I still see no indication, neither in the existin=
g<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eMMC cod=
e<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0of QEMU<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; nor the spec, that the boot and RPMB partition<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 sizes are<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0included=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0in that.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0Correct. Non-power-of-two sizes are very common for real<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eMMCs.<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0Taking a random<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0one from our lab:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 Gi=
B<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.228055]=C2=A0 mmcblk1: p1 p2 p3 p4<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31=
.5 MiB<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31=
.5 MiB<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0[=C2=A0 =C2=A0 1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.0=
0 MiB,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chardev =
(244:0)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0For eMMCs using MLC NAND, you can also configure part of<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the user=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0data area to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0be pSLC (pseudo single level cell), which changes the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0availabl=
e<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0capacity (after<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0a required power cycle).<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Yes=
. Extended partitions are a feature of version 4<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 cards, so<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0don&#39;=
t have<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; pow=
er-of-2 limits since they are a pure sector count in the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext_csd.=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0JESD84-B=
51A (eMMC 5.1A):<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Th=
e C_SIZE parameter is used to compute the device<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 capacity for<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up to 2 =
GB of density. See 7.4.52, SEC_COUNT [215:212] , for<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0details =
on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0calculat=
ing densities greater than 2 GB.&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So I wou=
ld now continue to enforce power-of-2 for 2G<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 (including)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cards,<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and rela=
x to multiples of 512 for larger ones.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0It&#39;s a multiple of=
 512k unless the card has a ext_csd, in<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 which case<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0it&#39;s a multiple of=
 512.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; More completely, this is from MMC 4.0 and=
 newer. Extended Capacity SD<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; cards report this in units of 512k bytes =
for all cards &gt; 2GiB.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 I&#39;m not sure which spec version you are re=
ferring to, but JESD84-A441<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 and JESD84-B51A mention nothing about 512K, ra=
ther &quot;Device density =3D<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 SEC_COUNT x 512B&quot;. And these are the spec=
s we very likely need to follow<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 here.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; You are right that=C2=A0this is in the MMC spec. However, the SD s=
pec is<br>
&gt;&gt; controlling for SD cards.<br>
&gt;&gt;<br>
&gt;&gt; SD Specifications=C2=A0Part 1=C2=A0Physical Layer=C2=A0Simplified =
Specification=C2=A0Version<br>
&gt;&gt; 9.10<br>
&gt;&gt; December 1, 2023<br>
&gt;&gt;<br>
&gt;&gt; Section 5.3 describes the CSD. Version 1.0 (which I&#39;d called v=
ersion 0<br>
&gt;&gt; in an earlier email because of its encoding) is the 2GB rule. Vers=
ion<br>
&gt; <br>
&gt; &lt; 2G or &lt;=3D 2G? For eMMC, it is &lt;=3D.<br>
&gt; <br>
&gt;&gt; 2.0 and 3.0 encode it as 512k count (from 5.3.3):<br>
&gt;&gt;<br>
&gt;&gt; C_SIZE<br>
&gt;&gt; This field is expanded to 28 bits and can indicate up to 128 TByte=
s.<br>
&gt;&gt;<br>
&gt;&gt; This parameter is used to calculate the user data area capacity in=
 the<br>
&gt;&gt; SD memory card (note that size of the protected area is zero for S=
DUC<br>
&gt;&gt; card). The user data area capacity is calculated from C_SIZE as fo=
llows:<br>
&gt;&gt;<br>
&gt;&gt; memory capacity =3D (C_SIZE+1) * 512KByte<br>
&gt;&gt;<br>
&gt;&gt; The Minimum user area size of SDUC Card is 4,294,968,320 sectors<b=
r>
&gt;&gt; (2TB+0.5MB).<br>
&gt;&gt; The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000=
h<br>
&gt;&gt; (4194304). The Maximum user area size of SDUC Card is 274,877,906,=
944<br>
&gt;&gt; sectors (128TB).<br>
&gt;&gt; The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFF=
h<br>
&gt;&gt; (268435455).<br>
&gt;&gt;<br>
&gt;&gt; So SD cards are yet again gratuitously different than MMC cards.<b=
r>
<br>
FTR so far QEMU only models SD spec v2.00 and v3.01, and eMMC spec 4.3.<br>=
</blockquote><div><br></div><div>IIRC (I can&#39;t find the old copies of t=
he spec I used), the SD Spec 2.0 introduced the 512k thing with its new CSD=
 for cards larger than 2GiB. I had to retrofit my stack, which I&#39;d writ=
ten to the SD 1.0 spec for it. Later versions (I&#39;m not sure which ones)=
 expanded the field size to what I aquoted. eMMC introduced EXT_CSD in vers=
ion 4.0, which has the 512 byte restriction and also partitions (since MMC =
didn&#39;t introduce a new CSD like SD did). The successor eMMC spec is wha=
t Jan was quoting.</div><div><br></div><div>Warner</div></div></div>

--00000000000074d98b063dd55d05--


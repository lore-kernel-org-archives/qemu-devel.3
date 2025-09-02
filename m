Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF1DCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVEE-0003Pn-5G; Tue, 02 Sep 2025 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVE5-0003NF-3Y
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:55:25 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVE2-0003Kr-Fw
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:55:24 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-329e47dfa3eso843131a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756835720; x=1757440520;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AaBXsDh4YhHGyhFmJdVw3KyuTtH3q/rNqf3j9TcB/0U=;
 b=HzB/ZVeV9NIQFicjMWyUQJejdlA2+ZWO2YMY5dK4aVR+yTHOs2jLcxeU4V7b9iT6Yy
 uqiwwIzAw3CzWmLsznzPnqykV7NRjf66cOqOJa5/vThbP4tNI+SRlLQD/e+nWVlsMRow
 8n7xcb0GWxSYo3j2PnySr17lpomXMr90HaZ0G0D+112hA+ci9Keihr3Ne/gNYLoz2pNz
 xsLi/soOMB8WfNiyy1TfYBKJhDZ9qox/nD5PAOG8zNEdgN6djUNOMIWvdgvH2E+nX177
 sdCnKKcZ/dKGeXd0wN/1TPOsof/CYLxiWyXtkeWceKgbClUfoOoU7VmuyleQeOXXqSfp
 3TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756835720; x=1757440520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AaBXsDh4YhHGyhFmJdVw3KyuTtH3q/rNqf3j9TcB/0U=;
 b=lRUVEa5OStVizdlmkjsnLuIIRsaoRrH3aD8GHjsiICGsZrqmvYNZqn5fK/Usv52Wdq
 SIY26B7V5UESloJiSPWso1oxsGJwCkzDSQztEV7qVFGo+/F+8Z7HXmsrCHY3hbIrkUGi
 lOWWUA/nMqa0dxA8vpOb+x9txNDhQwmBSWMckK8/wjrvYsuPmRPH1ffMweB5tUqXtadh
 dHzSZIZOdWjDOSZKRa20ViNVSTXp7HGFvmf0DA6G5iFORj5uv8NQG2UhuvmpgUUOqPAI
 2ga7rtml7CeuxpXeriOz+lp7bav/nHf8EcqBuaSkn2AbAUixKx/WsxUG69K56vGptDBU
 fb7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZrzw7WRlCJeY+BBvrQF1xT+Jf3fFoYoR/X6t46ICOpy8ixL10PgoqH6GG2Kql9YOpjAMSQCrmIfNj@nongnu.org
X-Gm-Message-State: AOJu0YxKeO5J6sKBK/s2JMnifPZbDVxew6WVhu+zZnXLVlZ6bBJwYo8z
 cb1MU6AbcJO61PzTFkUuzY3qkXXdLDRgbW/Ese/Z8s8ZA7p8l8wbl5Z8CDLidBAzoc4QojxHE/v
 Rwjx5LbbqCf/E35XU91vR5EFDbMoz3YQKFas4HxZ1eQ==
X-Gm-Gg: ASbGnctwbQtvxNLANjMvFIMTFYP4EK1JrYoyaNAZkB94XtDmpDENRzoxCSmVUdTEfsS
 3MSUKfeMfqePrXX5f6+RGvho17haHh9heN7uN/Y4SwiCr9U0+BdRwfCqLBD5Ppq460/uXZRohCD
 lAua6QXkhz8Q2bfD4NJzyHorSDKJ90Tfksy1PpbvB2KxyKyfFT/BXqqNOojYKgO/C7yZ5eYtsWh
 c5uJjTU55IUKMBAUgSWIrTSmtw+l6DugodvuF4=
X-Google-Smtp-Source: AGHT+IF6OkMltN2rb9sFJFv1APRz2nv2B7fZtVfdpqxtDcFOLRdz4ghvPoaR09IJRyHecVa6ohwE4tXHdkcJb7lmA30=
X-Received: by 2002:a17:90b:1c0a:b0:327:6a43:c73f with SMTP id
 98e67ed59e1d1-328156babddmr17699341a91.20.1756835719496; Tue, 02 Sep 2025
 10:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1756706188.git.jan.kiszka@siemens.com>
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
 <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
 <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
 <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
 <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
 <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
In-Reply-To: <85e230b8-75f5-43c7-897f-5abb18799d52@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 11:55:07 -0600
X-Gm-Features: Ac12FXyNUWJ8va0Bz22j-36GkvEbemz-qXAHlFluh_KtqwqMEzIyAM8fS8UsSFE
Message-ID: <CANCZdfpK6AS0tyzx+LwXGeC=1EtJpOhUQsFh=8L7ErazcoYUgg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000fd5e06063dd530cd"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1035.google.com
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

--000000000000fd5e06063dd530cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:53=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 02.09.25 19:48, Warner Losh wrote:
> >
> >
> > On Tue, Sep 2, 2025 at 11:37=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 02.09.25 19:30, Warner Losh wrote:
> >     >
> >     >
> >     > On Tue, Sep 2, 2025 at 11:22=E2=80=AFAM Warner Losh <imp@bsdimp.c=
om
> >     <mailto:imp@bsdimp.com>
> >     > <mailto:imp@bsdimp.com <mailto:imp@bsdimp.com>>> wrote:
> >     >
> >     >
> >     >
> >     >     On Tue, Sep 2, 2025 at 11:18=E2=80=AFAM Jan Kiszka
> >     <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> >     >     <mailto:jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>>> wrote:
> >     >
> >     >         On 02.09.25 19:07, Warner Losh wrote:
> >     >         >
> >     >         >
> >     >         > On Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbbe
> >     <jlu@pengutronix.de <mailto:jlu@pengutronix.de>
> >     >         <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>
> >     >         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>
> >     <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>>> wrote:
> >     >         >
> >     >         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote=
:
> >     >         >     > > > I expect us to be safe and able to deal with
> non-
> >     >         pow2 regions
> >     >         >     if we use
> >     >         >     > > > QEMUSGList from the "system/dma.h" API. But
> >     this is
> >     >         a rework
> >     >         >     nobody had
> >     >         >     > > > time to do so far.
> >     >         >     > >
> >     >         >     > > We have to tell two things apart: partitions
> >     sizes on
> >     >         the one
> >     >         >     side and
> >     >         >     > > backing storage sizes. The partitions sizes are
> >     (to my
> >     >         reading)
> >     >         >     clearly
> >     >         >     > > defined in the spec, and the user partition
> (alone!)
> >     >         has to be
> >     >         >     power of
> >     >         >     > > 2. The boot and RPMB partitions are multiples o=
f
> >     128K.
> >     >         The sum
> >     >         >     of them
> >     >         >     > > all is nowhere limited to power of 2 or even on=
ly
> >     >         multiples of 128K.
> >     >         >     > >
> >     >         >     >
> >     >         >     > Re-reading the part of the device capacity, the
> rules
> >     >         are more
> >     >         >     complex:
> >     >         >     >  - power of two up to 2 GB
> >     >         >     >  - multiple of 512 bytes beyond that
> >     >         >     >
> >     >         >     > So that power-of-two enforcement was and still is
> >     likely
> >     >         too strict.
> >     >         >
> >     >         >
> >     >         > It is. Version 0 (and MMC) cards had the capacity
> >     encoded like so:
> >     >         >                 m =3D mmc_get_bits(raw_csd, 128, 62, 12=
);
> >     >         >                 e =3D mmc_get_bits(raw_csd, 128, 47, 3)=
;
> >     >         >                 csd->capacity =3D ((1 + m) << (e + 2)) =
*
> csd-
> >     >         >read_bl_len;
> >     >         > so any card less than 2GB (well, technically 4GB, but 4=
GB
> >     >         version 0
> >     >         > cards were
> >     >         > rare and broke some stacks... I have one and I love it
> on my
> >     >         embedded
> >     >         > ARM board
> >     >         > that can't do version 1 cards). Version 1 cards encoded
> >     it like:
> >     >         >                 csd->capacity =3D
> >     >         ((uint64_t)mmc_get_bits(raw_csd, 128,
> >     >         > 48, 22) +
> >     >         >                     1) * 512 * 1024;
> >     >         > So it's a multiple of 512k. These are also called 'high
> >     >         capacity' cards.
> >     >         >
> >     >         > Version 4 introduces an extended CSD, which had a pure
> >     sector
> >     >         count in
> >     >         > the EXT CSD. I think this
> >     >         > is only for MMC cards. And also the partition
> information.
> >     >         >
> >     >         >
> >     >         >     > But I still see no indication, neither in the
> existing
> >     >         eMMC code
> >     >         >     of QEMU
> >     >         >     > nor the spec, that the boot and RPMB partition
> >     sizes are
> >     >         included
> >     >         >     in that.
> >     >         >
> >     >         >     Correct. Non-power-of-two sizes are very common for
> real
> >     >         eMMCs.
> >     >         >     Taking a random
> >     >         >     one from our lab:
> >     >         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
> >     >         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
> >     >         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5
> MiB
> >     >         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5
> MiB
> >     >         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00
> MiB,
> >     >         chardev (244:0)
> >     >         >
> >     >         >     For eMMCs using MLC NAND, you can also configure
> part of
> >     >         the user
> >     >         >     data area to
> >     >         >     be pSLC (pseudo single level cell), which changes t=
he
> >     >         available
> >     >         >     capacity (after
> >     >         >     a required power cycle).
> >     >         >
> >     >         >
> >     >         > Yes. Extended partitions are a feature of version 4
> >     cards, so
> >     >         don't have
> >     >         > power-of-2 limits since they are a pure sector count in
> the
> >     >         ext_csd.
> >     >         >
> >     >
> >     >         JESD84-B51A (eMMC 5.1A):
> >     >
> >     >         "The C_SIZE parameter is used to compute the device
> >     capacity for
> >     >         devices
> >     >         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] ,
> for
> >     >         details on
> >     >         calculating densities greater than 2 GB."
> >     >
> >     >         So I would now continue to enforce power-of-2 for 2G
> >     (including)
> >     >         cards,
> >     >         and relax to multiples of 512 for larger ones.
> >     >
> >     >
> >     >     It's a multiple of 512k unless the card has a ext_csd, in
> >     which case
> >     >     it's a multiple of 512.
> >     >
> >     >
> >     > More completely, this is from MMC 4.0 and newer. Extended Capacit=
y
> SD
> >     > cards report this in units of 512k bytes for all cards > 2GiB.
> >     >
> >
> >     I'm not sure which spec version you are referring to, but JESD84-A4=
41
> >     and JESD84-B51A mention nothing about 512K, rather "Device density =
=3D
> >     SEC_COUNT x 512B". And these are the specs we very likely need to
> follow
> >     here.
> >
> >
> > You are right that this is in the MMC spec. However, the SD spec is
> > controlling for SD cards.
> >
> > SD Specifications Part 1 Physical Layer Simplified Specification Versio=
n
> > 9.10
> > December 1, 2023
> >
> > Section 5.3 describes the CSD. Version 1.0 (which I'd called version 0
> > in an earlier email because of its encoding) is the 2GB rule. Version
>
> < 2G or <=3D 2G? For eMMC, it is <=3D.
>
> > 2.0 and 3.0 encode it as 512k count (from 5.3.3):
> >
> > C_SIZE
> > This field is expanded to 28 bits and can indicate up to 128 TBytes.
> >
> > This parameter is used to calculate the user data area capacity in the
> > SD memory card (note that size of the protected area is zero for SDUC
> > card). The user data area capacity is calculated from C_SIZE as follows=
:
> >
> > memory capacity =3D (C_SIZE+1) * 512KByte
> >
> > The Minimum user area size of SDUC Card is 4,294,968,320 sectors
> > (2TB+0.5MB).
> > The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h
> > (4194304). The Maximum user area size of SDUC Card is 274,877,906,944
> > sectors (128TB).
> > The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh
> > (268435455).
> >
> > So SD cards are yet again gratuitously different than MMC cards.
> >
>
> Argh, then we need to take the card type into account as well. Need to
> rework my patch...
>

Sorry to be the bearer of bad news... I stubbed my toe on this when I wrote
the FreeBSD stack 15 years ago and the experience is memorable, even after
all this time.

Warner

--000000000000fd5e06063dd530cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUdWUsIFNlcCAyLCAyMDI1IGF0IDExOjUz4oCvQU0gSmFuIEtpc3prYSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb20iPmphbi5raXN6a2FAc2ll
bWVucy5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPk9uIDAyLjA5LjI1IDE5OjQ4
LCBXYXJuZXIgTG9zaCB3cm90ZTo8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBPbiBU
dWUsIFNlcCAyLCAyMDI1IGF0IDExOjM34oCvQU0gSmFuIEtpc3prYSAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmphbi5raXN6a2FAc2llbWVucy5jb20iIHRhcmdldD0iX2JsYW5rIj5qYW4ua2lzemthQHNp
ZW1lbnMuY29tPC9hPjxicj4NCiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86amFuLmtp
c3prYUBzaWVtZW5zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmphbi5raXN6a2FAc2llbWVucy5jb208
L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBPbiAwMi4wOS4y
NSAxOTozMCwgV2FybmVyIExvc2ggd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IE9uIFR1ZSwgU2VwIDIsIDIwMjUg
YXQgMTE6MjLigK9BTSBXYXJuZXIgTG9zaCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmltcEBic2RpbXAu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+aW1wQGJzZGltcC5jb208L2E+PGJyPg0KJmd0O8KgIMKgIMKg
Jmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86aW1wQGJzZGltcC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5pbXBAYnNkaW1wLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAmbHQ7bWFpbHRv
OjxhIGhyZWY9Im1haWx0bzppbXBAYnNkaW1wLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmltcEBic2Rp
bXAuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzppbXBAYnNkaW1wLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmltcEBic2RpbXAuY29tPC9hPiZndDsmZ3Q7Jmd0OyB3cm90ZTo8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBPbiBUdWUsIFNlcCAyLCAyMDI1IGF0IDEx
OjE44oCvQU0gSmFuIEtpc3prYTxicj4NCiZndDvCoCDCoCDCoCZsdDs8YSBocmVmPSJtYWlsdG86
amFuLmtpc3prYUBzaWVtZW5zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmphbi5raXN6a2FAc2llbWVu
cy5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5j
b20iIHRhcmdldD0iX2JsYW5rIj5qYW4ua2lzemthQHNpZW1lbnMuY29tPC9hPiZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqYW4ua2lz
emthQHNpZW1lbnMuY29tIiB0YXJnZXQ9Il9ibGFuayI+amFuLmtpc3prYUBzaWVtZW5zLmNvbTwv
YT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqYW4ua2lzemth
QHNpZW1lbnMuY29tIiB0YXJnZXQ9Il9ibGFuayI+amFuLmtpc3prYUBzaWVtZW5zLmNvbTwvYT4m
Z3Q7Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoE9uIDAyLjA5LjI1IDE5OjA3LCBXYXJuZXIgTG9zaCB3cm90ZTo8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCZndDsgT24gVHVlLCBTZXAgMiwgMjAyNSBhdCAxMDo0OeKAr0FNIEphbiBMw7xiYmU8YnI+DQom
Z3Q7wqAgwqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRvOmpsdUBwZW5ndXRyb25peC5kZSIgdGFyZ2V0
PSJfYmxhbmsiPmpsdUBwZW5ndXRyb25peC5kZTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86amx1QHBlbmd1dHJvbml4LmRlIiB0YXJnZXQ9Il9ibGFuayI+amx1QHBlbmd1dHJvbml4LmRl
PC9hPiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzpqbHVAcGVuZ3V0cm9uaXguZGUiIHRhcmdldD0iX2JsYW5rIj5qbHVAcGVu
Z3V0cm9uaXguZGU8L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmpsdUBwZW5ndXRyb25p
eC5kZSIgdGFyZ2V0PSJfYmxhbmsiPmpsdUBwZW5ndXRyb25peC5kZTwvYT4mZ3Q7Jmd0Ozxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsgJmx0O21haWx0bzo8YSBocmVmPSJt
YWlsdG86amx1QHBlbmd1dHJvbml4LmRlIiB0YXJnZXQ9Il9ibGFuayI+amx1QHBlbmd1dHJvbml4
LmRlPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpqbHVAcGVuZ3V0cm9uaXguZGUiIHRh
cmdldD0iX2JsYW5rIj5qbHVAcGVuZ3V0cm9uaXguZGU8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDC
oCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmpsdUBwZW5ndXRyb25peC5kZSIgdGFyZ2V0PSJf
YmxhbmsiPmpsdUBwZW5ndXRyb25peC5kZTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
amx1QHBlbmd1dHJvbml4LmRlIiB0YXJnZXQ9Il9ibGFuayI+amx1QHBlbmd1dHJvbml4LmRlPC9h
PiZndDsmZ3Q7Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoE9u
IFR1ZSwgMjAyNS0wOS0wMiBhdCAxODozOSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZTo8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZndDsgJmd0OyBJ
IGV4cGVjdCB1cyB0byBiZSBzYWZlIGFuZCBhYmxlIHRvIGRlYWwgd2l0aCBub24tPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgcG93MiByZWdpb25zPGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgaWYgd2UgdXNlPGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7ICZndDsgUUVNVVNHTGlzdCBm
cm9tIHRoZSAmcXVvdDtzeXN0ZW0vZG1hLmgmcXVvdDsgQVBJLiBCdXQ8YnI+DQomZ3Q7wqAgwqAg
wqB0aGlzIGlzPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgYSByZXdvcms8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBub2JvZHkgaGFkPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAmZ3Q7ICZn
dDsgdGltZSB0byBkbyBzbyBmYXIuPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgJmd0OyAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgJmd0OyAmZ3Q7IFdlIGhhdmUgdG8gdGVsbCB0d28gdGhpbmdzIGFwYXJ0OiBw
YXJ0aXRpb25zPGJyPg0KJmd0O8KgIMKgIMKgc2l6ZXMgb248YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqB0aGUgb25lPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgc2lkZSBhbmQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAmZ3Q7ICZndDsgYmFja2luZyBzdG9yYWdlIHNpemVzLiBUaGUgcGFydGl0aW9u
cyBzaXplcyBhcmU8YnI+DQomZ3Q7wqAgwqAgwqAodG8gbXk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqByZWFkaW5nKTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoGNsZWFybHk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAm
Z3Q7wqAgwqAgwqAmZ3Q7ICZndDsgZGVmaW5lZCBpbiB0aGUgc3BlYywgYW5kIHRoZSB1c2VyIHBh
cnRpdGlvbiAoYWxvbmUhKTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoGhhcyB0
byBiZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHBvd2Vy
IG9mPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyAm
Z3Q7IDIuIFRoZSBib290IGFuZCBSUE1CIHBhcnRpdGlvbnMgYXJlIG11bHRpcGxlcyBvZjxicj4N
CiZndDvCoCDCoCDCoDEyOEsuPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgVGhl
IHN1bTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoG9mIHRo
ZW08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7ICZn
dDsgYWxsIGlzIG5vd2hlcmUgbGltaXRlZCB0byBwb3dlciBvZiAyIG9yIGV2ZW4gb25seTxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoG11bHRpcGxlcyBvZiAxMjhLLjxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCZndDsgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAmZ3Q7IFJlLXJlYWRpbmcgdGhlIHBh
cnQgb2YgdGhlIGRldmljZSBjYXBhY2l0eSwgdGhlIHJ1bGVzPGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgYXJlIG1vcmU8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAg
wqAmZ3Q7wqAgwqAgwqBjb21wbGV4Ojxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoCZndDsgwqAtIHBvd2VyIG9mIHR3byB1cCB0byAyIEdCPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyDCoC0gbXVsdGlwbGUgb2Yg
NTEyIGJ5dGVzIGJleW9uZCB0aGF0PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoCZndDsgU28gdGhhdCBwb3dlci1vZi10d28gZW5mb3JjZW1lbnQgd2FzIGFuZCBzdGls
bCBpczxicj4NCiZndDvCoCDCoCDCoGxpa2VseTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoHRvbyBzdHJpY3QuPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7IEl0IGlzLiBWZXJzaW9uIDAgKGFuZCBNTUMpIGNhcmRz
IGhhZCB0aGUgY2FwYWNpdHk8YnI+DQomZ3Q7wqAgwqAgwqBlbmNvZGVkIGxpa2Ugc286PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBtID0gbW1jX2dldF9iaXRzKHJhd19jc2QsIDEyOCwgNjIsIDEyKTs8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGUgPSBtbWNf
Z2V0X2JpdHMocmF3X2NzZCwgMTI4LCA0NywgMyk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjc2QtJmd0O2NhcGFjaXR5ID0g
KCgxICsgbSkgJmx0OyZsdDsgKGUgKyAyKSkgKiBjc2QtPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgJmd0O3JlYWRfYmxfbGVuOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCZndDsgc28gYW55IGNhcmQgbGVzcyB0aGFuIDJHQiAod2VsbCwgdGVjaG5pY2FsbHkg
NEdCLCBidXQgNEdCPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgdmVyc2lvbiAw
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyBjYXJkcyB3ZXJlPGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyByYXJlIGFuZCBicm9rZSBzb21lIHN0
YWNrcy4uLiBJIGhhdmUgb25lIGFuZCBJIGxvdmUgaXQgb27CoG15PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgZW1iZWRkZWQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7IEFSTSBib2FyZDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZn
dDsgdGhhdCBjYW4mIzM5O3QgZG8gdmVyc2lvbiAxIGNhcmRzKS4gVmVyc2lvbiAxIGNhcmRzIGVu
Y29kZWQ8YnI+DQomZ3Q7wqAgwqAgwqBpdCBsaWtlOjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCDCoCDCoCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3NkLSZndDtjYXBhY2l0eSA9
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgKCh1aW50NjRfdCltbWNfZ2V0X2Jp
dHMocmF3X2NzZCwgMTI4LDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsg
NDgsIDIyKSArPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxKSAqIDUxMiAqIDEwMjQ7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgJmd0OyBTbyBpdCYjMzk7cyBhIG11bHRpcGxlIG9mIDUxMmsuIFRo
ZXNlIGFyZSBhbHNvIGNhbGxlZCAmIzM5O2hpZ2g8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqBjYXBhY2l0eSYjMzk7IGNhcmRzLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7IFZlcnNp
b24gNCBpbnRyb2R1Y2VzIGFuIGV4dGVuZGVkIENTRCwgd2hpY2ggaGFkIGHCoHB1cmU8YnI+DQom
Z3Q7wqAgwqAgwqBzZWN0b3I8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBjb3Vu
dCBpbjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsgdGhlIEVYVCBDU0Qu
IEkgdGhpbmsgdGhpczxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsgaXMg
b25seSBmb3IgTU1DIGNhcmRzLiBBbmQgYWxzbyB0aGUgcGFydGl0aW9uIGluZm9ybWF0aW9uLjxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsgwqA8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgJmd0O8KgIMKgIMKgJmd0OyBCdXQgSSBzdGlsbCBzZWUgbm8gaW5kaWNhdGlvbiwgbmVpdGhl
ciBpbiB0aGUgZXhpc3Rpbmc8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBlTU1D
IGNvZGU8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBvZiBR
RU1VPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgJmd0OyBu
b3IgdGhlIHNwZWMsIHRoYXQgdGhlIGJvb3QgYW5kIFJQTUIgcGFydGl0aW9uPGJyPg0KJmd0O8Kg
IMKgIMKgc2l6ZXMgYXJlPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgaW5jbHVk
ZWQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBpbiB0aGF0
Ljxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBDb3JyZWN0LiBOb24tcG93ZXItb2YtdHdv
IHNpemVzIGFyZSB2ZXJ5IGNvbW1vbiBmb3IgcmVhbDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCDCoCDCoGVNTUNzLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoFRha2luZyBhIHJhbmRvbTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCZndDvCoCDCoCDCoG9uZSBmcm9tIG91ciBsYWI6PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgW8KgIMKgIDEuMjIwNTg4XSBtbWNibGsxOiBtbWMxOjAwMDEg
UzBKNTZYIDE0LjggR2lCPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8Kg
IMKgIMKgW8KgIMKgIDEuMjI4MDU1XcKgIG1tY2JsazE6IHAxIHAyIHAzIHA0PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgW8KgIMKgIDEuMjMwMzc1XSBtbWNi
bGsxYm9vdDA6IG1tYzE6MDAwMSBTMEo1NlggMzEuNSBNaUI8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBbwqAgwqAgMS4yMzM2NTFdIG1tY2JsazFib290MTog
bW1jMTowMDAxIFMwSjU2WCAzMS41IE1pQjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCZndDvCoCDCoCDCoFvCoCDCoCAxLjIzNjY4Ml0gbW1jYmxrMXJwbWI6IG1tYzE6MDAwMSBT
MEo1NlggNC4wMCBNaUIsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgY2hhcmRl
diAoMjQ0OjApPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoEZvciBlTU1DcyB1c2luZyBN
TEMgTkFORCwgeW91IGNhbiBhbHNvIGNvbmZpZ3VyZSBwYXJ0IG9mPGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgdGhlIHVzZXI8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAg
wqAgwqAmZ3Q7wqAgwqAgwqBkYXRhIGFyZWEgdG88YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAmZ3Q7wqAgwqAgwqBiZSBwU0xDIChwc2V1ZG8gc2luZ2xlIGxldmVsIGNlbGwpLCB3
aGljaCBjaGFuZ2VzIHRoZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoGF2YWls
YWJsZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoGNhcGFj
aXR5IChhZnRlcjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oGEgcmVxdWlyZWQgcG93ZXIgY3ljbGUpLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgJmd0OyBZZXMuIEV4dGVuZGVkIHBhcnRpdGlvbnMg
YXJlIGEgZmVhdHVyZSBvZiB2ZXJzaW9uIDQ8YnI+DQomZ3Q7wqAgwqAgwqBjYXJkcywgc288YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBkb24mIzM5O3QgaGF2ZTxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZndDsgcG93ZXItb2YtMiBsaW1pdHMgc2luY2UgdGhl
eSBhcmUgYSBwdXJlIHNlY3RvciBjb3VudCBpbiB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqBleHRfY3NkLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgSkVTRDg0LUI1MUEgKGVNTUMgNS4xQSk6PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCZxdW90O1RoZSBDX1NJWkUgcGFyYW1ldGVyIGlz
IHVzZWQgdG8gY29tcHV0ZSB0aGUgZGV2aWNlPGJyPg0KJmd0O8KgIMKgIMKgY2FwYWNpdHkgZm9y
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgZGV2aWNlczxicj4NCiZndDvCoCDC
oCDCoCZndDvCoCDCoCDCoCDCoCDCoHVwIHRvIDIgR0Igb2YgZGVuc2l0eS4gU2VlIDcuNC41Miwg
U0VDX0NPVU5UIFsyMTU6MjEyXSAsIGZvcjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoGRldGFpbHMgb248YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBjYWxjdWxh
dGluZyBkZW5zaXRpZXMgZ3JlYXRlciB0aGFuIDIgR0IuJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoFNvIEkgd291bGQgbm93IGNv
bnRpbnVlIHRvIGVuZm9yY2UgcG93ZXItb2YtMiBmb3IgMkc8YnI+DQomZ3Q7wqAgwqAgwqAoaW5j
bHVkaW5nKTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoGNhcmRzLDxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoGFuZCByZWxheCB0byBtdWx0aXBsZXMgb2YgNTEy
IGZvciBsYXJnZXIgb25lcy48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEl0JiMzOTtzIGEgbXVsdGlwbGUgb2Yg
NTEyayB1bmxlc3MgdGhlIGNhcmQgaGFzIGEgZXh0X2NzZCwgaW48YnI+DQomZ3Q7wqAgwqAgwqB3
aGljaCBjYXNlPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgaXQmIzM5O3MgYSBtdWx0aXBs
ZSBvZiA1MTIuPGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7IE1vcmUgY29tcGxldGVseSwgdGhpcyBpcyBmcm9tIE1NQyA0LjAg
YW5kIG5ld2VyLiBFeHRlbmRlZCBDYXBhY2l0eSBTRDxicj4NCiZndDvCoCDCoCDCoCZndDsgY2Fy
ZHMgcmVwb3J0IHRoaXMgaW4gdW5pdHMgb2YgNTEyayBieXRlcyBmb3IgYWxsIGNhcmRzICZndDsg
MkdpQi48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBJ
JiMzOTttIG5vdCBzdXJlIHdoaWNoIHNwZWMgdmVyc2lvbiB5b3UgYXJlIHJlZmVycmluZyB0bywg
YnV0IEpFU0Q4NC1BNDQxPGJyPg0KJmd0O8KgIMKgIMKgYW5kIEpFU0Q4NC1CNTFBIG1lbnRpb24g
bm90aGluZyBhYm91dCA1MTJLLCByYXRoZXIgJnF1b3Q7RGV2aWNlIGRlbnNpdHkgPTxicj4NCiZn
dDvCoCDCoCDCoFNFQ19DT1VOVCB4IDUxMkImcXVvdDsuIEFuZCB0aGVzZSBhcmUgdGhlIHNwZWNz
IHdlIHZlcnkgbGlrZWx5IG5lZWQgdG8gZm9sbG93PGJyPg0KJmd0O8KgIMKgIMKgaGVyZS48YnI+
DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBZb3UgYXJlIHJpZ2h0IHRoYXTCoHRoaXMgaXMg
aW4gdGhlIE1NQyBzcGVjLiBIb3dldmVyLCB0aGUgU0Qgc3BlYyBpczxicj4NCiZndDsgY29udHJv
bGxpbmcgZm9yIFNEIGNhcmRzLjxicj4NCiZndDsgPGJyPg0KJmd0OyBTRCBTcGVjaWZpY2F0aW9u
c8KgUGFydCAxwqBQaHlzaWNhbCBMYXllcsKgU2ltcGxpZmllZCBTcGVjaWZpY2F0aW9uwqBWZXJz
aW9uPGJyPg0KJmd0OyA5LjEwPGJyPg0KJmd0OyBEZWNlbWJlciAxLCAyMDIzPGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IFNlY3Rpb24gNS4zIGRlc2NyaWJlcyB0aGUgQ1NELiBWZXJzaW9uIDEuMCAod2hp
Y2ggSSYjMzk7ZCBjYWxsZWQgdmVyc2lvbiAwPGJyPg0KJmd0OyBpbiBhbiBlYXJsaWVyIGVtYWls
IGJlY2F1c2Ugb2YgaXRzIGVuY29kaW5nKSBpcyB0aGUgMkdCIHJ1bGUuIFZlcnNpb248YnI+DQo8
YnI+DQombHQ7IDJHIG9yICZsdDs9IDJHPyBGb3IgZU1NQywgaXQgaXMgJmx0Oz0uPGJyPg0KPGJy
Pg0KJmd0OyAyLjAgYW5kIDMuMCBlbmNvZGUgaXQgYXMgNTEyayBjb3VudCAoZnJvbSA1LjMuMyk6
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IENfU0laRTxicj4NCiZndDsgVGhpcyBmaWVsZCBpcyBleHBh
bmRlZCB0byAyOCBiaXRzIGFuZCBjYW4gaW5kaWNhdGUgdXAgdG8gMTI4IFRCeXRlcy48YnI+DQom
Z3Q7IDxicj4NCiZndDsgVGhpcyBwYXJhbWV0ZXIgaXMgdXNlZCB0byBjYWxjdWxhdGUgdGhlIHVz
ZXIgZGF0YSBhcmVhIGNhcGFjaXR5IGluIHRoZTxicj4NCiZndDsgU0QgbWVtb3J5IGNhcmQgKG5v
dGUgdGhhdCBzaXplIG9mIHRoZSBwcm90ZWN0ZWQgYXJlYSBpcyB6ZXJvIGZvciBTRFVDPGJyPg0K
Jmd0OyBjYXJkKS4gVGhlIHVzZXIgZGF0YSBhcmVhIGNhcGFjaXR5IGlzIGNhbGN1bGF0ZWQgZnJv
bSBDX1NJWkUgYXMgZm9sbG93czo8YnI+DQomZ3Q7IDxicj4NCiZndDsgbWVtb3J5IGNhcGFjaXR5
ID0gKENfU0laRSsxKSAqIDUxMktCeXRlPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFRoZSBNaW5pbXVt
IHVzZXIgYXJlYSBzaXplIG9mIFNEVUMgQ2FyZCBpcyA0LDI5NCw5NjgsMzIwIHNlY3RvcnM8YnI+
DQomZ3Q7ICgyVEIrMC41TUIpLjxicj4NCiZndDsgVGhlIE1pbmltdW0gdmFsdWUgb2YgQ19TSVpF
IGZvciBTRFVDIGluIENTRCBWZXJzaW9uIDMuMCBpcyAwNDAwMDAwaDxicj4NCiZndDsgKDQxOTQz
MDQpLiBUaGUgTWF4aW11bSB1c2VyIGFyZWEgc2l6ZSBvZiBTRFVDIENhcmQgaXMgMjc0LDg3Nyw5
MDYsOTQ0PGJyPg0KJmd0OyBzZWN0b3JzICgxMjhUQikuPGJyPg0KJmd0OyBUaGUgTWF4aW11bSB2
YWx1ZSBvZiBDX1NJWkUgZm9yIFNEVUMgaW4gQ1NEIFZlcnNpb24gMy4wIGlzIEZGRkZGRkZoPGJy
Pg0KJmd0OyAoMjY4NDM1NDU1KS48YnI+DQomZ3Q7IDxicj4NCiZndDsgU28gU0QgY2FyZHMgYXJl
IHlldCBhZ2FpbiBncmF0dWl0b3VzbHkgZGlmZmVyZW50IHRoYW4gTU1DIGNhcmRzLjxicj4NCiZn
dDsgPGJyPg0KPGJyPg0KQXJnaCwgdGhlbiB3ZSBuZWVkIHRvIHRha2UgdGhlIGNhcmQgdHlwZSBp
bnRvIGFjY291bnQgYXMgd2VsbC4gTmVlZCB0bzxicj4NCnJld29yayBteSBwYXRjaC4uLjxicj48
L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5Tb3JyeSB0byBiZSB0aGUgYmVhcmVyIG9m
IGJhZCBuZXdzLi4uIEkgc3R1YmJlZCBteSB0b2Ugb24gdGhpcyB3aGVuIEkgd3JvdGUgdGhlIEZy
ZWVCU0Qgc3RhY2sgMTUgeWVhcnMgYWdvIGFuZCB0aGUgZXhwZXJpZW5jZSBpcyBtZW1vcmFibGUs
IGV2ZW4gYWZ0ZXIgYWxsIHRoaXMgdGltZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pldhcm5l
csKgPC9kaXY+PC9kaXY+PC9kaXY+DQo=
--000000000000fd5e06063dd530cd--


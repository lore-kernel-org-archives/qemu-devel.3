Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430F9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utV8W-0006q2-J0; Tue, 02 Sep 2025 13:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utV86-0006kZ-7A
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:49:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utV83-00026z-Dt
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:49:13 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24a9cc916b3so27116325ad.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756835349; x=1757440149;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hYdL0c0h8e/f6IFUFfQ4CpQOV8PvCupqhJ/ce+m906s=;
 b=ykiDTbk6El/kl+KVtsXKG8lmkvFm6T+dfci5xUHFbnXwElZuenm6riKNfK3y0TcVcm
 jq7kKPqClrP6q+FAR4PryJfJETY2jwJNwXwcIgDxLYOXLWbdy3Zh6D9UD7d+QjcgM/zV
 kmPpHkqD0XV0s/owH1i8dCQ9poSF/hJU8pS9NZ4KHGxBl6d79G2JDscYea4TwbnrEr6e
 +uRjp2cIht/kx1eYa8zxUowIYaJZTe2pTb1m/2bqkQwTFU8PWQyVaN4jP6YcYXdEV4pK
 IXwW/miXqdUT46mFO3fIcHayyRiigBwPcZRW1Se2/dOY1vLAbYd6SDramCRPbc0h5dVM
 XDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756835349; x=1757440149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYdL0c0h8e/f6IFUFfQ4CpQOV8PvCupqhJ/ce+m906s=;
 b=XtvkvlwC7YQ14MvQ9t6aIHdBD8DERvJcaLn0zdfMVQONWL8t2D62EuLubi8DbB1YwX
 lL2lJT5P/A7XOzzg27RnbgjTiLdZOXzY0mpujOHkCk0eIThE1j/GjqD3EOA7Vf2iQGkO
 l9MxNeg8whYwe9v1E472zFHnLpCE+xI0L4oc//Y01iyjwi9grnUmaTmk0mCuc+XHR7MN
 AFv/JgBaEOtEvRFUDNgcbYZgWidDlIEAwywohIWcPDNsYBDAjEDNdXugHACLnLGPKxk7
 WikmFdyaJApDtYWFusOgN0VCiJ61aOxg3W4Be8rKJ/wi2R1z/WEexfaaMQjWnfqbpHiN
 oSEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+CyTK9A0NyJb8qFiCGkbkIcM4YuO4yhUNXHg/dVxCTQ3L238ktl6JIoVdfy7T1eUXViKPXMWpcI5U@nongnu.org
X-Gm-Message-State: AOJu0Yy6LNxZGbkDpi6/9ghSytChJ/kFQWU7KFLBpiCCQk9TPDVEjYyw
 JtHY1Vr2Z+HjYsy0ZU0FALT7XaKVH8mNVkJQkfeFkEdtESCzbkG6iZXBvRXg9bzbeZlibHOhcj/
 Z2ns4cCGiSsB8nbvW+12ui3T0xji0wIf9nnytLE2Riw==
X-Gm-Gg: ASbGncteTVTO0DCFyx9UZrwlkjx4awXd2YqsA5zRUU/v87dg479DCMTJdAaEfaWU7MY
 V8SblKg7vVMgnZ9xPTrHA2NHdgIrnHbr2ySyaX6SzyQ2RQU/A109jiFFPaDDz57eszHmM130YLY
 m5KFSdFIl7iUXzT4PqQWhDLGjLqL3ZrTiErdn4SzDbgtX/PhMuYBImyckR3K16est1MVjs8cmKk
 YD+fcJUBak0FRmErGL8pFdj1FfXLa+lgyiiJmQ=
X-Google-Smtp-Source: AGHT+IHy8FBfpzbCLa+ch4ukcV1XhygMFvcoTeOPUYlG3STGJxwl8oSw+PkDZ4KWWXhvSQ6Wrfh6ToVWVmrj3MW9Gtg=
X-Received: by 2002:a17:902:f54d:b0:24a:9c83:e19f with SMTP id
 d9443c01a7336-24a9c83e357mr121491665ad.53.1756835348886; Tue, 02 Sep 2025
 10:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1756706188.git.jan.kiszka@siemens.com>
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
 <CANCZdfp5AvUQNJ5m8V=z=R14CRwauSP7Qg+1FZ7VV_Ztb5Rb7A@mail.gmail.com>
 <CANCZdfrqiFBP9vP76yjvurmE5KX=OvC7c6vnUp66xr8jc0zaMg@mail.gmail.com>
 <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
In-Reply-To: <1a7e47de-0021-4180-90a1-b249af8d22e0@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 11:48:57 -0600
X-Gm-Features: Ac12FXwlPKYl_S-PhvC89tjoPDofymsDPSrCeQaYyOx53XtAJVCMqhVJfrAOKLA
Message-ID: <CANCZdfrgB5NXNSa+KHs9AcgFW8Qy+raj1a75DkuQeX2Lt1=aAw@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000e6480d063dd51ada"
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x635.google.com
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

--000000000000e6480d063dd51ada
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:37=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 02.09.25 19:30, Warner Losh wrote:
> >
> >
> > On Tue, Sep 2, 2025 at 11:22=E2=80=AFAM Warner Losh <imp@bsdimp.com
> > <mailto:imp@bsdimp.com>> wrote:
> >
> >
> >
> >     On Tue, Sep 2, 2025 at 11:18=E2=80=AFAM Jan Kiszka <jan.kiszka@siem=
ens.com
> >     <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >         On 02.09.25 19:07, Warner Losh wrote:
> >         >
> >         >
> >         > On Tue, Sep 2, 2025 at 10:49=E2=80=AFAM Jan L=C3=BCbbe <jlu@p=
engutronix.de
> >         <mailto:jlu@pengutronix.de>
> >         > <mailto:jlu@pengutronix.de <mailto:jlu@pengutronix.de>>>
> wrote:
> >         >
> >         >     On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
> >         >     > > > I expect us to be safe and able to deal with non-
> >         pow2 regions
> >         >     if we use
> >         >     > > > QEMUSGList from the "system/dma.h" API. But this is
> >         a rework
> >         >     nobody had
> >         >     > > > time to do so far.
> >         >     > >
> >         >     > > We have to tell two things apart: partitions sizes on
> >         the one
> >         >     side and
> >         >     > > backing storage sizes. The partitions sizes are (to m=
y
> >         reading)
> >         >     clearly
> >         >     > > defined in the spec, and the user partition (alone!)
> >         has to be
> >         >     power of
> >         >     > > 2. The boot and RPMB partitions are multiples of 128K=
.
> >         The sum
> >         >     of them
> >         >     > > all is nowhere limited to power of 2 or even only
> >         multiples of 128K.
> >         >     > >
> >         >     >
> >         >     > Re-reading the part of the device capacity, the rules
> >         are more
> >         >     complex:
> >         >     >  - power of two up to 2 GB
> >         >     >  - multiple of 512 bytes beyond that
> >         >     >
> >         >     > So that power-of-two enforcement was and still is likel=
y
> >         too strict.
> >         >
> >         >
> >         > It is. Version 0 (and MMC) cards had the capacity encoded lik=
e
> so:
> >         >                 m =3D mmc_get_bits(raw_csd, 128, 62, 12);
> >         >                 e =3D mmc_get_bits(raw_csd, 128, 47, 3);
> >         >                 csd->capacity =3D ((1 + m) << (e + 2)) * csd-
> >         >read_bl_len;
> >         > so any card less than 2GB (well, technically 4GB, but 4GB
> >         version 0
> >         > cards were
> >         > rare and broke some stacks... I have one and I love it on my
> >         embedded
> >         > ARM board
> >         > that can't do version 1 cards). Version 1 cards encoded it
> like:
> >         >                 csd->capacity =3D
> >         ((uint64_t)mmc_get_bits(raw_csd, 128,
> >         > 48, 22) +
> >         >                     1) * 512 * 1024;
> >         > So it's a multiple of 512k. These are also called 'high
> >         capacity' cards.
> >         >
> >         > Version 4 introduces an extended CSD, which had a pure sector
> >         count in
> >         > the EXT CSD. I think this
> >         > is only for MMC cards. And also the partition information.
> >         >
> >         >
> >         >     > But I still see no indication, neither in the existing
> >         eMMC code
> >         >     of QEMU
> >         >     > nor the spec, that the boot and RPMB partition sizes ar=
e
> >         included
> >         >     in that.
> >         >
> >         >     Correct. Non-power-of-two sizes are very common for real
> >         eMMCs.
> >         >     Taking a random
> >         >     one from our lab:
> >         >     [    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
> >         >     [    1.228055]  mmcblk1: p1 p2 p3 p4
> >         >     [    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
> >         >     [    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
> >         >     [    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB,
> >         chardev (244:0)
> >         >
> >         >     For eMMCs using MLC NAND, you can also configure part of
> >         the user
> >         >     data area to
> >         >     be pSLC (pseudo single level cell), which changes the
> >         available
> >         >     capacity (after
> >         >     a required power cycle).
> >         >
> >         >
> >         > Yes. Extended partitions are a feature of version 4 cards, so
> >         don't have
> >         > power-of-2 limits since they are a pure sector count in the
> >         ext_csd.
> >         >
> >
> >         JESD84-B51A (eMMC 5.1A):
> >
> >         "The C_SIZE parameter is used to compute the device capacity fo=
r
> >         devices
> >         up to 2 GB of density. See 7.4.52, SEC_COUNT [215:212] , for
> >         details on
> >         calculating densities greater than 2 GB."
> >
> >         So I would now continue to enforce power-of-2 for 2G (including=
)
> >         cards,
> >         and relax to multiples of 512 for larger ones.
> >
> >
> >     It's a multiple of 512k unless the card has a ext_csd, in which cas=
e
> >     it's a multiple of 512.
> >
> >
> > More completely, this is from MMC 4.0 and newer. Extended Capacity SD
> > cards report this in units of 512k bytes for all cards > 2GiB.
> >
>
> I'm not sure which spec version you are referring to, but JESD84-A441
> and JESD84-B51A mention nothing about 512K, rather "Device density =3D
> SEC_COUNT x 512B". And these are the specs we very likely need to follow
> here.
>

You are right that this is in the MMC spec. However, the SD spec is
controlling for SD cards.

SD Specifications Part 1 Physical Layer Simplified Specification Version
9.10
December 1, 2023

Section 5.3 describes the CSD. Version 1.0 (which I'd called version 0 in
an earlier email because of its encoding) is the 2GB rule. Version 2.0 and
3.0 encode it as 512k count (from 5.3.3):

C_SIZE
This field is expanded to 28 bits and can indicate up to 128 TBytes.

This parameter is used to calculate the user data area capacity in the SD
memory card (note that size of the protected area is zero for SDUC card).
The user data area capacity is calculated from C_SIZE as follows:

memory capacity =3D (C_SIZE+1) * 512KByte

The Minimum user area size of SDUC Card is 4,294,968,320 sectors
(2TB+0.5MB).
The Minimum value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h
(4194304). The Maximum user area size of SDUC Card is 274,877,906,944
sectors (128TB).
The Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh
(268435455).

So SD cards are yet again gratuitously different than MMC cards.

Warner

--000000000000e6480d063dd51ada
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 11:37=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemen=
s.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 02.09.25 19:30, Warner Losh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Sep 2, 2025 at 11:22=E2=80=AFAM Warner Losh &lt;<a href=3D"mai=
lto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsd=
imp.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 2, 2025 at 11:18=E2=80=AFAM Jan Kiszka =
&lt;<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@=
siemens.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com=
" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 02.09.25 19:07, Warner Losh wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Tue, Sep 2, 2025 at 10:49=E2=
=80=AFAM Jan L=C3=BCbbe &lt;<a href=3D"mailto:jlu@pengutronix.de" target=3D=
"_blank">jlu@pengutronix.de</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jlu@peng=
utronix.de" target=3D"_blank">jlu@pengutronix.de</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a href=3D"mailto:jlu=
@pengutronix.de" target=3D"_blank">jlu@pengutronix.de</a> &lt;mailto:<a hre=
f=3D"mailto:jlu@pengutronix.de" target=3D"_blank">jlu@pengutronix.de</a>&gt=
;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On Tue, 2025-=
09-02 at 18:39 +0200, Jan Kiszka wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; I expect us to be safe and able to deal with non-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pow2 regions<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0if we use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; QEMUSGList from the &quot;system/dma.h&quot; API. But this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a rework<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0nobody had<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; time to do so far.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; We =
have to tell two things apart: partitions sizes on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the one<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0side and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; bac=
king storage sizes. The partitions sizes are (to my<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reading)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0clearly<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; def=
ined in the spec, and the user partition (alone!)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0power of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 2. =
The boot and RPMB partitions are multiples of 128K.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The sum<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0of them<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; all=
 is nowhere limited to power of 2 or even only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multiples of 128K.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Re-readi=
ng the part of the device capacity, the rules<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0are more<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0complex:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0- =
power of two up to 2 GB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0- =
multiple of 512 bytes beyond that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; So that =
power-of-two enforcement was and still is likely<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0too strict.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; It is. Version 0 (and MMC) cards=
 had the capacity encoded like so:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 m =3D mmc_get_bits(raw_csd, 128, 62, 12);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 e =3D mmc_get_bits(raw_csd, 128, 47, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capacity =3D ((1 + m) &lt;&lt; (e + 2)) * =
csd-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;read_bl_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; so any card less than 2GB (well,=
 technically 4GB, but 4GB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; cards were<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; rare and broke some stacks... I =
have one and I love it on=C2=A0my<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0embedded<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ARM board<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; that can&#39;t do version 1 card=
s). Version 1 cards encoded it like:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 csd-&gt;capacity =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((uint64_t)mmc_get_bits(raw_csd, 128,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 48, 22) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1) * 512 * 1024;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; So it&#39;s a multiple of 512k. =
These are also called &#39;high<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capacity&#39; cards.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Version 4 introduces an extended=
 CSD, which had a=C2=A0pure sector<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; the EXT CSD. I think this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; is only for MMC cards. And also =
the partition information.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; But I st=
ill see no indication, neither in the existing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eMMC code<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0of QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; nor the =
spec, that the boot and RPMB partition sizes are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0included<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0in that.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Correct. Non-=
power-of-two sizes are very common for real<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eMMCs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Taking a rand=
om<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0one from our =
lab:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=
=A0 1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=
=A0 1.228055]=C2=A0 mmcblk1: p1 p2 p3 p4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=
=A0 1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=
=A0 1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0[=C2=A0 =C2=
=A0 1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chardev (244:0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0For eMMCs usi=
ng MLC NAND, you can also configure part of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0data area to<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0be pSLC (pseu=
do single level cell), which changes the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0available<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0capacity (aft=
er<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0a required po=
wer cycle).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Yes. Extended partitions are a f=
eature of version 4 cards, so<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0don&#39;t have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; power-of-2 limits since they are=
 a pure sector count in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext_csd.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0JESD84-B51A (eMMC 5.1A):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The C_SIZE parameter is used to=
 compute the device capacity for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up to 2 GB of density. See 7.4.52, SE=
C_COUNT [215:212] , for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0details on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0calculating densities greater than 2 =
GB.&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So I would now continue to enforce po=
wer-of-2 for 2G (including)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and relax to multiples of 512 for lar=
ger ones.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s a multiple of 512k unless the card has a e=
xt_csd, in which case<br>
&gt;=C2=A0 =C2=A0 =C2=A0it&#39;s a multiple of 512.<br>
&gt; <br>
&gt; <br>
&gt; More completely, this is from MMC 4.0 and newer. Extended Capacity SD<=
br>
&gt; cards report this in units of 512k bytes for all cards &gt; 2GiB.<br>
&gt; <br>
<br>
I&#39;m not sure which spec version you are referring to, but JESD84-A441<b=
r>
and JESD84-B51A mention nothing about 512K, rather &quot;Device density =3D=
<br>
SEC_COUNT x 512B&quot;. And these are the specs we very likely need to foll=
ow<br>
here.<br></blockquote><div><br></div><div>You are right that=C2=A0this is i=
n the MMC spec. However, the SD spec is controlling for SD cards.</div><div=
><br></div><div>SD Specifications=C2=A0Part 1=C2=A0Physical Layer=C2=A0Simp=
lified Specification=C2=A0Version 9.10<br>December 1, 2023</div><div><br></=
div><div>Section 5.3 describes the CSD. Version 1.0 (which I&#39;d called v=
ersion 0 in an earlier email because of its encoding) is the 2GB rule. Vers=
ion 2.0 and 3.0 encode it as 512k count (from 5.3.3):</div><div><br></div><=
div>C_SIZE<br>This field is expanded to 28 bits and can indicate up to 128 =
TBytes.<br><br>This parameter is used to calculate the user data area capac=
ity in the SD memory card (note that size of the protected area is zero for=
 SDUC card). The user data area capacity is calculated from C_SIZE as follo=
ws:<br><br>memory capacity =3D (C_SIZE+1) * 512KByte<br><br>The Minimum use=
r area size of SDUC Card is 4,294,968,320 sectors (2TB+0.5MB).<br>The Minim=
um value of C_SIZE for SDUC in CSD Version 3.0 is 0400000h (4194304). The M=
aximum user area size of SDUC Card is 274,877,906,944 sectors (128TB).<br>T=
he Maximum value of C_SIZE for SDUC in CSD Version 3.0 is FFFFFFFh (2684354=
55).</div><div><br></div><div>So SD cards are yet again gratuitously differ=
ent than MMC cards.</div><div><br></div><div>Warner</div></div></div>

--000000000000e6480d063dd51ada--


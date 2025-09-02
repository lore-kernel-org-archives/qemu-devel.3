Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E07DCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUgi-0006Yi-U9; Tue, 02 Sep 2025 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utUgh-0006Xi-LB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:20:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utUgc-0001EE-Nd
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:20:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-244582738b5so49228435ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756833648; x=1757438448;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MB/UTLU5xoKxE7cF24PN2jwSynC0IakO2k2lx1F4WAU=;
 b=SieLn9pvY3BfXYbhoROflNaV4CN9A82idLEuRaX06+b2dAVQWAOuTZyRwjcyHnYfsJ
 Mv8cllGdz9fopjU2T+4twaD8f3ysjWUBkuk/2+N+YQwAzv4BHAVHJKky6OWqAlPwftwa
 f9FP//owKkQIpVz3V8HHTsgAkotaDIXOZBAYRuqbMngO/Nt/aCSrnjagea4hTa1wpYAY
 1qlqeZq8cipQVY9N7ioczCessI8mP6StYn5YawHhH4Tx4BhyPBDQrMEGD0C+J5rCuRH0
 bqJNgoIaToPdTampiUgFSyUbY7VrjuwEXY4YZAeD7yFH07XlAtTMIzuQ4gllKDo1NIcx
 o6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756833648; x=1757438448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MB/UTLU5xoKxE7cF24PN2jwSynC0IakO2k2lx1F4WAU=;
 b=upWmrgsL32liunt80bAhXR260hfS62I/+OmROjSTrx73jRAaoHXAO6RuL0RbJh/NWV
 4rVFkg4e9A4tIdFHHuaSDiVVvo5vykCcK867lhpNtHQ9COX4AanEpIKcpTy+yTGTc4jx
 tVAikCZbqdyjZ4nPGFTvhksRiG1p1mHZUHIXQWXGqMua8tq5UEvAORS4jy6R77ts7JS7
 HkHDGo9KxMfgRw/P7eZgjHluzXNOeP4sskNVaVONjyaCs6j7v07tX7eIpMlEV7pHF7f6
 p0qUhr4eMd3/d3W5QB4nW+KMbhv5KnYcaZ2VqbuXa9PrmxovC+52H0o4xorIQoXy5tKo
 BsKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL9ZM1Tpt7jBdhGQ35ZnSMLG7yEcpwWRCON9NLmc1oMOxNRVqoEzOlQ5AQqQ/NXagsy/gH/wr/ZQqS@nongnu.org
X-Gm-Message-State: AOJu0YyK/2Qc88A94IG4rH9QeB9rUFhb+F221jNpkj41ncdIgZ90UxRL
 af6fXP1h1guZZFCFAmafMfIhzzGAOpqE2NjKI9rpJyJ7xkAVCL8NGRT8Tn3AFL/97PLGAwJSeiz
 0DGWy2YTN06oU7GyUXBHNiNu8cTgTIT9Yc0wnZGXW+Q==
X-Gm-Gg: ASbGncshuU+jT5vmziyFm9gulG05DbynBtOelHZBUQBHyoaNeNr8H896ZuUxYuUJl2E
 HwW/dQ0PHb2XGDLzZgLhXjxW2N6efpBU3PsBnb6VU/tvLXweDPs45rBxklt4+C1jONVWNo1RHoD
 6Sd6RRsofREXTVf4c9thYMr1Pu4AzRWMl6YIobloZzaJ0UipP2e+BkHl3GYV6ADupGYqcNQMaDl
 ztCSs5Iv00HL7w8XhqDkGQ05cTKnsps7oMflg/ssXd2j5g3og==
X-Google-Smtp-Source: AGHT+IFN+CC6dEJWkXfmVt5FMjtW5GOstmtyQ4VNnNqeSdyBYs2+FNjwHzjJJI4yl6Yb5MPZbb7TFAvp3xZacQYidVQ=
X-Received: by 2002:a17:903:41d0:b0:249:27b9:2a06 with SMTP id
 d9443c01a7336-2494488a758mr172585625ad.2.1756833647708; Tue, 02 Sep 2025
 10:20:47 -0700 (PDT)
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
In-Reply-To: <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 11:20:36 -0600
X-Gm-Features: Ac12FXyfqMuYvTFw8F1mZIMr4V0hMQtKgLv4ig9eRZGqFJ9MPwnTAGTxExBcI4A
Message-ID: <CANCZdfrTouq9JVPQqxFdKttZ0xqfgPAjMX8fLNVEf+YdLwDhtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
Content-Type: multipart/alternative; boundary="00000000000080a9fd063dd4b53b"
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URI_HEX=0.1 autolearn=no autolearn_force=no
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

--00000000000080a9fd063dd4b53b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:40=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 02.09.25 18:24, Jan Kiszka wrote:
> > On 02.09.25 18:20, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 2/9/25 18:14, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 2/9/25 18:00, C=C3=A9dric Le Goater wrote:
> >>>> On 9/2/25 17:55, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> On 2/9/25 17:47, C=C3=A9dric Le Goater wrote:
> >>>>>> On 9/2/25 17:45, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>> On 2/9/25 17:43, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
> >>>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
> >>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>>>>>>
> >>>>>>>>>>> The power-of-2 rule applies to the user data area, not the
> >>>>>>>>>>> complete
> >>>>>>>>>>> block image. The latter can be concatenation of boot partitio=
n
> >>>>>>>>>>> images
> >>>>>>>>>>> and the user data.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>>>>>>>> ---
> >>>>>>>>>>>    hw/sd/sd.c | 2 +-
> >>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >>>>>>>>>>> index 8c290595f0..16aee210b4 100644
> >>>>>>>>>>> --- a/hw/sd/sd.c
> >>>>>>>>>>> +++ b/hw/sd/sd.c
> >>>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev=
,
> >>>>>>>>>>> Error
> >>>>>>>>>>> **errp)
> >>>>>>>>>>>                return;
> >>>>>>>>>>>            }
> >>>>>>>>>>>    -        blk_size =3D blk_getlength(sd->blk);
> >>>>>>>>>>> +        blk_size =3D blk_getlength(sd->blk) - sd-
> >>>>>>>>>>>> boot_part_size * 2;
> >>>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
> >>>>>>>>>>>                int64_t blk_size_aligned =3D pow2ceil(blk_size=
);
> >>>>>>>>>>>                char *blk_size_str;
> >>>>>>>>>>
> >>>>>>>>>> This seems to break the tests/functional/arm/
> >>>>>>>>>> test_aspeed_rainier.py
> >>>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
> >>>>>>>>>>
> >>>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -
> >>>>>>>>>> display none -
> >>>>>>>>>> vga none -chardev socket,id=3Dmon,fd=3D5 -mon
> >>>>>>>>>> chardev=3Dmon,mode=3Dcontrol -
> >>>>>>>>>> machine rainier-bmc -chardev socket,id=3Dconsole,fd=3D10 -seri=
al
> >>>>>>>>>> chardev:console -drive file=3D/builds/qemu-project/qemu/
> >>>>>>>>>> functional- cache/
> >>>>>>>>>> download/
> >>>>>>>>>>
> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=3Dsd,=
id=3Dsd2,index=3D2
> -net nic -net user -snapshot
> >>>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
> >>>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
> >>>>>>>>>>
> >>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Hmm, then the test was always wrong as well. I suspect the
> >>>>>>>>> aspeed is
> >>>>>>>>> enabling boot partitions by default, and the image was created
> >>>>>>>>> to pass
> >>>>>>>>> the wrong alignment check. Where / by whom is the image
> maintained?
> >>>>>>>>
> >>>>>>>> C=C3=A9dric Le Goater (Cc'ed).
> >>>>>>>>
> >>>>>>>> The test comes from:
> >>>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-
> >>>>>>>> a85f-09964268533d@kaod.org/
> >>>>>>>>
> >>>>>>>> Maybe also relevant to your suspicion:
> >>>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-
> >>>>>>>> c2bf-28950ba48ccb@kaod.org/
> >>>
> >>> [*]
> >>>
> >>>>>>>
> >>>>>>> Digging further:
> >>>>>>> https://lore.kernel.org/qemu-
> >>>>>>> devel/
> 9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
> >>>>>>>
> >>>>>>
> >>>>>> yes commit c078298301a8 might have some impact there.
> >>>>>
> >>>>> With Jan patch, your script doesn't need anymore the
> >>>>>
> >>>>>    echo "Fixing size to keep qemu happy..."
> >>>>>
> >>>>> kludge.
> >>>>
> >>>> which script ?
> >>>
> >>> The one you pasted in [*]:
> >>>
> >>> --
> >>> #!/bin/sh
> >>>
> >>> URLBASE=3Dhttps://jenkins.openbmc.org/view/latest/job/latest-master/
> >>> label=3Ddocker-builder,target=3Dwitherspoon-tacoma/lastSuccessfulBuil=
d/
> >>> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
> >>>
> >>> IMAGESIZE=3D128
> >>> OUTFILE=3Dmmc.img
> >>>
> >>> FILES=3D"u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon-
> >>> tacoma.wic.xz"
> >>>
> >>> for file in ${FILES}; do
> >>>
> >>>      if test -f ${file}; then
> >>>          echo "${file}: Already downloaded"
> >>>      else
> >>>          echo "${file}: Downloading"
> >>>          wget -nv ${URLBASE}/${file}
> >>>      fi
> >>> done
> >>>
> >>> echo
> >>>
> >>> echo "Creating empty image..."
> >>> dd status=3Dnone if=3D/dev/zero of=3D${OUTFILE} bs=3D1M count=3D${IMA=
GESIZE}
> >>> echo "Adding SPL..."
> >>> dd status=3Dnone if=3Du-boot-spl.bin of=3D${OUTFILE} conv=3Dnotrunc
> >>> echo "Adding u-boot..."
> >>> dd status=3Dnone if=3Du-boot.bin of=3D${OUTFILE} conv=3Dnotrunc bs=3D=
1K seek=3D64
> >>> echo "Adding userdata..."
> >>> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd
> >>> status=3Dprogress of=3D${OUTFILE} conv=3Dnotrunc bs=3D1M seek=3D2
> >>> echo "Fixing size to keep qemu happy..."
> >>> truncate --size 16G ${OUTFILE}
> >>>
> >>> echo "Done!"
> >>> echo
> >>> echo " qemu-system-arm -M tacoma-bmc -nographic -drive
> >>> file=3Dmmc.img,if=3Dsd,index=3D2,format=3Draw"
> >>> ---
> >>
> >> FTR the alignment check was added to shut up fuzzed CVEs in commit
> >> a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes"):
> >>
> >>     QEMU allows to create SD card with unrealistic sizes. This could
> >>     work, but some guests (at least Linux) consider sizes that are not
> >>     a power of 2 as a firmware bug and fix the card size to the next
> >>     power of 2.
> >>
> >>     While the possibility to use small SD card images has been seen as
> >>     a feature, it became a bug with CVE-2020-13253, where the guest is
> >>     able to do OOB read/write accesses past the image size end.
> >>
> >>     In a pair of commits we will fix CVE-2020-13253 as:
> >>
> >>         Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >>         occurred and no data transfer is performed.
> >>
> >>         Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >>         occurred and no data transfer is performed.
> >>
> >>         WP_VIOLATION errors are not modified: the error bit is set, we
> >>         stay in receive-data state, wait for a stop command. All furth=
er
> >>         data transfer is ignored. See the check on sd->card_status at
> >>         the beginning of sd_read_data() and sd_write_data().
> >>
> >>     While this is the correct behavior, in case QEMU create smaller SD
> >>     cards, guests still try to access past the image size end, and QEM=
U
> >>     considers this is an invalid address, thus "all further data
> >>     transfer is ignored". This is wrong and make the guest looping unt=
il
> >>     eventually timeouts.
> >>
> >>     Fix by not allowing invalid SD card sizes (suggesting the expected
> >>     size as a hint):
> >>
> >>       $ qemu-system-arm -M orangepi-pc -drive
> >> file=3Drootfs.ext2,if=3Dsd,format=3Draw
> >>       qemu-system-arm: Invalid SD card size: 60 MiB
> >>       SD card size has to be a power of 2, e.g. 64 MiB.
> >>       You can resize disk images with 'qemu-img resize <imagefile> <ne=
w-
> >> size>'
> >>       (note that this will lose data if you make the image smaller tha=
n
> >> it currently is).
> >>
> >>
> >> I expect us to be safe and able to deal with non-pow2 regions if we us=
e
> >> QEMUSGList from the "system/dma.h" API. But this is a rework nobody ha=
d
> >> time to do so far.
> >
> > We have to tell two things apart: partitions sizes on the one side and
> > backing storage sizes. The partitions sizes are (to my reading) clearly
> > defined in the spec, and the user partition (alone!) has to be power of
> > 2. The boot and RPMB partitions are multiples of 128K. The sum of them
> > all is nowhere limited to power of 2 or even only multiples of 128K.
> >
>
> Re-reading the part of the device capacity, the rules are more complex:
>  - power of two up to 2 GB
>  - multiple of 512 bytes beyond that
>

Kinda. It is power of 2 up to 2GiB, but there were a number of 4GiB cards
that were not high capacity cards that encoded their size and were otherwis=
e
low capacity cards. Qemu doesn't need to support that. Its existing capacit=
y
check should be enough.

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index da5bdd134a..18b3f93965 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2151,7 +2151,7 @@ static void sd_realize(DeviceState *dev, Error **errp=
)
         }

         blk_size =3D blk_getlength(sd->blk);
-        if (blk_size > 0 && !is_power_of_2(blk_size)) {
+        if (blk_size > 0 && (blksize < SDSC_MAX_CAPACITY &&
!is_power_of_2(blk_size)) {
             int64_t blk_size_aligned =3D pow2ceil(blk_size);
             char *blk_size_str;

is what I'm running with, but it should have a second check for 512k size
if not an ext_csd situation.

High capacity cards, though have a limitation where it's the number of 1024
sectors (which are 512 bytes), so the limit is 512k. It encodes the CSD
differently than normal capacity cards. Thankfully, we have this in our
code already.

And really high capacity cards have an extended structure the size of the
card is reported in, and that appears to be in sectors.


> So that power-of-two enforcement was and still is likely too strict.
>

Agreed.

Warner


> But I still see no indication, neither in the existing eMMC code of QEMU
> nor the spec, that the boot and RPMB partition sizes are included in that=
.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
>

--00000000000080a9fd063dd4b53b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 10:40=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemen=
s.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 02.09.25 18:24, Jan Kiszka wrote:<br>
&gt; On 02.09.25 18:20, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt; On 2/9/25 18:14, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt; On 2/9/25 18:00, C=C3=A9dric Le Goater wrote:<br>
&gt;&gt;&gt;&gt; On 9/2/25 17:55, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:47, C=C3=A9dric Le Goater wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 9/2/25 17:45, Philippe Mathieu-Daud=C3=A9 wrote=
:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:43, Philippe Mathieu-Daud=C3=A9 w=
rote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:34, Jan Kiszka wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 02.09.25 17:06, Philippe Mathieu-Da=
ud=C3=A9 wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 1/9/25 07:56, Jan Kiszka wrote:=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Jan Kiszka &lt;<a href=
=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com=
</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The power-of-2 rule applies to=
 the user data area, not the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; complete<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; block image. The latter can be=
 concatenation of boot partition<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; images<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and the user data.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Jan Kiszka &lt;=
<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siem=
ens.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Reviewed-by: Philippe Mathieu-=
Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philm=
d@linaro.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 hw/sd/sd.c | 2 +-=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 1 file changed, 1=
 insertion(+), 1 deletion(-)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/hw/sd/sd.c b/hw/s=
d/sd.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index 8c290595f0..16aee210b4 1=
00644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/hw/sd/sd.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/hw/sd/sd.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -2789,7 +2789,7 @@ static v=
oid sd_realize(DeviceState *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Error<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; **errp)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_size =3D blk_getlength(sd-&gt;blk);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 blk_size =3D blk_getlength(sd-&gt;blk) - sd-<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; boot_part_size * 2;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_size &gt; 0 &amp;&amp; !is_power_of_=
2(blk_size)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t blk_size_ali=
gned =3D pow2ceil(blk_size);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *blk_size_str;<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This seems to break the tests/func=
tional/arm/<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; test_aspeed_rainier.py<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; test due to mmc-p10bmc-20240617.qc=
ow2 size:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Command: /builds/qemu-project/qemu=
/build/qemu-system-arm -<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; display none -<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vga none -chardev socket,id=3Dmon,=
fd=3D5 -mon<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; chardev=3Dmon,mode=3Dcontrol -<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; machine rainier-bmc -chardev socke=
t,id=3Dconsole,fd=3D10 -serial<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; chardev:console -drive file=3D/bui=
lds/qemu-project/qemu/<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; functional- cache/<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; download/<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; d523fb478d2b84d5adc5658d08502bc64b=
1486955683814f89c6137518acd90b,if=3Dsd,id=3Dsd2,index=3D2 -net nic -net use=
r -snapshot<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Output: qemu-system-arm: Invalid S=
D card size: 16 GiB<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; SD card size has to be a power of =
2, e.g. 16 GiB.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://gitlab.com/qemu=
-project/qemu/-/jobs/11217561316" rel=3D"noreferrer" target=3D"_blank">http=
s://gitlab.com/qemu-project/qemu/-/jobs/11217561316</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hmm, then the test was always wrong as=
 well. I suspect the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; aspeed is<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; enabling boot partitions by default, a=
nd the image was created<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to pass<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the wrong alignment check. Where / by =
whom is the image maintained?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; C=C3=A9dric Le Goater (Cc&#39;ed).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The test comes from:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lore.kernel.org/qemu-de=
vel/4d1777d6-0195-4ecb-" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/4d1777d6-0195-4ecb-</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://a85f-09964268533d@kaod.o=
rg/" rel=3D"noreferrer" target=3D"_blank">a85f-09964268533d@kaod.org/</a><b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Maybe also relevant to your suspicion:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lore.kernel.org/qemu-de=
vel/e401d119-402e-0edd-" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/e401d119-402e-0edd-</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://c2bf-28950ba48ccb@kaod.o=
rg/" rel=3D"noreferrer" target=3D"_blank">c2bf-28950ba48ccb@kaod.org/</a><b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [*]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Digging further:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lore.kernel.org/qemu-" rel=
=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; devel/<a href=3D"http://9046a4327336d4425f1e7e=
7a973edef9e9948e80.camel@pengutronix.de/" rel=3D"noreferrer" target=3D"_bla=
nk">9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; yes commit c078298301a8 might have some impact the=
re.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; With Jan patch, your script doesn&#39;t need anymore t=
he<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 echo &quot;Fixing size to keep qemu happy=
...&quot;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; kludge.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; which script ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The one you pasted in [*]:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --=C2=A0<br>
&gt;&gt;&gt; #!/bin/sh<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; URLBASE=3D<a href=3D"https://jenkins.openbmc.org/view/latest/j=
ob/latest-master/" rel=3D"noreferrer" target=3D"_blank">https://jenkins.ope=
nbmc.org/view/latest/job/latest-master/</a><br>
&gt;&gt;&gt; label=3Ddocker-builder,target=3Dwitherspoon-tacoma/lastSuccess=
fulBuild/<br>
&gt;&gt;&gt; artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; IMAGESIZE=3D128<br>
&gt;&gt;&gt; OUTFILE=3Dmmc.img<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; FILES=3D&quot;u-boot.bin u-boot-spl.bin obmc-phosphor-image-wi=
therspoon-<br>
&gt;&gt;&gt; tacoma.wic.xz&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; for file in ${FILES}; do<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if test -f ${file}; then<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo &quot;${=
file}: Already downloaded&quot;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo &quot;${=
file}: Downloading&quot;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget -nv ${UR=
LBASE}/${file}<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi<br>
&gt;&gt;&gt; done<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; echo<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; echo &quot;Creating empty image...&quot;<br>
&gt;&gt;&gt; dd status=3Dnone if=3D/dev/zero of=3D${OUTFILE} bs=3D1M count=
=3D${IMAGESIZE}<br>
&gt;&gt;&gt; echo &quot;Adding SPL...&quot;<br>
&gt;&gt;&gt; dd status=3Dnone if=3Du-boot-spl.bin of=3D${OUTFILE} conv=3Dno=
trunc<br>
&gt;&gt;&gt; echo &quot;Adding u-boot...&quot;<br>
&gt;&gt;&gt; dd status=3Dnone if=3Du-boot.bin of=3D${OUTFILE} conv=3Dnotrun=
c bs=3D1K seek=3D64<br>
&gt;&gt;&gt; echo &quot;Adding userdata...&quot;<br>
&gt;&gt;&gt; unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd<br>
&gt;&gt;&gt; status=3Dprogress of=3D${OUTFILE} conv=3Dnotrunc bs=3D1M seek=
=3D2<br>
&gt;&gt;&gt; echo &quot;Fixing size to keep qemu happy...&quot;<br>
&gt;&gt;&gt; truncate --size 16G ${OUTFILE}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; echo &quot;Done!&quot;<br>
&gt;&gt;&gt; echo<br>
&gt;&gt;&gt; echo &quot; qemu-system-arm -M tacoma-bmc -nographic -drive<br=
>
&gt;&gt;&gt; file=3Dmmc.img,if=3Dsd,index=3D2,format=3Draw&quot;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;<br>
&gt;&gt; FTR the alignment check was added to shut up fuzzed CVEs in commit=
<br>
&gt;&gt; a9bcedd15a5 (&quot;hw/sd/sdcard: Do not allow invalid SD card size=
s&quot;):<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 QEMU allows to create SD card with unrealistic =
sizes. This could<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 work, but some guests (at least Linux) consider=
 sizes that are not<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 a power of 2 as a firmware bug and fix the card=
 size to the next<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 power of 2.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 While the possibility to use small SD card imag=
es has been seen as<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 a feature, it became a bug with CVE-2020-13253,=
 where the guest is<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 able to do OOB read/write accesses past the ima=
ge size end.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 In a pair of commits we will fix CVE-2020-13253=
 as:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Read command is rejecte=
d if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 occurred and no data tr=
ansfer is performed.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Write command is reject=
ed if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 occurred and no data tr=
ansfer is performed.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WP_VIOLATION errors are=
 not modified: the error bit is set, we<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stay in receive-data st=
ate, wait for a stop command. All further<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data transfer is ignore=
d. See the check on sd-&gt;card_status at<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the beginning of sd_rea=
d_data() and sd_write_data().<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 While this is the correct behavior, in case QEM=
U create smaller SD<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 cards, guests still try to access past the imag=
e size end, and QEMU<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 considers this is an invalid address, thus &quo=
t;all further data<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 transfer is ignored&quot;. This is wrong and ma=
ke the guest looping until<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 eventually timeouts.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Fix by not allowing invalid SD card sizes (sugg=
esting the expected<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 size as a hint):<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ qemu-system-arm -M orangepi-pc -d=
rive<br>
&gt;&gt; file=3Drootfs.ext2,if=3Dsd,format=3Draw<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-system-arm: Invalid SD card si=
ze: 60 MiB<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SD card size has to be a power of 2=
, e.g. 64 MiB.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 You can resize disk images with &#3=
9;qemu-img resize &lt;imagefile&gt; &lt;new-<br>
&gt;&gt; size&gt;&#39;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (note that this will lose data if y=
ou make the image smaller than<br>
&gt;&gt; it currently is).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I expect us to be safe and able to deal with non-pow2 regions if w=
e use<br>
&gt;&gt; QEMUSGList from the &quot;system/dma.h&quot; API. But this is a re=
work nobody had<br>
&gt;&gt; time to do so far.<br>
&gt; <br>
&gt; We have to tell two things apart: partitions sizes on the one side and=
<br>
&gt; backing storage sizes. The partitions sizes are (to my reading) clearl=
y<br>
&gt; defined in the spec, and the user partition (alone!) has to be power o=
f<br>
&gt; 2. The boot and RPMB partitions are multiples of 128K. The sum of them=
<br>
&gt; all is nowhere limited to power of 2 or even only multiples of 128K.<b=
r>
&gt; <br>
<br>
Re-reading the part of the device capacity, the rules are more complex:<br>
=C2=A0- power of two up to 2 GB<br>
=C2=A0- multiple of 512 bytes beyond that<br></blockquote><div><br></div><d=
iv>Kinda. It is power of 2 up to 2GiB, but there were a number of 4GiB card=
s</div><div>that were not high capacity cards that encoded their size and w=
ere otherwise</div><div>low capacity cards. Qemu doesn&#39;t need to suppor=
t that. Its existing capacity</div><div>check should be enough.</div><div><=
br></div><div>diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>index da5bdd134a..18b=
3f93965 100644<br>--- a/hw/sd/sd.c<br>+++ b/hw/sd/sd.c<br>@@ -2151,7 +2151,=
7 @@ static void sd_realize(DeviceState *dev, Error **errp)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_size=
 =3D blk_getlength(sd-&gt;blk);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (blk_siz=
e &gt; 0 &amp;&amp; !is_power_of_2(blk_size)) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (blk_size &gt; 0 &amp;&amp; (blksize &lt; SDSC_MAX_CAPACITY &amp;&=
amp; !is_power_of_2(blk_size)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int64_t blk_size_aligned =3D pow2ceil(blk_size);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *blk_size_str;<br></div><div><br></=
div><div>is what I&#39;m running with, but it should have a second check fo=
r 512k size if not an ext_csd situation.</div><div><br></div><div>High capa=
city cards, though have a limitation where it&#39;s the number of 1024 sect=
ors (which are 512 bytes), so the limit is 512k. It encodes the CSD differe=
ntly than normal capacity cards. Thankfully, we have this in our code alrea=
dy.</div><div><br></div><div>And really high capacity cards have an extende=
d structure the size of the card is reported in, and that appears to be in =
sectors.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
So that power-of-two enforcement was and still is likely too strict.<br></b=
lockquote><div><br></div><div>Agreed.</div><div><br></div><div>Warner</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
But I still see no indication, neither in the existing eMMC code of QEMU<br=
>
nor the spec, that the boot and RPMB partition sizes are included in that.<=
br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
<br>
</blockquote></div></div>

--00000000000080a9fd063dd4b53b--


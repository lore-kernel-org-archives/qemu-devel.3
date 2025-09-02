Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA2CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVCS-0000xh-4u; Tue, 02 Sep 2025 13:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVCP-0000sk-IY
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:53:42 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1utVC9-0002wT-EL
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:53:31 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso3591346a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1756835603; x=1757440403;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1kN3MxMt6Gfk8QNcZ1IodmWAKdC49DsWbzEq9ePgvQ=;
 b=BSL+yldNl9Pm+r3vDRhiPebrVlc9ZFftln4/ucfyN8kB0DgKTumvyBtxQ/TA+URRHI
 kyIR6llO/FM7sUzRm+tNCQVdTWFIsg4zbPE7WKlK1Ji0NzmO0fp5WErBomObryIwNfcA
 JecKCQqN+TvF9j0YRaSls8nbdhzCYFiZivTXBDZfdkGWdJE4EunipvV4H5KGrcS2x31j
 I7QREJeJWBIuxZ4KmoIF33O+XfNuprpe1l+8nHZwaKoUoj5arKw3UnsiIKIDBgyg4/5I
 n7kuvSlgdf00Xk/31HhNm8qKD94A6U+bUA73CC8Q5qiIQQ3rFWKLSLHOdZMtwfgNK+2F
 6yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756835603; x=1757440403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1kN3MxMt6Gfk8QNcZ1IodmWAKdC49DsWbzEq9ePgvQ=;
 b=QonJ3zjQ/uOr7DyBcb2ip2rPzo9NErwWvtBLDGC2WscF++d9VCLipYAv8HtP2a7gvI
 z1DLAIpvfWgIP/NQH9j2qpTQmYbuHU6jVE4zvohZIgcauTHHtpbCbi367UcFPxboZyla
 5Im6+RT0FrKdPpVEeOJUVhJiLJ20f0DlfpULWZJ25TcdEDXVb/IGW87SwGWY/t5CVA4S
 6Zsi3WhkHekqk8OZ46Hu7u8OCC4zOiJNm27NPrY+L6my8SaMXSdoEjvo8GwdlwzGVz2B
 GBTPRdd56AXG2pyGv+XPjBFZ2qcIRrjMerShUcIbiSHXjaeGXvJ0i9JSCe4eET6nRJxQ
 Q80A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr84w5FbTJlypzFeDD2v/ioVF669RHYjSgte+qlTF5oLS4XMevgp2E9H77F39tn06JtIlKuoNoNYcY@nongnu.org
X-Gm-Message-State: AOJu0Yw0mGBxT7N5TS8RYHv+pFJZ9/dbxVotx7ldVPaAfysCz/9oTTUv
 DVkH6GTL8vxjtX2leJ5qhRPmir+WeG0DfjO+b8g8PmjuT6hHQOetHjXow0qoHVLqss6lardnBif
 mDIYXZBdl+Zg+Zg8+mfmlP2ZGMFOQHfMt6ESEmk4t2w==
X-Gm-Gg: ASbGnctr2YsbOMfCda0rLh+iCI3gqakVlHIW3VFGsehuG9WeBLIuHrOSlgG9lFrIAgV
 h7m0Ov9chu1aPqGdpPW8U2QlXiWUSRtoJDPG3CMWGtK9sTv1+gkHf9nI7d7y+lfRNmUlzeOvDfA
 71+yGRgRSspmIH5g4nY7FNeU0WvNaCeQGFSEutIFrll6h3eBHOyqPch23wa5F972vEOvLneeXef
 fxdHklaGeRnzYwnPuvyt/jk5KZ/TqdQbNOPvbrKSy5ebFRQ8A==
X-Google-Smtp-Source: AGHT+IFIS1H1z6hESrWZYE153ytBnQiyEzNBIMfWdTBgVNrpU/rYUvZSuUpAwb9lROMosMoskflooItofkPYZvX2nd8=
X-Received: by 2002:a17:90b:38c5:b0:327:c207:b3fb with SMTP id
 98e67ed59e1d1-328156cc954mr14812143a91.25.1756835603220; Tue, 02 Sep 2025
 10:53:23 -0700 (PDT)
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
 <CANCZdfrTouq9JVPQqxFdKttZ0xqfgPAjMX8fLNVEf+YdLwDhtg@mail.gmail.com>
 <c84dcfe7-4938-4f5f-ae49-36f2f5f36da4@siemens.com>
In-Reply-To: <c84dcfe7-4938-4f5f-ae49-36f2f5f36da4@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Sep 2025 11:53:11 -0600
X-Gm-Features: Ac12FXy-1DXnOnvHJv-o-tto6YoM_01Iaes5Ncs0q3qzCc-PkhAyQh2DNQ_dxe0
Message-ID: <CANCZdfp0jFxjy0naVxqm=snT7Wh0VhaButgNvwFfUR6oKFcE0g@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000000f1e12063dd52a99"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52d.google.com
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

--0000000000000f1e12063dd52a99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:39=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:

> On 02.09.25 19:20, Warner Losh wrote:
> >
> >
> > On Tue, Sep 2, 2025 at 10:40=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.=
com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 02.09.25 18:24, Jan Kiszka wrote:
> >     > On 02.09.25 18:20, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >> On 2/9/25 18:14, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >>> On 2/9/25 18:00, C=C3=A9dric Le Goater wrote:
> >     >>>> On 9/2/25 17:55, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >>>>> On 2/9/25 17:47, C=C3=A9dric Le Goater wrote:
> >     >>>>>> On 9/2/25 17:45, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >>>>>>> On 2/9/25 17:43, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >>>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
> >     >>>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daud=C3=A9 wrote:
> >     >>>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
> >     >>>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>>
> >     >>>>>>>>>>>
> >     >>>>>>>>>>> The power-of-2 rule applies to the user data area, not
> the
> >     >>>>>>>>>>> complete
> >     >>>>>>>>>>> block image. The latter can be concatenation of boot
> >     partition
> >     >>>>>>>>>>> images
> >     >>>>>>>>>>> and the user data.
> >     >>>>>>>>>>>
> >     >>>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>>
> >     >>>>>>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org
> >     <mailto:philmd@linaro.org>>
> >     >>>>>>>>>>> ---
> >     >>>>>>>>>>>    hw/sd/sd.c | 2 +-
> >     >>>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >     >>>>>>>>>>>
> >     >>>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >     >>>>>>>>>>> index 8c290595f0..16aee210b4 100644
> >     >>>>>>>>>>> --- a/hw/sd/sd.c
> >     >>>>>>>>>>> +++ b/hw/sd/sd.c
> >     >>>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceStat=
e
> >     *dev,
> >     >>>>>>>>>>> Error
> >     >>>>>>>>>>> **errp)
> >     >>>>>>>>>>>                return;
> >     >>>>>>>>>>>            }
> >     >>>>>>>>>>>    -        blk_size =3D blk_getlength(sd->blk);
> >     >>>>>>>>>>> +        blk_size =3D blk_getlength(sd->blk) - sd-
> >     >>>>>>>>>>>> boot_part_size * 2;
> >     >>>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)=
)
> {
> >     >>>>>>>>>>>                int64_t blk_size_aligned =3D
> >     pow2ceil(blk_size);
> >     >>>>>>>>>>>                char *blk_size_str;
> >     >>>>>>>>>>
> >     >>>>>>>>>> This seems to break the tests/functional/arm/
> >     >>>>>>>>>> test_aspeed_rainier.py
> >     >>>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
> >     >>>>>>>>>>
> >     >>>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm=
 -
> >     >>>>>>>>>> display none -
> >     >>>>>>>>>> vga none -chardev socket,id=3Dmon,fd=3D5 -mon
> >     >>>>>>>>>> chardev=3Dmon,mode=3Dcontrol -
> >     >>>>>>>>>> machine rainier-bmc -chardev socket,id=3Dconsole,fd=3D10
> -serial
> >     >>>>>>>>>> chardev:console -drive file=3D/builds/qemu-project/qemu/
> >     >>>>>>>>>> functional- cache/
> >     >>>>>>>>>> download/
> >     >>>>>>>>>>
> >
>  d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=3Dsd=
,id=3Dsd2,index=3D2
> -net nic -net user -snapshot
> >     >>>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
> >     >>>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
> >     >>>>>>>>>>
> >     >>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
> >     <https://gitlab.com/qemu-project/qemu/-/jobs/11217561316>
> >     >>>>>>>>>>
> >     >>>>>>>>>
> >     >>>>>>>>> Hmm, then the test was always wrong as well. I suspect th=
e
> >     >>>>>>>>> aspeed is
> >     >>>>>>>>> enabling boot partitions by default, and the image was
> created
> >     >>>>>>>>> to pass
> >     >>>>>>>>> the wrong alignment check. Where / by whom is the image
> >     maintained?
> >     >>>>>>>>
> >     >>>>>>>> C=C3=A9dric Le Goater (Cc'ed).
> >     >>>>>>>>
> >     >>>>>>>> The test comes from:
> >     >>>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-
> >     <https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb->
> >     >>>>>>>> a85f-09964268533d@kaod.org/ <http://
> >     a85f-09964268533d@kaod.org/>
> >     >>>>>>>>
> >     >>>>>>>> Maybe also relevant to your suspicion:
> >     >>>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-
> >     <https://lore.kernel.org/qemu-devel/e401d119-402e-0edd->
> >     >>>>>>>> c2bf-28950ba48ccb@kaod.org/ <http://
> >     c2bf-28950ba48ccb@kaod.org/>
> >     >>>
> >     >>> [*]
> >     >>>
> >     >>>>>>>
> >     >>>>>>> Digging further:
> >     >>>>>>> https://lore.kernel.org/qemu- <https://lore.kernel.org/qemu=
-
> >
> >     >>>>>>>
> >     devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de=
/
> >     <
> http://9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/>
> >     >>>>>>>
> >     >>>>>>
> >     >>>>>> yes commit c078298301a8 might have some impact there.
> >     >>>>>
> >     >>>>> With Jan patch, your script doesn't need anymore the
> >     >>>>>
> >     >>>>>    echo "Fixing size to keep qemu happy..."
> >     >>>>>
> >     >>>>> kludge.
> >     >>>>
> >     >>>> which script ?
> >     >>>
> >     >>> The one you pasted in [*]:
> >     >>>
> >     >>> --
> >     >>> #!/bin/sh
> >     >>>
> >     >>> URLBASE=3Dhttps://jenkins.openbmc.org/view/latest/job/latest-
> >     master/ <https://jenkins.openbmc.org/view/latest/job/latest-master/=
>
> >     >>>
> label=3Ddocker-builder,target=3Dwitherspoon-tacoma/lastSuccessfulBuild/
> >     >>> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
> >     >>>
> >     >>> IMAGESIZE=3D128
> >     >>> OUTFILE=3Dmmc.img
> >     >>>
> >     >>> FILES=3D"u-boot.bin u-boot-spl.bin obmc-phosphor-image-withersp=
oon-
> >     >>> tacoma.wic.xz"
> >     >>>
> >     >>> for file in ${FILES}; do
> >     >>>
> >     >>>      if test -f ${file}; then
> >     >>>          echo "${file}: Already downloaded"
> >     >>>      else
> >     >>>          echo "${file}: Downloading"
> >     >>>          wget -nv ${URLBASE}/${file}
> >     >>>      fi
> >     >>> done
> >     >>>
> >     >>> echo
> >     >>>
> >     >>> echo "Creating empty image..."
> >     >>> dd status=3Dnone if=3D/dev/zero of=3D${OUTFILE} bs=3D1M
> count=3D${IMAGESIZE}
> >     >>> echo "Adding SPL..."
> >     >>> dd status=3Dnone if=3Du-boot-spl.bin of=3D${OUTFILE} conv=3Dnot=
runc
> >     >>> echo "Adding u-boot..."
> >     >>> dd status=3Dnone if=3Du-boot.bin of=3D${OUTFILE} conv=3Dnotrunc=
 bs=3D1K
> >     seek=3D64
> >     >>> echo "Adding userdata..."
> >     >>> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd
> >     >>> status=3Dprogress of=3D${OUTFILE} conv=3Dnotrunc bs=3D1M seek=
=3D2
> >     >>> echo "Fixing size to keep qemu happy..."
> >     >>> truncate --size 16G ${OUTFILE}
> >     >>>
> >     >>> echo "Done!"
> >     >>> echo
> >     >>> echo " qemu-system-arm -M tacoma-bmc -nographic -drive
> >     >>> file=3Dmmc.img,if=3Dsd,index=3D2,format=3Draw"
> >     >>> ---
> >     >>
> >     >> FTR the alignment check was added to shut up fuzzed CVEs in comm=
it
> >     >> a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes")=
:
> >     >>
> >     >>     QEMU allows to create SD card with unrealistic sizes. This
> could
> >     >>     work, but some guests (at least Linux) consider sizes that
> >     are not
> >     >>     a power of 2 as a firmware bug and fix the card size to the
> next
> >     >>     power of 2.
> >     >>
> >     >>     While the possibility to use small SD card images has been
> >     seen as
> >     >>     a feature, it became a bug with CVE-2020-13253, where the
> >     guest is
> >     >>     able to do OOB read/write accesses past the image size end.
> >     >>
> >     >>     In a pair of commits we will fix CVE-2020-13253 as:
> >     >>
> >     >>         Read command is rejected if BLOCK_LEN_ERROR or
> ADDRESS_ERROR
> >     >>         occurred and no data transfer is performed.
> >     >>
> >     >>         Write command is rejected if BLOCK_LEN_ERROR or
> ADDRESS_ERROR
> >     >>         occurred and no data transfer is performed.
> >     >>
> >     >>         WP_VIOLATION errors are not modified: the error bit is
> >     set, we
> >     >>         stay in receive-data state, wait for a stop command. All
> >     further
> >     >>         data transfer is ignored. See the check on
> sd->card_status at
> >     >>         the beginning of sd_read_data() and sd_write_data().
> >     >>
> >     >>     While this is the correct behavior, in case QEMU create
> >     smaller SD
> >     >>     cards, guests still try to access past the image size end,
> >     and QEMU
> >     >>     considers this is an invalid address, thus "all further data
> >     >>     transfer is ignored". This is wrong and make the guest
> >     looping until
> >     >>     eventually timeouts.
> >     >>
> >     >>     Fix by not allowing invalid SD card sizes (suggesting the
> >     expected
> >     >>     size as a hint):
> >     >>
> >     >>       $ qemu-system-arm -M orangepi-pc -drive
> >     >> file=3Drootfs.ext2,if=3Dsd,format=3Draw
> >     >>       qemu-system-arm: Invalid SD card size: 60 MiB
> >     >>       SD card size has to be a power of 2, e.g. 64 MiB.
> >     >>       You can resize disk images with 'qemu-img resize
> >     <imagefile> <new-
> >     >> size>'
> >     >>       (note that this will lose data if you make the image
> >     smaller than
> >     >> it currently is).
> >     >>
> >     >>
> >     >> I expect us to be safe and able to deal with non-pow2 regions if
> >     we use
> >     >> QEMUSGList from the "system/dma.h" API. But this is a rework
> >     nobody had
> >     >> time to do so far.
> >     >
> >     > We have to tell two things apart: partitions sizes on the one sid=
e
> and
> >     > backing storage sizes. The partitions sizes are (to my reading)
> >     clearly
> >     > defined in the spec, and the user partition (alone!) has to be
> >     power of
> >     > 2. The boot and RPMB partitions are multiples of 128K. The sum of
> them
> >     > all is nowhere limited to power of 2 or even only multiples of
> 128K.
> >     >
> >
> >     Re-reading the part of the device capacity, the rules are more
> complex:
> >      - power of two up to 2 GB
> >      - multiple of 512 bytes beyond that
> >
> >
> > Kinda. It is power of 2 up to 2GiB, but there were a number of 4GiB car=
ds
> > that were not high capacity cards that encoded their size and were
> otherwise
> > low capacity cards. Qemu doesn't need to support that. Its existing
> capacity
> > check should be enough.
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index da5bdd134a..18b3f93965 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -2151,7 +2151,7 @@ static void sd_realize(DeviceState *dev, Error
> **errp)
> >          }
> >
> >          blk_size =3D blk_getlength(sd->blk);
> > -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> > +        if (blk_size > 0 && (blksize < SDSC_MAX_CAPACITY && !
> > is_power_of_2(blk_size)) {
>
> Close but not yet correct: <=3D
>

Ah, right.


> I have a patch under test for staging that also enforces the 512-byte rul=
e.
>

Yes. But  that rule only applies to MMC cards and not SD cards which have a
512k rule since they don't have the EXT_CSD that MMC cards have. The qemu
stack supports both kinds of cards. But I've not traced through app the
ACMD support to see if we record this difference or not.

Warner


> Jan
>
> >              int64_t blk_size_aligned =3D pow2ceil(blk_size);
> >              char *blk_size_str;
> >
> > is what I'm running with, but it should have a second check for 512k
> > size if not an ext_csd situation.
> >
> > High capacity cards, though have a limitation where it's the number of
> > 1024 sectors (which are 512 bytes), so the limit is 512k. It encodes th=
e
> > CSD differently than normal capacity cards. Thankfully, we have this in
> > our code already.
> >
> > And really high capacity cards have an extended structure the size of
> > the card is reported in, and that appears to be in sectors.
> >
> >
> >     So that power-of-two enforcement was and still is likely too strict=
.
> >
> >
> > Agreed.
> >
> > Warner
> >
> >
> >     But I still see no indication, neither in the existing eMMC code of
> QEMU
> >     nor the spec, that the boot and RPMB partition sizes are included i=
n
> >     that.
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Foundational Technologies
> >     Linux Expert Center
> >
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>

--0000000000000f1e12063dd52a99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, =
2025 at 11:39=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemen=
s.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 02.09.25 19:20, Warner Losh wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Sep 2, 2025 at 10:40=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mail=
to:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank"=
>jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 02.09.25 18:24, Jan Kiszka wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On 02.09.25 18:20, Philippe Mathieu-Daud=C3=A9=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; On 2/9/25 18:14, Philippe Mathieu-Daud=C3=
=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; On 2/9/25 18:00, C=C3=A9dric Le Goater=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt; On 9/2/25 17:55, Philippe Mathieu-=
Daud=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:47, C=C3=A9dric L=
e Goater wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt; On 9/2/25 17:45, Philippe =
Mathieu-Daud=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:43, Phili=
ppe Mathieu-Daud=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/9/25 17:34, J=
an Kiszka wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 02.09.25 17=
:06, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 1/9/25 =
07:56, Jan Kiszka wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: =
Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank">=
jan.kiszka@siemens.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com=
" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The po=
wer-of-2 rule applies to the user data area, not the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; comple=
te<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; block =
image. The latter can be concatenation of boot<br>
&gt;=C2=A0 =C2=A0 =C2=A0partition<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; images=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; and th=
e user data.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed=
-off-by: Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com" target=3D=
"_blank">jan.kiszka@siemens.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com=
" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Review=
ed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org"=
 target=3D"_blank">philmd@linaro.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0 hw/sd/sd.c | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff -=
-git a/hw/sd/sd.c b/hw/sd/sd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; index =
8c290595f0..16aee210b4 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/=
hw/sd/sd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/=
hw/sd/sd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -27=
89,7 +2789,7 @@ static void sd_realize(DeviceState<br>
&gt;=C2=A0 =C2=A0 =C2=A0*dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Error<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; **errp=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_size =3D blk_getleng=
th(sd-&gt;blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_size =3D blk_getlength(sd-&gt;b=
lk) - sd-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; bo=
ot_part_size * 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_size &gt; 0 =
&amp;&amp; !is_power_of_2(blk_size)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int64_t blk_size_aligned =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0pow2ceil(blk_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 char *blk_size_str;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This seems=
 to break the tests/functional/arm/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; test_aspee=
d_rainier.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; test due t=
o mmc-p10bmc-20240617.qcow2 size:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Command: /=
builds/qemu-project/qemu/build/qemu-system-arm -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; display no=
ne -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vga none -=
chardev socket,id=3Dmon,fd=3D5 -mon<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; chardev=3D=
mon,mode=3Dcontrol -<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; machine ra=
inier-bmc -chardev socket,id=3Dconsole,fd=3D10 -serial<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; chardev:co=
nsole -drive file=3D/builds/qemu-project/qemu/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; functional=
- cache/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; download/<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c=
6137518acd90b,if=3Dsd,id=3Dsd2,index=3D2 -net nic -net user -snapshot<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Output: qe=
mu-system-arm: Invalid SD card size: 16 GiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; SD card si=
ze has to be a power of 2, e.g. 16 GiB.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D=
"https://gitlab.com/qemu-project/qemu/-/jobs/11217561316" rel=3D"noreferrer=
" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/jobs/11217561316=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.com/qemu-project/qemu=
/-/jobs/11217561316" rel=3D"noreferrer" target=3D"_blank">https://gitlab.co=
m/qemu-project/qemu/-/jobs/11217561316</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hmm, then the =
test was always wrong as well. I suspect the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; aspeed is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; enabling boot =
partitions by default, and the image was created<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to pass<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the wrong alig=
nment check. Where / by whom is the image<br>
&gt;=C2=A0 =C2=A0 =C2=A0maintained?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; C=C3=A9dric Le Goa=
ter (Cc&#39;ed).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The test comes fro=
m:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https:/=
/lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lore.kernel.org/qemu-devel/4=
d1777d6-0195-4ecb-" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-devel/4d1777d6-0195-4ecb-</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://=
a85f-09964268533d@kaod.org/" rel=3D"noreferrer" target=3D"_blank">a85f-0996=
4268533d@kaod.org/</a> &lt;http://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://a85f-09964268533d@kaod.org/" rel=
=3D"noreferrer" target=3D"_blank">a85f-09964268533d@kaod.org/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Maybe also relevan=
t to your suspicion:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https:/=
/lore.kernel.org/qemu-devel/e401d119-402e-0edd-" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/e401d119-402e-0edd-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lore.kernel.org/qemu-devel/e=
401d119-402e-0edd-" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-devel/e401d119-402e-0edd-</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://=
c2bf-28950ba48ccb@kaod.org/" rel=3D"noreferrer" target=3D"_blank">c2bf-2895=
0ba48ccb@kaod.org/</a> &lt;http://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://c2bf-28950ba48ccb@kaod.org/" rel=
=3D"noreferrer" target=3D"_blank">c2bf-28950ba48ccb@kaod.org/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; [*]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt; Digging further:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lor=
e.kernel.org/qemu-" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-</a> &lt;<a href=3D"https://lore.kernel.org/qemu-" rel=3D"norefe=
rrer" target=3D"_blank">https://lore.kernel.org/qemu-</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0devel/<a href=3D"http://9046a4327336d4425f1e7e7a973=
edef9e9948e80.camel@pengutronix.de/" rel=3D"noreferrer" target=3D"_blank">9=
046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://9046a4327336d4425f1e7e7a973ed=
ef9e9948e80.camel@pengutronix.de/" rel=3D"noreferrer" target=3D"_blank">htt=
p://9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/</a>&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;&gt; yes commit c078298301a8 mi=
ght have some impact there.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt; With Jan patch, your script do=
esn&#39;t need anymore the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 echo &quot;Fixing=
 size to keep qemu happy...&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;&gt; kludge.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;&gt; which script ?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; The one you pasted in [*]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; --=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; #!/bin/sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; URLBASE=3D<a href=3D"https://jenkins.o=
penbmc.org/view/latest/job/latest-" rel=3D"noreferrer" target=3D"_blank">ht=
tps://jenkins.openbmc.org/view/latest/job/latest-</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0master/ &lt;<a href=3D"https://jenkins.openbmc.org/=
view/latest/job/latest-master/" rel=3D"noreferrer" target=3D"_blank">https:=
//jenkins.openbmc.org/view/latest/job/latest-master/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; label=3Ddocker-builder,target=3Dwither=
spoon-tacoma/lastSuccessfulBuild/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; artifact/openbmc/build/tmp/deploy/imag=
es/witherspoon-tacoma/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; IMAGESIZE=3D128<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; OUTFILE=3Dmmc.img<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; FILES=3D&quot;u-boot.bin u-boot-spl.bi=
n obmc-phosphor-image-witherspoon-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; tacoma.wic.xz&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; for file in ${FILES}; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if test =
-f ${file}; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 echo &quot;${file}: Already downloaded&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 echo &quot;${file}: Downloading&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wget -nv ${URLBASE}/${file}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; done<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Creating empty image...&quo=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; dd status=3Dnone if=3D/dev/zero of=3D$=
{OUTFILE} bs=3D1M count=3D${IMAGESIZE}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Adding SPL...&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; dd status=3Dnone if=3Du-boot-spl.bin o=
f=3D${OUTFILE} conv=3Dnotrunc<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Adding u-boot...&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; dd status=3Dnone if=3Du-boot.bin of=3D=
${OUTFILE} conv=3Dnotrunc bs=3D1K<br>
&gt;=C2=A0 =C2=A0 =C2=A0seek=3D64<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Adding userdata...&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; unxz -c obmc-phosphor-image-witherspoo=
n-tacoma.wic.xz | dd<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; status=3Dprogress of=3D${OUTFILE} conv=
=3Dnotrunc bs=3D1M seek=3D2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Fixing size to keep qemu ha=
ppy...&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; truncate --size 16G ${OUTFILE}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot;Done!&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; echo &quot; qemu-system-arm -M tacoma-=
bmc -nographic -drive<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; file=3Dmmc.img,if=3Dsd,index=3D2,forma=
t=3Draw&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; FTR the alignment check was added to shut =
up fuzzed CVEs in commit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; a9bcedd15a5 (&quot;hw/sd/sdcard: Do not al=
low invalid SD card sizes&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 QEMU allows to create S=
D card with unrealistic sizes. This could<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 work, but some guests (=
at least Linux) consider sizes that<br>
&gt;=C2=A0 =C2=A0 =C2=A0are not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 a power of 2 as a firmw=
are bug and fix the card size to the next<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 power of 2.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 While the possibility t=
o use small SD card images has been<br>
&gt;=C2=A0 =C2=A0 =C2=A0seen as<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 a feature, it became a =
bug with CVE-2020-13253, where the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 able to do OOB read/wri=
te accesses past the image size end.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 In a pair of commits we=
 will fix CVE-2020-13253 as:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 occurred and no data transfer is performed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 occurred and no data transfer is performed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 WP_VIOLATION errors are not modified: the error bit is<br>
&gt;=C2=A0 =C2=A0 =C2=A0set, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 stay in receive-data state, wait for a stop command. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0further<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data transfer is ignored. See the check on sd-&gt;card_status at<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 the beginning of sd_read_data() and sd_write_data().<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 While this is the corre=
ct behavior, in case QEMU create<br>
&gt;=C2=A0 =C2=A0 =C2=A0smaller SD<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 cards, guests still try=
 to access past the image size end,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 considers this is an in=
valid address, thus &quot;all further data<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 transfer is ignored&quo=
t;. This is wrong and make the guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0looping until<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 eventually timeouts.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 Fix by not allowing inv=
alid SD card sizes (suggesting the<br>
&gt;=C2=A0 =C2=A0 =C2=A0expected<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0 size as a hint):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ qemu-syst=
em-arm -M orangepi-pc -drive<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; file=3Drootfs.ext2,if=3Dsd,format=3Draw<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-system=
-arm: Invalid SD card size: 60 MiB<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SD card siz=
e has to be a power of 2, e.g. 64 MiB.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 You can res=
ize disk images with &#39;qemu-img resize<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;imagefile&gt; &lt;new-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; size&gt;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (note that =
this will lose data if you make the image<br>
&gt;=C2=A0 =C2=A0 =C2=A0smaller than<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; it currently is).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; I expect us to be safe and able to deal wi=
th non-pow2 regions if<br>
&gt;=C2=A0 =C2=A0 =C2=A0we use<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; QEMUSGList from the &quot;system/dma.h&quo=
t; API. But this is a rework<br>
&gt;=C2=A0 =C2=A0 =C2=A0nobody had<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;&gt; time to do so far.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; We have to tell two things apart: partitions s=
izes on the one side and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; backing storage sizes. The partitions sizes ar=
e (to my reading)<br>
&gt;=C2=A0 =C2=A0 =C2=A0clearly<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; defined in the spec, and the user partition (a=
lone!) has to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0power of<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2. The boot and RPMB partitions are multiples =
of 128K. The sum of them<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; all is nowhere limited to power of 2 or even o=
nly multiples of 128K.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Re-reading the part of the device capacity, the rul=
es are more complex:<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0- power of two up to 2 GB<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0- multiple of 512 bytes beyond that<br>
&gt; <br>
&gt; <br>
&gt; Kinda. It is power of 2 up to 2GiB, but there were a number of 4GiB ca=
rds<br>
&gt; that were not high capacity cards that encoded their size and were oth=
erwise<br>
&gt; low capacity cards. Qemu doesn&#39;t need to support that. Its existin=
g capacity<br>
&gt; check should be enough.<br>
&gt; <br>
&gt; diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
&gt; index da5bdd134a..18b3f93965 100644<br>
&gt; --- a/hw/sd/sd.c<br>
&gt; +++ b/hw/sd/sd.c<br>
&gt; @@ -2151,7 +2151,7 @@ static void sd_realize(DeviceState *dev, Error *=
*errp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_size =3D blk_getlength(sd-&gt;bl=
k);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (blk_size &gt; 0 &amp;&amp; !is_power_=
of_2(blk_size)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (blk_size &gt; 0 &amp;&amp; (blksize &=
lt; SDSC_MAX_CAPACITY &amp;&amp; !<br>
&gt; is_power_of_2(blk_size)) {<br>
<br>
Close but not yet correct: &lt;=3D<br></blockquote><div><br></div><div>Ah, =
right.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
I have a patch under test for staging that also enforces the 512-byte rule.=
<br></blockquote><div><br></div><div>Yes. But=C2=A0 that rule only applies =
to MMC cards and not SD cards which have a 512k rule since they don&#39;t h=
ave the EXT_CSD that MMC cards have. The qemu stack supports both kinds of =
cards. But I&#39;ve not traced through app the ACMD support to see if we re=
cord this difference or not.</div><div><br></div><div>Warner</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Jan<br>
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t blk_size_align=
ed =3D pow2ceil(blk_size);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *blk_size_str;<br=
>
&gt; <br>
&gt; is what I&#39;m running with, but it should have a second check for 51=
2k<br>
&gt; size if not an ext_csd situation.<br>
&gt; <br>
&gt; High capacity cards, though have a limitation where it&#39;s the numbe=
r of<br>
&gt; 1024 sectors (which are 512 bytes), so the limit is 512k. It encodes t=
he<br>
&gt; CSD differently than normal capacity cards. Thankfully, we have this i=
n<br>
&gt; our code already.<br>
&gt; <br>
&gt; And really high capacity cards have an extended structure the size of<=
br>
&gt; the card is reported in, and that appears to be in sectors.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So that power-of-two enforcement was and still is l=
ikely too strict.<br>
&gt; <br>
&gt; <br>
&gt; Agreed.<br>
&gt; <br>
&gt; Warner<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But I still see no indication, neither in the exist=
ing eMMC code of QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0nor the spec, that the boot and RPMB partition size=
s are included in<br>
&gt;=C2=A0 =C2=A0 =C2=A0that.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Jan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A0Siemens AG, Foundational Technologies<br>
&gt;=C2=A0 =C2=A0 =C2=A0Linux Expert Center<br>
&gt; <br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</blockquote></div></div>

--0000000000000f1e12063dd52a99--


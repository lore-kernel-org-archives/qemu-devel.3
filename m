Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ACBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDl5m-0007KT-Jy; Tue, 28 Oct 2025 10:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vDl5k-0007K3-Jd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:54:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vDl5f-0006ER-L9
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:54:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso1317798066b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761663259; x=1762268059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zv1Wg3M4ugYXxbZPVU/Hzk/GcPwGPylr5HkYvP73xFY=;
 b=gFZjQQUYyld9jHmLamqKBkYzluYDQ98gViP0HmCrZC56WPVmto9wSVyFPH1c7c93vR
 G/Qnw6D7nl3k/ABT3Fs2zOhYbIQD7nN6UdFaut9XHu9qgXCE0PmRvnV06/YUX+4B01kO
 OgXxX+FlfsqywJ/we+ajuDJ8LZGOpU7vnJ6G8saaRMZRfJDBupTxyhQ5y2O/2z56UvPC
 i4HdtvR9wsSkYpRMlOSQhTnQOcU/yexs3TeHiBCGVQkO36b0o0NplLLjwNLfjaUdmbyC
 X4pbgrPrZKpfUwRQBBP8oj3dEa7y5AhEZEmjqde8K2lZQC6/FCpXHkF15hlsZGDm844p
 u5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761663259; x=1762268059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zv1Wg3M4ugYXxbZPVU/Hzk/GcPwGPylr5HkYvP73xFY=;
 b=BepPVIOpuh3gw0Py41t79WeqELj4JamOg+TpOya594LCgaDZzu3KZS7/lQOPoDibg6
 UgamRfGoF+XLGkmslrn3cHuQ7RZ6+XU8P4rEoFQScwYIUejfkj9a8aydP6oAN73IiF1I
 2oh7VNF1cURaNaQeC3N0R0HIEqjayQEIwwae7qKlucTvwczu35ou46DRHAEPQwXOAuMN
 xTI9noyBvHCAFlXwEQhJumytj7g6EEg3jpWN9EZ4V7CCHfUXD2+r6e7MwnWy3+Su6tPy
 qgsJXs9l8PY1ibIeS61S3uZ72ksvILAAixxO8xHMgui4MKJw9UYtXnQYXS5PNLUCMpEm
 150w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjs6xLw3K6xT+RotTy7fzik90ByCXDU2lDA+9n8CY4Mc9dyr0oiiVuctsAgZP/cvbS50RqoMC18gjH@nongnu.org
X-Gm-Message-State: AOJu0Yz82tRJFOyjdB7OiovIZiQU5/zlkTvZHu66h0Wq3CbiMnrNc61w
 rt8U+yj3Ewgu1zVxltrMQS942uf93fX/IvwWr4OnzR6x4tXOSsOz8OU/C3PvZuRFWu7qixZV2zh
 atHipsTiSRauP36dpeLMZWe7LAHgw8CX/a0XN1nye
X-Gm-Gg: ASbGncu7I+T4+oBNvAExjFdGci+ou/WiP6iaNkyw8JWh12CYPeXK+a+WIJ9G40xMZyr
 9YNocZ2KXAp3b91EViiWDn/7pBMxi7HZnwiTp9yVWs/umPDlFXlu/nctrDDdclCZBzKUatBH5Gp
 S3e1biqmRIZ8pIcb0ytPOxYvI9XoaJI1+aYAkG2iXdh/QEJDpOWRKLVtfrX3W/GfFMbp7IlywG/
 H2vUkcsCPB48meR7lceEdCMlwj9UOICu0zYYF7L5Hl7XkDqZ9IIuBjDhByc
X-Google-Smtp-Source: AGHT+IFZao6DoM82bfca3v7ECne0QDSbsfUEBYz1pQyvOElazADWoQPObYyZ0hLGRhuavyy25E/ArAWOQBuKDXmZ1ak=
X-Received: by 2002:a17:907:2d8d:b0:b44:7c83:cd9 with SMTP id
 a640c23a62f3a-b6dba56a547mr376023566b.40.1761663259457; Tue, 28 Oct 2025
 07:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 <87ms5cmtqh.fsf@pond.sub.org>
In-Reply-To: <87ms5cmtqh.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 28 Oct 2025 15:54:07 +0100
X-Gm-Features: AWmQ_bk15KTUh8vd1uUcrss2yBm7G9nj3eiERVINlg4PeNbNivLnX8Pswodq05U
Message-ID: <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, hreitz@redhat.com, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 27, 2025 at 1:09=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > On Fri, Oct 24, 2025 at 10:35=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >>
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>
> >> > Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
> >> >> This allows more flexibility to vvfat backend. The value for "Numbe=
r of
> >> >> Heads" and "Sectors per track" are based on SD specifications Part =
2.
> >>
> >> This is too terse to remind me of how vvfat picks cylinders, heads, an=
d
> >> sectors before this patch, so I need to go dig through the source code=
.
> >> I figure it depends on configuration parameters @floppy and @fat-type
> >> like this:
> >>
> >>     floppy  fat-type    cyls heads secs   cyls*heads*secs*512
> >>     false      12         64    16   63         31.5 MiB
> >>     false      16       1024    16   63        504   MiB
> >>     false      32       1024    16   63        504   MiB
> >>     true       12         80     2   18       1440   KiB
> >>     true       16         80     2   36       2880   KiB
> >>     true       32         80     2   36       2880   KiB
> >>
> >> How exactly does the new parameter @size change this?
> >
> > My prime goal was to create a 256 Mib VVFAT disk. As you can see,
> > today for hard-disks there are only two possibilities: 31.5 Mib or 504
> > Mib. Hence, I've introduced the option `size=3Dxxx` to allow more
> > granular choices.
> > This option changes how cyls, heads and secs parameters are computed
> > to be as closed as possible of its value.
> >
> > I did try to keep it simple. I could have introduced options to select
> > cylinders, heads, etc. But I think "size=3Dxxx" would be more intuitive=
.
> > There are also approximations made, as not all sizes can be reached. I
> > didn't add errors or warnings for them. I'm fine adding them.
>
> I don't have an opinion on whether we should support more sizes and/or
> provide full control over CHS geometry.
>
> >> >> Some limitations remains, the size parameter is recognized only whe=
n
> >> >> "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxxx=
" is
> >> >> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB f=
or
> >> >> FAT12. FAT32 has not been adjusted and thus still default to 504MB.
> >>
> >> 31.5MiB unless I'm mistaken.
> >
> > True, I will fix it.
> >
> >> I'm not sure what you're trying to convey in this paragraph.  As far a=
s
> >> I can tell, you're adding a @size parameter to vvfat, so of course it
> >> doesn't affect raw.
> >
> > Yes, but AFAICT, `if=3Dsd,format=3Draw` will result in vvfat backend be=
ing
> > called. I didn't manage to make the new option work with
> > `if=3Dsd,format=3Draw,size=3D256Mb`. Thus, when the "size" option is no=
t
> > provided, I keep the previous value (those for your above comment).
> > Hence this paragraph to mostly warn people about the current
> > limitation.
>
> Are you talking about -drive?
>
> Complete examples, please.
>
> I'm confused about the connection between SD (from if=3Dsd here, and "SD
> specification" above) and vvfat.  SD is a frontend.  vvfat is a backend.

Alright, I'll try to explain how I came up with this patch. And sorry
if it's a bit blurry, I made it some months ago hence I don't remember
all the details...
So, first, my prime goal was to access a local folder in a QNX system
running on Raspi 4B emulation.
My usual way to pass such a local folder is through `-drive
file=3Dfat:rw:<host_folder>,format=3Draw`. For virt, it's usually
connected to virtio-blk-device: `-drive id=3Ddisk0,if=3Dnone,... -device
virtio-blk-device,drive=3Ddisk0`. For the Raspi 4b, adding the
virtio-blk-device is not possible, hence I have to connect it as a SD
card: `-drive if=3Dsd,...`.

However, without any `size=3D` argument, QEMU will complain that the SD
card has not a valid size:
  | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
-nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
rootfs.cpio.gz  -drive
id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Draw,if=3Dsd
  | qemu-system-aarch64: Invalid SD card size: 504 MiB
  | SD card size has to be a power of 2, e.g. 512 MiB.
  | You can resize disk images with 'qemu-img resize <imagefile> <new-size>=
'
  | (note that this will lose data if you make the image smaller than
it currently is).

("raspi4b-kernel", the dtb and the rootfs come from
functional/aarch64/test_raspi4.py)

Hence, I've added `size=3D256M` to reduce the size of that SD card and
make QEMU happy. This allows me to mount my host folder on Linux:
  | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
-nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
rootfs.cpio.gz  -drive
id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Draw,if=3Dsd,size=3D256M
  | (QEMU) # fdisk -l /dev/mmcblk1
  | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
  | 520 cylinders, 16 heads, 63 sectors/track
  | Units: sectors of 1 * 512 =3D 512 bytes
  |
  | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
Sectors  Size Id Type
  | /dev/mmcblk1p1 *  0,1,1       1023,15,63          63    1032191
1032129  503M  6 FAT16

As you can see the "Disk" has the right size (256MB) but the partition
still has a 503M size. However, Linux doesn't seem to care too much
about that as I'm able to mount this partition, and perform IO
operations.
  | (QEMU) # mount /dev/mmcblk1p1 /mnt
  | (QEMU) # ls /mnt
  | file.txt
  | (QEMU) # cat /mnt/file.txt
  | Hello World
  | (QEMU) # echo "OK" > /mnt/test.txt
  | (host) $ cat <host_folder>/test.txt
  | OK

Now, QNX comes into play.
First, the SD card must be connected to another bus. That patch is not
part of this series as I'm considering it a QNX issue. Just FTR here
is the patch:
  | --- a/hw/arm/bcm2838_peripherals.c
  | +++ b/hw/arm/bcm2838_peripherals.c
  | @@ -190,7 +190,7 @@ static void
bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
  |          &s_base->peri_mr, GPIO_OFFSET,
  |          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
  |
  | -    object_property_add_alias(OBJECT(s), "sd-bus",
OBJECT(&s->gpio), "sd-bus");
  | +    object_property_add_alias(OBJECT(s), "sd-bus",
OBJECT(&s->emmc2), "sd-bus");
  |
  |      /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */

Afterwards, QNX is able to see the SD card, but not able to mount it.
It complains about the filesystem being corrupted. Looking at `fdisk`
output, it shows a mismatch between the "total section" value and the
Cylinders/Heads/etc values.
  | (QEMU) # fdisk /dev/hd0 info
  | Physical disk characteristics: (/dev/hd0)
  |     Disk type        : Direct Access (0)
  |     Cylinders        : 520
  |     Heads            : 16
  |     Sectors/Track    : 63
  |     Total Sectors    : 524288
  |     Block Size       : 512
  |
  | Warning: total sectors field does not agree with
  |            cylinders*sectors/track*heads!! (524288 vs 524160)

The "no-mbr" option introduced in patch 1 is something we (Adacore's
QEMU team) have for a long time. I don't remember the details but we
are using it for other OSes as well (notably RTEMS).
Once added, and the drive command line updated for `-drive
id=3Dsdcard,file=3Dfat:rw:no-mbr:<host_folder>,format=3Draw,if=3Dsd,size=3D=
256M`,
I don't have this warning anymore. Though, I'm still getting the
corrupted filesystem error.

Afterwards, it's a bit blurry but I think by trial and errors we ended
up removing the SD size error and realize that `-drive
id=3Dsdcard,file=3Dfat:rw:no-mbr:<host_folder>,format=3Draw,if=3Dsd` was
working. However, `size=3D256M` still results in a corrupted filesystem.
As a comment in vvfat.c states that it either creates a "32MB or 504
MB disk". I decided to check if I can adapt, hence this patch.

I didn't find any VFAT documentation explaining the relation between
the size and the cylinders, heads, sector per track values. However,
the SD documentation was giving some recommandations, hence I used it
as a base.

I was unable to make `vvfat.c` recognize the "size" argument passed
along `format=3Draw`, even if hardcoding the value in `vvfat.c` did make
a difference. And that's why I'm adding the warning in the commit
message.

I've also realized that following my patch, the mismatch in between
the disk and the partition in Linux was going away when using `-drive
format=3Dvvfat,size=3Dxxx`. Making it not just QNX-oriented.
  | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
-nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
rootfs.cpio.gz  -drive
id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Dvvfat,if=3Dsd,size=3D256M
  | (QEMU) # fdisk -l /dev/mmcblk1
  | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
  | 1024 cylinders, 16 heads, 32 sectors/track
  | Units: sectors of 1 * 512 =3D 512 bytes
  |
  | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
Sectors  Size Id Type
  | /dev/mmcblk1p1 *  0,1,32      1023,15,32          63     524287
 524225  255M  6 FAT16

I probably missed a few things, but I hope this is clearer to you why
and how this series was made.


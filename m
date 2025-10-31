Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64C9CCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 07:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEjqn-0008IK-Av; Fri, 31 Oct 2025 03:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEjqk-0008Hz-Ki
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEjqe-0004YS-1t
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 03:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761896814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZfLoIxuyYHqNYzLW0Sa5YCRBWDIpmXSLyIpJXEdXds=;
 b=DxDKmpqkLqqjBOAfvkhmTJdV4iJDW2I82ePv35HAUn5UmQn8lApFH+5dcVlJuRoQXmOnkG
 nDAcftdrmqVU5KqNEez3W1Y0f6lmh1aDDoiaqw15lV95a6gSJ7w5RD+B9YXyOuMpVZ15KJ
 ZxgP3eYDZS4qm927YKEXpznRAEBFKpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-cGprRRKVNleV3pI9Th_Npg-1; Fri,
 31 Oct 2025 03:46:50 -0400
X-MC-Unique: cGprRRKVNleV3pI9Th_Npg-1
X-Mimecast-MFC-AGG-ID: cGprRRKVNleV3pI9Th_Npg_1761896809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760391834525; Fri, 31 Oct 2025 07:46:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99FF7180035A; Fri, 31 Oct 2025 07:46:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB6F521E6A27; Fri, 31 Oct 2025 08:46:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 hreitz@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
In-Reply-To: <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
 (=?utf-8?Q?=22Cl=C3=A9ment?= Chigot"'s message of "Tue, 28 Oct 2025
 15:54:07 +0100")
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <87ms5g3dnq.fsf@pond.sub.org>
 <CAJ307EjFXNyEwDTeXEwdc02PxBLHGENbPJCM+-v_6FRQ2VYEcw@mail.gmail.com>
 <87ms5cmtqh.fsf@pond.sub.org>
 <CAJ307EhFGHrTYcVJZghCNgGFmXZf1vTNg2E=7AA41jFvRqtGcg@mail.gmail.com>
Date: Fri, 31 Oct 2025 08:46:45 +0100
Message-ID: <877bwbcy3e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

> On Mon, Oct 27, 2025 at 1:09=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>>
>> > On Fri, Oct 24, 2025 at 10:35=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >>
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >>
>> >> > Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
>> >> >> This allows more flexibility to vvfat backend. The value for "Numb=
er of
>> >> >> Heads" and "Sectors per track" are based on SD specifications Part=
 2.
>> >>
>> >> This is too terse to remind me of how vvfat picks cylinders, heads, a=
nd
>> >> sectors before this patch, so I need to go dig through the source cod=
e.
>> >> I figure it depends on configuration parameters @floppy and @fat-type
>> >> like this:
>> >>
>> >>     floppy  fat-type    cyls heads secs   cyls*heads*secs*512
>> >>     false      12         64    16   63         31.5 MiB
>> >>     false      16       1024    16   63        504   MiB
>> >>     false      32       1024    16   63        504   MiB
>> >>     true       12         80     2   18       1440   KiB
>> >>     true       16         80     2   36       2880   KiB
>> >>     true       32         80     2   36       2880   KiB
>> >>
>> >> How exactly does the new parameter @size change this?
>> >
>> > My prime goal was to create a 256 Mib VVFAT disk. As you can see,
>> > today for hard-disks there are only two possibilities: 31.5 Mib or 504
>> > Mib. Hence, I've introduced the option `size=3Dxxx` to allow more
>> > granular choices.
>> > This option changes how cyls, heads and secs parameters are computed
>> > to be as closed as possible of its value.
>> >
>> > I did try to keep it simple. I could have introduced options to select
>> > cylinders, heads, etc. But I think "size=3Dxxx" would be more intuitiv=
e.
>> > There are also approximations made, as not all sizes can be reached. I
>> > didn't add errors or warnings for them. I'm fine adding them.
>>
>> I don't have an opinion on whether we should support more sizes and/or
>> provide full control over CHS geometry.
>>
>> >> >> Some limitations remains, the size parameter is recognized only wh=
en
>> >> >> "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxx=
x" is
>> >> >> keeping the previously hardcoded value: 504MB for FAT16 and 32 MB =
for
>> >> >> FAT12. FAT32 has not been adjusted and thus still default to 504MB.
>> >>
>> >> 31.5MiB unless I'm mistaken.
>> >
>> > True, I will fix it.
>> >
>> >> I'm not sure what you're trying to convey in this paragraph.  As far =
as
>> >> I can tell, you're adding a @size parameter to vvfat, so of course it
>> >> doesn't affect raw.
>> >
>> > Yes, but AFAICT, `if=3Dsd,format=3Draw` will result in vvfat backend b=
eing
>> > called. I didn't manage to make the new option work with
>> > `if=3Dsd,format=3Draw,size=3D256Mb`. Thus, when the "size" option is n=
ot
>> > provided, I keep the previous value (those for your above comment).
>> > Hence this paragraph to mostly warn people about the current
>> > limitation.
>>
>> Are you talking about -drive?
>>
>> Complete examples, please.
>>
>> I'm confused about the connection between SD (from if=3Dsd here, and "SD
>> specification" above) and vvfat.  SD is a frontend.  vvfat is a backend.
>
> Alright, I'll try to explain how I came up with this patch. And sorry
> if it's a bit blurry, I made it some months ago hence I don't remember
> all the details...
> So, first, my prime goal was to access a local folder in a QNX system
> running on Raspi 4B emulation.
> My usual way to pass such a local folder is through `-drive
> file=3Dfat:rw:<host_folder>,format=3Draw`. For virt, it's usually
> connected to virtio-blk-device: `-drive id=3Ddisk0,if=3Dnone,... -device
> virtio-blk-device,drive=3Ddisk0`. For the Raspi 4b, adding the
> virtio-blk-device is not possible, hence I have to connect it as a SD
> card: `-drive if=3Dsd,...`.
>
> However, without any `size=3D` argument, QEMU will complain that the SD
> card has not a valid size:
>   | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
> -nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
> console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
> rootfs.cpio.gz  -drive
> id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Draw,if=3Dsd
>   | qemu-system-aarch64: Invalid SD card size: 504 MiB
>   | SD card size has to be a power of 2, e.g. 512 MiB.
>   | You can resize disk images with 'qemu-img resize <imagefile> <new-siz=
e>'
>   | (note that this will lose data if you make the image smaller than
> it currently is).

Fun!

> ("raspi4b-kernel", the dtb and the rootfs come from
> functional/aarch64/test_raspi4.py)
>
> Hence, I've added `size=3D256M` to reduce the size of that SD card and
> make QEMU happy. This allows me to mount my host folder on Linux:
>   | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
> -nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
> console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
> rootfs.cpio.gz  -drive
> id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Draw,if=3Dsd,size=3D256M
>   | (QEMU) # fdisk -l /dev/mmcblk1
>   | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
>   | 520 cylinders, 16 heads, 63 sectors/track
>   | Units: sectors of 1 * 512 =3D 512 bytes

520 * 16 * 63 is 524160 sectors, 128 less than the 524288 reported.  I
figure that's harmless.  Only ancient software should look at CHS, and
losing a few sectors with ancient software is fine.

>   |
>   | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
> Sectors  Size Id Type
>   | /dev/mmcblk1p1 *  0,1,1       1023,15,63          63    1032191
> 1032129  503M  6 FAT16
>
> As you can see the "Disk" has the right size (256MB) but the partition
> still has a 503M size.

The partition table's EndLBA is 1032191 even though the disk has only
524288 cylinders.  Scary!

Its EndCHS is consistent with its EndLBA: 1024*16*63 =3D 1032191 + 1.

>                        However, Linux doesn't seem to care too much
> about that as I'm able to mount this partition, and perform IO
> operations.
>   | (QEMU) # mount /dev/mmcblk1p1 /mnt
>   | (QEMU) # ls /mnt
>   | file.txt
>   | (QEMU) # cat /mnt/file.txt
>   | Hello World
>   | (QEMU) # echo "OK" > /mnt/test.txt
>   | (host) $ cat <host_folder>/test.txt
>   | OK

Have you tried with a host folder containing more than 256MiB?  What
happens if you try to read all of it?

> Now, QNX comes into play.
> First, the SD card must be connected to another bus. That patch is not
> part of this series as I'm considering it a QNX issue. Just FTR here
> is the patch:
>   | --- a/hw/arm/bcm2838_peripherals.c
>   | +++ b/hw/arm/bcm2838_peripherals.c
>   | @@ -190,7 +190,7 @@ static void
> bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>   |          &s_base->peri_mr, GPIO_OFFSET,
>   |          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
>   |
>   | -    object_property_add_alias(OBJECT(s), "sd-bus",
> OBJECT(&s->gpio), "sd-bus");
>   | +    object_property_add_alias(OBJECT(s), "sd-bus",
> OBJECT(&s->emmc2), "sd-bus");
>   |
>   |      /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
>
> Afterwards, QNX is able to see the SD card, but not able to mount it.
> It complains about the filesystem being corrupted. Looking at `fdisk`
> output, it shows a mismatch between the "total section" value and the
> Cylinders/Heads/etc values.
>   | (QEMU) # fdisk /dev/hd0 info
>   | Physical disk characteristics: (/dev/hd0)
>   |     Disk type        : Direct Access (0)
>   |     Cylinders        : 520
>   |     Heads            : 16
>   |     Sectors/Track    : 63
>   |     Total Sectors    : 524288
>   |     Block Size       : 512
>   |
>   | Warning: total sectors field does not agree with
>   |            cylinders*sectors/track*heads!! (524288 vs 524160)

I'm not sure this mismatch causes the problem.  I suspect the bogus
EndLBA does.

> The "no-mbr" option introduced in patch 1 is something we (Adacore's
> QEMU team) have for a long time. I don't remember the details but we
> are using it for other OSes as well (notably RTEMS).

Suppressing MBR initialization avoids the partially bogus partition
table.

But if we create a partition table, it better make sense, don't you
think?

> Once added, and the drive command line updated for `-drive
> id=3Dsdcard,file=3Dfat:rw:no-mbr:<host_folder>,format=3Draw,if=3Dsd,size=
=3D256M`,
> I don't have this warning anymore. Though, I'm still getting the
> corrupted filesystem error.
>
> Afterwards, it's a bit blurry but I think by trial and errors we ended
> up removing the SD size error and realize that `-drive
> id=3Dsdcard,file=3Dfat:rw:no-mbr:<host_folder>,format=3Draw,if=3Dsd` was
> working. However, `size=3D256M` still results in a corrupted filesystem.
> As a comment in vvfat.c states that it either creates a "32MB or 504
> MB disk". I decided to check if I can adapt, hence this patch.
>
> I didn't find any VFAT documentation explaining the relation between
> the size and the cylinders, heads, sector per track values. However,
> the SD documentation was giving some recommandations, hence I used it
> as a base.
>
> I was unable to make `vvfat.c` recognize the "size" argument passed
> along `format=3Draw`, even if hardcoding the value in `vvfat.c` did make
> a difference. And that's why I'm adding the warning in the commit
> message.

This one:

    Some limitations remains, the size parameter is recognized only when
    "format=3Dvvfat" is passed. In particular, "format=3Draw,size=3Dxxx" is
    keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
    FAT12. FAT32 has not been adjusted and thus still default to 504MB.

> I've also realized that following my patch, the mismatch in between
> the disk and the partition in Linux was going away when using `-drive
> format=3Dvvfat,size=3Dxxx`. Making it not just QNX-oriented.
>   | (host) $ qemu-system-aarch64 -M raspi4b -kernel raspi4b-kernel
> -nographic -no-reboot -append "earlycon=3Dpl011,mmio32,0xfe201000
> console=3DttyAMA0 noreboot" -dtb bcm2711-rpi-4-b.dtb -initrd
> rootfs.cpio.gz  -drive
> id=3Dsdcard,file=3Dfat:rw:<host_folder>,format=3Dvvfat,if=3Dsd,size=3D256M
>   | (QEMU) # fdisk -l /dev/mmcblk1
>   | Disk /dev/mmcblk1: 256 MB, 268435456 bytes, 524288 sectors
>   | 1024 cylinders, 16 heads, 32 sectors/track
>   | Units: sectors of 1 * 512 =3D 512 bytes
>   |
>   | Device       Boot StartCHS    EndCHS        StartLBA     EndLBA
> Sectors  Size Id Type
>   | /dev/mmcblk1p1 *  0,1,32      1023,15,32          63     524287
>  524225  255M  6 FAT16

EndLBA matches disk size.  EndCHS still matches EndLBA.  Good.

The difference to the command line you showed above is format=3Draw (bad)
vs. format=3Dvvfat (good).

With format=3Draw,size=3D256M you get that size, but a bogus partition
table.

With format=3Dvvfat,size=3D256M you get that size, and a sensible partition
table.

Correct?

> I probably missed a few things, but I hope this is clearer to you why
> and how this series was made.



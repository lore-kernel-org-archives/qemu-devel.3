Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F79C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGUm-00019s-TZ; Thu, 02 Jul 2026 08:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfGUk-00017g-ED; Thu, 02 Jul 2026 08:26:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfGUi-0001b8-3r; Thu, 02 Jul 2026 08:26:17 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7D8E59672D;
 Thu, 02 Jul 2026 14:26:13 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id igmPXltyCeus; Thu,  2 Jul 2026 14:26:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2890E59672E; Thu, 02 Jul 2026 14:26:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2718559672C;
 Thu, 02 Jul 2026 14:26:11 +0200 (CEST)
Date: Thu, 2 Jul 2026 14:26:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Matt Jacobson <mhjacobson@me.com>
cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/5] hw/m68k: add working floppy controller for q800
In-Reply-To: <20260702022927.46510-1-mhjacobson@me.com>
Message-ID: <49d36fa3-da19-d723-7d05-794bf5d07dbb@eik.bme.hu>
References: <20260702022927.46510-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 1 Jul 2026, Matt Jacobson wrote:
> Implement the SWIM2 floppy controller and SuperDrive for the q800 machine.
>
> Reading and writing work, and booting a system disk works.
> Both GCR and MFM paths work.
> Tested with the Quadra 800 ROM running System 7 and A/UX 3.x.
> Whole-disk formatting/duplication does not yet work.
>
> Example usage:
> $ qemu-system-m68k \
>   -machine q800 \
>   -m 128 \
>   -bios "Quadra800.ROM" \
>   -nodefaults \
>   -drive if=mtd,file="pram.img",format=raw \
>   -drive if=floppy \
>   -drive if=floppy \
>   -drive if=scsi,media=disk,file="harddisk.img",format=raw \
>   -drive if=scsi,media=cdrom \
>   -nic user,model=dp83932 \
>   -audio none \
>   -display cocoa \
>   -name "Macintosh Quadra 800"
>
> (To populate the floppy drive at boot, use
> `-drive if=floppy,file="floppy.img",format=raw`.  However, note that the
> Macintosh ROM will eject non-bootable floppies on boot.)
>
> The Sony drive emulator takes raw images and will generate the GCR/MFM
> encoding on the fly.  Here are a couple sample images (HFS) to play with:
>
> <https://mjacobson.net/files/mac-disks/floppy-800.img>
> <https://mjacobson.net/files/mac-disks/floppy-1440.img>

Including a changelog about what's new in v3 here helps reviewers to 
remember what this version is about.

Regards,
BALATON Zoltan

> Matt Jacobson (5):
>  hw/block: add Sony/Apple "SuperDrive" diskette drive
>  fifo32: add fifo32_peek()
>  hw/block: add SWIM2 floppy controller for q800
>  hw/m68k: add working floppy controller for q800
>  hw/block: remove unused SWIM1 floppy controller stub
>
> MAINTAINERS                        |    2 -
> hw/block/meson.build               |    2 +-
> hw/block/sony_superdrive.c         | 1032 ++++++++++++++++++++++++++++
> hw/block/swim.c                    |  577 ----------------
> hw/block/swim2.c                   |  711 +++++++++++++++++++
> hw/block/trace-events              |   25 +-
> hw/m68k/q800.c                     |    5 +-
> hw/misc/mac_via.c                  |   16 +
> include/hw/block/sony_superdrive.h |   55 ++
> include/hw/block/swim.h            |   72 --
> include/hw/block/swim2.h           |   58 ++
> include/hw/m68k/q800.h             |    4 +-
> include/hw/misc/mac_via.h          |    3 +
> include/qemu/fifo32.h              |   31 +-
> 14 files changed, 1923 insertions(+), 670 deletions(-)
> create mode 100644 hw/block/sony_superdrive.c
> delete mode 100644 hw/block/swim.c
> create mode 100644 hw/block/swim2.c
> create mode 100644 include/hw/block/sony_superdrive.h
> delete mode 100644 include/hw/block/swim.h
> create mode 100644 include/hw/block/swim2.h
>
>


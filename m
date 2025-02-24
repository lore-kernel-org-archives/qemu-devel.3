Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E512C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 05:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmQyN-0000hi-NB; Mon, 24 Feb 2025 00:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQnX-0007pt-MV; Mon, 24 Feb 2025 00:14:31 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQnV-0006d8-R5; Mon, 24 Feb 2025 00:14:31 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4bdb423b971so1177892137.2; 
 Sun, 23 Feb 2025 21:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740374067; x=1740978867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A69i7VvcTTO+7ehkke80wkSGQ6qqqtZdm98NN1wdjdY=;
 b=LwbybJ3y5jynPrmT9LBxsr+3hJP9ni1/fbDG1kOjl0KHuJz2SQBgirZNneBirRsh0a
 638vy4Gk0pHbP1uetHvXTaBmVwrK6l43yMe+4GTPpTxdwfYWzHYVt9k7kFPzW6+6hLMb
 Nfz1UyNcGXEERHGepBaU72+Sqq787HnC1sDHgeaWbDFWR1g22ShCDfv6y+l1fJbu5I7s
 mxUO6mAB6mgb09N30xQojSRs+6PyEonBjq0eld6BN+3mVSNdCVZghssvB0qQ6bajcleO
 vhs3mDD2cHKTcvhbO2hbUrdOTHezybq22JbkvazGCnFkZkYgo4fU5/G/lXV6ZExEA925
 zO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740374067; x=1740978867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A69i7VvcTTO+7ehkke80wkSGQ6qqqtZdm98NN1wdjdY=;
 b=hTqkZy3LODP0PIeZNQO37kkbSIuQdOLj3jKNd5zYenPJmvZzu/7hRZbRqBZbw3UXbo
 J6zBLcYe05ciXLFq7EQn0txPTpEz1vR2wo7fE8paPglYVIj0j1IDafAeUBXic0yZVGup
 B9r53y4EQsVUzDi65AM6+F+WjcHU6nLhjxEJwk5uevWdchaZs1u3jA22rSnXIgGY+rRt
 hdVI8U+bp94JMNAafPa4/JR8J7DmQip55BRVxFZZOP9delpq5mq1zWle6o0Wuzvn00gI
 Ve9jT07xfzLmP+4ViSsYlBs4NYDAVa9iwL0XjR8yHXD/0HXdsDuH9UZ9mXf2eKBiHmq/
 neRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIrAAy1a5d3jbHS54KRUi2i0EEOtdSfS4nMe1FqSaxegdgS9PN4BLV8sipvbV0joHoo7sRs65lzHwsFA==@nongnu.org,
 AJvYcCXICAsdxiH17DiOBwhB8wxhy33wZxmvw2IDR7GTRo2x11xRWCYq+wSlyYIjiMWI+xl78Rm2cmv6h8pZ@nongnu.org
X-Gm-Message-State: AOJu0YwOS8orATKAHM214uE9NJG26yYQTgakMfvSKXG4NTXRyhwAdrbL
 sovhuLC33Os26NoofeBn6dtgHFGod232MCcpMKR4xI1dLRLv8g7eaY6BxHDVzrKpjIdISOhzDtn
 gt1Mx8Bs8aE3Xa2UXmanwo66IlJ8=
X-Gm-Gg: ASbGncu57P+i7pXALV/nhGDnbHPBiNXavWwBTNP5vo05/SHXinmT5pxfLkUYP2yEAug
 6d/SY6TMqVJMqT9+CR8+MLUK+RcL4LZToPusmEuGnA27EIC8Vno6wT6BcG+Qh/3p6yCYSQ0jhyG
 xg9kaV3B3CdXfd2yvkDCUgdi40UbJz2Sdr0Sre
X-Google-Smtp-Source: AGHT+IGuDxEonNmw1hmJjnYWIOdU7195mw84JLHY1eV7Ju+URBWlkre3kfojBy5Adq7ualji6nnkIvEiTYkguqt8Nkw=
X-Received: by 2002:a05:6102:4b18:b0:4bb:c0a7:39b8 with SMTP id
 ada2fe7eead31-4bfc022708fmr6116037137.17.1740374067140; Sun, 23 Feb 2025
 21:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250220-reggae-hardness-907e385516d8@spud>
In-Reply-To: <20250220-reggae-hardness-907e385516d8@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 15:14:00 +1000
X-Gm-Features: AWEUYZlAb2LXUi9ehUHDn8C9xhjRaogHo7sWUQILq5TJI_nY77i8tsgSmjC4WHU
Message-ID: <CAKmqyKNex8vQuT3ArR3gePfGfeLCZbW0DxzD9dz8oNAODE8sbw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
To: Conor Dooley <conor@kernel.org>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org,
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Feb 21, 2025 at 4:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> +cc qemu-riscv, Alistar.
>
> On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
> > Booting the microchip-icicle-kit machine using the latest PolarFire SoC
> > Hart Software Services (HSS) no longer works since Qemu lacks support
> > for several registers (clocks, DRAM controller). Also reading from the
> > SDCard does not work currently.
>
> On that note, I think the inaccurate docs about polarfire should be
> removed. There's a wiki page here with dead links, or links to things
> that do not work anymore:
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_S=
oC_Icicle_Kit
> I think the whole section should be removed, find it kinda odd that
> there's a polarfire section but not for any other board. Either way,
> it's talking about something that just does not work, the current HSS
> and Yocto don't boot.

The wiki is independent of the QEMU code base, so you can modify it. I
agree that we should remove outdated/wrong information as it's very
confusing to users.

>
> There's also a docs page here:
> https://www.qemu.org/docs/master/system/riscv/microchip-icicle-kit.html

That is generated from the QEMU codebase
`docs/system/riscv/microchip-icicle-kit.rst` and should be updated,
ideally with this patch set

> that has a copy of the table your patch 4 modifies, that probably should
> be updated to match your changes.
>
> In a similar vein to the wiki, it talks about the HSS and booting a
> yocto wic image. I think those should be deleted since they don't work.

Agreed

Alistair

>
> Alistar/Other RISC-V folks, what do you think? Bin wrote the port but
> seems to be AFK and I don't have the capacity to fix any of that stuff
> on top of what I already do in my spare time - do you agree that
> deleting the now inaccurate docs makes sense?
>
> > In order to allow tests runs for real-time kernels such as RTEMS and
> > Zephyr, improve the boot customization. This patch set enables a direct
> > run of kernel executables, for example:
> >
> > qemu-system-riscv64 -no-reboot -nographic \
> >   -serial null -serial mon:stdio \
> >   -smp 2 \
> >   -bios none \
> >   -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000 \
> >   -kernel rtos.elf
>
> The series breaks my usage:
> qemu//build/qemu-system-riscv64 -M microchip-icicle-kit \
>         -m 3G -smp 5 \
>         -kernel vmlinux.bin \
>         -dtb riscvpc.dtb \
>         -initrd initramfs.cpio.gz \
>         -display none -serial null \
>         -serial mon:stdio \
>         -D qemu.log -d unimp
> opensbi-riscv64-generic-fw_dynamic.bin: No such file or directory
> qemu-system-riscv64: could not load firmware 'opensbi-riscv64-generic-fw_=
dynamic.bin'
> make: *** [Makefile:305: qemu-icicle] Error 1
>
> Figure it is likely to be your patch 4? The file does exist, so probably
> some sort of path-to-it issues?
>
> Cheers,
> Conor.
>
> >
> > Sebastian Huber (5):
> >   hw/misc: Add MPFS system reset support
> >   hw/riscv: More flexible FDT placement for MPFS
> >   hw/riscv: Make FDT optional for MPFS
> >   hw/riscv: Allow direct start of kernel for MPFS
> >   hw/riscv: Configurable MPFS CLINT timebase freq
> >
> >  hw/misc/mchp_pfsoc_sysreg.c        |   7 ++
> >  hw/riscv/microchip_pfsoc.c         | 147 +++++++++++++++++++++--------
> >  include/hw/riscv/microchip_pfsoc.h |   1 +
> >  3 files changed, 115 insertions(+), 40 deletions(-)
> >
> > --
> > 2.43.0
> >
> >


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88500C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJX-0007K0-8l; Thu, 16 Jul 2026 10:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wkNIj-0006c0-CD
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:43:08 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wkNIb-0007hO-KH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:58 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8114a4542b2so7209977b3.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212970; cv=none;
 d=google.com; s=arc-20260327;
 b=lm53CKH7k8vtmSsGN8afvR0upHFOwSCWCqalOFSXkoNVVlDGKKgRpYvbhmQumTFNND
 NDnTKEnOqS+aGmLxL92DpuImQuxiC7QpB4xNjC+lJzNGgB+d2o0qYEIx4f8jnX0P3k/W
 87iw02yzpKeAo+p6QyITTannLw2kpmlTDefx3R0dJ62h/DpN/5HITiGagfjNH82maMMk
 H1eidqSft5vp8+rBMOPrgeumjLfBVToQz0s+rbAj9EKfVOc2nM5iqcZr364TJ4gLbwZW
 fVqXh53AJeo/1wF8rhYO+LOgF6c0jsy16VGHsMHG2iQNDBkTPzKqK0wuOc6ZfkzTE4Jv
 uv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0OXNv10CN64tbF4/e8/7EUE/YNaxUQhCo5JttJ30MMI=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=dUHPNoGNju2+z0Fte9IKmwj8QoxqsDVcMffd3GBDl+Xzrzrl++XwbnqkdQRePtTKCu
 8mkzV+xqk2y7sXSYbzrev95IAJQbqiakZqAo3O2CTGzTJMFhNW+fiqJzUijG39rvHQT2
 cc3VNwcYUVriP6cUL78OIBfOrtUj0ijVX5lLa4rRniTj2cwUhpcXxzHDnpK7Mx6THbjj
 BPgaQLv61fJMhEBhRH13F9cTpGS1yTB0y+Utp8RFJgtNaTWH34FM8UXyuy3u89tYsVmn
 3CzqJbJKXMMcjNTgMqDiJ/J1rtW/g4j7wBmFdw89wawZNCS+kJpgnyPCK61zMCStIfyv
 vXjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212970; x=1784817770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0OXNv10CN64tbF4/e8/7EUE/YNaxUQhCo5JttJ30MMI=;
 b=SB6BbtO3rBtnkF3DMQQSshN6uJQLEeP4/O/+B9ov93m4DNpl/sx5n3vxxRycnPfViy
 wT0MmaxEeOefcB29DgOiBagv6IA0OXv9IlMEp+VIsuJ/Xngwcib3NadtGp2Q08rbrHrE
 7+EtP/pupMrn+2NniWE+zlWm9IY0fNuU6SKDPrxZVUgtm5kTBPNQEJkjq1nyk2vo827z
 l9ixuXAL3Y8N9Pt3MNcjUeO/mdl2QxDgERbjUyYghOYrEBdgqlXyfuHzQNEOgc2ojhAg
 NFDVpTn1HvFqVOSCuoodSvg7PdJ6kyg90aofppuPSoNPQn8MQw+REU1U8adf8njnNESy
 jALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212970; x=1784817770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0OXNv10CN64tbF4/e8/7EUE/YNaxUQhCo5JttJ30MMI=;
 b=HwnLVEDPV/b2hhnKv1i0aUf5rgCbjfTqMwM9F3PCUWerWWmQnEL/tFg8qJGVXXoxcz
 xeeHoxQIrKD0AXyTkwTZyIETHaHzBTUS5Fd2XNPDH6El/ZRHr9FGziKBjh0HasMn2PVs
 zGsYiIxbHQHnrOCGkXktk7yGfcN5GzuzyaDvBRJhUrrItr0voxpuJbxbnVijxlQBTQi6
 g3GyDOpE5mVcJ+ac74Pp0SSdXQNQ5c+XId/VP9e2qYCvkxV2b0FWej07BhxaIP+0fihy
 cWEheKR3HoBDoYnaNBBhFF2bg0fEoJo27hPKrx8U++gk3mQcwkbwDDF/Qntmcnhv71u9
 9DeQ==
X-Gm-Message-State: AOJu0YyyWUt28rH8N+nS893VFn8tdoALfoopBlFxM98TBmrwt5c8/KAj
 38G1QRDXei/ELw+SSsCI27+B/RIOvaIWYaXgs4x4Ltzyb4w4OezHOXvX/5vdRd8im7z05Aq22d3
 wYk0LGp0XzdpFIDZZft9d9vE/uBYY2UY=
X-Gm-Gg: AfdE7clZmTwuHpsupkCxlSCyRFtiabj402m3YQmlPvU7LHA0SeS6cx22Q8oLicIjHJC
 Hs/96kn0np36RQk2gfOiQ9Npv0NOULwh0xGGVXNr8J9y0pvSCXH9HyuOCKyd9AQj7WDsOqNdqS1
 fRQRxCPa5GaI9dEg27IjPB24fNCzSRIkOWE5VBdeQmN3q+xZVaIbp6Y6dbDvXZOv5NnOuaX3mTb
 XwMKHzHMlDDZ160hBjOxSec6l1pp4lL3StQNZzP4DtGPT+8bDWRdQVCzJ89
X-Received: by 2002:a05:690c:6e82:b0:81e:a3a0:701b with SMTP id
 00721157ae682-81ecf78127dmr55073787b3.9.1784212970579; Thu, 16 Jul 2026
 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260715160731.29969-1-dingtao0430@163.com>
 <20260715160731.29969-2-dingtao0430@163.com>
In-Reply-To: <20260715160731.29969-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 16 Jul 2026 22:42:39 +0800
X-Gm-Features: AUfX_mwOEXLYyD2aMwMcDLa2F66caNhKvZMbng2BK39OrS0dbSWad0e-FbDTo40
Message-ID: <CAEUhbmX65ObC0Q+0xz_CZRntn8A0nyR_AhgJJhi6tqB+Q3d5nA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 16, 2026 at 12:08=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
te:
>
> During SDMA transfers, the controller raises an interrupt at buffer bound=
aries
> to request a system address update. The host driver will rewrite the SDHC=
_SYSAD register.
> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.=
pdf section 2.2.1)
> However, the current code will ignore write operations to SDHC_SYSAD.
>
> To fix this bug, when SDMA encounters a boundary, a state is set to recor=
d it.
> In this state, SDHC_SYSAD can be written. In other cases, it is still pro=
tected by TRANSFERRING_DATA.
>
> Meanwhile, a subsection has been added for migration.
>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> This bug may be encountered when using uboot with SDMA functionality, and=
 can be reproduced by following the steps below.
> Uboot test:
>     1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (=
MMC_SDHCI_SDMA=3Dy).
>         for more detail, can obtained
>         "https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingtao=
0430@163.com/T/#mcdf231e6bd762903f8393bf93253cbcb12ececcf"
>     2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=3Dsd -m=
 1024 -display none -serial null -serial stdio -monitor none \
>         -device loader,file=3Du-boot-dtb.bin,addr=3D0x04000000,cpu-num=3D=
0  \
>         -drive file=3Dzynq-sd.img,format=3Draw,if=3Dsd -D qemu.log
>
>
> After applying the fix, success load sd card:
>
> U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)
>
> Model: Xilinx ZC702 board
> DRAM:  ECC disabled 1 GiB
> Core:  33 devices, 21 uclasses, devicetree: board
> Flash: 0 Bytes
> NAND:  0 MiB
> MMC:   mmc@e0100000: 0
> Loading Environment from FAT... *** Error - No Valid Environment Area fou=
nd
> *** Warning - bad env area, using default environment
>
> In:    serial@e0001000
> Out:   serial@e0001000
> Err:   serial@e0001000
> Net:
> ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id
>
> Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a4:=
d3:6b
> eth0: ethernet@e000b000
> Hit any key to stop autoboot: 0
> Zynq> fatload mmc 0 ${kernel_addr_r} zImage
> 10838528 bytes read in 4316 ms (2.4 MiB/s)
> Zynq> fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
> 406531 bytes read in 199 ms (1.9 MiB/s)
> Zynq> setenv ramdisk_size ${filesize}
> Zynq> fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
> 15754 bytes read in 21 ms (732.4 KiB/s)
> Zynq> setenv bootargs console=3DttyPS0,115200 earlycon ignore_loglevel rd=
init=3D/init
> Zynq> bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr=
_r}
> Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
> ## Flattened Device Tree blob at 01f00000
>    Booting using the fdt blob at 0x1f00000
> Working FDT set to 1f00000
>    Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
>    Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
> Working FDT set to 2ff95000
>
> Starting kernel ...
>
>  hw/sd/sdhci.c         | 54 ++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/sd/sdhci.h |  2 ++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151F3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 05:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weQr3-0005gj-OG; Tue, 30 Jun 2026 01:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1weQqx-0005fI-Vy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 01:17:49 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1weQqt-0007ny-KK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 01:17:46 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664db84f074so1757802d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 22:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782796662; cv=none;
 d=google.com; s=arc-20260327;
 b=fzhJRBf3hXaJxFBEZmuU8fX7h4kvp8L/dLmvrUMchk4MF1tOsLgk7dZ2gv+jRJsZ0u
 aCQ7sW4ilyYWdxwuv8rubfdiVnkZ/8bCIsu3HCBYCsDP1TfUxgnxDlQADL8f9pkvPeQe
 +ftfa/4bLZ+PwT8+usBFeaBABcyhInTwr3FaZcBUlEVJEYUoARlipqllw0jXphZKZkpA
 JZg3lV/E0LnCpiUKBns1fL7DaqpRNePeZi5ajoeg6E1rP1EDLGM8pBKRkp2K3Lm31Sz7
 nLGmoCYW40jk6fKAFjzD4aH85vHIvHN1BUAMI/Avmj/8QeDwxsdE3MREG7TDzXuihfiq
 gEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BVTF+Ub9rlHpqD3pivcOnwoBRq9ruG7byLVLRbeZ24g=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=AZXRO7cL2dQJ2hdrPHeughJ+0KvKSnjX3tcNvNVujZtyCOfupBjJ6pIFdTWGlgvNHW
 OENLZzBlPAH6wpbMndkSW8iWe12rs4fo+SD/Mm0R2XM/Krc4tge/DCaYpitiU90inLOP
 meT9ktuu3nxLlVfA7LLEU8ppQ7im9qy9PFHRwW7rmZaVKTR2YzWod6DWvzBBhFzIUuHg
 RmiS+M6MJCLBdolQgEUSt6EeC9I9BvstdAsv28MmA85XDV7iItrRM2i2wlfyrpF3/Ooa
 ayFX/VzY5tKhrFMZ9TmOtt2JKD9ZgAOMOwMzwQYy7OZ+OAzutTzQvJ7dS3184HPmRiaW
 I08w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782796662; x=1783401462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVTF+Ub9rlHpqD3pivcOnwoBRq9ruG7byLVLRbeZ24g=;
 b=X/Y4fWsPbpPilvRNcs5VRbN+UhIaJL6s01DA5ooxgCVxFMNHkWYXswIrQnjoRhoP57
 E1729lMvOxKSA5KZ8Tbpe+I50oouHKjudAK4UAYtMB/L0xiSY3T4/a87Uq1lrfHYIUSG
 uihR9xJQS4orOT5oCwzaHGc8jCiog/VmTi48+kr+jA8O6wpBuv0y84no/WyuN7QSy54K
 +gy2dBw/UEyABd4PFgX7bHdXkS6G7I7OAedAZXs38chjlFpv0zFaHU5caLugGpAih5yK
 Ev/uzW2F31EV+XIRbDTSi8PV8zXt2XKYFPjAPf4Z+ofmlZuHV9yI51Y8aJda0AMULQSA
 uQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782796662; x=1783401462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BVTF+Ub9rlHpqD3pivcOnwoBRq9ruG7byLVLRbeZ24g=;
 b=SgJeGhxUB3C1AMs0805u/XIKlLmRSNZyuCN6mFzeIVjgoXIN4K71jvKVqkAQpBNHR2
 VYw8Tqv0UDCygH4ILLj27BfUXi8vALvF49P/iqLUXMDbiMgEB6hD7b/HanRnMHQMQbxU
 9D4TIe9nFMXnaFcaatFtYLGKNUwuC8VKWFFMoD2DQl0fl08fI7qQvfANr6Qns9jyzuLe
 G+KP6A0QICOaukB8H7ZwVO5uqw3BlkQrNrYd1mOUS1Fo15o4xHOGkrRoDECat103BXlX
 MIKkQS8Sn40LxejFnPnHApJ90SOIjOPIryTMM6uDFjTwnv+0jZzbPiH4GLCHcX+pbcKJ
 rDOQ==
X-Gm-Message-State: AOJu0YzU8E3+0yGFzTBQcY3oDLtLReQe3v9aWPuGCPTMlN0WimdsuMpz
 cgKxQAUtyK+AkqOAzxyyiylKD9S2AAqshSWRDMomhgQVIk1DOBHgyPAWtqqgTfe7VGhdTsBEqnv
 9Yp+ozSb4hKdWtUvXjlgxxkdw/cwb6gU=
X-Gm-Gg: AfdE7cmsb6uN3y89BAwR5K31RYTJ8hvZ7HmiD449lMCFTTBLQyQP4SNBQrjpiS1TXtB
 5MxclqxYz6+AExOz+vsQLSFgXFTTojcuQ/XqMZZiixGe1+7eqwl4YqB+7S9xpmO589Ko1OhXKsz
 tvk24ikxdfJy2iU3rZS7Yhc4hqHlPL3p1mXqBhnYZ85rMwHfQ15eV1FvWgaTF2c83Kq42V8/iIy
 qChvd8mr8ABbej5NbPvnkbtPnu3dgDUUNffcxpgzvsP3VyLJPNOrzLprME+chUiYRTSVTjM
X-Received: by 2002:a05:690e:4810:b0:664:7a6c:17c2 with SMTP id
 956f58d0204a3-664f9a33c67mr1672262d50.39.1782796662090; Mon, 29 Jun 2026
 22:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260629164533.42956-1-dingtao0430@163.com>
 <20260629164533.42956-2-dingtao0430@163.com>
In-Reply-To: <20260629164533.42956-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 30 Jun 2026 13:17:30 +0800
X-Gm-Features: AVVi8CfHefAlW_jXuKSHymbdXuaSx75H2VtVTr1V7Pwjx8F8zvxqR4DKUY9lNJc
Message-ID: <CAEUhbmXTe73LZFnG5MUGjkpXWaF7gn694cEsHfHsd6+TXfKe7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fixed sdma boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 30, 2026 at 12:46=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
te:
>
> During SDMA transfers, the controller raises an interrupt at buffer bound=
aries
> to request a system address update. But the emulation fails to clear the
> SDHC_DOING_READ/WRITE flags after DMA completion, so writes to SDHC_SYSAD=
 are
> ignored. Clear these flags when the transfer ends.
> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.=
pdf section 2.2.1)
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>

The commit summary should be something like:

hw/sd: sdhci: Fix SDMA boundary bug

> ---
> Uboot test:
>     1. Prepare zImage, U-Boot, and rootfs.cpio.gz, and make sure
>      the U-Boot configuration enables MMC_SDHCI_SDMA.
>      More details can be found at:
>      https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingtao0430=
@163.com/T/#mcdf231e6bd762903f8393bf93253cbcb12ececcf
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
>  hw/sd/sdhci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f..0d87289ca4 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -644,6 +644,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  s->data_count =3D 0;
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->prnsts &=3D ~SDHC_DOING_READ;
>                  break;
>              }
>          }
> @@ -669,6 +670,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  }
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->prnsts &=3D ~SDHC_DOING_WRITE;
>                  break;
>              }
>          }
> --

I reconsidered this, and now think we should keep these bits on here.
This is because BLKSIZE/BLKCNT register is also protected by
!TRANSFERRING_DATA(prnsts) and if we clear the bits, that will
accidentally allow overwriting LKSIZE/BLKCNT settings during a paused
SDMA transfer due to boundary hit, which is definitely not we want.
Even normal guest drivers won't do such things, QEMU shouldn't expose
such a possibility to the guest.

Instead we should add another state to indicate that SDMA transfer is
paused due to hitting the boundary and only with such state can we
write the SYSAD register.

Regards,
Bin


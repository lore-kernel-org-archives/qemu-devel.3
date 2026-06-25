Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E7CCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsli-0003W4-BI; Thu, 25 Jun 2026 18:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcslg-0003Vh-T1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:41:56 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wcslf-0004EG-0p
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:41:56 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-662c360aa73so422305d50.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782427314; cv=none;
 d=google.com; s=arc-20260327;
 b=HQhnPE4SihqaaqOkG2WjUgpg9gwxuNoA34/9AePiLflfPZIfW5BQe++AqTyUPnXIqq
 mkiL+KHi45N4kQhDKEaekzIyWFoBLQFu3Cd/Ix2QA6CEcgrZgOtaNFJwWG5u0mRTSluw
 flEj2A+Tg9U/QSW0elQpdbIRcSGtGDZR19Woj/hHfWsp+7irxhF7Uo7nMUevc/mowEAF
 wLP26vzEyZvcQ8FxKeOyogUPHHYQrgZpoP/CYBOni5U/BnnuC1Dbd+kI9P/fEP3CFPtQ
 eOrLr0RE7/mBTOeSqicETXNFmyjt36V63twE9Pj4ZwESvPCByCzwgZtl/QFX0fiZODh7
 L/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rOaDFJEnxQBazw0f8pswD1hRNZjvne7Cou16zAZh0po=;
 fh=gvDt/l0NjtJ7j6fPXI/3OX6LFkyzsAIAGRoWta4PwBc=;
 b=BxIiSldpmEtoufUisu6KN5xwppjjR5y4VWddzTLZf4KLvB+9a0/kQDxx8TEuLfna5b
 q73EZjVL7mZdBxiDYVRa5ebdirYsInJ7cX6j75Ziy8tQMOG1OGsacjdxiU8jlSggB4WN
 u7vUbNzrUq8Jh11L8kChTKE9Osvf1wcc5UBtNzS2j3fycWCxl+X4rfRDMZkCYlIDU7jh
 IuV0xllxC3uT0AFSeLN6LTaqgaNkDG2NcdjtZStp/0Yc5pLKSNVY8MxChG1IKhjRiyMd
 AMr+T6cBx+zanPKrn4uXXINHXXbCss+WqQq4JBcgi4jtdqDB3ObcR8Ff+Zpn8ldN3Q9R
 +Gfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782427314; x=1783032114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOaDFJEnxQBazw0f8pswD1hRNZjvne7Cou16zAZh0po=;
 b=RKeNLz6ygYjBjSqf0Bd4CnmGCtDUliWgDDENbFg3gszXQIAPbjKz12348zxVdXrs4H
 i/Iq/Pj82IGnFEC91XSxL4VSOcmpVLXKXHxgFngcMGCn6tV/2S64XI3h21T7As/EOymr
 Beb7xsaNKUbVQRW7hYNUzuC0Q+DcWctn47UaQTNIQet6pLFHDu2Zx3+tXqE/11H/b4ol
 RmKZW0/0p+Vka1a8y8Q3MvLeyNzhuoH2W1Z/KXfAh0KQwjgHOLje6swcWugUyeEsmuiM
 oypfWqU13okorAIjgu3ezgp5f4q/fqG9ao60MtSQG+lSIFS3bHyF2kHSZOX3woz1eBaP
 K5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782427314; x=1783032114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rOaDFJEnxQBazw0f8pswD1hRNZjvne7Cou16zAZh0po=;
 b=VfgCW5wWUgFtn5uVAgLdFe8EHYZnO0U3RCAlqYlELlAi4kgkkNVuztW+45mDQ9ZRXU
 Xr8NA9BiAcpIysoyH3GH3i59NxJ1/knz9lY1aiSfIfDrmElgN93TCMdkqiCv36N8pplu
 dvtXRcemZZYe/annfuafth9kszUPeOHtHzq/AGCTKLQCzqgORAYO/vb3DwNFo1QCe6vy
 o2GKGmiZpq8c0P3Y+sZ9CxmacFObTlWPASyYu+1QQvWOICs19TV7RYoYIDMDFXgkTqHT
 rYfs1OjLgrrfLNNjYeedm6hMjBS/lwFwo8ely6WRNCj4lnBJ6PR2KUly36LHvFIrK8IM
 9sHQ==
X-Gm-Message-State: AOJu0YzuTk15+9Kxk1Da6TzKnEeOe9y6O/ZW/I9rD4toKXxx7JGbQWie
 9MIikbT78P+5+5HLFFpbAjXWH7hWdZxlC9eRd8gOgWkCu5k0uYVKpmB3+naXzpQPIwFdbSG6ibo
 yjDCbp1WsUKl9nOsG/V6rtBl8+OIqOg4=
X-Gm-Gg: AfdE7cmn1x28Dhm2Cufn4jcq/idFyxb6bm/sV3hZeWCBwa9/55GU4efJwNncIf4KfFG
 /AEaTQi4SOk0HoP57BnaMcG8iqXco1WptoCVBbwQVErXS0CrpbNibSUCa4RMgzhpXZ4oh0qXjOq
 mjdmC2KNg+GluHfXjarAniIsN4k6Wod3dYdqorR09+hYMu+ATFnlZAF8QF3uKOLc13uxogSgX9S
 6Ip6Tlqu61FEGbCN1igQUAxSVi/OPaoybr03wRmwWXdEKQGKh6VU2uKw1vzCcFz0sd5WYgoliG0
 /SEH2x8jqzY=
X-Received: by 2002:a05:690e:12c4:b0:664:8f11:6f32 with SMTP id
 956f58d0204a3-6648f118f48mr2999256d50.48.1782427313640; Thu, 25 Jun 2026
 15:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260617155857.7451-1-dingtao0430@163.com>
 <20260617155857.7451-2-dingtao0430@163.com>
In-Reply-To: <20260617155857.7451-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 26 Jun 2026 06:41:41 +0800
X-Gm-Features: AVVi8CcrVoPA9v8jRCgRbubFAwkXLXdMgQrv51TJIw1Jf2uZvmSoJz3qB0J3Iuw
Message-ID: <CAEUhbmVPJ_cAUQbTo0C_4swXUmL-DV0OwR6ZcMhgCUhXAP0QEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fixed sdma boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb129.google.com
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

On Thu, Jun 18, 2026 at 12:01=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
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
> This is a QTest in npcm7xx_sdhci-test that exercises this boundary condit=
ion and
> validates the fix.
>
> QTest steps:
>   1. Replace npcm7xx_sdhci-test.c with the updated version (full code
>      available at: https://pastebin.com/AWVp2wFi).
>   2. Build with:
>        ../configure --target-list=3D"arm-softmmu,aarch64-softmmu" \
>                     --disable-slirp --enable-debug --disable-werror
>        ninja qemu-system-arm tests/qtest/npcm7xx_sdhci-test
>   3. Run the specific test case:
>        QTEST_QEMU_BINARY=3D./qemu-system-arm \
>          ./tests/qtest/npcm7xx_sdhci-test \
>          -p /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue
>
> Before the fix, the test fails with a BLKCNT assertion:
>   ERROR:...wait_for_block_count: assertion failed (qtest_readw(...) =3D=
=3D expected): (1 =3D=3D 0)
>
> After applying the fix, the test passes:
>   ok 1 /arm/npcm7xx_sdhci/read_sd_sdma_boundary_continue
>
> The new test case ensures the SDMA boundary handling works correctly and
> prevents future regressions.
>
>
> Uboot test:

U-Boot

>     1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (=
MMC_SDHCI_SDMA=3Dy).

Please specify which U-Boot defconfig you used for testing and how
zynq-sd.img was generated.

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
>
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
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

Regards,
Bin


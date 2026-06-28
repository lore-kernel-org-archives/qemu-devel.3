Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5469CC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 12:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdoNn-0008Ps-9x; Sun, 28 Jun 2026 08:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdoNH-0008F4-OW
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 08:12:36 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdoNF-0001le-NO
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 08:12:35 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664b3831a20so1502890d50.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 05:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782648752; cv=none;
 d=google.com; s=arc-20260327;
 b=DcgZCeXID85iJpanOc+MUN4UEqk1f7stjOpEgjLfgz958CD1N1rUe4vh05lnOZ+j4o
 m3GTu7FcoBqoqg0EoXHwySNrmDL0MjvKt/Xgd5C10Da0grEcF1HIBouJzE3s5xuUzpeu
 J1DSG2C6NYTCDPC+Sc0koyvyISnk8zgeJQHeFzb1twxVZdiQr6d6xaUf47jK2gvJAtvx
 HI8abf8MY8v7JxtYYQ9k0z+hQTJnst2a8y6xOB+w8vYouXMHx41arZJZRRX4xC1RSixD
 IOq92hWZh2EaPiQ1xB5f1jQIWOq22RX6Y+Us5rp6veR2XnYNBFxX0Ke6Sxt6ONgFgVYs
 BFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f6oCWPCyRjWCk/GzzmEPJ4gdzxTyxuN0j8f2E2jT2d0=;
 fh=gvDt/l0NjtJ7j6fPXI/3OX6LFkyzsAIAGRoWta4PwBc=;
 b=ELSbbt1mw/otKu4N/sDQf/OJhCdmZl982bQq7z8u9L2bd3RH7XN8T5E1qlpwUvlfLq
 pMKz1YwjhoTB7CWFsPYgCjLxaRnBlYKB+72GMP25IVh7akuoOevEEeka0Xi0m5p7UvK8
 Z7iWHpVELp6uzMgaNLa1TMtgdvNWHX/tkAsFR9oinAgnO0+ZO2wieANA1ixExMWTmNkf
 e7RC+ordHyTAROXo/WhKgrJg0TurRkYYny2kbLLaE/iioN+2QdWEcLIvrsB4FExhkT26
 VMIkGsMAUqT2pd84JewmZSFseKYlv9X+2b0Q4BAXmr1wS+raVsUdF7gGrF30bVCCcyA1
 LoNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782648752; x=1783253552; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6oCWPCyRjWCk/GzzmEPJ4gdzxTyxuN0j8f2E2jT2d0=;
 b=J6C9NEjgTcUO9TYtrjdpFelzJhSj4ugmXwhaWs82FHhwR0cHdpQaKom7hkX/yGp+9c
 OuNl1lALtY2SkctY18c2HzZcHYIcPwUSuyC3e/IM4cBKsdvA6XHeSZC0ifKZUgy74u61
 FcnA4UewQdLr+Qry4InJ12ZhmVENNb92Bnhclt71Pe76kHW9yDoyqQz0WI4qPnM3F262
 WJER4hOy6lfDV1ZOUtYzzwESglmJPVsyyrxyVAiZf+IyFql2Xm4tyoOGthQ8PyIPRf6a
 x5F6Rrf+CxdyTZ3OJgPXUbJpY37uXLaIZWdwQPfiG/YC+0J6jiQNXF6gyaZfyWXvd6F3
 l7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782648752; x=1783253552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f6oCWPCyRjWCk/GzzmEPJ4gdzxTyxuN0j8f2E2jT2d0=;
 b=UHV6aaZuXz2ATVsqxsQrn9QXmM5bd2B+dDdaKdlD7otRMX0/DBCsXR0WLEb066Eq8Y
 HJcPs2bRx36U4uzv/pkLCMesNUgkOvyg5o9YoJyzvLuKoXVXrCVyk7A6PpPU3Ve0Cz07
 7UwqyyZunjNSWbhA2pT1HVPim4Yc2JiycqNCkUFzTH1p+USMNJqvC2b6SwUJINi1WSFU
 Mc7yWIphdjkVI3/bj1IkRJLf5DmHdWK9jat8YwLRQSP5nmbMMN92NQk+2+Ll7L9Jji0Q
 VMdk5J73qZzQcLJDRj9zStEqCj2CnI6oxIqA6MkJrK/rYwXBjqnDGlWtIfLB84R1xyJ6
 ufLw==
X-Gm-Message-State: AOJu0Yz9Bwhwq9lvX3Nu8P0xssKyKOabCTFL9LJojC11Vz9J5Wg9sDUP
 LNJlAY4VUJSF95N66bawv6U+KbE4stLhQaEQ3X9XUjXC7Tklb9CFRoeNlcDu9SEPR1q2SBIBmXP
 Isx8U0Avl+pC9qNSR02TtNugYMZ0afEo=
X-Gm-Gg: AfdE7cmxHD2311RwiHe9rAJemBWURcSSlFZJBfmzZXXwHlP8kfpm02+yQbFRXb6wsPO
 9CTdyzOwsQLjJYx2bPDgVs2+jHYx32eemddJ0rN0D22TbNYk51yO/rF3q0PbAJ76PE5hjWfj3e5
 kqNPs9fjXQsHX5pf+t0cbveP6k3288RuRuqNnWbC/4vPZOOmB7qvG+YkQbRh2C0wKRREF2n9hm0
 0V+bnVaveS4+aibigRfZZD8hgvRug7+ftqhfbjkhtJ8UlRQJiEUCgj4LT30lN6iJ+dS2ZHqm4MG
X-Received: by 2002:a05:690e:134a:b0:664:9b83:300a with SMTP id
 956f58d0204a3-6649b833635mr8202728d50.27.1782648752059; Sun, 28 Jun 2026
 05:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260617155857.7451-1-dingtao0430@163.com>
 <20260617155857.7451-2-dingtao0430@163.com>
In-Reply-To: <20260617155857.7451-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 28 Jun 2026 20:12:20 +0800
X-Gm-Features: AVVi8CfXLUnSFy93jascvNnjUnYr7uuGsE93z-GDJbADT6HJ7Lv-MOeCPY_ILy4
Message-ID: <CAEUhbmVGrfD8WndBXNFJhZK3iVug-TXiQ3uQK6PvE0+z_wqqhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fixed sdma boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12d.google.com
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

The commit message could end here, and the following can be put below
--- so that they don't go into the commit message while it could still
provide useful information for people to understand the issue.

> This is a QTest in npcm7xx_sdhci-test that exercises this boundary condit=
ion and
> validates the fix.
>
> QTest steps:
>   1. Replace npcm7xx_sdhci-test.c with the updated version (full code
>      available at: https://pastebin.com/AWVp2wFi).

Please post a qtest patch instead.

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
>     1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (=
MMC_SDHCI_SDMA=3Dy).
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

Overall this patch LGTM.

Regards,
Bin


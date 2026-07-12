Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E62C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiuyv-0007sw-QX; Sun, 12 Jul 2026 10:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wiuyt-0007sD-U5
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:16:31 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wiuyr-0000D5-OJ
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:16:31 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664cdeab266so3704406d50.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 07:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783865788; cv=none;
 d=google.com; s=arc-20260327;
 b=qfJ+/3VMKh1XLetb5+GdkHZY3v45auW4vWowJ5HjxZkZihNBVTD36v3W74iIsV5KdV
 EtdNMF9RIPuivRIxiVHkZBwgwF6oo3KroW2Ef3ZTPKZAp6G53pgvWzM7l+zUAUem1pQp
 WGYR6WCNBrhfpkNztjkvqtm9ZjrQvbbBKAjeasK0BcimX1Ey0qYzgdBaJIr93My5+k2J
 wQezF3H1MizfH8XUcue00Tc7TLmvt6DW4buNPwoHlj6ZyOLtMZk01zPV7FEGb08vdSCT
 539OuECS5FyA5o/iLYnoGnaKuhEQ9sdlncNbPHryUrALk0doVRZgoe4lLmvhOb5oWD+B
 e2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wk0xlH/ukr0omBAS1oPZkfx7QlVDNCg1cc09vb9wvRA=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=cP+i800UxeXFzuFrBnuQsJDkwxW4xLP7h6OfItIaJPyK5NDRKsQiuYhEMcEeGCsaUc
 BjOwgx8V7iifYNu0k4+Rr1RS0qhAgbfdAfMd3Mb6PVbpJAnN9fTwfhruQOZgtd9tP5+w
 Nv/4Kj7q/XLGfci8ikH7tty3qOWC44rLn0xrBTeHVPRl5HcqIvrF9UQtf6sHeKe1akdz
 hQIH4ZQEi+hCARvUhq12Er+oeIuWpEHdJRRlDI3L8/J87+DamT4/DTVzbO1KtUVpatIs
 3CdW4YYIgTUjTbuyNv8Cyufqhev+3CFqLPLlf8zpJBEXv/kM30VIKh4Tsz/kkYhCRnf9
 K4mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783865788; x=1784470588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wk0xlH/ukr0omBAS1oPZkfx7QlVDNCg1cc09vb9wvRA=;
 b=g/eeHig9NdJbZxYcoW6zQqLvTAG5BCwuzUlmvdPcVTc/XT9ZK5YgFOzGP6opYLiLT7
 Vq9d1e6fSI+fdH1gfWFA2PXdFFYUTEfwk36mmWsGrCnFAs6jGicp3ejO1DvOwArMtMXG
 9Tn5Z+RmVJu4lq7LdzzHEHsFpJ4OXgk/lZFmEHKsE0/GrhAzTLT7cfNlTrSNQ3PAoTeK
 i7Kcf0XgshPwbTE/dPY2Gzm0m5sewTWTVt1ZLa/PZubCmwLQfVpOjmOBr9XW9PoUdCsB
 8lzT/SrWK80GTlXdq+y4Dl2Jga/9rR96AEFzmtUrT5B7CVhJ8uToN/ethMwt1R/taeJV
 pvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783865788; x=1784470588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wk0xlH/ukr0omBAS1oPZkfx7QlVDNCg1cc09vb9wvRA=;
 b=dDWuVaNycbcnDjZ/LfATFJMcXUpsIwxHHdGDd72cp3rJM7pQ94yeMcibq37cGShhof
 vmpXW78h13EauAGaNEKDzQ7cPEpUuRvr7MG+pw/42ltJNyBzuWSI1ZoyXQvBVkWznaRY
 nkjCZPBvdUyUGLF2H1/lZhSooNiYg4LURiHCzzY6Cc+2/0gJxXrvtSRY5I7VP1z8RHV2
 S16ADMEJ/ZiAJJql2ffp5PUxffO3br3X8ZQ4yfRdaZLvm//+4/RpsQIzc26fblaD5JYw
 inH1uSdR3T/yt1ypkhGltEm0Q84bRjW48bsxmf6Gz0go0BUcmmiMrXO5BGs+TbC6HJN+
 FM0w==
X-Gm-Message-State: AOJu0YxmseJf9acDKE04+yz0IUDb0aZR48b4UTochAfWIqL9iydC1yod
 POApGnEvzP25Xj6gfB1TLHUw5fThE1Y+3TWT/SF11aepEEoeqQzjcw8HZf7r+6jWeyB7G4uwUWp
 /v2xOriIX8iGBVsNYnNJSXKRiqO75iHw=
X-Gm-Gg: AfdE7cnnJiVdcHew3A9nOqsKnsfFf1A8DOSqimrugx46A1RHWpTV8FYpgnCIQcsO+sJ
 U2Etqb1klzWgDlQkBe3pXriU1TEmF949I6WrHoG3bQI/7VX4dsPUtW4oZE+SR1RHtt6KbO17HX4
 83eeX9iWpzmwKoT2VUSEn+RwKshXJeX0Y9bEC7B6bdjR94fI9d4L075VVO0Dv4HPag4xb6+CLJS
 z+pUNuWaAtiQ9iLuVFq/2D5MfXcY5F6p0uiiTsZpOERMo0RAFgxAdql+Bg0i8UcrvMpSmLH
X-Received: by 2002:a05:690e:e0b:b0:667:bdcb:c5d5 with SMTP id
 956f58d0204a3-667d7c49099mr2757708d50.62.1783865788381; Sun, 12 Jul 2026
 07:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260707170457.11659-1-dingtao0430@163.com>
 <20260707170457.11659-2-dingtao0430@163.com>
 <CAEUhbmVHOaFK0jwsE2XVG-ofyu7SeF6LkwAbXNFoYVokDu1ADA@mail.gmail.com>
In-Reply-To: <CAEUhbmVHOaFK0jwsE2XVG-ofyu7SeF6LkwAbXNFoYVokDu1ADA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 12 Jul 2026 22:16:16 +0800
X-Gm-Features: AVVi8CcM67eso67pk2qjYtIUGO40InEyc6BxYjAk5EFADDrXmW_rFsmUbsJieL4
Message-ID: <CAEUhbmXJaqRUFmqDHFsXr9QJTfeC7f733Po_MbmmQ6Ru9Qb4_w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Sun, Jul 12, 2026 at 9:38=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> On Wed, Jul 8, 2026 at 1:05=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
te:
> >
> > During SDMA transfers, the controller raises an interrupt at buffer bou=
ndaries
> > to request a system address update. The host driver will rewrite the SD=
HC_SYSAD register.
> > (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.0=
0.pdf section 2.2.1)
> > However, the current code will ignore write operations to SDHC_SYSAD.
> >
> > To fix this bug, when SDMA encounters a boundary, a state is set to rec=
ord it.
> > In this state, SDHC_SYSAD can be written. In other cases, it is still p=
rotected by TRANSFERRING_DATA.
> >
> > Version_id change to 2 for migration.
> >
> > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > Signed-off-by: Tao Ding <dingtao0430@163.com>
> > ---
> > The reviewer pointed out an issue in patch v3. When s->blkcnt decreases=
 to 1 the logic goes to
> > sdhci_sdma_transfer_single_block() where s->sdma_boundary_paused should=
 be cleared too.
> >
> > This bug may be encountered when using uboot with SDMA functionality, a=
nd can be reproduced by following the steps below.
> > Uboot test:
> >     1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config=
 (MMC_SDHCI_SDMA=3Dy).
> >         for more detail, can obtained
> >         "https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingt=
ao0430@163.com/T/#mcdf231e6bd762903f8393bf93253cbcb12ececcf"
> >     2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=3Dsd =
-m 1024 -display none -serial null -serial stdio -monitor none \
> >         -device loader,file=3Du-boot-dtb.bin,addr=3D0x04000000,cpu-num=
=3D0  \
> >         -drive file=3Dzynq-sd.img,format=3Draw,if=3Dsd -D qemu.log
> >
> >
> > After applying the fix, success load sd card:
> >
> > U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)
> >
> > Model: Xilinx ZC702 board
> > DRAM:  ECC disabled 1 GiB
> > Core:  33 devices, 21 uclasses, devicetree: board
> > Flash: 0 Bytes
> > NAND:  0 MiB
> > MMC:   mmc@e0100000: 0
> > Loading Environment from FAT... *** Error - No Valid Environment Area f=
ound
> > *** Warning - bad env area, using default environment
> >
> > In:    serial@e0001000
> > Out:   serial@e0001000
> > Err:   serial@e0001000
> > Net:
> > ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id
> >
> > Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a=
4:d3:6b
> > eth0: ethernet@e000b000
> > Hit any key to stop autoboot: 0
> > Zynq> fatload mmc 0 ${kernel_addr_r} zImage
> > 10838528 bytes read in 4316 ms (2.4 MiB/s)
> > Zynq> fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
> > 406531 bytes read in 199 ms (1.9 MiB/s)
> > Zynq> setenv ramdisk_size ${filesize}
> > Zynq> fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
> > 15754 bytes read in 21 ms (732.4 KiB/s)
> > Zynq> setenv bootargs console=3DttyPS0,115200 earlycon ignore_loglevel =
rdinit=3D/init
> > Zynq> bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_ad=
dr_r}
> > Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
> > ## Flattened Device Tree blob at 01f00000
> >    Booting using the fdt blob at 0x1f00000
> > Working FDT set to 1f00000
> >    Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
> >    Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
> > Working FDT set to 2ff95000
> >
> > Starting kernel ...
> >
> >  hw/sd/sdhci.c         | 14 +++++++++++---
> >  include/hw/sd/sdhci.h |  2 ++
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index c86dfa281f..dc774fdf21 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -307,6 +307,7 @@ static void sdhci_reset(SDHCIState *s)
> >      s->data_count =3D 0;
> >      s->stopped_state =3D sdhc_not_stopped;
> >      s->pending_insert_state =3D false;
> > +    s->sdma_boundary_paused =3D false;
> >      if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
> >              object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
> >          s->norintstsen =3D 0x013f;
> > @@ -620,6 +621,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >      }
> >
> >      s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
> > +    s->sdma_boundary_paused =3D false;
> >      if (s->trnmod & SDHC_TRNS_READ) {
> >          s->prnsts |=3D SDHC_DOING_READ;
> >          while (s->blkcnt) {
> > @@ -644,6 +646,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >                  s->data_count =3D 0;
> >              }
> >              if (page_aligned && boundary_count =3D=3D 0) {
> > +                s->sdma_boundary_paused =3D true;
> >                  break;
> >              }
> >          }
> > @@ -669,6 +672,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >                  }
> >              }
> >              if (page_aligned && boundary_count =3D=3D 0) {
> > +                s->sdma_boundary_paused =3D true;
> >                  break;
> >              }
> >          }
> > @@ -679,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >      }
> >
> >      if (s->blkcnt =3D=3D 0) {
> > +        s->sdma_boundary_paused =3D false;
> >          sdhci_end_transfer(s);
> >      } else {
> >          sdhci_update_irq(s);
> > @@ -690,6 +695,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIS=
tate *s)
> >  {
> >      uint32_t datacnt =3D s->blksize & BLOCK_SIZE_MASK;
> >
> > +    s->sdma_boundary_paused =3D false;
> >      if (s->trnmod & SDHC_TRNS_READ) {
> >          sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
> >          dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, data=
cnt,
> > @@ -1164,6 +1170,7 @@ static inline void sdhci_reset_write(SDHCIState *=
s, uint8_t value)
> >                  SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
> >          s->blkgap &=3D ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
> >          s->stopped_state =3D sdhc_not_stopped;
> > +        s->sdma_boundary_paused =3D false;
> >          s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
> >                  SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
> >          break;
> > @@ -1185,7 +1192,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
> >
> >      switch (offset & ~0x3) {
> >      case SDHC_SYSAD:
> > -        if (!TRANSFERRING_DATA(s->prnsts)) {
> > +        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) =
{
> >              s->sdmasysad =3D (s->sdmasysad & mask) | value;
> >              MASKED_WRITE(s->sdmasysad, mask, value);
> >              /* Writing to last byte of sdmasysad might trigger transfe=
r */
> > @@ -1477,8 +1484,8 @@ static const VMStateDescription sdhci_pending_ins=
ert_vmstate =3D {
> >
> >  const VMStateDescription sdhci_vmstate =3D {
> >      .name =3D "sdhci",
> > -    .version_id =3D 1,
> > -    .minimum_version_id =3D 1,
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 2,
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_UINT32(sdmasysad, SDHCIState),
> >          VMSTATE_UINT16(blksize, SDHCIState),
> > @@ -1508,6 +1515,7 @@ const VMStateDescription sdhci_vmstate =3D {
> >          VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, buf_m=
axsz),
> >          VMSTATE_TIMER_PTR(insert_timer, SDHCIState),
> >          VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
> > +        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >      .subsections =3D (const VMStateDescription * const []) {
> > diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> > index a9da6203fc..c485277744 100644
> > --- a/include/hw/sd/sdhci.h
> > +++ b/include/hw/sd/sdhci.h
> > @@ -103,6 +103,8 @@ struct SDHCIState {
> >       * to be protected. Set wp_inverted to invert the signal.
> >       */
> >      bool wp_inverted;
> > +    /* Indicate that SDMA transfer is paused due to hitting the bounda=
ry */
> > +    bool sdma_boundary_paused;
>
> It looks we can eliminate the need of introducing a new state to
> represent this scenario, instead we can do:
>
> static bool sdhci_sdma_transfer_active(SDHCIState *s)
> {
>     return TRANSFERRING_DATA(s->prnsts) && s->blkcnt &&
>            (s->blksize & BLOCK_SIZE_MASK) &&
>            SDHC_DMA_TYPE(s->hostctl1) =3D=3D SDHC_CTRL_SDMA;
> }
>
> and add such a condition in SYSAD handling:
>
> if (!TRANSFERRING_DATA() || sdhci_sdma_transfer_active())

This logic has a flaw. Please ignore. The introduction of a new state
seems inevitable.

>
> >  };
> >  typedef struct SDHCIState SDHCIState;
>

Regards,
Bin


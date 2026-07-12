Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DADC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wivMn-0003D0-BY; Sun, 12 Jul 2026 10:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivMd-0003CN-Ry
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:41:04 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivMb-0002OS-LX
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:41:03 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664dd23829eso2000608d50.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 07:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783867256; cv=none;
 d=google.com; s=arc-20260327;
 b=LgTe/xlxzyvicblrEYPE2AVjwFvw3OOR+5tUPPqdlcmwTOdgQGWaM+h/EYAiHCqpnE
 QiZmQzpcONABn//O49VHT/Vj9BH9zbn1nIOVBC4PrAzgf8MhTxr+GR+wBOszzEUKhj/G
 ds535aJJqNxHdzwwXJ4if2k7jkGXPPl973eKQtHjG1v8PVE2QIdIU/PeJtBCZxIyUUev
 YBltVyJ6r34bojTNCCdo4Hj7t8EC8xmSthf+iRLzs5uDNTMk+GFA2jwGqbVc05SAMHj2
 Xg20af4zhfCOzdSqeVob33Yva4PN6vlofOD1KRVyplQkujRrllTaAFHka0H1DeWWyZwa
 5oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J8LyC7S2ljG58bVI9/Y698lX2FMaserXfzEUAjHFprg=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=QrgQLD1iQlUVh6WprcdWsdcNVXXfczfFgElI8mmvwq25ZtEU1sOqvhUhzFYCj6UoLZ
 exaWpkJDDfv6ZtZPARVXliLlB3zxGfRMyMuuMoWh5yJJaNbC41oas1xbmtgYsDWuJ/1T
 FvOG3aDU9RRizj/AwL4LCBGvhwWnTR6ko3Wt4y1l0JG/T2e+j95e2NePkZOdj1rnpgKD
 sI/VRt3UFt7/g5eWWv4/xq/X+au5maWrYunvhtJxpMe0cPF6Rcax3aFklXcnQA3ajhAc
 X+vUKgR5kss4IQMNLCtdMI+Cw72J/hJtEe5UVLmN4FUaJjLanw7CWP9WdOzIYdx8aIMX
 zQNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783867256; x=1784472056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J8LyC7S2ljG58bVI9/Y698lX2FMaserXfzEUAjHFprg=;
 b=VWiH7NicF1EhEiRDFBVSGBv7NHrr5J9KO0TH9qnJLK/lRKNB51v+LLPjAe5MJ7/94T
 T/sPZ2PkZUuFLoo0eaH65O7u78J++LB9/YT8FsRiIm+0wl8SfGzrG//7TnA7eUx0DoFt
 gX/LgT5ixcHqv0rxAV/9XuIb4Y0w7y8+1/5wNMBoRkCtT8Sgq65/ueTjda7IjBdqN4/I
 UuGY+pZkDq6sBXRlBTqbqptUg6MgqtkjuZ1AO1JpWHrXINTZ8+7ZlihKZu6HDNOPmNWS
 DhtDfOeVWNRojXSZY0w8YBa8yCqSJGBB8bZJjFIef3xWZZ3i7LDaKP/1aedcaRH9/qVI
 aY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783867256; x=1784472056;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J8LyC7S2ljG58bVI9/Y698lX2FMaserXfzEUAjHFprg=;
 b=hrMEgAkXq5f1mbNiARARjaJYNBp9S7knomjvZhoVCrE49BKpZG7ORugqRExJ2YzGIA
 WDwQPDLI4m2fpbDk9BrsboQ47DkN0eO4YHiIakwwh+jhJPZg/hvMs98Rg9hkCX1con1y
 0vuS3SkLcv0GaGSITg+MrdySik0/x9heEOOBR54Me5fLHIaKr3uP1hxEk65hHWkzjDeu
 uv3WRq+Z3s4reNuy9unvDknglC3AmwDbriSmX+kQCIP+2eCaeklnkzhngawH+Dg6gqh4
 lYzCdrjqyW0FiXEmkx3SrGTL5rnzOSjA7KWiZjD9ga48rF3nYNB5QNWcA27mwvxOpCMf
 5hHQ==
X-Gm-Message-State: AOJu0YzBzzSldiki/tH2shSv4DKS5PNCkyIclujFIiknt5LficaSbYLR
 R3wNANxyAqU3VQWNXQKfcGf0bFAn4FFPgdRYd6qe6zpuFLDTQWEQRpbdus4yIFRXGJm/aS/JS8/
 rpMDYA8bcq6q7kNQf5A92wseeXPxIv5g=
X-Gm-Gg: AfdE7clOorrb9sc3Xft8YizM5e1JW6RhhhnSnLwIIQEN8O/o/2SvqO7z3MjY2JwHkPR
 uNrk5GBfTzRmfbAf0koeF3t2ApVZksCaz64F6WSmVbH2TbOI0KLY1aYop+qX1crgUwSJQ02fgZA
 Ofsqo+xnxNeqpvW51GZ/scs6Bpu3R6Kk7hwDTiqQMYldvpDbq4iRX5A4UC+D94RcuRgrTrS20N2
 hXmXgQ56lu2N1KXRKLPdNh6rm5WLaiU8rd76NWLN5cleVcFfjRYaA0QO/DkWinSC8Y8hPrfynBg
 LXCNJJI=
X-Received: by 2002:a05:690e:4147:b0:667:f1e8:477b with SMTP id
 956f58d0204a3-667f1e8483fmr441631d50.41.1783867256280; Sun, 12 Jul 2026
 07:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260707170457.11659-1-dingtao0430@163.com>
 <20260707170457.11659-2-dingtao0430@163.com>
 <CAEUhbmWgMUf6BrEmupsbp-zLEfjiv2JyHqtUmQy0C_Opd+Rd0A@mail.gmail.com>
In-Reply-To: <CAEUhbmWgMUf6BrEmupsbp-zLEfjiv2JyHqtUmQy0C_Opd+Rd0A@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 12 Jul 2026 22:40:44 +0800
X-Gm-Features: AUfX_mwQtdVPauR6C37O6-X7dSTvEq7FJ9YFKff0jHRbMoJ50JqW87UO5AAZoSE
Message-ID: <CAEUhbmUSRnaLrxxDTVDV9tgL_xZ9cGyHc7KkL5hjbjdRYmmfcQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb134.google.com
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

On Sun, Jul 12, 2026 at 10:35=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrot=
e:
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
>
> This one, and the following one
>
> >                  break;
> >              }
> >          }
> > @@ -669,6 +672,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >                  }
> >              }
> >              if (page_aligned && boundary_count =3D=3D 0) {
> > +                s->sdma_boundary_paused =3D true;
>
> can be moved to a single place before sdhci_update_irq() in the same func=
tion.
>
> >                  break;
> >              }
> >          }
> > @@ -679,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >      }
> >
> >      if (s->blkcnt =3D=3D 0) {
> > +        s->sdma_boundary_paused =3D false;
>
> Move setting sdma_boundary_paused false to inside sdhci_end_transfer().
>
> >          sdhci_end_transfer(s);
> >      } else {
>
> Move s->sdma_boundary_paused =3D true here.
>
> >          sdhci_update_irq(s);
> > @@ -690,6 +695,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIS=
tate *s)
> >  {
> >      uint32_t datacnt =3D s->blksize & BLOCK_SIZE_MASK;
> >
> > +    s->sdma_boundary_paused =3D false;
>
> This is not needed.
>
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
>
> Not needed.

I misread this one. This should be kept.

>
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
>
> Use a subsection is better in this case. See example of
> sdhci_pending_insert_vmstate.
>
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
> >  };
> >  typedef struct SDHCIState SDHCIState;

Regards,
Bin


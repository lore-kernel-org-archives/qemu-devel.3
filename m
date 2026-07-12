Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01D4C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wivb4-0004wj-7u; Sun, 12 Jul 2026 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivb3-0004wK-6T
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:55:57 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivb1-00045g-2s
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:55:56 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66771ded50aso4195094d50.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 07:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783868154; cv=none;
 d=google.com; s=arc-20260327;
 b=rjdyX+Jhsj+IHrV2o8jNNZKiLdUx8sPX+yXgkfSU3HQxcASulBJ4t14vBP6Bhre+D1
 kL+/hyJvnah2AYjwNZkua2uMwI079VWhDZ4wyA4sCdVGgHRTVa/ZFWz924OU58qxxXN0
 X+uQDZqmaLzBYLapwG8ECBlaBTPHMjeQvVysY7N+5LE+9B9jn4sByW2HQqElLciIE7A0
 xYZndIr4nZexUmNiXE3aoCozBSzfTtNnkzKmHYzwyZleKmirIwqK5Sl6RBb5CbJYEoxY
 FK5S0vDVwyHAvoUpel+1wtHoDp0tF9XOr06U4LtDMjDwS0bh4lODvLpOnvwJIsmaNQhu
 nQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vdn5E+soNr2leNfoyz8WqWyYCS3xy4lckC61r0ENiuA=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=eKlZjstl8S71aQCn3fbv7Sb0r2TGYRsmY8nEBjabF+eGQl1dEcCvmdHOXOWVEZgcDQ
 4l2KOuQ24ry3cWsWl4HUHe0yADusMNsV25uRs0F48QNfXB7tJjECK8H80bXQ50AEOrlo
 6dmpsyljfKhj5euHdkbsIzGd4Np7ZxCHCwbQ7EnjWcDx5q/gK0vgfj0bQTyAzQLcDkoY
 VVNpAmBcpUMB9DvLHT/aPTDzmFMCZcx8hcQgCIzEZPYzLZ2BgDVHDdyYDf6JPubogLdh
 /0pu3SaslVvml+DuCUU/zsb8wh6XiSJng+X/rTLw340qKAq46m9MfrDYdWLjkNuIZIoL
 8zAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783868154; x=1784472954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vdn5E+soNr2leNfoyz8WqWyYCS3xy4lckC61r0ENiuA=;
 b=I0kMBTgvMnqsAAqqNYkIOJ/MTEr7j8hS0b40x5Y5QS8+IlHBzkSWbL6ye4jGAnvcef
 AKMg2YEHIs8VqyYWhsCuyp5Dis7mmHgvpC9Q6B349nt64DKCEKgbubnYGL1IzJPnvmA9
 unILjwBw29xxMCI1xWs/c96mkfC/wn4N32EA3KYmHFs4pFWEFkGQnX1Q1/QrafKh+0Xb
 tUjsr8BQR2D3NlyoKPIeSc6cVTKo3cAKnXhGpMqDxLpqFujFe2qCaTGQsHDVNPvFlP7L
 pjT9Om0yozOQgYkkWdR6mzhIw/E02OAZH6R3XCTgozPvO9DbHZw5MIBGUK6pXF2cM4Yw
 yM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783868154; x=1784472954;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vdn5E+soNr2leNfoyz8WqWyYCS3xy4lckC61r0ENiuA=;
 b=HrxSFzKgwsu6c4NI2zdbNgXAvgSSfzuDqrU+cKRNI8OyZRvq+DJJyBs38PWIam+hNH
 kjdPuy+Eh3p5+t3YdVzQkYp3h+6esJbGCZ/UK4aBd/MEJLE2/bZDydLxrXDAQ9pHBNrD
 ycH4dwsbC05g2yE8WcQYf5Ji6y0f0sNQH8qhn4P5QCyZBTfAQlT7orQtHJMdROmI5BAn
 ZV5x6uy5sEExbcqI77AxyDI3QLjcQLQOWbRwTYghnfUuIpxKdyNBw/BbCWXZUhtYlOpJ
 2yJBH+orgo71rYAmo22MvhQ6YECZvM+a4nEHSuMdO3/LYhrwAWZIaCdnmcciQIUqI4mA
 wsZQ==
X-Gm-Message-State: AOJu0Yy7yokzkruFW0EU2+wP+eh9i7tynjyiLmUSWATFDLJHmaYHKHPq
 366klLTwCOIS3YWS5ZgP5jmS7JqXBwRogrl5trOYRKf7C99fFgsy5Kt7Ek1j0aTR/+fFh31IWnN
 IRxOI5oPy9VvqmdQpL74GLDMcX7MUkbg=
X-Gm-Gg: AfdE7cllhKazQ5FVjGPz9Re8ZRRpEv8rZKSVFfOhdxdPbPkZNJ8dkXfstz+qa+zskev
 tdAWjnP/HfPeBm84BKnahk/E/5GV9lk6DY01V+lbF5CWjG/sVwyP1TRp3xwJGr7XYx5rtzLRSEt
 7nxAXVadvzqd+AXODqtuATbfIV18F391/IFAY5w7yRbLx149EMmn0tSD6Vn9HGYiF4H80pxxwQm
 nDFNAeUkftmOBz+HxHizv4Z7UdvBVhJ0HVt/weOHFTK2I6dfJZNep1eHP0tegUHwTaD0dmd
X-Received: by 2002:a05:690e:150e:b0:667:8b90:356c with SMTP id
 956f58d0204a3-667d7ef1da1mr3425329d50.94.1783868153600; Sun, 12 Jul 2026
 07:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260707170457.11659-1-dingtao0430@163.com>
 <20260707170457.11659-2-dingtao0430@163.com>
In-Reply-To: <20260707170457.11659-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 12 Jul 2026 22:55:42 +0800
X-Gm-Features: AVVi8Ce-OBsGrhj4jJeePhMV8vdguPRKT78NdyCHLwJE-1YciqXACADAeDr2uys
Message-ID: <CAEUhbmW7hSLnUt481pOOiy0OyEBLe9+S4CRCSFLAUXy_9GFNkQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb131.google.com
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

On Wed, Jul 8, 2026 at 1:05=E2=80=AFAM Tao Ding <dingtao0430@163.com> wrote=
:
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
> Version_id change to 2 for migration.
>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> The reviewer pointed out an issue in patch v3. When s->blkcnt decreases t=
o 1 the logic goes to
> sdhci_sdma_transfer_single_block() where s->sdma_boundary_paused should b=
e cleared too.
>
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
>  hw/sd/sdhci.c         | 14 +++++++++++---
>  include/hw/sd/sdhci.h |  2 ++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f..dc774fdf21 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -307,6 +307,7 @@ static void sdhci_reset(SDHCIState *s)
>      s->data_count =3D 0;
>      s->stopped_state =3D sdhc_not_stopped;
>      s->pending_insert_state =3D false;
> +    s->sdma_boundary_paused =3D false;
>      if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
>              object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
>          s->norintstsen =3D 0x013f;
> @@ -620,6 +621,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>      }
>
>      s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
> +    s->sdma_boundary_paused =3D false;

I believe this line is not necessary too.

>      if (s->trnmod & SDHC_TRNS_READ) {
>          s->prnsts |=3D SDHC_DOING_READ;
>          while (s->blkcnt) {
> @@ -644,6 +646,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  s->data_count =3D 0;
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->sdma_boundary_paused =3D true;
>                  break;
>              }
>          }
> @@ -669,6 +672,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  }
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->sdma_boundary_paused =3D true;
>                  break;
>              }
>          }
> @@ -679,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>      }
>
>      if (s->blkcnt =3D=3D 0) {
> +        s->sdma_boundary_paused =3D false;
>          sdhci_end_transfer(s);
>      } else {
>          sdhci_update_irq(s);
> @@ -690,6 +695,7 @@ static void sdhci_sdma_transfer_single_block(SDHCISta=
te *s)
>  {
>      uint32_t datacnt =3D s->blksize & BLOCK_SIZE_MASK;
>
> +    s->sdma_boundary_paused =3D false;
>      if (s->trnmod & SDHC_TRNS_READ) {
>          sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
>          dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacn=
t,
> @@ -1164,6 +1170,7 @@ static inline void sdhci_reset_write(SDHCIState *s,=
 uint8_t value)
>                  SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
>          s->blkgap &=3D ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
>          s->stopped_state =3D sdhc_not_stopped;
> +        s->sdma_boundary_paused =3D false;
>          s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
>                  SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
>          break;
> @@ -1185,7 +1192,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>
>      switch (offset & ~0x3) {
>      case SDHC_SYSAD:
> -        if (!TRANSFERRING_DATA(s->prnsts)) {
> +        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
>              s->sdmasysad =3D (s->sdmasysad & mask) | value;
>              MASKED_WRITE(s->sdmasysad, mask, value);
>              /* Writing to last byte of sdmasysad might trigger transfer =
*/
> @@ -1477,8 +1484,8 @@ static const VMStateDescription sdhci_pending_inser=
t_vmstate =3D {
>
>  const VMStateDescription sdhci_vmstate =3D {
>      .name =3D "sdhci",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT32(sdmasysad, SDHCIState),
>          VMSTATE_UINT16(blksize, SDHCIState),
> @@ -1508,6 +1515,7 @@ const VMStateDescription sdhci_vmstate =3D {
>          VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, buf_max=
sz),
>          VMSTATE_TIMER_PTR(insert_timer, SDHCIState),
>          VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
> +        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),
>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription * const []) {
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index a9da6203fc..c485277744 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -103,6 +103,8 @@ struct SDHCIState {
>       * to be protected. Set wp_inverted to invert the signal.
>       */
>      bool wp_inverted;
> +    /* Indicate that SDMA transfer is paused due to hitting the boundary=
 */
> +    bool sdma_boundary_paused;
>  };
>  typedef struct SDHCIState SDHCIState;
>

Regards,
Bin


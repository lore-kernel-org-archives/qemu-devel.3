Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F40C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wivHu-00023r-EB; Sun, 12 Jul 2026 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivHt-00023a-1o
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:36:09 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wivHq-0001zf-TR
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:36:08 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664dd23829eso1998936d50.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 07:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783866966; cv=none;
 d=google.com; s=arc-20260327;
 b=YioDpW/iOSuizENEI8clMFSAtrR/oFHvup1wx87y56sq9nYYv4fpVyF4n9oC2G8NN1
 I+L8khi+9vybULHa8/SUtHl47yeESUQCMLAc7eSvg1JJjq6LJZoga2cA2lswov/vvsdv
 Pdgrig52Mifl1w+KTXBExhiRm7KLBALj5K4bBs9q2xhKJppVcxyjUw3s9Po56JQuXHiu
 3memn0q9/o2l8+Cdb5xGpe4tNzhKJG/fyQGknordWwY8gzuulbIlw5C3LImnBP1GzE3p
 +xfNDC1VHZ5hmR0x72olpO587vnFAEEnWJQ2TK3jR15aE8WLLBC/neo3Z+K6LmMX+FTf
 iQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6RQrJzzeiYUVqTIpSLsEj4gXrVJtWWIdLAImcd2bOkA=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=KWZxiXNz2fn74+ANyRsaw5a+1YmQQpGzZuXnBogudKI/6VdFZmjCA8QcDs0lTcw7qd
 oFYG8khtjxn1YjorqYhqxIIg8Z8LsjKDjdTRPo+8Gc/wFF61CFLaSBRzSB2f08eoDxrc
 VoF1XBlEfWY0pb6jhyrbi5BlDOuvevtKD3wTFZulIDFxSlkMv7o0tcBWlHdP+vVFzxVl
 OzpMXevvLD7SGlFYXqTLgTv1pHX1VABgS8lvIrJ9gY2GPegk2OPGemoAqMXxtVL7puz4
 7MURQhwUinkMxsnz0LpbgRdcIoMH0p3IrykkWjw5oTpoMopJgRPOGAf+d27+xufeITQv
 yZxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783866966; x=1784471766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6RQrJzzeiYUVqTIpSLsEj4gXrVJtWWIdLAImcd2bOkA=;
 b=hQuiJY6An9Sp5KP85mCpb3ltz0OiCVtIcx0Et/bcQiQ6m9CbkITGaWVmfJOzzAKwMj
 jlkJWrfcFbjgv3wFkwtLs5kILbU8WvyXRz8wX9lEVMmcYija0rNprrmSZzXB33MaaSr+
 9ydFklpdSTaF2lgD4G/gK6izpNiiaYPLVyM9WFEzHL0vi8/OGgh+d/r2vRBa/anVM67m
 rMKEfhWnYcybFSgbi45It4vkWcYjbz8mCmpT/ZsD58po4BoU104dZO61YkKupXSyd2OX
 hp77XODvanStJ+p1tHbiKhoYxRur9/uAD0jyx0Ezf0O3uw/jqFUCl3HTuaK0PxqoMUb5
 XGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783866966; x=1784471766;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RQrJzzeiYUVqTIpSLsEj4gXrVJtWWIdLAImcd2bOkA=;
 b=HZ7v3TiLD72nCo4A86tdr2AYaziFQ9pY0ICZ0weSpdqI1PDd63Ch5JCp8gwDnF9n0x
 NEyn4rl7olAMbowwTJw+oD+U5xLSNE0CNqL+QxSbAUKwGTXgWWgI1wQM0EGiPJO3SNN4
 hYw314ap2gCwXsYvuUwsUb8cgcKCcHPHgV+vLxqjoHBy7ZEMq8IcqGHlstPsUVLW5spw
 rTdVwXO2xY/1/biryiMjlOS3ClBKyjk1/Cvp8YP8jJwJyQyS1KShonm5Rj19YWjz+4eO
 pkPITT05qAoVNQ7frbqc/oHOKkUY3btjRQuWrU/vGHEotEOj5YbBLtaXEHs5cUDUCbZl
 JgWg==
X-Gm-Message-State: AOJu0YzhvimnIkwPRnTJYk0U4mEip01+NZkzkKV/9AvqxhvgodIwzDFZ
 l2Wa6LmHySRscnw/m5MQzAfNxgYkS6KH8fvLOEn1HNUQ7AEqd6UNOeG7+4u2tRIsgXmOK/6owAB
 GjnGsWviotXPBgLhsad61yAD/A8pIPRc=
X-Gm-Gg: AfdE7clr7RjT1KsjR1/1hwivr4j9n0UNJCv45xVPzHydMW830+VHz1G+CIRaf8afFsG
 8g1BKYiyQJGDgy0mpxM1KVcwoSR9+WCXHIBDe9+ImaP4YAzEW/Tozw+Fg0TVBjMQHWlzMFXwr7N
 DM9wbrCQsGDG2X5cYEvMBP5PHhSG5YWO17X+KjIXUaK/Bi7bhL0y2EZDPD03RKsSNzx31q9QHBu
 lb36IkjTMoU7Za+ZLqShCokNLOQvsLC1lOhHoGKEq/ubr0jCp9gK/zJ6vWP2ckDQuzXO/zXq/TM
 HaiuvmU=
X-Received: by 2002:a05:690e:4419:b0:667:a83f:28f7 with SMTP id
 956f58d0204a3-667d7b001fcmr3304527d50.21.1783866965700; Sun, 12 Jul 2026
 07:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260707170457.11659-1-dingtao0430@163.com>
 <20260707170457.11659-2-dingtao0430@163.com>
In-Reply-To: <20260707170457.11659-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 12 Jul 2026 22:35:54 +0800
X-Gm-Features: AUfX_mxMFUoCgY3mBzWe4a4Ttcf8__L4DgC--V1eGdhBub4L8v621jURVse7bVU
Message-ID: <CAEUhbmWgMUf6BrEmupsbp-zLEfjiv2JyHqtUmQy0C_Opd+Rd0A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb136.google.com
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
>      if (s->trnmod & SDHC_TRNS_READ) {
>          s->prnsts |=3D SDHC_DOING_READ;
>          while (s->blkcnt) {
> @@ -644,6 +646,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  s->data_count =3D 0;
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->sdma_boundary_paused =3D true;

This one, and the following one

>                  break;
>              }
>          }
> @@ -669,6 +672,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                  }
>              }
>              if (page_aligned && boundary_count =3D=3D 0) {
> +                s->sdma_boundary_paused =3D true;

can be moved to a single place before sdhci_update_irq() in the same functi=
on.

>                  break;
>              }
>          }
> @@ -679,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>      }
>
>      if (s->blkcnt =3D=3D 0) {
> +        s->sdma_boundary_paused =3D false;

Move setting sdma_boundary_paused false to inside sdhci_end_transfer().

>          sdhci_end_transfer(s);
>      } else {

Move s->sdma_boundary_paused =3D true here.

>          sdhci_update_irq(s);
> @@ -690,6 +695,7 @@ static void sdhci_sdma_transfer_single_block(SDHCISta=
te *s)
>  {
>      uint32_t datacnt =3D s->blksize & BLOCK_SIZE_MASK;
>
> +    s->sdma_boundary_paused =3D false;

This is not needed.

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

Not needed.

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

Use a subsection is better in this case. See example of
sdhci_pending_insert_vmstate.

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
> --
> 2.43.0
>


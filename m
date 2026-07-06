Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37582C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgkYY-0004ti-IW; Mon, 06 Jul 2026 10:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgkYM-0004tG-Od
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:44:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wgkYK-0004v0-7s
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:44:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso1927979f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 07:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783349045; cv=none;
 d=google.com; s=arc-20260327;
 b=Fpady5WwuTNBo+QfKh8mmkCOj+zZfhKAzTjZBe4DNX4VOwcs5OaiBNdElbfYHJEFg8
 R5rgDOtBPkKjmPD4cfJiWqbGtuvKtE87lUUn28F6MUaDLiWas5l0wLZRiOUh+bq7A4uK
 nO/VJoTd/nldOr7ZXBhxrMnndVUMIHK4+4dZrg4e3q+I6/u1E/Bp8Y04L5Uxvkt8w+3t
 ObFyM/5yo1LXuCqV+OQdMubPq3daLux3LTLZnmgsaXbzoNWicVMCFU74VphvLQj6DW/J
 mmF6P/gIm7j4XwJTEi4Xhyh0UFSl4u++x/Y2D26iSjY/xP2ryBME4vywW9jIvsbnohwB
 vq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RFjDf4UEzKbe5+xe1Fi1Zt64Rc6JS9NwHNaGE0853ic=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=nqh/6TbGaA1X2LYGBCDmaqxHZygFyvP8du3irbfFWZzjinu4Hi9sHZ3U1ug5qD2l8z
 Vpb63659RZpLyM9RWCP1GHONF8dj4EiY2s5I5dlwo7k/k3ZuynSHJjBrkNuLoXuhywyP
 jxj219fcy7xAi69PzNV0ggK7b4w70f6M6rY0g7fN2gVUrwVfwW+RuuhV7d1arNZYgLYm
 6leCiFnxRezapwFtR4bBLnfo0e0Y3/iRUgZQ/pe1eErkHAqHaxA8fqbIzfP0xOMO6A3y
 q1h8wOI6VvsbemWX4NOKVfb1clwiM05N5Mo/TfScPzNC+wBW5i0Vt9jdEtfPswKec1RK
 rofQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783349045; x=1783953845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFjDf4UEzKbe5+xe1Fi1Zt64Rc6JS9NwHNaGE0853ic=;
 b=jxXlDJEATS9TW8B1kWk0/xb99/g/nGa8v4YTSr5Tiwep7ZdyWhNIM6ItErYSyTr7jp
 YjJRDR166OHXwE3Tdau29VntB+7FCBvShgM2zMt5PMHzMoR8xOPcOHAxpW7iBq3stpdX
 miWNeE5nVGFQzMsARwexW6uVAqeWl+NVl6mPkSz4dtadhyq2ZTvj0pObYDKQ0kZgHV+9
 bMCAcw9L19hmOBtNdweeEeG5p2a7IeTPWPrXDOwbGSbNzwa2tiS0o2GHqXMZA4EwRQsD
 zVZXStSu9x4j01abjnZP6KtS5NXSpEyWlGCblZOawsQo2GUfjCaVchOwoqXIRhi2vsj6
 wjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783349045; x=1783953845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RFjDf4UEzKbe5+xe1Fi1Zt64Rc6JS9NwHNaGE0853ic=;
 b=jKkb9cyS9fwX4e+w5ndKh60qzRDwsFFnyvQhInRS0CVqO/jf5iOyE90fRGSGHRgSfa
 rS2Su5rz0i5JaofikGMI0UrI4navfUrAKiF83ojndftPYDbFZlKDINgJq9b1DceEseuB
 ow2UIZuj+cotBe04bLcoHX9/1MwYiA1yTCiwaGoISTOZHm3NBiUZNmjr3ZbQnDVYdnzX
 RjZixKUj7BttFQ/e2q2Wb5ptUZQRsMnv4VSlQ+FxmMIs1uolA1kO2nVPtzAsQbm2WrKZ
 aRFNFcoVSj3Q/ymAgSDhOvqQK0azjdrSMjasa2HZ0njp7ZpocRLokeK0NlgLHro+ZahN
 GgJQ==
X-Gm-Message-State: AOJu0Yy22hrm5FE1BzXA1FJcKj7LiNYrjPN8W8PmCFANaJFyIGt79YMl
 6TdZSXXwLFDwxW6hbspIsksldsEir2T8pchbMAeU2Rd3Illh62wQ6DLPQFQAXuWR1R1he8qQr6F
 3I5Gf/1uSXkXnS2bLyvlNVdD7pCoTKrk=
X-Gm-Gg: AfdE7clW8LphZJX+dYwMegdl4rscX52rVy+GRnaCqXh2eA0ATEPFXc51lxtSy7+AFnh
 Ak03sAqFLQA0DfG19POQOnVumbbaACXTB5fkIntoI6VNh8tIcYyHSFaBJrFJGRvN1KJ8MHgxTNL
 /Wmr/c2u+CeXvzHLPBJic2uJOR09bZFiCb5/cnp1Nszdjh1uSs16Z92erveHpetI6VZbt2LPTtT
 qXI7f8ZrMAgX54U4IZ+vli61//WcczxeDW7Jn3WjaVVuND6KTE63EvO38chVoNR6nsg4MBOKwJO
 hQ==
X-Received: by 2002:a5d:6845:0:b0:47d:d812:e067 with SMTP id
 ffacd0b85a97d-47de66c3d1fmr449445f8f.29.1783349044916; Mon, 06 Jul 2026
 07:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260701155759.43328-1-dingtao0430@163.com>
 <20260701155759.43328-2-dingtao0430@163.com>
In-Reply-To: <20260701155759.43328-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 6 Jul 2026 22:43:51 +0800
X-Gm-Features: AVVi8CdCvmn_MBftIyy6NVfuGnMXmxNCR4fqUJaIUM56hB07M-TOLY9zj5_Zv_k
Message-ID: <CAEUhbmUXV8zq6Vrf3xGk5FNx4A5rbRnLyOA36BJwDGb6713Hxw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 1, 2026 at 11:59=E2=80=AFPM Tao Ding <dingtao0430@163.com> wrot=
e:
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
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> The reviewer pointed out an issue in patch v2 and suggested a more approp=
riate way of modification.
> In this patch, a new state has been added to indicate encountering a boun=
dary.
> No additional state has been added to the existing stopped_state,
> which seems to be specifically for gap requests (as can be seen from some=
 if-else statements in the code)
>
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
>  hw/sd/sdhci.c         | 9 ++++++++-
>  include/hw/sd/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f..ecd286f2d7 100644
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

When s->blkcnt decreases to 1 the logic goes to
sdhci_sdma_transfer_single_block(() where s->sdma_boundary_paused
should be cleared too, otherwise it will cause potential subsequent
bypass of TRANSFERRING_DATA() check in the SYSAD programming.

>      } else {
>          sdhci_update_irq(s);
> @@ -1164,6 +1169,7 @@ static inline void sdhci_reset_write(SDHCIState *s,=
 uint8_t value)
>                  SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
>          s->blkgap &=3D ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
>          s->stopped_state =3D sdhc_not_stopped;
> +        s->sdma_boundary_paused =3D false;
>          s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
>                  SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
>          break;
> @@ -1185,7 +1191,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
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
> @@ -1508,6 +1514,7 @@ const VMStateDescription sdhci_vmstate =3D {
>          VMSTATE_VBUFFER_UINT32(fifo_buffer, SDHCIState, 1, NULL, buf_max=
sz),
>          VMSTATE_TIMER_PTR(insert_timer, SDHCIState),
>          VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
> +        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),

The version should be bumped up for migration.

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


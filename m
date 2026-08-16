Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDDCC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 15:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcdC-0003lx-Cv; Sun, 16 Aug 2026 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wvcdA-0003lC-1q
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:18:36 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wvcd7-0005Oy-4G
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 11:18:35 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7ff05e5d009so28767277b3.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786893512; cv=none;
 d=google.com; s=arc-20260327;
 b=Z8/34G6IBJxZWNrJ3zsGhjnx+U/8PJaXvdS6xSIxgci74tF7YGpr5pLb6EZGZoBKog
 +VKZM0W78R3Oo+rLK6BILnWKLRCpDask3YnEEiObkDXeuH4yLAKOCpY45B9P1bXEiVtA
 9zPxji+qJJl4UT5NKIVz6Ls2+pZhuavTN/SZM1jQ2+MML7JnJFlrAKydIxZcAoCfCoAk
 W3Nj5QJCg5xEdjUCY1+TG64EnctwPQqcnxWUWHexfungfoFU+UOlnvZZ8lzbNLcyq879
 iXSc0DP98ejiuAC8ztAJOROAshcWdqxV1v/rD3979dl2Qu0LEPyqEfbiCOtJ/kXiJrN/
 F06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HK4JIqAAc9rUWx3FELi+xM0+wW31ktAyp60PCTTrn8s=;
 fh=DLsCS/inX+RkvRQxwYBFfNhxsDndjb9n6uWalY9lDOY=;
 b=AvqccvzVt7ASBP3swRygV+0JkiJX+CiUUJ/Xyda9tdCEOkAi8WgAwCdYHgZs/Ysr4b
 LOsgqycFRgTMPCMY+jsBUBR9kFcgJIUj9VKq5Ac1fr+F2Acm2IVsH9pEAAQuy4yC5TL5
 +X9I+3BQg7qNB5d0pimipQE8uleeLu2Cxkdcvb2bEYO0kxFLp1iJkSf9B/9MPtbr81d8
 5Gr27eGZ0BOe+b73Fcsml8vmY/5BUMFIVI/Ws8Tak+8uMKH0rhLYNnS95xIMiAgn9vSn
 E92dus5HTq3V7+42Mj8JbnC8qA8CZ99G3yPv0kDyaiLBi0nD9+Bi2fkPWm4Bc7kuidrZ
 6OzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786893512; x=1787498312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HK4JIqAAc9rUWx3FELi+xM0+wW31ktAyp60PCTTrn8s=;
 b=f2L2XDWqBIUCh/A3JproRm/GLZ71JAYgKLAZ4GzTvKWQMdD8kGc/l5hxt/7QiZ3daW
 IeVZyo8STZTGDPBxKmfB396p6x8+0zcDR7Jw2dk87ttRAIcmjGBsX8Hmiv3rmXQRWYMd
 718gz3gyM0VZodvWq0+xHE9RYmnkzsq1FUT/LJQlUoy/XBt8lNulDng/xq5KJTQoEeFU
 5fdlWNYRp8mZaDVEHIpzqEIFvsPneilmqajBS9FD4t4YqQcVQz1AsfT9T3sgO/IN04qs
 hGPl1JcVJFLUEX9PPnKU37hv27c5dfoMHmtjlcf928/ZLGm0ehZCJ9I91VK4ABd8YXOw
 Eruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786893512; x=1787498312;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HK4JIqAAc9rUWx3FELi+xM0+wW31ktAyp60PCTTrn8s=;
 b=lLbZgSSH3CFTpoJLdbOXnWspOIGB83o/CB1VnqqLLZnZ5MZ2cIG1mZqXQZqCcpAcs0
 jc+A0XQrmOpH9mnZfKaHGlpFXRVBjRWOuHQHwfLdwXc21oc7xwW0NmBVbMMvELAVGk6Y
 1ZsiHkCpR9rUuTXukvpsZmi9Vz1Rhj3UchteAilfFfQ6N1quRw7IVTKUWJtWnq4gDvbx
 FAkr87OLZDq9qJWcxQrvEtGfXJRS8wMZ7CIcTn1HJjFeSYe7tcmRkZ1XjNa/X709MTdg
 oNeJC94YYQzEfWu365O6Ee5QB73GX0mAvFLQLpZxbidsh+4JZTClS5KNgW6QeRrbgcU/
 qUaQ==
X-Gm-Message-State: AOJu0YweOZtCkDP+ZtTDiAK3TwrPils/gCB1rGfUshTPXRfEhMSgcqX+
 bgrV2TMph1BlnpbbxOfjJsFHD7iOHEoNfnQ/kY0ugQgLp68A9CluEXvIhuUHw6+nP9XKdw4XrCv
 ZjxEu3Xfkqe7Bf2x25g0yZruQkyTYoUc=
X-Gm-Gg: AR+sD11QwLJU6RJn7xwMyjA2xoNJFXpvLZpLNvfoM6R+JRDt6ulqMUab4Cf2X0MMTKm
 RDXjLYajpOy4uPMlEH3sWwkbcu5NL0CD61btrx3an6xmjpzIyVaDrniUCpe8Xpk1b75/jZYaLdh
 RpDrp/awIeC3mvIsFbRMBXJ99OyQNnpA03nOgdAOWbkXxlO/lDqKvvhnXzu+FqtE+e8rn70lSDp
 kBKAlgubCFL8hlgCfFReH8HZN9CfWpoklvPq2/1y5UPdltrvkLKcL6pZ/o3cMqJjHDgXa9MON24
 xCVuV8TC70QI4cE15fWb7b1pWR4paUEXnYEKWS7EQ6KuGC08ZuWcy9NGPrQDVgFSY04vlRKKTUG
 +16A=
X-Received: by 2002:a05:690c:370a:b0:81f:3b6d:a0bb with SMTP id
 00721157ae682-83713377c28mr69259827b3.32.1786893511519; Sun, 16 Aug 2026
 08:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-3-flamboyant.h.01@gmail.com>
In-Reply-To: <20260808182956.290561-3-flamboyant.h.01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2026 23:18:20 +0800
X-Gm-Features: AcwNN1Wj1RgeYNsui8geNd8DHgTK9MND9vS3S170kHWxfcVyCCgW3AMnuCAedII
Message-ID: <CAEUhbmXRHxi-FBBA9+O+yimOZAMJcs7ZR5sQaJ56B6HPUyW4Ow@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] hw/ssi: Add DWC SSI standard interrupt support
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1130.google.com
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

Hi Kangjie,

On Sun, Aug 9, 2026 at 2:31=E2=80=AFAM Kangjie Huang <flamboyant.h.01@gmail=
.com> wrote:
>
> Implement raw and masked SSI interrupt status, threshold interrupts, and
> the documented read-clear registers.
>
> TXE and RXF are derived from FIFO levels. TXO, RXO, and RXU are latched
> causes. Expose the model's nine physical interrupt outputs.
>
> TXU, DONE, and AXIE depend on transfer engines outside the Standard PIO
> scope and remain deasserted. DONECR and AXIECR are RAZ/WI.
>
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  hw/ssi/dwc_ssi.c         | 129 ++++++++++++++++++++++++++++++++++++++-
>  include/hw/ssi/dwc_ssi.h |  18 +++++-
>  2 files changed, 145 insertions(+), 2 deletions(-)

Please squash this patch into patch 1. The introduction of a new model
is normally done in one single commit.

>
> diff --git a/hw/ssi/dwc_ssi.c b/hw/ssi/dwc_ssi.c
> index c0bcf8b869..43c5c5db88 100644
> --- a/hw/ssi/dwc_ssi.c
> +++ b/hw/ssi/dwc_ssi.c
> @@ -6,7 +6,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
>   * Emulates the DesignWare SSI controller in Standard SPI mode,
> - * covering the PIO/FIFO data path and chip selects.
> + * covering the PIO/FIFO data path, interrupt outputs and chip selects.
>   */
>
>  #include "qemu/osdep.h"
> @@ -26,6 +26,9 @@
>  #define DWC_SSI_IDR_RESET               0xa1b2c3d5
>  #define DWC_SSI_VERSION                 0x3130332a
>  #define DWC_SSI_PIO_TX_BATCH            64
> +#define DWC_SSI_IRQ_VALID_MASK          0x000009bf
> +#define DWC_SSI_IMPLEMENTED_LATCHED_IRQ_MASK \
> +    (R_RISR_TXOIR_MASK | R_RISR_RXOIR_MASK | R_RISR_RXUIR_MASK)
>
>  enum {
>      DWC_SSI_TMOD_TR,
> @@ -217,6 +220,22 @@ REG32(XIP_WRITE_CTRL, 0x148)
>  #define DWC_SSI_RX_SAMPLE_DELAY_WRITABLE_MASK \
>      (R_RX_SAMPLE_DELAY_RSD_MASK | R_RX_SAMPLE_DELAY_SE_MASK)
>
> +/*
> + * TXU, DONE and AXIE depend on transfer engines outside Standard PIO.
> + * Their physical outputs are exposed but remain deasserted in this mode=
l.
> + */
> +static const uint32_t dwc_ssi_irq_status_mask[DWC_SSI_IRQ_COUNT] =3D {
> +    [DWC_SSI_IRQ_TXE] =3D R_RISR_TXEIR_MASK,
> +    [DWC_SSI_IRQ_TXO] =3D R_RISR_TXOIR_MASK,
> +    [DWC_SSI_IRQ_RXF] =3D R_RISR_RXFIR_MASK,
> +    [DWC_SSI_IRQ_RXO] =3D R_RISR_RXOIR_MASK,
> +    [DWC_SSI_IRQ_TXU] =3D R_RISR_TXUIR_MASK,
> +    [DWC_SSI_IRQ_RXU] =3D R_RISR_RXUIR_MASK,
> +    [DWC_SSI_IRQ_MST] =3D R_RISR_MSTIR_MASK,
> +    [DWC_SSI_IRQ_DONE] =3D R_RISR_DONER_MASK,
> +    [DWC_SSI_IRQ_AXIE] =3D R_RISR_AXIER_MASK,
> +};
> +
>  static bool dwc_ssi_validate_config(DwcSsiState *s, Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(s);
> @@ -253,6 +272,45 @@ static void dwc_ssi_write_masked(DwcSsiState *s, uns=
igned int reg,
>      s->regs[reg] =3D (s->regs[reg] & ~mask) | (value & mask);
>  }
>
> +static uint32_t dwc_ssi_irq_raw_status(DwcSsiState *s)
> +{
> +    uint32_t status =3D s->irq_latched;
> +    uint32_t tx_used =3D fifo32_num_used(&s->tx_fifo);
> +    uint32_t rx_used =3D fifo32_num_used(&s->rx_fifo);
> +    uint32_t tx_threshold =3D
> +        FIELD_EX32(s->regs[R_TXFTLR], TXFTLR, TFT);
> +    uint32_t rx_threshold =3D
> +        FIELD_EX32(s->regs[R_RXFTLR], RXFTLR, RFT);
> +
> +    if (tx_used <=3D tx_threshold) {
> +        status |=3D R_RISR_TXEIR_MASK;
> +    }
> +    if (rx_used > rx_threshold) {
> +        status |=3D R_RISR_RXFIR_MASK;
> +    }
> +    return status & DWC_SSI_IRQ_VALID_MASK;
> +}
> +
> +static void dwc_ssi_update_irq(DwcSsiState *s)
> +{
> +    uint32_t status =3D dwc_ssi_irq_raw_status(s) &
> +                      s->regs[R_IMR] & DWC_SSI_IRQ_VALID_MASK;
> +
> +    for (int i =3D 0; i < DWC_SSI_IRQ_COUNT; i++) {
> +        qemu_set_irq(s->irqs[i], !!(status & dwc_ssi_irq_status_mask[i])=
);
> +    }
> +}
> +
> +static uint32_t dwc_ssi_irq_read_clear(DwcSsiState *s,
> +                                       uint32_t clear_mask)
> +{
> +    uint32_t active =3D s->irq_latched & clear_mask;
> +
> +    s->irq_latched &=3D ~clear_mask;
> +    dwc_ssi_update_irq(s);
> +    return !!active;
> +}
> +
>  static uint32_t dwc_ssi_frame_masked(DwcSsiState *s)
>  {
>      unsigned int bits =3D FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) + 1=
;
> @@ -322,6 +380,7 @@ static void dwc_ssi_abort_transfer(DwcSsiState *s)
>      s->phase =3D DWC_SSI_PHASE_IDLE;
>      s->remaining_frames =3D 0;
>      s->dummy_frame =3D 0;
> +    dwc_ssi_update_irq(s);
>  }
>
>  static uint32_t dwc_ssi_status(DwcSsiState *s)
> @@ -349,6 +408,8 @@ static void dwc_ssi_push_tx(DwcSsiState *s, uint32_t =
tx)
>      }
>
>      if (fifo32_is_full(&s->tx_fifo)) {
> +        s->irq_latched |=3D R_RISR_TXOIR_MASK;
> +        dwc_ssi_update_irq(s);
>          return;
>      }
>
> @@ -357,6 +418,7 @@ static void dwc_ssi_push_tx(DwcSsiState *s, uint32_t =
tx)
>      if (s->phase !=3D DWC_SSI_PHASE_STANDARD_TX_ONLY) {
>          dwc_ssi_run_transfer(s);
>      }
> +    dwc_ssi_update_irq(s);
>  }
>
>  static uint32_t dwc_ssi_send_frame(DwcSsiState *s,
> @@ -414,6 +476,7 @@ static void dwc_ssi_run_transfer(DwcSsiState *s)
>              uint32_t rx =3D dwc_ssi_send_frame(s, tx);
>
>              if (fifo32_is_full(&s->rx_fifo)) {
> +                s->irq_latched |=3D R_RISR_RXOIR_MASK;
>                  qemu_log_mask(LOG_GUEST_ERROR,
>                                "%s: RX FIFO full, dropping frame\n",
>                                DEVICE(s)->canonical_path);
> @@ -602,9 +665,11 @@ static uint64_t dwc_ssi_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>              value =3D fifo32_pop(&s->rx_fifo) & dwc_ssi_frame_masked(s);
>          } else {
>              value =3D 0;
> +            s->irq_latched |=3D R_RISR_RXUIR_MASK;
>          }
>
>          dwc_ssi_run_transfer(s);
> +        dwc_ssi_update_irq(s);
>          return value;
>      }
>
> @@ -634,6 +699,7 @@ static uint64_t dwc_ssi_read(void *opaque, hwaddr add=
r, unsigned int size)
>          value =3D fifo32_num_used(&s->tx_fifo);
>          if (s->phase =3D=3D DWC_SSI_PHASE_STANDARD_TX_ONLY) {
>              dwc_ssi_run_transfer(s);
> +            dwc_ssi_update_irq(s);
>          }
>          break;
>      case A_RXFLR:
> @@ -643,8 +709,35 @@ static uint64_t dwc_ssi_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>          value =3D dwc_ssi_status(s);
>          if (s->phase =3D=3D DWC_SSI_PHASE_STANDARD_TX_ONLY) {
>              dwc_ssi_run_transfer(s);
> +            dwc_ssi_update_irq(s);
>          }
>          break;
> +    case A_ISR:
> +        value =3D dwc_ssi_irq_raw_status(s) & s->regs[R_IMR] &
> +                DWC_SSI_IRQ_VALID_MASK;
> +        break;
> +    case A_RISR:
> +        value =3D dwc_ssi_irq_raw_status(s);
> +        break;
> +    case A_TXEICR:
> +        value =3D dwc_ssi_irq_read_clear(
> +            s, R_RISR_TXOIR_MASK | R_RISR_TXUIR_MASK);
> +        break;
> +    case A_RXOICR:
> +        value =3D dwc_ssi_irq_read_clear(s, R_RISR_RXOIR_MASK);
> +        break;
> +    case A_RXUICR:
> +        value =3D dwc_ssi_irq_read_clear(s, R_RISR_RXUIR_MASK);
> +        break;
> +    case A_MSTICR:
> +        value =3D dwc_ssi_irq_read_clear(s, R_RISR_MSTIR_MASK);
> +        break;
> +    case A_ICR:
> +        value =3D dwc_ssi_irq_read_clear(
> +            s, R_RISR_TXOIR_MASK | R_RISR_RXUIR_MASK |
> +               R_RISR_RXOIR_MASK | R_RISR_MSTIR_MASK);
> +        break;
> +
>      default:
>          if (addr >=3D DWC_SSI_REGS_SIZE || (addr & 0x3) !=3D 0) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> @@ -708,6 +801,7 @@ static void dwc_ssi_write(void *opaque, hwaddr addr,
>
>          dwc_ssi_update_cs(s);
>          dwc_ssi_run_transfer(s);
> +        dwc_ssi_update_irq(s);
>          break;
>      }
>      case A_MWCR:
> @@ -731,6 +825,7 @@ static void dwc_ssi_write(void *opaque, hwaddr addr,
>
>          dwc_ssi_update_cs(s);
>          dwc_ssi_run_transfer(s);
> +        dwc_ssi_update_irq(s);
>          break;
>      }
>      case A_BAUDR:
> @@ -750,6 +845,7 @@ static void dwc_ssi_write(void *opaque, hwaddr addr,
>          dwc_ssi_write_masked(s, R_TXFTLR, value,
>                               DWC_SSI_TXFTLR_WRITABLE_MASK);
>          dwc_ssi_run_transfer(s);
> +        dwc_ssi_update_irq(s);
>          break;
>      case A_RXFTLR:
>          if (!dwc_ssi_fifo_threshold_valid(
> @@ -761,6 +857,7 @@ static void dwc_ssi_write(void *opaque, hwaddr addr,
>          }
>          dwc_ssi_write_masked(s, R_RXFTLR, value,
>                               DWC_SSI_RXFTLR_WRITABLE_MASK);
> +        dwc_ssi_update_irq(s);
>          break;
>      case A_TXFLR:
>      case A_RXFLR:
> @@ -769,6 +866,16 @@ static void dwc_ssi_write(void *opaque, hwaddr addr,
>      case A_IMR:
>          dwc_ssi_write_masked(s, R_IMR, value,
>                               DWC_SSI_IMR_WRITABLE_MASK);
> +        dwc_ssi_update_irq(s);
> +        break;
> +    case A_ISR:
> +    case A_RISR:
> +        break;
> +    case A_TXEICR:
> +    case A_RXOICR:
> +    case A_RXUICR:
> +    case A_MSTICR:
> +    case A_ICR:
>          break;
>      case A_IDR:
>      case A_SSIC_VERSION_ID:
> @@ -809,12 +916,15 @@ static void dwc_ssi_enter_reset(Object *obj, ResetT=
ype type)
>      s->phase =3D DWC_SSI_PHASE_IDLE;
>      s->remaining_frames =3D 0;
>      s->dummy_frame =3D 0;
> +    s->irq_latched =3D 0;
>
>      s->regs[R_CTRLR0] =3D DWC_SSI_CTRLR0_RESET;
>      s->regs[R_SR] =3D DWC_SSI_SR_RESET;
>      s->regs[R_IMR] =3D s->cfg.imr_reset & DWC_SSI_IMR_WRITABLE_MASK;
>      s->regs[R_IDR] =3D DWC_SSI_IDR_RESET;
>      s->regs[R_SSIC_VERSION_ID] =3D DWC_SSI_VERSION;
> +
> +    dwc_ssi_update_irq(s);
>  }
>
>  static void dwc_ssi_hold_reset(Object *obj, ResetType type)
> @@ -829,6 +939,13 @@ static void dwc_ssi_hold_reset(Object *obj, ResetTyp=
e type)
>      }
>  }
>
> +static void dwc_ssi_exit_reset(Object *obj, ResetType type)
> +{
> +    DwcSsiState *s =3D DWC_SSI(obj);
> +
> +    dwc_ssi_update_irq(s);
> +}
> +
>  static bool dwc_ssi_fifo_valid(const Fifo32 *fifo, uint32_t depth)
>  {
>      const Fifo8 *fifo8 =3D &fifo->fifo;
> @@ -850,6 +967,9 @@ static int dwc_ssi_post_load(void *opaque, int versio=
n_id)
>      if (s->active_cs < -1 || s->active_cs >=3D (int)s->cfg.num_cs) {
>          return -EINVAL;
>      }
> +    if (s->irq_latched & ~DWC_SSI_IMPLEMENTED_LATCHED_IRQ_MASK) {
> +        return -EINVAL;
> +    }
>      if (!dwc_ssi_fifo_valid(&s->tx_fifo, s->cfg.fifo_depth) ||
>          !dwc_ssi_fifo_valid(&s->rx_fifo, s->cfg.fifo_depth)) {
>          return -EINVAL;
> @@ -878,6 +998,7 @@ static int dwc_ssi_post_load(void *opaque, int versio=
n_id)
>          qemu_irq_lower(s->cs_lines[s->active_cs]);
>      }
>
> +    dwc_ssi_update_irq(s);
>      return 0;
>  }
>
> @@ -893,6 +1014,7 @@ static const VMStateDescription vmstate_dwc_ssi =3D =
{
>          VMSTATE_UINT32_ARRAY(regs, DwcSsiState, DWC_SSI_NUM_REGS),
>          VMSTATE_FIFO32(tx_fifo, DwcSsiState),
>          VMSTATE_FIFO32(rx_fifo, DwcSsiState),
> +        VMSTATE_UINT32(irq_latched, DwcSsiState),
>          VMSTATE_UINT32(phase, DwcSsiState),
>          VMSTATE_UINT32(remaining_frames, DwcSsiState),
>          VMSTATE_UINT32(dummy_frame, DwcSsiState),
> @@ -913,6 +1035,10 @@ static void dwc_ssi_init(Object *obj)
>                            TYPE_DWC_SSI, DWC_SSI_MMIO_SIZE);
>      sysbus_init_mmio(sbd, &s->mmio);
>
> +    for (int i =3D 0; i < DWC_SSI_IRQ_COUNT; i++) {
> +        sysbus_init_irq(sbd, &s->irqs[i]);
> +    }
> +
>      s->active_cs =3D -1;
>  }
>
> @@ -957,6 +1083,7 @@ static void dwc_ssi_class_init(ObjectClass *klass, c=
onst void *data)
>      device_class_set_props(dc, dwc_ssi_properties);
>      rc->phases.enter =3D dwc_ssi_enter_reset;
>      rc->phases.hold =3D dwc_ssi_hold_reset;
> +    rc->phases.exit =3D dwc_ssi_exit_reset;
>  }
>
>  static const TypeInfo dwc_ssi_info =3D {
> diff --git a/include/hw/ssi/dwc_ssi.h b/include/hw/ssi/dwc_ssi.h
> index 6e4f8ea7bb..19499789af 100644
> --- a/include/hw/ssi/dwc_ssi.h
> +++ b/include/hw/ssi/dwc_ssi.h
> @@ -6,7 +6,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
>   * Emulates the DesignWare SSI controller in Standard SPI mode,
> - * covering the PIO/FIFO data path and chip selects.
> + * covering the PIO/FIFO data path, interrupt outputs and chip selects.
>   */
>
>  #ifndef HW_SSI_DWC_SSI_H
> @@ -25,6 +25,20 @@ OBJECT_DECLARE_SIMPLE_TYPE(DwcSsiState, DWC_SSI)
>  #define DWC_SSI_NUM_REGS \
>      (DWC_SSI_REGS_SIZE / sizeof(uint32_t))
>
> +/* SSI GPIO output ordering differs from RISR/ISR bit ordering. */
> +typedef enum DwcSsiIrq {
> +    DWC_SSI_IRQ_TXE,
> +    DWC_SSI_IRQ_TXO,
> +    DWC_SSI_IRQ_RXF,
> +    DWC_SSI_IRQ_RXO,
> +    DWC_SSI_IRQ_TXU,
> +    DWC_SSI_IRQ_RXU,
> +    DWC_SSI_IRQ_MST,
> +    DWC_SSI_IRQ_DONE,
> +    DWC_SSI_IRQ_AXIE,
> +    DWC_SSI_IRQ_COUNT,
> +} DwcSsiIrq;
> +
>  typedef enum DwcSsiPhase {
>      DWC_SSI_PHASE_IDLE,
>      DWC_SSI_PHASE_STANDARD_TX_ONLY,
> @@ -47,6 +61,7 @@ struct DwcSsiState {
>      SSIBus *spi;
>
>      qemu_irq *cs_lines;
> +    qemu_irq irqs[DWC_SSI_IRQ_COUNT];
>
>      Fifo32 tx_fifo;
>      Fifo32 rx_fifo;
> @@ -54,6 +69,7 @@ struct DwcSsiState {
>
>      DwcSsiConfig cfg;
>
> +    uint32_t irq_latched;
>      uint32_t phase;
>      uint32_t remaining_frames;
>      uint32_t dummy_frame;
> --

Regards,
Bin


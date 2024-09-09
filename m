Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55674CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 05:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snWat-0003Bg-42; Mon, 09 Sep 2024 01:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snWar-00038q-3t; Mon, 09 Sep 2024 01:05:41 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snWao-0003kT-Tb; Mon, 09 Sep 2024 01:05:40 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-501274e2c29so1112491e0c.3; 
 Sun, 08 Sep 2024 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725858337; x=1726463137; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdPYXBBzAlxQq7/EU5oaJza7/L5teRiU1X7mBIsS6as=;
 b=K0qklwgRCKU+EmDdkJIVwge97G+cbjJieiaMmemsTRyY+Gqta64F5VJ24uBIzH1eV2
 v995iQ0HOaB0EPHA5setmI2I7prs9IA2qfg7yCkgmfNoA837e43Yt7wkxnjMdgOYrWiG
 CG5fpWlkkzEhXU7F1w3gJ5M6y0s91BASjzyHVZvyOTduy2vxo/SFJFxMzZxUlCX46OSF
 xvmTKrNA+FkKml2rCyMaieSjjjagEZ38WESCf8oIgMrjvfP9GeT72oFRVljSUFQ5oc2/
 OdMJ8lfLexSoCKIK/AZTL47ehyDY8Nq9dydh7+2YfKoqpNfOQrJoIUPM8kH92xwTboCG
 /0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725858337; x=1726463137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdPYXBBzAlxQq7/EU5oaJza7/L5teRiU1X7mBIsS6as=;
 b=kfMnSWImdklGFIKBi4lghk+cXoGsyLHwTR2WU1tvkisal4iE+WCfxOO3LaA241aQ8I
 zg6vc/QrYleTr1yGi3zXFtEFaje/oUxSLiYjkOXNC3erEkJrDj12shPBddtKq/vxGuOS
 LIFFkUKUZZ66EUUn1irsAK9fzWtmTpCsSlb2lkJL3ayv1oHnepFiKB1YANbbTuGowTca
 NNrTt96l2vHU/65kBcxx/+D/UjjfqiHr0Edqaik6nzvhxY1CCG/zFWVK0lYUhwwuwCad
 sMc0JPSP3e6m9DJKLmPxowLgd3G8wlmQEv8XHNTBWQzs24Y2NGXLV8RCmaLxFRAPcsz2
 /dTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf8BBtEkWnApDYya54o47vNXD22W04mS3ju+CUq4dxzyAqb9o1znLTUIOT/DEnYkHYZAjYECGVI2zvTg==@nongnu.org,
 AJvYcCXBdFrVqAHvyvnk8/wMGs8wiCCBLRNMNzO6ae7YmwG8mVGJu8jcY3R7vUYAObdNCMs/JHkJr98DT7mK@nongnu.org
X-Gm-Message-State: AOJu0Yykyz/Ziq/lXZnX54FSI6Sf0V2AHYCvBy3Gae4MyFmY4qbCUnE/
 qFH2mGocZZ5/EsSapfcOvUxK7yPdoj2/ORNMW9YrrWJFzj7bj0UBwztYp9aAJ1tKZunWReINqdt
 EozCo0REZbNZv9ULqAhVLAM1mrV0=
X-Google-Smtp-Source: AGHT+IHEuFernUXL75QnResSnA+8KdsOlF/aJRc7LFuimYeOzkC6I57tJS04irfeUNaU8gbcLhW06LN3bPOVORa7aos=
X-Received: by 2002:a05:6122:7c6:b0:4f5:cd00:e492 with SMTP id
 71dfb90a1353d-50214237825mr11991114e0c.7.1725858337247; Sun, 08 Sep 2024
 22:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <a7604e4d61068ca4d384ae2a1377e1521d4d0235.1725651699.git.tjeznach@rivosinc.com>
In-Reply-To: <a7604e4d61068ca4d384ae2a1377e1521d4d0235.1725651699.git.tjeznach@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 15:05:10 +1000
Message-ID: <CAKmqyKNqUa8MkJQtq-0Td1aHniCfSihW8FMhSoeTMXySnBd9ug@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: riscv-imsic: Fix interrupt state updates.
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 7, 2024 at 6:24=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.co=
m> wrote:
>
> The IMSIC state variable eistate[] is modified by CSR instructions
> within a range dedicated to the local CPU and by MMIO writes from any CPU=
.
> Access to eistate from MMIO accessors is protected by the BQL, but
> read-modify-write (RMW) sequences from CSRRW do not acquire the BQL,
> making the RMW sequence vulnerable to a race condition with MMIO access
> from a remote CPU.
>
> This race can manifest as missing IPI or MSI in multi-CPU systems, eg:
>
> [   43.008092] watchdog: BUG: soft lockup - CPU#2 stuck for 27s! [kworker=
/u19:1:52]
> [   43.011723] CPU: 2 UID: 0 PID: 52 Comm: kworker/u19:1 Not tainted 6.11=
.0-rc6
> [   43.013070] Workqueue: events_unbound deferred_probe_work_func
> [   43.018776] [<ffffffff800b4a86>] smp_call_function_many_cond+0x190/0x5=
c2
> [   43.019205] [<ffffffff800b4f28>] on_each_cpu_cond_mask+0x20/0x32
> [   43.019447] [<ffffffff8001069a>] __flush_tlb_range+0xf2/0x190
> [   43.019683] [<ffffffff80010914>] flush_tlb_kernel_range+0x20/0x28
>
> The interrupt line raise/lower sequence was changed to prevent a race
> between the evaluation of the eistate and the execution of the qemu_irq
> raise/lower, ensuring that the interrupt line is not incorrectly
> deactivated based on a stale topei check result. To avoid holding BQL
> all modifications of eistate are converted to atomic operations.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_imsic.c | 50 +++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index b90f0d731d..9ef65d4012 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -55,7 +55,7 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *imsi=
c, uint32_t page)
>                 (imsic->eithreshold[page] <=3D imsic->num_irqs)) ?
>                 imsic->eithreshold[page] : imsic->num_irqs;
>      for (i =3D 1; i < max_irq; i++) {
> -        if ((imsic->eistate[base + i] & IMSIC_EISTATE_ENPEND) =3D=3D
> +        if ((qatomic_read(&imsic->eistate[base + i]) & IMSIC_EISTATE_ENP=
END) =3D=3D
>                  IMSIC_EISTATE_ENPEND) {
>              return (i << IMSIC_TOPEI_IID_SHIFT) | i;
>          }
> @@ -66,10 +66,24 @@ static uint32_t riscv_imsic_topei(RISCVIMSICState *im=
sic, uint32_t page)
>
>  static void riscv_imsic_update(RISCVIMSICState *imsic, uint32_t page)
>  {
> +    uint32_t base =3D page * imsic->num_irqs;
> +
> +    /*
> +     * Lower the interrupt line if necessary, then evaluate the current
> +     * IMSIC state.
> +     * This sequence ensures that any race between evaluating the eistat=
e and
> +     * updating the interrupt line will not result in an incorrectly
> +     * deactivated connected CPU IRQ line.
> +     * If multiple interrupts are pending, this sequence functions ident=
ically
> +     * to qemu_irq_pulse.
> +     */
> +
> +    if (qatomic_fetch_and(&imsic->eistate[base], ~IMSIC_EISTATE_ENPEND))=
 {
> +        qemu_irq_lower(imsic->external_irqs[page]);
> +    }
>      if (imsic->eidelivery[page] && riscv_imsic_topei(imsic, page)) {
>          qemu_irq_raise(imsic->external_irqs[page]);
> -    } else {
> -        qemu_irq_lower(imsic->external_irqs[page]);
> +        qatomic_or(&imsic->eistate[base], IMSIC_EISTATE_ENPEND);
>      }
>  }
>
> @@ -125,12 +139,11 @@ static int riscv_imsic_topei_rmw(RISCVIMSICState *i=
msic, uint32_t page,
>          topei >>=3D IMSIC_TOPEI_IID_SHIFT;
>          base =3D page * imsic->num_irqs;
>          if (topei) {
> -            imsic->eistate[base + topei] &=3D ~IMSIC_EISTATE_PENDING;
> +            qatomic_and(&imsic->eistate[base + topei], ~IMSIC_EISTATE_PE=
NDING);
>          }
> -
> -        riscv_imsic_update(imsic, page);
>      }
>
> +    riscv_imsic_update(imsic, page);
>      return 0;
>  }
>
> @@ -139,7 +152,7 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsic=
,
>                                 uint32_t num, bool pend, target_ulong *va=
l,
>                                 target_ulong new_val, target_ulong wr_mas=
k)
>  {
> -    uint32_t i, base;
> +    uint32_t i, base, prev;
>      target_ulong mask;
>      uint32_t state =3D (pend) ? IMSIC_EISTATE_PENDING : IMSIC_EISTATE_EN=
ABLED;
>
> @@ -157,10 +170,6 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *imsi=
c,
>
>      if (val) {
>          *val =3D 0;
> -        for (i =3D 0; i < xlen; i++) {
> -            mask =3D (target_ulong)1 << i;
> -            *val |=3D (imsic->eistate[base + i] & state) ? mask : 0;
> -        }
>      }
>
>      for (i =3D 0; i < xlen; i++) {
> @@ -172,10 +181,15 @@ static int riscv_imsic_eix_rmw(RISCVIMSICState *ims=
ic,
>          mask =3D (target_ulong)1 << i;
>          if (wr_mask & mask) {
>              if (new_val & mask) {
> -                imsic->eistate[base + i] |=3D state;
> +                prev =3D qatomic_fetch_or(&imsic->eistate[base + i], sta=
te);
>              } else {
> -                imsic->eistate[base + i] &=3D ~state;
> +                prev =3D qatomic_fetch_and(&imsic->eistate[base + i], ~s=
tate);
>              }
> +        } else {
> +            prev =3D qatomic_read(&imsic->eistate[base + i]);
> +        }
> +        if (val && (prev & state)) {
> +            *val |=3D mask;
>          }
>      }
>
> @@ -302,14 +316,14 @@ static void riscv_imsic_write(void *opaque, hwaddr =
addr, uint64_t value,
>      page =3D addr >> IMSIC_MMIO_PAGE_SHIFT;
>      if ((addr & (IMSIC_MMIO_PAGE_SZ - 1)) =3D=3D IMSIC_MMIO_PAGE_LE) {
>          if (value && (value < imsic->num_irqs)) {
> -            imsic->eistate[(page * imsic->num_irqs) + value] |=3D
> -                                                    IMSIC_EISTATE_PENDIN=
G;
> +            qatomic_or(&imsic->eistate[(page * imsic->num_irqs) + value]=
,
> +                       IMSIC_EISTATE_PENDING);
> +
> +            /* Update CPU external interrupt status */
> +            riscv_imsic_update(imsic, page);
>          }
>      }
>
> -    /* Update CPU external interrupt status */
> -    riscv_imsic_update(imsic, page);
> -
>      return;
>
>  err:
>
> base-commit: fd1952d814da738ed107e05583b3e02ac11e88ff
> --
> 2.34.1
>
>


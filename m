Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951C2C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOmT-0004dz-Jf; Sun, 23 Feb 2025 22:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOmQ-0004dE-PC; Sun, 23 Feb 2025 22:05:14 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOmO-00024u-R2; Sun, 23 Feb 2025 22:05:14 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4be75b2bbceso1360042137.1; 
 Sun, 23 Feb 2025 19:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740366311; x=1740971111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT+vyUjKEXI4nWchaFCzvC3t5+xFsAqweXULi30klzg=;
 b=QyXmzW/zqx719Kv6aDpI/pM7UsDpl8b4iiRefbEBHt0i5Xdt/Io40zHVhS60fGYERp
 ypV8TmH640l6StR/sw78LD8WwTLZJ97z6ZDXRCOZJv/NRSTQI7eWL7nJ3HFwqVrN3WuC
 zmcy7hzKlfcevZuVLHEf5NnEol5eOlTaXxg94c0WGy22zWuseosZbbRybleL7bpxwdvt
 IfiJf0NfCJwuPeNMgNnoUdkM9rJaY36olNoYuOi2v/TYDN6dDePqC2uOJj36KJjigMpL
 7rl08lj4ogo75nP3oTTIWgddJoBl2i4KINxgvaBGus/o057KXWLypytK93V/VwaHyeag
 MP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740366311; x=1740971111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PT+vyUjKEXI4nWchaFCzvC3t5+xFsAqweXULi30klzg=;
 b=M1Ek+JBXJU7U0pnwBUfODJKxB9DDG6PGcZ7Agz26TUK4TJ0WBOz703BpK0DGLO64Py
 n6z3BT2zEPrfg0LDqUfXDIm4XKnwZZ0ijR1i5BIlXnYmfFQ2dZKkmG+T7BML90MwvME5
 CgJz3ZxpESVXx5phMSR1kiF1FNvSCC8Rr6/se39X3Rs15ZUly17G5jmIERh/+bp3r97f
 6MHLVJfBk5bunFa2N+X6GluwQQT82+KjfkIffcLQP+nwUDg3L9/er9wzbYsLectVQQDC
 /vG87NdFCsuTDLDzYOpU/LNomZZcSOMYDRIFe8yG7ZH3oHuy8OL9NceM+6QTfMyGSeNI
 xAmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG42TvREGb6ufJ9LFQW1fFst9Yzuxh+/BmmvfIhTdmYI6tQBD7KzWGzoDIUnj+f9mXbwKwOZ3yy5R1@nongnu.org
X-Gm-Message-State: AOJu0YxRf+/Eg+UMDe9Q/60jyEMai7VoJgSWxOZ2XObw8SsiIHXm5PpP
 XKF0bZzZP1pqOkcPWWYvfrv1KIc5XGIcZ9K98tsefE3p5ssvodE+K86P+v59aQQ4AmTr65bVJdC
 WyPzQjyn3eLdUW2filha0Z0Fa3Vw=
X-Gm-Gg: ASbGncvvqIMpzoa40UqCEAyySaVcLBWEnU3sV5MNcAVQptVCfcW4cQOBvUG5OGELU2+
 2uoTNyvEJcHw419T3JAJL/pPzTs2v9d+RQxEABIC7RWAHa6FcXLlIs60sc4Y5CslLeZJeOeRJiN
 8/J0pXLMDrYn6dFdRN9Gpd6PPmEc1N1h6LwCZi
X-Google-Smtp-Source: AGHT+IH779+7QmUS1YusByDZlVPqcYRpC+JRoDH44w9qmbsc2tG1XylqC646kW+2DNt5wEu5zXq2lddvsKLrgaUCxys=
X-Received: by 2002:a05:6102:e13:b0:4bb:c527:aacd with SMTP id
 ada2fe7eead31-4bfc29545f4mr5022692137.23.1740366311013; Sun, 23 Feb 2025
 19:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-7-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:04:45 +1000
X-Gm-Features: AWEUYZmC9ofoyeGFb-GRx1OnEnbKJZx010-r_T9abGV6UTiz4B5OHFOtg2zu9bA
Message-ID: <CAKmqyKPCOSYxGCtVmoAZhA1fQyimdSDb=cMJiu3TiWQbcAZnDg@mail.gmail.com>
Subject: Re: [PATCH for-10.0 06/11] hw/riscv/riscv-iommu: add IOCOUNTINH mmio
 writes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Thu, Dec 5, 2024 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> RISCV_IOMMU_REG_IOCOUNTINH is done by riscv_iommu_process_iocntinh_cy(),
> which is called during riscv_iommu_mmio_write() callback via a new
> riscv_iommu_pricess_hpm_writes() helper.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 60 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h |  1 +
>  hw/riscv/riscv-iommu.c     | 38 ++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 325088333e..70814b942d 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -202,3 +202,63 @@ void riscv_iommu_hpm_timer_cb(void *priv)
>          riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
>      }
>  }
> +
> +static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
> +{
> +    const uint32_t inhibit =3D riscv_iommu_reg_get32(
> +        s, RISCV_IOMMU_REG_IOCOUNTINH);
> +    uint64_t overflow_at, overflow_ns;
> +
> +    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
> +        return;
> +    }
> +
> +    /*
> +     * We are using INT64_MAX here instead to UINT64_MAX because cycle c=
ounter
> +     * has 63-bit precision and INT64_MAX is the maximum it can store.
> +     */
> +    if (value) {
> +        overflow_ns =3D INT64_MAX - value + 1;
> +    } else {
> +        overflow_ns =3D INT64_MAX;
> +    }
> +
> +    overflow_at =3D (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ov=
erflow_ns;
> +
> +    if (overflow_at > INT64_MAX) {
> +        s->irq_overflow_left =3D overflow_at - INT64_MAX;
> +        overflow_at =3D INT64_MAX;
> +    }
> +
> +    timer_mod_anticipate_ns(s->hpm_timer, overflow_at);
> +}
> +
> +/* Updates the internal cycle counter state when iocntinh:CY is changed.=
 */
> +void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_in=
h)
> +{
> +    const uint32_t inhibit =3D riscv_iommu_reg_get32(
> +        s, RISCV_IOMMU_REG_IOCOUNTINH);
> +
> +    /* We only need to process CY bit toggle. */
> +    if (!(inhibit ^ prev_cy_inh)) {
> +        return;
> +    }
> +
> +    if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
> +        /*
> +         * Cycle counter is enabled. Just start the timer again and upda=
te
> +         * the clock snapshot value to point to the current time to make
> +         * sure iohpmcycles read is correct.
> +         */
> +        s->hpmcycle_prev =3D get_cycles();
> +        hpm_setup_timer(s, s->hpmcycle_val);
> +    } else {
> +        /*
> +         * Cycle counter is disabled. Stop the timer and update the cycl=
e
> +         * counter to record the current value which is last programmed
> +         * value + the cycles passed so far.
> +         */
> +        s->hpmcycle_val =3D s->hpmcycle_val + (get_cycles() - s->hpmcycl=
e_prev);
> +        timer_del(s->hpm_timer);
> +    }
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index cd896d3b7c..ee888650fb 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -26,5 +26,6 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
>  void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx=
,
>                                unsigned event_id);
>  void riscv_iommu_hpm_timer_cb(void *priv);
> +void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_in=
h);
>
>  #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 2ec388ff3d..56ec2d6d42 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1923,6 +1923,27 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUStat=
e *s, uint64_t data)
>      riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
>  }
>
> +static void riscv_iommu_process_hpm_writes(RISCVIOMMUState *s,
> +                                           uint32_t regb,
> +                                           bool prev_cy_inh)
> +{
> +    switch (regb) {
> +    case RISCV_IOMMU_REG_IOCOUNTINH:
> +        riscv_iommu_process_iocntinh_cy(s, prev_cy_inh);
> +        break;
> +
> +    case RISCV_IOMMU_REG_IOHPMCYCLES:
> +    case RISCV_IOMMU_REG_IOHPMCYCLES + 4:
> +        /* not yet implemented */
> +        break;
> +
> +    case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
> +        RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
> +        /* not yet implemented */
> +        break;
> +    }
> +}
> +
>  /*
>   * Write the resulting value of 'data' for the reg specified
>   * by 'reg_addr', after considering read-only/read-write/write-clear
> @@ -1950,6 +1971,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opa=
que, hwaddr addr,
>      uint32_t regb =3D addr & ~3;
>      uint32_t busy =3D 0;
>      uint64_t val =3D 0;
> +    bool cy_inh =3D false;
>
>      if ((addr & (size - 1)) !=3D 0) {
>          /* Unsupported MMIO alignment or access size */
> @@ -2017,6 +2039,16 @@ static MemTxResult riscv_iommu_mmio_write(void *op=
aque, hwaddr addr,
>          busy =3D RISCV_IOMMU_TR_REQ_CTL_GO_BUSY;
>          break;
>
> +    case RISCV_IOMMU_REG_IOCOUNTINH:
> +        if (addr !=3D RISCV_IOMMU_REG_IOCOUNTINH) {
> +            break;
> +        }
> +        /* Store previous value of CY bit. */
> +        cy_inh =3D !!(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTIN=
H) &
> +            RISCV_IOMMU_IOCOUNTINH_CY);
> +        break;
> +
> +
>      default:
>          break;
>      }
> @@ -2035,6 +2067,12 @@ static MemTxResult riscv_iommu_mmio_write(void *op=
aque, hwaddr addr,
>          stl_le_p(&s->regs_rw[regb], rw | busy);
>      }
>
> +    /* Process HPM writes and update any internal state if needed. */
> +    if (regb >=3D RISCV_IOMMU_REG_IOCOUNTOVF &&
> +        regb <=3D (RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4=
)) {
> +        riscv_iommu_process_hpm_writes(s, regb, cy_inh);
> +    }
> +
>      if (process_fn) {
>          process_fn(s);
>      }
> --
> 2.47.1
>
>


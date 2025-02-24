Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E478C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPE8-0007sX-IJ; Sun, 23 Feb 2025 22:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPE7-0007qK-Ca; Sun, 23 Feb 2025 22:33:51 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPE5-00056R-Q1; Sun, 23 Feb 2025 22:33:51 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-868e8ce3f73so1095872241.3; 
 Sun, 23 Feb 2025 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740368028; x=1740972828; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5X857c406PjEoUmuuZPiFDUO0HRHEIsdMuU6YoGIyQ=;
 b=QAf8xJcvtfO8HqL7W8wD178nLM96ng8CTR0JVNahfhHnzHq/lHEG/g02uUqPmQSD5s
 /2c4TQT+677AmAT2qauIpuk/ZrCekD1zazO0jAbu5QJBBxUTkOekvXP6RLOL7Oxmqjsl
 fo+z+pcEUqU+8LL8OYxDGVYiBmkPQ29c5Jd5fHJeatfQcTV7t8QUMmJCMLPGvN0AbKKR
 d/zA3qaBklpb0l3xbZg/OIiZ8bxeSZ6fGZHQ/CRGpD7YvHbwU/EqT/y7okhaYPv9GQjw
 fha45P9oW9y9v/CwSX/21Vc8OtEf4ZIt8X2+dvPk778yq2CwIdLJukX5zY/Sfgi+5YN6
 Ls5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740368028; x=1740972828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5X857c406PjEoUmuuZPiFDUO0HRHEIsdMuU6YoGIyQ=;
 b=shso2UGhfc7kki9Z99VWcOt43OZ9srLo2Vx5G7zdGUG/OoPzyVzSDKvMY8lvXOvvi3
 AsszndVQAufl8DUeqwGvp4lWrlR4jG5QHoDfSYWx89FHt5AP/OxWoxiEzjHGLBNfwAoq
 BhciEuBZqNFdkJYWX0E7lu8FIvsG3oBWbql1L0RapxONinnyzfL/+27Pj9DEUtV0sTu7
 ZYBVv7qLuKCAqxEpee0Wb54i9f5AprwxKhvGPm3sE8Kc7fmzqkHMdJiYZuM0vc0Rtcdb
 3B/agfIXsVBruBPowZrK4F9+MTioE9k6xle8z7hfSCZvwRHF4C8MeroArJz0DpRjQQtw
 Pdxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0lUk9OB8U7rCUj9a6aSf4owsxUyrAgp03WFUyrmWhdlt/LILed/jE14HdQUuY0jeUcHwHbUHjSczF@nongnu.org
X-Gm-Message-State: AOJu0YwcVESnqkHJV0VFEqu2qEMZ6TGs0oMhoNmyGCrS6rI/rmhGYeKB
 tu/wjPjn1Qcq8HDNup/bZDK5ENgeAzrWrB+ftmB6F9tk3lBVXWxL95vOpStAVu/XggawNtDaM+p
 HUeQJjNzt4M5Fnaokr4I0Xl4g7X8=
X-Gm-Gg: ASbGncs2VJKMACoaMC1z9uDKtLpCc+FPisMdnsLRO5CvRndJwX7wJq5QBlkbvnxNv16
 7knESi08k5mZPQEQKQJiDDhm9ZzPXFCrAQkhnum6uYpf1/icFuReL83r9ZY4q98p0AySsy6QzNy
 U38pDH0Hb9Oy9/gGNDPbQLPlGQEO9C4iMe46bq
X-Google-Smtp-Source: AGHT+IGiIKRK042rf+DgzcUv4/PmhKdA0Vqvrvf+f6EROVW2S5uiT5scnho9W9JGt4R1rCjfHR40oEqLh07s1Z0Q9Nc=
X-Received: by 2002:a05:6122:3903:b0:520:3465:7302 with SMTP id
 71dfb90a1353d-521ee2a27c3mr5701441e0c.5.1740368028417; Sun, 23 Feb 2025
 19:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-11-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-11-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:33:22 +1000
X-Gm-Features: AWEUYZkAN8sHGbWusL5tozgLhsZHWbe9h_pBsyRtdyuyweg77AYp1yzIzn_EQRM
Message-ID: <CAKmqyKMfvz1SgtKE4YY8JGmN1JdCW2zQJj8eQtFD0Gdr9Cm6nw@mail.gmail.com>
Subject: Re: [PATCH for-10.0 10/11] hw/riscv: add IOMMU HPM trace events
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Thu, Dec 5, 2024 at 11:34=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a handful of trace events to allow for an easier time debugging the
> HPM feature.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 10 ++++++++++
>  hw/riscv/trace-events      |  5 +++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 5518c287a5..c5034bff79 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -39,6 +39,8 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
>      const uint64_t ctr_prev =3D s->hpmcycle_prev;
>      const uint64_t ctr_val =3D s->hpmcycle_val;
>
> +    trace_riscv_iommu_hpm_read(cycle, inhibit, ctr_prev, ctr_val);
> +
>      if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
>          /*
>           * Counter should not increment if inhibit bit is set. We can't =
really
> @@ -61,6 +63,8 @@ static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t c=
tr_idx)
>      cntr_val =3D ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + of=
f]);
>      stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val =
+ 1);
>
> +    trace_riscv_iommu_hpm_incr_ctr(cntr_val);
> +
>      /* Handle the overflow scenario. */
>      if (cntr_val =3D=3D UINT64_MAX) {
>          /*
> @@ -244,6 +248,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState =
*s, bool prev_cy_inh)
>          return;
>      }
>
> +    trace_riscv_iommu_hpm_iocntinh_cy(prev_cy_inh);
> +
>      if (!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY)) {
>          /*
>           * Cycle counter is enabled. Just start the timer again and upda=
te
> @@ -268,6 +274,8 @@ void riscv_iommu_process_hpmcycle_write(RISCVIOMMUSta=
te *s)
>      const uint64_t val =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_IOHP=
MCYCLES);
>      const uint32_t ovf =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCO=
UNTOVF);
>
> +    trace_riscv_iommu_hpm_cycle_write(ovf, val);
> +
>      /*
>       * Clear OF bit in IOCNTOVF if it's being cleared in IOHPMCYCLES reg=
ister.
>       */
> @@ -352,6 +360,8 @@ void riscv_iommu_process_hpmevt_write(RISCVIOMMUState=
 *s, uint32_t evt_reg)
>          return;
>      }
>
> +    trace_riscv_iommu_hpm_evt_write(ctr_idx, ovf, val);
> +
>      /* Clear OF bit in IOCNTOVF if it's being cleared in IOHPMEVT regist=
er. */
>      if (get_field(ovf, BIT(ctr_idx + 1)) &&
>          !get_field(val, RISCV_IOMMU_IOHPMEVT_OF)) {
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index aaa2c0eb94..846f5f19c7 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -19,3 +19,8 @@ riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to =
vector %u"
>  riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t ms=
i_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_data 0x%=
x result %u"
>  riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
>  riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
> +riscv_iommu_hpm_read(uint64_t cycle, uint32_t inhibit, uint64_t ctr_prev=
, uint64_t ctr_val) "cycle 0x%lx inhibit 0x%x ctr_prev 0x%lx ctr_val 0x%lx"
> +riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%lx"
> +riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
> +riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x=
%lx"
> +riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) =
"ctr_idx 0x%x ovf 0x%x val 0x%lx"
> --
> 2.47.1
>
>


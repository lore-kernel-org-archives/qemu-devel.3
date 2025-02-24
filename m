Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89411C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPDi-0007cJ-Tp; Sun, 23 Feb 2025 22:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPDf-0007ba-NR; Sun, 23 Feb 2025 22:33:25 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPDe-00054d-6M; Sun, 23 Feb 2025 22:33:23 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86712bc0508so1109247241.2; 
 Sun, 23 Feb 2025 19:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740368000; x=1740972800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqdCZ5MaAlSF9nTQC1MacO3rNySE2hJnHZbCENXnbhA=;
 b=bf3e29pvIKkByBUOKTRaMCxQuf5/J6j8AM4LtyiXn4d2omgGgtR5prkDB9iamsVPns
 9OUgr3TgjHIpAegkiSdNU1Oqr4m2bt4cKwKDQVG2OMD3GvfwlwPSfwGfr4HY6OYodYpF
 2PJdY4dNQLRRmEl31dIOqpdxyQ5OEYuq4bGHl2kEBKh+73Ur+25xw42ENMSf9ERXvYmZ
 dFwc4WY1B/nysoWq/GUBsrKlw2M528Hj10r17Y4ZwvvwOzSoD2rbF6MeDLTuoBmtnPOa
 iOnpKpLB8Mh5Ex9IX5Y/xGisocuUIzpRntsYwgKPeJs1xg49pm6tuIfEI0QaXAV96+xv
 9Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740368000; x=1740972800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqdCZ5MaAlSF9nTQC1MacO3rNySE2hJnHZbCENXnbhA=;
 b=iVBEWDaVNrN4PTVvzPMlAnEjX7aGmXmBDIJkkXkTO8UILRjBHZlBhZw+yWeqJjMku5
 YLUhk9uHchi69cCq3ynoVXB7RU5CalF5dEuXP08E3NRCmy13OZMjhjbpO07OV8U1QZWA
 /xLlSKxKQJgFi+/TEUzaccwercU33iCjpHUxxH/+FVoABKBF3jC2u0rrFcYTCHHel8WJ
 UfRWkHT7kpOc+brmgYfDkdFQmlUN0zzoYx1mIj+yxxe0NTp5iBu1TYNfUOdQy8dPT6cG
 sIzHt8B1ex/gJ+T7H66OOyQfdCfPLkHuodg5aoGKUJ+MvzaFqOC6mmRl38PSYLuo9yBo
 IZjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2V2S80wotdeAASvMC6tzZcrOyqH5+hbcwUsfTJujMGl//TSfk5Lsqu1uPqwOLMnEYct3E8vDPuOmq@nongnu.org
X-Gm-Message-State: AOJu0YxumHqgbvn+jUWd0dENqJUWCNbWI4homW06h03dqqlClNsYhIiM
 fDqIYjW//27U4mccYsGPfCfei15HKhVTUHgUjndC0eyV7Y8kjnzKtPRfd+Efo5qkFqAoN+GZ8Jp
 L2pEVZUltClH99u7hHW7G7PSz60k=
X-Gm-Gg: ASbGnct6GsubC8UEFwWNo1II7D19RYnR5Eu/WmAAIGG+FW4NDx9s5GP4cgLvEPX2XxE
 fD34JkC0cmJDUrOpquq3t7XzUD+v13x4xJoeh7QCxlIk5L+yye3sLKc8a7XgwHUA1VWX5+D3FAQ
 cYYKYbXDk/GdEKHRGa9vSJxBckfgIEKmr+J/Ll
X-Google-Smtp-Source: AGHT+IEIlzLY1jPpx41Sz6a+tGKmX93ZAh/HuO2Wb1ePt2xiv4nevjHSBtt47jyRZ/bDmruuUHuNZkb0JCJ6DQ+jazk=
X-Received: by 2002:a05:6102:32d3:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4bfc01c63c8mr4548142137.25.1740367999738; Sun, 23 Feb 2025
 19:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-10-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-10-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:32:53 +1000
X-Gm-Features: AWEUYZmuXyTXpgXSz9y2RZnFTX5yuDE0PfYQkBjoAS7EOmTk6Su_xrgWx34t0fA
Message-ID: <CAKmqyKO7OL5N7HHLFPPP1OQMMvF6KjP3ftPUNnoqi7ndWgXroQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 09/11] hw/riscv/riscv-iommu.c: add
 RISCV_IOMMU_CAP_HPM cap
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Now that we have every piece in place we can advertise CAP_HTM to
> software, allowing any HPM aware driver to make use of the counters.
>
> HPM is enabled/disabled via the 'hpm-counters' attribute. Default value
> is 31, max value is also 31. Setting it to zero will disable HPM
> support.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 83cd529844..7df40900b0 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2256,6 +2256,15 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>                    RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
>      }
>
> +    if (s->hpm_cntrs > 0) {
> +        /* Clip number of HPM counters to maximum supported (31). */
> +        if (s->hpm_cntrs > RISCV_IOMMU_IOCOUNT_NUM) {
> +            s->hpm_cntrs =3D RISCV_IOMMU_IOCOUNT_NUM;
> +        }
> +        /* Enable hardware performance monitor interface */
> +        s->cap |=3D RISCV_IOMMU_CAP_HPM;
> +    }
> +
>      /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrou=
gh) */
>      s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
>                          RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MOD=
E_BARE);
> @@ -2303,6 +2312,18 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>              RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
>      }
>
> +    /* If HPM registers are enabled. */
> +    if (s->cap & RISCV_IOMMU_CAP_HPM) {
> +        /* +1 for cycle counter bit. */
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOCOUNTINH],
> +                 ~((2 << s->hpm_cntrs) - 1));
> +        stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCYCLES], 0);
> +        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMCTR_BASE],
> +               0x00, s->hpm_cntrs * 8);
> +        memset(&s->regs_ro[RISCV_IOMMU_REG_IOHPMEVT_BASE],
> +               0x00, s->hpm_cntrs * 8);
> +    }
> +
>      /* Memory region for downstream access, if specified. */
>      if (s->target_mr) {
>          s->target_as =3D g_new0(AddressSpace, 1);
> --
> 2.47.1
>
>


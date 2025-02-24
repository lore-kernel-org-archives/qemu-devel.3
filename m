Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24821C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNvk-0001oO-4P; Sun, 23 Feb 2025 21:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNvd-0001nb-60; Sun, 23 Feb 2025 21:10:42 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNva-0005fi-U6; Sun, 23 Feb 2025 21:10:40 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-8670d630d2dso1048935241.1; 
 Sun, 23 Feb 2025 18:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740363036; x=1740967836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EF6KQatkOvGENQcOFYVdjBYW4b0hNEXZxdZDE3g6a84=;
 b=LgM6RHVWUwHOmeKXPF8UXbDT99P16p1R3w5rJ3MD+st1slLSN9Z7kt7syyNiqRiIuT
 Lp8lCCjfVNvv0LHQAltBKmQJGsaUQxBSvC0I0kjmkIPYzKrLsQGTrvF7ZGgC4yk5fFaF
 LmXvTL+c1MrqjQ8j2oDLIQjwtTJ5G50h7YtsiS0NsoxUZ2hatoQK2W8prXshB6KQi1Wa
 wWltjwubKHg65/ZhYQcZEO1IuznASBMBGzIhob7y/8tQDwbj2laPLFVFSqcnX008dE2Z
 1qrTBbCyg82RUgup83bjyBl6bqOFKkB2/X8mojxwUcRrC5raoX6p4TIwvNTKj3FGoriv
 V5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740363036; x=1740967836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EF6KQatkOvGENQcOFYVdjBYW4b0hNEXZxdZDE3g6a84=;
 b=r8mx/o2j8oAtMBFyqM86kjiUUMIEL5RPgB/TEmCZ7HtxPlb7+CN0xjVRkZfMUHU690
 3o3qujzlJrBUdJOI8LjlOKXHEXBOu8lQHiJyYwS0asz8EhBYk7q6U2g3w2TZN9lpzNND
 V0LUONAvIoaMZg+m7SJQoKn1k2KZLn1+ikoYw95jLGM0Km0J/cFGTt/t1/feZ4F2JGE/
 jibl5M3zVBBNm8ekXMAuFQG62OFUpz4BVbzHvHiXlQ3RFKLJbXlL3sLtTMo+WpOx7Zdh
 Qwc51eGyuBD2EXsHmG8rTs53q0z2JRG/FdtE5usTkBW+dLyd0/0dSso203aabbyB+Z4W
 +kdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkObhOVh2XJqoMYab8ZGHu9CiUA4l3eMXC/d1Y9luFgmBousd1AXdyZEuAXVRJ0Z5pKf9dbjOO7Uh3@nongnu.org
X-Gm-Message-State: AOJu0YwogkmY6z5x2LIvuZzTnF6d09YC+5sZ9+htv5+YnODYsuvsA9oW
 ayOjtUhO055nQ7COCIPZWz65kj/K+wtWt1qcij/5ZVg4kSAi/xkzCVVUZeua/0DKVxxORkYZUSQ
 wezogszr6FVSgwsYSitJdauZMYNY=
X-Gm-Gg: ASbGncsvkkxpLaTMgoa4Ckzy2+wp0N/pTp8YS1ERhveCHI5+JZ1OblXNpnPYbZKkVJ8
 aQhCMNHbNdmTck7muLZXi1GiCCeP6D9WygS07SlC4QK+cF5BziP8H3Pxz7bBs/On7ojarZLXbx4
 udjGE6UvAvkAEfYYFMnCRS+sNjCrU2CQuvWfgf
X-Google-Smtp-Source: AGHT+IEyEKWVRU88Z2BuoLzF797ZkJvN1wbz1lQEqeT4mV/rZk7TApef/nDjk1/vmVaUvcpn2AJeYdVqX9cxDI8un7M=
X-Received: by 2002:a05:6122:201a:b0:51f:fc9d:875d with SMTP id
 71dfb90a1353d-521efd1be4amr5049280e0c.8.1740363036501; Sun, 23 Feb 2025
 18:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:10:10 +1000
X-Gm-Features: AWEUYZn256VEqGLCbmveiHpWnqnJDckTxoNEo7ZuvtnkkVgVHNx2RrBhCcNu_Xg
Message-ID: <CAKmqyKNPzb+xYUmgwx2mWu1egUso3S15ErwYmz8ATkDrKhdhCw@mail.gmail.com>
Subject: Re: [PATCH for-10.0 02/11] hw/riscv/riscv-iommu-bits.h: HPM bits
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Thu, Dec 5, 2024 at 11:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Add the relevant HPM (High Performance Monitor) bits that we'll be using
> in the next patches.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 485f36b9c9..298a060085 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -82,6 +82,7 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>  #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> +#define RISCV_IOMMU_CAP_HPM             BIT_ULL(30)
>  #define RISCV_IOMMU_CAP_DBG             BIT_ULL(31)
>  #define RISCV_IOMMU_CAP_PAS             GENMASK_ULL(37, 32)
>  #define RISCV_IOMMU_CAP_PD8             BIT_ULL(38)
> @@ -191,6 +192,52 @@ enum {
>      RISCV_IOMMU_INTR_COUNT
>  };
>
> +#define RISCV_IOMMU_IOCOUNT_NUM         31
> +
> +/* 5.19 Performance monitoring counter overflow status (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTOVF      0x0058
> +#define RISCV_IOMMU_IOCOUNTOVF_CY       BIT(0)
> +
> +/* 5.20 Performance monitoring counter inhibits (32bits) */
> +#define RISCV_IOMMU_REG_IOCOUNTINH      0x005C
> +#define RISCV_IOMMU_IOCOUNTINH_CY       BIT(0)
> +
> +/* 5.21 Performance monitoring cycles counter (64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER GENMASK_ULL(62, 0)
> +#define RISCV_IOMMU_IOHPMCYCLES_OVF     BIT_ULL(63)
> +
> +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMCTR_BASE   0x0068
> +#define RISCV_IOMMU_REG_IOHPMCTR(_n)    \
> +    (RISCV_IOMMU_REG_IOHPMCTR_BASE + (_n * 0x8))
> +
> +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> +#define RISCV_IOMMU_REG_IOHPMEVT_BASE   0x0160
> +#define RISCV_IOMMU_REG_IOHPMEVT(_n)    \
> +    (RISCV_IOMMU_REG_IOHPMEVT_BASE + (_n * 0x8))
> +#define RISCV_IOMMU_IOHPMEVT_EVENT_ID   GENMASK_ULL(14, 0)
> +#define RISCV_IOMMU_IOHPMEVT_DMASK      BIT_ULL(15)
> +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID  GENMASK_ULL(35, 16)
> +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID  GENMASK_ULL(59, 36)
> +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV    BIT_ULL(60)
> +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV    BIT_ULL(61)
> +#define RISCV_IOMMU_IOHPMEVT_IDT        BIT_ULL(62)
> +#define RISCV_IOMMU_IOHPMEVT_OF         BIT_ULL(63)
> +
> +enum RISCV_IOMMU_HPMEVENT_id {
> +    RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> +    RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> +    RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> +    RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> +    RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> +    RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> +    RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> +    RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> +    RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> +    RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> +};
> +
>  /* 5.24 Translation request IOVA (64bits) */
>  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
>
> --
> 2.47.1
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C04FC3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOoYX-0005j2-5u; Tue, 02 Jul 2024 21:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoYU-0005iT-W1; Tue, 02 Jul 2024 21:13:07 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOoYQ-00012o-2v; Tue, 02 Jul 2024 21:13:05 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4f2db3a59a5so89640e0c.0; 
 Tue, 02 Jul 2024 18:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719969180; x=1720573980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVZKFwEDodws2MPl22wNiaqOGt5kTFTXYePutgY3h6g=;
 b=UpbSHNZQGX+exFsfjTwWsegyabp0KKfYjskwwkVVLY85Sa4kOCTAna2T2pfiIkGMck
 wpJGZ0FktauylBYoZJfisARgD4ioENniLogT2paTnPXxUmneI+BS3jDNif4QB2BdQQeo
 05bXF3N/5BcvrPKRd57mDTJIhdK0HK1rHrcd04KBwgnkduzdpDN00X01m6MGvJgpb7el
 21TCA9vE2z1cqPzSbN1I22O0QPnKhMZFBwn9Hzc4yryPMoNXwwESz9bUX0+wk6vc4slf
 NitOI4JS6HkXCf4weDhH9DoDoadbsnXZEL70Uy+XtjCE2YBNdJFxwV20LGbEDPiVs+0k
 5GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719969180; x=1720573980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVZKFwEDodws2MPl22wNiaqOGt5kTFTXYePutgY3h6g=;
 b=s+//arL0vs1Gw8qWFDp0GX3ad/bkONr86Bo+j6JG4Np88UuiSEjWyfubhJl+T2zmTe
 d/Wr/H8au5DzubODF/agyEmRgBBtncC21HtMy74eYhYwW57pVs+0Z6NIE3gipar106bS
 5NlddE0YcRNyCWdxVYjsDOjC1/tjjUydN9SveB4moVuWHenpXzBOtDNX5qyyBGpjmXyB
 iQqFsTAv+3fByoryAxXq9pBWEoC8H6h+SJlCf77OPtdWoCTTGk8CkXLSHKV28cqseDuU
 mrb9jJwWE8G43E01LxGrSbatO5yUlBclNogQQ9yvdTqxarr+RfE1wdA8aRScQUGtbAWU
 uhKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQ6yQuFEvFQiCXWkKuVEKFChp8e/8Y8edh2AYQexAFIdQgUUpf7SuhbmWWqeUMoUxlgBqV5dt26DaXcutR9v5+kwPYOI=
X-Gm-Message-State: AOJu0YzVrOlDnGTOQKQWMGweiWOY8daLy2Z7ZO4wgvxzLFPUYQRyEV9x
 gBlDKkwDQ6ZyDOxtubu0aBmgmZhfaG2z1Ax53owpft7MroHFJ/VYTJh6+FZPOhRf19KQ3n+CnXf
 5Vk8nWVlyCXViUyIc/uEA5YaXRxw=
X-Google-Smtp-Source: AGHT+IGDqU5INc3z+oBRQTUiuWHH1OcslRRwyib0GtesbJWXlbesX8E4XiMKSQap7UlT9h51+2N/emsCfWwdrwFrTPQ=
X-Received: by 2002:a05:6122:d27:b0:4ef:66cf:8745 with SMTP id
 71dfb90a1353d-4f2a5682046mr13048015e0c.7.1719969180479; Tue, 02 Jul 2024
 18:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-4-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-4-bb0f10af7fa9@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 11:12:34 +1000
Message-ID: <CAKmqyKOidVP9rC_N=EpLxJ0hKgJuPckoa9VLKgROhZxcY=Ho3Q@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] target/riscv: Add cycle & instret privilege mode
 filtering definitions
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Thu, Jun 27, 2024 at 9:58=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the definitions for ISA extension smcntrpmf.
>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h      |  6 ++++++
>  target/riscv/cpu_bits.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 46faefd24e09..c5d289e5f4b9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -339,6 +339,12 @@ struct CPUArchState {
>
>      uint32_t mcountinhibit;
>
> +    /* PMU cycle & instret privilege mode filtering */
> +    target_ulong mcyclecfg;
> +    target_ulong mcyclecfgh;
> +    target_ulong minstretcfg;
> +    target_ulong minstretcfgh;
> +
>      /* PMU counter state */
>      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index c257c5ed7dc9..5faa817453bb 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -397,6 +397,10 @@
>  /* Machine counter-inhibit register */
>  #define CSR_MCOUNTINHIBIT   0x320
>
> +/* Machine counter configuration registers */
> +#define CSR_MCYCLECFG       0x321
> +#define CSR_MINSTRETCFG     0x322
> +
>  #define CSR_MHPMEVENT3      0x323
>  #define CSR_MHPMEVENT4      0x324
>  #define CSR_MHPMEVENT5      0x325
> @@ -427,6 +431,9 @@
>  #define CSR_MHPMEVENT30     0x33e
>  #define CSR_MHPMEVENT31     0x33f
>
> +#define CSR_MCYCLECFGH      0x721
> +#define CSR_MINSTRETCFGH    0x722
> +
>  #define CSR_MHPMEVENT3H     0x723
>  #define CSR_MHPMEVENT4H     0x724
>  #define CSR_MHPMEVENT5H     0x725
> @@ -884,6 +891,28 @@ typedef enum RISCVException {
>  /* PMU related bits */
>  #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
>
> +#define MCYCLECFG_BIT_MINH                 BIT_ULL(62)
> +#define MCYCLECFGH_BIT_MINH                BIT(30)
> +#define MCYCLECFG_BIT_SINH                 BIT_ULL(61)
> +#define MCYCLECFGH_BIT_SINH                BIT(29)
> +#define MCYCLECFG_BIT_UINH                 BIT_ULL(60)
> +#define MCYCLECFGH_BIT_UINH                BIT(28)
> +#define MCYCLECFG_BIT_VSINH                BIT_ULL(59)
> +#define MCYCLECFGH_BIT_VSINH               BIT(27)
> +#define MCYCLECFG_BIT_VUINH                BIT_ULL(58)
> +#define MCYCLECFGH_BIT_VUINH               BIT(26)
> +
> +#define MINSTRETCFG_BIT_MINH               BIT_ULL(62)
> +#define MINSTRETCFGH_BIT_MINH              BIT(30)
> +#define MINSTRETCFG_BIT_SINH               BIT_ULL(61)
> +#define MINSTRETCFGH_BIT_SINH              BIT(29)
> +#define MINSTRETCFG_BIT_UINH               BIT_ULL(60)
> +#define MINSTRETCFGH_BIT_UINH              BIT(28)
> +#define MINSTRETCFG_BIT_VSINH              BIT_ULL(59)
> +#define MINSTRETCFGH_BIT_VSINH             BIT(27)
> +#define MINSTRETCFG_BIT_VUINH              BIT_ULL(58)
> +#define MINSTRETCFGH_BIT_VUINH             BIT(26)
> +
>  #define MHPMEVENT_BIT_OF                   BIT_ULL(63)
>  #define MHPMEVENTH_BIT_OF                  BIT(31)
>  #define MHPMEVENT_BIT_MINH                 BIT_ULL(62)
>
> --
> 2.34.1
>
>


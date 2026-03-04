Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCD5EF8FF3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnk3-0005hm-4I; Wed, 04 Mar 2026 10:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnjk-0005e1-TU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:02:11 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnjh-0000K3-AR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:02:07 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-126ea4b77adso8931339c88.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636524; x=1773241324; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XiumJw2W56imU+12ZiLHoPETxKBZEnnMg8XYNeanKsI=;
 b=h1TAOnLqzPmiece5OA1Cfn0ixDcmSMUWQ0NXCiXr3cxzx+AyvJTijWpThKbJuhfFeF
 NS9ENwQfbTSWe8MWL/g34FS2kd904zTvgLd+qzT/w4t5QIK16DUV2bRjZKYG8aodVjJa
 QR7cCXw1KiXqCHCGACleitaFZT4nV9SUsBftIGWYVrHekTXeaMP25faXF02pYPVDE6kt
 oDr5qSmHo+CUEGpE4Q63EvRL0I+/+vh+8ZffdQMlrqT1J2PnkA5jrGgY8S3Bj8+Ie9ba
 UOY4iI5i3WhmMPRNZtN4x5+BGCVTg8hMznoRIkLug5U6AMTxx5GQkrBF8fUX/R1ITKHX
 E5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636524; x=1773241324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XiumJw2W56imU+12ZiLHoPETxKBZEnnMg8XYNeanKsI=;
 b=uWcXVUGvkn3R3he7W+RBHseJVUmkVnAfn2iTqEgEcQ/JnlHh3i6059D8IAxIYbXNx2
 95Y0XY5MdTP3k0RNz4ZXOPvxXZTFQNa98WpkTPlTNUL6U/NGl+reNK7CDstVbzHJ7eU5
 uZA/6mCrusD4vnZASn9eDstcU56VGRrgGjGnLuw7EBlZpkqiV59AHoHnRGSXpQMQhVUI
 fJh0aELA6RllqkX64bVna3ucKttoUxbAriNRc/3sBe+nyXv21m+kKdINDLVvFT0uOfI3
 IaH+NbYw4DDffNz8vMRJFYVjooZ0vrvnL9WOy30riOR8flAjGB/pPC00AvYJHjgohAXq
 WN+w==
X-Gm-Message-State: AOJu0YxdPKgBFfDr2qgfzhtjtlyHZSNxPWXF3ks+ux25sQFHMDhFJPZ8
 83FMR2CFTCs+cdT3NS3riGxeCEjyXTKJOPSD/ZP1DaCcexMXScWUy1AV
X-Gm-Gg: ATEYQzzM5U3TKrPS2Fr6dYTAFWrRaDWBGm8P4qBCYf0sIfPnIbzAFGoqMPn0D5PgNMt
 3b9KWqLzWLmjzeqKaAuu4wOvcmd+rWiRO5PxRjSWdR2/m0Z6uobq0sL9G02vY/cJcZIR0qwq0vX
 AXspDXbJcB3LB2eXA1Mvhf2aXguxXFnqZG9+6CuT55tzU4xumwV9kRrWa9Haf1E+ZIGFPVE5i2v
 FDicwPw9NJiPPZh83JmJ5qRivIVV2vwHpU5QeKi1MlpBO27GwL2HyMaj615pLX6g0fGQWLPNCJU
 PpCVVdtlFvT8EJVliU6BQGGA8IMmif5hUjBdguLZDh0KmKd4PKNOmyNdkFKdBSwkZNtd2G8GbUq
 59KHaaxWlEx5Y8GyHUsGAuC54eF+nhKF5zU6I0fdv5WmusoEcy4Mi2iZaBABOvmWI9tF4DaAzx7
 94n1135ud8L0Sreeh3mQUj9NlNTU5eY/fOgBpSM4L65n6XJmXSu3vBmxvuiZdJ+1vHbVl5wtgoR
 QjrApkngJOhb5n12cNEgdVS30cZOlQ=
X-Received: by 2002:a05:7022:62a9:b0:124:9fd8:4b99 with SMTP id
 a92af1059eb24-128b70829cemr887931c88.14.1772636522991; 
 Wed, 04 Mar 2026 07:02:02 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32633sm22093716c88.9.2026.03.04.07.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:02:02 -0800 (PST)
Date: Wed, 4 Mar 2026 23:01:38 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 02/14] target/riscv: Add cfg properity for Zvfofp8min
 extension
Message-ID: <aahJPhbv-4y0OVau@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-3-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-3-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
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

On Wed, Mar 04, 2026 at 09:39:54PM +0800, Max Chou wrote:
> According to the ISA spec of Zvfofp8min extension,
> 
> "The Zvfofp8min extension requires on the Zve32f extension."
> 
typo in commit subject -- "properity" should be "property".

Thanks,
Chao
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/vector_helper.c      | 3 ++-
>  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73cfcbdf6f..c3ddcefedc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>      ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 3696f02ee0..59302894af 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
>  BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfofp8min)
>  BOOL_FIELD(ext_smaia)
>  BOOL_FIELD(ext_ssaia)
>  BOOL_FIELD(ext_smctr)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 378b298886..ba89436f13 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>          return;
>      }
>  
> +    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
> +        return;
> +    }
> +
>      if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
>          error_setg(errp, "Zvfh extensions requires Zfhmin extension");
>          return;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index b2315ecf9c..57221ab884 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>      int xlen = riscv_cpu_xlen(env);
>      target_ulong reserved = 0;
>  
> -    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfofp8min) {
>          reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      } else {
> -- 
> 2.52.0
> 


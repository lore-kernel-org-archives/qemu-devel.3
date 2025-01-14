Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6E7E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXiMR-0007qJ-P1; Tue, 14 Jan 2025 09:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXiMG-0007pU-2U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:57:32 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXiMD-0005xb-Rf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:57:31 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so9526401a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736866648; x=1737471448; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tyZt1jdYiDaLSU6bNE/J/nXb9mG4jCzpkIlUepFJmO4=;
 b=FQ/+PVPeJDjpLpAIUsGGF6e/LIeLsng+BVEsIii+bH3GHn0NCv8MTuUohAYsytmriC
 MT2wXnthZad8tSQAlyUz5s9t97viF0incgju5c0tkOtBxDaHiwSL3lCeOfmOoOp3oREU
 X+nX5cgPdRbZlzOrKaNLbV7dq8DI1HlbxvQtI0Ibx4OuliFx7ZwQh34sw9nAxNWC7Krq
 3zb2Q/REpv4K5RlWraJ8q7Io95Q5tFbFB4qsm/IPKaXaSijFq9u/PH9PZI7SXbou9NUV
 WBhuqDjJN2u8dr7BTwdFI3bEFSrzh9LVBt6bhpDk6uEN16MATzfyeLCswr33Ibd42TDw
 b8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736866648; x=1737471448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyZt1jdYiDaLSU6bNE/J/nXb9mG4jCzpkIlUepFJmO4=;
 b=X7hlw/hOrdJ9wvTPq50fJNG3KigvcxejVss6b5VHECwRj9K6x9wnN36BIm8Nl0phie
 spfrC3SCYRh+32w8OpKzYUE7M6OJMlWFgua4Oy7h/r6yQsJ+ngsFxgFpR3uWDCCQGNgZ
 xtwjJsKMUFtGsRsmebuO+yY0SLTGy0LVUaedCOvOn7mLvnhNkcAXdqTg2ThJcASoansZ
 9nhlMgUc6K6RW3l/B138+hH2SC8Jz0hNNu2t7XqG/eedmTB3RLovdvQOBkFkYG8MStGL
 c5gfRJEODNJHtzKTpxKnpovIZOicMjpFO0fkMavuXojAtdkbn6W6pagE+v6AwIFQKg/D
 gtOQ==
X-Gm-Message-State: AOJu0YwHL7XcYmTFcQguF/LFc6oXUK9BC4beUwMXNrQcyoIvh4FN7sw4
 j97ZGFLIxNjbpDX/0rP/jmdl9lS2vDnEkPQ/0d91MM7ncAlGd4k1enIGi0s+Zyc=
X-Gm-Gg: ASbGncs5np4s8jgs/YRK97rXun6wlBzBXVoQMtRp/6P48qDf1Ot1YBerSDjA/V3rjX6
 NIXiYKm9gNFFgcJQ/r5LXGlKbnPIAJpzQtOHeM1S2hwNdnPxryKM3aS7aVm6iUGy8fNTPElgxED
 cIpeOuoyoeruo8U2m/AJ2NIfp5MZIMiu7tVc6BwtNmvkRlNPs9KNhpWwxiGnnZPYw4L3Gxlnr7X
 MO0Iqhn36E2G+TvPzZeHKK8CVzUBOz/hsiIL7CWw3enI9Nx/ZdjhfJMAUO2D0Tgs/g1u/JnQfvk
 K2aWahaeY2fPIpr6eKzfhdIUcw54KXzXAxEAd7/Bjw==
X-Google-Smtp-Source: AGHT+IHBV0HcYFWpXnSOgKOvGh0wLzgvankx8F98SdE11ozTcwuEtd8fS8xIHhacBtDeuNqB6qpyCg==
X-Received: by 2002:a17:907:2d94:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-ab2ab6a8e01mr2470340166b.5.1736866648230; 
 Tue, 14 Jan 2025 06:57:28 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af424sm645833866b.137.2025.01.14.06.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 06:57:27 -0800 (PST)
Date: Tue, 14 Jan 2025 15:57:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 3/4] target/riscv: add RVA23U64 profile
Message-ID: <20250114-65533b4fa14dbccc20496b88@orel>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114132012.1224941-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jan 14, 2025 at 10:20:11AM -0300, Daniel Henrique Barboza wrote:
> Add RVA23U64 as described in [1]. This profile does not share all
> mandatory RVA22U64 extensions so we can't use RVA22U64 as a parent. We
> need to declare all mandatory extensions from scratch.

But it does share all mandatory extensions of rva22u64 and you do use it
as a parent :-)

Thanks,
drew

> 
> A new "rva23u64" CPU is also added.
> 
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index d56b067bf2..53ead481a9 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -40,6 +40,7 @@
>  #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
>  #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
> +#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8d0563527f..e10ecc4ece 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2394,9 +2394,35 @@ static RISCVCPUProfile RVA22S64 = {
>      }
>  };
>  
> +/*
> + * All mandatory extensions from RVA22U64 are present
> + * in RVA23U64 so set RVA22 as a parent. We need to
> + * declare just the newly added mandatory extensions.
> + */
> +static RISCVCPUProfile RVA23U64 = {
> +    .parent = &RVA22U64,
> +    .name = "rva23u64",
> +    .misa_ext = RVV,
> +    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
> +    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
> +    .ext_offsets = {
> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
> +        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
> +        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
> +        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
> +        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
> +
> +        /* mandatory named features for this profile */
> +        CPU_CFG_OFFSET(ext_supm),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
>      &RVA22S64,
> +    &RVA23U64,
>      NULL,
>  };
>  
> @@ -2883,6 +2909,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
>  
>      RVA22S64.enabled = true;
>  }
> +
> +static void rva23u64_profile_cpu_init(Object *obj)
> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA23U64.enabled = true;
> +}
>  #endif
>  
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -3162,6 +3195,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
>  #endif /* TARGET_RISCV64 */
>  };
>  
> -- 
> 2.47.1
> 
> 


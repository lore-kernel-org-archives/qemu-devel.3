Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAD2C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXyi2-0000nx-TF; Wed, 15 Jan 2025 03:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXyi1-0000na-5V
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:25:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXyhz-0005TO-87
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:25:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5565263f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736929501; x=1737534301; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l69G2lDpddgYxxnSs3N1Bp/deVxXfPf59jILH1+TBII=;
 b=Zrm2n+nV2v7tQSnVlJvczecfCh6T4f2Dn4D+FhfYN9LIB4nn17bVVxw8PugvdRn/CC
 eOjADY5boG5FaQMOPRGJUk3No6LX6fzy6BlfaO7hVWGrqdfqpNMpDr1QvCmfFW6x+IYD
 uy62K540cvwkNkcpGbsbaS3uEkgxXsl5EdcrI25icYUHkN1MpNVGlwuwX+V+Luql0Dhg
 rSDgJzs5YaSzWGgoS/C8uuieT3yhWG3As4OkyrtO8QSkzxBe1h4dbXh+MusPGalHFuwz
 Kw9VCeOAu56UzbPb5zez7I5HR2DBrepjg5TacPN4nhX0ndviM1GQNBhq6PH0bIJYKsg9
 ufBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736929501; x=1737534301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l69G2lDpddgYxxnSs3N1Bp/deVxXfPf59jILH1+TBII=;
 b=M7DqcBj8WefRQqk8fi3nIQKZsZgMqI5vwIl1zqOfSyaaHIk+PXD4uaiYU0StFBKsXW
 82v0XELgXvvRhESM/P0TB2H9F20C4svHA0GCRHVsuicHmiZ+tL7OFqLzH/yhne+GpqjH
 dTdlnYrumze3zz8+5KF5MVAJFVIV3mgkFSSnFtvryoM19WzgiPvEN5PIdkK6y1x2ylE2
 80MKkeVjHanL9Fwst8xlmOx8z8piVurRG89dOZ3m1oY9owgnt6wTfBpIDLjvyHWuWpT7
 qzBxjcx2wmQ4MaxIeJ1vPwlH8gfLCTmct0GWRos1t0s3RPqiIRSsnSyOU6ZyQDVNBTDk
 vJEQ==
X-Gm-Message-State: AOJu0Yw3PafYDhjbCfyI3h6Y7Vrd7EHZxGxukF470b20xi7CzJRZLHcL
 HXUGh7h2WXfHOioNC93zz6kFLWNOjdSSORqye4m7ckKqGCVW9UZSMAcWCw62WWE=
X-Gm-Gg: ASbGncu6T00pZVR4uNDBFcQhjIhVuKU/2a9ovW8D4c6yIGCxOhgtc4K+lGMPU4tjmrY
 tZATvYBdEoWVetGH6Iz7fQEjy3XhxYBK860uffVhYq5R3lOUVfeA6/5z76iI8wZnT+1SphRw1Z3
 WgR3T3acXrXCs6TYU3qtHFlJaP9sEa/P2ui7PVOmVuQ6rT+tIQkVBMhiaHH1AbGyEPmWaRyDClb
 kKhHFm3z/AawTOpl5Hq7GMH7gcYj8myHgyaFB3OtpCioPIXFl+NRmJDOeZaaUVLaPA8jZInwUIX
 XvMIIv2YX9wRChxfH4NzZp5e5BpKvr8b9tx5jC3JPw==
X-Google-Smtp-Source: AGHT+IHjj+ur3R9GTqGCtvIOdMJn+0KAuI1Ijv2Khqq0+rJ+F4KyqfpxxZYS1eWJG9PqgJ/uqhwBQw==
X-Received: by 2002:a05:6000:2a3:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38a8730faafmr25139902f8f.46.1736929501075; 
 Wed, 15 Jan 2025 00:25:01 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80b2sm16715145f8f.80.2025.01.15.00.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:24:59 -0800 (PST)
Date: Wed, 15 Jan 2025 09:24:58 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 4/4] target/riscv: add RVA23S64 profile
Message-ID: <20250115-7dc96d44b7516a71858d6d81@orel>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190001.1650942-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42b.google.com
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

On Tue, Jan 14, 2025 at 04:00:01PM -0300, Daniel Henrique Barboza wrote:
> Add RVA23S64 as described in [1]. This profile inherits all mandatory
> extensions of RVA23U64, making it a child of the U64 profile.
> 
> A new "rva23s64" profile CPU is also added. This is the generated
> riscv,isa for it (taken via -M dumpdtb):
> 
> rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
> ziccrse_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zimop_
> zmmul_za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_
> zkt_zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
> sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
> sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
> supm_svade_svinval_svnapot_svpbmt
> 
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 53ead481a9..4cfdb74891 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -41,6 +41,7 @@
>  #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
> +#define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 371a7d63fa..9225459bf8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2418,10 +2418,44 @@ static RISCVCPUProfile RVA23U64 = {
>      }
>  };
>  
> +/*
> + * As with RVA23U64, RVA23S64 also defines 'named features'.
> + *
> + * Cache related features that we consider enabled since we don't
> + * implement cache: Ssccptr
> + *
> + * Other named features that we already implement: Sstvecd, Sstvala,
> + * Sscounterenw, Ssu64xl
> + *
> + * The remaining features/extensions comes from RVA23U64.
> + */
> +static RISCVCPUProfile RVA23S64 = {
> +    .parent = &RVA23U64,
> +    .name = "rva23s64",
> +    .misa_ext = RVS,
> +    .priv_spec = PRIV_VERSION_1_13_0,
> +    .satp_mode = VM_1_10_SV39,
> +    .ext_offsets = {
> +        /* These were present in RVA22S64 */

I'd prefer we come up with a way to inherit rva22s64, as it'll
make the fact that later profiles should expand earlier profiles
more clear and also avoid issues like missing zifencei. I guess
it should be as easy as renaming parent to uparent and adding an
sparent, right?

Thanks,
drew

> +        CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svade),
> +        CPU_CFG_OFFSET(ext_svpbmt), CPU_CFG_OFFSET(ext_svinval),
> +
> +        /* New in RVA23S64 */
> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
> +        CPU_CFG_OFFSET(ext_sscofpmf), CPU_CFG_OFFSET(ext_ssnpm),
> +
> +        /* Named features: Sha */
> +        CPU_CFG_OFFSET(ext_sha),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
> +    &RVA23S64,
>      NULL,
>  };
>  
> @@ -2915,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
>  
>      RVA23U64.enabled = true;
>  }
> +
> +static void rva23s64_profile_cpu_init(Object *obj)
> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA23S64.enabled = true;
> +}
>  #endif
>  
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
> @@ -3195,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
>      DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
> +    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
>  #endif /* TARGET_RISCV64 */
>  };
>  
> -- 
> 2.47.1
> 


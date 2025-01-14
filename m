Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6D8E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 15:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXinm-0006gV-5F; Tue, 14 Jan 2025 10:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXinh-0006fd-5b
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:25:53 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXinZ-0003GV-Kq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:25:48 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso1081499066b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736868344; x=1737473144; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gPZTiO31Q/Cg5BoGleAQgxej48cR4PkAAPzisfTgqww=;
 b=nCwlXzGLy5qZxgga4BzPxEw7lqZG/9Gor/rqZcNt6ORvGH8sQ4lHev4p/wc7HG3QNS
 SuTF3zG4VPu64LILGx6gKEk/0nij+NQOIBcbLb+HaqmLRvto6bkfx5m0gWzzQ4X+if/T
 dDHz9FQv+zJflPSTd4r5e/QrEgkAhTNaEGyeeIRpsVDm8oAO8Nc+JbAMO/D0XFQ6D+S7
 xQxaSGSzd9E/7nf9Cb0xPCfD/Vb60ezYtsCVcv3wR+LOpDEy96jSEMyLHwF20PDZsV7T
 F5t3moREODzD48v5qE5Lw0ae4Unp91l5+aMKlgWIdecuwc/UOjREYBy5Nh7EWuycvf4J
 qmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736868344; x=1737473144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPZTiO31Q/Cg5BoGleAQgxej48cR4PkAAPzisfTgqww=;
 b=R6vBK8dgc3UxM9Z84e5KKpS+TS+5ys0DPbbjzoQ0mDp/sxj+NNvonILGYGdlO1E7mm
 ntVLtAT49Xw0k7ZyrYYokkyw6ubdtT32s3on//cKc11wMZwNnTGWVEj9B0jhuW/s7SHL
 Ha+udPaf4VfjrlqgWhQCUntTSpBTC+u12ZmbuNkJ1W2Fih2lAgN2skJCifIKZdq40jhi
 trJLg40lMSCqD7x2zT16je3iyMoMrXLpL3bGXjgeMcTDLeFYdGzKIxJHIWEBQQBApzFt
 /FSClLgYF+9J/eUiIQ2ZTaxdzlYjnso9Sa5m2Jynn4aQdVz4rLG1bV7/P1NfTPVfDOsm
 4Qxw==
X-Gm-Message-State: AOJu0Yz7D1ERYkcrxItLdQTRWuq6V3ume+vvDpiSKJSD7Y23hNaZH6Us
 stpGhD+ff0NwXfWgE+6tKNrwdNkdM+yC0+V9BvtqKHUH4qt35TaS6v2I2RveCNE=
X-Gm-Gg: ASbGncvL7IsYkU9de3C40u0kl08UWIGP8oAEbfyBOKJb0I8wmnMEXK8rOgdi3Yz1uGz
 +NfFqBH2FOhYQTdoa0kL7E+mQc3IaXDbPM/8BOwcllNTJFg3YuB57Yo8qmf+1qlMFNnqDwyyDxD
 Uetj4bIGHIdxb5Xz3w3HH8u5Bp1Mk7EdH9caHU8QYgHylbNSD+zKiEadLtawmi+YDesOCX2vnKO
 JxaTDoE9ZYhc4cr3ekaNO30HP8tqQamZOCKhhYJdzw1UKuQwP4Es96RqWcbE0y255HFf/89O2rO
 Pe9tOJCRnGTDG2gFkk5tbAtjtLKePZuBiHycBmD9XA==
X-Google-Smtp-Source: AGHT+IF1KmlpeNz5YQQjpgMAiniTbZ5yV4W07g2ana/y1zgR0kJpdeN7NWAvtAqHysiMw8s20vq0zA==
X-Received: by 2002:a17:907:1c2a:b0:aa6:8e9e:1b5 with SMTP id
 a640c23a62f3a-ab2ab6a8530mr2073888766b.3.1736868343699; 
 Tue, 14 Jan 2025 07:25:43 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c964dc9dsm649153866b.178.2025.01.14.07.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 07:25:43 -0800 (PST)
Date: Tue, 14 Jan 2025 16:25:42 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 4/4] target/riscv: add RVA23S64 profile
Message-ID: <20250114-a6a244e7bfc4b7bd2535750d@orel>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
 <20250114132012.1224941-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114132012.1224941-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 14, 2025 at 10:20:12AM -0300, Daniel Henrique Barboza wrote:
> Add RVA23S64 as described in [1]. This profile inherits all mandatory
> extensions of RVA23U64, making it a child of the U64 profile.
> 
> A new "rva23s64" profile CPU is also added. This is the generated
> riscv,isa for it (taken via -M dumpdtb):
> 
> rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
> ziccrse_zicond_zicntr_zicsr_zihintntl_zihintpause_zihpm_zimop_zmmul_
> za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_zkt_
> zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
> sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
> sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
> supm_svade_svinval_svnapot_svpbmt
> 
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 43 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
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
> index e10ecc4ece..14af141349 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2419,10 +2419,45 @@ static RISCVCPUProfile RVA23U64 = {
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
> +        CPU_CFG_OFFSET(ext_svade), CPU_CFG_OFFSET(ext_svpbmt),
> +        CPU_CFG_OFFSET(ext_svinval),
> +
> +        /* New in RVA23S64 */
> +        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
> +        CPU_CFG_OFFSET(ext_sscofpmf),
> +
> +        /* Named features: Sha, ssu64xl, ssnpm */
> +        CPU_CFG_OFFSET(ext_sha),
> +        CPU_CFG_OFFSET(ext_ssnpm),

Why are we calling ssnpm a named feature? And same question for supm in
the last patch.

Thanks,
drew

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
> @@ -2916,6 +2951,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
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
> @@ -3196,6 +3238,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
> 


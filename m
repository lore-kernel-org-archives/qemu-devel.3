Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD2C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5UU-0006My-6H; Wed, 15 Jan 2025 10:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5UR-0006M3-W8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:39:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tY5UQ-00015t-91
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:39:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436341f575fso72900615e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736955568; x=1737560368; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pVcs6nhQLfkjHL7Jr+QBkQ7RCh20Iogl4hjagwL0gnI=;
 b=NBS9xko8TY+HYaxZUXS532PzEkBhHmSQeR3ydNwSj+2AxewKj9LnPDJJLAQcVImbKQ
 DzPl42vhgDtrtA9V6vguPM9pyPQ4ezPAGu9mfee9QcXbd387vl1FmiXhFvgMjs5FuU9z
 TzuTGsrVIbmQDKqIb1/4vpUZo/FAjdEynjs+qK7YG6pWFcLxtnQ61TUEHso64gvbA/pR
 a5ucqFcISrT5mndRI3rU7XIn9Uc85HSsQjAm909KHiyINc0owmfM0euiO3fSgyR/hVQf
 tiAaxsCVWr/b2q1Gnt7818PBSEk2L0CqNdkrkYYdhG1Cjphtf+vIRumXOP91IXhPboDA
 bp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955568; x=1737560368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVcs6nhQLfkjHL7Jr+QBkQ7RCh20Iogl4hjagwL0gnI=;
 b=kVRmhnrh3eI9ZY1Xfv8XOhg5/5A5zBkjxESKgySixlmy2PXE/XgLyivpZLudDtbMkX
 lWtqPkaYx5tjL+vYCC6nwWTGwNWpDEqEl2QMkLeJ9wLpJcv2G/Jh6SW1PxuDWMbxyq4k
 6L+XyIXR7y8b8Q7mDvXWpw5UdGPwUsn/hljjXsOuIRxbblgd+hml6UzUzhL0F3y5hU2T
 OJQR80GXVyq7FRQO55bu+byO9dOnI2XTskmYtOmQzwaXypgfyiQZURNIoXkPdAbeJcRG
 oT+Pfc9irEhguqO8vur/OULFnR3Rvq1qWUxfO1BUnEF7OPrkiPXpsLhLxjixm0esNeEA
 zdmw==
X-Gm-Message-State: AOJu0YyIKuArWAYF94+Q7qm2UlVN8oXD8bJvT59ZOIfbVWp+rWPIZ04j
 vb8oR9l0pAZYr9laKtFsM3FTBNqOOS6jHnL5BU3RBGeNpjFXUENXmpHitaWOqYs=
X-Gm-Gg: ASbGncuO00SjKIUFTmC5kpvoIKQcORWcmLazweEvPaHqtjneuyvRcggn2wsq7D73uJg
 DxCtpe+JlTPN1o5pEwWR0hiY00h5cXZVFof11eyn1fEJQFv4q8YiYg43806d+W2JFDM79ZDvHqP
 6lIPntwh15Oav34lU1B9eyUOPGnOgF6xOigtKE3iArcPs9wzPE9Gcw7+8LsJ4cUZS0WLEpNyXQv
 PMiRHUSVvka3+nG27W8XOuwq/Mtl+Cyw2xGeiLn3l5PItYcv70OBWGy5y2xUBiOND4JlJok0CXP
 73M7tl8mMKLBL1vJ4SSCnYq3B/c29ONntmvRuv/cbg==
X-Google-Smtp-Source: AGHT+IGGOuHn3J8jUAC6I8+Aev2u4lz6FI2ZrxW5nGcBPg2l20i2zNoALJ0KefgbIgWK0G1BouKN8A==
X-Received: by 2002:a05:600c:138a:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-436e2679a1cmr165168475e9.2.1736955568232; 
 Wed, 15 Jan 2025 07:39:28 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499821sm27124325e9.2.2025.01.15.07.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:39:27 -0800 (PST)
Date: Wed, 15 Jan 2025 16:39:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 6/6] target/riscv: add RVA23S64 profile
Message-ID: <20250115-28bfced9dc48ff95a89a6f0c@orel>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
 <20250115134957.2179085-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115134957.2179085-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32a.google.com
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

On Wed, Jan 15, 2025 at 10:49:57AM -0300, Daniel Henrique Barboza wrote:
> Add RVA23S64 as described in [1]. This profile inherits all mandatory
> extensions of RVA23U64 and RVA22S64, making it a child of both profiles.
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
>  target/riscv/cpu.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
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
> index 761da41e53..50e65932f6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2421,10 +2421,41 @@ static RISCVCPUProfile RVA23U64 = {
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
                                                   ^ RVA23S64

> + */
> +static RISCVCPUProfile RVA23S64 = {
> +    .u_parent = &RVA23U64,
> +    .s_parent = &RVA22S64,
> +    .name = "rva23s64",
> +    .misa_ext = RVS,
> +    .priv_spec = PRIV_VERSION_1_13_0,
> +    .satp_mode = VM_1_10_SV39,
> +    .ext_offsets = {
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
> @@ -2918,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
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
> @@ -3198,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C81D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6b0-0001pq-Rj; Fri, 09 Jan 2026 02:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6Yh-0000su-2P
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:05:23 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6Yf-00049z-AG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:05:18 -0500
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-34ccb7ad166so2340428a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767942315; x=1768547115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dnhfBOKf8swJO9zh9EmJRtB1p3BeUYjVTg2cVeC9Dg=;
 b=gdAJHwn25s28Rzsxg+aD0OA+cW7oqRh1VHnyBNZHBsB3TBjIh5gRg+J7VQ3lKzb+P8
 REnt4nsZwEWGGDx2m0XBEPASQsEpui1nFQkSKL/Hkqcu9Cll9LvcQUD8WYAsUraZEQ+3
 p/cv2yBqcymHC6AVXGvxvm6pk16V+h/09EkWpy7IvZMUWeeo2kIH7ozNAxFAqUlcglTx
 6zRYotcET0Vjo1tRDrrEZi8tIdmNg9clU9MC0N1j08Ds/ZpbC4zgZhj4u34dumpM9lsX
 KgNekX1Es6yCsbfe7ldoRMBN3sg1yFbA81HhRcwq9r2y2TiWPJCpBVad+gvV94eU2ciJ
 MATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942315; x=1768547115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7dnhfBOKf8swJO9zh9EmJRtB1p3BeUYjVTg2cVeC9Dg=;
 b=sJ2T16mGHO5YQRGGJu9HCcWx1FE0SIOrpaFzxp0kDo8yxj2vn+ow2hwJIm7OQbMRgH
 47wXn0a2E4byj1yFTlaqaDuCXTW6Q0r08dw2FbDAV7Nj3C2L3BL1oN3LEMhYHGasFrse
 5zadNk7bKc0Oh5QhoiGC0dU6mUO2ZxVTDijHUcOoya5mrHoi+emabD/dqvCjUClGsyFt
 3oAAWzny0T51HAtWKw+JkO6YnEF6vyruOp0E7MGYNwoVZiAuG36zmDTFwgCR3fjRDVqM
 91Kardm7ay92XLwjlNl7wAg0OIsc9vwUBYQVJEUbl3D9djxso4D6O4d3pq05fI/2Lu73
 D8Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjfHs2iwYKFc37Zk09crJwPnXdfDuhAZmZ6B1wWqiLk0B0M5h3usPp48FwqdyeCgCFpQ9n++pDmDLR@nongnu.org
X-Gm-Message-State: AOJu0Yw4ADGrIL3IKFikIJbJ8VY0m5r5uII9OVfJ7OjU/fxMUfD+PAAf
 bsUwnu6cTW4kdDYePfuqSzEfTpcSF1Kw8Nr6/tS6f9FtvJ87UfXfX/px
X-Gm-Gg: AY/fxX7V1nTgu5jXTU85nIkvrOT0JbkQ+C/bTVCLsoWExkXiaFkZRMTv7IiC+lkI4h9
 M42h+qXbn1VHaqX2S6zr70+le9wWWiAXgxMFyvdseW66THc6QF40ErbJZ7khneEhPI1b+NKbd+u
 zK5PnWR8fU/1FHdCCfT9/3zBXtWg8kQCFQg4YNGY7kQtV27uxB34dVjdlVne7Ll8XYNipROWEM4
 AJDt/SrqNgPZsDiM2gLJFpA2MrSBMtItCuOTe3daw/GkEoylIP8u/DuFXbgUYt2yamrhIU17p8r
 1R3UBuf2YunjbLrTntq/A4LLq5D+yrkptw1Yu5huMdCbii+//a7slL18H0NJcx77s60U+ER3AzW
 sqtiwU7FlgKyxvjdMWa5VYkQvtqmgJH/sBe/M2I5v7UAe35fs37VTtCC12Rk8qdE0BJnytYrUQb
 MZ4T3uHJKDzEBZknhKoYXaNMK/QDWqCBGNlA8Wct5udIPyni3njfvmoQH0lZM=
X-Google-Smtp-Source: AGHT+IFA2Z4sh6s2C75Rj7v90CRb7SjuS8UE9gBk8jDk29IvObEHhvm+YD3tBhto6ph6b1H2WY2iIw==
X-Received: by 2002:a17:90b:1ccd:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-34f68b4ce91mr8906937a91.6.1767942315414; 
 Thu, 08 Jan 2026 23:05:15 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb9a45dsm9846882a91.17.2026.01.08.23.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:05:14 -0800 (PST)
Message-ID: <59a65f5a-3d77-46af-aff4-8f490441faef@gmail.com>
Date: Fri, 9 Jan 2026 15:05:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/riscv: Add cfg properity for Zvfofp8min
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-7-max.chou@sifive.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20260108151650.16329-7-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> According to the ISA spec of Zvfofp8min extension,
> 
> "The Zvfofp8min extension requires on the Zve32f extension."
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/cpu.c                | 8 ++++++++
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 5 +++++
>  target/riscv/vector_helper.c      | 3 ++-
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8eab992154..b4b10b52d8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>      ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
>      ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>      ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>      ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> @@ -778,6 +779,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      set_default_nan_mode(1, &env->fp_status);
>      /* Default NaN value: sign bit clear, frac msb set */
>      set_float_default_nan_pattern(0b01000000, &env->fp_status);
> +    /*
> +     * RISC-V Zvfofp8min extension requires:
> +     * - Same canonical NaN (0x7F) for both E4M3 and E5M2 formats
> +     * - E5M2 format does not generate signaling NaNs (all NaNs are quiet)
> +     */
> +    set_ocp_fp8_same_canonical_nan(true, &env->fp_status);
> +    set_ocp_fp8e5m2_no_signal_nan(true, &env->fp_status);
Should ocp_fp8_* flags be conditional on Zvfofp8min instead of always enabled at
reset? Better for maintainability.

Thanks,
Chao
>      env->vill = true;
>  
>  #ifndef CONFIG_USER_ONLY
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
> index ec0ea4c143..ee5a1e595b 100644
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



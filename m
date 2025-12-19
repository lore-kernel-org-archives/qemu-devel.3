Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5984ED7496F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWsY-0001cx-Fn; Fri, 19 Dec 2025 04:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWWsW-0001cb-9k
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:34:28 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vWWsT-0001dZ-8w
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:34:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso2664093b3a.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766136863; x=1766741663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM4XQz4mJt2DajqQEcw9GLCbOmSh2EWuqNNfvsrfeE8=;
 b=fFamFtYfBwosCekYECEKQ7xHvCpnXscj+2awpiZEn1ZDkt2yskoaDuuWkaY9VeElcK
 HjrPl7pjbATuAweKjCT7Z0c+dlFdsCtM9QC0RVACV9Bgd0amA4lP5Pnu3v2TluGdoQbx
 3cmqRf24xEosd7iHixN2di++RdWw4fDwCgBvsyJeIHifelkv6dPKfr1CzXAj/zehaxuj
 u4DjOTzg8Pp7z0jG8kl1EE++o7def6ejrbQmitj59BD0zjMneSnHF1O3cdwerYNmCkkp
 Gy5Z4axowm5j2JUfhgKSttl8Tp9pE8vFb9wME2QK1/zxYFHOkhl/mR+xajZaYKVqypSF
 ov4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766136863; x=1766741663;
 h=content-transfer-encoding:in-reply-to:from:subject:references:cc:to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iM4XQz4mJt2DajqQEcw9GLCbOmSh2EWuqNNfvsrfeE8=;
 b=DMeTZ8Y6D6Kc6c7BqsDWdcpQB28eSB+46UlYkUPYAc4PRssMtuojMdRPJhj9i61qYY
 yOR8E0TJpcrPCIBGaecPAmxhz03rfjfgZYN6Kl3JZxCiIkhXlHff3ezWBvu2SE+ueRMK
 UCoNVw9QHQXmrQBaWoherbl2p+xvUAwyxuxGJwQf+skTJsPwI+8UmO2K3DC4oL1dhSsc
 R0ZMwAXrhlq3/NKBjKrDu+karY53hU1pyj4XWFCmTZ5udQYzqdKD2/b7k2U8r59fPbJT
 Iqifha5ecULaycb9exT5K/CByJTWVY9zjYUiNVthp1nf4ItqcWoFkYDeAzNULMGHYje3
 lvjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6CsSXa2CPclO62EKjQgn1Fz6p9RceWcTf07WMqC6YDDvVhs7u0NGrnmnUsjJBRAUQU2juJes9+sxm@nongnu.org
X-Gm-Message-State: AOJu0Ywzbks+brMdlBS+n6u2vid5lFGeEAl3f8JzA+1J4lBfRHZXHjM1
 N+3n7LERJShtVWF5QGCB/Nf8eKX4ejfFqYKckhdYsnKhSDydrA9cp2F2
X-Gm-Gg: AY/fxX4pR2VKw2i/faxFICMG4LuRV2f2kJCa0Y1KseACxWnG/09qgObc6WGyNoWsIot
 Vfvq56JYb7j90LQ36YZ4yuOkuPUWg9/QE+E50RXauPeEnOPuwDlg3bGuPt2/EdPDEUZLSkwxowj
 9MpJUAyAFwOLqgOMugkvKGxVEjSZsYOqYNe+Ogxo7ARQ4tU6AHnSVSfTTvmIuf/JwxzQ/+T1t3H
 heodmiaHoQHyfIpz8gONOUODmNFRp7IseNwO40HDL8naU6SmreQW2FIIEMMxYUlIlu/cF+XH+9b
 /mI4buE/5tEFvpeJjhqUmZK59ImWKgoXqITASrzA6L9+5FIFi/4IM/iRqcDVf5Sy5vPk/tgevWI
 H3yma3Eww93b0i9ojFt5XxyYMsGzVQGKleceXYiOtMZRGHvA8tbhfjSvkRmn8mhmUK1ye8naas/
 Sa91XkIVM9IixH2zQa/U0auY3u0J/ElW8=
X-Google-Smtp-Source: AGHT+IF6nucm86vP9xuMl8CZPx7n0DfKv6Nly8+aKYTtaRy98Pmtd5QWAjbjxtgJxcypCEXMWJ2I1Q==
X-Received: by 2002:a05:6a00:4107:b0:7f7:612e:461e with SMTP id
 d2e1a72fcca58-7ff66a6dedbmr2274535b3a.57.1766136862774; 
 Fri, 19 Dec 2025 01:34:22 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7af29dcfsm1849809b3a.17.2025.12.19.01.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:34:22 -0800 (PST)
Message-ID: <f1678338-f355-4bae-9fa3-53f92f6d1f72@gmail.com>
Date: Fri, 19 Dec 2025 17:33:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: roan.richmond@codethink.co.uk
Cc: alistair.francis@wdc.com, alistair23@gmail.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com
References: <20251209061510.75080-1-roan.richmond@codethink.co.uk>
Subject: Re: [PATCH v3] Add RISCV Zilsd extension
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20251209061510.75080-1-roan.richmond@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
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

On Tue,  9 Dec 2025 06:14:45 +0000, Roan Richmond wrote:
> This is based on v1.0 of the Zilsd extension [1].
> The specification is listed as in the Ratified state [2],
>  since Jan 30, 2025.
>
> [1]: https://github.com/riscv/riscv-zilsd
> [2]:
https://riscv.atlassian.net/wiki/spaces/HOME/pages/16154861/RISC-V+Specs+Under+Development
>
> Reviewed-by: Daniel Henrique barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson  <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> ---
>
> v3:
>   - Rebased on newest version of master
>   - Reworked `gen_store_zilsd`, now using one 64bit store instead of two 32bit
>     stores, as per Richard Henderson's suggestions.
>
>  target/riscv/cpu.c                      |  2 +
>  target/riscv/cpu_cfg_fields.h.inc       |  1 +
>  target/riscv/insn_trans/trans_rvi.c.inc | 62 ++++++++++++++++++++++++-
>  3 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..6e0d37fb96 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_13_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -1247,6 +1248,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>      MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>      MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index a154ecdc79..8d8e35e4cf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -41,6 +41,7 @@ BOOL_FIELD(ext_zicond)
>  BOOL_FIELD(ext_zihintntl)
>  BOOL_FIELD(ext_zihintpause)
>  BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc
b/target/riscv/insn_trans/trans_rvi.c.inc
> index 54b9b4f241..3a055f4e0d 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -370,6 +370,27 @@ static bool gen_load_tl(DisasContext *ctx, arg_lb *a,
MemOp memop)
>      return true;
>  }
>
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_load_zilsd(DisasContext *ctx, arg_lb *a)
> +{

Hi, Roan

On zilsd spec Chapter 2.1. Load/Store pair instructions (Zilsd) | Page 5:

```
Operands containing src for store instructions and dest for load instructions
are held in aligned x-register pairs, i.e., register numbers must be even.
Use of misaligned (odd-numbered) registers for these operands is reserved.
```

A check for the even-numbered property of the op register should be added at
the beginning of the gen_load_zilsd() and gen_store_zilsd():

    if ((a->rd % 0x1) != 0) {
        /* Using odd-numbered register is reserved */
        return false;
    }

> +    TCGv dest_1 = tcg_temp_new();
> +    TCGv dest_2 = tcg_temp_new();
> +    TCGv addr_1 = get_address(ctx, a->rs1, a->imm);
> +    TCGv addr_2 = get_address(ctx, a->rs1, a->imm + 4);
> +
> +    tcg_gen_qemu_ld_tl(dest_1, addr_1, ctx->mem_idx, MO_SL);
> +    tcg_gen_qemu_ld_tl(dest_2, addr_2, ctx->mem_idx, MO_SL);
> +
> +    /* If destination is x0 then result of the load is discarded */
> +    if (a->rd == 0) {
> +        return true;
> +    }
> +
> +    gen_set_gpr(ctx, a->rd, dest_1);
> +    gen_set_gpr(ctx, a->rd + 1, dest_2);
> +    return true;
> +}
> +
>  /* Compute only 64-bit addresses to use the address translation mechanism */
>  static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>  {
> @@ -409,6 +430,8 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp
memop)
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) == MXL_RV128) {
>          out = gen_load_i128(ctx, a, memop);
> +    } else if (memop == MO_SQ && get_xl(ctx) == MXL_RV32) {
> +        out = gen_load_zilsd(ctx, a);
>      } else {
>          out = gen_load_tl(ctx, a, memop);
>      }
> @@ -437,7 +460,10 @@ static bool trans_lw(DisasContext *ctx, arg_lw *a)
>
>  static bool trans_ld(DisasContext *ctx, arg_ld *a)
>  {
> -    REQUIRE_64_OR_128BIT(ctx);
> +    /* Check for Zilsd extension if 32bit */
> +    if (get_xl(ctx) == MXL_RV32 && !ctx->cfg_ptr->ext_zilsd) {
> +        return false;
> +    }
>      return gen_load(ctx, a, MO_SQ);
>  }
>
> @@ -482,6 +508,33 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a,
MemOp memop)
>      return true;
>  }
>
> +/* Zilsd extension adds load/store double for 32bit arch */
> +static bool gen_store_zilsd(DisasContext *ctx, arg_sb *a)
> +{
> +    TCGv_i64 data = tcg_constant_i64(0);
> +    TCGv addr = get_address(ctx, a->rs1, a->imm);
> +
Add similar checks as above:

    if ((a->rs2 % 0x1) != 0) {
        /* Using odd-numbered register is reserved */
        return false;
    }

> +    if (a->rs2 != 0) {
> +        TCGv data_1 = get_gpr(ctx, a->rs2, EXT_NONE);
> +        TCGv data_2 = get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +        data = tcg_temp_new_i64();
> +        /* little-endian memory access assumed for now */
> +        tcg_gen_concat_tl_i64(data, data_1, data_2);
> +    }
> +
> +    if (ctx->ztso) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +    }
> +
> +    /*
> +     * The spec allows for this op to be non-atomic and made of two 32bit
> +     * stores. However, the two stores have been combined into one 64bit store,
> +     * thus avoiding the case where only one of these stores succeeds.
> +     */
> +    tcg_gen_qemu_st_i64(data, addr, ctx->mem_idx, MO_UQ);
> +    return true;
> +}
> +

Thanks,
Chao


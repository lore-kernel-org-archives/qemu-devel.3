Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFA2CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 06:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm69Q-0003Lh-3V; Thu, 05 Sep 2024 02:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm69P-0003Kk-2J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:39:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm69N-0006nM-2p
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 02:39:26 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3df04cf5135so216754b6e.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725518363; x=1726123163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ItyniIbQKUeyGPq0jrN5DOSvaZan+wVqsRMsoH39zU=;
 b=jspk1sBHJ4QKm5cF51cGWGb/+R7/bNGOp/zCWiS0PO4NGD1JTRicoQDgwUEbzo9DJ6
 oz/4KF17Bh5OAg+rHMe/pSJNaHoVULVfkCUvOTGvjCLAYX0z1z5i3HflLJmLhq6swjpL
 TMAMCis5n2RyGUciEvLZeurG4jHPh+Xc6pQ0Jv13HfpoKhQbUGb+nn77GvRzdCVdNkHt
 D8f+HlrE4JP0QWOBzhzy79aHToqiZ+whjon6777VrEG4tXdbnQyhAU+CjHDusT9XEL0j
 xfTonLHhsSnBFqfb3hcRJ2BIl46sOHEsZXyZvaJJUDl9TupAFZV29OM/19/RZt38s5xb
 D7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725518363; x=1726123163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ItyniIbQKUeyGPq0jrN5DOSvaZan+wVqsRMsoH39zU=;
 b=hk/Mum3bJMFek7lIjb36oCr1RPjboCWh4RLBQ/w2AmHcV6Kv1Ct48nHsbWG2TI85dA
 G9J0Y6dxe9fUMvJLox/MZ0FxXcEfuifXlSeVbnOsTnhKE3t/CscMHEDU3CXkwJZRSzTh
 JmNojelbRE0DN2Ups5xz4wPmR+G1/90Vx3d1LDexfSL9WjNSrOYWepQPenMZD1ZS8jJX
 IXeAANzynuZNU4yAfD6sTnokbuHGbojtyVRoOpvF6uc/hDmx24aKQfaNuzoeFb66RJRY
 MJXgSd6juKtQt39UwH3+bGupFiquHV5WoEu0m+UFD7fP5qSZki2vopMCWRJ/3mxIjy5U
 2TNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyqQgfjJj8t2IUNqDnavYOL3LBaObet6GRE0xgRcmKbDEFKEQQM6Vl52TiW9PeelmcOwGw9vKlF5KJ@nongnu.org
X-Gm-Message-State: AOJu0YyfUYaJCMu4Yc6Izd3NWKQhxRVdvkRxgMilQRY8tu/S/1I7thcQ
 LjYbdNV+ThS2ohPDe4mzH5WT4iP6fXn0F8PfiLoEs3D4caJZuO+RylCVW57ktbU=
X-Google-Smtp-Source: AGHT+IE3P+JI+Iy7PFjWKddRLaZhFaqoSd4Aw9RjrvK53XUF1sDnxU//t/5EAzz488lZq107tSLnzA==
X-Received: by 2002:a05:6808:654c:b0:3e0:c13:9837 with SMTP id
 5614622812f47-3e00c139e6emr8977959b6e.37.1725518363435; 
 Wed, 04 Sep 2024 23:39:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbda77basm2649624a12.66.2024.09.04.23.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 23:39:22 -0700 (PDT)
Message-ID: <77a1f5a9-0dff-4207-940c-e0d52316398e@linaro.org>
Date: Wed, 4 Sep 2024 23:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] tcg/riscv: Implement vector load/store
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
 <20240904142739.854-6-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904142739.854-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/4/24 07:27, LIU Zhiwei wrote:
> @@ -811,31 +849,52 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg ret, TCGReg arg)
>       tcg_out_ext32s(s, ret, arg);
>   }
>   
> -static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
> -                         TCGReg addr, intptr_t offset)
> +static intptr_t split_offset_scalar(TCGContext *s, TCGReg *addr,
> +                                    intptr_t offset)
>   {
>       intptr_t imm12 = sextreg(offset, 0, 12);
>   
>       if (offset != imm12) {
>           intptr_t diff = tcg_pcrel_diff(s, (void *)offset);
>   
> -        if (addr == TCG_REG_ZERO && diff == (int32_t)diff) {
> +        if (*addr == TCG_REG_ZERO && diff == (int32_t)diff) {
>               imm12 = sextreg(diff, 0, 12);
>               tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - imm12);
>           } else {
>               tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
> -            if (addr != TCG_REG_ZERO) {
> -                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, addr);
> +            if (*addr != TCG_REG_ZERO) {
> +                tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, *addr);
>               }
>           }
> -        addr = TCG_REG_TMP2;
> +        *addr = TCG_REG_TMP2;
> +    }
> +    return imm12;
> +}
> +
> +static void split_offset_vector(TCGContext *s, TCGReg *addr, intptr_t offset)
> +{
> +    if (offset != 0) {
> +        if (offset == sextreg(offset, 0, 12)) {
> +            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, *addr, offset);
> +        } else {
> +            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
> +            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, *addr);
> +        }
> +        *addr = TCG_REG_TMP0;
>       }
> +}
> +
> +static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
> +                         TCGReg addr, intptr_t offset)
> +{
> +    intptr_t imm12;
>   
>       switch (opc) {
>       case OPC_SB:
>       case OPC_SH:
>       case OPC_SW:
>       case OPC_SD:
> +        imm12 = split_offset_scalar(s, &addr, offset);
>           tcg_out_opc_store(s, opc, addr, data, imm12);
>           break;
>       case OPC_LB:
> @@ -845,8 +904,31 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>       case OPC_LW:
>       case OPC_LWU:
>       case OPC_LD:
> +        imm12 = split_offset_scalar(s, &addr, offset);
>           tcg_out_opc_imm(s, opc, data, addr, imm12);
>           break;
> +    case OPC_VSE8_V:
> +    case OPC_VSE16_V:
> +    case OPC_VSE32_V:
> +    case OPC_VSE64_V:
> +    case OPC_VS1R_V:
> +    case OPC_VS2R_V:
> +    case OPC_VS4R_V:
> +    case OPC_VS8R_V:
> +        split_offset_vector(s, &addr, offset);
> +        tcg_out_opc_ldst_vec(s, opc, data, addr, true);
> +        break;
> +    case OPC_VLE8_V:
> +    case OPC_VLE16_V:
> +    case OPC_VLE32_V:
> +    case OPC_VLE64_V:
> +    case OPC_VL1RE64_V:
> +    case OPC_VL2RE64_V:
> +    case OPC_VL4RE64_V:
> +    case OPC_VL8RE64_V:
> +        split_offset_vector(s, &addr, offset);
> +        tcg_out_opc_ldst_vec(s, opc, data, addr, true);
> +        break;
>       default:
>           g_assert_not_reached();
>       }

This is more complicated than it needs to be, calling a combined function, then using a 
switch to separate, then calling separate functions.  Calling separate functions in the 
first place is simpler.  E.g.

static void tcg_out_vec_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
                              TCGReg addr, intptr_t offset)
{
     tcg_debug_assert(data >= TCG_REG_V0);
     tcg_debug_assert(addr < TCG_REG_V0);

     if (offset) {
         tcg_debug_assert(addr != TCG_REG_ZERO);
         if (offset == sextreg(offset, 0, 12)) {
             tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, offset);
         } else {
             tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
             tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, addr);
         }
         addr = TCG_REG_TMP0;
     }

     tcg_out32(s, opc | ((data & 0x1f) << 7) | (addr << 15) | (1 << 25));
}

>   static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
>                          TCGReg arg1, intptr_t arg2)
>   {
> -    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
> +    RISCVInsn insn;
> +
> +    if (type < TCG_TYPE_V64) {
> +        insn = (type == TCG_TYPE_I32) ? OPC_LW : OPC_LD;
> +    } else {
> +        int nf = get_vec_type_bytes(type) / riscv_vlenb;
> +
> +        switch (nf) {
> +        case 1:
> +            insn = OPC_VL1RE64_V;
> +            break;
> +        case 2:
> +            insn = OPC_VL2RE64_V;
> +            break;
> +        case 4:
> +            insn = OPC_VL4RE64_V;
> +            break;
> +        case 8:
> +            insn = OPC_VL8RE64_V;
> +            break;
> +        default:
> +            {
> +                int prev_vsew = riscv_set_vec_config_vl(s, type);
> +
> +                switch (prev_vsew) {
> +                case MO_8:
> +                    insn = OPC_VLE8_V;
> +                    break;
> +                case MO_16:
> +                    insn = OPC_VLE16_V;
> +                    break;
> +                case MO_32:
> +                    insn = OPC_VLE32_V;
> +                    break;
> +                case MO_64:
> +                    insn = OPC_VLE64_V;
> +                    break;
> +                default:
> +                    g_assert_not_reached();
> +                }
> +            }
> +            break;

This can be simplified:

     switch (type) {
     case TCG_TYPE_I32:
         tcg_out_ldst(s, OPC_LW, data, base, offset);
         break;
     case TCG_TYPE_I64:
         tcg_out_ldst(s, OPC_LD, data, base, offset);
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
     case TCG_TYPE_V256:
         if (type >= riscv_lg2_vlenb) {
             static const RISCVInsn whole_reg_ld[] = {
                 OPC_VL1RE64_V, OPC_VL2RE64_V, OPC_VL4RE64_V, OPC_VL8RE64_V
             };
             unsigned idx = type - riscv_lg2_vlenb;
             insn = whole_reg_ld[idx];
         } else {
             static const RISCVInsn unit_stride_ld[] = {
                 OPC_VLE8_V, OPC_VLE16_V, OPC_VLE32_V, OPC_VLE64_V
             };
             MemOp prev_vsew = set_vtype_len(s, type);
             insn = unit_stride_ld[prev_vsew];
         }
         tcg_out_vec_ldst(s, insn, data, base, offset);
         break;
     default:
         g_assert_not_reached();
     }

and similar for store.


r~


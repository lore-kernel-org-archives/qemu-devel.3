Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606C5CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSnn-0000B6-KV; Tue, 19 May 2026 18:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSnl-0000Aj-Vr
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:20:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSnj-00029w-K5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:20:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so1672076b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779229234; x=1779834034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V2rSyFQh748Ywm44QylXBDDkn41JjDJxYqsWrIlMJUM=;
 b=EHQjUHoE/jWsiiDDrBtLIYmPEClUzhQ0pYVsTpP29TY6CX4uNtiWG9jJaPm9Z+pxYj
 LUNvj12CdL4UudThioYMQCRg4ST6/0dptdmU+ELsHwe1VPgymBqXAqmLr7HEqYIljEEi
 WS3RQB4Cjo22jjHdKooLOI18z9++bU6qW9lMDqx0ZZJikmG9pzddDFbN6ZfxDq3bzfA0
 +h0jtFLS7K4TXgzAoimxprz+oBCTV4t0ej+dY+uGXVeX4ERU+Bvza5xEndGb+lp4LZTi
 p2sGht6cscMbgQLGAgktey3eUK4PIZEXiZu6fR6k6CNF9PWZP5WAjt8QdAI54adEM07J
 MgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229234; x=1779834034;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2rSyFQh748Ywm44QylXBDDkn41JjDJxYqsWrIlMJUM=;
 b=Vh8KcCn09/fnoa/CJibn6r+Ix21x9YRualpfXvYqxu5ACf4XlOuChqf23XwQ3oLns9
 QBhPwcQen/k7mAEQmWEL/snhgnhxHSBxA0Rknwyb0dvz046uC+63iMoxJrYke2DD9vnd
 Z4cauTunBFB6o7PsTVro850MLx89UQVcplHSFIvV3zhueQOqX9eXsPq8xsMLjMxHsak8
 WBe1russMyiLF8Rd3p8PM+cZ9hL+IrSBNo1MdKVKa8/BDW0zAw6MLO8/OF/oDVMEbucG
 PFvRdhrcymjfC0HOJDFO5+bIvBRfA9O4ckUC0fy2HIS4PPvW+HDTXiTdF1e8Mdq46SZ4
 JcOg==
X-Gm-Message-State: AOJu0YySJRGzzKN5NarVzQWftn+TJQD8ckW6qW1xeLZYqQsbpP0ildQA
 ETYU8O4/960boYPU5yLqz9KMhTpk4KzOnmb0YZn+c7VFtwLzeVuutFwPkivgSpAb2l36jygtFq+
 otZhuezk=
X-Gm-Gg: Acq92OGYUe/UMy1X5LAP6cawQxtL/VjuGKNmYLHNkAWWxAW1a1mU8/wFSic6xmEeHbz
 O6HuCgUfGhKMEMDvzvBuzr9OewaLWCf8jmxxc1dYpe4N4fb7RxOwVHrsJXC3gMkKJVAYTLKOD20
 5V3G3aU/FmS4M6o3LOcBv8rfbha6TvX3yg8NQAbzW9wXm9xWaWSGHjet9GXgCJy9qBQDvuKPtcz
 CgveWldSIJbrOktoT1VppiL0tJH4KaFLoOBDZ2TiN+JlxbsKS0x/1cYpZBAdZF6OpO/LSIxaUh0
 MT9ncANtzy5+uwikKs4q/+YWnFUGCtt7FC9sagwsPD5zQ0EsPR/wZ1qG1iZXj7r4Wtzg2QrH2Lk
 HBXwt3cRcd132376iMH0HKa/9RUhF98tmSnvmE5r9uGBXq5zPUOGrRnYMDTZvKe0JRg8aDrVDjB
 u/s4HRks8xlJIygYXfT86/dTCX+Vzx6xvrLvjZ
X-Received: by 2002:a05:6a20:3d94:b0:3a3:602d:a0d8 with SMTP id
 adf61e73a8af0-3b22e7537fbmr23250984637.17.1779229233951; 
 Tue, 19 May 2026 15:20:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb06268asm16695172a12.1.2026.05.19.15.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:20:33 -0700 (PDT)
Message-ID: <55708026-fa8a-4a72-b613-3a8820d750c6@linaro.org>
Date: Tue, 19 May 2026 15:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas/riscv.c: add 'cbo' insns to disassembler
To: qemu-devel@nongnu.org
References: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/19/26 13:47, Daniel Henrique Barboza wrote:
> We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
> disassembler recognizes all of them as 'lq', an insn that happens to
> share the same opcode space.
> 
> While we're at it reorder cbo_* entries in insn32.decode using opcode
> order instead of insn name.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   disas/riscv.c              | 29 ++++++++++++++++++++++++++++-
>   target/riscv/insn32.decode |  2 +-
>   2 files changed, 29 insertions(+), 2 deletions(-)

As far as it goes,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, I have long-standing nits:

> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..36609efdf5 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -985,6 +985,10 @@ typedef enum {
>       rv_op_ssamoswap_d = 953,
>       rv_op_c_sspush = 954,
>       rv_op_c_sspopchk = 955,
> +    rv_op_cbo_inval = 956,
> +    rv_op_cbo_clean = 957,
> +    rv_op_cbo_flush = 958,
> +    rv_op_cbo_zero = 959,
>   } rv_op;
>   
>   /* register names */
> @@ -2255,6 +2259,10 @@ const rv_opcode_data rvi_opcode_data[] = {
>         rv_op_sspush, 0 },
>       { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>         rv_op_sspopchk, 0 },
> +   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
>   };

There's got to be a better way to structure this code so that you don't have a magic 
correspondence between enumerators and array indexes.

>   
>   /* CSR names */
> @@ -2876,7 +2884,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               switch ((inst >> 12) & 0b111) {
>               case 0: op = rv_op_fence; break;
>               case 1: op = rv_op_fence_i; break;
> -            case 2: op = rv_op_lq; break;
> +            case 2:
> +               /*
> +                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> +                * with 'cbo' insns.  Check the next 5 bits to select
> +                * what we want:
> +                *
> +                * cbo_inval  0000000 00000 ..... 010 00000 0001111
> +                * cbo_clean  0000000 00001 ..... 010 00000 0001111
> +                * cbo_flush  0000000 00010 ..... 010 00000 0001111
> +                * cbo_zero   0000000 00100 ..... 010 00000 0001111
> +                *
> +                * Anything that doesn't match these will default to 'lq'.
> +                */
> +               switch ((inst >> 17) & 0b11111) {
> +               case 0: op = rv_op_cbo_inval; break;

Surely "return foo" would be easier than arranging to fall through all the way to the 
bottom of the function, just to do

     dec->op = op;

with no return value.

To my mind,

     void (*decode_func)(rv_decode *, rv_isa);

should return "const rv_opcode_data *", with NULL for unrecognized/illegal, so that each 
opcode_data array need not be exported along with the decode function.

Indeed, that means you need not have opcode_data arrays at all, and could write

static const rv_op_cbo_inval = {
     "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0
};

     ...
     case 0: return &rv_op_cbo_inval;


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC574C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nhn-0005rZ-0U; Tue, 15 Apr 2025 17:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nhg-0005jI-Q0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:20:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nhL-00043p-WC
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:20:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so5205595b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744752001; x=1745356801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOEWcx2YT2OFjirgWebggs2PzH80aIIVqhGybbNMEmM=;
 b=RxVCuQ7uywzk7A5JX1yjv7ljphBtjWT4TJSXDUvCiH3OpKI38AX9bFpIftxxq79TPL
 uwHvYgR0A/LDp9dvdop6gxHWGOp7f96z71ydXoaoh//N9nbl6EbfKWiICLOWlTYzfN06
 Ttm3bKyz0Eo7VEn3qxfEaTyB7VC3MAqFokX/gZSRsesTn9gjYOCwpqjCPBzGIyv8Mm6s
 2NzjWns9JyTg9Zxj4z21hkMQS43JCWfojmvk0taTOEw8+yNxugF/+7Q/4Zm3aaIF5vva
 PzKz5eSkacMtoA/drlD8fRs6GziE9NQ1TlpnLdm+cvoUDYgNngjpfwzgHDsPpGA8Niat
 WtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744752001; x=1745356801;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WOEWcx2YT2OFjirgWebggs2PzH80aIIVqhGybbNMEmM=;
 b=VhnrYazudzgVuXSPCr3bVbLD1HQGx2WCCsm4N6ZYW/ZvVfHUjYbAqmPfepdNPcCUit
 0XEMLu+dFpd+1ZIwRCSzOXCBQ+Feb4bIVqUjpbmHk2S1wSDKN9At6LCYWePHA4F6IpoI
 rIXyJ/1/1fjPSSr1Z4QzwxtrFHQDGvjq7K6f+ZbtgBzCoO8dBgei4gSAZ4r23X3SCsKu
 QMZsE0bzZDDnyvqqu4MLrHWbi8CkYXsvx7cZ/9WMe+bD46YQudT8dnheicvlUaIbAzzt
 BMJ5vsAz9635IDLMz3YzCQqBqjFnaxLzaAxK+shCbSWe3ofwWsX4eN9QiO7DT0yqNLeN
 wqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/xe7yNIVL9jjZtdc/IOSBLfavzk0RQUlVsJxQMJ1G/SRZmrlvfMnMw+bOUym7N5u2euuMxqCjqm5L@nongnu.org
X-Gm-Message-State: AOJu0YwLbMLPS0C/ALpDGNCtOXmFwzC6OBC8omZRr6/SmA5LS/YanYnp
 Vla4/g3uim8cq3K1LRjP3QYVSxfoGh7D4jxfuXO7g5ZQdbWxJvv7wAxZG6tFVWI=
X-Gm-Gg: ASbGncscYQtjJOwTRPP01bIRV4wKS7YDO2L+mWFV7y/0FAeNppFYXxQ5m3M5PhnKUsY
 UhLKxhnN06qof3qbbpVTjPx5MIV9mFUJUrBIIeswtotH6knh9grJaikbu+9Ruh74lUYgTtGT27o
 c64C/B/wC4u99HmYKitfnpA88aDSaf+s6TiLPWIBhNH2yaxs1CkuokXTu+kQETfjD8fw7QSnLAO
 8FkzRv93pxN6SVEnxbhjvACLsCk6IPqySUdqQjUu6oiEeZpKGZodUAG6/NqGTpQ4VquHdc/rQvT
 tzu4r7+ykb5/7wVLeCXfx8KN0ax9CN/hW0tnMaVEkUsCEl5YVEygXZvu5UZASul8
X-Google-Smtp-Source: AGHT+IFk5RFtp2IimBlOKkUolBcfRg/PSVicZVm7BQhhDv++08X19Xcy5D8CwcX8cGuJ3Qv43Ly0Ng==
X-Received: by 2002:a05:6a21:900f:b0:1f5:7eb5:72c7 with SMTP id
 adf61e73a8af0-203ae05c74amr825436637.29.1744752001508; 
 Tue, 15 Apr 2025 14:20:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220aeb5csm1352a12.4.2025.04.15.14.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:20:01 -0700 (PDT)
Message-ID: <11987ab5-fed2-4c04-ab14-d8c3d82c959d@linaro.org>
Date: Tue, 15 Apr 2025 14:20:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 073/163] tcg/mips: Support negsetcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-74-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-74-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-has.h |  4 ++--
>   tcg/mips/tcg-target.c.inc | 25 +++++++++++++++++++++++++
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
> index 05701fd228..c77d4296cf 100644
> --- a/tcg/mips/tcg-target-has.h
> +++ b/tcg/mips/tcg-target-has.h
> @@ -41,7 +41,7 @@ extern bool use_mips32r2_instructions;
>   /* optional instructions */
>   #define TCG_TARGET_HAS_bswap16_i32      1
>   #define TCG_TARGET_HAS_bswap32_i32      1
> -#define TCG_TARGET_HAS_negsetcond_i32   0
> +#define TCG_TARGET_HAS_negsetcond_i32   1
>   
>   #if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_add2_i32         0
> @@ -51,7 +51,7 @@ extern bool use_mips32r2_instructions;
>   #define TCG_TARGET_HAS_sub2_i64         0
>   #define TCG_TARGET_HAS_ext32s_i64       1
>   #define TCG_TARGET_HAS_ext32u_i64       1
> -#define TCG_TARGET_HAS_negsetcond_i64   0
> +#define TCG_TARGET_HAS_negsetcond_i64   1
>   #endif
>   
>   /* optional instructions detected at runtime */
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 6a97264c7c..759f152711 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -959,6 +959,25 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
>       tcg_out_setcond_end(s, ret, tmpflags);
>   }
>   
> +static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
> +                               TCGReg arg1, TCGReg arg2)
> +{
> +    int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
> +    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
> +
> +    /* If intermediate result is zero/non-zero: test != 0. */
> +    if (tmpflags & SETCOND_NEZ) {
> +        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
> +        tmp = ret;
> +    }
> +    /* Produce the 0/-1 result. */
> +    if (tmpflags & SETCOND_INV) {
> +        tcg_out_opc_imm(s, OPC_ADDIU, ret, tmp, -1);
> +    } else {
> +        tcg_out_opc_reg(s, OPC_SUBU, ret, TCG_REG_ZERO, tmp);
> +    }
> +}
> +
>   static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
>                              TCGReg arg2, TCGLabel *l)
>   {
> @@ -2270,6 +2289,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>       case INDEX_op_setcond_i64:
>           tcg_out_setcond(s, args[3], a0, a1, a2);
>           break;
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
> +        tcg_out_negsetcond(s, args[3], a0, a1, a2);
> +        break;
>       case INDEX_op_setcond2_i32:
>           tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
>           break;
> @@ -2364,6 +2387,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
>           return C_O1_I2(r, rz, rz);
>   
>       case INDEX_op_deposit_i32:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



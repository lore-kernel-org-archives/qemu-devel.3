Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F7CCD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzTC-0006vY-KG; Mon, 18 May 2026 11:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzTB-0006u1-Aq
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:01:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzT9-0002y9-OW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:01:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8383fb7143aso1029058b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779116482; x=1779721282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7DHQviIA2ZPf/L8eBjYbe/XU4W/Tql6IQwBRsYiKh8=;
 b=fe5aksalfQdprR6UClYSmVVTPrxlrKctWODl49I95TatcnnbxOrHfz6UUEonhLdg+G
 p0ssdrAlgdohAzcg4n6BEcNEXDWckBy6hQXJM904wAd0M5dL4IcHl0v3B+4GP4Oxo5M2
 UfyUh+KRKTGCsp5qGkbhTG+akQtbQDxRRGdGWnihf/IX8d6x4jBWBOoAGn5q7k2mCE7t
 FeSjovtujkaeLsNfKQiOOaU49L03nrIiUlsOhHplCpys78AMys/fU82fiymq7Wq5jW2u
 rYubX78smexVVV7rdZb4ICgXb1yVmNsxm7JQf4xmrGmfggM0hViCml0oQnpNAEtit/aK
 thGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779116482; x=1779721282;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7DHQviIA2ZPf/L8eBjYbe/XU4W/Tql6IQwBRsYiKh8=;
 b=X3m+LIadWKlDwCsol34j+KeT5NX/BKcQPRkUVwi7dwkbXGOuBHoVb+Yh3kKriKsTVK
 fQ900YxkX0KNKyYxQr3MTdw2TStz39axc/xP4HuDbPpj7WhCX3ThgywfAYmQ2E0gUTDs
 OMMROG4YrZYAFJRya330ASz+Uvb4fLmnuCxRPR1dnFO2tM5sC1PJLNtCyj/dhquRiF50
 HRcA5vDwpNmKstlG7w/AQ4O2AeE2orzSBwEOoQ+gyOdvRwIJUKzbHrX5dzHSp2LLdqE1
 DW/DPT8XkVAGkWCkp3zGk9VjOS70HOILlAJ76x6RQgXiM/Z737OF0hoSqL/w5dJDxSEf
 NvEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x1jnMfiWyhliyCwiO+E5vDDwRvbL0KIylw2U2sQ8BT66hAecQQSy4+zJx/RQVNRX/gqACfPM5FwGz@nongnu.org
X-Gm-Message-State: AOJu0YxeUM3tezUmdsnX5KIvjDbQKk8SVOHhAAeW7Ychg3IzvjIO38IZ
 jVlYu3DMhZZvrY9/QTKx9mWlsKLsWzpM6r4/gpRB54u9b0lkehvOjsAn3La4w156/pE=
X-Gm-Gg: Acq92OGA3UupKnYsjoQuznkhU/bJKWIB2hDGIho4v0sZGC0uJXKtNMzITi+hGnzu/r/
 5/DCdFuOjIWn8ejTKx6ktUEx5nx9Ue56aKnbzfOjiKy2fQbyb/ejNOd/w7fN6AQs2wa/A4/juvS
 erordYrv57jLv88O3lXh4SwPmOftJ3zN7z8lcJOghAeq4++7mhD6+9vmRy2jq9NA+47k32y3LQl
 H4NPvcFQufqSJR0pnFTUVhxBpJ0W/Lvh3wGjiy/2RTLQVO8+rCSEar+xSPlpm0vlACP3f3KKHuK
 GxBN4ykbtnWx/uyw/80tg72lwoL36BNt7hFKqGc/unPygya+lEhaWzLAyHW/LTWEChRP3DIAwMw
 DdxRSKxy6/reHN1swC4UEEpoxIg6fJ5Y109EdPBqHaiowwVPKAelxy5sj+CwkDNB+8m46zWBHHO
 6fQuxTGGXId7fsGaiMMevSieNjFijo9W5IX7xT
X-Received: by 2002:a05:6a00:1f09:b0:835:41f3:f453 with SMTP id
 d2e1a72fcca58-83f33c45ccemr15137106b3a.17.1779116481697; 
 Mon, 18 May 2026 08:01:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f7cd19sm14978540b3a.54.2026.05.18.08.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:01:21 -0700 (PDT)
Message-ID: <e706b069-06a0-48d8-8518-6ebfa644fae9@linaro.org>
Date: Mon, 18 May 2026 08:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 31/35] target/mips: decode Octeon COP2 selectors
 explicitly
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
 <20260517-mips-octeon-missing-insns-v2-v8-31-206151ee77ec@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-31-206151ee77ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/17/26 22:29, James Hilliard wrote:
> +static bool trans_octeon_cp2_mf_u32(DisasContext *ctx, arg_cp2 *a, int offset)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    tcg_gen_ld32u_i64(value, tcg_env, offset);
> +    gen_store_gpr(value, a->rt);
> +    return true;
> +}

I suspect this should always be signed.  It's the mips way.
One spot check:

> +CP2_MF_U32(CVM_MF_CRC_POLYNOMIAL, crc_poly);

is in fact

   rt = sign_extend(CRCPOLY<31:0>)

> +static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
> +                                       uint32_t sel)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_helper_octeon_cop2_dmfc2(value, tcg_env, tcg_constant_i32(sel));
> +    gen_store_gpr(value, a->rt);
> +    return true;
> +}

Do not smush decode back into one helper with a selector.
Use a separate helper function for each operation.

> +static bool trans_octeon_cp2_mt_resinp(DisasContext *ctx, arg_cp2 *a,
> +                                       unsigned int index)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_load_gpr(value, a->rt);
> +    tcg_gen_st_i64(value, tcg_env,
> +                   OCTEON_CRYPTO_OFFSET(aes_input[index]));
> +    tcg_gen_st_i64(value, tcg_env,
> +                   OCTEON_CRYPTO_OFFSET(aes_result[index]));
> +    return true;
> +}

Why does the document say AESRESINP[] and you're using two arrays?

> +
> +static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
> +                                       uint32_t sel)
> +{
> +    TCGv_i64 value = tcg_temp_new_i64();
> +
> +    gen_load_gpr(value, a->rt);
> +    gen_helper_octeon_cop2_dmtc2(tcg_env, value, tcg_constant_i32(sel));
> +    return true;
> +}

Likewise use separate helpers.

I really wanted these, and the helpers, added in batches of (much) less than 1000 lines 
each. How about a bare minimum of the Subcategory sections of Table 2-7: CRC, 3DES, etc?


r~


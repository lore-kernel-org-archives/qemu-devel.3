Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67968D2A533
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t171l-00065L-RS; Wed, 16 Oct 2024 12:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t171j-00063y-8p
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:37:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t171h-0000CZ-LG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:37:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e49ef3bb9so910782b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729096651; x=1729701451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DCkCLPTexPk+nB4jYXe9J+ec6ifKhVO6f22HFVhSlJw=;
 b=HRKrqBFoI7LOMIIlkmPhSm8kcbxTHMlXu6WobedPAWoiSbM5Jr0UiAH3Ffdu2G4DXy
 QM8HKMyggDNYS9eCRR8d1/Yf6aIZeIdkWRL0Om5FRWg1iLJepBQlAQMj5g7bDfCMxo4n
 cVvpjdXx3BqhtkcQswdCpm+q13S6C/jMyqS6LmHn7SCR40OHkTO00mjRDysEsDXYfiv6
 0f61kWhNxgIU5BpvA2CwQz2jWPgVfSRMp6U2xf820VukYbauLXvX2+2iVNrBcRta6VB3
 ozNdGJ/TKuM1Jwguk/bibYCTs4tZtE3TRjo8spW/ucAgl3O1nJ2r+likC+rbqlpshi4o
 ryDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729096651; x=1729701451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCkCLPTexPk+nB4jYXe9J+ec6ifKhVO6f22HFVhSlJw=;
 b=b8Xzr5tTupKAonj98HHGQHMxtSjbHQMHfVQiJVmPBEF3a7f+EG/koWbvzzrG+s0LUY
 9nmWMQV/BuIsCqJONx3se5Lyt/sr6KtqCkqO5EWcVy7nNkWTz7TbwcnlKsILPBkDY1no
 w4Utz8apWugNE51ZRM5WVET0/S2B1k0NaanfwaIP95FExOng9yLX4hoXGTzK5v4T1GEU
 Zs6AEHncll4sMMZv9xfZTn0RlVZ0m1SbX83ZgK9I5OcwUA04Sj5xrGnSzziV1yYDkbg9
 uQGxz/0NIe+pB+f5WswaYPCRPFQA1ocYZqPo2DB/Y270wFmveQuKLoVJlp6pTsR+8XGh
 GxSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8zafqMcsiy9T4zkqcP+MwLP8dSPcv5Hh9EQZNfoqoSUbrzdQO5nzKtTBMH+9R6dthsBxY3phwtOl@nongnu.org
X-Gm-Message-State: AOJu0YyIDFD8N/LgFuxujfq2e50Ekmyc/Nlg4tHeSMViXkVrm1oL/QuC
 m6NcYjvu+CrHHhCPkSD4Z4d4W/Ry1MgsoJjXnMXY4lyKxNJjG9QSrH8QJ2nLKqo=
X-Google-Smtp-Source: AGHT+IEBZG/ag9z3wE0VAU5ZRTAS+9J8gxJ7vOZhKmWgE0OaZl6QJRi598ussAqx/caYRy6ZL1vUbA==
X-Received: by 2002:a05:6a00:2f96:b0:71e:4798:8753 with SMTP id
 d2e1a72fcca58-71e8fd619d3mr297003b3a.6.1729096651355; 
 Wed, 16 Oct 2024 09:37:31 -0700 (PDT)
Received: from [192.168.1.221] ([148.222.130.0])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c715e49sm3494513a12.89.2024.10.16.09.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 09:37:30 -0700 (PDT)
Message-ID: <b48f19ae-0e73-48d1-a29e-0dd0e4570a39@linaro.org>
Date: Wed, 16 Oct 2024 13:37:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/25] target/i386: convert CMPXCHG8B/CMPXCHG16B to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241015141711.528342-1-pbonzini@redhat.com>
 <20241015141711.528342-14-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241015141711.528342-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

Hi,

On 15/10/24 11:16, Paolo Bonzini wrote:
> The gen_cmpxchg8b and gen_cmpxchg16b functions even have the correct
> prototype already; the only thing that needs to be done is removing the
> gen_lea_modrm() call.
> 
> This moves the last LOCK-enabled instructions to the new decoder.  It is
> now possible to assume that gen_multi0F is called only after checking
> that PREFIX_LOCK was not specified.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |   2 +
>   target/i386/tcg/translate.c      | 121 +------------------------------
>   target/i386/tcg/decode-new.c.inc |  34 ++++++---
>   target/i386/tcg/emit.c.inc       |  96 ++++++++++++++++++++++++
>   4 files changed, 124 insertions(+), 129 deletions(-)


> +static void gen_CMPXCHG8B(DisasContext *s, X86DecodedInsn *decode)
> +{
> +    TCGv_i64 cmp, val, old;
> +    TCGv Z;
> +
> +    cmp = tcg_temp_new_i64();
> +    val = tcg_temp_new_i64();
> +    old = tcg_temp_new_i64();
> +
> +    /* Construct the comparison values from the register pair. */
> +    tcg_gen_concat_tl_i64(cmp, cpu_regs[R_EAX], cpu_regs[R_EDX]);
> +    tcg_gen_concat_tl_i64(val, cpu_regs[R_EBX], cpu_regs[R_ECX]);
> +
> +    /* Only require atomic with LOCK; non-parallel handled in generator. */
> +    if (s->prefix & PREFIX_LOCK) {
> +        tcg_gen_atomic_cmpxchg_i64(old, s->A0, cmp, val, s->mem_index, MO_TEUQ);
> +    } else {
> +        tcg_gen_nonatomic_cmpxchg_i64(old, s->A0, cmp, val,
> +                                      s->mem_index, MO_TEUQ);
> +    }
> +
> +    /* Set tmp0 to match the required value of Z. */
> +    tcg_gen_setcond_i64(TCG_COND_EQ, cmp, old, cmp);
> +    Z = tcg_temp_new();
> +    tcg_gen_trunc_i64_tl(Z, cmp);
> +
> +    /*
> +     * Extract the result values for the register pair.
> +     * For 32-bit, we may do this unconditionally, because on success (Z=1),
> +     * the old value matches the previous value in EDX:EAX.  For x86_64,
> +     * the store must be conditional, because we must leave the source
> +     * registers unchanged on success, and zero-extend the writeback
> +     * on failure (Z=0).
> +     */
> +    if (TARGET_LONG_BITS == 32) {
> +        tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], old);
> +    } else {
> +        TCGv zero = tcg_constant_tl(0);
> +
> +        tcg_gen_extr_i64_tl(s->T0, s->T1, old);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EAX], Z, zero,
> +                           s->T0, cpu_regs[R_EAX]);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_regs[R_EDX], Z, zero,
> +                           s->T1, cpu_regs[R_EDX]);
> +    }
> +
> +    /* Update Z. */
> +    gen_compute_eflags(s);
> +    tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, Z, ctz32(CC_Z), 1);
> +}

On s390x the cdrom-test generates:

tcg/s390x/tcg-target.c.inc:1284:tgen_cmp2: code should not be reached


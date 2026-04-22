Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17337F94CBA
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 01:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFMQQ-0003ZF-SK; Tue, 21 Apr 2026 21:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFMQP-0003Z7-Ew
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:30:45 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFMQM-0001H7-3i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 21:30:45 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4779b2497b4so2885735b6e.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776821439; x=1777426239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AY4DsEvHkoRyrMih1ndeDcANuFXV8hcGvLhaszfMLKk=;
 b=nJDna/+ZwqGmp5WhKH1X+vMxUo7sYaKi/t19TUff6n2HUQEO+VhVUYvizr3tSMFzK7
 CkxRmjtpIWOOtIEymxD7QSprQaTZ/lKUkrUpICVJA6oB+/AbI1RN5OzDP2IbvP/H3kQy
 2JjyQNoHMBjeDnm3Vb9X4p8oV+5Th+O62BKW1bhVeubnwLFjDtOnxpvLS0OAIRlLu0So
 mdsC3MVEBX5e8KLC7EVaUkG55sfFVgewZ4nW+6VCG8hI0PsEK9wFXU69NAL5JNx+nBEP
 B7HCYqwSPpzxoapKdCBuu1dbKlwMPEuD5T2wQCgk5kQ794TdeO85IdKodtNCbMltTOAY
 5maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776821439; x=1777426239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AY4DsEvHkoRyrMih1ndeDcANuFXV8hcGvLhaszfMLKk=;
 b=f0bS2SOtX77HV1oF/VOJnhQ/97+Ug4ty+HNqqWRDpz0NHfAfgN/wfwGM/TWKL590Xk
 btAHa00twBqcEvkloVcS8s0ANh0rpwVQVfcpnWF/KLF5279gCX3Vq/2LDsl2YR2gOoXc
 FmsFKNhNlTc9FUd3cP0SdvU53zHb8pnCw3u7a3wEcDzuQjkaBqHHMeHdoOgEeUuvz2qq
 bbPv8AlGwJImfxl9UlAA2c/c0d3C7bFlmsUhCF3S8jHsJpwtdRme14NVXXRn915sMTte
 xbD27B49K7MyiiBHTejMz53xbgOmUz3a2bkPbf2fopTosTzm8b7ZnA5yx79iIgXIvdPW
 GHLw==
X-Gm-Message-State: AOJu0YwAms5plijTUgbQsKAyHUdgXtmKWZoBwc5RIan5TqhLawbWJ/e3
 2E/daBrUtEabDoHflYSL6hJkmacVwrlK6NyFkONCOp9EHUNapjhOVhZdHvgZ3IaD/WSP3DehZ+H
 wZaQLWR4=
X-Gm-Gg: AeBDies5UCIvu4VMdiuRqlyCWnLdNsOWaBqcAHsOZ1fthkcY+WQaQHyy7ND+flCgIgE
 NGdv5oAov2ioL/NitxidQEWp+Oh0+xKqLUhCrO3KJjNE3JC7qOxIjpPhRzJUx3M0MTegXoGJUkv
 vXKUPhEKLan+o7e0crXWXbB1zZgyQuLzNgGApwUL2BDdh1Vwq/UtnenCUBbNASh9lTMOqp7Daqq
 FwvAmHaLyv8Xntu0NQB5H1y3wv4W/cabncieIxpFEHCV9KtOsB74X78IwlsQn8272r2ZKIorho5
 8YWwrsrccDU3sBPaQqqVLwBuXblpw878PxT3wvnRijsYlCMpsd+VGY+6j6pSIo/FpV3AQRwUImk
 JJEDGxKsJbYbiv/nuwZHUmPYT39Z3y9+t2ztOzm+r82nexed3YcUw4bTp/5bVdCSMRHGQf9rguY
 y+iEpONpum1OfkOJjoTtGaVbm3Tnp1Mqq2oRAXXaYsaQnUjd73je/c4w+9mXT/LAEuxDM6Ac8A2
 TJT06r0eE1zDdlWIB8VKsM7j5LA5zwJ+F2jjzQ=
X-Received: by 2002:a05:6808:4f0a:b0:45e:e07d:85af with SMTP id
 5614622812f47-4799c872810mr10795017b6e.2.1776821439487; 
 Tue, 21 Apr 2026 18:30:39 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.197.244])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd5408b5asm3736106a34.11.2026.04.21.18.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 18:30:38 -0700 (PDT)
Message-ID: <a6e16057-cfab-4d5b-a4fe-028203947e86@linaro.org>
Date: Wed, 22 Apr 2026 11:30:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
To: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
 <20260421-mips-octeon-missing-insns-v2-v2-1-a0791df188c9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-1-a0791df188c9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 4/22/26 03:27, James Hilliard wrote:
> Linux/MIPS enables software fixups for user-mode unaligned scalar
> accesses by default through MIPS_FIXADE/TIF_FIXADE. QEMU linux-user did
> not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions
> unless translation was forced to use unaligned host accesses.
> 
> Replace the target-specific workaround with a generic MIPS linux-user
> implementation:
> 
> - key MIPS translation blocks on the linux-user unaligned policy,
> - implement sysmips(MIPS_FIXADE) to toggle that policy,
> - raise SIGBUS/BUS_ADRALN when fixups are disabled, and
> - handle the existing sysmips(MIPS_ATOMIC_SET) and MIPS_FLUSH_CACHE
>    commands in the new target-side sysmips dispatcher.
> 
> This makes the default behaviour match native Linux/MIPS more closely
> and keeps the signal semantics consistent with the kernel ABI without
> regressing other user-mode sysmips commands.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

This patch does multiple things.

(1) sysmips flush_cache.
(2) sysmips atomic_set.
(3) As stated, unaligned access controls.

I suggest breaking it into 3 patches, in the order above.
That will add a bare-bones do_sysmips function in the first patch.


> +#ifdef TARGET_NR_sysmips
> +static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
> +                                      abi_long value)
> +{
> +    uint32_t *ptr;
> +    abi_long old;
> +
> +    if (addr & 3) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    ptr = lock_user(VERIFY_WRITE, addr, sizeof(*ptr), true);
> +    if (!ptr) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    old = tswap32(qatomic_xchg(ptr, tswap32((uint32_t)value)));
> +    unlock_user(ptr, addr, sizeof(*ptr));
> +
> +    /*
> +     * MIPS uses a separate error flag, but the common linux-user syscall
> +     * path infers that flag from the return value.  Successful atomic_set
> +     * results can overlap the target errno range, so write the result
> +     * registers here and ask the CPU loop to leave them alone.
> +     */
> +    if ((abi_ulong)old >= (abi_ulong)-TARGET_EDQUOT) {
> +        env->active_tc.gpr[2] = old;
> +        env->active_tc.gpr[7] = 0;
> +        return -QEMU_ESIGRETURN;
> +    }
> +
> +    return old;

The comment is good, but the IF is unnecessary: always use the ESIGRETURN path.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1AC106ACE2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lip-0000zJ-AA; Thu, 12 Mar 2026 15:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lil-0000z5-La
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:29:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lij-00064A-9M
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:29:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso1234517f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773343759; x=1773948559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tN7w/0zA9Fizpo5ISfBL++5Bj4QOptPGVQ5LZ0QJP8U=;
 b=ZlfTtJ/+erfBdgCLjVBQKk7gg31I8lyEwV/8bsBKWnZgcfO74JgeHSw57CU1UecCZz
 RkxBtCxRb0OTPHcnw4iVnsPtH+688qalDiSZJVvdvkvayse4ZpvB+66MEjq6dR/vc6pA
 j5oF8mjDvt/UPc2UtZreyQv+WDbyz/LICKlyQM/DtOgAxfSxSw9GGMgS0lS9ymRQt2a8
 PE4Z7Bt+7a42Kr5T8gep6l98C1BuJd8S3f3zBjlxWz0qLgDPsD9UH/kAFOrvSWifbxwE
 JM0MIvQhGL61KYcs+K3yQdnc38TrJfFN8jnxeV+n8JaoEmfwEhNjVL25WkPH2L8HxI/t
 Uijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343759; x=1773948559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tN7w/0zA9Fizpo5ISfBL++5Bj4QOptPGVQ5LZ0QJP8U=;
 b=aZjWUe7bnxpJ6fhaw+BjEc4GsmOxARQ6jyXQ6mkjjW1/fkXH9+qbrq3AEYcB9oZgA5
 vAG/WVPRTFwRA57VtT0Z5WKrg5SU391VaM25hPklOhDUPfMkCQmlEirbrLjNf1xERZ6z
 ntD0jh6XNIb1lQx4Asg/e3Wk6wSZXlSqlcVCGZgqlpaYvsOicNcFEhKrChICo3ogC4i/
 UwKmMobFxFBRO6Q0AloHO7u0AnodcuZp35bYMU8qEpYc9B0sA4A700VUrWaG46hPnsAY
 IJhKS+MwFL+3gGrMLtbbeZDDJCf8hTxxuSc9gzg3ETM0eLuJvh6s799VwRsYhVMW3dME
 WcqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlnGoOUs5loNahpnGgql0leHD9MUYCLbeXlJTfbjbbRq+Djf+ExQ99orCol69FSP/KIJcKklBifA2d@nongnu.org
X-Gm-Message-State: AOJu0YwBML6IEA5sDrXYmga4X5Qb5Rj5HQFGiOJ8E44tfzXYamvZaUQl
 6kAXlkY47FuMF4638aR4QtfpFSxQoyAtI3Tst6X/RTXVnc6B33CIkd/x0/RiXokuwvo=
X-Gm-Gg: ATEYQzz8vTJg7fARUVIqbeZmo5GhUNgnUNXHnS3qNFmpMRDtObGnhse9Oefpz5sm+PS
 tqQTq0l57YozizjhI8buCXlNvUbtse9/LKSvef9oZu28zt/YHkAWEIBFtK8o9dm2F6KUk3o8fKN
 iY23e6EkB6igz4wH6TTcrljE8J8scijZpAua9baOIVxkbRdAtqzyA9ys3XlbG3A7MMctCUfvASy
 rSgKLiBRX5hHlVLRPyP0GGVq2W77KcqYS9DQu1+SG5jckVUbximt4xCaxBPyIZAqpv/ltVWExbc
 xiPPlq0nrBqIfDDj8FbEGuTaW9vxFGttJbyhHa/T2krB68uC5eDfwbPP/iMCRT/1FkFmGsvP+qn
 aFn+G0xAgGcO9B7pmkxrhUrd9M69VcbjvcoGgqc/+GnRdrD0+dV4GQvV1EcKl0wkAr846K0Zef7
 dhEXDOxzhg2CgOiPE0826k5FvSvXw2l4VobN3TfEzqx/cBBKnurOWKc4o1u2oYRCMC/qwPu7fCY
 s/p
X-Received: by 2002:a05:6000:240a:b0:439:b715:6f4b with SMTP id
 ffacd0b85a97d-43a04dcbb2dmr1548223f8f.57.1773343759225; 
 Thu, 12 Mar 2026 12:29:19 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a737csm9448036f8f.10.2026.03.12.12.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 12:29:18 -0700 (PDT)
Message-ID: <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
Date: Thu, 12 Mar 2026 20:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
Content-Language: en-US
To: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/3/26 17:27, Martin Kröning wrote:
> These functions are needed to support semihosting on CPUs that support
> runtime-configurable endianness. They should not be used in other contexts.

Another note is these function are not target-specific, which is great!

These can also be used outside of semihosting.

Matter of taste I'd have named them using this shorter pattern:

cpu_internal_tswap16() -> tswap16_cpu()

> 
> Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
> ---
>   include/exec/tswap.h | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/include/exec/tswap.h b/include/exec/tswap.h
> index 9e94fa0021..17ac544454 100644
> --- a/include/exec/tswap.h
> +++ b/include/exec/tswap.h
> @@ -10,6 +10,7 @@
>   
>   #include "qemu/bswap.h"
>   #include "qemu/target-info.h"
> +#include "hw/core/cpu.h"
>   
>   /*
>    * If we're in target-specific code, we can hard-code the swapping
> @@ -72,4 +73,39 @@ static inline void tswap64s(uint64_t *s)
>   }
>   #endif
>   
> +/*
> + * If we're in semihosting code, have to swap depending on the currently
> + * configured endianness of the CPU. These functions should not be used in
> + * other contexts.
> + */
> +#define cpu_internal_needs_bswap(cpu) \
> +    (HOST_BIG_ENDIAN != cpu_internal_is_big_endian(cpu))
> +
> +static inline uint16_t cpu_internal_tswap16(CPUState *cpu, uint16_t s)
> +{
> +    if (cpu_internal_needs_bswap(cpu)) {
> +        return bswap16(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint32_t cpu_internal_tswap32(CPUState *cpu, uint32_t s)
> +{
> +    if (cpu_internal_needs_bswap(cpu)) {
> +        return bswap32(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
> +static inline uint64_t cpu_internal_tswap64(CPUState *cpu, uint64_t s)
> +{
> +    if (cpu_internal_needs_bswap(cpu)) {
> +        return bswap64(s);
> +    } else {
> +        return s;
> +    }
> +}
> +
>   #endif  /* TSWAP_H */
> 



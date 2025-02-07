Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E60C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgTBT-0003DT-49; Fri, 07 Feb 2025 13:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTBQ-0003C6-L2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:34:33 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgTBN-0001vr-Ow
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:34:31 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso39057785ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738953268; x=1739558068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=scCLt4lohbE1AQx25ta1VXQZLYDsS2XoZD8uXI6vaAo=;
 b=B7inJ+fHYtyuznPGwfQ7/aVOPzrVXJsRymBTl1oV5lWdzLbGAVpY/FjGEkJKHaRtsX
 A8XaxqlDZIOphBKV5baDiF+1EvOM/ZlQCTk4FMSo2DbASWyt9Q4nNVkLShrI3F6FiS1T
 VfrJwrdRJLpMKjF13Uqzp+mmcL0Hf2bYymfSEhgNlLzyR+7JugWnEU4y496kVWM7wf7j
 u8frQSbyAkLF9HEVYtb8zNO2ib4WcudrhP0FytQ4GPTOv2fmXzTP/VGpcXPgwG/Yh6M1
 nKBaupVK9xRSL9NR9hCjDmeZUBOv8GkCKcqJOAfvdWCqGaQKdvNDYIjWC0CtXWkmzC0a
 cWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953268; x=1739558068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=scCLt4lohbE1AQx25ta1VXQZLYDsS2XoZD8uXI6vaAo=;
 b=VcNzlyq5BqNjMkLLDsNZOlX2pG2G3/eZup45z9xhsjVVWzO3o9ZHiZW56tNn7HWIHt
 EHY6+6lE4EIl7jTGJcdxx3H2vRB4szuFdcNg7R1DoaJ0a69gaDG0I17CcO6MVoF7+J17
 fV82aUdOIHVu1MlyMgKag1KWPjoPHPhncvXpqrFimE6vlidBpWhE5euSiReuTWQPZg9m
 aUESvJkOEudbr5bV64A7xdNLzaNQjXUe5cOQlXhrpfTbJZzoM5sTUhurTQHY8XsTAG0a
 A/mEpyuEfaesJ/4a7MKrTYnfuTCcKEL+QQ0Oxf64AWSlY+d2QDRTLBVWHpmWkc5KFBf3
 kFSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD3Unk0ytvmeUqVEQ4zdqueU6Kufe0VlcrfC55YAQHL1+UF7nAUaYtwysBSVJsgHHaXYLd5hHEzWsC@nongnu.org
X-Gm-Message-State: AOJu0YyBleMQhH7BO2S5QnZO2xyc7Nu6NcbvqfMrcvnPM5798TX0yes1
 xK+JqwemNQnuRDa4OwRggWTHf2KYwTzdkkH3y/EZld9OFkIyJ7Ddg6FvW9wZ85Q=
X-Gm-Gg: ASbGncuc18bOihACdUxS1d6laRcQkCuOlqymn+m8ABudi+aD+XoxM9BR7avfd/2QGhr
 d/TxKES0L/WNzfm23JteFQqKPWi8wB5efFOTVUz0LPGmhUcjTnLeqdEsKddjkq+tyTjx8i9RfKa
 d4kG0O1lFJ6f71Kwtwn8/dlM8cowJH8mYoXxaLbIExpfagjWZQLR349nnK9opSXc4rYE4dxTyRq
 znJmrCRlQcE+a5dbBwP2BgYRdsDZnShMyICxw6TZ8fM/Ics0vswHkVT5eS1ZCaDmeCRMSlZMAO5
 RNN1eAb6xhHwOix9BMMNvBr9XdUQ3wNk6hRN4g9WaHss+gc7UXEaTiM=
X-Google-Smtp-Source: AGHT+IF4E+bXkGzgB25TTuHhb32sFVZR8LwtOcS0c6JqrZ4wfEs22TUpIhduVya7u9MYnQpsb/ePcA==
X-Received: by 2002:a17:902:d4c9:b0:21f:3352:8f64 with SMTP id
 d9443c01a7336-21f50158c3emr66489165ad.26.1738953268080; 
 Fri, 07 Feb 2025 10:34:28 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36535f0fsm33991975ad.56.2025.02.07.10.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:34:27 -0800 (PST)
Message-ID: <997aeb8d-ffb5-43f2-a6f4-767e66a19494@linaro.org>
Date: Fri, 7 Feb 2025 10:34:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] arm/cpu: Add sysreg definitions in cpu-sysregs.h
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-2-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207110248.1580465-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/7/25 03:02, Cornelia Huck wrote:
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> new file mode 100644
> index 000000000000..de09ebae91a5
> --- /dev/null
> +++ b/target/arm/cpu-sysregs.h
...
> +static const uint32_t id_register_sysreg[NUM_ID_IDX] = {

You can't place the data into a header like this.

> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2213c277348d..4bbce34e268d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -30,6 +30,7 @@
>   #include "qapi/qapi-types-common.h"
>   #include "target/arm/multiprocessing.h"
>   #include "target/arm/gtimer.h"
> +#include "target/arm/cpu-sysregs.h"

The data will be replicated into *every* user of cpu.h.

> +static inline uint64_t _get_idreg(uint64_t *idregs, uint32_t index)
> +{
> +    return idregs[index];
> +}
> +
> +static inline void _set_idreg(uint64_t *idregs, uint32_t index, uint64_t value)
> +{
> +    idregs[index] = value;
> +}

No leading underscores -- this is not a freestanding environment like the kernel.
We must respect the system implementation namespace.

> +/* REG is ID_XXX */
> +#define FIELD_DP64_IDREG(ARRAY, REG, FIELD, VALUE)              \
> +{                                                             \
> +    uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);   \
> +        regval = FIELD_DP64(regval, REG, FIELD, VALUE);                 \
> +    _set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);             \
> +}
> +
> +#define FIELD_DP32_IDREG(ARRAY, REG, FIELD, VALUE)              \
> +{                                                             \
> +uint64_t regval = _get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX);       \
> +regval = FIELD_DP32(regval, REG, FIELD, VALUE);               \
> +_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, regval);                 \
> +}
> +
> +#define FIELD_EX64_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_EX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define FIELD_EX32_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_EX32(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define FIELD_SEX64_IDREG(ARRAY, REG, FIELD)                     \
> +FIELD_SEX64(_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX), REG, FIELD)  \
> +
> +#define SET_IDREG(ARRAY, REG, VALUE)                            \
> +_set_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX, VALUE)
> +
> +#define GET_IDREG(ARRAY, REG)                                   \
> +_get_idreg((uint64_t *)ARRAY, REG ## _EL1_IDX)

The casts look wrong, and seem very likely to hide bugs.
The macros should be written to be type-safe.

Perhaps like this:

#define FIELD_EX64_IDREG(ISAR, REG, FIELD) \
     ({ const ARMISARegisters *i_ = (ISAR); \
        FIELD_EX64(i_->idregs[REG ## _EL1_IDX], REG, FIELD); })


r~


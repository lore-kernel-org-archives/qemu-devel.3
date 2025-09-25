Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23988CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jIU-0000WO-Ju; Thu, 25 Sep 2025 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jIT-0000U8-4o
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:33:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jIK-0003zc-Kz
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:33:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso5958935e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796425; x=1759401225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R++n1zvdw+3fOueDvZ/OTFpQYf9e/S+aO6Ls0/42Ph0=;
 b=gsnR6P2agEgcWbFrytSWf/YXPjw7dKhRJHsK/17ZDrpIviGwXbThpEhs/9k60Hpnsk
 OKWgN0kTTqpxXxJHqGvnviQZVXSH4xfkWbTiBmaZX54GHro/y3scP9xNbbNeNCZHrROv
 cSQDviRENqnwXJvWfXZnbfAOvZy95gcOMFVBWChgu7O9ALjR5fgLTa825df0kifez5BP
 PpmwgWYHrHZRWC7atkeGMDUXhor7XTThec9LVxdk98doqcrmZyIe24U2vstgYGu6WRMo
 NGnEC5r51NaAkPClgKbFXxJUmOq6xPeeY3kGsvY3jPd//LzdJ0dgS73OmuaN+OGBPYPB
 h4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796425; x=1759401225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R++n1zvdw+3fOueDvZ/OTFpQYf9e/S+aO6Ls0/42Ph0=;
 b=lycALhgEJ+2HTUnPLwx5jPqdAzUcM5qb+09SPGM4grtDKZI0o41piV6dX+BpIsSgbd
 BMgkhTtfn/ZRYj+oXbzq2Z6pMXCfGx/iwU+vFD1PpsIK/n+4DPOeXX5NIDnWERaRUijI
 3jAyTR4EYfFVyQ4zKrxVe9RK6mY1SAiQKLcnmDdgASDwRTXFWyqOZhGn45Y5cfgA3MSg
 vjQQFnLCxRZ1StZHk/NsUakKqIgv5IPXJEGO4FLDFRzTjTtCmS3ZNzRPUNo49iushuFu
 eWESpW4MvioIlA0WeYuwEF10xIQ+GKXftwGO1/Nr8x7M6N7aUu1/6pQzoLtNYROXUyTD
 j4og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJGyX6lz4wwwBvIJfCNt7SdmNa5Sd3KtPvQeMpjaoK5F4ign38lYGmTbOH8cT2Y7jlafkPmkuF379q@nongnu.org
X-Gm-Message-State: AOJu0Yz2gZUT0qgk7BpBgvm+CIyd9t9wVSR3rDB9DONWoLkSkMPbIucl
 MYK4JHXgKKHrLYS0R4pbXtq5Uev+WzKTs62ZZvL1Rq0PAtNhbr0e2thMFf+5lCe/s5Y=
X-Gm-Gg: ASbGncvvDzOMTHdHlxALHdbgjfdpzc1bgqEq8xZ+rkOddzSbeScFUjv/ZbnXNQcFEhY
 Ky3ZAAarDGHe0DExmOFpX3U2mIwIeQhenue41LEdVGbmxwK9WSv1VxEo8viLNnIJC6nlZ0dlsFV
 yBJm1l/iQENDwyjXkidz1wT4jZzEPgVA+x0IBA8nLkcwXY+rsYGEa3DEGlkpJvkGNowXwVXtr9z
 /1EOxEVP6nRFWG0ZFW37/PA53huMiFh1HlsyJ9n3aBmWc/i/41aQC5vP04+wyleiQKXBLMG5998
 7Y3hA6gWri8Y5Zki0sf67pK0gu8l8uxgck7JemVbIGZcF0VGduBYAvhesz47YDvpYjvZ3owmHno
 jJYc2lJNF247IUx5EHWKxGUZZeDcKyrdpXfsO3ZLsXQBrjeHTfkH5xCdrun06sO5SXw==
X-Google-Smtp-Source: AGHT+IGXb4gploWtFKQ+cQ5y3KYDuCZdSZRCaU76Vi6aLz4FbWyQOvbCDxT9FTh5KACltpkYbGRjxg==
X-Received: by 2002:a05:600c:4816:b0:46e:3287:57d6 with SMTP id
 5b1f17b1804b1-46e32a0bd2amr17174775e9.27.1758796424758; 
 Thu, 25 Sep 2025 03:33:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be363esm28431145e9.15.2025.09.25.03.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:33:43 -0700 (PDT)
Message-ID: <59ae43f2-d392-4582-96dc-8465bf893bb1@linaro.org>
Date: Thu, 25 Sep 2025 12:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/36] target/arm/hvf: Sort the cpreg_indexes array
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b043eac8c6..99d8672b9b 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -925,6 +925,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>       arm_cpu->cpreg_array_len = sregs_cnt;
>       arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
>   
> +    /* cpreg tuples must be in strictly ascending order */

I don't get the "why". If this is related to a previous change,
maybe better to squash there?

Anyhow,
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
> +
>       assert(write_cpustate_to_list(arm_cpu, false));
>   
>       /* Set CP_NO_RAW system registers on init */



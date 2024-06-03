Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E956C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9s8-0002j9-39; Mon, 03 Jun 2024 11:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9s6-0002hy-3j
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:45:18 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9s4-00037L-2W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:45:17 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e73359b8fbso63123421fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717429511; x=1718034311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0zQ4HredofNILHiULg4J4DPS8C6yyIAW9Yckq18Fc8=;
 b=co0s3evUMXAKAhXjySyt28Nnka6yOKVL2H6a/cPQtQ61/hBURWr+Ok1QBoEadA2MOs
 eQ6ti5gPys7aIWeM+45aBXM8/6cpdB4UA7EjCYLRIi4cnCsN4EhxRE2gRp6rrS4nJPDx
 rqc7Ucxb7Al1TXOr4lRIrjBYqb3BPnUZvuMzqYf9yLz/YzoB9K3FrrJjBQjlalEHeKUC
 tSf2GrKr3Zf0ZDavQYy+47GZScT3zszOxuHM1TGHT7ohA4tcP13c4lxLxqSjKcBUkMip
 nWYoij8T0ZnEnF3X15sjLQYk3HsKHp/yyWkVFZxxgIjliwxE4CMYX/F13AeYAY67G/3a
 oweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717429511; x=1718034311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0zQ4HredofNILHiULg4J4DPS8C6yyIAW9Yckq18Fc8=;
 b=Qbnu5mtWJE+qKt5+b/koC3PP7KXgJL13bFYoM+xXOs/Asl/Roz1djvbE/E1gFcXlJu
 ZermyXxHfsBI8Bml7E4TKT8kqa02+DruUWnFVCZbrX43X6sYYoCJiIWvsLAHGgG/TG9D
 +I9hswoh/KGwSRmJO5ZCcSozP8N7wufQ+TIYDAQuDbDtu8TIJi5FpcwRJSKmrnF6VD1T
 cAUKNsSRcyMMfbuRF0pKgjiy6hCBC+VNm4b2fxoj1UQtxCAlW0VpoAx0xP8aM5z0ua+3
 Gy90P2wT4I6oXuoeX3fr5iK2H+X3x6RHXq5bufRaQKbuV7VU7JuU4MkyvNGw7odEBYK/
 lBCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4m8E2orRkeFxywjJON5aDRJua5Wz4IHSx/BTOWLLNEO13zHR+9Fm7WDrk6ugUEAxG5m+QuwoX7oGP2QrIcw99EqML+qs=
X-Gm-Message-State: AOJu0YzchQJHsRL2LbAaq9042roUhNoEA7RMYXJjCA7gOORllsJC/qDD
 UqIWUWpZO3tWghaFDoIYyqKO+6JUopGwvzia1UuE+VKjo0TqZYq6bdbGz2k6K9o=
X-Google-Smtp-Source: AGHT+IFbrzF2exHYmVkyxM5R+kEj3FxMKNVto5itK5euvNV2+7VzEwe0T0dhVA5WvkH2G8VdopDMhw==
X-Received: by 2002:a05:651c:211f:b0:2dd:ccb6:e836 with SMTP id
 38308e7fff4ca-2ea9516177bmr89307731fa.25.1717429510864; 
 Mon, 03 Jun 2024 08:45:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e4f0fd15esm6275047f8f.68.2024.06.03.08.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:45:10 -0700 (PDT)
Message-ID: <a3700c0c-889e-4bae-8a91-e374f8a5e03a@linaro.org>
Date: Mon, 3 Jun 2024 17:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/intc/loongson_ipi: Implement IOCSR address space
 for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/5/24 15:06, Jiaxun Yang wrote:
> Implement IOCSR address space get functions for MIPS/Loongson CPUs.
> 
> For MIPS/Loongson without IOCSR (i.e. Loongson-3A1000), get_cpu_iocsr_as
> will return as null, and send_ipi_data will fail with MEMTX_DECODE_ERROR,
> which matches expected behavior on hardware.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> I understand that there was a review comment stating that I shouldn't
> use TARGET_* macros in device drivers. But I still think this is the
> best way to handle architectural difference. There are many TARGET_*
> usages in hw/virtio for similiar purpose.
> ---
>   hw/intc/loongson_ipi.c | 39 ++++++++++++++++++++++++++++++---------
>   1 file changed, 30 insertions(+), 9 deletions(-)


>   static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
> @@ -56,18 +61,35 @@ static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
>       return MEMTX_OK;
>   }
>   
> -static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
> +static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
> +{
> +#ifdef TARGET_LOONGARCH64
> +    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
> +#endif
> +#ifdef TARGET_MIPS
> +    if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
> +        return &MIPS_CPU(cpu)->env.iocsr.as;
> +    }
> +#endif
> +    return NULL;
> +}
> +
> +static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
>                             MemTxAttrs attrs)
>   {
>       int i, mask = 0, data = 0;
> +    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);

LoongsonIPI should have an array of CPUState[] and MemoryRegion[].
(Or maybe add them to IPICore.)
Expose them as QOM link properties.

Caller wire them while creating the LoongsonIPI.
Then loongson_ipi_realize() resolves them once.
No need to call get_cpu_iocsr_as() and ipi_getcpu() for each MMIO
access IMO.

> +
> +    if (!iocsr_as) {
> +        return MEMTX_DECODE_ERROR;
> +    }



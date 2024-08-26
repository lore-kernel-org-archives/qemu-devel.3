Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34526C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibmM-0001jV-Eb; Mon, 26 Aug 2024 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sibmL-0001em-4y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:37:13 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sibmJ-0004KL-8g
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:37:12 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-533461323cdso5051989e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724686627; x=1725291427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdAiV8yRxDgdT8T6ds75yr5HfntCiTxjI/4+CpLb0FY=;
 b=m/WadDC+js0EdUPE3+j0F+8nuNixNQ+VUiIIX1g1Fc6bRDDhm5240UpH1DTv9lfdTF
 /rxY6g1mmKvX/ceqaZUq5K0PfIp3F0584t9/vcktqG3VUhPl2wIL5UQqvIphVGVJxw7q
 5r2J0HtiKB3mFKwtyF6rbopZi1b8kSuvSo+bOijn+t49fSz/ij0DZ542W6IGj4Fhcy6K
 TuqrfNxLAl/IUBqcqUdci2bMQxn/59QpdDiYOR26SxWI19D2oMi5wFdy1kg7xqiS4qp4
 HOZkRNZsi1GWi92Jw+a6g1ypQH66YfWXVaLbFlA06vczfTKdV9i/Np1bs8C2z7DOlCTF
 HbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686627; x=1725291427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdAiV8yRxDgdT8T6ds75yr5HfntCiTxjI/4+CpLb0FY=;
 b=FfB5cXb5/d5sm30fXX0JmXEUdulxsJ/VyVqU+e+S4c84TNLaFiKVfBf5/r7l7RnUpy
 Lk92wslcVlOZ96b7vgwj1gHp/j2SaHbixcsXwMtdT681qoA8OqoSuMt+kuCMNETx3Lpn
 hADVvnhJz1B6s2ZmVfbeX2/T+mImh+3VjkMESkzgVGLwndlKpmT2PJ3eJPr8pNHlyeEM
 uWowpayWp6xnVnpiGejLM/s4aIIRslVDkzY0Bh0/43uq9icCJz3yV74jDY5MZHLunEUW
 y1sqm7zOAm4YdM9EufQcp6yBkvQ+hn9wg6gK+JgrLpIttEKIrQ39swsKAY5IJ8xzK3Z9
 RfKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC0GRkZf1GiB22004oevkVi6thcusCUylEtNt1IZ/QpBT8n0D0fysV8f3Q3nvShwEpfy91U1oP5GOe@nongnu.org
X-Gm-Message-State: AOJu0Yz43+QljptmdHO/Cl+OEwRLZsOoHj3POT7HU6wATUu5J+kf/NAu
 WrgdH76zHlRI24S6ZzC7sPUp80MAunMPV7NyppS1Gac3+4gZX+m4/bJR43DjSjY3EVvHmaW1DoC
 F
X-Google-Smtp-Source: AGHT+IFZViTfas70w9NC0T4JfgutlrNCljEzXoJPZ5uGIg0u9pqYL7tsbSVtorx0HfS7v3A7rOJjRQ==
X-Received: by 2002:a05:6512:baa:b0:533:4668:8b86 with SMTP id
 2adb3069b0e04-5343885f620mr8462588e87.41.1724686627140; 
 Mon, 26 Aug 2024 08:37:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2a58d2sm675265966b.70.2024.08.26.08.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 08:37:06 -0700 (PDT)
Message-ID: <af06eb2c-273a-4001-8b65-24c2da008119@linaro.org>
Date: Mon, 26 Aug 2024 17:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: fix memleak in sbsa-ref.c
To: Dmitry Frolov <frolov@swemel.ru>, rad@semihalf.com,
 peter.maydell@linaro.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20240826141655.152179-2-frolov@swemel.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240826141655.152179-2-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Hi Dmitry,

On 26/8/24 16:16, Dmitry Frolov wrote:
> Memory, allocated by the first call of g_strdup_printf() is lost at
> the second call.
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   hw/arm/sbsa-ref.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ae37a92301..10984fc339 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -164,23 +164,17 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>   
>   static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
>   {
> -    char *nodename;
> -
> -    nodename = g_strdup_printf("/intc");
> -    qemu_fdt_add_subnode(sms->fdt, nodename);
> -    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +    qemu_fdt_add_subnode(sms->fdt, "/intc");
> +    qemu_fdt_setprop_sized_cells(sms->fdt, "/intc", "reg",
>                                    2, sbsa_ref_memmap[SBSA_GIC_DIST].base,
>                                    2, sbsa_ref_memmap[SBSA_GIC_DIST].size,
>                                    2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
>                                    2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
>   
> -    nodename = g_strdup_printf("/intc/its");
> -    qemu_fdt_add_subnode(sms->fdt, nodename);
> -    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +    qemu_fdt_add_subnode(sms->fdt, "/intc/its");
> +    qemu_fdt_setprop_sized_cells(sms->fdt, "/intc/its", "reg",
>                                    2, sbsa_ref_memmap[SBSA_GIC_ITS].base,
>                                    2, sbsa_ref_memmap[SBSA_GIC_ITS].size);
> -
> -    g_free(nodename);

Thanks for your patch, but Peter posted a similar one last week:
https://lore.kernel.org/qemu-devel/20240822162323.706382-1-peter.maydell@linaro.org/

>   }
>   
>   /*



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46C0C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 08:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWALQ-00066Y-F7; Mon, 30 Jun 2025 04:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWALN-00065m-0x
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:58:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWALL-0006XZ-08
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 04:58:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso2062257f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751273904; x=1751878704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHWetuynf3dOSfzPJHS+bo/GlNX8xbsdHnA7jAMx9Fo=;
 b=gXoz9v9uWzBjpYZ6XHcxUZ4aqslm9ppU1/1oNKK4NqUyFlRJc4POFg7c9l3xluj272
 2IrJSojTV2N/IPeHGQ1G1F/dSqdwLngMaO0C5GfMVquHvV6Nz6T3oRXxZmS9chCotIc1
 Vxl+TdKdLO0zhF846uW7W/VikaA2Q6BMnmPf6SaPlA1o97/LZFv/ZXWPo/Cb68yb/y1E
 lkTt2+DT0m7c7vNIb4DR3mAuLBKbDMHlMeAWr2JQw4fAASf+Bgutr2dZSGAzzXoZfmnL
 mkrGeyqwM6TSjM+2xtOXXu62gH5eVBnmaye7BPIHk7hqwg96OO+jE3ktoko6HXeoqESk
 coXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751273904; x=1751878704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHWetuynf3dOSfzPJHS+bo/GlNX8xbsdHnA7jAMx9Fo=;
 b=iFnLZdB6NPtJqI+wByNT2yXhX4kdEC+rMibqEbQWQ3HdAxfclDxiF6zkKUiUClL//4
 lWvO73MtLX8dQb7yOJefHvknJLFZxVKQqzXE3jFLZW8e8RadXcbkczfeurQIst8QTuHo
 mKl//AQtcRDYrO32uDPXJsggrn3NkMEsZZ03MFPwsamaEyIEQyLLXVRTL9HzSZ3KO7KW
 nhvDkwtiVUZuAxpFNyxj6CaAyG74fUT68shJlo/671jRU3hfnHVUS1ARSMochqnbMCEs
 1cvxozmhpmo/JbAC6oml7cndmX0wLLP2GDeZxwqYJHX9VaDTM7TVxcAh/vhiLWAnjg6C
 /P8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWewOuGYtkFJcScX2NpeZz6W4/n5Iss8J5vgz+/5e4RN1yfDMru6rifIsVZLn5XkwTMrVsyY/E6wXFr@nongnu.org
X-Gm-Message-State: AOJu0YxIJjTkmQ0SZW3mxLj2f4qEfY5kEBeqHGzPyLWWk5vgSC3/95Rc
 we/5/hkaodeRXA9UVPyUdO7V0S741yIwB2o+NpX2knEAGbH/iaau8GJOfzL61vsn+2c=
X-Gm-Gg: ASbGncuTgM3BB3df8zEpuX3azSvZDib92VIpslTJnOXN9qGwkmRTmKtjKRwe0lWc8gJ
 wqpBUJdww238sHFKyFmbKuuLuGllNZOFyQnIdXT7sT6MTDdv/lHkO6Kb+WLZgY6TsF6xpf7XTKQ
 Ww5WCSQ6U8/1p4F6d/fI8gwj4+4EbBh4VFMsMVX3UYUgjPQVQnTPDtvGeJ4gl7YsDoayGX6AsyV
 E59iQeoMJPA8seqe65+eZhG/H6pYtHkm5rRq24f7lot9TK9o7ceKCC1BhmynU5pvp0rEgy4BkY/
 rKDcNtGK/EJaoV40PKnvmg1YLKeX4ANqBsWImPCQe6+/I+QlZ+MW66cFs94kLfPaDkX+19b4nrI
 IEn2lZASLnVbXM8XWlaBAu7wrXwc/dA==
X-Google-Smtp-Source: AGHT+IHjt0uUViR++ixipvYWDGHBsqiMoDNaWynPi0BO4KpI14K3TTBktAVA++SF5qSx2PpsKoYWlQ==
X-Received: by 2002:a05:6000:440b:b0:3a5:287b:da02 with SMTP id
 ffacd0b85a97d-3a8fe4bd16fmr7344603f8f.40.1751273904251; 
 Mon, 30 Jun 2025 01:58:24 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3b3213sm126914845e9.18.2025.06.30.01.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 01:58:23 -0700 (PDT)
Message-ID: <44960792-ac07-4b93-af85-643f2f438798@linaro.org>
Date: Mon, 30 Jun 2025 10:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250629204851.1778-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi,

On 29/6/25 22:48, Bernhard Beschow wrote:
> Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/system/arm/imx8mp-evk.rst |  7 +++++++
>   hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
>   hw/arm/imx8mp-evk.c            | 11 +++++++++++
>   hw/arm/Kconfig                 |  3 ++-
>   hw/arm/meson.build             |  2 +-
>   5 files changed, 49 insertions(+), 7 deletions(-)


> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index b3082fa60d..30eb57318d 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -95,9 +95,20 @@ static void imx8mp_evk_init(MachineState *machine)
>   
>   static void imx8mp_evk_machine_init(MachineClass *mc)
>   {
> +    static const char *const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-a53"),
> +#ifdef CONFIG_KVM
> +        ARM_CPU_TYPE_NAME("host"),

IMO 'host' should be kept for 'virt' machines where we want the cpu
type with the maximum features possible.

For this case where a real SoC is virtualized with KVM, I'd keep the
SoC CPU type. If the host misses Cortex-A53 features, KVM will fail,
otherwise it will disable the extra features and only expose a A53
to the guest.

> +#endif /* CONFIG_KVM */
> +        NULL
> +    };



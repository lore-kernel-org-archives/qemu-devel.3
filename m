Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2036CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aVu-0000mD-IK; Wed, 24 Sep 2025 21:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aVs-0000lT-9U
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:11:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aVn-0000mr-OY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:11:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46dfd711172so3197965e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758762661; x=1759367461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhIHUUlhWKAlN5od0xfoeVS0hk23aHhXFxBsfij08Fs=;
 b=WvpVNLVzEcubiAk7KrWW7/T2dbPdNXQ5krXWGudfg3bzKMUhz+Yhfli3oFzy5fhrWn
 2KjqQBvgBbFmlqpLCc4PLCfVIEG/lzhAB0rsIsQTEglwvlotQeA5wItO/Lod5kV+yoR/
 DSVjXCcJVf+QWDTZ18Yt3VWKfpx4RSoNLMpmVe0ZRk4b5tczUoy2r6kx28udYvvdVDrP
 /AH7e3r1+VNO7EAzWiz8lgTjfhzkO+dOKmvesy+6SoX86I08gARhAm43CJlJJ2OcH/tX
 jFZaYO9BHnCPuKjy45sEtEUVhJm0Z8wJfnb0hYt+f24bgFGmX0pcSYlr05znz5sszmIt
 ucsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762661; x=1759367461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhIHUUlhWKAlN5od0xfoeVS0hk23aHhXFxBsfij08Fs=;
 b=kzhMtTDL3sr2DhaS28o34EwY4EyKzdCZaFKsYIaADLYKZa8aJqcmyQfQ3bFunLYSiP
 WPdhvNgtxSQev3eehqzsOX/tbB03cqiEMULGvshB50NYRFQ8t4ucL6hIexzgjqHZt+uj
 UI7rQyuMc3OJfW18WD+axbX/gt7CnzwhhK56xwVRV40e3Ifv/IHW7dpAizZ/3DauOEjO
 S3nrZ1cNc20d9vBF2Gbzdscbm5m+GzyN4NWl7xd1j1GNTeg0OMSh6AxTP6FYO1mWs3eT
 2D8QQUSsyKP5mC/lU0/mF24At9kU0IYaUgcZgUZPm/BXjXlP96LfsLemdCptPlGHSO3w
 nvHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXufOuNeRJBDw6esR77+mVk6QeisxX9/ElainOqO0mF7w59k38DTlnT0q3CNtUVBuKM00luO+V+2oT7@nongnu.org
X-Gm-Message-State: AOJu0YxCTAhxFk3XkmKoBNZXRGj6Y8ueor5godbqUaO2w27YRSlGGkQ9
 ZD3caS4/AVecHD8WeoZWkYfMU7cpby959u3ok44GpycJpHCFpMP5DhhfIsqasFKdvTU=
X-Gm-Gg: ASbGnct+8YIzv0H0F7Ull806XUE8EhmH0iIuIqELoKPc4eTJclX01MdBUUrgE0xgvWt
 eQc2mN+BKemKmLaWWUy9dUeh7Vx9pf8Fi61Q7WvYXo3JdMf627CmPbxTZTIP3NuyiDT4DBeQd1y
 9sp2xF2WgC0J/P2+fico+TLncZsbGeFARtuybT+Rh5m1bQMb5yz+yRi7o7K8BWosU3lTwdLc0+B
 uAFbaCnBgiCFjSX90WYiy4PZdFEGyJvGUnFXByHoeQbVWAo0/Q5K7wKFftmOMqtf4k940EI/YQo
 4yG+Zmhgtv5iwK+pqzTF10UB0AcF1UJie45O97VXHdinUPBcNCr/pIEQFi/xu1691h+XXm/EHJ0
 KK3dLM+RFxT/IVbxB/SgBFUdHkOva2pW7bXg3SMM/wwDpWkyNHxs0RIq6/WFoPy3j2Q==
X-Google-Smtp-Source: AGHT+IGZCC/okg2JhlLmjECODSxCdvEx8rAnVxDAqRTAE82888s12CHHrbUOsYXtweyE+h0j4mVWtQ==
X-Received: by 2002:a05:600c:4f49:b0:468:7a5a:725 with SMTP id
 5b1f17b1804b1-46e329d499fmr16316125e9.1.1758762660702; 
 Wed, 24 Sep 2025 18:11:00 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31e97sm53790225e9.14.2025.09.24.18.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 18:11:00 -0700 (PDT)
Message-ID: <132cc9e6-bab2-47d7-bfe3-c08ac5fc6816@linaro.org>
Date: Thu, 25 Sep 2025 03:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] hw/gpio/npcm8xx: Implement npcm sgpio device input
 pin logic
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, peter.maydell@linaro.org, clg@kaod.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, flwu@google.com,
 andrew@codeconstruct.com.au, Hao Wu <wuhaotsh@google.com>
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-6-lixiaoyan@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925005832.3708492-6-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/9/25 02:58, Coco Li wrote:
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/gpio/npcm8xx_sgpio.c          | 134 ++++++++++++++++++++---
>   include/hw/gpio/npcm8xx_sgpio.h  |   4 +-
>   tests/qtest/npcm8xx_sgpio-test.c | 180 ++++++++++++++++++++++++++-----
>   3 files changed, 274 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/gpio/npcm8xx_sgpio.c b/hw/gpio/npcm8xx_sgpio.c


> +static uint8_t get_even_bits(uint16_t n)
> +{
> +    n &= 0x5555;
> +
> +    n = (n | (n >> 1)) & 0x3333;
> +    n = (n | (n >> 2)) & 0x0F0F;
> +    n = (n | (n >> 4)) & 0x00FF;
> +
> +    return (uint8_t)n;
> +}
> +
> +static uint8_t get_odd_bits(uint16_t n)
> +{
> +    return get_even_bits(n >> 1);
> +}

Candidates for "include/qemu/bitops.h"?


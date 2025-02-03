Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97013C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezZM-0008Em-U5; Mon, 03 Feb 2025 11:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezZL-0008E6-6w
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:45:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezZJ-00086o-LE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:45:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so31948745e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738601104; x=1739205904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HwTx55omfIwn9vmPW4Ylr0tYSCsYYdwY9ilDwZcljFc=;
 b=dRd2RCaCX9RC0tYiXZ66Wy4Pj793SFi+BJiDcqcfRYu/HSPkhHXVGQJ8X4B3Bl/RoR
 H1LczXMirkj1J/ct9SF2WZ84tUvBD7ldiwCnwA/MvEV7+mv1+LY3fx+LZoVL/2covyBK
 T1aepFrQMrI02ErOrUgRWS4VLucIHv9s0rzV2fZ0iyr5Q0PWq2RgJ/GNliPxtZycbKHj
 skXQuPjJEPIaTLvHmsn2302iiW6rq2MvTqUUds7Of2CU9EB64hvXw4PTN8Wkg48oeoyG
 umVOXzxk6elviWJ7jty552wX7g6rRefz2Y4p/sf69w7cOxabMtsF/UF3SDGJTkngaauh
 zHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738601104; x=1739205904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HwTx55omfIwn9vmPW4Ylr0tYSCsYYdwY9ilDwZcljFc=;
 b=XxVipKoMZqwRv8oaNpoCTmiOxOPBty8IPq5IJLMi1GdnfwI9z3I4BtEVTieQJUMO0H
 WpgACjn1M9GFPoJ0NQ4Q41AONfQm4Vim0Y45EA2s1zulEqjEfbXBF1f3fHDSwnCmzuiB
 G5VFZLII80WHxSkvb9DoEGbWzJGKNvotAYvNjRR+0KtVWzTDXv0UEiAUODgmpqt5gjaI
 PVLT+RVeka6DIszpmbJO6Vk069ep+G10ccM/nmXTZGLutF46/JlAkWQN3HGyRDFhKD+Y
 iVvv/yHg2+5HEzyhRBO9EnLN5n6oE8elUbtydNtHEB73ZmwGKtTI1apMNyJG3d15iSYm
 U2pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU2+D0nBH+CjwyVu18sLqEcvuHV+150V466c3U57C4lriR+K8WD9Hv2WGBgvUqOS1ayJMHX+0VCIuF@nongnu.org
X-Gm-Message-State: AOJu0Yz59VMUrTkw3z/XwOpAfVJhidhsEE6UavHArk/NU7z1cZh2TmGg
 HKI+iCqlKQCsDqzYOhgHNWclccdF/a7Fa8Hg8i2ZnuUMRy9+/J5ISzOq/v4ht7w=
X-Gm-Gg: ASbGncvD2RcV7qw9b4e24v8D46N+Q60L/rBaAm8wdiAajf5LGHQ/ljvBOlCheoWnldR
 dfCnrOlihynXEysrVV8pEHKISkOrbpm2wtScRWG4Q+72Y2wIV5GZl9JsCR0KeZz/JtnbnXve5fG
 Lt4AWsoQA1rYmqwU+hn1Jcyh7xurKnn/3idMvzTcQERn6WQOfkhh/3wrpjsPKeTtgyfAgyxO/vD
 LghG0KzUfepo1/pik+/v5YdzQSQULLLtSWWBBIjNGb9fQXwd+KAS8dZqQGaF7wAeG72QIyPVMnV
 dDt/BkpTYo+ZFHr1+9wGFvwcrn2cpSOORxujSa9brcXEagdbup9mUBcKdoM=
X-Google-Smtp-Source: AGHT+IH/O0uQRyvhpGuXfc9gJ4kXTe69ZsOfNxUpWc+ECBDc2zpsjT0tmJh4NG8D4a9J6c7DcPOmlQ==
X-Received: by 2002:a05:600c:1f15:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-438dc3a84aamr225539795e9.5.1738601104140; 
 Mon, 03 Feb 2025 08:45:04 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec7f1sm13038493f8f.9.2025.02.03.08.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:45:03 -0800 (PST)
Message-ID: <119405b1-d7ba-4d61-bf7a-e2b0bce32d6e@linaro.org>
Date: Mon, 3 Feb 2025 17:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 4/5] hw/mem/cxl_type3: Ensure errp is set on
 realization failure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, mst@redhat.com
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20250203161908.145406-1-Jonathan.Cameron@huawei.com>
 <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203161908.145406-5-Jonathan.Cameron@huawei.com>
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

On 3/2/25 17:19, Jonathan Cameron via wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> Simply pass the errp to its callee which will set errp if needed, to
> enhance error reporting for CXL Type 3 device initialization by setting
> the errp when realization functions fail.
> 
> Previously, failing to set `errp` could result in errors being overlooked,
> causing the system to mistakenly treat failure scenarios as successful and
> potentially leading to redundant cleanup operations in ct3_exit().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



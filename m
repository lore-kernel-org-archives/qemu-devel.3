Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB40CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITLt-0003c2-4B; Mon, 10 Nov 2025 09:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITLk-0003Zn-SK
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:58:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITLi-0001Ey-20
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:58:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so37216465e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762786707; x=1763391507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TnIi3O7z0FDXW4dTw5vpMbVOZY4hrHB1tXHUK1da/Pk=;
 b=RP/xf6riXR4dmFQkaibzhh/odzLdC+I8z3GO7aJBFz2GBwvMg4fK30lgtbk3C4Lxxm
 MMyN3HzIe85tnogocSbEoXnt+UKYNKeYEDKSSq90TnbcOYKQ0fd9XQdw02ABNC73XjnN
 fs7V/jRXRVres03wKo0Ytp399gUtwvaVKJU2VVoYZygbKBAklwaImcy82p1C1pUkINYD
 v2IHKC6usu7ak6ymYS3kt0BeXSSPRyTWxrM8/npQS9sOCml0r/HlBRKdvtBrAQ1bDIXD
 H7hOAKxfUtb0Xnout2BdESFcb/lV7gz51dxin4LLq0VlHOppfe+NHVCVq+mILWRnLAgI
 v2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786707; x=1763391507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TnIi3O7z0FDXW4dTw5vpMbVOZY4hrHB1tXHUK1da/Pk=;
 b=B95RmdZeIe+5IxPbDihYT+UX7h99yDa6ulk4WBFb+qfh2vPfHQGIYlKUYYi2yaqsSG
 2DJ2KAoaprfCqQ+tf9HWGnIVH3gpqBWZF3LEaGuonLmPTLlqW3Z9kmNBJZuwlI85Sesp
 RJaulfRV/btCXYfa3FVegxd1P4R70953iPbX1XN/wDNrHsPe4hmygja3tp1k1ZcXogQi
 9vooLKOfmTPPSdYEjsgYUqyeVnAcwESWzYgmKDlDp0/2o/51xVTCaDQ+74+5NbCYAyHT
 JvLDyHOxuu50ZF7Sy+iQKKWaeE2eKA1S1o/Nk8+k5XcdLgA/WgWXHu5NPkvBwLAHWboj
 NmmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeCpksWxthKd+0/nUwEYEYwvUsERmt/ERcGmKp03JXsukH/Qs74Mp7bJGGV8KUt2sfr2Ay1cyP49YQ@nongnu.org
X-Gm-Message-State: AOJu0Yxt1LgFXYzWtw0H6ryuqSH1gWVzuwxRNZg6HvyARWlIU/6Sbq4L
 jVynqNFI2XjxkCW4vwFmUPje8QymFJnKWaSz+aV4LB1vA+eQ1D8dxywRkdak1ilmjdM=
X-Gm-Gg: ASbGnctgledPdDtH+Mp7mmySvlwjZFEmsIAdR2WTmLIXEBeD0u4rrnyDHlbHVTbYifF
 Cl00WRtSWVMok32c/7/sYTr0CjEnpZdAmU38y2XRvnIDIuGzmo9PYRDgQjrwMS5a04OLULJY6+T
 BEhKkYnpVdo7lgSi622HxAvYQf+gdRUBeE2akZ+RFlD1F0bUqZWTIIhqakAbXCYDDRp/50K3Vfs
 rF34ve2DdY1O+rU2baRS3UD4jUUTVvVU94Ygc8f8qGplRcedvi4IaO+w4lc9L31sYX2y9hTsNIv
 LrDG8AYruqxrfF5rmUTKLfKht6DDqbgDBc2jutsA27+kOrFrQ8B6wtCL2mNia4gaeXpoHTC7QdV
 uI/1HTO4tiqp5Da9/nyOCgaiHrPriFHOwe8Il2ViSXqi2UUtB4TnuUPN0Uq9hGD7ZQuq7L6QM+c
 LEq84qethDsC9VCuW2p8aaqyQTCvm/EfsSpJi77t5NfHqdET0IsofWie9VsdGU22bZql0e1XAVF
 bx0Q4e/qA==
X-Google-Smtp-Source: AGHT+IH8CinV22JzoLRIWc8gEQYetEzFJELDJmHWKDGNlCkPycgtsa7LggqN0wZzWy1eJ4UIl5umhw==
X-Received: by 2002:a05:600c:5494:b0:477:7b72:bf9a with SMTP id
 5b1f17b1804b1-4777b72c251mr44369555e9.28.1762786707500; 
 Mon, 10 Nov 2025 06:58:27 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763db453csm121669635e9.1.2025.11.10.06.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:58:27 -0800 (PST)
Message-ID: <09d88466-8ba6-4548-b2d4-dded9bed37b9@linaro.org>
Date: Mon, 10 Nov 2025 15:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/12] hw/arm/aspeed_ast10x0: Add AST1060 SoC support
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251106084925.1253704-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/11/25 09:49, Jamin Lin via wrote:
> Add initial support for the Aspeed AST1060 SoC. The AST1060 reuses most
> of the AST1030 peripheral device models, as the two SoCs share nearly
> the same controllers including WDT, SCU, TIMER, HACE, ADC, I2C, FMC,
> and SPI.
> 
> A new common initialization and realization framework (ast10x0_init
> and ast10x0_realize) is leveraged so AST1060 can instantiate the
> existing AST1030 models without redefining duplicate device types.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 61 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index c85c21b149..17f5285d85 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -190,6 +190,25 @@ static void aspeed_soc_ast1030_init(Object *obj)
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   }
>   
> +static void aspeed_soc_ast1060_init(Object *obj)
> +{
> +    char socname[8] = "ast1030";
> +
> +    /*
> +     * The AST1060 SoC reuses the AST1030 device models. Since all peripheral
> +     * models (e.g. WDT, SCU, TIMER, HACE, ADC, I2C, FMC, SPI) defined for
> +     * AST1030 are compatible with AST1060, we simply reuse the existing
> +     * AST1030 models for AST1060.
> +     *
> +     * To simplify the implementation, AST1060 sets its socname to that of
> +     * AST1030, avoiding the need to create a full set of new
> +     * TYPE_ASPEED_1060_XXX device definitions. This allows the same
> +     * TYPE_ASPEED_1030_WDT and other models to be instantiated for both
> +     * SoCs.
> +     */
> +    aspeed_soc_ast10x0_init(obj, socname);

Why not simply use:

        aspeed_soc_ast10x0_init(obj, "ast1030");

?

> +}


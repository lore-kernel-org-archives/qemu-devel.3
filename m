Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AABEEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE2v-0006K9-Lq; Tue, 10 Sep 2024 23:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2u-0006D7-Dc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:29:32 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE2s-00016X-MJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:29:32 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso5257324a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025369; x=1726630169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WrSzehcvXIz+Tdo5Z4PEfhKZ6Ym/D4gbm9MyOC4bajc=;
 b=JApCpjj7DQenSZO2e1GAQBJYgbJDMPeFX2nKQ5TW2xUvIkW3qRN/DaZsmy86hCYdzI
 4E92Xo8NdiyOaYP2IxspRv8TIv561dL7eMPccMzk6ZKvnzB/oDY8o0YPvqG9xrTWTML6
 sDVJKM/xw0b/fGlD5uM3iXMAWUGwIPa3EYLaHPmvOOgbViEX4RJK+7j3DuaGM9Bq/WX0
 mtI3wgIkg6Oy8R8HZhzlgvwz1a8t1677WMIyucaKJXkWxNCTypp4Ck9zgMOVY0qgJDnD
 IezcX2h4PcguZTbMsytwac9jLEjLKvgpI0TMXxbP0hRogcyhtBixS1jGszB71p/6cKBD
 7fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025369; x=1726630169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrSzehcvXIz+Tdo5Z4PEfhKZ6Ym/D4gbm9MyOC4bajc=;
 b=lFlh/2d5LSdynsNNC9u3gmDLakkVwIwPCQOYHEGZG4exYlG3dHvZ7eijRUP+IXa0m2
 F9nsJZyNoakTQMYzmPt3h8P0AnDbtc9wmcfuFigOfl4z3UCoQVUazX4xMHcloJ+h1kfx
 2QlzkgtpFYYQNtcR/f0VxBswscs9fhWDaLr7N10vu/G3zIRhq2Ll/wwItaizwpbSsjU/
 rFZqevPmuC14cvHTSEAdCZq1eSHMYk1ay0PjuBr9hhpd97G8mlFsFQZz9op9l3ikMRUd
 HbTjVwjI5h9trQ5sV1oTP9F2TfclCgv9Bsv3XKasTZFWqKNHppDLlr+zn0dz4DpQcM/h
 ViTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0U551Hd0X88uLRtZhIEQYxsCLwwMbvVUzSh3EVm/p+1bd1kvGM2AnU/9rc12DmMkf+asa9qbQCiAJ@nongnu.org
X-Gm-Message-State: AOJu0YzPjBhAtRIwB+ZtZtBMtZPbRg65JVzdPSRJFIfknI/IIQorDoP4
 QgtvXcsayNmo+gMxCQwf8JVN0PH7FEiEkCs6AkPBW2uDynHeXnsM2dtHpdMFbpk=
X-Google-Smtp-Source: AGHT+IEScqXv97OiAuBhjhKs/pxTJ/cW6nXC1a0FT9R5ZgccHDER92nUftJDKGx6hapMfATDe+mQ9Q==
X-Received: by 2002:a05:6a20:d50b:b0:1cf:4c48:5c07 with SMTP id
 adf61e73a8af0-1cf5e115b08mr4472697637.23.1726025369291; 
 Tue, 10 Sep 2024 20:29:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8459sm2054154b3a.24.2024.09.10.20.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:29:28 -0700 (PDT)
Message-ID: <cbe21fd8-a2e2-480a-9c41-6df82ccafaaf@linaro.org>
Date: Tue, 10 Sep 2024 20:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/39] hw/gpio: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/gpio/nrf51_gpio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
> index ffc7dff7964..f259be651e1 100644
> --- a/hw/gpio/nrf51_gpio.c
> +++ b/hw/gpio/nrf51_gpio.c
> @@ -40,7 +40,6 @@ static bool is_connected(uint32_t config, uint32_t level)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       return state;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


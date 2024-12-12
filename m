Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEAFE7717D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 00:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWeq-00042Y-Oi; Wed, 11 Dec 2024 19:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWep-00041p-8D
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:19 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWek-00034O-J6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:19 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71deb2025dbso53418a34.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 16:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961732; x=1734566532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oK0zIqbAdfEqP60qOwghnIWmq/AYF4LMXG9DAGlRvLY=;
 b=BREMci6R4C6Z7sgkGh1F4GMfjm7m86t3MP+HA+xzff0FZwVrQ0GVsmzmUN1rds+GPY
 OypSmRFvCHd9zvSiKpGHSX1t5qK9/OrgueCiWWFHvyfohCmWAP35+mMdbcSbdqdBa4xD
 +YmhSzZp2HLWDf1MoNY72HMYsUqwkXCwDNLtQ2qFbIe3NJ2kkIzVFsfU9IzE8Jxhs2vM
 1Gevlge6F293ypaaaUlAdGCjlnTWxDL1WM3ItjS3sG4CGQZxl3u+UYB/7XxY0eY7uXmm
 p8FGd551LJsXC2EGky96nn4ueAHUct4GHWgjdj7zcYLkv2+CbObsMF4IF/4OPUjt9shI
 Mqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961732; x=1734566532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oK0zIqbAdfEqP60qOwghnIWmq/AYF4LMXG9DAGlRvLY=;
 b=CIpqajAq8Maan/LiC3QTZYiaGfvHRKO/2t7y9FF45QWvBO7/kqEpqkQZkviqeWFxSS
 QpI2DgNtJCMpE5I8Id6t3aALxnDJOPwbtcg5EQv9lcp3Z7ut+JFVXAeQwzMn/lxKr9zH
 bt88mDISNqQIGhXCqh8BDAmZV3N49IssX3R/9o6SCeLkNSJ09norcOORc6KguJat+qqq
 Xw/MZRf/QKnjLELsmoLUlovoO30HS1oO7eexUfRAkRPKS+oat2jlpzYK/qVvFMUPtA7x
 8dvUVGT40oAvLPRQQP62M6R3fE7uUy9hLMdx6zsCzZ2790mkSVuCxBP/ss726urdnJEv
 5atw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/9aFPcB4u2i0JGeFGs1zlzlmE3QQd6mIKR+W6SO3Qgz6LXno+/C7xmRqKUo0V4iGBg5EzuJeSNee3@nongnu.org
X-Gm-Message-State: AOJu0YwFFqfIIgmOw8GjkUn5Tr/1rzt1wktkIFF8K8Kr7K2Ul/YFEJYG
 ZEHIo67jdagVA2dwhR4QKBWGWabbPqBeoMaBp3kdKGRW/VnXb5swm39TsZVvS10=
X-Gm-Gg: ASbGncuTjH76KeGOOpAsErQx5BwLD4ztcDk3rhtlsB1kYCHnxokCMoRjecLLfD6CJHF
 DSLU0X+j0jedBi5IEbDw+tRk+PEmtHD/HiMzFGMjwI4yWlFv/hiKtXce7ABW5mAIrFQWU8B6wp6
 n+GMJRJDIHbUlgYoaSfjgl79+fSV7AiKwkFlNB9Zpm+wuLsJT2JJA3NSI0EdJnyq+7Jtc+7RR1a
 pp/5IZPzKDH0twfDXn4HKvh7BiSEo79FmtXVWDVvHWVL0ZrHIPzi6iqfMPMdOeDEZ6xWC0+VbDj
 c7nKQT56isWKIp94HxeQF/jLyju1doMy
X-Google-Smtp-Source: AGHT+IF/rrbiVcNCEQWWB+SRPPxCtpE6kE+DwwyUvM5d2fT+ggq5yy97C433XvczGMCaoAsAGFg5Mw==
X-Received: by 2002:a05:6830:264b:b0:71d:f9f1:7f3a with SMTP id
 46e09a7af769-71e29c47dd6mr977981a34.24.1733961731873; 
 Wed, 11 Dec 2024 16:02:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e155ec9efsm777274a34.70.2024.12.11.16.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 16:02:11 -0800 (PST)
Message-ID: <0b64e23e-84ac-4f2e-a91e-6366e3de0b9c@linaro.org>
Date: Wed, 11 Dec 2024 18:02:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hw/sh4/r2d: Include missing 'exec/tswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> r2d.c indirectly get "exec/tswap.h" declarations via
> "exec/cpu-all.h". Include it directly to be able to
> remove the former from the latter, otherwise we get:
> 
>    hw/sh4/r2d.c:357:35: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      357 |         boot_params.loader_type = tswap32(1);
>          |                                   ^
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/sh4/r2d.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


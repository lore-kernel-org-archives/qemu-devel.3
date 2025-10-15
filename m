Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6CCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v968k-0006Qm-Oh; Wed, 15 Oct 2025 14:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v968c-0006PV-QX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:22:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v968U-0001EE-GP
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:22:14 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so8365823b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552519; x=1761157319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8KIwWEpZ8fDpkvniRKvSJ90U0nS7KGwqkmpiyoio9g=;
 b=cbajl1BGct1bfl/cLtB8eaChz1pUJkvZIJX+y9EZbKGWst4XQia117hdVWi7oc4L1y
 RUNhIrIxSftbIw22Z2dAJuO/VM93wlarGygayZK+jcO2rb2cmduorYkgyJ9CschfvFJr
 WvmeU/majpp4MxNd5QxE5ppqXMQcrTiqvi90f7jR6+Jd5BAicLtpskGbx+unHMZcK1Vu
 pRmB3Q2WPSozz92+uLSoGiCckks1TZWf1mOyhb4u9lgOIGzuIlyE3AFJ6CiAPvGpudSl
 FPqFAHCkETCArDqRFu/n4hWQBoFIFbf6yxCjP+jErEJ2Xrp88yiqB2IunuHre+V5O6q+
 pD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552519; x=1761157319;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8KIwWEpZ8fDpkvniRKvSJ90U0nS7KGwqkmpiyoio9g=;
 b=nDmRA431QlPnugXKfyAqZ/qpaFoOvutCSv/yQAv4ZJdmeEJURHldUHBh8K4wwG1mWc
 RPzhKyTP9JKNx/bBOCQ9yYP3NwEJB7b/JA9PUgt473En60uwmvKk/XgLfoyzoEwesX8b
 n8kXFt7y0VkjNO1jsfrcWFVQaxqx+QhhVCs9VwqexzSwBN9e4BBFZd2m6RTJUN/9TU2Z
 XGc3nxC/dQT0lXjFy9M92UR+MCkPOjhBLciUEuLRSn5GUbWVt4T+8Pp+B6P7DoE2u+fq
 tqshzBlqYu0KxyqBClQjeDf0gFF2xb/AVKl4IoAB3syxHcOKsOmnklTJaiivW3gAs6kA
 DibA==
X-Gm-Message-State: AOJu0YwekjCkaKHnayQr2X84+C5Gbu5wSYhx7tMsMGtE+XEuSrs46x4R
 XKt0IX1iFZDt8oWX7QIRx68PUEQ4GQ5KB9FfIsq0reVh3HuaP10a7zVvo9gD5/U0Uup/D3tgVMT
 jpTOt/bc=
X-Gm-Gg: ASbGncs+Gt8Lj6ER44pyMaMyDb9Li9nAPvz2A0cerMf64HjaYZPBs879zgrKjA+N6qJ
 5LIJFrfQ4GHl9NypGkKaz540B0ml7FUgjWNoY1O0FF47vLRtgPSkIpAB4mzL+/43W6SyzXKO+mX
 sfnCr5T9o2EiMFSGlveTJ62/RjnW3ByHHRhD8dulmEFyUw3Tu14r9I+Wca4uYpYlvXcHOQyWvlF
 xHGQlAoh0LxNtg69ci+7LuHHQl/Yt7KuDRwuFCP3k4XbUHB1h4aQsRAdsN9byFPiSTHX06Uqdgs
 6A0gr57ZVhaN+7hFDkfFiNeCnV4eDEfp8ROfGWMvcql6LzVw7OnEK/suiL8v1TOD4FVkuCEsmgs
 ibmjFy8o6jZzTmweuNDv73cUJXe8rTSaWZOtumtInIVnW4mowUhn1dILGCiU=
X-Google-Smtp-Source: AGHT+IEzlCu38AvLIeQ3XLNP3+NyDtBFMkOPgNmtyKxWqYsw8NSt5g8YG2P/Ezae+6y9nFeY1jXfzQ==
X-Received: by 2002:a05:6a20:394b:b0:2ac:7567:c069 with SMTP id
 adf61e73a8af0-32da8138f47mr41763650637.17.1760552518983; 
 Wed, 15 Oct 2025 11:21:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a228a5b91sm298043a12.15.2025.10.15.11.21.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:21:58 -0700 (PDT)
Message-ID: <7466d8c9-c16f-42c1-8e42-f4c6a877aa96@linaro.org>
Date: Wed, 15 Oct 2025 11:21:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> TheCPUClass::get_phys_page_debug() handler takes a 'vaddr' address
> and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
> cpu_get_phys_page_debug() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/microblaze/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


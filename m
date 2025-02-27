Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80A1C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmAf-0008Pi-JH; Thu, 27 Feb 2025 17:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmAc-0008NN-G3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:15:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmAY-0001a7-EW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:15:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so9958255e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740694549; x=1741299349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IegA5Dj/ThsKrckUWQ9Ykj9y/UmPIxtvY71qVVKLfM8=;
 b=uNHeo788Qf/ivJtpoQ/wm4wVHvLAXSrq4gzkSfHkPYu8zcgCs9gEzoLd2ehct/FKP1
 DTLEvmYVLu6r85Hsjm8pz7uWQcowiVcxRKcZqe1k0+FPCuRv2mouquRm3i5VPHKCRg6C
 nRUugyRNxmO3C7hn4xGNwkecRQjHsFSunU5uhGjNQz5CCxbN1T+Uzc6XkJt63Nz4xyXI
 7o1u8odPAl/u4y6URelBrIStk2op87MIu7tuVg/OXsmg9W/X3VkuGQTWIodwTI6Z0+s+
 9OKrjryuDwpn2pa1lWXJoPtD4quQcCGbUM4qFK0IVKa/0GDUKdOg54A/qOz1X5fbTm/d
 qaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740694549; x=1741299349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IegA5Dj/ThsKrckUWQ9Ykj9y/UmPIxtvY71qVVKLfM8=;
 b=HJ+v3pBt6Ro3QjeCnShg1UKLdd0IcZGrt6GqQXefDhntIyQ0E1vLFdiVXBf5H2l4KB
 KR6ickizmAvmcCVUA2OO/TDdDNnO/KKqOcQz/n6aPYlzNt6h9UBTs0sRgm+FfYFHtoao
 eXrcRzMIfZpIiIYUFyiP/G38IUp4ZFWnqcM5Zx6von0TfqHCIcv+LJUILTw3+dKCltD8
 wfTJkUL8D3FdsHEMVHtfBSIDeD7QsQxU++Rn7rbxZWUZHDDJCmo8x8cX4g8WOfAIRYv2
 769rYxV4B0tlkaGHUlhcwdWv5BCidcEbCV+mcIjn44QtC6pZUnOlkhTFLt4sXj3qXiKr
 plCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZ27hCVzXtB/uficBehvcXJuDPwOUjg+kprkXxmH6FGDfrl00DTDeIQzeGujTBQxkqpT0PrXrhRBq@nongnu.org
X-Gm-Message-State: AOJu0YwDqar9uivuEXvyy1FJRFNImEjqWhkxi+pjhHSCj8vR0ILxNLSi
 IpDaFAtZFpBQ6tKEzT/y46P5QbeIBvY34aQSkcrnl0I0yTKOADbBHqSlfONZ5zP5tx29r/QXu5Y
 KmQ0BBg==
X-Gm-Gg: ASbGnctbKyczMiyPYcu4Wgty37X8QdmeBbu9f7ne3e6PfbFzrIcX1HrIvumDEpv+03f
 sDP75c4SHv1qNwzPWToKnmQiTlsybVC1gMQehAiySGJ19oxDycReAVa3E++DtM0ujlyeXkRCuqs
 +VgCUshhRqFmUq1SFeuikhXoXgIFUTXAb6pMTJ+a/XQElhc8jK3cRFPSO0IIH89PcLT2FkHs1SP
 VHVTKPRkXCDaC/ynOWjFwn9h4uu45JgP6u5KqQjUo/dBf7NILIqNOnF9GyvjnWMSeeEMHaKOJ9I
 s20ub4YdmtPs88hGX2mRvGVqIw4OXQOnTMUoQeryGcD3Y+IJdPWEy2jEN9k1n96BEG9ePA==
X-Google-Smtp-Source: AGHT+IE0EQ5Mfp9CAWxTbMoBuW/UtGcJY75UMuax2dLEWiyR5HTYal57bzOTmfUdmzZgZKQk6t0T9Q==
X-Received: by 2002:a05:600c:a45:b0:439:5747:7f2d with SMTP id
 5b1f17b1804b1-43ba6758476mr5477615e9.21.1740694548931; 
 Thu, 27 Feb 2025 14:15:48 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53945bsm68273605e9.23.2025.02.27.14.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:15:48 -0800 (PST)
Message-ID: <8c4bb9d0-6dc1-409f-8fd1-4c711487b46e@linaro.org>
Date: Thu, 27 Feb 2025 23:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
 <20250227170117.1726895-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227170117.1726895-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 27/2/25 18:01, Peter Maydell wrote:
> In omap1.c, there are some debug printfs in the omap_rtc_write()
> function that are guardad by ifdef ALMDEBUG. ALMDEBUG is never
> set, so this is all dead code.
> 
> It's not worth the effort of converting all of these to tracepoints;
> a modern tracepoint approach would probably have a single tracepoint
> covering all the register writes anyway. Just delete the printf()s.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c | 51 --------------------------------------------------
>   1 file changed, 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



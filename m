Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jNF-0003dT-CA; Thu, 25 Sep 2025 06:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jMw-0003Yu-0Z
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:38:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jMk-0005TS-FW
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:38:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so5128495e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758796696; x=1759401496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9PbL6NQnWyxoavrDNdDaiuOGCD/mo82PXktNucPzjYI=;
 b=XGFP6hxoO7Rpe9Aol00vb9ab6L+V1s6Vhpq7RwlHoFYYCgMkR8uJXKuvc+FIaHzNsz
 Rsv7orvsmLlJ5a1b9t4wqjmW5A2DcCk1uxbse0Wyv+Nkte4GcC5l+JEgG6emrbDZVH8Q
 Vciq2V5FJlh0/aOQ0Oeg+UVeSNKVaJ9QwhxLts9o9pyF4rRa//qvQzyX6NAck885G1Z4
 SBTRMmajQOfmceA4sxXv6teILAl3VNg11lrSqQ+PiMmzWbsbcWJZxcaEZVH3bKfiAa2p
 LL9plCkVg0v1qrU9PyoRMiFNsvACiQaDziDV4F/qOQNMvoCJEjgJUMjIhy+BJoJ0Delo
 B6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758796696; x=1759401496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9PbL6NQnWyxoavrDNdDaiuOGCD/mo82PXktNucPzjYI=;
 b=aBIAHq7a3Inm+Y1ft7mrHfc04wNKJ8SUTFkUiTaxdGAlmSKLWQsDQsv4Ly7w+T9B4q
 1tEBk/JeyQHdZsGSPdBpzyP4Dx3FDbBAMlenxWufuS8jFWCoZlLdoU+D3u2ME3Y/QTd1
 GJtVqBBrpOqawJZjchkIWGsrM+EqsPN0m5a5L4T5fd09TnB5/m3VrIi2DYCZt4K72O0f
 u4Dp5apZAkhYRr/+/O7WPdH9TlmhlOV7+EnLT5VdIlvtuok9AoOfMQrhcvgj0Q+c0woC
 O3wEOZN3xChP9lrmNgNe3P8+Gx6Xsm+qIo1y3Kv6txNyXamjkZ6KTvBXCz+bWcs1bgw4
 IGOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtWQkFWDIvo0R+r32AqTU3kx6c0d8Q7nxWpAlXckFlPc66JyXNN7gno6Qu5UlMXseixOs0asrkn4Xs@nongnu.org
X-Gm-Message-State: AOJu0Yx3+8RjWHVNS+/PbaqRO4k5eQC8odDhHQIchCMYae1N4219u7To
 p9XFBjYeOMDsdvnyBX3IiLlp+FQuV5lUL8Rca12DScaFXmLDvhEkc/5kBAd9unlKFZo=
X-Gm-Gg: ASbGncvzto9hVHjjoFgUmUunmEACTyonOE7W3YUCxu0WfMIvaYGeMk73cv37jl2kZrN
 dHXpEc3RF7uUMSd/HapbBJHgl3GDRATIMi5OGknxBmyybmN1gRGTm1Kuq6DQiYrcXlMW2R5Op+Q
 9wimf/yMC9XdUfZUWo6PNvtwcWpaEHaXaPhvkAc3yW7uK+VFfgFtIGRF10Lx+gKplCMN4TrYGLc
 lgKkdsSMFPIc2d1HF40DVJa4WLPgd0fW+p0VY9KQNbaLq45mWejVmzrJ00cCnYns6PJ678yl2up
 mY5CjsJmsOrMcL5Skgrff0LJ3wxoaGHHqI3RAAGdBjDQFvMZLwCysIXbNZjOlIBtjOHjH0ozII7
 ZTKCzzKG2MXGPPFCJJs6gIXM6QEgkTScHKIQ+xxG3/WEzKxjJ4icLqBoygAe0a/d7Og==
X-Google-Smtp-Source: AGHT+IGLe9d3Xg67w/f1Zpl8nVLJb+4ZGH9pTmXKHHx5h1rBsJM4SqS9BfxuX+grVams023mcJUGng==
X-Received: by 2002:a05:600c:35c8:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-46e329fab19mr32973615e9.23.1758796696506; 
 Thu, 25 Sep 2025 03:38:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31f1dsm71175885e9.13.2025.09.25.03.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:38:15 -0700 (PDT)
Message-ID: <8ee0b130-6504-4922-af32-48db65d15a42@linaro.org>
Date: Thu, 25 Sep 2025 12:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/36] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Give a name to the bit we're already using.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



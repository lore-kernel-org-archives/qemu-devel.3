Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53284C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvkw-0003Bs-IN; Wed, 15 Jan 2025 00:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvku-0003BT-GY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:15:52 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvks-0006aW-RC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:15:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21bc1512a63so48289535ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736918149; x=1737522949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T4jHLXfC7bWKmG8mswF8v8W6ayI40uJwz/7BT2G/4y0=;
 b=oJ6gBHoc15jlex2nxC45vwR98p2dPyy/nRGxLTYpUXLSB3inHAX5YCy/1iEHsuIvXq
 MpaY7ycTDT6k9vSzPXFhXkLdsvAKvpmPIuQ8tzlqnJ9Qyb+csYN4TrcbcIejRxQ3yNyY
 RZW4nkehJkfjshh7rccdzqrGlnPJN1zp6XjA+JJEadGb/kxA4m9vLbAiJQU9GKXvgQCH
 guMSomFDZh+uxWQfb2iXD0WkmN8kaMYmKFoEpBF+WtBSTcQ8kSfc+ca9jMXM0ZGlo7IL
 Gks/APHDWaaNa1gOgvkqcO6AeVnXF5vra0xsqCrENvUzO3dbHd7o9zgqZd7l3tL2NOGK
 FGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918149; x=1737522949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4jHLXfC7bWKmG8mswF8v8W6ayI40uJwz/7BT2G/4y0=;
 b=qZcg5N2lp/siM2/bDn0oQayElfOTZW4O1raifcTWGdoMXa8QgEjyVpAfR0utzudjEK
 /zGKxXtjD/jx+IjrnE1qC489o8P5n4T4q0bPUqW/rIjDKulG8fac4TAmpI1DLaVCg8g0
 w/Nj9Ld9xy2TH7pEFDJ1ORTTEr3njHBFxnzHCy7zLbNcKGUtgsY4kzxhn5+w6PMsaCXk
 uKkSfXQZbpi/iqP3+dqVq2UoYvWrj5sw7BiQKuZRWBv2I5TlzLhJfhH7mdV23LRgd7LO
 ZUnrmprwu8KoTV1ZWgjG/9oATUORjUKgHahW2p2L0V91PQ125pD5egh1Yy89Kle84U7t
 ujpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdWzoVUyI2Txt5BTcmGjJNzQo1Fhzm7vUzh3OMLduEOuD8jPHWIK0jOJ3gSiZag7rqUiBY+ul23kLs@nongnu.org
X-Gm-Message-State: AOJu0YxX63ag+yjGf88ApvFkGJvFuKoZWcj0C30YzpgCr6T1SyqfJ1gp
 TavYh77YH1KMYDwG0W0EjLi2JQhJelu+kb7DZwal4kQmEgJ27MU42IDqB12WhnNAQYGTsU3elZB
 a
X-Gm-Gg: ASbGnctoBSDMXkLtS2+MLYGbru9H8BJVoXI8U50V+tPIuUiZijeNyGo2ZXs/9naIn6V
 onUNAGWOUKpja5QImhbkqn620oAI01PgY27LBIlMCnzHgWhVCD8iGr3/FLc4LNVU4fy8hCY1HiC
 AaWeBX37e5HbjEFtVF9pxpveDFxMYhgtkSPCllL4iTDJ7NGWShueS+74FjJp1P5V5HJsqsXpewv
 1Uytq/halHsS59kkqVrQM8WiLBy/fHeTlhAy7ayNeVW7SS2EzFLtxvTfModkUw0xDPffwFaFrel
 QoaH5V0IUvddFhHrOMqEYi8=
X-Google-Smtp-Source: AGHT+IHn6tfzXW3RbAIEm4boCkFGTe9eg7Llr6p0iFeYnh5S7dvMMRTpNMy32Z92ljr2rRBApCWgzA==
X-Received: by 2002:a05:6a20:3948:b0:1e1:384e:20f1 with SMTP id
 adf61e73a8af0-1e88d1348dbmr43233827637.25.1736918149117; 
 Tue, 14 Jan 2025 21:15:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31d5047df6sm9012446a12.59.2025.01.14.21.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:15:48 -0800 (PST)
Message-ID: <a8803e0e-9e50-4d49-ab76-773c24dd2bda@linaro.org>
Date: Tue, 14 Jan 2025 21:15:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/mips/loongson3_bootp: Propagate processor_id to
 init_cpu_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_bootp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


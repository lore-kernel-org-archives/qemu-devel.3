Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61DCC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvXg-0006PO-0U; Wed, 15 Jan 2025 00:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvXd-0006PA-VJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:02:10 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvXc-0004C3-Bm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:02:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21636268e43so147844055ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736917324; x=1737522124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xgQlJB2LXR4zDUHKxyGyp2tq6MiibtBpmsnVV71gEaw=;
 b=Y7+se1mIWamcWcN3lhio9694oRFO9hOD8IHf02EjeOI03p+Nzydh+jIZJHu1I4fwvQ
 XCwqXxe5R/DrXRtizI3B/FjztSLhz6FirGGtTY/xT92JwBiwLXnJu3bfHMipQ58j6qxL
 q8zNj54LMwUU5JfTj0Fqu0zsZGyArT0umJN8rLLzIvLVxHSYNdPJXpucN8AEH8z42B4F
 QAc8pNK9vFB+EvfuDdAmfeleKEG8yY5+ZoXC9TU2xr9O5b+tyGTn5+Ls2PusyzzTzuYe
 /mqYK+/Br4n1h9c5Jfk1MEdiXyEob3/AcW3VLBmeiDTkrbSrWgEjEbOVbrU1mfsEpVZ+
 TEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736917324; x=1737522124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgQlJB2LXR4zDUHKxyGyp2tq6MiibtBpmsnVV71gEaw=;
 b=XQOOVCeWesKv+J37ucvnJhS1BaFzwCvhvMCoChs2Kwn/mdlkFhHxvqh8XuMnqhQXx6
 g5L8WaoAACuDZPfNPoI2lvsfgdhtwKU4LqRP+AXLz2iJQivr9OEz48Jj+oZwZIQAUW8x
 iGvMsgT1uqIZDAeiX+lVY+MW2jiBe7Fh8EwvpwVQA8EbJu7S7Ik5JUNDI11DuffY4dUG
 N6RIou90hTZtgZh75h2WHXI0h6TPTvjA7Dk4MEyh3LEBTcn7aBV6rvevxpYTPhA3HyxF
 6ROY+xE12POZVWn+1Pqf42NWSxtNEJ00oqWnSeRwtddIpFQ0qZntI8TgQuzM0rq5eej1
 w+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhX4Iq8lnem26rNWzEgvchBFJ+T5pWjPS2kD3YIIDwIvEkGaEbnx2l/7jvaVXyJLplIq9lXBlm7Olb@nongnu.org
X-Gm-Message-State: AOJu0YwpiyTYEzHVqZZad7iwL3e63HleB491sYESeHxTbFnktvQCoX8s
 8ai8o0hu7oBZXln2LC6rQMstRH1EBK8a9T9KRbL5uCgfUWzcw23LgVhtdmt06xo=
X-Gm-Gg: ASbGncvKqEWeSFllRAFRxRCgoua+SWpw8IfQkuMGvnNQ1QdiI81+Bo0nGXLK+waMJM4
 SdLIoFojW9cYv0piB9AhwqLuYEIu9NPiEQgtPHP9tEv1WS7zM9L7HNYFkh4uCyIiVyITZxz+LbG
 27cZhny143IkUj9S4B2gNXmyigjiMkBD/YHXZ02eXfp4F/iZtWkBYr6O1ReF1qhzeY7pgr4xgVS
 1+CkLczDaQteE4KKRM2cj6MIANjITdATSsAv6G9X/sVomb09FzfZI9xAEmUWIclRette5NzsKCL
 FrFhym9s1k+clk/bkHE3vf0=
X-Google-Smtp-Source: AGHT+IEv99T7h/E5juRVQfr3oQY5PqStTwy0VXDTsXnjvrMB0J3aBpG0tXxAx9wwavlBP0w56vwDGQ==
X-Received: by 2002:a17:902:d511:b0:215:6489:cfbf with SMTP id
 d9443c01a7336-21a83f48cc0mr415759355ad.11.1736917324003; 
 Tue, 14 Jan 2025 21:02:04 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f217d56sm75076935ad.141.2025.01.14.21.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:02:03 -0800 (PST)
Message-ID: <1a4e4e5f-9bf0-462c-885e-5cf5fd033b7c@linaro.org>
Date: Tue, 14 Jan 2025 21:02:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/mips/loongson3_virt: Factor generic_cpu_reset()
 out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
> main_cpu_reset() is misleadingly named "main": it resets
> all vCPUs, with a special case for the first vCPU.
> 
> Factor generic_cpu_reset() out of main_cpu_reset(),
> allowing to remove one &first_cpu use.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


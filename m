Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DDFCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBduz-00053f-9I; Wed, 22 Oct 2025 14:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBduh-0004wk-5Y
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:23 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBduf-0004gp-7u
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:22 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c288d3f249so2896458a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761159017; x=1761763817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyVxWv571tllo5fRnB5mLx45pLmANbMPf/xlxm8Px64=;
 b=cMBpsRCXaMlOrla2HAeMY52N+7XuPzGDUrwIlsz4MaJCdT9b37gKZuLbQ5AHJPVLA1
 +iLGlYfKEhktX/23OmDdaoQBQZi+duFBCWvR17VoV41YHQy54gk3XiXrHm6I+Nvgjx+O
 qgL3uX1G7kZguU8ypEpABleDCw5L5YSa9uQyaiRIsvIyIZbFcIpY6eHGEunWeVpf97wt
 MemRjf9GHF6hYcSYK8jPauy/uopNyecfsoLBcUHBHty+NL0DK0dGNCa4o104tehYc+cO
 dnlW4xFNw0cenE7YVFbW/Xgyn3nRUosVN1p5WmTvZeSG8d9nwaubgRgygU6OacamkNOk
 WN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761159017; x=1761763817;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyVxWv571tllo5fRnB5mLx45pLmANbMPf/xlxm8Px64=;
 b=UbLCzyi24Rsca5usCNalWHU2733B8jUVoZ+GBKQYdvmVMcoxkNdI7AAtffbz3LjqWu
 04a57fpWFIegkdI8ngD0AswZCXgnbs4ilJWMotg/Xmdki+ygvBXnasF5LiQmMz1NtWII
 MWu+QxG1sI1f7sXWykli0zaSS6CfnOSxbCAkB3WmxArv9Ck0+Dh9BUuUeNX9cDAB7KjV
 qAk4bkywS6QS7g2CXBPduT1+EBw05/b0lTTE54yKxHGJnNQIZCdnSE9JYMY0gk4NfAYi
 a7JJbiqH4cXsaWe+SzbLqDe9eEuwfP1dSSEYXNpPSLzTNaDYojysxniijHiMQnvgiZdF
 3aZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYRP2G0p28ZIQ7QKMJFN5ESX7dCqRTvfxPRfYYojWI9S4Ps82G4FZM3tkHJbVVWkfLJakYEvLKRz+X@nongnu.org
X-Gm-Message-State: AOJu0YyPsIyKepy4YlxwIijN7yFq0sHLhxnhcK8igwPnFXRaQJhDk9cc
 DOe7HPT6MLgmDT5wGXqWYQRlwXKNRNPvui8UHfhS1hFkhrFECoMa8WOIRhtakdgENnU=
X-Gm-Gg: ASbGncsz4fSWx7A3uwiCn6qD04jKTyH/kqZmYfSyb2/y/9IAxjMgegDk5+yKqciT1aV
 p3o+qF0rAq8cjo3kVYNNY8wsaJJ9DY1a6u1O6dSeZgnUpGiHeth9gIxu+6Qi748ezvu5RJ4+esk
 OMuaVgmeiF3xuR6XpYk66ia2Pau6FcPhzPgSl77H/cHjhe86z5MQf1RkkxiNqpenR6VtKSyCjZB
 P2z6Dg9aoFWf4bfL0HQg6JUhgE0xmcx9p23KyVMXdAvWSjoJwSIZUmZ31jsinqaZcxzUX8US/m3
 mcfLH6+ES2v8GFmYQMHL655ZKDwqdGvEb90Aa7D3FvqSOjpUMjWqVxaeDCQZi844LFPGLPv0qzk
 5RXHWd99Oov9Zf9OQxJbZ15AVzf+INS4wahKv6BUw/7dyIiQP6fLrd9KrrWc0aDUu2Bz30aaQYL
 hYwidkXWthUQfIxZUcpy6K6vvT5APjHJ3TwdNsKBddaff7uizcrmhRABOuzpph
X-Google-Smtp-Source: AGHT+IHerwEjDMOTvA0iEb8poRu5khthYXybygj70OtaBMuNE1mi+mGkTYlFq0b0oA2JZGtbvkSRjg==
X-Received: by 2002:a05:6808:190f:b0:441:bd1f:58d4 with SMTP id
 5614622812f47-443a3153b7fmr8951241b6e.53.1761159016768; 
 Wed, 22 Oct 2025 11:50:16 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df722e5csm3438723b6e.24.2025.10.22.11.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 11:50:16 -0700 (PDT)
Message-ID: <e7f6ba47-0e99-46c4-8f45-35f86f9cc038@linaro.org>
Date: Wed, 22 Oct 2025 13:50:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/hppa: Fix firmware end address for LASI chip
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-6-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The base address of a LASI chip on a 715 machine starts at HPA
> 0xf0100000.  Make sure that the firmware does not extend beyond that
> address, otherwise it's not possible to access the LASI ports.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/hppa_hardware.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


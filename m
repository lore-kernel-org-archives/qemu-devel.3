Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B896C3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmUa-0003J6-NI; Tue, 13 May 2025 06:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmUU-0002uB-FY
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:04:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmUS-0007UL-S3
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:04:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so6444265e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130638; x=1747735438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gHNllcDu2HQZYyj8yiOKeJzlIBkFOSv3kPJp7LTifm4=;
 b=ncPT5JE3WvM+mNhxtqbSXHiJ6lkMSfB/AB0ZuLGoNQ/sTEaYG0qxWJgS7Kuo1zLLe8
 BwsXZ6pr550kFlXZh4wSSv89G8NrY7IJny3LUvR0++Bpd0wA3gqPDrok9Uy9YZUqaBXN
 bJFCD9zIhCijuIWL4S5lAplFrjgo67H+x2Huz63Ld89mrKsboowopTXIb2q7Yqy91KOe
 tadC5VQIZ9uAq3jvHUt0hbgzQga1bF6oux51CCvUINfwG9rNqLczAu6tm7+o86WZhAEU
 TE17Zne8R0qUGmNE4To1miMCJYvF8kiy75E14rFLfJtsU55Wzdtw+k/dlbzx62WpYJ/1
 STuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130638; x=1747735438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gHNllcDu2HQZYyj8yiOKeJzlIBkFOSv3kPJp7LTifm4=;
 b=R+aq5L11nOj5T+Z9hHh+m4+0VJCdb/LqRp7f/ZgPvU9Q7XqFqfkc1pVk6iBgOnW0a9
 dTj3Slfnj+eoK3mfEz1cxZ0uBLTD+tRlPiJBPW1ja979TrwvtlL3d/LHxlsSWnmEQ4Qg
 u+FxlU0kj5uppyjJ2ToYuOQWzb2Xw87F4zCwLJY3pqUQ51Whr/90nM9kJEA8lbmgvVqR
 tdDnXhSED1Y51zRaA3w3Ttn6h08BFqwMsyEgMjVkUGYSS06PQy4XwDYmyIwROiKlLbcq
 y+w5NNs1uqyRz/MMTjDNxRkn3CVX2f0YVjy4SJAjdFWq7g2uIQYnVWAGNUmWBZJE5VXt
 fJEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdZKRjS+2KVY7hYNLcOxCqbfdk84fiiXW/bxAd2FBevo2IxFt901bdunMSsw10WJZN9vXPRHLslTID@nongnu.org
X-Gm-Message-State: AOJu0YwVSWR2NT8xtmmo1VjXXz31CsDqbLKn9P6g9AJEC17VnXYjOg9W
 AKalcCF78nBCm2URN01ZBNLDH3KEGFqFk0ocOnZ19JODNH8AnTjmMHPg7yDSRZU=
X-Gm-Gg: ASbGnct7+uahqdu4IeJMogJ1laBBeY7TWlBShQ7N5T+0eBRlbMVvFqKv3EBPwakzKEO
 nUTPETn2p3//b5cbOybyJMdVYcMWPqWajuBRaztoJ7PRloxy3JEJQiJzAN7bxI4agBEya8gYFJu
 2DAYu0Ie/Bm4rQZLAw2W5CY23BjKlQvGZKBh5sButcMhfM5e1iHljytHszh9NvSHlOpafJ4docW
 XguwPBMmz7JT+DAeUuEqMTR441tkwakqU8u1wmAsDvMEN15Wpu5e47igmPCf8x7Ret5NhiPdoMQ
 aD16hgWl7V03o3yNZ8yJtbqb2jIr7SnyeNLoevKOf6uFR2wuOl2WZpwlsHoxEcRC31TK30YR1aE
 91nSZOThuVCD1loy9OQ==
X-Google-Smtp-Source: AGHT+IEhDYq/2I/yiB012F0CpLUUrDPMqhK0hGH6CL/pJsXqNbfYqCTrgN/8H+ya9oRU8wBIk7adBw==
X-Received: by 2002:a05:600c:a00a:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-442d6dc7cd1mr130023615e9.21.1747130638618; 
 Tue, 13 May 2025 03:03:58 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebd6asm15839035f8f.35.2025.05.13.03.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:03:58 -0700 (PDT)
Message-ID: <6e69551d-bbef-4ce0-8eb3-d488105ca7a8@linaro.org>
Date: Tue, 13 May 2025 11:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/48] target/arm/helper: use vaddr instead of
 target_ulong for exception_pc_alignment
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h            | 2 +-
>   target/arm/tcg/tlb_helper.c    | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



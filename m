Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52605C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuw65-00071Y-Fc; Wed, 19 Mar 2025 12:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw5v-00070Y-QO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:16:40 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw5t-0006Gd-QE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:16:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so811289a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742400993; x=1743005793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SypaUVmE5B1/v9h7ovW0a4NKvD8LajiKcFr9/zrH6YQ=;
 b=oewZzhqmulu9DIVSuHNZ9e8lZz9qvZn602GZFzA5fFfJu4b8jr/2ufOK2F19V26PMj
 jLFnjL7VI85bkSI2g/PA6sWWqPlOKevWmGBq8jMcvtrea2Gl70NA4I8Zfwik0jDKroRe
 ZIB4LUFWNBxeXwycvBAw+UVTKjGR7yrQs+jLK5w1dhtFzR0X7fyMvrkZKVx/xgqxqtF0
 kSuOr2F0j/srBfsDE+AsxV4WCdhvXTAQMXG4ecGb/qZg9KubYd9KBw0WOUcp6zqbBAyU
 0kpDXtewYqaEXh3AmYzGc+rvoML5cU3Cb4f0CRJwLwIVY6PlB8mRQ2mkcKXiDd/Gljtg
 cIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742400993; x=1743005793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SypaUVmE5B1/v9h7ovW0a4NKvD8LajiKcFr9/zrH6YQ=;
 b=wzu1XTMhMZ+jvOVBJIyXehxKMVBGL3jl905cWh6BVLQU4Phdu+dfMNZnqnTONJG/RX
 vuYCpKW89aRJGE8EPp4JKBvTbK869kOHMr5519G/pPkYNc+qKwltKdT0RmKlo+1aixqp
 q0ojFVAv8gr1xrTScWUqR1rKmVOyjM92qtJ5yEouqbZ2hHJV0zETWxta+M9pPW902gKq
 ASAOf3kEVtbOc58A+z8U9v8xWl/AEmzjZZg3us75/WVPVyCq/kmn1npP5I2C6X+8vKfQ
 NZ+54RfaJj5KSbnsU+W2deUOc0ETYKgx06UnQ8S+AdORPjJRKigEuLO79mnSQWumUAK2
 +7Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQV/oFb0lWcNDVfXhVaXvZcREcvnf2tFHye98RE4QFqbpXKQnkZ1SEiLWePLKfdRj/JroWzb1HMNA7@nongnu.org
X-Gm-Message-State: AOJu0YxS9mxDkrSI/jbPVuDecHYc2fbTHmUDWksBO/nWnTR6gvjH5CHQ
 9kQsbXa71MdY8NV4qy9bEsstjDpuZ8e0ClE5ZhnL6tzIM5BCHbHsmZ4F/hlv/Vw=
X-Gm-Gg: ASbGnctJqkZX4gC5xXRNBig0pXVTt9JDnmRKTCwjo6+dwrDLM28Qu34095y6DMrGTKX
 ut8ZV4CSfLkiANYnKQvwv44pQwfE96XUnVp2mWdCUVni1M02Asp/WusEukpAz+XtgL2RCyb9wQL
 rDEzFZtBGP8NF5RdPFLcptc3z19T/2Ybjap7lVqQD7zS7JO6jq1l/rQrBMLDjY3sNE0A2U1L74x
 jCYo53zOo33h4yEKxdy9sjbWOrQ+IF+gLgJbM99Y+FtPJXzuGWV2OmPvN9PGyba0PjtL3g04xlA
 n+9xuWkoeBGIUEmji5jyVpWJkfMUkXVXDOgAZ8oSAx64S2muzfw2Kpx7lwbVTPwLpGFUzXVJf8n
 qE1XTMgYh
X-Google-Smtp-Source: AGHT+IGXAwvanQxeXIFuOnw9naQbY7ulWm1vBXvxkv6EXnUUS8t4LAAdWjriEnZUfUNMoPclqavPRw==
X-Received: by 2002:a17:90b:1f8d:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-301bde6096cmr5713769a91.11.1742400993433; 
 Wed, 19 Mar 2025 09:16:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5a1591sm1803762a91.21.2025.03.19.09.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:16:33 -0700 (PDT)
Message-ID: <c573ca7f-dc63-4c6e-a49f-86eefe705665@linaro.org>
Date: Wed, 19 Mar 2025 09:16:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 03/12] tcg: Have tcg_gen_insn_start() take
 uint64_t arguments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/19/25 06:44, Philippe Mathieu-Daudé wrote:
> Since restore_state_to_opc()'s rework in commits d29256896..04f105758
> and TCGContext::gen_insn_data[] widened in commit c9ad8d27caa ("tcg:
> Widen gen_insn_data to uint64_t"), tcg_set_insn_start_param()'s 3rd
> argument is uint64_t, not target_ulong. Use the same type signature
> for tcg_gen_insn_start().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op.h      | 7 +++----
>   accel/tcg/translate-all.c | 2 +-
>   2 files changed, 4 insertions(+), 5 deletions(-)

Your argument is flawed.  It's not that the type when extracting is different, but that 
the type when inserting is intentionally truncated to the target address size.

It's quite possible that there are no longer any odd uses, since I guess all uses of 
tcg_gen_insn_start are now in TranslatorOps.insn_start, reading from 
DisasContextBase.pc_next.  If so, I would consider changing the type here to vaddr.


r~


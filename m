Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D8DC36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tve4b-0005Jl-Uv; Fri, 21 Mar 2025 11:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve4Y-0005JI-Si
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:14:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve4X-0005sW-14
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:14:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so40299845ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742570047; x=1743174847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNuwLb8wMmTbR8Jyl6o/q3m8AVIDe4CJwfvTEVtMvxM=;
 b=aukagm4cLTCObzekizD36faXETtFXgy3F9xShcniNSGC2xZ94DoGiQ93VD5bvrKsfg
 zmuexbr83sfA7S+ZKtlxJgrxjWcnYpzAK3h+mx7IeT/eh8kX6qvPi3HyT1uJK1iPjbTT
 z7ZuEbCi583aN9YRrTj8wfbxR+gjcsprEjR89JKtbIsSxt5hKhWX8dpEEpzuM7McCrjz
 4AzKOvUEJKBj6N0bt6PUmDjxKb/13x9g8UYVm59Pl9tn3EjK/zsV5XgRnsXaWFu9Aiwi
 cRzUWHf3gfLAYCjLyCpDdxgY0O2x4akPU0CR7SRcHn+SjwmD/1+UblqN5jnP+MDO+uxR
 xACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742570047; x=1743174847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNuwLb8wMmTbR8Jyl6o/q3m8AVIDe4CJwfvTEVtMvxM=;
 b=rCiQ2jJTcVZQXEkyqZ81WURRgslc6clWogymcSH21gwBqXrE+/j0gFW3wI3F+JT5LK
 bSzafRjUE8iS26TwsUffxtLMw9MzmEYpI/k4ej90SJogq/eRstcSIni4FLYL8fM6rlz2
 UEY39S2P7RMnEoN8MZ8ccg+Mgk0/QwsWN7qR9LUUre0L9zQXQyHB9Cp+eh2Uf/W3MQE5
 AdtcgODlmFH5mJfBO/Zzrhy0MogjQjLMdL5Cc8PiR7YMUvxocKyUJQEKb5IAo5v/5Ocf
 iQ/uaUlU8W4S5aUEGSYqfWcTNod4xCW4eeWtPsbgGNKdICjIFcLgyQPGUqTNmf7lL5wb
 wsKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKeNeyTX5n2ub1+BSVeMr9O2T/h5ScTTMANW9cpLv8lpoR6twCsUKaLAPpcNHop89D29QklrPNSspJ@nongnu.org
X-Gm-Message-State: AOJu0YyXOOUr9h1eRsmA7v9evWrF5SW2pTFGeE7xyFJfFuBboyLAt347
 LbjG4VwdEqDn40Vno/jhhUzWz36vuA4edaY3MvrueHWbe8jgOhAzJIiaLRzWlxs=
X-Gm-Gg: ASbGncsJOeyELcivQmzN5NSK5+iAeiNHySIZV/O6fMvBPvfzp4fZ2ORqApD/yDmipxH
 iaAGqJfP53Uc+NxYzDtqMqqTEFZAmGJs0m/gvcs3FQujOLbaGlcFOaNFC9P1q4pAdNA8nilrRAr
 9w2gSBZ5hudrYalb/Nuboalvs1OfKnLR4jFU2JHlAiQABNg4pwtk9P2Rl1yCyGJBviPnSurxAV3
 rSQgFpvsiNJoxUp9UMfuZWxw9SCOdvYwuFFLHIM6rUBGqY+Xm1TmODugWYYutZS485dqU1GWe+G
 TL1Uj082k4BVNfnGX2Xp71PSZaoVdHX1RIyokxKjTUoXpg2jmIIkK7KhIL9LVz+chi/u8ANNslx
 f/kabIPX+
X-Google-Smtp-Source: AGHT+IEnoq9R0oyth+GYfj4Z2IJ95D3l2+Z+L1aj11qtHE/Gr/E4JqvKasMRxYW7SdXYrHJpe92yWA==
X-Received: by 2002:a17:903:32c3:b0:226:5dbf:373f with SMTP id
 d9443c01a7336-22780c5413amr61068755ad.10.1742570047025; 
 Fri, 21 Mar 2025 08:14:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f459fbsm17997085ad.78.2025.03.21.08.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:14:06 -0700 (PDT)
Message-ID: <699630c9-17a1-47dd-87c6-b9ec68e8ee02@linaro.org>
Date: Fri, 21 Mar 2025 08:14:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] tcg: Always define TCG_GUEST_DEFAULT_MO
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321125737.72839-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/21/25 05:57, Philippe Mathieu-Daudé wrote:
> We only require the TCG_GUEST_DEFAULT_MO for MTTCG-enabled
> frontends, otherwise we use a default value of TCG_MO_ALL.
> 
> In order to simplify, require the definition for all targets,
> defining it for hexagon, m68k, rx, sh4 and tricore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hexagon/cpu-param.h | 3 +++
>   target/m68k/cpu-param.h    | 3 +++
>   target/rx/cpu-param.h      | 3 +++
>   target/sh4/cpu-param.h     | 3 +++
>   target/tricore/cpu-param.h | 3 +++
>   accel/tcg/translate-all.c  | 4 ----
>   6 files changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


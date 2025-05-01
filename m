Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0537DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVRP-0005JC-IZ; Thu, 01 May 2025 11:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVRH-0005IH-HM
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:03:03 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVRF-0007Dn-LM
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:03:03 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso1158237b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111780; x=1746716580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkq/VdLFYJfyJvgcdgfMRsRb6Gxm8UUMs/yuzG02xU4=;
 b=e56qoWAXt+TRFt3zniU/Jxc3RM/erdoE9aQ5HBETG/iM+bV5b5t2WdGxGUMsqBJSGG
 f7/CoyX0z99rYrUVYZoaYi0slaafNCNZ7ICnwTFCxwM7H0NiNTI4vc9YKwSHemqTK5R0
 BU0mS7K5yeIUEujMjLlyTaN3KSurP1Z37+hVPIXITJgua0NFoLRz4nCe9F2YO8Zde/56
 7yaRQh/oZne/xbw1AwuHVHQ7buL/FiLZlatQ8AjstKYQdvEn02mno8PmeikUOQU8FeTe
 SjNwbazM+BdKhxE9jdV8lP7WknfecVH2CsycJ1PEWLpdjqfycFVQYVdjzcznmmbrkQuA
 i/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111780; x=1746716580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkq/VdLFYJfyJvgcdgfMRsRb6Gxm8UUMs/yuzG02xU4=;
 b=Y9r3ZYO4/0hIgIxZLsNNAUlJtRckH4D+ABMla1GJCaZsa1ky6l4gky7GEExEWsUPof
 fMuMbSoMaVKIaudkTygQih+55aM4VsPbPjRtw9lvl+s4Cw1eOHxZp0xWRCuNNJbHxoe9
 XrEQdyw6IXTaTaOi4cYlX05/y+d8DT9+y0Rf1Sf1Lvkvixyd9zOH1Kuiskk6+nBWzvoy
 dfp1yISTR3f/1zoql3OoFguseM8YdqQGnaZAK9SuaswqNqA7HJeS8hHThjDP/IdZImDy
 XeHeTRswVEIX1lX2/CkXXxaiS/LmhUYiJajatM1o8++DZfaB1dRkkciNvCJeYzoRiGBD
 s0ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5YRzpRa21EemA5C1//ytK7zryAbnwoIgT2yULdnrVPtrG3Jbhb1FsKrm9UZ0XAqXFqXCPL2F9P6Xb@nongnu.org
X-Gm-Message-State: AOJu0Yw6MeBFW3guNjzc/V1mgF5Km6WrXyg0kKgE+TfnfdalXooJn0uN
 50ij/u5y4UzZZvE49/nexpxXZPs0mRetnY+08tNGY3SUEN+ZeodpI5u14fbd9Pg=
X-Gm-Gg: ASbGnctO4NIyZ3v0cc3P3l6LjjtjgkQSbFyWJa2TH8Px44dxIoNK0ZrslYXxEo4Jurr
 RWN9C+fdN/Q337r5m0GXHQapfc//YwhA51aH72+5DbovzgRURfPVVcQiLuEj6YxSfkW/Z7VZSxH
 8hkqCdwUSVHi/vcTfPkVRpHhfE7gnX5Bry8Bp+k1HN0OFOW9hTW3ApbLp46RzRaZeU59fWr9NG9
 wnrRCES8jXuPW+tb5s72jgKZ/aIff1NzUo35wNgSRp9kcWoGtRnBmC5yaIYE5H/4wmjaaF4L5cA
 xdwY3BhPBPeuVXGga5Q5+m1VSouzdGuHttv9Z0KhoVnNDAuH44Wk3F/MDJ551yaDn2QQAWJh8Yq
 bWXZV3CA=
X-Google-Smtp-Source: AGHT+IFpQDWzZkr7SDEpQqkD/ISUrJM6vDV/PLa2LIk+1brnq5oSIluMSLUP33z0eD1oTrBqKei8Ew==
X-Received: by 2002:a05:6a00:1311:b0:740:3830:4119 with SMTP id
 d2e1a72fcca58-7404790521fmr4868652b3a.18.1746111779927; 
 Thu, 01 May 2025 08:02:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404eeb1935sm938020b3a.18.2025.05.01.08.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:02:59 -0700 (PDT)
Message-ID: <8fdaed14-d2a1-4939-9b9b-5cf388e20ea8@linaro.org>
Date: Thu, 1 May 2025 08:02:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/33] target/arm/helper: use i64 for
 exception_pc_alignment
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h            | 2 +-
>   target/arm/tcg/tlb_helper.c    | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


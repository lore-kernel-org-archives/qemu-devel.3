Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y0e-0002yO-Hn; Wed, 23 Apr 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y0a-0002hk-FL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:11:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y0O-0000x6-OS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:11:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so46497475e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745406661; x=1746011461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60cd6x9b9k9k/Jy4gocYWg6RgC6gv5FjhH+nRo7l1ZA=;
 b=A+p+k2opCyn/7Ei+DEXQuZ8QXuGLDYFmRvNpyZb1TLRgeUG15h7iDc10TB1JxfRQU4
 YYKpLici+aWrhpTspbyFuqIjhJkaciA2xdMxPzOg/Cby/FO/tuppsBUhpCUdsN6+CcaJ
 +8+cPFYWpsSv6uFBL7xqp1NoA5vh0241SOiU1DoXXzzLFTnHljPhv4yJ35LX1Dm9NUbD
 Z5V5VOsGhKReruRjirK5BgibwsvTOl3yzm7KaVyPdFwu3h9fvD+xO3cYfI7fXraVu0N7
 EQxOjBodm7x8ema7D2QYmd92lEOV++oL7BsQM0gSrmhIQ2k2joAnQhsZtLjEht8mZdRN
 lHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406661; x=1746011461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=60cd6x9b9k9k/Jy4gocYWg6RgC6gv5FjhH+nRo7l1ZA=;
 b=BBFULJl6oOgpYHI0Ck4ytrx/NI8pQzqdzhQJofAgteVXO71BcALnp+VGiBozJEs/cO
 L+1KnKw962mPFXwm3Zv/SXj3RqE43HVj34cd20ihWMUlLddlji4Rf64fBH7UODemToJi
 ZfVjLL99NPrmwOeMbmitU9J0lEdmnvO4GvQViay/Im0q2n2jlSr8nauD5OuSgszHdUne
 WIqIhBee2RX/0itPaeeKC7LjWjU+ri5ukk4JmeKAfwlCvneBlrWSlcgh/yRMYu7RKEQf
 yNM74GI3aSzdBugo104ULrVdl4qlCO09u7ByBNAtBKDF0PERqa4Q/yE35Ye0mQwx0w6q
 En+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDTl9v2fGtka9Gr5bCzWpEUFv29uFZPElAg1s8LKv8mYMxi4Gadl0Mtl8qqMM2njOyVh9uCmeRAA26@nongnu.org
X-Gm-Message-State: AOJu0Yw8pYdb6pO76dxjYfsRKAJo4vCKU6RoXYV1YFwfzjUmy3Iiog90
 EslGHYkMpvmunKtu6/7C9tDD9iQZoohUAV1SCrJh09WksH2k0toIKfb4As2u7rs=
X-Gm-Gg: ASbGnctIqjG/fc1O4RUbJt103WOGsxPehzonIQe9KLrv18+XDEjrT7CHCDK772VpjrV
 PT0dv96a70kb06MV7nrHnh8kbZXmDU93L7r4CB8ZfmykC51mXPzsB5WR1hioZs2pp5qIpW8SrGL
 DK1k/uC9JyMQziv/wMcAY/eYT/HuhYrzQcm0R942HUkzXoLB5k5G/dbK1AZkQ/oIl0ZeiDreAhN
 7qc5Z3yRVsoaVjQcoONSEZ9E8EUkXtjREQab8M/3ZCitUcnF0shXoKPqBh/3bHSkyDZvJvGUkHv
 sHbf2inquMgJSGOsjuwVAS+uRoRx/R8bj0Bn27GFz4nYlsdwmaVcV20T0FOSia1dh7Dnmb6C9kc
 pEZ7m+ihY
X-Google-Smtp-Source: AGHT+IEpc50hJuTfPrFGvFNVlv87MzohxFd6AkusgFay/JiovvS9+VjJPi0a5uKqjoRIk5bzl/7GRA==
X-Received: by 2002:a05:600c:350a:b0:440:66c5:26f4 with SMTP id
 5b1f17b1804b1-4406ab703b8mr168120115e9.1.1745406661494; 
 Wed, 23 Apr 2025 04:11:01 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092b0a52asm22625105e9.0.2025.04.23.04.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:11:00 -0700 (PDT)
Message-ID: <cc3f6150-4877-410c-814a-981070b4d49b@linaro.org>
Date: Wed, 23 Apr 2025 13:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 009/147] exec/ram_addr: remove dependency on cpu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 22/4/25 21:25, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Needed so compilation units including it can be common.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-10-pierrick.bouvier@linaro.org>
> ---
>   include/exec/ram_addr.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



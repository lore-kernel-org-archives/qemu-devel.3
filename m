Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354E2E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWVw-0000iE-If; Wed, 11 Dec 2024 18:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWVu-0000hp-K6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:53:06 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWVs-00022q-VQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:53:06 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb7e725aa0so20618b6e.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961183; x=1734565983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JKyA9P5T/PzMjDSVhmu3JTNHYpd7/fpBHnZ2tHClu9o=;
 b=OVm3IT5u9APm3nFuKvFti7fIIlKboOnOLxDr4u22tbJoZR3R1mq1Rt26YuqC+pNP8B
 NPmKM+P1q7Atd5Tz+wTwAu+zgl8escwNYm4N6zaFL29CbXTYveOdcKo1ZBelYZVY9Alk
 sN7ixBm4IKwYRdgDadQ1SHfVPzNFR0InZhFODazO7tk4IG/pYU3Wl0Fk/P8s5la+Aq3l
 347aIfi6i1djmV4DVtLlk7cc2igv4Ng8zvtjllzCnOkZVPE5PfEvWz9GqpQBOzjioZgY
 6P/Js0TbzJtnmq5Dj3dp8z2oXJOg4waA5mtVjPaxVnJCKfB3/ecQ/PvBuqIWLxeasqcK
 LeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961183; x=1734565983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JKyA9P5T/PzMjDSVhmu3JTNHYpd7/fpBHnZ2tHClu9o=;
 b=aQ+R+NaemQ3QKZYhYO9M4OhjZkZaxkAc7gPVBBohpNuIOPg/xKkUH+riysGSSflRne
 gQHCfzh9Xq26c8wUqFssIAqex72ct1Pwv6hWW8NQd+ZbFhwjBJolJynHV6wpDzW7IYLB
 JtxI5oo29UV1LPPTsMspfSYyhUFbV0GsSzJvsvabeVOMht9WMG4Zgp4KDAmJ0Qk8Nzcm
 W54mvp4yBteIJEovZYzdheKUnVG15KLDQsKNA0j5U16scMy9lCJPbkVtN3fBuxWD9saN
 5cerHJp7WcPq5hueUKNB0dH6NBWrZUhMEex3GWc4tzOmBKE8BtJSwjp/XVuzGP2fur76
 GNkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmBUrqfQflNEtsaSgDkuRHZNtNKrBnLdjWYRqmMnbYxyyf5gUVAM7vZb4sc9LBzEwekH7EczXBaTH9@nongnu.org
X-Gm-Message-State: AOJu0Ywu2xQgflBveQsySu2GbpRW8WQ8BdRDaNzJqeAoNQRWP9mu4EZD
 IKygwFV9yZsuARuLlgBG9VucyeKXJHvFUhCQzgZKQSVEkIoINzgHMaWumih+uEs=
X-Gm-Gg: ASbGnctECEj6jW0YJR00eSLnFs2FI6BjWJYBjB/Pw3ZMyid1GKAH7d2QF1+nFcUo53L
 L3SZJKNc/4rS9U2LwafwSmVxd5xOmiZHpLUM0IKsH3IoaSMPpQ/WpEs/NzF7lHwKLmIXFwB2omN
 V2D6jJh+NzLurPxY2YSHVHY8BCikD2HBpuYJawZ82M7wUJ+pYTdCMwRH4+rG3YMPb/9iPNmGQvM
 kUTYTWMijuZqWJNDRJ0N/XAro0yU1gWzkrjP4V/56TrHcvisMNqax8e2AZQkpJWVr7E9Nu6x9fK
 RgNX707A2hH9QsUTR+9mKkQeY7HHzGUI
X-Google-Smtp-Source: AGHT+IFzEbYyT9tQ5kArZdZaeF5n4jMS/O3ALh1AASTIdF7oBGRUS9MgLgMi5npq705jIZ5vC38zEw==
X-Received: by 2002:a05:6870:9109:b0:29e:5bb8:fb35 with SMTP id
 586e51a60fabf-2a38271be13mr965228fac.37.1733961183379; 
 Wed, 11 Dec 2024 15:53:03 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f569a698dsm4123504fac.49.2024.12.11.15.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 15:53:02 -0800 (PST)
Message-ID: <0cd4b1da-eebe-425c-9a6b-b712e0a877e0@linaro.org>
Date: Wed, 11 Dec 2024 17:53:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] hw/arm: Include missing 'exec/tswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> Some files indirectly get "exec/tswap.h" declarations via
> "exec/cpu-all.h". Include it directly to be able to remove
> the former from the latter, otherwise we get:
> 
>    hw/arm/boot.c:175:19: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      175 |         code[i] = tswap32(insn);
>          |                   ^
>    hw/arm/npcm7xx.c:326:26: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      326 |         board_setup[i] = tswap32(board_setup[i]);
>          |                          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/boot.c    | 1 +
>   hw/arm/npcm7xx.c | 1 +
>   2 files changed, 2 insertions(+)
> 

These could all be cpu_to_le32, since TARGET_BIG_ENDIAN is always false for qemu-system-arm.


r~


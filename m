Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475DAD37496
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 20:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRc22-0003mC-UC; Fri, 05 Dec 2025 15:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc1z-0003lV-22
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:03:55 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc1t-0003oz-HO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:03:53 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c7bfba3996so1734928a34.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764965024; x=1765569824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ii4gGuTD/z2aXDf5fpF6enUH0NrhTKpchpffvaxQBiU=;
 b=X+DsiAaViq9wZRBNziY8QLHMMxscrd0GXy9JP/y+69Vpj9wE/TeK1QlL+YfiubnDjS
 s7GAnfjRPyARJMgMR2nL/9ydW8lMmNZhudIHBZoPn2IiiELyA7wxc8Xcg/DATMzYc18H
 c+Hm+o6KDmIXJizGxN7YJShEH+UZdwyqVTmzuiQ4i4vxWPv15/p0okHyd55IF4oO/TOv
 fwrt6uuxFvLz9IOMUnIOSZIOWP/3LkClYdRuI8MkZd/A6M1HXyCzp87I2uYaoUgGYjdu
 nMn7etBJ8GNUfptuzCOmg4EwNPPNttoCT9oodgdc204JrIfmIpQ2bUnxO4edWkYkjy+c
 WPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965024; x=1765569824;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ii4gGuTD/z2aXDf5fpF6enUH0NrhTKpchpffvaxQBiU=;
 b=bTAyM8Iq9OIDyx8SUbGo9dPa+Ft09mY7iBSJylosjcKyCmiCSrGQfbE2gcOrb+FCQw
 opYxbyqQ75CX1HPX2lokB44NaD+dSfHC5UiQxJyUT/1IhDtXRvSRWKJ3lw5Cx5Ha4c4w
 nWbyByENjhXrOtBo/PzXBVp+HGlhuWWt3LWgF1FrkAA5ezM8CP1oRYPf5JKJkH9ePFQY
 HEs3f+2Cd5/8jfnE1ts9ObXzVbjqYPyRZMgI9ycJvYusVDHzfexURVLRG6pMblXJkc3W
 +5LSVr9SvDN8MGn4Gn9QmvuLoL4TpuvAiNkpwqGHZnrgRi2VOJzaVbXFHiIlwrseJsfO
 1cAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXQ8GyUa/QnXIDfbwxWCrci9x5kn38h3B5SH41kPzu3oqrL/6CpgP4fmHfdjqwcm51MFUt2TwrigGV@nongnu.org
X-Gm-Message-State: AOJu0Yxv4HlM2VoBldPOi8SRYu5DzcNQbC4PkQJwzdcPfPRBKBJI8DFw
 9lDKQAxl12erq4LzyOLXLh+h0oHX3y6iegHcg/ZZWW/NQWo6OviQGlO/BzOq6q9MKiM=
X-Gm-Gg: ASbGnctQjc5RV8Jn7Jfw4JtzeZ8nGJTS5hJibu/GO5qzom/zcHweH/FPyPRDzOnyICD
 fgoFPNXtEO6ZKKV3pbsdsaSzgaA8Hx9+FUFL65p/2ncvAiTuuOwuDYcgfGLbLie8nA4BQcKR83L
 Fo8M55L6RzPrN6csqUphEJw6jqVgIOz4NFKDHw/IChf8HHu1qPDinGf3qhay/zIud2NaOM5gI6y
 /KXPYGvVqmI6OpA0bvWYx+ndoZRnSbK+4p7d9+4PUzqzD+Oaq4EfVOrTqI30WRIxI4dNAWy/C6u
 cMnKZxoedYlQe86bzp4qq1MSMs251vNTekn/ZdiE9Pr2xmcW4VIJZNSYdOSZCAiOhYbzZRpnnZx
 g9tbLo1CZw9RQ4ihA4IalgLaxnewoJtyk4g00Y8Le8jduU0kD41lSDzi2D3LQQdQ1mHvmYzsaW2
 RN/2OPQg7yLiTMfYS2U5Ll1oN5cdC3dpWSlewwVTV8SPu3cMd89onp9JyLkpLOGGMi
X-Google-Smtp-Source: AGHT+IFyy+MVG5hiLbRoJop11kVLNRoN1LVDhI9ewaPU6SjUu/H836/2G9meot7821vJ3LV4BL9xuw==
X-Received: by 2002:a05:6830:6285:b0:7c7:69d9:d8d3 with SMTP id
 46e09a7af769-7c970764290mr205544a34.12.1764965023774; 
 Fri, 05 Dec 2025 12:03:43 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91d96bsm4503773a34.8.2025.12.05.12.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 12:03:43 -0800 (PST)
Message-ID: <b34a6cde-6002-4179-8604-2158dd49b7c4@linaro.org>
Date: Fri, 5 Dec 2025 14:03:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 10/22] target/sh4: Replace cpu_stl_data() call
 in OCBI helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_stl_data() call,
> inline it. Set the return address argument.
> 
> See commit 852d481faf7 ("SH: Improve movca.l/ocbi
> emulation") for more context on this code.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sh4/op_helper.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


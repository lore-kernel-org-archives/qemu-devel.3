Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB600E63FFF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Aah-0007ka-Jd; Sat, 04 Apr 2026 19:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Aaf-0007jy-JI
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:39:45 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Aae-0006u1-0l
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:39:45 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso1703845a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775345982; x=1775950782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+vVJKpGt4Ir0Jq3Y1rQ5Oz2j81xkTcnzfMuAaNFhCs=;
 b=Py8d460nLXud+BrNqhNCc/opOVmf3fzcz1Y/wFchnK96Mwm6kTBldbEAXWRDm0iz94
 P2nr4ajWIbjZdPK0ralGpZYnXVgh69LG6WUrsND7GFgK5SNEBa5NboQQZzn2EOHMFhG+
 HmQsVCdXQDy3G/YKjaTFDJopKmrFk1lsuPyHlz+IYR8mv9cLLd7X7hZMpNmfh0NYuekp
 wiFW/shrjayP94DSuq1Zc0E4GkElf9RN6vI6eZ6gQNPzNE3N9AP6+cGe2RFF4fp+Ks6Q
 k9sTWqW5F/5trUeI+SI19g21EOPO93rRgWffqdDGJNtIG0H1t9lbpeojdW2Dma3a3VgC
 Omkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775345982; x=1775950782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+vVJKpGt4Ir0Jq3Y1rQ5Oz2j81xkTcnzfMuAaNFhCs=;
 b=Yj9OpALNiosRhh5B4JVoeWB//9yW+M/8+wgS+sJki2xXlvSLsgyT1JrvYwDuJd7U5e
 ahxVOGmRGS85t7JdQfJR0iCQ6BVVHd3Flxr6OAc/kYyyNesZdf5C0R5jjswABqc4fJJr
 WpnpTmIdX1glziLDJ4Jilb4nXbbonq8LLb9VpCWfIix+xdlmK9fQkx47ivVriyysyT9d
 RC7xQPN/NbEdlC7/+pDF0vPN/utGJCOC27L9jqGjhxnwR6zlWh5yj22XpwsfiKjMt8L2
 cO0VIAACXLrM9KavUVYeW/KazVTxEsosdKFEu146+1aXNwdCjeAde7ZOwn9A4WUsFcqb
 mMfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW3O5GcholPyHeIMYDu+Ha8evedQvQrGsHlHu382NEmBU4EHG7LLY2MzVteg3Ab8l0go8X2/euWetr@nongnu.org
X-Gm-Message-State: AOJu0YxEKE80M4xvFo6bNDsp4hsKayXBoBQx0D+fZioR3kCIhPK/HuGi
 Qn7MwTWyy9FFwjB/xG4x1C/12nD3GZQ212MDvTtyeFe7Lb2OBkPXb6bEuv5ur04DZJk=
X-Gm-Gg: AeBDiettrl6NQ3e7Jmr/cDtD4hCSIqW1BPoW2eTPkwu17ZN/ZKgc/+gbAabCUs4bCX7
 JnbW6oV18qPj4iwKqRAQTsPHyA2jSfUZZTWqeOvDfOtzLr1I8MGsI6Cb+5nQyERf/G+Zx444qGX
 /KjoDjMduKi76+Ek2WbjkC7EWRBBgY9lY0mRBqOfAhsJZaYb8ooejUFbwVw2+K+eYzOLLp1BLHx
 bAXxOPIglz2hmu9eTiIwNARHo9JcyZ08PejHzHY89VYm9JWxYpBfP1SoIwZxFHxY/T6eyEmenGn
 ZBmTARF7/hS3SUgS0vNiRQiO+O9L5QCJ/drGKTIRuHwkhXPDQ4+DnAuWoI9IEH9JK0NGilpQMMX
 ZivGAy/1QTl7ZSrkmH64ntNCfeXYdQ8ZOe6IBZ8ufFd1E57KmkFk7qYa3Ffkgu75+ZHF7tqYEe7
 94Hnmo9e8vq4sQ3BHQjkdHEIdzfHgPDs7yZEHAvIArXX7u93ssWFWYPf7SkLA1Cg7saws=
X-Received: by 2002:a17:903:32cd:b0:2ae:c816:ec5d with SMTP id
 d9443c01a7336-2b2818bc0e4mr68972505ad.32.1775345982251; 
 Sat, 04 Apr 2026 16:39:42 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472cdfesm97140715ad.14.2026.04.04.16.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 16:39:41 -0700 (PDT)
Message-ID: <3230449a-1c07-4e20-80d0-8a4e92fc0439@linaro.org>
Date: Sun, 5 Apr 2026 09:39:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/13] linux-user: add MTE_STORE_ONLY to prctl
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
 <20260309-feat-mte4-v4-4-daaf0375620d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260309-feat-mte4-v4-4-daaf0375620d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/10/26 08:59, Gabriel Brookman wrote:
> Linux-user processes can now control whether MTE_STORE_ONLY is enabled
> using the prctl syscall.
> 
> Signed-off-by: Gabriel Brookman<brookmangabriel@gmail.com>
> ---
>   linux-user/aarch64/mte_user_helper.c | 11 ++++++++++-
>   linux-user/aarch64/mte_user_helper.h | 14 +++++++++-----
>   linux-user/aarch64/target_prctl.h    |  6 +++++-
>   target/arm/gdbstub64.c               |  2 +-
>   tests/tcg/aarch64/mte.h              |  3 +++
>   5 files changed, 28 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


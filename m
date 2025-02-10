Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A5FC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZV9-00089d-8M; Mon, 10 Feb 2025 14:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZUR-0007rG-Cj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:30:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZUP-0000B0-Q7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:30:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so76902745ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739215840; x=1739820640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=duAHkguV6wi1ycgPR0bZ1Nz6/mIXIFXVmQK1UYCJa2M=;
 b=BLYuzhAWDZHi/zportxOFROKIgfUbymA79ADYaJ99ovO/SFzv28hj3DVTMOOCJB9tT
 5vWoC9PwOhtiB8noETagDd+atUG7o1K0PxsZAfmiTtRHsJe4dJ+l0yHBYaF5VGGRAEaf
 njWkfwnIQRmZglKoYd4tkApzXbORuF07wKKVezWEbbaFoUHjjsaUf1aGDGUVWz6ndy/d
 la15bmZYdL7XcbzQ3BFvA3ltVi1us1vh7bt2ZWJOaeMsfZxB2J5ykW2StnmyY2ldktBz
 PDBF3YIg2ARrbeR0/SpT5+UdhCdGJxCRksL2tdUKK/okrGSQo8KqI3Myo3Id7poiAqDt
 PJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739215840; x=1739820640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duAHkguV6wi1ycgPR0bZ1Nz6/mIXIFXVmQK1UYCJa2M=;
 b=UBPKOgOV9gfqjbyUxttg1RZJz9LflgB53CE4Vu+a1ESDmFRXiBQV7VvRNxaUH9KD/p
 yE4lZ/AiyXeN86R8RGhyVbNCTfGtLOn1JHQ1PgfTFm4UUi280VuEh4CcoLU7es5y48r5
 MM7kvFccDwGsfd4C9hP3u1QbggiEO3a2YBR01O5NGwL8aSa7RvtSux6Bx5afTW4TTH7t
 3mUtIsRwUkVEZnerIxLAeUb0kfygQ7jQVOJMA1fJApxyP6PbS57coCAcRfKVwIW7ti2C
 L5hQPe8LNeeYwFQWwgOX7tG+2U2+33nuPIwNnEhaFWiDbL3W98ZYn8/Ch+g/l1/nExgP
 Q1dQ==
X-Gm-Message-State: AOJu0YxcYC+Jx2HLvOrus7fJIWMA5/EWZ5BdaEGfBXCj6jG1oynn/Bsb
 9F5C3SfM8atrQkM0AZkeQPVhU3rF2os+i5kYxUEMKuBAyH/HNDRPHuVjY3Jmank2IAeAP+arPZR
 H
X-Gm-Gg: ASbGncvKCAaXc6kEyIXK/ig7TymFtSENpE8rJO80P0MUYLHgkEoFhPRGIDarlUv5z6c
 q8MPv/e4qbE4nYRkwi2xE3m2N7PLc94D220KgjntSZ+GOt87O4eO6VA/uyfrVYDWr33w76a47Tm
 WOKv8f+R8ahdCcJyT3i9KKaPFunAWuV/8PPJ++AUESGLaxFCempMUtqQAy7mlv/6d/zaQ7gpGe3
 8Uyp4rkkYoMo1IMSexSkwwjRfCPN3ueExoOQNuFUxflJfhRNnLJVq+yEVVN1CN4F5ts09R30rsS
 8msMR2pA/mPQlN6kdDJiKEJfGiYWlw/gy5NDSAyMLcWnygV3LFe+qFo=
X-Google-Smtp-Source: AGHT+IECKRU74U0jECiotYpv/WZMXiuh2Kn82nWeWf57q5KDMSCbOOoP1mXyfpODyRO5Rz0vRQVjSg==
X-Received: by 2002:a17:902:f687:b0:21f:4479:a34d with SMTP id
 d9443c01a7336-21f4e6bf3f3mr233827965ad.12.1739215840277; 
 Mon, 10 Feb 2025 11:30:40 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm6890279a91.44.2025.02.10.11.30.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:30:39 -0800 (PST)
Message-ID: <e7f5c8ae-e703-45d7-8e83-fe4c3f34a3c1@linaro.org>
Date: Mon, 10 Feb 2025 11:30:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR
 traps
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/30/25 10:23, Peter Maydell wrote:
> On XScale CPUs, there is no EL2 or AArch64, so no syndrome register.
> These traps are just UNDEFs in the traditional AArch32 sense, so
> CP_ACCESS_TRAP_UNCATEGORIZED is more accurate than CP_ACCESS_TRAP.
> This has no visible behavioural change, because the guest doesn't
> have a way to see the syndrome value we generate.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


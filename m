Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034BDE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4kC-0006ii-LJ; Tue, 10 Dec 2024 13:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4kA-0006hg-FK
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:13:58 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4k9-0002m5-55
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:13:58 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb6dc3e850so342312b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854436; x=1734459236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWsog/lsGiL8G4q5MO66poQ6hOfPYcZ/GRZKvTBrd4A=;
 b=Gx8h93A8riD5LH29JZthpepeuGrF89ft0yB1vATzKSd3LYaNwrUXJfqtYz8wbJonPk
 r/KqWKGmbELfrLp3Hvcy6P/5fDcEFXzzYAFPhsTzRT1n1lzIbgpI2GN5jZ6B2EKIHH6c
 0aUNwVSrNdrAljeXVVDDjaubxvlzRRODzfHMvrWZA5sKNjysbZRZlBYpzS1UXf/zdOFU
 eUQf8S/Qz84w6jS8QaLncCoaheNv/+Tc45I5I03yjMjapQyiyhbmHXU/fTtvnu7aXsT7
 agCg/neLUOxdqPFFiG+6JoBBPiZCN1xhs8ePcAqCztpm8lwzYVfGll0SZjJt3vGT3+22
 IGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854436; x=1734459236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWsog/lsGiL8G4q5MO66poQ6hOfPYcZ/GRZKvTBrd4A=;
 b=IEhKrsqThxo5S5cM1cQEJg/GpXldWNRqELOcnTvTGnxUERzFO13yC1ieRCkbiDwH+r
 xRMse8UjQvkdxefVEpdVPxQ0n/7wngAhnPBZG27E8xgMnRsl5s08vvIkTyvbvdkSDs9a
 jhyP+Z+2O1nhXac0lZ7GS+MQvikZu+BzspLL2eb5fJss9YBaM2J9UtbpR4Zu3BtiurES
 +muaEkc+sJdqbgdGQqfXXTMrtQZklVH5br20+JgbF168Iluwz+zUfJdOzp1atKg4SWgq
 TNc8En6B0HOC6DJIl6SnLHQN95NW2ERJq7HdswuAG+jn8JyK5RDD68/EJSu2AH1LhiuB
 tYGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9tPqIN07ZXTL5hUDEajhJicD1r7vs3NEodJClclXoMcwaTsqwv5zwc4+M4sr8G3JcsToBO26fliZQ@nongnu.org
X-Gm-Message-State: AOJu0YwCWsrVPIigak7T4UNgdSATbD5ZCXwU3HsrBR3ujkYLgc/KNXcj
 zpRSxaamqcSVYGNC/ebaU0ZyJCQjyHlPnfykGrzkArj9I4djXnub6vrJ7hrn8/RebOdWVoUCxQJ
 Xnj8E76Iy
X-Gm-Gg: ASbGncvtcbWXu1jwM0rgbtDbnF/1dc6FMRQwWJWSiuXzuYPmGGnsyD1co/Gapa+vogF
 zacRsEcVy4FFyi80BTS+qsNh6wb6oGAYpN/qjAyjBlmhz/fs/KigRpjvBPerMrV8CuTmVl/XWQO
 dv4b2sUDSXjsATPvYdz8/gAE9W2PptiV+PbZpwFJMsXaFiwkltMopcXPmWLbVfAU5ti2BhNPgtc
 AhJ5zErT6U1k0V8juSrNDS6+YyQpBzFkUQG72bxKcemfTMiLibYqHm9JSDhpNll1ZSpkO8=
X-Google-Smtp-Source: AGHT+IF8wut3OBSH/LRi8ctbQHqNk7fuRfiSMm4fLGhJcQB4EGbmFDl9/mi9sSLb8UGicZh6X6Yliw==
X-Received: by 2002:a05:6808:3b4:b0:3eb:7973:111a with SMTP id
 5614622812f47-3eb797311efmr1138083b6e.40.1733854435865; 
 Tue, 10 Dec 2024 10:13:55 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dfaae5a5dsm949491a34.28.2024.12.10.10.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:13:55 -0800 (PST)
Message-ID: <ee1f0cf0-e1c3-4ea2-bbd4-f278532ad2f8@linaro.org>
Date: Tue, 10 Dec 2024 12:13:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/arm: Move AArch64 TLBI insns from
 v8_cp_reginfo[]
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the AArch64 TLBI insns that are declared in v8_cp_reginfo[]
> into tlb-insns.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        |  11 +++
>   target/arm/helper.c        | 182 +++----------------------------------
>   target/arm/tcg/tlb-insns.c | 160 ++++++++++++++++++++++++++++++++
>   3 files changed, 182 insertions(+), 171 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


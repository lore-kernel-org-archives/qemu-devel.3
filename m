Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C62C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE7M-0004tL-Fp; Wed, 30 Jul 2025 17:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE76-00046C-I3
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:13:30 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE73-0007G3-TK
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:13:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-769a9c3bbc4so247978b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910003; x=1754514803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fnlkaUQoOQvmpNqdPCkzfU/xZc6EzZNq1jyooF/PlRc=;
 b=Tz3jr8B6ETbe42PSV0mtTdb8VGsGn6nppRxrWH1aKCzuJi2atWtpce7WJJW31f3qlf
 BtDJ3hOW7fH9wKcsACCzKLIIFES34B1eHslF40lxmTg/Zwi4L5TW/klPXMeqHUUcMfvZ
 AJk/GedwTonhgGbyhfKDCV4YigDofwnkpB9Lm4kV+uUcVVDfGP7gUmDqTonNTkX96wQn
 aBRdCUdMMK3G43MixXrqy7l3v0ztVGTBjzXpD4mZPFFnn0DsrIPYjnOhQSBSFo43XWaM
 tPwrcHKwH/LLxMoDszIj7vG5i/YTZexwx447YQrB0ySlYd510mxaHcgL8AqdW+dxxrH1
 K5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910003; x=1754514803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnlkaUQoOQvmpNqdPCkzfU/xZc6EzZNq1jyooF/PlRc=;
 b=V5fx3f4u/JfDnv+9nGwW2cFijhogmdgwe9pr4Bm/+g6nSQVgpaeuFGO5YcTnyyon19
 RlBgsMeNYPNeVhnIf48y5r5c1MxrpyxhuwWOj62iItSLy2bxXlGerebf4m4OwpOELxIO
 IAjqB/6RtAfNzYGnUtmFEcKpQLCNgrsGpqnAN1xQTl9IYerRY+KwPvX6nJ+cBxYMLl++
 Un+8NNRiaAPPhp1E6afqt5bC3aGNWewYvbHALcFPeFCEH31dQ2eRRdCIsuVgNdLhY+2B
 Yqrti/XQ5oingzdMIh97BnOG3biW+Y6VN0eT+EydH3NikcGLWlGKbH5Nl8KfeOz/wi3/
 vvhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwyVxBuBLAdHeWQPM4ugIlSCaIMOEl6HdhgtL8DEvK/Wm8jVJodVQpCRODMvUF3B83lSyICfVK9rgi@nongnu.org
X-Gm-Message-State: AOJu0YyLEbPd/emCtUn2kQ6JRhDsFJXzRt0CqdHt1tg9pQUgHtds0Cau
 jl+j5xFbWUkhRhGiP/1tnhBCwGrFgvsEmXCnWqkWqgnrfRuGDlCy4t94FEozqojmUoQ=
X-Gm-Gg: ASbGnctnI/BYwZciOMhIK5NAkrbsclFPzebNBJT0uGfj1q274HNsDfUxxqBnf2HOCYB
 mR51elTx7Qbah1Kcgb/y3eVhezrNksaF1f9AFR9w6NWroZSQFG6HvpkudMAIgggvKFDQ3mHXqwt
 +dKxluC4D9mA2Kqck+emjSXaXBA/q6fSSMQjXVF+6sPvXIjATSYPoC53l/eRxQR/jim2IRfmCaV
 +7AP6TCm/VoBOdLPxcvMCHHBPsIDdhkpfVpwgYG9tpmI+EL6BdckQKafMsKfFTWACffxhKAddGr
 IdSUFp7HzDSZsqHOOGiIzd8X8EuewqqAf4f26Br98XJsxUfUM56ZmZ69tndL8nX62fdh3wiiMBI
 PnMX7h1GBOk2RZVfR1aU7yAyj86sHhb+cEto=
X-Google-Smtp-Source: AGHT+IF+CnDMrTR5pDJBfnOY3tiS5AOJbmPuvBf70Ax6k5y4J5s4DX9PCHTkvHKj2jbvqS6jyyucZA==
X-Received: by 2002:a05:6a20:3c8d:b0:232:bdc1:6b94 with SMTP id
 adf61e73a8af0-23dc0ff8fb2mr6087851637.28.1753910003057; 
 Wed, 30 Jul 2025 14:13:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfbf7asm11466634b3a.75.2025.07.30.14.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:13:22 -0700 (PDT)
Message-ID: <c23b4c0c-4488-4735-b784-95b0ed3b52b9@linaro.org>
Date: Wed, 30 Jul 2025 14:13:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/82] target/arm: Remove unused env argument from
 regime_el
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h      |  8 ++++----
>   target/arm/helper.c         |  2 +-
>   target/arm/ptw.c            | 34 +++++++++++++++++-----------------
>   target/arm/tcg/mte_helper.c |  2 +-
>   4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



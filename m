Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D59C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16CA-0008Hy-TO; Sat, 05 Apr 2025 12:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16Bz-0007wM-AG
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16Bu-0005id-TU
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22401f4d35aso32019595ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869777; x=1744474577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEgxRcxkgXjLDvvGUDidBYuv26OXt1EYwuPH3C27/RU=;
 b=TQ36NrHOjCkc/rWNXtjA7zAQKKH4uoItQJ3mXesZNLoBhTfB0fIJG/+PxWyiqtXSt1
 4OF3IohVNnY8zuHj0wKuxvoFoAwAUDHY6hmEs7bWjwsoZ9vDiq3F2MKOdVNy5vRU1pOi
 dv7cnQP3RLI2nCf584szp6YNEzZ2o6wJK2hip/BwjrHdoNu4yTtdsLOb0XTC7B3EOiTe
 TOrltSrJgHt/BolHRSSCWsWCC7nhGPitv7Qf63mH7CElcsSMqszrzIBlOI4zero8gaB5
 IyZ1omheHy0+OLYp9xK3IDdpby8WKwlfrPs/h2TpLBHSQEktGolkkW3oDZtMXgS2+ywu
 vGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869777; x=1744474577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEgxRcxkgXjLDvvGUDidBYuv26OXt1EYwuPH3C27/RU=;
 b=Q3TVRRRuNwmKBzkwzQ5Gf9NmrnJDr0bmLtMW5BGDtzfl654bbMpTveYy5WYreZCLcL
 sx1NvYWVVHy4iV+Bmu1HSysRh4Ff8d95PLtAt4M1tqpQ5uKv855GsdTqextLxhCGK7Dl
 fCSz1njcj1Zu3NKpphV35GzpbCV0vSoGJulZuYRczRGwtRqUs9kECoh1lBpAY6xwNbAs
 ubFFNzBdHWnTrv03dPG4XdtbGH+ePO7z8CSfllvNen0MR1r6xm8n1XUgQrIr2YYmeB8g
 X+DFfcTj/dCHYBTbfcFxArQdv+8V5YKe8pfTQ6uRJnwczaEORLRhuYEzdoFAYUdvZBkT
 0D1Q==
X-Gm-Message-State: AOJu0YzwjlMLeyF6XoLai28mM3rwArVJ09zS9cKZy9FypAtO/ZQcHUOn
 m0yyeeDCYynubLL22qsCEE1I11z+n82ngx0ZsO9vVLiW4mbl4MoSRIXd0Qh+tmq7R7j1E+Zncbe
 H
X-Gm-Gg: ASbGncsSbfuKfJNrvlgs2PwxkkbQz+/H8fOV0GKac4vgAmgl3aaL6QEe6KM+CWkPeBy
 TNcc7vE922Ck17DKUN105JUkrM3Ny3hAud6exwmwhXEkwtb1cG33/hh4LKmcV2SOiUDxYG06ug/
 6q6mbF7P7BCizMBK4aZ1VkSN8T0jp4w/7AYc4yMXZqVunSuO4AHEQcY1r+ZIu/xgwY72xrXXVdU
 sg7HugBiYSgpVgMDMqBKhL1cN6YqDUReVZrt+mTlHA93y9IwhCrC8TbX23LtPl10HHJANVfzDnC
 wwrBw/cwF8CYcPb6sWnZUeHVUogENkW12dzHQ1/RiJjWXsNjF4VaYKgg8rAr1L4L
X-Google-Smtp-Source: AGHT+IGjwgmEHOM22VdmKv/iLXrKibLnhuZYn8/y/naQOwrbsRECqB4AkMeA7cqD4emnlQuObpwIkw==
X-Received: by 2002:a17:903:13d0:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-22a95516598mr51413185ad.11.1743869777117; 
 Sat, 05 Apr 2025 09:16:17 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229787776adsm51715335ad.247.2025.04.05.09.16.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:16:16 -0700 (PDT)
Message-ID: <a36e3fd2-7f93-407a-be2c-5b446b48ef88@linaro.org>
Date: Sat, 5 Apr 2025 09:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 6/9] target/arm/mte: Rename 'mte_helper.h' as
 generic 'mte.h'
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> "tcg/mte_helper.h" header name is a bit misleading, since it
> isn't restricted to TCG helpers. Rename it as "tcg/mte.h"
> which is a bit more generic.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/{mte_helper.h => mte.h} | 0
>   target/arm/gdbstub64.c                 | 2 +-
>   target/arm/tcg/mte_helper.c            | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename target/arm/tcg/{mte_helper.h => mte.h} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BA2C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVVI-0006z2-Fv; Thu, 01 May 2025 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVVC-0006te-9E
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVV9-0000XW-Kl
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:07:05 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso1272687a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112022; x=1746716822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EcM9dPq3o3V6LdIXkIrMSQgYINVmv6Fp7cayUpv4944=;
 b=X8PpWAik9h1jVrETJTm1ipl9q2IWZJhb9zJCAVOrwVjZMr+CrEJgpJas8EPPh5fZif
 BIliig42I2/P5JrmISvPkGCc5h/jPe7g8gvd2mWXW4oJAL4a75N6cuit8aYknN86YYh7
 VLjjPYjKvOXNRToQyxVs07UhtYxRxwMWJ/ujh1LE0xnHjkImt69eMb/6pbWUGeO19JGG
 KCHIFcRtMgUPl7ApLdCiJ6V9/PH6a8yHe5XCzaZHPnbVHd2rMzjJBs7PRCYPlNbF8CVZ
 wIhu1FFCQ6uwF3gnUq/4hlYnHZ4h6H40V+csSPPvJdR3czqLRLCu5Krmjqo/J8S9PiTz
 Q5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112022; x=1746716822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EcM9dPq3o3V6LdIXkIrMSQgYINVmv6Fp7cayUpv4944=;
 b=ptoFLqQQymdTSFOIQIIzuabucB5wlwFnvGkNrai1ULZE8GNeL40bsVy4a+1r2GraDS
 I+gjeZl1sGvv8CHa3m8aN5O64ooAOKxQhTuFGUqA3zQr+wef1EGynvADM1/yuj8xn5pU
 bOs6yLWzX0nrApKc79GBkU9rN9PbA1IWZ21Um7rUB6gorSq0DyaqM4fPme/23OIlv9HD
 wUVAOUYVilDCYX7HEmn/etIfRFl3AgwDaBCl+eq7gHmjezPk2PHSgmn4ariKflpRfdtF
 WficXG0EceUJOCuaqVbGvvCQNNA4biG7z55+sAq06gMWmxtUGWmr4k5VyF73SE9Rn4ll
 XDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwGYBLNiWfS5EYjkNdopucoGNZfxjOn5WmlEivros5Xq6jbgdm2V23yI4Pgq2RxhE8U91o/vA1z9he@nongnu.org
X-Gm-Message-State: AOJu0YzIFD/70HMilWAdzmemv2cVVz9Sk5afGWWXsaaITuRQqgjWoyQl
 tzw/4j1NN0x0zNrOVxsa0UDenq9d/oNBSQHjnxyNOpqGHP2skl35ikpG+vXfi80=
X-Gm-Gg: ASbGnct5w27G9UvYRtcgR+P0g/MJVOWPxyh+friMY6rFW4hCxVAX+swnnVvfcyp/Idm
 SfS/s7HwcepTtoV2DA818d/fELvLV2IYqC7h1UJJWKSHIcJZl9VbF3debhvBEYqUczhA5jafua0
 OVTo/Y3dtKKihFaxqZQR83e82KAGyB3b8HdTDcWofH8bXR+yd1S7FF6FdBYytg7GKg2JjX2WdwE
 S9s2MbAHy2ailnZGSLdCsbD93yFpYxgJGfa4gehnRAe3uNQqWMAUbdGrTl5LZBiW2k3uWE4VKg1
 LzyOWZiNEWqZ0TeaGpbXvcx8rLXDYexTuCwp3BRKR54xieCRfv6Tsuk7hb9aXcXzP/9dm6jUI/0
 3b70MfHE=
X-Google-Smtp-Source: AGHT+IGfItdxKMWWB0HXsdQlHgzmrixhckbDJw1c4W1R8FB34LVv12qDqlJ5sWBZkHPXgPbYrkQiYQ==
X-Received: by 2002:a17:90b:2707:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-30a41e6dcc0mr5736176a91.18.1746112022161; 
 Thu, 01 May 2025 08:07:02 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3480ea0dsm3690678a91.37.2025.05.01.08.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:07:01 -0700 (PDT)
Message-ID: <f631cd09-2b84-4327-8ef4-39aca5c8a599@linaro.org>
Date: Thu, 1 May 2025 08:07:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/33] target/arm/debug_helper: only include common
 helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> Avoid pulling helper.h which contains TARGET_AARCH64.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/debug_helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 473ee2af38e..357bc2141ae 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -12,10 +12,12 @@
>   #include "cpu-features.h"
>   #include "cpregs.h"
>   #include "exec/exec-all.h"
> -#include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
>   #include "system/tcg.h"
>   
> +#define HELPER_H "tcg/helper.h"
> +#include "exec/helper-proto.h.inc"
> +
>   #ifdef CONFIG_TCG
>   /* Return the Exception Level targeted by debug exceptions. */
>   static int arm_debug_target_el(CPUARMState *env)

Oh, I see.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


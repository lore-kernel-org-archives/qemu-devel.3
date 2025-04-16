Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2278EC369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56DK-0002dg-0x; Wed, 16 Apr 2025 13:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56DI-0002cz-3S
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:06:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u56DE-0004gO-0t
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:06:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227c7e57da2so64598245ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744823170; x=1745427970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pm0ody6J58bLDhdIId/qCZ9J43m8pd+bbJSV6OZ7wko=;
 b=it8wCItEjxyFA9Kbij/8Jyy3jVheM2gOgGzxeZt5BBolia6z6zVbzeGKrQ0jEzam+P
 fh2cYyDFLtlGINGrsB4BveJt/C8EasawXhegkrvf93Tv+MiOfe2bQCgwQ4LlwC7j58sc
 pUHZAhNwmy1vy5X8bynagFawTbUaKnZZzqt5rqK/PjZuj475gw5c7oTAAuiQHUyeeOt6
 f2mhgPgGl25YPJLdUaTBCVzJtmT4c4a4ufnSwqeWIEummOzia4Rtqc16b4oimEcxv7/9
 OWXKTOA0qBxrq3/L9gojjwLQyg0QysjtOFicvFdkG6V6z6YVOi3GCrswsv78axoO/D/H
 94yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744823170; x=1745427970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pm0ody6J58bLDhdIId/qCZ9J43m8pd+bbJSV6OZ7wko=;
 b=daL65tnj4+anlYD/c8j///3x26Eqj+P/db5SGNtJh2rIerzshLadHWGGd3SKjg/Vmx
 wdvyYYDm5vzLh9Yf2Fe2fA/hYNhyMxdj/k91p2Rm11BS3xXwfJGsLIdT9kUkwu1Itzla
 WhCh0wF92TaITorbEruQbAJAq4czPQLSrJfSruYwPy2UP5cW5Qy1L0KXHyPgJ6Y0GoD2
 +1ZL57fLU/jIRwgPEKO7BirWPU6JVTj0atL5PNxqabAEb6WSFLNK6ifQehcJ60f+PRjV
 Xk/MIf0NLW7OZSP1gr78hT3DLGYpktkYLgQ7knHA1H2hsMYjWUHT1GU+1CLqHATQKu8e
 Lx0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDCVXX7sWoNdU6gaJ/6ILFPWIJX0ztSdFbcsmRSiiAXMy+WQVWG5xKGPYXxQl9NjYX5436s+k9YlYN@nongnu.org
X-Gm-Message-State: AOJu0YyHtv825KloeIWYrKbJMa8mHQaSLKcoszKISBsSWw+6TXf6T05w
 fdBSztqnNRuVN/zC42kjGpWx/dt/kby2NCtYQTdCRvbeIF40XFmT2EYsQtvhtH3+sHqrAOgJlqL
 r
X-Gm-Gg: ASbGncsB1b4LoZv40NFuE/oxSeLgHQy1ZX2k788XNx6wQfO6cH/QyVMg4nqLx6EDdlF
 kiO0VqdSQvwnQLeYhNVmi1IGlsgrtQnWAiSZr9bVmEl5Vnot+I1p6wPurHHCNAnXcsoszxHGXto
 zuIPZ3wjjdAvmPVr1bRBa1+pa2o/kEBqr90ofwVgXQ6QCPQEZ1/AhuXHzugi4VSdzPJrio+IXx8
 U8XEZoRe7afXZC8bvjBb/Saenr7nsrL0Aopv8/MkeGo44KNACl14/gLFpGe3+sD96wAgZxGfXhb
 1zkJotDN93GZLh4rDHiPjGe+RDSjcKxiyHiyy8m1MCDy8djRhZYiBPbgSSEYFGObnUdYukwVAY4
 NRhqc+c8=
X-Google-Smtp-Source: AGHT+IG11/ua202mB2nX4PYlZHmiQ4/BFY+hKN9KbKGOPr1cuRscqHxX5Ih2kQVW/skvecUomGsP+g==
X-Received: by 2002:a17:903:2391:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22c358ddc27mr47902835ad.15.1744823170388; 
 Wed, 16 Apr 2025 10:06:10 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198a68sm10720483b3a.1.2025.04.16.10.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:06:09 -0700 (PDT)
Message-ID: <a5da81be-5ad3-4435-b783-385c498f3e56@linaro.org>
Date: Wed, 16 Apr 2025 10:06:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] target/arm: Replace target_ulong -> hwaddr in
 ARMMMUFaultInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
 <20250415172246.79470-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250415172246.79470-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/15/25 10:22, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 28585c07555..175fb792375 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -25,6 +25,7 @@
>   #ifndef TARGET_ARM_INTERNALS_H
>   #define TARGET_ARM_INTERNALS_H
>   
> +#include "exec/hwaddr.h"
>   #include "exec/breakpoint.h"
>   #include "hw/registerfields.h"
>   #include "tcg/tcg-gvec-desc.h"
> @@ -724,8 +725,8 @@ typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
>   struct ARMMMUFaultInfo {
>       ARMFaultType type;
>       ARMGPCF gpcf;
> -    target_ulong s2addr;
> -    target_ulong paddr;
> +    hwaddr s2addr;
> +    hwaddr paddr;
>       ARMSecuritySpace paddr_space;
>       int level;
>       int domain;



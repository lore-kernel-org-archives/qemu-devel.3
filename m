Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB9F8DFCB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUOq-0005V0-Fs; Thu, 16 Apr 2026 17:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUOo-0005Uj-L7
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:37:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDUOn-0001q8-7A
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:37:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso70885e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776375438; x=1776980238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eK1uuOg3zE6b5HYZ4Scrak5zX4QkXhqcS38nPiKEfO4=;
 b=IFvnksi15uupYPztiAq9qDemMar/rBI3IAbwjrX+IMjTfb21e1MPisfZFC5bs1JGPz
 M9OHVZOzBjEZz4QeQlSzHjAXBhs8GXbq3zoWo5wTuPklaStUwUUD832RFR8kDqBZNnyp
 WgbPiiKKL9x8KOJw3d/c1BiWv+oXTd5ZKYt5ge5W6b3jQQAUGYSZIK8gNSlruOwy69UC
 7ybM3r4T8SuKuGU7R8w6EvVT0aZml8j+QlRDCz7K8h/WmjNQeKSAoErEPR4304YHkgV0
 iaEBctSbbchz8DnCB/DlsTpDI8CgL1bZRooAUNtsiqgF7C1cEZaVG8W5uOn2VE7+0i+K
 u+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375438; x=1776980238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eK1uuOg3zE6b5HYZ4Scrak5zX4QkXhqcS38nPiKEfO4=;
 b=phKRfcWBB0rENta0xfDzXgRZXPjA905R538kCkeVzta4F6JvRg3ARSC5LiomkNJWNB
 wvRy56veTTFBHNa0PCdUJhX0mx7azlJoLvdZj35KlhMMlJJmAgbGy7khqQ7uUb1Yf29L
 1ffMfqZ2IbmugBufIvympyD/dLHc6cdpO+Zkm5D20ScOUdc7dVyziOeeebMHAzuyeUo/
 mLZ1fzckAPhR13rdYbP58ZsEZzbUVoyoLJxT3dKuZznCb7alN3rYHg3/eZ9P7dd+CGj4
 JPAYC2mMmUmXBUQGnGi1ZcOS8GJMKhKC04P81go9PMSSIp8I+dc+oG5MsAaXfpf0pkCC
 QAFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mMsQyAhaYAG4NTV2j6OjJ2P9e4WOD32v82FyxOmmrhhWGmxAwvKGQSNacIuDHGDDZ0fTjj3eeFe8U@nongnu.org
X-Gm-Message-State: AOJu0YxAoJjH/GddYKN6TN87yb5lqzVloeiZoRJtIui97MI5JPlvT3Te
 /4jy0azk9dBDbQzS4iJwQ7fV1n5Ta4qtZefkq06WE9gxsLe+IwW6lwA0T066truZrVw=
X-Gm-Gg: AeBDievKxsyD66xVHPEvWF6WX2QerlUFhAzFwoFhmCmCELEEm1n18eFmhtpIJ2E4Bi3
 nC6vxmMXrCm0n6Jv+PRul5NhqV7gKkwwvjhTHw1hpFexZ+ygcHs2ojRTaGbPH59DkTQwrmNiXdI
 NpNwxuDHjAQZOcO2loxSEzhON7l9o3cM8tS1k4Wv+r1DemmDCvThW8Iim8x5UeQigHaXgTbRP5Y
 VANiz9P+Kr7Xognhh4cnnDQKzfokRmFNr7e0jTiygVE1uyeS+HDIb/E+8DXV1yRkIrf6iaJjjF1
 CMgV3zlQl5ZOLt0d9KDjUD/MGN08pxHJUIM4b0xveFWfK/cK4Ef0Cruq86vZGe/UFXpkDvxYtvj
 E+Rub/sIolgeQX2cNCxgrBM/A6oPAwpe4G1LRXu34bxyEwyqJU/S5MjmGXsHn9+yh7+BjXnVo8k
 ijTVRKOclBLDMW8RnVIK24dG7uBlpzJmu/VFzrbsaqJBFR+GNvaIDSfa2f/P4+XNjV9BqLrw8us
 X9GCCbjcU4il20=
X-Received: by 2002:a05:600c:4515:b0:488:c282:e77e with SMTP id
 5b1f17b1804b1-488fb7879b0mr3383565e9.28.1776375438289; 
 Thu, 16 Apr 2026 14:37:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm80913295e9.5.2026.04.16.14.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:37:17 -0700 (PDT)
Message-ID: <a02e2440-6f88-4554-b7ae-f9989a7800aa@linaro.org>
Date: Thu, 16 Apr 2026 23:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/16] hexagon: group cpu configurations in their own
 struct
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
 <8f9a2e2ccfd2eeda73a63d1a6abbfd6e5458b44c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f9a2e2ccfd2eeda73a63d1a6abbfd6e5458b44c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 16/4/26 13:38, Matheus Tavares Bernardino wrote:
> This will be used in a follow up commit.
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h       | 10 +++-------
>   target/hexagon/cpu_bits.h  |  7 +++++++
>   target/hexagon/cpu.c       | 14 +++++++-------
>   target/hexagon/translate.c |  6 +++---
>   4 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 77822a48b6..d28beaa92f 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -119,19 +119,15 @@ typedef struct HexagonCPUClass {
>       ResettablePhases parent_phases;
>   } HexagonCPUClass;
>   
> +#include "cpu_bits.h"

Pre-existing but preferably "target/hexagon/cpu_bits.h".

>   struct ArchCPU {
>       CPUState parent_obj;
>   
>       CPUHexagonState env;
> -
> -    bool lldb_compat;
> -    target_ulong lldb_stack_adjust;
> -    bool short_circuit;
> -    bool ieee_fp_extension;
> +    HexagonCPUConfig cfg;
>   };
>   
> -#include "cpu_bits.h"
> -
>   FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>   
>   G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 19beca81c0..83d13de569 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -20,6 +20,13 @@
>   
>   #include "qemu/bitops.h"
>   
> +typedef struct HexagonCPUConfig {
> +    bool lldb_compat;
> +    uint32_t lldb_stack_adjust;
> +    bool short_circuit;
> +    bool ieee_fp_extension;

Maybe group boolean together?

> +} HexagonCPUConfig;

Minor nitpicking comments, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



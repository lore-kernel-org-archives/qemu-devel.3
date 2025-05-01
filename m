Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E64C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVdO-0004PK-Pq; Thu, 01 May 2025 11:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVdN-0004M9-R9
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:15:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVdL-0001vS-4D
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:15:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224019ad9edso16533755ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112529; x=1746717329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FF3pddHEwUgaH/9RTqdn87i5S0KIL/aYEK/4foUzVjo=;
 b=qsBjh34pV1FyyRxtKjqUTQ8t8RJrlKOqzIMDiUIStDe7/c3/2Swhn4hv8wjKwXb9RY
 +XHNkmozi3QztusMWyXqCa8ZfrSBRDWB60NhT6uGALb+qDIhH9f52j1tmQyuvb84+ild
 y4IuV9k+aX/Gl+H3yp9OkTnLWDbxCsblaZIYGdcjLnrr6cWBRaqLDTF2rQmVobYzZtfX
 0MOOk24/EjiAeXU8gW21jVGA7xugelcWz86gC1bPtQmC1Nn3FKUAk/C2XacpEdjEfXcm
 RbBHffFcDe7ruTXhyXRSZuq8wX4OODUM/SDFAhtd+NtFZra3ZmGamQHz7Iul3jfjpPch
 d97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112529; x=1746717329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FF3pddHEwUgaH/9RTqdn87i5S0KIL/aYEK/4foUzVjo=;
 b=mBsECGmpAY+YBmt3294uPbU5x4hNxjOrYMLIeJZTzNQuB6yczp8MlL3g8hBf7f/hzF
 /IXEeQYWhVZhd7ObR1FnDVqFDm6AQUoV4N1ixmf3FJJjgPHSpF8kdmGhcHG/QatAx8cM
 yMLfqP2Ok1B4ctSsltm+K4R+5uxDKNWW+Hl7jBTjPK/u6sFABaZWrFRl1ftzRWfatABj
 fGWBALSPjjizRp4+wbpZ9q3//O7dPzszoo47ODO4BMiRVK+LvOgkkJHIuVUtTOxNmWsd
 hqu5ntRiaGNaq7CG10E/3DveUQiGhqfFOLdzFIwJqrpulY7qKTpRITEBoyhIL9yBEtqL
 HQOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW15XvM0s0gDjvxtvCZ2J2gRLHTYMLTkvREKsEmZgK7DWWb1RXt7Gn2LjK7ZBSQ8Zthu4kax4FMmgID@nongnu.org
X-Gm-Message-State: AOJu0Yy20Y4aCiux8gXDps5UVLzVc2tUvuaEgQkzY9lzN98z3JWEQDfr
 Nlwh1CR8N9mf3HZvnuKqULkxIC6H/Sr357n1bUfCUumBigJzmRtJsvbKFqKHo+M=
X-Gm-Gg: ASbGncvWiApqwDCshSNpdKXKUrOaJkiA2wkFP0QEUNCQW7ZTNuuYpEf4oiqpsHpxTe3
 iHeXRO9974ofKtZ1CT+tXBRpyr0sm36nbusGSRgEvWziV1EaCapYG7uECAWlxt/U9kux57l1nFn
 KfVqPBdDOUAvc+OTYbt4CijsvYpub1Qm0U79NgZUvU+DH74ktXzoH+IekT5Y9O9hFbJwvXzfabt
 NHlnCc7WgkUAms1YF1YTwyJ87Hsf9Ctjw8EOCXcuJU/iQskqvglSvBbHe6Reh59IuvqkAtNTQlc
 4bn0AKyqRQ5KH3M8XoUPpUUIfKQkNUbCFHjXVlUO7ChaaIS8rcLaqovrHpaJsX3wyB/IYKh2Ug1
 R4rZYsJk=
X-Google-Smtp-Source: AGHT+IHmyRr7z6sPij1th8t08gn508e/IEYOVboajUzflb5IvUbXe1xABl2MLT26AzlI/t3uR/F3TA==
X-Received: by 2002:a17:903:4407:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-22e04127919mr60789965ad.46.1746112529060; 
 Thu, 01 May 2025 08:15:29 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1f9d4edc4esm731664a12.39.2025.05.01.08.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:15:28 -0700 (PDT)
Message-ID: <0762481e-878d-46dd-9964-666c115ca692@linaro.org>
Date: Thu, 1 May 2025 08:15:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/33] target/arm/helper: restrict include to common
 helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-20-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 257b1ba5270..085c1656027 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -12,7 +12,6 @@
>   #include "cpu.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "exec/helper-proto.h"
>   #include "exec/page-protection.h"
>   #include "exec/mmap-lock.h"
>   #include "qemu/main-loop.h"
> @@ -36,6 +35,9 @@
>   #include "target/arm/gtimer.h"
>   #include "qemu/plugin.h"
>   
> +#define HELPER_H "tcg/helper.h"
> +#include "exec/helper-proto.h.inc"
> +
>   #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
>   
>   static void switch_mode(CPUARMState *env, int mode);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


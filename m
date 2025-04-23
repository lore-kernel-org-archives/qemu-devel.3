Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0754FC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XKe-0004oi-9W; Wed, 23 Apr 2025 06:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XKV-0004mZ-MM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:27:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XKT-0004zA-S9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:27:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so45514095e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404064; x=1746008864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgAt+cSAYch6ElQ1CZ8H9YoheeGU03w95Z6dzIQD20M=;
 b=pmdfevh1+iOpgZkMFCVn0BGhAGVZpQlvHoWEW9VH9QNu79RLqAAdevkR6HI0k1S7i2
 7hTtf9nDZP1b7WSRVy97cjiDeae/5rrelhKKAH/dAX2c1+7UzPn3SZW7Sp1i9OcuG5UK
 sitKKOYz5Uvz2q9JX7RemaOzy/h6f1r7AezJbcupvFK+ke9XACJoPohOZf1aTzW6/0kO
 33UdACr2iCvULim6o70svKrvNMmuW74S+sFJA68XupsYvlAlJVYmLqVI5/TasVpdIHZ6
 2xYkJRJRlNEtuFZD2/aXFK9EGDEYllp6EWj/memaJkx0ysundG39VlUEMmKSXG2jIyZb
 ADUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404064; x=1746008864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgAt+cSAYch6ElQ1CZ8H9YoheeGU03w95Z6dzIQD20M=;
 b=sRZYsmEN8RU3TLYAFedd0NZxEBqOak37Y6HssrSD4HSI4sjfl91VJ3Pt9IMxAXRVbo
 n9kFrG6TgXxCAo08WjL9M8XHqXrUrkP5j9W8h26R2Kuo+A2DxhEBc66hWklXkuWLpNma
 +UhVIHs0Itx47CCCL+3HshVy0NFy+TlR8VXr03hlGzvzr1wfsYuof7aBS8Wbm0bk+DNi
 msbNBYDW0fiqSgXr3ugXAI9Cy0oSH61a1I+ewcX49vNIMqmQ0RDfh1rrRMhUheC5X1Qh
 GPT2vw8YvcEp80E4GQyYsKIQ6mmRTpTJE6ZhVh8tWtf94ZTZqumkWDQrHmTlQp11tuMY
 AG/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt18vTTRNU+z4op7lhbMfsmRHbdOImuTpBxb87cmHmLAIk40ap63zgV6S1ie8HIqd5bNw0eOjycqIo@nongnu.org
X-Gm-Message-State: AOJu0Yw6ZcnGPsWzRaw6kCjl+zxWSTCKgZpC774agNIQdri7iQZLQhFq
 bBADPDgdL1Lyscx9/nBuSf6ykwvwJxrgUChCpQKxFiR84QbjIjeW0e1yix34OV8=
X-Gm-Gg: ASbGncsuyQ6neWhJEq3pYMYOyC03dH9ClPPONnATx7hhGyBuL/kqb5Wlea/kQj8kisB
 xO/Hsev/D0JyV7nYewgFg6Pxt0Ldq3DBbL41VlBQMwXivtgpu4N9vVcWnbYTePeiXvlGZMPgDki
 Q0dEIPko4ChwgZrmqnPOpDOiMook+F2OXMgS99nWUsQpmQajvIK8qUWIGjUpV9kq0oURxTFVPli
 xHFFFRCEb7TEt7lU8llyssgypGxnzV5H2IIgrFt2ikdJdDCPtzvtRvIBHrWiy7uGWIvzEvY07gs
 Xq5aLG2USnMUTR8twOaB/+wLRI/YZxNGBwZ4zDP/rwvwjDlsudjgEU60QrXT3tO8tMvDsiPtEh8
 OuMSxe9bR
X-Google-Smtp-Source: AGHT+IG99NKR2wXFj/kXhUBKhh45J03IyVqyjegkIfUqi+44MHYwk8jKNrOGuwMRvCXOjoKqI5TZpw==
X-Received: by 2002:a05:600c:3d19:b0:440:68db:a045 with SMTP id
 5b1f17b1804b1-4406abff89emr154615165e9.26.1745404063907; 
 Wed, 23 Apr 2025 03:27:43 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d4158esm20487665e9.38.2025.04.23.03.27.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:27:43 -0700 (PDT)
Message-ID: <86ba7919-db11-45cd-8bdd-ede8f25f92d2@linaro.org>
Date: Wed, 23 Apr 2025 12:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 105/147] exec/cpu-all: remove tswap include
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-106-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-106-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h               | 1 -
>   target/ppc/mmu-hash64.h              | 2 ++
>   target/i386/tcg/system/excp_helper.c | 1 +
>   target/i386/xsave_helper.c           | 1 +
>   target/riscv/vector_helper.c         | 1 +
>   5 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 957c86886e..bfa039ab76 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -21,7 +21,6 @@
>   
>   #include "exec/cpu-common.h"
>   #include "exec/cpu-interrupt.h"
> -#include "exec/tswap.h"
>   #include "hw/core/cpu.h"
>   #include "exec/cpu-defs.h"
>   #include "exec/target_page.h"
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index ae8d4b37ae..b8fb12a970 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -1,6 +1,8 @@
>   #ifndef MMU_HASH64_H
>   #define MMU_HASH64_H
>   
> +#include "exec/tswap.h"

This header doesn't use "exec/tswap.h". Maybe you want this
reviewed patch instead:

https://lore.kernel.org/qemu-devel/20241211230357.97036-6-philmd@linaro.org/

> +
>   #ifndef CONFIG_USER_ONLY
>   
>   #ifdef TARGET_PPC64



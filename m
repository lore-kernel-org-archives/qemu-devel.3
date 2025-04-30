Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9CCC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACQU-0000lI-Q7; Wed, 30 Apr 2025 14:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACQS-0000gr-Jk
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:44:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACQQ-0007sp-Qb
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:44:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224171d6826so2639375ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038693; x=1746643493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdWqsLDjnrtyzwFMcIoY/AoiwcaSRG/i7b+cFDcrK9c=;
 b=nCIRq5KuGzUUej78SDkr57elVHknxFBNp+4tq5dewVRT68VEbDN6WRpmC4O0M3lhT6
 xDsKDsrjGuYkLdsSrJ6UzX71SQDZhreVsT87wnshFN9cKtTPkWIcBKBym4/jbVIbBGkv
 l842HKw0gWkbRU+K9rQkADOkSNHzrb8r90jIve++PFazzt6bvFZtyChIL+FmpjUjpemL
 XBDkKiCyMa2xbEFPCwOOyKHuPrlW8EJBJnxee+AJJe1yqgwJcN3JsBsUgQYNhE0MvS+M
 S2kO6SbXFMXXYKImCj7srrF8SlnuknELGUCsqieL1yQJtUcFY9wlRtJ9X4pFCaA0n0D1
 6KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038693; x=1746643493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JdWqsLDjnrtyzwFMcIoY/AoiwcaSRG/i7b+cFDcrK9c=;
 b=ljiuV+w2wkB6Dijjwk8plh2MYIhz0H3MEZPNodm3NG36cqTBRtvc1KPCyrGwJjmPSg
 Rbhe1XGzRuWsxsFwokPO7KkH+iK5j8DZzTkubQjyhE5Ulbn6Ge17fdnuNvmuEuQ3h3vJ
 3kcNPuoaEZyEJAgT5J9IPL1pgxQh3mLR625KMse9Uq1lLCeJU9l9s28zJQkCf1NK1jKi
 7a2FafJiufKjYzeD1P7B/K5qw2coOrq4F2fu3UNFK2FNUQ/16MzVs0IUakrKiwiY76R2
 +XwjQkm0LTaOzTUDbT9W4t3FBvB0oefDQpWZCww5I+QVWook7FZr15flC9EheqHUtBF9
 BgKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOw2K37Io4grOOJqIc1aD5Zye1A82wDQJ92NL1bYEQu7SHeX8u9CUn83+G9kx2ROOTvYUpW5otRQsN@nongnu.org
X-Gm-Message-State: AOJu0Yw7GXowlswQoUFV6l6vBeX0a8mbV7ir7rriVow89ePFGhQOZEJT
 XxK51TXTlZoyV9nHWeeWeNhlAG/7EdytKyCD4liyQLLZ3RWi7xdrF06MNmoshSw=
X-Gm-Gg: ASbGncsN07Df14+rXCJS2JM6xGS1S+R2QRazWCFl2nZ3v4EpXk0rGT5Agqv6XvUZG3r
 Bv426bFniUTA4NcarSvT/+k+KpZHU302lHh4ZvngUXST0oFGTekA58xJdi+b2s7VHT+LF+kvz4p
 YGGZVUnoaVW87g2iwIPTVOBouvX32V8qN03+Sb9ilZwx1an+lI5kSf7QLuj+ANvvWsyBZt0aEDw
 Bh22fWkqIc9Ch1FCG92nh6F9GM16qS1c/O0NhGbvoF9l4lTcTOiymUN0rxhxbDsFTl7qXpuFKnj
 eoFzXrq/s6Z9o7Gb+Oyg4Qh+Zq9Hk4mIav4yftMUe8NIBYd+Pb7ymbD5ulzHQMUKh2NcQIcP4vk
 8meGJybo=
X-Google-Smtp-Source: AGHT+IHxn1Zv7Hu1E+clIILqP1pD7IlfPAs6LU2N+d0EY9D8VKYrJPa4AMt91rvWNqyMk4G4YZ47MA==
X-Received: by 2002:a17:903:17cb:b0:224:191d:8a79 with SMTP id
 d9443c01a7336-22df57ab489mr60984125ad.27.1746038693185; 
 Wed, 30 Apr 2025 11:44:53 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7cb2sm126245815ad.112.2025.04.30.11.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:44:52 -0700 (PDT)
Message-ID: <639c510f-4843-4c08-9952-83f9e781d679@linaro.org>
Date: Wed, 30 Apr 2025 11:44:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] target/arm/cpu: remove TARGET_BIG_ENDIAN
 dependency
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-9-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 07f279fec8c..37b11e8866f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -23,6 +23,7 @@
>   #include "qemu/timer.h"
>   #include "qemu/log.h"
>   #include "exec/page-vary.h"
> +#include "exec/tswap.h"
>   #include "target/arm/idau.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> @@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   
>       info->endian = BFD_ENDIAN_LITTLE;
>       if (bswap_code(sctlr_b)) {
> -        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
> +        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>       }
>       info->flags &= ~INSN_ARM_BE32;
>   #ifndef CONFIG_USER_ONLY



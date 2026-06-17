Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AEECD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtgD-0005Z0-SL; Wed, 17 Jun 2026 13:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtgB-0005YK-L2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZtgA-0003QH-6i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:03:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so2903800b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781715833; x=1782320633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WcmPEXKq1bpIbkmeYDKzLPw+LFBUZI4XfaYUi8jS7vk=;
 b=PmcIaOe3cqJMZhS+IHWwGYLWDh3r6ZPUNooLnRwMRZhA7vGVQst/UfuDw2OY+Aox4c
 XcUmm2++ipozlb2acCoGx72sCicQVWHI3qwz8jKLLRKJCeNiE+uZ82RxVhMu0iyIGFW5
 zwZp/7VRFfyyowCWmfKtlnmdQ8vd9O8xkmU3PK+pd/qWHpAWFnOCjcq2l2V1WwD7dvfs
 o5AJ4zYLceWqzMqYsPgk2IVFMb0+ylwhEFP5iFV3EMeP7taUTwAv6uqORKMr0mNOUErh
 Eli999lrvbP+pckn0KBNOr+yMNdZs6bsjCuaDZ9BbGlolr1I3OYMmmT4Amq4HMciRRgy
 r2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781715833; x=1782320633;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcmPEXKq1bpIbkmeYDKzLPw+LFBUZI4XfaYUi8jS7vk=;
 b=E9uPpJrPDRUwgueSHqSoM9PW0l5vKIfe6dCpzp5zdl4z2dIWRsNbnisBulQZ7FXkJx
 v1erUZzagzFH50N6LDKYdqsa3JssBBS3py51azs1KLNUrOH2tCJkHoBPVcV/4Z3EBAKc
 kmnqzZ2WAeRivasYEUW1rVC8LHH14LOsZfo1JbeYCMQFtc+7FchZlj17sDZvUBZzVdoV
 EMJYQpeF6XpKG54YWYTPOFaGnGg0JMVYDye4/qFV1WX4SsnSwTjHt/bLMHd2RWckBcTL
 EFnr1lTsbkw1NHdZMrgFluD+o0BJB0Lb5UQbWQBJk4QlDebJoavUHYl/lPJNDeg9TnTW
 4SAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ErzES4yKhyG/7CNPXBen44wfOTgTGmUehnjHLRJQDCwTvBvDqsfDZsbHbxhTyO7gaqF9g0hor45bU@nongnu.org
X-Gm-Message-State: AOJu0Yz1MfdJxYqt451pe/u6x1+bFUFucufj9HC/jjCUdyNyP2ZWHBzR
 QLOvP/9tBrFAQnyJ5fmEVujGUlys1uMjN88ojv1k1qyw2OzFNfmgaufgf4HaiGqjLzzoc1uHDRH
 BNCWv
X-Gm-Gg: AfdE7cnpCTCTTWUZWB1LVdKF9QELPKNiSfc0+CWjIDqZLzRglrsZcqUQFiDvuM4RPke
 HsHNHXhyVRb3wvYXJMnqN5V//w4zx4zQS4GHHB+N6Scs/dKLN8Bx3uKmrOoQDnCXQLe9CBR3b4X
 H63uNKX7oE/zc/Yf07S1WkQDq8fXO1hF7etvAQK+xIQnVNH0THI+EyPa2yGothb8Ye4J5k+juyh
 /naiEIvNqaGdFTNVmb+fKJ1GCE3WuXXd6dh0CdGilpEyQUGtlqaukqd7Z8lr7U4BEvHC3Br3nxh
 os0hsb5QAahd8HmIEPAiYMrYnLBCJX1fdBu2hTGIi1OPYwW5wQ3yWM+wX3jqiqsvCD5ApwYqciq
 y1hU+ewHS1KwWD6XeLpl0hg6V0fiqBEsElkhZbBsCoAVIjU6NFBL1Lyks0pbFqXNrXoaYWYcySs
 bUgMfe2Evw7udYgrFeyjQGWZYo+DnHP7dzZl096wFSbCCKL0Gx54Zewy8Kbw==
X-Received: by 2002:a05:6a00:1706:b0:843:4726:e3df with SMTP id
 d2e1a72fcca58-8452459a7efmr5062056b3a.35.1781715832754; 
 Wed, 17 Jun 2026 10:03:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf2ac9sm16687476b3a.21.2026.06.17.10.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:03:50 -0700 (PDT)
Message-ID: <8c454161-9198-46f9-b03c-2cc3a1094678@linaro.org>
Date: Wed, 17 Jun 2026 10:03:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] exec/cpu-common.h: Avoid including unused
 'exec/vaddr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
 <20260617160426.64461-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617160426.64461-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/17/26 09:04, Philippe Mathieu-Daudé wrote:
> We neglected to remove the "exec/vaddr.h" header when moving
> cpu_memory_rw_debug() around in commit e9048f099b3 ("exec/cpu:
> Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and document").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 8cddd32ca8b..7dc8cab3263 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -9,7 +9,6 @@
>   #define CPU_COMMON_H
>   
>   #include "qemu/thread.h"
> -#include "exec/vaddr.h"
>   #include "hw/core/cpu.h"
>   #include "tcg/debug-assert.h"
>   #include "exec/page-protection.h"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


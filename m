Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA5C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrUT-00082s-O8; Wed, 18 Jun 2025 08:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRrUJ-000812-7D
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 08:02:02 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uRrUB-0005ll-AL
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 08:01:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso7798700a91.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750248100; x=1750852900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/tkdPWKJo/a+JyVTJ6TvzabpBYs9caR4EV3q+xM2r4=;
 b=rh+W4izH2ntbkmiVgmuswIabxGlNvYDArs7N7yi7OdIp5nLC6OrYGFkuNaqpQGCto6
 /Pla9lN1jShq+Qp4Vn1rJzEAwVOyFCjN8xG+MGQpV2otrkPGXRN+nKlNcgyoTwErhZ8C
 edVmr0BM1ORKQM7LPYiXC2jTfqqIHet89Up70l5DkSfjKM8qVSCRJH6FvgL5KTV6uZR4
 OUuo/jfXK+btHFd66GwsrQ5le/8VpfnaZIEulfWjdnYkghlWLRRVqrTuiEvlFzYsVX9D
 wMPldWtNyPx68WrHf2vSfg20FozwtIXH7BHM9AgrbnVG7Xs27+GAbM+BLz+UD1VW6GFm
 IOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750248100; x=1750852900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/tkdPWKJo/a+JyVTJ6TvzabpBYs9caR4EV3q+xM2r4=;
 b=MV3LF9gfAdTzIxCQFZlpxk1s6KjzKtgudnxCz2xv3L1W2qX1YYNPqP4lpzx0gXqmAk
 uWUV7fnkT0j9x/8hlsfh3SpTTFKtgE07y/8dBpR2mwAO3LOIZpSLXyBWu83FOVSjS35O
 Shnvo21oF3+WzH+C3EXUMxDOTIBwA7ywcPAQ3MvjOL8Y/T6CiNZ5fM0SD/Lj0lJQiAKk
 OF5AZo/TNL7XaXicSL6z7JQC83+bcVSxAQryDhyI1jN3/MMJ44+r/VJ5jiMKfwFsnfZX
 vna1A4MckPF/b4hDIeb0kroXlp5MI1bBvtgG8jLPxz55/IVxJqX8jzk4/f47t54kDIf5
 OpoA==
X-Gm-Message-State: AOJu0YwN8uuRTfLBUV3jNmr0tB1eX/CIgUQSvyJAMzI7238osFPsY/Yl
 tPPspnGkfT4JCld+rFi6r7x8YHcYN0F13Y7lBZk8NJAfs+YFx9FBE1xjVgddC/4BLV8=
X-Gm-Gg: ASbGnctyOLITFB2G0VFpj0HJ5f7JGr6hXMA21zjjpD74IroaP0rNsQyDjDlsbMArvmA
 ANUHX27noCWRxWXIvbqI27lNMyk2qcB5SccDsPv894f/wZpyAPbMniDsORKFsDwF43AyAGsI6zn
 CJmRFZ5dm+R0XqBf6qn+KCryMZm0wP762S21w3VAWi3q88M1ipK4JDJK3mcHUcYRf2oOwpxmQWg
 gWNd+05cmwCbEPtHEHYkxCuSC1TeJbBfe3Iiv/R+35mST54C07fs+PzHPD6xMqJj5iC/CxXXCfp
 te0PZbpTmrSLaRT2Yk2X47sbfbdPV7g7sRVPfGU0e3y2UYQUyZYl97jQVdWWIr5KH5kFHU+kdNS
 wwe8NQcY4lGQ0fY72hvX0YsYaJh/i
X-Google-Smtp-Source: AGHT+IE4rooealrof/WJ9zCozg1d7nY3DF5rWByGuBRoAf3aJ2FJZZM1FAi+HEx6ls56kobKy0sMeQ==
X-Received: by 2002:a17:90b:3c8e:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-313f1d2f830mr28186085a91.30.1750248100225; 
 Wed, 18 Jun 2025 05:01:40 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3142829d52dsm3436495a91.1.2025.06.18.05.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 05:01:39 -0700 (PDT)
Message-ID: <b82b85a1-1cb1-40a8-9d01-bb4b88c024c0@linaro.org>
Date: Wed, 18 Jun 2025 05:01:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Remove null pointer arithmetic in tcg_malloc()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org
References: <20250618103555.2020-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250618103555.2020-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 6/18/25 03:35, Ilya Leoshkevich wrote:
> Clang 20.1.6 (Fedora 20.1.6-1.fc42)'s UBSAN complains:
> 
>      qemu/include/tcg/tcg.h:715:19: runtime error: applying non-zero offset 64 to null pointer
> 
> The code uses NULL as pool's initial start and end, with the intention
> that `pool_cur + size > pool_end` should trigger the allocation.
> Unfortunately C prohibits adding non-zero to NULL, even if the result
> is not dereferenced.
> 
> Fix by using a dummy pool.

If we want to get uselessly technical, &dummy_pool + x, for x > 1 isn't legal either. 
This is just waiting for another ubsan update to break.

Does clang accept it if you rearrange the arithmetic to

   pool_end - pool_cur <= size

?

Otherwise, we may have to change the pool pointers to uintptr_t, so that we opt out of all 
ubsan silliness.


r~



> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tcg/tcg.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d714ae2889c..afcc7ec8849 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1358,13 +1358,14 @@ void *tcg_malloc_internal(TCGContext *s, int size)
>   
>   void tcg_pool_reset(TCGContext *s)
>   {
> +    static uint8_t dummy_pool;
>       TCGPool *p, *t;
>       for (p = s->pool_first_large; p; p = t) {
>           t = p->next;
>           g_free(p);
>       }
>       s->pool_first_large = NULL;
> -    s->pool_cur = s->pool_end = NULL;
> +    s->pool_cur = s->pool_end = &dummy_pool;
>       s->pool_current = NULL;
>   }
>   



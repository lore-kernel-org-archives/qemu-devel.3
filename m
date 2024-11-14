Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85CD6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe9v-0008GK-9N; Thu, 14 Nov 2024 13:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe9Z-00084z-2C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:01:29 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe9X-0002UH-Hm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:01:12 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so777119b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607270; x=1732212070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gOVc0IsxUjRY3luE4LOCMyQkK4uXUc41l5qhTU5bscE=;
 b=c4YtA3hPwSaUBqnfRd7SKZzITG2KrhagaQViBDB5Qx43pmJUVYf8Cto1+JPi+O9MH3
 Txaqtsl3mTdnXwEG5ij9Zheasff6EDUYFVjK/lccYzY5tkH/XSuCzmZBjOif6Fm+onJK
 OOg+tjdPwpmR53ulIA3pdjGW/WM9y0Fm6k+cBEL6buTzcaBky6xOkJWtJjg05RlJzip1
 yvseaM3oci/wGZK1JYF7/5ZJC5Um9wmZLj3gEMs/bwJ1kDouNSs2LGTziTskAjFUd195
 14AIzh66aJTAZ4U08tjhHAxfNJoIZYVfcmvGzSX5ctdQDJ4IiVY+k9QHylQhIpSdDanz
 k98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607270; x=1732212070;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gOVc0IsxUjRY3luE4LOCMyQkK4uXUc41l5qhTU5bscE=;
 b=I9GiWRAYv7NMFBHnqA/v2ygjEgv8Av1jRcFrRcjXVte/Wy2WrJs7Ze63m6WMCKeuaV
 ZT12Pvnz7ksbyKaCzokfnyTCEE+IeMgln2z8NhTVegQLmnSxwNmIH1H7OHkrY5hTvrg1
 EAsQa1NJG6uEqyi0J3D/cjNIkJPhElYYWzJ6qQCiwBWpUK2d5QQyuyfiOig4Wu4djGhN
 e+Q59MrYSuZ2XiI+Ck0NlJ4tUGGJAOnAQIgcjsd+GCCcQDIVsNGOCO0cgOvNZlwpQFyu
 m4O3rIIR65UeiPwd75ZmP6SuHeVJLKleQDpQhXSkhKky/paZyNnjNcQGYa/f/0kbQQB0
 3KRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgB6vlFG7NW9xHwdY+LPpH3HNKQ/iEeRkFLcEBmMcQft5rPCrkrlGiZNSfdiaKLIcbWTjZ31K9Nia3@nongnu.org
X-Gm-Message-State: AOJu0YwKKIUVgDsnFgt4fqGbg74ZqKText3UU0qAkDAyDQomPZw8fzPJ
 /5ztWHAho8EIMyl32lMfQg4bn3ADGZLtk8Uegfk82W+mQ+qjQ4wUK6DsIadzlktjL8qLYF/IKgp
 M1ry4vw==
X-Google-Smtp-Source: AGHT+IEXQcXrcMLEBR8mWD4sg/GdhclpsIWNe1fw4qpNd+nmQFNZR1i+H6W+WLhh8jSJ2+Vhf2do1A==
X-Received: by 2002:a05:6a00:1385:b0:710:6e83:cd5e with SMTP id
 d2e1a72fcca58-72469a5f5e0mr3901252b3a.0.1731607269581; 
 Thu, 14 Nov 2024 10:01:09 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a6f257asm1538862b3a.76.2024.11.14.10.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:01:07 -0800 (PST)
Message-ID: <6ebb5f22-235b-4340-95d7-d53d2e97a07f@linaro.org>
Date: Thu, 14 Nov 2024 10:01:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/54] accel/tcg: Remove IntervalTree entry in
 tlb_flush_page_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> Flush a page from the IntervalTree cache.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ea6a5177de..d532d69083 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -568,6 +568,7 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>       CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
>       vaddr lp_addr = desc->large_page_addr;
>       vaddr lp_mask = desc->large_page_mask;
> +    CPUTLBEntryTree *node;
>   
>       /* Check if we need to flush due to large pages.  */
>       if ((page & lp_mask) == lp_addr) {
> @@ -575,10 +576,17 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>                     VADDR_PRIx "/%016" VADDR_PRIx ")\n",
>                     midx, lp_addr, lp_mask);
>           tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
> -    } else {
> -        tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
> -                                   page, TARGET_PAGE_SIZE, -1);
> -        tlb_flush_vtlb_page_locked(cpu, midx, page);
> +        return;
> +    }
> +
> +    tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
> +                               page, TARGET_PAGE_SIZE, -1);
> +    tlb_flush_vtlb_page_locked(cpu, midx, page);
> +
> +    node = tlbtree_lookup_addr(desc, page);
> +    if (node) {
> +        interval_tree_remove(&node->itree, &desc->iroot);
> +        g_free(node);
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



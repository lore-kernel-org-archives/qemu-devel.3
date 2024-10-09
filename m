Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C0CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygUr-0004RL-LX; Wed, 09 Oct 2024 19:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygUp-0004RD-Tk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:53:35 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygUo-0007SW-Cq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:53:35 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e9f8d67df9so226105a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728518013; x=1729122813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWG+irtBh5tY59bQBJH0RsBp/hchjLZIbjSjpBxIc6k=;
 b=gtjPK04aDUGvUhqsSQsyf1lZTr8TJ61PevFJAkFtaBJhN3QmgeYY7+Jo+k244+Ukg9
 3ko18PZHawX2+alaE/QVhF5uDgP9jp+JwSw8rAOs2KtFUE6B72aOPl3hkf2OTEjQKmLB
 cjxcyzdriFMNOdHohLVe5WsV2UygfdlZrk2SMcajh6i72+wxOw/6+kqTO8PjM6zUHhN4
 iaOdT2QRv+CBgjgeRM6R1M6DpRymAffrkgqhhTvio5lKZiZuVS7OQ9u5WfNmRsNvJ4AF
 Ojwx/ZP43a4GIIatWWMEwsSHXoxo5TtCO2yhSndIt4W8mVxYcPDYY6ObNyWdxDnsO3VW
 +Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728518013; x=1729122813;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWG+irtBh5tY59bQBJH0RsBp/hchjLZIbjSjpBxIc6k=;
 b=ADuZ7L5m3fNT/9J4C35+vB1Miv7GaoakrrvQGuKEazb1ZPn8NBBikvJ4irQ6tu8buz
 M8FdiVK9L+OJb4lmQItKyhNagVco5Xt32UEDWZbIHPL6DiXp/cIqGz6hwhYVXwzuFXUY
 6Br2rRrhwtBxE7UfaOFL6X3cmmYn3j3GDpesRO4LzEbwpJA3enxV8gqzsAT7iUzSPZYY
 174Os21o497buLMOAEoUASbApzZ4yhLgTcKoKk2pVVqK2NHitGG1cXPhf8js8vpUkqkd
 LNOWVNP+jv27b6+Qfl7G2F+lTWRwoLmklmUvjZUkUuOUVkZReW9VcxEkfG9FYcGLTsjl
 T9cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMcdZABnvZgQi5iXSfisA0eCkqDLbl29wuTfuNpYgax6kzFdFXiQQAWDy0sFyZlWJbWNmHA5GnvSkD@nongnu.org
X-Gm-Message-State: AOJu0Ywu6NwUNZFXhE8e/+poivG5uRJvkFyTR7V6gr3C72eV1LqLSB7W
 hXU5iEWYAAjt677Sf4d9+RbaBQBBrUtsi+2jB/+dTU16Cp7mugy8lZOW7OOIy5nHqVmcuRg1MW8
 /kp0=
X-Google-Smtp-Source: AGHT+IEKGYiRaxjKAstQE82GqZyCTDHNUVwnk3VrHlB72prt17lcwzmKdH98mMpLbFHGJF9eUdCQ3w==
X-Received: by 2002:a05:6a21:a4c4:b0:1d5:10d7:2020 with SMTP id
 adf61e73a8af0-1d8ad860fd3mr2858892637.41.1728518012899; 
 Wed, 09 Oct 2024 16:53:32 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d47863sm8307179b3a.119.2024.10.09.16.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 16:53:32 -0700 (PDT)
Message-ID: <89cfdbf6-45d5-4829-9a18-d386cca7bb3b@linaro.org>
Date: Wed, 9 Oct 2024 16:53:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/23] accel/tcg: Remove IntervalTree entry in
 tlb_flush_page_locked
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Flush a page from the IntervalTree cache.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d964e1b2e8..772656c7f8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -573,6 +573,7 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
>       CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
>       vaddr lp_addr = desc->large_page_addr;
>       vaddr lp_mask = desc->large_page_mask;
> +    CPUTLBEntryTree *node;
>   
>       /* Check if we need to flush due to large pages.  */
>       if ((page & lp_mask) == lp_addr) {
> @@ -580,10 +581,17 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFECED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygtx-0003NS-Qp; Wed, 09 Oct 2024 20:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygtw-0003NJ-1F
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:19:32 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygtt-0003Ib-IK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:19:31 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e9f355dd5dso150487a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728519568; x=1729124368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r9mont+MjhVPO1kutSQjn+mT+7O2jKyUJ35wz2oqUPM=;
 b=AfGBkDXt1nf/POGHaPk4JySeDOcTcJpIhwsCYzabIreYwFLYEujYmastiCFqWieQY3
 JRx5b/zUsoWk8+x3bBHgCn+W2VdNyTinRAjmq499TlAOOspAJw9+LgrY0T4UVH9AmuW7
 EVNE3F7OIieisG3pEWBChwfmCRwrKfRkjM5LZ+6PLYFbpkprae5MoJJJRYHD2pHyg+0T
 llz4HILJ4NMfg7DKy12mXsDRPFS9u+lRdqq9wHlq+MHrlIaiakHEO1Q+TikItNZP82bS
 LjAawNg4Xm3Sl15YEWpXFNtCMMDrDZh/RvWDiV7sZFUBGHVKkd3XSS+8/LSimI2k+Vxt
 JyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728519568; x=1729124368;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r9mont+MjhVPO1kutSQjn+mT+7O2jKyUJ35wz2oqUPM=;
 b=mYDlLgcRr4E35JMsG3WK+rG+XGXgAjQT17cGqlsJ3AHDokMwNmB1bS+S20jMaMF5v/
 OIqWRVV2GkP6CFXplUqGPQ0ojUnU55FNDvE+vdNAkldgy8eIlnyBiG0fvUzn0n2kgWuZ
 515/2b4nHkKePKkhVZUzP0LB15h5OfvqFFoFes2OIkRyZUHZZ0NbDHFG7cF450QrbvZm
 6kntSaqj3+KEHVG4KYabz5+Oy88CWtMhZf7JA1FejfCabhXtBhidmuyIqKnGc4yZ6VBP
 xcU3/OdYiSRih5RbGnBrrhA8e71lEKcFeke2bxz3uJKlH0fTbtZQ1htrx+Et2WP3JaDQ
 fYkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIA/jULnJFPsZBHZtIOjzDmDdptb8ySYo86kHKjoiilB3BzNecBDPGvIPwUzcC1DdXytQf6nPVxIFY@nongnu.org
X-Gm-Message-State: AOJu0YzagFdiQn5K0ZtRDSGmZ9DHXzc/BtTmf0MtAk0VxoJ4VnmR2PsR
 qpv9cqMbWGBB+8EOIG/bs+xDq7Rf8SYZFccGH3p/KBVuBw7kDUdAHICQqLVTvRo=
X-Google-Smtp-Source: AGHT+IG4tri9bzXHcXl5ehC7uO91BQgxHAilawGTRdlKfg3eaxCkDjkZbproSxTPWs9ZnMl10YH32A==
X-Received: by 2002:a05:6a21:9103:b0:1d2:e807:b940 with SMTP id
 adf61e73a8af0-1d8a3cf65d5mr5920260637.50.1728519568182; 
 Wed, 09 Oct 2024 17:19:28 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aaba5a1sm6904b3a.175.2024.10.09.17.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:19:27 -0700 (PDT)
Message-ID: <f79fd425-4010-4d56-9cb3-8d6471fcbb3a@linaro.org>
Date: Wed, 9 Oct 2024 17:19:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] accel/tcg: Delay plugin adjustment in
 probe_access_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
> Remove force_mmio and place the expression into the IF
> expression, behind the short-circuit logic expressions
> that might eliminate its computation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 561f66c723..59ee766d51 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1403,7 +1403,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
>       vaddr page_addr = addr & TARGET_PAGE_MASK;
>       int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
> -    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
>       CPUTLBEntryFull *full;
>   
>       if (!tlb_hit_page(tlb_addr, page_addr)) {
> @@ -1434,9 +1433,14 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       flags |= full->slow_flags[access_type];
>   
> -    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
> -    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> -        || (access_type != MMU_INST_FETCH && force_mmio)) {
> +    /*
> +     * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
> +     * These cannot be treated as RAM.
> +     */
> +    if ((flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> +        || (access_type != MMU_INST_FETCH
> +            && check_mem_cbs
> +            && cpu_plugin_mem_cbs_enabled(cpu))) {
>           *phost = NULL;
>           return TLB_MMIO;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


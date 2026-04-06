Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BF5E9D828
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xcz-0000ps-WB; Sun, 05 Apr 2026 20:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xcy-0000pd-Aq
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:15:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xcw-0000ok-Kt
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:15:40 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c76eea1672aso46578a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434536; x=1776039336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0JuqdLwn/cO5iH73TcXFe8s0MNgLSl6Ln/ltkbbz/Kw=;
 b=pi7Ykjzn5cXGtAAOUiopyC6JVHJaIdi55YI0h/MFnfpwZ6j7CmidjO7d/83gN1MZ/K
 cawv+zFld63Tu+2Fzcf7vf0CpDubJOU2rqqihwl2AR16WQKOydmyw4zPaB+SUQwlPOFv
 9d0VZzCQEuIpJqyobTrYTDNlSwZ1IEiPdVfFaMFWZ5den9gVyM48osbXxoLhqqeKZvay
 FAM9gSRXItJFIejLfZlxeFpq59hE5KlrVOmjRxrNC+Jk6UTeZiQrih5+/wqLTCo6mE3n
 KlLO2cjWkm3vQmAIrln7lWCjUn/VICXSuid5ZRFOaz/AJnBfqMaP5PhVQrab32edLajb
 PDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434536; x=1776039336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JuqdLwn/cO5iH73TcXFe8s0MNgLSl6Ln/ltkbbz/Kw=;
 b=oUtDqrGkWg/KFpuwQnffyh6d/XymzTI4am7U9T11jKFW+DnyrGkCKC7ajPgD0XBYEj
 5NwBvG4WFKJVm147cuPtMaDcxH/PiusEvr2aUAH+gJa+rjPWaUmdL5W4dZkkOHTrltf6
 g9EdbrEk9mxs+EHoSsLES0xCKt2v3oRNMLjFUftY/nyvAdaJuP6ZzTweqLMmCo+/bEtU
 +/evFWAKS4jsisiFH6C8OMH+lpT+OFwrJfqyGK6GIgtNkClEEXaqFaChKI4/Fa8+cgfn
 wLko60ZwDyXi2zu8NmXd0Vm1/tenpMmB/jTCVpXbYeE/6BoEHWR6wQJ1yzrrWNSblcym
 r4sA==
X-Gm-Message-State: AOJu0YzrL792kh0oyDaYq0q5Yn9uMZva8S7ei5LqP675QsJvTzI/uQMX
 xv6B5Z58lMFMSfiwlgxNkNglzD06beAcbfpDy7JdqgRCFDwilRejVUaXaaBdnUgdNUZtsbAlYX7
 OBOne
X-Gm-Gg: AeBDies17atgV0XeOnHFF506l2jHF4jbHIEMXfoaCbkxXcdVQ42zq3KAopae22Jsyqw
 UOFz5hxs1Qx09AzW1FL0tcvnKunnHt2XnqlENabhWecJrL7yJawqWSr9fFaArFAL5Rmn3Drri0L
 JTImWoIZ8TjqgqvHdHR+D1MIw8PVdfByVWbkeRzQjkvdT1AjhLab7QTKO3GdFqdwNf8qJ4upBsB
 vHh1ZjgOUsYftJgKaSFRxJduntGO9+uTo0WUysAZJ3jn0rCHVyK6EUmj+/TyV6wKGtjcuuS4IIZ
 Pl/LoZLJmqY/A3adX4RpcAIBbeEuPrG8AAnm1UFeJk06Rf3Z6hZY0eqZvtmlLlfGe/uuSKdYYlG
 oj6W8FDndCloVSHJyhuwX1X5CNnEHN6HyPdXzcXhZ7ToDowNvwKzBTLyT6FhEkNarfWZab/lRUh
 D+Q51gJX1ESYwLN2QeloM+XIljFDjjllceL0uOIFZWI9q8LbSuB7eoe+3Zm3BK9jVLMR3fWbRJW
 uMZOw==
X-Received: by 2002:a17:903:4b47:b0:2ae:803e:6c0d with SMTP id
 d9443c01a7336-2b2816c291amr105156745ad.19.1775434536241; 
 Sun, 05 Apr 2026 17:15:36 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbc58sm123716705ad.78.2026.04.05.17.15.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:15:35 -0700 (PDT)
Message-ID: <02c9f561-b136-4c2a-bcb5-010db1a239c2@linaro.org>
Date: Mon, 6 Apr 2026 10:15:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/35] target/arm: use syndrome helpers in
 merge_syn_data_abort
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> One more step to removing the old defines.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 565954269f9..c74d8e785a6 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
>            */
>           assert(!fi->stage2);
>           syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
> -    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
> +    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
>           || fi->s1ptw || !fi->stage2) {
>           syn = syn_data_abort_no_iss(same_el, 0,
>                                       fi->ea, 0, fi->s1ptw, is_write, fsc);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


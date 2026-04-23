Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8717AFAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjqG-0005E6-W4; Wed, 22 Apr 2026 22:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjq7-0005CQ-Ba
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:30:53 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjq5-0002u9-Ph
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:30:51 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8ee62a19730so234130585a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776911449; x=1777516249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zYDYEXizfW6rvTyRVJFbPKbXP1tHt3hmW5DfTtI+Wqo=;
 b=R1QBeXQmwwFVyCZfWXhGt5WzJPTjlKTtexDiVmvGwd0az3PsRjCkIUxhvADT8xnjTj
 wIUNZEHV5fDFTwObE6EteMzkUfowF6lV7u0bg6It9dCshUUcMqjTeQgNOh77RFHMEOty
 0x4XlRdgYGAaD1N7+HbA2tjXuw5DBuru7MPYudby0jpLYb5E66Zb57JpBDEfIcYCmFiy
 UBdMHL/3Z0hA/+e8cfTGTOgOFPPd70DMo9o2KgNJDvTDvwXZzmX9B1Pcln41QBzFqLTZ
 CePmlWoiHbfKRUy8zOH6iw1t1GwnT+lTAM/irW1BT55vagSgCMZujzbboW1s4QZkqyya
 tccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911449; x=1777516249;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYDYEXizfW6rvTyRVJFbPKbXP1tHt3hmW5DfTtI+Wqo=;
 b=N4Y5Sb9Zj9JQJ8w4Y2iw4wmZelpU0PkA7HDRWnPt1sfkatDw3mDJTgfVEh1fHxJKZ0
 s6enwn5TGDiEcc99S7TW6IbEgy7pqS90VpMGlF5tthtSKHU3YDYuPwM3O4JEZJV8HCZL
 PkUYwwdMvP08eNsaTf/JSIMKqT/nYy/RpKPc+Iisf0Rk+jiZS0zdeVBSo+UirpqJo8M4
 jbh/E7lSb2mIWAGPHyguB9iWBqHpDQ62ZtjVpkngQVWmFocDLD9QpivGFvjU4N/5PlW5
 LkKslnY3YmS4RK4kiEvKtxbfUuIcBszu2e4hmDAQf7en4JOYsn40zAXLl4AP0s4yoPzv
 QxhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xuOAZWuhEbo40j7BK7MKWkyUaJJJd58mfo4WUwHgQJappFeLHOVWtS0LFq649yvvDuiQ6E6jLt8kw@nongnu.org
X-Gm-Message-State: AOJu0YxBqdYicIBjHiWWFjBHtdz6I0fnI2Pm3lcoRYON9QhffwXH7RdP
 4yLYI05X633E4vY7zwBg2AMIw+JW54MhNYUYIgVIzVW8URnqA485V2deVxXkpMNScqg=
X-Gm-Gg: AeBDieuVACdgtYd5O226VXfEf32bEwTDU8YhGbkQxRqGbKfAvwhjLNUU/ESpNC0p1cI
 064k4TdD74MY6EVL4mTaZ/Gj3J78FAdO/b456jEz+HKNnjWJpddoyGBNpAEuINGXmXAX9dvaVo4
 t2dGDtP1Q0m24UQJQ3sCCHs4ngCjvDRLHLAIBf/9yw+UlPcMzGTiSiKmIo6loQl04TL0a2BaGVZ
 4WL3FMny75/FsQwDcZkyJ+z1K3eNSO91O9IRlhJ3FZ21H5oCxp2oUAsLXDMimV5+NsvzZgsEGca
 WKo1gWAyjPyBQ8bFRcz6ZRxMH8NSYR9FZrCfUvWBCI7JE1FFfkosnDJRHvKV0t53Hakoa836WvJ
 GKkzFcMwbYKC++EGqoFQGHy+8gGgg42Y/WckjtVOaHfhj43TfvaVYNNW8FBJZrz7p+z7QoXrPZj
 Z9WGwIdBGuI+LJrcWk7z8hsMdnDWikggKP/ZzoFNsZNxNqNrXngI3ZnOtT7l2pqLQHbCNuWgIqS
 n+2AYhcAN8dQ+UsYvEpBiP6f1VM
X-Received: by 2002:a05:620a:178a:b0:8d7:f950:ea68 with SMTP id
 af79cd13be357-8e78f24ddfdmr3724454485a.13.1776911448665; 
 Wed, 22 Apr 2026 19:30:48 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8eb19632130sm1112106685a.41.2026.04.22.19.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:30:48 -0700 (PDT)
Message-ID: <c780ccb4-1490-4c04-bf15-43822c0b5266@linaro.org>
Date: Thu, 23 Apr 2026 12:30:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] target/ppc: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
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

On 4/18/26 03:30, Peter Maydell wrote:
> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> The ppc_xlate() function can accept a non-page-aligned input but may
> return a page-aligned output; we take the simple approach of ORing
> the page offset back into the result address after calling it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/ppc/mmu_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 52d48615ac..a1345df716 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -863,7 +863,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>                     ppc_env_mmu_index(&cpu->env, false), false) ||
>           ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
>                     ppc_env_mmu_index(&cpu->env, true), false)) {
> -        return raddr & TARGET_PAGE_MASK;
> +        return raddr | (addr & ~TARGET_PAGE_MASK);
>       }
>       return -1;
>   }



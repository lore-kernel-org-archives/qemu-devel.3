Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AC0C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHri-0001zQ-Nv; Mon, 30 Jun 2025 13:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHre-0001xV-7W
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:00:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHrc-0001zx-5Z
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:00:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-311da0bef4aso2425923a91.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302814; x=1751907614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3eQNe5zSWFvV6RMIIvin+yaWpWS4xAVg44LW33aFDA=;
 b=F5I+h4+ZQE+xHdTa2jLe6bz8pnJudMJjJOEiJaSZ+HaHbLR0mk+KyI4mKd09//c1UZ
 ssxLcf8PbXwrpqw+cwlyimrTsnHGEBqv6chfDcKIQ0uHYwZykPRSSmXFZ+QIFn3A3twG
 mTKPhaCb5hH2UpdQW8g7gtc2B9kYT+AG5FpLfUTz+QgtAkLqrn7rjt2Nu9SWXnWZxfJm
 qYryx6RegMefUnKJYJR5uRwBYnTMP7HP5g3qS9a9fOIa5HyA2KjsbLh8tgwZotQ1Ef75
 wZNfK3V/Uil5ue/ESP+E7h3yJLk9r0RRvWm8ptEQoTUPZ22YHn3iwDS07sZn0kcebpvD
 ZeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302814; x=1751907614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3eQNe5zSWFvV6RMIIvin+yaWpWS4xAVg44LW33aFDA=;
 b=F4cJhIpCbxHueNkjQdYErzqDgxZW43/EcLO0BMztI7i5CTdE6yzltcsZivwhRGSWxF
 91oPecwfUaxcIdMNcmxJsJNPLPmOuqYsuj8n+HDr0VzhLCtFMi2P18FVKqrKRf565qYI
 U2vNZQDZEYXl/32aOEKq1lEkK7oriQP/KOybTHQvaYA7mjZAkOoz25ivFi8zC3uEVnHt
 K6y+FbjyJxk37wSRDLaWqXh3zjTDE80KkhX6EV2tniazzTmwrh5sbElPCaGjRtSR7nfd
 O/PV6cTx62zYp63UjsmJ5MZy65+AGzq6Jusi3Udf60qq/bBrRXcOxpYkaLMFuhK5aT+U
 Q39A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7CqFzJFGpSPaTltcq4sEfBWnTPR5lHbehVNw1irHf4kTZNO9++KyaG/kFLOr/aFze4OTi7mtCcFZP@nongnu.org
X-Gm-Message-State: AOJu0YxK5Mgu/1ygu2nMTZJVX9aAxkpAkjFcaU49XTWFygC50q/TXm04
 m2ClpneMm0OeKdNwlOMHwqJ6y/qcDAJGgaJj+/6MPpfCbH7REKbYpaggGhXrCY8+ZgY=
X-Gm-Gg: ASbGnctjXJQYVCK04Vkn51tG6S6kwUysc94/ohgfKd6bJ3wWFgzLFIo735PYk9g4tbN
 1xp76sboKm32tSvFBHPCxYlj5Q5MaWDmrrfCdCMEL3x3PVPXFGVqYlhXC1Yrm8KbZ0I+l6HdP12
 owjYsrXnJ+sPaqIWnuJxrRQOT23waAyAcO7aVhDXBF7ZNW0eQAjb/3n5hRvSwlFG9HoBo6xQsZF
 S6xOCm2k4+PziPo9SyaLDj/OkUukeFml4T158pLFHK5dicTijt8gsePOmC7tdBJybijTEG5vy7q
 BfhwKRyf7XSfFY/RhRJUBxM4jAShhy3PqfrcthwwS0oUZ44v20PCA+CUGMOvS3OTS3s6g3uZkDQ
 =
X-Google-Smtp-Source: AGHT+IFGQTfgRoayqp0wsGP0Ws6F1wt15Q0VksNcgT2DBn3B6Mah97+3gXp2+5ltKhPsLpxd5/MThg==
X-Received: by 2002:a17:90a:ec86:b0:311:a314:c2ca with SMTP id
 98e67ed59e1d1-318c8ff301cmr17697123a91.6.1751302814166; 
 Mon, 30 Jun 2025 10:00:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f5383eb6sm14661996a91.10.2025.06.30.10.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 10:00:13 -0700 (PDT)
Message-ID: <c4a4b79f-788f-4c78-afc3-842c2dbcefa2@linaro.org>
Date: Mon, 30 Jun 2025 10:00:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/arm: Allow arm_cpu_tlb_fill_align optionally
 set CPUTLBEntryFull
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 23c72a99f5c..df04ef351d1 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -349,7 +349,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
>                                 &res, fi)) {
>           res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
>           res.f.extra.arm.shareability = res.cacheattrs.shareability;
> -        *out = res.f;
> +        if (out) {
> +            *out = res.f;
> +        }
>           return true;
>       }
>       if (probe) {

Would that be possible to provide more context about why it's needed?

The goal of tlb_fill_align is precisely to return a new CPUTLBEntryFull, 
while checking all the protection to access this page and generating a 
page fault if needed.

In case you just want to check if an address is valid, 
arm_cpu_get_phys_page_attrs_debug might be a better choice (checking for 
return value -1 in case of error).

Thanks,
Pierrick


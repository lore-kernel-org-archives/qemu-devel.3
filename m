Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F403C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEze-00033Q-Bz; Mon, 30 Jun 2025 09:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEzd-000338-52
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:56:21 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWEzb-0003tW-5R
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:56:20 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso772033fac.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751291777; x=1751896577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGFOiZa0zREV29yy8MdZoT3iiirrIep9pVPiA23b/cE=;
 b=tyuJnjbyJXlckDUK8fBZ9UXDE0SGcUeq779TIdKfIx9DJ/xSQeyl+o60kUVCAQnFry
 zlMn6E2rmC4ghKlVRclQN9v76vfzW6gBdcJobb+WdE5rapphZUytoji9EG4aoSR0XID4
 7dQg63MgD7zVayaY/NyeVLDSiPfN2OYXK4G2/6rB8nc4sKSSx/RT1LnwpgZn+9xDwX14
 DbLXupkjjLvzSjqbS7uwLnzZx4fwd+iXav+qr8kPsAqKEHH8m/dZQUay7iJTxD6dMI7t
 3nfnNANmAb0lIZbefunmnB/+QCeDEvVgDN3Oq9HpG1roiQ3FrYSCCSyP/iRH61ra98Zu
 2fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751291777; x=1751896577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGFOiZa0zREV29yy8MdZoT3iiirrIep9pVPiA23b/cE=;
 b=lk4LVr2zBn2rxl7EFJ+QCbla4QovwD2tSPPwDLZowU23M71GMTcVrweJ+V9vJVVloo
 0AqdX7goOWiF9Qc0dVMCsQYFqrPtYprQph6j1zV/+uxXJVh1yBgC9vIUcQfCWJMrlG2m
 A/zvHJ8ZGRoFdauexoMk7P/NSeKw2rG0hEVCKzk7g4U0ZoVFH8Hbzt+YJsJPlMm1XbpS
 wWuKXGgnZcqhzcmlYWXu/Hnls0NnndvSdNQ1+9IQ4UY3Xx6wofBzZEfnilCNntF4RenA
 KuQYUp8e0FSEROYeXna18MXDNVke7NF04r7SBFB8+LMGZSzJSBgBPWR39JrdW9rApXBc
 gBnQ==
X-Gm-Message-State: AOJu0YxdD+z7eFakNHVoswhvvRVXVM+1SDA2GtIASJUwjk5dBhRiycyC
 btx7Gv78ac4/COYBG7YnqwJAOAlr/W2ToFDzDvRrR/rud0BAqZt4PhyXunWM046zrDCTe5tOcOL
 3+apA
X-Gm-Gg: ASbGnctuFukuYT4y5rVvjpREatZZVeKbkoCM08v8dLTBtySFF5uwK+qlGgySiAeT2QU
 h1QfW4FpDIhj6+c0OZGxMe7O3n+MRLYlHyIWwMGw+EzrJdSJWDQ+mGMrr9//INrUVAIEPGJgSnb
 484dSN24RB+GhUXOiQODS3VuczwU5DI3JXo0ywNjntgTPxu0anJL2BLrB2Erpr6osUCN6Z4Ztbh
 yqJWXr9Y9WrHE//s4VlDgtPr07oJZnrSzm5aWqon/WUvX0lEWbE8wLkNgF70VqQpkX61YTd5HdB
 DtOvN/CFPdokFm97FTkc7+T3ssuJInxPOVTv/MyxASNJXtNZjSKXKTlS3Q6l8XswezeG0YGYeBu
 MR/FrvTVDxjc=
X-Google-Smtp-Source: AGHT+IF4Ymi8lmyuZJODt19HOT4QxbGoUKoOifXKDWsaoU3kw9Or4JAsy1K8g95vTOaxSl49XSApWQ==
X-Received: by 2002:a05:6870:d92:b0:2ea:70ad:4517 with SMTP id
 586e51a60fabf-2efed4f4f3emr8253925fac.15.1751291777136; 
 Mon, 30 Jun 2025 06:56:17 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb02ad29sm1670694a34.29.2025.06.30.06.56.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 06:56:16 -0700 (PDT)
Message-ID: <8141d048-42e5-4b79-a90d-0ef1857d5857@linaro.org>
Date: Mon, 30 Jun 2025 07:56:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/arm: Allow arm_cpu_tlb_fill_align optionally
 set CPUTLBEntryFull
To: qemu-devel@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250630130937.3487-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 6/30/25 07:09, Philippe Mathieu-Daudé wrote:
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

Why?  There's no other way to get the phys addr result.
Are you only calling this for the raise-exception side effect?


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8874ED59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6St-0006JM-3Z; Fri, 12 Dec 2025 11:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6Sr-0006IL-BZ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:57:57 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6Sp-0004P3-8g
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:57:57 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45391956bfcso1136488b6e.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765558674; x=1766163474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6ibLbD8DJU8rVfds+XaATneu1XsTFFaajuK/geRg9I=;
 b=vC3nPsMhJGIO9lxkkHHvjNiO1yj8LXpu/4arutQvhZfretXfXidUoHiz7lGYkjvrxi
 0yqBPvAIs/8zs4NHAiiT6AdIofsb99UgGDmDuRKljEgx4r2YkLPgQBnwdqEPrHrekAwX
 +mrD2DZ64OvyGBNu5XC3XJbilu9hZi56Ps+YykMGAY3KYz9SJY0sHn2VWN21uWwmsHd0
 oKRCxHb/L6uel0giJC/Jdu9ZS8N5oVxL+BZb1umpYNNCv1a/cBNJm59syWdJZGDebMvA
 o5DZ7AO6nXwhxqGhPCSh+6CZO15qhWGf4X4d3j2r5uHI343Ta3R7vHs69XvSoTyVUZo+
 j2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765558674; x=1766163474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6ibLbD8DJU8rVfds+XaATneu1XsTFFaajuK/geRg9I=;
 b=hUZi62uahMLBdt0NbjdbryrelxJ+q71gK/GS87MQRNTgEOxIDU6DA7Mrd7a3bSQxg5
 1WlIxV746lrOcuzCa5+b74yk5yOZqxsPRiw1J5EWozEOShz930dMWF99PeBL17lI2azA
 qiLMjADvXtwKNZePdsCEkxs+cnvj/i2k+tiBQrfdXEe8rnNovFIQ5GjnNcMn3zBmayib
 SmmgTKLQoch8rull4w112pXVACKIHIES6H5oCF1DXooasO6CaterQOYwV00QPMBZ6qe8
 C/fIL8Mighlg4b/nZ7+rvyU1pIKxtGmCnvlQqU9ZS2fttv8JfTfwrSYcidO+Um2XMmnX
 /o2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoxZdrQoNmAoOapfTOzLU6BgxlZUv/bzTfA0/RIAYlFZpivnGiEVM3BhoXS/xflPmXiz/XmcUPGPJG@nongnu.org
X-Gm-Message-State: AOJu0Yy6Bw1weexXO1Bs7WsQFhvesN/4I08NJi5Pa+/prZyt1oxDotRi
 HPSbAw/nXrH+Fl3cUtiqD0z/SqxTzzQnQ1e9IMjH79ks3ZYom0/cz43Hfk1AU8bU5nU=
X-Gm-Gg: AY/fxX49+WYnbQfONiLJhvoIvic2mehioE0suN+NjOVQ2k1Czp+onLLg7Bsj2z2b/vT
 cX0fvnzjNCknfmHgFNRfaDbTeEs4IWQzdxKzloYbvrTdDNY9uZG5mQ5PJ3xx38Out2890R8KjGZ
 0NTrrfTx+A5Y9ej5Wd1MKFlyZ09NAvjlH3prtaLeh23xlN91shTpNOUpz2JQxPlHrLKFxaSa2R9
 muQTrHdxBkrCqXFCsRmc7iQDvG5y3hyGeLGJx8pTbDnHmgBpmB8T9UiCPv0NJ9mEhRXek+CDYN9
 AmJW1al5IWfAFK8Qeaz0w+kfvjHlRrPEvP1Krs04E/xZYMZG5KOn2K1up8ZJs6CQC5RyWMQMq9I
 N+AJURf6X6SyKWUj5nvo9ATQ5+qB0A1lPpf0R4MJP/UuKQggeReSSXMV5q+mUaFaAzCoS1cwI3d
 fNF95bFNwM2kjUo5rqabCiKO6gVNH/F9fIlEmrGtk=
X-Google-Smtp-Source: AGHT+IF++DqLNxGtLSrek7Cof6da9ud+Un+sBrDOrERIn4f4Uay+BFjSAMhb+TCjudw+J1WySJ9z8Q==
X-Received: by 2002:a05:6808:1584:b0:43f:5b3e:11f4 with SMTP id
 5614622812f47-455ac95190cmr928516b6e.43.1765558673774; 
 Fri, 12 Dec 2025 08:57:53 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe4e1c5dsm1296980fac.14.2025.12.12.08.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:57:53 -0800 (PST)
Message-ID: <f1a210ab-8d4a-4646-b358-81183a74c5b2@linaro.org>
Date: Fri, 12 Dec 2025 10:57:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 18/22] target/ppc: Inline cpu_ld/st_data_ra()
 calls in do_hash()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ld*_data_ra()
> and cpu_st*_data_ra() calls, inline them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/tcg-excp_helper.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index edecfb85725..244aeb23c16 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -160,14 +160,17 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
>                       target_ulong rb, uint64_t key, bool store)
>   {
>       uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
> +    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    MemOpIdx oi = make_memop_idx(MO_TE | MO_UQ | MO_UNALN, mmu_idx);
> +    uintptr_t retaddr = GETPC();
>   
>       if (store) {
> -        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
> +        cpu_stq_mmu(env, ea, calculated_hash, oi, retaddr);
>       } else {
> -        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
> +        loaded_hash = cpu_ldq_mmu(env, ea, oi, retaddr);
>           if (loaded_hash != calculated_hash) {
>               raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                POWERPC_EXCP_TRAP, GETPC());
> +                                   POWERPC_EXCP_TRAP, retaddr);
>           }
>       }
>   }

This is the page translation hash.  I suspect the actual address must be aligned, and 
probably forcibly so via computation.  The MO_UNALN is either wrong or misleading.

r~


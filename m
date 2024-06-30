Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5A6C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 17:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxvc-0002Bp-Os; Sun, 30 Jun 2024 13:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxvJ-00022i-QU
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 13:01:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxvF-00024g-0J
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 13:01:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7067a2e9607so1837770b3a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719766862; x=1720371662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jMQnezKxuUJF8CHkae2hxAV5facrSExHSVd+van6xKI=;
 b=chO3bQwM/m8sSTmOh6mSyp5o58KtD4sCbRRsz9e+mkJ679z7gIkcS/pk0xY1kVcj8Y
 IVRDj1CK1wPfK21/kXiO2drxQh90UbonDLV6w0JFjNtMywP7T8VA9Sez8bed5fSCeyHH
 tzAsmVoZqYTX+ZM+hys++LUsAY+X+aZHOTKUUPmQg8m+Du1A6NQ14ZlPESEp6EdEHf8c
 iIgxVJQf5VLuSOdIAeaOba6yXrs8eqWHFRpiN0QWYcYTfYdAIG1CcijHh/1Q4UXuyVaP
 AQpm70XG4OZknKhouMGv0d5zfIRAFT67utOABc7oupBVP1zhHldknL9LlbN9jrEf+4y+
 Nz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719766862; x=1720371662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMQnezKxuUJF8CHkae2hxAV5facrSExHSVd+van6xKI=;
 b=uG2AB67e4dqccoAdZR1JBa5zz4WqshIf1pqJRwQsSpLg59HBmehb9j0RnLyC+zJpIl
 6TP8iZb746cBkbuRwzMAn0OzyIbOB7IKEjXWyO40QmU2O7AYT8QbmwLS7XEwouKVlhfy
 565qOGqvoKuYoihM8OTY6kgYwIjBVprkSDrlqpmVH95yyudyQzoe6YsfzA7poipXgsKZ
 pYN6SwcsHeZ7baQtlE7ZmorniMNHsfqhl/cpYoXSO2RZ0C+AYVBMYIAPFyK3MMuWknde
 SSdF7BXtMZBb9B+30hTpMy2dV6LO46OYTvU7SIrB0AHtAkcZuOhGgvqF/nmsTW/yQ/yp
 CRTQ==
X-Gm-Message-State: AOJu0Yz4B8tb/AwowGHLQ1+01K1JrCss8xTOstLHOUsmLqkyPR21fUq5
 /t49M8XPvy722xb4p4NGzn5sXXttxIHbqaoJWGKcCPqUPtwoLqVisMQ3D1KkXt8=
X-Google-Smtp-Source: AGHT+IEBfi5CfC0QqVq5k+blfZd4Z6cvCeQkGkrc+NV7oTAoVxHWvKpBiYKsE3OnZXwGAt64JPKOrA==
X-Received: by 2002:a05:6a20:6a20:b0:1be:d161:47e7 with SMTP id
 adf61e73a8af0-1bef60fce9amr6169164637.24.1719766862325; 
 Sun, 30 Jun 2024 10:01:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3bc5ffsm5072202a91.43.2024.06.30.10.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 10:01:01 -0700 (PDT)
Message-ID: <15fd6f84-6a80-44b6-93e1-b9ea8f9fadec@linaro.org>
Date: Sun, 30 Jun 2024 10:01:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/ppc : Update VSX storage access insns to
 use tcg_gen_qemu _ld/st_i128.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240630120157.259233-1-rathc@linux.ibm.com>
 <20240630120157.259233-4-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240630120157.259233-4-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/30/24 05:01, Chinmay Rath wrote:
> @@ -2175,13 +2179,13 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>                        int rt, bool store, bool paired)
>   {
>       TCGv ea;
> -    TCGv_i64 xt;
> +    TCGv_i128 data;
>       MemOp mop;
>       int rt1, rt2;
>   
> -    xt = tcg_temp_new_i64();
> +    data = tcg_temp_new_i128();
>   
> -    mop = DEF_MEMOP(MO_UQ);
> +    mop = DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR);
>   
>       gen_set_access_type(ctx, ACCESS_INT);
>       ea = do_ea_calc(ctx, ra, displ);
> @@ -2195,32 +2199,20 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>       }
>   
>       if (store) {
> -        get_cpu_vsr(xt, rt1, !ctx->le_mode);
> -        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
> -        gen_addr_add(ctx, ea, ea, 8);
> -        get_cpu_vsr(xt, rt1, ctx->le_mode);
> -        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
> +        get_vsr_full(data, rt1);
> +        tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
>           if (paired) {
>               gen_addr_add(ctx, ea, ea, 8);

The increment needs updating to 16.

> -            get_cpu_vsr(xt, rt2, !ctx->le_mode);
> -            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
> -            gen_addr_add(ctx, ea, ea, 8);
> -            get_cpu_vsr(xt, rt2, ctx->le_mode);
> -            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
> +            get_vsr_full(data, rt2);
> +            tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
>           }
>       } else {
> -        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
> -        set_cpu_vsr(rt1, xt, !ctx->le_mode);
> -        gen_addr_add(ctx, ea, ea, 8);
> -        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
> -        set_cpu_vsr(rt1, xt, ctx->le_mode);
> +        tcg_gen_qemu_ld_i128(data, ea, ctx->mem_idx, mop);
> +        set_vsr_full(rt1, data);
>           if (paired) {
>               gen_addr_add(ctx, ea, ea, 8);

Likewise.

With those fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


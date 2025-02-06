Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53234C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5yO-0000jl-NB; Thu, 06 Feb 2025 12:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg5yN-0000hO-Cm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:47:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg5yL-0006hI-Nj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:47:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f0444b478so18259495ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738864048; x=1739468848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSmxV1ScoJXs7z0KqNQ+7RFQYS/mpWtXU/9WFsEVWiU=;
 b=KwfMT2JULiXl86VnS81kCO0CNG32GFNN75VY78QuW/vBcv1YYTd1ibvsY26xJckUVK
 T+/X5e4Zj4HGeP57UmvgRfYMtZfH7xy7D/5WUhWdfxDZpc9D/Ds/sY8LO1z+CXBJQLCZ
 m+8Xg2MhzjQq+BQy4D2FpgZvepLVUibhjOGUD1FpVdwNA9PVsL4BJa7jFqte9kGzusxZ
 eeELUFTWEG9YPolxQK6RMh/SCDoHQCHCmd93OKu2TPEubelsyRk48orG7KFTk9x4gra+
 MRNw5uDY1V57K/QsZC6x31vFUTkUHKqmgAJol2lkyb6/+oaCgG0Q1ZUE8H9kOmTgDKnl
 EBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738864048; x=1739468848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSmxV1ScoJXs7z0KqNQ+7RFQYS/mpWtXU/9WFsEVWiU=;
 b=kGkits+QWL1UigH9sg7wrDh4oiWXcrjbVd0RjKRy9QWX/aclbV3kmT/URrBIFoaBPL
 d3/LOjZAKOCcklFhrCWwkw14cYVKOWBU+G25nRT7IHX9Ay4nkuhK0Z93ttd+W1pPyOeM
 mn44pm3xloXlzSPHvNnMck4tL3ic4jt4y+y5SFA/HjURlhjKD/XNCvElOE9TYAvokEPc
 OT9ruTw0BwghQWnF2iLE4F8QAV8YY3PWVf+8w8HszT81R4FIlCjSAlpAfk5jKeG7Mnal
 fv1XiIC/YD7l99jRdKBVw5xa3pD+fA8b5vumpZzthjArFPBaQYzDZhz+F89iFUOkRuGT
 ZgYQ==
X-Gm-Message-State: AOJu0YwPFbAgsWgRzEfRfhGFyE1KlFtsARPTVXDVjSwpKhHcxAiMTRZU
 SpBahuCOI9QwgWHF2/tL8dLgukT9kCmN9+lo0VVSWfxca37KB0YKWARi114JwAA2yLd79Vk75iE
 c
X-Gm-Gg: ASbGnctP2mKEhzXOG9jz8p9tYzx4euq/s+sZIYx7COj7df/kolaZSchZzis3bVyKKOX
 jahrjx8Nqv0UFUMGZaoRp9mlfJCg9HvLKlMI5G3NskDR9QQwl8BQ87y0oRmDJ/TlvZ6/BiZcxhP
 G5vBzAlBjVQ47hJLWgdfGDLTcG1xWHngPX8mv4Vmd1i6qV5M5MMbO+0XRiC8qndylYumtlsSYxG
 kcXSzhxVwbSEmwCtOKv8dvIojzGpsTF2Pw5V1qjsSiPocollWN7SB015Y5zCx4YkR6DAG7HJeQz
 KmhlEqMew3993lFtgC6Vc5uhNHiVj6Q+IVNWqep/N1+plowzJkU876E=
X-Google-Smtp-Source: AGHT+IHZbn++HBmWgbDGPMMZLM3CVd3OCalMUs9XBA5VhosR3Pyj5SrkXagCWeqLB/2MxmyHLIKUaw==
X-Received: by 2002:a17:902:cecf:b0:216:410d:4c67 with SMTP id
 d9443c01a7336-21f17edf13dmr124716245ad.41.1738864048157; 
 Thu, 06 Feb 2025 09:47:28 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51aee5ca8sm1391664a12.43.2025.02.06.09.47.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:47:27 -0800 (PST)
Message-ID: <7f6fc0ae-6cdd-4996-b411-762019efb003@linaro.org>
Date: Thu, 6 Feb 2025 09:47:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore: Inline TARGET_LONG_BITS in
 decode_rr_logical_shift()
To: qemu-devel@nongnu.org
References: <20250206173258.36624-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206173258.36624-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/6/25 09:32, Philippe Mathieu-Daudé wrote:
> We only support 32-bit TriCore architecture.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 6819b776686..c5b783b6a70 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -5936,7 +5936,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
>           break;
>       case OPC2_32_RR_CLO:
>           tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
> -        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
> +        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 32);
>           break;
>       case OPC2_32_RR_CLO_H:
>           gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
> @@ -5948,7 +5948,7 @@ static void decode_rr_logical_shift(DisasContext *ctx)
>           gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
>           break;
>       case OPC2_32_RR_CLZ:
> -        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
> +        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 32);
>           break;
>       case OPC2_32_RR_CLZ_H:
>           gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);

Leave it alone unless you swap /_tl/_i32/ ?


r~


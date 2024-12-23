Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BC8E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 15:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPkA4-0007a7-0B; Mon, 23 Dec 2024 10:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPkA2-0007Zi-Eh
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 10:15:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPkA0-0004us-SJ
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 10:15:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165cb60719so39961575ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 07:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734966955; x=1735571755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZcKkG06oo2IU0OUKRqystjJFEdaFtyLbFKkSptuE2o=;
 b=wwFm6poLyk9mwORkaBst4dzSkGrJvzF0DhNdSulw3a3p3mhg/1c3C2CymBTnn/yYsx
 TTVQEV/3FZf8B5oBb5Nx5AHCtoMTFGuvIFzYqttRlnYrDqMxUbrD+z2mSLgvbfqCoSZD
 q6K2dcWW3LwKJolkA8JEAAEGO8bd/je3gNzoxlUCo6Bie58FEQMszJNpWa4uttIxU476
 5MtDz9ulHZibH24LIIHVpcvCFL9eaNidr6aMDANllMv1wgg1f8X+BwSOXuENM02sIWlI
 Ybc5whxorw2xpMfWmG9MhmI2czp6Nn3NJEgI0qzFK2wlrmxPUrkluY+iYSev0UtpXhJP
 M8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734966955; x=1735571755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZcKkG06oo2IU0OUKRqystjJFEdaFtyLbFKkSptuE2o=;
 b=khZPEira8MbYXw0PPxlRKEiuTjDwgLwWEhHI866wKmzpgmO79K0a6nci1hQMpMzq3/
 F3cEwXzmR9Gibt29aSvAv2nCDFTARh/Iw5XUttWrveJf9M++XxISwkozOGd9jYoUO+4J
 LDMXfN6vfVC4CGEyGqnV3ezWwbHguylF40Rh4ayxeS1QtxjNdLyqq7kAsU7K02PeepSA
 axbzFienT7/CBpWKmCgYjPRD0QZIsrWB4ypANN6G2L1DVgbvF1FoA5iwj+GLhUpxylez
 IiqzK+/Z0Summi2ttuPDC+vF9ChvsS/bzHD4NerE0uVSdpGGv8iKyue4VcuqGHtXwE8m
 GuxQ==
X-Gm-Message-State: AOJu0Yydu9VYdl4IgHeOoS6mLqwlAkoNRzE+ZgNHrsmzigt+8bbUKiEU
 L04J5nDlUCVOnZuzOVA2v4p5GA9MpdpBaD8miBzPNxbLV7fRHQ+0dgnquzrd1RyoLOgw+fJikj9
 wZp4=
X-Gm-Gg: ASbGncvSE2KjpP0TdIDLhGxffQOx+xRkfB/2bzvT69WP6z5TKCRC6X2hH7ckkuu2nxU
 9VJr6Ug5YVPyj3zTyuFK52KHfbtrWa+bTvmEHg/OM4n3v8QQ6RXSNhzn893a5YvUhXkZmTVS73X
 ZJl8iVyhTMR7F3odEa8iKGo27whJEsxkcW3GOW1uczWrBzz0yETc68zPHoSLmngeznUxeiUd+/w
 Mtw6/f5TXrl5qWcFbG+oKaGR7wHSDS+8LG9joXNNaQDb6t9uymW8kUM0Tjgn7RwlS7VMx0=
X-Google-Smtp-Source: AGHT+IFIWsGOe5qbd9iW7ajLpZQx1FGeg5Y9dmFzlJSmI6D/yYXv94faQh32W3b2OR8Nj4PmMjCjCw==
X-Received: by 2002:a17:90b:54c3:b0:2ee:8439:dc8 with SMTP id
 98e67ed59e1d1-2f452ee6374mr17809549a91.34.1734966954740; 
 Mon, 23 Dec 2024 07:15:54 -0800 (PST)
Received: from [192.168.0.4] ([71.212.144.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477ec656sm8541547a91.30.2024.12.23.07.15.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 07:15:54 -0800 (PST)
Message-ID: <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
Date: Mon, 23 Dec 2024 07:15:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
To: qemu-devel@nongnu.org
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 12/22/24 15:40, Jiaxun Yang wrote:
> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv t0 = make_address_i(ctx, src1, a->imm);
...
> @@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       TCGLabel *l1 = gen_new_label();
>       TCGLabel *done = gen_new_label();
>   
> -    tcg_gen_addi_tl(t0, src1, a->imm);
> +    tcg_gen_mov_tl(t0, src1);
> +    t0 = make_address_i(ctx, t0, a->imm);

The move before make_address_i is not required.
See the similar code just above in gen_ll.


r~


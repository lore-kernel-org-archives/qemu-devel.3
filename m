Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CC8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSzR-0007BG-AX; Tue, 19 Mar 2024 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSzL-0006zj-Q4
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:30:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSz9-0005jb-NG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:30:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41462295004so4624455e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829804; x=1711434604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NEjIFZVV3ii3gf3KrdfEzBc3OBydYvxiLMF1DGBiN20=;
 b=vY45Qe8ycrOMHkwjEXa4POD0++0GeaTnIqppT9w4gURrB3VSBSywg/l7dnccdh8J5n
 Lxf/3SkWndJCfuAxkUDZph6J2DkqCW13i4NwgBkckggL+mrFlUV/St5F/lmUwEt/UWGx
 WaHJgln/v+QGMcENOGBytOik7QXxMBt5d9ef1JHXa5nnD+cTPUNYcWuJBpPsyJgxvk5z
 /9M+4cSJF0+w1m10VnTwywjXsPAuTLiMbaO1+XRkVBx+KpVBDykpPmt0HxPymrr0Jttc
 iuv+jmZhGCSyD/E61HrNl8lfJ6rVCHPsN5sfAeVDknClmDr/zsGo9qwul5eRbxz4L3ej
 VdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829804; x=1711434604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NEjIFZVV3ii3gf3KrdfEzBc3OBydYvxiLMF1DGBiN20=;
 b=ID//joZip1GP87gZy3kq7QqZUTHkwNyWhubf1Ua2AMjEhRUZoxHdxc2gS60GPoach3
 VSE2XKq/X25vj5P5XcVBkiYYxzc2rBY1iBkmCGbJnohFakSiOyCPtTZ7uaHVwrejQpqQ
 GNq5hUpkCyr29yKwL2WuGZd3pLwwhdYX3xIJuxM1WOU0NnKRHCaPuY/r8OHPJW5rI+35
 V750hMST9hyE6S2iR0W1gt9uWSb+ZbMPxYbSjIrRK+PgE11UQkxN5CaF3QaUial6E/JC
 A9WV525GTelPdCVgZ9Eep0IcVp9NsR54ff8Smik1W51WdfiVQ9Qr2ano6Rx8BmFp+cH4
 rq7g==
X-Gm-Message-State: AOJu0YyAdpBd3rijSu8t7poQb3/Bs9wrjGP9A+mKX4JHRxEf6VaBRjeb
 3je2im6qQqKvOQ7V3U2nI3kPRWN3vuHn8NJpSxIKIqGUwYPpfhKdB7cn5SvUEEua5cpSh3fzU6d
 u
X-Google-Smtp-Source: AGHT+IEmOS/8ngU7S5R9IZKSkRMbWQtAWf1xNM20onldg5oD9PShbaJNl0zVMFQlHX9r5v5PJfU6Ww==
X-Received: by 2002:a05:600c:350f:b0:414:6391:6afb with SMTP id
 h15-20020a05600c350f00b0041463916afbmr662601wmq.10.1710829804064; 
 Mon, 18 Mar 2024 23:30:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a05600c470f00b004128fa77216sm20446328wmo.1.2024.03.18.23.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 23:30:03 -0700 (PDT)
Message-ID: <5f94eca5-8606-43d4-8599-89316d951e7e@linaro.org>
Date: Tue, 19 Mar 2024 07:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/mmu-radix64: Use correct string format in
 walk_tree()
Content-Language: en-US
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leandro Lupori <leandro.lupori@eldorado.org.br>
References: <20240319051021.6752-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319051021.6752-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

+Anton

On 19/3/24 06:10, Philippe Mathieu-Daudé wrote:
> 'mask', 'nlb' and 'base_addr' are all uin64_t types.
> Use the corresponding PRIx64 format.
> 
> Fixes: d2066bc50d ("target/ppc: Check page dir/table base alignment")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/mmu-radix64.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 5823e039e6..690dff7a49 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -300,8 +300,8 @@ static int ppc_radix64_next_level(AddressSpace *as, vaddr eaddr,
>   
>           if (nlb & mask) {
>               qemu_log_mask(LOG_GUEST_ERROR,
> -                "%s: misaligned page dir/table base: 0x"TARGET_FMT_lx
> -                " page dir size: 0x"TARGET_FMT_lx"\n",
> +                "%s: misaligned page dir/table base: 0x%" PRIx64
> +                " page dir size: 0x%" PRIx64 "\n",
>                   __func__, nlb, mask + 1);
>               nlb &= ~mask;
>           }
> @@ -324,8 +324,8 @@ static int ppc_radix64_walk_tree(AddressSpace *as, vaddr eaddr,
>   
>       if (base_addr & mask) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -            "%s: misaligned page dir base: 0x"TARGET_FMT_lx
> -            " page dir size: 0x"TARGET_FMT_lx"\n",
> +            "%s: misaligned page dir base: 0x%" PRIx64
> +            " page dir size: 0x%" PRIx64 "\n",
>               __func__, base_addr, mask + 1);
>           base_addr &= ~mask;
>       }



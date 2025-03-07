Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F713C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaB7-0006QM-DF; Fri, 07 Mar 2025 11:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqaB4-0006Ic-W5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:03:59 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqaB3-0003IF-36
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:03:58 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fe9759e5c1so3167453a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741363435; x=1741968235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDEEKDVxxv3vHaj62SY+tCHyHLLGbBZRDfqqL8b4a7s=;
 b=TP2uM8xvsdBXau+9YNOoR3Tt688PTjh25S0tdo0LhPBrcZmnHaxpfEM+jC1+42WxYI
 AjNmRv+c7wEABQbKeVzs/L3e5RUwd2Zwtgzm41gIRO4/Eygrka3pqiIUEGJmJo2UFdyd
 v7PN96e/tgYRafm0iyCEe675+CSiJFdYgkLvtjixvsKJRgrgCvvuUrlp/XiqdAFJ5Kmt
 hDJXBeaMmftpDn/HKVxnvE1Ph1mDs7WN9yo/ulI+bI51XBQ9RkUkVLrYurngsu+NwjUo
 aGpIVxo71qy4odF7eraUmfEMPBoXCeYwlugNO7fDuaHJxlCu7oyeyz19t6C7EfleKYMg
 vsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363435; x=1741968235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDEEKDVxxv3vHaj62SY+tCHyHLLGbBZRDfqqL8b4a7s=;
 b=gpLwjHAyAWs2n7HMJCIfFaqW7YKr5Sr5V7nOkCF4RsTIVmJ1NmBvF6lgxtqo0wJC2Q
 h6SMd110NCmNdkU6TRI/7h5J0sjgXU/c7iCZQMygasAoWrlcGjbOYtsWBm8RlIi97Qmu
 dOVCp9ck2zHy1wneY30IMhXjVdZ8L9GQxfyyQjttkpNyLy1+Xbqi4fGvRmrxGRtSnOrj
 uDA7B4H3ozb+gNEpjgGUnHyeit5RhkfULHRwvCuwJgN6kfSMBV/ylxPmFy5iYcP1Kn2B
 OMlq2AzM9/ZiZ2Hqdr4Tbbg5tpKweH78xz4dbrak91C8c8MTPENDQrLL1yirHa2xlrZa
 AIdw==
X-Gm-Message-State: AOJu0YxV2QJ11JrHLk8K7hkcSj6uy/JGFUC8BdlU84JUhKBLReRJ8/K/
 K68tSxTjAwcgulwpwOn4WtRbYuEr/73Tl2OMgNRZj8kWCv9vRkmO0WLKQ62XCCqNHltPgJPQNu/
 y
X-Gm-Gg: ASbGncu73XFWzplwQ+DJftrfR/KOZZDu0MkjFqNVALsmY1yFRQubvYoOg9rfruuyeRT
 PveiY52qzh57Ba/zlwvX2QONErWyDcaDEu2FWzOIRCEmv7vacwc4bUiaKNeqe3FKSZ5aHb86dGs
 sPvHUVolZUT4shehU36oidtxXAw6+UkBuzc55QPlHASvVuxvt6lGSgjOyC4fMDmrmygA4RJ8erE
 sVhK6oAYCssPOWsmMwDio+mhTTcM7Y0JPnDA7bv8TR/668M/Qk5ZuHnZa7OAXhv5tlvUKNysXwY
 wDRAZCyxj/05rlqD+XMrncP0Qu4+2LVCdatq+skDmQefzyX64IzpsqntHGx8oOlqZqGR43CJREn
 iMil4nB3YTTUG3DAYtNEdmO/iP9U=
X-Google-Smtp-Source: AGHT+IGviBfJClGmUtN6+lDWjllOzYxtIMhLHXIMU/Y7DFhMF/VKZjZpLK1Cska5i6XZxLrRw8Q/ZQ==
X-Received: by 2002:a17:90b:1b0b:b0:2fa:e9b:33b8 with SMTP id
 98e67ed59e1d1-2ff7ce989dcmr7104642a91.18.1741363434883; 
 Fri, 07 Mar 2025 08:03:54 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:4c05:eee0:848:a879:417f?
 ([2607:fb91:1ec0:4c05:eee0:848:a879:417f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e75ed71sm5117113a91.2.2025.03.07.08.03.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:03:54 -0800 (PST)
Message-ID: <ebe5736b-7903-4763-8c4f-48a697b27df2@linaro.org>
Date: Fri, 7 Mar 2025 08:03:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
To: qemu-devel@nongnu.org
References: <20250307130951.4816-1-philmd@linaro.org>
 <20250307130951.4816-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307130951.4816-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/7/25 05:09, Philippe Mathieu-Daudé wrote:
> Massage target_mmap(): calculate alignment once, then
> unconditionally call mmap_find_vma_aligned().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/mmap.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 346f2cefd32..28d7e387a20 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -489,13 +489,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>        * before we truncate the length for mapping files below.
>        */
>       if (!(flags & MAP_FIXED)) {
> +        abi_ulong alignment = 0;
> +
>           host_len = len + offset - host_offset;
>           host_len = HOST_PAGE_ALIGN(host_len);
> -        if ((flags & MAP_ALIGNMENT_MASK) != 0)
> -            start = mmap_find_vma_aligned(real_start, host_len,
> -                (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
> -        else
> -            start = mmap_find_vma(real_start, host_len);
> +        if ((flags & MAP_ALIGNMENT_MASK) != 0) {
> +            alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
> +        }

No need for the if -- (0 & mask) >> shift == 0.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


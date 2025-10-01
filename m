Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCE0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rRx-00087N-I3; Wed, 01 Oct 2025 03:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rRp-0007w3-FU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:40:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rRW-0007GT-Ej
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:40:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4655303f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304395; x=1759909195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/PqkHiitfwGnP7fyZ0sCwBuwXOLvqqLRPDt5G2B5qM=;
 b=RytgUlwAWH6PPZVkrsBhA61Wh5rJTpvsJkgn5DLk2RtLgEuaU5ni0o/UcwIgPlEgB8
 aH9+eK04b9PUs+7c+Fb+OHx1hwbLw//DD/9rBe0L49gMpCzQKrucOT3WyIVAPEKy1F/z
 Wb7gSkN8aADtKB/yLll3WgO2N+T95k7640OuR5ORsKjo4QgFVXASwlBJhfbtxn8ONPeB
 lC20nwf8l5S+JGzQ8JiBbJjy9LCSqQdP1mQaegcmiMyRyJcuaU1TIktMsSZu/JphmXpT
 009IFqGBGP0yjr2l2jvATTdlWKqvFd8BKrr8BOasBH7Tf7y8hzl7Xrwcy5lI5DVaFJ9X
 h1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304395; x=1759909195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/PqkHiitfwGnP7fyZ0sCwBuwXOLvqqLRPDt5G2B5qM=;
 b=Y8FdhmYhHaQ96Hi1cMavm8DvYj4+oS2+Ux1IhO+ihJicX+MkmDXvnSP/+5Ogryp1DR
 HGwkSnfsJoeGRX4Iv+WbawbeD9UOitQ8H4m+5D7Og4n1Vo0oZdgnVFfxo6faLNwNywn3
 dPCO59nHyhf6GGlx3qtvedrd1Sw3HGpmVc9tWR1i9D+QIo7Cj5x3+cCIDPPecoGocQT9
 7B8Uu6nRZ+PjVWtZNh3YXOyCeX2Eb4kH8bqnBN60lAOeLtVMHq0mWlDoF+YWM9BSaFAn
 J07laFm3KQa9IYeG7wc7Y+te7QjerTpsWuf6oWhc70vAQjW+47JpZYqNJKjMS0aY+j5h
 ac3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaox0l3qe1ypW/z7RcQ78+ikg5QBzuZ4qGNbL8WcgQ8bui/nSX4vcTuGhRzFBkVB+ImRfbJFTh4ImW@nongnu.org
X-Gm-Message-State: AOJu0YySMkaAzDzHOWI9jqlb0RPAGIq7aDLDnuJkU3BOLPD41AjSzAUm
 0aHTesF63Jc3AjVucwo0megLgK3nnCzrWs5evg4ryrWjgxjdG2q/n6gF/YaSyYeL0AA=
X-Gm-Gg: ASbGncvfW02R+BZd1aHKrg0w+F8ZTuhX8hSBzjoOJuEWPhFF/19A9cifnLtgH8yCYkI
 SjkYHmKaWaI12QV/XaqxoFrX1Zc+WevokOKz/qSut72oGE2bDBuC4gxmubGyS4Xb2VpsziEab/g
 m+4sv8nSbnrrcBV/vwTqcCWzYQ2K1hit5/NmXM2Oik16jQpdhSPbaEVYmIsasu0eedhPzkEOaUa
 D8ZXUWToh3yMLjsBR2z8SQGRXkfLdeT1jpL98M7x0TY1LXAFiMd47Dg5rjNc2ihUpPY53PkLJne
 GyU7bJSv/4j5al3y+1xbTjLFGOzdNaZj6B31ZItrk9n4lSTN9vhiRj1CHEEoyFV67ji/q/nZDBN
 slxYCVDjolRQlxPUXTb/3XaKurd7crVtDDGBddHdk6/S+SwvriQpyY4RWbdUoKQ0Nz7BGMXAtOc
 y15AzLAvIagGbKXg2wfUck+Pan
X-Google-Smtp-Source: AGHT+IHqVfwmzofqwCB8DhD2FfptrnPA3enxurI1OGfpMBse/0S0Ko61boREs4WQwPWlyzGg/UF9eA==
X-Received: by 2002:a05:6000:3105:b0:3ec:3d75:1330 with SMTP id
 ffacd0b85a97d-4255781b091mr1625344f8f.52.1759304395417; 
 Wed, 01 Oct 2025 00:39:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm26433589f8f.49.2025.10.01.00.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:39:54 -0700 (PDT)
Message-ID: <84c9b930-5f93-4175-9605-a67054187079@linaro.org>
Date: Wed, 1 Oct 2025 09:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 1/10/25 09:32, Anton Johansson wrote:
> According to version 20250508 of the privileged specification,
> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
> when XLEN == 32 and accesses the top 32 bits of the 64-bit
> mhpmeventn registers. Combine the two arrays of target_ulong
> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
> 
> This also allows for some minor code simplification where branches
> handling either mhpmeventh[] or mhpmevent[] could be combined.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     | 10 +++----
>   target/riscv/csr.c     | 67 +++++++++++++++---------------------------
>   target/riscv/machine.c |  3 +-
>   target/riscv/pmu.c     | 53 ++++++++-------------------------
>   4 files changed, 42 insertions(+), 91 deletions(-)


> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 328fb674e1..d9939489e1 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -452,8 +452,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>           VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
>                                vmstate_pmu_ctr_state, PMUCTRState),
> -        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
> -        VMSTATE_UINTTL_ARRAY(env.mhpmeventh_val, RISCVCPU, RV_MAX_MHPMEVENTS),
> +        VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),

Each time you change a VMStateDescription structure you need to bump its
version.


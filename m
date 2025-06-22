Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E4BC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTARx-0001rm-2z; Sat, 21 Jun 2025 22:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTARu-0001rY-T7
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:28:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTARt-0003k8-Ci
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:28:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23508d30142so42064215ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559327; x=1751164127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cfeqs5UnoPL80Uh63jRSlgdUAixnsU7DKdhMBaP1EIo=;
 b=SNordKKoSNAtiZrJb/Di+NFC0y/K6yjpROTgJVZn0+XpL6byHRpq6HqNNIATnVCPpw
 JvBeLGGjqYSuTF+ujcFexqNnzc9CLPj7+V6ViHWVGiSRtxuY+yxPV8Ljp7AvfSa8aXL/
 5pEkfJaFLOKrgcZuXi8kDwzZav3qXPXj0dGFzuBp1t6odLev3AO+Ac0fzrJzw1QuZgtk
 aePqgERvMhaa+4Sv6dFSK5BpctpgKOJuRgBMcajr0Stu9WzuNBmF/7Fnl6yOERbAV0lg
 PH/D/kwZQHU6AqnXjE0iMKpLOZ0btoayYnRblCHGr2Jz8tzYsl7UzSn79s8BP60VKxnI
 1VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559327; x=1751164127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfeqs5UnoPL80Uh63jRSlgdUAixnsU7DKdhMBaP1EIo=;
 b=b6gGtfUBAJaYKJmKX7HjZOvBlVDZ+6GSZp4l991ksslCt90QUTTNdvUq4BA/hanABa
 Ch5GKh+OkTlYJ4NQxz0wSzEbG/tV3EEBMj0pcFa3ZY0aC1BXL+6Osl7ZSQetPoTbNkjA
 /lx2S62tv8hRDADdKkW65CvDelSbZCMlttO8N1b7VgLJISt2OR504NL3S5qob5wGjPAB
 o3GsJJZdIMsdHfwF1umnkwFo//nbmzqFGQ80pNubU30swwrnu6eSlnLX1dyswGDRkxLO
 nTqNhca00u51mhBZLwrVjvPbbpEfDEtj8tTADY6h690th4nm76CUTsS3IeYLpv57jLD3
 p7Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsVp/VlPeDFkBET4pp1VqDwM4l1jvMIfYQZDbvKTes3H7bws84uEd4gTVwZEVfC2Gl4jpb3RwYxseo@nongnu.org
X-Gm-Message-State: AOJu0YySlmhMo3knLn0gwESU2zxMivCt+0GFojxJgUjszOmxsetlB6YP
 So1QkHJOMz3rCaI/ublLvW1MgXrjnj41tANvHUnPa7YunIQCyhugdSowlgunM8NPpGw=
X-Gm-Gg: ASbGncuh0LIZo+/PEhanuDNRWAYaF27SEh/sktGsrB2TA5pfSjZsjaX9g6YGA735syC
 jvoopMZNuU6hxvzbIAY44muO2PI1hVdNf4bAQP6pmikwlnPk1Nyi8qV5e0hQ5aj56MQTPC+iXTQ
 eZd6ETHMGxMuvftUCpURfHyukd7YJ0UolY3FTcB32fuEh++W6K6yhdE2jLfc4JQvbbkaOgX+WvX
 P6eKee/z/qJIIYT1vHMMoqBDTMxThcrflD/qEdfi2J57ndJ3kc1qVs7ype36fslTBrqQ0OMPQqn
 WnQhXotoz291WxSLvDESN9lgLP3ENNYBeYb7dU1ze+bAT45fHut99RogRt7j8kY25CpXpelPC3M
 YXaFvVs5oSyaf9NYPbg4x/kv4inN6YM9mTsK2x4c=
X-Google-Smtp-Source: AGHT+IHahm9/74zGOKZzT8C+25/cqpGiYh5+pwyd54H/zEfjsm0WiDJtFoG8UGdkg4iB+89M21dHXA==
X-Received: by 2002:a17:903:2389:b0:236:9402:a622 with SMTP id
 d9443c01a7336-237d9a793e5mr124455805ad.34.1750559327551; 
 Sat, 21 Jun 2025 19:28:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d866b5d3sm51281275ad.164.2025.06.21.19.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:28:47 -0700 (PDT)
Message-ID: <141573ab-ebeb-43f9-a98e-774f84608d22@linaro.org>
Date: Sat, 21 Jun 2025 19:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 07/42] accel/split: Implement
 supports_guest_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-all.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-all.c b/accel/split/split-all.c
> index 8b9f8ff77a4..cb910300931 100644
> --- a/accel/split/split-all.c
> +++ b/accel/split/split-all.c
> @@ -61,7 +61,18 @@ static bool split_cpus_are_resettable(AccelState *as)
>   
>   static bool split_supports_guest_debug(AccelState *as)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(as);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +    bool supported = false;
> +
> +    if (hwc->supports_guest_debug) {
> +        supported |= hwc->supports_guest_debug(sas->hw);
> +    }
> +    if (swc->supports_guest_debug) {
> +        supported |= swc->supports_guest_debug(sas->sw);
> +    }
> +    return supported;
>   }
>   
>   static int split_gdbstub_supported_sstep_flags(AccelState *as)

Require both to support debug?  Otherwise support depends on state.


r~


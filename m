Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60B7F9937C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsVA-00078B-5L; Thu, 23 Apr 2026 07:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsUf-0006Vm-36
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:45:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsUc-00069q-N6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:45:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b24fdac394so63364685ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944713; x=1777549513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MczHLxhuOcwSUdIHttHOA1r7HnYO6NFpnnqUMnKb6yM=;
 b=nc10NTU4ts2BiPKAteMSgQsWIzlNqNXllEgjZQ/Vkg3a2xVrt+7QfEakBk57Pppofu
 OhA7G426rLNybMTawhzCwvWG6c5PwZd+hVLIhc6S8D9nDCDgPAIPodmRd/ewGlsNggbA
 jcFUma0dz4pSezigSSpchTulQHAr4ZTHMTCQWN4/SYZwm64ncqTwsz+1a0xnR2KYFFvu
 YLrpI28kUjlOffBYgg+Ek0MA21x4ETTT1SPO7L+p8U0qtUX8R6DEPoQ2g/BstQDABFO+
 vPFzs+lNnI03L7sBx7xErDYFt2liLfU3jFdk566yqD2bGfrSKIhLajjpXDTgU57jjWcr
 Nrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944713; x=1777549513;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MczHLxhuOcwSUdIHttHOA1r7HnYO6NFpnnqUMnKb6yM=;
 b=qkB2TxbCWhVJPO/DtfiGkf+PMKRCjzmmOx57UslHNuj5TKw+Dw8nO/Qfil+MQDo3X/
 DGyw0/MSF7r1+wZ1eKQPr4lPCmn5ta1cyjaKG80XzihVsR2l8KIL7v+3YtmcEnHowdR+
 ALrlaJKtOtgby5FI/ePhuDx/+1BejNhEBbPiB1HaQQoGQhvLDsO4MMSRD72kWGJ5PPhg
 Rdvv/t7vSka63HGUXSHDTqoMtYDsDVk14kcR0QrTZc+R+ckdt62ZSjqnq/gCVR2LbZGi
 6Qg42q7MxFKBXnUQr5PXoav9USnWNMReXaQdDmH93JVMYV6z+oHElhzF3AF1n0LV0xRn
 hPlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jbELizO6MzsrpP5WLF6UKUa6v6vu/G3wzxWnSorCqiIvNImpmXsmHl64MgnV6efww37Vly7DJMv/w@nongnu.org
X-Gm-Message-State: AOJu0YxLoLQsotkFQnmzWuKI25quxvw5Q/TI8aZw5tNWXxKHSwCeWk37
 wOUpBRQOYlqlsgFb9vyhMx9XPraU9Qe9qOUbsmwvN8gCiA2B/IrmRi1hXK8IMZI0898=
X-Gm-Gg: AeBDiesa9CVFWpEFAXvPtbruqAg4RUPK436kD8eM+msM42N2Q3Oy74RGMmTFdz+6JoZ
 lN74QVZtgHkFCz+rJ50EbTrvB9gXZq/pBPS79toRWg6coVvn5M9HgqJRQvP8/650RUMbicZXA+f
 US4/Mm0bbPZeeTlKjoQkGj3rAa8RxbzxD6JZqGYbWeU7Mnumckg2XH9S1/U8c89QxlNC2/G983U
 UR2pf7u1JSeI94ZG/AkR9FmYXFvadQ6E4t7zVprYYoe3aXO7YSXrPEhGIc/SeTdVYjrd/Trg8Ur
 KFecnWTGNn/YLB5lOlBmbsQJMKv+nzYWBbZDzIjm7j8fzrP95YXwO1ZSA/V5z6ByRoX12eEcZsZ
 /cjwvPvmFZzySOxMY7QtNOo44BCfqluXkZsmB2UnVUpiAzBshbX8pq2gD9NjkXRWmbG7fvLftW3
 WOyJUNyLVwm6AmLrdxTMUrZqITh4d/qMP2SIrgnSA+ZXHneN+80w==
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id
 d9443c01a7336-2b79ed0505amr31090975ad.32.1776944712962; 
 Thu, 23 Apr 2026 04:45:12 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0d0f8sm181138375ad.47.2026.04.23.04.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:45:12 -0700 (PDT)
Message-ID: <271f2665-7d03-47f9-b795-23ae1d44340d@linaro.org>
Date: Thu, 23 Apr 2026 21:45:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/microblaze: Replace translator_ldl_swap() ->
 translator_ldl_end()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the microblaze targets, using mo_endian(ctx) --
> which we introduced in commit 2c9e8ddd7699 -- instead of MO_TE.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/cpu.h       | 7 -------
>   target/microblaze/translate.c | 4 ++--
>   2 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


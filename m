Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D6AC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhtt-0002aj-SJ; Sat, 25 Jan 2025 10:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhtr-0002aN-Vj
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:16:44 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhtq-0002dC-Bg
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:16:43 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216728b1836so49229245ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818201; x=1738423001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=An+sE9DBoYYw7anO33hCPsD9R9Njhppr8J8h2EWtSJY=;
 b=F44Q0Sw4lNXuq6qvQsNyFZIg+AcaXiS/V5yqcDchX2/u6DAhZn8r7wd9UCvuIbUb8W
 HwNeoZbsZQiKaAmb99VrJFOy543d31OJJJB3mGfWZ/C1IuqtV7ZWLX1Ow8OoJOVfxb+F
 UesPi3NzZ77ix3cI0TIpDYQ68H0SwbBFec53jxQ7wcyyKSVCbH8ftGJJfoJtlhutSgKw
 RNYglDl/TogxmN8kgN4RynUgQ5cPhLfqpkM51BaL7T3elELnJmVoDjRN9k+VJuMLIih/
 0LNYzZ3zfsiCj308SEVjeSqyeDMiy9sLZj9vJflIlXs7gQV36xWViTGFyhlBiIjL7Rr4
 6+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818201; x=1738423001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=An+sE9DBoYYw7anO33hCPsD9R9Njhppr8J8h2EWtSJY=;
 b=hMpJrvbJxhWxR+3aM/QxMC6vctxD35cCp2hi4HiNIsULA1ca02VMuAfTQ9jCQpNgBc
 IlGDz906SQ1aKGpybchN0B8w0RkLvt6aYqjmJlVzriQguKxgTIC2ryfqo5Exyk5RoM8P
 ngq71e22cP2RLPct6gCsW3MXYU8IHWhcTk7E7GvitOjSqjFJ36XhiOLAIomq92R373DI
 YHoZppL21g6qmV4tRMcYCc4qJM3SgL8mGsPMJTvN1RizhqfhN/PtWPC58t9frHqIdWmJ
 j5CFvAQ9UbGBGXrAWPdFcyhKfrjMn9eev4epVLmG6zjb8xi8UPJtO9922XjQzckEf5Wn
 Y71g==
X-Gm-Message-State: AOJu0Ywz81EoGop+uvUmhbVdogwlvB1nTGbQxU+9pApIIBExZLxcfuyJ
 rWB8Jgo1MI47E/LhSloRqtUI47fI6DU5Bk71Hi3y7Xp8nhxI2wiufjrRP7BRZob9Cgy+IBpP2Ef
 W
X-Gm-Gg: ASbGnct0wxIM1a2XrL/qPmh+hTWL5nkDMuiLLS3Yn+7XVtyZa1xTmLAsBCAzOOyDGR/
 JQ1fKlttEVcMAkZWdGeVF5KEW/0Eh83SH9/JiiLRWq3qaZ6BpVLGlkBkYunT63pV3aikcYO4Nk8
 R6D9HgZpo/OOfzQgcKle4fPKz9CKqhMXK8eojorPukzVroV+y/UWb9ngxQrtuBLYbuLUMAFO1mW
 uKqrwcZXPKr39CReilaqFGPm4TKEmoP6l0pc5ZG6mM/ZpRlHROUYz+aVFNaODvnWg+zQCuDZn8y
 iN8Y3PWqn3O3sgmHiE3l6A==
X-Google-Smtp-Source: AGHT+IEwBUcVB3vXwIitt0Y5m+nr6KWCqFGUOYHMJ6JStlhYyCJZ5Fj8j1etHRXcph/iQJftOZSzQQ==
X-Received: by 2002:a05:6a00:13a0:b0:72d:9ec5:922 with SMTP id
 d2e1a72fcca58-72dafbf04f5mr51510000b3a.24.1737818200796; 
 Sat, 25 Jan 2025 07:16:40 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c779sm3899063b3a.145.2025.01.25.07.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:16:40 -0800 (PST)
Message-ID: <49a63d8f-e263-49a9-9da1-5edb9f526637@linaro.org>
Date: Sat, 25 Jan 2025 07:16:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/76] target/arm: Use fp_status_a32 in vjvct helper
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> Use fp_status_a32 in the vjcvt helper function; this is called only
> from the A32/T32 decoder and is not used inside a
> set_rmode/restore_rmode sequence.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index 7475f97e0ce..0671ba3a88b 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -1144,7 +1144,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
>   
>   uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
>   {
> -    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status);
> +    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
>       uint32_t result = pair;
>       uint32_t z = (pair >> 32) == 0;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


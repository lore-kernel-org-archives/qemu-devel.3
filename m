Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED1CC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhH4-0008LM-O5; Tue, 18 Mar 2025 20:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhGQ-0008BV-OV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:26:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhGP-0000nS-5l
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:26:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22622ddcc35so7301775ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742343988; x=1742948788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qq1YeTc9ZNM3CII830y4P3g/MlTvOBGSEWkG+5cSj5M=;
 b=RiwOPIKkEgPNwLLXh92IFzjqO51gcly4eXqRHVSqkVHnekJBr4GF4HF5v7CTCvBtjo
 7zdJGSHTfhRe4WVqkKpnus97Jw0LYOQagVqXIexFsEo23plB/5ZKOy2yed8Ck/ZsXGUB
 9i+Gna8bLuRnP4zBEg22MLCY10KYV24cIaxY7z+S9BBmQQw3ylQ3LQlO8Tqi+zMByX1G
 aDbt2GWAVl5fE+kYdHeDlWKR9cVp9MhZ2YacTpasahDoVn8G/8HnkubYF3cYxhcx6Jts
 QoKgSlxequDmpMsDvxeCYjfm8RKWUh9uZVlIRm1Jf+eedXwC3Ey6axuosg/LbaSqqpPI
 ptCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742343988; x=1742948788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qq1YeTc9ZNM3CII830y4P3g/MlTvOBGSEWkG+5cSj5M=;
 b=Je9o79e1W7ALURFe59KUdMAjCgx2FkKkNgO5IFaWeRzIF2bqHgz+wHvnC0Y+VQ4OuB
 zdz+vy3+ffwRhsJxtahHxuuPNJlf32ZDMyh5URbdBIZSo8kED2hmRZvIXQ5TEkSlaBv8
 /0XY6LBlxNr1dKFkPvsL9t/6Tm40C0Ydp4RPkiZeD3MvFNk+htCOzVemEXl5VkDW+K64
 xBP3R1XkOqTNV0gpP4Ehz+yjEoaqd/WQNeZOcBQmPQr5L2ZKgmJ/7wzb6JwtsbmOx/BR
 buGR1zZPPlK0teyPSQmcENaWYqIWbPJHZbWF0DRf26Pi6onvy/Vo8ksMmPAb/Wlzc+ru
 DMUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy4u646WCFR5OI4BwBOLQwqM8PI1kd5O/aw/wUfon/WgXq8sufblzAYr+rSj6yAtRyHx4nG9ubI5pB@nongnu.org
X-Gm-Message-State: AOJu0Yz5gzXsh6+BqCSaNJ+7lW1nC8sjqU/HOV1Zz10Tsmsct2/El5RV
 9Vd76GR4lQd5DbpyOFEOZ3pk0rFKdxZ38Fi+aiMwy75OjBr1voM4uLCgD2ntGeo=
X-Gm-Gg: ASbGncsly4xMPBa6Vqc2W3sIIbJKH6n1ezvHKLOqbwu5/M5ySlhVf1PBTBtKlhRiVBJ
 jgUoaYgks0zoSCzQF2Att1BTEtAYjUSdSOC+/WxzEhYwyqQnOf6pReAubhKuIFDSyv2+fEvQ8Yf
 megTj21SmYhIxidxf2Ehc5Kx45swJD8nCVXtkqAXphUpjDMH1dHsWaen391BwcPZSa9kjniB/5s
 VAotxSwNAhbl2MrP5xqfMkabJ/9d4fSajLIKSUMtmIkOe1BJJP1UpK4CJH90opWd+hbfQ0r2qGO
 P+6JvspBkldnFHK4Ja+fGMsa+iLWbejOlhZ5ah1L0+2L95uMczb95PU3uQ==
X-Google-Smtp-Source: AGHT+IGxgu/kDapEk/9c8K6CmWrP9PtCgV59Bu+v4Vh3bOPnvVG1rnwh/zrYkQVtbAjTPgwEtg4zGg==
X-Received: by 2002:a17:902:ccca:b0:21f:1549:a55a with SMTP id
 d9443c01a7336-226498280c2mr11113585ad.1.1742343987772; 
 Tue, 18 Mar 2025 17:26:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888414sm101072325ad.21.2025.03.18.17.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:26:27 -0700 (PDT)
Message-ID: <d3aecfb8-f555-4320-ac89-fc3410af90e7@linaro.org>
Date: Tue, 18 Mar 2025 17:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/42] target/mips: Restrict semihosting tests to
 system mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> We do not set CONFIG_SEMIHOSTING in
> configs/targets/mips*-linux-user.mak.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index b207106dd7..47df563e12 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -32,8 +32,10 @@
>   #include "exec/exec-all.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-clock.h"
> -#include "semihosting/semihost.h"
>   #include "fpu_helper.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "semihosting/semihost.h"
> +#endif
>   
>   const char regnames[32][3] = {
>       "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
> @@ -415,12 +417,11 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
>       restore_pamask(env);
>       cs->exception_index = EXCP_NONE;
>   
> +#ifndef CONFIG_USER_ONLY
>       if (semihosting_get_argc()) {
>           /* UHI interface can be used to obtain argc and argv */
>           env->active_tc.gpr[4] = -1;
>       }
> -
> -#ifndef CONFIG_USER_ONLY
>       if (kvm_enabled()) {
>           kvm_mips_reset_vcpu(cpu);
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



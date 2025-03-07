Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4171DC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd9G-0002AL-NA; Fri, 07 Mar 2025 14:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8y-0001oZ-UL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8x-0007Rr-4V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:14:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22185cddbffso63961455ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374837; x=1741979637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXWV7vE88iw6DMUPkIgypcrZAfNYMyplayycjZHA1kw=;
 b=NTrPFF3m+wrxLe01ExX1ztlXse5r2ri5BGlGU1HygVPwZ4w/vsTNZ7hID4NcZsL7uM
 Wpz02napVWY8fccdsRN58m29G1ICoZuivkIntTVkxV4KXm5KbPkMJAA6Of4nV5L7RbbW
 bPM+hQyLHACHjbi5JwW4QxZ2NNlz4YlZWTvtXWq/2MC6WMjyTkC+TZKFVo6yF7jfmV/6
 IOh6IDnRvS1fUeM+Uyeq33//y7GnAB132y/kQiZ7EjxxlH8iBZpYmo2MqZpmVNEb2hVo
 gBm2efiIOEP/d/VDyt0crslJaamarNEt/W9/HSoXdBoB+yPgU8ha0YmATRynjz0i2sSE
 hsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374837; x=1741979637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXWV7vE88iw6DMUPkIgypcrZAfNYMyplayycjZHA1kw=;
 b=AEDIg0FYVGfL5AvGcDAlpTUPZreWYT/H+oFxt0NKQZeAnpIJBWa2GYQR0dbECRYL7Y
 mm1yrFnu+/nYPHlfyodBgfSHWuuunqUbGpgkpm9303bwh2TZSGken6OJC5WgvdM5PFDs
 yWEGmRfSp35Ac1uCSTSpsIjZmkqXDQgMoiGuF/olmnGj2iLM2W07AXlrNq6DQPUT2rZ8
 QSzjpUVkVP2ncNF+gENk/9LOBpIfoVf+oD9n03E5poxvSZa5Gr34zYDIiL/QiXyeulPd
 tAT/lWM07hQHISkz78xVHhT/RbMlZ+BQ9xaImBcrHw2YFWhDYMKrQB8fYDlFv3rfkXFG
 wtdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXD8QCRsU7p2KRWZDAY13SRc2ZQfg6MmbKNqLCKWj/nV1XXwVCuAQUNnMyVAgQY9Lh6HAAlHiX8sWn@nongnu.org
X-Gm-Message-State: AOJu0YyYzQfvei1NN8bwkpKCFTk+N59T89ZaADLQ5ryGKbbYfQgdwL05
 YKPlQ5kypxi0CIMcsS6ppczhNwRBumJVGZLpOOXihoqH4OYERWssJ+rEjEW6Bow=
X-Gm-Gg: ASbGnctzu37HSLGGlXQvALsdf448MEOwgLWdnIpBUt7/0zr/if1Zw9nKqI4gNW+HF7L
 CIcBs0hY21aLS3U6uY5N8alsLWmnxXnvAQKxGauzZTIzWK/F2sZo1pjXaWUnyTA8CMRolu1P7H2
 ySKx6KlvB96avPV0lSCkUp+g7+yeU54JNpt/szFGuCxEuUl7aMhX4QIuFb6j8n8hgJCAxbEEC7D
 Lq9AHm5rf2g6vkfQw5tdoDnlItVGEPIsaF2kCQ5XkatAYJBy/H8vWRfR/KvSuPpWDYjlOsse/Af
 l+ZvOEUvYbtv+EIxFVNcjY0R0K2kpOzSk/5VikfVE2TIEYjNTL7qpxZu7Q==
X-Google-Smtp-Source: AGHT+IGacn4BFSBoyRostO44rwrwqhFEqglhcopclwcAKnTsspqCQoHHK4H58EScFG1Xq8XupbHbcA==
X-Received: by 2002:a05:6a00:2d97:b0:736:5813:8c46 with SMTP id
 d2e1a72fcca58-736bc0a2247mr1011254b3a.8.1741374837335; 
 Fri, 07 Mar 2025 11:13:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f8611sm3747806b3a.98.2025.03.07.11.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:56 -0800 (PST)
Message-ID: <8ebe7ade-2c43-487d-95a6-4395add59aea@linaro.org>
Date: Fri, 7 Mar 2025 11:13:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] accel/tcg: Build tcg-runtime.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.c | 8 ++------
>   accel/tcg/meson.build   | 2 +-
>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 9fa539ad3d..72c4c6bd31 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -23,13 +23,9 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
> -#include "cpu.h"
> +#include "exec/cpu-common.h"
>   #include "exec/helper-proto-common.h"
> -#include "exec/cpu_ldst.h"
> -#include "exec/exec-all.h"
> -#include "disas/disas.h"
> -#include "exec/log.h"
> -#include "tcg/tcg.h"
> +#include "exec/helper-getpc.h"
>   
>   #define HELPER_H  "accel/tcg/tcg-runtime.h"
>   #include "exec/helper-info.c.inc"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 81fb25da5c..411fe28dea 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -1,5 +1,6 @@
>   common_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'cpu-exec-common.c',
> +  'tcg-runtime.c',
>   ))
>   tcg_specific_ss = ss.source_set()
>   tcg_specific_ss.add(files(
> @@ -7,7 +8,6 @@ tcg_specific_ss.add(files(
>     'cpu-exec.c',
>     'tb-maint.c',
>     'tcg-runtime-gvec.c',
> -  'tcg-runtime.c',
>     'translate-all.c',
>     'translator.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



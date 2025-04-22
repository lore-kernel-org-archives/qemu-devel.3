Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A022DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HRU-0003aW-2Z; Tue, 22 Apr 2025 13:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HRR-0003Zd-IO
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:29:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HRP-0006b3-Jk
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:29:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223fd89d036so67630715ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745342990; x=1745947790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bD/8hhikUYra7TMvr+cj7e78H1jxAsD5Br7DhPkuIZA=;
 b=TUQYT60qbqzYwH4w/PzVG7CNj3d7Flz0iCDVHt0qRXzrQLhnk0Wgy1cIEy6VrBbVWh
 xZOXfVaBWWfS1JmB7Gq4iS7xPznk+8dn6M4CIqwtCxEcJhraNRlxWoguVpSH75ZfSWYp
 l3mS6D/WbZnDg+bdGFgslSpIcMmD8e5c3wQaMQwhLq4lFLllkYo4sn5haTQAIuDO6BE9
 Ybw5TKncOH+1KUwN2j6HSLpSsr00J5FQhSDwM+856mPD3F8yBJen48POWtmVRSsKQsI3
 vqU5JaXbzl3gbQYSyjOqoXqw0/OfCfZRH9BKS1Kl5oSZu74u73dIktsTJpZ4kLsulIz3
 DYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745342990; x=1745947790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bD/8hhikUYra7TMvr+cj7e78H1jxAsD5Br7DhPkuIZA=;
 b=glT2Fj+rvLedZ3H9YEYnVrsLzpJeks7Z5oKUUFZJLcDrP5e69ljs9bBA5oG9ztiA3e
 vnJK46G40kxiWwidv33zyxyX2wMKwTcuREUHUv2fPMiOz4hiYLghEp6ysMaCK7d3295H
 oCRG1qASCxcjQS/vTFT0vgjnc+KfDZIi5hD7pFPGTp/+T5FPyzvVc6nd8PRGj173aXZU
 lWc+r3xXjeksnpdVkWU3lfiHmQVPR7VEYMZeeWz3ANWgtxkkXwFt6CWnjsT0ucN4BkyE
 xwBZVsUQcGKMdUzKrV888lraszwbx8kuMh4pY3oC48+pJhWDsl1xN9aSSmayB+KTqT6O
 XoWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNCMaZpw0Aon647bXrRIfkMX4BK3WgDLhc6CCHbRJ85Gb3c0vPt2/okhkGXxCDqV6kFTB14J6pFhU8@nongnu.org
X-Gm-Message-State: AOJu0YyyFrkFsJfTB6g35YLL+YOVOeomO+nF2zS4SNaZDqGLk2bGVeTE
 OmJZ2VCaBIrWj7xxhRh+3uplkglabH7lr79kCiwHUsdU6NdsnjX+TUtii1QUXqI=
X-Gm-Gg: ASbGncvRjnCWbc86/zwtmD0LOtMHOGcALc+GqXk/kS+kBWweA/Xo1QImzkWjyIsGmjk
 /20//esLULYFSO6q1lWhD1V6JDC+JxnB0tOfv7I8dv812TyFxWpLz93zhpoe/AB8hYB37nQcZqT
 jv4wbY0oB6HX0nVOyyVbJaEj9mYfsM5mEUodMLU0thPXfEaHsnizqHwG2oNPiKc8dqkVA4h0NbP
 X9XXUEnqmclEn+wwi8hNFoiKqwzoBM1XgG/BCr7I3+E0ld+wNLeTFoFcCnW1SB/iEa7tlfM4LlX
 wdozwtC++BlHWd4ukpgObY9FwsYMKzOv0jAhvy0Um+DdKs91tGMbMyAnohydZB+dZU604tvEIm1
 vL67/YCQ=
X-Google-Smtp-Source: AGHT+IG2cFJ21XhmqoBxv+btCG/weQCblVSQmwiSM9ST4IuGX7HMOtWeiPeQ+OnF2J7O0BVRHEIdVA==
X-Received: by 2002:a17:903:1aa8:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-22c53285c0amr277737585ad.10.1745342990082; 
 Tue, 22 Apr 2025 10:29:50 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c0857sm9258568b3a.16.2025.04.22.10.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:29:49 -0700 (PDT)
Message-ID: <daaf8c0b-75b5-417d-a86a-3b62b18dd03d@linaro.org>
Date: Tue, 22 Apr 2025 10:29:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 03/19] system/vl: Filter machine list available for
 a particular target binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Binaries can register a QOM type to filter their machines
> by filling their TargetInfo::machine_typename field.
> 
> This can be used by example by main() -> machine_help_func()
> to filter the machines list.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build                     |  1 +
>   include/qemu/target-info-impl.h |  3 +++
>   include/qemu/target-info.h      |  8 ++++++++
>   system/vl.c                     |  3 ++-
>   target-info-qom.c               | 15 +++++++++++++++
>   target-info-stub.c              |  2 ++
>   target-info.c                   |  5 +++++
>   7 files changed, 36 insertions(+), 1 deletion(-)
>   create mode 100644 target-info-qom.c
> 
> diff --git a/meson.build b/meson.build
> index 09b16e2f7ae..a1109b6db3f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
>   specific_ss.add(files('page-target.c', 'page-vary-target.c'))
>   
>   common_ss.add(files('target-info.c'))
> +system_ss.add(files('target-info-qom.c'))
>   specific_ss.add(files('target-info-stub.c'))
>   
>   subdir('backends')
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index c276b84ceca..4ef54c5136a 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -16,6 +16,9 @@ typedef struct TargetInfo {
>       /* runtime equivalent of TARGET_NAME definition */
>       const char *const target_name;
>   
> +    /* QOM typename machines for this binary must implement */
> +    const char *const machine_typename;
> +
>   } TargetInfo;

You don't really want the second 'const' in either of these.

> diff --git a/target-info-qom.c b/target-info-qom.c
> new file mode 100644
> index 00000000000..a6fd8f1d5a3
> --- /dev/null
> +++ b/target-info-qom.c
> @@ -0,0 +1,15 @@
> +/*
> + * QEMU binary/target API (QOM types)
> + *
> + *  Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +static const TypeInfo target_info_types[] = {
> +};
> +
> +DEFINE_TYPES(target_info_types)

Delay this until it's actually used.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


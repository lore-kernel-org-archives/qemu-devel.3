Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60403C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoM3-0001c1-HP; Thu, 13 Jun 2024 13:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHoM1-0001bK-9W
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:35:17 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHoLy-000803-Tz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:35:17 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52bc274f438so1712476e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718300113; x=1718904913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gVi2i17iwFKRNp1HuWOGx0blD5PjqRB1Gkpz7f6aBYo=;
 b=Xo9ukvcs1bojnBQSvIuzbWqYk5pLlI5eHgvh2ssMcJ4h7HajIeoe4L6gS7bkuljroV
 132MrTHFCeiJgX+EnFNz/JpRVij2juVH4Zhf1pzcF5u8EVajzwEiM4mLuTOx7twfMZj9
 I1dgDhsKkjUbguF0b3mrAk5lt5Li6Ohnzj4nfASmrhgUd7aPLSeMt78qDpwMx+Dd9qQp
 sJucb4rYBnSsk9rNBytRrWXFoWLA2pYT+aFnWrhRtrmRr0PPV7Eng6XvjaxlbEhLJCp4
 BUNxtS1qxAZqkfmuttyMOu2IibCL6Bhl/x9O/bvr1HAGInGX7aiosuIrm9RAos3C82CZ
 RKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718300113; x=1718904913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gVi2i17iwFKRNp1HuWOGx0blD5PjqRB1Gkpz7f6aBYo=;
 b=Op8VScOnj7HGEwKXMqNkNVgkArVws1Lr4Fx3LiERibE3fsteqMjYjTyHKqJgd/fgXv
 iTGqRO6aQ1YMu4do0yO+Rn0FGT+Xi+ehAFjQlHTi3gDrMIv5cGEWT6WZMmLwgxzarcaW
 X5iNvgJwxm4AeZevz61Y24LHHl74E9aCAtSiWskpzdNg3570cGQFW/YQ9cRfBztPytHm
 jf9sP2m8caUcrqcAR8JNh85gvQTOXzerj5agh7tDoT8WhUoY2Ck265Jku/ZF+xD7YzkU
 4hwdzQRC5NMcG52cdltqps6TF41MKl0M5SDTRff3ac1lt2iFM8BDhFFDxnbAvkDMkPli
 yHNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtIWbs/aM3bTaEU6cSFDCexDEdyAo3dD02UIZCgOVpIUYG+8JcvBe3S8l7ynayjg89mhMyfjJ9WthRaMQrxz4fKLNydE=
X-Gm-Message-State: AOJu0YwQK+skg2vQQH5/K9psEbMvbPVm2/Vru+8Z60kmMdAbhoJnEmub
 AifQW57CCNz9A8frG8jAMP+xRH9M4BMWCCDWeYoQMm3oGvo61fL4JNGcmCGOJ84=
X-Google-Smtp-Source: AGHT+IEtlyvkBEj/5mvqweuUYJMEhdWhta2wJxyNLabmdhxMlbwBPyHM8uYRMlJrgFqe3FVEWkjQyA==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id
 2adb3069b0e04-52ca6e64378mr269371e87.17.1718300112959; 
 Thu, 13 Jun 2024 10:35:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36074e0e5adsm2332186f8f.0.2024.06.13.10.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 10:35:12 -0700 (PDT)
Message-ID: <20996ca9-9feb-42ee-8850-af265f77f72b@linaro.org>
Date: Thu, 13 Jun 2024 19:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613172103.2987519-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 13/6/24 19:21, Gustavo Romero wrote:
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/aarch64/target_prctl.h | 22 ++-----------
>   target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
>   2 files changed, 55 insertions(+), 20 deletions(-)
>   create mode 100644 target/arm/mte.h


> diff --git a/target/arm/mte.h b/target/arm/mte.h
> new file mode 100644
> index 0000000000..89712aad70
> --- /dev/null
> +++ b/target/arm/mte.h
> @@ -0,0 +1,53 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * Copyright (c) 2024 Linaro, Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef MTE_H
> +#define MTE_H
> +
> +#ifdef CONFIG_TCG
> +#ifdef CONFIG_USER_ONLY
> +#include "sys/prctl.h"
> +
> +static void set_mte_tcf0(CPUArchState *env, abi_long value)

Either declare it inlined (otherwise we'll get multiple symbols
declared if this header is included multiple times), or
preferably only expose the prototype.

Also I'd use the 'arm_' prefix.

> +{
> +    /*
> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> +     *
> +     * The kernel has a per-cpu configuration for the sysadmin,
> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> +     * which qemu does not implement.
> +     *
> +     * Because there is no performance difference between the modes, and
> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
> +     * as the preferred mode.  With this preference, and the way the API
> +     * uses only two bits, there is no way for the program to select
> +     * ASYMM mode.
> +     */
> +    unsigned tcf = 0;
> +    if (value & PR_MTE_TCF_SYNC) {
> +        tcf = 1;
> +    } else if (value & PR_MTE_TCF_ASYNC) {
> +        tcf = 2;
> +    }
> +    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
> +}
> +#endif /* CONFIG_USER_ONLY */
> +#endif /* CONFIG_TCG */
> +
> +#endif /* MTE_H */



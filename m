Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D84D18135
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 17:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Oyz-0002Dz-2o; Mon, 14 Oct 2024 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0Oyv-0002Da-AW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 13:35:45 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0Oyt-00008q-MG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 13:35:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e6f085715so633429b3a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728927342; x=1729532142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LR64Rkd4C2I1cnkL6K9XtFcIqqau7Qe1OYDNRb1eO0c=;
 b=jpE99YTZXmlc9udf1tW/LIl5oelEJxc5oPES77V89tCNnOBEBMDrhaa2wqWjEtvE0v
 E4GggrGUkxbLBM0i9W93CE0eprpBC8uEp2Bam81RIRosY40F3zs+6Ws1QwuO6OvIBM0g
 eYpd7VwdQWoga62BxOjuVo4FRUNUqjlgeM1VI4miKjVpcOt74hNOYirYkFPJzULFqPMc
 W2ALfaiTR6ERUB4QnTH1pMFt5c4pes93gZFwMfaFRRWRtE4BztfNLHDEgZyDOD+phuGT
 qR2vPhrmedDFZtuTdaQUI2efVJHGTg4kgs1WibRI/dgzLq+Cp9BriiQBEAaXuzkL/bYP
 a4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728927342; x=1729532142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LR64Rkd4C2I1cnkL6K9XtFcIqqau7Qe1OYDNRb1eO0c=;
 b=nPo/sYjjkB/mtZVu7cguhXWVKxJlu5W81mvyl2QUZTFpwazs+Xu0Ow5mucMaOmECNc
 Zi4F6YkE6iBrPaKRYUPyYpeChhEl3GatcqS/YDNR+k6mi7yW7FLGj2wTO1a5pFfphMt+
 aFJ6NTjCgSMkz5NoV2PhDLJ771tiVJczkRPX6DRZz/AdcG3VFwBrdgIpxDmSNFhk5RdR
 WxrNg/2IZG7t9Tw8tcsAjdasn1aETLylqQ6OolQVDSDlxeDDQ8F38lDXK1Y0OZBdunnu
 N4p2CFs3Q0/L+H69vI+pQbZwKIIc7FEvmVFaRI73uIRDlQBgDR+sfGVA9BjUnD0+0qWk
 NBFA==
X-Gm-Message-State: AOJu0YzFO6kd9ZrPYmpBeWFOiH2NW2Y0UE2XjcJF62JZkkDbIJEzvZFx
 9XBENdXMzX0Q6imsE6Uaz6n+KFnC3OmTkpeJNkJuO/1W7Y6uAGbCGpefwIBvjTKCR6jd4lLY5Tg
 6
X-Google-Smtp-Source: AGHT+IEB2Lkw18YIDkiNcMHUgYgjOCRWiE1oIozaY8UI0ddwmsm75H1asLEkmXnRIlkqnkjEUklIVA==
X-Received: by 2002:a05:6a00:a93:b0:71e:b8:1930 with SMTP id
 d2e1a72fcca58-71e4c17bb0dmr14777095b3a.16.1728927341947; 
 Mon, 14 Oct 2024 10:35:41 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.39.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e4640772csm5813528b3a.63.2024.10.14.10.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 10:35:41 -0700 (PDT)
Message-ID: <d4a61045-5ddd-477c-a78b-5892c7d79ea2@linaro.org>
Date: Mon, 14 Oct 2024 14:35:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] tests/tcg/aarch64: add system test for FEAT_XS
To: qemu-devel@nongnu.org
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
 <20241014-arm-feat-xs-v1-4-42bb714d6b11@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-4-42bb714d6b11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
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

Hi Manos,

On 10/14/24 07:48, Manos Pitsidianakis wrote:
> Add system test to make sure FEAT_XS is enabled for max cpu emulation
> and that QEMU doesn't crash when encountering an NXS instruction
> variant.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   tests/tcg/aarch64/system/feat-xs.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..52a481c577f9420fa2f6d6a794c1f26772cb4bff
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/feat-xs.c
> @@ -0,0 +1,27 @@
> +/*
> + * FEAT_XS Test
> + *
> + * Copyright (c) 2024 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <minilib.h>
> +#include <stdint.h>
> +
> +int main(void)
> +{
> +    uint64_t isar1;
> +
> +    asm volatile ("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
> +    if (((isar1 >> 56) & (0xff)) != 1) {

XS field is 4 bits, so & against 0xF instead of 0xFF?


Cheers,
Gustavo

> +        ml_printf("FEAT_XS not supported by CPU");
> +        return 1;
> +    }
> +    /* VMALLE1NXS */
> +    asm volatile (".inst 0xd508971f");
> +    /* VMALLE1OSNXS */
> +    asm volatile (".inst 0xd508911f");
> +
> +    return 0;
> +}
> 



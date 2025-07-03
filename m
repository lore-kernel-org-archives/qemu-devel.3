Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE914C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHkP-0007fT-L3; Thu, 03 Jul 2025 07:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhX-0001jV-Ry
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:02:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhV-0004BC-Md
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so32571295e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540514; x=1752145314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OohUo2uJk7GnemHNOOPbqmlHUCl8DjJKrjMI+LBrmxg=;
 b=ct6JRg6jj9LAH7TvtP46mCil9VdXEcEKtalu/KlFhB5vYsJTY+WFrzc7vtmPl+hfIX
 r9iy7zpLB41CSiRxDHp6jLroTSBN89HHd5VD43i+rrY/HmSIcFLxQwDcb6Djb0LKyVkY
 4Je780RGwgqNNVe7Yx99jmuzWU22CFnB69Z2G549AME6qSvM2z5ZhYyGuEUp9xLyFA3t
 fJkFhJgSarJHd8S+gWHGBdpfejWpugrQwtQBojFifbl95CHg22ADRpWFh+twv4ipxhJc
 ZJlsXrnX9Z5Q7x+A8Z34zqby6GdUDCT11kAdwu6fpznlKnrGgJcTfayinWt3gICxaxSs
 OrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540514; x=1752145314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OohUo2uJk7GnemHNOOPbqmlHUCl8DjJKrjMI+LBrmxg=;
 b=lbneXPkvrKMz97dxBQQyw9emztaz762SRFUR345KYzV1e5kzxTGxkJkjGLybqqZg4w
 qMUly1VlbrWtviGq5c0OeVr75l/1CLyhqUZEDq840esoF2dKoTWMDpq2iWT6HhCpCH+E
 oOMiDjkqla8MDeZd9xqoG4cBUxvAHSlHLuAtq1x+O1h3TXBj2yx5dqsa52O3z2f+ocoy
 EEor3+7bMwZuqXMqP/FcpW7d4kJXNhPOy+hNE5jXCNHYMJbFuv3WuiyrvV32NKiuvbAQ
 nmw1fEfEU84go2cZd/hcbo4Wkr33qwy/Y4fo/TwoV80Xzl5YjRsXtmUgGboEdmlukwiW
 gsmQ==
X-Gm-Message-State: AOJu0YwPaFIN9wP6m6i3X3iukEZK/m5ner8qpB35nln7Z9wmXES7Pcf7
 6S+KE7Cq68UCuQVyougngSgCGkfwjCJbdAPTvMDyCE9Cw9jSn/6X8mapAQmyP3R9jE4/ZIOsbtn
 GWV8/mJU=
X-Gm-Gg: ASbGncv8K0BGG2J0aYKJODEW9o8rX73oWhbG3Wryo7+DgEvXGc6Rjrk79JphYrA8Jjo
 5IwrkMlHa73H0WOQki1DXdmFcHI8Go8HpT3Vk5px5TTV0rqd0NIhgzzyR6zhDAKYuxS6FX1Rlnz
 q0sj1govtqSScbLX7wIPcKOOUUacnD5WsfnujF5+DfeRxbaMEQ9gMIgKdhlsC22beyk9Jhdv4yL
 zBKwg1ar1fISBJRY/7CNv5SeAcsAgTIx8Smm4QAWcLai4wYao/pHctT7u6JxIOsK2iKfc/wGjc1
 1XGXv/G7c1vhjyaUb1aBDpjOAEZiQCdkVlrxjN/axf26vYv+ta5cCvU9SJXs63q/hVwvnRfaL5l
 4
X-Google-Smtp-Source: AGHT+IFCCXZps50G7p4whhH0cZWqb2jr4G/5NcgmjSBVBYoSRhCPrtuIlzc/qLHxS9eIV2c45N/42A==
X-Received: by 2002:a05:600c:46d2:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-454a9be9fa3mr39052665e9.0.1751540513894; 
 Thu, 03 Jul 2025 04:01:53 -0700 (PDT)
Received: from [10.79.43.25] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99a3b81sm23123805e9.26.2025.07.03.04.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:01:53 -0700 (PDT)
Message-ID: <2bf6e6c0-d082-44df-9b13-93bdcfdf79f9@linaro.org>
Date: Thu, 3 Jul 2025 13:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 44/69] accel/nvmm: Expose nvmm_enabled() to common code
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-45-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-45-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/7/25 12:55, Philippe Mathieu-Daudé wrote:
> Currently nvmm_enabled() is restricted to target-specific code.
> By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/nvmm.h       | 23 ++++++++++++-----------
>   accel/stubs/nvmm-stub.c     | 12 ++++++++++++
>   target/i386/nvmm/nvmm-all.c |  6 ------
>   accel/stubs/meson.build     |  1 +
>   4 files changed, 25 insertions(+), 17 deletions(-)
>   create mode 100644 accel/stubs/nvmm-stub.c
> 
> diff --git a/include/system/nvmm.h b/include/system/nvmm.h
> index 6971ddb3a5a..7390def9adb 100644
> --- a/include/system/nvmm.h
> +++ b/include/system/nvmm.h
> @@ -13,17 +13,18 @@
>   #define QEMU_NVMM_H
>   
>   #ifdef COMPILING_PER_TARGET
> -
> -#ifdef CONFIG_NVMM
> -
> -int nvmm_enabled(void);
> -
> -#else /* CONFIG_NVMM */
> -
> -#define nvmm_enabled() (0)
> -
> -#endif /* CONFIG_NVMM */
> -
> +# ifdef CONFIG_NVMM
> +#  define CONFIG_NVMM_IS_POSSIBLE
> +# endif /* !CONFIG_NVMM */
> +#else
> +# define CONFIG_NVMM_IS_POSSIBLE
>   #endif /* COMPILING_PER_TARGET */
>   
> +#ifdef CONFIG_NVMM_IS_POSSIBLE
> +extern bool nvmm_allowed;
> +#define nvmm_enabled() (nvmm_allowed)
> +#else /* !CONFIG_NVMM_IS_POSSIBLE */
> +#define nvmm_enabled() 0
> +#endif /* !CONFIG_NVMM_IS_POSSIBLE */
> +
>   #endif /* QEMU_NVMM_H */
> diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
> new file mode 100644
> index 00000000000..cc58114ceb3
> --- /dev/null
> +++ b/accel/stubs/nvmm-stub.c
> @@ -0,0 +1,12 @@
> +/*
> + * NVMM stubs for QEMU
> + *
> + *  Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/hvf.h"
> +
> +bool nvmm_allowed;

Consider this missing hunk squashed:

-- >8 --
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index a392d3fc232..b4a4d50e860 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -49 +49 @@ struct qemu_machine {
-static bool nvmm_allowed;
+bool nvmm_allowed;
---


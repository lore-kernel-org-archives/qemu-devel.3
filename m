Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A3DC282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhGi-0008F8-IE; Tue, 18 Mar 2025 20:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhG2-00082e-Ld
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:26:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhG0-0000lc-EF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:26:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22548a28d0cso18730485ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742343962; x=1742948762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0aqZzlpYBLlNsxwaTLq9zvwCnBZAH6RrCI4a138V2c=;
 b=eqm17toyEzJASS1BIOWsAQqjq8/vSxwlB2d51e7ZSEqNGz1lfBnVfCopxQKkXV4bQa
 aDz/dfMs3sj09I8Z9x7Qj53+GL2EADd7dfPls69Gq5hlyhuehRJH+hp/1B+o/6ZK2T0D
 JKBzQq8iuy1oCl17mpxO1nq+vfntiPl5E48OX0rXqPnhdQEgEvEOEouEzZ8GzgxAPa9c
 eVrnXp0zo4F6VM9Ho79D/gKV0jCh1aTB7nRewyISqPwCw7Lb5ooNT2aMmEpH+/lsOgGJ
 wMm7lsPPc0CfrkX4muQb++XiB+45wE1NBELwLxChxfpqpaoPbtXuOBp13Gs/uUOCr4RB
 +Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742343962; x=1742948762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0aqZzlpYBLlNsxwaTLq9zvwCnBZAH6RrCI4a138V2c=;
 b=RD+SaKMnQS/M35e/XIOPvEXHBqutUaLq6gcg2wVphPb4ve3WGJp/aLSgqTRZVvscoO
 8ET+UNQVl4CIw/oswrjk1GruAIvl8o3R2JEzwSR3Ecc2mFqibvEOWTmrDJDGk4jxAPhw
 wy9GIAE26Dam+Dyh+Q649UtDY89PkGyMvxoJ7lHQZwuh64Qr+iOskW425wen8itsAHLc
 krnORrmHICrmQ23xWl99BM9xtlAZEVFnrO5/0ZsscJ8l3l9Nxq1sg3nQEuyvWNb6kdwK
 hkSSUgjX0MMzrT7OEcOSFPp9WjQzFZqT1Hj6PrMRzfWfev0WMMDLyQXpJlR9Mm1viLc8
 MV2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ1mmjgul1q16scC5LSTNCcvy1cTaNdjDA6G+bh1WelKKt3yl5ODCGih8ksbVy+npkhzsQkf/J/vMH@nongnu.org
X-Gm-Message-State: AOJu0Yz+sZi0C6g4oUd+UwdxbWFPWyDoxf+Ld3qolOmQ9VYO/tSzR0iO
 TLtsZqC1wqMPaf6srHM7UieWjYazPbgNqWxzBGWelUkltvF0DfLMHx+msAHnqeA=
X-Gm-Gg: ASbGnct/GnFzqhbh/VVi2/2/TS+PcAzh2dtaj+b2aE6XCCJ+EL8MQUeVw9jyQSbauPa
 3IYf44dlgqROti+LuFYH2VP1fpmtM/jWQJz2qjZp9UmXKu2vjU2AKtYYKMxRwQ/SDzchd8aiBzB
 uY9q870B7wJi99en2Rj6j3kGdZ5/E57R7DeVT4jID/b1QIqZkIis4lhvKq25Y20DzgTOg9p+Drn
 Z+PDcn2BaFRUTMhlRyZCjMZBnMRw6psBzV8RyrzaB9cLyeh+CqxG3tFaXcfW9QFVsBcBthpCe2y
 +hRrxDaVdk6OQn67eBo6EvR//a1Z05rwCcses5Tzng31gjnQa/bYIwL6kg==
X-Google-Smtp-Source: AGHT+IGwyqkKUe1ETJBzyG35DRrjFt4mKp1Q9+dOwcbQkK1RqlVxHD+cE3uiM3Z73pwDOoDKPt8dAA==
X-Received: by 2002:a17:902:e888:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-2264982b2famr8304565ad.5.1742343962291; 
 Tue, 18 Mar 2025 17:26:02 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe7b6sm101468525ad.177.2025.03.18.17.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:26:01 -0700 (PDT)
Message-ID: <c548e44d-cd1b-4d00-9d2e-43732d81602d@linaro.org>
Date: Tue, 18 Mar 2025 17:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/42] semihosting: Move user-only implementation
 out-of-line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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
> Avoid testing CONFIG_USER_ONLY in semihost.h.
> The only function that's required is semihosting_enabled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/semihosting/semihost.h | 29 ++---------------------------
>   semihosting/user.c             | 15 +++++++++++++++
>   semihosting/meson.build        |  2 ++
>   3 files changed, 19 insertions(+), 27 deletions(-)
>   create mode 100644 semihosting/user.c
> 
> diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
> index 97d2a2ba99..b03e637578 100644
> --- a/include/semihosting/semihost.h
> +++ b/include/semihosting/semihost.h
> @@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
>       SEMIHOSTING_TARGET_GDB
>   } SemihostingTarget;
>   
> -#ifdef CONFIG_USER_ONLY
> -static inline bool semihosting_enabled(bool is_user)
> -{
> -    return true;
> -}
> -
> -static inline SemihostingTarget semihosting_get_target(void)
> -{
> -    return SEMIHOSTING_TARGET_AUTO;
> -}
> -
> -static inline const char *semihosting_get_arg(int i)
> -{
> -    return NULL;
> -}
> -
> -static inline int semihosting_get_argc(void)
> -{
> -    return 0;
> -}
> -
> -static inline const char *semihosting_get_cmdline(void)
> -{
> -    return NULL;
> -}
> -#else /* !CONFIG_USER_ONLY */
>   /**
>    * semihosting_enabled:
>    * @is_user: true if guest code is in usermode (i.e. not privileged)
> @@ -59,17 +33,18 @@ static inline const char *semihosting_get_cmdline(void)
>    * Return true if guest code is allowed to make semihosting calls.
>    */
>   bool semihosting_enabled(bool is_user);
> +
>   SemihostingTarget semihosting_get_target(void);
>   const char *semihosting_get_arg(int i);
>   int semihosting_get_argc(void);
>   const char *semihosting_get_cmdline(void);
>   void semihosting_arg_fallback(const char *file, const char *cmd);
> +
>   /* for vl.c hooks */
>   void qemu_semihosting_enable(void);
>   int qemu_semihosting_config_options(const char *optstr);
>   void qemu_semihosting_chardev_init(void);
>   void qemu_semihosting_console_init(Chardev *);
> -#endif /* CONFIG_USER_ONLY */
>   void qemu_semihosting_guestfd_init(void);
>   
>   #endif /* SEMIHOST_H */
> diff --git a/semihosting/user.c b/semihosting/user.c
> new file mode 100644
> index 0000000000..9473729beb
> --- /dev/null
> +++ b/semihosting/user.c
> @@ -0,0 +1,15 @@
> +/*
> + * Semihosting for user emulation
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "semihosting/semihost.h"
> +
> +bool semihosting_enabled(bool is_user)
> +{
> +    return true;
> +}
> diff --git a/semihosting/meson.build b/semihosting/meson.build
> index 86f5004bed..ab67f87e4f 100644
> --- a/semihosting/meson.build
> +++ b/semihosting/meson.build
> @@ -15,5 +15,7 @@ system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
>     'stubs-system.c',
>   ))
>   
> +user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
> +
>   specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
>   		if_true: files('arm-compat-semi.c'))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



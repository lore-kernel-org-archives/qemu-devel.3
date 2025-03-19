Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A21FC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhI5-0000Qy-8M; Tue, 18 Mar 2025 20:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhHL-0008QK-76
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:27:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhH4-0000qm-Vm
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:27:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22622ddcc35so7310675ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344029; x=1742948829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s15q50u8vJWqScxvLJ88Viib4EmNuu+MARScWGFwsxo=;
 b=lS8V/FHzII7OkwdGvOXnV14p+aqy5dwqWyoPs+6RbSed8DNCl3c/gxjyg+kNLxs1aw
 uL/7Y1tpgqNpYbolRkqBjDnaoPd7eE2vSAsimKtKxp//ibxv306gGVF5ZAtTXtzHdpl8
 EIPh9is2ELc+UZUqY0oyZE4oxddqDLNXTusiTrkt7HEVliSd0r1849ZjrRJEIezv49a8
 WWk/8i5FEW82ZzHlhMmuPXKQFpVFAXsWqa7Yf6v4d6JoGMjkwhyOm9nH0cjRhGx3c0sY
 RXw6X49YcW9AnC9X+V9tVqwye6wLWh/fINl8KsSKNwDEOCNJD2HZRb4jJ8/8xY63WQoU
 PfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344029; x=1742948829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s15q50u8vJWqScxvLJ88Viib4EmNuu+MARScWGFwsxo=;
 b=VkB05AiOf9Vvrn81d4eGXz5tHyWFzmb5rU1EIidPBLxO3GFoadBrlm08B4k8ezi1z0
 lhC9mY18G8Y7p1Ik7+1V/p0eMyNIwuCDfmueIsiO4eXSOIwVmLv+SLHCmKYJjwjGFzUX
 3W/KJbfuqwd5QpliXyfwMdk0q68/GgIq+MZnPMwzRUWQrj9eJRRRQJDhAhfeI19fJpzM
 DSiZSz8A+KPNIec97hge4LRWF9JdUb0rXMmmHvtLxf4W1+9iFl8xHaPZYOylxSzXpmLY
 fP/rbV8V6L2ncAVMBYggIxc3WoLGFZGXWgdv+WHntanXDtd070aj6vW339eieC2CvyKF
 upUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnzJ8CYcs616BI/CosvbNgInAkgSNCS/YST3o7ZgTZyEZGtg4l30KOpXs/fOXrgMOLlRAXWupdoI0/@nongnu.org
X-Gm-Message-State: AOJu0Yy/vfP8h88kqskA7E0dRlYv46+kkSv36FCQ4kNrWVd9qZxVy2zV
 DKToglI70W971/LHItTUhrVUkAPbXtW3JgNRjxHc8agFADQHNxzoGknaoRmJTBU=
X-Gm-Gg: ASbGnctng9cmgzz5Gk/aAqScIN/y2esKk8VhzHhW4q7auB+dCiRfZm5rIVf4bdF5wpU
 GqreUfspGL1WCTL6G4L0nl2fg4ngUaAlAKX5GHAr7kJwWlkpo15gYBUlsCgIMlrOosKR8uasvG+
 X4/dq2jcixEs1jT8cBvzIT6hMz/75NdkPVzVBPghfy6d7+crbGB81kmVVG7updFf33K600tX5L+
 C1EJn4Pxl1VP3fggwNw2XydTTCdrceYvOx8ATkqoO2mz3INl70BuwtCPKj6wE6s/3tWw+8mDq9U
 nnhEr5FpP9IAUfmgWYBP0gq48A/o9sNlqRhJIAVggYbLLCJBd2VGdHJd2w==
X-Google-Smtp-Source: AGHT+IH7030KQSL8xskFiN/0iQSJnQEeXRNqayWHMd36SvVJo+xhbBZgqOz4PfcepashyV+GmoDbtA==
X-Received: by 2002:a17:902:ccc7:b0:224:ff0:4360 with SMTP id
 d9443c01a7336-22649cb6a06mr10206555ad.53.1742344029082; 
 Tue, 18 Mar 2025 17:27:09 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6d0asm101613875ad.130.2025.03.18.17.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:27:08 -0700 (PDT)
Message-ID: <6a9f2116-e598-4342-bdeb-c67969dc1bad@linaro.org>
Date: Tue, 18 Mar 2025 17:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/42] target/xtensa: Restrict semihosting tests to
 system mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-29-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> configs/targets/xtensa*-linux-user.mak.
> 
> Do not raise SIGILL for user-only unconditionally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/translate.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 4f02cefde3..cb817b3119 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -35,14 +35,14 @@
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
>   #include "qemu/qemu-print.h"
> -#include "semihosting/semihost.h"
>   #include "exec/translator.h"
>   #include "exec/translation-block.h"
> -
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> -
>   #include "exec/log.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "semihosting/semihost.h"
> +#endif
>   
>   #define HELPER_H "helper.h"
>   #include "exec/helper-info.c.inc"
> @@ -2241,17 +2241,15 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
>                                           const OpcodeArg arg[],
>                                           const uint32_t par[])
>   {
> -    bool is_semi = semihosting_enabled(dc->cring != 0);
> -#ifdef CONFIG_USER_ONLY
> -    bool ill = true;
> -#else
> -    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
> -    bool ill = dc->config->hw_version <= 250002 && !is_semi;
> -#endif
> -    if (ill || !is_semi) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
> +#ifndef CONFIG_USER_ONLY
> +    if (semihosting_enabled(dc->cring != 0)) {
> +        return 0;
>       }
> -    return ill ? XTENSA_OP_ILL : 0;
> +#endif
> +    qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
> +
> +    /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
> +    return dc->config->hw_version <= 250002 ? XTENSA_OP_ILL : 0;
>   }
>   
>   static void translate_simcall(DisasContext *dc, const OpcodeArg arg[],

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



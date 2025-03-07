Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C7C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd8H-00010w-5N; Fri, 07 Mar 2025 14:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8F-0000vF-Gz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:15 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd8D-00065K-Rz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:13:15 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224100e9a5cso43428155ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374792; x=1741979592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u0/X50UeS703QJxdxYEye+mwpoIbxHd8hWJMLAXeyMQ=;
 b=Trt0YQpfUbHe2BuW7D9Z9H7tV8diphU+cw9W/v/Cx+6GzNPDiQb7wrSOcDdajZIbRm
 sNmEYLbY51tig/uypACSMZvWfnmDcmihzZBycUT3/gjQUMVcsY8oZdg8dGIxzNZ+uqRC
 xR9IzKKZqKUjK+HmDR2LAcaUZTt5oP5kqEdyfjq/e714frYSYNdymcjVZuJhFX7RMOoL
 csaZoVn0W1VlGjgMwrEV8QIao8/0s3sQTX+GP4G/Xiw7kVBIpfKZhVVje7nxESslgrVy
 h3J2QsHYToFqhB1HuvSaq3gtvKHTG7wS+3dP745Vy0C24aoL0ovR1dbpmcyoK4zBZs+Y
 pcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374792; x=1741979592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u0/X50UeS703QJxdxYEye+mwpoIbxHd8hWJMLAXeyMQ=;
 b=OKu1I6lT5z+5yebzVJ72Y7dWEre5qTjel3Zs2zJpCCE3AFKb5mWlnD2vCM4dzah84/
 Ibx+Ui0xDO2PRJQuaeLlKlOqclfpl7yf9hj7aMow4DYRcL1GO08Rq0yPQ5B4/xvx5zxa
 3ySY00dET0rffSjtD27q72la9v0Jea9f3Itacv9sWi2FH+nk6As/TcfhTGFM8IejOadd
 oHpnKcp2R0JQx3Z8Su/MTf2u4tPJ8eaqSvWcHbjBRj7B/OICfe7Fmio7pzHcHKdT01b5
 S5b2f/kgwrfkHymfY7i8GA9vZhugfCWD/jEP4pXlSv0scpe6EM3JD9AECcTQLMp0lIzX
 5cjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7I/9rYpInJnzOTKazBFb+N+S5yNolOj0Zm/dUP0z0ytY60RhsKgejbaqOZgPNp3j0TCv3h/0NAKM@nongnu.org
X-Gm-Message-State: AOJu0YwWjy/rMSgWva3MqQQiUitqns/MF/akYE+iN1SIw5MHbV2uwFK1
 hqz46BLg3GujIa67W8DmO3y0/y4tE1r8IWPaTkhZtpdiu7riKCd1Bd0TseyitmU=
X-Gm-Gg: ASbGncsqJmk/xMSBhHQGi4H+xWvQD4qoqfSJI7mLsBHO29Z+12e/gzXO0P1yjnAIhM0
 YIxYipoHkvrW4Aml5cn8n/wb23eVvGfo9apMuYf+js4QcADTXsltTmurmECNyrYpa2e36AUMCrb
 te/S1zhWXgMrWIXhST2+3viMECiyQiUuNQqaOt6usK7hyWHIAYl9TG5zx9Vwpbv1Ni+0X6htGYO
 sSJUyf75ZEzg4XZkLlLbSTYwhnMK7P8hZzbQzW5dYeI09mKWh3jRZYl7WhF/F4UWMo7P38Qc8tu
 +BB2FW+ldPkFOo0wbCBMPopEtfKUNsdtb2536PqX+tw0rbV56sys2R37cQ==
X-Google-Smtp-Source: AGHT+IHXfQgh9j9OrSHSGjETN+rH3ryBNWAWbeKa36S3h5eWVVXswoo3nWJybhkJ/BhR0j80UEo7qw==
X-Received: by 2002:a17:903:289:b0:224:216e:3342 with SMTP id
 d9443c01a7336-22428c11ce4mr80988865ad.43.1741374792424; 
 Fri, 07 Mar 2025 11:13:12 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f7cbsm33845335ad.140.2025.03.07.11.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:13:12 -0800 (PST)
Message-ID: <598bf89c-b98a-4d67-b690-80cc978b2ab6@linaro.org>
Date: Fri, 7 Mar 2025 11:13:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] accel/tcg: Build tcg-accel-ops-icount.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> All that is required is to avoid including exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-icount.c | 2 +-
>   accel/tcg/meson.build            | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
> index d6b472a0b0..27cf1044c7 100644
> --- a/accel/tcg/tcg-accel-ops-icount.c
> +++ b/accel/tcg/tcg-accel-ops-icount.c
> @@ -28,7 +28,7 @@
>   #include "system/cpu-timers.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/guest-random.h"
> -#include "exec/exec-all.h"
> +#include "hw/core/cpu.h"
>   
>   #include "tcg-accel-ops.h"
>   #include "tcg-accel-ops-icount.h"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 70ada21f42..891b724eb6 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
>     'tcg-accel-ops-mttcg.c',
> -  'tcg-accel-ops-icount.c',
>     'tcg-accel-ops-rr.c',
>   ))
>   
> @@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'icount-common.c',
>     'monitor.c',
>     'tcg-accel-ops.c',
> +  'tcg-accel-ops-icount.c',
>     'watchpoint.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B5EC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyG9c-0003DF-8y; Fri, 28 Mar 2025 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG9Y-00039q-ST
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:18:09 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG9X-0001lV-07
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:18:08 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e6194e9d2cso4994483a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193085; x=1743797885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5F7YhE2KJTb9eMXwA+biBKoMTtJFMQytrIX82a9jQo=;
 b=HNpn5elvzKwYAXl2dRwu6xDxc6Bi/5ePHhCM5oPIWDdZA5fXF0wRp7Tx0TgmHnhre5
 n2zq3emCCfZBUBKL+Eh1ek4BY/0Trf25+nKM+dgd3jJWxBEM9uwlOe2k7EAsfeKwN6/d
 Lwseb1ZEHIFUCwHIVMTP48yi5aUYBybpMcfcYZ1Pe5SyQP4ci9xfEv5XN9Dn/2VyiWDJ
 +oXDHD38kHHMT0M8J/DC+zhXBoqRq/FVdNhgfs82gIJLAfVXIrzLBJPlkdwsFFhteOa1
 E9X35DS1CgxISCSDUUCjSBJhhgkVzIiP7j7D6vqJISkWoSMF9NRgbH/718u1+ytXCtz5
 1OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193085; x=1743797885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V5F7YhE2KJTb9eMXwA+biBKoMTtJFMQytrIX82a9jQo=;
 b=rQxvKX6vN4zBxQrbh8VUPaQ5/dNMhgyI+Wy+qCOND/u3YoXaNaORpER+hr6on9SeFN
 HZ2Ukjh5PaqhLIuEh4Zzjbafe4qXa68YeWCBlHwjbHcAEK/k9nmWe8z9Rj1JrJJ6RJ2Q
 bZ2iPrIkN9S2NM22np9+wp/0rOGTdH1/mSfBSeEwP9SFFM7HDMNfjFidJRU+XlKiE/4t
 2uB6tRh3rj+Zn4MVnezEFHZp1CwwbL3yjig0cukYhLxj6yJ0VvRUCy6gXhgTZHiUJ+jS
 OppSXVOlmERDrw2sI70NYKZ1O4jSMySYAWP1tqUAkeGV5A3yidudTZH0H86higR4Eae8
 HUIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiJV123j8AuO5wai/GjrpWQ/dxULq2ovfE+X7rDnzJgNDRHqnu35HsoYVHRcboZava0Fb9NH9kC1r1@nongnu.org
X-Gm-Message-State: AOJu0YzlyKQedFhqbwvFsXWiQ7aZSDn9HBDlZdcMwCWqxV8y68nuJ6c9
 RiYSA+Y0TbqX8093299lfSpi4/UPKKRKnlgdc+SPR0hGUGiUu7WnxdTl+Ndhmew=
X-Gm-Gg: ASbGnct2UNYhdzfnYPAumiOmXDsL8nSMnUInMsHb1x57LahppEciJfjh2Tup/dx1Rk2
 l2msk+fjdzVja7ibfAhW/gr+fNUo2ezVJGqLWAFtc57U1n9TYBJ5ZzSSSqOuZ49lM+pflmCdreK
 PnHYS/8cqM5kOUDyUeiIDg5UNsGr5I0sScK8QparD36Z/o6f71fBGrxzL26gKIM9k9BixUqsz3c
 2VHegaJjWq905deJgHTq+hEUM99tdx/eIDHjsyoc2jElgrSTDJCOO6ohZfMbEwfICYtKKJUnoeW
 wXTl5+SJ8pGrU8GirsrtWvkoV0vthk5IS5m4X81MTEAv8PGiEs4NS9sCavY=
X-Google-Smtp-Source: AGHT+IGPGvYHevwfY2xUMOANH545XlN9av4K7u0IRVT1QBSyqGTjDq5P55M045yNuWbtmhuRT7836w==
X-Received: by 2002:a17:907:3f07:b0:ac2:fd70:dd98 with SMTP id
 a640c23a62f3a-ac738abe27emr45733766b.22.1743193084779; 
 Fri, 28 Mar 2025 13:18:04 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922ba02sm214072866b.10.2025.03.28.13.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:18:03 -0700 (PDT)
Message-ID: <03530b52-0048-4b49-b690-62f1a2bf88d3@linaro.org>
Date: Fri, 28 Mar 2025 13:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] accel/tcg: Remove cpu-all.h, exec-all.h from
 tb-internal.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x535.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> Not used by tb-internal.h, but add an include for
> target_page.h in tb-maint.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h | 2 --
>   accel/tcg/tb-maint.c    | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
> index f7c2073e29..f9a06bcbab 100644
> --- a/accel/tcg/tb-internal.h
> +++ b/accel/tcg/tb-internal.h
> @@ -9,8 +9,6 @@
>   #ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
>   #define ACCEL_TCG_TB_INTERNAL_TARGET_H
>   
> -#include "exec/cpu-all.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   
>   /*
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index d5899ad047..df3438e190 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -26,6 +26,7 @@
>   #include "exec/page-protection.h"
>   #include "exec/mmap-lock.h"
>   #include "exec/tb-flush.h"
> +#include "exec/target_page.h"
>   #include "tb-internal.h"
>   #include "system/tcg.h"
>   #include "tcg/tcg.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



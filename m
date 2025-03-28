Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D41C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGI4-0007uH-5X; Fri, 28 Mar 2025 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGI0-0007mq-Ur
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:26:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyGHy-0002nk-Q2
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:26:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so4854282a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193609; x=1743798409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F9pIUiGHkEqoEmdIOZ7r72I7ZMk2OckJdSRmdM/UDVc=;
 b=fsC9gvk/psUIu7+9rSkFlNP7h4IyQZzbwIM4i+igsZ319UCg2VgCFqjjM1sN/6rSZG
 iK1LVY5S/sLmaTjpgeUOj5ED7YOzx6zUC9Ud+qJwOYPe05BrYIIA/h7xq9o9AWpXDHu5
 ApCrTBNach48Zib9ZTpSVZoBz8r2gon0UXKsnUHTkEREEuQjqdicpxRAhU3LLwpNa6XK
 lBBf2JxPm6um2l55zrAOcHuet60Dtke94Aa91HW2KRQQruLecBfOITCHqAUvcrqviN5f
 N2FDFBNazL1n/biMj2sHZ0AfGyTe/Jmp9FzIyofPQGc/j23O7s2P1GpZuBQp56BxF/HO
 PoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193609; x=1743798409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F9pIUiGHkEqoEmdIOZ7r72I7ZMk2OckJdSRmdM/UDVc=;
 b=wleVPyw6nbt6hN+tmmHFWG0H3sAfVZ36e2dy2gQol5oRGF0zX8sVvcab4PRI8AVZMy
 I0ZxtLmq9BUxKRww7rusjDqyRbN3WYNcYvrgCyzTSCuwfKkC4heF5CF+8xa0s55NJlgZ
 hM6ibA1b0rXi/CXJjt2vA6+VODNPyi5yjbMEHLxdPvtcoPW7VxUtzazD2rG883/dKpuQ
 s+K3FcN0IbpFViovbxIM/0V6AMhiayHsz1QbnaMPUte+Aeys85dV855nvMXZdO2R3iBc
 uZ+fTYILWwrjcGr31weJ3ADPsPV1a8TdzqRj6/azdjotAhs0MTjfkBCWgxy6Tf79LMdP
 itbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8uFAo235uc86JztqQ5ImQubioSuUVNI1MKuT1xUmQut9qmHu212FJP+4a+kzzbkfkRiYZL5G6SHfV@nongnu.org
X-Gm-Message-State: AOJu0Yz1JDIjm/x4/SINiq4ZbGqrWBHg2r5KPY4xw4R9pDfSdpEqe0vU
 IAw8jhT5aTSxtd2HyBcC7yjQDLjXDYE2+fkkHh+GJejxrQX8G8ZO9oTZHimpieUAH7sTEpK13oL
 RwzU=
X-Gm-Gg: ASbGncuSGHTgEInq3/Q0HBn+pBFnnhHiHBgm21tHtbmY1pmBBO7puyhbprKCpaueB4f
 Yj4RA8lOn8xMUtMr2sBTGWSpEqkYnfeQMhGf6m/84WePC2qZLzQqc4D2PMf++jbOaxsvBPsqaJm
 dEo7oDBrPh0CBq6/UDN5/7dP40v2iBMWtr+l2baksBnYBBIHATiadZBvBLMb/VEHwN14hchNr7I
 Yj2W4+IA6MEnLv849IyS7Wtmggv33Da+unYnpE1XSMU//Ywg8ZZvFbBSX2frUWQdbf2otTMurPC
 09BuDgfQ4SXJ49FpdMLJf0ZoJxszMDYaLw5xj95SddyuCh+H2Qmy8rJQ51k=
X-Google-Smtp-Source: AGHT+IHrO42TdgxNNJwd4Ln1i+SSVOPwwVC/oagpwKYw2dFIVnZo0UxRlqsImbjdU6wj4tiIbJrXRw==
X-Received: by 2002:a17:907:3e0a:b0:ac6:e20f:fa48 with SMTP id
 a640c23a62f3a-ac738a9dfc3mr36798466b.33.1743193609027; 
 Fri, 28 Mar 2025 13:26:49 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71966df75sm207522566b.124.2025.03.28.13.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:26:47 -0700 (PDT)
Message-ID: <4ad31da9-813c-494d-82e8-4c0505e90e5d@linaro.org>
Date: Fri, 28 Mar 2025 13:26:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] page-vary: Move and rename qemu_target_page_bits_min
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x529.google.com
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
> Rename to migration_legacy_page_bits, to make it clear that
> we cannot change the value without causing a migration break.
> Move to page-vary.h and page-vary-target.c.
> Define via TARGET_PAGE_BITS if not TARGET_PAGE_BITS_VARY.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/page-vary.h   | 9 +++++++++
>   include/exec/target_page.h | 1 -
>   migration/savevm.c         | 6 +++---
>   page-target.c              | 5 -----
>   page-vary-target.c         | 9 +++++++++
>   5 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
> index 54ddde308a..101c25911c 100644
> --- a/include/exec/page-vary.h
> +++ b/include/exec/page-vary.h
> @@ -49,4 +49,13 @@ bool set_preferred_target_page_bits(int bits);
>    */
>   void finalize_target_page_bits(void);
>   
> +/**
> + * migration_legacy_page_bits
> + *
> + * For migration compatibility with qemu v2.9, prior to the introduction
> + * of the configuration/target-page-bits section, return the value of
> + * TARGET_PAGE_BITS that the target had then.
> + */
> +int migration_legacy_page_bits(void);
> +
>   #endif /* EXEC_PAGE_VARY_H */
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index 8e89e5cbe6..e4bd7f7767 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -63,7 +63,6 @@ static inline int qemu_target_page_bits(void)
>       return TARGET_PAGE_BITS;
>   }
>   
> -int qemu_target_page_bits_min(void);
>   size_t qemu_target_pages_to_MiB(size_t pages);
>   
>   #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c33200a33f..0c12e373b4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -50,6 +50,7 @@
>   #include "system/cpus.h"
>   #include "system/memory.h"
>   #include "exec/target_page.h"
> +#include "exec/page-vary.h"
>   #include "trace.h"
>   #include "qemu/iov.h"
>   #include "qemu/job.h"
> @@ -339,7 +340,7 @@ static int configuration_pre_load(void *opaque)
>        * predates the variable-target-page-bits support and is using the
>        * minimum possible value for this CPU.
>        */
> -    state->target_page_bits = qemu_target_page_bits_min();
> +    state->target_page_bits = migration_legacy_page_bits();
>       return 0;
>   }
>   
> @@ -462,8 +463,7 @@ static const VMStateInfo vmstate_info_capability = {
>    */
>   static bool vmstate_target_page_bits_needed(void *opaque)
>   {
> -    return qemu_target_page_bits()
> -        > qemu_target_page_bits_min();
> +    return qemu_target_page_bits() > migration_legacy_page_bits();
>   }
>   
>   static const VMStateDescription vmstate_target_page_bits = {
> diff --git a/page-target.c b/page-target.c
> index 321e43d06f..8fcd5443b5 100644
> --- a/page-target.c
> +++ b/page-target.c
> @@ -9,11 +9,6 @@
>   #include "qemu/osdep.h"
>   #include "exec/target_page.h"
>   
> -int qemu_target_page_bits_min(void)
> -{
> -    return TARGET_PAGE_BITS_MIN;
> -}
> -
>   /* Convert target pages to MiB (2**20). */
>   size_t qemu_target_pages_to_MiB(size_t pages)
>   {
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 84ddeb7c26..6251d948cf 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -23,6 +23,15 @@
>   #include "exec/page-vary.h"
>   #include "exec/target_page.h"
>   
> +int migration_legacy_page_bits(void)
> +{
> +#ifdef TARGET_PAGE_BITS_VARY
> +    return TARGET_PAGE_BITS_MIN;
> +#else
> +    return TARGET_PAGE_BITS;
> +#endif
> +}
> +
>   bool set_preferred_target_page_bits(int bits)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



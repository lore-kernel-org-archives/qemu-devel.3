Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3DBECD9B0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 01:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voAs4-0000ZS-4j; Thu, 05 Feb 2026 20:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voAs2-0000Z0-5U
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:42:54 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voAs0-00039R-LI
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:42:53 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-354a69b1455so168442a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770342171; x=1770946971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dpnueChdPcvggmI9TKR6LpVjNjrzFL3DD7HnCNiKmZE=;
 b=FMvOctXznFnspWLBwoVpWAGAWJKCNxF1OTcLcoLegAtVw88EPmm+Asyc5CbsmXyTwt
 c6U8csWY9FJGwCSMz9J7Y+c7vOGhMvmLQO72o1vVMn9AZZ22O9gUVrRgDlrjYoGSFvcm
 5tBOSIQANVcWOYmHftS8C9Dpc+XX7bTRruo9/XfC9eAtXO9udPI8IDn0mZAJlD0aVQ7J
 Y0u7XVus4wjUUa1QnUDKOnr3aA4mjxG/yCzCii5Ki6y8I/N9zGDUO1/EEnT5jU8W/Kzd
 MGRP4LCbEySrxGB9a3wti5B/DalRrqFzjr5YbVJuFvP0pM5mEm5sRQZAvYgeZmLV9jIY
 7yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342171; x=1770946971;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpnueChdPcvggmI9TKR6LpVjNjrzFL3DD7HnCNiKmZE=;
 b=TqqJ03L9hFKYUR2jeJRO04weUyRiJ5fETpSl9KNsClFgffEzDyj1bIzgpuOWivgYoW
 HrBiL+tldctHxJwIVqB+hMAE6Fp/12xQ3Aajm90GjXzKk2/o4QFNuQktc2URQYmRgk4r
 nbesYQgtiFie/LU3ZmPB7osz6ybaeBDsDNuCObZHxUYCKThhEkE3HvbqDaTtWQWDa1OV
 av/pdULvpS4SRaTy8Y9sgA1kMzsgfCWli6/NWOWlTQtiOraRNPfn0STAvRd3++hytKuC
 GfQUlQ/yp4TtcJo/4qxRyhnpEs5f8QFaLn8WYeZRJjp03L1m3mm3vi57AslTCUl65Mt/
 Zqxg==
X-Gm-Message-State: AOJu0Yy1dY9oUTWraN97fi8fSEVG2vkNXLTYo1t2ujJx+/JC3XM/uO9x
 ZuzKICedzzUCkegmQFE83BengQn/f0YvV85ItETy4sO36a5WjGJBc02dys25C6d37tSfelSLyb6
 WIb/WuacLLA==
X-Gm-Gg: AZuq6aLN7Bocq19uqnOP9o19M76zBIdrXys68NDQJcIKbd17SEkVYXf9bXl/5ZMQXvS
 yYN/A8QdDmCqO35FDy2CBqkN7rUv58v8PS6BiXp6nZZDp1GMLfzEhETd6OMSvEPnsqzbAXQWF9e
 88idTYIy8ng0bXNtSj8CX3uvdgyZ1fsR3hgfvGiI95edQME2Nq5LBfpzYWALzNK8eRV5RxOVi0N
 IE7WaI6MiHiO32hmZ7CYg/DVf4y/68LhZFS4LA+6lPnJm22OOuitgu01Th5vf3EJarFJIO6j+IL
 U0pRjbUg8yQeI8/fJ/xJFs15DwSjg6FssJDotB5la8ws8/xIyAM0KQs7EMF0PQIRWXLAtaw+gVQ
 4DMtQBgzterGNdBVysvXUpCqd0mvcSfzHWowL5JYNHMFc5tl4aeXL8nZ5kYz4UwJmhG1d/OVe+7
 O7m91fB13HImV6b+QNL+soDboRo460SmVaKuP4H5NQlT2mv3a/cR93BaTXehb5JiEBzBuEufnxO
 ZXJKkW5s0ox2l8F5Yz+nufg1emkscphGe2AOmtPwb+81j7J1bmWXQ==
X-Received: by 2002:a17:90b:1d52:b0:352:c34a:342c with SMTP id
 98e67ed59e1d1-354b3e68290mr758335a91.29.1770342170506; 
 Thu, 05 Feb 2026 17:42:50 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b222355asm804074a91.13.2026.02.05.17.42.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 17:42:49 -0800 (PST)
Message-ID: <a7001938-fd6b-470c-88f2-5fb29d603b8c@linaro.org>
Date: Fri, 6 Feb 2026 11:42:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] bsd-user: Add target_to_host_semarray for semaphore
 operations
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-7-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-7-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add target_to_host_semarray() to convert target semaphore array to host
> format for semctl(2) SETALL operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index d2107b2f85..07d8bf1304 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -18,6 +18,11 @@
>    */
>   #include "qemu/osdep.h"
>   
> +#define _WANT_SEMUN
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/sem.h>
>   #include <sys/uuid.h>
>   
>   #include "qemu.h"
> @@ -44,3 +49,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
>       unlock_user_struct(target_uuid, target_addr, 1);
>       return 0;
>   }
> +
> +abi_long target_to_host_semarray(int semid, unsigned short **host_array,
> +        abi_ulong target_addr)
> +{
> +    abi_long ret;
> +    int nsems, i;
> +    unsigned short *array;
> +    union semun semun;
> +    struct semid_ds semid_ds;
> +
> +    semun.buf = &semid_ds;
> +    ret = semctl(semid, 0, IPC_STAT, semun);
> +    if (ret == -1) {
> +        return get_errno(ret);
> +    }
> +    nsems = semid_ds.sem_nsems;
> +    *host_array = (unsigned short *)malloc(nsems * sizeof(unsigned short));

g_malloc, or test for allocation failure and return -TARGET_ENOMEM.

> +    array = lock_user(VERIFY_READ, target_addr,
> +        nsems * sizeof(unsigned short), 1);
> +    if (array == NULL) {
> +        free(*host_array);
> +        return -TARGET_EFAULT;
> +    }
> +    for (i = 0; i < nsems; i++) {
> +        (*host_array)[i] = array[i];

__get_user, for endianness issues.


r~


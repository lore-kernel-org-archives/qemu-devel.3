Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF257ECD9B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voBWX-0006ld-W9; Thu, 05 Feb 2026 21:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBWW-0006ky-Bz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:24:44 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voBWU-0008Kb-JD
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:24:43 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82318702afbso171927b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770344680; x=1770949480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAaHEsUR9wSQ3j72iY6cCkBG//eNWK2LReUNp08tHJY=;
 b=GpfAnjIF51DUCJSEdRvPoOCaWF5neX9mB0S2ndoFw8n+GzdJP0GwsDtJnud9h/8SaO
 xwyfcA0OviEu2DOouVKEzX4oBlQw/7ZvvYXyYGjMDg8UOq119E+O5T8cTQYz44pzZwAH
 Q1uYsdBMBXUT7GIJu4lodDDk0lkTkZ4Y2M47OzQ0+cGs/W4Z1J29NOVPfc+eCM3sQ6zT
 HRSqaCUJKaDfZZgogh4BKoJqd2VOrvvhg0mYHqLykDvOB/MKFiZcLd3NCEgsfQ/7QfJD
 QffsB1U4Qztk9q2TM0TNtm3tdmcvVS9ERWLHlENFqP/TIp+5TS/a1jl+dinYarxPX6f/
 mQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770344680; x=1770949480;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAaHEsUR9wSQ3j72iY6cCkBG//eNWK2LReUNp08tHJY=;
 b=ANOJRhJoY3MZtsUNUC+8DLHX2t+EyhXIn68vrscuNJZ0Kb9UgJ+KaWuP0kXwivX8v4
 E8PJbiCPUGgC1EebAfrvW/WW7+QUuxrJnknOz8M/YNRPxA9IJCmJ2XRmRNlOl3fZ95p8
 /vztO9n6+bY1O1IDa6dpocyT49Hh/gsYML9orVmpJeXU+02anGPLiCOVpEjq+Lp7q2JR
 KeZshgVSsh8hYQWzNuOAr2hHDN0YsMCF+hXGi6UXnLhbuZXdv+W/T3ca4XMMyfTAZmp5
 lLZXsOnvpfhexx+VQ9808Vw8Aq3hkuzo3Alz/D6FIGKk4WLx+++MVz9hgy0gjRGsp4y1
 543g==
X-Gm-Message-State: AOJu0YzLITKyvFCe3hGMO5n6KdNAFS0wHjqubm9Dv8uJtuynfgrvspHT
 u0S8WN8U/cH5b8w/Dv7MGoKKOTV2YD6GGHjhawrSa9vN7VlEj9pLuosKoSccw83lzyU72V7P0y7
 uJQomRR8dow==
X-Gm-Gg: AZuq6aLx7Xtd5FUlOrtMC3vN8pDrjfa9zw2ykvBFE6683gfz+Q6Pe45zqinvqJ5sk7C
 z7cPLsdVKDrMtindaXbWtrGFhSlj0eZZaqygBawp9gykWSNL4qBldSHShk9bTba401kzyUGTLrG
 7RZPWb9d+iejHJE9B9SUfJAycHcgZxoDs9wvsJ4WAZBg391nnaCqQBV/SkmsVUtUIDWy3p0U3Xh
 tgzecVCp2P96qv1sDYYI8UZrn3RtCAnDbFWIhourkQ3kxnqIxEqmN22IZBotbUjxAijQ7sBwqRp
 B6s6XkUoG2wywl+WVYtg3kFdv6/ZV+2pFrFMUZEjOB2VAxQalnHahFU1ZxF7r6Z8qb8rFwBWen9
 Gj8NODgQKc60fjf70EMhDNj9fkkpwyWNY9V8DO95m9YiBhT1bseWS0Y/qc0Q/j2diYmWv/91rwE
 y5XsXExu4WtlFzGH9TVi1/WCzQy31Z3mzTn4TGZhgi34vXkuwIxQRaAEe5G6eGEzKn792TZUnQc
 pknW1uQcvb6lMJ6agYRD3GuS5Pttzs3I+flJg+t5qE=
X-Received: by 2002:a05:6a21:6da4:b0:370:73c1:6a87 with SMTP id
 adf61e73a8af0-393ad3775f7mr1227442637.58.1770344680090; 
 Thu, 05 Feb 2026 18:24:40 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb4fbd26sm678354a12.1.2026.02.05.18.24.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:24:39 -0800 (PST)
Message-ID: <76a0a345-b974-45ad-af4f-dd6d5701d999@linaro.org>
Date: Fri, 6 Feb 2026 12:24:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] bsd-user: Add target_to_host_semid_ds for semctl(2)
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-9-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-9-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Add target_to_host_semid_ds() to convert target struct semid_ds to host
> format for semctl(2) IPC_SET operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index 7bdf65450a..581eb50355 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -111,3 +111,26 @@ abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
>       unlock_user(array, target_addr, 1);
>       return 0;
>   }
> +
> +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
> +        abi_ulong target_addr)
> +{
> +    struct target_semid_ds *target_sd;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    target_to_host_ipc_perm__locked(&(host_sd->sem_perm), &target_sd->sem_perm);

Drop the useless parens following &.

> +    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
> +    /* host_sd->sem_base  = g2h_untagged(target_sd->sem_base); */
> +    host_sd->sem_nsems = tswap16(target_sd->sem_nsems);
> +#if defined(TARGET_I386)
> +    host_sd->sem_otime = tswap32(target_sd->sem_otime);
> +    host_sd->sem_ctime = tswap32(target_sd->sem_ctime);
> +#else
> +    host_sd->sem_otime = tswap64(target_sd->sem_otime);
> +    host_sd->sem_ctime = tswap64(target_sd->sem_ctime);
> +#endif
> +    unlock_user_struct(target_sd, target_addr, 0);
> +    return 0;
> +}
> 

Use __get_user and you won't need the ifdef, since the size of the type is then 
automatically handled.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B64ECD9AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9Ue-00068W-KB; Thu, 05 Feb 2026 19:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9Ud-00068O-KB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:14:39 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9Uc-0003PW-7B
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:14:39 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c636487ccaeso510957a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770336876; x=1770941676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGMOW28sv5bdSSj6tQyfXBRc6PgUCnNigUvOgNAOxiA=;
 b=Alju65jXDF04NTBYoYKM8nVFXzeVaOsSsRtZmISXcS92I5yZxkoJzkOG6OPnRUCfpG
 ylUK8jT0mXzI5i7hotMbLI1r2iiwvPTtsdKm3j0IN3TRjwySGMPzOQYGt+DdqMMi8dfo
 qWR1hWMeBHRKc2M68OgbOzKW3KXOT5nHn7BMKmbW6azcn4+I8D8zBBf98eeAfpG+AXP7
 uf834AQ8IwrrDyuMZnpoavfs4gFY3eFba/itQOTPjpbCtM/T2hY5HiPoa2b8d7t8W0dI
 6HhRCJZlk1Trt0vnnucSFP/B7z7wUxM/GMCyb3m4fu9UiucHW3cmXDO4pfmSwtTwrVC6
 YqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770336876; x=1770941676;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vGMOW28sv5bdSSj6tQyfXBRc6PgUCnNigUvOgNAOxiA=;
 b=WA22xEGKHwrMFesGvzaowpVc+2sTy9T2Qk+hUxr3NJcafmhVJDTXuLxL33CW3pgeSc
 YitTMIwMl+Ysbt0hL+IDmeSDj7rjiyLrlXxig/W4d/+Kjpjq2wWsbGGXjXBHhixJXTkP
 hKCxjOz6qzDCqO22y3Cg3kpnvg+70meHRYxYWYeFAzj3fpWSCvFJ34mNXlH2w00MiDEX
 qJcRmZt3vCEmolSn7Yq3jOrNkbcNthNhsQdp/j9LhsXc24kzf1LhLyfB0vPNwD1rqdLD
 C0RO1qmUp5JWH+CLKd5eOszKQagNxAmnALAmjLvnpGR4I+0aVGCBX74AKjgU4ugCov+V
 URqQ==
X-Gm-Message-State: AOJu0Yxqw8P3w5pb3w0NCbI4xjqQo7uaQwQzFxGdnGQAbOoq/kLoZy8B
 Q2oh73LHIL7G0rcHAJcym+nvkyF9X8X79ruFeRwgT37qAL+yzmZacHNpvzv9bZhxW/AXwBKHaZB
 F12vdhM71GA==
X-Gm-Gg: AZuq6aJr1598IRwJfFL93jAYc1b0V4kUAieMWntbAZBuRXCF/Gv5Qc1UuaAIidlS5YI
 QJqpNlw/YDHncuxev0Am1eGQGovWeJ19y1oHtnE0w0U116o2U196NUsDa0fOri8ewRPiR4UUuWm
 kpDed70EvtoD+0oSdCwJzU0+W9vI2xHHD7Kvaq6DL1wDDK5Gh8cwSWfKi3R/a32PEJcQYE6FG7H
 ZRv7gs66bOSR4RjJLGlQxgmLYLD3SEV6qGgLKLtTGwXkassc+Edh2TSxO2BXRb6c98dM5nfQOKH
 SWeS7JLeKdmLuS/JhRIKcEwIVAYOPKj3jpDAoyW6LEnE1arT8nZnlO4DLv/GoOTujn8oD/R8+Wl
 ouMfL2saQL97sgqee1WEwK40eDtNYPW2NLnxY5lQn62pAZ71aFjKVjeVUYOvdcO3f3YSKqeQI0O
 l9ybRMxgrPKtnCu6Yl5M3LuKA0uKTj+cOJZyH3UWcorxciTlcKBt7VLmMkmqf4JJwQk05U+d2+6
 RXskNfZRh+kllqPn5y7U/hjBYIJHeb2Rn0P7ytpfg==
X-Received: by 2002:a17:90b:4c09:b0:343:c3d1:8bb1 with SMTP id
 98e67ed59e1d1-354b3ce8cbcmr541136a91.28.1770336876203; 
 Thu, 05 Feb 2026 16:14:36 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb4fbcbdsm541129a12.4.2026.02.05.16.14.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 16:14:35 -0800 (PST)
Message-ID: <973e564e-73a4-4b15-b83e-1aea1b043e47@linaro.org>
Date: Fri, 6 Feb 2026 10:14:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] bsd-user: Add target_semid_ds and target_msqid_ds
 structures
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-3-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-3-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
> Add the target ABI definitions for System V semaphore and message queue
> data structures, needed for semctl() and msgctl() syscall emulation.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index cc4b484f3a..98bdf8cc1a 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -92,6 +92,39 @@ struct bsd_shm_regions {
>       abi_long size;
>   };
>   
> +/*
> + * sys/sem.h
> + */
> +struct target_semid_ds {
> +    struct target_ipc_perm sem_perm; /* operation permission struct */
> +    abi_ulong   sem_base;   /* pointer to first semaphore in set */

While they'll be the same underlying type, abi_ptr is "more correct".

> +    uint16_t    sem_nsems;  /* number of sems in set */

abi_ushort.

> +struct target_msqid_ds {
> +    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
> +    abi_ulong   msg_first;  /* first message in the queue */
> +    abi_ulong   msg_last;   /* last message in the queue */

Both abi_ptr.


r~


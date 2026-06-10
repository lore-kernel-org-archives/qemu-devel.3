Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C2BCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXO05-0001F4-VB; Wed, 10 Jun 2026 14:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXO03-0001E6-Q5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:50:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXO01-0001UJ-Ef
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:50:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-37474afe908so1713720a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781117400; x=1781722200; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7m6KrAPD4rXQG/wWXko1HPt1/0bD5isu1abW+qBhWjI=;
 b=ukCWr6aaP/LW3fiRvKJwCJDKIoBROcWMxrXXAYaU5hACO7un3K9GCmv1fbLe0sGJPQ
 DF2qaelqrkogPtbvO6LOfPDSeJfHBHPcv5nwje1KgF36cDiGU8ETJiqV+9iXlKTZlrsJ
 /cnGtkeIvZWeJVrv/03TT3o4R8cz9wIZi31sJe7Rt0A1EsoKR821mVQiikW3EGWwbWLK
 r+BDNNi5+qAjlsP1EVVRZc29SUHxQ77jDBmtc1hsl2GYHAj6lOHO4hzvBPQdNbQvztXX
 ojIvTQ6F8zxDAQ0hlXWrtSu+oe4uWvGZ8fJwaBX1tt8LDNm8wIJ422LbvTr1strfHYmC
 WdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781117400; x=1781722200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7m6KrAPD4rXQG/wWXko1HPt1/0bD5isu1abW+qBhWjI=;
 b=VxbGnTrRKMTMXiw0EzWNrg4TRc4QM+RIa85dYQzhu+2CFRuOjOB5urBzg3nrw20VCz
 lLlgWkdaHBvZOPiRoJS1ZKPz+yuXgg8w6LGNXz+vL/cwFsj0hFVZI41/mP7FXKpAm2w9
 z6D5KDisyr989L0K91TkdCXEV7WePCB5isD2i3Pc1G04MAPaBAh5mDz+NtxXLG5XvPdj
 6L7Za+YqekFGmSq4NPPhgPKvIq2sSAXZly4diliXIEY2R3SweE31JGvkMPqKHXbUo7PV
 l/PLLeo7Sa8V9c6h4lCE9tQEmsoIVPjYvxoKQ58cV7QXBZkkX5a9G9soMnj9dJfMyels
 mGAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//7n3yk1c0yJLvqdRT3AacgNihGt8cwDAn4G60UNJWSLmobIXUfbVB5ccU1IZIE5pXhjwYCHaVTpZ6@nongnu.org
X-Gm-Message-State: AOJu0YzvEpcab8UslS8ckgz43o+KaC8JiUyUbR1IlqIlwg7M7hcLD2DJ
 fUC2+53GpcDn/y4pvAt8XZ9Owt9Fb0IwfoE52yOswsiskYZpOw04jcmIlkWls7dp4e4=
X-Gm-Gg: Acq92OGfRlouxsBLHTu+ErAF8YhoVsP1+6ai6+dKPLaz6N4jO8WvzrAPitypIti6ODq
 0VHaFUwx/qH2INM80LhE9YjBu857ruop+mqVBkk67W+/EYmnUXynA0X8klgxcwSVcytLuzxiZ3F
 wn4fjokcspoxK58dSbF7tEoSg8HymM8xH9VkDvuB/MLXpFotf9/9dLoyHb5I7TtGzXElfYe8uCm
 Cn8+ahZaP0SAcs/LxMNCqcMf5AcI7zd0GEco4pMLilvkQ81LW9EoEYaFus3iRXCxf1doSnCpGkR
 eMzbSb/rssdg4mFTWVeSfeXdNQcvu++BSWkIu/2FecIo0go+nDXzzFgqPYt1BHabzAwmygcsaRH
 ZlQGmnjLO8r6n9gq/zGMN7RaV65F46cBDmn2eXMEJSzhy4kMIOOhrEjvhG3n/0Ix7m//sL9QQL0
 C7RN6b6g8/Zc9PVJecqbXVl45vBID7ck8Cp8uxWSVf1FXeckw=
X-Received: by 2002:a17:90b:570e:b0:36d:dfe4:387c with SMTP id
 98e67ed59e1d1-370eed08b30mr28439659a91.10.1781117399594; 
 Wed, 10 Jun 2026 11:49:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37752b5a9d5sm103406a91.6.2026.06.10.11.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:49:59 -0700 (PDT)
Message-ID: <4853852b-015f-4e16-aee3-7750a35b9c78@linaro.org>
Date: Wed, 10 Jun 2026 11:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Implement /proc/cpuinfo for ppc cpus
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, qemu-ppc@nongnu.org
References: <20260610180749.10883-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260610180749.10883-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/26 11:06, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I've tried to mimic what I've seen on two debian porterboxes (ppc64 and
> ppc64le), which are running via KVM/QEMU. I assume the model type of
> pSeries and such doesn't make much sense for some older ppc chips, so
> any better suggestions here are welcome.
> 
> v2: drop colon, add clock output, refine pvr calculation
> (@Richard: I suggest to completely drop the clock for v3 ?!?!)
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: qemu-ppc@nongnu.org
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/ppc/target_proc.h | 91 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/ppc/target_proc.h b/linux-user/ppc/target_proc.h
> index 43fe29ca72..6d78c0f543 100644
> --- a/linux-user/ppc/target_proc.h
> +++ b/linux-user/ppc/target_proc.h
> @@ -1 +1,90 @@
> -/* No target-specific /proc support */
> +/*
> + * ppc specific proc functions for linux-user
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef PPC_TARGET_PROC_H
> +#define PPC_TARGET_PROC_H
> +
> +#include <time.h>
> +
> +#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF)      /* Version field */
> +#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF)      /* Revison field */
> +#define PVR_MAJ(pvr)    (((pvr) >>  4) & 0xF)   /* Major revision field */
> +#define PVR_MIN(pvr)    (((pvr) >>  0) & 0xF)   /* Minor revision field */
> +
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    struct timespec res;
> +    double freq_mhz;
> +    int i, num_cpus;
> +    unsigned int maj, min, pvr;
> +
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(env_cpu(cpu_env));
> +    DeviceClass *dc = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
> +
> +    pvr = pcc->pvr;
> +
> +    /* Taken from Linux kernel: */
> +    /* If we are a Freescale core do a simple check so
> +     * we don't have to keep adding cases in the future */
> +    if (PVR_VER(pvr) & 0x8000) {
> +            switch (PVR_VER(pvr)) {
> +            case 0x8000:	/* 7441/7450/7451, Voyager */
> +            case 0x8001:	/* 7445/7455, Apollo 6 */
> +            case 0x8002:	/* 7447/7457, Apollo 7 */
> +            case 0x8003:	/* 7447A, Apollo 7 PM */
> +            case 0x8004:	/* 7448, Apollo 8 */
> +            case 0x800c:	/* 7410, Nitro */
> +                    maj = ((pvr >> 8) & 0xF);
> +                    min = PVR_MIN(pvr);
> +                    break;
> +            default:	/* e500/book-e */
> +                    maj = PVR_MAJ(pvr);
> +                    min = PVR_MIN(pvr);
> +                    break;
> +            }
> +    } else {
> +            switch (PVR_VER(pvr)) {
> +                    case 0x1008:	/* 740P/750P ?? */
> +                            maj = ((pvr >> 8) & 0xFF) - 1;
> +                            min = pvr & 0xFF;
> +                            break;
> +                    case 0x004e: /* POWER9 bits 12-15 give chip type */
> +                    case 0x0080: /* POWER10 bit 12 gives SMT8/4 */
> +                            maj = (pvr >> 8) & 0x0F;
> +                            min = pvr & 0xFF;
> +                            break;
> +                    default:
> +                            maj = (pvr >> 8) & 0xFF;
> +                            min = pvr & 0xFF;
> +                            break;
> +            }
> +    }

Reindent for qemu style.

> +
> +    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
> +        res.tv_nsec = 1;
> +    }
> +    freq_mhz = 1000.0 / res.tv_nsec;

Seems ok.

> +        dprintf(fd, "processor:\t: %d\n", i);

Still have an extra : here.


r~


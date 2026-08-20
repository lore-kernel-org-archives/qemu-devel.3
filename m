Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D966EC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4Zz-0006kr-3v; Thu, 20 Aug 2026 11:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4Zw-0006jW-7y
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:21:16 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4Zu-0002ca-Hh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:21:15 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2598539a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787239273; x=1787844073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JBiklarrCZGlNuTGlfjF66tiZXZ/iOMyq4iHSICM5cc=;
 b=RM0YQ7zj9vNJ54qF0TPbhzeRzS32C4bekijOaOS6twd3AI+pfaruq+l9THl46cdiUp
 DsL+8Ms8yb9WXCtMcDce6KmvqF+f5cx+Y3+uPKpZeYt4z+NG2L87BjZPqWe9fmE3XRGr
 rGP+WfSN1HpWn9ojSwvL8mA1Tj/OLuzVLpKKMxxgAuSGK/pPbGls3rCiL0R3WRtYDzxQ
 dYaxXe0Z0OPSALS4T/4HHZG7/36lieaU7JmvkXHBdTFQpuBJbFMDw1l3/0KWQnusc9Q4
 B69taZEGxlXPGNOp+FxW1vWefo6fZzrEuptml9ffXPn9cAaRr6iNiLeA/lTzwTKzLtLS
 YhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787239273; x=1787844073;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JBiklarrCZGlNuTGlfjF66tiZXZ/iOMyq4iHSICM5cc=;
 b=HOGiD42bEfC5H43KyOxDOMy1EYEov7PAvEtArBppi3Mdp+ElC7uoTs777v7Hdnxis1
 7etaidML3lt5zFkze7rZuAhoR1OVqcDsxcJJg4GucxDMEaPOyfl0NHGJK2Dl0vhcHSkS
 Im48d04ECk6vCgCRW3noC2J0gdE/BUl1xSdw7X3lJ36pNreNp0IRAGA5gT62v3xwJL/D
 pS8lwQ1FrdSodCEV1L32O+Kpeze8sALE5TkDACLAgS5FrHGgEDIcuMX3eBezx8KScaHo
 LUXpFJG5bvowwsIZBwqxPpMoeH2783rflA3ns1qZjDhYCLzBaoNr81T5VD+/k+wwyp+R
 Rj2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7BgnPpIMaM7YTF8mlUZW7ex7FAE4lbU4whT9dnPzE2sAPy1pOWwdmOKsCx00Q9azEZ+1nIRcb+bVz@nongnu.org
X-Gm-Message-State: AFuF++mdycd0I/lsW7FJ3z0q1yWnT5s0t4zexwD1ovhL4ygeJVxp+s19
 zunRyozZF6ZWnFPFiHi1JV7HgbFli8Go3qWd7MHT0801efGxntYR3y8anLqdieYSMgw=
X-Gm-Gg: AR+sD117ZPcYsCzWHbdqGJ/+/U/0i3aIOD9rQkhF6b59j4oJC0KsfDfYimXtYMsDzzm
 tdTR8Wz69ueVtDUF5wIvnFAJs+o2+MoG9Bx8C28bvUhmEtJQ7E574qsRxl7uWzrtivrtfQ/rTx6
 d3Fh25/g8gnfRqNKmbKe4NVGPailZun6OWgMCOxHeRXRUEOl0nNbHsvMJfa5/1AbuBqG5E+BTtl
 wPK4dEezxCqrbXZfKqzdzxQ9X2eMuj8Kgb193NSiWsnIzG0SxK5Cj5sV1afj9UvVP/xLjiAoRWk
 FR9H71SBfzEpTE5pmU0B4QROVUTy+fLoiM0cg18w3KJUIxGZA9UomX+sWCMETiu03qjbVB3WIKR
 qJ9sg9lTCAlBrMw+f+Seo/A5hFJ/7Y7QLnSvSZTMjG1LGtjraXNww0QNRUas8DEWkzyCXn44T9L
 AjRZsthUkbfnzar2ZzSheC+eP6ntKmouWW80Y7hVF47cxhcOlaBUxQ7iu+rICeRItZ6W3CQyGm1
 rso8D8=
X-Received: by 2002:a17:90b:390c:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-3958110c03emr21321281a91.10.1787239272449; 
 Thu, 20 Aug 2026 08:21:12 -0700 (PDT)
Received: from ?IPV6:2607:fb90:331d:db6f:e6eb:39ca:2251:a26f?
 ([2607:fb90:331d:db6f:e6eb:39ca:2251:a26f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17f48sm7805182a91.2.2026.08.20.08.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:21:11 -0700 (PDT)
Message-ID: <0b70e3cc-e14f-4737-b265-c7d12898169a@linaro.org>
Date: Thu, 20 Aug 2026 08:21:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment
 accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820104730.25462-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 8/20/26 03:47, Philippe Mathieu-Daudé wrote:
> Introduce const-qualified variants of cpu_env() and
> env_archcpu(), to safely access CPU architecture
> state when it should not be modified.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h | 11 +++++++++++
>   include/hw/core/cpu.h     |  6 ++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6594f7fa1be..f3a3799f451 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -79,6 +79,17 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
>   }
>   #endif /* CONFIG_TCG */
>   
> +/**
> + * env_archcpu_const(env)
> + * @env: The architecture environment (const).
> + *
> + * Return the const ArchCPU associated with the environment.
> + */
> +static inline const ArchCPU *env_archcpu_const(const CPUArchState *env)
> +{
> +    return (const void *)env - sizeof(CPUState);
> +}
> +
>   /**
>    * env_archcpu(env)
>    * @env: The architecture environment
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 81af7b9ee1a..59f777f3f15 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -594,6 +594,12 @@ struct CPUState {
>   QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
>                     sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
>   
> +static inline const CPUArchState *cpu_env_const(const CPUState *cpu)
> +{
> +    /* We validate that CPUArchState follows CPUState in cpu-target.c */
> +    return (const CPUArchState *)(cpu + 1);
> +}
> +
>   static inline CPUArchState *cpu_env(CPUState *cpu)
>   {
>       /* We validate that CPUArchState follows CPUState in cpu-target.c */

I wonder if we can use _Generic to make this automatic, rather than have to choose between 
two different function names.


r~


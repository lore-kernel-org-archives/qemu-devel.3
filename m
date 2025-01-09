Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C3E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqYx-0007RV-LD; Thu, 09 Jan 2025 06:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqYv-0007Qa-R4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:18:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqYt-0004XZ-Un
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:18:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so9854105e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736421530; x=1737026330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ME0+3AFyXLGdqFXUo3zVv+IGspfWxTahIBFqoUfx1Ns=;
 b=R7Z/QS74XLa3+9Zeevfj1kYfWI95r9JOAPqHMPTT8JtJBuNne4wpO6ypdypN5p/gnl
 Q08qtdZoRpTEEr7sYMGqNasSQpyQ+HnCLtES08d92jvGRxgqSFTO/xX7vVVAVz4wMy8x
 5Lv4KIRBahOwwlab0mUI1wZ214l5Y5wTXbuPWX5l4Q5UeQ7/6kWF9Q1dbCGAjnzTRgwt
 BJk296aZ6Vh0U6v40OUHxNw0gGAWtk4Njl+CWu9gX690Oi170/9lj2/oOipmPKyvkbS1
 GQ+h1C1ABzMIfySqfMGSdRlEQbXuWEOfFd+3xp8mUIj8z9ZcTDqPCSqesqIlSzAVbDwB
 Cs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736421530; x=1737026330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ME0+3AFyXLGdqFXUo3zVv+IGspfWxTahIBFqoUfx1Ns=;
 b=D2n/O2l5V5f6w+XV36JsR/ekcIFtBJMqBeqXJ110t4W2CxC8nhHIlKA1oLgb/K8fLN
 vDWmtPtSJORR7BPU292ri63d6WhBVcB2/yHTL5AZFSTPFkWxgWPXQc3PAIbS2Igw7R3F
 RAfLRx8vkCkKVGnu3CngWtRn8X5nxNr5XqzLIVUbrUqUOAgiItDRiKHQ9yLDFiehSd2e
 zyaeh0Av5bs87rm8e0iknz2HDr9XFg4NjAGauSaTzQFyeZLfnbqqp0AT60x73TgsDRI0
 w1u+AoSsHveYjx/r792t6+Bx5eLXtJStPMWzH68rC12TtvGKXFyNpoCORpBxGA8ud93K
 fkSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/5dQnrtIVdw6i61rRSAb1Ud7gINre3cihHneo5E3OTNjV2pFc3F3v1jyihA4pFTEctcHk2yR0mW5t@nongnu.org
X-Gm-Message-State: AOJu0YxIFU94Uqjxe5j2Iz0mFDxdj7Bl2j2gthk/RXXD2HsQkpSZP1NY
 VfxZVS93GNaeJ54krEfWL5x9N35zUu8Ajj9giZcWuVCNi5ZuXjSVCyKULGoNQRM=
X-Gm-Gg: ASbGncubYGQrhCo+Xxok/KurVkF3wwnM8EGeS/tNPyJoZQd5vRI8T2mrZ7uMCb1tk1u
 4NYJrMqu0WlysMzJpSq353Lsn59Nl6kT1itWRf/UWLOaoe8PPIwWhP6qnbL3+sgmm4iZGeq7NZN
 CbiVl0Ae3TUvZ+KFkIylb2BfQItsQxhVifm9orcLANc8qzsmwI7AZ42cCrp6gwyGOJim7wh+mLk
 SDImQLES+5vWAxDHHkD6tuT3GAXcLa1elbB+rpklkF65/vQbpeCQA/vq03kREJ8EL5Q7YD9xD24
 hkmBrcEhS+56Pd7cuhBoJq9K
X-Google-Smtp-Source: AGHT+IHxltDmN8R2Exw0WE83WeQQVgR4NuppXtMw+Va+iaxJ0DlHZ5eXIb6MJb4IqtyMUFDEgri9wg==
X-Received: by 2002:a5d:5986:0:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-38a8733a214mr5702120f8f.52.1736421529927; 
 Thu, 09 Jan 2025 03:18:49 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2dfsm1529283f8f.7.2025.01.09.03.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:18:49 -0800 (PST)
Message-ID: <718a0ab6-cc07-4721-9560-7745ed1c04a6@linaro.org>
Date: Thu, 9 Jan 2025 12:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] target/arm: implement SEL2 physical and virtual
 timers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org, Andrei Homescu <ahomescu@google.com>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@google.com>,
 =?UTF-8?Q?R=C3=A9mi_Denis-Courmont?= <remi.denis.courmont@huawei.com>
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-4-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218181511.3575613-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 18/12/24 19:15, Alex Bennée wrote:
> When FEAT_SEL2 was implemented the SEL2 timers where missed. This
> shows up when building the latest Hafnium with SPMC_AT_EL=2. The
> actual implementation utilises the same logic as the rest of the
> timers so all we need to do is:
> 
>    - define the timers and their access functions
>    - conditionally add the correct system registers
>    - create a new accessfn as the rules are subtly different to the
>      existing secure timer
> 
> Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> Cc: Andrei Homescu <ahomescu@google.com>
> Cc: Arve Hjønnevåg <arve@google.com>
> Cc: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> ---
> v1
>    - add better comments to GTIMER descriptions
>    - also define new timers for sbsa-ref
>    - don't conditionally gate qemu_timer creation on the feature
>    - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/g_tval_[read|write]
> v2
>    - rename IRQ to ARCH_TIMER_S_EL2_VIRT_IRQ
>    - split machine enablement into separate patches
>    - return CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases
> ---
>   include/hw/arm/bsa.h |   2 +
>   target/arm/cpu.h     |   2 +
>   target/arm/gtimer.h  |   4 +-
>   target/arm/cpu.c     |   4 ++
>   target/arm/helper.c  | 158 +++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 169 insertions(+), 1 deletion(-)


> diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
> index de016e6da3..f8f7425a5f 100644
> --- a/target/arm/gtimer.h
> +++ b/target/arm/gtimer.h
> @@ -15,7 +15,9 @@ enum {
>       GTIMER_HYP      = 2, /* EL2 physical timer */
>       GTIMER_SEC      = 3, /* EL3 physical timer */

Should we rename as GTIMER_SEC_PEL3 for consistency?

>       GTIMER_HYPVIRT  = 4, /* EL2 virtual timer */

Also GTIMER_HYP     -> GTIMER_PEL2,
      GTIMER_HYPVIRT -> GTIMER_VEL2?

> -#define NUM_GTIMERS   5
> +    GTIMER_SEC_PEL2 = 5, /* Secure EL2 physical timer */
> +    GTIMER_SEC_VEL2 = 6, /* Secure EL2 virtual timer */
> +#define NUM_GTIMERS   7
>   };
>   
>   #endif|


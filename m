Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA45CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x9q-0006wj-Q2; Thu, 09 Oct 2025 16:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x9b-0006qM-O8
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:22:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x9Y-0007mZ-0G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:22:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so826659f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041337; x=1760646137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aKSswabPU/8R3lhuB6jBAxLqRgzybmIf+RPVJzc6u9A=;
 b=OKDtShxaMIDaCdElJ6mnG/v0rNYYJybzi+Ix2R551MyuDaHnK75p3dV0V+Wa038WPo
 355C7EtE7RUdOs/ZVqG6GpH3X5Vg51TFp7LwBB9ryJCZtJ+8v6oVlnlqno92bFq/BEVm
 DBR5xFi2h406kDSatrn8+hLEj3zyMe4fnyMFyy7ZBhyZ7L4ZAx8OvfSCPJXklYRctuWS
 nHCDxAOMOkrC0ddTetWz75op2+Qt+13GhIKd5Bfvic0UjMq28qO97Zp+VeCeDQamjcM4
 PP03LdiNe3UvNSSRL3OMCK8/8igzDHWjoEkSOROXz4TFlpc9IeYwOnEB9JFKtAhlqguk
 rm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041337; x=1760646137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKSswabPU/8R3lhuB6jBAxLqRgzybmIf+RPVJzc6u9A=;
 b=Ey/hlpx1SWel0Nmkm028FWQqYTcG9P7fQF31pgOfRd404OF3CMSbeLABrm2W2wFFlC
 GlrcxkMRgx099fotkaurjvhnI+7IbTsOO/+ZOqP+nIkdVk5MNFftSOfh3u53Z9ioR0b3
 PyOyBDUM0QFkXNdNLtAkHaBcvsnUL3nv+/V4AajpUn63yZPk92FBWzarSgCeQaC5cjRL
 jJgydvou5UnndVJ26QQ5KMIqioODm8dvF4IweITcoc1hY/BWI7I/VTzceDi9OvKCU7cc
 EgjNcJLdaE7HGbmxLytYAa3Kou/xXB1Blhpjf8a+cJaBBjM3iJ0/SSvziQftwDzp+GW4
 zylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU1GsD3axGCdR9fvsc0Lttie4nkwuFRPmtWbsPOJyXpzn7zmXXv/a8Ls2Z44goXwnEgM5vY7tq+b9k@nongnu.org
X-Gm-Message-State: AOJu0Yz6Sk+95/o9noAzCnExmf+aHMs65wUAZW+lGHBq+hI6ZhrjW/Rs
 zH7twlGh9FjRzvmBfUJJxUSozy2xxZFLwqFs2CTx6T+/UP6f+zEBsz0qRvPsoqzO0wQ=
X-Gm-Gg: ASbGncs6kKIMn1RKRgDI9tGtVCRsksRq6EXXjBEdlhU+JxqjlQQY2jXka6uVH8C7tci
 stQKgWkxM2elF35Xz85Z8nte4ufAhratGIYa4IzAc67dQa7GOwU6JMripxVrFUdRyp8ckjPEQbv
 o95xkz6U7new6CYnc89FSgh4db+qLlymR8xfcYQavvR/T3aiR9P2DLNca4K5J+580G/r7iwf3mK
 2oC4CypHnoVhRf9TaqR/D1ht+oK3PyzeOmmAJOg9mwYB5179mLMRh6a3M0Yoe3SrtT08bO5Hhim
 P0mv20JNSCepyg0zAL7aTnprQcBDDjD3w5DTuRM3KWR6eLETiE/d2ZFoAI9KbjMAcuBnjLqLHRn
 qSrkd7P+U3WDERQbOCiIHkJMpA8xnuEekVv2k02qJi2tNAeTrkSzrog6z7Cha3xer4k9MnuxKex
 /0tJv5g+Mum9OC23ckf6Q6d5usRF/P
X-Google-Smtp-Source: AGHT+IF9y7060pmQ3TIL5BAGiH+K9B7/YIYtPFzNLvWdRSHHjAd4h8EFbhzrbZt0eAgPQ54R5l3ffA==
X-Received: by 2002:a05:6000:310a:b0:414:a552:86b1 with SMTP id
 ffacd0b85a97d-4266e8e48ccmr5712641f8f.63.1760041336945; 
 Thu, 09 Oct 2025 13:22:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e82dfsm625224f8f.52.2025.10.09.13.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 13:22:16 -0700 (PDT)
Message-ID: <e61d9cbd-62eb-43f7-ad82-904ae4ba9ee0@linaro.org>
Date: Thu, 9 Oct 2025 22:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-user/hexagon: use abi_ulong
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
References: <20251009195943.438454-1-brian.cain@oss.qualcomm.com>
 <20251009195943.438454-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009195943.438454-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 9/10/25 21:59, Brian Cain wrote:
> Change the user_regs_struct to use abi_ulong instead of
> target_ulong.
> 
> Link: https://lore.kernel.org/qemu-devel/7bf3d8c5-df07-4cbd-ba62-4c7246a5f96b@linaro.org/
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   linux-user/hexagon/signal.c | 52 ++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
> index 2847952216..e5514b2bec 100644
> --- a/linux-user/hexagon/signal.c
> +++ b/linux-user/hexagon/signal.c
> @@ -24,30 +24,30 @@
>   #include "linux-user/trace.h"
>   
>   struct target_user_regs_struct {
> -    target_ulong r0,  r1,  r2,  r3;
> -    target_ulong r4,  r5,  r6,  r7;
> -    target_ulong r8,  r9, r10, r11;
> -    target_ulong r12, r13, r14, r15;
> -    target_ulong r16, r17, r18, r19;
> -    target_ulong r20, r21, r22, r23;
> -    target_ulong r24, r25, r26, r27;
> -    target_ulong r28, r29, r30, r31;

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



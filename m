Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE3E88D69
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8m7V-0004GY-NQ; Fri, 03 Apr 2026 17:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m7U-0004F8-A0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:32:00 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8m7S-0004sO-UA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:32:00 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3591cc98871so993878a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251917; x=1775856717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmDyxPnfruQ2f/86WMPLM9VunxPOUc4NK0eBB5Qwglk=;
 b=Id96kUcyRnLty0EDWJ9wYftFAIZIrGj/MvoA/xTyHae4Ycj6RTnugHYKx4Uj62dOPT
 jbgNW4dM0TY2f2vxQzuL0Ve9FqB6XcesANBwSJcdl53U+w4punw2tphhXIS/Jol/J6eW
 U0ApXKBmCSJmoWq0PvMuslKUPy4BJatA1FVC13EZHVGe6Z3R7iANhG+tKUbusaisqAPP
 oUqSpHfI1tSgZ0VYSFKpWIZn8d6sjGg8F8e8VmxcG7kpoSpQCHm31zsKrQxdi5EVbrw6
 7Hp1EVlSR8G0VsshM9nTucfRrr4JXThI/PH2asw4pmRLt7smZ96aaNmqR/ppwgPhjUny
 luBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251917; x=1775856717;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WmDyxPnfruQ2f/86WMPLM9VunxPOUc4NK0eBB5Qwglk=;
 b=hsihnEk/Ow67JnvGyWpJvZp7t0FTACbvBf4+gCtDQi8mN7ve2qo/4JF3HRgZdQos2X
 DIALq2vd4w5Kn2BcJulUg3WDlA5PdGv//WXuQYicU8cerPYPNRZcuqNlkTKHbbZ8IapH
 pAJZavhhqP4zHXknuWEzoEZMHIqsgYVmqWITgQWIyLc2cFbfRlbdhX9+MLUfkL/5X6ob
 IJSd0UhnkkVNcKyz0U6mq56W7uCsOMIy0u6zYvh5MGnycesk/2kNXxFcsUHB/DwlKJ5o
 Wri0aM+JRxty1gXdiXoYAExY+YAjyLp+ut1cLnZEx1mouQzzJWa61pBylbceJXfpryaB
 onNg==
X-Gm-Message-State: AOJu0Yx2lIknO0KU20xwiLgHUWXVzVqMPcuwQjtkJd/QFPalzqe9J9Pg
 cnbboHL0SRKVFHfqCOU1+5zSivTF++/L5m4EOWwhT23hf0aIf7nFjYhpZxC+6w4dv72Y/QuQLyP
 7Iz0BuDk=
X-Gm-Gg: AeBDievL6pcElyaWhqzaoQuX4CNRVHQiRfTpeN19IjOutp2ZzQnBiNycET5p67FqxcT
 Bd8CymlGYWNAzdpeQ5vx8mTQbsEcoYNNoBjMAZdaIthnGkRZ24RvUWFkMWoIw7GUYd3ZI8HBjmW
 SRFDa9ieCwQBIWo1cBM12DbFyGPYTlPDGg+XNvL8t/GFwdiH0AN+FNLDXwoFAaHAnKdGZhAtAqL
 U5pOCI7pKzo4JIJca7LDM2EZyEat0Dy2N5xiSBjD15H8NwkaEwgld/H7SUydOJ5Dw78YzPhU2ef
 vu3G6jtzqWHGc0Va1CBp1cxDmwUsNO3B7Dgwd+Ik+uurP5zRI6wvx3zjIG04j18D4b0O1vvW/QC
 DpteGC/7fkvviY2cMYxGYFr9zgCImKM2HU/t+vonbVtirZNG2zOKWy2r8ItrQBD4kNqWfcPgGu4
 a3AgFLBP/o5Jad+5wgIm3r2p5OywCO5Ta3g4SosSYXQSvJF+f43W1kVcgrZjgKjBj1yxo=
X-Received: by 2002:a17:90b:4b89:b0:35d:a9bd:1ff6 with SMTP id
 98e67ed59e1d1-35de695fa86mr3598786a91.23.1775251916924; 
 Fri, 03 Apr 2026 14:31:56 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe95abc3sm12537387a91.15.2026.04.03.14.31.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:31:56 -0700 (PDT)
Message-ID: <e02da1c8-9f48-4dab-b4b8-302ab8c69d74@linaro.org>
Date: Sat, 4 Apr 2026 07:31:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 5/8] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
To: qemu-devel@nongnu.org
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401201753.92290-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/2/26 06:17, Philippe Mathieu-Daudé wrote:
> Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
> compilation unit common") which replaced the target_ulong use in
> arm_handle_psci_call(), replace the one in hvf_handle_psci_call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd9..678afe5c8e1 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
>       bool target_aarch64 = true;
>       CPUState *target_cpu_state;
>       ARMCPU *target_cpu;
> -    target_ulong entry;
> +    uint64_t entry;
>       int target_el = 1;
>       int32_t ret = 0;
>   

This could be vaddr, because entry is the start pc for the on-lining cpu.
But uint64_t does match arm_set_cpu_on declaration.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2B2CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eyv-0007Dt-9X; Mon, 22 Sep 2025 07:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0eyn-0007Bv-47
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:45:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0eyj-0004o2-PM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:45:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4694ac46ae0so27470205e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758541503; x=1759146303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8GPgQ+ZBnofQntEFxmbcCSolGQZQeJ6GKK8FUgJvcps=;
 b=JYTZwjwqGKq02ahok+1FnXMKX95BBe1DrYHW+bPILQh/zDkgwoZ/yNTMsbocjhC++Y
 uasZsAwemrbJVQ+zqAA/UxYP55piYx+VshBJaBNQ0/FR3HTKRw+ui0LsGFhNsErqlRsg
 IGMDoKbYPBTR1verQp2Ea8pEcs4pOKPHqT7fA1v+aCfTsDHaRupyhzfSHKTc+L8zUgYX
 almnbhwqnZedm9QYZXeM8DICDar6TCkLECZA9iy8eL46L5YHpJLCig/iCXhTXHWwfSoa
 XvolsLOk5AnbFa+5IWTiLHjRPLcJNikffVsYi9rCQxdls4V1vXMM3GyalI3EyEIebUcc
 nK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541503; x=1759146303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8GPgQ+ZBnofQntEFxmbcCSolGQZQeJ6GKK8FUgJvcps=;
 b=S1YNA7wciPZglj6n52Cuz6vWicAIllsnRFkqvRNuIqWBOuF3lZNKlb756ZOPM2fDgI
 Rd+gwoYzX69jEpITHhvusJXtFOcotpM0OgpDmuMQgnj9J+URl0z8OYqYKG/c0C0jMMdd
 a6GBnWAQ2X1JE/1cVzOPtdsepi7T3f5t7S9hKeXO2nMo4c9EcyDyluNUqBx/5mc1jYFl
 vxwx59lIEL281b0HDnVV9KL1o0FT+Wrp9pzNcDMBe3RcJiQoi2u0Uao5DizW8okxYqvi
 QHoI6oGoH4zMUi1/zzHhygGqCyDKygfLfHiODCXcz12/q74jp77LGyhY6ezCi/w2AKDf
 7Odg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQfd3oqWiJdTVqXL/8H8aGvrVi7dFCO5RNwsdwV/sRH6gay5E9bqNCVZKgFqymhFwR2cvxHR3/A1jn@nongnu.org
X-Gm-Message-State: AOJu0Yzyupi+wd5IESqj1vXRzavUznm8HC638NmmK9Lj/csLNi+B+jLt
 pQF8k1rDQl1XwMbNeSQsSlefEGaIpXRsjvLtzfFMJcoy5oRzESbzt5xpCTByZen2okY=
X-Gm-Gg: ASbGncubtDKtAxsuLB8c87d7EacausN0Li3O6LTCVCmZ2j+Gx1farHhkYo08FNCTyO7
 DVa3ybyyMTs6v3tHOTKImGYcwrLf/47nSb14WjMCfFdVn2nT009Eqm1oJ3Lxre+6/4cQ6f248SP
 yf2k/tneU2n91Ab3qTbiN/9tIlaSF76Y9eCpb4xkh1yHTB86JfE4WVa3Wqzj3HD4OVCbqea57yP
 /vM6fzJIXNZSW01cvRosDb4e3V8PDvGcXUNMbcLu7x0dqha5orXvy/F1lDZY84V0/WorDGc5Tbd
 GmkBtqvvE1BT7WDb63B4K0/Z0Q1B1QlyOJQsSYHU0VoEAVoDBuamMw1g61C9OMz5lvUZx4ICWq1
 9wMQOVQCkk+X2YMToE5oiJJGiddOTUkM2mcvXZ+nf3dYOEatCHHeOb201EyoOmeXCeQ==
X-Google-Smtp-Source: AGHT+IE+byEg1s+YzwMbCwqMro+S6ZABiylmsVF7ChYNOBKEhvRmTahbZAk46Hxcn/RAO7HavHyGlQ==
X-Received: by 2002:a05:600c:3595:b0:458:bf0a:6061 with SMTP id
 5b1f17b1804b1-467f00c5fd6mr166044545e9.24.1758541502958; 
 Mon, 22 Sep 2025 04:45:02 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46566f72354sm198210695e9.3.2025.09.22.04.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:45:02 -0700 (PDT)
Message-ID: <449d90c7-c6c4-4a89-adc7-4a3fdbf837c8@linaro.org>
Date: Mon, 22 Sep 2025 13:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/25] target/mips: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <cover.1757018626.git.neither@nut.email>
 <f3896fee60c263aaa4890094ec0d1acc39da8595.1757018626.git.neither@nut.email>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f3896fee60c263aaa4890094ec0d1acc39da8595.1757018626.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Julian,

On 4/9/25 22:46, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for MIPS targets. We consider the exceptions
> NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
> exceptions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index 1e8901556d..566924b079 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -18,6 +18,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/bitops.h"
> +#include "qemu/plugin.h"
>   
>   #include "cpu.h"
>   #include "internal.h"
> @@ -1034,6 +1035,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
>       bool update_badinstr = 0;
>       target_ulong offset;
>       int cause = -1;
> +    uint64_t last_pc = env->active_tc.PC;
>   
>       if (qemu_loglevel_mask(CPU_LOG_INT)
>           && cs->exception_index != EXCP_EXT_INTERRUPT) {
> @@ -1052,6 +1054,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
>           cs->exception_index = EXCP_NONE;

I wonder why this code path is different. I'd unify by removing this
line and replacing s/return/break/, then handle in the switch case
you add at the end.

Anyway,

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           mips_semihosting(env);
>           env->active_tc.PC += env->error_code;
> +        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
>           return;
>       case EXCP_DSS:
>           env->CP0_Debug |= 1 << CP0DB_DSS;
> @@ -1336,6 +1339,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
>                    env->CP0_Status, env->CP0_Cause, env->CP0_BadVAddr,
>                    env->CP0_DEPC);
>       }
> +    switch (cs->exception_index) {
> +    case EXCP_NMI:
> +    case EXCP_EXT_INTERRUPT:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +    }
>       cs->exception_index = EXCP_NONE;
>   }
>   


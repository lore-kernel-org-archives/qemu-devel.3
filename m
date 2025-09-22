Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF18DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0et9-0004bx-Pi; Mon, 22 Sep 2025 07:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0esc-0004G3-2N
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:38:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0esR-0003BR-2e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso14839705e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758541112; x=1759145912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9/xXQlctWLNQ/NhVZbnd3WaXEEUa8QWXM/80o3JOUE=;
 b=qHynglBKjmOJxyj7IJgk0LR31WS39ArLxf0XacaTSyJOX4MgpIidC12ert2s10AkU9
 5hsMl9pTWXabcCx4b76/Iytg1p0ep3l70rkh58cia3nS9/RObEpgDLHYSAqElK7TH4gs
 O/qgfHG1e/kzUyuckuEMV/JxsqG7Nlvd3DY0DwzGrdPv3C3Pd0YmdLBJy/T/9CB0KX8J
 b6IB4a5mqIgIFcDhHpFfMY00yolgfRluKie42HcUvsb5Vb8L5brwcQ9iqOqk23V/qg3h
 ZYrBnG4dahrIyHmIJVXymSBBAScc1RpLo9q9uL6MbeBPdEcVLYQcatR2GBDxk90HmDzF
 EI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541112; x=1759145912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j9/xXQlctWLNQ/NhVZbnd3WaXEEUa8QWXM/80o3JOUE=;
 b=suQp4RKKZljmf4qQFWbIOQuRtsi+KKa+83351fBliQuNPtkkaN5MllPeALqmIEtbcf
 IGpgJD6vdnw4FxUF4Hez9GUTIIhizgnTM/QNi0UiDo8l7bZ2blRp1zIL12rMV7hEv1vS
 rrx7+oHYrGVN/aaEvXvYkZKlPSLVp70RudKraf/QXnKLWzY2vuslHzbYnWlGsOO2RNid
 nIYYOPlR8XzzcOZgmk5fcBCMPMEOCp89mwpQXd/1Lk4pC/LDtvj1RulZP+HfktkB+MP7
 6k100+b93qw09qJX1T6Evyx1K/xqi+nMyxhhu8EOom0owyH7bVXExuECPFu2EQ/Sgshg
 YSag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5pV95hJJhnv6OQcGTx27lHNCRG5Ucroucu70qMY5lV0Zrj1bO1TRiltObvgFv78nwrWZwnhkHdQhn@nongnu.org
X-Gm-Message-State: AOJu0YySPsSzYnG+fIvw++ok1a4brn0SFImQxO4UYc5SyC0vaj6//nqr
 rxVUj4qxFMqX8TZnfRHagJ3tXlfW/skJhyJYh720z+NYb7VD3LTwKseE8nY8S8VPeTI=
X-Gm-Gg: ASbGncu+tdaQBWrIllX7QCvJlccTV9LEjnDFC1eAmVP8hn1YA7PNF1USpl0ewLXvWuU
 DRbrBSRHap92hN8wzlMMRmFSe5oP0VX2gXYz8WjuGfx9QQxQgZUTo/ScRG7UkTjQhcUZOT/Dcjp
 VeNhELerNMBbBBNQiPaLJFcwq/GpioQ5AZ2+HF+EcU6ipgsVOygu5WMUjTYFKbJ3B3/dWYN6xY3
 qBIpLsZKzNPb17e4vfqVZQuWU41Q3PwveTqit4B98PfMfkvtrzBpzGIcG+DIjkGzdWAh1y+8WKF
 yFj/AsfC1mE2iz7ADNEZg84QJPT+CZ4nDW3ntNOb10q8Wfbu79T1gb+GRBRTxYTDZiCR59Abk8e
 ZWX3P1+C+WUFvRF7EuFCW1yWiOp4rqCfNM5Edyeo/A6zkG8r2bda3nT154qoGmz3SJA==
X-Google-Smtp-Source: AGHT+IHE9hJgsUNfA4P1nbivBX4kfP7PhSYFmOenCPS1PpPxr8D3zdPCQvsUmw6mcI0d80z5RITaqw==
X-Received: by 2002:a05:600c:4e8d:b0:45f:2cd5:507a with SMTP id
 5b1f17b1804b1-467f205a3b1mr87035965e9.19.1758541111831; 
 Mon, 22 Sep 2025 04:38:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e15d1610fsm15697225e9.7.2025.09.22.04.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:38:31 -0700 (PDT)
Message-ID: <fe7c9f9a-3198-44ff-bbcc-2ede230b2278@linaro.org>
Date: Mon, 22 Sep 2025 13:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/25] target/hppa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <cover.1757018626.git.neither@nut.email>
 <c0b0251e53f1d602cfc333c53c6aeb723d9ddf01.1757018626.git.neither@nut.email>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c0b0251e53f1d602cfc333c53c6aeb723d9ddf01.1757018626.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/9/25 22:46, Julian Ganz wrote:
> We identified a number of exceptions as interrupts, and we assume any
> unknown exception is also an interrupt. HPPA appears to not have any
> form of host-call.
> 
> This change places the hook for PA-RISC targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/hppa/int_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 191ae19404..0742990c90 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/helper-proto.h"
>   #include "hw/core/cpu.h"
>   #include "hw/hppa/hppa_hardware.h"
> +#include "qemu/plugin.h"
>   
>   static void eval_interrupt(HPPACPU *cpu)
>   {
> @@ -95,6 +96,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>       CPUHPPAState *env = &cpu->env;
>       int i = cs->exception_index;
>       uint64_t old_psw, old_gva_offset_mask;
> +    uint64_t last_pc = cs->cc->get_pc(cs);
>   
>       /* As documented in pa2.0 -- interruption handling.  */
>       /* step 1 */
> @@ -212,6 +214,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>       env->iasq_f = 0;
>       env->iasq_b = 0;
>   
> +    switch (i) {
> +    case EXCP_HPMC:
> +    case EXCP_POWER_FAIL:
> +    case EXCP_RC:
> +    case EXCP_EXT_INTERRUPT:
> +    case EXCP_LPMC:
> +    case EXCP_PER_INTERRUPT:
> +    case EXCP_TOC:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);

In the other target patches you list a set and default to
the rest, why listing here the 2 sets and then falling
back to the default? Should the default be g_assert_not_reached()?

> +        break;
> +    case EXCP_ITLB_MISS:
> +    case EXCP_IMP:
> +    case EXCP_ILL:
> +    case EXCP_BREAK:
> +    case EXCP_PRIV_OPR:
> +    case EXCP_PRIV_REG:
> +    case EXCP_OVERFLOW:
> +    case EXCP_COND:
> +    case EXCP_ASSIST:
> +    case EXCP_DTLB_MISS:
> +    case EXCP_NA_ITLB_MISS:
> +    case EXCP_NA_DTLB_MISS:
> +    case EXCP_DMP:
> +    case EXCP_DMB:
> +    case EXCP_TLB_DIRTY:
> +    case EXCP_PAGE_REF:
> +    case EXCP_ASSIST_EMU:
> +    case EXCP_HPT:
> +    case EXCP_LPT:
> +    case EXCP_TB:
> +    case EXCP_DMAR:
> +    case EXCP_DMPI:
> +    case EXCP_UNALIGN:
> +    case EXCP_SYSCALL:
> +    case EXCP_SYSCALL_LWS:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    }
> +
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static const char * const names[] = {
>               [EXCP_HPMC]          = "high priority machine check",



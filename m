Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF99F9EDF9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFgYW-0002ai-FN; Wed, 22 Apr 2026 19:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgYU-0002aK-LX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:00:26 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgYS-0007XP-HU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:00:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82735a41920so2451612b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776898822; x=1777503622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKI+3ncngUQuOf/A2a3/pnSbJtCw8Fu0fkPbMWKLwSc=;
 b=A7yd1vRkX8H3Yl10CdVOlk2S3CJFNNxWD2UYzGUWmPHhVcP9z1HOGR+9urZdxnvseC
 5+X7DmA27owmEGQJblzmp7DUPRYm8NPXebe9ykRg+1zar4PRlBM5MhniTpkGwJSHl/1Q
 S9lGgNbFpuE9IWdYMY45pHEysM2BTK532JobOPWyLBu+SICshv8MNXZeivZxPVpDefUg
 3CxzwzABgPcME8FLw5zDMMoN18J09kvfknV5Do4ANr9kYd0CcmVVSmFlhHSfGETFo61d
 0tfISRYviNkoifQkCDgF2UYuPYH5y0SGdkKjPLjbAU4m209bQxbR6Rs9mF5LrMTOAGnO
 VKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776898822; x=1777503622;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKI+3ncngUQuOf/A2a3/pnSbJtCw8Fu0fkPbMWKLwSc=;
 b=eZknWuYmptfaEMoxskN1iQ/w5Dtm+rcAvvwTnytQe3SSVcoBCvGJfXtEZG43Z23U8q
 r+pjkeovuOmUgZ5tJMwHwZMopGTDJ47siDH/nLShLsylmNRlCgvrRU/Kv25qwDueZ3CY
 fHvslCvRUi5KHj7HPspBLNZtrRO6HdiU/I8Brx9YY5ssreuv8KiwWUx3A3EfOQ4+y1zc
 ZFIWYJedx+54kgBFLLREUiR4wzjMel2hqJ8YpDhWzWGNjk3xgJEnsd/0sldtn3r1cqfL
 Y98ZO8Cm3Ts+R0kQa/9QKtkinSDTi5v9YslcDets0pSfwvZO5bhHKlFjRCQSKvyzTy7d
 eMxg==
X-Gm-Message-State: AOJu0Yw8VEWA8+dXySaXdyK/p+pzzg2I6UwquSnPaFfU14HvMLQ1Mtrj
 vfzPR5X8PCkP6tyMf0BbTF6U+i8/yYj1qDLgTKndL7LmO1L07U63/K6R4ssHM2DmOff2kiSO/Ai
 BgjAnDqE=
X-Gm-Gg: AeBDieunmatVQSg4kbXUyBLwGJ4+rfkydGIjQIlGRgTNcANU4wqn7pItpQ67c1Vz92k
 hTX9Ilst3HvQH7TJrPx5TTnnePAm4SCDDUcXUwM5wzejvXGaWUcHuHJuLtbtsyX41J1mrsV4yXr
 2xQRecoi6pD1vBmxkMEAEXJH0nb8hUw6htsdqLCZeEiWFCyMQnl31/41k3GVz3hjT+4zSK5s0+O
 AFlQBAvBNPazUILti0Ke5VKX8986asZv/soar5ygd7J6+A7UlRG4wmkod1gvW1RQ3MLuPiqHDf0
 7Nz89EgdO0JOMXJM4OCeIduUM6E1H+Ha4qX/sdTSd2nvY2k8HS/40FPR5tkXVpkOG7buMGAmwwI
 z+OYTZFEDGhTXmvaIeKZmHgTo5k5b3B0UiZs1YVBU1jKgi7Rl3oNTecwasGEyI87h1vyNW94cw4
 gQii8InKQW3oGMYCPOMq4zJvh6FKLtvgnr0E9WHMp8HUT5GqbioA==
X-Received: by 2002:a05:6a00:27a1:b0:82c:d7c4:4c5c with SMTP id
 d2e1a72fcca58-82f8c82e219mr25728197b3a.20.1776898820823; 
 Wed, 22 Apr 2026 16:00:20 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f94204ac8sm17187649b3a.0.2026.04.22.16.00.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 16:00:20 -0700 (PDT)
Message-ID: <ede428ce-a99e-4630-a000-7d8356f08ac7@linaro.org>
Date: Thu, 23 Apr 2026 09:00:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/32] target/arm: implement global monitor events
To: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-30-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/22/26 22:52, Alex Bennée wrote:
> Moving from Exclusive to Open Access should generate event stream
> events. Technically a non-exclusive store to any address range covered
> by the global monitor should also trigger such an event but we can
> only detect that after the event by seeing if memory doesn't match
> cpu_exclusive_val when processing the eventual store exclusive.
> 
> The CLREX instruction has the same effect as do other operations
> clearing the exclusive state (such as eret).
> 
> We special case STLR/STL (Store Release) instructions to generate
> events because their use is a suggested pattern for clearing locks
> that might be sleeping. We only trigger the event if we detect an
> exclusive instruction is running.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - add gen_global_event_reg() and use that
>    - add handling for STL/STLR
> ---
>   target/arm/internals.h         |  1 +
>   target/arm/tcg/translate.h     | 14 ++++++++++++++
>   target/arm/tcg/translate-a64.c | 23 +++++++++++++++++++++++
>   target/arm/tcg/translate.c     | 20 ++++++++++++++++++++
>   4 files changed, 58 insertions(+)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 089f679ac0a..7045b4a56bd 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -709,6 +709,7 @@ static inline void arm_broadcast_event(void)
>   static inline void arm_clear_exclusive(CPUARMState *env)
>   {
>       env->exclusive_addr = -1;
> +    arm_broadcast_event();
>   }

An out-of-line arm_broadcast_event suggests an out of line arm_clear_exclusive too.

> @@ -3544,6 +3553,7 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
>       TCGv_i64 clean_addr;
>       MemOp memop;
>       bool iss_sf = ldst_iss_sf(a->sz, false, false);
> +    TCGLabel *skip_monitor_event = gen_new_label();
>   
>       /*
>        * StoreLORelease is the same as Store-Release for QEMU, but
> @@ -3562,6 +3572,19 @@ static bool trans_STLR(DisasContext *s, arg_stlr *a)
>                                   true, a->rn != 31, memop);
>       do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
>                 iss_sf, a->lasr);
> +
> +    /*
> +     * We don't fully model the global monitor as it would be very
> +     * expensive for every memory access. However in the Arm ARM "Use
> +     * of Wait for Event (WFE) and Send Event (SEV) with lock" it does
> +     * give the example of using STLR to clear a lock. So if a lock is
> +     * active trigger the global event register so we don't deadlock
> +     * while sleeping.
> +     */
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, cpu_exclusive_addr, -1, skip_monitor_event);
> +    gen_global_event_reg();
> +    gen_set_label(skip_monitor_event);
> +
>       return true;
>   }
>   

Um, no.  Just because STLR is used in the example, *any* change to the memory region must 
raise the event.  There's nothing special about STLR vs STL vs STB etc.

The only thing I can think that would handle this is to set up a watchpoint in WFE before 
going to sleep, then wake on the watchpoint trigger.  Disabling the watchpoint on any 
other wakeup could be annoying.


r~


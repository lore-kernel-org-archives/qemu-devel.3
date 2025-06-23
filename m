Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A0DC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 19:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTmXg-0003m7-Pd; Mon, 23 Jun 2025 15:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTmXf-0003lr-3C
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:09:19 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTmXc-0004zU-GW
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:09:18 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso5792456b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750705754; x=1751310554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZWA00bdu/egrXwNGQU5NGoComP7aVR7SWR7O/a2cZE0=;
 b=aqKKHpnlPwVayBpKSzR6L1GIabU3hf+bRGKmmjXK98adv3j/rVNsJPFP4I6fZ71CGw
 avr+xsO++1OQz2r0fUPgOvk3znkU8z8x2Ha2J96r2Drxkq4wE6nNw0ggis59VPotdm5Y
 f8MHbFhfOVp3X/7Osuf6APe2ZaKRgD33nU7FRToRVfa3RHAz3ngT9t/orkCgzjxZVq47
 WUte05dphPMrmIfxiCci7z32uOC5vOwMn+hRv0niBfGmrqgfcpCy9pQm9BnkTonFGIRt
 Uk2bGCJE8FFxSCyPJvudnH8F3nk0p3TDHLF8pfmoApc6vu0uc2XGvzDv24YdEn0dHbcJ
 zUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750705754; x=1751310554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWA00bdu/egrXwNGQU5NGoComP7aVR7SWR7O/a2cZE0=;
 b=Nwp8em5aZWlffC+wKMqc5LCN4SwsvnctEGV6vSxHAE0EweANoOTOGIO70ajcRYKPzx
 g2TMlqzDtl0Q86cDFfdZLuJANATMn8aZiFfJq6NXMFAxkoIrobLYUUBTN1/uAoQnqLpe
 Vxko+KsvGylxnZdEVEphDfKn00SaEZt3zjJzgbWCGpQCyrwUyObqhnLcxXaOWtbj7bez
 KGqyeWGRJ9N0mnCwr5bBqSEY5W7pyyyLBn9YoSfXzuTEITXrDSnvvQIdCTc4KsnRG2dE
 3irBtWjZM1Qv7r3L+lpntY8siJG+LXjKd5s4keWZhmQtBVWtUkI/LngE6dUOeGGc5JFA
 WuTg==
X-Gm-Message-State: AOJu0YxmHx+XjRexROWNpZlQJMhJwhsUF0PA6Smk/6SN7741I+RLbD1i
 cS2GyJau0J+O7N09X99KFvWBaKDeyW0x1+fnBmnYvXub4KkpvL+rEl07cT1Gd08NLNX2qWHiKco
 xWwgomOA=
X-Gm-Gg: ASbGncuutb8JMeYNLl3aDke9vdPeNfxckzMDe2xsgpR2NsX4reVOysKxRw5vPAglgqv
 7r8EnhypDh2z6ZFk/5kzduD2O4RZzvZkOPtnUVkG+PMGZmDTv3Kz+aaXV4vAzmqzy5qB+r2kgBs
 2Wy57GICKkpICXUDL/lNx2A4veYmP19OOigkwDDiu6nG+zEnZfA3G2RRsPF7Z1R3EmJ1ppsWixo
 c082gHRbmDp1XK/NjQfiUzxhUDh6n89dd9chfsTgUuhASUB6IgUxUaQCQwq2d/6mG2PGhJ3XHmk
 qxGc+5DPP+OGVnYgTbUFvQX0/avFY+ZCO3cdZVrwXvuh0hOSHedYa8JoiGyy42DxBNAz+VB7tZ2
 xGDbpmpQlaGhxbQgT11QFULDdITWJ
X-Google-Smtp-Source: AGHT+IHlz7qMh/0TTZIqA1bpK/1ZHHHbif0nVlOjpPLHb9ZFuFi76I5h3yGYYcQoBTqZ4m3eyfbjQA==
X-Received: by 2002:a05:6a21:ea0b:b0:220:37a7:578f with SMTP id
 adf61e73a8af0-22037a75af9mr12363653637.2.1750705754416; 
 Mon, 23 Jun 2025 12:09:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a674eb6sm9293138b3a.144.2025.06.23.12.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 12:09:14 -0700 (PDT)
Message-ID: <7705c58c-4105-454b-ad5c-e3d9c8027c50@linaro.org>
Date: Mon, 23 Jun 2025 12:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Add syscall dispatch support
To: qemu-devel@nongnu.org
References: <20250604121437.28176-4-floss@arusekk.pl>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250604121437.28176-4-floss@arusekk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/4/25 05:00, Arusekk wrote:
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -865,3 +865,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
>       unlock_user(tramp, sigtramp_page, 2 * 8);
>   }
>   #endif
> +
> +bool is_vdso_sigreturn(abi_ulong pc)
> +{
> +#ifndef TARGET_X86_64
> +    if (pc == default_sigreturn + 8 || pc == default_rt_sigreturn + 7)
> +        return true;
> +#endif
> +    return false;
> +}

Braces required.

> --- a/linux-user/mips/signal.c
> +++ b/linux-user/mips/signal.c
> @@ -393,3 +393,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
>   
>       unlock_user(tramp, sigtramp_page, 2 * 8);
>   }
> +
> +bool is_vdso_sigreturn(abi_ulong pc)
> +{
> +#ifdef TARGET_ARCH_HAS_SETUP_FRAME
> +    if (pc == default_sigreturn + 8)
> +        return true;
> +#endif

Likewise.

> +++ b/linux-user/ppc/signal.c
> @@ -730,3 +730,12 @@ void setup_sigtramp(abi_ulong sigtramp_page)
>   
>       unlock_user(tramp, sigtramp_page, 2 * 8);
>   }
> +
> +bool is_vdso_sigreturn(abi_ulong pc)
> +{
> +#ifdef TARGET_ARCH_HAS_SETUP_FRAME
> +    if (pc == default_sigreturn + 8)
> +        return true;
> +#endif

Likewise.

> +++ b/linux-user/sparc/signal.c
> @@ -789,3 +789,12 @@ do_sigsegv:
>       force_sig(TARGET_SIGSEGV);
>   }
>   #endif /* TARGET_SPARC64 */
> +
> +bool is_vdso_sigreturn(abi_ulong pc)
> +{
> +#ifdef TARGET_ABI32
> +    if (pc == default_sigreturn + 8 || pc == default_rt_sigreturn + 8)
> +        return true;
> +#endif

Likewise.

> +++ b/linux-user/qemu.h
> @@ -161,6 +161,11 @@ struct TaskState {
>       /* This thread's sigaltstack, if it has one */
>       struct target_sigaltstack sigaltstack_used;
>   
> +    /* This thread's SYSCALL_USER_DISPATCH state, len=~0 means disabled */
> +    abi_ulong sys_dispatch;
> +    abi_ulong sys_dispatch_len;
> +    abi_ulong sys_dispatch_selector;

dispatch and selector should probably be "vaddr" for self-documentation.

> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc37028597..027e4237b9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6340,6 +6340,10 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
>   #endif
>   #ifndef PR_SET_SYSCALL_USER_DISPATCH
>   # define PR_SET_SYSCALL_USER_DISPATCH 59
> +# define PR_SYS_DISPATCH_OFF 0
> +# define PR_SYS_DISPATCH_ON 1
> +# define SYSCALL_DISPATCH_FILTER_ALLOW 0
> +# define SYSCALL_DISPATCH_FILTER_BLOCK 1
>   #endif
>   #ifndef PR_SME_SET_VL
>   # define PR_SME_SET_VL  63
> @@ -6469,6 +6473,37 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>       case PR_SET_UNALIGN:
>           return do_prctl_set_unalign(env, arg2);
>   
> +    case PR_SET_SYSCALL_USER_DISPATCH:
> +        {
> +            TaskState *ts = get_task_state(env_cpu(env));
> +            switch (arg2) {
> +            case PR_SYS_DISPATCH_OFF:
> +                if (arg3 || arg4 || arg5) {
> +                    return -TARGET_EINVAL;
> +                }
> +                ts->sys_dispatch_len = (abi_ulong)~0ULL;
> +                return 0;
> +            case PR_SYS_DISPATCH_ON:
> +                {
> +                    uint8_t sb;
> +
> +                    if (arg3 && arg3 + arg4 <= arg3) {
> +                        return -TARGET_EINVAL;
> +                    }
> +                    if (arg5 && get_user_u8(sb, arg5)) {

Use access_ok, just like the kernel.

> +                        return -TARGET_EFAULT;
> +                    }
> +                    (void)sb;  /* used later, only checked for access */
> +                    ts->sys_dispatch = arg3;
> +                    ts->sys_dispatch_len = arg4;
> +                    ts->sys_dispatch_selector = arg5;
> +                    return 0;
> +                }
> +            default:
> +                return -TARGET_EINVAL;
> +            }
> +        }

I think this should be split out to do_prctl_syscall_user_dispatch().

> +
>       case PR_CAP_AMBIENT:
>       case PR_CAPBSET_READ:
>       case PR_CAPBSET_DROP:
> @@ -6523,7 +6558,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
>       case PR_SET_MM:
>       case PR_GET_SECCOMP:
>       case PR_SET_SECCOMP:
> -    case PR_SET_SYSCALL_USER_DISPATCH:
>       case PR_GET_THP_DISABLE:
>       case PR_SET_THP_DISABLE:
>       case PR_GET_TSC:
> @@ -13881,12 +13915,37 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>       return ret;
>   }
>   
> +static bool sys_dispatch(abi_ulong pc, TaskState *ts)
> +{

Move pc - offset < len check here.

> +    if (unlikely(is_vdso_sigreturn(pc))) {
> +        return false;
> +    }
> +    if (likely(ts->sys_dispatch_selector)) {
> +        uint8_t sb;
> +        if (get_user_u8(sb, ts->sys_dispatch_selector)) {
> +            force_sig(TARGET_SIGSEGV);
> +            return true;
> +        }
> +        if (likely(sb == SYSCALL_DISPATCH_FILTER_ALLOW)) {
> +            return false;
> +        }
> +        if (unlikely(sb != SYSCALL_DISPATCH_FILTER_BLOCK)) {
> +            force_sig(TARGET_SIGSYS);
> +            return true;
> +        }
> +    }
> +    force_sig_fault(TARGET_SIGSYS, TARGET_SYS_USER_DISPATCH, pc);
> +    return true;
> +}
> +
>   abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>                       abi_long arg2, abi_long arg3, abi_long arg4,
>                       abi_long arg5, abi_long arg6, abi_long arg7,
>                       abi_long arg8)
>   {
>       CPUState *cpu = env_cpu(cpu_env);
> +    TaskState *ts = get_task_state(cpu);
> +    vaddr pc = cpu->cc->get_pc(cpu);
>       abi_long ret;
>   
>   #ifdef DEBUG_ERESTARTSYS
> @@ -13903,6 +13962,12 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>       }
>   #endif
>   
> +    if (unlikely(pc - ts->sys_dispatch >= ts->sys_dispatch_len)) {

This isn't correct.  The kernel expression is gated by a bit in the work flags.

> +        if (sys_dispatch(pc, ts)) {
> +            return -QEMU_ESIGRETURN;
> +        }
> +    }

Better as:

     if (unlikely(ts->sys_dispatch_len != ~0)) {
         vaddr pc = cpu->cc->get_pc(cpu);
         if (sys_dispatch(pc, ts)) {
             return -QEMU_ESIGRETURN;
         }
     }


r~


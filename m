Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1B3CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6X8q-0001JQ-G8; Wed, 08 Oct 2025 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6X8o-0001Ii-BP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:35:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6X7i-0000Wy-JE
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:35:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-330469eb750so113133a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759941273; x=1760546073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=346pFNDRPIW86vtU6Q0PGhiz/IFYmG8Fle9CEvOB4Rc=;
 b=eqmmkz0ke4PrUWBNJ7hwP6T80rFhcd85ZUzyrEyZbqQzMqxRIzP1088pOYiqoNg85p
 svmTsKMefjTjZ5U32FT80RLcrXNDbxF9rbH/lrWI+Ifm/vUgePv71ireKJJKBdZh4Wnm
 k5/jghFQojNKYLeAIgkbpdwYVhdL0eZkTmQMhKh73nYZzahoNp2JsXrm4lKa6GsbPclU
 YTPC2cjD4rw6GruP2GeTekWZ/Ti6y+yljR9+HI6AOehDxkubN10ej7sQW46ERhAr5N11
 viALlHLmHQM2iNTJuRLE7O7m95m45WKUugupVYQCkXSBltVbHksXTwHEUzaj0sbhffCu
 e12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759941273; x=1760546073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=346pFNDRPIW86vtU6Q0PGhiz/IFYmG8Fle9CEvOB4Rc=;
 b=T6L1dfi85JKBjaShYzGb5yTIc0vzTM9NUVw+jsbwWmVsZvMCVdQixIATXZJUORTU0D
 JygdMPfUB8kEij+mmG+rNHwLN39hHIIpx8sB6ipHS2pQ/sJ7DRetLOe3cHxQq++BkxPd
 6wOUNEKUdgcwWE2DGGNiULTUppM92wFpmBnb1KOQGqG/MV+KwOKry8W5eBDna2tnpNPK
 QQ1W6hltVuqwQGSO+8RhdU/lcE9j3sIQZlRKyUca04GhpJSuGcIsj+5GpyTl/S6fxsA6
 9uKwpE1kiOAR8S4QOCS9cRMQ9mEdrUgOuMutcS82hrc+1pEGT+JKoerfFU/Dw9WC6Ioq
 HBGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUENmej+pr6OS0apX7og1NCRTq2H17n2i2ZlTnnlRuCz1O/R+Fpic4oeo70qtyz06C1+Rf9IKGIwJ/i@nongnu.org
X-Gm-Message-State: AOJu0YwUd6KlSfQxBU4RNUZOyNT2fJU8kYd5HKQtIidSwnDZEmVB04KX
 WHllN2xFXwVQe1RsAtRfOhkpbCVOfC5S8Xu001oMcC4tF95t3ZexVpCOu7ZTduqJ6MoO++ZkA0r
 wlLiwBTA=
X-Gm-Gg: ASbGncv+Xn3SYkKT1YdNx0E1ZbDFHSu1uiox3WVKiiiZubgfa2wXOFppFqXKekHqLU4
 8mHJcelkWGxFMnmbuxFLaHp6JZcjRFCelL0oAkJXroM9eB9ZR1kwKx9yKPLVxzB3UsS/BkCIps4
 bucZ2sGcDnevpxZQ4nz2Oa/8UNM8punZ2ZHglw612MUAxFqbyp2zh49SOba7nZjre+dP0ro0yev
 Dd92eEqzSi8tSX87IpXyq2+0g+u2a4N/YolnBCdtfO4sHDL2NgEUp+lbXSD5a7mhXNLNTZ+cGo5
 f9rpfkxMu0Vc2hwwvNbU/lhmrr++lqRAD6l2mVFbpvm4Kgvzvqng0dPCWr6BMoox5gVE8SvMvHa
 u1WBAt0ZhXjIdOlvFhsKaiP8mcRc3Cpf5rwqXpX0m28zeTQULq7r/wNmtrlEnJYcffZpyBYXRFg
 ==
X-Google-Smtp-Source: AGHT+IFdMh5rGXFQCkIlO+1sm2XZsRdJUrr+/TKvPdRV5e2KpA3zltcjx7+vgzfFtg0qlrBCCp8ZmA==
X-Received: by 2002:a17:90b:1b11:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-33b51391ab4mr5073330a91.32.1759941272677; 
 Wed, 08 Oct 2025 09:34:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6311462b24sm7993226a12.37.2025.10.08.09.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:34:32 -0700 (PDT)
Message-ID: <fb66bad0-1b40-49cd-bd99-8751726daacf@linaro.org>
Date: Wed, 8 Oct 2025 09:34:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] linux-user: add syscall-filter and fork-cpu in plugin
 interfaces
Content-Language: en-US
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org
References: <1131357261.3273575.1759928457969.JavaMail.zimbra@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1131357261.3273575.1759928457969.JavaMail.zimbra@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hy Ziyang,

On 10/8/25 6:00 AM, Ziyang Zhang wrote:
> This commit introduces a syscall filtering mechanism for user-mode
> emulation, allowing plugins to intercept and handle system calls.
> 
> Key features:
> - New API functions: qemu_plugin_set_syscall_filter() and
>    qemu_plugin_fork_cpu_loop()
> - A new enum qemu_plugin_syscall_filter_ret to represent filter results
> - Integration into the cpu loop for i386 and x86_64
> - A new header file include/user/syscall-filter.h
> 
> The filtering mechanism works by allowing a plugin to register a
> callback that is invoked before each system call. The callback can
> decide whether to pass, skip, or exit the current cpu loop. When
> skipping, the plugin can provide a value to be returned to the guest.
> 
> Additionally, a new function qemu_plugin_fork_cpu_loop() is provided to
> allow plugins to fork a new cpu loop, which is useful for temporarily
> resuming guest emulation (e.g., for executing callbacks) during the
> first system call.
> 
> The implementation inserts the filter checks in the cpu loop for both
> the int $0x80 (i386) and syscall (x86_64) paths.
> 
> At KVM Forum 2025, we presented Lorelei, a system designed to enable
> guest programs executed by the QEMU user-mode emulator to accelerate
> performance by invoking natively compiled host libraries via syscalls.
> We have successfully supported libraries such as SDL, OpenGL, and
> Vulkan, allowing QEMU user-mode to emulate GPU-dependent games.
> 
> Following an invitation from Mr. Bouvier to upstream Lorelei to QEMU, we
> refined its architecture to load the Lorelei module as a TCG plugin.
> 
> Since host libraries may execute guest function pointers (callbacks),
> Lorelei implements a novel nested execution model:
> 
> - During syscall filtering, Lorelei triggers a temporary cpu_loop when a
>    host library begins executing a guest callback
> - This temporarily reverts to full emulation mode to execute the guest
>    callback
> - The guest code then issues a magic syscall to exit the temporary
>    cpu_loop
> - Control returns to the host library's original execution context
> 
> 
> Slides: https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/Slides_DQPMaZE.pdf
> Video: https://www.youtube.com/watch?v=_jioQFm7wyU&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=22
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>   include/qemu/plugin.h         | 28 +++++++++++++++++++
>   include/qemu/qemu-plugin.h    | 44 +++++++++++++++++++++++++++++
>   include/user/syscall-filter.h | 36 ++++++++++++++++++++++++
>   linux-user/i386/cpu_loop.c    | 52 +++++++++++++++++++++++++++++++++--
>   linux-user/main.c             |  1 +
>   linux-user/user-internals.h   |  1 +
>   plugins/api.c                 | 14 ++++++++++
>   plugins/core.c                | 31 +++++++++++++++++++++
>   plugins/plugin.h              |  8 ++++++
>   9 files changed, 213 insertions(+), 2 deletions(-)
>   create mode 100644 include/user/syscall-filter.h
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index af5f9db469..7b1e7df035 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -207,6 +207,22 @@ void qemu_plugin_user_prefork_lock(void);
>    */
>   void qemu_plugin_user_postfork(bool is_child);
>   
> +/**
> + * qemu_plugin_filter_syscall(): filter a system call
> + * @cpu: CPUState pointer
> + * @num: syscall number
> + * @a1-a8: syscall arguments
> + * @sysret: pointer to the sysret value, not used if passed
> + * @return: syscall filter return value
> + */
> +int qemu_plugin_filter_syscall(CPUState *cpu,
> +                               int num, uint64_t a1, uint64_t a2,
> +                               uint64_t a3, uint64_t a4, uint64_t a5,
> +                               uint64_t a6, uint64_t a7, uint64_t a8,
> +                               uint64_t *sysret);
> +
> +void qemu_plugin_set_fork_cpu_loop_entry(void (*entry)(uint64_t));
> +
>   #else /* !CONFIG_PLUGIN */
>   
>   static inline void qemu_plugin_add_opts(void)
> @@ -277,6 +293,18 @@ static inline void qemu_plugin_user_prefork_lock(void)
>   static inline void qemu_plugin_user_postfork(bool is_child)
>   { }
>   
> +static inline
> +int qemu_plugin_filter_syscall(CPUState *cpu,
> +                               int num, uint64_t a1, uint64_t a2,
> +                               uint64_t a3, uint64_t a4, uint64_t a5,
> +                               uint64_t a6, uint64_t a7, uint64_t a8,
> +                               uint64_t *sysret)
> +{ }
> +
> +static inline
> +void qemu_plugin_set_fork_cpu_loop_entry(void (*entry)(uint64_t))
> +{ }
> +
>   #endif /* !CONFIG_PLUGIN */
>   
>   #endif /* QEMU_PLUGIN_H */
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c71c705b69..2567eba673 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -939,4 +939,48 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
>   QEMU_PLUGIN_API
>   uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
>   
> +/**
> + * enum qemu_plugin_syscall_filter_ret - syscall filter return values
> + *
> + * @QEMU_PLUGIN_SYSCALL_FILTER_PASS: control should continue as usual
> + * @QEMU_PLUGIN_SYSCALL_FILTER_SKIP: syscall is filtered and skipped
> + * @QEMU_PLUGIN_SYSCALL_FILTER_EXIT: current cpu loop should exit
> + *
> + */
> +enum qemu_plugin_syscall_filter_ret {
> +    QEMU_PLUGIN_SYSCALL_FILTER_PASS = 0,
> +    QEMU_PLUGIN_SYSCALL_FILTER_SKIP,
> +    QEMU_PLUGIN_SYSCALL_FILTER_EXIT,
> +};
> +
> +/**
> + * typedef qemu_plugin_syscall_filter_cb_t - syscall filter callback
> + * @num: syscall number
> + * @a1-a8: syscall arguments
> + * @sysret: pointer to the sysret value, only used when returning SKIP
> + * @return: syscall filter return value
> + */
> +typedef int
> +(*qemu_plugin_syscall_filter_cb_t)(uint64_t num, uint64_t a1, uint64_t a2,
> +                                   uint64_t a3, uint64_t a4, uint64_t a5,
> +                                   uint64_t a6, uint64_t a7, uint64_t a8,
> +                                   uint64_t *sysret);
> +
> +/**
> + * qemu_plugin_set_syscall_filter() - set the unique syscall filter
> + * @id: plugin ID
> + * @cb: callback function to filter the syscall
> + *
> + * Returns true if the filter was set, false if the syscall number is already
> + * registered or if the callback is NULL.
> + */
> +bool qemu_plugin_set_syscall_filter(qemu_plugin_id_t id,
> +                                    qemu_plugin_syscall_filter_cb_t cb);
> +
> +/**
> + * qemu_plugin_fork_cpu_loop() - fork a new cpu loop
> + * @sysret: value to return to the child cpu loop
> + */
> +void qemu_plugin_fork_cpu_loop(uint64_t sysret);
> +
>   #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/include/user/syscall-filter.h b/include/user/syscall-filter.h
> new file mode 100644
> index 0000000000..45db9ff8f5
> --- /dev/null
> +++ b/include/user/syscall-filter.h
> @@ -0,0 +1,36 @@
> +/*
> + * System Call Filter Wrappers for *-user
> + *
> + * Copyright (c) 2019 Linaro
> + * Written by Ziyang Zhang <functioner@sjtu.edu.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef SYSCALL_FILTER_H
> +#define SYSCALL_FILTER_H
> +
> +#ifndef CONFIG_USER_ONLY
> +#error Cannot include this header from system emulation
> +#endif
> +
> +#include "user/abitypes.h"
> +#include "qemu/plugin.h"
> +
> +static inline int filter_syscall(CPUState *cpu, int num,
> +                                 abi_long arg1, abi_long arg2,
> +                                 abi_long arg3, abi_long arg4,
> +                                 abi_long arg5, abi_long arg6,
> +                                 abi_long arg7, abi_long arg8, abi_ulong *sysret)
> +{
> +    uint64_t sysret64 = 0;
> +    int ret = qemu_plugin_filter_syscall(cpu, num,
> +                             arg1, arg2, arg3, arg4,
> +                             arg5, arg6, arg7, arg8, &sysret64);
> +    if (ret != QEMU_PLUGIN_SYSCALL_FILTER_PASS) {
> +        *sysret = sysret64;
> +    }
> +    return ret;
> +}
> +
> +#endif // SYSCALL_FILTER_H
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index 92beb6830c..adbe48bb05 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -24,6 +24,7 @@
>   #include "cpu_loop-common.h"
>   #include "signal-common.h"
>   #include "user-mmap.h"
> +#include "user/syscall-filter.h"
>   
>   /***********************************************************/
>   /* CPUX86 core interface */
> @@ -203,8 +204,21 @@ static bool maybe_handle_vm86_trap(CPUX86State *env, int trapnr)
>       return false;
>   }
>   
> -void cpu_loop(CPUX86State *env)
> -{
> +static void cpu_loop_impl(CPUX86State *env);
> +
> +void cpu_loop(CPUX86State *env) {
> +    cpu_loop_impl(env);
> +    __builtin_unreachable();
> +}
> +
> +void fork_cpu_loop(uint64_t sysret) {
> +    CPUX86State *env = cpu_env(thread_cpu);
> +    env->regs[R_EAX] = sysret;
> +    process_pending_signals(env);
> +    cpu_loop_impl(env);
> +}
> +
> +static void cpu_loop_impl(CPUX86State *env) {
>       CPUState *cs = env_cpu(env);
>       int trapnr;
>       abi_ulong ret;
> @@ -220,6 +234,23 @@ void cpu_loop(CPUX86State *env)
>   #ifndef TARGET_X86_64
>           case EXCP_SYSCALL:
>   #endif
> +            /* syscall filter */
> +            {
> +                int syscall_filter_ret = filter_syscall(cs,
> +                             env->regs[R_EAX],
> +                             env->regs[R_EBX],
> +                             env->regs[R_ECX],
> +                             env->regs[R_EDX],
> +                             env->regs[R_ESI],
> +                             env->regs[R_EDI],
> +                             env->regs[R_EBP],
> +                             0, 0, &ret);
> +                if (syscall_filter_ret == QEMU_PLUGIN_SYSCALL_FILTER_EXIT)
> +                    return;
> +                else if (syscall_filter_ret == QEMU_PLUGIN_SYSCALL_FILTER_SKIP)
> +                    break;
> +            }
> +
>               /* linux syscall from int $0x80 */
>               ret = do_syscall(env,
>                                env->regs[R_EAX],
> @@ -238,6 +269,23 @@ void cpu_loop(CPUX86State *env)
>               break;
>   #ifdef TARGET_X86_64
>           case EXCP_SYSCALL:
> +            /* syscall filter */
> +            {
> +                int syscall_filter_ret = filter_syscall(cs,
> +                                env->regs[R_EAX],
> +                                env->regs[R_EDI],
> +                                env->regs[R_ESI],
> +                                env->regs[R_EDX],
> +                                env->regs[10],
> +                                env->regs[8],
> +                                env->regs[9],
> +                                0, 0, &ret);
> +                if (syscall_filter_ret == QEMU_PLUGIN_SYSCALL_FILTER_EXIT)
> +                    return;
> +                else if (syscall_filter_ret == QEMU_PLUGIN_SYSCALL_FILTER_SKIP)
> +                    break;
> +            }
> +
>               /* linux syscall from syscall instruction.  */
>               ret = do_syscall(env,
>                                env->regs[R_EAX],
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..32b7fe38c5 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -738,6 +738,7 @@ int main(int argc, char **argv, char **envp)
>       }
>       trace_init_file();
>       qemu_plugin_load_list(&plugins, &error_fatal);
> +    qemu_plugin_set_fork_cpu_loop_entry(fork_cpu_loop);
>   
>       /* Zero out regs */
>       memset(regs, 0, sizeof(struct target_pt_regs));
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 5c7f173ceb..224c914f33 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -66,6 +66,7 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
>                       abi_long arg8);
>   extern __thread CPUState *thread_cpu;
>   G_NORETURN void cpu_loop(CPUArchState *env);
> +void fork_cpu_loop(uint64_t sysret);
>   abi_long get_errno(abi_long ret);
>   const char *target_strerror(int err);
>   int get_osversion(void);
> diff --git a/plugins/api.c b/plugins/api.c
> index 2ff13d09de..f70e141cf7 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -628,3 +628,17 @@ void qemu_plugin_update_ns(const void *handle, int64_t new_time)
>       }
>   #endif
>   }
> +
> +bool qemu_plugin_set_syscall_filter(qemu_plugin_id_t id,
> +                                    qemu_plugin_syscall_filter_cb_t cb)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return plugin_set_syscall_filter(id, cb);
> +#else
> +    return false;
> +#endif
> +}
> +
> +void qemu_plugin_fork_cpu_loop(uint64_t sysret) {
> +    plugin_fork_cpu_loop(sysret);
> +}
> \ No newline at end of file
> diff --git a/plugins/core.c b/plugins/core.c
> index 12c67b4b4e..ea17e85c02 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -692,6 +692,21 @@ void qemu_plugin_user_postfork(bool is_child)
>       }
>   }
>   
> +int qemu_plugin_filter_syscall(CPUState *cpu,
> +                               int num, uint64_t a1, uint64_t a2,
> +                               uint64_t a3, uint64_t a4, uint64_t a5,
> +                               uint64_t a6, uint64_t a7, uint64_t a8,
> +                               uint64_t *sysret) {
> +    if (plugin.syscall_filter_cb) {
> +        return plugin.syscall_filter_cb(num, a1, a2, a3, a4, a5, a6, a7, a8, sysret);
> +    }
> +    return QEMU_PLUGIN_SYSCALL_FILTER_PASS;
> +}
> +
> +void qemu_plugin_set_fork_cpu_loop_entry(void (*entry)(uint64_t)) {
> +    plugin.fork_cpu_loop_entry = entry;
> +}
> +
>   static bool plugin_dyn_cb_arr_cmp(const void *ap, const void *bp)
>   {
>       return ap == bp;
> @@ -743,3 +758,19 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
>       g_array_free(score->data, TRUE);
>       g_free(score);
>   }
> +
> +bool plugin_set_syscall_filter(qemu_plugin_id_t id,
> +                               qemu_plugin_syscall_filter_cb_t cb)
> +{
> +    if (plugin.syscall_filter_cb) {
> +        return false;
> +    }
> +    plugin.syscall_filter_cb = cb;
> +    return true;
> +}
> +
> +void plugin_fork_cpu_loop(uint64_t sysret) {
> +    if (plugin.fork_cpu_loop_entry) {
> +        plugin.fork_cpu_loop_entry(sysret);
> +    }
> +}
> \ No newline at end of file
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 30e2299a54..41899a2dc6 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -48,6 +48,9 @@ struct qemu_plugin_state {
>       struct qht dyn_cb_arr_ht;
>       /* How many vcpus were started */
>       int num_vcpus;
> +
> +    qemu_plugin_syscall_filter_cb_t syscall_filter_cb;
> +    void (*fork_cpu_loop_entry)(uint64_t);
>   };
>   
>   
> @@ -118,4 +121,9 @@ struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
>   
>   void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
>   
> +bool plugin_set_syscall_filter(qemu_plugin_id_t id,
> +                               qemu_plugin_syscall_filter_cb_t cb);
> +
> +void plugin_fork_cpu_loop(uint64_t sysret);
> +
>   #endif /* PLUGIN_H */

thanks for posting this!

Just for sake of centralizing the conversation, let's ignore this 
thread, and answer of the other one, where you added someone else in copy.

I'll answer on other thread.

Pierrick


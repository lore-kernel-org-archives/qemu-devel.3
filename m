Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B18C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIses-00049F-FX; Sat, 24 May 2025 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIseq-000496-CQ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:27:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIseo-0008E2-Eb
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:27:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so10833755e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107656; x=1748712456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DIK74+bF4b3uRY8LTo9EFd1nvgeWvAY9NQfhs4O3DI=;
 b=Nmpy0UXQ9S/fXCeTyF0Y10EhTcfsHUs2q5My/MfUO8Hq8Yj+hF7j7AepUoIcsbA5O0
 fb5+LFY6Z8Zbu+Z3zyO/15CU0gjPEfXXLBkAf8UGqMX7zglvIdXUSeSo+MRVeEhZlhau
 mi3OBHoOIa68C/sAwNN8biJjZVM0TTsHNbQCZFBgfiEgxqiKjjOGgRLIAzMaH3HdeuXk
 mLC7Kx01/f18qNi2oKcgqDtmB1sR6sTTay7rbWgnSgdXlN078ogHqVuqmtmcFhSFXOqu
 oWOjDzfsO2wsXkmQmcETwX5Su5Z7M1DEpuq32HwdNCAyEXm2QMcJVBrKjmOO4HtAqY7F
 6Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107656; x=1748712456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DIK74+bF4b3uRY8LTo9EFd1nvgeWvAY9NQfhs4O3DI=;
 b=nsYj8O9q5YECGzNNWMglubDaLEQODHzDJ8DDADoPxrbHY8eLwqXeRPBreB4mpz5WJf
 EjYEMUDO3LvR0QF5cQrLeGImA8DyPGWwaDS8PKgNaY6/WuP/UWtFSBhZ5R1easgyqv1+
 kILLLIL22pdRBRhfFz9no3Bs7Bvo0dU1mP121Y346GCBHZetbuedtepPt+ZAreVGuXnD
 3KTECC3zqeyDj9WY9Iw90AW90dwI12l5L/qKk/a7hdUCwtr/zhCnGLmwN7AkbhnZBmsj
 tIFcCBt7bMXrdq8XXoUdAGEz08dlRJwC06UQGkUruAMWWv2UiCDeyP9NJ/PpZCUAkISG
 8rvA==
X-Gm-Message-State: AOJu0YzVnKIXGqEqTgD6zUvZx7VKpkpuoLHmgbJ01dfFqfrkU25wwg2p
 KdWBsdzdvQ+XqFKRPgDxBCfjcE32xI0ecmC7lqhHfP6nNg88d3JAfzCnyHYXTsdRGW29gRCVe8d
 OTt0wIT9WwA==
X-Gm-Gg: ASbGncsuOgPEX5/vWBSeaTdKHBStdVe+S75wklCrOaO2bwcwiLV/44bTZ/8RuaHvJ8b
 ENPX46ZcpCz41tcqGLpfIVNxjutJFIGd+J8hFyIg1F1XvYgVv8R1OiKR2N/qKBGyJTeWFtdE4D2
 FFrH7+QxwP7ym65WLi4WINlQtF+BhtlyAIEVA8H7o4g3ptY9AJcUTRC2AR3RYTxusEJrAGzFNr6
 JtxZBuPcioq4ULVH66YoM8yJq9mgM6GA+G3g2IbKL4YqwpyfM05m+AmzjhnS+napA7HXbvF3bG5
 9g+z5+XP3GXeFgdgvSvNK5JKHPQtMdJ1KzFHitxUkJG6rlaTt0TT5afvhwjet5T/Nw==
X-Google-Smtp-Source: AGHT+IHQs90+6epCdSAhfZMqXQ6+tBm/xc7ajvoBzaS/xL7DisJ3j6HmZZZzdr7axuEhNE9KATZK5A==
X-Received: by 2002:a05:600c:37c4:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-44c92d351e0mr26822585e9.24.1748107656414; 
 Sat, 24 May 2025 10:27:36 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cbb90a5bsm2971795f8f.56.2025.05.24.10.27.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:27:35 -0700 (PDT)
Message-ID: <25151025-e2df-460c-8d54-431ce8cb2b88@linaro.org>
Date: Sat, 24 May 2025 18:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition, we
> recently introduced API for registering callbacks for discontinuity
> events, specifically for interrupts, exceptions and host calls.
> 
> This change introduces the corresponding hooks called from target
> specific code inside qemu.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   include/qemu/plugin.h | 12 ++++++++++
>   plugins/core.c        | 53 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 27a176b631..3494325039 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
>   void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
>   void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
>   void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from);
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from);
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from);
>   void
>   qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>                            uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
> @@ -243,6 +246,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>   static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>   { }
>   
> +static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
> +{ }
> +
> +static inline void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
> +{ }
> +
> +static inline void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> +{ }
> +
>   static inline void
>   qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
>                            uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
> diff --git a/plugins/core.c b/plugins/core.c
> index dc1f5cb4d8..f07813d588 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -104,6 +104,44 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
>       }
>   }
>   
> +/*
> + * Disable CFI checks.
> + * The callback function has been loaded from an external library so we do not
> + * have type information
> + */
> +QEMU_DISABLE_CFI
> +static void plugin_vcpu_cb__discon(CPUState *cpu,
> +                                   enum qemu_plugin_discon_type type,
> +                                   uint64_t from)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev;
> +    uint64_t to = cpu->cc->get_pc(cpu);

Maybe cleaner to pass in @to.  It's readily available in the callers.


r~

> +
> +    if (cpu->cpu_index < plugin.num_vcpus) {
> +        switch (type) {
> +        case QEMU_PLUGIN_DISCON_INTERRUPT:
> +            ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
> +            break;
> +        case QEMU_PLUGIN_DISCON_EXCEPTION:
> +            ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
> +            break;
> +        case QEMU_PLUGIN_DISCON_HOSTCALL:
> +            ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        /* iterate safely; plugins might uninstall themselves at any time */
> +        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> +            qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
> +
> +            func(cb->ctx->id, cpu->cpu_index, type, from, to);
> +        }
> +    }
> +}
> +
>   /*
>    * Disable CFI checks.
>    * The callback function has been loaded from an external library so we do not
> @@ -539,6 +577,21 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>       }
>   }
>   
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from);
> +}
> +
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from);
> +}
> +
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from);
> +}
> +
>   void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>                                          qemu_plugin_vcpu_simple_cb_t cb)
>   {



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A365FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eow-0001fm-Nm; Mon, 22 Sep 2025 07:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0eok-0001YP-P9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:34:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0eoe-00029C-Di
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:34:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso14800035e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758540881; x=1759145681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTjvk6GxZuR2zGa6Oy3VxNKzOakA+GOA3aZioMtCQXs=;
 b=StWZ9LBb4vbD1NgAgYjcdBlprwqR+WV02jnGX3mRUEEkt/+5QiOTxsR5XD714JAFpm
 gcUbcfFma+4DI+LY6T56DUtN8jWvehtO9CTfFaaF08pQTIY59HiSl5SQ9jbRpF/RKcGU
 Q0JUR5XN3TfsMxCGfE9enq7LDv8hD60YW/cn446uqBakASgRdHxgwWf9MnbJjC5ScKCu
 NPKHwVFIvIB4aLbEg/WVuUh5M7KXg/abxID0rOEcnr5GHzhNHzzQcgRbVnd0OoPv5z5h
 k22u2rwR8H0DnNoayfTeEd1ohlYEClY8XRIVAXAiTe6qHsdOH8hW7GIUd2Yxr0hHwYNv
 zgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758540881; x=1759145681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MTjvk6GxZuR2zGa6Oy3VxNKzOakA+GOA3aZioMtCQXs=;
 b=LXKw2KImJmVEdwNY/NOcBUZGJZy+x0QxjeegToWBjPC/UgNh5elgYuzDtBm0lvtluw
 wzAyTKnzU/Pa3+9RwOixzhHefhx/Ww2a5RlRuaIzh3Eg+3DqKGbyjVDCLY4ndo7k95jY
 puf0Ej5tVQwDdSfSsbZ62tfO5firLeqegu0jOEFcHM+8KMvHx/FUCyrF20uP1nZAUtYj
 0YTlnfcWNPBVLuueWFYE9VNSJlImJEjL9GgrtgJeZ1G7dwTFRUSQHK3ox8bTr38IYfK1
 zZ2QiG6a6BZyg+laWloMEoGtdRMK2N/iRwOBiWj0/SO+YKDzS/sj6VhH4iwZZJx28mEx
 L+SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxElHDFFrP7MQc87xcVMevHRWq9mKmtRl3Z9FKgK4rTOozGkWafgUhilW4tbQIj8rNHH/b8SXxHvlW@nongnu.org
X-Gm-Message-State: AOJu0YzuAuxWYw6oxYMvXxCmomsuqYQnSGZzY/tWaeMOAHxvkDu52VSm
 BUxIeVibTm/fXISoSL1Ux8QGNSuvsdQxiEqv7jYUQahiBomn/jP7JZUiTc9LXxnUrLQ=
X-Gm-Gg: ASbGnctK/1tw4rID2pVMcwb8uV+lNuAW9Oaj4s6UcncLZKhMR4f2bO4WHPqCI0jnizF
 80Kss5hkU6HC0VNiDL6AYz563TTt+jRYyoELydf8J8jp0fe+/WuGw3/3qFM2XTbG+DiMCn2xNGU
 +JOIP9/AYJoMN+qzMKXaQAY1byI18V72xPC0xC6Cg/KcZW33L5jrIAm7ZtGNft0hYf598+S6AjP
 vZs6rpUONyAvmjP1Ofu1MvJ2VfeIIrfn5D3aotjl3hlkzaj+3ihTgPQCDQJLp/AKPGwW2uYYO6v
 PkMsV976pk61BLV1cbvlwaPHqF5UfFMSkuXfhXQeyNMoOJhJck4Z13YWerZNqG2ia+qzM31mk4X
 BcGiLdg81QobLSs55BvEDg1OK8KoN21JboazBIoGFIpPeoaezR1IpsLHWZOGluKeuHg==
X-Google-Smtp-Source: AGHT+IGCvOUYvupXi0993l8RV+TWGYTek2iJflEx/BHxUChq4KnZ1fzP8ZnNceqg/GIAsANtMNHlKQ==
X-Received: by 2002:a05:6000:2dc1:b0:3f9:1571:fdea with SMTP id
 ffacd0b85a97d-3f915720302mr5531444f8f.44.1758540880519; 
 Mon, 22 Sep 2025 04:34:40 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee074121b2sm19532809f8f.27.2025.09.22.04.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:34:40 -0700 (PDT)
Message-ID: <cf87d645-c125-4c3c-b909-4eaabfcaa41c@linaro.org>
Date: Mon, 22 Sep 2025 13:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/25] plugins: add hooks for new discontinuity related
 callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1757018626.git.neither@nut.email>
 <03eab59217365665b60ac169723ab689d2a97be4.1757018626.git.neither@nut.email>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03eab59217365665b60ac169723ab689d2a97be4.1757018626.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/9/25 22:46, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition, we
> recently introduced API for registering callbacks for discontinuity
> events, specifically for interrupts, exceptions and host calls.
> 
> This change introduces the corresponding hooks called from target
> specific code inside qemu.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   include/qemu/plugin.h | 12 ++++++++++++
>   plugins/core.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 8cf20cd96f..cea0a68858 100644
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
> @@ -258,6 +261,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
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
> index a04cb2392d..1f0ddebcbf 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -105,6 +105,30 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
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
> +                                   enum qemu_plugin_event ev,
> +                                   enum qemu_plugin_discon_type type,
> +                                   uint64_t from)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    uint64_t to = cpu->cc->get_pc(cpu);
> +
> +    if (cpu->cpu_index < plugin.num_vcpus) {
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
> @@ -557,6 +581,24 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>       }
>   }
>   
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT,
> +                           QEMU_PLUGIN_DISCON_INTERRUPT, from);
> +}
> +
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_EXCEPTION,
> +                           QEMU_PLUGIN_DISCON_EXCEPTION, from);
> +}
> +
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_EV_VCPU_HOSTCALL,
> +                           QEMU_PLUGIN_DISCON_HOSTCALL, from);
> +}

No blocking question; do we really need one callback for each discon
type? (can't we just pass the type by argument?).


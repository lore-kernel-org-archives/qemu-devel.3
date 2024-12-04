Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2677CE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIy9O-0003oD-KE; Wed, 04 Dec 2024 17:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy9H-0003nc-9q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:47:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy9D-0003TQ-Lf
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:47:10 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee345c1bbdso255617a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352426; x=1733957226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9q2SdJy37ByRNCmFPhfaMzijVLYIDsVzz++KjVfFBg=;
 b=ooy5BQ5/cfjISjrQGLaChFinSHnQNEWM57Nnkpb3UHl8Qrt72JOpH2BhgAOjTVVtQw
 +coNMRS/D/OGxLLz+P+7KsXZBsURI8k2FusXbFU2bT+uESksx3PCwOfwEPdukf8lgzAk
 u3eArgnuwJGpNZQrAu8A3rzdU2jI0N8RtkIj+EtlbcE6e9b5hapjyhiTvhi/zMHrbBpb
 6I3L9DkNWqL/ZOW1yBauFuc1P3wPyMJ2WdEWE7UQUYJQQZqomvdlXIA8IGYURrkNHIuJ
 8q0PDExI8IhfAGuzbO34MtbGnPrYW6WK3QZ2sH5LBxiVdF15i4QooLBF0o7A2KV1ibwS
 w3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352426; x=1733957226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9q2SdJy37ByRNCmFPhfaMzijVLYIDsVzz++KjVfFBg=;
 b=tUkBILY0m58NQ61xGDBKOAt/P2PIZhNkB6N6lvuoNl30F22GNIs/UPBwHbhriDgOii
 IkGe6035xTmB8jmjRMLca29ujf+LdQ/raIF2S7aeLi/CB94MhMj/vKCHmqOOh/EIKVON
 mRJx5HnRhcwTjQI8QQ6MeJ9KMNGz6/t17/T8yF27NGKNJu7AYnvst2Lxyys/661anb7s
 nKNQi1R707NdV+XHglSQXJmS3X+C4FgcQbeWd8pqzeE36hOgOfYXcLUL5I6jWDzDwJcb
 Ew3hifo67fREWaQVCmp8PVuy0Me7LgXnpGomc9mwPztwZjEr9XoLAv9mSZRN6d+Ny0y5
 b19w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/aN1zyDexT8iWNAAAt7rojkW9O0T+OsGgNLy77ZGDYXOUmuHLIMdGVYiD142nCvjeMX6matvCJkaW@nongnu.org
X-Gm-Message-State: AOJu0YwV1D6dcv1M5Ug+NKi0GxZdVyUlRg+Hc3TXl6XGr82HqBWUEoYA
 FxDEkHcJTdCPv7yyDcwHFoGIfqFbFqBQ5oauTwwJ4BEMWuUbwO2IfoX3niQ1+hk=
X-Gm-Gg: ASbGncs5vm5YUYc1ZmfwMcexIhVjjl0N4zxfnuUYJXOA914YKNbowVqIQZAEB9u574H
 5quO9wbiDPyJuzBZxd64Zd98wpfC6RyG8GR1LrU0wu9EVcM+blbJWcghrRfTGBerbcw02HO23/Q
 NCEDHcPOFfgiFbsSVFwRhriMX8QZKJtVpAK6ctnDm8f1otKxuRpse6i+NNlZ5TPkauXoJF2+tA6
 NSWEmFEFcYnfrsc1BO3GXzjGbgnsbvRpk9+TQqm2gVrWXJlh5vU13MMhOcrvKjml8y8+xofHVB1
 m39VYW+sZzH101iXIaKIPA==
X-Google-Smtp-Source: AGHT+IEmLYs2mlOG29hOn7Fhdd5FRJFSKlvWYPi86Xr2njj/rq+wLVJ1NcdiehRa6V6mFCqP8+SlRQ==
X-Received: by 2002:a17:90b:1b4d:b0:2ee:889b:b11e with SMTP id
 98e67ed59e1d1-2ef0125b333mr12044521a91.30.1733352426089; 
 Wed, 04 Dec 2024 14:47:06 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45f7d7c4sm69678a91.3.2024.12.04.14.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:47:05 -0800 (PST)
Message-ID: <1f008181-46a4-44da-a6a1-8e3678af2dda@linaro.org>
Date: Wed, 4 Dec 2024 14:47:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/11] plugins: add hooks for new discontinuity
 related callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <18b8687e6310a68283b8b3ed72ad38479114bc51.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <18b8687e6310a68283b8b3ed72ad38479114bc51.1733063076.git.neither@nut.email>
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

On 12/2/24 11:26, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition, we
> recently introduced API for registering callbacks for discontinuity
> events, specifically for interrupts, exceptions and host calls.
> 
> This change introduces the corresponding hooks called from target
> specific code inside qemu.
> ---
>   include/qemu/plugin.h | 12 ++++++++++
>   plugins/core.c        | 52 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 27a176b631..3de9cb3fe4 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
>   void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
>   void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
>   void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to);
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to);
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to);
>   void
>   qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>                            uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
> @@ -243,6 +246,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>   static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>   { }
>   
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{ }
> +
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{ }
> +
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{ }
> +
>   static inline void
>   qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
>                            uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
> diff --git a/plugins/core.c b/plugins/core.c
> index a89a4a0315..2c9637334f 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -112,6 +112,43 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
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
> +                                   uint64_t from, uint64_t to)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev;
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
> @@ -547,6 +584,21 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>       }
>   }
>   
> +void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from, to);
> +}
> +
> +void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from, to);
> +}
> +
> +void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from, uint64_t to)
> +{
> +    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from, to);
> +}
> +
>   void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>                                          qemu_plugin_vcpu_simple_cb_t cb)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755FBE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIy7h-0002gP-5r; Wed, 04 Dec 2024 17:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy7d-0002fn-0K
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:45:29 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy7b-0003Nu-5x
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:45:28 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fcc8533607so347878a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352325; x=1733957125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XK7SF/Q9KYBxwC/DHUQmd07jbjXrGqFMjTGR3jkWbpc=;
 b=f3kF4469LGN9wENWZnH2b0zdssqHlbU9xJuINNNkW4qXXV8oPrbpFsYAnQvcLlmQ/A
 KWykmiaBKJjTJo0pDc241eZkQFevmldP2tMGcwZYiDbLAzw+zw2lXzKR+8dbtdqF6lgP
 e4Etpg4Sr6ma9UEzgIxv7L2eIcndGkD2BLtD3pMidniTCUfTwOm5IfGKbdRwhp5PklTS
 mNVjCNT48OeHw/6Sc15TH/f6x2WVeBrRzi617er4cjBsHjCisO+znatuc3bfyPOEDVzm
 lwU8l3y1o61+ldv30ipkgCs6WMwaGegMZzeH0auDxc6EpAcsJvHyeekImTtHJCl6fNB3
 qWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352325; x=1733957125;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XK7SF/Q9KYBxwC/DHUQmd07jbjXrGqFMjTGR3jkWbpc=;
 b=KC3NXsP5YFfIgSgD54WB3kExYbmEBcE5YE9jMErZU92YOVHrti+Km6JiyxF34O5rC5
 by2AM1hnNfJtvnK+RiY4/o2nZ2BgjgWKwAoW+LHskvKzkVz4Jyc8FX507SBcLbNcIQFy
 kDYfe/KiMwD6vl5rRTZbgUSdzEPxwj+vpYGHduGY1Mk2sw2oqWrYm2F/7BV4/ou+1pWs
 4pdepYBHbinvhq5hbLCzlHbG3xRj/jIAs5Ik+Opw0Xq1BIfBDG098I/+yrYgayhsgHlw
 +ZpnVc5IDIYE6YDZb0tYiwMyrx/ERs3jnE591D00FfHy7kzTqvrY/CtpoCNLwXNgEL2f
 /i4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvKl5fdNLpUjMpJfv0lzVhKr6G8zYXZRhVkUN0jCiI1r2W4GUHFBYML1OJYi6d/qBVmITOgw0cl//H@nongnu.org
X-Gm-Message-State: AOJu0Yx4c09jO1tRXBxQ7RtQ5TYcGw072m6RTv0ESXIVasHrvFvRe6+/
 2InCi73DgBaZyjsNdnUQs0Sd06gETbdYT0Ny1sZ/mZ3XiuaZtdZ3pbvD3Fp/8hU=
X-Gm-Gg: ASbGnctDQIQNsv9VUrZvCN52Whie0oVWnQfD57gUnUODL3r720MQTOR/mRUAcLAvx6G
 3aHQEd0SCVQ/pDF7kgSIsS+YLV29OK0SFpn/B0D6D1LSh2mIcsG1+pcFFvOv2c5wQPEIpTfhxFU
 +ZL67pdViPMCaUcXsdphsl2fePx9x7AuFM6qIrfgVlcG6saTZKV7n62nuGjtVwjqL1ovk4ApqUv
 To3eSlAH2wG9gbXKDYKsFW+CgfInq4ksK6o3OX4WqtLaolqXaSvT+0oLXJWy7i6UNPfphcvgF92
 SgntluqP4MIjF+xrXJP50w==
X-Google-Smtp-Source: AGHT+IHk968599/R3JGnTDm2qP55jLR0beqzmQWID6U6l99EWjOsp7f86cqYSLhHUU7Zqltc/4+m8Q==
X-Received: by 2002:a05:6a20:6a1b:b0:1db:f00e:2dfe with SMTP id
 adf61e73a8af0-1e165412f88mr12192509637.39.1733352325245; 
 Wed, 04 Dec 2024 14:45:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd156dfe2fsm59064a12.31.2024.12.04.14.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:45:24 -0800 (PST)
Message-ID: <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
Date: Wed, 4 Dec 2024 14:45:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

thanks for the update!
Comments below.

On 12/2/24 11:26, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. However, traps of
> any kind, i.e. interrupts or exceptions, were previously not covered.
> These kinds of events are arguably quite significant and usually go hand
> in hand with a PC discontinuity. On most platforms, the discontinuity
> also includes a transition from some "mode" to another. Thus, plugins
> for the analysis of (virtualized) embedded systems may benefit from or
> even require the possiblity to perform work on the occurance of an
> interrupt or exception.
> 
> This change introduces the concept of such a discontinuity event in the
> form of an enumeration. Currently only traps are covered. Specifically
> we (loosely) define interrupts, exceptions and host calls across all
> platforms. In addition, this change introduces a type to use for
> callback functions related to such events. Since possible modes and the
> enumeration of interupts and exceptions vary greatly between different
> architectures, the callback type only receives the VCPU id, the type of
> event as well as the old and new PC.
> ---
>   include/qemu/plugin.h      |  1 +
>   include/qemu/qemu-plugin.h | 43 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 9726a9ebf3..27a176b631 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -59,6 +59,7 @@ union qemu_plugin_cb_sig {
>       qemu_plugin_udata_cb_t           udata;
>       qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
>       qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
> +    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
>       qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
>       qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
>       qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 0fba36ae02..9c67374b7e 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
>   typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
>                                               void *userdata);
>   
> +
> +/**
> + * enum qemu_plugin_discon_type - type of a (potential) PC discontinuity
> + *
> + * @QEMU_PLUGIN_DISCON_INTERRUPT: an interrupt, defined across all architectures
> + *                                as an asynchronous event, usually originating
> + *                                from outside the CPU
> + * @QEMU_PLUGIN_DISCON_EXCEPTION: an exception, defined across all architectures
> + *                                as a synchronous event in response to a
> + *                                specific instruction being executed
> + * @QEMU_PLUGIN_DISCON_HOSTCALL: a host call, functionally a special kind of
> + *                               exception that is not handled by code run by
> + *                               the vCPU but machinery outside the vCPU
> + * @QEMU_PLUGIN_DISCON_ALL: all types of disconinuity events currently covered
> + */
> +enum qemu_plugin_discon_type {
> +    QEMU_PLUGIN_DISCON_INTERRUPT = 1,
> +    QEMU_PLUGIN_DISCON_EXCEPTION = 2,
> +    QEMU_PLUGIN_DISCON_HOSTCALL = 4,
> +    QEMU_PLUGIN_DISCON_ALL = 7
> +};

Matter of style, but would be better to use:

enum qemu_plugin_discon_type {
      QEMU_PLUGIN_DISCON_INTERRUPT = 1 << 0,
      QEMU_PLUGIN_DISCON_EXCEPTION = 1 << 1,
      QEMU_PLUGIN_DISCON_HOSTCALL = 1 << 2,
      QEMU_PLUGIN_DISCON_ALL = -1
};

> +
> +/**
> + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
> + * @vcpu_index: the current vcpu context
> + * @type: the type of discontinuity
> + * @from_pc: the source of the discontinuity, e.g. the PC before the
> + *           transition
> + * @to_pc: the PC pointing to the next instruction to be executed
> + *

Missing those parameters when building doc.
include/qemu/qemu-plugin.h:198: warning: Function parameter or member 
'id' not described in 'qemu_plugin_vcpu_discon_cb_t'
include/qemu/qemu-plugin.h:289: warning: Function parameter or member 
'type' not described in 'qemu_plugin_register_vcpu_discon_cb'
2 warnings as Errors

> + * The excact semantics of @from_pc depends on @the type of discontinuity. For
> + * interrupts, @from_pc will point to the next instruction which would have
> + * been executed. For exceptions and host calls, @from_pc will point to the
> + * instruction that caused the exception or issued the host call. Note that
> + * in the case of exceptions, the instruction is not retired and thus not
> + * observable via general instruction exec callbacks. The same may be the case
> + * for some host calls such as hypervisor call "exceptions".
> + */
> +typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
> +                                             unsigned int vcpu_index,
> +                                             enum qemu_plugin_discon_type type,
> +                                             uint64_t from_pc, uint64_t to_pc);
> +
>   /**
>    * qemu_plugin_uninstall() - Uninstall a plugin
>    * @id: this plugin's opaque ID

Overall I'm ok with what it looks like.

However, it seems that your conclusion was we can't always guarantee to 
have from_pc, and I'm not sure that the solution to simply drop it is 
the right one.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23AF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFWz5-0003gD-Mv; Wed, 22 Apr 2026 08:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFWyW-0003ZW-Cr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:46:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFWyS-0003uH-Nh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:46:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so3689698f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776861990; x=1777466790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pdIGFris0LcFliAfxkjkRyx8MOk+sTo4lkSE4XaOh8E=;
 b=N8TgEuXI6gw8tUYOhWPYhdP2EX8xQrm/akCXiVIXSWgtTCGbNBgz7540wdR6wtUZaf
 glqojxxOXjOzJoQrNGf6uakNH1XgNr6qLauvAmYAOtNQ373vZ+5MHNiUSPS5sElkfuUM
 CnljWnqI4PsRzNjZu3mQsiJX3XKHB5Wc7Ls9VvUZXyQdfA36b7Z4A3hxNObod69R61xS
 Cc/B9KVbrDhuLOioVofbK4B2qLfNAAsuovW7vV+sLrEEHffhcMVHfboZYv9IVMD5EYbp
 M4A5rhzgZ1ctRGbIET9+yCNQVrXEoRggd0kJ4ExIn9CGy5TNvKe28myyjDUXgb/qRg/J
 WOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776861990; x=1777466790;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdIGFris0LcFliAfxkjkRyx8MOk+sTo4lkSE4XaOh8E=;
 b=TswbEwMG8qgkRb+B4FjAu9wspN5i5HjQA3J/7NADMPZcJ4G4nyziFTSwMOLyxyk6F2
 NebnL2OebcIyy4ZKakmdPcWwGlJ9VRuaExiD5NhSprr9UaQJzn7UAuYp01FyrhaQL2nS
 h3oZwlk1+Fa2B6GtvUWH2THoX/lFIWS9NuenoGEh6pPE0gloPvK28OsHJAb687Rok8TA
 yODkjVaFfnLkTkFMab0BTN4cr/Xex5heDhhuuqQ/PAQ0j331dg/90cK6rdUKnffChwGX
 OZExp3FPNWVVcytBvHZmjcfxJ6wSLWyiEqBeXgy1iAhzmxHHwsaN79AfUEnlFiSIv0Nj
 CcSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WPgJUfsFBQKLU9q8UnaWRwhp12x1HzmFEf7PbeBlj+KSgocULzMD2kY2wuF2lJnv2fi9FOd6Q3Ckq@nongnu.org
X-Gm-Message-State: AOJu0Yyh3d3RtGgy3n/OTY2M6viEWEESOGJnUms4tcquZupYRRxvV4be
 kDtGE4fQYcEUOkBLLfhQ1JgCTENLD41EhrRHRLFaAsdk6BxQ0KCsZZAc7mCfUOg4A/4=
X-Gm-Gg: AeBDiesz4eu+TxyqcfA5+LD2ScASbj9n30OLl+bx+qUN73qKWOsDcsCOEIssqjg8Fur
 qnf2TIfjfXBvsOeEofkFVdZ8rumLL+MOLsJ7D1ssLJHdDY9L1qgegc8cgxv2JrweRnSpwlQPQ44
 6TrIKw1S8ih4rQTX1NOQ7IGK6Kd+lAIImzYKwFBRWZX/iDPVIBLQRr7PGJTeIP1XXBR07aglfQZ
 rjkiqHsXdGl8tnEtRsdwMWtpZuK26RuQ9H4r+B5BLwktIy+GVySWqnreIFyg0sHlLNUoXHCmLWJ
 3XHGKfFugIv9Yu5G4o97yoHwkQYtQkKBs8jXsv50j7VImOAJ8nTTtpjsdblrxbeSBAIUgFDminO
 5DBXskDUDPGhvMQlgmz0r7vD9ZalTE/8kC/5wU5sgoVfUtEedkcbdn2omjGAGjkUIX8nzuTziK3
 7Ij8IYHOxM13uXx6thEK1RtX79jMlA+uOi4Yi3dxFO/TOTdVBMYmb+chLykTR8fRGmfNWeH1a8e
 lQn
X-Received: by 2002:a05:6000:2f8a:b0:43d:7a08:a5e6 with SMTP id
 ffacd0b85a97d-43fe3e073c9mr36804737f8f.29.1776861989671; 
 Wed, 22 Apr 2026 05:46:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm46545447f8f.2.2026.04.22.05.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 05:46:29 -0700 (PDT)
Message-ID: <a8cb94f0-9970-40b8-912b-3ab81a5907f4@linaro.org>
Date: Wed, 22 Apr 2026 14:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] whpx: i386, arm: do partition reset on boot CPU reset
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260421205749.55060-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421205749.55060-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

+Ani

On 21/4/26 22:57, Mohamed Mediouni wrote:
> WHvResetPartition resets partition state, and is not supported on Windows 10.
> 
> On Arm, it's supposed to be used for reboots. The prior location of the
> WHvResetPartition call wasn't right, as other vCPUs might still have
> been running, causing the call to fail.

Is it very different from the conceptual step introduced in commit
4003e5e65fe ("hw/accel: add a per-accelerator callback to change
VM accelerator handle")?

> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/accel-system.c       |  9 +++++++++
>   accel/whpx/whpx-common.c   | 13 +++++++++++++
>   include/accel/accel-ops.h  |  1 +
>   include/qemu/accel.h       |  3 +++
>   system/runstate.c          |  5 +++++
>   target/arm/whpx/whpx-all.c |  2 --
>   6 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index 150af05bf5..5352ccd937 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -75,6 +75,15 @@ void accel_pre_resume(MachineState *ms, bool step_pending)
>       }
>   }
>   
> +void accel_reset(MachineState *ms)
> +{
> +    AccelState *accel = ms->accelerator;
> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
> +    if (acc->reset_vm) {
> +        acc->reset_vm(accel);
> +    }
> +}
> +
>   /* initialize the arch-independent accel operation interfaces */
>   void accel_init_ops_interfaces(AccelClass *ac)
>   {
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 6fe44d5910..1f7b7d764d 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -205,6 +205,18 @@ static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
>       cpu->vcpu_dirty = true;
>   }
>   
> +/*
> + * Partition support
> + */
> +
> +static void whpx_partition_reset(AccelState* as)
> +{
> +    struct whpx_state *whpx = &whpx_global;
> +    if (whp_dispatch.WHvResetPartition) {
> +        whp_dispatch.WHvResetPartition(whpx->partition);
> +    }
> +}
> +
>   /*
>    * CPU support.
>    */
> @@ -622,6 +634,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
>       ac->name = "WHPX";
>       ac->init_machine = whpx_accel_init;
>       ac->pre_resume_vm = whpx_pre_resume_vm;
> +    ac->reset_vm = whpx_partition_reset;
>       ac->allowed = &whpx_allowed;
>   
>       object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
> index f46492e3fe..a1c9f3ae7b 100644
> --- a/include/accel/accel-ops.h
> +++ b/include/accel/accel-ops.h
> @@ -33,6 +33,7 @@ struct AccelClass {
>       /* system related hooks */
>       void (*setup_post)(AccelState *as);
>       void (*pre_resume_vm)(AccelState *as, bool step_pending);
> +    void (*reset_vm)(AccelState *as);
>       bool (*has_memory)(AccelState *accel, AddressSpace *as,
>                          hwaddr start_addr, hwaddr size);
>   
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index d3638c7bfd..0e12aea7db 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -54,6 +54,9 @@ void accel_setup_post(MachineState *ms);
>   
>   void accel_pre_resume(MachineState *ms, bool step_pending);
>   
> +/* Reset accelerator state. */
> +void accel_reset(MachineState *ms);
> +
>   /**
>    * accel_cpu_instance_init:
>    * @cpu: The CPU that needs to do accel-specific object initializations.
> diff --git a/system/runstate.c b/system/runstate.c
> index 2d4e95a216..734e3c037c 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -564,6 +564,11 @@ void qemu_system_reset(ShutdownCause reason)
>           qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>       }
>   
> +    if (current_machine) {
> +        /* Tell the accelerator that the VM is being reset. */
> +        accel_reset(current_machine);
> +    }
> +
>       /*
>        * Some boards use the machine reset callback to point CPUs to the firmware
>        * entry point.  Assume that this is not the case for boards that support
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 4019a513aa..f345fea4fe 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -472,8 +472,6 @@ int whpx_vcpu_run(CPUState *cpu)
>               if (arm_cpu->power_state != PSCI_OFF) {
>                   whpx_psci_cpu_off(arm_cpu);
>               }
> -            /* Partition-wide reset, to reset state for reboots to succeed. */
> -            whp_dispatch.WHvResetPartition(whpx->partition);
>               bql_unlock();
>               break;
>           case WHvRunVpExitReasonNone:



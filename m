Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E26CEE36A9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZwJ-0002kL-2V; Thu, 12 Feb 2026 11:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqZwC-0002jX-I9
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:53:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqZwA-0005xV-QT
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:53:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so15843455e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770915185; x=1771519985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RniBsc2Xbq85WI7J4jNKYo1JqkqyD7JEHQQIAnWE9EA=;
 b=Kuc0ccjF/fL9NfKS6mC47PgRVVE0Vh/0k1aCqUX0Q5/CbgMKCkfalJ7q8RZndl9We6
 maOfhGKSLSA1kNvvItUKkSR9f6aQsWmIvkWsNa6iZlfskID5XexKCs0AJ01xnkxe/t6L
 bH4C9cz89YOwS84vsFkVU0NjDEy47jmm75o0b987Y4GUdSysNNPMLoCYrXmBsV5bHOAx
 rVMN3uhITuznI5F9PorPb6ZFQgnMAQUOC+ym5ptOBIEu5LnGGcGiS0P7FO6cNRKNmd8O
 ovv5fG2puKrysz5ddYghDC9osPdX3WKZjKQv8kFQBzU2tI0HeimkPzooTA94aUFXlL2+
 /B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915185; x=1771519985;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RniBsc2Xbq85WI7J4jNKYo1JqkqyD7JEHQQIAnWE9EA=;
 b=is8pBsOfdPLEZOqphnMgUdfN76TLHmfoyMxig8bDZquhSxUMK8zhXXrBWk8HjiqcKa
 9YrjF/nufbWe7c7p6l2x+lw6wnm72vSAPN8gAQeMsMffvlaTa7FkhAG2zIvQH/br5L2r
 TgKZBSDF3TJorUAP5fDQOTBn8YjaZBlU2h5xJvjx0h2QmPMnWAsasprorjhvt+Iy/iPI
 ZOa+0FfqOd8rVqagXU6JmxLlrKgbHZFuUlKg4BeozvWiDGec614FMjNexQKPjMoo4Nuu
 ku1rQ+I3+0Ttxlu8QnCq0IHIrdv5CtqiCpqR26OegcPZRRaAx8D5roP1lvOXCE9O9zX6
 dCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgX+jQtZLER2RAyRx7UIHrrKnE1N/oasq6YQxfDdH7bdIQHBaX4oYcrKvwQPaMCBPp+fta68AYMyd0@nongnu.org
X-Gm-Message-State: AOJu0Yy7lzAPDk666uFcaSeu8O0dkMFz8OjSwgp00tw1VN4Up/rETAA9
 JmnGvGxcdTCsWgUFCTfR1lWQoA+YREWCIM5zEZ5OMjn4qw+PFh0eiDr7p2JXhGE6UTxpDZsvCTr
 ibiNmZ5w=
X-Gm-Gg: AZuq6aJILY5iG8V4OzPcTiO61r/aKKyS0WYsOL6llI7slVJ2X0Rs6X12dapaxjDOsnr
 8iqtFE+vkNffvDKmNO9BJGZaIUE/MkTRy3h2thJclIW6bAN2GY3wUR8Bpz8Y5J0asGGyAW2KByl
 CmAHltYlzSro1BILl5fZFdhySkbmMyR4EHzg3DZnyAfZs9W6Ic5raazQTznsqAPAqpMOTEErQaN
 LrSdLfwVlOHLu9S5BN2nDtp3KOr9T1DHg2QFTGO8CiRv7LjNEvUCVmHEfJZ9qBh1UDhEw4DTSEM
 rT6toxrjAzKIzh5/tr7GhdxVff4Xo0rdhz2YA9JSKItOnBL6zNFxlbDtkglzdJaYY6jgcW4J+Ff
 8YDbMfdNswlVVm2f5FvgicoySESVUdz21TDQcXULINS6QOhRyBgd/E9PO1kNZ9hJz3EIqU6Lw7l
 h9nppPqnnovGhgKoBQoDhk24VUOOFxjbnX0rSG02tXcStLFsb8YfwiJOE0IApeMAdeMg==
X-Received: by 2002:a05:600c:4f91:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-48365fec543mr50874815e9.4.1770915184801; 
 Thu, 12 Feb 2026 08:53:04 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm198594775e9.8.2026.02.12.08.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:53:04 -0800 (PST)
Message-ID: <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
Date: Thu, 12 Feb 2026 17:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-4-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212062522.99565-4-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Ani,

On 12/2/26 07:24, Ani Sinha wrote:
> When a confidential virtual machine is reset, a new guest context in the
> accelerator must be generated post reset. Therefore, the old accelerator guest
> file handle must be closed and a new one created. To this end, a per-accelerator
> callback, "reset_vmfd" is introduced that would get called when a confidential
> guest is reset. Subsequent patches will introduce specific implementation of
> this callback for KVM accelerator.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   include/accel/accel-ops.h |  1 +
>   system/runstate.c         | 37 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
> index 23a8c246e1..998a95ca69 100644
> --- a/include/accel/accel-ops.h
> +++ b/include/accel/accel-ops.h
> @@ -23,6 +23,7 @@ struct AccelClass {
>       AccelOpsClass *ops;
>   
>       int (*init_machine)(AccelState *as, MachineState *ms);
> +    int (*reset_vmfd)(MachineState *ms);

So far 'vmfd' is a KVM concept. Can we use a more generic name?

Please add a @docstring description for this handler.

>       bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
>       void (*cpu_common_unrealize)(CPUState *cpu);
>       /* get_stats: Append statistics to @buf */
> diff --git a/system/runstate.c b/system/runstate.c
> index 5d58260ed5..0a74e3ade5 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -42,6 +42,7 @@
>   #include "qapi/qapi-commands-run-state.h"
>   #include "qapi/qapi-events-run-state.h"
>   #include "qemu/accel.h"
> +#include "accel/accel-ops.h"
>   #include "qemu/error-report.h"
>   #include "qemu/job.h"
>   #include "qemu/log.h"
> @@ -509,6 +510,9 @@ void qemu_system_reset(ShutdownCause reason)
>   {
>       MachineClass *mc;
>       ResetType type;
> +    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
> +    bool vmfd_reset = false;
> +    int ret;
>   
>       mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
>   
> @@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
>       default:
>           type = RESET_TYPE_COLD;
>       }
> +
> +    /*
> +     * different accelerators implement how to close the old file handle of
> +     * the accelerator descriptor and create a new one here. Resetting
> +     * file handle is necessary to create a new confidential VM context post
> +     * VM reset.
> +     */
> +    if (!cpus_are_resettable() &&
> +        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
> +         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
> +        if (ac->reset_vmfd) {
> +            ret = ac->reset_vmfd(current_machine);
> +            if (ret < 0) {
> +                error_report("unable to reset vmfd: %s(%d)",
> +                             strerror(-ret), ret);
> +                vm_stop(RUN_STATE_INTERNAL_ERROR);
> +            }
> +            vmfd_reset = true;

If we need a such flag, please rename it generically.

> +        } else {
> +            error_report("accelerator does not support reset");
> +        }
> +    }
> +
>       if (mc && mc->reset) {
>           mc->reset(current_machine, type);
>       } else {
> @@ -543,7 +570,15 @@ void qemu_system_reset(ShutdownCause reason)
>        * it does _more_  than cpu_synchronize_all_post_reset().
>        */
>       if (cpus_are_resettable()) {
> -        cpu_synchronize_all_post_reset();
> +        if (vmfd_reset) {
> +            /*
> +             * If vmfd has changed, then vcpufds have also changed.
> +             * Need to sync full cpu state for non confidential guests.
> +             */
> +            cpu_synchronize_all_post_init();

Calling post_init() in reset() is dubious. It might work with KVM by
chance (because only KVM implements .reset_vmfd), but by design I
don't expect it to work on other accelerators. If you really think
this is the only solution, then you'll need to document cpu_sync*
methods very carefully.

> +        } else {
> +            cpu_synchronize_all_post_reset();
> +        }
>       }
>   
>       vm_set_suspended(false);

Isn't the confidential_guest_kvm_reset() API more appropriate here?


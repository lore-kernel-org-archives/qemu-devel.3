Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8C1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujcRl-0005a1-Gl; Wed, 06 Aug 2025 07:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujcNs-0002XN-6g
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:32:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujcNo-0000Aa-Ly
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:32:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so3844579f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754479954; x=1755084754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N41CPXk6KyWRQrYKEY9IeLXQoYbkGzLpS42kYyNwKAk=;
 b=RrQydYf8EweJiurtQgGui41+z+Cm9bFk1YQ+hDCAoFiBV7LZAU4gWUG6fUlAzfYt5L
 +KGXFTC+pIEN1tTtFGAP8rD/iupmITCuq/hLIOOF1uBlzqwZA1UEwvbBnTv1TY4wcKf6
 Cbz0CkxpD2bnPU2CUtSKTJXuG8BdehO8XR7OntXKXNxlRc/Oz82W3UKapee9BclMit9w
 6zDTkALleTeQXet99CL2MPdAmOX9tMjH1EF9Ttx+sJOgh9fQfW/a0dar8oCv0SK1Ifo8
 s+M1hDs7KN+/lwTorryQlrqyroU0tV37FugOUhUOGYmrwQwbQZZy63XEnt1zqnPVXnZh
 L5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754479954; x=1755084754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N41CPXk6KyWRQrYKEY9IeLXQoYbkGzLpS42kYyNwKAk=;
 b=MftF3hwxaE8ZQPSkO8/zTWt24CABbkrwiESrR/iHBstbpapFHgHgfwC+WUME7NDAap
 7TU9rMsVEQzA3hnYHIO34Sf76bOS41/chqkISDT7m+GryyK39LKbQB47Gwwy6B2xDmrR
 TmcVD/Sm1SZoO7nJOsaTg0bG2corHaHHZQ3tXqH1cvmjB8DnFGujePnr0dcR+zYqH9MY
 8/XMEfLmFSPhHyhnbQiPZ9PlgmoE8LbCmiE1nh2tO3WWrik/gzA+AdGf6t0GWfeh7MLt
 RyYT2ZS9hdH85ZHCss02jrgivEC/IFf7WnsrZZkXawJe0nTK+K+nE5/KSxX194RhfV1a
 Jwlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeeHNFPodDieRU2okC+aSJzW+5Z8GEacKpMiKNZFrDhQrdjsep5xhb5Y4Q7QYptSAFGbavWhvfOWB5@nongnu.org
X-Gm-Message-State: AOJu0YzETvAvle1B+ulHs4rq6U7Ji/enweErKN0IO2nHDJI6KjvuMp3u
 lR2KVlL2CNQKUrfTZoiAhIcK30IbChS3Xq2L6tBlLDHV5awjgjgsixhpkgUeHEgcAt94EOl8TY9
 ZnwVv
X-Gm-Gg: ASbGncsGNcYTaj+kvaLi6hyIdRn9I5cgz/aiNYfj+NehudU4nxM+r+yANLQNrPmtfud
 eYCMpNlPPtzLTiumD69ZD0r8G3wwL4JQVVk4zxWtVEYdSuun9QxfYOdSEKUx9sMnEqvcY6lBlUL
 SHSsprk3AhPom/Qe41y914u5YllwTavGV1Lq1A7H+s5W+BV/cb4nDgGrUaB+h77s+8ukPuLiTT8
 ssDtUQKF7z74MxMe1gJVxahfhgzzZqKRSGdOMxFevBaA5PaSbCtphQWLsIn5g4T0AGayRjMAhtF
 nxWoR/ZkZsI88dKyChokJIEYFtUOkYm/17YlSI7KAut0KHRP+1593eWrfly1GxhCVQE/cs0z17v
 45eEieeYoNM9bGrqoa2zAWn5N7WxCDYYXiRkcUOzIKHcIdSGzv4tGvPGmlMkGPt6D/w==
X-Google-Smtp-Source: AGHT+IFMM3Ypr+FRs3yfml80pD85anfq5qGiocHLdnQ/RelWnX9QyYRq/dI7NfZnwh005FDrGgeunQ==
X-Received: by 2002:a05:6000:2482:b0:3b7:951c:aef3 with SMTP id
 ffacd0b85a97d-3b8f41c8213mr2148352f8f.38.1754479954504; 
 Wed, 06 Aug 2025 04:32:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47ca5fsm22343078f8f.63.2025.08.06.04.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 04:32:33 -0700 (PDT)
Message-ID: <32928301-9db8-4003-84fc-82f3129bb8c3@linaro.org>
Date: Wed, 6 Aug 2025 13:32:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/13] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov
 <imammedo@redhat.com>, qemu-arm@nongnu.org, Alexander Graf
 <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-3-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728134114.77545-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/25 15:41, Mohamed Mediouni wrote:
> Misc changes needed for HVF vGIC enablement.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c        | 44 ++++++++++++++++++++++++++++++++++++++
>   accel/stubs/hvf-stub.c     |  1 +
>   hw/arm/virt.c              | 16 +++++++++-----
>   hw/intc/arm_gicv3_common.c |  3 +++
>   include/system/hvf.h       |  3 +++
>   system/vl.c                |  2 ++
>   6 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 0a4b498e83..5af76ba7a6 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -10,6 +10,8 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
>   #include "accel/accel-ops.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
> @@ -20,6 +22,7 @@
>   #include "trace.h"
>   
>   bool hvf_allowed;
> +bool hvf_kernel_irqchip;

OK.

>   
>   struct mac_slot {
>       int present;
> @@ -290,6 +293,41 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
>       return SSTEP_ENABLE | SSTEP_NOIRQ;
>   }
>   
> +static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +#ifdef __aarch64__

We try to avoid such #ifdef'ry...

> +    OnOffSplit mode;
> +    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
> +        return;
> +    }
> +
> +    switch (mode) {
> +    case ON_OFF_SPLIT_ON:
> +        hvf_kernel_irqchip = true;
> +        break;
> +
> +    case ON_OFF_SPLIT_OFF:
> +        hvf_kernel_irqchip = false;
> +        break;
> +
> +    case ON_OFF_SPLIT_SPLIT:
> +        error_setg(errp, "HVF: split irqchip is not supported on Arm.");
> +        break;
> +
> +    default:
> +        /*
> +         * The value was checked in visit_type_OnOffSplit() above. If
> +         * we get here, then something is wrong in QEMU.
> +         */
> +        abort();
> +    }
> +#else
> +    error_setg(errp, "HVF: setting irqchip configuration not supported on x86_64.");
> +#endif
> +}
> +
>   static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
> @@ -297,6 +335,12 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>       ac->init_machine = hvf_accel_init;
>       ac->allowed = &hvf_allowed;
>       ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
... better add hvf_arch_register_class_properties(), empty stub
on x86 and filled in aarch64.

> +    hvf_kernel_irqchip = true;
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> +        NULL, hvf_set_kernel_irqchip,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, "kernel-irqchip",
> +        "Configure HVF irqchip");
>   }


> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..1c072d15a4 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1773,6 +1773,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
>                                      false);
>           object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
>                                      false);
> +        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
> +                                   false);

Discussing about this object_register_sugar_prop() call on IRC, Paolo
said:

  > It's okay the property already exists for KVM so it's okay to add
  > the synonym for HVF as well
  > Maybe make sure it's not registered for x86?

>           qdict_del(qdict, "kernel-irqchip");
>       }
>   



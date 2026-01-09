Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E245BD26D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJtV-00033f-9e; Fri, 09 Jan 2026 16:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJtH-00032v-RN
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:19:28 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veJtG-0005pr-4U
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:19:27 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81f3c14027cso38993b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767993564; x=1768598364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXs8thDAEX0T8FwN+HHt4IjEeYjwkoOPzTC5QOie3+s=;
 b=sTsvhklAonECEDETYyayVfdqqVMF6vjME6MR33BjUSvJ0pHH6O8/r09RdIU+SeagGL
 191o2BcUJSwYWWDSGMka8RGgB6KedrKmzds3xuosmdp/zWSmMfhK7jixtASfZaYfqimS
 bxXENjpoOQmUk6kKCjUkCIrfI/bYL0ooCR3mL+PXCyJm9DYDCr8qYRwZXF95bTffyUsR
 nh7utfEziWSrdEoyTO8QhAfFTpnoz6YSeAzUEZJDEmugyCUBEfTDNW7XCRl03csYnm9+
 1vGkp4cGOs9oTet6k2rL95hNmYcOYOkBo1kkL237bM4foB9KPHvItGkQAtpRDRhdZcTL
 hyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767993564; x=1768598364;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXs8thDAEX0T8FwN+HHt4IjEeYjwkoOPzTC5QOie3+s=;
 b=DEZPR182xHc7OeG5+qTWei6VH3BeHUH2qeJIzaPtFn2gXTD2DMMARZh1mikWa0mS2I
 u+FP8bZx3K5FGtpcQEJMG1JU4BBwsbuRtCIobp9lTGwgtstJwN4WWpPcMAuMW3eQ2YbP
 iWJ6Yh1gHKogzwSio0pVesOjnErafDDQ9YRVyzXS7XjC5usEl4iNPTBt1XsRi4SM8lSX
 qUJw1awkpK/PIiVRMvr9GUam1Yz+yqDOTHUj9DzYRxyXE1arxRflEfBmcsopVXeGWY5X
 qOqVmFBA35UtciU3tt1rongUuUlBdi9cInLQf9+ePJvkK87Srt9gIqkLEfkns6kwbxjd
 cSmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyHoHXDuB0epPT/M9JYuZ0RYTyITBEtA53I06ZEDwbeOHeaqWGp/4URrAeynZhQbPlj2OyThehh+P0@nongnu.org
X-Gm-Message-State: AOJu0Yyb7fxVCylbp1pCw8Id1EN4fWJQ2PPNIlxC/kQXrx9tx5DJbTrz
 52sqRi0FWaGCa3OUkHRFGm1Lq4sDDHdXA+AeQJYyfL37yaJK7PaHHO0LA7gimpQ4r38=
X-Gm-Gg: AY/fxX5MdHzpdxlj8RDHuHuwPbmIZ7ivHPnKQmOTlR8VUD+LNpFPQLR6NEQZj26JGsx
 8xgXqAbgSMn1NUfcbTBoY8A1y0oF42yONJTvcWyiS/u2MjdDZiq9U0eN++lCUPkVF2xNgWwj1VP
 2lCPnZ8nZ7007sqooUcZhTnu+wG+Gv63j8/X6FZJg37rRrZIMIo/xbrSwNqVu2toJpMe0J5XqQg
 53rQmj1n0Fa2KAIzyp0fQvkL2PLwyrTyhIxla6u9T9jDjP19yalPw+UEQfYKkTtF31N9uuZdnxd
 d+cSX4yuQ2boQ08PoJF+MeMbL7KkGeLiy3ZrYitG/vL424Oi/A1YJV2GDWQmSaRO4YxF9ssYjbX
 oIcuQT0jY8b8TuBalboPnIV22rKeIGDbSyuQpPMgicowwjqADT5ch5RQmNjtMrHes0DjpYEGVsr
 2FIctw5SfGFgttM47fAi7dE6KziQ==
X-Google-Smtp-Source: AGHT+IFZyNZBGiyTr2ozwWAMuU0nvavmm2JqC+DTmcXlBhvgImwWlOChlKfIs0s8VuB15R+KcahCIg==
X-Received: by 2002:a05:6a00:6ca2:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-81e1b779ffdmr3398736b3a.25.1767993563873; 
 Fri, 09 Jan 2026 13:19:23 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c5edd921sm11105584b3a.69.2026.01.09.13.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:19:23 -0800 (PST)
Message-ID: <e6f82d35-41cf-4acf-a47d-6130d5b6cc99@linaro.org>
Date: Sat, 10 Jan 2026 08:19:17 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/29] target/arm/arm-qmp-cmds.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Move gic_cap_kvm_probe to target/arm/kvm.c to remove #ifdef CONFIG_KVM.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h      |  3 +++
>   target/arm/arm-qmp-cmds.c | 25 +------------------------
>   target/arm/kvm-stub.c     |  5 +++++
>   target/arm/kvm.c          | 21 +++++++++++++++++++++
>   target/arm/meson.build    |  2 +-
>   5 files changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 6a9b6374a6d..cc0b374254e 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -11,6 +11,7 @@
>   #ifndef QEMU_KVM_ARM_H
>   #define QEMU_KVM_ARM_H
>   
> +#include "qapi/qapi-types-misc-arm.h"
>   #include "system/kvm.h"
>   #include "target/arm/cpu-qom.h"
>   
> @@ -263,4 +264,6 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
>   
>   void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
>   
> +void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
> +
>   #endif
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 45df15de782..29102587bae 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -43,29 +43,6 @@ static GICCapability *gic_cap_new(int version)
>       return cap;
>   }
>   
> -static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
> -{
> -#ifdef CONFIG_KVM
> -    int fdarray[3];
> -
> -    if (!kvm_arm_create_scratch_host_vcpu(fdarray, NULL)) {
> -        return;
> -    }
> -
> -    /* Test KVM GICv2 */
> -    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V2)) {
> -        v2->kernel = true;
> -    }
> -
> -    /* Test KVM GICv3 */
> -    if (kvm_device_supported(fdarray[1], KVM_DEV_TYPE_ARM_VGIC_V3)) {
> -        v3->kernel = true;
> -    }
> -
> -    kvm_arm_destroy_scratch_host_vcpu(fdarray);
> -#endif
> -}

Previously did nothing without kvm, and even with CONFIG_KVM fails silently if kvm can't 
be used.

> -
>   GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>   {
>       GICCapabilityList *head = NULL;
> @@ -74,7 +51,7 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
>       v2->emulated = true;
>       v3->emulated = true;
>   
> -    gic_cap_kvm_probe(v2, v3);
> +    arm_gic_cap_kvm_probe(v2, v3);

No kvm_enabled check.


>   
>       QAPI_LIST_PREPEND(head, v2);
>       QAPI_LIST_PREPEND(head, v3);
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index c93462c5b9b..ea67deea520 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -124,3 +124,8 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>   {
>       g_assert_not_reached();
>   }
> +
> +void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
> +{
> +    g_assert_not_reached();
> +}

Danger, Will Robinson!

This need only do nothing.
But you could equivalently add a kvm check to the call, and have the call be removed.


r~


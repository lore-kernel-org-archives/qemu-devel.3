Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43628D3A696
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 20:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5sYf-0001Rk-38; Tue, 29 Oct 2024 16:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sYc-0001Qx-MY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:11:14 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5sYa-0000UI-Oj
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:11:14 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539ebb5a20aso6069844e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730232668; x=1730837468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVffrm7ORWtwr/oTU7Spuj4YBIi+VLsXfNiPlPYNk9Q=;
 b=pYlMVtrgkWt/fXrWr6xRpa0xd22PSjid7b52NOBbTxLn8HuzWA0J8+a2PAIrW1iolG
 OEwKpcaN2Ig+tH4jU02xi/ulEAaG7cVjlBo2x8nklB5+fYlS+4s9E4kAWOA68TvyRvL2
 LdPgd8kCnSj+ZR41F7SKCncUpIuETG+AvN5Frrxc3QX2yAjYPxCFT9VRswoXeVo+Gjt4
 AhwoLrrUiKb7STt0WbuTGDRrsrJTPKwYNH35tzKLT7DaLbQ5xXxjTBTxd3m3Y6O+9tbi
 r5P5ElOiG4ewnP2QVvI1x2fEV+dl/t4NXQJjUl7Hl82AXAGFo3Dyb2uOIboOef9U30Rm
 FIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232668; x=1730837468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVffrm7ORWtwr/oTU7Spuj4YBIi+VLsXfNiPlPYNk9Q=;
 b=q0SgSmV2KFZEwRNwitTDHvu3x72NE3XhnMFTW15zDgYVn7GS0/FQqtG6BRWvEKrGd6
 t4I/IKRjL0vI06l6rAcWyfk+jtHQJqvgVtt5GtrtwPoIzEyGDD0fKGc+CGRUxeaF+uTP
 vnhrStPMy9AiovBsXq6WSw+evhVkbnH7tr98qGkGnlOIeIfvRV1e5EeWCcozmtwGjo4T
 f0CYbePmgiXbi29EENlwO0xzLk5cSsksHGSg3p9Na8ru3Q8aMP2h7JNkI5DUsrTd9mnA
 XIUT6dAnEykWK//FBuQelSfVv9JeztnEieqw5qpaTchYKfMpq5pRnLLu/37JFpvCyUH8
 ak3w==
X-Gm-Message-State: AOJu0YyeM7OIljaFilwT9tMP7nIU7IsKPo8/9FQQWHy/Jf7USNtme4Jc
 oQe5+kcXt+8fcVjY5BkElOyIvn71zom6nfBg/StRqCGDSAgDSGcymCrctFC6/xg=
X-Google-Smtp-Source: AGHT+IEQm7S7HhrAefu6bB3WsI9sjvU1NibhMhK2h3mgqHzs6Ac3q/ixT/MrrVYq2nNiKqsosFqETQ==
X-Received: by 2002:a05:6512:1285:b0:539:e513:1f66 with SMTP id
 2adb3069b0e04-53b3491e086mr6508337e87.37.1730232667785; 
 Tue, 29 Oct 2024 13:11:07 -0700 (PDT)
Received: from [192.168.156.226] ([91.223.100.133])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53bc0d5f161sm40364e87.213.2024.10.29.13.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 13:11:07 -0700 (PDT)
Message-ID: <31e8dc51-f70f-44eb-a768-61cfa50eed5b@linaro.org>
Date: Tue, 29 Oct 2024 17:10:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] hw/core: Make CPU topology enumeration
 arch-agnostic
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
 <20241022135151.2052198-3-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241022135151.2052198-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 22/10/24 10:51, Zhao Liu wrote:
> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.
> 
> To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
> CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
> socket.
> 
> Also, enumerate additional topology levels for non-i386 arches, and add
> a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
> with compatibility requirement of arch-specific cache topology models.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes since Patch v3:
>   * Dropped "invalid" level to avoid an unsettable option. (Daniel)
> ---
>   hw/i386/x86-common.c       |   4 +-
>   include/hw/i386/topology.h |  23 ++----
>   qapi/machine-common.json   |  44 +++++++++++-
>   target/i386/cpu.c          | 144 ++++++++++++++++++-------------------
>   target/i386/cpu.h          |   4 +-
>   5 files changed, 123 insertions(+), 96 deletions(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index b86c38212eab..bc360a9ea44b 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -273,12 +273,12 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>   
>       if (ms->smp.modules > 1) {
>           env->nr_modules = ms->smp.modules;
> -        set_bit(CPU_TOPO_LEVEL_MODULE, env->avail_cpu_topo);
> +        set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
>       }
>   
>       if (ms->smp.dies > 1) {
>           env->nr_dies = ms->smp.dies;
> -        set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
> +        set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
>       }
>   
>       /*
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 48b43edc5a90..b2c8bf2de158 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -39,7 +39,7 @@
>    *  CPUID Fn8000_0008_ECX[ApicIdCoreIdSize[3:0]] is set to apicid_core_width().
>    */
>   
> -
> +#include "qapi/qapi-types-machine-common.h"
>   #include "qemu/bitops.h"
>   
>   /*
> @@ -62,22 +62,7 @@ typedef struct X86CPUTopoInfo {
>       unsigned threads_per_core;
>   } X86CPUTopoInfo;
>   
> -#define CPU_TOPO_LEVEL_INVALID CPU_TOPO_LEVEL_MAX
> -
> -/*
> - * CPUTopoLevel is the general i386 topology hierarchical representation,
> - * ordered by increasing hierarchical relationship.
> - * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> - * or AMD (CPUID[0x80000026]).
> - */
> -enum CPUTopoLevel {
> -    CPU_TOPO_LEVEL_SMT,
> -    CPU_TOPO_LEVEL_CORE,
> -    CPU_TOPO_LEVEL_MODULE,
> -    CPU_TOPO_LEVEL_DIE,
> -    CPU_TOPO_LEVEL_PACKAGE,
> -    CPU_TOPO_LEVEL_MAX,
> -};
> +#define CPU_TOPOLOGY_LEVEL_INVALID CPU_TOPOLOGY_LEVEL__MAX


> @@ -341,18 +341,18 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
>       return 0;
>   }
>   
> -static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> +static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
>   {
>       switch (topo_level) {
> -    case CPU_TOPO_LEVEL_INVALID:
> +    case CPU_TOPOLOGY_LEVEL_INVALID:

Since we use an enum, I'd rather directly use CPU_TOPOLOGY_LEVEL__MAX.

Or maybe in this case ...

>           return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
> -    case CPU_TOPO_LEVEL_SMT:
> +    case CPU_TOPOLOGY_LEVEL_THREAD:
>           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> -    case CPU_TOPO_LEVEL_CORE:
> +    case CPU_TOPOLOGY_LEVEL_CORE:
>           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> -    case CPU_TOPO_LEVEL_MODULE:
> +    case CPU_TOPOLOGY_LEVEL_MODULE:
>           return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
> -    case CPU_TOPO_LEVEL_DIE:
> +    case CPU_TOPOLOGY_LEVEL_DIE:
>           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
>       default:
            /* Other types are not supported in QEMU. */
            g_assert_not_reached();

... return CPUID_1F_ECX_TOPO_LEVEL_INVALID as default.

Can be cleaned on top, so:

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>




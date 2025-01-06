Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5299E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtn0-0006Ge-0S; Mon, 06 Jan 2025 15:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUtmx-0006Fm-Ra
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:33:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUtmv-0006Yv-U7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:33:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21680814d42so181941985ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736195604; x=1736800404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tRChKa/6ydnGwRW0eNjgRJAJvFNapuIamBmUVRUNy3A=;
 b=IoQwsCO+dH8lnKWUZahye4QXYo4pIvN3x06dI+KhtTmEFpVQlJqy7lRP/ZM8bVT7dj
 Monyy+08cPdtFhQYYGXw0epE+fzUCgS7rMko9LWsXT3Ve0taxr5iTP9SjAW5taVjLbWE
 o8Am4OqcNHHtgAVJ1CJJjgkdI6aUze0vxJULQ/bou1UBMq+XF63aUSV0apubt+57fAtU
 VAbxFIalFZTetAYrT1raV43wSy+BQ0/PxqlElQV7VDU1bajAI0bpQuNT53MxHacmRX3U
 ziuZ9/alCRMzcrr2IUemNeIn0OiylObStdPAdB022OiODXOnNvNjvZlQPUQtYWejlScl
 4O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736195604; x=1736800404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRChKa/6ydnGwRW0eNjgRJAJvFNapuIamBmUVRUNy3A=;
 b=FVKRLkcONK26QTMnA+C4hqNE8+WayAdPRnfxo0KohlXfRQ/vzK5fkz480ZUWvst28h
 Di56NYdrIQHTnIfjM4lU+wSSgKq72+X6XvV7isTDc2Sn8cOcuoAGpjpbmuzLhz7Wi3dk
 6hWM3f+CTGwGIFNPhw6GWcwYWy9R/BXgckUKShHkh0WZVa0xKtLtD0IPBhGLYFRjR00R
 HyKQj7zcDzSAmju7NYvfMMLl93DyDZIkI8Ogpq8K68RrDFjhV5SZ/6X61ER20f2eMOqQ
 GRHpup4cx9HPQT7akEeNQ7SE28PUm50pdiMgF/P/Q42zO/9HOq+lYM7YpI9fMW1wy58c
 bYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWlhHtSYcsXRGeO/VfXeL8mWQWspPJJkQTGRY2HNFuarL520Ql1aGZvwARYU2cp8dSYkHzQpBT9ixp@nongnu.org
X-Gm-Message-State: AOJu0YzC/aMbvRAV6+Rqru/49TwfitkUKU3t44srl6+61dvdRqQDjn+w
 CaP3ODPzFNB7QC6ENKV86balzuiXmf/TwYYjKyj/S0hnVFfdPKjTFxWLtGW8w4Y=
X-Gm-Gg: ASbGnct1b01wINqpj//BQauuxu4RRSb+Tz9zZf9iOOM4Hf38hEmmsgNvVvANI25ICE4
 rbDBs1wiLXCrRQUlNDpPZnz8w4nMKoCz+Y8nBMXtpZ9pmI72kPhGpVwv2SQ4g85HPVvyL5zerY7
 80ppmC/TQVw7Mm2dISTRbU5B7eHRzCM5goU/vFrJCDhIh1MZJCNTlD6tIOSSPmzFFTh/q3G9bTb
 hNMng+jgyvQuChTSVK9dlYq6UocjvY8TfoNRuA64qfPtwUeNia2B4ofWcmvDR1rQMV9w9Aw4Eoq
 HMA2kyPIdrvaBb1jJTLj7y0LwN/XMnHr+iQ=
X-Google-Smtp-Source: AGHT+IGIo280ucsBcngxguAyG9JQ9T3VFgxxJUPO1hVz/7EWXjloduoiThjDr/f0vbWxM4+ikOS8ZQ==
X-Received: by 2002:a17:903:2384:b0:216:5cbd:5449 with SMTP id
 d9443c01a7336-219e6e9e8c5mr891272455ad.13.1736195604239; 
 Mon, 06 Jan 2025 12:33:24 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cde66sm296704655ad.145.2025.01.06.12.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 12:33:23 -0800 (PST)
Message-ID: <bd8168fe-c774-4f75-8a94-1a67ec31e38d@ventanamicro.com>
Date: Mon, 6 Jan 2025 17:33:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] accel/hvf: Use CPU_FOREACH_HVF()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Zhao Liu
 <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20250106200258.37008-1-philmd@linaro.org>
 <20250106200258.37008-7-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250106200258.37008-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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



On 1/6/25 5:02 PM, Philippe Mathieu-Daudé wrote:
> Only iterate over HVF vCPUs when running HVF specific code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 4 ++++
>   accel/hvf/hvf-accel-ops.c | 9 +++++----
>   target/arm/hvf/hvf.c      | 4 ++--
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 42ae18433f0..3cf64faabd1 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -11,6 +11,8 @@
>   #ifndef HVF_INT_H
>   #define HVF_INT_H
>   
> +#include "system/hw_accel.h"
> +
>   #ifdef __aarch64__
>   #include <Hypervisor/Hypervisor.h>
>   typedef hv_vcpu_t hvf_vcpuid;
> @@ -74,4 +76,6 @@ int hvf_put_registers(CPUState *);
>   int hvf_get_registers(CPUState *);
>   void hvf_kick_vcpu_thread(CPUState *cpu);
>   
> +#define CPU_FOREACH_HVF(cpu) CPU_FOREACH_HWACCEL(cpu)


Cosmetic comment: given that this is HVF specific code and we only support one hw
accelerator at a time, I'd skip this alias and use CPU_FOREACH_HWACCEL(cpu) directly.
It would make it easier when grepping to see where and how the macro is being used.
Same thing in the next patch with CPU_FOREACH_KVM().


LGTM otherwise. Thanks,

Daniel


> +
>   #endif
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 945ba720513..bbbe2f8d45b 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -504,7 +504,7 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>           }
>       }
>   
> -    CPU_FOREACH(cpu) {
> +    CPU_FOREACH_HVF(cpu) {
>           err = hvf_update_guest_debug(cpu);
>           if (err) {
>               return err;
> @@ -543,7 +543,7 @@ static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
>           }
>       }
>   
> -    CPU_FOREACH(cpu) {
> +    CPU_FOREACH_HVF(cpu) {
>           err = hvf_update_guest_debug(cpu);
>           if (err) {
>               return err;
> @@ -560,7 +560,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
>       QTAILQ_FOREACH_SAFE(bp, &hvf_state->hvf_sw_breakpoints, entry, next) {
>           if (hvf_arch_remove_sw_breakpoint(cpu, bp) != 0) {
>               /* Try harder to find a CPU that currently sees the breakpoint. */
> -            CPU_FOREACH(tmpcpu)
> +            CPU_FOREACH_HVF(tmpcpu)
>               {
>                   if (hvf_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
>                       break;
> @@ -572,7 +572,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
>       }
>       hvf_arch_remove_all_hw_breakpoints();
>   
> -    CPU_FOREACH(cpu) {
> +    CPU_FOREACH_HVF(cpu) {
>           hvf_update_guest_debug(cpu);
>       }
>   }
> @@ -581,6 +581,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
>   {
>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>   
> +    ops->get_cpus_queue = hw_accel_get_cpus_queue;
>       ops->create_vcpu_thread = hvf_start_vcpu_thread;
>       ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
>   
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0afd96018e0..13400ff0d5f 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2269,10 +2269,10 @@ static void hvf_arch_set_traps(void)
>   
>       /* Check whether guest debugging is enabled for at least one vCPU; if it
>        * is, enable exiting the guest on all vCPUs */
> -    CPU_FOREACH(cpu) {
> +    CPU_FOREACH_HVF(cpu) {
>           should_enable_traps |= cpu->accel->guest_debug_enabled;
>       }
> -    CPU_FOREACH(cpu) {
> +    CPU_FOREACH_HVF(cpu) {
>           /* Set whether debug exceptions exit the guest */
>           r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
>                                                 should_enable_traps);



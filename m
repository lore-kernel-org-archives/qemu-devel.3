Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7ADC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GMk-0007sH-Hq; Fri, 25 Apr 2025 06:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GMh-0007rr-Fp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:33:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GMf-0007QR-2S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:33:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1108077f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577179; x=1746181979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sOvNB9OXakWwwLO478SymfKCouNPG/XyF/EAXAqw/50=;
 b=GwN32SDdl6rMVmNI/5R6vcrD5kd9H37byn/zMchhMBwpQBrEuhtHKi8zojtFbX6Dxs
 fTbCrjD+1a5XonQtQxJHrMVKz48p/4tryzlPTOeiXGY0MveO2sfHj1rdC7rtQhLSwgiO
 ntsCWz/N+eDlCFKJxZb7p7BUgsnuGU+6/7cXUvpDEqtjL6PKlA5n8rUAI3UJpGpHaRgM
 DXst+g9ho71Mc186WFCLzESP0/vYdXlrBD6c6yIn4TopR5coLg81jLtB/fDakV+Jb6Yv
 4v3fzu7IuOUjHSylbPhrrdcQkzxCyDZh9x7quhqNWCy51TAD4ryy8VRiSmc1VZ6+NARr
 HGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577179; x=1746181979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sOvNB9OXakWwwLO478SymfKCouNPG/XyF/EAXAqw/50=;
 b=IyByZcT4jWrioUr+d8H7JJYrB8bECum1Np13gWa+WBoufnKQXKR2ofXdIqOStSpMHY
 wIT584JLzH4u8XKXG5vUidxwSiqHley9rbdWHwTQBHFvrqpwvWvxQJ59mEPjQ5K2zITM
 7pM0+0HRG754Y7hJwbSUbtBKGy8qvL2DmxikTOCOZ/o8tREFn7SeOUo/zyHHx0IZXDo9
 ADGJtgfosTbQ6BiuNXp3YiE70FCzHxUSrXxqEV18njh/1i0KVvBpK5cHSy2GRv/ILBCm
 RRipn/dm7EP4prO59mGjKiUVnI3xmSkXMHtQxhDvB9vvlsFjMkEz5XZFbxofDLHPQV4M
 dJzA==
X-Gm-Message-State: AOJu0YwyDdbDmy2yIpOPPm3FJKPlHpdU7jta9syL/nzxu5foEjJasCEC
 adQT5kAl+OVGNGcZbwvj/uuTgqXH+/69ITQ8Ow9dgIIoz2SpVIoWPFDkeNyB6uw=
X-Gm-Gg: ASbGnctq5TWkxRWQL8usBkhibfHV54pj0lcItgHUpgITjFZ1vS0dE6ktIzhokFoQ7+F
 p8iPPIwwOP6FLG2T9MRyuEumEIC5G5TaxpQGPU01l9rwBVpEY+RCdcdb9vfAGUX4s52PL3mnq/O
 HTbBeoPJ8XdNrBcb/O0SqG8mJQVwSkcGzocYycUTzsx+BAY0o6ClBOW5JF9bhkbXOTXxGkRBmY5
 8D1vt680k2FriwAs9JfaKJrytXZ/WV7xSpzh6NxejEXl4jV1LxMqXWS5AvofHwrzeWYAa6ACajz
 sLH1fXAQTht8841cJW2iaGIeiFarNABFzdzmJFslK9LjurT/rDigrdWS4JvxbeB6wUAYlBfA/VZ
 CoDiYra2Z
X-Google-Smtp-Source: AGHT+IFMMVBirbFD7Umi/fq28itS5m0zi8Hkp7j4s4Q3aCO6JdI/MQBixPoYKElyC2opOx8PMWuqqw==
X-Received: by 2002:a05:6000:4304:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a074e3c47cmr1386882f8f.29.1745577178843; 
 Fri, 25 Apr 2025 03:32:58 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46976sm1941254f8f.63.2025.04.25.03.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:32:58 -0700 (PDT)
Message-ID: <6a93fa6b-d38d-48ac-9cde-488765238247@linaro.org>
Date: Fri, 25 Apr 2025 12:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] i386/kvm: Support fixed counter in KVM PMU filter
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-6-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250409082649.14733-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 9/4/25 10:26, Zhao Liu wrote:
> KVM_SET_PMU_EVENT_FILTER of x86 KVM allows user to configure x86 fixed
> function counters by a bitmap.
> 
> Add the support of x86-fixed-counter in kvm-pmu-filter object and handle
> this in i386 kvm codes.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
> Changes since RFC v2:
>   * Drop KVMPMUX86FixedCounter structure and use uint32_t to represent
>     bitmap in QAPI directly.
>   * Add Tested-by from Yi.
>   * Add documentation in qemu-options.hx.
>   * Bump up the supported QAPI version to v10.1.
> 
> Changes since RFC v1:
>   * Make "action" as a global (per filter object) item, not a per-counter
>     parameter. (Dapeng)
>   * Bump up the supported QAPI version to v10.0.
> ---
>   accel/kvm/kvm-pmu.c      | 31 +++++++++++++++++++++++++++++++
>   include/system/kvm-pmu.h |  5 ++++-
>   qapi/kvm.json            |  6 +++++-
>   qemu-options.hx          |  6 +++++-
>   target/i386/kvm/kvm.c    | 39 ++++++++++++++++++++++++---------------
>   5 files changed, 69 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
> index 9205907d1779..509d69d9c515 100644
> --- a/accel/kvm/kvm-pmu.c
> +++ b/accel/kvm/kvm-pmu.c
> @@ -101,6 +101,29 @@ fail:
>       qapi_free_KvmPmuFilterEventList(head);
>   }
>   
> +static void kvm_pmu_filter_get_fixed_counter(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
> +
> +    visit_type_uint32(v, name, &filter->x86_fixed_counter, errp);
> +}
> +
> +static void kvm_pmu_filter_set_fixed_counter(Object *obj, Visitor *v,
> +                                             const char *name, void *opaque,
> +                                             Error **errp)
> +{
> +    KVMPMUFilter *filter = KVM_PMU_FILTER(obj);
> +    uint32_t counter;
> +
> +    if (!visit_type_uint32(v, name, &counter, errp)) {
> +        return;
> +    }
> +
> +    filter->x86_fixed_counter = counter;
> +}
> +
>   static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
>   {
>       object_class_property_add_enum(oc, "action", "KvmPmuFilterAction",
> @@ -116,6 +139,14 @@ static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
>                                 NULL, NULL);
>       object_class_property_set_description(oc, "events",
>                                             "KVM PMU event list");
> +
> +    object_class_property_add(oc, "x86-fixed-counter", "uint32_t",
> +                              kvm_pmu_filter_get_fixed_counter,
> +                              kvm_pmu_filter_set_fixed_counter,
> +                              NULL, NULL);
> +    object_class_property_set_description(oc, "x86-fixed-counter",
> +                                          "Enablement bitmap of "
> +                                          "x86 PMU fixed counter");

Adding that x86-specific field to all architectures is a bit dubious.

>   }
>   
>   static void kvm_pmu_filter_instance_init(Object *obj)
> diff --git a/include/system/kvm-pmu.h b/include/system/kvm-pmu.h
> index 6abc0d037aee..5238b2b4dcc7 100644
> --- a/include/system/kvm-pmu.h
> +++ b/include/system/kvm-pmu.h
> @@ -19,10 +19,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(KVMPMUFilter, KVM_PMU_FILTER)
>   
>   /**
>    * KVMPMUFilter:
> - * @action: action that KVM PMU filter will take for selected PMU events.
> + * @action: action that KVM PMU filter will take for selected PMU events
> + *    and counters.
>    * @nevents: number of PMU event entries listed in @events
>    * @events: list of PMU event entries.  A PMU event entry may represent one
>    *    event or multiple events due to its format.
> + * @x86_fixed_counter: bitmap of x86 fixed counter.
>    */
>   struct KVMPMUFilter {
>       Object parent_obj;
> @@ -30,6 +32,7 @@ struct KVMPMUFilter {
>       KvmPmuFilterAction action;
>       uint32_t nevents;
>       KvmPmuFilterEventList *events;
> +    uint32_t x86_fixed_counter;
>   };


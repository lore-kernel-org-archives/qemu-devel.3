Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE56C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCQK-0008OT-Ub; Mon, 19 Aug 2024 20:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgCOF-0005mR-Ew
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgCOD-0001lz-Bh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724112379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJEydKeQmdOmLMAudtBetG1MczMHRW8T9SNRL0pTjIc=;
 b=Vt+OVpyxci/JW62TU16butW/xUXftpPo2jdsYFLY3GTW6D1KzFyxg1rk86JbL5sjOxEOcJ
 JEUvYA+k10Jcp+V6/tK2wcY49VrkdUYTJeGsyxD+FNGkuU+CocAbZB/G617ZEmSeKUrXR4
 cbosGrmHLkSW7gG6psznrsDTiPNKFBQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Ckv9nPDSOtm4ICokFPHK4A-1; Mon, 19 Aug 2024 20:06:18 -0400
X-MC-Unique: Ckv9nPDSOtm4ICokFPHK4A-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d1da888717so4975960a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112377; x=1724717177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJEydKeQmdOmLMAudtBetG1MczMHRW8T9SNRL0pTjIc=;
 b=jubeesR3VYrGAMV9Dk4Tfi3pKusXCANPR0HVV3nJr2wpbNYeLg4vdSOfgfebils8Pd
 IryTTx098ecDmn018fSWMOOo1FcApnZoAtlXuSHm+/GQjc0hf+GPx2GmmRoUR8V3AwlV
 EZkhzA+SH+QI4waPoE8dg7940DLYpVBsHsexKApsiP+JhG0awSF4M8qWoX/aneuuuSiD
 NiDwvpNaxR5ZaDHMAbh61Cm6PjPaLWdQpti5CSb7ciAGgJfFyFWwE6/LmPTKNvOOvXBM
 tosZFVdken4pYnqJVGqj/yK3lsUWHOeqv/+DKNbV6V/UZ9Tr/lD9lAPSpBHTKckAhrPp
 Rh3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpv03wWqUygHW2Gzgok6M7+SQA37HKMOGOvamRo6aW/yg2StN9ufwqpOgDTRfB6rZj36K5f1ejatbjA6ezjxf/hmE8jcg=
X-Gm-Message-State: AOJu0YzJSCVLIy9Q3KcBdu6BQDEXzsMhgQV7hmn+5GMfngov8DQNbmfs
 Y5sJ5R4a/L/r2c9jfLN26zDUSxJXOVFZ50vQMMofVEu1sFT7krcVTe7/NrWL2xsuIMaI18+u+zg
 NChEQ5U8WhYqBSiIADSV/r8yL2D160ScbWcop4qXE/si2Yt1IL+Ij
X-Received: by 2002:a17:90a:e7cc:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d5c0d79fcdmr786305a91.5.1724112376874; 
 Mon, 19 Aug 2024 17:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZgeUN0x9iXDe/MSbK5PvLGYSjLcMrYCVuezaufi1qw8ae1qu2R50IXRu1AdaQAH1k6xRArQ==
X-Received: by 2002:a17:90a:e7cc:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d5c0d79fcdmr786278a91.5.1724112376311; 
 Mon, 19 Aug 2024 17:06:16 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7dd3f0sm11710796a91.18.2024.08.19.17.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 17:06:15 -0700 (PDT)
Message-ID: <9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com>
Date: Tue, 20 Aug 2024 10:05:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 17/29] arm/virt: Release objects for *disabled*
 possible vCPUs after init
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-18-salil.mehta@huawei.com>
 <51dc0813-7dc9-4927-a24b-bd718be54e46@redhat.com>
 <6b435c1f2b934867b8d82850d6d866c6@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <6b435c1f2b934867b8d82850d6d866c6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Salil,

On 8/19/24 10:21 PM, Salil Mehta wrote:
>>   From: Gavin Shan <gshan@redhat.com>
>>   Sent: Tuesday, August 13, 2024 2:17 AM
>>   To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
>>   qemu-arm@nongnu.org; mst@redhat.com
>>   
>>   On 6/14/24 9:36 AM, Salil Mehta wrote:
>>   > During `machvirt_init()`, QOM ARMCPU objects are pre-created along
>>   > with the corresponding KVM vCPUs in the host for all possible vCPUs.
>>   > This is necessary due to the architectural constraint that KVM
>>   > restricts the deferred creation of KVM vCPUs and VGIC
>>   > initialization/sizing after VM initialization. Hence, VGIC is pre-sized with
>>   possible vCPUs.
>>   >
>>   > After the initialization of the machine is complete, the disabled
>>   > possible KVM vCPUs are parked in the per-virt-machine list
>>   > "kvm_parked_vcpus," and we release the QOM ARMCPU objects for the
>>   > disabled vCPUs. These will be re-created when the vCPU is hotplugged
>>   > again. The QOM ARMCPU object is then re-attached to the corresponding
>>   parked KVM vCPU.
>>   >
>>   > Alternatively, we could have chosen not to release the QOM CPU objects
>>   > and kept reusing them. This approach might require some modifications
>>   > to the `qdevice_add()` interface to retrieve the old ARMCPU object
>>   > instead of creating a new one for the hotplug request.
>>   >
>>   > Each of these approaches has its own pros and cons. This prototype
>>   > uses the first approach (suggestions are welcome!).
>>   >
>>   > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > ---
>>   >   hw/arm/virt.c | 32 ++++++++++++++++++++++++++++++++
>>   >   1 file changed, 32 insertions(+)
>>   >
>>   > diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
>>   > 9d33f30a6a..a72cd3b20d 100644
>>   > --- a/hw/arm/virt.c
>>   > +++ b/hw/arm/virt.c
>>   > @@ -2050,6 +2050,7 @@ static void virt_cpu_post_init(VirtMachineState
>>   *vms, MemoryRegion *sysmem)
>>   >   {
>>   >       CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
>>   >       int max_cpus = MACHINE(vms)->smp.max_cpus;
>>   > +    MachineState *ms = MACHINE(vms);
>>   >       bool aarch64, steal_time;
>>   >       CPUState *cpu;
>>   >       int n;
>>   > @@ -2111,6 +2112,37 @@ static void virt_cpu_post_init(VirtMachineState
>>   *vms, MemoryRegion *sysmem)
>>   >               }
>>   >           }
>>   >       }
>>   > +
>>   > +    if (kvm_enabled() || tcg_enabled()) {
>>   > +        for (n = 0; n < possible_cpus->len; n++) {
>>   > +            cpu = qemu_get_possible_cpu(n);
>>   > +
>>   > +            /*
>>   > +             * Now, GIC has been sized with possible CPUs and we dont
>>   require
>>   > +             * disabled vCPU objects to be represented in the QOM. Release
>>   the
>>   > +             * disabled ARMCPU objects earlier used during init for pre-sizing.
>>   > +             *
>>   > +             * We fake to the guest through ACPI about the
>>   presence(_STA.PRES=1)
>>   > +             * of these non-existent vCPUs at VMM/qemu and present these
>>   as
>>   > +             * disabled vCPUs(_STA.ENA=0) so that they cant be used. These
>>   vCPUs
>>   > +             * can be later added to the guest through hotplug exchanges
>>   when
>>   > +             * ARMCPU objects are created back again using 'device_add' QMP
>>   > +             * command.
>>   > +             */
>>   > +            /*
>>   > +             * RFC: Question: Other approach could've been to keep them
>>   forever
>>   > +             * and release it only once when qemu exits as part of finalize or
>>   > +             * when new vCPU is hotplugged. In the later old could be released
>>   > +             * for the newly created object for the same vCPU?
>>   > +             */
>>   > +            if (!qemu_enabled_cpu(cpu)) {
>>   > +                CPUArchId *cpu_slot;
>>   > +                cpu_slot = virt_find_cpu_slot(ms, cpu->cpu_index);
>>   > +                cpu_slot->cpu = NULL;
>>   > +                object_unref(OBJECT(cpu));
>>   > +            }
>>   > +        }
>>   > +    }
>>   >   }
>>   
>>   It's probably hard to keep those ARMCPU objects forever. First of all, one
>>   vCPU can be hot-added first and then hot-removed afterwards. With those
>>   ARMCPU objects kept forever, the syntax of 'device_add' and 'device_del'
>>   become broken at least.
> 
> I had prototyped both approaches 4 years back. Yes, interface problem with
> device_add was solved by a trick of keeping the old vCPU object and on
> device_add instead of creating a new vCPU object we could use the old vCPU
> object and then call qdev_realize() on it.
> 
> But bigger problem with this approach is that of migration. Only realized objects
> have state to be migrated. So it might look cleaner on one aspect but had its
> own issues.
> 
> I think I did share a prototype of this with Igor which he was not in agreement with
> and wanted vCPU objects to be destroyed like in x86. Hence, we stuck with
> the current approach.
> 

Migration needn't to be the blocker necessarily. For those states of vCPUs, which
have been instantiated and not realized yet, those states can be moved around to
be managed under another migratable object (e.g. MachineState). In this way, those
vCPU states can be migrated together with MachineState. However, it sounds strange
to me to have vCPU objects instantiated, but unrealized until hot-add is triggered.
It's not what QOM supposes to support.

Ok, I don't realize x86 also follows this model: instantiate hotpluggable vCPUs
and destroy them on bootup.

> 
>>   The ideal mechanism would be to avoid instanciating those ARMCPU objects
>>   and destroying them soon. I don't know if ms->possible_cpus->cpus[] can
>>   fit and how much efforts needed.
> 
> This is what we are doing now in the current approach. Please read the KVMForum
> slides of 2023 for more details and the cover letter of RFC V3 for more details.
> 

My question has been parsed in a wrong way. My question was if it's doable to avoid
instantiating vCPU#1 on bootup when we have command lines '-cpu host -smp cpus=1,max_cpus=2'
and release it in machvirt_init(). Instead, ms->possible_cpus->cpus[] are reused to create
GICv3 and vCPU file descriptors. It looks like a clean way at least. There may be significant
efforts to reuse mc->possible_cpus->cpus[], but vCPU#1 object has ephemeral life cycle.
It looks unnecessary to create the ephemeral vCPU#1 object.

Thanks,
Gavin



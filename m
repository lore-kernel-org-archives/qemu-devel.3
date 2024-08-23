Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0053EC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 10:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shRuJ-0002E0-0H; Fri, 23 Aug 2024 06:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1shRuE-0002Cu-CC
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 06:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1shRuB-0001IM-P7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 06:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724410348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uis5UZkHvL4tuC2wK12ycafDdDpOMpMexq8FX0cMKU=;
 b=IBbiSB0TidbW/QdC70mAnjbKfJ8t4X6bzQp4FYmq0a6LiHqReA96RQVOcT6rzIlpGcYOtI
 OQ7wL2rMHzqkccBbqpwDwSkb6vMcRB6kgtmthxr9EgjWoZ3WWZ9pBgswvB/bJI2RNIGWzX
 e/1n+getxbs8EsIkn/+bpyiZzvsO/mM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-dHg6tVHVNeO6Y6fVlHurUA-1; Fri, 23 Aug 2024 06:52:27 -0400
X-MC-Unique: dHg6tVHVNeO6Y6fVlHurUA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ff24acb60dso18286255ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 03:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724410346; x=1725015146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0uis5UZkHvL4tuC2wK12ycafDdDpOMpMexq8FX0cMKU=;
 b=joQWYNfTje2RfJ1mMeoy7va1Kcgux/kJybtV6cefS/NXAM/toGjg9pYm3DmpE930rJ
 3REln414yL9rhEpWkadxq2bFHQNhp6R00JFE4JQSqtuuTtH3VqE9Z4lY+E0H6V804hqu
 z3wPGrGgsiAyQWbUzQFplmg7sRiS53d8bkAIOu2D7+de0QHJJ0P2qMkxl5PDSwRDXFUS
 53Kx1BzAgbPpoQNV7So6X5QJteGk60k0TKoT4l+B6EaFCHCtEvMPdnoYzbIrBYsI54SZ
 PWcp9YKPfzyFKTJWBNXq9DcGgi7izGf/2MCFkxK55XJ+BfCHajQBx3x+1pfeNj2OFQHa
 FUsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2xvUkTC4ZeghL1bTdtigAKjvKkvQS44jRiXzkV4Qc3zpH7x24kRSDb3u/4iNVXizSiOoqWBUNWAbN@nongnu.org
X-Gm-Message-State: AOJu0YxtkHjORo2Tq8LYlJbqVJX/U6Y9qJ1I+uKpgeDlNn66glrHE1xO
 nvMLXpkrsqYEkp9AQYBbxKGA0Lp03MWaENte8ro2f0YQZSsCwkp4fXECfyw74gdww1a80CNOk0+
 V+3gyv8mD86QhZ+ftnly61R+wzMDWd+YntFMcUQrU6WZyXRucymBu
X-Received: by 2002:a17:902:d2c6:b0:202:3617:d52a with SMTP id
 d9443c01a7336-2039c324606mr48661535ad.6.1724410346204; 
 Fri, 23 Aug 2024 03:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9ftdRhUGXJwHv+r6kKfXjKTJIpfMyXNBYBNWIdQ/aSdQKh4bdcn9Uan8N4Bha772mcRUTw==
X-Received: by 2002:a17:902:d2c6:b0:202:3617:d52a with SMTP id
 d9443c01a7336-2039c324606mr48660755ad.6.1724410345311; 
 Fri, 23 Aug 2024 03:52:25 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dbed6sm26151165ad.172.2024.08.23.03.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 03:52:24 -0700 (PDT)
Message-ID: <13ab0fda-fea3-47a6-8c17-006e6bd4430a@redhat.com>
Date: Fri, 23 Aug 2024 20:52:09 +1000
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
 <9b7582f0-8149-4bf0-a1aa-4d4fe0d35e70@redhat.com>
 <1252c2d35b3e40ed84d5d5ae454878a7@huawei.com>
 <d2371011-e7a3-42fe-b1a3-a185fbf4a612@redhat.com>
 <1c31ab30bae6437fac7799227ca4bfd1@huawei.com>
 <62227c7a-6c0e-403a-8d6a-9647c6e006e6@redhat.com>
 <754a693989cf426bb07e40c43b80bce2@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <754a693989cf426bb07e40c43b80bce2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Sail,

On 8/22/24 8:58 PM, Salil Mehta wrote:
>>   On 8/21/24 8:23 PM, Salil Mehta wrote:
>>   >>
>>   >>   On 8/21/24 2:40 AM, Salil Mehta wrote:
>>   >>   >
>>   >>   > I don’t understand this clearly. Are  you suggesting to reuse only
>>   >>   > single vCPU object to initialize all KVM vCPUs not yet plugged? If
>>   >>   > yes, then I'm not sure what do we gain here by adding this complexity?
>>   >>   > It does not consume time or resources because we are not realizing any
>>   >>   > of these vCPU object in any case.
>>   >>   >
>>   >>
>>   >>   First of all, it seems we have different names and terms for those cold-
>>   >>   booted vCPUs and hotpluggable vCPUs. For example, vCPU-0 and vCPU-1
>>   >>   are cold-booted vCPUs while
>>   >>   vCPU-2 and vCPU-3 are hotpluggable vCPUs when we have '-smp
>>   >>   maxcpus=4,cpus=2'. Lets stick to convention and terms for easier discussion.
>>   >>
>>   >>   The idea is avoid instantiating hotpluggable vCPUs in virtmach_init() and
>>   >>   released in the same function for those hotpluggable vCPUs. As I can
>>   >>   understand, those hotpluggable vCPU instances are serving for two
>>   >>   purposes: (1) Relax the constraint that all vCPU's (kvm) file descriptor have
>>   >>   to be created and populated;
>>   >
>>   >
>>   > We are devising *workarounds* in Qemu for the ARM CPU architectural
>>   > constraints in KVM and in Guest Kernel,  *not relaxing* them. We are
>>   > not allowed to meddle with the constraints. That is the whole point.
>>   >
>>   > Not having to respect those constraints led to rejection of the
>>   > earlier attempts to upstream Virtual CPU Hotplug for ARM.
>>   >
>>   
>>   I meant to 'overcome' the constraints by 'relax'. My apologies if there're any
>>   caused confusions.
> 
> 
> Ok. No issues. It was important for me to clarify though.
> 
> 
>   Previously, you had attempt to create all vCPU objects
>>   and reuse them when vCPU hot added.
> 
> Yes, at QOM level. But that approach did not realize the unplugged/yet-to-be-plugged
> vCPUs. We were just using QOM vCPU objects as the place holders
> 

Right, my point was actually vCPU objects are too heavy as the place holders. It was
reason why I had the concern: why those hotpluggable vCPU objects can't be avoided
during the bootup time.

>   In current implementation, the
>>   hotpluggable vCPUs are instantiated and released pretty soon. I was
>>   bringing the third possibility, to avoid instantiating those hotpluggable vCPU
>>   objects, for discussion.
> 
> 
> Are you suggesting not calling KVM_ARM_VCPU_INIT IOCTL as all for the vCPUs
> which are part of possible list but not yet plugged?
> 
> If yes, we cannot do that as KVM vCPUs should be fully initialized even before
> VGIC is initialized inside the KVM. This is a constraint. I've explained this in
> detail in the cover letter of this patch-set and in the slides I have shared
> earlier.
> 

No, it's not what I was suggesting. What I suggested is to avoid creating those hotpluggable
vCPU objects (place holders) during the bootup time. However, all vCPU file descriptors (KVM
objects) still need to be created and initialized before GICv3 is initialized. It's one of
the constrains. So we need to create and populate all vCPU file descriptors through
ioctl(vm_fd, CREATE_VCPU) and ioctl(vcpu_fd, INIT_VCPU) before GICv3 object is created and
realized. As I explained in the previous reply, the hotpluggable vCPU objects (place holders)
haven't to be created in order to initialize and populate the vCPU file descriptors for those
hotpluggable vCPUs. I think the parameters used to create and initialize vCPU-0's file descriptor
can be reused by all other vCPUs, because we don't support heterogeneous vCPUs.

What I suggested is something like below: the point is to avoid instantiating those hotpluggable
vCPUs, but their vCPU file descriptor (KVM object) are still created and initialized.

     static void machvirt_init(MachineState *machine)
     {

         /*
          * Instantiate and realize vCPU-0, record the parameter passed to
          * ioctl(vcpu-fd, VCPU_INIT, &init), or a better place to remember the parameter.
          * The point is the parameter can be shared by all vCPUs.
          */

         /*
          * Create vCPU descriptors for all other vCPUs (including hotpluggable vCPUs).
          * The remembered parameter is reused and passed to ioctl(vcpu-fd, VCPU_INIT, &init).
          */

         /* Instanaite and realize other cold-booted vCPUs */

         /* Instantiate and realize GICv3 */

     }

> 
> In this series, the life cycle of those hotpluggable
>>   vCPU objects are really short. Again, I didn't say we must avoid instantiating
>>   those vCPU objects, I brought the topic ONLY for discussion.
> 
> Sure, I appreciate that. For the details of the reasons please follow below:
> 
> 1. Cover Letter of this patch-set (Constraints are explained there)
> 2. KVMForum Slides of 2020 and 2023
> 
> 
>>   > (2) Help to instantiate and realize
>>   >>   GICv3 object.
>>   >>
>>   >>   For (1), I don't think we have to instantiate those hotpluggable vCPUs at all.
>>   >>   In the above example where we have command line '-smp
>>   >>   maxcpus=4,cpus=2', it's unnecessary to instantiate
>>   >>   vCPU-3 and vCPU-4 to create and populate their KVM file descriptors.
>>   >
>>   >
>>   > We cannot defer create vCPU in KVM after GIC has been initialized in KVM.
>>   > It needs to know every vCPU that will ever exists right at the time it
>>   > is getting Initialized. This is an ARM CPU Architectural constraint.
>>   >
>>   
>>   It will be appreciated if more details other than 'an ARM CPU architectural constraint'
>>   can be provided. I don't understand this constrain very well at least.
> 
> 
> We cannot do that as we MUST present KVM vCPUs to the VGIC fully initialized,
> even before it starts its initialization. Initialization of the vCPUs also initializes
> the system registers for the corresponding KVM vCPU.
> 
> For example, MPIDR_EL1 must be initialized at VCPU INIT time. We cannot
> avoid this. MPIDR value is used by VGIC during its initialization. This MUST be
> present for all of the possible KVM vCPUs right from start during vgic_init()
> 
> Please check the cover letter of this patch-set, I explained these there and the
> KVMForum slides.  Please review and comment there and let me know what is
> not clear from the text.
> 

It seems my suggestion wasn't fully understood. I was suggesting to avoid instantiating
those hotpluggable vCPU objects (place holders) during QEMU startup time. All vCPU file
descriptors (the vCPU's corresponding objects) still need to be in place before GICv3
object is initiated and realized.

> 
>>   >   A
>>   >>   vCPU's KVM file descriptor is create and populated by the following ioctls
>>   >>   and function calls. When the first vCPU (vCPU-0) is realized, the property
>>   >>   corresponding to "&init" is fixed for all vCPUs. It means all vCPUs have same
>>   >>   properties except the "vcpu_index".
>>   >>
>>   >>      ioctl(vm-fd,   KVM_CREATE_VCPU,   vcpu_index);
>>   >>      ioctl(vcpu-fd, KVM_ARM_VCPU_INIT, &init);
>>   >>      kvm_park_vcpu(cs);
>>   >>
>>   >>   A vCPU's properties are determined by two sources and both are global. It
>>   >>   means all vCPUs should have same properties: (a) Feature registers
>>   >>   returned from the host. The function
>>   >>   kvm_arm_get_host_cpu_features() is called for once, meaning this source
>>   >>   is same to all vCPUs;
>>   >
>>   >
>>   > Sure, but what are you trying to save here?
>>   >
>>   
>>   As mentioned above, the life cycle of those hotpluggable vCPU objects are
>>   really short. They still consume time and memory to instantiate them. If I'm
>>   correct, one of the primary goal for vCPU hotplug feature is to save system
>>   boot-up time, correct?
> 
> 
> Correct. We targeted vCPU hotplug for Kata-containers for on-demand resource
> allocation and saving the resources. Kata-containers can work with different types
> of VMM like Qemu and microVMs like Firecracker. AFAIK, Usecase of microVM is
> slightly different than the normal containers. They are short lived (say around
> 15 min) and require ultrafast boot-up times (say less than 125 ms) - these figures
> are from Amazon who invented the concept of microVM in the earlier decade.
> 
> With the current patches, we have only partially achieved what we had started
> i.e. Kata/Qemu but we also want to target Kata/microVM. In our case, we want
> that microVM to be Qemu based fro ARM. I think x86 already has reduced lots
> of legacy stuff and created a microVM in Qemu. I'm not sure how it compares
> against the true microVM like Firecracker. It will be a good target to reduce
> memory foot print of ARM Qemu Virt Machine. or think or creating a new one
> just like x86. Using the vCPU Hotplug feature we were drastically able to reduce
> the boot up times of Qemu. Please check the calibrated performance figures in
> KVmForum  2023 slide 19G (Page 26) [1]
> 
> [1]  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> 
> Last year, I had prototyped a microVM for ARM, Michael Tsirkin suggested that if
> the performance number of the ARM Virt machine can match the x86 microVM then
> we might not require an explicit microVM code for ARM. Hence, my current efforts
> are to reduce the memory foot print of existing Virt machine. But I do have a rough
> prototype of microVM as well. We can debate about that later in a different
> discussion.
> 

Thanks for the linker to the slides. Yeah, it's nice to reduce the bootup time
and memory footprint if possible. vCPU hotplug feature may help to improve the
performance, but all other paths might also impact the performance. In summary,
it's a comprehensive goal to reduce the memory footprint and bootup time, and
other components (paths) need optimization to achieve this goal.

> 
>>   >>   (b) The parameters provided by user through '-cpu host,sve=off' are
>>   >>   translated to global properties and applied to all vCPUs when they're
>>   >>   instantiated.
>>   >
>>   >
>>   > Sure. Same is the case with PMU and other per-vCPU parameters.
>>   > We do not support heterogenous computing and therefore we do not have
>>   > per-vCPU control of these features as of now.
>>   >
>>   >
>>   >>
>>   >>          (a)                                            (b)
>>   >>
>>   >>      aarch64_host_initfn                          qemu_init
>>   >>      kvm_arm_set_cpu_features_from_host           parse_cpu_option
>>   >>        kvm_arm_get_host_cpu_features
>>   cpu_common_parse_features
>>   >>                                                   qdev_prop_register_global
>>   >>                                                     :
>>   >>                                                   device_post_init
>>   >>
>>   >> qdev_prop_set_globals
>>   >
>>   >
>>   > Sure, I understand the code flow but what are you trying to suggest here?
>>   >
>>   
>>   I tried to explain that vCPU object isn't needed to create and populate
>>   vCPU's file descriptors, as highlight in (1). The information used to create the
>>   cold-booted
>>   vCPU-0 can be reused because all vCPUs have same properties and feature
>>   set.
> 
> 
> It does not matter. We use those QOM vCPU object states to initializes Qemu
> GICv3 model with max possible vCPUs and then release the QOM vCPU objects.
> which are yet-to-be-plugged.
> 

It's what has been implemented in this series. My concern remains: why those
vCPU hotpluggable objects can't be avoided? Again, their corresponding vCPU
file descritpors (KVM vCPU objects) still have to be in place before GICv3
is instantiated and realized.

> 
>>   >>   For (2), I'm still looking into the GICv3 code for better understanding.
>>   >
>>   >
>>   > Oh, I thought you said you've finished your reviews 😊
>>   >
>>   > Please take your time. For your reference, you might want to check:
>>   >
>>   > KVMForum 2023:
>>   > https://kvm-
>>   forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Vir
>>   > t_CPU_Hotplug_-__ii0iNb3.pdf
>>   > https://kvm-forum.qemu.org/2023/KVM-forum-cpu-
>>   hotplug_7OJ1YyJ.pdf
>>   >
>>   > KVMForum 2020:
>>   > https://kvm-
>>   forum.qemu.org/2020/Oct%2029_Challenges%20in%20Supporting%
>>   >
>>   20Virtual%20CPU%20Hotplug%20in%20SoC%20Based%20Systems%20like%2
>>   0ARM64_
>>   > Salil%20Mehta.pdf
>>   >
>>   
>>   hmm, 'finished my review' has been misread frankly. By that, I meant I
>>   finished my tests and provided all the comments I had. Some of them are
>>   questions and discussions, which I still need to follow up.
> 
> 
> Sure. No worries. Even if you miss, you will have more chance to comment on
> upcoming RFC V4 😊
> 

Ok :-)

> 
>>   > Until
>>   >>   now, I don't see we need the instantiated hotpluggable vCPUs either.
>>   >
>>   >
>>   > I think, I've already answered this above it is because of ARM Architectural
>>   constraint.
>>   >
>>   >
>>   >   For
>>   >>   example, the redistributor regions can be exposed based on 'maxcpus'
>>   >>   instead of 'cpus'.
>>   >
>>   > You mean during the review of the code you found that we are not doing
>>   it?
>>   >
>>   
>>   It's all about the discussion to the possibility to avoid instantiating
>>   hotpluggable vCPU objects.
> 
> 
> As mentioned above, with the current KVM code you cannot. But if we
> really want to then perhaps we would need to change KVM.
> 
> I might be wrong but AFAICS I don’t see a reason why we cannot have
> something like *batch* KVM vCPU create and  initialize instead of current
> sequential KVM operations. This will avoid multiple calls to the KVM Host
> and can improve Qemu init time further. But this will require a separate
> discussion in the LKML including all the KVM folks.
> 
> This has potential to delay the vCPU hotplug feature acceptance and I'm
> really not in favor of that. We have already stretched it a lot because of
> the standards change acceptance earlier.
> 

Again, my suggestion wasn't completely understood. I was suggesting to avoid instantiating
those hotpluggable objects, but their vCPU file descriptors still need to be in place
before GICv3's instantiation and realization.

Yes, I was also concerned that too much code changes would be needed if my suggestion is
accepted. It will definitely delay the feature's upstreaming process. It's why I said the
topic (to avoid the hotpluggable objects) are just for discussion now. We can do it (as
separate optimization) after your current implementation is merged.

> 
>>   > The IRQ connection and teardown can be dynamically
>>   >>   done by connecting the board with GICv3 through callbacks in
>>   >>   ARMGICv3CommonClass.
>>   >>   The connection between GICv3CPUState and CPUARMState also can be
>>   >>   done dynamically.
>>   >
>>   > Are you suggesting this after reviewing the code or you have to review
>>   > it yet? 😉
>>   >
>>   
>>   I was actually trying to ask for your input and feedback. I was hoping your
>>   input to clear my puzzles: why vCPU objects must be in place to create
>>   GICv3 object?
>>   Is it possible to create the GICv3 object without those vCPU objects?
> 
> 
> No. VGIC initializes IRQs to target KVM vCPUs, it would expect same KVM vCPU MPIDR
> or MP-AFFINITY configured when KVM vCPUs were initialized at the first place
> otherwise the VGIC initialization will not happen correctly. Hence, the sequence.
> 
> The sequence of these initialization is generally strictly controlled by specification
> which is closely tied up with hardware including powering up initializations.
> You will need to honor the expectations of the KVM VGIC init which in turn are
> ARM CPU Architecture specification compliant. It is not just a loosely written code.
> 

umm, As I explained from the beginning, all KVM vCPU file descriptors are still
in place before GICv3 is instantiated and realized. With those KVM vCPU file
descriptor, we shouldn't have problem except more code changes are needed, or
I miss something? :)

> 
> What
>>   kinds of efforts we need to avoid instantiating those hotpluggable vCPU
>>   objects.
> 
> 
> I mentioned one of the ways above. Introduce *batch* KVM vCPU create &
> initialize. But it will have to undergo greater scrutiny because we are touching
> a common part which might affect many stake holders.  But this is a discussion
> we can do later as part of microVM for ARM.
> 

Remember you just had the architecture agnostic series merged. The vCPU file
descriptor can be parked and picked up at a later time based on the vCPU index.
This KVM vCPU create in batch mode can be well supported. What you need to is
record the parameters passed to ioctl(vm_fd, CREATE_VCPU, index) and ioctl(vcpu_fd,
INIT_CPU) for vCPU-0 in hw/arm/virt.c and create all other vCPU file descriptors
based on the recorded parameters.

Thanks,
Gavin



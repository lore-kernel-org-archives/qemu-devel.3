Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5298BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglSg-0006zI-0g; Wed, 21 Aug 2024 09:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sglSe-0006tJ-Eq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sglSb-0005fJ-Oy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724247192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk9o2fGV5BiG3cKjkmtD4loTHjBCkjb5hbPIyeMrQhI=;
 b=cfZM4xEr1jwyXAs7Xbia4U+eezmSL5fy7xnYmIGRlsfQ0heXdU7J5IcgXoqpsUxIaaZbuW
 USVDpDMOd0aFEZmM0xNgcIeCnhuIH6DncDQnaGMWxLinBlXTR12kVJQTI1ulUIElKeasVB
 +qJnVst1g8ZUkzljdpOf0VcCdCy2iEg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-RLOWgs67P8y8xwuR0ixnQQ-1; Wed, 21 Aug 2024 09:33:11 -0400
X-MC-Unique: RLOWgs67P8y8xwuR0ixnQQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7126ca1ece1so695184b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247190; x=1724851990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wk9o2fGV5BiG3cKjkmtD4loTHjBCkjb5hbPIyeMrQhI=;
 b=OxaYG0rtD6WxzAo+s9ZlIkD2SJl0v1mF1VcKP4ZIlbP9xn63gXDQGELkcp61eHaCDy
 EIaLzme+AOpZ87Ag/L/739te46T1KGpswjCOLFu9HT0+eoqoDfFhjOY1h9EeI4TYi/md
 1y1uBVevq9el0/IFBJx+XKTMeEYgiyYqgB2mKCuwCNjC6t9aOxFFJnywPakhwz4Ew/St
 zdPw9is/uHqB/mIP4gM0WeVwR1M2ktZL9CbqvoGRPHje4BPccYiq288MnLIKgNlhN68T
 1ZnF+EcIktrQsv2qaiYEI2J0wYAPcvu6xfneyPGrE4xTImfaFz8vZ5A5rLOzWI5XpPCW
 VEnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZJHoV6AUhhyd7CrfQ3vCkGz1lN+D05WIjGB0B6Z7eY8tPqVKn9eMZXZq2k0qMMA1xjYTMdKwEk6wz@nongnu.org
X-Gm-Message-State: AOJu0Yw70tFGNEQ0xiZKoF9NeXtQ3/Q0F/MpPvNpzfh8vBoKHbDUmUBA
 IIvYOysx7hZ1TP90FyOC2eU/lKMhRDOHh+tyjHYyQR4IMeqlOCC+es/RTJ37w85r83kmUZ2uX2B
 L639QWlcA7hQEJ/xnlQslVNMzf2EXk1e+qBF2Elu9Yc698ictuRc5
X-Received: by 2002:a05:6a20:d046:b0:1c3:acd1:5caf with SMTP id
 adf61e73a8af0-1cada297c71mr3953675637.23.1724247189935; 
 Wed, 21 Aug 2024 06:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPzGJE7WFAqs5aMsbBXVhVoQlck9HR1Q+mYwAN1WYlodKWu/6mZJo8hY1TQ/es78DdlqJVQ==
X-Received: by 2002:a05:6a20:d046:b0:1c3:acd1:5caf with SMTP id
 adf61e73a8af0-1cada297c71mr3953620637.23.1724247189267; 
 Wed, 21 Aug 2024 06:33:09 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71410dabb3csm2612172b3a.213.2024.08.21.06.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 06:33:08 -0700 (PDT)
Message-ID: <62227c7a-6c0e-403a-8d6a-9647c6e006e6@redhat.com>
Date: Wed, 21 Aug 2024 23:32:53 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <1c31ab30bae6437fac7799227ca4bfd1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/21/24 8:23 PM, Salil Mehta wrote:
>>   
>>   On 8/21/24 2:40 AM, Salil Mehta wrote:
>>   >
>>   > I don’t understand this clearly. Are  you suggesting to reuse only
>>   > single vCPU object to initialize all KVM vCPUs not yet plugged? If
>>   > yes, then I'm not sure what do we gain here by adding this complexity?
>>   > It does not consume time or resources because we are not realizing any
>>   > of these vCPU object in any case.
>>   >
>>   
>>   First of all, it seems we have different names and terms for those cold-
>>   booted vCPUs and hotpluggable vCPUs. For example, vCPU-0 and vCPU-1
>>   are cold-booted vCPUs while
>>   vCPU-2 and vCPU-3 are hotpluggable vCPUs when we have '-smp
>>   maxcpus=4,cpus=2'. Lets stick to convention and terms for easier discussion.
>>   
>>   The idea is avoid instantiating hotpluggable vCPUs in virtmach_init() and
>>   released in the same function for those hotpluggable vCPUs. As I can
>>   understand, those hotpluggable vCPU instances are serving for two
>>   purposes: (1) Relax the constraint that all vCPU's (kvm) file descriptor have
>>   to be created and populated;
> 
> 
> We are devising *workarounds* in Qemu for the ARM CPU architectural constraints
> in KVM and in Guest Kernel,  *not relaxing* them. We are not allowed to meddle with
> the constraints. That is the whole point.
> 
> Not having to respect those constraints led to rejection of the earlier attempts to
> upstream Virtual CPU Hotplug for ARM.
> 

I meant to 'overcome' the constraints by 'relax'. My apologies if there're any caused
confusions. Previously, you had attempt to create all vCPU objects and reuse them when
vCPU hot added. In current implementation, the hotpluggable vCPUs are instantiated and
released pretty soon. I was bringing the third possibility, to avoid instantiating those
hotpluggable vCPU objects, for discussion. In this series, the life cycle of those
hotpluggable vCPU objects are really short. Again, I didn't say we must avoid instantiating
those vCPU objects, I brought the topic ONLY for discussion.

> 
> (2) Help to instantiate and realize
>>   GICv3 object.
>>   
>>   For (1), I don't think we have to instantiate those hotpluggable vCPUs at all.
>>   In the above example where we have command line '-smp
>>   maxcpus=4,cpus=2', it's unnecessary to instantiate
>>   vCPU-3 and vCPU-4 to create and populate their KVM file descriptors.
> 
> 
> We cannot defer create vCPU in KVM after GIC has been initialized in KVM.
> It needs to know every vCPU that will ever exists right at the time it is getting
> Initialized. This is an ARM CPU Architectural constraint.
> 

It will be appreciated if more details other than 'an ARM CPU architectural constraint'
can be provided. I don't understand this constrain very well at least.

> 
>   A
>>   vCPU's KVM file descriptor is create and populated by the following ioctls
>>   and function calls. When the first vCPU (vCPU-0) is realized, the property
>>   corresponding to "&init" is fixed for all vCPUs. It means all vCPUs have same
>>   properties except the "vcpu_index".
>>   
>>      ioctl(vm-fd,   KVM_CREATE_VCPU,   vcpu_index);
>>      ioctl(vcpu-fd, KVM_ARM_VCPU_INIT, &init);
>>      kvm_park_vcpu(cs);
>>   
>>   A vCPU's properties are determined by two sources and both are global. It
>>   means all vCPUs should have same properties: (a) Feature registers
>>   returned from the host. The function
>>   kvm_arm_get_host_cpu_features() is called for once, meaning this source
>>   is same to all vCPUs;
> 
> 
> Sure, but what are you trying to save here?
> 

As mentioned above, the life cycle of those hotpluggable vCPU objects are really
short. They still consume time and memory to instantiate them. If I'm correct,
one of the primary goal for vCPU hotplug feature is to save system boot-up time,
correct?

> 
>>   (b) The parameters provided by user through '-cpu host,sve=off' are
>>   translated to global properties and applied to all vCPUs when they're
>>   instantiated.
> 
> 
> Sure. Same is the case with PMU and other per-vCPU parameters.
> We do not support heterogenous computing and therefore we do not
> have per-vCPU control of these features as of now.
> 
> 
>>   
>>          (a)                                            (b)
>>   
>>      aarch64_host_initfn                          qemu_init
>>      kvm_arm_set_cpu_features_from_host           parse_cpu_option
>>        kvm_arm_get_host_cpu_features              cpu_common_parse_features
>>                                                   qdev_prop_register_global
>>                                                     :
>>                                                   device_post_init
>>                                                   qdev_prop_set_globals
> 
> 
> Sure, I understand the code flow but what are you trying to suggest here?
> 

I tried to explain that vCPU object isn't needed to create and populate vCPU's file
descriptors, as highlight in (1). The information used to create the cold-booted
vCPU-0 can be reused because all vCPUs have same properties and feature set.

> 
>>   For (2), I'm still looking into the GICv3 code for better understanding.
> 
> 
> Oh, I thought you said you've finished your reviews 😊
> 
> Please take your time. For your reference, you might want to check:
> 
> KVMForum 2023:
> https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
> https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
> 
> KVMForum 2020:
> https://kvm-forum.qemu.org/2020/Oct%2029_Challenges%20in%20Supporting%20Virtual%20CPU%20Hotplug%20in%20SoC%20Based%20Systems%20like%20ARM64_Salil%20Mehta.pdf
> 

hmm, 'finished my review' has been misread frankly. By that, I meant I finished my tests and
provided all the comments I had. Some of them are questions and discussions, which I still need
to follow up.

> 
> Until
>>   now, I don't see we need the instantiated hotpluggable vCPUs either.
> 
> 
> I think, I've already answered this above it is because of ARM Architectural constraint.
> 
> 
>   For
>>   example, the redistributor regions can be exposed based on 'maxcpus'
>>   instead of 'cpus'.
> 
> You mean during the review of the code you found that we are not doing it?
> 

It's all about the discussion to the possibility to avoid instantiating hotpluggable
vCPU objects.

> 
> The IRQ connection and teardown can be dynamically
>>   done by connecting the board with GICv3 through callbacks in
>>   ARMGICv3CommonClass.
>>   The connection between GICv3CPUState and CPUARMState also can be
>>   done dynamically.
> 
> Are you suggesting this after reviewing the code or you have to review it yet? 😉
> 

I was actually trying to ask for your input and feedback. I was hoping your input
to clear my puzzles: why vCPU objects must be in place to create GICv3 object?
Is it possible to create the GICv3 object without those vCPU objects? What kinds
of efforts we need to avoid instantiating those hotpluggable vCPU objects.
The best way perhaps is to find the answer from the code by myself ;-)

Thanks,
Gavin



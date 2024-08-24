Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0BAC52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 10:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shnch-0000yf-WA; Sat, 24 Aug 2024 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1shncg-0000ur-5I
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 06:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1shnce-00034Z-9p
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 06:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724493829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffUXUtZG5YUtp0+O/N6DeNhpe+KKK5tZSkLiAxwnExI=;
 b=F3l0DXY5eYmPHrNNkEFeO1BQ5mdb4xhG6yNtZJyICBfxG11qxvJHrXbd5lT0f5mGWhOcDr
 pxTQqksjcJS2ldxAhPpKJFoXtEG0sU4W24d93CS4+VthvvylxBIDXy88Zs5TeIh10UEk64
 Ig7ZXuBCtxr1pBPvhnz36KS1hT2jcDU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mj9GXjsKOxmswqzw5O2YpQ-1; Sat, 24 Aug 2024 06:03:45 -0400
X-MC-Unique: mj9GXjsKOxmswqzw5O2YpQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7141f62ac14so3055934b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2024 03:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724493824; x=1725098624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffUXUtZG5YUtp0+O/N6DeNhpe+KKK5tZSkLiAxwnExI=;
 b=j6i4/YC8+aVOxJ91AYXtU/u62eXiYykQ6T65FZDJWHclyS59N+9fB/u/3/YG9zotVg
 oazNoqOtabYJ+sCq0ClltX7vqrfiLdJxvDYgjg6qQxIOze91PQ6uTE1keUP4+8p+d8Us
 50c4KmDV7sEQM4IW4Bq1B/ZXReblSq+XDJnYgR3ZxWPnffu3lYxGB1j/SM9OGOruOD2m
 dvVToWTdL/p+bIFO7Lekz1N1jc/JFK6VN0PDyDy1y2QQiTpQ6LXUi7YvaELtoVjKwLfN
 r4veEZaS5LjU/ularQrLRMkSibbSapG0giwdw20xwFyYPhPcGs+02wafiWZC8/4rpGK7
 22EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXzn2uf62F/8eO9x7+4qA7z2CSZfyiPR4jTjYbnZWwQgMJgkE18RFIlX9ehfvo6luPhC6Srv4c0Ub3@nongnu.org
X-Gm-Message-State: AOJu0YxuDSrvr0zg1KU5T3QWmUcrFjnlUm8EUdlk4Y2/JJJG69S107rw
 IqQi049gExwA8Boig3Klvl/JUrRMtQ+Us06lhF6xFagb6cTjq/PvpI1OvanqCXcnQtyyUnzy6cf
 8pRcdezACz6XU8Ae+Mn9KWHJ7ecfOdJvm6QUJsGuQJKyU6AnD0/04
X-Received: by 2002:a05:6a20:d818:b0:1ca:9ca3:2e6e with SMTP id
 adf61e73a8af0-1cc89d6ba5emr9010001637.8.1724493824178; 
 Sat, 24 Aug 2024 03:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEp8gYYi9kjSRMw91hd+CXq2nlnFSOoBowYiH5Ki/iSBxyfF7Vxq/8AhImPkcUfxnbIKnm1g==
X-Received: by 2002:a05:6a20:d818:b0:1ca:9ca3:2e6e with SMTP id
 adf61e73a8af0-1cc89d6ba5emr9009915637.8.1724493823404; 
 Sat, 24 Aug 2024 03:03:43 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.113.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430020fsm4395915b3a.146.2024.08.24.03.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Aug 2024 03:03:42 -0700 (PDT)
Message-ID: <82deccdf-ad02-4c7f-bcb6-20cfd2723c17@redhat.com>
Date: Sat, 24 Aug 2024 20:03:27 +1000
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
 <13ab0fda-fea3-47a6-8c17-006e6bd4430a@redhat.com>
 <aa6bf3294acb4b3f9819c77c94af67c9@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <aa6bf3294acb4b3f9819c77c94af67c9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/23/24 11:17 PM, Salil Mehta wrote:
>>   On 8/22/24 8:58 PM, Salil Mehta wrote:
>>   >>   On 8/21/24 8:23 PM, Salil Mehta wrote:
>>   >>   >>
>>   >>   >>   On 8/21/24 2:40 AM, Salil Mehta wrote:
>>   >>   >>   >
>>   >>   >>   > I don’t understand this clearly. Are  you suggesting to reuse only
>>   >>   >>   > single vCPU object to initialize all KVM vCPUs not yet plugged? If
>>   >>   >>   > yes, then I'm not sure what do we gain here by adding this complexity?
>>   >>   >>   > It does not consume time or resources because we are not realizing any
>>   >>   >>   > of these vCPU object in any case.
>>   >>   >>   >
>>   >>   >>
>>   >>   >>   First of all, it seems we have different names and terms for those cold-
>>   >>   >>   booted vCPUs and hotpluggable vCPUs. For example, vCPU-0 and vCPU-1
>>   >>   >>   are cold-booted vCPUs while
>>   >>   >>   vCPU-2 and vCPU-3 are hotpluggable vCPUs when we have '-smp
>>   >>   >>   maxcpus=4,cpus=2'. Lets stick to convention and terms for easier discussion.
>>   >>   >>
>>   >>   >>   The idea is avoid instantiating hotpluggable vCPUs in virtmach_init() and
>>   >>   >>   released in the same function for those hotpluggable vCPUs. As I can
>>   >>   >>   understand, those hotpluggable vCPU instances are serving for two
>>   >>   >>   purposes: (1) Relax the constraint that all vCPU's (kvm) file descriptor have
>>   >>   >>   to be created and populated;
>>   >>   >
>>   >>   >
>>   >>   > We are devising *workarounds* in Qemu for the ARM CPU architectural
>>   >>   > constraints in KVM and in Guest Kernel,  *not relaxing* them. We are
>>   >>   > not allowed to meddle with the constraints. That is the whole point.
>>   >>   >
>>   >>   > Not having to respect those constraints led to rejection of the
>>   >>   > earlier attempts to upstream Virtual CPU Hotplug for ARM.
>>   >>   >
>>   >>
>>   >>   I meant to 'overcome' the constraints by 'relax'. My apologies if there're any
>>   >>   caused confusions.
>>   >
>>   >
>>   > Ok. No issues. It was important for me to clarify though.
>>   >
>>   >
>>   >   Previously, you had attempt to create all vCPU objects
>>   >>   and reuse them when vCPU hot added.
>>   >
>>   > Yes, at QOM level. But that approach did not realize the
>>   > unplugged/yet-to-be-plugged vCPUs. We were just using QOM vCPU objects
>>   > as the place holders
>>   >
>>   
>>   Right, my point was actually vCPU objects are too heavy as the place
>>   holders. It was reason why I had the concern: why those hotpluggable vCPU
>>   objects can't be avoided during the bootup time.
> 
> 
> Sure, to list down again. For the reasons I've already explained :
> 
> 1. KVM MUST have details about all the vCPUs and its features finalized before the VGIC
>      initialization. This is ARM CPU Architecture constraint. This is immutable requirement!
> 2. QOM vCPUs has got representational changes of the KVM vCPU like vcpu-id, features
>      list etc. These MUST be finalized even before QOM begins its own GICv3 initialization
>      which will end up in initialization of KVM VGIC. QOM vCPUs MUST be handed over to
>      the GICV3 QOM in fully initialized state. The same reason applies here as well.
>      Till this point we are architecture compliant. The only place where we are not ARM
>      Architecture compliant is where in QOM, we dissociate the vCPU state with GICV3
>      CPU State during unplug action or for the yet-to-be-plugged vCPUs. Later are
>      released as part of virt_cpu_post_init() in our current design.
> 

Thanks for your time to evaluate and reply. Sorry that I'm not convinced. You're explaining
what we already have in current design and implementation. It doesn't mean the current design
and implementation is 100% perfect and flawless.

In current design and implementation, all (QOM) vCPU objects have to be instantiated, even
though those hotpluggable (QOM) vCPU objects aren't realized at bootup time. After that, those
(QOM) hotpluggable vCPU objects are finalized and destroyed so that they can be hot added
afterwards. This sounds like we create (QOM) vCPU objects, remove those (QOM) vCPU objects
at booting time so that they can be hot-added at running time. The duplicate work is obvious
there. This scheme and design looks just-for-working, not in an optimized way to me.

I'm giving up the efforts to convince you. Lets see if other reviewers will have same concern
or not. Another possibility would be to have current implementation (with all fixes) merged
upstream firstly, and then seek optimizations after that. That time, the suggestion can be
re-evaluated.

> 
>>   >   In current implementation, the
>>   >>   hotpluggable vCPUs are instantiated and released pretty soon. I was
>>   >>   bringing the third possibility, to avoid instantiating those hotpluggable vCPU
>>   >>   objects, for discussion.
>>   >
>>   >
>>   > Are you suggesting not calling KVM_ARM_VCPU_INIT IOCTL as all for the
>>   > vCPUs which are part of possible list but not yet plugged?
>>   >
>>   > If yes, we cannot do that as KVM vCPUs should be fully initialized
>>   > even before VGIC is initialized inside the KVM. This is a constraint.
>>   > I've explained this in detail in the cover letter of this patch-set
>>   > and in the slides I have shared earlier.
>>   >
>>   
>>   No, it's not what I was suggesting. What I suggested is to avoid creating
>>   those hotpluggable vCPU objects (place holders) during the bootup time.
>>   However, all vCPU file descriptors (KVM
>>   objects) still need to be created and initialized before GICv3 is initialized. It's
>>   one of the constrains. So we need to create and populate all vCPU file
>>   descriptors through ioctl(vm_fd, CREATE_VCPU) and ioctl(vcpu_fd,
>>   INIT_VCPU) before GICv3 object is created and realized. As I explained in
>>   the previous reply, the hotpluggable vCPU objects (place holders) haven't
>>   to be created in order to initialize and populate the vCPU file descriptors for
>>   those hotpluggable vCPUs. I think the parameters used to create and
>>   initialize vCPU-0's file descriptor can be reused by all other vCPUs, because
>>   we don't support heterogeneous vCPUs.
>>   What I suggested is something like below: the point is to avoid instantiating
>>   those hotpluggable vCPUs, but their vCPU file descriptor (KVM object) are
>>   still created and initialized.
>>   
>>        static void machvirt_init(MachineState *machine)
>>        {
>>   
>>            /*
>>             * Instantiate and realize vCPU-0, record the parameter passed to
>>             * ioctl(vcpu-fd, VCPU_INIT, &init), or a better place to remember the
>>   parameter.
>>             * The point is the parameter can be shared by all vCPUs.
>>             */
>>   
>>            /*
>>             * Create vCPU descriptors for all other vCPUs (including hotpluggable
>>   vCPUs).
>>             * The remembered parameter is reused and passed to ioctl(vcpu-fd,
>>   VCPU_INIT, &init).
>>             */
>>   
>>            /* Instanaite and realize other cold-booted vCPUs */
>>   
>>            /* Instantiate and realize GICv3 */
>>   
>>        }
> 
> 
> No. For the reasons I've mentioned above, we MUST provide fully initialize the QOM
> vCPU objects before initialization of QOM GICV3 kicks in. This ensures that nothing
> breaks during initialization process of the QOM GICV3.  Therefore, the optimization
> steps mentioned above are unnecessary and could cause problems in future.
> Additionally, the evolution of the GICV3 QOM can be independent of the ARM Virt
> Machine as it can be used with other Machines as well so we MUST treat it as a black
> box which needs QOM vCPU objects as inputs during its initialization.
> 

Your explanation is not completely correct to me. It's what we had in current design. It
doesn't means the design should have to be like this. The (KVM) vCPU file descriptor must
be in place before QOM GICv3 object is instantiated and realized, but the (QOM) vCPU objects
don't have to exist before that. However, we may need a lot of code changes to tame GICv3Common
and GICv3KVM so that they can be vCPU hot-add/remove friendly and then to avoid the pre-created
(QOM) vCPU objects.

It can be something to be re-evaluated in the future, as I said above. Frankly, It's pointless
to take our time on the discussions without reaching to any conclusions. From my side, I've tried
my best to provide my comments and explain my thoughts. Appreciated for your patience, time on
evaluation, and replies :)

Thanks,
Gavin



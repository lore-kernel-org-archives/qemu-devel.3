Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9EACCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 01:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBkbI-0000QN-Cr; Wed, 22 Oct 2025 21:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vBkbF-0000Pn-HK
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vBkbC-0000hV-KC
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 21:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761184721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLIRAtTk5wrvbZRpK/LftAlTIbj9T9Qc4n5r36kVcmc=;
 b=VLKRloT5Tn3WiFD86gQ/mXFV+Wrf3Ia8wWZuDcUx/KrlxI/NuR5QZiEEg0OXzRy4Bu+7jG
 aVhr3xf+XBoYuWB1MuKAFUiev7DrNJ27ghHdCF1iv7si8M6bwV3VAcsvM/k0Pcdl9sJDIp
 RSVA/x71am9Iawwj0pW87KQcgoXXFsw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-hr6yXsynMliw6cKNNqV9IQ-1; Wed, 22 Oct 2025 21:58:39 -0400
X-MC-Unique: hr6yXsynMliw6cKNNqV9IQ-1
X-Mimecast-MFC-AGG-ID: hr6yXsynMliw6cKNNqV9IQ_1761184718
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b6cf3112d08so508185a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 18:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761184717; x=1761789517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLIRAtTk5wrvbZRpK/LftAlTIbj9T9Qc4n5r36kVcmc=;
 b=K8LEogYwI8GSD85McXxVVhq0UTmiOC1qiNdtoLpe0mcuBaCGzi+qE1C8iakpaXkeie
 doT2/VbRrACltmyE0vlIxkhEcdsNQ8wGGgr1imHufJDb2Mt8WxV+XWf55wihWqygePgw
 9N/Zw1xc8QwWDuV7q9Pfnz2FrHJ/5dFMZS44PGr8i+zCJoC/fuDY2qml4aI01Jbg/wUz
 VGPhJxSb6kE4xT8eZFrFB94VqxDMaWDk7KLM+0n5mSF5codSnDIEznEGrMgcPVFIb+QS
 Eh3f063gcZbwBqraFwR7Sbh2CfD99PFJIZqHY4LCKNIX2i+nnLceFZZDWdY/bXc6cqof
 mOgQ==
X-Gm-Message-State: AOJu0YyaYQNOrrKL9dnmXAznwRomIw/MPbDQ0qNEwOOlS5gooz06R4Bc
 dNlCRDzktIG1bwh8CftvFeoEg5YvLLPnNB50W14LVR41wd/1HRDvR7/LfnFC2YtYQ4GwFdwhpNz
 lz0vtjHdMK5bWeXznl16c3+NLSRuY4r0H7K1ptxri9lfMFw5aIPtvdH5H0w9GMBhH
X-Gm-Gg: ASbGncvotxMrh8sx8ruR0oszP3iMZPGV64ykThMeqKP4OecrymbOYocOFCjxg1lWtZV
 /vUK6lh+jVAQfHHiCC+qwjT0N3NVXLZ2kt0KHXoBmB6bjJuwmy8dKe2SlCR3oSsVNtlpK3au8Iy
 6qGUiGQStIdkC69+TWXV7O9uNVfHQWZ6F2PeVwXkd1AKkyHR6JHyrxp4QdbvcuhxMbNvnzg8yy2
 HTQTyBORn76N04ZVQim6dYPPdN/KEPX48FfI98nT4FGmNEwYjdAq/cfPJkocUdCH7Sgiomrzpwd
 0xjMvwDMRpW5I3fiZktCz5kj5+D57hrolSL9U/VoyuywTu9RQGNw4SQFrVYbbTagDjpetQiEvwP
 hzL4/s0SZMmUGK30+zIjUZ9yT1ZlmO8qzhQySfk0=
X-Received: by 2002:a05:6a20:3d81:b0:32b:83af:9b5 with SMTP id
 adf61e73a8af0-334a861740cmr32187863637.33.1761184716851; 
 Wed, 22 Oct 2025 18:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkfr/rEg0MK3RyApv9Sehg292xcxqyonjPqUBvzKrxOBv+Z9dc1jOVcqUt1qfoMxrfrFDz0w==
X-Received: by 2002:a05:6a20:3d81:b0:32b:83af:9b5 with SMTP id
 adf61e73a8af0-334a861740cmr32187791637.33.1761184716378; 
 Wed, 22 Oct 2025 18:58:36 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274a64c5esm683255b3a.10.2025.10.22.18.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 18:58:35 -0700 (PDT)
Message-ID: <fa5d5a65-616f-405a-a5e5-f8b70ff32193@redhat.com>
Date: Thu, 23 Oct 2025 11:58:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V6 05/24] arm/virt,kvm: Pre-create KVM vCPUs for
 'disabled' QOM vCPUs at machine init
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com,
 armbru@redhat.com, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com, Keqian Zhu <zhuqian1@huawei.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
 <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
 <CAJ7pxeaUfUeXwtTVheCTxej-aCTCx0n8-XyAKaFneVUjcWL_7w@mail.gmail.com>
 <beab3dd4-0c19-441c-a9f5-ecae9e791753@redhat.com>
 <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/25 10:35 AM, Salil Mehta wrote:
> On Thu, Oct 23, 2025 at 12:14 AM Gavin Shan <gshan@redhat.com> wrote:
>> On 10/23/25 4:50 AM, Salil Mehta wrote:
>>> On Wed, Oct 22, 2025 at 6:18 PM Salil Mehta <salil.mehta@opnsrc.net> wrote:
>>>> On Wed, Oct 22, 2025 at 10:37 AM Gavin Shan <gshan@redhat.com> wrote:
>>>>> On 10/1/25 11:01 AM, salil.mehta@opnsrc.net wrote:
>>>>>> From: Salil Mehta <salil.mehta@huawei.com>

[...]

>>>>>> +void kvm_arm_create_host_vcpu(ARMCPU *cpu)
>>>>>> +{
>>>>>> +    CPUState *cs = CPU(cpu);
>>>>>> +    unsigned long vcpu_id = cs->cpu_index;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = kvm_create_vcpu(cs);
>>>>>> +    if (ret < 0) {
>>>>>> +        error_report("Failed to create host vcpu %ld", vcpu_id);
>>>>>> +        abort();
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Initialize the vCPU in the host. This will reset the sys regs
>>>>>> +     * for this vCPU and related registers like MPIDR_EL1 etc. also
>>>>>> +     * get programmed during this call to host. These are referenced
>>>>>> +     * later while setting device attributes of the GICR during GICv3
>>>>>> +     * reset.
>>>>>> +     */
>>>>>> +    ret = kvm_arch_init_vcpu(cs);
>>>>>> +    if (ret < 0) {
>>>>>> +        error_report("Failed to initialize host vcpu %ld", vcpu_id);
>>>>>> +        abort();
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * park the created vCPU. shall be used during kvm_get_vcpu() when
>>>>>> +     * threads are created during realization of ARM vCPUs.
>>>>>> +     */
>>>>>> +    kvm_park_vcpu(cs);
>>>>>> +}
>>>>>> +
>>>>>
>>>>> I don't think we're able to simply call kvm_arch_init_vcpu() in the lazily realized
>>>>> path. Otherwise, it can trigger a crash dump on my Nvidia's grace-hopper machine where
>>>>> SVE is supported by default.
>>>>
>>>> Thanks for reporting this. That is not true. As long as we initialize
>>>> KVM correctly and
>>>> finalize the features like SVE we should be fine. In fact, this is
>>>> precisely what we are
>>>> doing right now.
>>>>
>>>> To understand the crash, I need a bit more info.
>>>>
>>>> 1#  is happening because KVM_ARM_VCPU_INIT is failing. If yes, the can you check
>>>>         within the KVM if it is happening because
>>>>        a.  features specified by QEMU are not matching the defaults within the KVM
>>>>              (HInt: check kvm_vcpu_init_check_features())?
>>>>        b. or complaining about init feate change kvm_vcpu_init_changed()?
>>>> 2#  or it is happening during the setting of vector length or
>>>> finalizing features?
>>>>
>>>> int kvm_arch_init_vcpu(CPUState *cs)
>>>> {
>>>>      [...]
>>>>            /* Do KVM_ARM_VCPU_INIT ioctl */
>>>>           ret = kvm_arm_vcpu_init(cpu);   ---->[1]
>>>>           if (ret) {
>>>>              return ret;
>>>>          }
>>>>             if (cpu_isar_feature(aa64_sve, cpu)) {
>>>>           ret = kvm_arm_sve_set_vls(cpu); ---->[2]
>>>>           if (ret) {
>>>>               return ret;
>>>>           }
>>>>           ret = kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);--->[3]
>>>>           if (ret) {
>>>>               return ret;
>>>>           }
>>>>       }
>>>> [...]
>>>> }
>>>>
>>>> I think it's happening because vector length is going uninitialized.
>>>> This initialization
>>>> happens in context to  arm_cpu_finalize_features() which I forgot to call before
>>>> calling KVM finalize.
>>>>
>>>>>
>>>>> kvm_arch_init_vcpu() is supposed to be called in the realization path in current
>>>>> implementation (without this series) because the parameters (features) to KVM_ARM_VCPU_INIT
>>>>> is populated at vCPU realization time.
>>>>
>>>> Not necessarily. It is just meant to initialize the KVM. If we take care of the
>>>> KVM requirements in the similar way the realize path does we should be
>>>> fine. Can you try to add the patch below in your code and test if it works?
>>>>
>>>>    diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index c4b68a0b17..1091593478 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -1068,6 +1068,9 @@ void kvm_arm_create_host_vcpu(ARMCPU *cpu)
>>>>            abort();
>>>>        }
>>>>
>>>> +     /* finalize the features like SVE, SME etc */
>>>> +     arm_cpu_finalize_features(cpu, &error_abort);
>>>> +
>>>>        /*
>>>>         * Initialize the vCPU in the host. This will reset the sys regs
>>>>         * for this vCPU and related registers like MPIDR_EL1 etc. also
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> $ home/gavin/sandbox/qemu.main/build/qemu-system-aarch64           \
>>>>>      --enable-kvm -machine virt,gic-version=3 -cpu host               \
>>>>>      -smp cpus=4,disabledcpus=2 -m 1024M                              \
>>>>>      -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image    \
>>>>>      -initrd /home/gavin/sandbox/images/rootfs.cpio.xz -nographic
>>>>> qemu-system-aarch64: Failed to initialize host vcpu 4
>>>>> Aborted (core dumped)
>>>>>
>>>>> Backtrace
>>>>> =========
>>>>> (gdb) bt
>>>>> #0  0x0000ffff9106bc80 in __pthread_kill_implementation () at /lib64/libc.so.6
>>>>> #1  0x0000ffff9101aa40 [PAC] in raise () at /lib64/libc.so.6
>>>>> #2  0x0000ffff91005988 [PAC] in abort () at /lib64/libc.so.6
>>>>> #3  0x0000aaaab1cc26b8 [PAC] in kvm_arm_create_host_vcpu (cpu=0xaaaab9ab1bc0)
>>>>>        at ../target/arm/kvm.c:1081
>>>>> #4  0x0000aaaab1cd0c94 in virt_setup_lazy_vcpu_realization (cpuobj=0xaaaab9ab1bc0, vms=0xaaaab98870a0)
>>>>>        at ../hw/arm/virt.c:2483
>>>>> #5  0x0000aaaab1cd180c in machvirt_init (machine=0xaaaab98870a0) at ../hw/arm/virt.c:2777
>>>>> #6  0x0000aaaab160f220 in machine_run_board_init
>>>>>        (machine=0xaaaab98870a0, mem_path=0x0, errp=0xfffffa86bdc8) at ../hw/core/machine.c:1722
>>>>> #7  0x0000aaaab1a25ef4 in qemu_init_board () at ../system/vl.c:2723
>>>>> #8  0x0000aaaab1a2635c in qmp_x_exit_preconfig (errp=0xaaaab38a50f0 <error_fatal>)
>>>>>        at ../system/vl.c:2821
>>>>> #9  0x0000aaaab1a28b08 in qemu_init (argc=15, argv=0xfffffa86c1f8) at ../system/vl.c:3882
>>>>> #10 0x0000aaaab221d9e4 in main (argc=15, argv=0xfffffa86c1f8) at ../system/main.c:71
>>>>
>>>>
>>>> Thank you for this. Please let me know if the above fix works and also
>>>> the return values in
>>>> case you encounter errors.
>>>
>>> I've pushed the fix to below branch for your convenience:
>>>
>>> Branch: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v6.2
>>> Fix: https://github.com/salil-mehta/qemu/commit/1f1fbc0998ffb1fe26140df3c336bf2be2aa8669
>>>
>>
>> I guess rfc-v6.2 branch isn't ready for test because it runs into another crash
>> dump with rfc-v6.2 branch, like below.
> 
> 
> rfc-6.2 is not crashing on Kunpeng920 where I tested. But this
> chip does not have some ARM extensions like SVE etc so
> Unfortunately, I can't test SVE/SME/PAuth etc support.
> 
> Can you disable SVE and then try if it comes up just to corner
> the case?
> 

Right, this crash dump shouldn't be encountered if SVE isn't supported. I already
had the workaround "-cpu host,sve=off" to keep my tests moving forwards...

>>
>> host$ /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64                     \
>>         -accel kvm -machine virt,gic-version=host,nvdimm=on                         \
>>         -cpu host,sve=on                                                            \
>>         -smp maxcpus=4,cpus=2,disabledcpus=2,sockets=2,clusters=2,cores=1,threads=1 \
>>         -m 4096M,slots=16,maxmem=128G                                               \
>>         -object memory-backend-ram,id=mem0,size=2048M                               \
>>         -object memory-backend-ram,id=mem1,size=2048M                               \
>>         -numa node,nodeid=0,memdev=mem0,cpus=0-1                                    \
>>         -numa node,nodeid=1,memdev=mem1,cpus=2-3                                    \
>>         -L /home/gavin/sandbox/qemu.main/build/pc-bios                              \
>>         -monitor none -serial mon:stdio -nographic -gdb tcp::6666                   \
>>         -qmp tcp:localhost:5555,server,wait=off                                     \
>>         -bios /home/gavin/sandbox/qemu.main/build/pc-bios/edk2-aarch64-code.fd      \
>>         -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image               \
>>         -initrd /home/gavin/sandbox/images/rootfs.cpio.xz                           \
>>         -append memhp_default_state=online_movable
>>           :
>>           :
>> guest$ cd /sys/devices/system/cpu/
>> guest$ cat present enabled online
>> 0-3
>> 0-1
>> 0-1
>> (qemu) device_set host-arm-cpu,socket-id=1,cluster-id=0,core-id=0,thread-id=0,admin-state=enable
>> qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (2): Operation not permitted
> 
> 
> Ah, I see. I think I understand the issue. It's complaining
> about calling the  finalize twice. Is it possible to check as
> I do not have a way to test it?
> 
> 
> int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
> {
> switch (feature) {
> case KVM_ARM_VCPU_SVE:
> [...]
> if (kvm_arm_vcpu_sve_finalized(vcpu))
> return -EPERM;-----> this where it must be popping?
> [...]
> }
> 

Right, I think that's the case: QEMU tries to finalize SVE capability for twice,
which is the real problem. I'm explaining what I found as below, which would be
helpful to the forthcoming revisions.

machvirt_init
   virt_setup_lazy_vcpu_realization
     arm_cpu_finalize_features
     kvm_arm_create_host_vcpu
       kvm_create_vcpu                       // New fd is created
       kvm_arch_init_vcpu
         kvm_arm_vcpu_init
         kvm_arm_sve_set_vls
         kvm_arm_vcpu_finalize               // (A) SVE capability is finalized

device_set_admin_power_state
   device_pre_poweron
     virt_machine_device_pre_poweron
       virt_cpu_pre_poweron
         qdev_realize
           arm_cpu_realizefn
             cpu_exec_realizefn
             arm_cpu_finalize_features       // Called for the second time
             qemu_init_vcpu
               kvm_start_vcpu_thread
                 kvm_vcpu_thread_fn
                   kvm_init_vcpu
                     kvm_create_vcpu         // Called for the second time
                     kvm_arch_init_vcpu      // Called for the second time
                       kvm_arm_vcpu_init
                       kvm_arm_sve_set_vls   // (B) Failed here
                       kvm_arm_vcpu_finalize

(B) where we try to finalize SVE capability again. It has been finalized at (A)
     Fianlizing SVE capability for twice is disallowed by KVM on the host side.


>>
>> I picked the fix (the last patch in rfc-v6.2 branch) to rfc-v6 branch, same crash dump
>> can be seen.
> 
> Are you getting previously reported abort or above new problem?
> 

Previously, the VM can't be started. After your fix is applied, the VM is able to start.
It's a new problem that qemu crash dump is seens on attempt to hot add a vCPU.

Thanks,
Gavin



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EBBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQDs-0003P1-3s; Mon, 12 Aug 2024 04:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdQDp-0003MI-VA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdQDl-0002Ew-GG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723450563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoL7wwtFd86vAPLugXd+UlC7FcHiJVd/NyfCXHrp6VI=;
 b=hsWjPlfSgNzZEk5nsJAiWooCOW/P83f6q/yftjOD+ToKDU7rKt1U++Vb6x6sFfYffvbIRh
 BkAtgLEpy2m2P0h/Qy/jtkfK3lN7FMZw9Yl6s+lpPGilL0iPcQPhlL5V8HF6juNf1X4N0x
 3ZdHiggf1z7D9G8unOZ1iW8sI1qceso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-SDHt3qgFMR-_D07npwfUZA-1; Mon, 12 Aug 2024 04:16:00 -0400
X-MC-Unique: SDHt3qgFMR-_D07npwfUZA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280e1852f3so33817375e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723450559; x=1724055359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoL7wwtFd86vAPLugXd+UlC7FcHiJVd/NyfCXHrp6VI=;
 b=DLNlpegw/bzqJxMtUJLwpUD6xMhMSXeOxhXCQpyRqqQTus5QiCvyojUa+7Es7iFpu6
 1vU+57abx8mmCi+9rVS+Ehfzznu+km7VqIl5sWNX5HGLpKaaQoeSJ2f+juXMylCAyVPo
 RPPqKwgEWw4TXuyJkXJf/yFD/vMARvQn4uMbw8YkITn/wEw0LD+C+7tF32+gG8ITaHwg
 V8ZXm7yzQ2Vny4WEo3GQ3Zpj4XRXPFfL8/CcQ97hzsck9nyxKOe73mLrmARttRhYg8kS
 1NRuBNzs0Mufzv+9xBB/seHZtVutwic0Vw+XnBY7dKEfFEtOoh4vxR98uQsIssKr4O1I
 4VQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhoDIgjbHUB83Nl8QZ0CIDl/H/NzX05Gcwu8z+D4ui8UScsXhUGaGHYgeNsSCNhkVZHLAjsNtJvMbV@nongnu.org
X-Gm-Message-State: AOJu0YytXqPpLPjo6qBEk9GYUKeFREetBzJ1VvcmKXcVrN3AdLGPETfJ
 V4L7rCCokyH4FyuhpMGNfRxiKQ2Z3oobQNDvAaXKo47dbf8Gzbx/DV6idC4icPOuLfVR/xjMVRZ
 HklSEEcjf9RmVtIsfoRSfSn+lDlZbjdP2zuTGyP9ggmL2+5v+JsO1
X-Received: by 2002:a05:600c:548b:b0:428:c0a:27ea with SMTP id
 5b1f17b1804b1-429c3a1bc92mr51096455e9.12.1723450559269; 
 Mon, 12 Aug 2024 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuSfKqcUKUWY2LDEgt3ACpm2jEBpK8uGzrUGYzUEnYwwFEXD/4I31D3Ip1FDCxUvUdWIkukg==
X-Received: by 2002:a05:600c:548b:b0:428:c0a:27ea with SMTP id
 5b1f17b1804b1-429c3a1bc92mr51096225e9.12.1723450558634; 
 Mon, 12 Aug 2024 01:15:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77370b0sm94098375e9.32.2024.08.12.01.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 01:15:57 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:15:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Message-ID: <20240812101556.1a395712@imammedo.users.ipa.redhat.com>
In-Reply-To: <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 12 Aug 2024 14:35:56 +1000
Gavin Shan <gshan@redhat.com> wrote:

> On 6/14/24 9:36 AM, Salil Mehta wrote:
> > This shall be used to store user specified topology{socket,cluster,core,thread}
> > and shall be converted to a unique 'vcpu-id' which is used as slot-index during
> > hot(un)plug of vCPU.
> > 
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >   hw/arm/virt.c         | 10 ++++++++++
> >   include/hw/arm/virt.h | 28 ++++++++++++++++++++++++++++
> >   target/arm/cpu.c      |  4 ++++
> >   target/arm/cpu.h      |  4 ++++
> >   4 files changed, 46 insertions(+)
> >   
> 
> Those 4 properties are introduced to determine the vCPU's slot, which is the index
> to MachineState::possible_cpus::cpus[]. From there, the CPU object or instance is
> referenced and then the CPU's state can be further determined. It sounds reasonable
> to use the CPU's topology to determine the index. However, I'm wandering if this can
> be simplified to use 'cpu-index' or 'index' for a couple of facts: (1) 'cpu-index'

Please, don't. We've spent a bunch of time to get rid of cpu-index in user
visible interface (well, old NUMA CLI is still there along with 'new' topology
based one, but that's the last one).

> or 'index' is simplified. Users have to provide 4 parameters in order to determine
> its index in the extreme case, for example "device_add host-arm-cpu, id=cpu7,socket-id=1,
> cluster-id=1,core-id=1,thread-id=1". With 'cpu-index' or 'index', it can be simplified
> to 'index=7'. (2) The cold-booted and hotpluggable CPUs are determined by their index
> instead of their topology. For example, CPU0/1/2/3 are cold-booted CPUs while CPU4/5/6/7
> are hotpluggable CPUs with command lines '-smp maxcpus=8,cpus=4'. So 'index' makes
> more sense to identify a vCPU's slot.
cpu-index have been used for hotplug with x86 machines as a starting point
to implement hotplug as it was easy to hack and it has already existed in QEMU.

But that didn't scale as was desired and had its own issues.
Hence the current interface that majority agreed upon.
I don't remember exact arguments anymore (they could be found qemu-devel if needed)
Here is a link to the talk that tried to explain why topo based was introduced.
  http://events17.linuxfoundation.org/sites/events/files/slides/CPU%20Hot-plug%20support%20in%20QEMU.pdf


> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3c93c0c0a6..11fc7fc318 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2215,6 +2215,14 @@ static void machvirt_init(MachineState *machine)
> >                             &error_fatal);
> >   
> >           aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
> > +        object_property_set_int(cpuobj, "socket-id",
> > +                                virt_get_socket_id(machine, n), NULL);
> > +        object_property_set_int(cpuobj, "cluster-id",
> > +                                virt_get_cluster_id(machine, n), NULL);
> > +        object_property_set_int(cpuobj, "core-id",
> > +                                virt_get_core_id(machine, n), NULL);
> > +        object_property_set_int(cpuobj, "thread-id",
> > +                                virt_get_thread_id(machine, n), NULL);
> >   
> >           if (!vms->secure) {
> >               object_property_set_bool(cpuobj, "has_el3", false, NULL);
> > @@ -2708,6 +2716,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >   {
> >       int n;
> >       unsigned int max_cpus = ms->smp.max_cpus;
> > +    unsigned int smp_threads = ms->smp.threads;
> >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >       MachineClass *mc = MACHINE_GET_CLASS(vms);
> >   
> > @@ -2721,6 +2730,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
> >       ms->possible_cpus->len = max_cpus;
> >       for (n = 0; n < ms->possible_cpus->len; n++) {
> >           ms->possible_cpus->cpus[n].type = ms->cpu_type;
> > +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
> >           ms->possible_cpus->cpus[n].arch_id =
> >               virt_cpu_mp_affinity(vms, n);
> >     
> 
> Why @vcpus_count is initialized to @smp_threads? it needs to be documented in
> the commit log.
> 
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index bb486d36b1..6f9a7bb60b 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -209,4 +209,32 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
> >               vms->highmem_redists) ? 2 : 1;
> >   }
> >   
> > +static inline int virt_get_socket_id(const MachineState *ms, int cpu_index)
> > +{
> > +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> > +
> > +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
> > +}
> > +
> > +static inline int virt_get_cluster_id(const MachineState *ms, int cpu_index)
> > +{
> > +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> > +
> > +    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
> > +}
> > +
> > +static inline int virt_get_core_id(const MachineState *ms, int cpu_index)
> > +{
> > +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> > +
> > +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
> > +}
> > +
> > +static inline int virt_get_thread_id(const MachineState *ms, int cpu_index)
> > +{
> > +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
> > +
> > +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
> > +}
> > +
> >   #endif /* QEMU_ARM_VIRT_H */
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 77f8c9c748..abc4ed0842 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -2582,6 +2582,10 @@ static Property arm_cpu_properties[] = {
> >       DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> >                           mp_affinity, ARM64_AFFINITY_INVALID),
> >       DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> > +    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
> > +    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
> > +    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
> > +    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
> >       DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
> >       /* True to default to the backward-compat old CNTFRQ rather than 1Ghz */
> >       DEFINE_PROP_BOOL("backcompat-cntfrq", ARMCPU, backcompat_cntfrq, false),
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index c17264c239..208c719db3 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1076,6 +1076,10 @@ struct ArchCPU {
> >       QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
> >   
> >       int32_t node_id; /* NUMA node this CPU belongs to */
> > +    int32_t socket_id;
> > +    int32_t cluster_id;
> > +    int32_t core_id;
> > +    int32_t thread_id;
> >   
> >       /* Used to synchronize KVM and QEMU in-kernel device levels */
> >       uint8_t device_irq_level;  
> 
> Thanks,
> Gavin
> 



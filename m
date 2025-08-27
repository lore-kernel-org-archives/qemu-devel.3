Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEH2-0003g3-Ov; Wed, 27 Aug 2025 07:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urEH1-0003fk-9i
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urEGw-0002BE-81
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756293896;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uwcEGb4Mv0Dh9MNWxBrvDnYs2eh2CziwqrkxcX8YHyY=;
 b=CRx9eYcuwJaNlTWS1wrdCAL5itSlY9rbcyCTUb8FzCkqDLYmkXmTzygnuZA84soJjnlsVV
 XniPpXTaICy+fkF/UeXwwTgskWDLIC6Y9jT+E8W6ET69t+Tm8LV6GjXk0EPp86i5e6moUo
 24at1VQgfbfEUEdXbMHd2xxmiyRAKyk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-ROt0HmK-Mwmu78lqAKITMw-1; Wed,
 27 Aug 2025 07:24:52 -0400
X-MC-Unique: ROt0HmK-Mwmu78lqAKITMw-1
X-Mimecast-MFC-AGG-ID: ROt0HmK-Mwmu78lqAKITMw_1756293890
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A4CB1800342; Wed, 27 Aug 2025 11:24:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E797E1800293; Wed, 27 Aug 2025 11:24:42 +0000 (UTC)
Date: Wed, 27 Aug 2025 12:24:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 10/26] accel/mshv: Add vCPU creation and execution loop
Message-ID: <aK7q91-sjFp8nVIG@redhat.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-11-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807143951.1154713-11-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 04:39:35PM +0200, Magnus Kulke wrote:
> Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
> Register the MSHV CPU execution loop loop with the QEMU accelerator
> framework to enable guest code execution.
> 
> The target/i386 functionality is still mostly stubbed out and will be
> populated in a later commit in this series.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 187 +++++++++++++++++++++++++++++++++---
>  accel/mshv/trace-events     |   2 +
>  include/system/mshv.h       |  17 ++++
>  target/i386/mshv/mshv-cpu.c |  63 ++++++++++++
>  4 files changed, 257 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 54c32d6252..a4eeaeec76 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -391,6 +391,24 @@ int mshv_hvcall(int vm_fd, const struct mshv_root_hvcall *args)
>      return ret;
>  }
>  
> +static int mshv_init_vcpu(CPUState *cpu)
> +{
> +    int vm_fd = mshv_state->vm;
> +    uint8_t vp_index = cpu->cpu_index;
> +    int ret;
> +
> +    mshv_arch_init_vcpu(cpu);
> +    cpu->accel = g_new0(AccelCPUState, 1);
> +
> +    ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
> +    if (ret < 0) {
> +        return -1;
> +    }
> +
> +    cpu->accel->dirty = true;
> +
> +    return 0;
> +}
>  
>  static int mshv_init(AccelState *as, MachineState *ms)
>  {
> @@ -413,6 +431,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
>          return -1;
>      }
>  
> +    mshv_init_cpu_logic();
> +
>      mshv_init_msicontrol();
>  
>      ret = create_vm(mshv_fd, &vm_fd);
> @@ -442,40 +462,183 @@ static int mshv_init(AccelState *as, MachineState *ms)
>      return 0;
>  }
>  
> +static int mshv_destroy_vcpu(CPUState *cpu)
> +{
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    int vm_fd = mshv_state->vm;
> +
> +    mshv_remove_vcpu(vm_fd, cpu_fd);
> +    mshv_vcpufd(cpu) = 0;
> +
> +    mshv_arch_destroy_vcpu(cpu);
> +    g_free(cpu->accel);

Since the lifetime of the CPUState is not tightly
tied to the cpu->accel, I'd suggest that here
should use

  g_clear_pointer(&cpu->accel, g_free);

so that if there is any race with code accessing
cpu->accel after it is free'd, we'll get a clear
NULL de-reference, rather than use-after-free which
is harder to diagnose.


> +static void *mshv_vcpu_thread(void *arg)
> +{
> +    CPUState *cpu = arg;
> +    int ret;
> +
> +    rcu_register_thread();
> +
> +    bql_lock();
> +    qemu_thread_get_self(cpu->thread);
> +    cpu->thread_id = qemu_get_thread_id();

So every MSHV  vCPU has a corresponding Linux thread, similar
to the model with KVM.  In libvirt we rely on the vCPU thread
being controllable with all the normal Linux process related
APIs. For example, setting thread CPU affinity, setting NUMA
memory policy, setting scheduler priorities, putting threads
into cgroups and applying a wide variety of cgroup controls.

Will there be any significant "gotchas" with the threads for
MSHV vCPUs, that would mean the above libvirt controls would
either raise errors, or silently not have any effect ?


> +    current_cpu = cpu;
> +    ret = mshv_init_vcpu(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to init vcpu %d", cpu->cpu_index);
> +        goto cleanup;
> +    }
> +
> +    /* signal CPU creation */
> +    cpu_thread_signal_created(cpu);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> +
> +    do {
> +        if (cpu_can_run(cpu)) {
> +            mshv_cpu_exec(cpu);
> +        }
> +        qemu_wait_io_event(cpu);
> +    } while (!cpu->unplug || cpu_can_run(cpu));
> +
> +    mshv_destroy_vcpu(cpu);
> +cleanup:
> +    cpu_thread_signal_destroyed(cpu);
> +    bql_unlock();
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
>  static void mshv_start_vcpu_thread(CPUState *cpu)
>  {
> -    error_report("unimplemented");
> -    abort();
> +    char thread_name[VCPU_THREAD_NAME_SIZE];
> +
> +    cpu->thread = g_malloc0(sizeof(QemuThread));

     = g_new0(QemuThread, 1);

> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));

     = g_new0(QemuCond, 1);

> +
> +    qemu_cond_init(cpu->halt_cond);
> +
> +    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);
> +    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
> +                       QEMU_THREAD_JOINABLE);
> +}



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



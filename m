Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AA4CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3v9L-0005Sl-Re; Wed, 01 Oct 2025 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3v9J-0005ST-IF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3v98-0003lW-T2
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759318637;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uM+C04Uou+0L5SbpdqRstzBuNSxqWZvsuF8Hy365MZ0=;
 b=Ntwo/+ft4Mv1RY11rEzlxIboHBUPXzjznaJvj2ErPSZqqPDaXm9cFxTjbhONJ9jAB4Wm8f
 MABpQ6LLEyV3Qs4MyE04wMX4rTRNGA+t5/GOf5BSqA/P6Peml87HiGtrgUYAd6AePOtxXB
 F/mqmWcGm4olV03LyZ/QdePXbTbVUm4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-cqFDdJa0NNGEi0AnpbmnRw-1; Wed,
 01 Oct 2025 07:37:14 -0400
X-MC-Unique: cqFDdJa0NNGEi0AnpbmnRw-1
X-Mimecast-MFC-AGG-ID: cqFDdJa0NNGEi0AnpbmnRw_1759318632
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB4F19560AF; Wed,  1 Oct 2025 11:37:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A9430002C5; Wed,  1 Oct 2025 11:37:02 +0000 (UTC)
Date: Wed, 1 Oct 2025 12:36:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 10/27] accel/mshv: Add vCPU creation and execution loop
Message-ID: <aN0SWa-i-zJJLDW2@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-11-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-11-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 16, 2025 at 06:48:30PM +0200, Magnus Kulke wrote:
> Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
> Register the MSHV CPU execution loop loop with the QEMU accelerator
> framework to enable guest code execution.
> 
> The target/i386 functionality is still mostly stubbed out and will be
> populated in a later commit in this series.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 188 +++++++++++++++++++++++++++++++++---
>  accel/mshv/trace-events     |   2 +
>  include/system/mshv.h       |  17 ++++
>  target/i386/mshv/mshv-cpu.c |  64 ++++++++++++
>  4 files changed, 259 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 63f2ed5fa1..b49988d294 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -392,6 +392,24 @@ int mshv_hvcall(int fd, const struct mshv_root_hvcall *args)
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
> @@ -414,6 +432,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
>          return -1;
>      }
>  
> +    mshv_init_mmio_emu();
> +
>      mshv_init_msicontrol();
>  
>      ret = create_vm(mshv_fd, &vm_fd);
> @@ -443,40 +463,184 @@ static int mshv_init(AccelState *as, MachineState *ms)
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
> +    g_clear_pointer(&cpu->accel, g_free);

This is a double-free.

   g_clear_pointer(&cpu->accel, g_free);

is equivalent to

   g_free(cpu->accel)
   cpu->accel = NULL;

So you don't need the earlier 'g_free(cpu->accel)'
call


> +void mshv_arch_destroy_vcpu(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
> +    g_free(env->emu_mmio_buf);
> +    env->emu_mmio_buf = NULL;

These two lines could be replaced with

  g_clear_pointer(&env->emu_mmio_buf, g_free);


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



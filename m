Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF1DC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwTM-0007yn-Fw; Wed, 02 Apr 2025 07:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwTJ-0007xJ-7B
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwTG-00049R-SO
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743594084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=F26kejczB0IcvMC9uwew5ia4bJQR9YG97iffe6dCF9k=;
 b=GaH+BbAigB6Onp/wRSEamEnOISlUews2G/bzuO8HMdB6R3vAva0U69l+36tbEV5r2i3KhD
 DTZi6gTt2BOjbEO6bltoyd4r7pgPtEGB8bUwgVyGCklm9FwZHwcDFY6xfsffKFuIM/x1n6
 XvkyNrvnwS1AmQEfML+AwlPlk7Pm8oc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-oV5Y6yZePlyefDgH-YTdIQ-1; Wed,
 02 Apr 2025 07:41:22 -0400
X-MC-Unique: oV5Y6yZePlyefDgH-YTdIQ-1
X-Mimecast-MFC-AGG-ID: oV5Y6yZePlyefDgH-YTdIQ_1743594081
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6AE91800EC5; Wed,  2 Apr 2025 11:41:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 618471956094; Wed,  2 Apr 2025 11:41:14 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:41:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 08/55] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <Z-0iV-xIeu0hoaaC@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-9-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-9-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 01, 2025 at 09:01:18AM -0400, Xiaoyao Li wrote:
> Invoke KVM_TDX_INIT_VM in kvm_arch_pre_create_vcpu() that
> KVM_TDX_INIT_VM configures global TD configurations, e.g. the canonical
> CPUID config, and must be executed prior to creating vCPUs.
> 
> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
> 
> Note, this doesn't address the fact that QEMU may change the CPUID
> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
> provide a stable CPUID config prior to kvm_arch_init().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes in v8:
> - Drop the code that initializes cpu->kvm_state before
>   kvm_arch_pre_create_vcpu() because it's not needed anymore.
> 
> Changes in v7:
> - Add comments to explain why KVM_TDX_INIT_VM should retry on -EAGAIN;
> - Add retry limit of 10000 times for -EAGAIN on KVM_TDX_INIT_VM;
> 
> Changes in v6:
> - setup xfam explicitly to fit with new uapi;
> - use tdx_caps->cpuid to filter the input of cpuids because now KVM only
>   allows the leafs that reported via KVM_TDX_GET_CAPABILITIES;
> 
> Changes in v4:
> - mark init_vm with g_autofree() and use QEMU_LOCK_GUARD() to eliminate
>   the goto labels; (Daniel)
> Changes in v3:
> - Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
> ---
>  target/i386/kvm/kvm.c       |  16 +++---
>  target/i386/kvm/kvm_i386.h  |   5 ++
>  target/i386/kvm/meson.build |   2 +-
>  target/i386/kvm/tdx-stub.c  |  10 ++++
>  target/i386/kvm/tdx.c       | 105 ++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h       |   6 +++
>  6 files changed, 137 insertions(+), 7 deletions(-)
>  create mode 100644 target/i386/kvm/tdx-stub.c


> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 16f67e18ae78..0afaf739c09f 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c

> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
> +    Error *local_err = NULL;
> +    int retry = 10000;
> +    int r = 0;
> +
> +    QEMU_LOCK_GUARD(&tdx_guest->lock);
> +    if (tdx_guest->initialized) {
> +        return r;
> +    }
> +
> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> +
> +    r = setup_td_xfam(x86cpu, errp);
> +    if (r) {
> +        return r;
> +    }
> +
> +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
> +    tdx_filter_cpuid(&init_vm->cpuid);
> +
> +    init_vm->attributes = tdx_guest->attributes;
> +    init_vm->xfam = tdx_guest->xfam;
> +
> +    /*
> +     * KVM_TDX_INIT_VM gets -EAGAIN when KVM side SEAMCALL(TDH_MNG_CREATE)
> +     * gets TDX_RND_NO_ENTROPY due to Random number generation (e.g., RDRAND or
> +     * RDSEED) is busy.
> +     *
> +     * Retry for the case.
> +     */
> +    do {
> +        error_free(local_err);
> +        local_err = NULL;
> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm, &local_err);
> +    } while (r == -EAGAIN && --retry);
> +
> +    if (r < 0) {
> +        if (!retry) {
> +            error_report("Hardware RNG (Random Number Generator) is busy "
> +                         "occupied by someone (via RDRAND/RDSEED) maliciously, "
> +                         "which leads to KVM_TDX_INIT_VM keeping failure "
> +                         "due to lack of entropy.");

This needs to be

     error_append_hint(local_err, ....);

so that this message gets associated with the error object that
is propagated, and the top level will print it all at once.

> +        }
> +        error_propagate(errp, local_err);
> +        return r;
> +    }
> +
> +    tdx_guest->initialized = true;
> +
> +    return 0;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0CED12693
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I8R-0004nX-Mb; Tue, 05 Nov 2024 06:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8I8Q-0004nM-DJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8I8O-00020v-Ip
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730807647;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5fDfx53ZSBgYR8OHgSEUnZXPbbkgehmSaTpCCC/NvY=;
 b=Quk51M8SDp437YVCrG3owv0mJB6nFpd9kZIWeWWsnsV3D752DPs8ARvr+3zKTH3TRTcdQB
 hoJvOYZsZmuODKcxGeTE7R5uGlk2CRApAyUH9TG3kJX0hA/Df96y7JzkoX3x8/Z3D1OBWN
 JQ28RdQMLzl/7KQ4FGpx5pm4JYBFD4I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-w2gr8U1KPmG-WWxWF-gCrg-1; Tue,
 05 Nov 2024 06:54:04 -0500
X-MC-Unique: w2gr8U1KPmG-WWxWF-gCrg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 135C61955F40; Tue,  5 Nov 2024 11:54:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16E21195607C; Tue,  5 Nov 2024 11:53:54 +0000 (UTC)
Date: Tue, 5 Nov 2024 11:53:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <ZyoHTuWRrtbyR6I0@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <Zyn0oBKvOC9rvcqk@redhat.com>
 <f0283ac7-31bb-4d59-b45d-046f3e582d55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0283ac7-31bb-4d59-b45d-046f3e582d55@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 05, 2024 at 07:51:53PM +0800, Xiaoyao Li wrote:
> On 11/5/2024 6:34 PM, Daniel P. Berrangé wrote:
> > On Tue, Nov 05, 2024 at 01:23:17AM -0500, Xiaoyao Li wrote:
> > > Invoke KVM_TDX_INIT in kvm_arch_pre_create_vcpu() that KVM_TDX_INIT
> > > configures global TD configurations, e.g. the canonical CPUID config,
> > > and must be executed prior to creating vCPUs.
> > > 
> > > Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
> > > 
> > > Note, this doesn't address the fact that QEMU may change the CPUID
> > > configuration when creating vCPUs, i.e. punts on refactoring QEMU to
> > > provide a stable CPUID config prior to kvm_arch_init().
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > ---
> > > Changes in v6:
> > > - setup xfam explicitly to fit with new uapi;
> > > - use tdx_caps->cpuid to filter the input of cpuids because now KVM only
> > >    allows the leafs that reported via KVM_TDX_GET_CAPABILITIES;
> > > 
> > > Changes in v4:
> > > - mark init_vm with g_autofree() and use QEMU_LOCK_GUARD() to eliminate
> > >    the goto labels; (Daniel)
> > > Changes in v3:
> > > - Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
> > > ---
> > >   accel/kvm/kvm-all.c         |  8 ++++
> > >   target/i386/kvm/kvm.c       | 15 +++++--
> > >   target/i386/kvm/kvm_i386.h  |  3 ++
> > >   target/i386/kvm/meson.build |  2 +-
> > >   target/i386/kvm/tdx-stub.c  |  8 ++++
> > >   target/i386/kvm/tdx.c       | 87 +++++++++++++++++++++++++++++++++++++
> > >   target/i386/kvm/tdx.h       |  6 +++
> > >   7 files changed, 125 insertions(+), 4 deletions(-)
> > >   create mode 100644 target/i386/kvm/tdx-stub.c

> > > +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
> > > +{
> > > +    X86CPU *x86cpu = X86_CPU(cpu);
> > > +    CPUX86State *env = &x86cpu->env;
> > > +    g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
> > > +    int r = 0;
> > > +
> > > +    QEMU_LOCK_GUARD(&tdx_guest->lock);
> > > +    if (tdx_guest->initialized) {
> > > +        return r;
> > > +    }
> > > +
> > > +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
> > > +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> > > +
> > > +    r = setup_td_xfam(x86cpu, errp);
> > > +    if (r) {
> > > +        return r;
> > > +    }
> > > +
> > > +    init_vm->cpuid.nent = kvm_x86_build_cpuid(env, init_vm->cpuid.entries, 0);
> > > +    tdx_filter_cpuid(&init_vm->cpuid);
> > > +
> > > +    init_vm->attributes = tdx_guest->attributes;
> > > +    init_vm->xfam = tdx_guest->xfam;
> > > +
> > > +    do {
> > > +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
> > > +    } while (r == -EAGAIN);
> > 
> > Other calls to tdx_vm_ioctl don't loop on EAGAIN. Is the need to
> > do this retry specific to only KVM_TDX_INIT_VM, or should we push
> > the EAGAIN retry logic inside tdx_vm_ioctl_helper so all callers
> > benefit ?
> 
> So far, only KVM_TDX_INIT_VM can get -EAGAIN due to KVM side TDH_MNG_CREATE
> gets TDX_RND_NO_ENTROPY because Random number generation (e.g., RDRAND or
> RDSEED) failed and in this case it should retry.

Ok, no problem.

> I think adding a commment to explain why it can get -EAGAIN and needs to
> retry should suffice?

Sure, a comment is useful.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



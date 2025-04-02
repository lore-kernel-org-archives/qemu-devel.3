Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D254C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzzUa-0001ik-1i; Wed, 02 Apr 2025 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzzUY-0001iR-OF
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzzUW-00013j-I4
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743605694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFQFFt3eYGni+Iy/Ebc0glNqyUlJyXnj5Hi35jIZM2Y=;
 b=Ve4qkvkmJgi0oXeJYEdssrAcMmdbmuF8eT6bgcKs2hEP/eCUB18CrL+HWVzDyNEb81YtTj
 mJmvf7HnNkFKQ0291RgBbAraDRAPeTVo3eHBsgYHERtKSD78gvXt/PtquE0A3PlrYt6Wmg
 C4HfR7u9h8hAXE9z00lbhgsHkJZUsU4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-V12LjXPwMK2OYocQQUao6w-1; Wed,
 02 Apr 2025 10:54:49 -0400
X-MC-Unique: V12LjXPwMK2OYocQQUao6w-1
X-Mimecast-MFC-AGG-ID: V12LjXPwMK2OYocQQUao6w_1743605688
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 684701955DCD; Wed,  2 Apr 2025 14:54:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B11221955BC2; Wed,  2 Apr 2025 14:54:45 +0000 (UTC)
Date: Wed, 2 Apr 2025 15:54:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 05/55] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Message-ID: <Z-1PslaL5IL_qjVJ@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-6-xiaoyao.li@intel.com>
 <Z-0YzauBkAl8pyIP@redhat.com>
 <b1586891-6446-474e-8950-8dbc9ac6e607@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1586891-6446-474e-8950-8dbc9ac6e607@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Apr 02, 2025 at 10:52:38PM +0800, Xiaoyao Li wrote:
> On 4/2/2025 7:00 PM, Daniel P. Berrangé wrote:
> > On Tue, Apr 01, 2025 at 09:01:15AM -0400, Xiaoyao Li wrote:
> > > KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
> > > IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
> > > TDX context. It will be used to validate user's setting later.
> > > 
> > > Since there is no interface reporting how many cpuid configs contains in
> > > KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
> > > and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
> > > 
> > > Besides, introduce the interfaces to invoke TDX "ioctls" at VCPU scope
> > > in preparation.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > > Changes in v7:
> > > - refine and unifiy the error handling; (Daniel)
> > > 
> > > Changes in v6:
> > > - Pass CPUState * to tdx_vcpu_ioctl();
> > > - update commit message to remove platform scope thing;
> > > - dump hw_error when it's non-zero to help debug;
> > > 
> > > Changes in v4:
> > > - use {} to initialize struct kvm_tdx_cmd, to avoid memset();
> > > - remove tdx_platform_ioctl() because no user;
> > > 
> > > Changes in v3:
> > > - rename __tdx_ioctl() to tdx_ioctl_internal()
> > > - Pass errp in get_tdx_capabilities();
> > > 
> > > changes in v2:
> > >    - Make the error message more clear;
> > > 
> > > changes in v1:
> > >    - start from nr_cpuid_configs = 6 for the loop;
> > >    - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
> > > ---
> > >   target/i386/kvm/kvm.c      |   2 -
> > >   target/i386/kvm/kvm_i386.h |   2 +
> > >   target/i386/kvm/tdx.c      | 107 ++++++++++++++++++++++++++++++++++++-
> > >   3 files changed, 108 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > index 1af4710556ad..b4fa35405fe1 100644
> > > --- a/target/i386/kvm/kvm.c
> > > +++ b/target/i386/kvm/kvm.c
> > > @@ -1779,8 +1779,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
> > >   static Error *invtsc_mig_blocker;
> > > -#define KVM_MAX_CPUID_ENTRIES  100
> > > -
> > >   static void kvm_init_xsave(CPUX86State *env)
> > >   {
> > >       if (has_xsave2) {
> > > diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> > > index 88565e8dbac1..ed1e61fb8ba9 100644
> > > --- a/target/i386/kvm/kvm_i386.h
> > > +++ b/target/i386/kvm/kvm_i386.h
> > > @@ -13,6 +13,8 @@
> > >   #include "system/kvm.h"
> > > +#define KVM_MAX_CPUID_ENTRIES  100
> > > +
> > >   /* always false if !CONFIG_KVM */
> > >   #define kvm_pit_in_kernel() \
> > >       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
> > > diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> > > index 4ff94860815d..c67be5e618e2 100644
> > > --- a/target/i386/kvm/tdx.c
> > > +++ b/target/i386/kvm/tdx.c
> > > @@ -10,17 +10,122 @@
> > >    */
> > >   #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qapi/error.h"
> > >   #include "qom/object_interfaces.h"
> > >   #include "hw/i386/x86.h"
> > >   #include "kvm_i386.h"
> > >   #include "tdx.h"
> > > +static struct kvm_tdx_capabilities *tdx_caps;
> > > +
> > > +enum tdx_ioctl_level {
> > > +    TDX_VM_IOCTL,
> > > +    TDX_VCPU_IOCTL,
> > > +};
> > > +
> > > +static int tdx_ioctl_internal(enum tdx_ioctl_level level, void *state,
> > > +                              int cmd_id, __u32 flags, void *data,
> > > +                              Error **errp)
> > > +{
> > > +    struct kvm_tdx_cmd tdx_cmd = {};
> > > +    int r;
> > > +
> > > +    const char *tdx_ioctl_name[] = {
> > > +        [KVM_TDX_CAPABILITIES] = "KVM_TDX_CAPABILITIES",
> > > +        [KVM_TDX_INIT_VM] = "KVM_TDX_INIT_VM",
> > > +        [KVM_TDX_INIT_VCPU] = "KVM_TDX_INIT_VCPU",
> > > +        [KVM_TDX_INIT_MEM_REGION] = "KVM_TDX_INIT_MEM_REGION",
> > > +        [KVM_TDX_FINALIZE_VM] = "KVM_TDX_FINALIZE_VM",
> > > +        [KVM_TDX_GET_CPUID] = "KVM_TDX_GET_CPUID",
> > > +    };
> > > +
> > > +    tdx_cmd.id = cmd_id;
> > > +    tdx_cmd.flags = flags;
> > > +    tdx_cmd.data = (__u64)(unsigned long)data;
> > > +
> > > +    switch (level) {
> > > +    case TDX_VM_IOCTL:
> > > +        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> > > +        break;
> > > +    case TDX_VCPU_IOCTL:
> > > +        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> > > +        break;
> > > +    default:
> > > +        error_setg(errp, "Invalid tdx_ioctl_level %d", level);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    if (r < 0) {
> > > +        error_setg_errno(errp, -r, "TDX ioctl %s failed, hw_errors: 0x%llx",
> > > +                         tdx_ioctl_name[cmd_id], tdx_cmd.hw_error);
> > > +    }
> > > +    return r;
> > > +}
> > > +
> > > +static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data,
> > > +                               Error **errp)
> > > +{
> > > +    return tdx_ioctl_internal(TDX_VM_IOCTL, NULL, cmd_id, flags, data, errp);
> > > +}
> > > +
> > > +static inline int tdx_vcpu_ioctl(CPUState *cpu, int cmd_id, __u32 flags,
> > > +                                 void *data, Error **errp)
> > > +{
> > > +    return  tdx_ioctl_internal(TDX_VCPU_IOCTL, cpu, cmd_id, flags, data, errp);
> > > +}
> > > +
> > > +static int get_tdx_capabilities(Error **errp)
> > > +{
> > > +    struct kvm_tdx_capabilities *caps;
> > > +    /* 1st generation of TDX reports 6 cpuid configs */
> > > +    int nr_cpuid_configs = 6;
> > > +    size_t size;
> > > +    int r;
> > > +
> > > +    do {
> > > +        Error *local_err = NULL;
> > > +        size = sizeof(struct kvm_tdx_capabilities) +
> > > +                      nr_cpuid_configs * sizeof(struct kvm_cpuid_entry2);
> > > +        caps = g_malloc0(size);
> > > +        caps->cpuid.nent = nr_cpuid_configs;
> > > +
> > > +        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps, &local_err);
> > > +        if (r == -E2BIG) {
> > > +            g_free(caps);
> > > +            nr_cpuid_configs *= 2;
> > > +            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
> > > +                error_report("KVM TDX seems broken that number of CPUID entries"
> > > +                             " in kvm_tdx_capabilities exceeds limit: %d",
> > > +                             KVM_MAX_CPUID_ENTRIES);
> > > +                error_propagate(errp, local_err);
> > > +                return r;
> > > +            }
> > > +            error_free(local_err);
> > 
> > IIRC, you'll need  'local_err = NULL' here, otherwise next time around
> > the loop 'local_err' will be pointing to a free'd error object which
> > 'error_setg' will think is still valid & won't overwrite.
> 
> it's set to NULL at the beginning of the do loop.

Oh yes, i missed that, your code is fine as is then.

> (It looks I need to declare Error *local_err outside the do loop.)

Nah, it is fine within the loop given nothing outside needs it.

> 
> > > +        } else if (r < 0) {
> > > +            g_free(caps);
> > > +            error_propagate(errp, local_err);
> > > +            return r;
> > > +        }
> > > +    } while (r == -E2BIG);
> > > +
> > > +    tdx_caps = caps;
> > > +
> > > +    return 0;
> > > +}
> > > +
> > 
> > 
> > With regards,
> > Daniel
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



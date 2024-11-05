Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B99D12678
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Gpt-0006PP-Pe; Tue, 05 Nov 2024 05:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8Gpm-0006P3-UD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8Gpg-0002Ka-65
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730802633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=omLt+paAOaPZrPQNaMMM2fwM/w25+sBkNVQx6IwIEuA=;
 b=WyN2IGouZPcL0NkMHjN0556bsoAm6eTzFzQf1+QZLmGoPj0KBnVqCk4oyYs7G9pA7jGOvm
 TCQF440ParKKP78j6Cn3EtEhHVYQpJn/4mROqg5lvVjTnu4D8R63xDCEBiZF366komdbLt
 YmnmT7EsWc/NeZNPNqcJuNddjFv6jtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-d7orJl4AO5ue1Z39z7GPpw-1; Tue,
 05 Nov 2024 05:30:30 -0500
X-MC-Unique: d7orJl4AO5ue1Z39z7GPpw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F8921955F41; Tue,  5 Nov 2024 10:30:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B85C230001A3; Tue,  5 Nov 2024 10:30:20 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:30:17 +0000
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
Subject: Re: [PATCH v6 05/60] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Message-ID: <ZynzuSIWG7jRNBfE@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-6-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-6-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Nov 05, 2024 at 01:23:13AM -0500, Xiaoyao Li wrote:
> KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
> IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
> TDX context. It will be used to validate user's setting later.
> 
> Since there is no interface reporting how many cpuid configs contains in
> KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
> and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
> 
> Besides, introduce the interfaces to invoke TDX "ioctls" at VCPU scope
> in preparation.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
> - Pass CPUState * to tdx_vcpu_ioctl();
> - update commit message to remove platform scope thing;
> - dump hw_error when it's non-zero to help debug;
> 
> Changes in v4:
> - use {} to initialize struct kvm_tdx_cmd, to avoid memset();
> - remove tdx_platform_ioctl() because no user;
> 
> Changes in v3:
> - rename __tdx_ioctl() to tdx_ioctl_internal()
> - Pass errp in get_tdx_capabilities();
> 
> changes in v2:
>   - Make the error message more clear;
> 
> changes in v1:
>   - start from nr_cpuid_configs = 6 for the loop;
>   - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
> ---
>  target/i386/kvm/kvm.c      |  2 -
>  target/i386/kvm/kvm_i386.h |  2 +
>  target/i386/kvm/tdx.c      | 93 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2bbac603da70..b843de7f2379 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1782,8 +1782,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  
>  static Error *invtsc_mig_blocker;
>  
> -#define KVM_MAX_CPUID_ENTRIES  100
> -
>  static void kvm_init_xsave(CPUX86State *env)
>  {
>      if (has_xsave2) {
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 9de9c0d30388..7ac4c3a91171 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -13,6 +13,8 @@
>  
>  #include "sysemu/kvm.h"
>  
> +#define KVM_MAX_CPUID_ENTRIES  100
> +
>  #ifdef CONFIG_KVM
>  
>  #define kvm_pit_in_kernel() \
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 85f006c1d6b4..907044910fec 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -12,17 +12,108 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "qom/object_interfaces.h"
>  
>  #include "hw/i386/x86.h"
>  #include "kvm_i386.h"
>  #include "tdx.h"
>  
> +static struct kvm_tdx_capabilities *tdx_caps;
> +
> +enum tdx_ioctl_level {
> +    TDX_VM_IOCTL,
> +    TDX_VCPU_IOCTL,
> +};
> +
> +static int tdx_ioctl_internal(enum tdx_ioctl_level level, void *state,
> +                              int cmd_id, __u32 flags, void *data)
> +{
> +    struct kvm_tdx_cmd tdx_cmd = {};
> +    int r;
> +
> +    tdx_cmd.id = cmd_id;
> +    tdx_cmd.flags = flags;
> +    tdx_cmd.data = (__u64)(unsigned long)data;
> +
> +    switch (level) {
> +    case TDX_VM_IOCTL:
> +        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +        break;
> +    case TDX_VCPU_IOCTL:
> +        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +        break;
> +    default:
> +        error_report("Invalid tdx_ioctl_level %d", level);
> +        exit(1);
> +    }
> +
> +    if (r && tdx_cmd.hw_error) {
> +        error_report("TDX ioctl %d return with %d, hw_errors: 0x%llx",
> +                     cmd_id, r, tdx_cmd.hw_error);
> +    }
> +    return r;
> +}

I feel like the error handling of this method is rather inconsistent.
In one place we error_report() and then exit(), in another place
we error_report() but return, and in another place we report nothing
at all. When we return, the caller propagates an Error **errp object,
but this propagated message lacks the potentially useful 'hw_errors'
info.

IMHO this method ought to have an 'Error **errp' parameter and always
fill it & propagate. Let the caller decide whether to exit or not.

If you continue returning 'r', then the caller can still handle
E2BIG, discarding the 'Error' object in that case.


> +
> +static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data)
> +{
> +    return tdx_ioctl_internal(TDX_VM_IOCTL, NULL, cmd_id, flags, data);
> +}
> +
> +static inline int tdx_vcpu_ioctl(CPUState *cpu, int cmd_id, __u32 flags,
> +                                 void *data)
> +{
> +    return  tdx_ioctl_internal(TDX_VCPU_IOCTL, cpu, cmd_id, flags, data);
> +}
> +
> +static int get_tdx_capabilities(Error **errp)
> +{
> +    struct kvm_tdx_capabilities *caps;
> +    /* 1st generation of TDX reports 6 cpuid configs */
> +    int nr_cpuid_configs = 6;
> +    size_t size;
> +    int r;
> +
> +    do {
> +        size = sizeof(struct kvm_tdx_capabilities) +
> +                      nr_cpuid_configs * sizeof(struct kvm_cpuid_entry2);
> +        caps = g_malloc0(size);
> +        caps->cpuid.nent = nr_cpuid_configs;
> +
> +        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps);
> +        if (r == -E2BIG) {
> +            g_free(caps);
> +            nr_cpuid_configs *= 2;
> +            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
> +                error_setg(errp, "%s: KVM TDX seems broken that number of CPUID"
> +                           " entries in kvm_tdx_capabilities exceeds limit %d",
> +                           __func__, KVM_MAX_CPUID_ENTRIES);
> +                return r;
> +            }
> +        } else if (r < 0) {
> +            g_free(caps);
> +            error_setg_errno(errp, -r, "%s: KVM_TDX_CAPABILITIES failed", __func__);
> +            return r;
> +        }
> +    } while (r == -E2BIG);
> +
> +    tdx_caps = caps;
> +
> +    return 0;
> +}
> +
>  static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
> +    int r = 0;
> +
>      kvm_mark_guest_state_protected();
>  
> -    return 0;
> +    if (!tdx_caps) {
> +        r = get_tdx_capabilities(errp);
> +    }
> +
> +    return r;
>  }
>  
>  static int tdx_kvm_type(X86ConfidentialGuest *cg)
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



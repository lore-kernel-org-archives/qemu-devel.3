Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CCFC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 11:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwZp-0004Cq-Jo; Wed, 02 Apr 2025 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwZj-00049A-U7
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwZi-0006gW-1Q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743594485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=o2NGpTrDic/uWhYLB7QuDilseWBH9MdkTNlNRhRsO5A=;
 b=iz+t3UIj55lmxQwx88QNTvAfJB4dM228kSnYhTrh8R337uuNJPJORJO0QX0xtHvo3k3S0s
 8+JkzBvL7ko8YzIVcfolxrV7Hif2TAnLPkTuX5jSQixjRTCzvRXct1rBLKuKny/yCEaa6U
 /KBqek6FaD4Ka7Sg2R1ZZrrrDfIzdxE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-kWcTSLBKOaenXE5RUMq0qQ-1; Wed,
 02 Apr 2025 07:48:02 -0400
X-MC-Unique: kWcTSLBKOaenXE5RUMq0qQ-1
X-Mimecast-MFC-AGG-ID: kWcTSLBKOaenXE5RUMq0qQ_1743594481
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D35F1800EC5; Wed,  2 Apr 2025 11:48:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 069E13001D0E; Wed,  2 Apr 2025 11:47:57 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:47:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 12/55] i386/tdx: Validate TD attributes
Message-ID: <Z-0j6nfevxiCJ_ud@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-13-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-13-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Apr 01, 2025 at 09:01:22AM -0400, Xiaoyao Li wrote:
> Validate TD attributes with tdx_caps that only supported bits are
> allowed by KVM.
> 
> Besides, sanity check the attribute bits that have not been supported by
> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> TD support lands in QEMU.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v8:
> - Split the mrconfigid/mrowner/mrownerconfig part into a seperate next
>   patch;
> 
> Changes in v7:
> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>   user's request. (Rick)
> 
> Changes in v3:
> - using error_setg() for error report; (Daniel)
> ---
>  target/i386/kvm/tdx.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 1202b2111ba8..aa043acb1a88 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -18,10 +18,15 @@
>  #include "kvm_i386.h"
>  #include "tdx.h"
>  
> +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>  #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>  #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
>  #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
>  
> +#define TDX_SUPPORTED_TD_ATTRS  (TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE |\
> +                                 TDX_TD_ATTRIBUTES_PKS | \
> +                                 TDX_TD_ATTRIBUTES_PERFMON)
> +
>  static TdxGuest *tdx_guest;
>  
>  static struct kvm_tdx_capabilities *tdx_caps;
> @@ -153,13 +158,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
>      return KVM_X86_TDX_VM;
>  }
>  
> -static void setup_td_guest_attributes(X86CPU *x86cpu)
> +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
> +{
> +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
> +        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
> +                   "(KVM supported: 0x%llx)", tdx->attributes,
> +                   tdx_caps->supported_attrs);
> +        return -1;
> +    }
> +
> +    if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
> +        warn_report("Some QEMU unsupported TD attribute bits being requested:"
> +                    "requested: 0x%lx QEMU supported: 0x%llx",
> +                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);

IIUC, this is an explicit user mis-configuration, and so we
ought to use  error_setg & return -1, not merely a warning.

> +    }
> +
> +    return 0;
> +}
> +
> +static int setup_td_guest_attributes(X86CPU *x86cpu, Error **errp)
>  {
>      CPUX86State *env = &x86cpu->env;
>  
>      tdx_guest->attributes |= (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS) ?
>                               TDX_TD_ATTRIBUTES_PKS : 0;
>      tdx_guest->attributes |= x86cpu->enable_pmu ? TDX_TD_ATTRIBUTES_PERFMON : 0;
> +
> +    return tdx_validate_attributes(tdx_guest, errp);
>  }
>  
>  static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
> @@ -225,7 +250,10 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>                          sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>  
> -    setup_td_guest_attributes(x86cpu);
> +    r = setup_td_guest_attributes(x86cpu, errp);
> +    if (r) {
> +        return r;
> +    }
>  
>      r = setup_td_xfam(x86cpu, errp);
>      if (r) {
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



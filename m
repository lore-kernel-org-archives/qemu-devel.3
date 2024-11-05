Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D8DD1267D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Gxa-00017s-6J; Tue, 05 Nov 2024 05:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8GxX-00017J-Vs
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8GxU-0002t1-OB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730803127;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sK/6DimcM6s/4CQKE4lNadkNqe4oszzONtph8blZGq0=;
 b=P+m/F455SH0+1EG2A562c3ZpG93Y7KLpkYl28AKhpcb5ur2tYCPv+Fi2MH2hXvptg4REs0
 bL36PUCcNnbyhYJ6/SEKffaBxuIhy7niLj7Xrltn3bUFPd8q0fW+UfjRqSNHxJfPqCCePL
 FnMgZNxP4KhtwDE4FlvisFgYQoLJW9U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-2919mB85NKGfOIKEA8-5HA-1; Tue,
 05 Nov 2024 05:38:45 -0500
X-MC-Unique: 2919mB85NKGfOIKEA8-5HA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 730E019560A5; Tue,  5 Nov 2024 10:38:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E60B519560A3; Tue,  5 Nov 2024 10:38:36 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:38:33 +0000
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
Subject: Re: [PATCH v6 14/60] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Message-ID: <Zyn1qW36aJeIGqbC@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-15-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-15-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Tue, Nov 05, 2024 at 01:23:22AM -0500, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
> can be provided for TDX attestation. Detailed meaning of them can be
> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
> 
> Allow user to specify those values via property mrconfigid, mrowner and
> mrownerconfig. They are all in base64 format.
> 
> example
> -object tdx-guest, \
>   mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>   mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>   mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - refine the doc comment of QAPI properties;
> 
> Changes in v5:
>  - refine the description of QAPI properties and add description of
>    default value when not specified;
> 
> Changes in v4:
>  - describe more of there fields in qom.json
>  - free the old value before set new value to avoid memory leak in
>    _setter(); (Daniel)
> 
> Changes in v3:
>  - use base64 encoding instread of hex-string;
> ---
>  qapi/qom.json         | 16 +++++++-
>  target/i386/kvm/tdx.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h |  3 ++
>  3 files changed, 104 insertions(+), 1 deletion(-)

> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 5a9ce2ada89d..887a5324b439 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -13,6 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/base64.h"
>  #include "qapi/error.h"
>  #include "qom/object_interfaces.h"
>  
> @@ -222,6 +223,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      X86CPU *x86cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86cpu->env;
>      g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
> +    size_t data_len;
>      int r = 0;
>  
>      QEMU_LOCK_GUARD(&tdx_guest->lock);
> @@ -232,6 +234,37 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>                          sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>  
> +#define SHA384_DIGEST_SIZE  48

Don't define this - as of fairly recently, we now have
QCRYPTO_HASH_DIGEST_LEN_SHA384 in QEMU's "crypto/hash.h"
header.

> +    if (tdx_guest->mrconfigid) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
> +            error_setg(errp, "TDX: failed to decode mrconfigid");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrconfigid, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrowner) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
> +                              strlen(tdx_guest->mrowner), &data_len, errp);
> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
> +            error_setg(errp, "TDX: failed to decode mrowner");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrowner, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrownerconfig) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
> +                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
> +            error_setg(errp, "TDX: failed to decode mrownerconfig");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrownerconfig, data, data_len);
> +    }
> +
>      r = setup_td_guest_attributes(x86cpu, errp);
>      if (r) {
>          return r;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



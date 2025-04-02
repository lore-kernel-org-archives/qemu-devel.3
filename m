Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E7C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 11:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwdU-00079X-L4; Wed, 02 Apr 2025 07:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwdP-00078n-Ms
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwdN-0008Dt-Sk
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743594713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fW0KRKQsEvznJMKh92RToEvOS1OUhgzRnHy+Bp8akFA=;
 b=VI898A0YG1D6JKohO1ERPpJDxIXggjpc4gyRNSnm7FNUfkqpDnGfqy4qR21oU8/dFowC1M
 Wx5BiUp13S3ZzHUMGKK7F3O9fh+D9IIKngbPuxdp4u61l3J13WIXjaust3cVpWDopzFiUj
 ReDG+tTOTYbNCT9XH96UHXTHxn/ZcTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ogOmvLDnO_eA2OvaYWZudw-1; Wed,
 02 Apr 2025 07:51:50 -0400
X-MC-Unique: ogOmvLDnO_eA2OvaYWZudw-1
X-Mimecast-MFC-AGG-ID: ogOmvLDnO_eA2OvaYWZudw_1743594709
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A94180049D; Wed,  2 Apr 2025 11:51:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC9FA3001D0E; Wed,  2 Apr 2025 11:51:45 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:51:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Message-ID: <Z-0kzoSrlkohaA8A@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-14-xiaoyao.li@intel.com>
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

On Tue, Apr 01, 2025 at 09:01:23AM -0400, Xiaoyao Li wrote:
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
> Changes in v8:
>  - it gets squashed into previous patch in v7. So split it out in v8;
> 
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
> index aa043acb1a88..77ddb2655c53 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -11,8 +11,10 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/base64.h"
>  #include "qapi/error.h"
>  #include "qom/object_interfaces.h"
> +#include "crypto/hash.h"
>  
>  #include "hw/i386/x86.h"
>  #include "kvm_i386.h"
> @@ -239,6 +241,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      CPUX86State *env = &x86cpu->env;
>      g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>      Error *local_err = NULL;
> +    size_t data_len;
>      int retry = 10000;
>      int r = 0;
>  
> @@ -250,6 +253,36 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>      init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>                          sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>  
> +    if (tdx_guest->mrconfigid) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrconfigid");
> +            return -1;
> +        }

When '!data',  qbase64_decode will have already filled 'errp' with
details, so we must immediately 'return -1', as a repeated error_setg
call is an programming error.

The error_setg call should only be done in response to failing
the 'data_len' check and the message should specify the lengths
eg more like this

  if (!data) {
      return -1;
  }

  if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
      error_setg(errp, "TDX mrconfigid len %d must match SHA384 digest len %d",
                 data_len, QCRYPTO_HASH_DIGEST_LEN_SHA384)
      return -1;
  }


> +        memcpy(init_vm->mrconfigid, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrowner) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
> +                              strlen(tdx_guest->mrowner), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> +            error_setg(errp, "TDX: failed to decode mrowner");
> +            return -1;
> +        }
> +        memcpy(init_vm->mrowner, data, data_len);
> +    }
> +
> +    if (tdx_guest->mrownerconfig) {
> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
> +                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
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



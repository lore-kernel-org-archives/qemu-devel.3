Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C14C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvY2-0001hY-56; Wed, 02 Apr 2025 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzvXz-0001h7-0U
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzvXt-0001wJ-Ai
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743590527;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kB4I3IHrM1XtSFECX3Ur/T7LJyYAkOCONioTfvcclAQ=;
 b=Xd4IKmHzmv9WwP3AZ64ty2Af7y8QhmFbq7LN8syLz6NsXvT5KltVd1ESy4hQkkjCWdwex2
 M1MlhUSufsxRop/ID54eYi+R7QE4Go3vw+otrRcZkzo0njmShpy4QUjxyq4tSlBDwyGk1O
 1ce7W/kmd53kQLp6ymwR4wtPHjpzLsM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-XzDHl0K0O0ipqyc9ch8qPg-1; Wed,
 02 Apr 2025 06:42:03 -0400
X-MC-Unique: XzDHl0K0O0ipqyc9ch8qPg-1
X-Mimecast-MFC-AGG-ID: XzDHl0K0O0ipqyc9ch8qPg_1743590522
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D16C18001E0; Wed,  2 Apr 2025 10:42:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E1991956094; Wed,  2 Apr 2025 10:41:59 +0000 (UTC)
Date: Wed, 2 Apr 2025 11:41:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 38/55] i386/tdx: Set and check kernel_irqchip mode for
 TDX
Message-ID: <Z-0UdHfoXN-wIEnV@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-39-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401130205.2198253-39-xiaoyao.li@intel.com>
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

On Tue, Apr 01, 2025 at 09:01:48AM -0400, Xiaoyao Li wrote:
> KVM mandates kernel_irqchip to be split mode.
> 
> Set it to split mode automatically when users don't provide an explicit
> value, otherwise check it to be the split mode.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 0d30506c2021..4128f27d6b64 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -16,6 +16,7 @@
>  #include "qapi/error.h"
>  #include "qom/object_interfaces.h"
>  #include "crypto/hash.h"
> +#include "system/kvm_int.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "exec/ramblock.h"
> @@ -390,6 +391,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          return -EINVAL;
>      }
>  
> +    if (kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO ) {

Nitpick, no need for a space before the ')' ...

> +        kvm_state->kernel_irqchip_split = ON_OFF_AUTO_ON;
> +    } else if(kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {

..and need a space between 'if' and '('

> +        error_setg(errp, "TDX VM requires kernel_irqchip to be split");
> +        return -EINVAL;
> +    }
> +

Note for self - 'tdx_kvm_init' is called by 'confidential_guest_kvm_init',
which is called by 'kvm_arch_init', which is called by 'kvm_init' *before*
it processes "kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO" to set
the default. So this change is correctly taking priority over the default
behaviour.

>      if (!tdx_caps) {
>          r = get_tdx_capabilities(errp);
>          if (r) {
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



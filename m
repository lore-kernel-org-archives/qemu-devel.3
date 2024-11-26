Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBAED3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 12:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuop-0007T8-Bb; Tue, 26 Nov 2024 07:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFuoi-0007RV-Ef
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFuof-0003jQ-LN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732624635;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXHJH1NFPr5BUMazKPvhlxdfocMk4iwpK5En4hIA2Gs=;
 b=L5SXkmTWGkT0deV8B+1mA8cHp3dmX1FmSFmdZrUWfmDTsi0Iwbjj/yhJS/L5VpQEDKV641
 EAvABqoGXW2w7itOU9Hb8Q0EMOlebmSvmy95K+LaF7ARAn9q4PYgemICpINL5V4Xw57Ol4
 dkJBzmvTBjqQWR+qTiWrbj5TsIWHQqE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17--urY9HtHN7aHLAB5bg19-A-1; Tue,
 26 Nov 2024 07:37:10 -0500
X-MC-Unique: -urY9HtHN7aHLAB5bg19-A-1
X-Mimecast-MFC-AGG-ID: -urY9HtHN7aHLAB5bg19-A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1BF41956088; Tue, 26 Nov 2024 12:37:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A74CF1955F40; Tue, 26 Nov 2024 12:37:05 +0000 (UTC)
Date: Tue, 26 Nov 2024 12:37:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 02/26] target/arm: Add confidential guest support
Message-ID: <Z0XA7tNaD3iFZ8uM@redhat.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125195626.856992-4-jean-philippe@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Nov 25, 2024 at 07:56:01PM +0000, Jean-Philippe Brucker wrote:
> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> support the Arm Realm Management Extension (RME). It is instantiated by
> passing on the command-line:
> 
>   -M virt,confidential-guest-support=<id>
>   -object rme-guest,id=<id>[,options...]
> 
> This is only the skeleton. Support will be added in following patches.
> 
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: remove some boilerplate with OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> ---
>  docs/system/confidential-guest-support.rst |  1 +
>  target/arm/kvm-rme.c                       | 40 ++++++++++++++++++++++
>  target/arm/meson.build                     |  7 +++-
>  3 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/kvm-rme.c
> 
> diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> index 0c490dbda2..acf46d8856 100644
> --- a/docs/system/confidential-guest-support.rst
> +++ b/docs/system/confidential-guest-support.rst
> @@ -40,5 +40,6 @@ Currently supported confidential guest mechanisms are:
>  * AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-memory-encryption`)
>  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
>  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> +* Arm Realm Management Extension (RME)
>  
>  Other mechanisms may be supported in future.
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> new file mode 100644
> index 0000000000..67909349c1
> --- /dev/null
> +++ b/target/arm/kvm-rme.c
> @@ -0,0 +1,40 @@
> +/*
> + * QEMU Arm RME support
> + *
> + * Copyright Linaro 2024
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "exec/confidential-guest-support.h"
> +#include "hw/boards.h"
> +#include "hw/core/cpu.h"
> +#include "kvm_arm.h"
> +#include "migration/blocker.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/runstate.h"
> +
> +#define TYPE_RME_GUEST "rme-guest"
> +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> +
> +struct RmeGuest {
> +    ConfidentialGuestSupport parent_obj;
> +};
> +
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> +                                          CONFIDENTIAL_GUEST_SUPPORT,
> +                                          { TYPE_USER_CREATABLE }, { })
> +
> +static void rme_guest_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +static void rme_guest_init(Object *obj)
> +{
> +}
> +
> +static void rme_guest_finalize(Object *obj)
> +{
> +}

When you create a new "user creatable" object, there should also be a
corresponding addition to qapi/qom.json.

I believe you have the qom.json addition in a later patch, but it
should actually be here 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



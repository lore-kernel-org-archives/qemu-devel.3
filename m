Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF08FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMDW-0000hW-4o; Tue, 06 Feb 2024 09:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXMDV-0000hI-5V
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXMDS-00015o-Rr
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707228864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6SqQywtqFY0K3ZJqSuB6+0q234mp3ZxEleeqsCm76+c=;
 b=YlLy7zEQnwKbPcjdT6B5XsGIp2eeAUV5r/YAKGk6uoAxdr5WH3tYYQSzPpfeCxIG4GkTfW
 GP2mkqojI7Ns8sTwCNAOb+G0tpYut/O01uKer23++U0mDLt+7GMN2bvSTG1cf7ODrg1Gbb
 wScnqMZImX+32STH4t3NYzodbozAlKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-c4uSsh_wMKW-ULvjPLBb-g-1; Tue, 06 Feb 2024 09:14:19 -0500
X-MC-Unique: c4uSsh_wMKW-ULvjPLBb-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D0AE848528;
 Tue,  6 Feb 2024 14:14:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51380492BF0;
 Tue,  6 Feb 2024 14:14:16 +0000 (UTC)
Date: Tue, 6 Feb 2024 14:14:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 1/4] confidential guest support: Add kvm_init() and
 kvm_reset() in class
Message-ID: <ZcI-tqhgJA06g4UQ@redhat.com>
References: <20240206082852.3333299-1-xiaoyao.li@intel.com>
 <20240206082852.3333299-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206082852.3333299-2-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 03:28:49AM -0500, Xiaoyao Li wrote:
> Different confidential VMs in different architectures all have the same
> needs to do their specific initialization (and maybe resetting) stuffs
> with KVM. Currently each of them exposes individual *_kvm_init()
> functions and let machine code or kvm code to call it.
> 
> To make it more object oriented, add two virtual functions, kvm_init()
> and kvm_reset() in ConfidentialGuestSupportClass, and expose two helpers
> functions for invodking them.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  include/exec/confidential-guest-support.h | 42 ++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index ba2dd4b5dfc4..ff0bfb26ad7a 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -23,7 +23,10 @@
>  #include "qom/object.h"
>  
>  #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
> -OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
> +OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
> +                    ConfidentialGuestSupportClass,
> +                    CONFIDENTIAL_GUEST_SUPPORT)
> +
>  
>  struct ConfidentialGuestSupport {
>      Object parent;
> @@ -55,8 +58,45 @@ struct ConfidentialGuestSupport {
>  
>  typedef struct ConfidentialGuestSupportClass {
>      ObjectClass parent;
> +
> +    int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
> +    int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
>  } ConfidentialGuestSupportClass;
>  
> +static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
> +                                              Error **errp)
> +{
> +    ConfidentialGuestSupportClass *klass;
> +
> +    if (!cgs) {
> +        return 0;
> +    }

Typically I would expect any class/object methods to mandate a non-NULL
class/instance pointer.

IOW, the caller would generally be expected to check NULL and not
call this method in that case.

> +
> +    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
> +    if (klass->kvm_init) {
> +        return klass->kvm_init(cgs, errp);
> +    }
> +
> +    return 0;
> +}
> +
> +static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
> +                                               Error **errp)
> +{
> +    ConfidentialGuestSupportClass *klass;
> +
> +    if (!cgs) {
> +        return 0;
> +    }
> +
> +    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
> +    if (klass->kvm_reset) {
> +        return klass->kvm_reset(cgs, errp);
> +    }
> +
> +    return 0;
> +}
> +
>  #endif /* !CONFIG_USER_ONLY */
>  
>  #endif /* QEMU_CONFIDENTIAL_GUEST_SUPPORT_H */
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



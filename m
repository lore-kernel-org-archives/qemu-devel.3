Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F1C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFG1-0005wb-Mr; Tue, 08 Jul 2025 16:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZDsT-0000jh-QN
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZDsN-0000cp-7j
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1Tm9Hk4YTR+xgkoFzzx4hBrKhYyI1qJZgxCuD/u5pE8=;
 b=eYy///LomE5GYkr3NzA1poY/gCxNZMXzCkhTMQg14zkdj8KcCBlsafmF965D7wdwcV/uEb
 H9R3IctpKUVbOd7Va+Ccr+wNZGzOtTCM6Wq+FH3JSGra+GEbRFT7TNc1BvKgxRqA4NscqF
 tOTmQIUzounouI1c+oDPxqta5OHesE8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-v8xOg2zCOsac6F362uSPKg-1; Tue,
 08 Jul 2025 11:07:43 -0400
X-MC-Unique: v8xOg2zCOsac6F362uSPKg-1
X-Mimecast-MFC-AGG-ID: v8xOg2zCOsac6F362uSPKg_1751987262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EADB18089B7; Tue,  8 Jul 2025 15:07:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E9FB195608F; Tue,  8 Jul 2025 15:07:33 +0000 (UTC)
Date: Tue, 8 Jul 2025 16:07:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 02/16] backends/confidential-guest-support: Add
 functions to support IGVM
Message-ID: <aG00MgIsZdXq9bRy@redhat.com>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
 <23e34a106da87427899f93178102e4a6ef50c966.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23e34a106da87427899f93178102e4a6ef50c966.1751554099.git.roy.hopkins@randomman.co.uk>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 03, 2025 at 04:03:10PM +0100, Roy Hopkins wrote:
> In preparation for supporting the processing of IGVM files to configure
> guests, this adds a set of functions to ConfidentialGuestSupport
> allowing configuration of secure virtual machines that can be
> implemented for each supported isolation platform type such as Intel TDX
> or AMD SEV-SNP. These functions will be called by IGVM processing code
> in subsequent patches.
> 
> This commit provides a default implementation of the functions that
> either perform no action or generate an error when they are called.
> Targets that support ConfidentalGuestSupport should override these
> implementations.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Gerd Hoffman <kraxel@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> ---
>  backends/confidential-guest-support.c       | 31 ++++++++++
>  include/system/confidential-guest-support.h | 67 +++++++++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index 8ff7bfa857..c5bef1fbfa 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -14,15 +14,46 @@
>  #include "qemu/osdep.h"
>  
>  #include "system/confidential-guest-support.h"
> +#include "qapi/error.h"
>  
>  OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                              confidential_guest_support,
>                              CONFIDENTIAL_GUEST_SUPPORT,
>                              OBJECT)
>  
> +static bool check_support(ConfidentialGuestPlatformType platform,
> +                         uint16_t platform_version, uint8_t highest_vtl,
> +                         uint64_t shared_gpa_boundary)

Nit-pick - underindented by 1 space.


> diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
> index ea46b50c56..79ecd21f42 100644
> --- a/include/system/confidential-guest-support.h
> +++ b/include/system/confidential-guest-support.h


> @@ -64,6 +95,42 @@ typedef struct ConfidentialGuestSupportClass {
>  
>      int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
>      int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
> +
> +    /*
> +     * Check to see if this confidential guest supports a particular
> +     * platform or configuration.
> +     *
> +     * Return true if supported or false if not supported.
> +     */
> +    bool (*check_support)(ConfidentialGuestPlatformType platform,
> +                         uint16_t platform_version, uint8_t highest_vtl,
> +                         uint64_t shared_gpa_boundary);

Nit-pick: underindented 1 space.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



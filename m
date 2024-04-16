Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C985C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjfW-000850-1U; Tue, 16 Apr 2024 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjfS-00084i-V1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjfR-0006aQ-5E
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713277210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iTIBHNgayvDV32/qJdvJyCzisR8vMk9FI3nNdRz063U=;
 b=QbwewN9Vyg3VRDtuFGXQg2RCe4MoEeip7mzLpVi4pOCDFS2HgQZhgQD0N/9Mm9hWF28m/F
 aNx42MpgDH+topiK9Z1XVW8y7e7vBMnQPbvyX48Tp08NY0+na+2pMwYJ8F4PkS6zl52xcy
 12YpStV0JOueKSfIWsbASwLf1OaPfk4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-p434WneHMdifZq6oydck5g-1; Tue,
 16 Apr 2024 10:20:09 -0400
X-MC-Unique: p434WneHMdifZq6oydck5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C97851C031A5;
 Tue, 16 Apr 2024 14:20:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2A8C2166B32;
 Tue, 16 Apr 2024 14:20:05 +0000 (UTC)
Date: Tue, 16 Apr 2024 15:19:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
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
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 05/10] i386/pc: Process IGVM file during PC
 initialization if present
Message-ID: <Zh6JD28dTfO-oEb2@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <32b59ca0922721f1588f497b6604f064132b62e9.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32b59ca0922721f1588f497b6604f064132b62e9.1712141833.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 03, 2024 at 12:11:36PM +0100, Roy Hopkins wrote:
> An IGVM file contains configuration of a guest that supports
> confidential computing hardware. As part of the PC system
> initialisation, the IGVM needs to be processed to apply this
> configuration before the guest is started.
> 
> This patch introduces processing of a provided IGVM file at the end of
> the current PC initialization steps. If an IGVM file has been provided
> then the directives in the file are processed completing the
> initialization of the target.
> 
> If no IGVM file has been specified by the user then no there is no
> intended consequences in these changes.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  backends/confidential-guest-support.c     | 18 ++++++++++++++++++
>  hw/i386/pc_piix.c                         |  4 ++++
>  hw/i386/pc_q35.c                          |  4 ++++
>  include/exec/confidential-guest-support.h | 17 +++++++++++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index adfe447334..79c0f3fc56 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -88,3 +88,21 @@ static void confidential_guest_support_init(Object *obj)
>  static void confidential_guest_support_finalize(Object *obj)
>  {
>  }
> +
> +bool cgs_is_igvm(ConfidentialGuestSupport *cgs)
> +{
> +#if defined(CONFIG_IGVM)
> +    return cgs && cgs->igvm;
> +#else
> +    return false;
> +#endif
> +}
> +
> +void cgs_process_igvm(ConfidentialGuestSupport *cgs)
> +{
> +#if defined(CONFIG_IGVM)
> +    if (cgs && cgs_is_igvm(cgs)) {

Either remove the 'cgs &&' check which cgs_is_igvm already
does, or fully inline 'cgs_is_igvm'.

> +        igvm_process(cgs, &error_fatal);
> +    }
> +#endif
> +}


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



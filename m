Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED01DD6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4K9-0005Kh-DW; Thu, 21 Nov 2024 05:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4K7-0005KU-Fz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4K4-0002TJ-OW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732184523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XaycezCz2rBOur+KyWEmyt37RPzEtdFKrQfYQPbOyFw=;
 b=XuZlRG7baSKGk5c2hButf5125vKBqCXw29MGGSbwXg7kkxb/MEREEGndLBdOA6DbjAm0sO
 saVfuo0gPVz7ZXyAIxD7TjXD+PmR49JIbl4GSj/bZM/1y3eoSFFzd5tBISO0TJaPY3tDxo
 CA4YliLS/UW9ce3OVmQPQCLxwlrwsdg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-WKgQWEevMLqifuvcIw1oFg-1; Thu,
 21 Nov 2024 05:21:59 -0500
X-MC-Unique: WKgQWEevMLqifuvcIw1oFg-1
X-Mimecast-MFC-AGG-ID: WKgQWEevMLqifuvcIw1oFg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DA4619560AF; Thu, 21 Nov 2024 10:21:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D90619560A3; Thu, 21 Nov 2024 10:21:52 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:21:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 08/12] qdev: Make qdev_get_machine() not use
 container_get()
Message-ID: <Zz8JvAxXHqa3wfHv@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120215703.3918445-9-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 20, 2024 at 04:56:59PM -0500, Peter Xu wrote:
> Currently, qdev_get_machine() has a slight misuse on container_get(), as
> the helper says "get a container" but in reality the goal is to get the
> machine object.  It is still a "container" but not strictly.
> 
> Note that it _may_ get a container (at "/machine") in our current unit test
> of test-qdev-global-props.c before all these changes, but it's probably
> unexpected and worked by accident.
> 
> Switch to an explicit object_resolve_path_component(), with a side benefit
> that qdev_get_machine() can happen a lot, and we don't need to split the
> string ("/machine") every time.  This also paves way for making the helper
> container_get() never try to return a non-container at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/core/qdev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5f13111b77..c869c47a27 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -817,7 +817,13 @@ Object *qdev_get_machine(void)
>      static Object *dev;
>  
>      if (dev == NULL) {
> -        dev = container_get(object_get_root(), "/machine");
> +        /*
> +         * NOTE: when the machine is not yet created, this helper will
> +         * also keep the cached object untouched and return NULL.  The next
> +         * invoke of the helper will try to look for the machine again.
> +         * It'll only cache the pointer when it's found the first time.
> +         */

This smells like a recipe for subtle bugs. I think I'd consider it a code
flaw if something called qdev_get_machine() in a scenario where the machine
does not yet exist.

> +        dev = object_resolve_path_component(object_get_root(), "machine");
>      }

IOW, I think we should assert that dev != NULL to ensure we immediately
diagnose the flawed sequence of calls.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



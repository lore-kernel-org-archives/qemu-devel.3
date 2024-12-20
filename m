Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB762E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 09:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZ2e-0003bJ-GK; Fri, 20 Dec 2024 04:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOZ2b-0003b5-Hu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOZ2Z-0008BR-Re
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734685882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=r3Qj87n+qCu8bZrwVnSAKMWuo8okMmKbcU2qR+F4yFg=;
 b=TWckIn81y9IBBZ3AKzWg2N5y3YbDkPcwXjCuRb1UiWeOoFs8bQNrJp0Vau8z7tyY1kTrZt
 zdVi+hrm5oV9nHn2/VXK6XeKGtN7G35MQjgHYvUw3eWIZBb/GmlyNpmF9CUYKCf3h3E9xO
 EkF8uu0+GJ/kcuo/1dLHirdxqBkcNrY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-5choLKdTPPaOAll7VFtwfQ-1; Fri,
 20 Dec 2024 04:11:20 -0500
X-MC-Unique: 5choLKdTPPaOAll7VFtwfQ-1
X-Mimecast-MFC-AGG-ID: 5choLKdTPPaOAll7VFtwfQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 947841956096; Fri, 20 Dec 2024 09:11:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 116C019560AD; Fri, 20 Dec 2024 09:11:17 +0000 (UTC)
Date: Fri, 20 Dec 2024 09:11:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 2/2] tests/qtest/migration: Stop checking
 __NR_userfaultfd
Message-ID: <Z2U0sno0hsoAxos6@redhat.com>
References: <20241218192223.10551-1-farosas@suse.de>
 <20241218192223.10551-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218192223.10551-3-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 04:22:23PM -0300, Fabiano Rosas wrote:
> We don't need to check for __NR_userfaultfd in the tests anymore, the
> syscall has been present in Linux for a long time now.

The same is true of the migration/postcopy-ram.c  code too which I
think should be changed at the same time as its tests.

There are a few other places in QEMU also checking __NR_userfaultfd
but not directly under migration subsystem, so change those ones at
your discretion.

> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/migration-util.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index eb3640e27e..23e0163945 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -27,8 +27,8 @@
>  #include <sys/syscall.h>
>  #endif
>  
> -/* for uffd_version_check() */
> -#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> +/* for ufd_version_check() */
> +#if defined(__linux__) && defined(CONFIG_EVENTFD)
>  #include <sys/eventfd.h>
>  #include "qemu/userfaultfd.h"
>  #endif
> @@ -301,7 +301,7 @@ bool probe_o_direct_support(const char *tmpfs)
>  }
>  #endif
>  
> -#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> +#if defined(__linux__) && defined(CONFIG_EVENTFD)
>  bool ufd_version_check(bool *uffd_feature_thread_id)
>  {
>      struct uffdio_api api_struct;
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



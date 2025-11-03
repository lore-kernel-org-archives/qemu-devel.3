Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13644CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1tL-0006dm-KG; Mon, 03 Nov 2025 16:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vG1tJ-0006Xp-7j
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vG1t6-0007OM-Ah
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DNFwLPgHgwG4NrYyq8LDcXqG9jQJFJaLWzM3ZqRqtIE=;
 b=E7tfxPWLkhzQgg9oD15VpboMC+qTZXq1Q0fzpTLFWLXRsnM03ItzYUlHbHRbCAWxGI3+mx
 /jQvfgFpo2DxMckYuMUzJdyuU8y1GOeF3EE4BxPApfPI2UI9g7Cc7aRlaz6F/tILRRdedV
 mlNRzysZx4FB29RtxuvGjOGFPcieXPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-cg-phmOuMr-uKGWhUF1fuw-1; Mon,
 03 Nov 2025 16:14:44 -0500
X-MC-Unique: cg-phmOuMr-uKGWhUF1fuw-1
X-Mimecast-MFC-AGG-ID: cg-phmOuMr-uKGWhUF1fuw_1762204483
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AFC31800451; Mon,  3 Nov 2025 21:14:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D953319540DA; Mon,  3 Nov 2025 21:14:41 +0000 (UTC)
Date: Mon, 3 Nov 2025 21:14:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Message-ID: <aQka0DTrVsJrfU5z@redhat.com>
References: <20251103185750.1394036-1-jon@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103185750.1394036-1-jon@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 11:57:50AM -0700, Jon Kohler wrote:
> Increase MAX_MEM_PREALLOC_THREAD_COUNT from 16 to 32. This was last
> touched in 2017 [1] and, since then, physical machine sizes and VMs
> therein have continue to get even bigger, both on average and on the
> extremes.
> 
> For very large VMs, using 16 threads to preallocate memory can be a
> non-trivial bottleneck during VM start-up and migration. Increasing
> this limit to 32 threads reduces the time taken for these operations.
> 
> Test results from quad socket Intel 8490H (4x 60 cores) show a fairly
> linear gain of 50% with the 2x thread count increase.
> 
> ---------------------------------------------
> Idle Guest w/ 2M HugePages   | Start-up time
> ---------------------------------------------
> 240 vCPU, 7.5TB (16 threads) | 2m41.955s
> ---------------------------------------------
> 240 vCPU, 7.5TB (32 threads) | 1m19.404s
> ---------------------------------------------

If we're configuring a guest with 240 vCPUs, then this implies the admin
is expecting that the guest will consume upto 240 host CPUs worth of
compute time.

What is the purpose of limiting the number of prealloc threads to a
value that is an order of magnitude less than the number of vCPUs the
guest has been given ? 

Have you measured what startup time would look like with 240 prealloc
threads ? Do we hit some scaling limit before that point making more
prealloc threads counter-productive ? 

I guess there could be different impact for hotadd vs cold add. With
cold startup the vCPU threads are not yet consuming CPU time, so we
can reasonably consume that resource for prealloc, where as for
hot-add any prealloc is on top of what vCPUs are already consuming.

> [1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  util/oslib-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 3c14b72665..dc001da66d 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -61,7 +61,7 @@
>  #include "qemu/memalign.h"
>  #include "qemu/mmap-alloc.h"
>  
> -#define MAX_MEM_PREALLOC_THREAD_COUNT 16
> +#define MAX_MEM_PREALLOC_THREAD_COUNT 32
>  
>  struct MemsetThread;
>  
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



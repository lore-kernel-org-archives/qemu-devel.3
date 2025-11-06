Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D383CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2JL-00009v-LP; Thu, 06 Nov 2025 10:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vH2JJ-00009c-EG
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:54:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vH2JH-0002rZ-4j
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762444440;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eao2U0Cg+WpYftE7DpjOP/WrvnfOylH9QJQOTLiLM9Y=;
 b=jTxjVXdUO62zqkozeh7jiV+XUK3vwjyhFcxoX9tDI+AlxFuBmJ5hKetuzbAf/BXCrCOrp9
 LAB2xOpjB6RbQO8achZwvrME+ANGTaw9CJOafGGRwRy0YdLLxOsqxr+haewgjOk3MR+q3x
 zicU9KUjzNG1JnltqUT1L/uZ4IZooVM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-hYFk_J6oOX2mHHQsYVH8vw-1; Thu,
 06 Nov 2025 10:53:55 -0500
X-MC-Unique: hYFk_J6oOX2mHHQsYVH8vw-1
X-Mimecast-MFC-AGG-ID: hYFk_J6oOX2mHHQsYVH8vw_1762444435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC3218002E9; Thu,  6 Nov 2025 15:53:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A5A1180035F; Thu,  6 Nov 2025 15:53:53 +0000 (UTC)
Date: Thu, 6 Nov 2025 15:53:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] util/oslib-posix: increase memprealloc thread count
 to 32
Message-ID: <aQzEjov7dGPQeR3f@redhat.com>
References: <20251106163143.4185468-1-jon@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106163143.4185468-1-jon@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 06, 2025 at 09:31:43AM -0700, Jon Kohler wrote:
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
> 
> Note: Going above 32 threads appears to have diminishing returns at
> the point where the memory bandwidth and context switching costs
> appear to be a limiting factor to linear scaling. For posterity, on
> the same system as above:
> - 32 threads: 1m19s
> - 48 threads: 1m4s
> - 64 threads: 59s
> - 240 threads: 50s
> 
> Additional thread counts also get less interesting as the amount of
> memory is to be preallocated is smaller. Putting that all together,
> 32 threads appears to be a sane number with a solid speedup on fairly
> modern hardware. To go faster, we'd either need to improve the hardware
> (CPU/memory) itself or improve clear_pages_*() on the kernel side to
> be more efficient.
> 
> [1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  util/oslib-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

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



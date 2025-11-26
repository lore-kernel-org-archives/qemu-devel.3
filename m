Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A385D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOK5T-0003O4-75; Wed, 26 Nov 2025 13:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOK5K-0003Nq-TU
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOK5I-000725-IW
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764181062;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hz9+Rz8X8oSU6qtaZYARK5brv2KJTugejhJd87EYqWo=;
 b=Kod0eE7sO3bIqDUuoXZFoAKTBbrKpZOvndqhsC404vobl1ec1978s8BKkZg0ZV9ty17Aea
 FoimWw3lMRN79TzqTmMFHJm874hJ+8qW1MkhKmTX6ciAK9dO/GqmoAPlvOPTKELu1A8JJd
 e3BCysPOd9zQe+2WVLYm+vDbsKL9VBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-ozOrKSSNOQG_2b11QdnLGw-1; Wed,
 26 Nov 2025 13:17:38 -0500
X-MC-Unique: ozOrKSSNOQG_2b11QdnLGw-1
X-Mimecast-MFC-AGG-ID: ozOrKSSNOQG_2b11QdnLGw_1764181058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0031954B11; Wed, 26 Nov 2025 18:17:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD4C7180047F; Wed, 26 Nov 2025 18:17:35 +0000 (UTC)
Date: Wed, 26 Nov 2025 18:17:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] util/oslib-posix: increase memprealloc thread count
 to 32
Message-ID: <aSdEPK3U6B_9gSKV@redhat.com>
References: <20251106163143.4185468-1-jon@nutanix.com>
 <aQzEjov7dGPQeR3f@redhat.com>
 <FA4A9CAA-F033-4F1A-8197-799913A65DDA@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA4A9CAA-F033-4F1A-8197-799913A65DDA@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 26, 2025 at 06:14:43PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 6, 2025, at 10:53 AM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Thu, Nov 06, 2025 at 09:31:43AM -0700, Jon Kohler wrote:
> >> Increase MAX_MEM_PREALLOC_THREAD_COUNT from 16 to 32. This was last
> >> touched in 2017 [1] and, since then, physical machine sizes and VMs
> >> therein have continue to get even bigger, both on average and on the
> >> extremes.
> >> 
> >> For very large VMs, using 16 threads to preallocate memory can be a
> >> non-trivial bottleneck during VM start-up and migration. Increasing
> >> this limit to 32 threads reduces the time taken for these operations.
> >> 
> >> Test results from quad socket Intel 8490H (4x 60 cores) show a fairly
> >> linear gain of 50% with the 2x thread count increase.
> >> 
> >> ---------------------------------------------
> >> Idle Guest w/ 2M HugePages   | Start-up time
> >> ---------------------------------------------
> >> 240 vCPU, 7.5TB (16 threads) | 2m41.955s
> >> ---------------------------------------------
> >> 240 vCPU, 7.5TB (32 threads) | 1m19.404s
> >> ---------------------------------------------
> >> 
> >> Note: Going above 32 threads appears to have diminishing returns at
> >> the point where the memory bandwidth and context switching costs
> >> appear to be a limiting factor to linear scaling. For posterity, on
> >> the same system as above:
> >> - 32 threads: 1m19s
> >> - 48 threads: 1m4s
> >> - 64 threads: 59s
> >> - 240 threads: 50s
> >> 
> >> Additional thread counts also get less interesting as the amount of
> >> memory is to be preallocated is smaller. Putting that all together,
> >> 32 threads appears to be a sane number with a solid speedup on fairly
> >> modern hardware. To go faster, we'd either need to improve the hardware
> >> (CPU/memory) itself or improve clear_pages_*() on the kernel side to
> >> be more efficient.
> >> 
> >> [1] 1e356fc14bea ("mem-prealloc: reduce large guest start-up and migration time.")
> >> 
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> util/oslib-posix.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Thanks, Daniel !
> 
> Is there anything else we need on this one? Want to
> make sure it doesn’t get lost.

Paolo (CCd) is primary maintainer for this code and should queue it.

> >> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> >> index 3c14b72665..dc001da66d 100644
> >> --- a/util/oslib-posix.c
> >> +++ b/util/oslib-posix.c
> >> @@ -61,7 +61,7 @@
> >> #include "qemu/memalign.h"
> >> #include "qemu/mmap-alloc.h"
> >> 
> >> -#define MAX_MEM_PREALLOC_THREAD_COUNT 16
> >> +#define MAX_MEM_PREALLOC_THREAD_COUNT 32
> >> 
> >> struct MemsetThread;


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



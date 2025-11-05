Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB112CCFA07
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZT3-0005z0-8k; Wed, 05 Nov 2025 04:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGZT0-0005yX-UQ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGZSy-0007k7-Q8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762333567;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JT3lY+gkcP7vA8o48OfuF4DrzIjw7+cLZeuS47LLdC4=;
 b=Rntkx5SnT1U+g4yc4SJW+whjoe6r/QBqZd1JW/C519SReH9//ZGMTEPCmInqR/Y1k577XN
 IUjzYJo0WG3pp/240CDhibx68gaVcgyKDCaEP4mgEpVElUkOfdTGxJGMnDfIdwmKEwkvoL
 Zrw47dbGBbzo/xs3hZ/JvnhjSlMagf4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-z4qS2qghPB2ZenxXVlko_Q-1; Wed,
 05 Nov 2025 04:06:03 -0500
X-MC-Unique: z4qS2qghPB2ZenxXVlko_Q-1
X-Mimecast-MFC-AGG-ID: z4qS2qghPB2ZenxXVlko_Q_1762333562
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A37AE1956060; Wed,  5 Nov 2025 09:06:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C372F1956095; Wed,  5 Nov 2025 09:06:00 +0000 (UTC)
Date: Wed, 5 Nov 2025 09:05:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Message-ID: <aQsTdMyp6aPmhjDY@redhat.com>
References: <20251103185750.1394036-1-jon@nutanix.com>
 <aQka0DTrVsJrfU5z@redhat.com>
 <545E78A6-6013-45E1-9C3B-7D027FF12E00@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <545E78A6-6013-45E1-9C3B-7D027FF12E00@nutanix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 04, 2025 at 08:33:05PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 3, 2025, at 4:14 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Mon, Nov 03, 2025 at 11:57:50AM -0700, Jon Kohler wrote:
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
> > 
> > If we're configuring a guest with 240 vCPUs, then this implies the admin
> > is expecting that the guest will consume upto 240 host CPUs worth of
> > compute time.
> > 
> > What is the purpose of limiting the number of prealloc threads to a
> > value that is an order of magnitude less than the number of vCPUs the
> > guest has been given ?
> 
> Daniel - thanks for the quick review and thoughts here.
> 
> I looked back through the original commits that led up to the current 16
> thread max, and it wasn’t immediately clear to me why we clamped it at
> 16. Perhaps there was some other contention at the time.
> 
> > Have you measured what startup time would look like with 240 prealloc
> > threads ? Do we hit some scaling limit before that point making more
> > prealloc threads counter-productive ?
> 
> I have, and it isn’t wildly better, it comes down to about 50-ish seconds,
> as you start running into practical limitations on the speed of memory, as
> well as context switching if you’re doing other things on the host at the
> same time.
> 
> In playing around with some other values, here’s how they shake out:
> 32 threads: 1m19s
> 48 threads: 1m4s
> 64 threads: 59s
> …
> 240 threads: 50s
> 
> This also looks much less exciting when the amount of memory is
> smaller. For smaller memory sizes (I’m testing with 7.5TB), anything
> smaller than that gets less and less fun from a speedup perspective.
> 
> Putting that all together, 32 seemed like a sane number with a solid
> speedup on fairly modern hardware.

Yep, that's useful background, I've no objectino to picking 32.

Perhaps worth putting a bit more of this details into the
commit message as background.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



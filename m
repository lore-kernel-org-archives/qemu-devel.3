Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82932C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0FN-0001jv-BQ; Tue, 12 Mar 2024 07:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rk0FK-0001gy-0G
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rk0FH-0000I0-Rw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710242675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lRlfgkYdcLj0GqSS+bigFU6Ii28C5BfJP+1uPmfUdP4=;
 b=I22sb+tG+prTr531Z/NaOEkOxXODmK7mjYGVvq5E1fgreZSWcQDvUS77WDiUVN/9XD0rHO
 2qAE8jqolhBASayKZVXpN2iIaTXrQWPkVmLDNGw33QME7I+vaGITfWidLbUx1/IaVlzq3T
 qXHfQ5eml3tbzOHB0jyk6WbFE+0IRh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-UeTk8x_hNnyV4605KCCAkg-1; Tue, 12 Mar 2024 07:24:32 -0400
X-MC-Unique: UeTk8x_hNnyV4605KCCAkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7C7101A56C;
 Tue, 12 Mar 2024 11:24:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 585692166B4F;
 Tue, 12 Mar 2024 11:24:31 +0000 (UTC)
Date: Tue, 12 Mar 2024 12:24:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>
Subject: Re: [PATCH] virtio-blk: iothread-vq-mapping coroutine pool sizing
Message-ID: <ZfA7bhciuvDtO3fI@redhat.com>
References: <20240311201423.387622-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311201423.387622-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 11.03.2024 um 21:14 hat Stefan Hajnoczi geschrieben:
> It is possible to hit the sysctl vm.max_map_count limit when the
> coroutine pool size becomes large. Each coroutine requires two mappings
> (one for the stack and one for the guard page). QEMU can crash with
> "failed to set up stack guard page" or "failed to allocate memory for
> stack" when this happens.
> 
> Coroutine pool sizing is simple when there is only one AioContext: sum
> up all I/O requests across all virtqueues.
> 
> When the iothread-vq-mapping option is used we should calculate tighter
> bounds: take the maximum number of the number of I/O requests across all
> virtqueues. This number is lower than simply summing all virtqueues when
> only a subset of the virtqueues is handled by each AioContext.

The reasoning is that each thread has its own coroutine pool for which
the pool size applies individually, and it doesn't need to have space
for coroutines running in a different thread, right? I'd like to have
this recorded in the commit message.

Of course, this also makes me wonder if a global coroutine pool size
really makes sense or if it should be per thread. One thread could be
serving only one queue (maybe the main thread with a CD-ROM device) and
another thread 32 queues (the iothread with the interesting disks).
There is no reason for the first thread to have a coroutine pool as big
as the second one.

But before we make the size thread-local, maybe having thread-local
pools wasn't right to begin with because multiple threads can run main
context code and they should therefore share the same coroutine pool (we
already had the problem earlier that coroutines start on the vcpu thread
and terminate on the main thread and this plays havoc with coroutine
pools).

Maybe per-AioContext pools with per-AioContext sizes would make more
sense?

> This is not a solution to hitting vm.max_map_count, but it helps. A
> guest with 64 vCPUs (hence 64 virtqueues) across 4 IOThreads with one
> iothread-vq-mapping virtio-blk device and a root disk without goes from
> pool_max_size 16,448 to 10,304.
> 
> Reported-by: Sanjay Rao <srao@redhat.com>
> Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Either way, this should already strictly improve the situation, so I'm
happy to apply this change for now.

Kevin



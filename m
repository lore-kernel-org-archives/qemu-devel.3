Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F512C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXiPL-0005zb-Nq; Wed, 07 Feb 2024 08:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXiPJ-0005yz-Mv
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXiPF-0005Jm-7B
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707314163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8nYo5TPxsAqIVeZkviFkHKOtyj3AdeLIA4XmKZa/Lg=;
 b=gAFHs66CA/l1clQML5+tY552pMZNWHfGs3Xcvi7dFl0B+92dcQdrFfVJXHyYBWkVfgXSmV
 pjjhb05q44c0Hc5jgGoXrHcE9sRj90UjietU+6q1YNSfYpoHtLDY2/cyl3wuhFWlvVqvwc
 7GKoYbx4+xYtXUYqTpbelRL1AqKANOw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-6kYuB4D_O36zpDZ4qamTEQ-1; Wed,
 07 Feb 2024 08:56:02 -0500
X-MC-Unique: 6kYuB4D_O36zpDZ4qamTEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D08643806700;
 Wed,  7 Feb 2024 13:56:01 +0000 (UTC)
Received: from redhat.com (pixel-6a.str.redhat.com [10.33.192.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9776640C9444;
 Wed,  7 Feb 2024 13:56:00 +0000 (UTC)
Date: Wed, 7 Feb 2024 14:55:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
Message-ID: <ZcOL725H_pkewVLM@redhat.com>
References: <20240202144755.671354-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202144755.671354-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 02.02.2024 um 15:47 hat Hanna Czenczek geschrieben:
> Hi,
> 
> Without the AioContext lock, a BB's context may kind of change at any
> time (unless it has a root node, and I/O requests are pending).  That
> also means that its own context (BlockBackend.ctx) and that of its root
> node can differ sometimes (while the context is being changed).
> 
> blk_get_aio_context() doesn't know this yet and asserts that both are
> always equal (if there is a root node).  Because it's no longer true,
> and because callers don't seem to really care about the root node's
> context, we can and should remove the assertion and just return the BB's
> context.
> 
> Beyond that, the question is whether the callers of
> blk_get_aio_context() are OK with the context potentially changing
> concurrently.  Honestly, it isn't entirely clear to me; most look OK,
> except for the virtio-scsi code, which operates under the general
> assumption that the BB's context is always equal to that of the
> virtio-scsi device.  I doubt that this assumption always holds (it is
> definitely not obvious to me that it would), but then again, this series
> will not make matters worse in that regard, and that is what counts for
> me now.
> 
> One clear point of contention is scsi_device_for_each_req_async(), which
> is addressed by patch 2.  Right now, it schedules a BH in the BB
> context, then the BH double-checks whether the context still fits, and
> if not, re-schedules itself.  Because virtio-scsi's context is fixed,
> this seems to indicate to me that it wants to be able to deal with a
> case where BB and virtio-scsi context differ, which seems to break that
> aforementioned general virtio-scsi assumption.
> 
> Unfortunately, I definitely have to touch that code, because accepting
> concurrent changes of AioContexts breaks the double-check (just because
> the BB has the right context in that place does not mean it stays in
> that context); instead, we must prevent any concurrent change until the
> BH is done.  Because changing contexts generally involves a drained
> section, we can prevent it by keeping the BB in-flight counter elevated.
> 
> Question is, how to reason for that.  I’d really rather not include the
> need to follow the BB context in my argument, because I find that part a
> bit fishy.
> 
> Luckily, there’s a second, completely different reason for having
> scsi_device_for_each_req_async() increment the in-flight counter:
> Specifically, scsi_device_purge_requests() probably wants to await full
> completion of scsi_device_for_each_req_async(), and we can do that most
> easily in the very same way by incrementing the in-flight counter.  This
> way, the blk_drain() in scsi_device_purge_requests() will not only await
> all (cancelled) I/O requests, but also the non-I/O requests.
> 
> The fact that this prevents the BB AioContext from changing while the BH
> is scheduled/running then is just a nice side effect.
> 
> 
> Hanna Czenczek (2):
>   block-backend: Allow concurrent context changes
>   scsi: Await request purging
> 
>  block/block-backend.c | 22 +++++++++++-----------
>  hw/scsi/scsi-bus.c    | 30 +++++++++++++++++++++---------
>  2 files changed, 32 insertions(+), 20 deletions(-)

Thanks, applied to the block branch.

Kevin



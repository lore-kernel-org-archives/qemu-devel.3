Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C4ACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNsQ4-0004Lp-4M; Fri, 15 May 2026 09:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNsPn-0004KB-FN
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNsPl-00011G-Pm
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778851037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52yYhojV2eoReHOjLGLk3p8TMHI7/7+uWnB0ZqL2JSw=;
 b=HfxZUFdRuslYieC6rB0Iyo+ylfyrOT/7qnyQcQ8XjIqH3o2yixNzP5bUujCugAKTWE9oH3
 iqh+SJnqY6cTLrBxAg92pfY/GqSdY1v9YCm5cd0z+SElSlhZYcCZO06/XnsCDzbzWt79l4
 kzNHliLh/AQ+5qIDR5QKbwCVoEWM9yo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-S-h4tLr6NhSeNhc8JT2Vkg-1; Fri,
 15 May 2026 09:17:12 -0400
X-MC-Unique: S-h4tLr6NhSeNhc8JT2Vkg-1
X-Mimecast-MFC-AGG-ID: S-h4tLr6NhSeNhc8JT2Vkg_1778851030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C59C1956046; Fri, 15 May 2026 13:17:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE44919560A2; Fri, 15 May 2026 13:17:07 +0000 (UTC)
Date: Fri, 15 May 2026 15:17:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH 1/2] block/graph-lock: fix missed wakeup in
 bdrv_graph_co_rdunlock()
Message-ID: <agcc0dEwnb_knUE7@redhat.com>
References: <20260424103917.248668-1-den@openvz.org>
 <20260424103917.248668-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424103917.248668-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24.04.2026 um 12:39 hat Denis V. Lunev geschrieben:
> tests/qemu-iotests/tests/iothreads-create reproduces the hang on
> master under `stress-ng --cpu $(nproc) --timeout 0`.  The iotest's
> vm.run_job() times out and qemu stays permanently stuck in
> ppoll(timeout=-1) inside bdrv_graph_wrlock_drained -> blk_remove_bs
> during qemu_cleanup().  The timing window is narrow on modern
> bare-metal hardware and much wider in a VM guest; downstream trees
> that still use plain bdrv_graph_wrlock() in blk_remove_bs() hit it
> on the first iteration under the same stress.
> 
> bdrv_graph_wrlock() zeroes has_writer around its AIO_WAIT_WHILE loop
> so that callbacks dispatched by aio_poll() can still take the read
> lock on the fast path.  The rdunlock side, however, only kicks a
> waiting writer when has_writer is observed set; a reader that drops
> its lock inside the polling window silently returns and nothing ever
> wakes the writer:
> 
>   main thread                         iothread0 coroutine
>   -----------                         -------------------
>   bdrv_graph_wrlock:                  rdlock held, reader_count=1
>     bdrv_drain_all_begin_nopoll
>     has_writer = 0
>     AIO_WAIT_WHILE_UNLOCKED(
>         NULL, reader_count >= 1):
>       num_waiters++
>       smp_mb
>       aio_poll(main_ctx, true)   -->  bdrv_graph_co_rdunlock:
>         (ppoll, blocked)                reader_count-- -> 0
>                                         smp_mb
>                                         read has_writer = 0
>                                         skip aio_wait_kick()
>                                       return
> 
> reader_count is now 0 and num_waiters is still 1, but no BH, fd or
> timer on the main AioContext will fire -- the only entity that could
> kick just decided it did not have to.  Main stays in ppoll() holding
> BQL, so RCU, VCPUs and any iothread path that needs BQL stall behind
> it.  The hang is final; no timeout, no forward progress, no recovery
> as there is no other source of wake up inside qemu_cleanup().
> 
> bdrv_drain_all_begin() does not close the race on its own: it
> quiesces in-flight I/O, but graph readers also include non-I/O
> coroutines (block-job cleanup, virtio-scsi polling) that drain does
> not evict.  The bdrv_graph_wrlock_drained() wrapper narrows the
> window but does not eliminate it; every plain bdrv_graph_wrlock()
> site is exposed on the same basis.
> 
> Drop the has_writer check in bdrv_graph_co_rdunlock() and call
> aio_wait_kick() unconditionally.  The helper itself loads num_waiters
> atomically and only schedules a dummy BH when a waiter exists, so the
> change is a no-op on the no-writer path and closes the missed-wakeup
> on the writer path.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks, applied to the block branch.

Kevin



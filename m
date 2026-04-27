Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC11FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHPO6-0007CB-Cm; Mon, 27 Apr 2026 13:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPNy-0007BT-O1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wHPNu-0005zs-If
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 13:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777309476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6r8IkjV91wOyIbrB7n71DtnQuy7ErFb93/t8lm5zY6Y=;
 b=KSTAgSulica+j4cFRIQGaC4qarwIW4UA1wPkaBGJo4p3Pxqw0t6rM0GLd5++Uuz2Sdql0M
 YbV1iOLNe0VFa6M2TvmzKBejcEDsKgSFuJBrEIFpn1CLlGNftjCiWFN6nZpYTUu91uv5Ba
 VmlV4xRFykUf7gKYwhOII9lGUwaM3MY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-Nl5PF5oYP7SErhAaPbDo2Q-1; Mon,
 27 Apr 2026 13:04:35 -0400
X-MC-Unique: Nl5PF5oYP7SErhAaPbDo2Q-1
X-Mimecast-MFC-AGG-ID: Nl5PF5oYP7SErhAaPbDo2Q_1777309474
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55CC19560B9; Mon, 27 Apr 2026 17:04:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4414819560B1; Mon, 27 Apr 2026 17:04:30 +0000 (UTC)
Date: Mon, 27 Apr 2026 19:04:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] block/io: serialise discard and write-zeroes against
 in-flight writes
Message-ID: <ae-XHByosS2Q4vHC@redhat.com>
References: <20260421155628.3600671-1-den@openvz.org>
 <20260421155628.3600671-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421155628.3600671-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 21.04.2026 um 17:56 hat Denis V. Lunev geschrieben:
> qcow2's write path drops s->lock around the data I/O of an allocating
> write. A concurrent discard (or MAY_UNMAP write-zeroes) on the same
> guest offset lands the cluster-free operation in that window. The
> original writer then reacquires the lock and unconditionally writes
> L2[G] = alloc_offset | OFLAG_COPIED on its now-stale l2meta, binding
> the L2 entry to a freed cluster:
> 
>   WRITE coroutine                       DISCARD coroutine
>   ---------------                       -----------------
>   qcow2_co_pwritev_part:
>     lock(s->lock)
>     qcow2_alloc_host_offset:
>       handle_copied reads L2[G] = C | OFLAG_COPIED
>       builds l2meta { alloc=C, keep_old_clusters=true }
>     unlock(s->lock)                 -->
>     bdrv_co_pwritev_part (data I/O)    lock(s->lock)
>                                        qcow2_co_pdiscard on G:
>                                          discard_in_l2_slice
>                                            set_l2_entry(G, 0)
>                                            free_any_cluster(C):
>                                              rc(C) 1 -> 0
>                                        unlock(s->lock)
>     lock(s->lock)
>     qcow2_handle_l2meta(link_l2=true):
>       qcow2_alloc_cluster_link_l2:
>         set_l2_entry(G, C | OFLAG_COPIED)  <- stale alloc onto
>                                               freed cluster
> 
> The next allocator pass re-hands C out on rc=0, so we end up with two
> L2 entries aliasing one host cluster. On disk this shows up in
> qemu-img check as refcount=0 with a live OFLAG_COPIED reference or as
> refcount < reference; at runtime the next discard on either alias
> prints "qcow2_free_clusters failed: Invalid argument" on stderr with
> no guest-visible error.

I mostly agree with the problem description, except that I don't think
it's qcow2_alloc_host_offset(), but rather handle_copied(). If it were a
completely new cluster, it wouldn't be mapped in the L2 table yet and
discard wouldn't even see it. But when an existing cluster needs to have
its L2 entry modified (e.g. pre-allocated zero cluster, or with
subclusters), then we get the problem.

> Mark both discards and all write-zeroes (with or without MAY_UNMAP)
> as BDRV_REQ_SERIALISING in the generic block layer. Their
> tracked_request then waits for overlapping in-flight writes,
> including non-serialising ones, to finish their format-driver commit
> before any L2/refcount mutation happens.

I don't think this is a good fix.

On the one hand it's a very big hammer, serialising all requests with
discards/write zeroes while only a small subset of writes really
constitute a problem.

On the other hand, it's not enough to ensure consistency. Writes also
have to be serialised against conflicting other writes, so this kind of
synchronisation is already the block driver's problem. And in fact,
qcow2 does have the mechanism for it (s->cluster_allocs). Discards and
write_zeroes requests just don't look at it yet. This is easy enough to
fix in qcow2.

If another driver drops the lock for writes, it has to build a similar
synchronisation mechanism either way.

So just serialising some requests that we suspect might exhibit bugs in
the block driver feels like it's just papering over the problem instead
of solving it.

I'll send an alternative proposal in a moment.

Kevin



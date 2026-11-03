Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD70606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVbNpj1w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5LB-0001RC-U8; Mon, 02 Nov 2026 22:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5Kv-0001Om-BS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5Kr-000779-HD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793677040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+repCJUePQ5prkiwRWgsKvFajEW8Nxs0UrdwLthhp+g=;
 b=EVbNpj1wy1tVIOtHEgTsIKkFHuOUMwrLJ0QcjDt6dp9IeBPAOmvcnSr64+0YCIFeuA+Unh
 I0t/60NoZRBiUPyGcQiAoVq8xFG4zRD1jKTjZxxz2bbjR6EJzoSSbrzOhKT1TOLl6gOB0v
 Lii5yKgHuPucHFlHq6FWv8QlmDtMVyg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-edK7mau5NBi6UrN_DU6htA-1; Mon,
 02 Nov 2026 22:37:19 -0500
X-MC-Unique: edK7mau5NBi6UrN_DU6htA-1
X-Mimecast-MFC-AGG-ID: edK7mau5NBi6UrN_DU6htA_1793677038
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912AC18005AE; Tue,  3 Nov 2026 03:37:17 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6653030000E3; Tue,  3 Nov 2026 03:37:15 +0000 (UTC)
Date: Mon, 2 Nov 2026 21:37:12 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v4 12/12] block/block-copy: coalesce write-zeroes tasks
Message-ID: <aulWN3IIdjcqmq_M@redhat.com>
References: <20261030010613.1612771-1-den@openvz.org>
 <20261030010613.1612771-13-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030010613.1612771-13-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 02:06:12AM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Task size was capped to block_copy_chunk_size() regardless of method,
> which sizes a task by the copy buffer. A write-zeroes task carries no
> buffer, so that cap only splits one long known-zero run into a crowd of
> small COPY_WRITE_ZEROES tasks, each with its own request against the
> target.
> 
> block_copy_task_create() already decides from zero_bitmap how far a task
> may run, so add block_copy_widen_zero_area() to that decision: a
> write-zeroes task runs to the next clean cluster of copy_bitmap, at most
> BDRV_REQUEST_MAX_BYTES aligned down to cluster_size, and the existing
> clamp cuts it back to where the zero run ends. The experimental x-perf
> max-chunk does not bound it, and its documentation now says so.
> Widening is safe: an overlapping caller waits on the task's BlockReq via
> reqlist_wait_one() rather than observing it mid-flight.
> 
> A request that large is only cheap where the target zeroes by metadata.
> BDRV_REQ_NO_FALLBACK in supported_zero_flags rules out the targets which
> cannot, qcow2 v2 and iscsi among them, but it is optimistic for the
> rest: file-posix advertises it at open and only learns from a failing
> fallocate. So a write-zeroes task asks for it while the target is
> believed to oblige, which costs nothing when it does. A refusal ends the
> widening and shrinks the task to one cluster, written with fallback
> allowed. The rest of the range is dirty again, and the next pass of
> block_copy_common() picks it up as buffer-sized tasks running in
> parallel. Part of the refused range may already be zeroed, since
> -ENOTSUP only says the fast path is unavailable, and writing zeroes over
> it again changes nothing.
> 
> Such a task is also the only one sure to need no buffer: without
> NO_FALLBACK, bdrv_co_do_pwrite_zeroes() writes the zeroes out through a
> bounce buffer. So it alone is left out of the memory pool and of the
> rate limit, where one widened request would otherwise hold the job back
> for as long as speed= takes to pass its whole length. The one-cluster
> write left after a refusal is not charged either, though it may bounce:
> that is at most one cluster per worker, once, as tasks created after the
> refusal are charged in full.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/block-copy.c   | 96 +++++++++++++++++++++++++++++++++++++++-----
>  qapi/block-core.json |  4 +-
>  2 files changed, 88 insertions(+), 12 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



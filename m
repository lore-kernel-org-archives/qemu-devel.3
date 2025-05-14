Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9178AC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIBl-0000Pj-UJ; Wed, 14 May 2025 15:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFIBL-0000DD-NI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFIBK-0002MT-4E
 for qemu-devel@nongnu.org; Wed, 14 May 2025 15:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747252461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5eLV7ApxDJeth06MTKdZ1qt6Sj7u+dse9JPW+lE24FI=;
 b=XbCSlfktxbRO5dxJMxEDoQQyGiV/Pc80tCwyv94SYRLjsBXdLKWkh6asrVE0CRALimR/cE
 B2Yqe5/fROl+y5cUeZmtOyGo+13TA9kTF3nkOHpIreT/gg6e69g1jeQ2OFp5qCTBtugUUu
 kpAVzelA29iPv80Lg39uvLgOnq0M41E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-m0t7cGL9OCevSX8HFYQc6A-1; Wed,
 14 May 2025 15:54:17 -0400
X-MC-Unique: m0t7cGL9OCevSX8HFYQc6A-1
X-Mimecast-MFC-AGG-ID: m0t7cGL9OCevSX8HFYQc6A_1747252456
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F9741800DA1; Wed, 14 May 2025 19:54:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187551956058; Wed, 14 May 2025 19:54:11 +0000 (UTC)
Date: Wed, 14 May 2025 21:54:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 10/11] block/graph-lock: add drain flag to
 bdrv_graph_wr{,un}lock
Message-ID: <aCT04V_-LtCXryqv@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-11-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-11-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
> For convenience, allow indicating whether the write-locked section
> should also be a drained section directly when taking the write
> lock.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Good idea, the pattern seems to be common enough.

> In bdrv_graph_wrlock() there is a comment that it uses
> bdrv_drain_all_begin_nopoll() to make sure that constantly arriving
> new I/O doesn't cause starvation. The changes from this series are at
> odds with that, but there doesn't seem to be any (new) test failures.

I don't see why they are at odds with it? Draining an already drained
node isn't a problem, it just increases the counter without doing
anything else.

> The following script was used:
> 
> > find . -name '*.c' -exec sed -i -z 's/bdrv_drain_all_begin();\n\s*bdrv_graph_wrlock();/bdrv_graph_wrlock(true);/g' {} ';'
> > find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();\n\s*bdrv_drain_all_end();/bdrv_graph_wrunlock(true);/g' {} ';'
> > find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrlock();/bdrv_graph_wrlock(false);/g' {} ';'
> > find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();/bdrv_graph_wrunlock(false);/g' {} ';'
> 
>  block.c                            | 62 ++++++++++++------------------
>  block/backup.c                     |  6 +--
>  block/blklogwrites.c               | 12 ++----
>  block/blkverify.c                  |  6 +--
>  block/block-backend.c              | 12 ++----
>  block/commit.c                     | 20 ++++------
>  block/graph-lock.c                 | 22 ++++++++---
>  block/mirror.c                     | 27 ++++++-------
>  block/qcow2.c                      |  6 +--
>  block/quorum.c                     | 12 ++----
>  block/replication.c                | 21 ++++------
>  block/snapshot.c                   |  6 +--
>  block/stream.c                     | 16 +++-----
>  block/vmdk.c                       | 30 +++++----------
>  blockdev.c                         | 10 ++---
>  blockjob.c                         | 18 +++------
>  include/block/graph-lock.h         |  8 +++-
>  scripts/block-coroutine-wrapper.py |  4 +-
>  tests/unit/test-bdrv-drain.c       | 58 ++++++++++------------------
>  tests/unit/test-bdrv-graph-mod.c   | 30 +++++----------
>  20 files changed, 152 insertions(+), 234 deletions(-)

> diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
> index 2c26c72108..f291ccbc97 100644
> --- a/include/block/graph-lock.h
> +++ b/include/block/graph-lock.h
> @@ -108,17 +108,21 @@ void unregister_aiocontext(AioContext *ctx);
>   *
>   * The wrlock can only be taken from the main loop, with BQL held, as only the
>   * main loop is allowed to modify the graph.
> + *
> + * @drain whether bdrv_drain_all_begin() should be called before taking the lock
>   */
>  void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
> -bdrv_graph_wrlock(void);
> +bdrv_graph_wrlock(bool drain);

I would prefer having two separate functions instead of a bool
parameter.

bdrv_graph_wrlock() could stay as it is, and bdrv_graph_wrlock_drained()
could be the convenience wrapper that drains first.

>  /*
>   * bdrv_graph_wrunlock:
>   * Write finished, reset global has_writer to 0 and restart
>   * all readers that are waiting.
> + *
> + * @drain whether bdrv_drain_all_end() should be called after releasing the lock
>   */
>  void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
> -bdrv_graph_wrunlock(void);
> +bdrv_graph_wrunlock(bool drain);

Here I would prefer to only keep the old bdrv_graph_wrunlock() without
a parameter. Can we just remember @drain from bdrv_graph_wrlock() in a
global variable? This would prevent callers from mismatching lock and
unlock variants (which TSA wouldn't be able to catch).

Kevin



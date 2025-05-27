Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E9C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvyW-0003f4-RV; Tue, 27 May 2025 11:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJvyO-0003dn-1T
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJvyG-0007Un-Ls
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ga+4ynvGmz3YUt7Tv4iZYJWJsba7PhYx5/bGHZ310Q=;
 b=ENsuFYwmYAg+dZS0Ag5OyMrKDL6+o4SmuIoRHZA8FLHVmej0JxzDKCJxbMD0LcWl3t9LIa
 1A4kj2GM/ITM4J/8Bqv3EV6XdH3/wh6v/7jMZK23wvUfYVpl1VTeSRxQBlRzrC+OY2rhE8
 /QHVGhfdzuzs1eZhbW+BtXjDuA2vyp4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-85RdAwdpOPqAoWd4fZFlzg-1; Tue,
 27 May 2025 11:11:59 -0400
X-MC-Unique: 85RdAwdpOPqAoWd4fZFlzg-1
X-Mimecast-MFC-AGG-ID: 85RdAwdpOPqAoWd4fZFlzg_1748358717
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 332281800261; Tue, 27 May 2025 15:11:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 783B518004A7; Tue, 27 May 2025 15:11:50 +0000 (UTC)
Date: Tue, 27 May 2025 17:11:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v3 08/24] block: move drain outside of
 bdrv_change_aio_context() and mark GRAPH_RDLOCK
Message-ID: <aDXWM_jZWo9w_f9v@redhat.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-9-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526132140.1641377-9-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> Note that even if bdrv_drained_begin() were already marked as
> GRAPH_UNLOCKED, TSA would not complain about the instance in
> bdrv_change_aio_context() before this change, because it is preceded
> by a bdrv_graph_rdunlock_main_loop() call. It is not correct to
> release the lock here, and in case the caller holds a write lock, it
> wouldn't actually release the lock.
> 
> In combination with block-stream, there is a deadlock that can happen
> because of this [0]. In particular, it can happen that
> main thread              IO thread
> 1. acquires write lock
>                          in blk_co_do_preadv_part():
>                          2. have non-zero blk->in_flight
>                          3. try to acquire read lock
> 4. begin drain
> 
> Steps 3 and 4 might be switched. Draining will poll and get stuck,
> because it will see the non-zero in_flight counter. But the IO thread
> will not make any progress either, because it cannot acquire the read
> lock.
> 
> After this change, all paths to bdrv_change_aio_context() drain:
> bdrv_change_aio_context() is called by:
> 1. bdrv_child_cb_change_aio_ctx() which is only called via the
>    change_aio_ctx() callback, see below.
> 2. bdrv_child_change_aio_context(), see below.
> 3. bdrv_try_change_aio_context(), where a drained section is
>    introduced.
> 
> The change_aio_ctx() callback is called by:
> 1. bdrv_attach_child_common_abort(), where a drained section is
>    introduced.
> 2. bdrv_attach_child_common(), where a drained section is introduced.
> 3. bdrv_parent_change_aio_context(), see below.
> 
> bdrv_child_change_aio_context() is called by:
> 1. bdrv_change_aio_context(), i.e. recursive, so being in a drained
>    section is invariant.
> 2. child_job_change_aio_ctx(), which is only called via the
>    change_aio_ctx() callback, see above.
> 
> bdrv_parent_change_aio_context() is called by:
> 1. bdrv_change_aio_context(), i.e. recursive, so being in a drained
>    section is invariant.
> 
> This resolves all code paths. Note that bdrv_attach_child_common()
> and bdrv_attach_child_common_abort() hold the graph write lock and
> callers of bdrv_try_change_aio_context() might too, so they are not
> actually allowed to drain either. This will be addressed in the
> following commits.
> 
> More granular draining is not trivially possible, because
> bdrv_change_aio_context() can recursively call itself e.g. via
> bdrv_child_change_aio_context().
> 
> [0]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/
> 
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>



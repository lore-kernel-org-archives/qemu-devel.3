Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3700C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFGFZ-0008HB-IW; Wed, 14 May 2025 13:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFGFI-0007Su-8B
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFGFE-00053y-Rb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747245015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TJZlKUfCtTI01nmC0/fMoub6wT+ReoY1R41oMaARDU=;
 b=X5xuEeUOauqQ4fAT/G163uI8dtsZzSKqeo2n2B+YYfpm1oRjaZS8R45FIzUEEulies1Wrm
 kqZ4y/EbadEs6c3h1Szja7d3XndFD1wG6oWSCnm0JdP3DvpX/D2v3xwdYZDYeS3f4wmQJk
 m+Szx/VuzRTbb8UzhYCw12g4Emgrn94=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-R6KWxMI5ML6FeG9x7XMgMQ-1; Wed,
 14 May 2025 13:50:12 -0400
X-MC-Unique: R6KWxMI5ML6FeG9x7XMgMQ-1
X-Mimecast-MFC-AGG-ID: R6KWxMI5ML6FeG9x7XMgMQ_1747245011
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF4B4195DE75; Wed, 14 May 2025 17:50:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3FA719560B4; Wed, 14 May 2025 17:50:06 +0000 (UTC)
Date: Wed, 14 May 2025 19:50:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 08/11] block: mark bdrv_drained_begin() as GRAPH_UNLOCKED
Message-ID: <aCTXy0mMCCmjMeNE@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-9-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-9-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
> bdrv_drained_begin() polls and is not allowed to be called with the
> block graph lock held. Mark the function as such.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> This does not catch the issue reported by Andrey, because there
> is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
> the function bdrv_change_aio_context(). That unlock is of course
> ineffective if the exclusive lock is held, but it seems to prevent TSA
> from finiding the issue.

Yes, GRAPH_UNLOCKED is weak. It doesn't actually prove that the graph is
unlocked, but just flags direct callers that are known to hold the lock.
So because bdrv_try_change_aio_context() and bdrv_change_aio_context()
don't have TSA annotations, it misses the problem. If they had an
annotation, it would find the problem. (If they were GRAPH_UNLOCKED,
because they can't be called, or if they were GRAPH_RDLOCK/WRLOCK
because of double locking.)

TSA does have negative requirements that would prove it, but that would
essentially mean annotating everything in QEMU, even outside the block
layer, down to main() as GRAPH_UNLOCKED. I don't think that's practical.

Hmm, or maybe it wouldn't be that bad if we could have something like
assume_graph_unlocked()...? Not for this series anyway.

> The next patch is concerned with that.
> 
>  include/block/block-io.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index b49e0537dd..34b9f1cbfc 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -429,7 +429,8 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
>   *
>   * This function can be recursive.
>   */
> -void bdrv_drained_begin(BlockDriverState *bs);
> +void GRAPH_UNLOCKED
> +bdrv_drained_begin(BlockDriverState *bs);

No need for the line break, it fits easily on a single line.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>



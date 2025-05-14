Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEAFC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFZ9-0004LW-4Y; Wed, 14 May 2025 13:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFYh-00033S-8M
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFYd-0007pY-9F
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKphMvnfY4he6VSX6ukJwQwTVPcMtU6ZhPexPN4J51E=;
 b=gyvj1el6ewu0s+HYi4yDGyCO+SOBvT7VkcvB7KmgS/LoiV2XstqC97V35nG4gn/9/8cdPK
 2VuG40hiHoDkPHTfZ2WR96NxuZlzt9WB0ptRAW7DzINsHv43KbIVB0i5ZsqvX857qrJ1KG
 9yzei7CSvlVOUtDfOmzD2+m6vajxg6s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354--ZenrUMDNEunMMtWR0UHOg-1; Wed,
 14 May 2025 13:06:11 -0400
X-MC-Unique: -ZenrUMDNEunMMtWR0UHOg-1
X-Mimecast-MFC-AGG-ID: -ZenrUMDNEunMMtWR0UHOg_1747242369
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6002E195608B; Wed, 14 May 2025 17:06:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C321955F24; Wed, 14 May 2025 17:06:05 +0000 (UTC)
Date: Wed, 14 May 2025 19:06:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 05/11] block: move drain outside of read-locked
 bdrv_inactivate_recurse()
Message-ID: <aCTNek1ugvseHAQq@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-6-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-6-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> More granular draining is not trivially possible, because
> bdrv_inactivate_recurse() can recursively call itself.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/block.c b/block.c
> index c7c26533c9..10052027cd 100644
> --- a/block.c
> +++ b/block.c
> @@ -6991,6 +6991,8 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
>      int ret;
>      uint64_t cumulative_perms, cumulative_shared_perms;
>  
> +    assert(qatomic_read(&bs->quiesce_counter) > 0);
> +
>      GLOBAL_STATE_CODE();
>  
>      if (!bs->drv) {
> @@ -7036,9 +7038,7 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
>          return -EPERM;
>      }
>  
> -    bdrv_drained_begin(bs);
>      bs->open_flags |= BDRV_O_INACTIVE;
> -    bdrv_drained_end(bs);
>  
>      /*
>       * Update permissions, they may differ for inactive nodes.
> @@ -7063,14 +7063,20 @@ int bdrv_inactivate(BlockDriverState *bs, Error **errp)
>      int ret;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
>  
>      if (bdrv_has_bds_parent(bs, true)) {
>          error_setg(errp, "Node has active parent node");
> +        bdrv_graph_rdunlock_main_loop();
> +        bdrv_drain_all_end();
>          return -EPERM;
>      }
>  
>      ret = bdrv_inactivate_recurse(bs, true);
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Failed to inactivate node");
>          return ret;

This might be another one that would become a bit clearer if you put the
unlock/drain_end at the end and use a goto out for the error cases.

Kevin



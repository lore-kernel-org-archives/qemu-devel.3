Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515ECC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWaoa-0007TP-AU; Tue, 01 Jul 2025 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWaoT-0007Ox-GP
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWaoL-0005bi-Co
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751375646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Stw24SGoQtlqpYEhQevLbtZS1fjti6KrntxHeaDdln0=;
 b=SUHJ84CABZTAqRI4OCEHoI1jRIqv+YUnumzCe8t/AvtiU/04GWa4FMGYhagJOliihKhz8g
 b9VBHey5zzmJytkljgkJTbpVboIcj0yWsYgThhSMJcsrXTDUwqYyTjNJDXSDy4viGvr/zH
 5RMZU5AFO89CR2uF7UZiH1ZtvGAbRHI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-zbBl6BsePvezhWaKCVLtZg-1; Tue,
 01 Jul 2025 09:14:01 -0400
X-MC-Unique: zbBl6BsePvezhWaKCVLtZg-1
X-Mimecast-MFC-AGG-ID: zbBl6BsePvezhWaKCVLtZg_1751375640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745771955ED1; Tue,  1 Jul 2025 13:13:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5B28180035E; Tue,  1 Jul 2025 13:13:52 +0000 (UTC)
Date: Tue, 1 Jul 2025 15:13:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 27/48] block: call bdrv_set_backing_hd() while
 unlocked in bdrv_open_backing_file()
Message-ID: <aGPfDUjWTQf9SHNN@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <20250530151125.955508-28-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530151125.955508-28-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 30.05.2025 um 17:11 hat Fiona Ebner geschrieben:
> This is in preparation to mark bdrv_set_backing_hd() as
> GRAPH_UNLOCKED.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 1da10d55f0..ca3b67b233 100644
> --- a/block.c
> +++ b/block.c
> @@ -3632,7 +3632,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>      Error *local_err = NULL;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    bdrv_graph_rdlock_main_loop();
>  
>      if (bs->backing != NULL) {
>          goto free_exit;
> @@ -3711,9 +3712,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>                  backing_hd->filename);
>      }
>  
> +

Extra blank line.

>      /* Hook up the backing file link; drop our reference, bs owns the
>       * backing_hd reference now */
> +    bdrv_graph_rdunlock_main_loop();
>      ret = bdrv_set_backing_hd(bs, backing_hd, errp);
> +    bdrv_graph_rdlock_main_loop();
>      bdrv_unref(backing_hd);
>  
>      if (ret < 0) {

Kevin



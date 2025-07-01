Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A855C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZIw-0003gZ-BJ; Tue, 01 Jul 2025 07:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWZIr-0003g8-00
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWZIn-00024U-6t
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751369845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vw5O4lMVxeF8wcY5LvDDfJqxCwiPzAWKcuF+9FH0pxE=;
 b=h4t5bfobRHdVqEaPTmiAZM+FKyvnFIKmPyjgs4wTKLqlZeEcIYYkrCk6sw1iS0MESmg0BX
 5DmrKFlXtjbsokOJm9nOdynce9nLONrmcDhEZrVmFkoBCmjIcVXw7Hu2wkgZa75msZQ69y
 Hd+0vNThJRXcu1ur5/kFtNaqwNP7j3I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-6UyDl35rNMmEEnclqVAofg-1; Tue,
 01 Jul 2025 07:37:22 -0400
X-MC-Unique: 6UyDl35rNMmEEnclqVAofg-1
X-Mimecast-MFC-AGG-ID: 6UyDl35rNMmEEnclqVAofg_1751369840
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F87B1808984; Tue,  1 Jul 2025 11:37:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA2730001B1; Tue,  1 Jul 2025 11:37:13 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:37:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v4 24/48] block: add bdrv_graph_wrlock_drained()
 convenience wrapper
Message-ID: <aGPIZvQwejyjRPKw@redhat.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <20250530151125.955508-25-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530151125.955508-25-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 30.05.2025 um 17:11 hat Fiona Ebner geschrieben:
> Many write-locked sections are also drained sections. A new
> bdrv_graph_wrunlock_drained() wrapper around bdrv_graph_wrunlock() is
> introduced, which will begin a drained section first. A global
> variable is used so bdrv_graph_wrunlock() knows if it also needs
> to end such a drained section. Both the aio_poll call in
> bdrv_graph_wrlock() and the aio_bh_poll() in bdrv_graph_wrunlock()
> can re-enter a write-locked section. While for the latter, ending the
> drain could be moved to before the call, the former requires that the
> variable is a counter and not just a boolean.
> 
> Since the wrapper calls bdrv_drain_all_begin(), which must be called
> with the graph unlocked, mark the wrapper as GRAPH_UNLOCKED too.
> 
> The switch to the new helpers was generated with the following
> commands and then manually checked:
> find . -name '*.c' -exec sed -i -z 's/bdrv_drain_all_begin();\n\s*bdrv_graph_wrlock();/bdrv_graph_wrlock_drained();/g' {} ';'
> find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();\n\s*bdrv_drain_all_end();/bdrv_graph_wrunlock();/g' {} ';'
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v4:
> * Adapt to context changes from earlier patch.
> * Mark the wrapper as GRAPH_UNLOCKED itself

> diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
> index 2c26c72108..b564cba2c0 100644
> --- a/include/block/graph-lock.h
> +++ b/include/block/graph-lock.h
> @@ -112,10 +112,21 @@ void unregister_aiocontext(AioContext *ctx);
>  void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
>  bdrv_graph_wrlock(void);
>  
> +/*
> + * bdrv_graph_wrlock_drained:
> + * Similar to bdrv_graph_wrlock, but will begin a drained section before
> + * locking.
> + */
> +void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA GRAPH_UNLOCKED
> +bdrv_graph_wrlock_drained(void);

GRAPH_UNLOCKED is redundant. TSA_ACQUIRE(graph_lock) already means that
you can't call the function while holding the lock.

Kevin



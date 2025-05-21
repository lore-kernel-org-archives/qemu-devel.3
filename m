Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA7FC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHg8w-0001Sg-HB; Wed, 21 May 2025 05:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHg8u-0001RW-9B
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHg8p-0002nL-8H
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747821217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mM7XzfWvF5G5HVJY+98oHV6JxxeBdB2ztXBAKSfnCiU=;
 b=L5NSek9Y61gW5/4/Q5dOwLwAAfsrPxW1oxDVjNkYxYU/7OXbTnL2ZeR9ArBGTk9fUA/lzn
 MI7bmknKmQ+eQ4T+1qJ0wFfqN6WpOk0RtDpLqifqSpQFxbjDfIBn0vV0fxAuDMFqVrFlM2
 kWvp65BjuKXUu5dB7s4fhnvOyeOOdUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-UI-dv02fNWy1ErRXfW71kg-1; Wed,
 21 May 2025 05:53:35 -0400
X-MC-Unique: UI-dv02fNWy1ErRXfW71kg-1
X-Mimecast-MFC-AGG-ID: UI-dv02fNWy1ErRXfW71kg_1747821214
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E045180087B; Wed, 21 May 2025 09:53:31 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4748F195608F; Wed, 21 May 2025 09:53:25 +0000 (UTC)
Date: Wed, 21 May 2025 11:53:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 03/24] block/snapshot: move drain outside of
 read-locked bdrv_snapshot_delete()
Message-ID: <aC2ik_hczX3nu_tH@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-4-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-4-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> More granular draining is not trivially possible, because
> bdrv_snapshot_delete() can recursively call itself.
> 
> The return value of bdrv_all_delete_snapshot() changes from -1 to
> -errno propagated from failed sub-calls. This is fine for the existing
> callers of bdrv_all_delete_snapshot().
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Use 'must be drained' instead of 'needs to be drained'.
> * Use goto for cleanup/error handling in bdrv_all_delete_snapshot().
> * Don't use atomics to access bs->quiesce_counter.
> 
>  block/snapshot.c | 26 +++++++++++++++-----------
>  blockdev.c       | 25 +++++++++++++++++--------
>  qemu-img.c       |  2 ++
>  3 files changed, 34 insertions(+), 19 deletions(-)

> @@ -571,19 +569,22 @@ int bdrv_all_delete_snapshot(const char *name,
>      ERRP_GUARD();
>      g_autoptr(GList) bdrvs = NULL;
>      GList *iterbdrvs;
> +    int ret = 0;

The initialisation here is technically not needed...

>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> -    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
> -        return -1;
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
> +
> +    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
> +    if (ret < 0) {
> +        goto out;
>      }

...because ret is assigned here before anyone reads it. But it doesn't
hurt either, so:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>



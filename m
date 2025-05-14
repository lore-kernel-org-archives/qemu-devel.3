Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51594C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFLq-0001LY-E0; Wed, 14 May 2025 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFLo-0001Gn-US
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFFLn-0005zU-Ey
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747241578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EY4ve/+Lp62bT0DfzCnPV7RhgdlVV/6MA/q9pFP7zs=;
 b=d+lN8QyxsrTT38H+v5/naIo+gweyPNmOdFEyRs056XTCSOstNJl04fN8lHcS3UPIvct7QE
 Y9KhQdlbm7zbafNZ45RAIE6HB5yOHrY3vPKopLM6fufku8G/tziEIAh/f4XD0FnlCar9cW
 FRJx35JKFlPSXfxeQBPTAZeK4spy0ms=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-b68njEjdMiuvRi_cjqllTQ-1; Wed,
 14 May 2025 12:52:53 -0400
X-MC-Unique: b68njEjdMiuvRi_cjqllTQ-1
X-Mimecast-MFC-AGG-ID: b68njEjdMiuvRi_cjqllTQ_1747241571
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D560719560AB; Wed, 14 May 2025 16:52:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E03730001A1; Wed, 14 May 2025 16:52:46 +0000 (UTC)
Date: Wed, 14 May 2025 18:52:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH 03/11] block/snapshot: move drain outside of read-locked
 bdrv_snapshot_delete()
Message-ID: <aCTKXFeACdBnrIZ-@redhat.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-4-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508140936.3344485-4-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> 
> More granular draining is not trivially possible, because
> bdrv_snapshot_delete() can recursively call itself.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/snapshot.c | 18 ++++++++++++------
>  blockdev.c       | 25 +++++++++++++++++--------
>  qemu-img.c       |  2 ++
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index 22567f1fb9..7788e1130b 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -327,7 +327,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>  
>  /**
>   * Delete an internal snapshot by @snapshot_id and @name.
> - * @bs: block device used in the operation
> + * @bs: block device used in the operation, needs to be drained

Forgot to add this piece of nitpicking on the previous patch: Other
places say "must be drained", which I slightly prefer because of how
RFC 2119 has "MUST", but not "NEEDS TO". Matter of taste, I guess, but
if you agree, we could change it for the non-RFC series.

>   * @snapshot_id: unique snapshot ID, or NULL
>   * @name: snapshot name, or NULL
>   * @errp: location to store error
> @@ -356,6 +356,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>      BlockDriverState *fallback_bs = bdrv_snapshot_fallback(bs);
>      int ret;
>  
> +    assert(qatomic_read(&bs->quiesce_counter) > 0);
> +
>      GLOBAL_STATE_CODE();
>  
>      if (!drv) {
> @@ -368,9 +370,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>          return -EINVAL;
>      }
>  
> -    /* drain all pending i/o before deleting snapshot */
> -    bdrv_drained_begin(bs);
> -
>      if (drv->bdrv_snapshot_delete) {
>          ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
>      } else if (fallback_bs) {
> @@ -382,7 +381,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
>          ret = -ENOTSUP;
>      }
>  
> -    bdrv_drained_end(bs);
>      return ret;
>  }
>  
> @@ -573,9 +571,13 @@ int bdrv_all_delete_snapshot(const char *name,
>      GList *iterbdrvs;
>  
>      GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    bdrv_drain_all_begin();
> +    bdrv_graph_rdlock_main_loop();
>  
>      if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
> +        bdrv_graph_rdunlock_main_loop();
> +        bdrv_drain_all_end();
>          return -1;
>      }

I think this wants to be changed into:

    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
    if (ret < 0) {
        goto out;
    }

(Changing the return value from -1 to -errno is fine for the callers.)

> @@ -594,12 +596,16 @@ int bdrv_all_delete_snapshot(const char *name,
>          if (ret < 0) {
>              error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
>                            name, bdrv_get_device_or_node_name(bs));
> +            bdrv_graph_rdunlock_main_loop();
> +            bdrv_drain_all_end();
>              return -1;
>          }

Same here.

>  
>          iterbdrvs = iterbdrvs->next;
>      }
>  
> +    bdrv_graph_rdunlock_main_loop();
> +    bdrv_drain_all_end();
>      return 0;
>  }

Kevin



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40138C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4gu-0000EG-KS; Thu, 22 May 2025 08:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI4gn-0000DT-Rf
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI4gY-00057D-QJ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747915562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hG/11CuvHu1HvUyGEUNQHX0COYeSQw/zXUoe2N0J/oU=;
 b=CGIKpc4inKi14itboHQw7xtTwyXzIcgnmcSEVtN9M4OFiYk9GxM+IKMIzVstSdpP0NCkoj
 XrciACymfzM9gakmZ1604ULb2zrQDZeaBexpoRbEGxUBPbTjCqxlFnI7ZPHxsUlg9lJYB7
 Kspa91tG424AJq9BbgJjzta34vZw7Ec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-MjqP47shOcqXNcfhU3zW7g-1; Thu,
 22 May 2025 08:05:58 -0400
X-MC-Unique: MjqP47shOcqXNcfhU3zW7g-1
X-Mimecast-MFC-AGG-ID: MjqP47shOcqXNcfhU3zW7g_1747915557
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D294B1800258; Thu, 22 May 2025 12:05:55 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.76])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31139195801F; Thu, 22 May 2025 12:05:49 +0000 (UTC)
Date: Thu, 22 May 2025 14:05:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 08/24] block: move drain outside of
 bdrv_change_aio_context() and mark GRAPH_RDLOCK
Message-ID: <aC8TG0ut33F_kkMP@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-9-f.ebner@proxmox.com>
 <aC35wP_tPcNzFvP9@redhat.com>
 <da1004d1-6366-4d2f-bc71-fd20de054bde@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1004d1-6366-4d2f-bc71-fd20de054bde@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

Am 22.05.2025 um 11:09 hat Fiona Ebner geschrieben:
> Am 21.05.25 um 18:05 schrieb Kevin Wolf:
> > Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> >> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
> >>
> >> Note that even if bdrv_drained_begin() would already be marked as
> > 
> > "if ... were already marked"
> 
> Ack.
> 
> ---snip 8<---
> 
> >> diff --git a/block.c b/block.c
> >> index 01144c895e..7148618504 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -106,9 +106,9 @@ static void bdrv_reopen_abort(BDRVReopenState *reopen_state);
> >>  
> >>  static bool bdrv_backing_overridden(BlockDriverState *bs);
> >>  
> >> -static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> >> -                                    GHashTable *visited, Transaction *tran,
> >> -                                    Error **errp);
> >> +static bool GRAPH_RDLOCK
> >> +bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> >> +                        GHashTable *visited, Transaction *tran, Error **errp);
> > 
> > For static functions, we should have rhe GRAPH_RDLOCK annotation both
> > here and in the actual definition, too.
> 
> Will fix in v3!
> 
> >>  /* If non-zero, use only whitelisted block drivers */
> >>  static int use_bdrv_whitelist;
> >> @@ -3040,8 +3040,10 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
> >>  
> >>          /* No need to visit `child`, because it has been detached already */
> >>          visited = g_hash_table_new(NULL, NULL);
> >> +        bdrv_drain_all_begin();
> >>          ret = s->child->klass->change_aio_ctx(s->child, s->old_parent_ctx,
> >>                                                visited, tran, &error_abort);
> >> +        bdrv_drain_all_end();
> >>          g_hash_table_destroy(visited);
> >>  
> >>          /* transaction is supposed to always succeed */
> >> @@ -3122,9 +3124,11 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
> >>              bool ret_child;
> >>  
> >>              g_hash_table_add(visited, new_child);
> >> +            bdrv_drain_all_begin();
> >>              ret_child = child_class->change_aio_ctx(new_child, child_ctx,
> >>                                                      visited, aio_ctx_tran,
> >>                                                      NULL);
> >> +            bdrv_drain_all_end();
> >>              if (ret_child == true) {
> >>                  error_free(local_err);
> >>                  ret = 0;
> > 
> > Should we document in the header file that BdrvChildClass.change_aio_ctx
> > is called with the node drained?
> > 
> > We could add assertions to bdrv_child/parent_change_aio_context or at
> > least comments to this effect. (Assertions might be over the top because
> > it's easy to verify that both are only called from
> > bdrv_change_aio_context().)
> 
> Sounds good. Would the following be okay?
> 
> For bdrv_parent_change_aio_context() and for change_aio_ctx() the same
> (except the name of @child is @c for the former):
> 
> > /*
> >  * Changes the AioContext of for @child to @ctx and recursively for the
> >  * associated block nodes and all their children and parents. Returns true if

"of for"?

This might be a bit too specific for child_of_bds, while the function is
also implemented for BlockBackends and block jobs. Keeping the
description more in line with other BdrvChildClass functions, maybe
something generic like:

    Notifies the parent that the child is trying to change its
    AioContext. The parent may in turn change the AioContext of other
    nodes in the same transaction.

> >  * the change is possible and the transaction @tran can be continued. Returns
> >  * false and sets @errp if not and the transaction must be aborted.
> >  *
> >  * @visited will accumulate all visited BdrvChild objects. The caller is
> >  * responsible for freeing the list afterwards.
> >  *
> >  * Must be called with the affected block nodes drained.
> >  */
> 
> and for bdrv_child_change_aio_context() slightly different:
> 
> > /*
> >  * Changes the AioContext of for @c->bs to @ctx and recursively for all its

Again "of for".

> >  * children and parents. Returns true if the change is possible and the
> >  * transaction @tran can be continued. Returns false and sets @errp if not and
> >  * the transaction must be aborted.
> >  *
> >  * @visited will accumulate all visited BdrvChild objects. The caller is
> >  * responsible for freeing the list afterwards.
> >  *
> >  * Must be called with the affected block nodes drained.
> >  */

The rest looks good. (Much better than what I would have done, I was
only thinking of the last line without a proper documentation of the
whole function.)

Kevin



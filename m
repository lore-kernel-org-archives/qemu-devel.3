Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149CC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTmR-00034Y-1T; Mon, 26 May 2025 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTmJ-000340-RM
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJTmH-0000iY-OS
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+tEYPInPC8HcbqoZL0jNLDxJO6cFDnaR3m+D7wNKio=;
 b=Hy2dnjhTYV1elJzUIkIA1cLMg0cGh8+xUUZodWDLD1EoDIYz8X8wXoNsEM3nMR2ZSfLH/M
 ku5B2pu0mSBARfRD0dwRpZskTXeH0RbkyAdsCwdaf/sLPBO68lXBFslMlJmno9+J0u6iAI
 hYyTMH2EyL/20Xp97froC7fHTdzK+gk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-av34zpLMO6uKFPJ7iamdrg-1; Mon,
 26 May 2025 05:05:43 -0400
X-MC-Unique: av34zpLMO6uKFPJ7iamdrg-1
X-Mimecast-MFC-AGG-ID: av34zpLMO6uKFPJ7iamdrg_1748250341
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB2871800374; Mon, 26 May 2025 09:05:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD6331956095; Mon, 26 May 2025 09:05:28 +0000 (UTC)
Date: Mon, 26 May 2025 11:05:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, den@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net,
 ari@tuxera.com, tbaeder@redhat.com
Subject: Re: [PATCH v2 07/24] block: mark bdrv_child_change_aio_context()
 GRAPH_RDLOCK
Message-ID: <aDQu1vCXPdJ8vAH-@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-8-f.ebner@proxmox.com>
 <9f8355c0-3e00-4e9b-b8dd-3997f5236a6a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8355c0-3e00-4e9b-b8dd-3997f5236a6a@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 23.05.2025 um 19:20 hat Andrey Drobyshev geschrieben:
> On 5/20/25 1:29 PM, Fiona Ebner wrote:
> > This is a small step in preparation to mark bdrv_drained_begin() as
> > GRAPH_UNLOCKED. More concretely, it is in preparatoin to move the
> > drain out of bdrv_change_aio_context() and marking that function as
> > GRAPH_RDLOCK.
> > 
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> > 
> > New in v2.
> > 
> >  include/block/block-global-state.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
> > index 9be34b3c99..aad160956a 100644
> > --- a/include/block/block-global-state.h
> > +++ b/include/block/block-global-state.h
> > @@ -274,9 +274,10 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag);
> >  int bdrv_debug_resume(BlockDriverState *bs, const char *tag);
> >  bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
> >  
> > -bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
> > -                                   GHashTable *visited, Transaction *tran,
> > -                                   Error **errp);
> > +bool GRAPH_RDLOCK
> > +bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
> > +                              GHashTable *visited, Transaction *tran,
> > +                              Error **errp);
> >  int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
> >                                  BdrvChild *ignore_child, Error **errp);
> >  
> 
> I think we might as well add the GRAPH_RDLOCK mark to the actual
> function definition in block.c for better readability.

We don't do this for public functions. The reason is that TSA can't
catch it if you annotate the function definition, but forget it in the
header file. So to the human reader (and in code after the definition in
the same file) it would look like the lock is taken, but in reality
callers in other source files can call the function without holding the
lock.

If https://github.com/llvm/llvm-project/pull/67520 is merged eventually,
we can reconsider this rule, but for now, it's better to keep it.

Kevin



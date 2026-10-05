Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08E7CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqM1-0002Af-Cr; Mon, 05 Oct 2026 17:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDqLy-00029N-Qr
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDqLw-0002DM-DG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791236167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A4RRJYbB+rF3PxxxenrjlAErBNkcBxXJzIQIT6rzrpQ=;
 b=CmLNzLJpk7y+5CO1YH2tum5r7QIqxb5hphZ9HYbr+1wIFrgt6Ml9/w5GCl6PQDbANSMLQH
 91ZwnTLkyaPQWZrSCqTrPpUurZrlrQYr49iqCo3Ab40yxs0d96JRdpNY0ovAYmfERVtAnk
 EzwRhXW7/qvkjFUT/KU/SSFtY1ZSvPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-Lin9DhHhMKSW9OWw6jo2kA-1; Mon,
 05 Oct 2026 17:36:03 -0400
X-MC-Unique: Lin9DhHhMKSW9OWw6jo2kA-1
X-Mimecast-MFC-AGG-ID: Lin9DhHhMKSW9OWw6jo2kA_1791236162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5633D195BDEE; Mon,  5 Oct 2026 21:36:02 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A38921800446; Mon,  5 Oct 2026 21:35:59 +0000 (UTC)
Date: Mon, 5 Oct 2026 16:35:56 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] migration/block-dirty-bitmap: fix postcopy abort
 with bitmaps on several nodes
Message-ID: <asQUhvM5iDFi6PAR@redhat.com>
References: <20260924115611.4098417-1-den@openvz.org>
 <20260924115611.4098417-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924115611.4098417-2-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 24, 2026 at 01:56:10PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> With dirty bitmaps on more than one node, the source switches nodes
> during the postcopy bulk phase and sends the node name again. The
> destination reads those chunks in the postcopy listen thread, which does
> not hold the BQL, and resolves the name through bdrv_lookup_bs():
> 
>   qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
>   `qemu_in_main_thread()' failed.
> 
> The bdrv_find_dirty_bitmap() call right after it needs the BQL or the
> dirty bitmap lock as well. Taking the BQL there would deadlock: the
> listen thread holds s->lock, and dirty_bitmap_mig_before_vm_start()
> takes s->lock with the BQL held.
> 
> Every node and bitmap that a non-START chunk refers to was set up by a
> START chunk, and those are loaded under the BQL during setup. Record the
> node alias there, and resolve all other chunks against s->bitmaps
> instead of the block graph.
> 
> Bitmaps on a single node never resend the node name after setup, which
> is why migrate-bitmaps-postcopy-test does not catch this.
> 
> Fixes: f791bf7f93f2 ("assertions for block global state API")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: qemu-stable@nongnu.org
> ---
>  migration/block-dirty-bitmap.c | 59 +++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 1b8f39c12b..61691ee4cc 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -136,6 +136,7 @@ typedef struct DBMSaveState {
>  } DBMSaveState;
>  
>  typedef struct LoadBitmapState {
> +    char node_alias[256];

Is making this fixed-length rather than malloc'd char* correct?

/me checks

migration/block-dirty-bitmap.c:    char node_alias[256];

Yep. I'm a bit surprised we did it that way earlier, but this is
correct. That said, if enough structs reference the same size, we may
want a #define or enum named value in a header, rather than a magic
number at each use site.

> +/*
> + * Only START chunks are guaranteed to be loaded under the BQL; the rest may
> + * come from the postcopy listen thread and must not touch the block graph.
> + */
> +static BlockDriverState *dirty_bitmap_load_find_bs(DBMLoadState *s,
> +                                                   const char *device,
> +                                                   const char *node_name,
> +                                                   Error **errp)
> +{
> +    GSList *item;
> +
> +    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
> +        return bdrv_lookup_bs(device, node_name, errp);
> +    }
> +
> +    for (item = s->bitmaps; item; item = g_slist_next(item)) {
> +        LoadBitmapState *b = item->data;
> +
> +        if (!strcmp(b->node_alias, s->node_alias)) {
> +            return b->bs;
> +        }
> +    }
> +
> +    error_setg(errp, "Error: no migrated bitmaps on node alias '%s'",
> +               s->node_alias);

Drop the "Error: " prefix; it will be redundant if the caller reports
rather than ignores the error.

Otherwise, this makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



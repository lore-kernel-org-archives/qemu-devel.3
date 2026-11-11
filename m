Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C08606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EI/RXko0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRAyG-0006T5-7N; Wed, 11 Nov 2026 11:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRAyE-0006SK-8e
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRAyC-0005w5-7w
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794413682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D8RnwpCDBr4ELQYjHroLORK1SRwDMgX2DMLgi4YTih4=;
 b=EI/RXko070eQ2kTeGEsyxPpw0FGYdODMRRbG5wUJ2wPTeOHBZV4fi/jyHAojY7db8SzjW9
 WE8IflIoXwaJeqqPxrBrh1Da3CWned6qIulqk+FZIu+naV5DEEL2TeiJE4fUo5dxdFh3dP
 /yCZSuG/qEf0cIzwbn5usJEg9WR4sD0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Xf57ylnhMhyf3S13igsDXw-1; Wed,
 11 Nov 2026 11:14:39 -0500
X-MC-Unique: Xf57ylnhMhyf3S13igsDXw-1
X-Mimecast-MFC-AGG-ID: Xf57ylnhMhyf3S13igsDXw_1794413678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C8101800632; Wed, 11 Nov 2026 16:14:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC173195608B; Wed, 11 Nov 2026 16:14:34 +0000 (UTC)
Date: Wed, 11 Nov 2026 10:14:32 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org
Subject: Re: [PATCH] migration/block-dirty-bitmap: don't hold the load lock
 across stream reads
Message-ID: <avSSfOePcQNalVcV@redhat.com>
References: <20261110155113.2721134-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110155113.2721134-1-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:24:08PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> dirty_bitmap_load() takes dbm_state.load.lock for each chunk and holds
> it while it reads the chunk from the migration stream.
> 
> In precopy the load runs in the incoming migration coroutine, which
> yields in qemu_fill_buffer() while it waits for data, still holding
> the lock. A quit on the destination at that point never completes:
> migration_shutdown() calls dirty_bitmap_mig_cancel_incoming(), which
> takes the same lock in the same main thread.
> 
> In postcopy the load runs in the listen thread, and the main thread
> takes the lock in dirty_bitmap_mig_before_vm_start(), called from
> loadvm_postcopy_handle_run_bh(), and in migration_shutdown(). The main
> loop then waits until the source sends the next chunk.
> 
> Read each chunk into a DBMLoadChunk first and take the lock only to
> resolve the names and apply the chunk. The lock protects the bitmaps
> list and the resolved node and bitmap, which the main thread uses. The
> flags and alias strings read from the stream are only touched by the
> code doing the load.

I'm guessing this should be considered for 11.2, and necessary as a
followup for the recent commit 4d11088a "migration/block-dirty-bitmap:
fix postcopy abort...")?

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: qemu-block@nongnu.org
> ---
>  migration/block-dirty-bitmap.c | 222 +++++++++++++++++++--------------
>  1 file changed, 130 insertions(+), 92 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 35623379eb..14e5a984e4 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c

> -static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
> +static int dirty_bitmap_load_bits(DBMLoadState *s, DBMLoadChunk *c)
>  {
...
> -        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
> -                                                           first_byte,
> -                                                           nr_bytes);
> -
> -        if (needed_size > buf_size ||
> -            buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
> -             /* Here used same alignment as in send_bitmap_bits */
> -        ) {

It looks odd to see a comment appear mid-argument, which results in
unusual formatting...

> -            error_report("Migrated bitmap granularity doesn't "
> -                         "match the destination bitmap '%s' granularity",
> -                         bdrv_dirty_bitmap_name(s->bitmap));
> -            cancel_incoming_locked(s);
> -            return 0;
> -        }
> +    if (s->cancelled) {
> +        return 0;
> +    }
>  
> -        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
> -                                           false);
> +    needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
> +                                                       c->first_byte,
> +                                                       c->nr_bytes);
> +
> +    if (needed_size > c->buf_size ||
> +        c->buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
> +         /* Here used same alignment as in send_bitmap_bits */
> +    ) {

...which then got preserved with an unindent. Not worth cleaning up,
but it did make me do a double-take.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



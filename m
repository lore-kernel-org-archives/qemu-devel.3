Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7246C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDjQ-0006on-17; Tue, 09 Apr 2024 11:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ruDjH-0006l0-Ro
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ruDjF-00077y-NT
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712677784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w7Bsc4uznrT5ksMXhJdZ0vxKI+BIJmCr1cqx4d4P8Y=;
 b=c+mPTYBCCc7ZDW2Z8oWT8I1y58zKMdh/FoszF6yFHkHPMshUFA2LXjEeIpIw8znWgJlZ+J
 aztVZXJ2w4p5+VaQiYfaYj4PhBSx3cDEZorf28EnS6DGhDTrGpfiKP908wLo9jCgranisD
 aruiS4r8zyfrQwvxi41jZCRLQinnVvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562--It6wc6vMzKQJsqE08sPAA-1; Tue, 09 Apr 2024 11:49:42 -0400
X-MC-Unique: -It6wc6vMzKQJsqE08sPAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7157A802CA7;
 Tue,  9 Apr 2024 15:49:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B1F40B497A;
 Tue,  9 Apr 2024 15:49:41 +0000 (UTC)
Date: Tue, 9 Apr 2024 10:49:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v5 2/2] nbd/server: Mark negotiation functions as
 coroutine_fn
Message-ID: <eu34jjayqnpqsubkv4wpxogh6dwaok2t35udee4ojpvn5imcv3@n75m44kvv64u>
References: <20240408160214.1200629-4-eblake@redhat.com>
 <20240408160214.1200629-6-eblake@redhat.com>
 <f00ac999-fb9b-4429-b5b9-be27153f77a5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00ac999-fb9b-4429-b5b9-be27153f77a5@yandex-team.ru>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 09, 2024 at 09:30:39AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 08.04.24 19:00, Eric Blake wrote:
> > nbd_negotiate() is already marked coroutine_fn.  And given the fix in
> > the previous patch to have nbd_negotiate_handle_starttls not create
> > and wait on a g_main_loop (as that would violate coroutine
> > constraints), it is worth marking the rest of the related static
> > functions reachable only during option negotiation as also being
> > coroutine_fn.
> > 
> > Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >   nbd/server.c | 102 +++++++++++++++++++++++++++++----------------------
> >   1 file changed, 59 insertions(+), 43 deletions(-)
> > 
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 98ae0e16326..1857fba51c1 100644
> 
> [..]
> 
> >   {
> >       int rc;
> >       g_autofree char *name = NULL;
> > @@ -755,7 +764,8 @@ struct NBDTLSServerHandshakeData {
> >       Coroutine *co;
> >   };
> > 
> > -static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> > +static coroutine_fn void
> 
> This is not, that's a callback for tls handshake, which is not coroutine context as I understand.

The call chain is:

nbd_negotiate() - coroutine_fn before this patch
  nbd_negotiate_options() - marked coroutine_fn here
    nbd_negotiate_handle_starttls() - marked coroutine_fn here
      qio_channel_tls_handshake() - in io/channel-tls.c; not marked coroutine_fn, but
                                    works both in or out of coroutine context
        ...
        nbd_server_tls_handshake() - renamed in 1/2 of this series

> without this hunk:

I can drop that particular marking.  There are cases where the
callback is reached without having done the qemu_coroutine_yield() in
nbd_negotiate_handle_starttls; but there are also cases where the IO
took enough time that the coroutine yielded and it is that callback
that reawakens it.

> 
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



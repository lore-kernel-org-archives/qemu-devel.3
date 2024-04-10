Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A01CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 12:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXSC-00027e-Eq; Wed, 10 Apr 2024 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ruXS8-00026r-Al
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1ruXS5-00025u-6k
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712753600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caZM7rtRjsuS3iLa65dZktnUNXGk0M/o/y95auFUw/U=;
 b=FH7YCVKi2sroOibzEy9LiSsS6yIE8IznN9o0fZyZZSvKBz0a0GpK6UBrKWlpoIZMS42QTA
 Y946aOq+eRcFUrDn+onEpBHvsY8/2u73k/FgCEH+92FFUNCqao7P8yBUdDSMVVwpb4otja
 IC3ZGj90Zfcif8PwWhC1e7gpUKNNqA4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-JPGQ7fxTOlOIYW10s78Czw-1; Wed,
 10 Apr 2024 08:53:16 -0400
X-MC-Unique: JPGQ7fxTOlOIYW10s78Czw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4977D3C100CC;
 Wed, 10 Apr 2024 12:53:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF53C1C06667;
 Wed, 10 Apr 2024 12:53:14 +0000 (UTC)
Date: Wed, 10 Apr 2024 07:53:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Zhu Yangyang <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v5 2/2] nbd/server: Mark negotiation functions as
 coroutine_fn
Message-ID: <2mijqphs3shdkr3j24mlcisekpsookri4q6fah5fws6veiokvb@lt6yfouqspif>
References: <20240408160214.1200629-4-eblake@redhat.com>
 <20240408160214.1200629-6-eblake@redhat.com>
 <f00ac999-fb9b-4429-b5b9-be27153f77a5@yandex-team.ru>
 <eu34jjayqnpqsubkv4wpxogh6dwaok2t35udee4ojpvn5imcv3@n75m44kvv64u>
 <67979e90-653b-410e-9ed4-02d37410dea1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67979e90-653b-410e-9ed4-02d37410dea1@yandex-team.ru>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10, 2024 at 10:05:28AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > @@ -755,7 +764,8 @@ struct NBDTLSServerHandshakeData {
> > > >        Coroutine *co;
> > > >    };
> > > > 
> > > > -static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> > > > +static coroutine_fn void
> > > 
> > > This is not, that's a callback for tls handshake, which is not coroutine context as I understand.
> > 
> > The call chain is:
> > 
> > nbd_negotiate() - coroutine_fn before this patch
> >    nbd_negotiate_options() - marked coroutine_fn here
> >      nbd_negotiate_handle_starttls() - marked coroutine_fn here
> >        qio_channel_tls_handshake() - in io/channel-tls.c; not marked coroutine_fn, but
> >                                      works both in or out of coroutine context
> >          ...
> >          nbd_server_tls_handshake() - renamed in 1/2 of this series
> > 
> > > without this hunk:
> > 
> > I can drop that particular marking.  There are cases where the
> > callback is reached without having done the qemu_coroutine_yield() in
> > nbd_negotiate_handle_starttls; but there are also cases where the IO
> > took enough time that the coroutine yielded and it is that callback
> > that reawakens it.
> 
> The key thing for me is that in this case (when coroutine yielded), nbd_server_tls_handshake() would finally be called from glib IO handler, set in
> 
>    qio_channel_tls_handshake()
>       qio_channel_tls_handshake_task()
>          qio_channel_add_watch_full()
>             g_source_set_callback(source, (GSourceFunc)func, user_data, notify);   <<<
> 
> , which would definitely not be a coroutine context.
> 
> 
> Do I understand correctly, that "coroutine_fn" means "only call from coroutine context"[1], or does it mean "could be called from coroutine context"[2]?

I'm always fuzzy on that distinction myself.  But reading the docs helps...


> 
> The comment in osdep.h says:
> 
>  * Mark a function that executes in coroutine context                                                     |}
>  *                                                                                                        |
>  * Functions that execute in coroutine context cannot be called directly from                             |
>  * normal functions. ...
> 
> So I assume, we mean [1].

...[1] sounds more appropriate.  Adding the marker is more of a
promise that "I've audited that this function does not block and is
therefore safe for a function in coroutine context to use", but
sometimes additionally implies "this function assumes a coroutine is
present; if you are not in a coroutine, things might break".  But with
a bit of thought, it is obvious that a coroutine can call functions
that are not marked with coroutine_fn: any non-blocking syscall fits
in this category (since we don't have control over system headers to
add coroutine_fn annotations to those).  So on that grounds, it is
okay for a function marked coroutine_fn to call another function not
marked coroutine_fn - it just makes the auditing harder to ensure that
you aren't violating your promise of no non-blocking calls.

It's too close to 9.0-rc3 for my comfort to include this patch series.
Even though this bug can cause wedged migrations, I'd feel more
comfortable with preparing the pull request for this series (including
your fix for dropping this one annotation) for 9.1 and for qemu-stable
once the release is complete.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



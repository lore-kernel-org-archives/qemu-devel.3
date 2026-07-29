Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03B2C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5Wg-0003I6-BU; Wed, 29 Jul 2026 10:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wp5Wf-0003Hw-AM
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wp5Wd-0008BE-5V
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785336289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmdgnSPnKN3uthYPh8zdt7PucxSbnaGqkfZSZ3N7U/g=;
 b=SjuHzUYyEZYLC7zzoPGl4rT99N+hmkrv/3ojpQf3CIGOjrk+akoijfkFD6X+OW+fZNKZ2S
 wle/Wifo1jhrJew9KbtoZdU0BFd71QZZitPxf3A7gVpkwCeZyiqvY5GcCFyUQEUkEoFaal
 ZjoutQ5Iu4np56xtFzEYVxqfWz9NBn8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-UfO3hKnRMGCxp7y-4CKAyg-1; Wed,
 29 Jul 2026 10:43:50 -0400
X-MC-Unique: UfO3hKnRMGCxp7y-4CKAyg-1
X-Mimecast-MFC-AGG-ID: UfO3hKnRMGCxp7y-4CKAyg_1785336229
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8459A18002C5; Wed, 29 Jul 2026 14:43:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDF541C; Wed, 29 Jul 2026 14:43:47 +0000 (UTC)
Date: Wed, 29 Jul 2026 15:43:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH v2 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amoRn1-uqUWjXlsc@redhat.com>
References: <20260728210417.1925078-1-peterx@redhat.com>
 <20260728210417.1925078-5-peterx@redhat.com>
 <amkfP-dtwmxzg_TC@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amkfP-dtwmxzg_TC@x1.local>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 05:29:35PM -0400, Peter Xu wrote:
> On Tue, Jul 28, 2026 at 05:04:16PM -0400, Peter Xu wrote:
> > In an unlikely case, when a migration stream is attached to the destination
> > QEMU and only send <4 bytes to the channel as magic, it's possible that
> > migration_channel_read_peek() may spin forever.
> > 
> > Fix it by adding a manual sleep for partial read.
> > 
> > Since the path isn't attached to a coroutine, it means when partial read
> > happens, there's yet not much we can do but hang the main thread, it will
> > happen even for len==0 case.  It means monitors can hang due to this,
> > either partial read or no data arrived (but connection established).
> > 
> > Leave this for later, the hope is this is extremely rare in production.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 1e2935f926..f446561b59 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >  
> >          if (len == buflen) {
> >              break;
> > +        } else if (len == 0) {
> 
> I think this should be QIO_CHANNEL_ERR_BLOCK, not 0..  I'll fix it when I
> post v3, and I'll do some more tests.

Yep, 0 == EOF, so you'll need ERR_BLOCK.

> 
> > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > +        } else {
> > +            /*
> > +             * When partially ready, we can't use qio_channel_wait_cond()
> > +             * because it will return immediately.  Apply a manual wait.
> > +             */
> > +            assert(!qemu_in_coroutine());
> > +            g_usleep(1000);

So this will block the main loop, but this is OK because

 * If the network is untrusted, migration should have been configured
   to use TLS with a certificate allow-list. This peek takes place
   after the TLS handshake so is protected
 * On the dest host, it doesn't hugely matter that we block the main
   loop as there's no running guest yet that will stall. Just any
   use of QMP commands on the dest will stall.

> >          }
> > -
> > -        qio_channel_wait_cond(ioc, G_IO_IN);
> >      }
> >  
> >      return 0;
> > -- 
> > 2.54.0
> > 
> 
> -- 
> Peter Xu
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3109CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoj70-0005L9-U6; Wed, 20 Aug 2025 09:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoj6w-0005H0-0d
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoj6s-0007O2-IT
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755697453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/XzB296YyTD60Mm6vyLW74nVkUCDB7UFuvDaxeGHp9A=;
 b=gt5iXV0bGYp/bpyBxkkUMH7/7GfDhCyhGiT4yIMts1wLsUe1TvyCPpv4or7dIBlDONREmp
 +jSQCf5P4yd5acDxTPdqzhgHrVB9okBEfYvank9twa+N1IYMOTNZu6+K6MKZ1JPKaPGGvD
 uyj3YvFhE5QKT8EkmwtWHafYLKxGejE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-2RsooUrDO2uAB9-Dg6LQjQ-1; Wed,
 20 Aug 2025 09:44:09 -0400
X-MC-Unique: 2RsooUrDO2uAB9-Dg6LQjQ-1
X-Mimecast-MFC-AGG-ID: 2RsooUrDO2uAB9-Dg6LQjQ_1755697447
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BC2E180044F; Wed, 20 Aug 2025 13:44:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1F353000198; Wed, 20 Aug 2025 13:43:58 +0000 (UTC)
Date: Wed, 20 Aug 2025 14:43:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 26/33] io/channel-socket: introduce
 qio_channel_socket_keep_nonblock()
Message-ID: <aKXRGiDQlyPyhNsh@redhat.com>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXNLfKWzHKUhGaz@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKXNLfKWzHKUhGaz@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 20, 2025 at 09:27:09AM -0400, Peter Xu wrote:
> On Wed, Aug 13, 2025 at 07:48:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > Add a possibility to keep socket non-block status when passing
> > through qio channel. We need this to support migration of open
> > fds through migration channel.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >  include/io/channel-socket.h |  3 +++
> >  io/channel-socket.c         | 16 ++++++++++++----
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > index a88cf8b3a9..0a4327d745 100644
> > --- a/include/io/channel-socket.h
> > +++ b/include/io/channel-socket.h
> > @@ -49,6 +49,7 @@ struct QIOChannelSocket {
> >      socklen_t remoteAddrLen;
> >      ssize_t zero_copy_queued;
> >      ssize_t zero_copy_sent;
> > +    bool keep_nonblock;
> >  };
> >  
> >  
> > @@ -275,4 +276,6 @@ int qio_channel_socket_set_send_buffer(QIOChannelSocket *ioc,
> >                                         size_t size,
> >                                         Error **errp);
> >  
> > +void qio_channel_socket_keep_nonblock(QIOChannel *ioc);
> > +
> >  #endif /* QIO_CHANNEL_SOCKET_H */
> > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > index 3b7ca924ff..cd93d7f180 100644
> > --- a/io/channel-socket.c
> > +++ b/io/channel-socket.c
> > @@ -462,9 +462,16 @@ static void qio_channel_socket_finalize(Object *obj)
> >  }
> >  
> >  
> > +void qio_channel_socket_keep_nonblock(QIOChannel *ioc)
> > +{
> > +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> > +    sioc->keep_nonblock = true;
> > +}
> > +
> > +
> >  #ifndef WIN32
> >  static void qio_channel_socket_copy_fds(struct msghdr *msg,
> > -                                        int **fds, size_t *nfds)
> > +                                        int **fds, size_t *nfds, bool set_block)
> >  {
> >      struct cmsghdr *cmsg;
> >  
> > @@ -497,8 +504,9 @@ static void qio_channel_socket_copy_fds(struct msghdr *msg,
> >                  continue;
> >              }
> >  
> > -            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
> > -            qemu_socket_set_block(fd);
> > +            if (set_block) {
> > +                qemu_socket_set_block(fd);
> > +            }
> 
> "keep_nonblock" as a feature in iochannel is slightly hard to digest.  It
> can also be read as "keep the fd to be always nonblocking".
> 
> Is this feature required, or can this also be done in a get() or
> post_load() on the other side to set nonblock to whatever it should be
> (that dest QEMU should be aware of)?

Either we preserve state of the flag when receiving the FD,
or every QEMU backend that we're receiving FDs on behalf of
needs to reset the flag when migration passes over the FD.

The latter might actually be a more robust scheme. If we're
migrating across QEMU versions, there is not a strict
guarantee that the new QEMU version's backend will want the
O_NONBLOCK flag in the same state as the old QEMU version.
The code might have been re-written to work in a different
way than previously.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



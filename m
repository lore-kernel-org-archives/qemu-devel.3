Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14D9C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 11:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmXK2-0001Cs-QY; Tue, 19 Mar 2024 07:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmXJw-0001Bo-IR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmXJr-0007ht-8U
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710846465;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBmrqa3sxfUAfacCA97A3V3qvSpzP2nfvScm/ojfNSE=;
 b=GGF4HX8opHfm/+8tn969mv1mJonlJuoZHOFp1eZ2m5jBluMQ1JWjOm8hmEgivykIUP3fnZ
 LeZxe/xf8Dyaas9vUygSZSjQa/8+zYPBMx3UcLo+fHnHMQ5D6vY6Z+CfabUqkXqR11Fclo
 8MaaK5icAoZ0XoMaLUIR2b9K+J7Yjro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-2ayTesYQPbepQdBibujlcg-1; Tue, 19 Mar 2024 07:07:42 -0400
X-MC-Unique: 2ayTesYQPbepQdBibujlcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54575800264;
 Tue, 19 Mar 2024 11:07:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85BFF3C54;
 Tue, 19 Mar 2024 11:07:41 +0000 (UTC)
Date: Tue, 19 Mar 2024 11:07:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/3 for 9.0] Revert "chardev: use a child source for qio
 input source"
Message-ID: <Zflxz1ssjtXQjGRf@redhat.com>
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-4-berrange@redhat.com>
 <CAJ+F1CLgjRuzBFeBneDmy0j_ZObhYc+xxueyA8k7RHYd+wckeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLgjRuzBFeBneDmy0j_ZObhYc+xxueyA8k7RHYd+wckeg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 12:20:18AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 18, 2024 at 10:25 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > This reverts commit a7077b8e354d90fec26c2921aa2dea85b90dff90,
> > and add comments to explain why child sources cannot be used.
> >
> > When a GSource is added as a child of another GSource, if its
> > 'prepare' function indicates readiness, then the parent's
> > 'prepare' function will never be run. The io_watch_poll_prepare
> > absolutely *must* be run on every iteration of the main loop,
> > to ensure that the chardev backend doesn't feed data to the
> > frontend that it is unable to consume.
> >
> > At the time a7077b8e354d90fec26c2921aa2dea85b90dff90 was made,
> > all the child GSource impls were relying on poll'ing an FD,
> > so their 'prepare' functions would never indicate readiness
> > ahead of poll() being invoked. So the buggy behaviour was
> > not noticed and lay dormant.
> >
> > Relatively recently the QIOChannelTLS impl introduced a
> > level 2 child GSource, which checks with GNUTLS whether it
> > has cached any data that was decoded but not yet consumed:
> >
> >   commit ffda5db65aef42266a5053a4be34515106c4c7ee
> >   Author: Antoine Damhet <antoine.damhet@shadow.tech>
> >   Date:   Tue Nov 15 15:23:29 2022 +0100
> >
> >     io/channel-tls: fix handling of bigger read buffers
> >
> >     Since the TLS backend can read more data from the underlying QIOChannel
> >     we introduce a minimal child GSource to notify if we still have more
> >     data available to be read.
> >
> >     Signed-off-by: Antoine Damhet <antoine.damhet@shadow.tech>
> >     Signed-off-by: Charles Frey <charles.frey@shadow.tech>
> >     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> > With this, it is now quite common for the 'prepare' function
> > on a QIOChannelTLS GSource to indicate immediate readiness,
> > bypassing the parent GSource 'prepare' function. IOW, the
> > critical 'io_watch_poll_prepare' is being skipped on some
> > iterations of the main loop. As a result chardev frontend
> > asserts are now being triggered as they are fed data they
> > are not ready to consume.
> >
> > A reproducer is as follows:
> >
> >  * In terminal 1 run a GNUTLS *echo* server
> >
> >    $ gnutls-serv --echo \
> >                  --x509cafile ca-cert.pem \
> >                  --x509keyfile server-key.pem \
> >                  --x509certfile server-cert.pem \
> >                  -p 9000
> >
> >  * In terminal 2 run a QEMU guest
> >
> >    $ qemu-system-s390x \
> >        -nodefaults \
> >        -display none \
> >        -object tls-creds-x509,id=tls0,dir=$PWD,endpoint=client \
> >        -chardev socket,id=con0,host=localhost,port=9000,tls-creds=tls0 \
> >        -device sclpconsole,chardev=con0 \
> >        -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2
> >
> > After the previous patch revert, but before this patch revert,
> > this scenario will crash:
> >
> >   qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
> >   `size <= SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
> >
> > This assert indicates that 'tcp_chr_read' was called without
> > 'tcp_chr_read_poll' having first been checked for ability to
> > receive more data
> >
> > QEMU's use of a 'prepare' function to create/delete another
> > GSource is rather a hack and not normally the kind of thing that
> > is expected to be done by a GSource. There is no mechanism to
> > force GLib to always run the 'prepare' function of a parent
> > GSource. The best option is to simply not use the child source
> > concept, and go back to the functional approach previously
> > relied on.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  chardev/char-io.c | 55 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 50 insertions(+), 5 deletions(-)
> >
> > diff --git a/chardev/char-io.c b/chardev/char-io.c
> > index 4451128cba..3c725f530b 100644
> > --- a/chardev/char-io.c
> > +++ b/chardev/char-io.c
> > @@ -33,6 +33,7 @@ typedef struct IOWatchPoll {
> >      IOCanReadHandler *fd_can_read;
> >      GSourceFunc fd_read;
> >      void *opaque;
> > +    GMainContext *context;
> >  } IOWatchPoll;
> >
> >  static IOWatchPoll *io_watch_poll_from_source(GSource *source)
> > @@ -50,28 +51,58 @@ static gboolean io_watch_poll_prepare(GSource *source,
> >          return FALSE;
> >      }
> >
> > +    /*
> > +     * We do not register the QIOChannel watch as a child GSource.
> > +     * The 'prepare' function on the parent GSource will be
> > +     * skipped if a child GSource's 'prepare' function indicates
> > +     * readiness. We need this prepare function be guaranteed
> 
> argh, indeed
> 
> I suppose the child 'prepare' could be changed to always return FALSE,
> but that would be hackish too

If the child returned 'FALSE', then that would defeat the point
of the TLS GSource. It has to return 'TRUE' in order to avoid
sleeping in poll() when there is cached data inside GNUTLS.

> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thank you for the review.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF7C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9j0b-00055G-7R; Tue, 29 Apr 2025 07:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1u9j0R-00053R-WD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1u9j0P-0006HK-D3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745925603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4TxzK1WFgWXPVjDHG/DLh2GlOiJW5utn86/pzkRT7mo=;
 b=fL47o+Q3wLHZm614+mI0mukSVaAHVRJU9qkrM0oFtFDY1cBNKEqAhjLuiU7N4ZTruC7BVW
 //JY8OkSSvTWdTsk4Wl6D7evH9DxxUNGbMBm90wQ1cOy5ZGKYst+F5vsZCy5H+CIC1M13n
 hXfwG+hGGrv0cqH9dzfbIg70UQEn9fY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-9CvwBduuOOKDZS__YogSzA-1; Tue,
 29 Apr 2025 07:20:01 -0400
X-MC-Unique: 9CvwBduuOOKDZS__YogSzA-1
X-Mimecast-MFC-AGG-ID: 9CvwBduuOOKDZS__YogSzA_1745925600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBAA51800263; Tue, 29 Apr 2025 11:19:59 +0000 (UTC)
Received: from localhost (unknown [10.42.28.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 874B019560A3; Tue, 29 Apr 2025 11:19:59 +0000 (UTC)
Date: Tue, 29 Apr 2025 12:19:58 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
Message-ID: <20250429111958.GI1450@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <877c33qzzn.fsf@pond.sub.org> <20250429091422.GG1450@redhat.com>
 <87wmb3jkoh.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmb3jkoh.fsf@pond.sub.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 29, 2025 at 01:01:34PM +0200, Markus Armbruster wrote:
> "Richard W.M. Jones" <rjones@redhat.com> writes:
> 
> > On Tue, Apr 29, 2025 at 07:49:00AM +0200, Markus Armbruster wrote:
> >> Eric Blake <eblake@redhat.com> writes:
> >> 
> >> > From: "Richard W.M. Jones" <rjones@redhat.com>
> >> >
> >> > Add multi-conn option to the NBD client.  This commit just adds the
> >> > option, it is not functional.
> >> >
> >> > Setting this to a value > 1 permits multiple connections to the NBD
> >> > server; a typical value might be 4.  The default is 1, meaning only a
> >> > single connection is made.  If the NBD server does not advertise that
> >> > it is safe for multi-conn then this setting is forced to 1.
> >> >
> >> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> >> > [eblake: also expose it through QMP]
> >> > Signed-off-by: Eric Blake <eblake@redhat.com>
> >> > ---
> >> >  qapi/block-core.json |  8 +++++++-
> >> >  block/nbd.c          | 24 ++++++++++++++++++++++++
> >> >  2 files changed, 31 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index 7f70ec6d3cb..5c10824f35b 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -4545,6 +4545,11 @@
> >> >  #     until successful or until @open-timeout seconds have elapsed.
> >> >  #     Default 0 (Since 7.0)
> >> >  #
> >> > +# @multi-conn: Request the number of parallel client connections to make
> >> > +#     to the server, up to 16.  If the server does not advertise support
> >> > +#     for multiple connections, or if this value is 0 or 1, all traffic
> >> > +#     is sent through a single connection.  Default 1 (Since 10.1)
> >> > +#
> >> 
> >> So we silently ignore @multi-conn when its value is (nonsensical) zero,
> >> and when the server doesn't let us honor the value.  Hmm.  Silently
> >> ignoring the user's wishes can result in confusion.  Should we reject
> >> instead?
> >
> > We could certainly reject 0.  It's also possible to reject the case
> > where multi-conn is not supported by the server, but is requested by
> > the client, but I feel that's a bit user-unfriendly.  After all,
> > multi-conn isn't essential for it to work, it's needed if you want
> > best performance.  (Maybe issue a warning in the code - below - where
> > we set multi-conn back to 1?  I don't know what qemu thinks about
> > warnings.)
> 
> QMP doesn't support warnings, so they go to stderr instead, where they
> may or may not be seen.
> 
> When I instruct a program to do X, I prefer it to do exactly X, and fail
> when that's not possible.  Correcting X behind my back may be friendly,
> until the day I spent quality time figuring out WTF is going on.
> 
> Perhaps this one is a matter of documentation.  As is, @multi-conn feels
> like "set the number of connections" to me, until I read the fine print,
> which contradicts it.  We could perhaps phrase it as a limit instead:
> enable multiple connections and simultaneously limit their number.

It is tricky.  In nbdcopy we've preferred to go with "you suggest some
numbers and we'll pick something that works":

https://gitlab.com/nbdkit/libnbd/-/blob/master/copy/main.c?ref_type=heads#L446-L493

but also we do provide a way for you to find out what was selected:

https://gitlab.com/nbdkit/libnbd/-/blob/master/copy/main.c?ref_type=heads#L521

(I'm not claiming this is the best approach or suitable for everyone.)

In the context of qemu that might suggest having separate
multi_conn_requested and multi_conn fields, where the latter can be
queried over QMP to find out what is actually going on.  Could even
add multi_conn_max to allow MAX_MULTI_CONN constant to be read out.

> >> >  # Features:
> >> >  #
> >> >  # @unstable: Member @x-dirty-bitmap is experimental.
> >> > @@ -4558,7 +4563,8 @@
> >> >              '*tls-hostname': 'str',
> >> >              '*x-dirty-bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
> >> >              '*reconnect-delay': 'uint32',
> >> > -            '*open-timeout': 'uint32' } }
> >> > +            '*open-timeout': 'uint32',
> >> > +            '*multi-conn': 'uint32' } }
> >> >
> >> >  ##
> >> >  # @BlockdevOptionsRaw:
> >> > diff --git a/block/nbd.c b/block/nbd.c
> >> > index d5a2b21c6d1..5eb00e360af 100644
> >> > --- a/block/nbd.c
> >> > +++ b/block/nbd.c
> >> > @@ -48,6 +48,7 @@
> >> >
> >> >  #define EN_OPTSTR ":exportname="
> >> >  #define MAX_NBD_REQUESTS    16
> >> > +#define MAX_MULTI_CONN      16
> >> 
> >> Out of curiosity: where does this value come from?
> >
> > So I should note first this is a maximum, not a recommendation.
> 
> Is it the arbitrarily chosen maximum for QEMU, or is it the well-known
> maximum for NBD, or is it something else?

I don't recall exactly, but it was probably an ass-pulled number.

> > nbdcopy defaults to 4, which was derived from testing on a high end
> > (for 2024) AMD machine.  Above 4 performance doesn't increase any
> > further on that machine.  It's going to very much depend on how many
> > cores you have spare, how many TCP connections you want to open, and
> > how effectively the client and server handle parallelism.
> >
> > And imponderables like one we hit in virt-v2v: If accessing a VMware
> > server, the VMware server actually slows down as you add more
> > connections, even though it should theoretically support multi-conn.
> > We ended up forcing multi-conn to 1 in this case.  You can't know this
> > in advance from the client side.
> >
> >> >
> >> >  #define COOKIE_TO_INDEX(cookie) ((cookie) - 1)
> >> >  #define INDEX_TO_COOKIE(index)  ((index) + 1)
> >> > @@ -97,6 +98,7 @@ typedef struct BDRVNBDState {
> >> >      /* Connection parameters */
> >> >      uint32_t reconnect_delay;
> >> >      uint32_t open_timeout;
> >> > +    uint32_t multi_conn;
> >> >      SocketAddress *saddr;
> >> >      char *export;
> >> >      char *tlscredsid;
> >> > @@ -1840,6 +1842,15 @@ static QemuOptsList nbd_runtime_opts = {
> >> >                      "attempts until successful or until @open-timeout seconds "
> >> >                      "have elapsed. Default 0",
> >> >          },
> >> > +        {
> >> > +            .name = "multi-conn",
> >> > +            .type = QEMU_OPT_NUMBER,
> >> > +            .help = "If > 1 permit up to this number of connections to the "
> >> > +                    "server. The server must also advertise multi-conn "
> >> > +                    "support.  If <= 1, only a single connection is made "
> >> > +                    "to the server even if the server advertises multi-conn. "
> >> > +                    "Default 1",
> >> 
> >> This text implies the requested value is silently limited to the value
> >> provided by the server, unlike the doc comment above.  Although the
> >> "must" in "the sever must" could also be understood as "error when it
> >> doesn't".
> >
> > I'll just note that multi-conn is a boolean flag advertised by the
> > server.  Servers don't advertise any preferred number of connections.
> > I don't know how to improve the text.
> 
> Let's get the QAPI schema doc comment right before we worry about this
> one.
> 
> >> > +        },
> >> >          { /* end of list */ }
> >> >      },
> >> >  };
> >> > @@ -1895,6 +1906,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
> >> >
> >> >      s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
> >> >      s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
> >> > +    s->multi_conn = qemu_opt_get_number(opts, "multi-conn", 1);
> >> > +    if (s->multi_conn > MAX_MULTI_CONN) {
> >> > +        s->multi_conn = MAX_MULTI_CONN;
> >> > +    }
> >> 
> >> We silently cap the user's requested number to 16.  Not clear from QAPI
> >> schema doc comment; the "up to 16" there suggests more is an error.
> >> Should we error out instead?
> >> 
> >> >
> >> >      ret = 0;
> >> >
> >> > @@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
> >> >
> >> >      nbd_client_connection_enable_retry(s->conn);
> >> >
> >> > +    /*
> >> > +     * We set s->multi_conn in nbd_process_options above, but now that
> >> > +     * we have connected if the server doesn't advertise that it is
> >> > +     * safe for multi-conn, force it to 1.
> >> > +     */
> >> > +    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
> >> > +        s->multi_conn = 1;
> >> > +    }
> >> > +
> >> >      return 0;
> >> >
> >> >  fail:
> >
> > Rich.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org



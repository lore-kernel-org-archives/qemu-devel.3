Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5363D0E6C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vpu-0002gz-EM; Mon, 21 Oct 2024 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vph-0002f0-Nk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vpf-0000hi-9Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729530278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0liHVoROa1J0qYnOxwdeEAY+BIUlw+5Mmuf3QfPiFI=;
 b=YOdhZKbGNu/BJGAUzVF/RaUuybCmW4cun60Pub0FIhQOf7sIFEXTrQGKHz6EVQluc7U4p/
 UEPAW1A5sFORM4PWiVnFI4I/UKu8dU3jyy0WySiNK0SDw4kUS66HrOS31XwCiIp64aB9Hr
 SzB8DeWQdDHoBtt9OqJQ2QdbJBbr/Uo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-G2p0AufLOpCRosdZ8ESisA-1; Mon,
 21 Oct 2024 13:04:35 -0400
X-MC-Unique: G2p0AufLOpCRosdZ8ESisA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B6241955F41; Mon, 21 Oct 2024 17:04:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAC051956088; Mon, 21 Oct 2024 17:04:32 +0000 (UTC)
Date: Mon, 21 Oct 2024 18:04:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] util: don't set SO_REUSEADDR on client sockets
Message-ID: <ZxaJnRIqZl9ock_x@redhat.com>
References: <20241021145410.1420261-1-berrange@redhat.com>
 <CAFEAcA9_9jYHHspAbR=3uXLHD=7AcMN3dQubYxsAQgyCyMOFUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9_9jYHHspAbR=3uXLHD=7AcMN3dQubYxsAQgyCyMOFUw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 21, 2024 at 05:53:17PM +0100, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 15:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Setting the SO_REUSEADDR property on a socket allows binding to a port
> > number that is in the TIMED_WAIT state. This is usually done on listener
> > sockets, to enable a server to restart itself without having to wait for
> > the completion of TIMED_WAIT on the port.
> 
> [...]
> 
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 60c44b2b56..80594ecad5 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -367,7 +367,6 @@ static int inet_connect_addr(const InetSocketAddress *saddr,
> >                           addr->ai_family);
> >          return -1;
> >      }
> > -    socket_set_fast_reuse(sock);
> >
> >      /* connect to peer */
> >      do {
> 
> We definitely want to keep the socket_set_fast_reuse()
> call in create_fast_reuse_socket() as that function is
> used (only) in the "create socket, listen, bind" server
> socket code path. (Arguably create_fast_reuse_socket()
> is a bit unnecessary as it has only one callsite.)
> 
> The one in inet_connect_addr() is clearly wrong as that's
> the client end (fixed in this patch).
> 
> How about the call in inet_dgram_saddr() ? I'm not sure how
> SO_REUSEADDR interacts with UDP sockets... (I'm assuming
> the answer is "we need it there" so I'm kind of asking for
> the code-review record really.)

We need the one in inet_dgram_saddr, because there is an
explicit bind() call there, for the situation where the
local UDP address is set.

> In net/socket.c we already set SO_REUSEADDR for dgram
> and for listening sockets but not for client ones, so
> we're now consistent there.
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



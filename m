Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C92606A330
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gnu.org header.i=@gnu.org header.a=rsa-sha256 header.s=fencepost-gnu-org header.b=ble8xtey
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSMN8-0005L8-DQ; Sat, 14 Nov 2026 17:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xSMN6-0005Ks-5M
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 17:37:20 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1xSMN4-0000Jt-Nj; Sat, 14 Nov 2026 17:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=a4Dqt6GDj7BUTxNijNnpJKJab28aWBoYzolKj9C5ido=; b=ble8xteyY62ofZ6h0Dda
 5MyDEk7D3AN4KyQn5qq8BEIOfHcA6Il//RTq872FrBZknbk0FE45WmauN0DSD/6OTdvii1hKaW532
 3gAKviDKJpekPeyQGQXxE/hAozn5v/kFhbO0t7R61utUxI8rJLokq0RRSbwcEKQN2hbYwhRNYGxTp
 f4bMc3BuXvG+3Lsx4DLhucybDHfGtHcocoDo3Dx9KtuOJWVuje6Y8aoZ6bS9RhLcC8HDDUTPDRmkn
 OgHrVZsjX0RV1EHbd4a1PPFQQ1DrtunUfT0+eLQhVoO0jBqYJzILbigelj6mI8ex98603UQVrkIaV
 VPZLoz27RANHvg==;
Date: Sat, 14 Nov 2026 23:37:15 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Gavin Li <gavin.li@samsara.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v1] net: add per-connection guestfwd unix support
Message-ID: <avjim5JwouXNASfm@end>
References: <20261107044225.2786-1-gavin.li@samsara.com>
 <avXZcIP3t8DExhse@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avXZcIP3t8DExhse@redhat.com>
Organization: I am not organized
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Daniel P. Berrangé, le jeu. 12 nov. 2026 15:21:20 +0000, a ecrit:
> On Fri, Nov 06, 2026 at 11:42:25PM -0500, Gavin Li wrote:
> > For -netdev user,guestfwd=..., add support for unix-per-connection: in
> > addition to the currently supported tcp: and cmd:. With
> > unix-per-connection:, a new connection is opened to the given unix
> > socket.  This is an improvement over the current unix: support, which
> > does not support 1:1 guest:host connections.
> 
> I'm not familiar with guestfwd, but from the manpage, I would
> rather assume that it always opens a new connection to the host
> socket for each guest connection.

No, qemu opens the unix socket at initialization and just forwards data
to it.

> What are its current semantics when two guest connections are
> initiated on the same port, if that's not happening ?

It's just mixing the data coming from the connections into the unix
connection, and sending all data from the unix connection to one of the
tcp connection.

> > diff --git a/net/slirp.c b/net/slirp.c
> > index 451c0fd1ba..b0b03b2bf5 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
> >                         "forwarding rule '%s'", config_str);
> >              return -1;
> >          }
> > +    } else if (g_str_has_prefix(p, "unix-per-connection:")) {
> 
> This is rather a mouthful as a parameter name,

It seemed a bit long to me too.

> and including '-' in the name is undesirable, since we're already
> using '-' as a general separator.

That's indeed a no-go.

> Could it be just 'unix' to match the use of 'unix' in hostfwd ?

That would prevent from being able to get the one-unix-connection
behavior.

Samuel

> > +        if (slirp_add_unix(s->slirp, &p[20], &server, port) < 0) {
> > +            error_setg(errp, "Conflicting/invalid host:port in guest "
> > +                       "forwarding rule '%s'", config_str);
> > +            return -1;
> > +        }
> >      } else {
> >          Error *err = NULL;
> >          /*
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 5fe9d73eaa..062cd39aa3 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3553,6 +3553,15 @@ SRST
> >              # and connect the TCP stream to its stdin/stdout
> >              |qemu_system| -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
> >  
> > +    ``guestfwd=[tcp]:server:port-unix-per-connection:path``
> > +        With ``unix-per-connection:``, a new connection is opened to the
> > +        given unix socket per TCP connection made by the guest. The unix socket
> > +        need not exist at startup time.
> 
> I think the existing docs probably benefit from an update to
> better show how the new parmeter is different from what I
> would think was already the semantics.
> 
> > +
> > +        .. parsed-literal::
> > +
> > +            |qemu_system| -nic user,guestfwd=tcp:10.0.2.100:1234-unix-per-connection:/tmp/socket
> > +
> >  ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
> >      Configure a host TAP network backend with ID id.
> >  
> > 
> > base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
> > -- 
> > 2.55.0
> > 


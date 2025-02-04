Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC825C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKa0-0005dd-J5; Tue, 04 Feb 2025 10:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfKZx-0005d5-JE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfKZv-0006hD-MP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738681866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QSsQg4uvCIcJhgzplszGguykLuhW0HQivP56iy/FG3Q=;
 b=UWBj3SqGdC4pm4F9kO5W8qNOcx9lX2nh4xURPKVIr4OrUqiHxLN9x1MCrGlCz2YbW/AE+Z
 rAj9JLJmE855rJwOVkFrKGfceGWI5uTwbriNcbuuQH1OuKHQMmsO4eStpR43BRkMj4yrHj
 /8PxMHZFz4yYkMvnWdipipexeBQG/FM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-lUBYEjkWNZuZDgA367ua6g-1; Tue,
 04 Feb 2025 10:11:03 -0500
X-MC-Unique: lUBYEjkWNZuZDgA367ua6g-1
X-Mimecast-MFC-AGG-ID: lUBYEjkWNZuZDgA367ua6g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B1171955DBA; Tue,  4 Feb 2025 15:11:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3621E30001BE; Tue,  4 Feb 2025 15:10:56 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:10:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6It_VosnqBYt8OI@redhat.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6ElIlavWHda8YcH@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 03, 2025 at 03:20:50PM -0500, Peter Xu wrote:
> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> > On 3.02.2025 19:20, Peter Xu wrote:
> > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > 
> > > > Multifd send channels are terminated by calling
> > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > > 
> > > > Unfortunately, this does not terminate the TLS session properly and
> > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > > 
> > > > The only reason why this wasn't causing migration failures is because
> > > > the current migration code apparently does not check for migration
> > > > error being set after the end of the multifd receive process.
> > > > 
> > > > However, this will change soon so the multifd receive code has to be
> > > > prepared to not return an error on such premature TLS session EOF.
> > > > Use the newly introduced QIOChannelTLS method for that.
> > > > 
> > > > It's worth noting that even if the sender were to be changed to terminate
> > > > the TLS connection properly the receive side still needs to remain
> > > > compatible with older QEMU bit stream which does not do this.
> > > 
> > > If this is an existing bug, we could add a Fixes.
> > 
> > It is an existing issue but only uncovered by this patch set.
> > 
> > As far as I can see it was always there, so it would need some
> > thought where to point that Fixes tag.
> 
> If there's no way to trigger a real functional bug anyway, it's also ok we
> omit the Fixes.
> 
> > > Two pure questions..
> > > 
> > >    - What is the correct way to terminate the TLS session without this flag?
> > 
> > I guess one would need to call gnutls_bye() like in this GnuTLS example:
> > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> > 
> > >    - Why this is only needed by multifd sessions?
> > 
> > What uncovered the issue was switching the load threads to using
> > migrate_set_error() instead of their own result variable
> > (load_threads_ret) which you had requested during the previous
> > patch set version review:
> > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> > 
> > Turns out that the multifd receive code always returned
> > error in the TLS case, just nothing was previously checking for
> > that error presence.
> 
> What I was curious is whether this issue also exists for the main migration
> channel when with tls, especially when e.g. multifd not enabled at all.  As
> I don't see anywhere that qemu uses gnutls_bye() for any tls session.

We've been lazy and avoided using gnutls_bye because it adds a
bunch more complexity to the shutdown sequence, and premature
shutdown from an malicious attack would be expected to cause
the QEMU protocol in the TLS channel to fail anyway.

> Does it mean we need proper gnutls_bye() somewhere?

Depends if the protocol we run over TLS can identify premature
termination itself, or whether it relies on TLS to identify
it.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



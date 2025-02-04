Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7EBC02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL1M-00073E-GG; Tue, 04 Feb 2025 10:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfL1K-00072w-KJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfL1I-0005Bk-H6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738683562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=b6XIYj/Z5yxUwTyekU7ZfW3eJL5WPyvX+W1OvPsZhEI=;
 b=USxN5J9il5LyQp6RA5Wb2H/U+ylL7lMKqLeANf9VeAQcxbKmldQVYlm5a5SZ6ue9WEoSCz
 HjFzpEqgb6uTF484By/H/cAYtWPnGaXgB5LpyEw3UxpvkSZczpP4Wu4/pxUA7/EkCTyaE/
 HZWEfr3xAg23tdmw9jRL3WwJUE3IXoQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-GUxOz_WEMYmGzkt-QwBF6A-1; Tue,
 04 Feb 2025 10:39:16 -0500
X-MC-Unique: GUxOz_WEMYmGzkt-QwBF6A-1
X-Mimecast-MFC-AGG-ID: GUxOz_WEMYmGzkt-QwBF6A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371A019560B1; Tue,  4 Feb 2025 15:39:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2BB418009AA; Tue,  4 Feb 2025 15:39:10 +0000 (UTC)
Date: Tue, 4 Feb 2025 15:39:07 +0000
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
Message-ID: <Z6I0mzWEsl5y57Zj@redhat.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <Z6Iy0wY-lsx3M71M@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6Iy0wY-lsx3M71M@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
> > On 3.02.2025 23:56, Peter Xu wrote:
> > > On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
> > > > On 3.02.2025 21:20, Peter Xu wrote:
> > > > > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> > > > > > On 3.02.2025 19:20, Peter Xu wrote:
> > > > > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > 
> > > > > > > > Multifd send channels are terminated by calling
> > > > > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > > > > > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > > > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > > > > > > 
> > > > > > > > Unfortunately, this does not terminate the TLS session properly and
> > > > > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > > > > > > 
> > > > > > > > The only reason why this wasn't causing migration failures is because
> > > > > > > > the current migration code apparently does not check for migration
> > > > > > > > error being set after the end of the multifd receive process.
> > > > > > > > 
> > > > > > > > However, this will change soon so the multifd receive code has to be
> > > > > > > > prepared to not return an error on such premature TLS session EOF.
> > > > > > > > Use the newly introduced QIOChannelTLS method for that.
> > > > > > > > 
> > > > > > > > It's worth noting that even if the sender were to be changed to terminate
> > > > > > > > the TLS connection properly the receive side still needs to remain
> > > > > > > > compatible with older QEMU bit stream which does not do this.
> > > > > > > 
> > > > > > > If this is an existing bug, we could add a Fixes.
> > > > > > 
> > > > > > It is an existing issue but only uncovered by this patch set.
> > > > > > 
> > > > > > As far as I can see it was always there, so it would need some
> > > > > > thought where to point that Fixes tag.
> > > > > 
> > > > > If there's no way to trigger a real functional bug anyway, it's also ok we
> > > > > omit the Fixes.
> > > > > 
> > > > > > > Two pure questions..
> > > > > > > 
> > > > > > >      - What is the correct way to terminate the TLS session without this flag?
> > > > > > 
> > > > > > I guess one would need to call gnutls_bye() like in this GnuTLS example:
> > > > > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> > > > > > 
> > > > > > >      - Why this is only needed by multifd sessions?
> > > > > > 
> > > > > > What uncovered the issue was switching the load threads to using
> > > > > > migrate_set_error() instead of their own result variable
> > > > > > (load_threads_ret) which you had requested during the previous
> > > > > > patch set version review:
> > > > > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> > > > > > 
> > > > > > Turns out that the multifd receive code always returned
> > > > > > error in the TLS case, just nothing was previously checking for
> > > > > > that error presence.
> > > > > 
> > > > > What I was curious is whether this issue also exists for the main migration
> > > > > channel when with tls, especially when e.g. multifd not enabled at all.  As
> > > > > I don't see anywhere that qemu uses gnutls_bye() for any tls session.
> > > > > 
> > > > > I think it's a good to find that we overlooked this before.. and IMHO it's
> > > > > always good we could fix this.
> > > > > 
> > > > > Does it mean we need proper gnutls_bye() somewhere?
> > > > > 
> > > > > If we need an explicit gnutls_bye(), then I wonder if that should be done
> > > > > on the main channel as well.
> > > > 
> > > > That's a good question and looking at the code qemu_loadvm_state_main() exits
> > > > on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
> > > > and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
> > > > in qemu_loadvm_state() - so still not until channel EOF.
> > > 
> > > I had a closer look, I do feel like such pre-mature termination is caused
> > > by explicit shutdown()s of the iochannels, looks like that can cause issue
> > > even after everything is sent.  Then I noticed indeed multifd sender
> > > iochannels will get explicit shutdown()s since commit 077fbb5942, while we
> > > don't do that for the main channel.  Maybe that is a major difference.
> > > 
> > > Now I wonder whether we should shutdown() the channel at all if migration
> > > succeeded, because looks like it can cause tls session to interrupt even if
> > > the shutdown() is done after sent everything, and if so it'll explain why
> > > you hit the issue with tls.
> > > 
> > > > 
> > > > Then I can't see anything else reading the channel until it is closed in
> > > > migration_incoming_state_destroy().
> > > > 
> > > > So most likely the main migration channel will never read far enough to
> > > > reach that GNUTLS_E_PREMATURE_TERMINATION error.
> > > > 
> > > > > If we don't need gnutls_bye(), then should we always ignore pre-mature
> > > > > termination of tls no matter if it's multifd or non-multifd channel (or
> > > > > even a tls session that is not migration-related)?
> > > > 
> > > > So basically have this patch extended to calling
> > > > qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
> > > 
> > > If above theory can stand, then eof-okay could be a workaround papering
> > > over the real problem that we shouldn't always shutdown()..
> > > 
> > > Could you have a look at below patch and see whether it can fix the problem
> > > you hit too, in replace of these two patches (including the previous
> > > iochannel change)?
> > > 
> > 
> > Unfortunately, the patch below does not fix the problem:
> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > 
> > I think that, even in the absence of shutdown(), if the sender does not
> > call gnutls_bye() the TLS session is considered improperly terminated.
> 
> Ah..
> 
> How about one more change on top of above change to disconnect properly for
> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would that
> make sense to you?

Calling gnutls_bye from qio_channel_tls_close is not viable for the
API contract of qio_channel_close. gnutls_bye needs to be able to
perform I/O, which means we need to be able to tell the caller
whether it needs to perform an event loop wait for POLLIN or POLLOUT.

This is the same API design scenario as the gnutls_handshake method.
As such I tdon't think it is practical to abstract it inside any
existing QIOChannel API call, it'll have to be standalone like
qio_channel_tls_handshake() is.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



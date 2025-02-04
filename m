Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1FCC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLXU-0002sx-TN; Tue, 04 Feb 2025 11:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfLXO-0002sD-Uu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfLXN-0005wh-0o
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738685551;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b2YjdFg+NxAIDW28eFblgjsR4zr6NFIz9n6bkf3L0Y=;
 b=bFUHEMD82Zl0TBSFu1NACiAYbaAcXHAL0etYVTcCT62m6Jf2SkR9BvQYxANuGoz0yOBLzb
 1RGxwN+dvfI8iuljrfiOkWWFOBWiaGvtghQ4usWPvEmVrOsogpNzSJHePskBhRfpTn+WD+
 iLZ/q4G/4q0p1i1/hRAZ7XYXXQkWsJU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-P4FI_83PM9uZ_mQ5km4efg-1; Tue,
 04 Feb 2025 11:12:27 -0500
X-MC-Unique: P4FI_83PM9uZ_mQ5km4efg-1
X-Mimecast-MFC-AGG-ID: P4FI_83PM9uZ_mQ5km4efg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47E3419560B0; Tue,  4 Feb 2025 16:12:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B847195608E; Tue,  4 Feb 2025 16:12:19 +0000 (UTC)
Date: Tue, 4 Feb 2025 16:12:15 +0000
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
Message-ID: <Z6I8X94q6Fpimwkn@redhat.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local> <Z6ItUtb-NhKnn8hy@redhat.com>
 <Z6I6FF_4r_uVUlWU@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6I6FF_4r_uVUlWU@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 04, 2025 at 11:02:28AM -0500, Peter Xu wrote:
> On Tue, Feb 04, 2025 at 03:08:02PM +0000, Daniel P. Berrangé wrote:
> > On Mon, Feb 03, 2025 at 01:20:01PM -0500, Peter Xu wrote:
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
> > > 
> > > Two pure questions..
> > > 
> > >   - What is the correct way to terminate the TLS session without this flag?
> > > 
> > >   - Why this is only needed by multifd sessions?
> > 
> > Graceful TLS termination (via gnutls_bye()) should only be important to
> > security if the QEMU protocol in question does not know how much data it
> > is expecting to recieve. ie it cannot otherwise distinguish between an
> > expected EOF, and a premature EOF triggered by an attacker.
> > 
> > If the migration protocol has sufficient info to know when a chanel is
> > expected to see EOF, then we should stop trying to read from the TLS
> > channel before seeing the underlying EOF.
> > 
> > Ignoring GNUTLS_E_PREMATURE_TERMINATION would be valid if we know that
> > migration will still fail corretly in the case of a malicious attack
> > causing premature termination.
> > 
> > If there's a risk that migration may succeed, but with incomplete data,
> > then we would need the full gnutls_bye dance.
> 
> IIUC that's not required for migration then, because migration should know
> exactly how much data to receive, and migration should need to verify that
> and fail if the received data didn't match the expectation along the way.
> We also have QEMU_VM_EOF as the end mark of stream.
> 
> Said that, are we sure any pre-mature termination will only happen after
> all data read in the receive buffer that was sent?
> 
> To ask in another way: what happens if the source QEMU sends everything and
> shutdown()/close() the channel, meanwhile the dest QEMU sees both (1) rest
> data to read, and (2) a pre-mature terminatino of TLS session in a read()
> syscall.  Would (2) be reported even before (1), or the order guaranteed
> that read of the residue data in (1) always happen before (2) (considering
> dest QEMU can be slow sometime on consuming the network buffers)?

That's not logically possible.

In both (1) and (2) you are issuing a read() call to the TLS channel.

The first read call(s) consume all incoming data. Only once the underlying
TCP socket read() returns 0, would GNUTLS  see that it hasn't got any
TLS "bye" packet, and thus return GNUTLS_E_PREMATURE_TERMINATION from
the layered TLS read(). IOW, if you see GNUTLS_E_PREMATURE_TERMINATION
you know you have already read all received data off the socket.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



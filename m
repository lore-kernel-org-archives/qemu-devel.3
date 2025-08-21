Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B061FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up61X-00053W-W4; Thu, 21 Aug 2025 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1up61U-00052x-LR
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1up61O-0004F2-OH
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755785525;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4aYEQLxJmPsGBQzK4OyRwnO3KV+lWydA4xY7oO7lK1w=;
 b=TqH+pubBe8D17Isn9JKP4J/HJoSBcEeFpojcLhNwh1VIQS+q9FyOt0joLr5G7pLKVULUQU
 Xby83m38Sx7BBMy4RnUMTiMgX7nEsxyXXquOGIIDIBWrlncvMbVnro06lzIPOEXuu8Tcuv
 kfdtzuNKMEPMMmVeviNA/HNV5oIqI6E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-UzF-_ERuNlqZ6KyRsy-Xrw-1; Thu,
 21 Aug 2025 10:12:02 -0400
X-MC-Unique: UzF-_ERuNlqZ6KyRsy-Xrw-1
X-Mimecast-MFC-AGG-ID: UzF-_ERuNlqZ6KyRsy-Xrw_1755785521
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C35F11956095; Thu, 21 Aug 2025 14:12:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ADD719560B0; Thu, 21 Aug 2025 14:11:54 +0000 (UTC)
Date: Thu, 21 Aug 2025 15:11:51 +0100
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
Message-ID: <aKcpJ7Ool4AwhCSo@redhat.com>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-27-vsementsov@yandex-team.ru>
 <aKXNLfKWzHKUhGaz@x1.local> <aKXRGiDQlyPyhNsh@redhat.com>
 <e3c67e47-8a5e-459f-8d76-a00032b7e013@yandex-team.ru>
 <aKcjAIVheXDJpWgV@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKcjAIVheXDJpWgV@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 21, 2025 at 09:45:36AM -0400, Peter Xu wrote:
> On Thu, Aug 21, 2025 at 03:07:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > What I dislike in the way, when we reset to blocking always, and set
> > non-blocking again where needed:
> > 
> > 1. Extra fcntl calls for nothing (I think actually, in most cases, for
> > fds passed through migration stream(s) we'll want to keep fd as is)
> >
> > 2. When we reset to blocking on target, it's visible on source and may
> > break things.
> >
> > In these series it's probably doesn't really matter, as at the time when
> > we get the descriptor on target, it should not be used anymore on source.
> >
> > But for example, in CPR-transfer, where descriptors are passed in the
> > preliminary stage, and source is running and use the descriptors, we
> > shouldn't change the non-blocking status of fd on target. Probably,
> > CPR-transfer for now only works with fds which are blpcking, so we don't
> > have a problem.
> >
> > So, I think, that better default is preserve state of the flag for fds
> > passed through migration stream. And backends may modify it if needed (I
> > think, in most cases - they will not need).
> 
> I agree having that as a default iochannel behavior is questionable.
> 
> If it was defined for any fd-passing protocols making sure nonblocking
> status is predictable (in this case, fds will be always blocking), IMHO it
> should be done in the protocol layer either constantly setting or clearing
> NONBLOCK flag before sending the fds, rather than having it silently
> processed in iochannel internals.

We explicitly did not want to rely on the senders to do this, as the
senders generally does not know what receiving QEMU wants to do with
the FDs.

Clearing the non-blocking flag was chosen to make the default state of
passed-in FDs, be identical to the default state of FDs that QEMU opens
itself. This removes the possibility of bugs we've seen in the past,
where code assumed an FD's blocking flag was in its default state you
get from 'socket()' and then broke when receiving a pre-opened FD
over QEMU in a different state.  Basically anything using SocketAddress
should be getting an FD in the same state whether opened by QEMU or
passed in.

> Do we know how many existing users are relying such behavior?  I wonder if
> we could still push this operation to the protocols that will need it, then
> we can avoid this slightly awkward iochannel feature flag, because the
> iochannel user will simply always have full control.

Primarily this is relevant to the monitor QMP/HMP, which in turns
makes it is relevant to UNIX chardevs. There are a number of other
areas in QEMU calling qio_channel_readv_full() with a non-NULL fds
argument though.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



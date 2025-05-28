Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 21:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNuO-0002yg-AM; Wed, 28 May 2025 17:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNuM-0002xn-9q
 for qemu-devel@nongnu.org; Wed, 28 May 2025 17:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNuK-0006QF-9h
 for qemu-devel@nongnu.org; Wed, 28 May 2025 17:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748466108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zFBE8SAJDDngh2zXzBJrZt3oJ0f6yCA1JCf3Pe2RTk=;
 b=cqSpp5K2ofzjgYwXgW69JBAuWLO+Ny5zQKMoSuRyUS3EurxzI5zE/50JG3sZOTkKrcVg0Z
 3IbVJ6Fi77zt8wO7OqR4c0phdQ/BQ+3MFoaXPjAxk2gBAeK2Kp3RRifwQEaSlxpE3lXTY1
 bMXc51I6wClbu/ggunQjYzKkZR6KMFo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-tywb6C0FOUObzySjb5x0Wg-1; Wed,
 28 May 2025 17:01:44 -0400
X-MC-Unique: tywb6C0FOUObzySjb5x0Wg-1
X-Mimecast-MFC-AGG-ID: tywb6C0FOUObzySjb5x0Wg_1748466103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53D4F1800256; Wed, 28 May 2025 21:01:43 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 417CF1956096; Wed, 28 May 2025 21:01:40 +0000 (UTC)
Date: Wed, 28 May 2025 16:01:38 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 04/11] aio-posix: integrate fdmon into glib event loop
Message-ID: <d6etturmeqhdesowvvsuelbiq2xe2xon7ikldhnguaa5gkl4gj@asvzkuwajicn>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-5-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 28, 2025 at 03:09:09PM -0400, Stefan Hajnoczi wrote:
> AioContext's glib integration only supports ppoll(2) file descriptor
> monitoring. epoll(7) and io_uring(7) disable themselves and switch back
> to ppoll(2) when the glib event loop is used. The main loop thread
> cannot use epoll(7) or io_uring(7) because it always uses the glib event
> loop.
> 
> Future QEMU features may require io_uring(7). One example is uring_cmd
> support in FUSE exports. Each feature could create its own io_uring(7)
> context and integrate it into the event loop, but this is inefficient
> due to extra syscalls. It would be more efficient to reuse the
> AioContext's existing fdmon-io_uring.c io_uring(7) context because
> fdmon-io_uring.c will already be active on systems where Linux io_uring
> is available.
> 
> In order to keep fdmon-io_uring.c's AioContext operational even when the
> glib event loop is used, extend FDMonOps with an API similar to
> GSourceFuncs so that file descriptor monitoring can integrate into the
> glib event loop.
> 
> A quick summary of the GSourceFuncs API:
> - prepare() is called each event loop iteration before waiting for file
>   descriptors and timers.
> - check() is called to determine whether events are ready to be
>   dispatched after waiting.
> - dispatch() is called to process events.
> 
> More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html
> 
> Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
> also implement epoll(7)- and io_uring(7)-specific file descriptor
> monitoring code for glib event loops.
> 
> Note that it's still faster to use aio_poll() rather than the glib event
> loop since glib waits for file descriptor activity with ppoll(2) and
> does not support adaptive polling. But at least epoll(7) and io_uring(7)
> now work in glib event loops.

Nice.

> 
> Splitting this into multiple commits without temporarily breaking
> AioContext proved difficult so this commit makes all the changes. The
> next commit will remove the aio_context_use_g_source() API because it is
> no longer needed.

Resulting in a big patch, but I agree that there's no easier way to do
it more incrementally.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h   | 36 ++++++++++++++++++
>  util/aio-posix.h      |  5 +++
>  tests/unit/test-aio.c |  7 +++-
>  util/aio-posix.c      | 69 ++++++++-------------------------
>  util/fdmon-epoll.c    | 52 ++++++++++++++++++++++---
>  util/fdmon-io_uring.c | 44 +++++++++++++++++++++-
>  util/fdmon-poll.c     | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  7 files changed, 239 insertions(+), 62 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



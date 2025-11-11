Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF55DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 14:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIpDp-0007Sk-Ti; Tue, 11 Nov 2025 09:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpCh-0006N0-1c
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIpCe-0002qg-5g
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 09:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762870715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CL+Cmq6fFUqzDhIKDYLGhHHPDC8Ib7bC/iDnGoWjnhg=;
 b=TpkDLkN1xuCDUhAk7Tl2pXzdZuBiTlaXhb7xJ8AzrgR6o59KnFL4kLQUWqbfIMjU90zEdY
 uO2GoO31MFEy6VPNCHZ+1VaNatrHeUl8QDomrKDWIS1qfo94jRV2DsYSD+vTOWuRIVZHOp
 gSZD7Y2u5XFKqHIGtVsRJyeMY3L//Jg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-fs5OrdmVMbm9ySYi89qi1g-1; Tue,
 11 Nov 2025 09:18:33 -0500
X-MC-Unique: fs5OrdmVMbm9ySYi89qi1g-1
X-Mimecast-MFC-AGG-ID: fs5OrdmVMbm9ySYi89qi1g_1762870713
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C2871800473; Tue, 11 Nov 2025 14:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E22630044E0; Tue, 11 Nov 2025 14:18:30 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:18:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH v2 10/12] qio: Add QIONetListener API for using AioContext
Message-ID: <aRNFs0oVp9-ZItfU@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
 <20251108230525.3169174-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108230525.3169174-24-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Nov 08, 2025 at 04:59:31PM -0600, Eric Blake wrote:
> The user "John Doe" reported a deadlock when attempting to use
> qemu-storage-daemon to serve both a base file over NBD, and a qcow2
> file with that NBD export as its backing file, from the same process,
> even though it worked just fine when there were two q-s-d processes.
> The bulk of the NBD server code properly uses coroutines to make
> progress in an event-driven manner, but the code for spawning a new
> coroutine at the point when listen(2) detects a new client was
> hard-coded to use the global GMainContext; in other words, the
> callback that triggers nbd_client_new to let the server start the
> negotiation sequence with the client requires the main loop to be
> making progress.  However, the code for bdrv_open of a qcow2 image
> with an NBD backing file uses an AIO_WAIT_WHILE nested event loop to
> ensure that the entire qcow2 backing chain is either fully loaded or
> rejected, without any side effects from the main loop causing unwanted
> changes to the disk being loaded (in short, an AioContext represents
> the set of actions that are known to be safe while handling block
> layer I/O, while excluding any other pending actions in the global
> main loop with potentially larger risk of unwanted side effects).
> 
> This creates a classic case of deadlock: the server can't progress to
> the point of accept(2)ing the client to write to the NBD socket
> because the main loop is being starved until the AIO_WAIT_WHILE
> completes the bdrv_open, but the AIO_WAIT_WHILE can't progress because
> it is blocked on the client coroutine stuck in a read() of the
> expected magic number from the server side of the socket.
> 
> This patch adds a new API to allow clients to opt in to listening via
> an AioContext rather than a GMainContext.  This will allow NBD to fix
> the deadlock by performing all actions during bdrv_open in the main
> loop AioContext.
> 
> An upcoming patch will then add a unit test (kept separate to make it
> easier to rearrange the series to demonstrate the deadlock without
> this patch).
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: Retitle and add new API rather than changing semantics of
> existing qio_net_listener_set_client_func; use qio accessor rather
> than direct access to the sioc fd and a lower-level aio call
> ---
>  include/io/net-listener.h | 16 ++++++++++++++++
>  io/net-listener.c         | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 49 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



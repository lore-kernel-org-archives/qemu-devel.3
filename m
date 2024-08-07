Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89241C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sblPs-0004sR-F4; Wed, 07 Aug 2024 14:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblPp-0004em-C6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sblPm-00063M-Rp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723055377;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3DL5fY+1h4XM5i3gTPixbwdC4381vvzw/q4aERMqgo=;
 b=VwE5pWycoam5Udi+mGVj/JgTEB4npuEl9jegW8jk57+uehfw1uvRk5zs5FAw/vcf53xaIa
 Hf1TGN3mFOXX+wEK8Lcloh/pEy3EhMT/jTWNKphxfyiHGbOpUSbUzTb2r5X4XKR2V/eS9p
 bzg7oNaG3NNDZ0xIZWsoqz+bYnYQTeE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-CGHjcbBUPOi7e2cBnc0s9Q-1; Wed,
 07 Aug 2024 14:29:34 -0400
X-MC-Unique: CGHjcbBUPOi7e2cBnc0s9Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95C41955D5E; Wed,  7 Aug 2024 18:29:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 149513000199; Wed,  7 Aug 2024 18:29:28 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:29:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 5/7] nbd/server: CVE-2024-7409: Close stray client
 sockets at shutdown
Message-ID: <ZrO9BeplRulpFbVP@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
 <20240807174943.771624-14-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807174943.771624-14-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 07, 2024 at 12:43:31PM -0500, Eric Blake wrote:
> A malicious client can attempt to connect to an NBD server, and then
> intentionally delay progress in the handshake, including if it does
> not know the TLS secrets.  Although this behavior can be bounded by
> the max-connections parameter, the QMP nbd-server-start currently
> defaults to unlimited incoming client connections.  Worse, if the
> client waits to close the socket until after the QMP nbd-server-stop
> command is executed, qemu will then SEGV when trying to dereference
> the NULL nbd_server global which is no longer present, which amounts
> to a denial of service attack.  If another NBD server is started
> before the malicious client disconnects, I cannot rule out additional
> adverse effects when the old client interferes with the connection
> count of the new server.
> 
> For environments without this patch, the CVE can be mitigated by
> ensuring (such as via a firewall) that only trusted clients can
> connect to an NBD server.  Note that using frameworks like libvirt
> that ensure that TLS is used and that nbd-server-stop is not executed
> while any trusted clients are still connected will only help if there
> is also no possibility for an untrusted client to open a connection
> but then stall on the NBD handshake.
> 
> Given the previous patches, it would be possible to guarantee that no
> clients remain connected by having nbd-server-stop sleep for longer
> than the default handshake deadline before finally freeing the global
> nbd_server object, but that could make QMP non-responsive for a long
> time.  So intead, this patch fixes the problem by tracking all client
> sockets opened while the server is running, and forcefully closing any
> such sockets remaining without a completed handshake at the time of
> nbd-server-stop, then waiting until the coroutines servicing those
> sockets notice the state change.  nbd-server-stop now has a second
> AIO_WAIT_WHILE_UNLOCKED (the first is indirectly through the
> blk_exp_close_all_type() that disconnects all clients that completed
> handshakes), but forced socket shutdown is enough to progress the
> coroutines and quickly tear down all clients before the server is
> freed, thus finally fixing the CVE.
> 
> This patch relies heavily on the fact that nbd/server.c guarantees
> that it only calls nbd_blockdev_client_closed() from the main loop
> (see the assertion in nbd_client_put() and the hoops used in
> nbd_client_put_nonzero() to achieve that); if we did not have that
> guarantee, we would also need a mutex protecting our accesses of the
> list of connections to survive re-entrancy from independent iothreads.
> 
> Although I did not actually try to test old builds, it looks like this
> problem has existed since at least commit 862172f45c (v2.12.0, 2017) -
> even back when that patch started using a QIONetListener to handle
> listening on multiple sockets, nbd_server_free() was already unaware
> that the nbd_blockdev_client_closed callback can be reached later by a
> client thread that has not completed handshakes (and therefore the
> client's socket never got added to the list closed in
> nbd_export_close_all), despite that patch intentionally tearing down
> the QIONetListener to prevent new clients.
> 
> Reported-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Fixes: CVE-2024-7409
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev-nbd.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



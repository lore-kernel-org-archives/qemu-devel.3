Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5895C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGTh-000289-1c; Tue, 06 Aug 2024 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbGTe-00026O-1k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbGTc-0002QX-4Z
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722936448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6KUktOqAR7o5UgRH5OgOaBvW94h6ziIa85YMP20k0Q=;
 b=KZIJROZuMr/FKjaSJjAW+TwEl1wuFWWpn5Mg8YuEoaGSQCU6EFTG6ujpcM8AH3o/svNaQg
 gA4UQ7EL8hAWtBrBRuoHhtrXLGvqCI4XOcMeAz9eXIVJ0D20CCW1UlBAer65Z9NXDdjTL5
 iKCjv4Gvnv5N6J4VM7vRuiyLAfvPCxQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-vgt5SrozO5mDmSj4jYGFwg-1; Tue,
 06 Aug 2024 05:27:24 -0400
X-MC-Unique: vgt5SrozO5mDmSj4jYGFwg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5CE19560BF; Tue,  6 Aug 2024 09:27:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C83981955D4A; Tue,  6 Aug 2024 09:27:19 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:27:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 1/2] nbd: CVE-2024-7409: Close stray client sockets at
 server shutdown
Message-ID: <ZrHsdA15hsFaaq1t@redhat.com>
References: <20240806022542.381883-4-eblake@redhat.com>
 <20240806022542.381883-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806022542.381883-5-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 05, 2024 at 09:21:35PM -0500, Eric Blake wrote:
> A malicious client can attempt to connect to an NBD server, and then
> intentionally delay progress in the handshake, including if it does
> not know the TLS secrets.  Although this behavior can be bounded by
> the max-connections parameter, the QMP nbd-server-start currently
> defaults to unlimited incoming client connections.  Worse, if the
> client waits to close the socket until after the QMP nbd-server-stop
> command is executed, qemu will then SEGV when trying to dereference
> the NULL nbd_server global whish is no longer present, which amounts
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
> This patch fixes the problem by tracking all client sockets opened
> while the server is running, and forcefully closing any such sockets
> remaining without a completed handshake at the time of
> nbd-server-stop, then waiting until the coroutines servicing those
> sockets notice the state change.  nbd-server-stop may now take
> slightly longer to execute, but the extra time is independent of
> client response behaviors, and is generally no worse than the time
> already taken by the blk_exp_close_all_type() that disconnects all
> clients that completed handshakes (since that code also has an
> AIO_WAIT_WHILE_UNLOCKED).  For a long-running server with lots of
> clients rapidly connecting and disconnecting, the memory used to track
> all client sockets can result in some memory overhead, but it is not a
> leak; the next patch will further optimize that by cleaning up memory
> as clients go away.  At any rate, this patch in isolation is
> sufficient to fix the CVE.
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
> even back in that patch to start using a QIONetListener to handle
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
>  blockdev-nbd.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



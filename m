Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4853CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFAi-0004Aq-Df; Tue, 04 Nov 2025 06:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGFAe-0004A1-DE
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGFAb-0002Fq-G9
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762255547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gOdY+hzldAKGBiGIp5gU8O5u0l/ZVznN1W4WLDRGsMY=;
 b=Jr13Nx0jatbvYXaEvQn/OB63UoeeIfG4ou35/K79eO6oFo4veoXGLk/bbFpdsEu7C0h1pd
 WTKhxyHqNAJpgxL+oD7d9x//m8QSeDvBGKz3yLXjeXs8k9Wae5UnHOwtiXkndTxO48YUP2
 rRN6HGB9PEOOaccN4ViRdiJ6P4lbAoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-pn29DpQLMPqXePvzhDMcTQ-1; Tue,
 04 Nov 2025 06:25:43 -0500
X-MC-Unique: pn29DpQLMPqXePvzhDMcTQ-1
X-Mimecast-MFC-AGG-ID: pn29DpQLMPqXePvzhDMcTQ_1762255542
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD080195609D; Tue,  4 Nov 2025 11:25:42 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C908180044F; Tue,  4 Nov 2025 11:25:40 +0000 (UTC)
Date: Tue, 4 Nov 2025 12:25:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 3/8] qio: Remember context of
 qio_net_listener_set_client_func_full
Message-ID: <aQnisoN92ihQ1LjG@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-13-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202849.3687643-13-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> io/net-listener.c has two modes of use: asynchronous (the user calls
> qio_net_listener_set_client_func to wake up the callback via the
> global GMainContext, or qio_net_listener_set_client_func_full to wake
> up the callback via the caller's own alternative GMainContext), and
> synchronous (the user calls qio_net_listener_wait_client which creates
> its own GMainContext and waits for the first client connection before
> returning, with no need for a user's callback).  But commit 938c8b79
> ("qio: store gsources for net listeners", v2.12.0) has a latent logic
> flaw: when qio_net_listener_wait_client finishes on its temporary
> context, it reverts all of the siocs back to the global GMainContext
> rather than the potentially non-NULL context they might have been
> originally registered with.  Similarly, if the user creates a
> net-listener, adds initial addresses, registers an async callback with
> a non-default context (which ties to all siocs for the initial
> addresses), then adds more addresses with qio_net_listener_add, the
> siocs for later addresses are blindly placed in the global context,
> rather than sharing the context of the earlier ones.
> 
> In practice, I don't think this has caused issues.  As pointed out by
> the original commit, all async callers prior to that commit were
> already okay with the NULL default context; and the typical usage
> pattern is to first add ALL the addresses the listener will pay
> attention to before ever setting the async callback.  Likewise, if a
> file uses only qio_net_listener_set_client_func instead of
> qio_net_listener_set_client_func_full, then it is never using a custom
> context, so later assignments of async callbacks will still be to the
> same global context as earlier ones.  Meanwhile, any callers that want
> to do the sync operation to grab the first client are unlikely to
> register an async callback; altogether bypassing the question of
> whether later assignments of a GSource are being tied to a different
> context over time.
> 
> I do note that chardev/char-socket.c is the only file that calls both
> qio_net_listener_wait_client (sync for a single client in
> tcp_chr_accept_server_sync), and qio_net_listener_set_client_func_full
> (several places, all with chr->gcontext, but sometimes with a NULL
> callback function during teardown).  But as far as I can tell, the two
> uses are mutually exclusive, based on the is_waitconnect parameter to
> qmp_chardev_open_socket_server.
> 
> That said, it is more robust to remember when a callback function is
> tied to a non-default context, and have both the sync wait and any
> late address additions honor that same context.  That way, the code
> will be robust even if a later user performs a sync wait for a
> specific client in the middle of servicing a longer-lived
> QIONetListener that has an async callback for all other clients.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

> @@ -160,6 +160,7 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
>      listener->io_func = func;
>      listener->io_data = data;
>      listener->io_notify = notify;
> +    listener->context = context;

Now that you show me this, I think patch 2 actually also needs to check
that context is unchanged. We don't remember the old value before this
patch, so maybe the order of patch 2 and 3 should be swapped.

Kevin



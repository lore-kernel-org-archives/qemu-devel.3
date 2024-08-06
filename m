Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A7DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 02:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9wc-0004Oc-TC; Mon, 05 Aug 2024 22:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9wZ-0004BL-Po
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sb9wY-0007ge-AC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 22:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722911337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OXNRdWcWSrPX21XNzGEaK4DwU/IzVdh6F6QHNktjhTw=;
 b=czm15Jz3UdeKg4yvEaP3zdrVbSRlxpwvoI0vwLkQT6zt/TXp/i4gEWQEoAoNp29LVV7kyC
 Qq6+ueJhjPFNPuiiae6qjO3Ra3/FLrVbV1BiJ2Clnj9ID/25RLI9M9t61kbM4RCNalezaB
 bKspipl5IwsuSekhLIqZokQ7xK2d13s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-h1m1bSdRMNyG_0iGA7ailA-1; Mon,
 05 Aug 2024 22:28:51 -0400
X-MC-Unique: h1m1bSdRMNyG_0iGA7ailA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4B01955F0D; Tue,  6 Aug 2024 02:28:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6831E1955D42; Tue,  6 Aug 2024 02:28:47 +0000 (UTC)
Date: Mon, 5 Aug 2024 21:28:44 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 andrey.drobyshev@virtuozzo.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: Re: [PATCH v2 1/3] nbd: CVE-XXX: Use cookie to track generation of
 nbd-server
Message-ID: <o6v2e2yluxyidcfncwoc52a3c3odhhqynjjwxv4gaq5nrzftb7@j722m2nygery>
References: <20240802014824.1906798-5-eblake@redhat.com>
 <20240802014824.1906798-6-eblake@redhat.com>
 <b91052fc-0286-4161-8a3b-10bd45c3485a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91052fc-0286-4161-8a3b-10bd45c3485a@yandex-team.ru>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 02, 2024 at 06:00:32PM GMT, Vladimir Sementsov-Ogievskiy wrote:
> > -static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
> > +static void nbd_blockdev_client_closed(NBDClient *client, uint32_t cookie,
> > +                                       bool ignored)
> >   {
> >       nbd_client_put(client);
> > -    assert(nbd_server->connections > 0);
> > -    nbd_server->connections--;
> > -    nbd_update_server_watch(nbd_server);
> > +    /* Ignore any (late) connection made under a previous server */
> > +    if (cookie == nbd_cookie) {
> 
> creating a getter nbd_client_get_cookie(client), and use it instead of passing together with client, will simplify the patch a lot. [*]
> 
> Hmm.. don't we need some atomic accessors for nbd_cookie? and for nbs_server->connections.. The function is called from client, which live in coroutine and maybe in another thread? At least client code do atomic accesses of client->refcount..
> 
> > +        assert(nbd_server->connections > 0);
> > +        nbd_server->connections--;
> > +        nbd_update_server_watch(nbd_server);

The client code already jumps through hoops to make sure
nbd_blockdev_client_closed() is the last thing called, and that
nbd_client_put() is only reached from the main thread (any coroutines
fired off a one-shot bh); but I added asserts in v3 to make it clear
I'm relying on the synchronous nature of coroutines yielding only at
known points and the code executing only in the main thread as the
reason why we don't need explicit locking here.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



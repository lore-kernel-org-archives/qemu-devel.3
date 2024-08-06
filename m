Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED39C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJmL-0003u8-Hh; Tue, 06 Aug 2024 08:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbJlf-0000lY-AW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbJlc-0000zw-So
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722949099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Jp4GYq0Q+y0lAIVBGLkBXkXlpXH90EQAb39NujUIDQ=;
 b=FZvqVjdDCL7BfjEtOjzEAHeiZK7pDWrjrbPkJbcV98oXT1roeacLQAuW5ukgRhbVZCUSAw
 /8dRyZb1TO/ObTYiWYpl2erJYug4o/jCtfhMihvvMQExIWYyNXX9UmKh4N1LYvok2XGYiP
 eCPBIrTBP4szJOzENsEtZ8X7DMtWjr8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-MR1GhnxoP726GbPPC6h8Aw-1; Tue,
 06 Aug 2024 08:58:17 -0400
X-MC-Unique: MR1GhnxoP726GbPPC6h8Aw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38F11955D53; Tue,  6 Aug 2024 12:58:14 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8576300019B; Tue,  6 Aug 2024 12:58:10 +0000 (UTC)
Date: Tue, 6 Aug 2024 07:58:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 2/2] nbd: Clean up clients more efficiently
Message-ID: <sx5es6bzgepmx3bsnjrtprb35iwkyzqadtf46shfcl7lkdsuxc@gjcvjopdmpzo>
References: <20240806022542.381883-4-eblake@redhat.com>
 <20240806022542.381883-6-eblake@redhat.com>
 <ZrHtxrb5dyh3eKJu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrHtxrb5dyh3eKJu@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Aug 06, 2024 at 10:32:54AM GMT, Daniel P. Berrangé wrote:
> On Mon, Aug 05, 2024 at 09:21:36PM -0500, Eric Blake wrote:
> > Since an NBD server may be long-living, serving clients that
> > repeatedly connect and disconnect, it can be more efficient to clean
> > up after each client disconnects, rather than storing a list of
> > resources to clean up when the server exits.  Rewrite the list of
> > known clients to be double-linked so that we can get O(1) deletion to
> > keep the list pruned to size as clients exit.  This in turn requires
> > each client to track an opaque pointer of owner information (although
> > qemu-nbd doesn't need to refer to it).
> 
> I tend to feel that this needs to be squashed into the previous
> patch.  The previous patch effectively creates unbounded memory
> usage in the NBD server. ie consider a client that connects and
> immediately disconnects, not sending any data, in a tight loop.
> It will "leak" NBDConn & QIOChanelSocket pointers for each
> iteration of the loop, only to be cleaned up when the NBD Server
> is shutdown.
> 
> Especially given that we tagged the previous commit with a CVE
> and not this commit,  people could be misled into backporting
> only the former commit leaving them open to the leak.

Makes sense.  Will respin v4 along those lines; although I plan to
refactor slightly: have patch 1 pick up the part of this patch that
allows server.c to track a client's owner, then patch 2 be the CVE fix
creating the doubly-linked list of QIOSocketChannel wrappers as
owners.  Also, I realized that nbd_server->connections == 0 is now
effectively redundant with QLIST_EMPTY(&nbd_server->conns), so that's
another cleanup to squash in.

> > @@ -103,14 +112,9 @@ static void nbd_server_free(NBDServerData *server)
> >       */
> >      qio_net_listener_disconnect(server->listener);
> >      object_unref(OBJECT(server->listener));
> > -    while (!QSLIST_EMPTY(&server->conns)) {
> > -        NBDConn *conn = QSLIST_FIRST(&server->conns);
> > -
> > +    QLIST_FOREACH_SAFE(conn, &server->conns, next, tmp) {
> >          qio_channel_shutdown(QIO_CHANNEL(conn->cioc), QIO_CHANNEL_SHUTDOWN_BOTH,
> >                               NULL);
> > -        object_unref(OBJECT(conn->cioc));
> > -        QSLIST_REMOVE_HEAD(&server->conns, next);
> > -        g_free(conn);
> >      }
> > 
> >      AIO_WAIT_WHILE_UNLOCKED(NULL, server->connections > 0);

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBB5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhEc-0006Hq-CK; Wed, 05 Nov 2025 12:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGhEQ-0006C9-L4
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vGhEO-0003tV-U7
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762363415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IFgw0/iwfRyWWBieintj411YlV49KaKmaUC5PPtrCrA=;
 b=QKQ7zb0FOYyEyqUoWZ9G3f8BDAZZh01M8F0J263hwAnL4Ei/DhHcqCuRcKOn+DAWzGlZxB
 mnnGuiEsCv4w+hWd0rDCuNJy9JfZNDh/L4Gnx2Gt50AEr+BUrzXKdljYg21+tSdevse+vY
 q3479yvszjFokDRlOhUAQ0U88ycpkOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-BMVQnFCaPRy-p8MYktBE2A-1; Wed,
 05 Nov 2025 12:23:33 -0500
X-MC-Unique: BMVQnFCaPRy-p8MYktBE2A-1
X-Mimecast-MFC-AGG-ID: BMVQnFCaPRy-p8MYktBE2A_1762363413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14805195606D; Wed,  5 Nov 2025 17:23:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07DCD300018D; Wed,  5 Nov 2025 17:23:30 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:23:28 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 2/8] qio: Minor optimization when callback function is
 unchanged
Message-ID: <emxeau4ezaaz2ekufiu4lyiuw2qs2dc5wwvebiughorornn4oz@gn53wczz5nmg>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-12-eblake@redhat.com>
 <aQnf8N1jv56390bF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnf8N1jv56390bF@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 04, 2025 at 12:13:52PM +0100, Kevin Wolf wrote:
> Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> > In qemu-nbd and other NBD server setups where parallel clients are
> > supported, it is common that the caller will re-register the same
> > callback function as long as it has not reached its limit on
> > simultaneous clients.  In that case, there is no need to tear down and
> > reinstall GSource watches in the GMainContext.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  io/net-listener.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/io/net-listener.c b/io/net-listener.c
> > index 0adbc409cf2..e89286ea63c 100644
> > --- a/io/net-listener.c
> > +++ b/io/net-listener.c
> > @@ -147,6 +147,10 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
> >  {
> >      size_t i;
> > 
> > +    if (listener->io_func == func && listener->io_data == data) {
> > +        return;
> > +    }
> 
> Wouldn't a change of listener->io_notify also be significant?

On paper, yes.  In practice: io_notify is usually either a free-like
function (including obect_unref in this bucket), or NULL.  In the
former, you are passing in a malloc'd or reference-counted object,
where the cleanup action at notify time will never vary (the nature of
the object being passed in determines how to clean up when it is no
longer in use).  In the latter, passing NULL means no cleanup is
necessary.  I struggle to see a scenario where you would register a
callback opaque pointer with one cleanup function, and then change
your mind to re-register the same object but a different io_notify
cleanup function.

But I'm not opposed to adding the additional check for an unchanged
io_notify in v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



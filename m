Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09312C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGeDK-0002Yz-Hr; Mon, 10 Jun 2024 08:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGeDI-0002X9-Ue
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGeDH-0007tc-9T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718022805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GO4XBaxLMaqOALhqc0MVL7g3RZdGNWRxrvPLVYI3N3M=;
 b=ZgX+xxqA6WfoiHNYicGA6jDIudEmbhWSyY75BEVDai8kzdR8u46tU1yKWX7YdWurWStRP5
 zf4ggYiucNs/8DLB+dT9Lbv+RxsBVHpxTkQkTQUNYaFB8ZZwtTQ0zoY0+ElYMvemZ+MmRD
 cu6MfR5cHaMx08AuQNWiaeCBMvQIkt0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-WwTq65lAPji3RolTHzsyzw-1; Mon,
 10 Jun 2024 08:33:22 -0400
X-MC-Unique: WwTq65lAPji3RolTHzsyzw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33B9D19560B0; Mon, 10 Jun 2024 12:33:21 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C2C619560AF; Mon, 10 Jun 2024 12:33:17 +0000 (UTC)
Date: Mon, 10 Jun 2024 07:33:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 andrey.drobyshev@virtuozzo.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
Message-ID: <ooczxb5vojkt6blp2hhyfqcvltgzemtmwmigvgeg4utngwrcpo@2rolx5gvqzlr>
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
 <810e4bf9-ba9b-4bff-976e-047e8be467ba@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810e4bf9-ba9b-4bff-976e-047e8be467ba@virtuozzo.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Jun 08, 2024 at 11:36:59AM GMT, Alexander Ivanov wrote:
> There is a bug reproducer in the attachment.

Summarizing the reproducer, you are repeatedly calling QMP
nbd-server-start/nbd-server-stop on qemu as NBD server in one thread,
and repeatedly calling 'qemu-nbd -L' in another, to try and provoke
the race where the server is stopped while qemu-nbd -L is still trying
to grab information.

> 
> 
> On 6/7/24 17:00, Alexander Ivanov wrote:
> > In some cases, the NBD server can be stopped before
> > nbd_blockdev_client_closed() is called, causing the nbd_server variable
> > to be nullified. This leads to a NULL pointer dereference when accessing
> > nbd_server.

Am I correct that the NULL pointer deref was in qemu-nbd in your
reproducer, and not in qemu-kvm?

> > 
> > Add a NULL check for nbd_server to the nbd_blockdev_client_closed()
> > function to prevent NULL pointer dereference.
> > 
> > Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> > ---
> >   blockdev-nbd.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> > index 213012435f..fb1f30ae0d 100644
> > --- a/blockdev-nbd.c
> > +++ b/blockdev-nbd.c
> > @@ -52,6 +52,9 @@ int nbd_server_max_connections(void)
> >   static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
> >   {
> >       nbd_client_put(client);
> > +    if (nbd_server == NULL) {
> > +        return;
> > +    }
> >       assert(nbd_server->connections > 0);

While this does indeed avoid the NULL dereference right here, I still
want to understand why nbd_server is getting set to NULL while there
is still an active client, and make sure we don't have any other NULL
derefs.  I'll respond again once I've studied the code a bit more.

> >       nbd_server->connections--;
> >       nbd_update_server_watch(nbd_server);
> 
> -- 
> Best regards,
> Alexander Ivanov

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



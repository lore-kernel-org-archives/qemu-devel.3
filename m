Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 21:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnm4-0002aS-Kc; Wed, 07 Aug 2024 17:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbnm1-0002WD-Jp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbnly-000385-FM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723064440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlxAMSOUL0KU0r0fKvvjgH5FZQxAgmhsjadVkTxx6hc=;
 b=jSMdYdxop0Z0L1sZ1zuA8lD78gHfhaF3Kg0Dscm/7XYEHu4J3bX8YJoMKN7/7U4cbiZBj5
 tlOKWXGf6bh3lRSJZWPtPTLwQ+FxX4Yi409cPY6pv+TEXxfSPFk8PkJ+nR054pznuQU/a7
 FR2jsaOrIr8HhazzApnk6MOtA3SKnS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-b41ngP3qN4SNN3MaRfZSrg-1; Wed,
 07 Aug 2024 17:00:37 -0400
X-MC-Unique: b41ngP3qN4SNN3MaRfZSrg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3317A1944CF2; Wed,  7 Aug 2024 21:00:35 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F9D519560A7; Wed,  7 Aug 2024 21:00:31 +0000 (UTC)
Date: Wed, 7 Aug 2024 16:00:29 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 2/7] nbd/server: Plumb in new args to nbd_client_add()
Message-ID: <tk5xmfx4xjntlurr7ijjf2x6fy636smwirlkrihszvshcw2kic@t72ctdboompw>
References: <20240807174943.771624-9-eblake@redhat.com>
 <20240807174943.771624-11-eblake@redhat.com>
 <ZrO1zME-67HcGn0Z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrO1zME-67HcGn0Z@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 07, 2024 at 06:58:36PM GMT, Daniel P. Berrangé wrote:
> On Wed, Aug 07, 2024 at 12:43:28PM -0500, Eric Blake wrote:
> > Upcoming patches to fix a CVE need to track an opaque pointer passed
> > in by the owner of a client object, as well as reequest for a time

s/reequest/request/

> > limit on how fast negotiation must complete.  Prepare for that by
> > changing the signature of nbd_client_new() and adding an accessor to
> > get at the opaque pointer, although for now the two servers
> > (qemu-nbd.c and blockdev-nbd.c) do not change behavior.
> > 
> > Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  include/block/nbd.h | 11 ++++++++++-
> >  blockdev-nbd.c      |  6 ++++--
> >  nbd/server.c        | 20 +++++++++++++++++---
> >  qemu-nbd.c          |  4 +++-
> >  4 files changed, 34 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/block/nbd.h b/include/block/nbd.h
> > index 4e7bd6342f9..5fe14786414 100644
> > --- a/include/block/nbd.h
> > +++ b/include/block/nbd.h
> > @@ -33,6 +33,12 @@ typedef struct NBDMetaContexts NBDMetaContexts;
> > 
> >  extern const BlockExportDriver blk_exp_nbd;
> > 
> > +/*
> > + * NBD_DEFAULT_HANDSHAKE_LIMIT: Number of seconds in which client must
> > + * succeed at NBD_OPT_GO before being forcefully dropped as too slow.
> > + */
> > +#define NBD_DEFAULT_HANDSHAKE_LIMIT 10
> 
> Suggest
> 
> s/NBD_DEFAULT_HANDSHAKE_LIMIT/NBD_DEFAULT_HANDSHAKE_MAX_SECS/

I like it.

> 
> 
> > +
> >  /* Handshake phase structs - this struct is passed on the wire */
> > 
> >  typedef struct NBDOption {
> > @@ -403,9 +409,12 @@ AioContext *nbd_export_aio_context(NBDExport *exp);
> >  NBDExport *nbd_export_find(const char *name);
> > 
> >  void nbd_client_new(QIOChannelSocket *sioc,
> > +                    uint32_t handshake_limit,
> 
> s/handshake_limit/handshake_max_secs/
> 
> to make the units of the parameter self-documenting.
> 
> Since this is a non-functional suggestion
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Will adjust the series with the fallout.

At this point, I'm leaning towards queuing 1-5 in an upcoming pull
request, but leaving 6-7 for the 9.2 development cycle.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



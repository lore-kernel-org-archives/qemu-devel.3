Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C960E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJgcJ-0004za-4x; Fri, 06 Dec 2024 17:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgcH-0004zF-8B
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgcF-0004yX-Hq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733523362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9u7Znw1pbPoc1Y4P76pQPGRxcPMLoD3Dmzksu/Bdz8I=;
 b=V+j1C0/ay+ceNTk/xWt3V8vtf3V0fCcLlt9FLgP808JTjs0nH5eDHbVv/8rT2aQNn9lSjg
 edyQPgREunrh+D0a3L5TIyW3XVB7pL9FvblM9yUIUoZd8KuWyFtkF+q2lz8BUUuM93HQ6j
 Te6FwQC/XYPtJ1xMLvCsSBGdlvvJoWc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-FBHMMFDCNjCRka0ZCqnT1w-1; Fri, 06 Dec 2024 17:16:01 -0500
X-MC-Unique: FBHMMFDCNjCRka0ZCqnT1w-1
X-Mimecast-MFC-AGG-ID: FBHMMFDCNjCRka0ZCqnT1w
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-841ac3f9391so237171539f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733523360; x=1734128160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9u7Znw1pbPoc1Y4P76pQPGRxcPMLoD3Dmzksu/Bdz8I=;
 b=JqUq8ZYSPSQ36hp6igi9L23JGpZKlbCbfc1KIpjzh2fa5nDN4xUTDaHXXcsua5S8cD
 ai2McrHtjZsOUMzt9fX1qWv5MUfFmubQX+PrlP7OuEXF45DrwwM6KWkGICN4mRayF+zX
 dv+C5C7KkxHjqdASSaBC9P4J3lHuA3btuOiG837wp7DyPrswZ7q6WFkZoJ/CsuFwtWJj
 PSvaqJzdhveJZD0b9YJ702g2IQLxykjOzYjO2qP4csEASjMU9DfKaOQX71vFI6X8eO6Y
 EMvhJOwNYkYQW/gfx1eFbBSS8uzVfJFDbE99R+lD2r7t3Lnu8Zlp7VXHiccOyVI94KBY
 1myw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2UVUARuylMpe1jWASB96ggBZFzEdrV+7YLjaBtCjrh8/4I+jfIu5unwEBFSN600FUizFibelLl5zc@nongnu.org
X-Gm-Message-State: AOJu0YxV7YrMU2KnGvzow/mmGAco1ujy8yBSpfxuCNEkhb3UY1hboeD5
 BjV4ZJ7Ei0qp75s9isvKB5d/UVri1xCDOtH7576CqKD4FstTNb8wujIDin94yHl8AJTTdBYVLZa
 IA19IZNq9Lj8C51MXN9GLnNG717x2rSMJsS/gbIu2xIf29KnTRvNl
X-Gm-Gg: ASbGncvH0UIDkORc3TDw0XwlUs1HAq7YLMuMDRKExw+nQ+UUw5pgZtz0GoJ6OLaZHJ+
 nxEKEWKONADf5lUYTsAF1FxIO3hmXKtFUaWBWnIGUBGNRBao1KwkGszY/1QP6r6tiQTIAst12A9
 GRhHKX0p7yLmJGyQYL2wlxsAnMFmLmYDs/VpXieChhmlUVeuPHVqkaRbhZ5kgCqRMmTHdAHw7mh
 iyvE3NZpr1Lgd1ezDjQH7pSPV4RZHklBm+jl6yS7liuAm+RfSZn/vxWygfxcwJ2eJaRGHldc8ZR
 XHMO9/miMGQ=
X-Received: by 2002:a05:6602:2b01:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-8447e0ea343mr722625139f.0.1733523360281; 
 Fri, 06 Dec 2024 14:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5kXrBw3cynu1L5//uUaiUAizOx7QgfN9a7oltMafmNLm6nhFJmN/3D78msjJXDsznBMAp3g==
X-Received: by 2002:a05:6602:2b01:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-8447e0ea343mr722623039f.0.1733523360005; 
 Fri, 06 Dec 2024 14:16:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286107f22sm972556173.2.2024.12.06.14.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:15:59 -0800 (PST)
Date: Fri, 6 Dec 2024 17:15:57 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 07/24] migration: Document the BQL behavior of load
 SaveVMHandlers
Message-ID: <Z1N3nftzk1tIuVEg@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1DLw2Tw9vZmH06K@x1n>
 <48b99312-384e-4d93-9008-a83d6cce177d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48b99312-384e-4d93-9008-a83d6cce177d@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 07:40:19PM +0100, Maciej S. Szmigiero wrote:
> On 4.12.2024 22:38, Peter Xu wrote:
> > On Sun, Nov 17, 2024 at 08:20:02PM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Some of these SaveVMHandlers were missing the BQL behavior annotation,
> > > making people wonder what it exactly is.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/register.h | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > index 39991f3cc5d0..761e4e4d8bcb 100644
> > > --- a/include/migration/register.h
> > > +++ b/include/migration/register.h
> > > @@ -212,6 +212,8 @@ typedef struct SaveVMHandlers {
> > >       void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
> > >                                   uint64_t *can_postcopy);
> > > +    /* This runs inside the BQL. */
> > > +
> > >       /**
> > >        * @load_state
> > >        *
> > > @@ -246,6 +248,8 @@ typedef struct SaveVMHandlers {
> > >       int (*load_state_buffer)(void *opaque, char *buf, size_t len,
> > >                                Error **errp);
> > > +    /* The following handlers run inside the BQL. */
> > > +
> > >       /**
> > >        * @load_setup
> > >        *
> > > @@ -272,6 +276,9 @@ typedef struct SaveVMHandlers {
> > >        */
> > >       int (*load_cleanup)(void *opaque);
> > > +
> > > +    /* This runs outside the BQL. */
> > > +
> > >       /**
> > >        * @resume_prepare
> > >        *
> > > @@ -284,6 +291,8 @@ typedef struct SaveVMHandlers {
> > >        */
> > >       int (*resume_prepare)(MigrationState *s, void *opaque);
> > > +    /* The following handlers run inside the BQL. */
> > > +
> > >       /**
> > >        * @switchover_ack_needed
> > >        *
> > > 
> > 
> > Such change is not only error prone when adding new hooks, it's also hard
> > to review..
> > 
> > If we do care about that, I suggest we attach that info to every command.
> > For example, changing from:
> > 
> >      /**
> >       * @save_state
> >       * ...
> > 
> > To:
> > 
> >      /**
> >       * @save_state (invoked with BQL)
> >       * ...
> > 
> > Or somewhere in the doc lines of each hook.
> > 
> 
> This would need rewriting all the existing BQL comments/annotations
> in SaveVMHandlers since all of these are of the "separator" form as
> these introduced in this patch.

Yeah, I'd go for it if I'm touching it.  But it's your call, either use
this (it'll need 5 extra minutes for me to review such, but it's ok), or go
with what I said, or drop this patch and leave it for later.

-- 
Peter Xu



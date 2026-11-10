Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00775606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SANveJ6z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQo8h-000362-9H; Tue, 10 Nov 2026 10:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQo8d-000330-AG
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQo8a-0007HU-TN
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794325915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBx3Te+iXAjh6lQwYL5dSRN7bVIh+k7MD95QfpBz468=;
 b=SANveJ6zI8GaJM8hbP2IPFXhICKfGSOvC6poZWXR/bDKXpIOG3rYQtDH4CTu5fHqdcJKLy
 yIAn1B+SMnTsl4xRT33q/lFEfgcgxCKaD4YxFxczJTvbTE/S2BTJXDln9GOUySnBEMonb8
 Bvi1iS6w/FWBSjtSvs0xgU8fg6kzliQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-T_c8aCmYNFeGJSIDlot7ZA-1; Tue,
 10 Nov 2026 10:51:52 -0500
X-MC-Unique: T_c8aCmYNFeGJSIDlot7ZA-1
X-Mimecast-MFC-AGG-ID: T_c8aCmYNFeGJSIDlot7ZA_1794325911
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CAFC1955F7F; Tue, 10 Nov 2026 15:51:50 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 074691955DB9; Tue, 10 Nov 2026 15:51:47 +0000 (UTC)
Date: Tue, 10 Nov 2026 09:51:45 -0600
From: Eric Blake <eblake@redhat.com>
To: guillaume vincke <guillaume.vincke@ovhcloud.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH 1/2] nbd: Add an unstable query for the client state
Message-ID: <avM8KkT30Eqol7PS@redhat.com>
References: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
 <20261109160609.1434289-2-guillaume.vincke@ovhcloud.com>
 <87v764yhjg.fsf@pond.sub.org>
 <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730c1463-8dfb-4040-9c61-330882320d7c@ovhcloud.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 04:07:35PM +0100, guillaume vincke wrote:
> On 11/10/26 13:53, Markus Armbruster wrote:
> 
> Thanks for the review. Let me clarify before posting a v2.
> 
> > 
> > Why block-core.json and not block-export.json?
> 
> If I get this right, block-export.json covers the server part. I
> thought adding this next to BlockdevOptionsNbd was a better fit. I can
> change that in v2 if you think block-export.json is a better match.

I'll trust Markus on this part of the review.

> > > +#
> > > +# @quit: Client will not reconnect.
> > 
> > What does this one mean exactly?
> 
> The client stopped for good. Requests fail and it never reconnects.
> This state is reached on fatal error or teardown.

So either the server gave up on the client (a protocol error such as
an incorrect magic number that means the server has lost sync and
prefers not to further entertain further input from the client), or
the client gracefully terminated (the NBD_OPT_ABORT during handshake
or NBD_CMD_DISC during normal operation for the client to tell the
server it is done). I don't know if we can tell those apart, nor if we
need to.  For debugging purposes, merely knowing that the connection
is done (even if the fd is still in the process of being cleaned up)
is already good enough for most purposes.

> 
> > 
> > > +#
> > > +# Since: 11.2
> > 
> > Making 11.2 seems unlikely.
> 
> Sure. Would updating this to 12.0 make more sense ?

Agreed - this is too much on the "new feature" side to make soft
freeze; even if it only exists to make debugging easier and the iotest
that is now in 11.2 a bit more robust, I think aiming the new QMP
command for 12.0 is better.

> > > +#
> > > +# @state: The client state.
> > > +#
> > > +# @connector: The connector details.  Only present while a connection
> > > +#     attempt is running or its channel is parked.
> > > +#
> > > +# Since: 11.2
> > > +##
> > > +{ 'struct': 'XDbgNbdClient',
> > > +  'data': { 'state': 'XDbgNbdClientState',
> > > +            '*connector': 'XDbgNbdClientConnector' } }
> > 
> > How the combined state machine works is not clear to me.  Is it
> > documented anywhere?
> 
> I did not find a proper documentation. I found the comments on the code
> to be quite explicit though. The connector only runs in a connecting-*
> state. In that state, when processing a request, the client tries to
> get the channel from the connector. When the connector has a valid
> channel but the client did not request it, the connector is in parked
> state. Do you think this command should document that behavior?
> 
> > 
> > > +
> > > +##
> > > +# @x-debug-query-nbd-client:
> > > +#     Get the NBD client state.
> > > +#
> > > +# @node-name: node name of the NBD client to query.
> > 
> > How would I find the valid node names?  query-block-exports?
> 
> The node-name is listed by query-named-block-nodes or is the one passed
> to blockdev-add. I will add a reference to those commands in the
> docstring to clarify.

The export name need not match the node name (although it is common
for management apps to set the export name to copy the node name).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



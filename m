Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D44C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAud-00031E-FU; Thu, 22 May 2025 14:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIAua-00030I-Sv
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIAuZ-0002jS-1A
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747939498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKtEYkxGPbe+Ls+tdPb0JhlPJWHNlDLtDdWMPwwVfXA=;
 b=Ildj43v/X5DwGN0prEUYRmQ6hQrRTjbE+tGK4QtrMm8AlfNnE5/uI7bM2wePDrdIrlOLdb
 eX8kDpdmsw0oyACipW6XBeilcP7nxXNRvr8Mrm/kpXV7djP/PuXwNSoy56ByWhQI+JXzrt
 bkxtnIXbItI5R7kZAxplOZ29eD12lMg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-TKHbbRO3NDWgruQvQjJv2g-1; Thu,
 22 May 2025 14:44:55 -0400
X-MC-Unique: TKHbbRO3NDWgruQvQjJv2g-1
X-Mimecast-MFC-AGG-ID: TKHbbRO3NDWgruQvQjJv2g_1747939494
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1F3A180087F; Thu, 22 May 2025 18:44:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF1C1944DFF; Thu, 22 May 2025 18:44:50 +0000 (UTC)
Date: Thu, 22 May 2025 13:44:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
Message-ID: <fqocrea23tvvi73ld7yvhhw4h7ojv7qzf3jygw5ggxdu3ksb2a@l5l2duiwuzox>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
 <3233ad9b-028f-4136-9391-2130ecd5d4fe@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3233ad9b-028f-4136-9391-2130ecd5d4fe@virtuozzo.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 22, 2025 at 08:38:34PM +0300, Andrey Drobyshev wrote:
> On 4/28/25 9:46 PM, Eric Blake wrote:
> > From: "Richard W.M. Jones" <rjones@redhat.com>
> > 
> > Add multi-conn option to the NBD client.  This commit just adds the
> > option, it is not functional.
> > 
> > Setting this to a value > 1 permits multiple connections to the NBD
> > server; a typical value might be 4.  The default is 1, meaning only a
> > single connection is made.  If the NBD server does not advertise that
> > it is safe for multi-conn then this setting is forced to 1.
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > [eblake: also expose it through QMP]
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  qapi/block-core.json |  8 +++++++-
> >  block/nbd.c          | 24 ++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> >
> 
> Pardon my nitpicking, but it seems to me that the name "multi-conn"
> doesn't really suggest "number of simultaneous NBD client connections",
> especially when similarly named NBD_FLAG_CAN_MULTI_CONN_BIT represents
> binary logic: supported or not supported.  Maybe smth like
> "multi_conns_num" would be better? Or anything else as long as it's
> clear it's an int, not bool.

Maybe 'max-multi-conn-clients', since it is something that even if the
user sets it to larger than 1 but the server doesn't advertise the
bit, then we silently restrict to one client.

> > @@ -1895,6 +1906,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
> > 
> >      s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
> >      s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
> > +    s->multi_conn = qemu_opt_get_number(opts, "multi-conn", 1);
> > +    if (s->multi_conn > MAX_MULTI_CONN) {
> > +        s->multi_conn = MAX_MULTI_CONN;
> > +    }
> > 
> 
> I agree with Markus that this setting value different from what's been
> directly requested by user shouldn't go silent.  Having some kind of
> warning at the very least would be nice.

Okay, I'll make sure to warn if it exceeds the compile-time max.

> 
> >      ret = 0;
> > 
> > @@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
> > 
> >      nbd_client_connection_enable_retry(s->conn);
> > 
> > +    /*
> > +     * We set s->multi_conn in nbd_process_options above, but now that
> > +     * we have connected if the server doesn't advertise that it is
> > +     * safe for multi-conn, force it to 1.
> > +     */
> > +    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
> > +        s->multi_conn = 1;
> > +    }
> 
> Same here.

Here, I disagree.  But that's where better naming comes into play: if
there is 'max-' in the name, then the user should not be surprised if
they don't actually achieve the max (because the server lacked
support).  On the other hand, I could see how you might want to know
if you have a mismatched setup ("I think the server SHOULD be
supporting multi-conn, so I request multiple clients, and I want to be
informed if my expectations were not met because then I know to go
reconfigure the server").  Thoughts?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org



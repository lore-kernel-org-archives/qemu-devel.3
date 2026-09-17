Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C867C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Ta-00032G-2J; Thu, 17 Sep 2026 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x77TW-000325-CY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x77TT-0002yn-QZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789633686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrQ0anvr6bN20/n/L6hgJPzL3+TdN+q+yt5MMOQe070=;
 b=NfiA+X9eGoaT6gxdgEUudHSOGLy7XOJ2eepk99yv0s7ZMP4d2wPJ6MFuPH8rDC8H26LrbT
 snNy6WMAMO5PN1Cnwmgyr2nus8DC5A6WC+yNwF6EFHLhtDEeTQRrylzVNTlpQ3hPDIMTqN
 j3P07uhC3oamFlUFgQPBiRFhhLs4gsc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-WbAA7BPpOV-fvfkQf-nNaA-1; Thu,
 17 Sep 2026 04:28:03 -0400
X-MC-Unique: WbAA7BPpOV-fvfkQf-nNaA-1
X-Mimecast-MFC-AGG-ID: WbAA7BPpOV-fvfkQf-nNaA_1789633682
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C795E1954AD6; Thu, 17 Sep 2026 08:28:01 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A7AF30001A2; Thu, 17 Sep 2026 08:28:00 +0000 (UTC)
Date: Thu, 17 Sep 2026 09:27:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Tim Foerster <tim.foerster@hetzner.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowangio@gmail.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: QMP: exposing the host TAP interface name
Message-ID: <aqukjSkXD5XycdN-@redhat.com>
References: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
 <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Sep 16, 2026 at 05:18:05PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Sep 16, 2026 at 10:22 AM Tim Foerster via qemu development
> <qemu-devel@nongnu.org> wrote:
> >
> > Hi,
> >
> > I'd like to query the host TAP interface name of a network backend via QMP, especially when the TAP FD is passed to QEMU using SCM_RIGHTS
> > and then assigned to a backend through fd=.
> >
> > In my current setup, retrieving this information externally requires CAP_SYS_PTRACE. This gives the management process far more access
> > than needed and conflicts with the Landlock sandboxing I want to apply, due to Landlock's ptrace restrictions [1].
> >
> > QEMU already owns the FD, and tap_fd_get_ifname() can retrieve the name using TUNGETIFF on Linux. For a TAP passed through fd=, x-query-
> > network currently reports the following (simplified):
> >
> > {
> >   "name": "hostnet0",
> >   "type": "tap",
> >   "info-str": "fd=42"
> > }
> >
> > I'd like to obtain the actual interface name in a structured field, regardless of how the TAP was created or passed to QEMU. For example:
> >
> > {
> >   "name": "hostnet0",
> >   "type": "tap",
> >   "info-str": "fd=42",
> >   "data": {
> >     "ifname": "vnet7"
> >   }
> > }
> >
> > Would extending x-query-network be the preferred approach? If so, would you prefer a dedicated ifname field or a type-specific data object
> > selected by the existing type field?
> 
> x- QMP commands are not meant for any other usage than debugging and
> testing (in fact, we should probably exclude them in production
> builds!). In particular, this command is currently only meant to be a
> HMP "info network" substitute for test/debugging only atm.
> 
> >
> > Personally, I'd prefer an approach that is reasonably easy to backport downstream to older QEMU releases. Since x-query-network is
> > relatively new, extending it would also require bringing that command to releases which don't have it yet, potentially increasing the
> > backporting effort.
> >
> > A type-specific data object could also accommodate additional TAP properties later, such as multiqueue mode or vnet_hdr. However, those
> > are outside my current scope, I only need the interface name.
> 
> I'd suggest a new query-network-tap(name: hostnet0) -> TAPInfo command
> for your specific case. Eventually, later, NetworkClientInfo could
> later embed that data.
> 
> Let see what other people & maintainers think

A minor nitpick about naming, on the command line and QMP command
we use the term 'netdev' for the modern config approach, rather
than "net" or "network" which is the original terminology prior
to "netdev".

On the general design though, IMHO, adding such narrow commands
is not very desirable.

On the input side we already have a data structure defined for
the input arguments to 'netdev-add', namely "Netdev", which
has fields for all the possible config options of all the
backends via a discriminated union.

In the case of TAP devices there are two scenarios - the low
level backend represented in NetdevTapOptions, and the high
level backend rerpesented in NetdevBridgeOptions.

The NetdevTapOptions struct already includes a "ifname" field.v
In the case of passing in an FD during 'netdev-add', 'fd' would
be set, while 'ifname' would be left unset.

It is reasonable to say, however, then upon querying the live
NetdevTapOptions, *only* the "ifname" field ought to be present,
either the orignal value from the user, or the derived value
from calling tap_fd_get_ifname(). 

IOW, what I'm saying is that if we want to query the live netdv
backend config, we should have:

   { 'command': 'query-netdevs', 'data': ['Netdev'] }

as a formal QAPI model.

Aside from the general plumbing work, two things to be aware of

 * After creating the netdev initially, we throw away the
   original "Netdev" struct data. We would need to preserve
   that struct, so that we can later report it back with
   query-netdevs. The TAP backend would also have to fill-in
   the 'ifname' field when given an 'fd' initially.


 * In theory someone could still be using '-net' instead
   of '-netdev', where IIUC, we will have an "Netdev"
   struct at any point.

   The idealized thing todo is to fold "-net" onto "-netdev"
   by making it synthesize a "Netdev" and then go through
   the Netdev setup code path, but their semantics aren't a
   perfect match which is why they're separate to begin
   with. So ignore that idea.

   The more practical thing to do is merely document that
   'query-netdevs' only reports on backends created via
   '-netdev' and thus declare '-net' compatibility entirely
   out of scope.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



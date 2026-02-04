Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AB3E9539B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncnY-0002ZX-MC; Wed, 04 Feb 2026 08:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vncnT-0002Z0-7r
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:19:55 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vncnQ-0001iU-Os
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:19:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAACC5BD33;
 Wed,  4 Feb 2026 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770211188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHaMWIKiJhu0lt4XdxztwPrPnpbGguB803kEe1LrJfQ=;
 b=MDlTlX1vu8vh8vYceFUeI4LUeAhHDDNiIPpoZwl7vp2MDVdIxCSZqF3ro4k9c0eysOIznA
 +c/kbXD3N0aC8TTRE7PFU4wygnLP5IoqzY+dUIr5QDBCrs6oI8Xlul1yjaqppC21IHEhoH
 77SeVUZKDdM3foyGof7JtVwCe8HkXnI=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=MDlTlX1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770211188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHaMWIKiJhu0lt4XdxztwPrPnpbGguB803kEe1LrJfQ=;
 b=MDlTlX1vu8vh8vYceFUeI4LUeAhHDDNiIPpoZwl7vp2MDVdIxCSZqF3ro4k9c0eysOIznA
 +c/kbXD3N0aC8TTRE7PFU4wygnLP5IoqzY+dUIr5QDBCrs6oI8Xlul1yjaqppC21IHEhoH
 77SeVUZKDdM3foyGof7JtVwCe8HkXnI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8981F3EA63;
 Wed,  4 Feb 2026 13:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zjmCIHRHg2kNXwAAD6G6ig
 (envelope-from <mwilck@suse.com>); Wed, 04 Feb 2026 13:19:48 +0000
Message-ID: <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
From: Martin Wilck <mwilck@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Benjamin Marzinski
 <bmarzins@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>, afaria@redhat.com, 
 qemu-devel@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 04 Feb 2026 14:19:48 +0100
In-Reply-To: <20260203180437.GA527989@fedora>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: CAACC5BD33
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=mwilck@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

On Tue, 2026-02-03 at 13:04 -0500, Stefan Hajnoczi wrote:
> On Tue, Feb 03, 2026 at 12:53:12PM -0500, Benjamin Marzinski wrote:
> > On Tue, Feb 03, 2026 at 10:09:39AM -0500, Stefan Hajnoczi wrote:
> > > On Tue, Jan 27, 2026 at 04:06:03PM -0500, Benjamin Marzinski
> > > wrote:
> > > > On Tue, Jan 27, 2026 at 01:47:43PM -0500, Stefan Hajnoczi
> > > > wrote:
> > > > > Hi Benjamin and Paolo,
> > > > > I would like to discuss changes to DM-Multipath and qemu-pr-
> > > > > helper to
> > > > > handle SCSI Persistent Reservations in QEMU without
> > > > > privileged code.
> > > > >=20
> > > > > SCSI Persistent Reservations support in QEMU is built on the
> > > > > qemu-pr-helper daemon that performs PERSISTENT RESERVATION IN
> > > > > and
> > > > > PERSISTENT RESERVATION OUT commands on behalf of the guest.
> > > > > The
> > > > > qemu-pr-helper process provides privilege separation for
> > > > > ioctl(SG_IO)'s
> > > > > CAP_SYS_RAWIO and libmpathpersist's root privileges since the
> > > > > main QEMU
> > > > > process should not have those privileges.
> > > > >=20
> > > > > There are issues with the current approach:
> > > > > - Privileged code is a security attack surface.
> > > > > - A bunch of code is required for privilege separation and
> > > > > for management
> > > > > =C2=A0 tools to set up qemu-pr-helper with access to multipathd.
> > > > > - The interface is SCSI-specific and does not support NVMe.
> > > > >=20
> > > > > Several of us have pondered a different approach that I will
> > > > > summarize
> > > > > here. The <linux/pr.h> ioctl interface provides an
> > > > > alternative to
> > > > > ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It
> > > > > supports both
> > > > > SCSI and NVMe. Since privileges are not required, there would
> > > > > be no need
> > > > > for the qemu-pr-helper daemon anymore.
> > > > >=20
> > > > > The blocker is that <linux/pr.h> is not usable in multipath
> > > > > environments. The Linux DM-Multipath driver has an incomplete
> > > > > ioctl
> > > > > implementation that falls short of what libmpathpersist and
> > > > > multipathd
> > > > > do in userspace. Kernel changes are necessary to fix this.
> > > > >=20
> > > > > My suggestion is to implement <linux/pr.h> via upcalls from
> > > > > DM-Multipath
> > > > > to multipathd. That way applications like QEMU can
> > > > > consistently use
> > > > > <linux/pr.h> across block device types and no longer have to
> > > > > go through
> > > > > the privileged libmpathpersist interface.
> > > >=20
> > > > This would take intercepting the pr commands to multipath
> > > > devices right
> > > > at the start of dm_call_pr(). In order to make some persistent
> > > > reservation commands seem atomic, libmpathpersist needs to
> > > > suspend the
> > > > multipath device in certain situations. So device-mapper cannot
> > > > call
> > > > dm_get_live_table(), since this will block suspends. This
> > > > should be o.k.
> > > > Libmpathpersist is designed to handle the possiblity that the
> > > > multipath
> > > > device gets reloaded with different paths while it is running.
> > > > And since
> > > > the multipath target is an immutable singleton target, there is
> > > > no
> > > > possibility of it turning into another target type because of a
> > > > table
> > > > reload during suspend.
> > > >=20
> > > > Also, just to clarify, the kernel code can't interface directly
> > > > with
> > > > multipathd. Most of the code for handling persistent
> > > > reservations is in
> > > > libmpathpersist, which just needs multipathd to do things like
> > > > make sure
> > > > that paths that are added in the furture get registered
> > > > properly. There
> > > > would likely need to be some new program (that is just a thin
> > > > wrapper
> > > > around libmpathpersist) which can be called with
> > > > call_usermodehelper().
> >=20
> > Adding Martin Wilck, since he will also be looking at these
> > changes.
> > =C2=A0
> > > Hi everyone,
> > > I'm starting to work on the DM-Multipath changes. Some more
> > > details on
> > > how I am approaching this:
> > >=20
> > > - multipath-tools will create multipath device-mapper targets
> > > with a new
> > > =C2=A0 ctr argument (pr_netlink) when this feature is enabled. When
> > > the
> > > =C2=A0 feature is disabled, everything remains backwards compatible.
> > > With the
> > > =C2=A0 pr_netlink ctr argument, the multipath target sends a netlink
> > > =C2=A0 multicast group notification instead of handling PR operations
> > > (e.g.
> > > =C2=A0 IOC_PR_* ioctls) in the kernel.
> > >=20
> > > - There will be a new program in multipath-tools called
> > > mpathpersistd
> > > =C2=A0 that listens on the netlink multicast group for notifications.
> > > The
> > > =C2=A0 notification tells it which multipath device has a pending PR
> > > =C2=A0 operation. It fetches the PR operation parameters by sending a
> > > netlink
> > > =C2=A0 message, performs the persistent reservation operation via
> > > =C2=A0 libmpathpersist, and then sends a response to the kernel via
> > > another
> > > =C2=A0 netlink message.
> > >=20
> > > - The multipath device-mapper target completes the PR operation
> > > upon
> > > =C2=A0 receiving the netlink response.
> > >=20
> > > I ended up choosing netlink because call_usermodehelper() seems
> > > less
> > > appropriate for an operation triggered by untrusted userspace
> > > processes.
> > >=20
> > > Your input is welcome. Let me know if a different approach would
> > > be
> > > better.
> >=20
> > Is the netlink interface going to be a generic persistent
> > reservation
> > upcall interface, or it this just for dm multipath? I'm not sure if
> > there would ever be another user, and I don't have enough
> > experience
> > with the netlink code to know how ugly it might be to route
> > communications from different kernel drivers to different userspace
> > daemons through the same generic netlink family. But if there's not
> > much extra complexity in building a generic interface, it seems
> > like
> > it would be preferable to a multipath specific one.
>=20
> It can be generic. The messages will contain the block device
> major:minor as well as information to describe <linux/pr.h> requests.

So the ioctls will pass through qemu into the kernel, to be intercepted
by the dm-mpath driver, which will use an upcall to have them handled
by mpathpersistd (for the actual command) and multipathd (for the path
registrations).

I don't fully understand the advantage, security and complexity-wise,
of this concept, compared to intercepting them qemu and using a socket
to talk to mpathpersistd directly. If we did this, we could even
support both generic and SCSI PR commands.

Regards
Martin


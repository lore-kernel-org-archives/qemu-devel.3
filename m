Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA9AEC1E92
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwT6-000318-5J; Thu, 05 Feb 2026 05:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vnwT5-00030t-7Z
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:20:11 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mwilck@suse.com>) id 1vnwT3-0007e4-8R
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:20:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 817605BD78;
 Thu,  5 Feb 2026 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770286807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzU5sJFijs89eY03gzb5l8Gfl0mRycAhHvicbkX+qFo=;
 b=J6wCQMc0RDhwx/tPdhbbHP42isyZunN5fJRwj4XG5FGFmPX7M5H4LS36/uP5Dk9cJxe+jE
 NpejveIIIPImLzZ+8DiGlZHamWRoXgv0jd/4C9OlgmebZYvoLHZ9Yb/F4RBeOFts2KUZ8Z
 vVmut+GNL+bTt/ZTIQE26KL/4LHc/zo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1770286806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzU5sJFijs89eY03gzb5l8Gfl0mRycAhHvicbkX+qFo=;
 b=AZdbKl+iP/xf+fGPvj0UM4Gc3Id0WfyotPxDgIfntuihsdmmL5vK6vHeiZSt/AuQ1fcL70
 4JituvcnrnUcJZHi+XLYjiv3p3K3zCYQhmhkgFDkXB9dSqUcz9z7pcO3z8CQ8fdpxxFKci
 RkpoGopzXkHMmbotuw7njje9EqTM26Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 414593EA63;
 Thu,  5 Feb 2026 10:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yI7gDtZuhGmlPQAAD6G6ig
 (envelope-from <mwilck@suse.com>); Thu, 05 Feb 2026 10:20:06 +0000
Message-ID: <6c7229e3d085f961209338e165e8487cbc5b8ed0.camel@suse.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
From: Martin Wilck <mwilck@suse.com>
To: Benjamin Marzinski <bmarzins@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, 	qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, afaria@redhat.com, 	qemu-devel@nongnu.org, Mikulas
 Patocka <mpatocka@redhat.com>
Date: Thu, 05 Feb 2026 11:20:05 +0100
In-Reply-To: <aYPsdWW6ntBq2RFm@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <ff71f35e-06b5-4a82-98ec-8e0419f5ec62@suse.de>
 <aYPsdWW6ntBq2RFm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=mwilck@suse.com;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2026-02-04 at 20:03 -0500, Benjamin Marzinski wrote:
> On Thu, Feb 05, 2026 at 12:57:38AM +0100, Hannes Reinecke wrote:
> > On 2/4/26 19:32, Stefan Hajnoczi wrote:
> > > On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
> > > > Hi Stefan,
> > > >=20
> > > > On Tue, 2026-02-03 at 13:04 -0500, Stefan Hajnoczi wrote:
> > [ .. ]>>>
> > > > > It can be generic. The messages will contain the block device
> > > > > major:minor as well as information to describe <linux/pr.h>
> > > > > requests.
> > > >=20
> > > > So the ioctls will pass through qemu into the kernel, to be
> > > > intercepted
> > > > by the dm-mpath driver, which will use an upcall to have them
> > > > handled
> > > > by mpathpersistd (for the actual command) and multipathd (for
> > > > the path
> > > > registrations).
> > > >=20
> > > > I don't fully understand the advantage, security and
> > > > complexity-wise,
> > > > of this concept, compared to intercepting them qemu and using a
> > > > socket
> > > > to talk to mpathpersistd directly. If we did this, we could
> > > > even
> > > > support both generic and SCSI PR commands.
> > >=20
> > > Hi Martin,
> > > The simplification and security benefits are on the application
> > > side,
> > > not on the DM-Multipath side, so I can see what you're getting
> > > at. From
> > > the DM-Multipath perspective things get a little more complex.
> > >=20
> > > =C2=A0From an application perspective, a single API that works across
> > > block
> > > device types (SCSI, NVMe, DM-Multipath) and requires no
> > > privileges or
> > > sockets (they are a pain in container environments) is the most
> > > convenient. The <linux/pr.h> ioctl API offers exactly this.
> > >=20
> > > Unfortunately, DM-Multipath currently does not fully support
> > > <linux/pr.h>. It sends PR operations down each path, but that is
> > > only a
> > > subset of libmpathpersist's logic and multipathd is not kept in
> > > sync.
> > >=20
> > > My impression is that libmpathpersist and multipathd logic cannot
> > > be
> > > easily moved into the kernel. This is where the upcall idea comes
> > > from.
> > > Let's notify multipath-tools from DM-Multipath so it can do its
> > > work in
> > > userspace.
> > >=20
> > It _might_ be possible by extending the current path-switching
> > code in the kernel to keep track of PRs. The we could move the
> > registration upon path switching, and (ideally) could do away
> > with upcalls.
> > Not sure, though, how targets react when having to deal with a
> > flood of PR commands ...
> > But maybe worth a try.
>=20
> Making a multipath device pretend to be single Persistently
> Reservable
> device involves a lot of ugly workarounds that I'm not really excited
> to
> see in the kernel.
>=20
> For instance, every time a new path appears or a path that was down
> when
> the device was registered comes up, multipath needs to register that
> path. But a preempt could come it while it is doing this (or indeed
> any
> time after multipath registered the other paths). So it has to check
> the that the registrations are still there on the other paths before
> registering the new path, and then check again afterwards to make
> sure
> that there wasn't a preempt during the registration.=20
>=20
> Worse, you can't release a reservation from a path that is down. If
> multipath needs to release its reservation, and the path that is
> holding
> it is down, the only solution I could come up with is to suspend the
> device so no IO happens. Preempt the reservation to move it to an
> active
> path, which wipes the registrations off all the other paths. Then
> reregister the all the active paths again, and unsuspend the device.
> The failed paths will get reregistred as they come back up.
>=20
> And there's more cases like these. They are, of course, just as
> doable
> in the kernel as in userspace, but it's a lot of persistent
> reservation
> code to put into the multipath target.

Having reviewed (or tried to do so) Ben's code for handling the various
corner cases, I agree that we don't want to start all over with this.

Martin


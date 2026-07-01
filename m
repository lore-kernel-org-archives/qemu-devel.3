Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484AEC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevmw-0007uj-Cz; Wed, 01 Jul 2026 10:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wevmu-0007ub-Kq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:19:40 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wevms-0002OO-Dv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=m4bQvNHDs6XwQLXSCduuBqKVav7YlWO7rkKAwP8IZBc=; b=Fo8EDsSI1hytdL/N
 SIQwF0VH/fU7FKAT84JZ6UmX0ZU3tlAEHYjrdhEUyOx/oEseqB1A14yhUfBk9lQ/f56ZW7eCN7e3U
 148CZtRAyUwa86uN2sE4/h/gzyEOreWZQ+ngqb6DE9+7bJomWRdwd9v1zqIN0nlQ96zpaG6xKfJyE
 /lF+q6wiaRlGou+7iIbEFETiBjae72m9ACLn3LiPzMR7ZzI3qm3e+199iLJsLOZzkTJgC/pz3eop8
 C5zJ6l92sjgkexoLWtCeNqm7wuTRD6if5rjg5mSRCAN9EgCUtRaFbu7SiM4vh4iqkBDkA5AbKA4v6
 bJ+TUf25+aZxLlD8/A==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wevmm-0000000BSVX-3Kau;
 Wed, 01 Jul 2026 14:19:32 +0000
Date: Wed, 1 Jul 2026 14:19:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <akUh9FLxh3COFvP1@gallifrey>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
 <87zf0busnt.fsf@pond.sub.org> <akTLejz0-b48s5NS@redhat.com>
 <87mrwa4yrl.fsf@pond.sub.org> <akUaDiOQIvJFDJTe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akUaDiOQIvJFDJTe@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 14:17:57 up 46 days, 17:30,  3 users,  load average: 0.05, 0.04, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Wed, Jul 01, 2026 at 03:37:02PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Wed, Jul 01, 2026 at 08:32:06AM +0200, Markus Armbruster wrote:
> > >> marcandre.lureau@redhat.com writes:
> > >> 
> > >> >> The default monitor is usually a long lived object that will exist for
> > >> >> the entire lifetime of the VM. A monitor can only service a single
> > >> >> client at a time though, and so it might be desirable to hotplug
> > >> >> additional monitors at runtime for specific tasks. If doing that,
> > >> >> however, there is a need to remove the monitor when it is no longer
> > >> >> needed.
> > >> 
> > >> Whatever adds the additional monitor can also delete it.  The fact that
> > >> you propose other means suggests you believe this would be cumbersome in
> > >> practice.  Why?
> > >
> > > The use is is that someone/something wants to spawn a script that
> > > does some job with the QEMU monitor.  The thing that spawns the
> > > script adds the new monitor and launches the script. Having
> > > auto-delete means that you do not need to then keep track of that
> > > script to perform cleanup of the dynamically added monitor. It
> > > gives you "do the right thing" behaviour automatically when the
> > > script exits, closing its monitor connection.
> > >
> > > The initial series proposed by Christian supported the ability
> > > to run "object-del' on the monitor itself - a "self delete"
> > > essentially. That is very awkward from the code POV, as it
> > > required special case hanlding to ensure the QMP response to
> > > the delete action got sent on the socket before the delete
> > > action took place. It also made it impossible to then delete
> > > the character device.
> > >
> > > Auto-delete gives us a better solution with less code complexity.
> > 
> > I agree "self delete" is problematic.
> > 
> > I wonder how important the ability to fire and forget a script with a
> > dedicated monitor is.  I'd (naively?) expect whatever spawns the script
> > to reap its exit status.
> > 
> > If it is important, what about fire and forget a script with a dedicated
> > character device?  Can't come up with a use case for that within ten
> > seconds.  However, we use character devices for all kinds of crap.  Food
> > for thought, not a demand.
> 
> In a hypothetical libvirt usage of this functionality, libvirt would
> not be spawning the script or even know what its PID is. Libvirt would
> just create a auto-delete monitor, open an FD to it, and pass the FD
> back to the libvirt client & forget about it.
> 
> > >> >> Allowing a client to run "object-del" against its own monitor adds
> > >> >> complex edge cases, as it would be desirable to send the QMP response
> > >> >> despite the monitor sending it being deleted. Doing "object-del" alone
> > >> >> will also result in orphaning a character device backend instance, as
> > >> >> there is no opportunity to run the companion "chardev-del" command.
> > >> >> 
> > >> >> A simpler way to ensure cleanup is to add the concept of auto-deleting
> > >> >> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> > >> >> emitted, the equivalent of "object-del" + "chardev-del" can be run
> > >> >> internally. Since the transient client has already droppped its
> > >> >> monitor connection, there is no synchronization to be concerned about.
> > >> 
> > >> If object-del or chardev-del fail, there's no way to report the error.
> > >> Can they fail?
> > >
> > > object-del can fail if
> > >
> > >  * An object with the specified "id" does not exist. That shouldn't
> > >    happen in this case but harmless if it odes.
> > >  * object_del command tries to delete the monitor that
> > >    is servicing the object_del command. Cannot happen with
> > >    auto-delete
> > >  * the monitor has not finished initializing it BH with
> > >    chardev handlers. Cannot happen if we know we have a
> > >    live connection already.
> > >
> > > chardev-del can fail if
> > >
> > >  * The chardev with "id" does not exist. SHouldn't happen
> > >    but is harmless if it does
> > >  * The chardev reports it is "busy" - aka the frontend
> > >    is still connected - we just deleted it so cannot happen
> > >  * Record/replay is in use - a niche use case
> > >
> > > So I don't think errors are a problem.
> > >
> > >> Do we always want to delete both monitor and character device?
> > >
> > > IMHO yes they are a pair whose lifetime should be tied together
> > > for normal use.
> > 
> > Would we make monitor auto-delete delete its character device if
> > character devices also had an auto-delete feature?
> 
> That's a possibility.
> 
> We would have to accept that it allows users to create a scenario in
> which auto-delete will frequenty fail.
> 
> ie configuring the chardev for auto-delete, but not having the
> frontend auto-delete, which would trigger the "busy" check. 

This feels like it has some overlap with 'yank'?  Where you can force
a channel to get out of the way even if you don't delete it at that point.

Dave

> Not convinced that's nicer ?
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C19BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevGZ-000655-Te; Wed, 01 Jul 2026 09:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wevGR-00064S-7o
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wevGO-0007RO-H9
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782913563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbB998jaC+hWnrxKMzzt8H82XlG8CHfZRQnJXOKRDTQ=;
 b=hRc07zPLEgzqW7bBVzM/9qGFH9aZPhonSeGWloYeHIuJElFmsqWJha5ybee0nL33qCAqSt
 AgkUPdKdRcgcc53lsbR/GOvAUll8qjBdObMXQsFBjBFVFfNahchUJylmiZREiJXENrdBmM
 H48qB4tu3Td8YSxc1K0uCe15fd7Vh1k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-zuLVNv-bNO-0_JpNbMpoxQ-1; Wed,
 01 Jul 2026 09:46:00 -0400
X-MC-Unique: zuLVNv-bNO-0_JpNbMpoxQ-1
X-Mimecast-MFC-AGG-ID: zuLVNv-bNO-0_JpNbMpoxQ_1782913558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 642511944E45; Wed,  1 Jul 2026 13:45:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.35])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B8211955D53; Wed,  1 Jul 2026 13:45:53 +0000 (UTC)
Date: Wed, 1 Jul 2026 14:45:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <akUaDiOQIvJFDJTe@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
 <87zf0busnt.fsf@pond.sub.org> <akTLejz0-b48s5NS@redhat.com>
 <87mrwa4yrl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrwa4yrl.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 01, 2026 at 03:37:02PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jul 01, 2026 at 08:32:06AM +0200, Markus Armbruster wrote:
> >> marcandre.lureau@redhat.com writes:
> >> 
> >> >> The default monitor is usually a long lived object that will exist for
> >> >> the entire lifetime of the VM. A monitor can only service a single
> >> >> client at a time though, and so it might be desirable to hotplug
> >> >> additional monitors at runtime for specific tasks. If doing that,
> >> >> however, there is a need to remove the monitor when it is no longer
> >> >> needed.
> >> 
> >> Whatever adds the additional monitor can also delete it.  The fact that
> >> you propose other means suggests you believe this would be cumbersome in
> >> practice.  Why?
> >
> > The use is is that someone/something wants to spawn a script that
> > does some job with the QEMU monitor.  The thing that spawns the
> > script adds the new monitor and launches the script. Having
> > auto-delete means that you do not need to then keep track of that
> > script to perform cleanup of the dynamically added monitor. It
> > gives you "do the right thing" behaviour automatically when the
> > script exits, closing its monitor connection.
> >
> > The initial series proposed by Christian supported the ability
> > to run "object-del' on the monitor itself - a "self delete"
> > essentially. That is very awkward from the code POV, as it
> > required special case hanlding to ensure the QMP response to
> > the delete action got sent on the socket before the delete
> > action took place. It also made it impossible to then delete
> > the character device.
> >
> > Auto-delete gives us a better solution with less code complexity.
> 
> I agree "self delete" is problematic.
> 
> I wonder how important the ability to fire and forget a script with a
> dedicated monitor is.  I'd (naively?) expect whatever spawns the script
> to reap its exit status.
> 
> If it is important, what about fire and forget a script with a dedicated
> character device?  Can't come up with a use case for that within ten
> seconds.  However, we use character devices for all kinds of crap.  Food
> for thought, not a demand.

In a hypothetical libvirt usage of this functionality, libvirt would
not be spawning the script or even know what its PID is. Libvirt would
just create a auto-delete monitor, open an FD to it, and pass the FD
back to the libvirt client & forget about it.

> >> >> Allowing a client to run "object-del" against its own monitor adds
> >> >> complex edge cases, as it would be desirable to send the QMP response
> >> >> despite the monitor sending it being deleted. Doing "object-del" alone
> >> >> will also result in orphaning a character device backend instance, as
> >> >> there is no opportunity to run the companion "chardev-del" command.
> >> >> 
> >> >> A simpler way to ensure cleanup is to add the concept of auto-deleting
> >> >> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> >> >> emitted, the equivalent of "object-del" + "chardev-del" can be run
> >> >> internally. Since the transient client has already droppped its
> >> >> monitor connection, there is no synchronization to be concerned about.
> >> 
> >> If object-del or chardev-del fail, there's no way to report the error.
> >> Can they fail?
> >
> > object-del can fail if
> >
> >  * An object with the specified "id" does not exist. That shouldn't
> >    happen in this case but harmless if it odes.
> >  * object_del command tries to delete the monitor that
> >    is servicing the object_del command. Cannot happen with
> >    auto-delete
> >  * the monitor has not finished initializing it BH with
> >    chardev handlers. Cannot happen if we know we have a
> >    live connection already.
> >
> > chardev-del can fail if
> >
> >  * The chardev with "id" does not exist. SHouldn't happen
> >    but is harmless if it does
> >  * The chardev reports it is "busy" - aka the frontend
> >    is still connected - we just deleted it so cannot happen
> >  * Record/replay is in use - a niche use case
> >
> > So I don't think errors are a problem.
> >
> >> Do we always want to delete both monitor and character device?
> >
> > IMHO yes they are a pair whose lifetime should be tied together
> > for normal use.
> 
> Would we make monitor auto-delete delete its character device if
> character devices also had an auto-delete feature?

That's a possibility.

We would have to accept that it allows users to create a scenario in
which auto-delete will frequenty fail.

ie configuring the chardev for auto-delete, but not having the
frontend auto-delete, which would trigger the "busy" check. 

Not convinced that's nicer ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



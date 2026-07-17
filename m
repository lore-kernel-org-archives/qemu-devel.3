Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C823C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkkMF-0007eg-DF; Fri, 17 Jul 2026 11:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkkM2-0007dM-VW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 11:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkkM0-0006R1-4y
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 11:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784301594;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7psHR1jKzVPf9yD/fBEwSDBf2JWN+FMrBcGNbo4utA=;
 b=UAox9aTwAvJrrvG4jTJAj/4cC+SG3hauOmEGvfb3V1+ZlFLNOW3jdy841P35yHluETFFnV
 Z13cja+DvtX/ZN5E3Kxw6YjP/vlUCV6dQEhQg2g5aYgs0QUNm8VXW+bErbUrQXU+hPKVRf
 fr7oSplrcB8d8u49yZomJgK/Zp4i068=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-o6D7BFzCOJGWyQmSITGxIQ-1; Fri,
 17 Jul 2026 11:19:51 -0400
X-MC-Unique: o6D7BFzCOJGWyQmSITGxIQ-1
X-Mimecast-MFC-AGG-ID: o6D7BFzCOJGWyQmSITGxIQ_1784301590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8B461955DD3; Fri, 17 Jul 2026 15:19:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C86630040BF; Fri, 17 Jul 2026 15:19:45 +0000 (UTC)
Date: Fri, 17 Jul 2026 16:19:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <alpIDh7WOcFsa9EA@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj4V6I__bCOjRTt@redhat.com> <87ech24wcz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ech24wcz.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Jul 16, 2026 at 03:34:20PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:
> >
> >> Assumptions:
> >> 
> >> A) The migration stream is assumed to be secured by TLS on a per-host
> >> basis.
> >> 
> >> B) For migration streams stored to file, including snapshots, it is
> >> assumed that the storage file is authentic, i.e. the files are owned by
> >> the party performing the live migration and have not been tampered with.
> >
> > Can you clarify "the party performing the live migration" ?
> >
> > Is that referring to the "guest owner" who initiates the migration,
> > or is that referring to the mgmt app control plane.
> >
> 
> I was thinking that the entity issuing qmp_migrate/loadvm should
> guarantee the integrity of the file up to that moment and while QEMU is
> reading it.
> 
> I would say when there's a management application, that is the entity
> we're talking about, but could very well be an end-user issuing commands
> to QEMU directly.


Ok, can you rephrase that a little to make it more clear
that we are definitely *not* talking abut the guest owner
in this scenario. ie the saved state files are assumed to
be under control of the host mgmt app or host admin only,
so there's no privilege boundary involved.

> > The risk I've always been concerned about is the guest owner
> > tampering with state files, though I'm increasing coming to
> > the view point that state files must *never* be allowed to be
> > modified by the guest owner. Mgmt apps must either prevent
> > that through storage permissions, or detect that by digitally
> > signing state files that are theoretically writable by guest
> > owners & validate sig before restore.
> >
> 
> I think it makes sense for the management app to impose such a
> constraint. I'm not so sure about QEMU expecting that it does,
> though. Some apps might have a different opinion and the users are
> probably not going to like losing access.
> 
> Doesn't the guest owner already have control over what goes in the
> migration stream in the first place?

The guest owner only controls what is accessible from their
VM, or what the mgmt APIs they're talking to allow for.

IOW, they should not be able to directly control the structure
of the migration stream vmstate data, nor the XML that libvirt
prepends, only payload in fields within the vmstate.

The issue is that's not the case today with at least some
mgmt apps I fear, but writing this down from QEMU's POV
will help clarify that.

> >> C) The network ports used for migration are expected to be available
> >> only during migration. No long-standing listening destination QEMU
> >> process.
> >
> > I wonder, does that make a difference to our risk ?
> >
> > If we're concerned about an undesirable app/client conjnectnig to a
> > open network port, QEMU has that threat no matter how short the time
> > windows is that the ports are accepting incoming clients.  So I'm
> > not sure this point helps us.
> >
> 
> I'm more worried about an unexpected migration. An incoming vm will just
> take whatever is given to it. If there is a (legitimate) migration
> happening in a short window of time, attempts to hijack that destination
> machine would cause a migration failure and be detectable.
> 
> Now I'm also thinking of an eavesdropper tagging along in some multifd
> channel, if that's even possible.

So overall, I don't think this point has any influence on whether
we'll tag a bug as a security issue or not. This feels like just
guidance on usage of live migration.

> >> D) The network used for migration is expected to be adequately isolated.
> >
> > Is that intended to be in additional to (A) or instead of (A) ?
> >
> > If in addition to (A) then I'm wondering what benefits listing
> > this point brings - what risks are eliminated that TLS does not
> > already eliminate ?
> >
> 
> In addition. Then maybe you're right that there's no additional benefit,
> I can't think of a scenario. However it's common practice for admins to
> not use TLS and rely on network isolation. I don't want to make it seem
> that TLS is mandatory. As Peter pointed out, it's not a default
> configuration.

So if we want to allow non-TLS then we need to combine the
two points to say:

   The migration connection must be either protected with TLS,
   or must run over a fully trusted (virtual private) network.

> >> E) The migration source QEMU process is assumed to be secure. Compromise
> >> of the source QEMU process is nonetheless possible but exploiting the
> >> migration process is expected to grant no further privileges.
> >
> > This is the tricky assumption.
> >
> > Cnsider source host as 2 QEMU processes, one of tenant A and
> > one for tenant B.
> >
> > If tenant A compromises their QEMU, and can wait until a live
> > migration for tenant B is initiating, potentially tenant A can
> > connect to a dest QEMU for tenant B. I would consider that to
> > be gaining privileges.
> >
> 
> I thought of that, but I can't understand how "dest QEMU for tenant B"
> isn't just "dest QEMU for tenant A that has now took over". If none of
> the stream from source B is reaching dest B, then that's harmless.

Two VMs configured with identical virtual hardware should have
the same vmstate structure, and so be compatible from the
POV of live migration flow. They can none the less have different
backend connections. So if tenant A can connect to a incoming
QEMU from tenant B, the live migration can probably succeed,
thus giving tenant A a working VM but with the HDD now backed
by data belonging to tenant B.


> > With TLS we lack fine grained authentication in common setups
> > today that rely on x509 certs configured per-host, not per-QEMU.
> >
> > In current libvirt we're introducing oout of the box support for
> > TLS PSK, which means live migration sessions will be tied to
> > individual matched (src,dst) QEMU pairs, so even if tenant A is
> > compromised they would be able to do a TLS handshake for tenant
> > B's dst QEMU.
> >
> 
> ITYM "wouldn't be able".

Yes.

> > I'd like app mgmt apps to switch to PSK instad of x509 for
> > live migration, but that'll take along time.
> >
> 
> Is TLS PSK a reasonable setup to expect and to include in this policy?

We should probably have a standalone doc for migraton detailing
the recommended configuration scenarios, we could then link to
from this doc if needed.


> > WIth this it seems like the only 2 scenarios where a migration security
> > flaw can be issued are:
> >
> >  * Something goes wrong before/during the TLS handshake
> >  * A bug in source QEMU, somehow allows a guest OS user
> >    to set magic device data that turns into an exploitable
> >    VM state record.
> >
> 
> We don't need a bug in source QEMU, the magic data could be within
> accepted parameters.

I guess there could be a bug in the dest QEMU that trips up over
otherwise valid vmstate data. Dn't recall seeing an example of it
but never say never.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



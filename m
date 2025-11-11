Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 09:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIkdy-0004pP-JF; Tue, 11 Nov 2025 04:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIkdx-0004os-7L
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 04:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vIkdt-0007SH-9B
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 04:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762853182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vTYzTdjpmGhX7DUC8Vq/oWP/BRRooqDWQWC3XV8iTuI=;
 b=fcs8J3dXfpFth55f53MiRy6pFdiKbGeYxn5YIi9x2Nx5rEW0pKij2pBqdRbcQ4B51SKscE
 zzVYsHHuDTMy8TRo5/5CmOOjtLmILWa4stKaxYFGdj8B5lwFUolxj7F40BRMKmv4e3Yy6P
 7kms0a3y9lz/QQL5tS5f9JhRc/xYJd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-n-1FhPbQOuSf1hfcNddn-w-1; Tue,
 11 Nov 2025 04:26:09 -0500
X-MC-Unique: n-1FhPbQOuSf1hfcNddn-w-1
X-Mimecast-MFC-AGG-ID: n-1FhPbQOuSf1hfcNddn-w_1762853168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFCE11955F28; Tue, 11 Nov 2025 09:26:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.84])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 691D91800576; Tue, 11 Nov 2025 09:26:03 +0000 (UTC)
Date: Tue, 11 Nov 2025 09:25:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: Does our interface compatibility promise cover defaults?
Message-ID: <aRMBJeTMy3lmglqb@redhat.com>
References: <875xbhdl59.fsf@pond.sub.org>
 <c3868653-4909-46bd-be59-426e4e4b0b62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3868653-4909-46bd-be59-426e4e4b0b62@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 11, 2025 at 09:58:53AM +0100, Paolo Bonzini wrote:
> On 11/11/25 09:32, Markus Armbruster wrote:
> > > From about/deprecated.rst:
> > 
> >      In general features are intended to be supported indefinitely once
> >      introduced into QEMU. In the event that a feature needs to be removed,
> >      it will be listed in this section. The feature will remain functional for the
> >      release in which it was deprecated and one further release. After these two
> >      releases, the feature is liable to be removed. Deprecated features may also
> >      generate warnings on the console when QEMU starts up, or if activated via a
> >      monitor command, however, this is not a mandatory requirement.
> > 
> > This obviously applies to syntax and semantics of our external
> > interface.
> > 
> > Does it apply to default values there?
> > 
> > If no: does this mean we can change defaults without notice?
> 
> In some sense, versioned machine types are an example "changing the defaults
> without notice": almost every release of QEMU changes the default values for
> -M pc and -M virt.
> 
> But then, while we change the defaults, we provide a way to access the old
> defaults and only remove the old machine types with advance notification.

Machine types are a special case because we've explicitly designed &
documented them to have this behaviour of changing on every release,
long before we even had the deprecation policy, while also providing
the versioned machines for back compat. More recently we documented
a formal 6 year lifecycle for version machines.


When it comes to defaults in general, and interaction with the
deprecation policy, IMHO, we need to consider the goal of the
policy.

Essentially we're trying to make it possible for QEMU to drop
legacy technical debt, while avoiding repeated surprises on
users and mgmt apps. The compromise was to give users a min
two releases prior warning of the change coming along in the
future to give them time to adapt.

We still have the tension there between the two parties.

As maintainers of QEMU we'd like scope of that policy to be as
narrow as possible, while as a user of QEMU I'd like the scope
to be broad enough to cover anything that might break the way
I currently consume QEMU.

IOW, I think users would consider that policy to apply to defaults
in general, modulo exceptions like the non-versioned machine types
/ aliases which have been explicitly designed to change.

> > If yes: does this mean any change of defaults needs notice in
> > about/deprecated.rst and the grace period?
> 
> Generally speaking I'd say so.

With our mix of versioned and non-versioned machine types things are
somewhat fuzzier than that.

If the default is related to a piece of virtual hardware that is
*only* capable of be used by a non-versioned machine type, then
we have generally been happy to change it without notice.

For virtual hardware covered bya versioned machine type, then we
change it, but add the back compat.

IOW, anything related to virtual hardware is pretty loose with
defaults and hasn't gone through the deprecation process.


The defaults for stuff that is backend related, however, is much
more in scope of the deprecation policy IMHO.

>                                 I don't speak much crypto, but the latest
> commit to deprecated.rst (commit d58f9b20c71, "crypto: deprecate use of
> external dh-params.pem file", 2025-11-03) looks like a change of defaults.

NB not really a change in defaults. Traditionally, by default, we would
auto-generate Diffie-Hellman parameters at startup by calling a special
GNUTLS API. GNUTLS now auto-generates Diffie-Hellman parameters without
any special API being required. Its approach to generating has changed
to be RFC compliant. So we removed our code to manually auto-generate
DH parameters.

Both before & after, users could optionally override the generated
defaults with an external dh-params.pem file they created themselves.

Since GNUTLS is now RFC compliant for its auto-generated parameters,
there is no longer a compelling reason to allow the external override
so we're deprecating it.

I expect almost no one will be using the external dh-params.pem file.
Even once we remove it nothing breaks - existing deployments continue
working, just silently switching to the RFC compliant DH params, which
should not have any observable behavioural change for an admin.

TL:DR: the commit d58f9b20c71 is removing an opt-in feature, not a
default.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



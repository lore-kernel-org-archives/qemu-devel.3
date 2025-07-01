Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE1CC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWX0Z-0000zb-AL; Tue, 01 Jul 2025 05:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWWvf-0007PF-F8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uWWvc-0000d0-UD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751360721;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nfCd01WHXXPf7bviuVKsNPOKn2EB6Rm7iWIAz+Kbovc=;
 b=AiS7tjh+yO7TnPTBtAfN+PdWlWmo1HPh3fUCLuboqCin46GsF/nWfob6FXzgN2wBuN52n5
 mjVt3YbSrOPP9jSklmxr5TSUUkd43bJremvs8DhKSxUEamzmpcoDABSXjHgzQgAx7PF3OM
 UQbtDd7eqHvWZL/n5wbUe2PWvvlazm8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-p5d_ooi5NaWFiCZOFwbLDQ-1; Tue,
 01 Jul 2025 05:05:17 -0400
X-MC-Unique: p5d_ooi5NaWFiCZOFwbLDQ-1
X-Mimecast-MFC-AGG-ID: p5d_ooi5NaWFiCZOFwbLDQ_1751360716
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21F70180028C; Tue,  1 Jul 2025 09:05:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.157])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB917195609D; Tue,  1 Jul 2025 09:05:13 +0000 (UTC)
Date: Tue, 1 Jul 2025 10:05:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
Message-ID: <aGOkxrIpbi-tWB25@redhat.com>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de>
 <87cyas88gg.fsf@pond.sub.org> <878qlf7nc0.fsf@suse.de>
 <87o6uayh9r.fsf@pond.sub.org> <87zfdu5zf4.fsf@suse.de>
 <877c0xpsli.fsf@pond.sub.org> <87tt4153ql.fsf@suse.de>
 <8734bg4cde.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734bg4cde.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 01, 2025 at 09:08:13AM +0200, Markus Armbruster wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> Fabiano Rosas <farosas@suse.de> writes:
> >>
> >>> Markus Armbruster <armbru@redhat.com> writes:
> >>>
> >>>> Fabiano Rosas <farosas@suse.de> writes:
> >>>>
> >>>>> Markus Armbruster <armbru@redhat.com> writes:
> >>>>>
> >>>>>> Fabiano Rosas <farosas@suse.de> writes:
> 
> [...]
> 
> >> There more than one way to skin this cat.  I like to keep state
> >> normalized.
> >>
> >> State is an optional StrOrNull.  Possible values:
> >>
> >> * NULL
> >>
> >> * QNull, i.e. non-NULL, ->type is QTYPE_QNULL
> >>
> >> * Empty string, i.e. non-NULL, ->type is QTYPE_QSTRING, ->u.s is ""
> >>
> >> * Non-empty string, i.e. non-NULL, -> type is QTYPE_QSTRING, ->u.s is
> >>   not "" (and cannot be NULL)
> >>
> >> As far as I understand, we have just two cases semantically:
> >>
> >> * Set, value is a non-empty string (empty makes no sense)
> >>
> >> * Unset
> >>
> >> I'd normalize the state to "either NULL, or (non-empty) string".
> >>
> >
> > This is what I wanted to do (in the next version), but it results in
> > more complex and less readable code:
> 
> [...]
> 
> > If we instead normalize to "either non-empty string or empty string"
> > then:
> 
> [...]
> 
> > The query methods get simpler because s->parameters already contains
> > data in the format they expect, we can normalize earlier in [2], which
> > means data is always in the same format throughout
> > qmp_migrate_set_parameters() and lastly, we already have the getter
> > methods [1] which can expose "abc"|NULL to the rest of the code anyway.
> 
> I'd like the possible states to be clearly visible, and suggest to guard
> them with assertions.  Details, such as how exactly the states are
> encoded, are up to you.  You're in a better position to judge them than
> I am.
> 
> >> When writing state, we need to normalize.
> >>
> >> When reading state, we can rely on it being normalized.  Asserting it is
> >> seems prudent, and should help readers.
> >>
> >
> > My main concern is that reading can rely on it being normalized, but the
> > query methods cannot, so they need to do an "extra conversion", which
> > from the reader's POV, will look nonsensical. It's not as simple as
> > using a ternary because the StrOrNull object needs to be allocated.
> 
> [...]
> 
> >>> There are two external interfaces actually.
> >>>
> >>> -global migration.some_compat_option=on (stored in MigrationState):
> >>>
> >>> seems intentional and I believe we'd lose the ability to get out of some
> >>> tricky situations if we ditched it.
> >>>
> >>> -global migation.some_random_option=on (stored in MigrationParameters):
> >>>
> >>> has become a debugging *feature*, which I personally don't use, but
> >>> others do. And worse: we don't know if anyone uses it in production.
> >>
> >> Accidental external interface.
> >>
> >>> We also arbitrarily put x- in front of options for some reason. There is
> >>> an argument to drop those because x- is scary and no one should be using
> >>> them.
> >>
> >> We pretty much ditched the x- convention in the QAPI schema.
> >> docs/devel/qapi-code-gen.rst:
> >>
> >>     Names beginning with ``x-`` used to signify "experimental".  This
> >>     convention has been replaced by special feature "unstable".
> >>
> >> Goes back to
> >>
> >> commit a3c45b3e62962f99338716b1347cfb0d427cea44
> >> Author: Markus Armbruster <armbru@redhat.com>
> >> Date:   Thu Oct 28 12:25:12 2021 +0200
> >>
> >>     qapi: New special feature flag "unstable"
> >>     
> >>     By convention, names starting with "x-" are experimental.  The parts
> >>     of external interfaces so named may be withdrawn or changed
> >>     incompatibly in future releases.
> >
> > This allows dropping about half of the parameters we expose. Deprecate
> > the other half, move the remaining legitimate compat options into
> > MigrationParameters, (which can be set by migrate-set-parameters) and
> > maybe we can remove the TYPE_DEVICE from MigrationState anytime this
> > decade.
> 
> I'd love to get rid of the pseudo-device.
> 
> > Moving all qdev properties to their own TYPE_DEVICE object and putting
> > it under --enable-debug is also an idea.
> >
> > I'm willing to do the work if we ever reach a consensus about this.
> 
> I'd like migration to work more like other long-running tasks: pass the
> entire configuration with the command starting it, provide commands and
> events to manage the task while it runs.
> 
> This is advice, not a demand.  I'm not going to block change the
> migration maintainers want.  I may ask you to do the QAPI schema part in
> certain ways, but that's detail.

This should be doable as IIUC at the end of this series, the QMP
'migrate-incoming' command parameters can express all the required
data for accepting an incoming migration. As such, that parameter
struct could be exposed on the CLI with the CLI json syntax to
accept complex args in a way that wasn't possible historically
with -incoming.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



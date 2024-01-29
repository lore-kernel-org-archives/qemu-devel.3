Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AE7C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURwW-0001FY-KU; Mon, 29 Jan 2024 08:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rURwU-0001EO-Gx
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:44:54 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rURwR-0002t3-KH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:44:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7863B21FB4;
 Mon, 29 Jan 2024 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706535889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFyftbgOZlHgCE5+OmaGiwtPLxz3dTGHKFOgM8pBxDw=;
 b=lKkq9tLi27kwR99aDc5yNxUhPlxXM7K0Q9hhBEDrq3ODyrmVV7lSydon5CzfYmaUSxCCyK
 Y27UN1Pf+VE7QO88pM/w/wbCSMG/oY1GuxzKKybwHsVFgmUVTRHAy3JUTdpfBtt3oUc2K/
 el7hVvuMY3V/hr1bYbcopkQwrrDvnSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706535889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFyftbgOZlHgCE5+OmaGiwtPLxz3dTGHKFOgM8pBxDw=;
 b=P3P9I7K0WT7rtRicawD7j6JDssBOf72l0+mxiwP2NpG7prTQpg4f2AxW495vuxZOCnX0WM
 ymCv9f17m5CqchAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706535889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFyftbgOZlHgCE5+OmaGiwtPLxz3dTGHKFOgM8pBxDw=;
 b=lKkq9tLi27kwR99aDc5yNxUhPlxXM7K0Q9hhBEDrq3ODyrmVV7lSydon5CzfYmaUSxCCyK
 Y27UN1Pf+VE7QO88pM/w/wbCSMG/oY1GuxzKKybwHsVFgmUVTRHAy3JUTdpfBtt3oUc2K/
 el7hVvuMY3V/hr1bYbcopkQwrrDvnSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706535889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFyftbgOZlHgCE5+OmaGiwtPLxz3dTGHKFOgM8pBxDw=;
 b=P3P9I7K0WT7rtRicawD7j6JDssBOf72l0+mxiwP2NpG7prTQpg4f2AxW495vuxZOCnX0WM
 ymCv9f17m5CqchAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04EE413A5D;
 Mon, 29 Jan 2024 13:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1yt7L9Crt2VmKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 13:44:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
In-Reply-To: <Za81vJgTjFSGT56r@x1n>
References: <20240122070600.16681-1-peterx@redhat.com>
 <87plxtgyxx.fsf@suse.de> <Za81vJgTjFSGT56r@x1n>
Date: Mon, 29 Jan 2024 10:44:46 -0300
Message-ID: <87frygdzjl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lKkq9tLi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P3P9I7K0
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7863B21FB4
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jan 22, 2024 at 12:39:06PM -0300, Fabiano Rosas wrote:
>> peterx@redhat.com writes:
>> 
>> > From: Peter Xu <peterx@redhat.com>
>> >
>> > The current article is not extremely easy to follow, and may contain too
>> > much information for someone looking for solutions on VMSD compatibility
>> > issues.  Meanwhile, VMSD versioning is not discussed.
>> >
>> > I'm not yet sure whether we should just obsolete VMSD versioning; it's
>> > still used quite a lot.  And I had a feeling that for simple use cases
>> > where backward migration is not strongly required, device developers can
>> > still consider using it.  So in this patch I decided to keep it (anyway, we
>> > can't drop it in the near future because of massive existing users), and we
>> > can still allow user to use it in contexts where forward-only migration
>> > might be enough.
>> >
>> > This doc patch does below changes:
>> >
>> >   - Rename the page from "Backward compatibility" to "Migration
>> >   compatibility", to avoid using "backward" as a word (because we'll want
>> >   to identify "forward" / "backward" migrations in the new doc)
>> >
>> >   - Add a TOC for this page for better indexing
>> >
>> >   - A new section to explain what is forward/backward migration
>> >
>> >   - A new small section for VMSD just to make things complete
>> >
>> >   - Explain the two ways to make VMSD compatible with old qemu binaries
>> >
>> >     For this one, I added a small section on how to use VMSD versioning for
>> >     new fields just to start such documents.  Rename the old "How backwards
>> >     compatibility works" section to "machine type based (forward+backward
>> >     migration)" to be the 2nd solution (I called it machine type based
>> >     solution). When at it, I provided a summary and a TODO for the 2nd
>> >     solution.
>> >
>> >   - A new section to explain which solution to choose
>> >
>> >   - Moved the other two existing sections into "Extended readings", because
>> >   they can be even further away to most device developers
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  docs/devel/migration/compatibility.rst | 140 ++++++++++++++++++++++++-
>> >  1 file changed, 137 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
>> > index 5a5417ef06..ea9da201ef 100644
>> > --- a/docs/devel/migration/compatibility.rst
>> > +++ b/docs/devel/migration/compatibility.rst
>> > @@ -1,8 +1,139 @@
>> > -Backwards compatibility
>> >  =======================
>> > +Migration compatibility
>> > +=======================
>> > +
>> > +Migration is a hard topic sometimes.  One of the major reason is that it
>> > +has a strict compatibility requirement - a migration (live or not) can
>> > +happen between two different versions of QEMUs, so QEMU needs to make sure
>> 
>> S/QEMUs/QEMU/
>
> I'll fix all these up that you suggested as English issues.
>
>> 
>> > +the migration can work across different versions of QEMU binaries.
>> > +
>> > +This document majorly discusses the compatibility requirement of forward /
>> 
>> s/majorly/mainly/
>> 
>> > +backward migrations that QEMU need to maintain, and what QEMU developers
>> 
>> s/need/needs/
>> 
>> > +should do to achieve such compatibility requirements across different QEMU
>> 
>> maybe s/achieve/maintain/ ?
>> 
>> > +versions.
>> > +
>> > +.. contents::
>> > +
>> > +Types of migrations (forward / backward)
>> > +========================================
>> > +
>> > +Let's firstly define the terms **forward migration** and **backward
>> > +migration**.
>> > +
>> > +.. note::
>> > +
>> > +    To simplify the use case, we always discuss between two consecutive
>> > +    versions of QEMU major releases (between QEMU version *N* and QEMU
>> > +    version *N-1*).  But logically it applies to the case where the two
>> > +    QEMU binaries involved contains more than one major version difference.
>> > +
>> > +.. _forward_migration:
>> > +
>> > +**Forward migration**: can be seen as the use case where a VM cluster can
>> > +upgrade its nodes to a newer version of QEMU (version *N*) from an older
>> > +version of QEMU (version *N-1*).
>> > +
>> > +.. _backward_migration:
>> > +
>> > +**Backward migration**: can be seen as the use case where a VM cluster
>> > +would like to migrate from a newer version of QEMU (version *N*) back to an
>> > +even older version of QEMU (version *N-1*).
>> 
>> I'd drop the VM cluster part from these. Define the terms in a more
>> strict manner (QEMU versions, n/n-1, that's it). Then the parts below
>> could be second paragraphs further detailing the use-cases of the two
>> types of migration.
>
> OK.
>
>> 
>> > +
>> > +A forward migration is more common, where system upgrades are needed.  In
>> > +this case, the upgrade can be done seamlessly by live migrating the old VMs
>> > +to the new VMs with the new binaries.
>> 
>> I got a bit confused whether this was describing migration to a
>> different host or within the same host. I suggest we spell it out some
>> more:
>
> It can be same-host or across-host.
>
>> 
>> "live migrating an existing VM that uses an old QEMU binary to another
>> VM using the newly updated QEMU binary."
>
> Even though I don't see a major difference on how it was reworded.. but I
> can use your version here.
>
>> 
>> > +
>> > +A backward migration can be less common OTOH, because downgrade is less
>> > +common than upgrade for whatever reasons.  However for a production level
>> > +system setup, this should also be allowed, because a cluster can contain
>> > +different versions of QEMU binary.  It should be always allowed to migrate
>> > +between old and new hosts as long as the machine type is supported across
>> > +all the relevant hosts / nodes.
>> > +
>> > +VMState description data structure (VMSD)
>> > +=========================================
>> > +
>> > +VMSD (or in the complete form, **VMStateDescription**) is the data
>> > +structure that QEMU uses to describe data to be migrated for devices.
>> > +Each device should provide its own VMSD structure to describe what it needs
>> > +to be migrated when a VM live migration is requested.
>> > +
>> > +Device VMSD compatibility
>> > +=========================
>> > +
>> > +Then if the VMSD structures need changing, how does the device maintain
>> > +compatibilty?
>> 
>> s/compatibilty/compatibility/
>> 
>> Hm, there's a logical jump here from the _device_ changing to this
>> requiring a change in the VMSD. Also the device is not the thing that
>> maintains compatibility. Again we might need to spell it out:
>> 
>> "When a device data needs to change from one QEMU version to another,
>> how to maintain compatibility?" ... or something like this
>
> OK.
>
>> 
>> >  
>> > -How backwards compatibility works
>> > ----------------------------------
>> > +Here we only discuss VMSD-based migrations.  If one device is not using
>> > +VMSD to migrate its device data, it's considered part of "advanced users",
>> > +then this document may not apply anymore.  If you're writting a new device,
>> > +please always consider starting with VMSD-based migration model.
>> > +
>> > +Consider the case where a device can start to support a new feature in the
>> > +current release, where it wasn't supported before.  The new feature may
>> 
>> s/, where it/ that/
>> 
>> > +require some new device states to be migrated (which can be new VMSD fields
>> > +to be added, or new subsections).  The same question needs to be answered
>> > +when one would like to modify an existing VMSD fields / layouts to fix a
>> 
>> s/an //
>> 
>> > +bug, and so on.
>> > +
>> > +Depending on the goal, the solution to this problem may vary.
>> > +
>> > +If one would like to provide a full support of migration between whatever
>> > +versions, one can try to implement it using :ref:`machine_type_compat`
>> > +solution.  If one would like to provide a fundamental upgrade-only
>> > +compatibility, one could consider to use the simpler
>> > +:ref:`vmsd_versioning_compat` solution.
>> 
>> Should this whole paragraph be put before mentioning VMSD? Otherwise
>> here we are talking about machine type compat after having said: "Here
>> we only discuss VMSD-based migrations".
>
> Note that even with the machine compat properties solution we mentioned
> below, the device will still need some VMSD entry changes, and VMSD is
> still the core of the problem.
>
> The difference is instead of using VMSD versioning, one may need to link
> the VMSD entry to the machine compat properties via either:
>
>   - VMStateDescription.needed(), as a sub-vmsd or,
>
>   - VMStateField.field_exists() as a vmsd field.
>
> That's why I want to keep VMSD a separate section, because it's always the
> core of the problem, no matter for either of the two solutions below.
>
>> 
>> All in all this could be:
>> 
>> up top:
>> Migration compatibility strategies
>> ==================================
>> 
>> When a device data needs to change from one QEMU version to another, how
>> to maintain compatibility?
>> 
>> Depending on the goal, the solution to this problem may vary.
>> 
>> If one would like to provide a full support of migration between
>> arbitrary versions, one can try to implement it using
>> :ref:`machine_type_compat` solution.  If one would like to provide a
>> fundamental upgrade-only compatibility, one could consider to use the
>> simpler :ref:`vmsd_versioning_compat` solution.
>> 
>> VMState description data structure (VMSD)
>> -----------------------------------------
>> 
>> VMSD (or in the complete form, **VMStateDescription**) is the data ...
>> ...
>> 
>> Machine type properties
>> -----------------------
>> 
>> The QEMU machine type is versioned (-machine q35 resolves is equivalent
>> to pc-q35-9.0) and has properties that can be set to different values
>> across machine versions. Those can be used to enable/disable different
>> parts of the code and can be used to help migration compatibility.
>
> Some statement on machine types may be good, but I'm afraid then we'll also
> need to describe more on machine compat properties, which is IMHO even more
> important.  That part is actually more or less covered by the old document
> below (which is pretty long that Juan drafted just a while ago).  That's
> why I didn't mention much on machine types here, leaving that for the rest.
>
> PS: I added a "TODO" though right below for a possible future rewrite [1].
> The current explanation is, IMHO, too much, and not as clear.
>
> The major goal of this doc patch is adding vmsd versioning into the
> picutre, and describe both solutions we can use, while in Juan's old
> version there's no mention of VMSD versioning.  The ultimate goal is in the
> future we can share the doc to other developers when asking similar
> questions.
>
> Since we're at it, I would also like to know how you think about whether we
> should still suggest people using VMSD versioning, as we know that it won't
> work for backward migrations.
>
> My current thoughts is it is still fine, as it's easier to use, and it
> should still be applicable to the cases where a strict migration semantics
> are not required.  However it's hard to justify which device needs that
> strictness.

I'd prefer if we kept things strict. However I don't think we can do
that without having enough testing and specially, clear recipes on how
to add compatibility back once it gets lost. Think of that recent thread
were we discussed an old powerpc issue. How come we can see the fix
today in the code but cannot tell which problem it was trying to solve?
That's bonkers. Ideally every type of breakage would have a mapping into
why it breaks and how to fix it.

So with testing to catch the issue early and a clear step-by-step on how
to identify and fix compatibility, then we could require strict
compatibility for every device.

>
> For example, any device to be used in migration-test must be forward +
> backward migration compatible at least, because you just added the n-1
> regression tests to cover both directions.  Said that, only a few devices
> are involved because currently our migration-test qemu cmdline is pretty
> simple.

We might want to make a distinction between migration core vs. device
state testing. I see n-1 testing more like migration core testing. It's
bad to break migration, but it's really bad to break migration for
everyone because we refactored something deep within migration/.

I also wouldn't mind if we had some simple way for device developers to
add migration tests that cover their code. Currently it's infeasible to
edit migration-test with new command lines for every device of
interest. Maybe we could have a little framework that takes a command
line and spits a migration stream? Something really self-contained,
behind the device's CONFIG in meson.

>
> Fundamentally, IMHO it's because QEMU as a project is used both in
> enterprise and personal emulations.  I think it might be too strict to
> always request backward migration capability if we know some device / arch
> is only used for personal, or educational, purposes.

Do we need migration support tiers? =)

If a machine supports KVM, that's already a good indication that we will
want to have migration working both ways.

If the machine supports only TCG, then migration will probably be a nice
to have for development, but no one would be relying on it in
production. It might be ok to only support forward migration.

Could that be a first filter to reason about this? That might narrow the
list of devices enough.

> The other reason is so far using machine compat properties can sometimes be
> complicated, and I'm not sure whether it's worthwhile we keep requesting
> that to device developers.  Maybe some day we can provide some VMSD macros
> to make that even easier, then we can obsolete VMSD versionings.  But I
> haven't really thought it through.
>
>> 
>> Migration compatibility solutions
>> =================================
>> 
>> VMSD versioning (forward migration only)
>> ----------------------------------------
>> ...
>> 
>> Machine type based (forward+backward migration)
>> -----------------------------------------------
>> ...
>> 
>> > +
>> > +Solutions
>> > +=========
>> > +
>> > +.. _vmsd_versioning_compat:
>> > +
>> > +VMSD versioning (forward migration only)
>> > +----------------------------------------
>> > +
>> > +This is normally the simplest way to support cross-version QEMU live
>> > +migration. The trade-off is backward migration will not be supported. It
>> > +means migrations from new QEMU binaries to old QEMU binaries can fail. It's
>> > +because even if the new QEMU can understand the old version of VMSD by
>> > +proper versioning of the VMSD fields, the old QEMU will not be able to
>> > +understand the new version of VMSD layout.  Then when someone migrates a VM
>> > +using the new VMSD to an older version of QEMU, the old QEMU will not
>> > +accept the new migration stream, reporting that the VSMD version too new.
>> 
>> But we still have _some_ form of backward compat for _some_ kinds of
>> problems by using dummy fields in the VMSD for instance, right?
>
> Just to make sure we're on the same page: UNUSED is definitely needed for
> forward migration, since if without those the old stream will still contain
> the removed field, which on the new binary will be wrongly recognized as
> the "next" field if ever existed, or "extra / unknown" fields, probably
> messing up the next device state.
>
> For backward, I assume it only works if all-zero is a valid state first on
> that field being removed on the old binary.  Otherwise it might still fail
> in weird ways, afaiu.  For that, I'd say that shouldn't be stated as
> supported either as a general approach.
>
>> 
>> > +
>> > +Please have a look at **include/migration/vmstate.h** for more information
>> > +on how to use VMSD versioning.
>> > +
>> > +Taking an example of adding a new field for migration.  The change will
>> > +need to at least contain two parts:
>> > +
>> > +  - Boost existing VMSD version.
>> > +
>> > +  - Add the new VMSD field with the boosted version, with specific
>> > +    **VMSTATE_\*_V()** macros.  For example, **VMSTATE_UINT8_V()** will
>> > +    define an uint8 typed VMSD field with version specified.
>> > +
>> > +.. _machine_type_compat:
>> > +
>> > +Machine type based (forward+backward migration)
>> > +-----------------------------------------------
>> > +
>> > +QEMU developers can leverage machine type compatibile properties to provide
>> 
>> compatible
>> 
>> > +a fully migratable device / protocol, so the migration behavior will be
>> > +defined by the machine type, no matter which QEMU binary will be used.  One
>> > +can reference the entries defined in **hw_compat_\*** global properties for
>> > +examples.
>> > +
>> > +Comparing to VMSD versioning approach above, this may require more code
>> > +changes, but provide a higher level of compatibility that is bound to the
>> > +machine type being used.  To be explicit, since the migration behavior is
>> > +bound to machine type, it will support both forward migration and backward
>> > +migration as long as the machine type is supported.
>> > +
>> > +.. note::
>> > +
>> > +   Currently this section is pretty long.  TODO: rewrite this section to
>> > +   make it easier for QEMU developers to understand.
>
> [1]
>
>> >  
>> >  When we do migration, we have two QEMU processes: the source and the
>> >  target.  There are two cases, they are the same version or they are
>> > @@ -217,6 +348,9 @@ machine types to have the right value::
>> >           ...
>> >       };
>> >  
>> > +Extended readings
>> > +=================
>> > +
>> >  A device with different features on both sides
>> >  ----------------------------------------------
>> 


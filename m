Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A352C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP60U-0007hG-7a; Tue, 10 Jun 2025 16:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uP60S-0007gu-6n
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:55:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uP60P-0005ma-Ft
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:55:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55EA5219A1;
 Tue, 10 Jun 2025 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749588935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guNg54tHiMA7beLDs974U2jyNYjqvunbXNJ0b+QFC2w=;
 b=N5Ndj9Z2sKAS9bsMbgBj5lQNr7czwlZwiSTUaj+pzg25b3b/2Fr5WqaQlUGj2C3ynTDCf3
 SwWCjMufrxmrnm7PGsMYBLbYJzqHhYQU9GEMzocC85pAK+9jW+KZ/2HHPLz5RMAbzWQ/An
 2Kbs93BBwFh0VjU4FtmqxK4ynVegcA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749588935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guNg54tHiMA7beLDs974U2jyNYjqvunbXNJ0b+QFC2w=;
 b=HCg44rMvXXkEoj+Ye0PbyuVQVneYR3eyzvtxzg1M4Tae+r5MTuzDLdtezCKyYqKg/ZzcYv
 s2HxYLnI4C3CQzDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749588935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guNg54tHiMA7beLDs974U2jyNYjqvunbXNJ0b+QFC2w=;
 b=N5Ndj9Z2sKAS9bsMbgBj5lQNr7czwlZwiSTUaj+pzg25b3b/2Fr5WqaQlUGj2C3ynTDCf3
 SwWCjMufrxmrnm7PGsMYBLbYJzqHhYQU9GEMzocC85pAK+9jW+KZ/2HHPLz5RMAbzWQ/An
 2Kbs93BBwFh0VjU4FtmqxK4ynVegcA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749588935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guNg54tHiMA7beLDs974U2jyNYjqvunbXNJ0b+QFC2w=;
 b=HCg44rMvXXkEoj+Ye0PbyuVQVneYR3eyzvtxzg1M4Tae+r5MTuzDLdtezCKyYqKg/ZzcYv
 s2HxYLnI4C3CQzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD0B1139E2;
 Tue, 10 Jun 2025 20:55:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h7dKHsabSGiXLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Jun 2025 20:55:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
In-Reply-To: <aEdFgjAAuagXUyT9@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de> <aENBda_y3v3y4ptS@x1.local>
 <874iwswrex.fsf@suse.de> <aENUrociiqlFuPpz@x1.local>
 <87y0u1ugkx.fsf@suse.de> <aEcC9X5i6eV4N7An@x1.local>
 <87v7p4vlnl.fsf@suse.de> <aEcwaZFSyarnFTPv@x1.local>
 <87plfcvh2l.fsf@suse.de> <aEdFgjAAuagXUyT9@x1.local>
Date: Tue, 10 Jun 2025 17:55:31 -0300
Message-ID: <87jz5juxj0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, Jun 09, 2025 at 04:41:06PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Jun 09, 2025 at 03:02:06PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Mon, Jun 09, 2025 at 11:37:02AM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
>> >> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> >> 
>> >> >> >> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
>> >> >> >> >> Allow the migrate and migrate_incoming commands to pass the migration
>> >> >> >> >> configuration options all at once, dispensing the use of
>> >> >> >> >> migrate-set-parameters and migrate-set-capabilities.
>> >> >> >> >> 
>> >> >> >> >> The motivation of this is to simplify the interface with the
>> >> >> >> >> management layer and avoid the usage of several command invocations to
>> >> >> >> >> configure a migration. It also avoids stale parameters from a previous
>> >> >> >> >> migration to influence the current migration.
>> >> >> >> >> 
>> >> >> >> >> The options that are changed during the migration can still be set
>> >> >> >> >> with the existing commands.
>> >> >> >> >> 
>> >> >> >> >> The order of precedence is:
>> >> >> >> >> 
>> >> >> >> >> 'config' argument > -global cmdline > defaults (migration_properties)
>> >> >> >> >
>> >> >> >> > Could we still keep the QMP migrate-set-parameters values?
>> >> >> >> >
>> >> >> >> >   'config' argument > QMP setups using migrate-set-parameters >
>> >> >> >> >     -global cmdline > defaults (migration_properties)
>> >> >> >> >
>> >> >> >> 
>> >> >> >> That's the case. I failed to mention it in the commit message. IOW it
>> >> >> >> behaves just like today, but the new 'config' way takes precedence over
>> >> >> >> all.
>> >> >> >
>> >> >> > Referring to below chunk of code:
>> >> >> >
>> >> >> > [...]
>> >> >> >
>> >> >> >> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
>> >> >> >> >> +                             Error **errp)
>> >> >> >> >> +{
>> >> >> >> >> +    ERRP_GUARD();
>> >> >> >> >> +
>> >> >> >> >> +    assert(bql_locked());
>> >> >> >> >> +
>> >> >> >> >> +    /* reset to default parameters */
>> >> >> >> >> +    migrate_params_apply(&s->defaults);
>> >> >> >
>> >> >> > IIUC here it'll reset all global parameters using the initial defaults
>> >> >> > first, then apply the "config" specified in "migrate" QMP command?
>> >> >> >
>> >> >> 
>> >> >> Yes, this is so any previously set parameter via migrate-set-parameter
>> >> >> gets erased. I think what we want (but feel free to disagree) is to have
>> >> >> the migrate-set-parameter _eventually_ only handle parameters that need
>> >> >> to be modifed during migration runtime. Anything else can be done via
>> >> >> passing config to qmp_migrate.
>> >> >> 
>> >> >> For -global, I don't have a preference. Having -global take precedence
>> >> >> over all would require a way to know which options were present in the
>> >> >> command-line and which are just the defaults seet in
>> >> >> migration_properties. I currently don't know how to do that. If it is at
>> >> >> all possible (within reason) we could make the change, no worries.
>> >> >> 
>> >> >> > I think there're actually two separate questions to be asked, to make it
>> >> >> > clearer, they are:
>> >> >> 
>> >> >> Here it got ambiguous when you say "global", I've been using -global to
>> >> >> refer to the cmdline -global migration.foo, but others have used global
>> >> >> to mean s->parameters (which has an extended lifetime). Could you
>> >> >> clarify?
>> >> >
>> >> > I meant the -global, and the global setups via migrate-set-parameters.
>> >> >
>> >> > As replied to Dan in the other email, I changed my mind on question (1); I
>> >> > think it makes sense to have it YES.  I left my pure question on (2) there
>> >> > too.
>> >> >
>> >> > Do we really want to disable migrate-set-parameters setting most of the
>> >> > parameters, and only allow it to be set during migration on a few things
>> >> > like bandwidth or so?
>> >> >
>> >> 
>> >> Well, if we decide we have reasons to introduce the "config" concept,
>> >> then I think we should not present two ways of doing the same
>> >> thing. User calls qmp_migrate with its arguments and that's the
>> >> migration. No other ways of setting parameters.
>> >> 
>> >> Since we do have parameters that are set in "runtime" I though of
>> >> keeping migrate-set-parameters around to minimize the interface
>> >> change. Maybe those should have been separate knobs on their own after
>> >> all... But in any case, we can't reject migrate-set-parameters because
>> >> it might happen way earlier than the actual migration command. So I
>> >> don't think anything changes regarding the API.
>> >> 
>> >> > I just don't really see the major benefit of that yet.  I would think it
>> >> > make more sense if we don't need to change any parameters in migration,
>> >> > then provide that in one shot in QMP migrate "config".  Maybe making more
>> >> > sense if migration is not heavily thread-based but having its aiocontext so
>> >> > we could even move to Jobs.
>> >> >
>> >> > Now after all we'll need to allow setting something like bandwidth even
>> >> > during migration alive, and we have all the things ready allowing to set
>> >> > before migration starts, I'm not 100% sure whether we need to bother even
>> >> > if it does look cleaner, because we'll still break mgmt used to be working
>> >> > for years.. I could be over-cautious on breaking things, but I still want
>> >> > to understand better on the benefits.
>> >> >
>> >> 
>> >> Makes sense. We'd say either use the old way or the new way. If both are
>> >> mixed, then the new way takes precedence. That keeps older apps working
>> >> and allows new code to transition into the new way.
>> >
>> > Fair enough.  Yes whenever the new way is chosen it can work in anyway we
>> > define it.
>> >
>> > It's just that if the global list of parameters will still be around then
>> > it seems to have no good reason to not build the migration parameters on
>> > top of the global list of parameters.  After all, anything can be
>> > overwritten in the QMP migrate if needed.
>> >
>> 
>> If we had a way to detect that the user has modified some parameters via
>> the cmdline, then we could merge that with the s->defaults and restore
>> it before applying config, that would achieve what you want. I'm in
>> favor, -global should only be used for debugging, I think it's fine if
>> we let it go through. But anything set by migrate-set-parameters
>> definitely needs to be reset. I just need a way to differentiate between
>> "default parameter" vs. "default parameter that got overwritten by
>> -global". I'll try to figure something out.
>
> I think I see what you meant.  Ignoring -global is ok.  I agree with you
> that should be pure debugging, and feel free to keep it like that if you
> can't find anything to persist it - it may not justify your time spent if
> it grows too much.
>

I think I caused some confusion here. I wrote migrate_params_override()
last thing on a friday and forgot it did the right thing from the
beginning:

    migrate_params_apply(&s->defaults);
    qmp_migrate_set_parameters(new, errp);

This s->defaults is poorly named and is actualy already the merge of
defaults + globals, because qdev does it for us. migrate_params_apply()
will then copy that to s->parameters and qmp_migrate_set_parameters()
will apply the 'new' params from 'config' on top s->parameters. An
example:

Setting multifd-channels (default 2) using various methods and querying
both QMP and HMP:

a) global overrides default:

 $ ./qemu-system-x86_64 -global migration.multifd-channels=4 ...
 => QMP: "multifd-channels": 4, HMP: multifd-channels: 4

b) migrate-set-parameter overrides global:

 { 'execute': 'migrate-set-parameters', 'arguments': { 'multifd-channels': 8 } }
 => QMP: "multifd-channels": 8, HMP: multifd-channels: 8

c) config not touching the parameter, value is reset to global:

 { 'execute': 'migrate', 'arguments': { ..., 'config': { 'multifd': true } } }
 => QMP: "multifd-channels": 4, HMP: multifd-channels: 4

d) config overrides all:

 { 'execute': 'migrate', 'arguments': { ..., 'config': {'multifd-channels': 16 } } }
 => QMP: "multifd-channels": 16, HMP: multifd-channels: 16

Without global:

e) default is set initially

 $ ./qemu-system-x86_64 ...
 => QMP: "multifd-channels": 2, HMP: multifd-channels: 2

f) migrate-set-parameter overrides default:

 { 'execute': 'migrate-set-parameters', 'arguments': { 'multifd-channels': 8 } }
 => QMP: "multifd-channels": 8, HMP: multifd-channels: 8

g) config not touching the parameter, value is reset to default:

 { 'execute': 'migrate', 'arguments': { ..., 'config': { 'multifd': true } } }
 => "multifd-channels": 2, HMP: multifd-channels: 2

h) config overrides all:

 { 'execute': 'migrate', 'arguments': { ..., 'config': {'multifd-channels': 16 } } }
 => QMP: "multifd-channels": 16, HMP: multifd-channels: 16

I'll update the variable names and code comments to be more
precise. Sorry for the noise.


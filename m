Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1594C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOgpB-00084W-7B; Mon, 09 Jun 2025 14:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOgp8-0007zR-6q
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:02:18 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uOgp4-0000Q5-IB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:02:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F8C31F6E6;
 Mon,  9 Jun 2025 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749492130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxfVT0GM0GaktC2LuLyebCIQOybE0epmE+LXDMW8oM8=;
 b=Kh5ZxB21pPBuJxcXksPzMrsiH/P3Y2LWvx1Pk3A/xG8Uu62vMWRkU0FbxMqvgtLSBRJmMB
 OcC3ElLA+2WdpXCDXaiCjFSZKjzIBDR9s+/zfIz4oS5xUmTYzot/VmT6qwBdsAVncxO02+
 oueB7vZqE3d1uiOTUKEd8qdbKAyaUXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749492130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxfVT0GM0GaktC2LuLyebCIQOybE0epmE+LXDMW8oM8=;
 b=Z7exDFXTlgVzyMe7zSZ5XHmgEk0o83zeHlowJOsMz/zOGV3pQ+7HOsiU9t6gVIhZl2oYKI
 gATb+sbKHMyp/7DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kh5ZxB21;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z7exDFXT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749492130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxfVT0GM0GaktC2LuLyebCIQOybE0epmE+LXDMW8oM8=;
 b=Kh5ZxB21pPBuJxcXksPzMrsiH/P3Y2LWvx1Pk3A/xG8Uu62vMWRkU0FbxMqvgtLSBRJmMB
 OcC3ElLA+2WdpXCDXaiCjFSZKjzIBDR9s+/zfIz4oS5xUmTYzot/VmT6qwBdsAVncxO02+
 oueB7vZqE3d1uiOTUKEd8qdbKAyaUXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749492130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxfVT0GM0GaktC2LuLyebCIQOybE0epmE+LXDMW8oM8=;
 b=Z7exDFXTlgVzyMe7zSZ5XHmgEk0o83zeHlowJOsMz/zOGV3pQ+7HOsiU9t6gVIhZl2oYKI
 gATb+sbKHMyp/7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77FB13A1D;
 Mon,  9 Jun 2025 18:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z1x0HaEhR2gFKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Jun 2025 18:02:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
In-Reply-To: <aEcC9X5i6eV4N7An@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de> <aENBda_y3v3y4ptS@x1.local>
 <874iwswrex.fsf@suse.de> <aENUrociiqlFuPpz@x1.local>
 <87y0u1ugkx.fsf@suse.de> <aEcC9X5i6eV4N7An@x1.local>
Date: Mon, 09 Jun 2025 15:02:06 -0300
Message-ID: <87v7p4vlnl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4F8C31F6E6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Mon, Jun 09, 2025 at 11:37:02AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
>> >> >> Allow the migrate and migrate_incoming commands to pass the migration
>> >> >> configuration options all at once, dispensing the use of
>> >> >> migrate-set-parameters and migrate-set-capabilities.
>> >> >> 
>> >> >> The motivation of this is to simplify the interface with the
>> >> >> management layer and avoid the usage of several command invocations to
>> >> >> configure a migration. It also avoids stale parameters from a previous
>> >> >> migration to influence the current migration.
>> >> >> 
>> >> >> The options that are changed during the migration can still be set
>> >> >> with the existing commands.
>> >> >> 
>> >> >> The order of precedence is:
>> >> >> 
>> >> >> 'config' argument > -global cmdline > defaults (migration_properties)
>> >> >
>> >> > Could we still keep the QMP migrate-set-parameters values?
>> >> >
>> >> >   'config' argument > QMP setups using migrate-set-parameters >
>> >> >     -global cmdline > defaults (migration_properties)
>> >> >
>> >> 
>> >> That's the case. I failed to mention it in the commit message. IOW it
>> >> behaves just like today, but the new 'config' way takes precedence over
>> >> all.
>> >
>> > Referring to below chunk of code:
>> >
>> > [...]
>> >
>> >> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
>> >> >> +                             Error **errp)
>> >> >> +{
>> >> >> +    ERRP_GUARD();
>> >> >> +
>> >> >> +    assert(bql_locked());
>> >> >> +
>> >> >> +    /* reset to default parameters */
>> >> >> +    migrate_params_apply(&s->defaults);
>> >
>> > IIUC here it'll reset all global parameters using the initial defaults
>> > first, then apply the "config" specified in "migrate" QMP command?
>> >
>> 
>> Yes, this is so any previously set parameter via migrate-set-parameter
>> gets erased. I think what we want (but feel free to disagree) is to have
>> the migrate-set-parameter _eventually_ only handle parameters that need
>> to be modifed during migration runtime. Anything else can be done via
>> passing config to qmp_migrate.
>> 
>> For -global, I don't have a preference. Having -global take precedence
>> over all would require a way to know which options were present in the
>> command-line and which are just the defaults seet in
>> migration_properties. I currently don't know how to do that. If it is at
>> all possible (within reason) we could make the change, no worries.
>> 
>> > I think there're actually two separate questions to be asked, to make it
>> > clearer, they are:
>> 
>> Here it got ambiguous when you say "global", I've been using -global to
>> refer to the cmdline -global migration.foo, but others have used global
>> to mean s->parameters (which has an extended lifetime). Could you
>> clarify?
>
> I meant the -global, and the global setups via migrate-set-parameters.
>
> As replied to Dan in the other email, I changed my mind on question (1); I
> think it makes sense to have it YES.  I left my pure question on (2) there
> too.
>
> Do we really want to disable migrate-set-parameters setting most of the
> parameters, and only allow it to be set during migration on a few things
> like bandwidth or so?
>

Well, if we decide we have reasons to introduce the "config" concept,
then I think we should not present two ways of doing the same
thing. User calls qmp_migrate with its arguments and that's the
migration. No other ways of setting parameters.

Since we do have parameters that are set in "runtime" I though of
keeping migrate-set-parameters around to minimize the interface
change. Maybe those should have been separate knobs on their own after
all... But in any case, we can't reject migrate-set-parameters because
it might happen way earlier than the actual migration command. So I
don't think anything changes regarding the API.

> I just don't really see the major benefit of that yet.  I would think it
> make more sense if we don't need to change any parameters in migration,
> then provide that in one shot in QMP migrate "config".  Maybe making more
> sense if migration is not heavily thread-based but having its aiocontext so
> we could even move to Jobs.
>
> Now after all we'll need to allow setting something like bandwidth even
> during migration alive, and we have all the things ready allowing to set
> before migration starts, I'm not 100% sure whether we need to bother even
> if it does look cleaner, because we'll still break mgmt used to be working
> for years.. I could be over-cautious on breaking things, but I still want
> to understand better on the benefits.
>

Makes sense. We'd say either use the old way or the new way. If both are
mixed, then the new way takes precedence. That keeps older apps working
and allows new code to transition into the new way.

> One step back, on this "allow migrate to specify 'config'" request: I
> think we can definitely do that as it still provides some kind of
> atomicity.  But frankly speaking I never see it a "real problem" - do
> we really have report or use case showing that Libvirt can trigger
> "migrate" with some global settings touched by other apps at all?
>

I don't think other apps is the problem, but libvirt itself maybe
attempting two migrations in sequence after one of them fails.

There always the possibility that the user is poking around, which of
course is not advisable, but if a weird migration bug shows up it's
difficult to confirm that other app/user hasn't changed the parameters.

> To me, it was yet an illutionary problem, I never know the answer of that.
> If Libvirt is still the owner of QEMU instance via the QMP channel, I
> actually don't really see why the atomicity would even help, even though we
> can still provide that as it's pretty easy as something optional; like what
> this patch does without too much hassle.
>

We can provide it, but I'd rather not unless we agree that is the way
forward. We don't need another way of doing the same as existing
commands.

> Then if to move one step further to remove all global settings, we face
> breaking debugging scripts, and breaking of any old libvirt and non-libvirt
> mgmt apps.  Frankly I really don't yet know whether it's a good idea.  I
> could miss some important reasoning of why we want to do it - it needs to
> be something not relevant to "making the code cleaner", IMHO..

I don't see it as breaking the old stuff. Because any old users would
still be using migrate-set-parameters as usual. So I think your concern
is about calling migrate the new way and also keeping -global
working. As I said, personally I don't mind if put some ifs around to
keep -global working.

Could we add another parameter that says allow-globals (or w/e) and make
everyone happy?



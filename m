Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2EECD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPJb-0008CI-MR; Tue, 02 Jun 2026 09:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUPJZ-0008Aj-BB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:37:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUPJW-0008I7-6p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:37:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 612FF6B0ED;
 Tue,  2 Jun 2026 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780407467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPDZWrQrvp8j1kbdE+WXc6uZg5H54UA0eadxPXQn/+0=;
 b=A2yX1BSKNT9CI3rGdbwEfpxSaJbO8pef939Qdgcj03vmv9OAGXwpEy9gE8sLCdwmh4aW+K
 c6MV9xKu9mIYGi+CHbTtD7LeB9vIf1sXWOBQWwrd6Zi3PzEo5lgtnVg3DEKSwlpnSaG3g9
 hIUmhyAJTquOWf4p11Q5jkwSFHB8jrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780407467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPDZWrQrvp8j1kbdE+WXc6uZg5H54UA0eadxPXQn/+0=;
 b=y9CVPRB4UvydLH4kCwn/pFk4zeYqYR/GoYjnrVQ1zYkwmiQhgnMpY/EGzZ/L4/do38MfQ9
 oteKt1T60uBDCECw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780407467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPDZWrQrvp8j1kbdE+WXc6uZg5H54UA0eadxPXQn/+0=;
 b=A2yX1BSKNT9CI3rGdbwEfpxSaJbO8pef939Qdgcj03vmv9OAGXwpEy9gE8sLCdwmh4aW+K
 c6MV9xKu9mIYGi+CHbTtD7LeB9vIf1sXWOBQWwrd6Zi3PzEo5lgtnVg3DEKSwlpnSaG3g9
 hIUmhyAJTquOWf4p11Q5jkwSFHB8jrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780407467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPDZWrQrvp8j1kbdE+WXc6uZg5H54UA0eadxPXQn/+0=;
 b=y9CVPRB4UvydLH4kCwn/pFk4zeYqYR/GoYjnrVQ1zYkwmiQhgnMpY/EGzZ/L4/do38MfQ9
 oteKt1T60uBDCECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB605779A7;
 Tue,  2 Jun 2026 13:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6G+3LqrcHmoiQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 02 Jun 2026 13:37:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Maciej S.
 Szmigiero" <maciej.szmigiero@oracle.com>, Jason Wang
 <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
In-Reply-To: <ah36ZhBP2TweYhg0@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com> <87pl2ftc12.fsf@suse.de>
 <ahmrcVkOWW5iwozk@x1.local> <87cxyetbc4.fsf@suse.de>
 <ah36ZhBP2TweYhg0@x1.local>
Date: Tue, 02 Jun 2026 10:37:39 -0300
Message-ID: <87zf1d6p24.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 29, 2026 at 01:44:11PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, May 28, 2026 at 07:16:57PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > QEMU doesn't yet have a good way to specify migration parameters so that
>> >> > they can be available even during early stage of QEMU boots.  It is because
>> >> > the migration object (who owns the migration parameters) will only be
>> >> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
>> >> > reading migration parameters is illegal.
>> >> >
>> >> > However, QEMU does have special use cases for such, namely only-migratable
>> >> > flag, and cpr-transfer. Recently, we have one more possible user to read a
>> >> > to-be-introduced new migration parameters during backend initialization
>> >> > phase.  We can introduce yet another global variable (or per-device
>> >> > parameter) to bypass this limitation, but we can also seek for a generic
>> >> > solution that we can setup migration parameters very early, even during
>> >> > backend initializations.
>> >> >
>> >> > See this discussion for more details on the context of the problem:
>> >> >
>> >> >   https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
>> >> >
>> >> > This patch wants to take the latter approach.
>> >> >
>> >> > As a start, introduce a new way to specify migration parameters in QEMU
>> >> > boot commandline, as proposed in the above discussion:
>> >> >
>> >> >   -incoming config:key1=value1,key2=value2,...
>> >> >
>> >> > When specified, QEMU will parse a string formatted MigrationParameters and
>> >> > keep it.  When migration object is created, it will apply all the settings
>> >> > as initial value.
>> >> >
>> >> > Since the application of boot parameters will be after object_new()
>> >> > completes, it means it happens after all machine compat properties or
>> >> > -global settings (which should be done during instance_post_init()).
>> >> >
>> >> > So far, it's still only a way to specify parameters.  All parameters are
>> >> > not visible before migration object created, like before.  Any parameter
>> >> > that needs to be visible during boot will need to opt-in this feature.
>> >> > Follow up patches will switch the current users to use this model.
>> >> >
>> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> >> > ---
>> >> >  include/migration/misc.h |  5 ++++
>> >> >  migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
>> >> >  system/vl.c              |  7 ++++++
>> >> >  qemu-options.hx          | 18 ++++++++++++--
>> >> >  4 files changed, 82 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/include/migration/misc.h b/include/migration/misc.h
>> >> > index 3159a5e53c..aff79b1380 100644
>> >> > --- a/include/migration/misc.h
>> >> > +++ b/include/migration/misc.h
>> >> > @@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
>> >> >  /* Parse @uri and return @channel, returning true on success */
>> >> >  bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> >> >                         Error **errp);
>> >> > +/*
>> >> > + * Parse @config_str in form of "config:key1=value1,..." to initialize
>> >> > + * migration parameters.
>> >> > + */
>> >> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp);
>> >> >  
>> >> 
>> >> 'boot' is not the right word. Maybe 'early'?
>> >
>> > I am ok to switch to "early".  Another option is.. "cmdline"?
>> >
>> 
>> Either is fine.
>> 
>> >> 
>> >> >  /* migration/multifd-device-state.c */
>> >> >  typedef struct SaveCompletePrecopyThreadData {
>> >> > diff --git a/migration/migration.c b/migration/migration.c
>> >> > index 074d3f2c69..d918be7a44 100644
>> >> > --- a/migration/migration.c
>> >> > +++ b/migration/migration.c
>> >> > @@ -41,6 +41,7 @@
>> >> >  #include "qapi/qapi-commands-migration.h"
>> >> >  #include "qapi/qapi-events-migration.h"
>> >> >  #include "qapi/qmp/qerror.h"
>> >> > +#include "qapi/qobject-input-visitor.h"
>> >> >  #include "qobject/qnull.h"
>> >> >  #include "qemu/rcu.h"
>> >> >  #include "postcopy-ram.h"
>> >> > @@ -94,6 +95,9 @@ enum mig_rp_message_type {
>> >> >  static MigrationState *current_migration;
>> >> >  static MigrationIncomingState *current_incoming;
>> >> >  
>> >> > +/* Only used during boot, destroyed after migration object initialized */
>> >> > +static MigrationParameters *mig_boot_params;
>> >> > +
>> >> >  static GSList *migration_blockers[MIG_MODE__MAX];
>> >> >  
>> >> >  static bool migration_object_check(MigrationState *ms, Error **errp);
>> >> > @@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
>> >> >  static void migration_release_dst_files(MigrationState *ms);
>> >> >  static void migration_completion_end(MigrationState *s);
>> >> >  
>> >> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp)
>> >> > +{
>> >> > +    Visitor *v;
>> >> > +
>> >> > +    if (mig_boot_params) {
>> >> > +        error_setg(errp, "Only one -incoming config:* is allowed.");
>> >> > +        return false;
>> >> > +    }
>> >> > +
>> >> > +    v = qobject_input_visitor_new_str(config_str, NULL, errp);
>> >> > +    if (!v) {
>> >> > +        goto fail;
>> >> > +    }
>> >> > +
>> >> > +    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
>> >> > +        goto fail;
>> >> > +    }
>> >> > +
>> >> > +    visit_free(v);
>> >> > +    return true;
>> >> > +
>> >> > +fail:
>> >> > +    visit_free(v);
>> >> > +    return false;
>> >> > +}
>> >> > +
>> >> > +static void migration_parameters_boot_apply(void)
>> >> > +{
>> >> > +    if (mig_boot_params) {
>> >> > +        /*
>> >> > +         * This can fail, because qobject visitor doesn't do sanity check
>> >> > +         * on values while parsing.  It's not too late; we're still in boot
>> >> > +         * phase.
>> >> > +         */
>> >> > +        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
>> >> > +        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
>> >> > +    }
>> >> > +}
>> >> > +
>> >> >  static void migration_downtime_start(MigrationState *s)
>> >> >  {
>> >> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
>> >> > @@ -322,6 +365,17 @@ void migration_object_init(void)
>> >> >  
>> >> >      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>> >> >  
>> >> > +    /*
>> >> > +     * Apply boot migration parameters in case the user specified some via
>> >> > +     * command line "-incoming config:*". NOTE: this will overwrite machine
>> >> > +     * type compat properties and -global settings!
>> >> > +     */
>> >> 
>> >> Hmm, but then it's exactly the same as -global migration.* ? Why do we
>> >> need to extend -incoming?
>> >> 
>> >> Also, I don't see how qmp_migrate_set_parameters can overwrite compat
>> >> properties. They're not part of MigrationParameters.
>> >
>> > Some of this should have been mentioned in my other replies, let me know if
>> > there's still concern over there after reading those.
>> >
>> 
>> The question about -global is non-sensical, forget about it.
>> 
>> > In this case, after we set current_migration pointer compat properties are
>> > applied, due to instance_post_init() happening within object_new().
>> >
>> 
>> Yes, but migration_properties has two distinct sets of Properties, one
>> contains only compat properties that match machine.c properties and the
>> other has properties that go into MigrationParameters. I was under the
>> impression that we never tied compat to parameters.
>> 
>> The only machine compat property that is also a migration parameter I
>> see is zero-page-detection. Maybe we shouldn't have done that. Now we
>> can't decouple MigrationParameters from -global. Unless, of course we
>> declare that from now on compat needs to be done with a new property
>> that's not part of MigrationParameters; and duplicate
>> zero-page-detection.
>
> I always treated migration parameters to be a subset of what we can apply
> to compat properties in the past.
>

Good to know.

> For example, -global almost works the same as compat properties and also at
> the same time, currently both done in device_post_init().
>
> In the future, if your series to convert caps to parameters work, then I
> also want to add even more "parameters" (which used to be caps, like
> postcopy preempt mode) into lists of machine compat properties, so e.g. we
> can enable preempt mode by default.
>
> I hope that makes it useful, but if you still see some benefits of
> splitting the two things (compat properties / parameters), let me know.  I
> may not have fully caught what you're visioning.
>

The problem I see is a long-standing one: MigrationParameters needs to
be embedded into MigrationState because of -global (as both compat and
debug feature). As long as that holds, we'll need workarounds such as
having this extra early state.

But let's not make this a problem to be solved in this series, please
disconsider this discussion.

Just to wrap my thoughts, for reference:

What I want is a migration-owned MigrationParameters that we can do
anything with, decoupled from whatever is needed to expose compat
properties. There's two ways to achieve this: One is to declare
parameters are separate from compat and drop the debug usage (what I
suggested in my previous email). The other is to make MigrationState
stop being a QOM object and instead make MigrationParameters itself be a
QOM object. Then we could reference its members directly from qdev.

>> 
>> >> 
>> >> > +    migration_parameters_boot_apply();
>> >> > +
>> >> > +    /*
>> >> > +     * The boot parameters should have been verified already, but leave it
>> >> > +     * after applying boot parameters to do one check for everything.
>> >> > +     */
>> >> 
>> >> Will it get expensive? We do that for every QEMU start.
>> >
>> > Checking caps and parameters?  Why expensive?
>> >
>> 
>> Just because we're putting more migration code in QEMU's startup
>> path. Most QEMU invocations don't care about migration. Eventually,
>> checking every parameter twice might have an impact.
>
> I would expect most QEMU invocations should care about migration, but
> irrelevant of that.. I never expected these checks to be expensive.
>

Well, only a small subset of invocations will actually result in a
migration. There's many uses of QEMU that don't require, or even cannot
migrate.

> postcopy_ram_supported_by_host() might be the heaviest, but it's
> conditional and I still don't see it an issue. We also don't run any loop.
>
> What made you worry on this?
>

I don't know. The voices in my head.

>> 
>> > Here I should have mentioned we must do one shot check here, because
>> > sometimes there're illegal mixtures of "-incoming config*" and default
>> > values only after they merged together.  I'll update the comment for it,
>> > IOW we must check here anyway.
>> >
>> 
>> Right.
>> 
>> >> 
>> >> >      migration_object_check(current_migration, &error_fatal);
>> >> >  
>> >> >      ram_mig_init();
>> >> > diff --git a/system/vl.c b/system/vl.c
>> >> > index da36b2c6e1..49f5fa0c7b 100644
>> >> > --- a/system/vl.c
>> >> > +++ b/system/vl.c
>> >> > @@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
>> >> >  
>> >> >      if (!strcmp(str, "defer")) {
>> >> >          channel = NULL;
>> >> > +    } else if (!strncmp(str, "config:", 7)) {
>> >> > +        /*
>> >> > +         * This is not a channel setup, but configuration to incoming
>> >> > +         * migration parameters to make them available during early boot.
>> >> > +         */
>> >> > +        migration_parameters_boot_parse(str + 7, &error_fatal);
>> >> > +        return;
>> >> >      } else if (migrate_is_uri(str)) {
>> >> >          migrate_uri_parse(str, &channel, &error_fatal);
>> >> >      } else {
>> >> > diff --git a/qemu-options.hx b/qemu-options.hx
>> >> > index 96ae41f787..1fc92a409a 100644
>> >> > --- a/qemu-options.hx
>> >> > +++ b/qemu-options.hx
>> >> > @@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>> >> >      "-incoming <channel>\n" \
>> >> >      "                accept incoming migration on the migration channel\n" \
>> >> >      "-incoming defer\n" \
>> >> > -    "                wait for the URI to be specified via migrate_incoming\n",
>> >> > +    "                wait for the URI to be specified via migrate_incoming\n"
>> >> > +    "-incoming config:key1=value1,key2=value2,...\n" \
>> >> > +    "                specify migration parameters valid even during boot\n",
>> >> >      QEMU_ARCH_ALL)
>> >> >  SRST
>> >> > +
>> >> >  The -incoming option specifies the migration channel for an incoming
>> >> > -migration.  It may be used multiple times to specify multiple
>> >> > +migration, or can also be used to setup migration parameters for the
>> >> > +incoming migration.  It may be used multiple times to specify multiple
>> >> >  migration channel types.  The channel type is specified in <channel>,
>> >> >  or is 'main' for all other forms of -incoming.  If multiple -incoming
>> >> >  options are specified for a channel type, the last one takes precedence.
>> >> > @@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
>> >> >      Wait for the URI to be specified via migrate\_incoming. The monitor
>> >> >      can be used to change settings (such as migration parameters) prior
>> >> >      to issuing the migrate\_incoming to allow the migration to begin.
>> >> > +
>> >> > +``-incoming config:key1=value1[,key2=value2,...]``
>> >> > +
>> >> > +    Specify migration parameters in QEMU commandlines, so that these
>> >> 
>> >> command line
>> >
>> > Fixed.
>> >
>> >> 
>> >> > +    parameters will be available even during very early boot of QEMU.
>> >> > +    They will be applied properly after QEMU boots and when the migration
>> >> 
>> >> The "applied properly" part is implementation detail.
>> >
>> > True, I simplified it:
>> >
>> > ``-incoming config:key1=value1[,key2=value2,...]``
>> >
>> >     Specify migration parameters in QEMU command line, so that these
>> >     parameters will be available even during very early boot of QEMU.  It
>> >     has similar effect as setting these parameters using QMP command
>> >     ``migrate-set-parameters`` or HMP command ``migrate_set_parameter``.
>> >
>> 
>> ack.
>> 
>> >> 
>> >> > +    core is initialized.  From that POV, it has similar effect as setting
>> >> > +    these parameters using QMP command ``migrate-set-parameters`` or HMP
>> >> > +    command ``migrate_set_parameter``.
>> >> > +
>> >> >  ERST
>> >> >  
>> >> >  DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>> >> 
>> 


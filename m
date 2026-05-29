Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939CCCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 16:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0Jq-0000kH-KK; Fri, 29 May 2026 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wT0Jo-0000jw-SO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:44:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wT0Jm-0007Ch-7A
 for qemu-devel@nongnu.org; Fri, 29 May 2026 12:44:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D878A66DB9;
 Fri, 29 May 2026 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780073054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIR8ldmFk/8NCAmwzLgrL1AlP2jHKHnPdVQbTb6Q6go=;
 b=X9Dho32EozBUrOJ7WaHk1R2ailJFUXGd+kiwzYS3i9cIz5+fsVApeWg9uBfQuR9iwQZziD
 84jOFgm9gHJ3FbVRel2YkDLmpU4ifO18PM5F/rA+ZvBxXhIQwYf9lcOOlme4zRqvhuHKut
 pvh2yPzqtElBRw+c5pjvQg4I7NOMB0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780073054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIR8ldmFk/8NCAmwzLgrL1AlP2jHKHnPdVQbTb6Q6go=;
 b=ZmKXQPwxw7J7WNl24TAXFWIdPU1kzm74coSzsSxZlgoAh7s/mFB1ujrXbZaaLV4jiLP/jE
 w10W0mkm7dj5+WDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780073054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIR8ldmFk/8NCAmwzLgrL1AlP2jHKHnPdVQbTb6Q6go=;
 b=X9Dho32EozBUrOJ7WaHk1R2ailJFUXGd+kiwzYS3i9cIz5+fsVApeWg9uBfQuR9iwQZziD
 84jOFgm9gHJ3FbVRel2YkDLmpU4ifO18PM5F/rA+ZvBxXhIQwYf9lcOOlme4zRqvhuHKut
 pvh2yPzqtElBRw+c5pjvQg4I7NOMB0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780073054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIR8ldmFk/8NCAmwzLgrL1AlP2jHKHnPdVQbTb6Q6go=;
 b=ZmKXQPwxw7J7WNl24TAXFWIdPU1kzm74coSzsSxZlgoAh7s/mFB1ujrXbZaaLV4jiLP/jE
 w10W0mkm7dj5+WDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A9A779A7;
 Fri, 29 May 2026 16:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rLqlCl7CGWoiBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 May 2026 16:44:14 +0000
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
In-Reply-To: <ahmrcVkOWW5iwozk@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com> <87pl2ftc12.fsf@suse.de>
 <ahmrcVkOWW5iwozk@x1.local>
Date: Fri, 29 May 2026 13:44:11 -0300
Message-ID: <87cxyetbc4.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 28, 2026 at 07:16:57PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > QEMU doesn't yet have a good way to specify migration parameters so that
>> > they can be available even during early stage of QEMU boots.  It is because
>> > the migration object (who owns the migration parameters) will only be
>> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
>> > reading migration parameters is illegal.
>> >
>> > However, QEMU does have special use cases for such, namely only-migratable
>> > flag, and cpr-transfer. Recently, we have one more possible user to read a
>> > to-be-introduced new migration parameters during backend initialization
>> > phase.  We can introduce yet another global variable (or per-device
>> > parameter) to bypass this limitation, but we can also seek for a generic
>> > solution that we can setup migration parameters very early, even during
>> > backend initializations.
>> >
>> > See this discussion for more details on the context of the problem:
>> >
>> >   https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
>> >
>> > This patch wants to take the latter approach.
>> >
>> > As a start, introduce a new way to specify migration parameters in QEMU
>> > boot commandline, as proposed in the above discussion:
>> >
>> >   -incoming config:key1=value1,key2=value2,...
>> >
>> > When specified, QEMU will parse a string formatted MigrationParameters and
>> > keep it.  When migration object is created, it will apply all the settings
>> > as initial value.
>> >
>> > Since the application of boot parameters will be after object_new()
>> > completes, it means it happens after all machine compat properties or
>> > -global settings (which should be done during instance_post_init()).
>> >
>> > So far, it's still only a way to specify parameters.  All parameters are
>> > not visible before migration object created, like before.  Any parameter
>> > that needs to be visible during boot will need to opt-in this feature.
>> > Follow up patches will switch the current users to use this model.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/migration/misc.h |  5 ++++
>> >  migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
>> >  system/vl.c              |  7 ++++++
>> >  qemu-options.hx          | 18 ++++++++++++--
>> >  4 files changed, 82 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/migration/misc.h b/include/migration/misc.h
>> > index 3159a5e53c..aff79b1380 100644
>> > --- a/include/migration/misc.h
>> > +++ b/include/migration/misc.h
>> > @@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
>> >  /* Parse @uri and return @channel, returning true on success */
>> >  bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> >                         Error **errp);
>> > +/*
>> > + * Parse @config_str in form of "config:key1=value1,..." to initialize
>> > + * migration parameters.
>> > + */
>> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp);
>> >  
>> 
>> 'boot' is not the right word. Maybe 'early'?
>
> I am ok to switch to "early".  Another option is.. "cmdline"?
>

Either is fine.

>> 
>> >  /* migration/multifd-device-state.c */
>> >  typedef struct SaveCompletePrecopyThreadData {
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 074d3f2c69..d918be7a44 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -41,6 +41,7 @@
>> >  #include "qapi/qapi-commands-migration.h"
>> >  #include "qapi/qapi-events-migration.h"
>> >  #include "qapi/qmp/qerror.h"
>> > +#include "qapi/qobject-input-visitor.h"
>> >  #include "qobject/qnull.h"
>> >  #include "qemu/rcu.h"
>> >  #include "postcopy-ram.h"
>> > @@ -94,6 +95,9 @@ enum mig_rp_message_type {
>> >  static MigrationState *current_migration;
>> >  static MigrationIncomingState *current_incoming;
>> >  
>> > +/* Only used during boot, destroyed after migration object initialized */
>> > +static MigrationParameters *mig_boot_params;
>> > +
>> >  static GSList *migration_blockers[MIG_MODE__MAX];
>> >  
>> >  static bool migration_object_check(MigrationState *ms, Error **errp);
>> > @@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
>> >  static void migration_release_dst_files(MigrationState *ms);
>> >  static void migration_completion_end(MigrationState *s);
>> >  
>> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp)
>> > +{
>> > +    Visitor *v;
>> > +
>> > +    if (mig_boot_params) {
>> > +        error_setg(errp, "Only one -incoming config:* is allowed.");
>> > +        return false;
>> > +    }
>> > +
>> > +    v = qobject_input_visitor_new_str(config_str, NULL, errp);
>> > +    if (!v) {
>> > +        goto fail;
>> > +    }
>> > +
>> > +    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
>> > +        goto fail;
>> > +    }
>> > +
>> > +    visit_free(v);
>> > +    return true;
>> > +
>> > +fail:
>> > +    visit_free(v);
>> > +    return false;
>> > +}
>> > +
>> > +static void migration_parameters_boot_apply(void)
>> > +{
>> > +    if (mig_boot_params) {
>> > +        /*
>> > +         * This can fail, because qobject visitor doesn't do sanity check
>> > +         * on values while parsing.  It's not too late; we're still in boot
>> > +         * phase.
>> > +         */
>> > +        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
>> > +        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
>> > +    }
>> > +}
>> > +
>> >  static void migration_downtime_start(MigrationState *s)
>> >  {
>> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
>> > @@ -322,6 +365,17 @@ void migration_object_init(void)
>> >  
>> >      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>> >  
>> > +    /*
>> > +     * Apply boot migration parameters in case the user specified some via
>> > +     * command line "-incoming config:*". NOTE: this will overwrite machine
>> > +     * type compat properties and -global settings!
>> > +     */
>> 
>> Hmm, but then it's exactly the same as -global migration.* ? Why do we
>> need to extend -incoming?
>> 
>> Also, I don't see how qmp_migrate_set_parameters can overwrite compat
>> properties. They're not part of MigrationParameters.
>
> Some of this should have been mentioned in my other replies, let me know if
> there's still concern over there after reading those.
>

The question about -global is non-sensical, forget about it.

> In this case, after we set current_migration pointer compat properties are
> applied, due to instance_post_init() happening within object_new().
>

Yes, but migration_properties has two distinct sets of Properties, one
contains only compat properties that match machine.c properties and the
other has properties that go into MigrationParameters. I was under the
impression that we never tied compat to parameters.

The only machine compat property that is also a migration parameter I
see is zero-page-detection. Maybe we shouldn't have done that. Now we
can't decouple MigrationParameters from -global. Unless, of course we
declare that from now on compat needs to be done with a new property
that's not part of MigrationParameters; and duplicate
zero-page-detection.

>> 
>> > +    migration_parameters_boot_apply();
>> > +
>> > +    /*
>> > +     * The boot parameters should have been verified already, but leave it
>> > +     * after applying boot parameters to do one check for everything.
>> > +     */
>> 
>> Will it get expensive? We do that for every QEMU start.
>
> Checking caps and parameters?  Why expensive?
>

Just because we're putting more migration code in QEMU's startup
path. Most QEMU invocations don't care about migration. Eventually,
checking every parameter twice might have an impact.

> Here I should have mentioned we must do one shot check here, because
> sometimes there're illegal mixtures of "-incoming config*" and default
> values only after they merged together.  I'll update the comment for it,
> IOW we must check here anyway.
>

Right.

>> 
>> >      migration_object_check(current_migration, &error_fatal);
>> >  
>> >      ram_mig_init();
>> > diff --git a/system/vl.c b/system/vl.c
>> > index da36b2c6e1..49f5fa0c7b 100644
>> > --- a/system/vl.c
>> > +++ b/system/vl.c
>> > @@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
>> >  
>> >      if (!strcmp(str, "defer")) {
>> >          channel = NULL;
>> > +    } else if (!strncmp(str, "config:", 7)) {
>> > +        /*
>> > +         * This is not a channel setup, but configuration to incoming
>> > +         * migration parameters to make them available during early boot.
>> > +         */
>> > +        migration_parameters_boot_parse(str + 7, &error_fatal);
>> > +        return;
>> >      } else if (migrate_is_uri(str)) {
>> >          migrate_uri_parse(str, &channel, &error_fatal);
>> >      } else {
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 96ae41f787..1fc92a409a 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>> >      "-incoming <channel>\n" \
>> >      "                accept incoming migration on the migration channel\n" \
>> >      "-incoming defer\n" \
>> > -    "                wait for the URI to be specified via migrate_incoming\n",
>> > +    "                wait for the URI to be specified via migrate_incoming\n"
>> > +    "-incoming config:key1=value1,key2=value2,...\n" \
>> > +    "                specify migration parameters valid even during boot\n",
>> >      QEMU_ARCH_ALL)
>> >  SRST
>> > +
>> >  The -incoming option specifies the migration channel for an incoming
>> > -migration.  It may be used multiple times to specify multiple
>> > +migration, or can also be used to setup migration parameters for the
>> > +incoming migration.  It may be used multiple times to specify multiple
>> >  migration channel types.  The channel type is specified in <channel>,
>> >  or is 'main' for all other forms of -incoming.  If multiple -incoming
>> >  options are specified for a channel type, the last one takes precedence.
>> > @@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
>> >      Wait for the URI to be specified via migrate\_incoming. The monitor
>> >      can be used to change settings (such as migration parameters) prior
>> >      to issuing the migrate\_incoming to allow the migration to begin.
>> > +
>> > +``-incoming config:key1=value1[,key2=value2,...]``
>> > +
>> > +    Specify migration parameters in QEMU commandlines, so that these
>> 
>> command line
>
> Fixed.
>
>> 
>> > +    parameters will be available even during very early boot of QEMU.
>> > +    They will be applied properly after QEMU boots and when the migration
>> 
>> The "applied properly" part is implementation detail.
>
> True, I simplified it:
>
> ``-incoming config:key1=value1[,key2=value2,...]``
>
>     Specify migration parameters in QEMU command line, so that these
>     parameters will be available even during very early boot of QEMU.  It
>     has similar effect as setting these parameters using QMP command
>     ``migrate-set-parameters`` or HMP command ``migrate_set_parameter``.
>

ack.

>> 
>> > +    core is initialized.  From that POV, it has similar effect as setting
>> > +    these parameters using QMP command ``migrate-set-parameters`` or HMP
>> > +    command ``migrate_set_parameter``.
>> > +
>> >  ERST
>> >  
>> >  DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>> 


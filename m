Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5DDCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAFN-0001E4-KN; Mon, 01 Jun 2026 17:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUAFM-0001Dw-RF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUAFK-0007ey-6z
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780349547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lh7/U0ecMpIMpHc61EvpB1bg7zxfn07WCG5YDBzVxnc=;
 b=HUF+TZuZSIWroYlhGVKL8zkhE+ww8L5pfLWNk5Fj0ilOwbD0bLz37XbxQhtNUc8Ys7oDQW
 c/j6CEfXA0YJFhLxkdjxh0rrNQB6YTwoSi5pPG1ptPCavHmmWTTzKHWnJlwqDDOkvA+3Lj
 JUQQuPZbZrb49ldOipaGkN3G7QfVOAk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-gkVPHMtLMGCjYYEkXSRVgw-1; Mon, 01 Jun 2026 17:32:26 -0400
X-MC-Unique: gkVPHMtLMGCjYYEkXSRVgw-1
X-Mimecast-MFC-AGG-ID: gkVPHMtLMGCjYYEkXSRVgw_1780349546
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cce1c3c26bso62905516d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780349546; x=1780954346; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh7/U0ecMpIMpHc61EvpB1bg7zxfn07WCG5YDBzVxnc=;
 b=MHLEtqdDu3IneOQ8jXljVTr/pcf4GfAkQfWMWY0gBKMySZI+pxrmgDAuGGGHbAiRyQ
 H1maFm0He2rAP5R8FAdHa9FP7q1CJxFBmVTNo7FJXNXzBQZ2Z4LLWLDP22IglzfIm9Bz
 ijcEKhjoRX8IcetrSCqKsW7YHoZHXJ3HD6huCZ+QtXUY0Syn7HMFddokUlfAhcHBAc52
 6K+9HrYE7dQgva9jMMyPSKb6wHGdgAapjDpZKKTHmN1gf4X2hzwH5jGuU7LGi34unx2Z
 oIAjEVXJlXuWrm2y7WPxumVUFZ3dJHTsyph+vCnL5D/14WORP8pPgW7/CuCKPzZ/pziZ
 CgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780349546; x=1780954346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lh7/U0ecMpIMpHc61EvpB1bg7zxfn07WCG5YDBzVxnc=;
 b=Nrt2g9udRVqfzNKLL7dBRltAexTTdKbzVCRoifD3WXeZUmajgAeMWdEr1dn7vl+UcO
 vicZoXTnRMOAKWL9NPVD3rUDpkflvtgtGF3K1BNgGrBE48PHDHEMxIm5nK3A5KtdxqN4
 Y2gQ/5seZJTmQzMf0If6f3UHyRKKQI2PWqgbxpoUZtJPb037yhQw1bcGBr9aChYjCwNq
 G4/kpSvB3wpT0tRaY7LAUx1CFn1aRCOry36Rn1f4GzGEJmgj37VcXZu6suZwtZ6+IPUR
 JFAOiXPmPGBM0d1UbOmX4aHJwcbLoj9OnMBJ36i0npwWPLSGJlVshbdmCLoW7M+KWszX
 MC4g==
X-Gm-Message-State: AOJu0Yze7urQERnKwnVLUEpoBBih2nOd6hET9jqQ81ALbDAanGI/uZ5B
 fqEZb0EalfgrukPioKBSWxl5JlpmyuPOBgJgwYDmdi66yOEBaJFtXPXGCewDyGq1L+DyvSwFkSA
 Nl+DacUPRORMiTgGe83h/peUSYz+als5JM/M/EUYD43/JZXH7iM4B9s0F
X-Gm-Gg: Acq92OELUtI1ieakBJVFlm0yCVqYoVajUj8ewxx7bNz1lrD5v1NKr6UByhH0OohEaKU
 c07iAnARcamu5qxXVNgPJpYMdGGDAp6KV59O84DdulyrQT4Q13m3mV1jcwEWn7a9DWGWwd8aAKR
 gFzYLJ3jyBNb7TuoU2Znp8drABKCa1/b+g1ej/CYLzmAGM9v0CtPYgG8aLAZ1e2RnspjjXoNFj9
 mT4ni273WNrxGY0LawBeF0OJSko1oBLh8QyB0zW31E22/3mqzpT/4S4nqvBj8xlqUEfwCrxq3fU
 Jp9iml2opxiIXerabSAFRzozt4OPDQ82qPCD2pqeXQbi0o6eYMu67wOScoGRqMwhHvosHsJbc6F
 SQR7AKwNDb1XUG5rn/nRCR7Ri7w==
X-Received: by 2002:a05:620a:648d:b0:915:2ab1:389a with SMTP id
 af79cd13be357-9153dc29868mr1901127085a.44.1780349545550; 
 Mon, 01 Jun 2026 14:32:25 -0700 (PDT)
X-Received: by 2002:a05:620a:648d:b0:915:2ab1:389a with SMTP id
 af79cd13be357-9153dc29868mr1901121485a.44.1780349544961; 
 Mon, 01 Jun 2026 14:32:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153262b95esm1154656085a.37.2026.06.01.14.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:32:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:32:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <ah36ZhBP2TweYhg0@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <87pl2ftc12.fsf@suse.de> <ahmrcVkOWW5iwozk@x1.local>
 <87cxyetbc4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cxyetbc4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 29, 2026 at 01:44:11PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 28, 2026 at 07:16:57PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > QEMU doesn't yet have a good way to specify migration parameters so that
> >> > they can be available even during early stage of QEMU boots.  It is because
> >> > the migration object (who owns the migration parameters) will only be
> >> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
> >> > reading migration parameters is illegal.
> >> >
> >> > However, QEMU does have special use cases for such, namely only-migratable
> >> > flag, and cpr-transfer. Recently, we have one more possible user to read a
> >> > to-be-introduced new migration parameters during backend initialization
> >> > phase.  We can introduce yet another global variable (or per-device
> >> > parameter) to bypass this limitation, but we can also seek for a generic
> >> > solution that we can setup migration parameters very early, even during
> >> > backend initializations.
> >> >
> >> > See this discussion for more details on the context of the problem:
> >> >
> >> >   https://lore.kernel.org/r/ahdI7Vl5KraK566D@x1.local
> >> >
> >> > This patch wants to take the latter approach.
> >> >
> >> > As a start, introduce a new way to specify migration parameters in QEMU
> >> > boot commandline, as proposed in the above discussion:
> >> >
> >> >   -incoming config:key1=value1,key2=value2,...
> >> >
> >> > When specified, QEMU will parse a string formatted MigrationParameters and
> >> > keep it.  When migration object is created, it will apply all the settings
> >> > as initial value.
> >> >
> >> > Since the application of boot parameters will be after object_new()
> >> > completes, it means it happens after all machine compat properties or
> >> > -global settings (which should be done during instance_post_init()).
> >> >
> >> > So far, it's still only a way to specify parameters.  All parameters are
> >> > not visible before migration object created, like before.  Any parameter
> >> > that needs to be visible during boot will need to opt-in this feature.
> >> > Follow up patches will switch the current users to use this model.
> >> >
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  include/migration/misc.h |  5 ++++
> >> >  migration/migration.c    | 54 ++++++++++++++++++++++++++++++++++++++++
> >> >  system/vl.c              |  7 ++++++
> >> >  qemu-options.hx          | 18 ++++++++++++--
> >> >  4 files changed, 82 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/include/migration/misc.h b/include/migration/misc.h
> >> > index 3159a5e53c..aff79b1380 100644
> >> > --- a/include/migration/misc.h
> >> > +++ b/include/migration/misc.h
> >> > @@ -133,6 +133,11 @@ bool migrate_is_uri(const char *uri);
> >> >  /* Parse @uri and return @channel, returning true on success */
> >> >  bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> >> >                         Error **errp);
> >> > +/*
> >> > + * Parse @config_str in form of "config:key1=value1,..." to initialize
> >> > + * migration parameters.
> >> > + */
> >> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp);
> >> >  
> >> 
> >> 'boot' is not the right word. Maybe 'early'?
> >
> > I am ok to switch to "early".  Another option is.. "cmdline"?
> >
> 
> Either is fine.
> 
> >> 
> >> >  /* migration/multifd-device-state.c */
> >> >  typedef struct SaveCompletePrecopyThreadData {
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index 074d3f2c69..d918be7a44 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -41,6 +41,7 @@
> >> >  #include "qapi/qapi-commands-migration.h"
> >> >  #include "qapi/qapi-events-migration.h"
> >> >  #include "qapi/qmp/qerror.h"
> >> > +#include "qapi/qobject-input-visitor.h"
> >> >  #include "qobject/qnull.h"
> >> >  #include "qemu/rcu.h"
> >> >  #include "postcopy-ram.h"
> >> > @@ -94,6 +95,9 @@ enum mig_rp_message_type {
> >> >  static MigrationState *current_migration;
> >> >  static MigrationIncomingState *current_incoming;
> >> >  
> >> > +/* Only used during boot, destroyed after migration object initialized */
> >> > +static MigrationParameters *mig_boot_params;
> >> > +
> >> >  static GSList *migration_blockers[MIG_MODE__MAX];
> >> >  
> >> >  static bool migration_object_check(MigrationState *ms, Error **errp);
> >> > @@ -102,6 +106,45 @@ static bool stop_return_path_thread_on_source(MigrationState *s);
> >> >  static void migration_release_dst_files(MigrationState *ms);
> >> >  static void migration_completion_end(MigrationState *s);
> >> >  
> >> > +bool migration_parameters_boot_parse(const char *config_str, Error **errp)
> >> > +{
> >> > +    Visitor *v;
> >> > +
> >> > +    if (mig_boot_params) {
> >> > +        error_setg(errp, "Only one -incoming config:* is allowed.");
> >> > +        return false;
> >> > +    }
> >> > +
> >> > +    v = qobject_input_visitor_new_str(config_str, NULL, errp);
> >> > +    if (!v) {
> >> > +        goto fail;
> >> > +    }
> >> > +
> >> > +    if (!visit_type_MigrationParameters(v, NULL, &mig_boot_params, errp)) {
> >> > +        goto fail;
> >> > +    }
> >> > +
> >> > +    visit_free(v);
> >> > +    return true;
> >> > +
> >> > +fail:
> >> > +    visit_free(v);
> >> > +    return false;
> >> > +}
> >> > +
> >> > +static void migration_parameters_boot_apply(void)
> >> > +{
> >> > +    if (mig_boot_params) {
> >> > +        /*
> >> > +         * This can fail, because qobject visitor doesn't do sanity check
> >> > +         * on values while parsing.  It's not too late; we're still in boot
> >> > +         * phase.
> >> > +         */
> >> > +        qmp_migrate_set_parameters(mig_boot_params, &error_abort);
> >> > +        g_clear_pointer(&mig_boot_params, qapi_free_MigrationParameters);
> >> > +    }
> >> > +}
> >> > +
> >> >  static void migration_downtime_start(MigrationState *s)
> >> >  {
> >> >      trace_vmstate_downtime_checkpoint("src-downtime-start");
> >> > @@ -322,6 +365,17 @@ void migration_object_init(void)
> >> >  
> >> >      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> >> >  
> >> > +    /*
> >> > +     * Apply boot migration parameters in case the user specified some via
> >> > +     * command line "-incoming config:*". NOTE: this will overwrite machine
> >> > +     * type compat properties and -global settings!
> >> > +     */
> >> 
> >> Hmm, but then it's exactly the same as -global migration.* ? Why do we
> >> need to extend -incoming?
> >> 
> >> Also, I don't see how qmp_migrate_set_parameters can overwrite compat
> >> properties. They're not part of MigrationParameters.
> >
> > Some of this should have been mentioned in my other replies, let me know if
> > there's still concern over there after reading those.
> >
> 
> The question about -global is non-sensical, forget about it.
> 
> > In this case, after we set current_migration pointer compat properties are
> > applied, due to instance_post_init() happening within object_new().
> >
> 
> Yes, but migration_properties has two distinct sets of Properties, one
> contains only compat properties that match machine.c properties and the
> other has properties that go into MigrationParameters. I was under the
> impression that we never tied compat to parameters.
> 
> The only machine compat property that is also a migration parameter I
> see is zero-page-detection. Maybe we shouldn't have done that. Now we
> can't decouple MigrationParameters from -global. Unless, of course we
> declare that from now on compat needs to be done with a new property
> that's not part of MigrationParameters; and duplicate
> zero-page-detection.

I always treated migration parameters to be a subset of what we can apply
to compat properties in the past.

For example, -global almost works the same as compat properties and also at
the same time, currently both done in device_post_init().

In the future, if your series to convert caps to parameters work, then I
also want to add even more "parameters" (which used to be caps, like
postcopy preempt mode) into lists of machine compat properties, so e.g. we
can enable preempt mode by default.

I hope that makes it useful, but if you still see some benefits of
splitting the two things (compat properties / parameters), let me know.  I
may not have fully caught what you're visioning.

> 
> >> 
> >> > +    migration_parameters_boot_apply();
> >> > +
> >> > +    /*
> >> > +     * The boot parameters should have been verified already, but leave it
> >> > +     * after applying boot parameters to do one check for everything.
> >> > +     */
> >> 
> >> Will it get expensive? We do that for every QEMU start.
> >
> > Checking caps and parameters?  Why expensive?
> >
> 
> Just because we're putting more migration code in QEMU's startup
> path. Most QEMU invocations don't care about migration. Eventually,
> checking every parameter twice might have an impact.

I would expect most QEMU invocations should care about migration, but
irrelevant of that.. I never expected these checks to be expensive.

postcopy_ram_supported_by_host() might be the heaviest, but it's
conditional and I still don't see it an issue. We also don't run any loop.

What made you worry on this?

> 
> > Here I should have mentioned we must do one shot check here, because
> > sometimes there're illegal mixtures of "-incoming config*" and default
> > values only after they merged together.  I'll update the comment for it,
> > IOW we must check here anyway.
> >
> 
> Right.
> 
> >> 
> >> >      migration_object_check(current_migration, &error_fatal);
> >> >  
> >> >      ram_mig_init();
> >> > diff --git a/system/vl.c b/system/vl.c
> >> > index da36b2c6e1..49f5fa0c7b 100644
> >> > --- a/system/vl.c
> >> > +++ b/system/vl.c
> >> > @@ -1838,6 +1838,13 @@ static void incoming_option_parse(const char *str)
> >> >  
> >> >      if (!strcmp(str, "defer")) {
> >> >          channel = NULL;
> >> > +    } else if (!strncmp(str, "config:", 7)) {
> >> > +        /*
> >> > +         * This is not a channel setup, but configuration to incoming
> >> > +         * migration parameters to make them available during early boot.
> >> > +         */
> >> > +        migration_parameters_boot_parse(str + 7, &error_fatal);
> >> > +        return;
> >> >      } else if (migrate_is_uri(str)) {
> >> >          migrate_uri_parse(str, &channel, &error_fatal);
> >> >      } else {
> >> > diff --git a/qemu-options.hx b/qemu-options.hx
> >> > index 96ae41f787..1fc92a409a 100644
> >> > --- a/qemu-options.hx
> >> > +++ b/qemu-options.hx
> >> > @@ -5366,11 +5366,15 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
> >> >      "-incoming <channel>\n" \
> >> >      "                accept incoming migration on the migration channel\n" \
> >> >      "-incoming defer\n" \
> >> > -    "                wait for the URI to be specified via migrate_incoming\n",
> >> > +    "                wait for the URI to be specified via migrate_incoming\n"
> >> > +    "-incoming config:key1=value1,key2=value2,...\n" \
> >> > +    "                specify migration parameters valid even during boot\n",
> >> >      QEMU_ARCH_ALL)
> >> >  SRST
> >> > +
> >> >  The -incoming option specifies the migration channel for an incoming
> >> > -migration.  It may be used multiple times to specify multiple
> >> > +migration, or can also be used to setup migration parameters for the
> >> > +incoming migration.  It may be used multiple times to specify multiple
> >> >  migration channel types.  The channel type is specified in <channel>,
> >> >  or is 'main' for all other forms of -incoming.  If multiple -incoming
> >> >  options are specified for a channel type, the last one takes precedence.
> >> > @@ -5411,6 +5415,16 @@ options are specified for a channel type, the last one takes precedence.
> >> >      Wait for the URI to be specified via migrate\_incoming. The monitor
> >> >      can be used to change settings (such as migration parameters) prior
> >> >      to issuing the migrate\_incoming to allow the migration to begin.
> >> > +
> >> > +``-incoming config:key1=value1[,key2=value2,...]``
> >> > +
> >> > +    Specify migration parameters in QEMU commandlines, so that these
> >> 
> >> command line
> >
> > Fixed.
> >
> >> 
> >> > +    parameters will be available even during very early boot of QEMU.
> >> > +    They will be applied properly after QEMU boots and when the migration
> >> 
> >> The "applied properly" part is implementation detail.
> >
> > True, I simplified it:
> >
> > ``-incoming config:key1=value1[,key2=value2,...]``
> >
> >     Specify migration parameters in QEMU command line, so that these
> >     parameters will be available even during very early boot of QEMU.  It
> >     has similar effect as setting these parameters using QMP command
> >     ``migrate-set-parameters`` or HMP command ``migrate_set_parameter``.
> >
> 
> ack.
> 
> >> 
> >> > +    core is initialized.  From that POV, it has similar effect as setting
> >> > +    these parameters using QMP command ``migrate-set-parameters`` or HMP
> >> > +    command ``migrate_set_parameter``.
> >> > +
> >> >  ERST
> >> >  
> >> >  DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
> >> 
> 

-- 
Peter Xu



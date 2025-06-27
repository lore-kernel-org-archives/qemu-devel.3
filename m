Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD2DC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVFgD-0000m2-Om; Fri, 27 Jun 2025 16:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uVFgB-0000lA-Rm
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:28:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uVFg9-0007h1-5P
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:28:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2957B1F390;
 Fri, 27 Jun 2025 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751056086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQf8nRkHxe+dCqmcHghgsowWn5iA1OwjTiCWGLyjtWU=;
 b=N8ZOx5J7eYmK9aDwYvxJbWpjidSE/hOFFhA4IwGspZKCpyWAdSlnyOT+5/JLTCohUh4tjZ
 tWVm+rt9QqF9vlOjF4hGE8EQsFj9ceKFMX0mcUbBXPWRnrSEZ6om/wae2bCETVbGCfZxBl
 cPJFMtcYuok+UhT/O8bQQmmhN1TSTnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751056086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQf8nRkHxe+dCqmcHghgsowWn5iA1OwjTiCWGLyjtWU=;
 b=2EKIvy7NnrDIbvJzRrNoSyZYFdoOuJda200AQGx6YTWr2HPcAcJitg71LWmtSZNpSFau7R
 hwI6Lw6ilQP4s5AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751056086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQf8nRkHxe+dCqmcHghgsowWn5iA1OwjTiCWGLyjtWU=;
 b=N8ZOx5J7eYmK9aDwYvxJbWpjidSE/hOFFhA4IwGspZKCpyWAdSlnyOT+5/JLTCohUh4tjZ
 tWVm+rt9QqF9vlOjF4hGE8EQsFj9ceKFMX0mcUbBXPWRnrSEZ6om/wae2bCETVbGCfZxBl
 cPJFMtcYuok+UhT/O8bQQmmhN1TSTnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751056086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQf8nRkHxe+dCqmcHghgsowWn5iA1OwjTiCWGLyjtWU=;
 b=2EKIvy7NnrDIbvJzRrNoSyZYFdoOuJda200AQGx6YTWr2HPcAcJitg71LWmtSZNpSFau7R
 hwI6Lw6ilQP4s5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9453613786;
 Fri, 27 Jun 2025 20:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qDukFdX+XmjsMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Jun 2025 20:28:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
In-Reply-To: <877c0xpsli.fsf@pond.sub.org>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de> <87cyas88gg.fsf@pond.sub.org>
 <878qlf7nc0.fsf@suse.de> <87o6uayh9r.fsf@pond.sub.org>
 <87zfdu5zf4.fsf@suse.de> <877c0xpsli.fsf@pond.sub.org>
Date: Fri, 27 Jun 2025 17:28:02 -0300
Message-ID: <87tt4153ql.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Fabiano Rosas <farosas@suse.de> writes:
>>>
>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>
>>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>>
>>>>>> The migration parameters tls_creds, tls_authz and tls_hostname
>>>>>> currently have a non-uniform handling. When used as arguments to
>>>>>> migrate-set-parameters, their type is StrOrNull and when used as
>>>>>> return value from query-migrate-parameters, their type is a plain
>>>>>> string.
>>>>>>
>>>>>> Not only having to convert between the types is cumbersome, but it
>>>>>> also creates the issue of requiring two different QAPI types to be
>>>>>> used, one for each command. MigrateSetParameters is used for
>>>>>> migrate-set-parameters with the TLS arguments as StrOrNull while
>>>>>> MigrationParameters is used for query-migrate-parameters with the TLS
>>>>>> arguments as str.
>>>>>>
>>>>>> Since StrOrNull could be considered a superset of str, change the type
>>>>>> of the TLS arguments in MigrationParameters to StrOrNull and add a
>>>>>> helper to ensure they're never actually used as QTYPE_QNULL.
>>>>>
>>>>> The type of @tls_creds, @tls-hostname, @tls-authz changes from str to
>>>>> StrOrNull in introspection query-migrate-parameters.  Loss of precision.
>>>>> Introspection is already imprecise: it shows the members optional even
>>>>> though they aren't.  We accept the loss of precision to enable
>>>>> de-duplication.
>>>>>
>>>>> This should be worked into the commit message.
>>>>>
>>>>
>>>> Ack.
>>>>
>>>>>> This will allow the type duplication to be removed in the next
>>>>>> patches.
>>>>>>
>>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>>> ---
>>>>>>  migration/migration-hmp-cmds.c |   8 +-
>>>>>>  migration/migration.c          |   2 +
>>>>>>  migration/options.c            | 149 ++++++++++++++++++++-------------
>>>>>>  migration/options.h            |   1 +
>>>>>>  migration/tls.c                |   2 +-
>>>>>>  qapi/migration.json            |   6 +-
>>>>>>  6 files changed, 99 insertions(+), 69 deletions(-)
>>>>>>
>>>>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>>>> index e8a563c7d8..bc8179c582 100644
>>>>>> --- a/migration/migration-hmp-cmds.c
>>>>>> +++ b/migration/migration-hmp-cmds.c
>>>>>> @@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>>>          monitor_printf(mon, "%s: %u\n",
>>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>>>>>>              params->max_cpu_throttle);
>>>>>> -        assert(params->tls_creds);
>>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>>>>>> -            params->tls_creds);
>>>>>> -        assert(params->tls_hostname);
>>>>>> +                       params->tls_creds ? params->tls_creds->u.s : "");
>>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>>>>>> -            params->tls_hostname);
>>>>>> +                       params->tls_hostname ? params->tls_hostname->u.s : "");
>>>>>>          assert(params->has_max_bandwidth);
>>>>>>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>>>>>> @@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>>>              params->max_postcopy_bandwidth);
>>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>>>>> -            params->tls_authz);
>>>>>> +                       params->tls_authz ? params->tls_authz->u.s : "");
>>>>>>  
>>>>>>          if (params->has_block_bitmap_mapping) {
>>>>>>              const BitmapMigrationNodeAliasList *bmnal;
>>>>>
>>>>> Before, the code assumes ->tls_creds, ->tls_hostname, and ->tls_authz
>>>>> are non-null.  It assert its assumption for the first two.
>>>>>
>>>>> Afterwards, it maps null to "".  Why is that necessary?  Hmm, see below.
>>>>>
>>>>
>>>> Maps NULL to "" because the intermediate type, MigrationParameters, has
>>>> been changed from str to StrOrNull. For the purposes of info
>>>> migrate_parameters and query-migrate-parameters the only valid values
>>>> are a non-empty string or an empty string.
>>>
>>> But is NULL possible?  If you just change the type from str to StrOrNull
>>> and no more, it isn't.
>>>
>>
>> Since the TLS options don't have a qdev property anymore, they also
>> don't get set a default value. So s->parameters can indeed have the NULL
>> value in it.
>>
>> I could initialize them in migrate_params_init. It's all about choosing
>> where to move the complexity.
>
> True!
>
>>                               I'm leaning towards keeping it in the
>> interface: query-migrate converts them to whatever it needs to output
>> and set-migrate writes a normalized version into s->parameters.
>
> There more than one way to skin this cat.  I like to keep state
> normalized.
>
> State is an optional StrOrNull.  Possible values:
>
> * NULL
>
> * QNull, i.e. non-NULL, ->type is QTYPE_QNULL
>
> * Empty string, i.e. non-NULL, ->type is QTYPE_QSTRING, ->u.s is ""
>
> * Non-empty string, i.e. non-NULL, -> type is QTYPE_QSTRING, ->u.s is
>   not "" (and cannot be NULL)
>
> As far as I understand, we have just two cases semantically:
>
> * Set, value is a non-empty string (empty makes no sense)
>
> * Unset
>
> I'd normalize the state to "either NULL, or (non-empty) string".
>

This is what I wanted to do (in the next version), but it results in
more complex and less readable code:

A) "abc"|NULL

hmp_info_migrate_parameters:
    monitor_printf(..., params->tls_creds ? params->tls_creds->u.s : "");

migrate_tls_creds:
    if (s->parameters.tls_creds) {
        return s->parameters.tls_creds->u.s;
    }
    return NULL;

migrate_params_check:
    if (migrate_zero_copy_send() && params->tls_creds ...

qmp_migrate_set_parameters:
    migrate_params_test_apply(params);
    if (migrate_params_check(tmp)) {
        migrate_params_apply(params);
        tls_normalize_qnull_empty_str_to_null(&s->parameters);  <-- [1]
    }

qmp_query_migrate_parameters:
    params = QAPI_CLONE(MigrationParameters, &s->parameters);
    tls_normalize_null_back_to_empty_str();   <-- [2]

Issues here are that in [1] we can't normalize earlier because we need
QTYPE_QNULL to know whether the option was ever set and in [2], since
s->parameters may contain NULL, we need another conversion step to be
able to return "". Overall, this makes the normalization step not very
useful because we need to keep track of which parts of the code are
normalized or not.

If we instead normalize to "either non-empty string or empty string"
then:

B) "abc"|""

hmp_info_migrate_parameters:
    monitor_printf(..., params->tls_creds);

migrate_tls_creds:
    if (*s->parameters.tls_creds->u.s) {
        return s->parameters.tls_creds->u.s;
    }
    return NULL;   <-- [1]

migrate_params_check:
    if (migrate_zero_copy_send() && *params->tls_creds->u.s ...

qmp_migrate_set_parameters:
    tls_normalize_qnull_null_to_str(&s->parameters);  <-- [2]
    migrate_params_test_apply(params);
    if (migrate_params_check(tmp)) {
        migrate_params_apply(params);
    }

qmp_query_migrate_parameters:
    params = QAPI_CLONE(MigrationParameters, &s->parameters);

The query methods get simpler because s->parameters already contains
data in the format they expect, we can normalize earlier in [2], which
means data is always in the same format throughout
qmp_migrate_set_parameters() and lastly, we already have the getter
methods [1] which can expose "abc"|NULL to the rest of the code anyway.

> When writing state, we need to normalize.
>
> When reading state, we can rely on it being normalized.  Asserting it is
> seems prudent, and should help readers.
>

My main concern is that reading can rely on it being normalized, but the
query methods cannot, so they need to do an "extra conversion", which
from the reader's POV, will look nonsensical. It's not as simple as
using a ternary because the StrOrNull object needs to be allocated.

> [...]
>
>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>> index 162c72cda4..45a95dc6da 100644
>>>>>> --- a/migration/options.c
>>>>>> +++ b/migration/options.c
>>>>>> @@ -162,9 +162,11 @@ const Property migration_properties[] = {
>>>>>>      DEFINE_PROP_SIZE("announce-step", MigrationState,
>>>>>>                        parameters.announce_step,
>>>>>>                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>>>>>> -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>>>>>> -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>>>>>> -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
>>>>>> +    /*
>>>>>> +     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
>>>>>> +     * which can't be easily handled (if at all) by qdev. So these
>>>>>> +     * will not be exposed as global migration options (-global).
>>>>>> +     */
>>>>>
>>>>> This is a compatibility break.

Coming back to this, I implemented a DEFINE_PROP_STR_OR_NULL. It's way
better than removing the options, because this allows a default to be
set, which means query-migrate-parameters() doesn't need to deal with an
initial NULL value anymore (if query is called before set).

>>>>>
>>>>> The orthodox way to break it is deprecate, let the grace period expire,
>>>>> break.  Record in docs/about/deprecated.rst at the beginning, move the
>>>>> record to docs/about/removed-features.rst at the end.
>>>>>
>>>>> An argument could be made that the interface in question is
>>>>> accidental[*], not actually used by anything, and therefore breaking it
>>>>> without a grace period is fine.  But even then we should record the
>>>>> breakage in docs/about/removed-features.rst.
>>>>>
>>>>
>>>> Ok. Alternatively I could try a little harder to keep these
>>>> options. I'll see what I can do.
>>>
>>> What do we think about this external interface?
>>>
>>> If we think it's accidental and unused, then putting in more work to
>>> keep it makes no sense.
>>>
>>> If we think it's deliberate and/or used, we should either keep it, or
>>> replace it the orthodox way.
>>>
>>
>> There are two external interfaces actually.
>>
>> -global migration.some_compat_option=on (stored in MigrationState):
>>
>> seems intentional and I believe we'd lose the ability to get out of some
>> tricky situations if we ditched it.
>>
>> -global migation.some_random_option=on (stored in MigrationParameters):
>>
>> has become a debugging *feature*, which I personally don't use, but
>> others do. And worse: we don't know if anyone uses it in production.
>
> Accidental external interface.
>
>> We also arbitrarily put x- in front of options for some reason. There is
>> an argument to drop those because x- is scary and no one should be using
>> them.
>
> We pretty much ditched the x- convention in the QAPI schema.
> docs/devel/qapi-code-gen.rst:
>
>     Names beginning with ``x-`` used to signify "experimental".  This
>     convention has been replaced by special feature "unstable".
>
> Goes back to
>
> commit a3c45b3e62962f99338716b1347cfb0d427cea44
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Thu Oct 28 12:25:12 2021 +0200
>
>     qapi: New special feature flag "unstable"
>     
>     By convention, names starting with "x-" are experimental.  The parts
>     of external interfaces so named may be withdrawn or changed
>     incompatibly in future releases.

This allows dropping about half of the parameters we expose. Deprecate
the other half, move the remaining legitimate compat options into
MigrationParameters, (which can be set by migrate-set-parameters) and
maybe we can remove the TYPE_DEVICE from MigrationState anytime this
decade.

Moving all qdev properties to their own TYPE_DEVICE object and putting
it under --enable-debug is also an idea.

I'm willing to do the work if we ever reach a consensus about this.

>     
>     The naming convention makes unstable interfaces easy to recognize.
>     Promoting something from experimental to stable involves a name
>     change.  Client code needs to be updated.  Occasionally bothersome.
>     
>     Worse, the convention is not universally observed:
>     
>     * QOM type "input-barrier" has properties "x-origin", "y-origin".
>       Looks accidental, but it's ABI since 4.2.
>     
>     * QOM types "memory-backend-file", "memory-backend-memfd",
>       "memory-backend-ram", and "memory-backend-epc" have a property
>       "x-use-canonical-path-for-ramblock-id" that is documented to be
>       stable despite its name.
>     
>     We could document these exceptions, but documentation helps only
>     humans.  We want to recognize "unstable" in code, like "deprecated".
>     
>     So support recognizing it the same way: introduce new special feature
>     flag "unstable".  It will be treated specially by the QAPI generator,
>     like the existing feature flag "deprecated", and unlike regular
>     feature flags.
>     
>     This commit updates documentation and prepares tests.  The next commit
>     updates the QAPI schema.  The remaining patches update the QAPI
>     generator and wire up -compat policy checking.
>     
>     Management applications can then use query-qmp-schema and -compat to
>     manage or guard against use of unstable interfaces the same way as for
>     deprecated interfaces.
>     
>     docs/devel/qapi-code-gen.txt no longer mandates the naming convention.
>     Using it anyway might help writers of programs that aren't
>     full-fledged management applications.  Not using it can save us
>     bothersome renames.  We'll see how that shakes out.
>     
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Reviewed-by: Juan Quintela <quintela@redhat.com>
>     Reviewed-by: John Snow <jsnow@redhat.com>
>     Message-Id: <20211028102520.747396-2-armbru@redhat.com>
>
> The x- convention lives on in external interfaces that bypass QAPI, in
> particular QOM/qdev properties.
>
>> I think it would be good to at least separate the responsibilities so
>> when the time comes we can deprecate/remove/replace the offending
>> interfaces. But I won't go into that now, there's already too much
>> change going on for this release.
>
> Makes sense.


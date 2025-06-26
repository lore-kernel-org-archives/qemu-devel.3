Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179D3C7EE33
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 09:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUj45-0004yQ-MG; Thu, 26 Jun 2025 05:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUj41-0004vV-3b
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUj3x-00077H-SN
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750930711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ovtkkJXqIZp6CZvQOJLpUdp8uPSb7RPjCj664+4ds50=;
 b=ORdcMYvAUUuFUzLjp4jNWBFYk/C+3APK3tZRG4FVdwdL8ijG8lp8vzrdKu5/QFU07wP8+2
 B2AdayDCbKQLtrhan9xT348Ni5l/ZzbbK2UKoPiXzZIcoaBF1NQJ5WCdB5fkC3RrCHF3TN
 jtbKN6n8sUlH1eP/4kViJ8YaAoozMD0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-SdpXTDnmNASeRBGylGFnJA-1; Thu,
 26 Jun 2025 05:38:29 -0400
X-MC-Unique: SdpXTDnmNASeRBGylGFnJA-1
X-Mimecast-MFC-AGG-ID: SdpXTDnmNASeRBGylGFnJA_1750930708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35C421955ECC; Thu, 26 Jun 2025 09:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91CA919560AF; Thu, 26 Jun 2025 09:38:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C3B8B21E6A27; Thu, 26 Jun 2025 11:38:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
In-Reply-To: <878qlf7nc0.fsf@suse.de> (Fabiano Rosas's message of "Wed, 25 Jun
 2025 14:17:19 -0300")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de> <87cyas88gg.fsf@pond.sub.org>
 <878qlf7nc0.fsf@suse.de>
Date: Thu, 26 Jun 2025 11:38:24 +0200
Message-ID: <87o6uayh9r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> The migration parameters tls_creds, tls_authz and tls_hostname
>>> currently have a non-uniform handling. When used as arguments to
>>> migrate-set-parameters, their type is StrOrNull and when used as
>>> return value from query-migrate-parameters, their type is a plain
>>> string.
>>>
>>> Not only having to convert between the types is cumbersome, but it
>>> also creates the issue of requiring two different QAPI types to be
>>> used, one for each command. MigrateSetParameters is used for
>>> migrate-set-parameters with the TLS arguments as StrOrNull while
>>> MigrationParameters is used for query-migrate-parameters with the TLS
>>> arguments as str.
>>>
>>> Since StrOrNull could be considered a superset of str, change the type
>>> of the TLS arguments in MigrationParameters to StrOrNull and add a
>>> helper to ensure they're never actually used as QTYPE_QNULL.
>>
>> The type of @tls_creds, @tls-hostname, @tls-authz changes from str to
>> StrOrNull in introspection query-migrate-parameters.  Loss of precision.
>> Introspection is already imprecise: it shows the members optional even
>> though they aren't.  We accept the loss of precision to enable
>> de-duplication.
>>
>> This should be worked into the commit message.
>>
>
> Ack.
>
>>> This will allow the type duplication to be removed in the next
>>> patches.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  migration/migration-hmp-cmds.c |   8 +-
>>>  migration/migration.c          |   2 +
>>>  migration/options.c            | 149 ++++++++++++++++++++-------------
>>>  migration/options.h            |   1 +
>>>  migration/tls.c                |   2 +-
>>>  qapi/migration.json            |   6 +-
>>>  6 files changed, 99 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index e8a563c7d8..bc8179c582 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>          monitor_printf(mon, "%s: %u\n",
>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>>>              params->max_cpu_throttle);
>>> -        assert(params->tls_creds);
>>>          monitor_printf(mon, "%s: '%s'\n",
>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>>> -            params->tls_creds);
>>> -        assert(params->tls_hostname);
>>> +                       params->tls_creds ? params->tls_creds->u.s : "");
>>>          monitor_printf(mon, "%s: '%s'\n",
>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>>> -            params->tls_hostname);
>>> +                       params->tls_hostname ? params->tls_hostname->u.s : "");
>>>          assert(params->has_max_bandwidth);
>>>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>>> @@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>              params->max_postcopy_bandwidth);
>>>          monitor_printf(mon, "%s: '%s'\n",
>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>> -            params->tls_authz);
>>> +                       params->tls_authz ? params->tls_authz->u.s : "");
>>>  
>>>          if (params->has_block_bitmap_mapping) {
>>>              const BitmapMigrationNodeAliasList *bmnal;
>>
>> Before, the code assumes ->tls_creds, ->tls_hostname, and ->tls_authz
>> are non-null.  It assert its assumption for the first two.
>>
>> Afterwards, it maps null to "".  Why is that necessary?  Hmm, see below.
>>
>
> Maps NULL to "" because the intermediate type, MigrationParameters, has
> been changed from str to StrOrNull. For the purposes of info
> migrate_parameters and query-migrate-parameters the only valid values
> are a non-empty string or an empty string.

But is NULL possible?  If you just change the type from str to StrOrNull
and no more, it isn't.

>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 4697732bef..f65cb81b6d 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -4053,6 +4053,8 @@ static void migration_instance_finalize(Object *obj)
>>>  {
>>>      MigrationState *ms = MIGRATION_OBJ(obj);
>>>  
>>> +    migrate_tls_opts_free(&ms->parameters);
>>
>> Is this a bug fix?
>>
>
> My new version is a little different, but I can make it a separate patch
> if that happens to be the case.

Yes, please.

>> As far as I can tell, the object gets destroyed only on QEMU shutdown.
>> Freeing resources then is unnecessary, except it may help leak detection
>> tools.
>>
>
> From a maintenance perspective I consider any leak as a bug because I
> don't have control over what kinds of leak detection tools are ran on
> the code. To avoid spending time looking at such bug reports I have ASAN
> automated in my testing and I fix early any leaks that it founds.
>
>>> +
>>>      qemu_mutex_destroy(&ms->error_mutex);
>>>      qemu_mutex_destroy(&ms->qemu_file_lock);
>>>      qemu_sem_destroy(&ms->wait_unplug_sem);
>>> diff --git a/migration/options.c b/migration/options.c
>>> index 162c72cda4..45a95dc6da 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -162,9 +162,11 @@ const Property migration_properties[] = {
>>>      DEFINE_PROP_SIZE("announce-step", MigrationState,
>>>                        parameters.announce_step,
>>>                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>>> -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>>> -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>>> -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
>>> +    /*
>>> +     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
>>> +     * which can't be easily handled (if at all) by qdev. So these
>>> +     * will not be exposed as global migration options (-global).
>>> +     */
>>
>> This is a compatibility break.
>>
>> The orthodox way to break it is deprecate, let the grace period expire,
>> break.  Record in docs/about/deprecated.rst at the beginning, move the
>> record to docs/about/removed-features.rst at the end.
>>
>> An argument could be made that the interface in question is
>> accidental[*], not actually used by anything, and therefore breaking it
>> without a grace period is fine.  But even then we should record the
>> breakage in docs/about/removed-features.rst.
>>
>
> Ok. Alternatively I could try a little harder to keep these
> options. I'll see what I can do.

What do we think about this external interface?

If we think it's accidental and unused, then putting in more work to
keep it makes no sense.

If we think it's deliberate and/or used, we should either keep it, or
replace it the orthodox way.

Trouble is a common answer for use of accidental interfaces is "beats
me".  I wish we'd stop creating them.

>> Aside: the interface in question is a hack (making the migration object
>> a device) piled onto a hack (the way compat properties work, and how
>> they spill into -global).  Past sins catching up with us...
>>
>
> Hm, I've been experimenting with adding new objects (still TYPE_DEVICE)
> to hold the compatibility options and parameters only. Not the entire
> migration state. The MigrationState object would then be converted into
> a regular struct.
>
> MigrationState => internal type holding migration state (a better name
> could be used)
> MigrationOptionsState => -global migration-options.foo=on
> MigrationCompatState => -global migration foo=on
>
> But it's getting a little tricky due to s->parameters *also* containing
> compat options, namely zero-page-detection.

-global is a trap.  Heck, global configuration state is a trap.  See
discussion in review of RFC v3.

We can't always fill in the our spiked pits.  Sometimes the best we can
do is to plank them and put up some "here be danger" signs.

>>>      DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
>>>                         parameters.x_vcpu_dirty_limit_period,
>>>                         DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
>>> @@ -379,13 +381,6 @@ bool migrate_rdma(void)
>>>      return s->rdma_migration;
>>>  }
>>>  
>>> -bool migrate_tls(void)
>>> -{
>>> -    MigrationState *s = migrate_get_current();
>>> -
>>> -    return s->parameters.tls_creds && *s->parameters.tls_creds;
>>> -}
>>> -
>>>  typedef enum WriteTrackingSupport {
>>>      WT_SUPPORT_UNKNOWN = 0,
>>>      WT_SUPPORT_ABSENT,
>>> @@ -834,21 +829,44 @@ const char *migrate_tls_authz(void)
>>>  {
>>>      MigrationState *s = migrate_get_current();
>>>  
>>> -    return s->parameters.tls_authz;
>>> +    if (s->parameters.tls_authz &&
>>> +        s->parameters.tls_authz->type == QTYPE_QSTRING &&
>>> +        *s->parameters.tls_authz->u.s) {
>>> +        return s->parameters.tls_authz->u.s;
>>> +    }
>>> +
>>> +    return NULL;
>>>  }
>>>  
>>>  const char *migrate_tls_creds(void)
>>>  {
>>>      MigrationState *s = migrate_get_current();
>>>  
>>> -    return s->parameters.tls_creds;
>>> +    if (s->parameters.tls_creds &&
>>> +        s->parameters.tls_creds->type == QTYPE_QSTRING &&
>>> +        *s->parameters.tls_creds->u.s) {
>>> +        return s->parameters.tls_creds->u.s;
>>> +    }
>>> +
>>> +    return NULL;
>>>  }
>>>  
>>>  const char *migrate_tls_hostname(void)
>>>  {
>>>      MigrationState *s = migrate_get_current();
>>>  
>>> -    return s->parameters.tls_hostname;
>>> +    if (s->parameters.tls_hostname &&
>>> +        s->parameters.tls_hostname->type == QTYPE_QSTRING &&
>>> +        *s->parameters.tls_hostname->u.s) {
>>> +        return s->parameters.tls_hostname->u.s;
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>
>> Again, the code changes to cope with null.  Why is that necessary?
>> Again, see below.
>>
>
> This is actually a bit roundabout indeed. In my new version I do:
>
> - migrate-set-parameters: always write either NULL or a non-empty
>   QTYPE_QSTRING to s->parameters.
>     
> - query-migrate-parameters: always return a (possibly empty)
>   QTYPE_QSTRING.
>
> With this, internal representation is: NULL for not present, non-empty
> string for present.
>
>>> +
>>> +bool migrate_tls(void)
>>> +{
>>> +    return !!migrate_tls_creds();
>>>  }
>>>  
>>>  uint64_t migrate_vcpu_dirty_limit_period(void)
>>> @@ -888,6 +906,36 @@ AnnounceParameters *migrate_announce_params(void)
>>>      return &ap;
>>>  }
>>>  
>>> +void migrate_tls_opts_free(MigrationParameters *params)
>>> +{
>>> +    qapi_free_StrOrNull(params->tls_creds);
>>> +    qapi_free_StrOrNull(params->tls_hostname);
>>> +    qapi_free_StrOrNull(params->tls_authz);
>>> +}
>>> +
>>> +/* needs BQL if dst is part of s->parameters */
>>> +static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
>>> +{
>>> +    StrOrNull *dst = *dstp;
>>> +
>>> +    assert(!dst);
>>> +
>>> +    dst = *dstp = g_new0(StrOrNull, 1);
>>> +    dst->type = QTYPE_QSTRING;
>>> +
>>> +    if (!src) {
>>> +        dst->u.s = g_strdup("");
>>> +        return;
>>> +    }
>>> +
>>> +    if (src->type == QTYPE_QSTRING) {
>>> +        dst->u.s = g_strdup(src->u.s);
>>> +    } else {
>>> +        assert(src->type == QTYPE_QNULL);
>>> +        dst->u.s = g_strdup("");
>>> +    }
>>> +}
>>
>> Postcondition: dstp points to a StrOrNull containing a str,
>> i.e. QTYPE_QSTRING.  Makes sense.
>>
>> I'd prefer something like
>>
>>        StrOrNull *dst = g_new0(StrOrNull, 1);
>>
>>        ... fill in members ...
>>
>>        assert(!*dstp);
>>        *dstp = dst;
>>
>
> This code is also reworked a bit on the next version, I'll see whether
> the comment still applies.
>
>>> +
>>>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>>  {
>>>      MigrationParameters *params;
>>> @@ -903,10 +951,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>>      params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
>>>      params->has_cpu_throttle_tailslow = true;
>>>      params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
>>> -    params->tls_creds = g_strdup(s->parameters.tls_creds);
>>> -    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
>>> -    params->tls_authz = g_strdup(s->parameters.tls_authz ?
>>> -                                 s->parameters.tls_authz : "");
>>> +
>>> +    tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
>>> +    tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
>>> +    tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
>>> +
>>>      params->has_max_bandwidth = true;
>>>      params->max_bandwidth = s->parameters.max_bandwidth;
>>>      params->has_avail_switchover_bandwidth = true;
>>> @@ -963,9 +1012,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>>  
>>>  void migrate_params_init(MigrationParameters *params)
>>>  {
>>> -    params->tls_hostname = g_strdup("");
>>> -    params->tls_creds = g_strdup("");
>>> -
>>
>> Is this the reason why the code now needs to deal with null?
>>
>> I'm not objecting, just pointing out that the commit message didn't
>> prepare me for such a change.
>>
>
> I'll document it.
>
>>>      /* Set has_* up only for parameter checks */
>>>      params->has_throttle_trigger_threshold = true;
>>>      params->has_cpu_throttle_initial = true;
>>
>> I'm stopping here to ask: how exactly does the patch change quasi-global
>> state, namely current_migration->parameters->tls_*?
>>
>
> It makes sure the current_migration->parameters->tls_* options are
> always QTYPE_QSTRING and either a non-empty or an empty string.
>
> The next version of the patch will instead use non-empty QTYPE_QSTRING
> or NULL, which is cleaner from a C perspective.

Agree.

The struct members will have type StrOrNull, but only certain values can
occur: non-empty string, and NULL.  Worth a comment, I think.  Also
consider assertions.

> Both versions ensure the query-* and set-* commands continue to expose
> the same values. Query only shows non-empty or empty string and Set
> accepts all values of a StrOrNull type.
>
>> [...]
>>
>>
>> [*] We have oh so many accidental external interfaces.



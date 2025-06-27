Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B5FC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 07:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV3Et-0003ip-S4; Fri, 27 Jun 2025 03:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV3Er-0003if-VQ
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 03:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uV3El-0000cJ-GT
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 03:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751008256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkQ1xFzU+AAnrhYp46iuIqC9iGvf/z+vIoqwOXU5BeQ=;
 b=DUpDkAAIJhK3dvEJf9oaPGXbczLLUcsd+Muyt5oArCq7LoT8G/fdLhvs7mU84Y9nKFbyyd
 OBJG5CX+EXcgVyZbMK7ahVTk6/H2vRvA/FGVJ/HRpHjclJq50flqiViLMagC2zT2Sr9gC1
 VZEWAvjkYEhimLZlqsZ0n5Rj70DxoWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-YjHKL9XnMDGVV6UFLxnUfQ-1; Fri,
 27 Jun 2025 03:10:53 -0400
X-MC-Unique: YjHKL9XnMDGVV6UFLxnUfQ-1
X-Mimecast-MFC-AGG-ID: YjHKL9XnMDGVV6UFLxnUfQ_1751008252
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76840180028A; Fri, 27 Jun 2025 07:10:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3E26194128F; Fri, 27 Jun 2025 07:10:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CA1321E6A27; Fri, 27 Jun 2025 09:10:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
In-Reply-To: <87zfdu5zf4.fsf@suse.de> (Fabiano Rosas's message of "Thu, 26 Jun
 2025 11:51:27 -0300")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de> <87cyas88gg.fsf@pond.sub.org>
 <878qlf7nc0.fsf@suse.de> <87o6uayh9r.fsf@pond.sub.org>
 <87zfdu5zf4.fsf@suse.de>
Date: Fri, 27 Jun 2025 09:10:49 +0200
Message-ID: <877c0xpsli.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Fabiano Rosas <farosas@suse.de> writes:
>>>>
>>>>> The migration parameters tls_creds, tls_authz and tls_hostname
>>>>> currently have a non-uniform handling. When used as arguments to
>>>>> migrate-set-parameters, their type is StrOrNull and when used as
>>>>> return value from query-migrate-parameters, their type is a plain
>>>>> string.
>>>>>
>>>>> Not only having to convert between the types is cumbersome, but it
>>>>> also creates the issue of requiring two different QAPI types to be
>>>>> used, one for each command. MigrateSetParameters is used for
>>>>> migrate-set-parameters with the TLS arguments as StrOrNull while
>>>>> MigrationParameters is used for query-migrate-parameters with the TLS
>>>>> arguments as str.
>>>>>
>>>>> Since StrOrNull could be considered a superset of str, change the type
>>>>> of the TLS arguments in MigrationParameters to StrOrNull and add a
>>>>> helper to ensure they're never actually used as QTYPE_QNULL.
>>>>
>>>> The type of @tls_creds, @tls-hostname, @tls-authz changes from str to
>>>> StrOrNull in introspection query-migrate-parameters.  Loss of precision.
>>>> Introspection is already imprecise: it shows the members optional even
>>>> though they aren't.  We accept the loss of precision to enable
>>>> de-duplication.
>>>>
>>>> This should be worked into the commit message.
>>>>
>>>
>>> Ack.
>>>
>>>>> This will allow the type duplication to be removed in the next
>>>>> patches.
>>>>>
>>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>>> ---
>>>>>  migration/migration-hmp-cmds.c |   8 +-
>>>>>  migration/migration.c          |   2 +
>>>>>  migration/options.c            | 149 ++++++++++++++++++++-------------
>>>>>  migration/options.h            |   1 +
>>>>>  migration/tls.c                |   2 +-
>>>>>  qapi/migration.json            |   6 +-
>>>>>  6 files changed, 99 insertions(+), 69 deletions(-)
>>>>>
>>>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>>> index e8a563c7d8..bc8179c582 100644
>>>>> --- a/migration/migration-hmp-cmds.c
>>>>> +++ b/migration/migration-hmp-cmds.c
>>>>> @@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>>          monitor_printf(mon, "%s: %u\n",
>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>>>>>              params->max_cpu_throttle);
>>>>> -        assert(params->tls_creds);
>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>>>>> -            params->tls_creds);
>>>>> -        assert(params->tls_hostname);
>>>>> +                       params->tls_creds ? params->tls_creds->u.s : "");
>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>>>>> -            params->tls_hostname);
>>>>> +                       params->tls_hostname ? params->tls_hostname->u.s : "");
>>>>>          assert(params->has_max_bandwidth);
>>>>>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>>>>> @@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>>              params->max_postcopy_bandwidth);
>>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>>>> -            params->tls_authz);
>>>>> +                       params->tls_authz ? params->tls_authz->u.s : "");
>>>>>  
>>>>>          if (params->has_block_bitmap_mapping) {
>>>>>              const BitmapMigrationNodeAliasList *bmnal;
>>>>
>>>> Before, the code assumes ->tls_creds, ->tls_hostname, and ->tls_authz
>>>> are non-null.  It assert its assumption for the first two.
>>>>
>>>> Afterwards, it maps null to "".  Why is that necessary?  Hmm, see below.
>>>>
>>>
>>> Maps NULL to "" because the intermediate type, MigrationParameters, has
>>> been changed from str to StrOrNull. For the purposes of info
>>> migrate_parameters and query-migrate-parameters the only valid values
>>> are a non-empty string or an empty string.
>>
>> But is NULL possible?  If you just change the type from str to StrOrNull
>> and no more, it isn't.
>>
>
> Since the TLS options don't have a qdev property anymore, they also
> don't get set a default value. So s->parameters can indeed have the NULL
> value in it.
>
> I could initialize them in migrate_params_init. It's all about choosing
> where to move the complexity.

True!

>                               I'm leaning towards keeping it in the
> interface: query-migrate converts them to whatever it needs to output
> and set-migrate writes a normalized version into s->parameters.

There more than one way to skin this cat.  I like to keep state
normalized.

State is an optional StrOrNull.  Possible values:

* NULL

* QNull, i.e. non-NULL, ->type is QTYPE_QNULL

* Empty string, i.e. non-NULL, ->type is QTYPE_QSTRING, ->u.s is ""

* Non-empty string, i.e. non-NULL, -> type is QTYPE_QSTRING, ->u.s is
  not "" (and cannot be NULL)

As far as I understand, we have just two cases semantically:

* Set, value is a non-empty string (empty makes no sense)

* Unset

I'd normalize the state to "either NULL, or (non-empty) string".

When writing state, we need to normalize.

When reading state, we can rely on it being normalized.  Asserting it is
seems prudent, and should help readers.

[...]

>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>> index 162c72cda4..45a95dc6da 100644
>>>>> --- a/migration/options.c
>>>>> +++ b/migration/options.c
>>>>> @@ -162,9 +162,11 @@ const Property migration_properties[] = {
>>>>>      DEFINE_PROP_SIZE("announce-step", MigrationState,
>>>>>                        parameters.announce_step,
>>>>>                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>>>>> -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>>>>> -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>>>>> -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
>>>>> +    /*
>>>>> +     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
>>>>> +     * which can't be easily handled (if at all) by qdev. So these
>>>>> +     * will not be exposed as global migration options (-global).
>>>>> +     */
>>>>
>>>> This is a compatibility break.
>>>>
>>>> The orthodox way to break it is deprecate, let the grace period expire,
>>>> break.  Record in docs/about/deprecated.rst at the beginning, move the
>>>> record to docs/about/removed-features.rst at the end.
>>>>
>>>> An argument could be made that the interface in question is
>>>> accidental[*], not actually used by anything, and therefore breaking it
>>>> without a grace period is fine.  But even then we should record the
>>>> breakage in docs/about/removed-features.rst.
>>>>
>>>
>>> Ok. Alternatively I could try a little harder to keep these
>>> options. I'll see what I can do.
>>
>> What do we think about this external interface?
>>
>> If we think it's accidental and unused, then putting in more work to
>> keep it makes no sense.
>>
>> If we think it's deliberate and/or used, we should either keep it, or
>> replace it the orthodox way.
>>
>
> There are two external interfaces actually.
>
> -global migration.some_compat_option=on (stored in MigrationState):
>
> seems intentional and I believe we'd lose the ability to get out of some
> tricky situations if we ditched it.
>
> -global migation.some_random_option=on (stored in MigrationParameters):
>
> has become a debugging *feature*, which I personally don't use, but
> others do. And worse: we don't know if anyone uses it in production.

Accidental external interface.

> We also arbitrarily put x- in front of options for some reason. There is
> an argument to drop those because x- is scary and no one should be using
> them.

We pretty much ditched the x- convention in the QAPI schema.
docs/devel/qapi-code-gen.rst:

    Names beginning with ``x-`` used to signify "experimental".  This
    convention has been replaced by special feature "unstable".

Goes back to

commit a3c45b3e62962f99338716b1347cfb0d427cea44
Author: Markus Armbruster <armbru@redhat.com>
Date:   Thu Oct 28 12:25:12 2021 +0200

    qapi: New special feature flag "unstable"
    
    By convention, names starting with "x-" are experimental.  The parts
    of external interfaces so named may be withdrawn or changed
    incompatibly in future releases.
    
    The naming convention makes unstable interfaces easy to recognize.
    Promoting something from experimental to stable involves a name
    change.  Client code needs to be updated.  Occasionally bothersome.
    
    Worse, the convention is not universally observed:
    
    * QOM type "input-barrier" has properties "x-origin", "y-origin".
      Looks accidental, but it's ABI since 4.2.
    
    * QOM types "memory-backend-file", "memory-backend-memfd",
      "memory-backend-ram", and "memory-backend-epc" have a property
      "x-use-canonical-path-for-ramblock-id" that is documented to be
      stable despite its name.
    
    We could document these exceptions, but documentation helps only
    humans.  We want to recognize "unstable" in code, like "deprecated".
    
    So support recognizing it the same way: introduce new special feature
    flag "unstable".  It will be treated specially by the QAPI generator,
    like the existing feature flag "deprecated", and unlike regular
    feature flags.
    
    This commit updates documentation and prepares tests.  The next commit
    updates the QAPI schema.  The remaining patches update the QAPI
    generator and wire up -compat policy checking.
    
    Management applications can then use query-qmp-schema and -compat to
    manage or guard against use of unstable interfaces the same way as for
    deprecated interfaces.
    
    docs/devel/qapi-code-gen.txt no longer mandates the naming convention.
    Using it anyway might help writers of programs that aren't
    full-fledged management applications.  Not using it can save us
    bothersome renames.  We'll see how that shakes out.
    
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Juan Quintela <quintela@redhat.com>
    Reviewed-by: John Snow <jsnow@redhat.com>
    Message-Id: <20211028102520.747396-2-armbru@redhat.com>

The x- convention lives on in external interfaces that bypass QAPI, in
particular QOM/qdev properties.

> I think it would be good to at least separate the responsibilities so
> when the time comes we can deprecate/remove/replace the offending
> interfaces. But I won't go into that now, there's already too much
> change going on for this release.

Makes sense.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8786DC7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 14:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUnwz-00021S-KT; Thu, 26 Jun 2025 10:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUnwx-00021I-2N
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 10:51:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUnwu-00087Y-G5
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 10:51:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B6B32116D;
 Thu, 26 Jun 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750949491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBI160HhSrNEejK2cx47Y0grp6tGE3tTYyrmmuTe4Qs=;
 b=N3HUUp8jP7gg2w8zfMYg1JnnLLO0QJkiLzlB/ebOiipn+DxWbUDMRBC9mKIf6YlGYIVId5
 /uS85fFaHn9/MGZ/ouBpcPK+cavydYQGvtKcTmy57pFolpM7HqxRhgrAdaDbFd1NDThEge
 8G3fpRaOMNj8gawnOysj+YE7xXRB1f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750949491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBI160HhSrNEejK2cx47Y0grp6tGE3tTYyrmmuTe4Qs=;
 b=aa4FdUMFVlEgvW3gSfRNkkT/SjlMuDkbJqahpyx8bl8tDr9fcvYnHRGRwv4xdxKKu7iAez
 Jr7Dw5VjZbAq2lBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N3HUUp8j;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aa4FdUMF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750949491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBI160HhSrNEejK2cx47Y0grp6tGE3tTYyrmmuTe4Qs=;
 b=N3HUUp8jP7gg2w8zfMYg1JnnLLO0QJkiLzlB/ebOiipn+DxWbUDMRBC9mKIf6YlGYIVId5
 /uS85fFaHn9/MGZ/ouBpcPK+cavydYQGvtKcTmy57pFolpM7HqxRhgrAdaDbFd1NDThEge
 8G3fpRaOMNj8gawnOysj+YE7xXRB1f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750949491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBI160HhSrNEejK2cx47Y0grp6tGE3tTYyrmmuTe4Qs=;
 b=aa4FdUMFVlEgvW3gSfRNkkT/SjlMuDkbJqahpyx8bl8tDr9fcvYnHRGRwv4xdxKKu7iAez
 Jr7Dw5VjZbAq2lBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A0C138A7;
 Thu, 26 Jun 2025 14:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ywBfFnJeXWhVNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Jun 2025 14:51:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 01/21] migration: Normalize tls arguments
In-Reply-To: <87o6uayh9r.fsf@pond.sub.org>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-2-farosas@suse.de> <87cyas88gg.fsf@pond.sub.org>
 <878qlf7nc0.fsf@suse.de> <87o6uayh9r.fsf@pond.sub.org>
Date: Thu, 26 Jun 2025 11:51:27 -0300
Message-ID: <87zfdu5zf4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B6B32116D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Fabiano Rosas <farosas@suse.de> writes:
>>>
>>>> The migration parameters tls_creds, tls_authz and tls_hostname
>>>> currently have a non-uniform handling. When used as arguments to
>>>> migrate-set-parameters, their type is StrOrNull and when used as
>>>> return value from query-migrate-parameters, their type is a plain
>>>> string.
>>>>
>>>> Not only having to convert between the types is cumbersome, but it
>>>> also creates the issue of requiring two different QAPI types to be
>>>> used, one for each command. MigrateSetParameters is used for
>>>> migrate-set-parameters with the TLS arguments as StrOrNull while
>>>> MigrationParameters is used for query-migrate-parameters with the TLS
>>>> arguments as str.
>>>>
>>>> Since StrOrNull could be considered a superset of str, change the type
>>>> of the TLS arguments in MigrationParameters to StrOrNull and add a
>>>> helper to ensure they're never actually used as QTYPE_QNULL.
>>>
>>> The type of @tls_creds, @tls-hostname, @tls-authz changes from str to
>>> StrOrNull in introspection query-migrate-parameters.  Loss of precision.
>>> Introspection is already imprecise: it shows the members optional even
>>> though they aren't.  We accept the loss of precision to enable
>>> de-duplication.
>>>
>>> This should be worked into the commit message.
>>>
>>
>> Ack.
>>
>>>> This will allow the type duplication to be removed in the next
>>>> patches.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>>  migration/migration-hmp-cmds.c |   8 +-
>>>>  migration/migration.c          |   2 +
>>>>  migration/options.c            | 149 ++++++++++++++++++++-------------
>>>>  migration/options.h            |   1 +
>>>>  migration/tls.c                |   2 +-
>>>>  qapi/migration.json            |   6 +-
>>>>  6 files changed, 99 insertions(+), 69 deletions(-)
>>>>
>>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>> index e8a563c7d8..bc8179c582 100644
>>>> --- a/migration/migration-hmp-cmds.c
>>>> +++ b/migration/migration-hmp-cmds.c
>>>> @@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>          monitor_printf(mon, "%s: %u\n",
>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>>>>              params->max_cpu_throttle);
>>>> -        assert(params->tls_creds);
>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>>>> -            params->tls_creds);
>>>> -        assert(params->tls_hostname);
>>>> +                       params->tls_creds ? params->tls_creds->u.s : "");
>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>>>> -            params->tls_hostname);
>>>> +                       params->tls_hostname ? params->tls_hostname->u.s : "");
>>>>          assert(params->has_max_bandwidth);
>>>>          monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
>>>>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>>>> @@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>              params->max_postcopy_bandwidth);
>>>>          monitor_printf(mon, "%s: '%s'\n",
>>>>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>>> -            params->tls_authz);
>>>> +                       params->tls_authz ? params->tls_authz->u.s : "");
>>>>  
>>>>          if (params->has_block_bitmap_mapping) {
>>>>              const BitmapMigrationNodeAliasList *bmnal;
>>>
>>> Before, the code assumes ->tls_creds, ->tls_hostname, and ->tls_authz
>>> are non-null.  It assert its assumption for the first two.
>>>
>>> Afterwards, it maps null to "".  Why is that necessary?  Hmm, see below.
>>>
>>
>> Maps NULL to "" because the intermediate type, MigrationParameters, has
>> been changed from str to StrOrNull. For the purposes of info
>> migrate_parameters and query-migrate-parameters the only valid values
>> are a non-empty string or an empty string.
>
> But is NULL possible?  If you just change the type from str to StrOrNull
> and no more, it isn't.
>

Since the TLS options don't have a qdev property anymore, they also
don't get set a default value. So s->parameters can indeed have the NULL
value in it.

I could initialize them in migrate_params_init. It's all about choosing
where to move the complexity. I'm leaning towards keeping it in the
interface: query-migrate converts them to whatever it needs to output
and set-migrate writes a normalized version into s->parameters.

>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 4697732bef..f65cb81b6d 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -4053,6 +4053,8 @@ static void migration_instance_finalize(Object *obj)
>>>>  {
>>>>      MigrationState *ms = MIGRATION_OBJ(obj);
>>>>  
>>>> +    migrate_tls_opts_free(&ms->parameters);
>>>
>>> Is this a bug fix?
>>>
>>
>> My new version is a little different, but I can make it a separate patch
>> if that happens to be the case.
>
> Yes, please.
>
>>> As far as I can tell, the object gets destroyed only on QEMU shutdown.
>>> Freeing resources then is unnecessary, except it may help leak detection
>>> tools.
>>>
>>
>> From a maintenance perspective I consider any leak as a bug because I
>> don't have control over what kinds of leak detection tools are ran on
>> the code. To avoid spending time looking at such bug reports I have ASAN
>> automated in my testing and I fix early any leaks that it founds.
>>
>>>> +
>>>>      qemu_mutex_destroy(&ms->error_mutex);
>>>>      qemu_mutex_destroy(&ms->qemu_file_lock);
>>>>      qemu_sem_destroy(&ms->wait_unplug_sem);
>>>> diff --git a/migration/options.c b/migration/options.c
>>>> index 162c72cda4..45a95dc6da 100644
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -162,9 +162,11 @@ const Property migration_properties[] = {
>>>>      DEFINE_PROP_SIZE("announce-step", MigrationState,
>>>>                        parameters.announce_step,
>>>>                        DEFAULT_MIGRATE_ANNOUNCE_STEP),
>>>> -    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
>>>> -    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
>>>> -    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
>>>> +    /*
>>>> +     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
>>>> +     * which can't be easily handled (if at all) by qdev. So these
>>>> +     * will not be exposed as global migration options (-global).
>>>> +     */
>>>
>>> This is a compatibility break.
>>>
>>> The orthodox way to break it is deprecate, let the grace period expire,
>>> break.  Record in docs/about/deprecated.rst at the beginning, move the
>>> record to docs/about/removed-features.rst at the end.
>>>
>>> An argument could be made that the interface in question is
>>> accidental[*], not actually used by anything, and therefore breaking it
>>> without a grace period is fine.  But even then we should record the
>>> breakage in docs/about/removed-features.rst.
>>>
>>
>> Ok. Alternatively I could try a little harder to keep these
>> options. I'll see what I can do.
>
> What do we think about this external interface?
>
> If we think it's accidental and unused, then putting in more work to
> keep it makes no sense.
>
> If we think it's deliberate and/or used, we should either keep it, or
> replace it the orthodox way.
>

There are two external interfaces actually.

-global migration.some_compat_option=on (stored in MigrationState):

seems intentional and I believe we'd lose the ability to get out of some
tricky situations if we ditched it.

-global migation.some_random_option=on (stored in MigrationParameters):

has become a debugging *feature*, which I personally don't use, but
others do. And worse: we don't know if anyone uses it in production.

We also arbitrarily put x- in front of options for some reason. There is
an argument to drop those because x- is scary and no one should be using
them.

I think it would be good to at least separate the responsibilities so
when the time comes we can deprecate/remove/replace the offending
interfaces. But I won't go into that now, there's already too much
change going on for this release.



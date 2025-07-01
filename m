Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594F3C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbql-0003S3-UW; Tue, 01 Jul 2025 10:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWbqZ-0003NQ-6x
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:20:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWbqV-00018U-K3
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:20:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD19B21162;
 Tue,  1 Jul 2025 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751379623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goWdJuS3DzQyjPND8No4w9Goa0Xs/b5flGeXidYb/2Q=;
 b=T9wiU1JoOA/Gn768dy+9KUloa+uESZuiSJ/8//ArFPk/JI/WIDW3h3EnqRth0/YKdNPkpp
 oB7s2grXxu1Fng3XVaKXqJefIajRECgPEu2usoVnXKVFVbcax7bE5UroCoI5WQqh/LZAy9
 Bu/LQcxbzJlDVEo6V5bgJ0iIayIm5Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751379623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goWdJuS3DzQyjPND8No4w9Goa0Xs/b5flGeXidYb/2Q=;
 b=WcMKb9BcgCOuLx2C/rNp57C5pUGMTtaWLBmxqEu61DqNRqRE7t5r3TSFqQF1C96ySiShdv
 QqPx23YvhyJaVeCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751379623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goWdJuS3DzQyjPND8No4w9Goa0Xs/b5flGeXidYb/2Q=;
 b=T9wiU1JoOA/Gn768dy+9KUloa+uESZuiSJ/8//ArFPk/JI/WIDW3h3EnqRth0/YKdNPkpp
 oB7s2grXxu1Fng3XVaKXqJefIajRECgPEu2usoVnXKVFVbcax7bE5UroCoI5WQqh/LZAy9
 Bu/LQcxbzJlDVEo6V5bgJ0iIayIm5Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751379623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goWdJuS3DzQyjPND8No4w9Goa0Xs/b5flGeXidYb/2Q=;
 b=WcMKb9BcgCOuLx2C/rNp57C5pUGMTtaWLBmxqEu61DqNRqRE7t5r3TSFqQF1C96ySiShdv
 QqPx23YvhyJaVeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F4A41364B;
 Tue,  1 Jul 2025 14:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MrSMAKfuY2hCDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Jul 2025 14:20:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
In-Reply-To: <87y0t81hg1.fsf@pond.sub.org>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-4-farosas@suse.de> <87y0t81hg1.fsf@pond.sub.org>
Date: Tue, 01 Jul 2025 11:20:20 -0300
Message-ID: <87o6u456xn.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>> The migration parameters tls_creds, tls_authz and tls_hostname
>> currently have a non-uniform handling. When used as arguments to
>> migrate-set-parameters, their type is StrOrNull and when used as
>> return value from query-migrate-parameters their type is a plain
>> string.
>>
>> Not only having to convert between the types is cumbersome, but it
>> also creates the issue of requiring two different QAPI types to be
>> used, one for each command. MigrateSetParameters is used for
>> migrate-set-parameters with the TLS arguments as StrOrNull while
>> MigrationParameters is used for query-migrate-parameters with the TLS
>> arguments as str.
>>
>> Since StrOrNull could be considered a superset of str, change the type
>> of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
>> that QTYPE_QNULL is never used.
>>
>> 1) migrate-set-parameters will always write QTYPE_QSTRING to
>>   s->parameters, either an empty or non-empty string.
>>
>> 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
>>   empty or non-empty.
>>
>> 3) the migrate_tls_* helpers will always return a non-empty string or
>>   NULL, for the internal migration code's consumption.
>>
>> Points (1) and (2) above help simplify the parameters validation and
>> the query command handling because s->parameters is already kept in
>> the format that query-migrate-parameters (and info migrate_paramters)
>> expect. Point (3) is so people don't need to care about StrOrNull in
>> migration code.
>>
>> This will allow the type duplication to be removed in the next
>> patches.
>>
>> Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
>> from str to StrOrNull in introspection of the query-migrate-parameters
>> command. We accept this imprecision to enable de-duplication.
>>
>> There's no need to free the TLS options in
>> migration_instance_finalize() because they're freed by the qdev
>> properties .release method.
>>
>> Temporary in this patch:
>> migrate_params_test_apply() copies s->parameters into a temporary
>> structure, so it's necessary to drop the references to the TLS options
>> if they were not set by the user to avoid double-free. This is fixed
>> in the next patches.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> diff --git a/migration/options.c b/migration/options.c
>> index 384ef9e421..f7bbdba5fc 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>
> [...]
>
>> @@ -935,6 +951,37 @@ AnnounceParameters *migrate_announce_params(void)
>>      return &ap;
>>  }
>>  
>> +void migrate_tls_opts_free(MigrationParameters *params)
>> +{
>> +    qapi_free_StrOrNull(params->tls_creds);
>> +    qapi_free_StrOrNull(params->tls_hostname);
>> +    qapi_free_StrOrNull(params->tls_authz);
>> +}
>> +
>> +/* either non-empty or empty string */
>
> This isn't true, because ...
>
>> +static void tls_opt_to_str(StrOrNull **tls_opt)
>> +{
>> +    StrOrNull *opt = *tls_opt;
>> +
>> +    if (!opt) {
>> +        return;
>
> ... it can also be null.
>

Hmm, I'll have to double check, but with the StrOrNull property being
initialized, NULL should not be possible. This looks like a mistake.

> Maybe
>
>    /* Normalize QTYPE_QNULL to QTYPE_QSTRING "" */
>
>> +    }
>> +
>> +    switch (opt->type) {
>> +    case QTYPE_QSTRING:
>> +        return;
>> +    case QTYPE_QNULL:
>> +        qobject_unref(opt->u.n);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    opt->type = QTYPE_QSTRING;
>> +    opt->u.s = g_strdup("");
>> +    *tls_opt = opt;
>> +}
>
> I'd prefer something like
>
>        if (!opt || opt->type == QTYPE_QSTRING) {
>            return;
>        }
>        qobject_unref(opt->u.n);
>        opt->type = QTYPE_QSTRING;
>        opt->u.s = g_strdup("");
>        *tls_opt = opt;
>
> But this is clearly a matter of taste.
>
>> +
>>  MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>  {
>>      MigrationParameters *params;
>
> [...]
>
>> @@ -1251,18 +1294,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>      }
>>  
>>      if (params->tls_creds) {
>> -        assert(params->tls_creds->type == QTYPE_QSTRING);
>> -        dest->tls_creds = params->tls_creds->u.s;
>> +        dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
>> +    } else {
>> +        /* drop the reference, it's owned by s->parameters */
>> +        dest->tls_creds = NULL;
>
> Suggest "clear the reference" to avoid associations with reference
> counting.
>
>>      }
>>  
>>      if (params->tls_hostname) {
>> -        assert(params->tls_hostname->type == QTYPE_QSTRING);
>> -        dest->tls_hostname = params->tls_hostname->u.s;
>> +        dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
>> +    } else {
>> +        /* drop the reference, it's owned by s->parameters */
>> +        dest->tls_hostname = NULL;
>>      }
>>  
>>      if (params->tls_authz) {
>> -        assert(params->tls_authz->type == QTYPE_QSTRING);
>> -        dest->tls_authz = params->tls_authz->u.s;
>> +        dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
>> +    } else {
>> +        /* drop the reference, it's owned by s->parameters */
>> +        dest->tls_authz = NULL;
>>      }
>>  
>>      if (params->has_max_bandwidth) {
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 4963f6ca12..97bb022c45 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1293,9 +1293,9 @@
>>              '*cpu-throttle-initial': 'uint8',
>>              '*cpu-throttle-increment': 'uint8',
>>              '*cpu-throttle-tailslow': 'bool',
>> -            '*tls-creds': 'str',
>> -            '*tls-hostname': 'str',
>> -            '*tls-authz': 'str',
>> +            '*tls-creds': 'StrOrNull',
>> +            '*tls-hostname': 'StrOrNull',
>> +            '*tls-authz': 'StrOrNull',
>>              '*max-bandwidth': 'size',
>>              '*avail-switchover-bandwidth': 'size',
>>              '*downtime-limit': 'uint64',
>
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>


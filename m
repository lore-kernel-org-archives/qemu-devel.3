Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07462CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwKL-000168-Iq; Thu, 23 Oct 2025 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwJu-0000ma-2j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwJs-0001It-0m
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0179B21196;
 Thu, 23 Oct 2025 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761229768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWQnq3rhcmuTeRWi+KJMH833c0BoceOzoH4HDgODqmQ=;
 b=oCGi746gDqkogxPrU40AaTtmNTNLVrFVybA3AwCP28ZUXYY7nHtjX4r5BbHAh9s1e9Lm8P
 O8W6V7IwrJQ5n2I25nZIMeT9r69Y7457mpOaCi4R6Ku6IoYQD5N7ZO0i7ZBt5sHxDOdpCv
 0wqWofJuaFWgG4jMHIkUguDHzAHQfTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761229768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWQnq3rhcmuTeRWi+KJMH833c0BoceOzoH4HDgODqmQ=;
 b=0wKa07grvpLBcT3T8Ga2yiBVp3qS291DN6oyV9tUKJAdbHMOyA6KdjzvpL+4+1dGTFEq6b
 b/1buD6B13Nd2dDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761229764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWQnq3rhcmuTeRWi+KJMH833c0BoceOzoH4HDgODqmQ=;
 b=KrUkobWmS0SDQkl2+at54TW+W1tyg91AHxaZzgTeslrWgBRAHppt+eoOpiPNy0maSxJHAO
 8ZqnOlBLoDmyatIvHI5Sh2uMuySlAKEAQqb6NPJM5itRg4RQO2eR5T8IcbN8fc7RjkvcFV
 9dh/V8f1I4bTluN5MGgeFvPK3MVNwNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761229764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWQnq3rhcmuTeRWi+KJMH833c0BoceOzoH4HDgODqmQ=;
 b=prc1Z2BQl7jXGnb9FrUzHZQXZf8CMjIXsRIdtMbJf6LhE/oe5epb/mj4ZDcNBKhVm+7EMu
 lKHgUkP3rNriKUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77B70136CF;
 Thu, 23 Oct 2025 14:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ux9fD8M7+mjFZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Oct 2025 14:29:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/24] migration: Normalize tls arguments
In-Reply-To: <20251015023114.24876-1-guobin@linux.alibaba.com>
References: <20250630195913.28033-4-farosas@suse.de>
 <20251015023114.24876-1-guobin@linux.alibaba.com>
Date: Thu, 23 Oct 2025 11:29:20 -0300
Message-ID: <871pmtu1xb.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Fabiano Rosas wrote on Mon, 30 Jun 2025 16:58:52 -0300:
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
>> ---
>>  migration/migration-hmp-cmds.c |   7 +-
>>  migration/options.c            | 156 ++++++++++++++++++++-------------
>>  migration/options.h            |   1 +
>>  migration/tls.c                |   2 +-
>>  qapi/migration.json            |   6 +-
>>  5 files changed, 106 insertions(+), 66 deletions(-)
>> 
>> +void migrate_tls_opts_free(MigrationParameters *params)
>> +{
>> +    qapi_free_StrOrNull(params->tls_creds);
>> +    qapi_free_StrOrNull(params->tls_hostname);
>> +    qapi_free_StrOrNull(params->tls_authz);
>> +}
>> +
>> +/* either non-empty or empty string */
>> +static void tls_opt_to_str(StrOrNull **tls_opt)
>> +{
>> +    StrOrNull *opt = *tls_opt;
>> +
>> +    if (!opt) {
>> +        return;
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
>> +
>
> Can these two functions be changed to be general, not just for tls?
> IMHO: 
> void migrate_strornull_opts_free(MigrationParameters *params)
> boid strornull_to_str(StrOrNull **the_opt)
>
> In this way, when members of type StrOrNull are added later,
> the function can be reused.
>

Ah, that's a clever observation, but we should probably refrain from
adding more StrOrNull options. The original intent behind the creation
of this type was already to workaround issues with the TLS options. I'd
rather leave it like this.

> --
> Bin Guo


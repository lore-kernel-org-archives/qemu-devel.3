Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03FD6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJtJ-0000pb-6J; Thu, 18 Dec 2025 14:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWJt7-0000lI-LY
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:42:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vWJss-0001Nt-Ha
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:42:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F5DC3369C;
 Thu, 18 Dec 2025 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766086909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jh9O5Pzgyzk7uG3p0CGl0+vL0prblUoKvR5Agh+K1ys=;
 b=M2Ub4yRgS3YhbSULiCfqJsr83Q3Ddds53PQaoI57Bn6nX9cjKq274bX9XgIsDi37G9Gdqs
 IZQ42jzmfj6hRanEyXudZf4gtTrHjV4RIBaC05ulI4E8EYSWIc7caPmwMDzVMtt4I7fTII
 /6kt1fKwLUvzQ+tTqnnhfjZ8upQeaqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766086909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jh9O5Pzgyzk7uG3p0CGl0+vL0prblUoKvR5Agh+K1ys=;
 b=GEeCtDe+jHGS11XN3V50+DWKZCpH4Xoy9N+FrmRnUAaLnvnOQer07cZsStYcceEvS9ie3c
 qrDx8CW0uCuTwCAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766086909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jh9O5Pzgyzk7uG3p0CGl0+vL0prblUoKvR5Agh+K1ys=;
 b=M2Ub4yRgS3YhbSULiCfqJsr83Q3Ddds53PQaoI57Bn6nX9cjKq274bX9XgIsDi37G9Gdqs
 IZQ42jzmfj6hRanEyXudZf4gtTrHjV4RIBaC05ulI4E8EYSWIc7caPmwMDzVMtt4I7fTII
 /6kt1fKwLUvzQ+tTqnnhfjZ8upQeaqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766086909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jh9O5Pzgyzk7uG3p0CGl0+vL0prblUoKvR5Agh+K1ys=;
 b=GEeCtDe+jHGS11XN3V50+DWKZCpH4Xoy9N+FrmRnUAaLnvnOQer07cZsStYcceEvS9ie3c
 qrDx8CW0uCuTwCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5BF53EA63;
 Thu, 18 Dec 2025 19:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Map8I/xYRGkqUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Dec 2025 19:41:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 30/51] tests/qtest/migration: Add temporary code to
 toggle usage of config
In-Reply-To: <aUQ7DcU5T_GH8G1V@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-31-farosas@suse.de> <aUQ7DcU5T_GH8G1V@x1.local>
Date: Thu, 18 Dec 2025 16:41:46 -0300
Message-ID: <875xa31ssl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 15, 2025 at 07:00:16PM -0300, Fabiano Rosas wrote:
>> The tests are being refactored to pass migration options to QEMU using
>> the new API of passing a JSON object as argument the migration
>> commands instead of using several calls to the
>> migrate_set_capabilities|parameters commands.
>> 
>> Since multiple tests share common infrastructure (framework.c,
>> migration-utils.c, migration-qmp.c), it's cumbersome to convert tests
>> in small chunks, which would require changes to every common function
>> to accept both the new and old ways.
>> 
>> After some tinkering, an easier way to do this transition is to allow
>> the tests to set a key in the config dict itself telling whether the
>> config is supported. With this, the common functions can be fully
>> altered to support the config object, as long as they check this
>> temporary key and do the right thing.
>> 
>> QEMU doesn't know about this hack, so some code is needed to hide it
>> when issuing QMP commands with the config object.
>> 
>> This will all be removed once tests are fully converted.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/migration-qmp.h  |  1 -
>>  tests/qtest/migration/migration-util.c |  1 +
>>  tests/qtest/migration/migration-util.h | 34 ++++++++++++++++++++++++++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
>> index 940ffd5950..9a36a677ba 100644
>> --- a/tests/qtest/migration/migration-qmp.h
>> +++ b/tests/qtest/migration/migration-qmp.h
>> @@ -47,5 +47,4 @@ void migrate_recover(QTestState *who, const char *uri);
>>  void migrate_cancel(QTestState *who);
>>  void migrate_postcopy_start(QTestState *from, QTestState *to,
>>                              QTestMigrationState *src_state);
>> -
>>  #endif /* MIGRATION_QMP_H */
>> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
>> index 416dd10ef8..e702f00896 100644
>> --- a/tests/qtest/migration/migration-util.c
>> +++ b/tests/qtest/migration/migration-util.c
>> @@ -255,6 +255,7 @@ static void migration_test_wrapper(const void *data)
>>  
>>      test->data = g_new0(MigrateCommon, 1);
>>      test->data->start.config = qdict_new();
>> +    qdict_put_bool(test->data->start.config, "use-config", false);
>>  
>>      g_test_message("Running /%s%s", qtest_get_arch(), test->name);
>>      test->func(test->name, test->data);
>> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
>> index e73d69bab0..3c3b5a8777 100644
>> --- a/tests/qtest/migration/migration-util.h
>> +++ b/tests/qtest/migration/migration-util.h
>> @@ -60,4 +60,38 @@ void migration_test_add_suffix(const char *path, const char *suffix,
>>  char *migrate_get_connect_uri(QTestState *who);
>>  void migrate_set_ports(QTestState *to, QList *channel_list);
>>  
>> +/*
>> + * Scaffolding to allow the framework _common functions and _qmp
>> + * functions to use the config object while some tests are still using
>> + * migrate_set_*. Tests that have been converted will set use-config =
>> + * true on the config dict.
>> + */
>> +static bool has_key;
>> +static bool use_config;
>
> Looks like this is temp measure, so no strong opinions.. said that, it
> looks tricky to have the two globals shared between all the tests, and
> having magic keys in the qdict.
>

It is tricky, but it works. The other options all require "passing
something" in, which ends up touching good code and causing a mess with
rebases and the overall clarity of the patches. But let me read about
your suggestions below...

> Can we pass in MigrateStart* for config_load() and config_put()?  Then at
> least we can change globals into per-test flags of MigrateStart.
>
> Btw, AFAIU the two helpers should always used in a pair but load() and
> put() do not look like a pair..
>

My mind went to vcpu_load/vcpu_put from kvm code. =D

> If we can have args->use_config as a bool, having tests opt-in config
> setups by setting it, then I wonder if we can do that like:
>

The migrate_qmp commands don't take args. So I'd have to alter their
signature just for this temporary state. That's why I put the flag in
the dict itself.

>   if (args->use_config) {
>       // do whatever with args->config...
>   } else {
>       // covered by other migrate-set-parameters QMP commands..
>   }
>
> Do we really need config_put()? I'll keep reading, but please evaluate..
>

Because of the migrate_incoming_qmp and -incoming calls, we need to take
the key out of the dict to hide it. Then put it back so the rest of the
code, e.g. migrate_qmp can use it.

>> +static inline QDict *config_load(QDict *config)
>> +{
>> +    if (!config) {
>> +        return NULL;
>> +    }
>> +
>> +    has_key = qdict_haskey(config, "use-config");
>> +    if (has_key) {
>> +        use_config = qdict_get_try_bool(config, "use-config", false);
>> +        qdict_del(config, "use-config");
>> +    }
>> +
>> +    if (use_config) {
>> +        return config;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static inline void config_put(QDict *config)
>> +{
>> +    if (config && has_key) {
>> +        qdict_put_bool(config, "use-config", use_config);
>> +    }
>> +}
>> +
>>  #endif /* MIGRATION_UTIL_H */
>> -- 
>> 2.51.0
>> 


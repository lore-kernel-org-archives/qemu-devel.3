Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2056C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOT-0002Fp-4G; Wed, 21 Feb 2024 10:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoKi-0001XF-SV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:30 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcm9S-0002QN-8T
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:56:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A66CC21E91;
 Wed, 21 Feb 2024 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708520199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MIPu86tIchJ6b8BwxjDHYVh04fQuCLgWEi2rU2O1rw=;
 b=JigMZKdHhulbW9LJz6Y6bWV+mb02Gni+AdWeaP9allzROuGsJ4DbhfOb5n1x+Po9XQO/Qb
 vZD12/WfJv2JKdQX63glBJ5Bq/yMC3ky72vgFnHhbs51GjH0Wth/omWHPWyN99QUZtSOrP
 PgkBRnck+KHXU4V6E7ni5LmcwLMrE0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708520199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MIPu86tIchJ6b8BwxjDHYVh04fQuCLgWEi2rU2O1rw=;
 b=7RQM1nZx6BnNChHSjF5Fv2CP9YsbjUxjfZn7kd0TjcDc8KWHdRTLVdUvyZ9hnF7ZM8gmQA
 WPLSWCqDNJi2ClAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708520199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MIPu86tIchJ6b8BwxjDHYVh04fQuCLgWEi2rU2O1rw=;
 b=JigMZKdHhulbW9LJz6Y6bWV+mb02Gni+AdWeaP9allzROuGsJ4DbhfOb5n1x+Po9XQO/Qb
 vZD12/WfJv2JKdQX63glBJ5Bq/yMC3ky72vgFnHhbs51GjH0Wth/omWHPWyN99QUZtSOrP
 PgkBRnck+KHXU4V6E7ni5LmcwLMrE0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708520199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MIPu86tIchJ6b8BwxjDHYVh04fQuCLgWEi2rU2O1rw=;
 b=7RQM1nZx6BnNChHSjF5Fv2CP9YsbjUxjfZn7kd0TjcDc8KWHdRTLVdUvyZ9hnF7ZM8gmQA
 WPLSWCqDNJi2ClAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F7A4139D0;
 Wed, 21 Feb 2024 12:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ha5cOQbz1WV+awAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 12:56:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
In-Reply-To: <ZdVlUsTDJA4hdNhg@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
Date: Wed, 21 Feb 2024 09:56:36 -0300
Message-ID: <87y1beascb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JigMZKdH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7RQM1nZx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A66CC21E91
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
>> The QMP command query_migrate might see incorrect throughput numbers
>> if it runs after we've set the migration completion status but before
>> migration_calculate_complete() has updated s->total_time and s->mbps.
>> 
>> The migration status would show COMPLETED, but the throughput value
>> would be the one from the last iteration and not the one from the
>> whole migration. This will usually be a larger value due to the time
>> period being smaller (one iteration).
>> 
>> Move migration_calculate_complete() earlier so that the status
>> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
>> update.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
>> ---
>>  migration/migration.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index ab21de2cad..7486d59da0 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
>>                                   int new_state);
>>  static void migrate_fd_cancel(MigrationState *s);
>>  static bool close_return_path_on_source(MigrationState *s);
>> +static void migration_calculate_complete(MigrationState *s);
>>  
>>  static void migration_downtime_start(MigrationState *s)
>>  {
>> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
>>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>>                            MIGRATION_STATUS_COLO);
>>      } else {
>> +        migration_calculate_complete(s);
>>          migrate_set_state(&s->state, current_active_state,
>>                            MIGRATION_STATUS_COMPLETED);
>>      }
>> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
>>          goto fail;
>>      }
>>  
>> +    migration_calculate_complete(s);
>>      migrate_set_state(&s->state, current_active_state,
>>                        MIGRATION_STATUS_COMPLETED);
>>      return;
>> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
>>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>      int64_t transfer_time;
>>  
>> +    /* QMP could read from these concurrently */
>> +    bql_lock();
>>      migration_downtime_end(s);
>>      s->total_time = end_time - s->start_time;
>>      transfer_time = s->total_time - s->setup_time;
>>      if (transfer_time) {
>>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
>>      }
>> +    bql_unlock();
>
> The lock is not needed?
>
> AFAIU that was needed because of things like runstate_set() rather than
> setting of these fields.
>

Don't we need to keep the total_time and mbps update atomic? Otherwise
query-migrate might see (say) total_time=0 and mbps=<correct value> or
total_time=<correct value> and mbps=<previous value>.

Also, what orders s->mbps update before the s->state update? I'd say we
should probably hold the lock around the whole total_time,mbps,state
update.

I'm not entirely sure, what do you think?

> See migration_update_counters() where it also updates mbps without holding
> a lock.

Here it might be less important since it's the middle of the migration,
there will proabably be more than one query-migrate which would see the
correct values.

>
> Other than that it looks all good.
>
>>  }
>>  
>>  static void update_iteration_initial_status(MigrationState *s)
>> @@ -3145,7 +3151,6 @@ static void migration_iteration_finish(MigrationState *s)
>>      bql_lock();
>>      switch (s->state) {
>>      case MIGRATION_STATUS_COMPLETED:
>> -        migration_calculate_complete(s);
>>          runstate_set(RUN_STATE_POSTMIGRATE);
>>          break;
>>      case MIGRATION_STATUS_COLO:
>> @@ -3189,9 +3194,6 @@ static void bg_migration_iteration_finish(MigrationState *s)
>>      bql_lock();
>>      switch (s->state) {
>>      case MIGRATION_STATUS_COMPLETED:
>> -        migration_calculate_complete(s);
>> -        break;
>> -
>>      case MIGRATION_STATUS_ACTIVE:
>>      case MIGRATION_STATUS_FAILED:
>>      case MIGRATION_STATUS_CANCELLED:
>> -- 
>> 2.35.3
>> 


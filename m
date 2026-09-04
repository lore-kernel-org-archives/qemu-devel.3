Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B37DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UIZ-0008PT-MX; Fri, 04 Sep 2026 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UIY-0008OP-Eb
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:49:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2UIW-0005AC-0M
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:49:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C38611FA8F;
 Fri,  4 Sep 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788529772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAOby7fYyZ24SfxoZ74LH5G2c7SoDnR9AIx17UUV7ss=;
 b=mOlZ4HtPLA9o4TOq8oBeFqJZFXkr4R5gPwoTD9N8kQVtpABQzhriOa3+iDvqVePRWZO/wS
 mEV68XwCNdXnqLjGH12RC9zvL1fPdVASty0vZTDLuL9TjQrBQl7DI1cpGPKpk03k/hNOF6
 5Be8p5A8UPSMTNSziseJblW0R9g8tic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788529772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAOby7fYyZ24SfxoZ74LH5G2c7SoDnR9AIx17UUV7ss=;
 b=4KG+zDkVxrh9d86tnzIYGLV8Ze7xtsPghfIRTj35e0RPUcq080bHXOXH6lgJ40T2QoOcsW
 JqAJquQ3J67XioDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788529768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAOby7fYyZ24SfxoZ74LH5G2c7SoDnR9AIx17UUV7ss=;
 b=AShB8Cmlg0IEqvisVWJl8ihrSwJCOj+8pfSNa/M9Qw1ktQ06gkjbi9tPZBvfK7G/bdltK7
 9vKUYS6gTXP+eF6w92CPRN4R2jruaHdPgrtQJEPzt+/++ldrw/r2mhfaOF+vJioeCgeBcZ
 dKUfYbXtpI9GtedFvJ3G5fJB2JhyOV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788529768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAOby7fYyZ24SfxoZ74LH5G2c7SoDnR9AIx17UUV7ss=;
 b=3OpCJ6cPfdzDYu1OmB51nNhofa0vMNboVF5H71AL1vEA28aOoCWVVrJTv+lUryd2rg5x1h
 5bg37hTw5eaU8TAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C22213678;
 Fri,  4 Sep 2026 13:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A5WuB2jMmmpiIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Sep 2026 13:49:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH 15/18] qapi/migration: Remove MigrationParameter
In-Reply-To: <apq4cH0QTHoAG4-m@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-16-farosas@suse.de> <apq4cH0QTHoAG4-m@x1.local>
Date: Fri, 04 Sep 2026 10:49:22 -0300
Message-ID: <87wlt16s9p.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

> On Wed, Sep 02, 2026 at 07:15:43PM -0300, Fabiano Rosas wrote:
>> This enum is convenient in two ways (just how enums work):
>> 
>> 1- It provides the number of migration parameters as its __MAX member.
>> 
>> 2- It allows iterating over an integer range and get a migration
>>    parameter name string corresponding to that position in the enum.
>> 
>> The migration code doesn't have the need for (2) anymore.
>> 
>> Balancing the benefit of (1) versus the disadvantage of requiring
>> migration.json to be updated in two different places whenever a
>> parameter is added, experience shows that the latter churn is enough
>> to decide to remove the enum.
>
> I may have a slightly different feeling, but that takes a few things into
> account, (1) we don't have issue duplicating docs for the two parameter
> names anymore, (2) the dup is only about adding the same string once more
> in qapi/, (3) we now have this migrate_mark_all_params_present() function
> that must set all has_* fields, which the __MAX did help to guard a bit..
>

I understand your points, I'm also unsure. I slightly prefer to have the
"problem" inside migration/ than inside qapi/. Let me ponder a bit more
during the respin, let's see.

> I think it's also fine to remove it completely, we just need to be more
> careful instead on migrate_mark_all_params_present() later.  Which one is
> easier to be forgotten?  I don't know..
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c |  6 +-----
>>  qapi/migration.json | 36 ------------------------------------
>>  2 files changed, 1 insertion(+), 41 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 5d17acdd881..f988b181f0e 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1127,7 +1127,6 @@ static MigrationParameters *migrate_params_from_dict(QDict *d, Error **errp)
>>   */
>>  static void migrate_mark_all_params_present(MigrationParameters *p)
>>  {
>> -    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
>>      bool *has_fields[] = {
>>          &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
>>          &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
>> @@ -1144,10 +1143,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>>          &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>>      };
>>  
>> -    len = ARRAY_SIZE(has_fields);
>> -    assert(len + n_str_args == MIGRATION_PARAMETER__MAX);
>> -
>> -    for (int i = 0; i < len; i++) {
>> +    for (int i = 0; i < ARRAY_SIZE(has_fields); i++) {
>>          *has_fields[i] = true;
>>      }
>>  }
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index b1eaf7b0545..78c6e933cf1 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -796,42 +796,6 @@
>>        'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>>    } }
>>  
>> -##
>> -# @MigrationParameter:
>> -#
>> -# Migration parameters enumeration.  The enumeration values mirror the
>> -# members of @MigrationParameters.
>> -#
>> -# Features:
>> -#
>> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>> -#     @x-vcpu-dirty-limit-period are experimental.
>> -#
>> -# Since: 2.4
>> -##
>> -{ 'enum': 'MigrationParameter',
>> -  'data': ['announce-initial', 'announce-max',
>> -           'announce-rounds', 'announce-step',
>> -           'throttle-trigger-threshold',
>> -           'cpu-throttle-initial', 'cpu-throttle-increment',
>> -           'cpu-throttle-tailslow',
>> -           'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>> -           'avail-switchover-bandwidth', 'downtime-limit',
>> -           { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>> -           'multifd-channels',
>> -           'xbzrle-cache-size', 'max-postcopy-bandwidth',
>> -           'max-cpu-throttle', 'multifd-compression',
>> -           'multifd-zlib-level', 'multifd-zstd-level',
>> -           'multifd-qatzip-level',
>> -           'block-bitmap-mapping',
>> -           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>> -           'vcpu-dirty-limit',
>> -           'mode',
>> -           'zero-page-detection',
>> -           'direct-io',
>> -           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>> -           'cpr-exec-command'] }
>> -
>>  ##
>>  # @migrate-set-parameters:
>>  #
>> -- 
>> 2.53.0
>> 


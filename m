Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D7DC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTzp-0002U7-2Z; Tue, 03 Jun 2025 11:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMTzl-0002OL-Ch
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:56:09 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMTzg-00031m-Ex
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:56:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A23A61FD14;
 Tue,  3 Jun 2025 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748966161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN70W6RwK9+/1EtX97jEaYfYwU4ub3fAwjmZZWvPgGs=;
 b=iC02QbibTrmhY5ZRJfveQVHaTM+P2l2crw9TaIh+uwEZWoXgkxL1GRXY9JG4F6h3nqmwtD
 LKrzr6KTsmDg68ssk4uFf4Hw2WbaN0brAOuk5fvhw7gSKs/BPOyFZex1Ap0v4q0K+Y/Ib6
 KYhqn69qdgfcOeaEC3dL/v+m3FYPNng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748966161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN70W6RwK9+/1EtX97jEaYfYwU4ub3fAwjmZZWvPgGs=;
 b=5zh5/DhVReHGxNEa6gqxoBa0hjjkSSw09DMG1pq8Ue60Ah8kLY7/XI950tBcpHqTHsK9s9
 ccmLmKqQExlfajBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UQ7OpSdw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kyzsk7CM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748966160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN70W6RwK9+/1EtX97jEaYfYwU4ub3fAwjmZZWvPgGs=;
 b=UQ7OpSdw1VKvh7TQZIJFKpy/Z4tTPGX9ul1uO7iVkvuIv3Le8Myeufl5NXO/pgiiTiVCAc
 VNUR1wU+bZL3DpW7ghDvajAzF9tDbS9lmj0Z9KXrxAIMRhDOIFlkTSFOPM6LAh67Iv31Ki
 U2Dz08cUO/lYy7GJp0cwAIZr7Ra4ZjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748966160;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN70W6RwK9+/1EtX97jEaYfYwU4ub3fAwjmZZWvPgGs=;
 b=kyzsk7CM0OeghPbz90WS87CdzWf6i/+hQ7mT/2/V8caaDJaCzWGMZJEYMBKCb/PO54STFt
 g2dEfLBXhmqX7xDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1419913A92;
 Tue,  3 Jun 2025 15:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fj7MMQ8bP2grQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 15:55:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 05/13] migration/postcopy: Drop
 PostcopyBlocktimeContext.start_time
In-Reply-To: <87h60w4yb3.fsf@suse.de>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-6-peterx@redhat.com> <87h60w4yb3.fsf@suse.de>
Date: Tue, 03 Jun 2025 12:55:57 -0300
Message-ID: <87bjr44y5u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: A23A61FD14
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> Now with 64bits, the offseting using start_time is not needed anymore,
>> because the array can always remember the whole timestamp.
>>
>> Then drop the unused parameter in get_low_time_offset() altogether.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/postcopy-ram.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 72f9075e69..c6ae4b650c 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -123,7 +123,6 @@ typedef struct PostcopyBlocktimeContext {
>>      uint64_t last_begin;
>>      /* number of vCPU are suspended */
>>      int smp_cpus_down;
>> -    uint64_t start_time;
>>  
>>      /*
>>       * Handler for exit event, necessary for
>> @@ -157,7 +156,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>>      ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
>>      ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
>>      ctx->exit_notifier.notify = migration_exit_cb;
>> -    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>      qemu_add_exit_notifier(&ctx->exit_notifier);
>>  
>>      return ctx;
>> @@ -818,9 +816,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
>>      return -1;
>>  }
>>  
>> -static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
>> +static uint64_t get_low_time_offset(void)
>>  {
>> -    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
>> +    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>  }
>
> Looking at this and the previous patch, this not "low" anymore, i.e.,
> not the lower 32 bits of a 64 bit value. This function and related
> variables should be renamed.
>

Ok, next patch does it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E531CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyus-0005a5-GI; Tue, 26 Aug 2025 15:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uqyul-0005Xr-P4
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:01:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uqyui-0002Uw-Il
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 15:01:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B3C921167;
 Tue, 26 Aug 2025 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756234855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6xTe21q9V8m7t02JOh+ImAnLH3QdxuoiCWz7MVaA6s=;
 b=nHXEupbswGOb2wk5vtEu17+Op6pmJSJI+RMVxia0mcpXFe9/+Ll4U5m3PFPC2zJ7LDLVny
 V6pXq42HtdFTuqMlyXugOR39xpvmvWNJCp+/BCtB479YBhAlYXCXEfj7BsSJ1eLM38VLkh
 3RnRbAiQTRpHpkFqpqo/lfYgcU0bheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756234855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6xTe21q9V8m7t02JOh+ImAnLH3QdxuoiCWz7MVaA6s=;
 b=5mvs+H8t1sIvczEPuEI10HQvrZbkyl3MuxpocgPHKRgT00lIy9WjVMHxWoNXMcWxdLLz58
 3Ufs83fo4q4cBCCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nHXEupbs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5mvs+H8t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756234855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6xTe21q9V8m7t02JOh+ImAnLH3QdxuoiCWz7MVaA6s=;
 b=nHXEupbswGOb2wk5vtEu17+Op6pmJSJI+RMVxia0mcpXFe9/+Ll4U5m3PFPC2zJ7LDLVny
 V6pXq42HtdFTuqMlyXugOR39xpvmvWNJCp+/BCtB479YBhAlYXCXEfj7BsSJ1eLM38VLkh
 3RnRbAiQTRpHpkFqpqo/lfYgcU0bheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756234855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6xTe21q9V8m7t02JOh+ImAnLH3QdxuoiCWz7MVaA6s=;
 b=5mvs+H8t1sIvczEPuEI10HQvrZbkyl3MuxpocgPHKRgT00lIy9WjVMHxWoNXMcWxdLLz58
 3Ufs83fo4q4cBCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D711013A31;
 Tue, 26 Aug 2025 19:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kiZIJWYErmgGHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Aug 2025 19:00:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] migration: Fix state transition in postcopy_start()
 error handling
In-Reply-To: <aK37u8DSP4tGFcLI@x1.local>
References: <20250826115145.871272-1-jmarcin@redhat.com>
 <aK37u8DSP4tGFcLI@x1.local>
Date: Tue, 26 Aug 2025 16:00:52 -0300
Message-ID: <87sehdkivv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6B3C921167
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Tue, Aug 26, 2025 at 01:51:40PM +0200, Juraj Marcin wrote:
>> From: Juraj Marcin <jmarcin@redhat.com>
>> 
>> Commit 48814111366b ("migration: Always set DEVICE state") introduced
>> DEVICE state to postcopy, which moved the actual state transition that
>> leads to POSTCOPY_ACTIVE.
>> 
>> However, the error handling part of the postcopy_start() function still
>> expects the state POSTCOPY_ACTIVE, but depending on where an error
>> happens, now the state can be either ACTIVE, DEVICE or CANCELLING, but
>> never POSTCOPY_ACTIVE, as this transition now happens just before a
>> successful return from the function.
>> 
>> Instead, accept any state except CANCELLING when transitioning to FAILED
>> state.
>> 
>> Cc: qemu-stable@nongnu.org
>> Fixes: 48814111366b ("migration: Always set DEVICE state")
>> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
>
> Thanks, Juraj!
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

>> 
>> ---
>> In the RFC[1] where this patch was discussed, there was also a
>> suggestion for a helper function migrate_set_failure() that would check
>> if the state is not CANCELLING and then set migration error and FAILED
>> state. I discussed the implementation with Peter, and we came to a
>> conclusion that instead of patching such clean-up on top of the current
>> error handling code, it might be more useful to do a larger refactor and
>> clean-up of all error handling in the migration code.
>> 
>> Such clean-up should reduce the number of places where we need to
>> explicitly transition to a FAILED state (ideally to one, or only a
>> couple of places), and instead only set an appropriate migration error
>> using migrate_set_error(). Additionally, it would also refactor
>> inappropriate uses of QEMUFile errors where the error is not really an
>> error of the underlying channel and migrate_set_error() should be used
>> instead.
>
> Fabiano: we discussed something around the FAILED status before as well.
> If you started working on something in this area, please shoot!
>

I don't have anything planned, it's just the thread that I already
linked in the previous version of this patch. Juraj is aware.

>> 
>> [1]: https://lore.kernel.org/all/20250807114922.1013286-3-jmarcin@redhat.com/
>> ---
>>  migration/migration.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 10c216d25d..32b8ce5613 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>  fail_closefb:
>>      qemu_fclose(fb);
>>  fail:
>> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> -                          MIGRATION_STATUS_FAILED);
>> +    if (ms->state != MIGRATION_STATUS_CANCELLING) {
>> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>> +    }
>>      migration_block_activate(NULL);
>>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>>      bql_unlock();
>> -- 
>> 2.50.1
>> 


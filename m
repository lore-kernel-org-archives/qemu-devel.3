Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AC0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSRz-0007cY-D8; Fri, 08 Aug 2025 15:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukSRx-0007c6-IU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 15:08:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukSRv-0007UV-F3
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 15:08:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 270F21F7FE;
 Fri,  8 Aug 2025 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754680097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjcubkIDA/wpAyiybnKYxXLPSvaes8dEdtd/JjaSmFY=;
 b=lVkkb29wZ2WstMf78EyRm55g+XKNptDb18y9+72IIQAMcgofQCcDLLC+iAcECQjUJwHLyR
 TxHJDPH+b65WXVCL0IeOaP70tkae1RzuqsWuezql/5YS0q9ceMOMDcrb1GLj6YJbTgbWQK
 mS0w/M2jR6QKJ73lRzN8n/yDzBZqLc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754680097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjcubkIDA/wpAyiybnKYxXLPSvaes8dEdtd/JjaSmFY=;
 b=hJl1Zz5MF5e0Bmf+gG3Cfuzb5XzXke8pVMZgHbmcQTqidbGKMmDv+qdOnbEYsjEOH6FmRz
 U2uBcw2sOOi6xnAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E3ujDZPO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YV+ethyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754680096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjcubkIDA/wpAyiybnKYxXLPSvaes8dEdtd/JjaSmFY=;
 b=E3ujDZPOqN4rOeKTS4hZrIDCo00c3lg22jzb/GvuCyx36fKcK3OiT9eafbhEXdpae1Pd8U
 F56/xGufGcOyAWOLxw60Eph+xvDeI4kVNJQdd2h9apx3As50vrFMUipZhAUWVT4CV5Gpjg
 xOpNxo3+ilfcbJ6jtxq9xebwoDUGn/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754680096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjcubkIDA/wpAyiybnKYxXLPSvaes8dEdtd/JjaSmFY=;
 b=YV+ethyGzS8HoNG+Cq4F2gC0pXxGVYhgrjInhy7Ei1sjL9zVFM7HDz9+yWGGFhgOdEpfRe
 b1bKsPv1oz5aSGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9397F13A7E;
 Fri,  8 Aug 2025 19:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1J5mFB9LlmjZewAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Aug 2025 19:08:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/4] migration: Fix state transition in
 postcopy_start() error handling
In-Reply-To: <aJUSeOIKfQ47uliY@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-3-jmarcin@redhat.com> <aJUSeOIKfQ47uliY@x1.local>
Date: Fri, 08 Aug 2025 16:08:12 -0300
Message-ID: <87ectl1vj7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 270F21F7FE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Thu, Aug 07, 2025 at 01:49:10PM +0200, Juraj Marcin wrote:
>> From: Juraj Marcin <jmarcin@redhat.com>
>> 
>> Depending on where an error during postcopy_start() happens, the state
>> can be either "active", "device" or "cancelling", but never
>> "postcopy-active". Migration state is transitioned to "postcopy-active"
>> only just before a successful return from the function.
>> 
>> Accept any state except "cancelling" when transitioning to "failed"
>> state.
>> 
>> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
>> ---
>>  migration/migration.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 10c216d25d..e5ce2940d5 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>  fail_closefb:
>>      qemu_fclose(fb);
>>  fail:
>> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> -                          MIGRATION_STATUS_FAILED);
>> +    if ( ms->state != MIGRATION_STATUS_CANCELLING) {
>> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>> +    }
>
> Hmm, this might have been overlooked from my commit 48814111366b.  Maybe
> worth a Fixes and copy stable?
>
> For example, I would expect the old code (prior of 48814111366b) still be
> able to fail postcopy and resume src QEMU if qemu_savevm_send_packaged()
> failed.  Now, looks like it'll be stuck at "device" state..
>
> The other thing is it also looks like a common pattern to set FAILED
> meanwhile not messing with a CANCELLING stage.  It's not easy to always
> remember this, so maybe we should consider having a helper function?
>
>   migrate_set_failure(MigrationState *, Error *err);
>

We didn't do it back then because at there would be some logical
conflict with this series:

https://lore.kernel.org/r/20250110100707.4805-1-shivam.kumar1@nutanix.com

But I don't remember the details. If it works this time I'm all for it.

> Which could set err with migrate_set_error() (likely we could also
> error_report() the error), and update FAILED iff it's not CANCELLING.
>
> I saw three of such occurances that such helper may apply, but worth double
> check:
>
> postcopy_start[2725]           if (ms->state != MIGRATION_STATUS_CANCELLING) {
> migration_completion[3069]     if (s->state != MIGRATION_STATUS_CANCELLING) {
> igration_connect[4064]        if (s->state != MIGRATION_STATUS_CANCELLING) {
>
> If the cleanup looks worthwhile, and if the Fixes apply, we could have the
> cleanup patch on top of the fixes patch so patch 1 is easier to backport.
>
> Thanks,
>
>>      migration_block_activate(NULL);
>>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>>      bql_unlock();
>> -- 
>> 2.50.1
>> 


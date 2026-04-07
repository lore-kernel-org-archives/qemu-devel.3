Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D34FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVy-0007cY-TN; Tue, 07 Apr 2026 14:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wABTe-0002am-Jc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1wA5Hp-0006Jh-9b
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 08:12:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76FCC5BD70;
 Tue,  7 Apr 2026 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775563923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjJfEQOQebhmdaL6bxd1TkQa8g9eaTIQX4HgIqleqdM=;
 b=ya74biBPDzxqTFCezlk3BZJXTbKOZFA0P0k+0CO70QXGUA5tEKslj4uvl1iD3ZSC2dNKo8
 YQUzZC0ebbfG5TRfveeGaldlqI4Vm4A7soc/8oAypZKmUiIZaXqL0KU0DKM8f05gHbkIbJ
 t4jeFaG6IP7p3GK7l+Ijf97nDelxW/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775563923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjJfEQOQebhmdaL6bxd1TkQa8g9eaTIQX4HgIqleqdM=;
 b=kidfX31qjPuEtAbfSC5oH12dKAA0skbMsHdRkE4GzsW71pSEE6XniGlMENJuKC30E/mJQ4
 Cs/iJNuvmHuYE0AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ya74biBP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kidfX31q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775563923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjJfEQOQebhmdaL6bxd1TkQa8g9eaTIQX4HgIqleqdM=;
 b=ya74biBPDzxqTFCezlk3BZJXTbKOZFA0P0k+0CO70QXGUA5tEKslj4uvl1iD3ZSC2dNKo8
 YQUzZC0ebbfG5TRfveeGaldlqI4Vm4A7soc/8oAypZKmUiIZaXqL0KU0DKM8f05gHbkIbJ
 t4jeFaG6IP7p3GK7l+Ijf97nDelxW/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775563923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjJfEQOQebhmdaL6bxd1TkQa8g9eaTIQX4HgIqleqdM=;
 b=kidfX31qjPuEtAbfSC5oH12dKAA0skbMsHdRkE4GzsW71pSEE6XniGlMENJuKC30E/mJQ4
 Cs/iJNuvmHuYE0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 083A94A0B0;
 Tue,  7 Apr 2026 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4ii0OpL01GlBBAAAD6G6ig
 (envelope-from <cfontana@suse.de>); Tue, 07 Apr 2026 12:12:02 +0000
Message-ID: <afc6a092-9441-4335-bd00-0c613180f152@suse.de>
Date: Tue, 7 Apr 2026 14:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: track timing and received pages in
 MigrationIncomingState
From: Claudio Fontana <cfontana@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <20260405152612.93027-1-viking4@gmail.com>
 <20260405152612.93027-2-viking4@gmail.com>
 <043e3410-9a58-4102-86a2-177579b63add@suse.de>
Content-Language: en-US
In-Reply-To: <043e3410-9a58-4102-86a2-177579b63add@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 76FCC5BD70
Received-SPF: pass client-ip=195.135.223.131; envelope-from=cfontana@suse.de;
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

On 4/7/26 14:02, Claudio Fontana wrote:
> Hello,
> 
> On 4/5/26 17:26, Trieu Huynh wrote:
>> From: Trieu Huynh <vikingtc4@gmail.com>
>>
>> Add start_time, total_time, received_normal_pages,
>> received_zero_pages, and received_xbzrle_pages to
>> MigrationIncomingState.
>>
>> start_time is recorded when the incoming state transitions to ACTIVE;
>> total_time is recorded when it transitions to COMPLETED. The page
>> counters are incremented in ram_load_precopy() as each page type is
>> received from the source.
>>
>> These fields will be used by a subsequent patch to populate
>> fill_destination_migration_info() for the migration COMPLETED case.
>>
>> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>> ---
>>  migration/migration.c |  2 ++
>>  migration/migration.h | 17 +++++++++++++++++
>>  migration/ram.c       |  3 +++
>>  3 files changed, 22 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5c9aaa6e58..17c9a8b344 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -726,6 +726,7 @@ static void process_incoming_migration_bh(void *opaque)
>>       */
>>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>                        MIGRATION_STATUS_COMPLETED);
>> +    mis->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - mis->start_time;
>>      migration_incoming_state_destroy();
>>  }
>>  
>> @@ -758,6 +759,7 @@ process_incoming_migration_co(void *opaque)
>>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>>                        MIGRATION_STATUS_ACTIVE);
>>  
>> +    mis->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>      mis->loadvm_co = qemu_coroutine_self();
>>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>>      mis->loadvm_co = NULL;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index b6888daced..cd51ae452c 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -176,6 +176,23 @@ struct MigrationIncomingState {
>>      /* PostCopyFD's for external userfaultfds & handlers of shared memory */
>>      GArray   *postcopy_remote_fds;
>>  
>> +    /*
>> +     * Timestamps for reporting migration duration via query-migrate on the
>> +     * destination. start_time is recorded when the state moves to ACTIVE;
>> +     * total_time is recorded when it moves to COMPLETED.
>> +     */
>> +    int64_t start_time;
>> +    int64_t total_time;
> 
> nit: since this is a timestamp and these are directly linked to state changes,
> why not call these:
> 
> int64_t migration_active_ts;
> int64_t migration_completed_ts;

I got the second one wrong, it is not a timestamp, that is indeed a time.
So clarity in the name seems to be more than a nit. What about:

int64_t migration_active_ts;      /* ms */
int64_t migration_completed_time; /* ms */

Thanks,

Claudio

> 
>> +
>> +    /*
>> +     * Page counters for reporting RAM statistics via query-migrate on the
>> +     * destination.  Incremented in ram_load_precopy() as each page type
>> +     * is received.
>> +     */
>> +    uint64_t received_normal_pages;
>> +    uint64_t received_zero_pages;
>> +    uint64_t received_xbzrle_pages;
>> +
>>      MigrationStatus state;
>>  
>>      /*
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 979751f61b..6646e5daad 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4417,10 +4417,12 @@ static int ram_load_precopy(QEMUFile *f)
>>                  break;
>>              }
>>              ram_handle_zero(host, TARGET_PAGE_SIZE);
>> +            mis->received_zero_pages++;
>>              break;
>>  
>>          case RAM_SAVE_FLAG_PAGE:
>>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>> +            mis->received_normal_pages++;
>>              break;
>>  
>>          case RAM_SAVE_FLAG_XBZRLE:
>> @@ -4430,6 +4432,7 @@ static int ram_load_precopy(QEMUFile *f)
>>                  ret = -EINVAL;
>>                  break;
>>              }
>> +            mis->received_xbzrle_pages++;
>>              break;
>>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
>>              multifd_recv_sync_main();
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852CFD3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSd8P-0002tr-LZ; Mon, 08 Dec 2025 10:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vSd8L-0002sz-Dq
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:26:41 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vSd8J-0003jB-1B
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:26:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A89D05BCC9;
 Mon,  8 Dec 2025 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765207595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKHo35LhjGJo6FXZCEVR+MKbVywEaPfZESTommw/vrI=;
 b=P3AUMj6xqnG762a8Su/rlyjGKfuEoV0OiYKYmyBedJjJZ2pxsCTMjZkEpt6wEQcwelU/D5
 qwDyGPaSjhOPPJKJ85fVqS2wrxoN+MJ6eN5bA/Z+oqzsDC7b35Ukh298E71k1jRf0LlAmj
 GTFLNKb1fxLmQhGkF57YPVPZ3KtgEOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765207595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKHo35LhjGJo6FXZCEVR+MKbVywEaPfZESTommw/vrI=;
 b=WNVBAo1PBwhpjiCUVXXxj3BU8J1SENNSjY/eFaKrXbW05qWVBmpNlGa2BQntlIMSO2h4A1
 cKA+eiDh72VXUVAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PfXGLjew;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p5DiUMnb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765207594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKHo35LhjGJo6FXZCEVR+MKbVywEaPfZESTommw/vrI=;
 b=PfXGLjew1za8AZo6mwtuZLQEyw5PBCHrnAgPbEEyvzoCKHD9VVKhJoQiDAnZeqcRoXEEZE
 CxuBhnbpNfd74np3kVnhSLzdaSKDelBym/ayFuBwgin66n3qxQVCxEPNYdjh1hOdWNpEs9
 qo8be1kvlm5Npp7nfPm47KIOwTQjcQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765207594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKHo35LhjGJo6FXZCEVR+MKbVywEaPfZESTommw/vrI=;
 b=p5DiUMnbsSRBkrj5F/aZzAkgTeDPrx0wXYiR7JUG3FjsQTWFkXQcSSwUfIhNeYE/JPzQtf
 cqe5tr4gP7BPgqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE263EA63;
 Mon,  8 Dec 2025 15:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mgIENCnuNmlLbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Dec 2025 15:26:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] migration: Fix a possible crash when halting a guest
 during migration
In-Reply-To: <20251208144525.GA1341938@fedora>
References: <20251208135101.271417-1-thuth@redhat.com>
 <20251208144525.GA1341938@fedora>
Date: Mon, 08 Dec 2025 12:26:31 -0300
Message-ID: <87jyyxkna0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A89D05BCC9
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Dec 08, 2025 at 02:51:01PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>> 
>> When shutting down a guest that is currently in progress of being
>> migrated, there is a chance that QEMU might crash during bdrv_delete().
>> The backtrace looks like this:
>> 
>>  Thread 74 "mig/src/main" received signal SIGSEGV, Segmentation fault.
>> 
>>  [Switching to Thread 0x3f7de7fc8c0 (LWP 2161436)]
>>  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>  5560	        QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
>>  (gdb) bt
>>  #0  0x000002aa00664012 in bdrv_delete (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:5560
>>  #1  bdrv_unref (bs=0x2aa00f875c0) at ../../devel/qemu/block.c:7170
>>  Backtrace stopped: Cannot access memory at address 0x3f7de7f83e0
>> 

How does the migration thread reaches here? Is this from
migration_block_inactivate()?

>> The problem is apparently that the migration thread is still active
>> (migration_shutdown() only asks it to stop the current migration, but
>> does not wait for it to finish)

"asks it to stop", more like pulls the plug abruptly. Note that setting
the CANCELLING state has technically nothing to do with this, the actual
cancelling lies on the not so gentle:

if (s->to_dst_file) {
    qemu_file_shutdown(s->to_dst_file);
}
 
>> , while the main thread continues to
>> bdrv_close_all() that will destroy all block drivers. So the two threads
>> are racing here for the destruction of the migration-related block drivers.
>> 
>> I was able to bisect the problem and the race has apparently been introduced
>> by commit c2a189976e211c9ff782 ("migration/block-active: Remove global active
>> flag"), so reverting it might be an option as well, but waiting for the
>> migration thread to finish before continuing with the further clean-ups
>> during shutdown seems less intrusive.
>> 
>> Note: I used the Claude AI assistant for analyzing the crash, and it
>> came up with the idea of waiting for the migration thread to finish
>> in migration_shutdown() before proceeding with the further clean-up,
>> but the patch itself has been 100% written by myself.
>
> It sounds like the migration thread does not hold block graph refcounts
> and assumes the BlockDriverStates it uses have a long enough lifetime.
>
> I don't know the migration code well enough to say whether joining in
> migration_shutdown() is okay. Another option would be expicitly holding
> the necessary refcounts in the migration thread.
>

I agree. In principle and also because shuffling the joining around
feels like something that's prone to introduce other bugs.

>> 
>> Fixes: c2a189976e ("migration/block-active: Remove global active flag")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  migration/migration.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b316ee01ab2..6f4bb6d8438 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -380,6 +380,16 @@ void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
>>      qemu_bh_schedule(bh);
>>  }
>>  
>> +static void migration_thread_join(MigrationState *s)
>> +{
>> +    if (s && s->migration_thread_running) {
>> +        bql_unlock();
>> +        qemu_thread_join(&s->thread);
>> +        s->migration_thread_running = false;
>> +        bql_lock();
>> +    }
>> +}
>> +
>>  void migration_shutdown(void)
>>  {
>>      /*
>> @@ -393,6 +403,13 @@ void migration_shutdown(void)
>>       * stop the migration using this structure
>>       */
>>      migration_cancel();
>> +    /*
>> +     * Wait for migration thread to finish to prevent a possible race where
>> +     * the migration thread is still running and accessing host block drivers
>> +     * while the main cleanup proceeds to remove them in bdrv_close_all()
>> +     * later.
>> +     */
>> +    migration_thread_join(migrate_get_current());
>>      object_unref(OBJECT(current_migration));
>>  
>>      /*
>> @@ -1499,12 +1516,7 @@ static void migration_cleanup(MigrationState *s)
>>  
>>      close_return_path_on_source(s);
>>  
>> -    if (s->migration_thread_running) {
>> -        bql_unlock();
>> -        qemu_thread_join(&s->thread);
>> -        s->migration_thread_running = false;
>> -        bql_lock();
>> -    }
>> +    migration_thread_join(s);
>>  
>>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>>          /*
>> -- 
>> 2.52.0
>> 


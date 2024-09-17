Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EFCAC594
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcCp-0002bj-3R; Tue, 17 Sep 2024 13:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqcCn-0002an-NL; Tue, 17 Sep 2024 13:41:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqcCl-0007bU-M6; Tue, 17 Sep 2024 13:41:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C0EE223C2;
 Tue, 17 Sep 2024 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726594893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV4Jk/DyRwEY/5RUztZ5Ca6cW77LKSDPHskASsa8X4Y=;
 b=uM0suUn/wFz+jOAuClJOFLpdTZiEkVevnh6Ttb2Q5gKxrdBmwoaaSFf2sAaHnWR4GdJqCW
 vA7P2IaevoZRM5lJKKdjK7KeArz02o8GfN8jiNxc3HlClgxehseeNJevu66cULm0fOqyR5
 GA7+7JknAYv9DH+xbkmvuZ1HDdScJWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726594893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV4Jk/DyRwEY/5RUztZ5Ca6cW77LKSDPHskASsa8X4Y=;
 b=hcVVNzmIg9K0pn0xTup/eaCyHJxTDobpg0I36hxJvJhrfuR9Lk3B5mpOgus6z7epIFS09s
 eAEelkFAriKo73Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726594893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV4Jk/DyRwEY/5RUztZ5Ca6cW77LKSDPHskASsa8X4Y=;
 b=uM0suUn/wFz+jOAuClJOFLpdTZiEkVevnh6Ttb2Q5gKxrdBmwoaaSFf2sAaHnWR4GdJqCW
 vA7P2IaevoZRM5lJKKdjK7KeArz02o8GfN8jiNxc3HlClgxehseeNJevu66cULm0fOqyR5
 GA7+7JknAYv9DH+xbkmvuZ1HDdScJWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726594893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dV4Jk/DyRwEY/5RUztZ5Ca6cW77LKSDPHskASsa8X4Y=;
 b=hcVVNzmIg9K0pn0xTup/eaCyHJxTDobpg0I36hxJvJhrfuR9Lk3B5mpOgus6z7epIFS09s
 eAEelkFAriKo73Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88400139CE;
 Tue, 17 Sep 2024 17:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPwBFEy/6Wa/eQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 17:41:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
In-Reply-To: <Zum2LOpaIRVDDEo9@x1n>
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-3-farosas@suse.de> <Zum2LOpaIRVDDEo9@x1n>
Date: Tue, 17 Sep 2024 14:41:30 -0300
Message-ID: <87frpyyy7p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Fri, Sep 13, 2024 at 07:05:42PM -0300, Fabiano Rosas wrote:
>> Fix a segmentation fault in multifd when rb->receivedmap is cleared
>> too early.
>> 
>> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
>> multiple page faults"), multifd started using the rb->receivedmap
>> bitmap, which belongs to ram.c and is initialized and *freed* from the
>> ram SaveVMHandlers.
>> 
>> Multifd threads are live until migration_incoming_state_destroy(),
>> which is called after qemu_loadvm_state_cleanup(), leading to a crash
>> when accessing rb->receivedmap.
>> 
>> process_incoming_migration_co()        ...
>>   qemu_loadvm_state()                  multifd_nocomp_recv()
>>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
>>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
>>   ...
>>   migration_incoming_state_destroy()
>>     multifd_recv_cleanup()
>>       multifd_recv_terminate_threads(NULL)
>> 
>> Move the loadvm cleanup into migration_incoming_state_destroy(), after
>> multifd_recv_cleanup() to ensure multifd thread have already exited
>> when rb->receivedmap is cleared.
>> 
>> The have_listen_thread logic can now be removed because its purpose
>> was to delay cleanup until postcopy_ram_listen_thread() had finished.
>> 
>> CC: qemu-stable@nongnu.org
>> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 1 +
>>  migration/migration.h | 1 -
>>  migration/savevm.c    | 9 ---------
>>  3 files changed, 1 insertion(+), 10 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dea06d577..b190a574b1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>>  
>>      multifd_recv_cleanup();
>> +    qemu_loadvm_state_cleanup();
>>  
>>      if (mis->to_src_file) {
>>          /* Tell source that we are done */
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 38aa1402d5..20b0a5b66e 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -101,7 +101,6 @@ struct MigrationIncomingState {
>>      /* Set this when we want the fault thread to quit */
>>      bool           fault_thread_quit;
>>  
>> -    bool           have_listen_thread;
>>      QemuThread     listen_thread;
>>  
>>      /* For the kernel to send us notifications */
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d0759694fd..532ee5e4b0 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>>       * got a bad migration state).
>>       */
>>      migration_incoming_state_destroy();
>> -    qemu_loadvm_state_cleanup();
>>  
>>      rcu_unregister_thread();
>> -    mis->have_listen_thread = false;
>>      postcopy_state_set(POSTCOPY_INCOMING_END);
>>  
>>      object_unref(OBJECT(migr));
>> @@ -2130,7 +2128,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>>          return -1;
>>      }
>>  
>> -    mis->have_listen_thread = true;
>>      postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
>>                             postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
>>      trace_loadvm_postcopy_handle_listen("return");
>> @@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)
>>  
>>      trace_qemu_loadvm_state_post_main(ret);
>>  
>> -    if (mis->have_listen_thread) {
>> -        /* Listen thread still going, can't clean up yet */
>> -        return ret;
>> -    }
>
> Hmm, I wonder whether we would still need this.  IIUC it's not only about
> cleanup, but also that when postcopy is involved, dst QEMU postpones doing
> any of the rest in the qemu_loadvm_state_main() call.
>
> E.g. cpu put, aka, cpu_synchronize_all_post_init(), is also done in
> loadvm_postcopy_handle_run_bh() later.
>
> IOW, I'd then expect when this patch applied we'll put cpu twice?
>
> I think the should_send_vmdesc() part is fine, as it returns false for
> postcopy anyway.  However not sure on the cpu post_init above.

I'm not sure either, but there's several ioctls in there, so it's
probably better to skip them. I'll keep the have_listen and adjust the
comment.


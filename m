Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9405BC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regVx-00028y-O0; Mon, 26 Feb 2024 14:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1regVq-00027k-5K
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:19:43 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1regVm-0006ye-1R
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:19:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2ABE61FB66;
 Mon, 26 Feb 2024 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708975171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2N+wplvFW/flGsHEkie+GMAmP4m6s0j0YL00O/a8deM=;
 b=grSnnNI9X8hrq8gNB/PaXUrZTzDzEHVaWPcHsVqpeLcUzwiKofTQ/VGR3VRgb0h8xbDs9M
 DaYXuGRM/G/mmmHITZ/PIP3zYID8r0So8HgKKc8otd2hhQy1EBOaMTWNOBHmXiDWIFoz/m
 sBwJMRnsRI6D145ZbHbjPok/97DfrNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708975171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2N+wplvFW/flGsHEkie+GMAmP4m6s0j0YL00O/a8deM=;
 b=BkGkWMRa8t9TbuEj8cuv7+A1qVdWkRl1TkbLxmnOH3xU/wj3p6f+ZJvPAc4TDW+XNGxBWO
 s0SunZoTaCtRglDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708975171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2N+wplvFW/flGsHEkie+GMAmP4m6s0j0YL00O/a8deM=;
 b=grSnnNI9X8hrq8gNB/PaXUrZTzDzEHVaWPcHsVqpeLcUzwiKofTQ/VGR3VRgb0h8xbDs9M
 DaYXuGRM/G/mmmHITZ/PIP3zYID8r0So8HgKKc8otd2hhQy1EBOaMTWNOBHmXiDWIFoz/m
 sBwJMRnsRI6D145ZbHbjPok/97DfrNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708975171;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2N+wplvFW/flGsHEkie+GMAmP4m6s0j0YL00O/a8deM=;
 b=BkGkWMRa8t9TbuEj8cuv7+A1qVdWkRl1TkbLxmnOH3xU/wj3p6f+ZJvPAc4TDW+XNGxBWO
 s0SunZoTaCtRglDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A72513A58;
 Mon, 26 Feb 2024 19:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v5QtGELk3GXTOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 19:19:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 19/34] migration/multifd: Allow receiving pages
 without packets
In-Reply-To: <Zdw2qilH4DVdmmjB@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-20-farosas@suse.de> <Zdw2qilH4DVdmmjB@x1n>
Date: Mon, 26 Feb 2024 16:19:28 -0300
Message-ID: <875xybav9b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=grSnnNI9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BkGkWMRa
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2ABE61FB66
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Tue, Feb 20, 2024 at 07:41:23PM -0300, Fabiano Rosas wrote:
>> Currently multifd does not need to have knowledge of pages on the
>> receiving side because all the information needed is within the
>> packets that come in the stream.
>> 
>> We're about to add support to fixed-ram migration, which cannot use
>> packets because it expects the ramblock section in the migration file
>> to contain only the guest pages data.
>> 
>> Add a data structure to transfer pages between the ram migration code
>> and the multifd receiving threads.
>> 
>> We don't want to reuse MultiFDPages_t for two reasons:
>> 
>> a) multifd threads don't really need to know about the data they're
>>    receiving.
>> 
>> b) the receiving side has to be stopped to load the pages, which means
>>    we can experiment with larger granularities than page size when
>>    transferring data.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> @Peter: a 'quit' flag cannot be used instead of pending_job. The
>> receiving thread needs know there's no more data coming. If the
>> migration thread sets a 'quit' flag, the multifd thread would see the
>> flag right away and exit.
>
> Hmm.. isn't this exactly what we want?  I'll comment for this inline below.
>
>> The only way is to clear pending_job on the
>> thread and spin once more.
>> ---
>>  migration/file.c    |   1 +
>>  migration/multifd.c | 122 +++++++++++++++++++++++++++++++++++++++++---
>>  migration/multifd.h |  15 ++++++
>>  3 files changed, 131 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/file.c b/migration/file.c
>> index 5d4975f43e..22d052a71f 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -6,6 +6,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "exec/ramblock.h"
>>  #include "qemu/cutils.h"
>>  #include "qapi/error.h"
>>  #include "channel.h"
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 0a5279314d..45a0c7aaa8 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -81,9 +81,15 @@ struct {
>>  
>>  struct {
>>      MultiFDRecvParams *params;
>> +    MultiFDRecvData *data;
>>      /* number of created threads */
>>      int count;
>> -    /* syncs main thread and channels */
>> +    /*
>> +     * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
>> +     *
>> +     * For files: this is only posted at the end of the file load to mark
>> +     *            completion of the load process.
>> +     */
>>      QemuSemaphore sem_sync;
>>      /* global number of generated multifd packets */
>>      uint64_t packet_num;
>> @@ -1110,6 +1116,53 @@ bool multifd_send_setup(void)
>>      return true;
>>  }
>>  
>> +bool multifd_recv(void)
>> +{
>> +    int i;
>> +    static int next_recv_channel;
>> +    MultiFDRecvParams *p = NULL;
>> +    MultiFDRecvData *data = multifd_recv_state->data;
>
> [1]
>
>> +
>> +    /*
>> +     * next_channel can remain from a previous migration that was
>> +     * using more channels, so ensure it doesn't overflow if the
>> +     * limit is lower now.
>> +     */
>> +    next_recv_channel %= migrate_multifd_channels();
>> +    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
>> +        if (multifd_recv_should_exit()) {
>> +            return false;
>> +        }
>> +
>> +        p = &multifd_recv_state->params[i];
>> +
>> +        /*
>> +         * Safe to read atomically without a lock because the flag is
>> +         * only set by this function below. Reading an old value of
>> +         * true is not an issue because it would only send us looking
>> +         * for the next idle channel.
>> +         */
>> +        if (qatomic_read(&p->pending_job) == false) {
>> +            next_recv_channel = (i + 1) % migrate_multifd_channels();
>> +            break;
>> +        }
>> +    }
>
> IIUC you'll need an smp_mb_acquire() here.  The ordering of "reading
> pending_job" and below must be guaranteed, similar to the sender side.
>

I've been thinking about this even on the sending side.

We shouldn't need the barrier here because there's a control flow
dependency on breaking the loop. I think pending_job *must* be read
prior to here, otherwise the program is just wrong. Does that make
sense?

>> +
>> +    assert(!p->data->size);
>> +    multifd_recv_state->data = p->data;
>
> [2]
>
>> +    p->data = data;
>> +
>> +    qatomic_set(&p->pending_job, true);
>
> Then here:
>
>        qatomic_store_release(&p->pending_job, true);

Ok.

>
> Please consider add comment above all acquire/releases pairs like sender
> too.
>
>> +    qemu_sem_post(&p->sem);
>> +
>> +    return true;
>> +}
>> +
>> +MultiFDRecvData *multifd_get_recv_data(void)
>> +{
>> +    return multifd_recv_state->data;
>> +}
>
> Can also use it above [1].
>
> I'm thinking maybe we can do something like:
>
> #define  MULTIFD_RECV_DATA_GLOBAL  (multifd_recv_state->data)
>
> Then we can also use it at [2], and replace multifd_get_recv_data()?
>

We need the helper because multifd_recv_state->data needs to be
accessible from ram.c in patch 24.

>> + static void multifd_recv_terminate_threads(Error *err) { int i; @@
>> -1134,11 +1187,26 @@ static void multifd_recv_terminate_threads(Error
>> *err) MultiFDRecvParams *p = &multifd_recv_state->params[i];
>>  
>>          /*
>> -         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
>> -         * however try to wakeup it without harm in cleanup phase.
>> +         * The migration thread and channels interact differently
>> +         * depending on the presence of packets.
>>           */
>>          if (multifd_use_packets()) {
>> +            /*
>> +             * The channel receives as long as there are packets. When
>> +             * packets end (i.e. MULTIFD_FLAG_SYNC is reached), the
>> +             * channel waits for the migration thread to sync. If the
>> +             * sync never happens, do it here.
>> +             */
>>              qemu_sem_post(&p->sem_sync);
>> +        } else {
>> +            /*
>> +             * The channel waits for the migration thread to give it
>> +             * work. When the migration thread runs out of work, it
>> +             * releases the channel and waits for any pending work to
>> +             * finish. If we reach here (e.g. due to error) before the
>> +             * work runs out, release the channel.
>> +             */
>> +            qemu_sem_post(&p->sem);
>>          }
>>  
>>          /*
>> @@ -1167,6 +1235,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>>      p->c = NULL;
>>      qemu_mutex_destroy(&p->mutex);
>>      qemu_sem_destroy(&p->sem_sync);
>> +    qemu_sem_destroy(&p->sem);
>>      g_free(p->name);
>>      p->name = NULL;
>>      p->packet_len = 0;
>> @@ -1184,6 +1253,8 @@ static void multifd_recv_cleanup_state(void)
>>      qemu_sem_destroy(&multifd_recv_state->sem_sync);
>>      g_free(multifd_recv_state->params);
>>      multifd_recv_state->params = NULL;
>> +    g_free(multifd_recv_state->data);
>> +    multifd_recv_state->data = NULL;
>>      g_free(multifd_recv_state);
>>      multifd_recv_state = NULL;
>>  }
>> @@ -1251,11 +1322,11 @@ static void *multifd_recv_thread(void *opaque)
>>          bool has_data = false;
>>          p->normal_num = 0;
>>  
>> -        if (multifd_recv_should_exit()) {
>> -            break;
>> -        }
>> -
>>          if (use_packets) {
>> +            if (multifd_recv_should_exit()) {
>> +                break;
>> +            }
>> +
>>              ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>>                                             p->packet_len, &local_err);
>>              if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>> @@ -1274,6 +1345,26 @@ static void *multifd_recv_thread(void *opaque)
>>              p->flags &= ~MULTIFD_FLAG_SYNC;
>>              has_data = !!p->normal_num;
>>              qemu_mutex_unlock(&p->mutex);
>> +        } else {
>> +            /*
>> +             * No packets, so we need to wait for the vmstate code to
>> +             * give us work.
>> +             */
>> +            qemu_sem_wait(&p->sem);
>> +
>> +            if (multifd_recv_should_exit()) {
>> +                break;
>> +            }
>> +
>> +            /*
>> +             * Migration thread did not send work, break and signal
>> +             * sem_sync so it knows we're not lagging behind.
>> +             */
>> +            if (!qatomic_read(&p->pending_job)) {
>> +                break;
>> +            }
>
> In reality, this _must_ be true when reaching here, right?  Since AFAIU
> recv side p->sem is posted only in two conditions:
>
>   1) when there is work (pending_job==true)
>   2) when terminating threads (multifd_recv_should_exit==true)

    3) at multifd_recv_sync_main (pending_job state is unknown)

>
> Then if 2) is checked above, I assume 1) must be the case here?
>

The issue is that 'exiting' is global while p->pending_job is
per-channel. Whenever we set 'exiting', there's no guarantee that all
channels have already passed the should_exit check. Some of them could
still have pending_job=true by the time they see the exiting flag.

We queue all the jobs and immediately call recv_sync_main. It doesn't
matter that all jobs are queued and that we know for sure the work is
done. What matters is that each channel gets to finish its work before
it sees the exit flag. And that depends on checking pending_job.

>> +
>> +            has_data = !!p->data->size;
>>          }
>>  
>>          if (has_data) {
>> @@ -1288,9 +1379,17 @@ static void *multifd_recv_thread(void *opaque)
>>                  qemu_sem_post(&multifd_recv_state->sem_sync);
>>                  qemu_sem_wait(&p->sem_sync);
>>              }
>> +        } else {
>> +            p->total_normal_pages += p->data->size / qemu_target_page_size();
>> +            p->data->size = 0;
>> +            qatomic_set(&p->pending_job, false);
>
> I think it needs to be:
>
>   qatomic_store_release(&p->pending_job, false);
>
> ?
>
> So as to guarantee when the other side sees pending_job==false, size must
> already have been reset.
>

Ok.

>>          }
>>      }
>>  
>> +    if (!use_packets) {
>> +        qemu_sem_post(&p->sem_sync);
>> +    }
>> +
>>      if (local_err) {
>>          multifd_recv_terminate_threads(local_err);
>>          error_free(local_err);
>> @@ -1320,6 +1419,10 @@ int multifd_recv_setup(Error **errp)
>>      thread_count = migrate_multifd_channels();
>>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>>      multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>> +
>> +    multifd_recv_state->data = g_new0(MultiFDRecvData, 1);
>> +    multifd_recv_state->data->size = 0;
>> +
>>      qatomic_set(&multifd_recv_state->count, 0);
>>      qatomic_set(&multifd_recv_state->exiting, 0);
>>      qemu_sem_init(&multifd_recv_state->sem_sync, 0);
>> @@ -1330,8 +1433,13 @@ int multifd_recv_setup(Error **errp)
>>  
>>          qemu_mutex_init(&p->mutex);
>>          qemu_sem_init(&p->sem_sync, 0);
>> +        qemu_sem_init(&p->sem, 0);
>> +        p->pending_job = false;
>>          p->id = i;
>>  
>> +        p->data = g_new0(MultiFDRecvData, 1);
>> +        p->data->size = 0;
>> +
>>          if (use_packets) {
>>              p->packet_len = sizeof(MultiFDPacket_t)
>>                  + sizeof(uint64_t) * page_count;
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 9a6a7a72df..19188815a3 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -13,6 +13,8 @@
>>  #ifndef QEMU_MIGRATION_MULTIFD_H
>>  #define QEMU_MIGRATION_MULTIFD_H
>>  
>> +typedef struct MultiFDRecvData MultiFDRecvData;
>> +
>>  bool multifd_send_setup(void);
>>  void multifd_send_shutdown(void);
>>  int multifd_recv_setup(Error **errp);
>> @@ -23,6 +25,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>  void multifd_recv_sync_main(void);
>>  int multifd_send_sync_main(void);
>>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>> +bool multifd_recv(void);
>> +MultiFDRecvData *multifd_get_recv_data(void);
>>  
>>  /* Multifd Compression flags */
>>  #define MULTIFD_FLAG_SYNC (1 << 0)
>> @@ -63,6 +67,13 @@ typedef struct {
>>      RAMBlock *block;
>>  } MultiFDPages_t;
>>  
>> +struct MultiFDRecvData {
>> +    void *opaque;
>> +    size_t size;
>> +    /* for preadv */
>> +    off_t file_offset;
>> +};
>> +
>>  typedef struct {
>>      /* Fields are only written at creating/deletion time */
>>      /* No lock required for them, they are read only */
>> @@ -154,6 +165,8 @@ typedef struct {
>>  
>>      /* syncs main thread and channels */
>>      QemuSemaphore sem_sync;
>> +    /* sem where to wait for more work */
>> +    QemuSemaphore sem;
>>  
>>      /* this mutex protects the following parameters */
>>      QemuMutex mutex;
>> @@ -163,6 +176,8 @@ typedef struct {
>>      uint32_t flags;
>>      /* global number of generated multifd packets */
>>      uint64_t packet_num;
>> +    int pending_job;
>> +    MultiFDRecvData *data;
>>  
>>      /* thread local variables. No locking required */
>>  
>> -- 
>> 2.35.3
>> 


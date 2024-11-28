Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CBDD69102
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGdNY-00082U-I2; Thu, 28 Nov 2024 07:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdNM-00082D-TO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:12:05 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdNK-0006xo-GJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:12:04 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tGdNG-00000002v0J-2btJ; Thu, 28 Nov 2024 13:11:58 +0100
Message-ID: <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
Date: Thu, 28 Nov 2024 13:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 28.11.2024 11:26, Avihai Horon wrote:
> 
> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Some drivers might want to make use of auxiliary helper threads during VM
>> state loading, for example to make sure that their blocking (sync) I/O
>> operations don't block the rest of the migration process.
>>
>> Add a migration core managed thread pool to facilitate this use case.
>>
>> The migration core will wait for these threads to finish before
>> (re)starting the VM at destination.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/migration/misc.h |  3 ++
>>   include/qemu/typedefs.h  |  1 +
>>   migration/savevm.c       | 77 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 81 insertions(+)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 804eb23c0607..c92ca018ab3b 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
>>   /* migration/block.c */
>>
>>   AnnounceParameters *migrate_announce_params(void);
>> +
>>   /* migration/savevm.c */
>>
>>   void dump_vmstate_json_to_file(FILE *out_fp);
>> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
>> +                                   void *opaque);
>>
>>   /* migration/migration.c */
>>   void migration_object_init(void);
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 3d84efcac47a..8c8ea5c2840d 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
>>    * Function types
>>    */
>>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>> +typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
>>
>>   #endif /* QEMU_TYPEDEFS_H */
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 1f58a2fa54ae..6ea9054c4083 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -54,6 +54,7 @@
>>   #include "qemu/job.h"
>>   #include "qemu/main-loop.h"
>>   #include "block/snapshot.h"
>> +#include "block/thread-pool.h"
>>   #include "qemu/cutils.h"
>>   #include "io/channel-buffer.h"
>>   #include "io/channel-file.h"
>> @@ -71,6 +72,10 @@
>>
>>   const unsigned int postcopy_ram_discard_version;
>>
>> +static ThreadPool *load_threads;
>> +static int load_threads_ret;
>> +static bool load_threads_abort;
>> +
>>   /* Subcommands for QEMU_VM_COMMAND */
>>   enum qemu_vm_cmd {
>>       MIG_CMD_INVALID = 0,   /* Must be 0 */
>> @@ -2788,6 +2793,12 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>>       int ret;
>>
>>       trace_loadvm_state_setup();
>> +
>> +    assert(!load_threads);
>> +    load_threads = thread_pool_new();
>> +    load_threads_ret = 0;
>> +    load_threads_abort = false;
>> +
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>           if (!se->ops || !se->ops->load_setup) {
>>               continue;
>> @@ -2806,19 +2817,72 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>>               return ret;
>>           }
>>       }
>> +
>> +    return 0;
>> +}
>> +
>> +struct LoadThreadData {
>> +    MigrationLoadThread function;
>> +    void *opaque;
>> +};
>> +
>> +static int qemu_loadvm_load_thread(void *thread_opaque)
>> +{
>> +    struct LoadThreadData *data = thread_opaque;
>> +    int ret;
>> +
>> +    ret = data->function(&load_threads_abort, data->opaque);
>> +    if (ret && !qatomic_read(&load_threads_ret)) {
>> +        /*
>> +         * Racy with the above read but that's okay - which thread error
>> +         * return we report is purely arbitrary anyway.
>> +         */
>> +        qatomic_set(&load_threads_ret, ret);
>> +    }
> 
> Can we use cmpxchg instead? E.g.:
> 
> if (ret) {
>      qatomic_cmpxchg(&load_threads_ret, 0, ret);
> }

cmpxchg always forces sequentially consistent ordering
while qatomic_read() and qatomic_set() have relaxed ordering.

As the comment above describes, there's no need for sequential
consistency since which thread error is returned is arbitrary
anyway.

>> +
>>       return 0;
>>   }
>>
>> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
>> +                                   void *opaque)
>> +{
>> +    struct LoadThreadData *data;
>> +
>> +    /* We only set it from this thread so it's okay to read it directly */
>> +    assert(!load_threads_abort);
>> +
>> +    data = g_new(struct LoadThreadData, 1);
>> +    data->function = function;
>> +    data->opaque = opaque;
>> +
>> +    thread_pool_submit(load_threads, qemu_loadvm_load_thread,
>> +                       data, g_free);
>> +    thread_pool_adjust_max_threads_to_work(load_threads);
>> +}
>> +
>>   void qemu_loadvm_state_cleanup(void)
>>   {
>>       SaveStateEntry *se;
>>
>>       trace_loadvm_state_cleanup();
>> +
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>           if (se->ops && se->ops->load_cleanup) {
>>               se->ops->load_cleanup(se->opaque);
>>           }
>>       }
>> +
>> +    /*
>> +     * We might be called even without earlier qemu_loadvm_state_setup()
>> +     * call if qemu_loadvm_state() fails very early.
>> +     */
>> +    if (load_threads) {
>> +        qatomic_set(&load_threads_abort, true);
>> +        bql_unlock(); /* Load threads might be waiting for BQL */
>> +        thread_pool_wait(load_threads);
>> +        bql_lock();
>> +        g_clear_pointer(&load_threads, thread_pool_free);
> 
> Since thread_pool_free() also waits for pending jobs before returning, can we drop the explicit thread_pool_wait()? E.g.:
> 
> qatomic_set(&load_threads_abort, true);
> bql_unlock(); /* Load threads might be waiting for BQL */
> g_clear_pointer(&load_threads, thread_pool_free);
> bql_lock();

If we document that thread_pool_free() has also wait semantics
as Cédric has suggested then we can indeed avoid the explicit
wait on cleanup.
  
> Thanks.

Thanks,
Maciej



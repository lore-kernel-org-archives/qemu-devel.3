Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59419ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snilt-0003mY-9r; Mon, 09 Sep 2024 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snilq-0003d8-TX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:05:50 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snilp-0001lz-01
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:05:50 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1snilg-0006RE-Ur; Mon, 09 Sep 2024 20:05:40 +0200
Message-ID: <4a4d4429-84a5-4ca0-be87-db6354405eb5@maciej.szmigiero.name>
Date: Mon, 9 Sep 2024 20:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
 <ec2b1687-5e53-4c1c-b1a5-24c38512daa0@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ec2b1687-5e53-4c1c-b1a5-24c38512daa0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On 5.09.2024 17:13, Avihai Horon wrote:
> 
> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> load_finish SaveVMHandler allows migration code to poll whether
>> a device-specific asynchronous device state loading operation had finished.
>>
>> In order to avoid calling this handler needlessly the device is supposed
>> to notify the migration code of its possible readiness via a call to
>> qemu_loadvm_load_finish_ready_broadcast() while holding
>> qemu_loadvm_load_finish_ready_lock.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/migration/register.h | 21 +++++++++++++++
>>   migration/migration.c        |  6 +++++
>>   migration/migration.h        |  3 +++
>>   migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
>>   migration/savevm.h           |  4 +++
>>   5 files changed, 86 insertions(+)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 4a578f140713..44d8cf5192ae 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
>>       int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
>>                                Error **errp);
>>
>> +    /**
>> +     * @load_finish
>> +     *
>> +     * Poll whether all asynchronous device state loading had finished.
>> +     * Not called on the load failure path.
>> +     *
>> +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
>> +     *
>> +     * If this method signals "not ready" then it might not be called
>> +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
>> +     * while holding qemu_loadvm_load_finish_ready_lock.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @is_finished: whether the loading had finished (output parameter)
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     * It's not an error that the loading still hasn't finished.
>> +     */
>> +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
>> +
>>       /**
>>        * @load_setup
>>        *
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dea06d57732..d61e7b055e07 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -259,6 +259,9 @@ void migration_object_init(void)
>>
>>       current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>>
>> +    qemu_mutex_init(&current_incoming->load_finish_ready_mutex);
>> +    qemu_cond_init(&current_incoming->load_finish_ready_cond);
>> +
>>       migration_object_check(current_migration, &error_fatal);
>>
>>       ram_mig_init();
>> @@ -410,6 +413,9 @@ void migration_incoming_state_destroy(void)
>>           mis->postcopy_qemufile_dst = NULL;
>>       }
>>
>> +    qemu_mutex_destroy(&mis->load_finish_ready_mutex);
>> +    qemu_cond_destroy(&mis->load_finish_ready_cond);
>> +
>>       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>   }
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 38aa1402d516..4e2443e6c8ec 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -230,6 +230,9 @@ struct MigrationIncomingState {
>>
>>       /* Do exit on incoming migration failure */
>>       bool exit_on_error;
>> +
>> +    QemuCond load_finish_ready_cond;
>> +    QemuMutex load_finish_ready_mutex;
>>   };
>>
>>   MigrationIncomingState *migration_incoming_get_current(void);
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 3fde5ca8c26b..33c9200d1e78 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3022,6 +3022,37 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return ret;
>>       }
>>
>> +    qemu_loadvm_load_finish_ready_lock();
>> +    while (!ret) { /* Don't call load_finish() handlers on the load failure path */
>> +        bool all_ready = true;
> 
> Nit: Maybe rename all_ready to all_finished to be consistent with load_finish() terminology? Same for this_ready.

Will rename it accordingly.

>> +        SaveStateEntry *se = NULL;
>> +
>> +        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +            bool this_ready;
>> +
>> +            if (!se->ops || !se->ops->load_finish) {
>> +                continue;
>> +            }
>> +
>> +            ret = se->ops->load_finish(se->opaque, &this_ready, &local_err);
>> +            if (ret) {
>> +                error_report_err(local_err);
>> +
>> +                qemu_loadvm_load_finish_ready_unlock();
>> +                return -EINVAL;
>> +            } else if (!this_ready) {
>> +                all_ready = false;
>> +            }
>> +        }
>> +
>> +        if (all_ready) {
>> +            break;
>> +        }
>> +
>> +        qemu_cond_wait(&mis->load_finish_ready_cond, &mis->load_finish_ready_mutex);
>> +    }
>> +    qemu_loadvm_load_finish_ready_unlock();
>> +
>>       if (ret == 0) {
>>           ret = qemu_file_get_error(f);
>>       }
>> @@ -3126,6 +3157,27 @@ int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
>>       return 0;
>>   }
>>
>> +void qemu_loadvm_load_finish_ready_lock(void)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    qemu_mutex_lock(&mis->load_finish_ready_mutex);
>> +}
>> +
>> +void qemu_loadvm_load_finish_ready_unlock(void)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    qemu_mutex_unlock(&mis->load_finish_ready_mutex);
>> +}
>> +
>> +void qemu_loadvm_load_finish_ready_broadcast(void)
>> +{
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    qemu_cond_broadcast(&mis->load_finish_ready_cond);
> 
> Do we need a broadcast? isn't signal enough as we only have one waiter thread?

Currently, there's just one waiter but looking at the relatively small
implementation difference between pthread_cond_signal() and
pthread_cond_broadcast() I'm not sure whether it is worth changing it
it to _signal() and not having a possibility of signalling multiple
waiters upfront.

> Thanks.

Thanks,
Maciej



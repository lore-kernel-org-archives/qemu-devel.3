Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61F0ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snin6-0001al-U6; Mon, 09 Sep 2024 14:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snin3-0001HH-Ik
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:06 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snin0-0001uF-If
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:05 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1snimr-0006S6-VZ; Mon, 09 Sep 2024 20:06:54 +0200
Message-ID: <ad637771-3eff-4492-b3a8-e72bb1e91551@maciej.szmigiero.name>
Date: Mon, 9 Sep 2024 20:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] vfio/migration: Multifd device state transfer
 support - receive side
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
 <12ebbb56-c2a7-42d0-8dad-9b459a490c39@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <12ebbb56-c2a7-42d0-8dad-9b459a490c39@nvidia.com>
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

On 9.09.2024 10:55, Avihai Horon wrote:
> 
> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> The multifd received data needs to be reassembled since device state
>> packets sent via different multifd channels can arrive out-of-order.
>>
>> Therefore, each VFIO device state packet carries a header indicating
>> its position in the stream.
>>
>> The last such VFIO device state packet should have
>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config
>> state.
>>
>> Since it's important to finish loading device state transferred via
>> the main migration channel (via save_live_iterate handler) before
>> starting loading the data asynchronously transferred via multifd
>> a new VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE flag is introduced to
>> mark the end of the main migration channel data.
>>
>> The device state loading process waits until that flag is seen before
>> commencing loading of the multifd-transferred device state.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c           | 338 +++++++++++++++++++++++++++++++++-
>>   hw/vfio/pci.c                 |   2 +
>>   hw/vfio/trace-events          |   9 +-
>>   include/hw/vfio/vfio-common.h |  17 ++
>>   4 files changed, 362 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 24679d8c5034..57c1542528dc 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/vfio.h>
>>   #include <sys/ioctl.h>
>>
>> +#include "io/channel-buffer.h"
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "migration/misc.h"
>> @@ -47,6 +48,7 @@
>>   #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>>   #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>>   #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE    (0xffffffffef100006ULL)
>>
>>   /*
>>    * This is an arbitrary size based on migration of mlx5 devices, where typically
>> @@ -55,6 +57,15 @@
>>    */
>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>
>> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
>> +
>> +typedef struct VFIODeviceStatePacket {
>> +    uint32_t version;
>> +    uint32_t idx;
>> +    uint32_t flags;
>> +    uint8_t data[0];
>> +} QEMU_PACKED VFIODeviceStatePacket;
>> +
>>   static int64_t bytes_transferred;
>>
>>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
>> @@ -254,6 +265,188 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>       return ret;
>>   }
>>
>> +typedef struct LoadedBuffer {
>> +    bool is_present;
>> +    char *data;
>> +    size_t len;
>> +} LoadedBuffer;
> 
> Maybe rename LoadedBuffer to a more specific name, like VFIOStateBuffer?

Will do.

> I also feel like LoadedBuffer deserves a separate commit.
> Plus, I think it will be good to add a full API for this, that wraps the g_array_* calls and holds the extra members.
> E.g, VFIOStateBuffer, VFIOStateArray (will hold load_buf_idx, load_buf_idx_last, etc.), vfio_state_array_destroy(), vfio_state_array_alloc(), vfio_state_array_get(), etc...
> IMHO, this will make it clearer.

Will think about wrapping GArray accesses in separate methods,
however wrapping a single line GArray call in a separate function
normally would seem a bit excessive.

>> +
>> +static void loaded_buffer_clear(gpointer data)
>> +{
>> +    LoadedBuffer *lb = data;
>> +
>> +    if (!lb->is_present) {
>> +        return;
>> +    }
>> +
>> +    g_clear_pointer(&lb->data, g_free);
>> +    lb->is_present = false;
>> +}
>> +
>> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>> +                                  Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> 
> Move lock to where it's needed? I.e., after trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx)

It's a declaration of a new variable so I guess it should always be
at the top of the code block in the kernel / QEMU code style?

Also, these checks below are very unlikely to fail and even if they do,
I doubt a failed migration due to bit stream corruption is a scenario
worth optimizing run time performance for.

>> +    LoadedBuffer *lb;
>> +
>> +    if (data_size < sizeof(*packet)) {
>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>> +                   data_size, sizeof(*packet));
>> +        return -1;
>> +    }
>> +
>> +    if (packet->version != 0) {
>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>> +                   packet->version);
>> +        return -1;
>> +    }
>> +
>> +    if (packet->idx == UINT32_MAX) {
>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>> +                   packet->idx);
>> +        return -1;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
>> +
>> +    /* config state packet should be the last one in the stream */
>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>> +        migration->load_buf_idx_last = packet->idx;
>> +    }
>> +
>> +    assert(migration->load_bufs);
>> +    if (packet->idx >= migration->load_bufs->len) {
>> +        g_array_set_size(migration->load_bufs, packet->idx + 1);
>> +    }
>> +
>> +    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
>> +    if (lb->is_present) {
>> +        error_setg(errp, "state buffer %" PRIu32 " already filled", packet->idx);
>> +        return -1;
>> +    }
>> +
>> +    assert(packet->idx >= migration->load_buf_idx);
>> +
>> +    migration->load_buf_queued_pending_buffers++;
>> +    if (migration->load_buf_queued_pending_buffers >
>> +        vbasedev->migration_max_queued_buffers) {
>> +        error_setg(errp,
>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>> +        return -1;
>> +    }
> 
> I feel like max_queued_buffers accounting/checking/configuration should be split to a separate patch that will come after this patch.
> Also, should we count bytes instead of buffers? Current buffer size is 1MB but this could change, and the normal user should not care or know what is the buffer size.
> So maybe rename to migration_max_pending_bytes or such?

Since it's Peter that asked for this limit to be introduced in the first place
I would like to ask him what his preference here.

@Peter: max queued buffers or bytes?

>> +
>> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>> +    lb->len = data_size - sizeof(*packet);
>> +    lb->is_present = true;
>> +
>> +    qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
> 
> There is only one thread waiting, shouldn't signal be enough?

Will change this to _signal() since it clearly doesn't
make sense to have a future-proof API here - it's an
implementation detail.

>> +
>> +    return 0;
>> +}
>> +
>> +static void *vfio_load_bufs_thread(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    Error **errp = &migration->load_bufs_thread_errp;
>> +    g_autoptr(QemuLockable) locker = qemu_lockable_auto_lock(
>> +        QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));
> 
> Any special reason to use QemuLockable?

I prefer automatic lock management (RAII-like) for the same reason
I prefer automatic memory management: it makes it much harder to
forget to unlock the lock (or free memory) in some error path.

That's the reason these primitives were introduced in QEMU in the
first place (apparently modeled after its Glib equivalents) and
why these are being (slowly) introduced to Linux kernel too.

>> +    LoadedBuffer *lb;
>> +
>> +    while (!migration->load_bufs_device_ready &&
>> +           !migration->load_bufs_thread_want_exit) {
>> +        qemu_cond_wait(&migration->load_bufs_device_ready_cond, &migration->load_bufs_mutex);
>> +    }
>> +
>> +    while (!migration->load_bufs_thread_want_exit) {
>> +        bool starved;
>> +        ssize_t ret;
>> +
>> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
>> +
>> +        if (migration->load_buf_idx >= migration->load_bufs->len) {
>> +            assert(migration->load_buf_idx == migration->load_bufs->len);
>> +            starved = true;
>> +        } else {
>> +            lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
>> +            starved = !lb->is_present;
>> +        }
>> +
>> +        if (starved) {
>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name, migration->load_buf_idx);
>> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond, &migration->load_bufs_mutex);
>> +            continue;
>> +        }
>> +
>> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
>> +            break;
>> +        }
>> +
>> +        if (migration->load_buf_idx == 0) {
>> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
>> +        }
>> +
>> +        if (lb->len) {
>> +            g_autofree char *buf = NULL;
>> +            size_t buf_len;
>> +            int errno_save;
>> +
>> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>> +                                                           migration->load_buf_idx);
>> +
>> +            /* lb might become re-allocated when we drop the lock */
>> +            buf = g_steal_pointer(&lb->data);
>> +            buf_len = lb->len;
>> +
>> +            /* Loading data to the device takes a while, drop the lock during this process */
>> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
>> +            ret = write(migration->data_fd, buf, buf_len);
>> +            errno_save = errno;
>> +            qemu_mutex_lock(&migration->load_bufs_mutex);
>> +
>> +            if (ret < 0) {
>> +                error_setg(errp, "write to state buffer %" PRIu32 " failed with %d",
>> +                           migration->load_buf_idx, errno_save);
>> +                break;
>> +            } else if (ret < buf_len) {
>> +                error_setg(errp, "write to state buffer %" PRIu32 " incomplete %zd / %zu",
>> +                           migration->load_buf_idx, ret, buf_len);
>> +                break;
>> +            }
>> +
>> +            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>> +                                                         migration->load_buf_idx);
>> +        }
>> +
>> +        assert(migration->load_buf_queued_pending_buffers > 0);
>> +        migration->load_buf_queued_pending_buffers--;
>> +
>> +        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>> +        }
>> +
>> +        migration->load_buf_idx++;
>> +    }
>> +
>> +    if (migration->load_bufs_thread_want_exit &&
>> +        !*errp) {
>> +        error_setg(errp, "load bufs thread asked to quit");
>> +    }
>> +
>> +    g_clear_pointer(&locker, qemu_lockable_auto_unlock);
>> +
>> +    qemu_loadvm_load_finish_ready_lock();
>> +    migration->load_bufs_thread_finished = true;
>> +    qemu_loadvm_load_finish_ready_broadcast();
>> +    qemu_loadvm_load_finish_ready_unlock();
>> +
>> +    return NULL;
>> +}
>> +
>>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>>                                            Error **errp)
>>   {
>> @@ -285,6 +478,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       uint64_t data;
>>
>> +    trace_vfio_load_device_config_state_start(vbasedev->name);
> 
> Maybe split this and below trace_vfio_load_device_config_state_end to a separate patch?

I guess you mean to add these trace points in a separate patch?
Can do.

>> +
>>       if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
>>           int ret;
>>
>> @@ -303,7 +498,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>           return -EINVAL;
>>       }
>>
>> -    trace_vfio_load_device_config_state(vbasedev->name);
>> +    trace_vfio_load_device_config_state_end(vbasedev->name);
>>       return qemu_file_get_error(f);
>>   }
>>
>> @@ -687,16 +882,70 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                   vbasedev->migration->device_state, errp);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    assert(!migration->load_bufs);
>> +    migration->load_bufs = g_array_new(FALSE, TRUE, sizeof(LoadedBuffer));
>> +    g_array_set_clear_func(migration->load_bufs, loaded_buffer_clear);
>> +
>> +    qemu_mutex_init(&migration->load_bufs_mutex);
>> +
>> +    migration->load_bufs_device_ready = false;
>> +    qemu_cond_init(&migration->load_bufs_device_ready_cond);
>> +
>> +    migration->load_buf_idx = 0;
>> +    migration->load_buf_idx_last = UINT32_MAX;
>> +    migration->load_buf_queued_pending_buffers = 0;
>> +    qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
>> +
>> +    migration->config_state_loaded_to_dev = false;
>> +
>> +    assert(!migration->load_bufs_thread_started);
> 
> Maybe do all these allocations (and de-allocations) only if multifd device state is supported and enabled?
> Extracting this to its own function could also be good.

Sure, will try to avoid unnecessarily allocating multifd device state
related things if this functionality is unavailable anyway.
  
>>
>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                    vbasedev->migration->device_state, errp);
>> +    migration->load_bufs_thread_finished = false;
>> +    migration->load_bufs_thread_want_exit = false;
>> +    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
>> +                       vfio_load_bufs_thread, opaque, QEMU_THREAD_JOINABLE);
> 
> The device state save threads are manged by migration core thread pool. Don't we want to apply the same thread management scheme for the load flow as well?

I think that (in contrast with the device state saving threads)
the buffer loading / reordering thread is an implementation detail
of the VFIO driver, so I don't think it really makes sense for multifd code
to manage it.

>> +
>> +    migration->load_bufs_thread_started = true;
>> +
>> +    return 0;
>>   }
>>
>>   static int vfio_load_cleanup(void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration->load_bufs_thread_started) {
>> +        qemu_mutex_lock(&migration->load_bufs_mutex);
>> +        migration->load_bufs_thread_want_exit = true;
>> +        qemu_mutex_unlock(&migration->load_bufs_mutex);
>> +
>> +        qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
>> +        qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
>> +
>> +        qemu_thread_join(&migration->load_bufs_thread);
>> +
>> +        assert(migration->load_bufs_thread_finished);
>> +
>> +        migration->load_bufs_thread_started = false;
>> +    }
>>
>>       vfio_migration_cleanup(vbasedev);
>> +
>> +    g_clear_pointer(&migration->load_bufs, g_array_unref);
>> +    qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
>> +    qemu_cond_destroy(&migration->load_bufs_device_ready_cond);
>> +    qemu_mutex_destroy(&migration->load_bufs_mutex);
>> +
>>       trace_vfio_load_cleanup(vbasedev->name);
>>
>>       return 0;
>> @@ -705,6 +954,7 @@ static int vfio_load_cleanup(void *opaque)
>>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       int ret = 0;
>>       uint64_t data;
>>
>> @@ -716,6 +966,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>           switch (data) {
>>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>>           {
>> +            migration->config_state_loaded_to_dev = true;
>>               return vfio_load_device_config_state(f, opaque);
>>           }
>>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>> @@ -742,6 +993,15 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>               }
>>               break;
>>           }
>> +        case VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE:
>> +        {
>> +            QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>> +
>> +            migration->load_bufs_device_ready = true;
>> +            qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
>> +
>> +            break;
>> +        }
>>           case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
>>           {
>>               if (!vfio_precopy_supported(vbasedev) ||
>> @@ -774,6 +1034,76 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>>       return ret;
>>   }
>>
>> +static int vfio_load_finish(void *opaque, bool *is_finished, Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    g_autoptr(QemuLockable) locker = NULL;
> 
> Any special reason to use QemuLockable?

The same reason as for the automatic locking above.
  
> Thanks.
> 

Thanks,
Maciej



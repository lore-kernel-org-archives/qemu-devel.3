Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 23:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL9JR-0008BN-0R; Tue, 10 Dec 2024 18:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tL9JK-0007ve-MT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 18:06:36 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tL9JH-0008AE-5x
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 18:06:34 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tL9JD-00000003Z3P-2dV7; Wed, 11 Dec 2024 00:06:27 +0100
Message-ID: <9106d15e-3ff5-4d42-880d-0de70a4caa1c@maciej.szmigiero.name>
Date: Wed, 11 Dec 2024 00:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
 <579c8131-0554-4ea4-b222-36a8a350df02@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <579c8131-0554-4ea4-b222-36a8a350df02@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Avihai,

On 9.12.2024 10:13, Avihai Horon wrote:
> Hi Maciej,
> 
> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> The multifd received data needs to be reassembled since device state
>> packets sent via different multifd channels can arrive out-of-order.
>>
>> Therefore, each VFIO device state packet carries a header indicating its
>> position in the stream.
>>
>> The last such VFIO device state packet should have
>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>
>> Since it's important to finish loading device state transferred via the
>> main migration channel (via save_live_iterate SaveVMHandler) before
>> starting loading the data asynchronously transferred via multifd the thread
>> doing the actual loading of the multifd transferred data is only started
>> from switchover_start SaveVMHandler.
>>
>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>>
>> This sub-command is only sent after all save_live_iterate data have already
>> been posted so it is safe to commence loading of the multifd-transferred
>> device state upon receiving it - loading of save_live_iterate data happens
>> synchronously in the main migration thread (much like the processing of
>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>> processed all the proceeding data must have already been loaded.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c           | 402 ++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c                 |   2 +
>>   hw/vfio/trace-events          |   6 +
>>   include/hw/vfio/vfio-common.h |  19 ++
>>   4 files changed, 429 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 683f2ae98d5e..b54879fe6209 100644
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
>> @@ -55,6 +56,15 @@
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
>> @@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>       return ret;
>>   }
>>
>> +typedef struct VFIOStateBuffer {
>> +    bool is_present;
>> +    char *data;
>> +    size_t len;
>> +} VFIOStateBuffer;
>> +
>> +static void vfio_state_buffer_clear(gpointer data)
>> +{
>> +    VFIOStateBuffer *lb = data;
>> +
>> +    if (!lb->is_present) {
>> +        return;
>> +    }
>> +
>> +    g_clear_pointer(&lb->data, g_free);
>> +    lb->is_present = false;
>> +}
>> +
>> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
>> +{
>> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
>> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
>> +}
>> +
>> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
>> +{
>> +    g_clear_pointer(&bufs->array, g_array_unref);
>> +}
>> +
>> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
>> +{
>> +    assert(bufs->array);
>> +}
>> +
>> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
>> +{
>> +    return bufs->array->len;
>> +}
>> +
>> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
>> +{
>> +    g_array_set_size(bufs->array, size);
>> +}
> 
> The above three functions seem a bit too specific.

You asked to have "full API for this [VFIOStateBuffers - MSS],
that wraps the g_array_* calls and holds the extra members"
during the review of the previous version of this patch set so here it is.

> 
> How about:
> Instead of size_set and assert_init, introduce a vfio_state_buffers_insert() function that handles buffer insertion to the array from the validated packet.
> 
> Instead of size_get, introduce vfio_state_buffers_get() that handles the array length and is_present checks.
> We can also add a vfio_state_buffer_write() function that handles writing the buffer to the device.
> 
> IMHO this will also make vfio_load_state_buffer() and vfio_load_bufs_thread(), which are rather long, clearer.

I think it would be even nicer to keep vfio_state_buffer_*() methods as thin wrappers
(low level API) and introduce intermediate API doing more or less what you have
described above to simplify vfio_load_bufs_thread() (and possibly vfio_load_state_buffer() too).

>> +
>> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>> +{
>> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>> +}
>> +
>> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>> +                                  Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>> +    VFIOStateBuffer *lb;
>> +
>> +    /*
>> +     * Holding BQL here would violate the lock order and can cause
>> +     * a deadlock once we attempt to lock load_bufs_mutex below.
>> +     */
>> +    assert(!bql_locked());
>> +
>> +    if (!migration->multifd_transfer) {
>> +        error_setg(errp,
>> +                   "got device state packet but not doing multifd transfer");
>> +        return -1;
>> +    }
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
>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>> +
>> +    /* config state packet should be the last one in the stream */
>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>> +        migration->load_buf_idx_last = packet->idx;
>> +    }
>> +
>> +    vfio_state_buffers_assert_init(&migration->load_bufs);
>> +    if (packet->idx >= vfio_state_buffers_size_get(&migration->load_bufs)) {
>> +        vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
>> +    }
>> +
>> +    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
>> +    if (lb->is_present) {
>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>> +                   packet->idx);
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
> Copying my question from v2:
> 
> Should we count bytes instead of buffers? Current buffer size is 1MB but this could change, and the normal user should not care or know what is the buffer size.
> So maybe rename to migration_max_pending_bytes or such?
> 
> And Maciej replied:
> 
> Since it's Peter that asked for this limit to be introduced in the first place
> I would like to ask him what his preference here.
> @Peter: max queued buffers or bytes?
> 
> So Peter, what's your opinion here?
> 
>> +
>> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>> +    lb->len = data_size - sizeof(*packet);
>> +    lb->is_present = true;
>> +
>> +    qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
>> +
>> +    return 0;
>> +}
>> +
>> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>> +
>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOStateBuffer *lb;
>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>> +    QEMUFile *f_out = NULL, *f_in = NULL;
>> +    uint64_t mig_header;
>> +    int ret;
>> +
>> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
>> +    lb = vfio_state_buffers_at(&migration->load_bufs, migration->load_buf_idx);
>> +    assert(lb->is_present);
>> +
>> +    bioc = qio_channel_buffer_new(lb->len);
>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
>> +
>> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
>> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
>> +
>> +    ret = qemu_fflush(f_out);
>> +    if (ret) {
>> +        g_clear_pointer(&f_out, qemu_fclose);
>> +        return ret;
>> +    }
>> +
>> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
>> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
>> +
>> +    mig_header = qemu_get_be64(f_in);
>> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
>> +        g_clear_pointer(&f_out, qemu_fclose);
>> +        g_clear_pointer(&f_in, qemu_fclose);
>> +        return -EINVAL;
>> +    }
>> +
>> +    bql_lock();
>> +    ret = vfio_load_device_config_state(f_in, vbasedev);
>> +    bql_unlock();
>> +
>> +    g_clear_pointer(&f_out, qemu_fclose);
>> +    g_clear_pointer(&f_in, qemu_fclose);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
>> +                                             bool *abort_flag)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    return migration->load_bufs_thread_want_exit || qatomic_read(abort_flag);
>> +}
>> +
>> +static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> 
> Move QEMU_LOCK_GUARD() below the local var declaration?
> I usually don't expect to see mutex lockings as part of local var declaration block, which makes it easy to miss when reading the code.
> (Although QEMU_LOCK_GUARD declares a local variable under the hood, it's implicit and not visible to the user).

I guess you mean moving it..

>> +    int ret;

^ ..here.

Will do.

>> +    assert(migration->load_bufs_thread_running);
>> +
>> +    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
>> +        VFIOStateBuffer *lb;
>> +        guint bufs_len;
>> +        bool starved;
>> +
>> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
>> +
>> +        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
>> +        if (migration->load_buf_idx >= bufs_len) {
>> +            assert(migration->load_buf_idx == bufs_len);
>> +            starved = true;
>> +        } else {
>> +            lb = vfio_state_buffers_at(&migration->load_bufs,
>> +                                       migration->load_buf_idx);
>> +            starved = !lb->is_present;
>> +        }
>> +
>> +        if (starved) {
>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>> +                                                        migration->load_buf_idx);
>> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
>> +                           &migration->load_bufs_mutex);
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
>> +            ssize_t wr_ret;
>> +            int errno_save;
>> +
>> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>> +                                                           migration->load_buf_idx);
>> +
>> +            /* lb might become re-allocated when we drop the lock */
>> +            buf = g_steal_pointer(&lb->data);
>> +            buf_len = lb->len;
>> +
>> +            /*
>> +             * Loading data to the device takes a while,
>> +             * drop the lock during this process.
>> +             */
>> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
>> +            wr_ret = write(migration->data_fd, buf, buf_len);
>> +            errno_save = errno;
>> +            qemu_mutex_lock(&migration->load_bufs_mutex);
>> +
>> +            if (wr_ret < 0) {
>> +                ret = -errno_save;
>> +                goto ret_signal;
>> +            } else if (wr_ret < buf_len) {
>> +                ret = -EINVAL;
>> +                goto ret_signal;
>> +            }
> 
> Should we loop the write until reaching buf_len bytes?
> Partial write is not considered error according to write(2) manpage.

Yes, it's probably better to allow partial writes in case
some VFIO kernel driver actually makes use of them.

> 
> Thanks.

Thanks,
Maciej



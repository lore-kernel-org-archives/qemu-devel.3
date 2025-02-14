Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD8FC02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj750-0004DX-CK; Fri, 14 Feb 2025 20:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2lW-0003n1-Ow
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:58:26 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2lU-00051g-4s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:58:26 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tj2lO-00000007HpC-1Eyv; Fri, 14 Feb 2025 21:58:18 +0100
Message-ID: <50715039-1eb8-454b-9ab7-fb1490e27841@maciej.szmigiero.name>
Date: Fri, 14 Feb 2025 21:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/33] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <74c4bbaaccd81e883504ae478e84394ddd96bbae.1738171076.git.maciej.szmigiero@oracle.com>
 <1b708674-e14d-46c2-8373-a0b12cf08b10@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <1b708674-e14d-46c2-8373-a0b12cf08b10@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 12.02.2025 14:47, Cédric Le Goater wrote:
> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> The multifd received data needs to be reassembled since device state
>> packets sent via different multifd channels can arrive out-of-order.
>>
>> Therefore, each VFIO device state packet carries a header indicating its
>> position in the stream.
>> The raw device state data is saved into a VFIOStateBuffer for later
>> in-order loading into the device.
>>
>> The last such VFIO device state packet should have
>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c           | 116 ++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c                 |   2 +
>>   hw/vfio/trace-events          |   1 +
>>   include/hw/vfio/vfio-common.h |   1 +
>>   4 files changed, 120 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index bcdf204d5cf4..0c0caec1bd64 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -301,6 +301,12 @@ typedef struct VFIOStateBuffer {
>>   } VFIOStateBuffer;
>>   typedef struct VFIOMultifd {
>> +    VFIOStateBuffers load_bufs;
>> +    QemuCond load_bufs_buffer_ready_cond;
>> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>> +    uint32_t load_buf_idx;
>> +    uint32_t load_buf_idx_last;
>> +    uint32_t load_buf_queued_pending_buffers;
>>   } VFIOMultifd;
>>   static void vfio_state_buffer_clear(gpointer data)
>> @@ -346,6 +352,103 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>   }
> Each routine executed from a migration thread should have a preliminary
> comment saying from which context it is called: migration or VFIO

Do you mean like whether it is called from the code in qemu/migration/
directory or the code in hw/vfio/ directory?

What about internal linkage ("static") functions?
Do they need such comment too? That would actually decrease the readability
of these one-or-two line helpers due to high comment-to-code ratio.

As far as I can see, pretty much no existing VFIO migration function
has such comment.

>> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>> +                                          VFIODeviceStatePacket *packet,
>> +                                          size_t packet_total_size,
>> +                                          Error **errp)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    VFIOStateBuffer *lb;
>> +
>> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
>> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
>> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
>> +    }
>> +
>> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
>> +    if (lb->is_present) {
>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>> +                   packet->idx);
>> +        return false;
>> +    }
>> +
>> +    assert(packet->idx >= multifd->load_buf_idx);
>> +
>> +    multifd->load_buf_queued_pending_buffers++;
>> +    if (multifd->load_buf_queued_pending_buffers >
>> +        vbasedev->migration_max_queued_buffers) {
>> +        error_setg(errp,
>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>> +        return false;
>> +    }
> 
> AFAICT, attributes multifd->load_buf_queued_pending_buffers and
> vbasedev->migration_max_queued_buffers are not strictly necessary.
> They allow to count buffers and check an arbitrary limit, which
> is UINT64_MAX today. It makes me wonder how useful they are.

You are right they aren't strictly necessary and in fact they weren't
there in early versions of this patch set.

It was introduced upon Peter's request since otherwise the source
could theoretically cause the target QEMU to allocate unlimited
amounts of memory for buffers-in-flight:
https://lore.kernel.org/qemu-devel/9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name/
(scroll to the "Risk of OOM on unlimited VFIO buffering" section).

If that's an actual risk in someone's use case then that person
could lower that limit from UINT64_MAX to, for example, 10 buffers.

> Please introduce them in a separate patch at the end of the series,
> adding documentation on the "x-migration-max-queued-buffers" property
> and also general documentation on why and how to use it.

I can certainly move it to the end of the series - done now.

>> +
>> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>> +    lb->len = packet_total_size - sizeof(*packet);
>> +    lb->is_present = true;
>> +
>> +    return true;
>> +}
>> +
>> +static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>> +                                   Error **errp)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIOMultifd *multifd = migration->multifd;
>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
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
>> +        return false;
>> +    }
>> +
>> +    assert(multifd);
>> +
>> +    if (data_size < sizeof(*packet)) {
>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>> +                   data_size, sizeof(*packet));
>> +        return false;
>> +    }
>> +
>> +    if (packet->version != 0) {
> 
> Please add a define for version, even if 0.

I've introduced a new define VFIO_DEVICE_STATE_PACKET_VER_CURRENT.

>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>> +                   packet->version);
>> +        return false;
>> +    }
>> +
>> +    if (packet->idx == UINT32_MAX) {
>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>> +                   packet->idx);
> 
> I don't think printing out packet->idx is useful here.

Yeah, it's unlikely that the value of UINT32_MAX will ever change :)

Removed now.

>> +        return false;
>> +    }
>> +
>> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> 
> I wonder if we can add thread ids to trace events. It would be useful.

load_state_buffer is called from multifd channel receive threads
so passing multifd channel id there would require adding this multifd-specific
parameter to qemu_loadvm_load_state_buffer() and load_state_buffer
SaveVMHandler.

>> +
>> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
>> +
>> +    /* config state packet should be the last one in the stream */
>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>> +        multifd->load_buf_idx_last = packet->idx;
>> +    }
>> +
>> +    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {
> 
> So the migration thread calling multifd_device_state_recv() will
> exit 

The thread is calling multifd_device_state_recv() is a multifd
channel receive thread.

> and the vfio thread loading the state into the device will
> hang until its aborted ?

In the normal (successful) migration flow the vfio_load_bufs_thread()
will exit after loading (write()'ing) all buffers into the device
and then loading its config state.

In the aborted/error/unsuccessful migration flow it will get
terminated from vfio_load_cleanup() -> vfio_multifd_free() ->
vfio_load_cleanup_load_bufs_thread().

vfio_load_cleanup_load_bufs_thread() will signal
load_bufs_buffer_ready_cond and load_bufs_iter_done_cond since
the load thread indeed could be waiting on them.

> 
> This sequence is expected to be called to release the vfio thread
> 
>         while (multifd->load_bufs_thread_running) {
>              multifd->load_bufs_thread_want_exit = true;
> 
>              qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
>          ...
>         }
> 
> right ?

Right, that's a part of the code in vfio_load_cleanup_load_bufs_thread().

> 
> The way the series is presented makes it a bit complex to follow the
> proposition, especially regarding the creation and termination of
> threads, something the reader should be aware of.
> 
> As an initial step in clarifying the design, I would have preferred
> a series of patches introducing the various threads, migration threads
> and VFIO threads, without any workload. Once the creation and termination
> points are established I would then introduce the work load for each
> thread.

When I am doing review of anything more complex (though it's not usually
in QEMU) I mainly follow the final code flow as an operation is handled
since looking just from top to down at individual commits rarely gives
enough context to see how every part interacts together.

But for this the reviewer needs to see the whole code for the logical
operation, rather than just a part of it.

I think that adding the load operation in parts doesn't really
help since the reason why things are done such way in earlier patches
are only apparent in later patches and the earlier parts doesn't
really have much sense on their own.
Not to mention extra code churn when rebasing/reworking that increases
chance of a typo or a copy-paste mistake happening at some point.

I also see that in comments to a later patch you dislike that
a dummy vfio_load_bufs_thread_load_config() gets added in one patch
then immediately replaced by the real implementation in the next patch.
Previously, you also said that vfio_load_config_after_iter() seems
to be unused in the patch that adds it - that's exactly the kind of
issues that bringing the complete operation in one patch avoids.

I agree that, for example, x-migration-load-config-after-iter feature
could be a separate patch as it is a relatively simple change.

Same goes for x-migration-max-queued-buffers checking/enforcement,
compat changes, exporting existing settings (variables) as properties
or adding a g_autoptr() cleanup function for an existing type.

That's why originally the VFIO part of the series was divided into two
parts - receive and send, since these are two separate, yet internally
complete operations.

I also export the whole series (including the current WiP state, with
code moved to migration-multifd.{c,h} files, etc.) as a git tree at
https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio
since this way it can be easily seen how the QEMU code currently
looks after the whole patch set or set of patches there.

> 
> Thanks,
> 
> C.

Thanks,
Maciej



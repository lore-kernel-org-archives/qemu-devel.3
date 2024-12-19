Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1CBE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGP-0002gG-Nz; Thu, 19 Dec 2024 11:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOHHN-0000nO-Fc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:13:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOHHK-0005D3-C4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734617604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cHyHiTyJtk8XLUl1pBksJd5oxYGRQNo5KqWbwI7wjOw=;
 b=EKtc01yKREtay0Rua+Gt5yicomSzxttFrlyVGuSJEImdN0ApF4crYR2icMKUR1p5D+JlUB
 vXcp7Ex/9MwW3OME7gac2AAygaWIr/YzYZMuIP11Zkr0NmY900ewrsiLXTX1O7O3UMxwPp
 7y5E1rwPbFHdtYHf9QLOxrlWJKPhEQo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-dJ12a29uP7SvUnZxlOs2RA-1; Thu, 19 Dec 2024 09:13:21 -0500
X-MC-Unique: dJ12a29uP7SvUnZxlOs2RA-1
X-Mimecast-MFC-AGG-ID: dJ12a29uP7SvUnZxlOs2RA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43627bb20b5so8266055e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734617599; x=1735222399;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHyHiTyJtk8XLUl1pBksJd5oxYGRQNo5KqWbwI7wjOw=;
 b=XlbrrlEOLMOuaQDX/H7omrUiQdWany68/1X/lm4aEq7weraW3hd+8U8BFB52i+XvGm
 ne5ZHwUVrVteYX3HMGgXwcAxhd/5SoyCRr4S/l17xKLzc4H2mAOkebPR8AxUpnxz8foJ
 Fj0Ct6Xz43Y0t92eU98SLUV/VpqtU9dxujiXm17Y9Gw71FnnkCg4V0KiOF7turztvzG1
 xT3M/jG4TMmZsZrK9yvr2RsCPDoDwqbi//fwoE47H9VrAYSajhDYSiaRqtnhGPEFuDUU
 +ZiOj2SiAPXfijBc9vhtunntrF24FwMRK1bccalmBk5XyR7z1acq8/nNalIQI7WMHHMq
 YDZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9N95MPegtZx0k++SHH0SwuUyl/zAe4/tnJL39MWIy9GsezNp8dIwSqcs0Ia7GOfXidhEI+GWiJRCI@nongnu.org
X-Gm-Message-State: AOJu0YyP2N9LqTigfVb/95Aq1TjyOgwSka9F7dLjy3bEQ+1b7I/cR/bt
 YS8NoDL76K41FfCWm8r5Fl1A3KwTWqdLwOsNMqWM3xDqHBzneVD4w+MiUGEyg0ofTq4IfDx/CCc
 ZqgTPE/wowxs3q20bM+0ZN2qViOGHuH7gn3W3wQbHv4ppbUt2lB4k
X-Gm-Gg: ASbGncuDJYY6yvx55wjaL0t1Svy/ZEnVEUMl1+3mraMfaUHzlO140A9mEG8OhZ7ki7w
 8j/qqZsA6gp3xwQAhySxPyODGdiKizbcanK2eZPPatSJD7NAwAHKndW/87h+eTpqRHc7omyn1md
 XGF3CcmmWRtqCy0ZI1GiOWE4c6pzTiyHVWzTjfHoxXuiAYrbCk7z+EBMxvaac/VAe74K7TEAnI5
 G9WhkzVW+D+PN+AKJyBB7Ogf+mSPjiPZUG8IJAwWNbXwBro6VRyP9+BDphBvOdQTcBVKyWNUUTk
 MPPuAYGWHkJG3qDXXXw=
X-Received: by 2002:a05:600c:5248:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-436553eb4a4mr54825635e9.25.1734617599335; 
 Thu, 19 Dec 2024 06:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2bbcVJrvbzn7xdSMnSiAzFv1iyO02UAWLWJzkGrSCGwH4FBDCBARXIHqKOqJDH9tt+Vl/zQ==
X-Received: by 2002:a05:600c:5248:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-436553eb4a4mr54825255e9.25.1734617598795; 
 Thu, 19 Dec 2024 06:13:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm19168905e9.14.2024.12.19.06.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:13:18 -0800 (PST)
Message-ID: <ddd0df36-54bd-4fa1-8697-188f2a947ea0@redhat.com>
Date: Thu, 19 Dec 2024 15:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
 <eb962f64-56ae-4fce-913d-6f7429675df7@redhat.com>
 <2aecdbf0-945a-43d5-a197-fd6761e3b81e@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2aecdbf0-945a-43d5-a197-fd6761e3b81e@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/11/24 00:04, Maciej S. Szmigiero wrote:
> Hi Cédric,
> 
> On 2.12.2024 18:56, Cédric Le Goater wrote:
>> Hello Maciej,
>>
>> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> The multifd received data needs to be reassembled since device state
>>> packets sent via different multifd channels can arrive out-of-order.
>>>
>>> Therefore, each VFIO device state packet carries a header indicating its
>>> position in the stream.
>>>
>>> The last such VFIO device state packet should have
>>> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
>>>
>>> Since it's important to finish loading device state transferred via the
>>> main migration channel (via save_live_iterate SaveVMHandler) before
>>> starting loading the data asynchronously transferred via multifd the thread
>>> doing the actual loading of the multifd transferred data is only started
>>> from switchover_start SaveVMHandler.
>>>
>>> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
>>> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
>>>
>>> This sub-command is only sent after all save_live_iterate data have already
>>> been posted so it is safe to commence loading of the multifd-transferred
>>> device state upon receiving it - loading of save_live_iterate data happens
>>> synchronously in the main migration thread (much like the processing of
>>> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
>>> processed all the proceeding data must have already been loaded.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 402 ++++++++++++++++++++++++++++++++++
>>
>> This is quite a significant update to introduce all at once. It lacks a
>> comprehensive overview of the design for those who were not involved in
>> the earlier discussions adding support for multifd migration of device
>> state. There are multiple threads and migration streams involved at
>> load time which deserve some descriptions. I think the best place
>> would be at the end of :
>>
>>     https://qemu.readthedocs.io/en/v9.1.0/devel/migration/vfio.html
> 
> Will try to add some design/implementations descriptions to
> docs/devel/migration/vfio.rst.
> 
>> Could you please break down the patch to progressively introduce the
>> various elements needed for the receive sequence ? Something like :
>>
>>    - data structures first
>>    - init phase
>>    - run time
>>    - and clean up phase
>>    - toggles to enable/disable/tune
>>    - finaly, documentation update (under vfio migration)
> 
> Obviously I can split the VFIO patch into smaller fragments,
> but this means that the intermediate form won't be testable
> (I guess that's okay).

As long as bisect is not broken, it is fine. Typically, the last patch
of a series is the one activating the new proposed feature.

> 
>> Some more below,
>>
>>>   hw/vfio/pci.c                 |   2 +
>>>   hw/vfio/trace-events          |   6 +
>>>   include/hw/vfio/vfio-common.h |  19 ++
>>>   4 files changed, 429 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 683f2ae98d5e..b54879fe6209 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -15,6 +15,7 @@
>>>   #include <linux/vfio.h>
>>>   #include <sys/ioctl.h>
>>> +#include "io/channel-buffer.h"
>>>   #include "sysemu/runstate.h"
>>>   #include "hw/vfio/vfio-common.h"
>>>   #include "migration/misc.h"
>>> @@ -55,6 +56,15 @@
>>>    */
>>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
>>> +
>>> +typedef struct VFIODeviceStatePacket {
>>> +    uint32_t version;
>>> +    uint32_t idx;
>>> +    uint32_t flags;
>>> +    uint8_t data[0];
>>> +} QEMU_PACKED VFIODeviceStatePacket;
>>> +
>>>   static int64_t bytes_transferred;
>>>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>> @@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>>       return ret;
>>>   }
>>> +typedef struct VFIOStateBuffer {
>>> +    bool is_present;
>>> +    char *data;
>>> +    size_t len;
>>> +} VFIOStateBuffer;
>>> +
>>> +static void vfio_state_buffer_clear(gpointer data)
>>> +{
>>> +    VFIOStateBuffer *lb = data;
>>> +
>>> +    if (!lb->is_present) {
>>> +        return;
>>> +    }
>>> +
>>> +    g_clear_pointer(&lb->data, g_free);
>>> +    lb->is_present = false;
>>> +}
>>> +
>>> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
>>> +{
>>> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
>>> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
>>> +}
>>> +
>>> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
>>> +{
>>> +    g_clear_pointer(&bufs->array, g_array_unref);
>>> +}
>>> +
>>> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
>>> +{
>>> +    assert(bufs->array);
>>> +}
>>> +
>>> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
>>> +{
>>> +    return bufs->array->len;
>>> +}
>>> +
>>> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
>>> +{
>>> +    g_array_set_size(bufs->array, size);
>>> +}
>>> +
>>> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>> +{
>>> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>> +}
>>> +
>>> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>>> +                                  Error **errp)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
>>> +    VFIOStateBuffer *lb;
>>> +
>>> +    /*
>>> +     * Holding BQL here would violate the lock order and can cause
>>> +     * a deadlock once we attempt to lock load_bufs_mutex below.
>>> +     */
>>> +    assert(!bql_locked());
>>> +
>>> +    if (!migration->multifd_transfer) {
>>
>> Hmm, why is 'multifd_transfer' a migration attribute ? Shouldn't it
>> be at the device level ? 
> 
> I thought migration-time data goes into VFIOMigration?

yes. Sorry, I was confused by the object MigrationState which is global.
VFIOMigration is a device leve object. We are fine.

AFAICT, this supports hybrid configs : some devices using multifd
migration and some others using standard migration.

> I don't have any strong objections against moving it into VFIODevice though.
> 
>> Or should all devices of a VM support multifd
>> transfer ? That said, I'm a bit unclear about the limitations, if there
>> are any. Could please you explain a bit more when the migration sequence
>> is setup for the  device ?
>>
> 
> The reason we need this setting on the receive side is because we
> need to know whether to start the load_bufs_thread (the migration
> core will later wait for this thread to finish before proceeding further).
> 
> We also need to know whether to allocate multifd-related data structures
> in the VFIO driver based on this setting.
> 
> This setting ultimately comes from "x-migration-multifd-transfer"
> VFIOPCIDevice setting, which is a ON_OFF_AUTO setting ("AUTO" value means
> that multifd use in the driver is attempted in configurations that
> otherwise support it).
> 
>>
>>> +        error_setg(errp,
>>> +                   "got device state packet but not doing multifd transfer");
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (data_size < sizeof(*packet)) {
>>> +        error_setg(errp, "packet too short at %zu (min is %zu)",
>>> +                   data_size, sizeof(*packet));
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->version != 0) {
>>> +        error_setg(errp, "packet has unknown version %" PRIu32,
>>> +                   packet->version);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (packet->idx == UINT32_MAX) {
>>> +        error_setg(errp, "packet has too high idx %" PRIu32,
>>> +                   packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
>>> +
>>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>>> +
>>> +    /* config state packet should be the last one in the stream */
>>> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
>>> +        migration->load_buf_idx_last = packet->idx;
>>> +    }
>>> +
>>> +    vfio_state_buffers_assert_init(&migration->load_bufs);
>>> +    if (packet->idx >= vfio_state_buffers_size_get(&migration->load_bufs)) {
>>> +        vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
>>> +    }
>>> +
>>> +    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
>>> +    if (lb->is_present) {
>>> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
>>> +                   packet->idx);
>>> +        return -1;
>>> +    }
>>> +
>>> +    assert(packet->idx >= migration->load_buf_idx);
>>> +
>>> +    migration->load_buf_queued_pending_buffers++;
>>> +    if (migration->load_buf_queued_pending_buffers >
>>> +        vbasedev->migration_max_queued_buffers) {
>>> +        error_setg(errp,
>>> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
>>> +                   packet->idx, vbasedev->migration_max_queued_buffers);
>>> +        return -1;
>>> +    }
>>> +
>>> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>>> +    lb->len = data_size - sizeof(*packet);
>>> +    lb->is_present = true;
>>> +
>>> +    qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>>> +
>>> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    VFIOStateBuffer *lb;
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    QEMUFile *f_out = NULL, *f_in = NULL;
>>> +    uint64_t mig_header;
>>> +    int ret;
>>> +
>>> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
>>> +    lb = vfio_state_buffers_at(&migration->load_bufs, migration->load_buf_idx);
>>> +    assert(lb->is_present);
>>> +
>>> +    bioc = qio_channel_buffer_new(lb->len);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
>>> +
>>> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
>>> +
>>> +    ret = qemu_fflush(f_out);
>>> +    if (ret) {
>>> +        g_clear_pointer(&f_out, qemu_fclose);
>>> +        return ret;
>>> +    }
>>> +
>>> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
>>> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
>>> +
>>> +    mig_header = qemu_get_be64(f_in);
>>> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
>>> +        g_clear_pointer(&f_out, qemu_fclose);
>>> +        g_clear_pointer(&f_in, qemu_fclose);
>>> +        return -EINVAL;
>>> +    }
>>
>> All the above code is using the QIOChannel interface which is sort of an
>> internal API of the migration subsystem. Can we move it under migration ?
> 
> hw/remote and hw/virtio are also using QIOChannel API, not to mention
> qemu-nbd, block/nbd and backends/tpm, so definitely it's not just the
> core migration code that uses it.

These examples are not device models.

> I don't think introducing a tiny generic migration core helper which takes
> VFIO-specific buffer with config data and ends calling VFIO-specific
> device config state load function really makes sense.

qemu_file_new_input/ouput, qio_channel_buffer_new, qio_channel_io_seek,
qio_channel_buffer_new are solely used in migration. That's why I am
reluctant to use them directly in VFIO.

I agree it is small, for now.

> 
>>
>>> +
>>> +    bql_lock();
>>> +    ret = vfio_load_device_config_state(f_in, vbasedev);
>>> +    bql_unlock();
>>> +
>>> +    g_clear_pointer(&f_out, qemu_fclose);
>>> +    g_clear_pointer(&f_in, qemu_fclose);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
>>> +                                             bool *abort_flag)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    return migration->load_bufs_thread_want_exit || qatomic_read(abort_flag);
>>> +}
>>> +
>>> +static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
>>> +    int ret;
>>> +
>>> +    assert(migration->load_bufs_thread_running);
>>> +
>>> +    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
>>> +        VFIOStateBuffer *lb;
>>> +        guint bufs_len;
>>> +        bool starved;
>>> +
>>> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
>>> +
>>> +        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
>>> +        if (migration->load_buf_idx >= bufs_len) {
>>> +            assert(migration->load_buf_idx == bufs_len);
>>> +            starved = true;
>>> +        } else {
>>> +            lb = vfio_state_buffers_at(&migration->load_bufs,
>>> +                                       migration->load_buf_idx);
>>> +            starved = !lb->is_present;
>>> +        }
>>> +
>>> +        if (starved) {
>>> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
>>> +                                                        migration->load_buf_idx);
>>> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
>>> +                           &migration->load_bufs_mutex);
>>> +            continue;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
>>> +            break;
>>> +        }
>>> +
>>> +        if (migration->load_buf_idx == 0) {
>>> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
>>> +        }
>>> +
>>> +        if (lb->len) {
>>> +            g_autofree char *buf = NULL;
>>> +            size_t buf_len;
>>> +            ssize_t wr_ret;
>>> +            int errno_save;
>>> +
>>> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
>>> +                                                           migration->load_buf_idx);
>>> +
>>> +            /* lb might become re-allocated when we drop the lock */
>>> +            buf = g_steal_pointer(&lb->data);
>>> +            buf_len = lb->len;
>>> +
>>> +            /*
>>> +             * Loading data to the device takes a while,
>>> +             * drop the lock during this process.
>>> +             */
>>> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
>>> +            wr_ret = write(migration->data_fd, buf, buf_len);
>>> +            errno_save = errno;
>>> +            qemu_mutex_lock(&migration->load_bufs_mutex);
>>> +
>>> +            if (wr_ret < 0) {
>>> +                ret = -errno_save;
>>> +                goto ret_signal;
>>> +            } else if (wr_ret < buf_len) {
>>> +                ret = -EINVAL;
>>> +                goto ret_signal;
>>> +            }
>>> +
>>> +            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
>>> +                                                         migration->load_buf_idx);
>>> +        }
>>> +
>>> +        assert(migration->load_buf_queued_pending_buffers > 0);
>>> +        migration->load_buf_queued_pending_buffers--;
>>> +
>>> +        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
>>> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
>>> +        }
>>> +
>>> +        migration->load_buf_idx++;
>>> +    }
>>> +
>>> +    if (vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
>>> +        ret = -ECANCELED;
>>> +        goto ret_signal;
>>> +    }
>>> +
>>> +    ret = vfio_load_bufs_thread_load_config(vbasedev);
>>> +
>>> +ret_signal:
>>> +    migration->load_bufs_thread_running = false;
>>> +    qemu_cond_signal(&migration->load_bufs_thread_finished_cond);
>>> +
>>> +    return ret;
>>
>> Is the error reported to the migration subsytem ?
> 
> Yes, via setting "load_threads_ret" in qemu_loadvm_load_thread().
> 
>>> +}
>>> +
>>>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>>>                                            Error **errp)
>>>   {
>>> @@ -430,6 +726,12 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>>       return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>   }
>>> +static bool vfio_multifd_transfer_supported(void)
>>> +{
>>> +    return migration_has_device_state_support() &&
>>> +        migrate_send_switchover_start();
>>> +}
>>> +
>>>   /* ---------------------------------------------------------------------- */
>>>   static int vfio_save_prepare(void *opaque, Error **errp)
>>> @@ -695,17 +997,73 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>       assert(!migration->load_setup);
>>> +    /*
>>> +     * Make a copy of this setting at the start in case it is changed
>>> +     * mid-migration.
>>> +     */
>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>>> +    } else {
>>> +        migration->multifd_transfer =
>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>> +    }
>>> +
>>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>>> +        error_setg(errp,
>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>> +                   vbasedev->name);
>>> +        return -EINVAL;
>>> +    }
>>
>> Can we move these checks ealier ? in vfio_migration_realize() ?
>> If possible, it would be good to avoid the multifd_transfer attribute also.
> 
> We can't since the value is changeable at runtime, so it could have been
> changed after the VFIO device got realized.

We will need discuss this part again. Let's keep it that way for now.

>>>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>>>                                      migration->device_state, errp);
>>>       if (ret) {
>>>           return ret;
>>>       }
>>> +    if (migration->multifd_transfer) {
>>> +        assert(!migration->load_bufs.array);
>>> +        vfio_state_buffers_init(&migration->load_bufs);
>>> +
>>> +        qemu_mutex_init(&migration->load_bufs_mutex);
>>> +
>>> +        migration->load_buf_idx = 0;
>>> +        migration->load_buf_idx_last = UINT32_MAX;
>>> +        migration->load_buf_queued_pending_buffers = 0;
>>> +        qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
>>> +
>>> +        migration->load_bufs_thread_running = false;
>>> +        migration->load_bufs_thread_want_exit = false;
>>> +        qemu_cond_init(&migration->load_bufs_thread_finished_cond);
>>
>> Please provide an helper routine to initialize all the multifd transfer
>> attributes. We might want to add a struct to gather them all by the way.
> 
> Will move these to a new helper.
> 
>>> +    }
>>> +
>>>       migration->load_setup = true;
>>>       return 0;
>>>   }
>>> +static void vfio_load_cleanup_load_bufs_thread(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
>>> +    bql_unlock();
>>> +    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
>>> +        if (!migration->load_bufs_thread_running) {
>>> +            break;
>>> +        }
>>> +
>>> +        migration->load_bufs_thread_want_exit = true;
>>> +
>>> +        qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
>>> +        qemu_cond_wait(&migration->load_bufs_thread_finished_cond,
>>> +                       &migration->load_bufs_mutex);
>>> +
>>> +        assert(!migration->load_bufs_thread_running);
>>> +    }
>>> +    bql_lock();
>>> +}
>>> +
>>>   static int vfio_load_cleanup(void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> @@ -715,7 +1073,19 @@ static int vfio_load_cleanup(void *opaque)
>>>           return 0;
>>>       }
>>> +    if (migration->multifd_transfer) {
>>> +        vfio_load_cleanup_load_bufs_thread(vbasedev);
>>> +    }
>>> +
>>>       vfio_migration_cleanup(vbasedev);
>>
>> Why is the cleanup done in two steps ?
> 
> I'm not sure what "two steps" here refer to, but
> if you mean to move the "if (migration->multifd_transfer)"
> block below to the similar one above then it should be possible.

good. It is preferable.


Thanks,

C.




> 
>>> +
>>> +    if (migration->multifd_transfer) {
>>> +        qemu_cond_destroy(&migration->load_bufs_thread_finished_cond);
>>> +        vfio_state_buffers_destroy(&migration->load_bufs);
>>> +        qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
>>> +        qemu_mutex_destroy(&migration->load_bufs_mutex);
>>> +    }
>>> +
>>>       migration->load_setup = false;
>>>       trace_vfio_load_cleanup(vbasedev->name);
> (..)
> 
> 
>> Thanks,
>>
>> C.
>>
> 
> Thanks,
> Maciej
> 



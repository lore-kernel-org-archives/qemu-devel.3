Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C32ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snioJ-0002lK-D1; Mon, 09 Sep 2024 14:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snioC-0002MJ-V5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:08:19 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1snio7-0001zB-Gj
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:08:16 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sniny-0006Sn-Vt; Mon, 09 Sep 2024 20:08:03 +0200
Message-ID: <a7cd0a2f-6dba-4fec-b63b-b7985e01608b@maciej.szmigiero.name>
Date: Mon, 9 Sep 2024 20:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] vfio/migration: Multifd device state transfer
 support - send side
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
 <d801c59f-60da-4d42-ae0f-c70d99c45990@nvidia.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <d801c59f-60da-4d42-ae0f-c70d99c45990@nvidia.com>
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

On 9.09.2024 13:41, Avihai Horon wrote:
> 
> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Implement the multifd device state transfer via additional per-device
>> thread inside save_live_complete_precopy_thread handler.
>>
>> Switch between doing the data transfer in the new handler and doing it
>> in the old save_state handler depending on the
>> x-migration-multifd-transfer device property value.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration.c           | 169 ++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |   2 +
>>   include/hw/vfio/vfio-common.h |   1 +
>>   3 files changed, 172 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 57c1542528dc..67996aa2df8b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -655,6 +655,16 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>       int ret;
>>
>> +    /* Make a copy of this setting at the start in case it is changed mid-migration */
>> +    migration->multifd_transfer = vbasedev->migration_multifd_transfer;
> 
> Should VFIO multifd be controlled by main migration multifd capability, and let the per VFIO device migration_multifd_transfer property be immutable and enabled by default?
> Then we would have a single point of configuration (and an extra one per VFIO device just to disable for backward compatibility).
> Unless there are other benefits to have this property configurable?

We want multifd device state transfer property to be configurable per-device
in case in the future we add another device type (besides VFIO) that supports
multifd device state transfer.

In this case, we might need to enable the multifd device state transfer just
for VFIO devices, but not for this new device type when we are migrating to a
QEMU target that supports just the VFIO multifd device state transfer.

TBH, I'm not opposed to adding a additional global multifd device state transfer
switch (if we keep the per-device ones too) but I am not sure what value it adds.

>> +
>> +    if (migration->multifd_transfer && !migration_has_device_state_support()) {
>> +        error_setg(errp,
>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>> +                   vbasedev->name);
>> +        return -EINVAL;
>> +    }
>> +
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>
>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>> @@ -835,10 +845,20 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>>       ssize_t data_size;
>>       int ret;
>>       Error *local_err = NULL;
>>
>> +    if (migration->multifd_transfer) {
>> +        /*
>> +         * Emit dummy NOP data, vfio_save_complete_precopy_thread()
>> +         * does the actual transfer.
>> +         */
>> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> 
> There are three places where we send this dummy end of state, maybe worth extracting it to a helper? I.e., vfio_send_end_of_state() and then document there the rationale.

I'm not totally against it but it's wrapping just a single line of code in
a separate function?

>> +        return 0;
>> +    }
>> +
>>       trace_vfio_save_complete_precopy_started(vbasedev->name);
>>
>>       /* We reach here with device state STOP or STOP_COPY only */
>> @@ -864,12 +884,159 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>       return ret;
>>   }
>>
>> +static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
>> +                                                                char *idstr,
>> +                                                                uint32_t instance_id,
>> +                                                                uint32_t idx)
>> +{
>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>> +    QEMUFile *f = NULL;
>> +    int ret;
>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>> +    size_t packet_len;
>> +
>> +    bioc = qio_channel_buffer_new(0);
>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>> +
>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>> +
>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>> +    if (ret) {
>> +        return ret;
> 
> Need to close f in this case.

Right - by the way, that's a good example why RAII
helps avoid such mistakes.

>> +    }
>> +
>> +    ret = qemu_fflush(f);
>> +    if (ret) {
>> +        goto ret_close_file;
>> +    }
>> +
>> +    packet_len = sizeof(*packet) + bioc->usage;
>> +    packet = g_malloc0(packet_len);
>> +    packet->idx = idx;
>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>> +
>> +    if (!multifd_queue_device_state(idstr, instance_id,
>> +                                    (char *)packet, packet_len)) {
>> +        ret = -1;
> 
> goto ret_close_file?

Right, it would be better not to increment the counter in this case.

>> +    }
>> +
>> +    bytes_transferred += packet_len;
> 
> bytes_transferred is a global variable. Now that we access it from multiple threads it should be protected.

Right, this stat needs some concurrent access protection.

> Note that now the VFIO device data is reported also in multifd stats (if I am not mistaken), is this the behavior we want? Maybe we should enhance multifd stats to distinguish between RAM data and device data?

Multifd stats report total size of data transferred via multifd so
they should include device state too.

It may make sense to add a dedicated device state transfer counter
at some time though.

>> +
>> +ret_close_file:
> 
> Rename to "out" as we only have one exit point?
> 
>> +    g_clear_pointer(&f, qemu_fclose);
> 
> f is a local variable, wouldn't qemu_fclose(f) be enough here?

Sure, but why leave a dangling pointer?

Currently, it is obviously a NOP (probably deleted by dead store
elimination anyway) but the code might get refactored at some point
and I think it's good practice to always NULL pointers after freeing
them where possible and so be on the safe side.

>> +    return ret;
>> +}
>> +
>> +static int vfio_save_complete_precopy_thread(char *idstr,
>> +                                             uint32_t instance_id,
>> +                                             bool *abort_flag,
>> +                                             void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>> +    uint32_t idx;
>> +
>> +    if (!migration->multifd_transfer) {
>> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
>> +        return 0;
>> +    }
>> +
>> +    trace_vfio_save_complete_precopy_thread_started(vbasedev->name,
>> +                                                    idstr, instance_id);
>> +
>> +    /* We reach here with device state STOP or STOP_COPY only */
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>> +                                   VFIO_DEVICE_STATE_STOP, NULL);
>> +    if (ret) {
>> +        goto ret_finish;
>> +    }
>> +
>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>> +
>> +    for (idx = 0; ; idx++) {
>> +        ssize_t data_size;
>> +        size_t packet_size;
>> +
>> +        if (qatomic_read(abort_flag)) {
>> +            ret = -ECANCELED;
>> +            goto ret_finish;
>> +        }
>> +
>> +        data_size = read(migration->data_fd, &packet->data,
>> +                         migration->data_buffer_size);
>> +        if (data_size < 0) {
>> +            if (errno != ENOMSG) {
>> +                ret = -errno;
>> +                goto ret_finish;
>> +            }
>> +
>> +            /*
>> +             * Pre-copy emptied all the device state for now. For more information,
>> +             * please refer to the Linux kernel VFIO uAPI.
>> +             */
>> +            data_size = 0;
> 
> According to VFIO uAPI, ENOMSG can only be returned in the PRE_COPY device states.
> Here we are in STOP_COPY, so we can drop the ENOMSG handling.

Will drop this ENOMSG handling.

> Thanks.

Thanks,
Maciej




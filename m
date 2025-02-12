Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0193FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiD5l-0007tn-Mj; Wed, 12 Feb 2025 08:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiD5j-0007tT-5S
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiD5h-00035y-8z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739368068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eXWu2pZWoabibxWD/riJBS13K7qqR8j35WGmOATiewE=;
 b=bLAsO/6hwvVuPkescyVaPOIJp+oOpbhZv9ATycLk0RnpIn4yC7iYlRLEcLay8lzA76xMzX
 cPXFDQU301JHnZ024/liuxiYPk7Ftqil1c7hH/BpYc25dpaHfmJxv65+5jCc1ooSn9xXc5
 a/7NNQ9302wIKvTS51sC4jETYmXufc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-cA-A6ghvNEOhHaF11MKWDA-1; Wed, 12 Feb 2025 08:47:46 -0500
X-MC-Unique: cA-A6ghvNEOhHaF11MKWDA-1
X-Mimecast-MFC-AGG-ID: cA-A6ghvNEOhHaF11MKWDA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd8d11139so921760f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739368065; x=1739972865;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXWu2pZWoabibxWD/riJBS13K7qqR8j35WGmOATiewE=;
 b=UAn8tuXPx9G8bGb1kwniybfdzo2VYQq97uG39o0mEV9nh0ox7gk7cuCpiXsqvFwan0
 AV2HFluujzoXh0HWX31YicvLLTees1zJbYhEVbkwwYMT3NjBC2j7cKYhs+btODrBRo8C
 9gdhU5zog2oi/ggeO40a7yJAykB8mjbX9PZladm4JkDDPrFDrSOl75p1iy6BLDpaVitq
 gn1XxZnzONvjGKOpXpGKGbCoDOkJZPBaV5RmAZGhh/GtuI8HqTj8F/sl9huPm8yBFABo
 wADm3RHKmexKOgRgEWkjCDiTzD+N27O9Dq3X6wfHVV8bbQ1Qzjdes9pdlUPXEV4TiTu/
 nPpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbU0Htpk9DQcfloSU7q7GTMdWHwnBNR/iD276NbLDcr1YS9BCU+OpEa6tkQERQWlxE6GL82aFl5aD7@nongnu.org
X-Gm-Message-State: AOJu0YyfHt4YL8vX5RtWBrxwGyEbOH9m8j8t+sbD8n6DFO/39P2rU1T6
 zqrDrLw6UY3Fr8gUX7G3CU0UH8x4Z09448YdskwxsIMm5Uvcfv6dHqOxIObahQQSLX7G1ZPB4AH
 hUemHIFfyoUf68kNJHlWCBRluXWp3QNwN1gUqZo68l2WODeydMWJV
X-Gm-Gg: ASbGncsBRa6jNSy6r5Hu0cXBNxiafhrshaBUU9otpG80axo2Tnj7JMszMlu4m5nrn4B
 5NHmz+4MqVkQGiTI1Hvn8tEGfmJcL9nZEkB06VG3X67Pzb+dEvzywqhy+1WoWBRn1hCj6Um8Yy/
 IpAlWz3dxwcDDmkE7F4LFBWm5pf8K3FQh/tbVFx5sEZK+fivGj+8YnU52q11RV2u7KRht/ApaPh
 KJa1oe5a+rPSkafyO4nZdFzc4KMxtjuoJ7UBfbae+PzPWng68Z2FkK8JIajPeQl+AraqjCNSIxk
 uD54V5nyn2RXxFhFM/IxAj37dskItAvucwESDR9e0DM=
X-Received: by 2002:a5d:54d0:0:b0:38d:deca:fccf with SMTP id
 ffacd0b85a97d-38dea270ce8mr2264834f8f.13.1739368065473; 
 Wed, 12 Feb 2025 05:47:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0qgJLPuV4o8zA0NJh3G/3r3RrQnworVK7Jli8/yebK/trIeEC/DW7XbuK1FE1dXNtED2tDA==
X-Received: by 2002:a5d:54d0:0:b0:38d:deca:fccf with SMTP id
 ffacd0b85a97d-38dea270ce8mr2264813f8f.13.1739368065048; 
 Wed, 12 Feb 2025 05:47:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2e0765esm12304985f8f.82.2025.02.12.05.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 05:47:44 -0800 (PST)
Message-ID: <1b708674-e14d-46c2-8373-a0b12cf08b10@redhat.com>
Date: Wed, 12 Feb 2025 14:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/33] vfio/migration: Multifd device state transfer
 support - received buffers queuing
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <74c4bbaaccd81e883504ae478e84394ddd96bbae.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <74c4bbaaccd81e883504ae478e84394ddd96bbae.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
> 
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
> The raw device state data is saved into a VFIOStateBuffer for later
> in-order loading into the device.
> 
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 116 ++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c                 |   2 +
>   hw/vfio/trace-events          |   1 +
>   include/hw/vfio/vfio-common.h |   1 +
>   4 files changed, 120 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bcdf204d5cf4..0c0caec1bd64 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -301,6 +301,12 @@ typedef struct VFIOStateBuffer {
>   } VFIOStateBuffer;
>   
>   typedef struct VFIOMultifd {
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMultifd;
>   
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -346,6 +352,103 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>   }
>   
Each routine executed from a migration thread should have a preliminary
comment saying from which context it is called: migration or VFIO

> +static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
> +                                          VFIODeviceStatePacket *packet,
> +                                          size_t packet_total_size,
> +                                          Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +
> +    vfio_state_buffers_assert_init(&multifd->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
> +        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
> +                   packet->idx);
> +        return false;
> +    }
> +
> +    assert(packet->idx >= multifd->load_buf_idx);
> +
> +    multifd->load_buf_queued_pending_buffers++;
> +    if (multifd->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);
> +        return false;
> +    }

AFAICT, attributes multifd->load_buf_queued_pending_buffers and
vbasedev->migration_max_queued_buffers are not strictly necessary.
They allow to count buffers and check an arbitrary limit, which
is UINT64_MAX today. It makes me wonder how useful they are.

Please introduce them in a separate patch at the end of the series,
adding documentation on the "x-migration-max-queued-buffers" property
and also general documentation on why and how to use it.

> +
> +    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
> +    lb->len = packet_total_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    return true;
> +}
> +
> +static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                   Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());
> +
> +    if (!migration->multifd_transfer) {
> +        error_setg(errp,
> +                   "got device state packet but not doing multifd transfer");
> +        return false;
> +    }
> +
> +    assert(multifd);
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));
> +        return false;
> +    }
> +
> +    if (packet->version != 0) {

Please add a define for version, even if 0.

> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);
> +        return false;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx %" PRIu32,
> +                   packet->idx);

I don't think printing out packet->idx is useful here.

> +        return false;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);

I wonder if we can add thread ids to trace events. It would be useful.

> +
> +    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        multifd->load_buf_idx_last = packet->idx;
> +    }
> +
> +    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {

So the migration thread calling multifd_device_state_recv() will
exit and the vfio thread loading the state into the device will
hang until its aborted ?

This sequence is expected to be called to release the vfio thread

        while (multifd->load_bufs_thread_running) {
             multifd->load_bufs_thread_want_exit = true;

             qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
	    ...
        }

right ?


The way the series is presented makes it a bit complex to follow the
proposition, especially regarding the creation and termination of
threads, something the reader should be aware of.

As an initial step in clarifying the design, I would have preferred
a series of patches introducing the various threads, migration threads
and VFIO threads, without any workload. Once the creation and termination
points are established I would then introduce the work load for each
thread.


Thanks,

C.




> +        return false;
> +    }
> +
> +    qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
> +
> +    return true;
> +}
> +
>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>                                            Error **errp)
>   {
> @@ -405,11 +508,23 @@ static VFIOMultifd *vfio_multifd_new(void)
>   {
>       VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>   
> +    vfio_state_buffers_init(&multifd->load_bufs);
> +
> +    qemu_mutex_init(&multifd->load_bufs_mutex);
> +
> +    multifd->load_buf_idx = 0;
> +    multifd->load_buf_idx_last = UINT32_MAX;
> +    multifd->load_buf_queued_pending_buffers = 0;
> +    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
> +
>       return multifd;
>   }
>   
>   static void vfio_multifd_free(VFIOMultifd *multifd)
>   {
> +    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
> +    qemu_mutex_destroy(&multifd->load_bufs_mutex);
> +
>       g_free(multifd);
>   }
>   
> @@ -940,6 +1055,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
>   };
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 83090c544d95..2700b355ecf1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3380,6 +3380,8 @@ static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
>                               vbasedev.migration_load_config_after_iter,
>                               ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1bebe9877d88..042a3dc54a33 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,6 +153,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c0c9c0b1b263..0e8b0848882e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -139,6 +139,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       OnOffAuto migration_load_config_after_iter;
> +    uint64_t migration_max_queued_buffers;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 



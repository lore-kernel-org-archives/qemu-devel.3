Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D78FD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAfH-0003x6-9c; Mon, 02 Dec 2024 12:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tIAfF-0003wR-PY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tIAfC-0000DE-RY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733162208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5mH0ww6sX60HeS1pqbh3ud4pxqOa3syrtCMzFLTcAhI=;
 b=berplRS3EPNqQC6znnOyfadLnh76DVed281l+u8YCf/FU6pHRMsbojnJwmMEcdyEKuhWO2
 7P+vl0I/TQrRbgn5Gbq3dwjmxJg7kknmtPMsI/1F8JlCS0HjuwYX4I5FQk2ZQKz7gWZy4G
 tBCAs9i0GSuv+BcImzUbS114SGedRb8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-wWaAyKPePIGx8pGwHyb5PA-1; Mon, 02 Dec 2024 12:56:47 -0500
X-MC-Unique: wWaAyKPePIGx8pGwHyb5PA-1
X-Mimecast-MFC-AGG-ID: wWaAyKPePIGx8pGwHyb5PA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a73651e2so29240515e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733162206; x=1733767006;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5mH0ww6sX60HeS1pqbh3ud4pxqOa3syrtCMzFLTcAhI=;
 b=F6SbHpvVJi60i7Qpsh2FkT6P37pyoJPVBFF8uDd8IvuvzEdvjOTPJeA1noN6/hKAa6
 wPCgMzz+kQkupaEKjzkNIoQW8lynwFimMP8Um6pr9arPmGSUA07VXMJXU2UtvAdLTJNB
 llQvxM9ESJPVg0APG2Rcxj2WAD+kHVCUrrLukQQw8aYTpwwmW/iUE7y5WmVPToRHIlQH
 TXU/2AF5Qc9d8YQX5/ytw+N1wFBcnXWkKY5k+FsPUM6I3/r7Kc5HF39ZocE+yYFByPm7
 BYeEs0DrbhlkwGJSm+Y2D7RBLGyrLDEcgtN2FMAf2pnN5gjkTzb9ZBFhVI5yIE/VRySt
 3cFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDO3l0WCdhBPPmgy7MMfC+hIsihwdOlCVNuR9VjO3RvjNaYAxHaPyDLkjtC1e2nCo5whWJsycD9Ncv@nongnu.org
X-Gm-Message-State: AOJu0Yw0ofytJG4seIeZ/bRCnikSTNaJz+eoTA6EFsXDKFbq7dEcTQMQ
 VkPiZSM4jU7SM/N9IBl39+L3Ccv0/CKVIE54swfMIZ3spC0ZatZiBbFe2tx2uM9bT+YtM99S3fm
 DNg/em5YaBlnMvcGDKvfBbbf+4EeKrZfjRyp+9utclF0JgWvYzD+r
X-Gm-Gg: ASbGncv17I3F7e+uvsEiMge8Qf0MCxgN8P1y86g3dG68YJEbWgr/JB6teOyg8MHh3Br
 svNgMzxHsNEqugY35jmkgQpCOD5eW0Ud0vLMxfvwMnLyClHFf9QFT3tBXxiST1EqMYYdrC/XGGU
 jraV78jEbV02dV4y4W65NaE2L3cPh34e2FLvOSaAncVevzZAJB3mABD+TojAVjvQTZfx+9nvudA
 hKl5qG8crOeokpM8/HftNv2xFDOzn4KDW+A5zJ8MaVpEXmlDgGldFC+cI1zXtGCDSgtP6QAzJQP
 X0vEdW4Mkypi
X-Received: by 2002:a5d:6d83:0:b0:385:eb8b:3ec6 with SMTP id
 ffacd0b85a97d-385eb8b3fe6mr6384243f8f.29.1733162205860; 
 Mon, 02 Dec 2024 09:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEak04WZeyUNljGcDIrxRoo0OMRm14nIg5eeolrmlA6qUAEr9xQ4FPbbgXFPVLsO5DumdPD4w==
X-Received: by 2002:a5d:6d83:0:b0:385:eb8b:3ec6 with SMTP id
 ffacd0b85a97d-385eb8b3fe6mr6384213f8f.29.1733162205320; 
 Mon, 02 Dec 2024 09:56:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f32793sm162440045e9.31.2024.12.02.09.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:56:44 -0800 (PST)
Message-ID: <eb962f64-56ae-4fce-913d-6f7429675df7@redhat.com>
Date: Mon, 2 Dec 2024 18:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello Maciej,

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> The multifd received data needs to be reassembled since device state
> packets sent via different multifd channels can arrive out-of-order.
> 
> Therefore, each VFIO device state packet carries a header indicating its
> position in the stream.
> 
> The last such VFIO device state packet should have
> VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.
> 
> Since it's important to finish loading device state transferred via the
> main migration channel (via save_live_iterate SaveVMHandler) before
> starting loading the data asynchronously transferred via multifd the thread
> doing the actual loading of the multifd transferred data is only started
> from switchover_start SaveVMHandler.
> 
> switchover_start handler is called when MIG_CMD_SWITCHOVER_START
> sub-command of QEMU_VM_COMMAND is received via the main migration channel.
> 
> This sub-command is only sent after all save_live_iterate data have already
> been posted so it is safe to commence loading of the multifd-transferred
> device state upon receiving it - loading of save_live_iterate data happens
> synchronously in the main migration thread (much like the processing of
> MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
> processed all the proceeding data must have already been loaded.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 402 ++++++++++++++++++++++++++++++++++

This is quite a significant update to introduce all at once. It lacks a
comprehensive overview of the design for those who were not involved in
the earlier discussions adding support for multifd migration of device
state. There are multiple threads and migration streams involved at
load time which deserve some descriptions. I think the best place
would be at the end of :

    https://qemu.readthedocs.io/en/v9.1.0/devel/migration/vfio.html

Could you please break down the patch to progressively introduce the
various elements needed for the receive sequence ? Something like :

   - data structures first
   - init phase
   - run time
   - and clean up phase
   - toggles to enable/disable/tune
   - finaly, documentation update (under vfio migration)

Some more below,

>   hw/vfio/pci.c                 |   2 +
>   hw/vfio/trace-events          |   6 +
>   include/hw/vfio/vfio-common.h |  19 ++
>   4 files changed, 429 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 683f2ae98d5e..b54879fe6209 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -15,6 +15,7 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   
> +#include "io/channel-buffer.h"
>   #include "sysemu/runstate.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "migration/misc.h"
> @@ -55,6 +56,15 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>   
> +#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
> +
> +typedef struct VFIODeviceStatePacket {
> +    uint32_t version;
> +    uint32_t idx;
> +    uint32_t flags;
> +    uint8_t data[0];
> +} QEMU_PACKED VFIODeviceStatePacket;
> +
>   static int64_t bytes_transferred;
>   
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
> @@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> +typedef struct VFIOStateBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} VFIOStateBuffer;
> +
> +static void vfio_state_buffer_clear(gpointer data)
> +{
> +    VFIOStateBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
> +{
> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
> +}
> +
> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
> +{
> +    g_clear_pointer(&bufs->array, g_array_unref);
> +}
> +
> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
> +{
> +    assert(bufs->array);
> +}
> +
> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
> +{
> +    return bufs->array->len;
> +}
> +
> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
> +{
> +    g_array_set_size(bufs->array, size);
> +}
> +
> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
> +{
> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
> +}
> +
> +static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
> +                                  Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
> +    VFIOStateBuffer *lb;
> +
> +    /*
> +     * Holding BQL here would violate the lock order and can cause
> +     * a deadlock once we attempt to lock load_bufs_mutex below.
> +     */
> +    assert(!bql_locked());
> +
> +    if (!migration->multifd_transfer) {

Hmm, why is 'multifd_transfer' a migration attribute ? Shouldn't it
be at the device level ? Or should all devices of a VM support multifd
transfer ? That said, I'm a bit unclear about the limitations, if there
are any. Could please you explain a bit more when the migration sequence
is setup for the  device ?



> +        error_setg(errp,
> +                   "got device state packet but not doing multifd transfer");
> +        return -1;
> +    }
> +
> +    if (data_size < sizeof(*packet)) {
> +        error_setg(errp, "packet too short at %zu (min is %zu)",
> +                   data_size, sizeof(*packet));
> +        return -1;
> +    }
> +
> +    if (packet->version != 0) {
> +        error_setg(errp, "packet has unknown version %" PRIu32,
> +                   packet->version);
> +        return -1;
> +    }
> +
> +    if (packet->idx == UINT32_MAX) {
> +        error_setg(errp, "packet has too high idx %" PRIu32,
> +                   packet->idx);
> +        return -1;
> +    }
> +
> +    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
> +
> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> +
> +    /* config state packet should be the last one in the stream */
> +    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
> +        migration->load_buf_idx_last = packet->idx;
> +    }
> +
> +    vfio_state_buffers_assert_init(&migration->load_bufs);
> +    if (packet->idx >= vfio_state_buffers_size_get(&migration->load_bufs)) {
> +        vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
> +    }
> +
> +    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
> +    if (lb->is_present) {
> +        error_setg(errp, "state buffer %" PRIu32 " already filled",
> +                   packet->idx);
> +        return -1;
> +    }
> +
> +    assert(packet->idx >= migration->load_buf_idx);
> +
> +    migration->load_buf_queued_pending_buffers++;
> +    if (migration->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);
> +        return -1;
> +    }
> +
> +    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
> +    lb->len = data_size - sizeof(*packet);
> +    lb->is_present = true;
> +
> +    qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
> +
> +    return 0;
> +}
> +
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
> +static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;
> +    uint64_t mig_header;
> +    int ret;
> +
> +    assert(migration->load_buf_idx == migration->load_buf_idx_last);
> +    lb = vfio_state_buffers_at(&migration->load_bufs, migration->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return ret;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -EINVAL;
> +    }

All the above code is using the QIOChannel interface which is sort of an
internal API of the migration subsystem. Can we move it under migration ?


> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
> +                                             bool *abort_flag)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->load_bufs_thread_want_exit || qatomic_read(abort_flag);
> +}
> +
> +static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
> +    int ret;
> +
> +    assert(migration->load_bufs_thread_running);
> +
> +    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
> +        VFIOStateBuffer *lb;
> +        guint bufs_len;
> +        bool starved;
> +
> +        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
> +
> +        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
> +        if (migration->load_buf_idx >= bufs_len) {
> +            assert(migration->load_buf_idx == bufs_len);
> +            starved = true;
> +        } else {
> +            lb = vfio_state_buffers_at(&migration->load_bufs,
> +                                       migration->load_buf_idx);
> +            starved = !lb->is_present;
> +        }
> +
> +        if (starved) {
> +            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
> +                                                        migration->load_buf_idx);
> +            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
> +                           &migration->load_bufs_mutex);
> +            continue;
> +        }
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last) {
> +            break;
> +        }
> +
> +        if (migration->load_buf_idx == 0) {
> +            trace_vfio_load_state_device_buffer_start(vbasedev->name);
> +        }
> +
> +        if (lb->len) {
> +            g_autofree char *buf = NULL;
> +            size_t buf_len;
> +            ssize_t wr_ret;
> +            int errno_save;
> +
> +            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
> +                                                           migration->load_buf_idx);
> +
> +            /* lb might become re-allocated when we drop the lock */
> +            buf = g_steal_pointer(&lb->data);
> +            buf_len = lb->len;
> +
> +            /*
> +             * Loading data to the device takes a while,
> +             * drop the lock during this process.
> +             */
> +            qemu_mutex_unlock(&migration->load_bufs_mutex);
> +            wr_ret = write(migration->data_fd, buf, buf_len);
> +            errno_save = errno;
> +            qemu_mutex_lock(&migration->load_bufs_mutex);
> +
> +            if (wr_ret < 0) {
> +                ret = -errno_save;
> +                goto ret_signal;
> +            } else if (wr_ret < buf_len) {
> +                ret = -EINVAL;
> +                goto ret_signal;
> +            }
> +
> +            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> +                                                         migration->load_buf_idx);
> +        }
> +
> +        assert(migration->load_buf_queued_pending_buffers > 0);
> +        migration->load_buf_queued_pending_buffers--;
> +
> +        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
> +            trace_vfio_load_state_device_buffer_end(vbasedev->name);
> +        }
> +
> +        migration->load_buf_idx++;
> +    }
> +
> +    if (vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
> +        ret = -ECANCELED;
> +        goto ret_signal;
> +    }
> +
> +    ret = vfio_load_bufs_thread_load_config(vbasedev);
> +
> +ret_signal:
> +    migration->load_bufs_thread_running = false;
> +    qemu_cond_signal(&migration->load_bufs_thread_finished_cond);
> +
> +    return ret;

Is the error reported to the migration subsytem ?

> +}
> +
>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>                                            Error **errp)
>   {
> @@ -430,6 +726,12 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>       return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>   }
>   
> +static bool vfio_multifd_transfer_supported(void)
> +{
> +    return migration_has_device_state_support() &&
> +        migrate_send_switchover_start();
> +}
> +
>   /* ---------------------------------------------------------------------- */
>   
>   static int vfio_save_prepare(void *opaque, Error **errp)
> @@ -695,17 +997,73 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   
>       assert(!migration->load_setup);
>   
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }
> +
> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
> +        error_setg(errp,
> +                   "%s: Multifd device transfer requested but unsupported in the current config",
> +                   vbasedev->name);
> +        return -EINVAL;
> +    }

Can we move these checks ealier ? in vfio_migration_realize() ?
If possible, it would be good to avoid the multifd_transfer attribute also.

>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>                                      migration->device_state, errp);
>       if (ret) {
>           return ret;
>       }
>   
> +    if (migration->multifd_transfer) {
> +        assert(!migration->load_bufs.array);
> +        vfio_state_buffers_init(&migration->load_bufs);
> +
> +        qemu_mutex_init(&migration->load_bufs_mutex);
> +
> +        migration->load_buf_idx = 0;
> +        migration->load_buf_idx_last = UINT32_MAX;
> +        migration->load_buf_queued_pending_buffers = 0;
> +        qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
> +
> +        migration->load_bufs_thread_running = false;
> +        migration->load_bufs_thread_want_exit = false;
> +        qemu_cond_init(&migration->load_bufs_thread_finished_cond);

Please provide an helper routine to initialize all the multifd transfer
attributes. We might want to add a struct to gather them all by the way.

> +    }
> +
>       migration->load_setup = true;
>   
>       return 0;
>   }
>   
> +static void vfio_load_cleanup_load_bufs_thread(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
> +        if (!migration->load_bufs_thread_running) {
> +            break;
> +        }
> +
> +        migration->load_bufs_thread_want_exit = true;
> +
> +        qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
> +        qemu_cond_wait(&migration->load_bufs_thread_finished_cond,
> +                       &migration->load_bufs_mutex);
> +
> +        assert(!migration->load_bufs_thread_running);
> +    }
> +    bql_lock();
> +}
> +
>   static int vfio_load_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> @@ -715,7 +1073,19 @@ static int vfio_load_cleanup(void *opaque)
>           return 0;
>       }
>   
> +    if (migration->multifd_transfer) {
> +        vfio_load_cleanup_load_bufs_thread(vbasedev);
> +    }
> +
>       vfio_migration_cleanup(vbasedev);

Why is the cleanup done in two steps ?

> +
> +    if (migration->multifd_transfer) {
> +        qemu_cond_destroy(&migration->load_bufs_thread_finished_cond);
> +        vfio_state_buffers_destroy(&migration->load_bufs);
> +        qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
> +        qemu_mutex_destroy(&migration->load_bufs_mutex);
> +    }
> +
>       migration->load_setup = false;
>       trace_vfio_load_cleanup(vbasedev->name);
>   
> @@ -725,6 +1095,7 @@ static int vfio_load_cleanup(void *opaque)
>   static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       int ret = 0;
>       uint64_t data;
>   
> @@ -736,6 +1107,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (migration->multifd_transfer) {
> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
> +                             vbasedev->name);
> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> @@ -801,6 +1178,29 @@ static bool vfio_switchover_ack_needed(void *opaque)
>       return vfio_precopy_supported(vbasedev);
>   }
>   
> +static int vfio_switchover_start(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Load thread is only used for multifd transfer */
> +        return 0;
> +    }
> +
> +    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
> +    bql_unlock();
> +    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
> +        assert(!migration->load_bufs_thread_running);
> +        migration->load_bufs_thread_running = true;
> +    }
> +    bql_lock();
> +
> +    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
> +
> +    return 0;
> +}
> +
>   static const SaveVMHandlers savevm_vfio_handlers = {
>       .save_prepare = vfio_save_prepare,
>       .save_setup = vfio_save_setup,
> @@ -814,7 +1214,9 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
>       .load_state = vfio_load_state,
> +    .load_state_buffer = vfio_load_state_buffer,
>       .switchover_ack_needed = vfio_switchover_ack_needed,
> +    .switchover_start = vfio_switchover_start,
>   };
>   
>   /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9d547cb5cdff..72d62ada8a39 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3384,6 +3384,8 @@ static Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   qdev_prop_on_off_auto_mutable, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1bebe9877d88..418b378ebd29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -153,6 +153,12 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
>   vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
> +vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_start(const char *name) " (%s)"
> +vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
> +vfio_load_state_device_buffer_end(const char *name) " (%s)"
>   vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b1c03a82eec8..0954d6981a22 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -61,6 +61,11 @@ typedef struct VFIORegion {
>       uint8_t nr; /* cache the region number for debug */
>   } VFIORegion;
>   
> +/* type safety */
> +typedef struct VFIOStateBuffers {
> +    GArray *array;
> +} VFIOStateBuffers;
> +
>   typedef struct VFIOMigration {
>       struct VFIODevice *vbasedev;
>       VMChangeStateEntry *vm_state;
> @@ -73,10 +78,23 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       bool initial_data_sent;
>   
>       bool event_save_iterate_started;
>       bool event_precopy_empty_hit;
> +
> +    QemuThread load_bufs_thread;
> +    bool load_bufs_thread_running;
> +    bool load_bufs_thread_want_exit;
> +
> +    VFIOStateBuffers load_bufs;
> +    QemuCond load_bufs_buffer_ready_cond;
> +    QemuCond load_bufs_thread_finished_cond;
> +    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
> +    uint32_t load_buf_idx;
> +    uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMigration;
>   
>   struct VFIOGroup;
> @@ -136,6 +154,7 @@ typedef struct VFIODevice {
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
>       bool migration_events;
> +    uint64_t migration_max_queued_buffers;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
>       unsigned int num_regions;
> 


Thanks,

C.





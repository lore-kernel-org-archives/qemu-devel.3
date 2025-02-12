Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF44C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiG9L-0000WH-SR; Wed, 12 Feb 2025 12:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiG9J-0000L9-8r
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiG9F-00072h-W4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739379819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aFMlFddybkqWcRzWjPFQYBd4TB6PAo2oP/gRGfQDCpo=;
 b=U12+Yw8mreYuUthgkLZ1F16u4F2Y5oGlezaJ209XkQyEmzyE/J1Tmm7bm3DhCt7Uw7d5UM
 IoCoGVaglxv/MLDnBBdvaferD3GyUCAr8PWMxG+fXxNdO47HPwx5qu4O7IcLmxBCxQDgN+
 iI/8McbSlGuTu54SzBz/1E4CQEPDDI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-3Yju7qTwMg-75ZhSt8L8sA-1; Wed, 12 Feb 2025 12:03:37 -0500
X-MC-Unique: 3Yju7qTwMg-75ZhSt8L8sA-1
X-Mimecast-MFC-AGG-ID: 3Yju7qTwMg-75ZhSt8L8sA_1739379816
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc709f938so639368f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739379816; x=1739984616;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFMlFddybkqWcRzWjPFQYBd4TB6PAo2oP/gRGfQDCpo=;
 b=FyFTYQRp2qVIKs3TyQAUlcCPbR0MAP58AqmUvzn5vLxreOZP/SiyDqWdoyWQhGOVsH
 ZKckYs5iofepmzp4Cqo33Evt/jEVqofNLSZ29QpDPkxnkUZk1rYV+x4zDASZ0zFfr/78
 gCLpJh282PtSApiwrREBHVNeAFt2+W2ngUwowOtYqDeJJawE0wcAtRrGJmVOvLxNmhEQ
 OBzLp6egqJ59ybtCPfvVlQtMXmRVqTIggkcxfyBGPOr/u+Z6v6nlCXtYvbbq9d76WuTc
 csDdlRZ/DMvXckIlZu9eJpng9aFt9/q+9enVXaWmQjXHnPcnctxWBlct6aHwQAp03H6X
 zWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbXHdAxQ5+KMVBB+lCIehF4WdEepVUVBYSHvSjyB8oYI1yz89XDLcI9YvYkKcwIbvDTiFXotmwMvtS@nongnu.org
X-Gm-Message-State: AOJu0Yw3VebHaVq6G0cfk68J+IcygCfUOlIHLRHtSJwMyXmymXwLUg97
 1JyaihV5QkLCGEdnTgZaYC+vqnhfbMKVkYy6gpD0YZ9Swq4s1QDfPnaWQ4U7pSGtulzqtgHFWBh
 H+n/tJjnPKCiPkQuiMe5E9ibK2LQD2+C2gr0Ov6CypQUzUbD/xR46
X-Gm-Gg: ASbGncuLdUVowDia9FSTYQFaugg2XjCahM3BvaANKJU5soBYa4c6lTGnxYgVi9mwamM
 yCqsjgtZBkHMmguGpOqsGdlIZshuIOj6nw3ZGlQBlVQDrlwoXSb0iaVD+tfsTtajm3nRLc47bod
 NspO+DpFjOxa8+JUQWVtY/BoxrL1z9seajVgftxSvKpRo0zRbusqTxzsFzN6ZpS1FI2gcqfbtAe
 km87tFnm6B0MHsYvxD+vRSF94FiPvN2f/RbguqJbKQgHrBOxgIhOJ4BeN+Rd2s1z6GGllpXC4Zy
 yb3vNvokc6Txe7a7Y0OZ4rbFd1XcBwQImXb8Gw5PApE=
X-Received: by 2002:a05:6000:4024:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-38f2467a8aamr22117f8f.18.1739379814400; 
 Wed, 12 Feb 2025 09:03:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIAhbSEDdQseG/5BPL+A/P6+bMvgyA8qH0MVoGNwjmtZnhqslStTmLQ0tQ/bk4P8xWFwcxfg==
X-Received: by 2002:a05:6000:4024:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-38f2467a8aamr21966f8f.18.1739379812368; 
 Wed, 12 Feb 2025 09:03:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055859sm25453385e9.10.2025.02.12.09.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:03:31 -0800 (PST)
Message-ID: <adfcab18-549c-4a15-be87-1ca73ffffa0f@redhat.com>
Date: Wed, 12 Feb 2025 18:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/33] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <6c79a4f61f0b8bee30cda8242af7f51856392051.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <6c79a4f61f0b8bee30cda8242af7f51856392051.1738171076.git.maciej.szmigiero@oracle.com>
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
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
> 
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending on the
> x-migration-multifd-transfer device property value.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c  | 159 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/trace-events |   2 +
>   2 files changed, 161 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 31f651ffee85..37d1c0f3d32f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -943,6 +943,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
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

Please implement a common routine vfio_multifd_is_enabled() that can be
shared with vfio_load_setup().

> +
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>   
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -1114,13 +1132,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       return !migration->precopy_init_size && !migration->precopy_dirty_size;
>   }
>   
> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)

I would prefer naming it vfio_multifd_emit_dummy_eos().

> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    assert(migration->multifd_transfer);
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>       int ret;
>       Error *local_err = NULL;
>   
> +    if (migration->multifd_transfer) {
> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -1146,12 +1183,133 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       return ret;
>   }
>   
> +static int
> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
> +                                                     char *idstr,
> +                                                     uint32_t instance_id,
> +                                                     uint32_t idx)

why use 'async_thread' in the name ?

vfio_save_complete_precopy_config_state() should be enough to refer
to its caller vfio_save_complete_precopy_thread(). Please add
an 'Error **' argument too.


> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);

I would prefer that we catch the error and propagate it to the caller.

> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        return -1;
> +    }
> +
> +    qatomic_add(&bytes_transferred, packet_len);
> +
> +    return 0;
> +}
> +
> +static int vfio_save_complete_precopy_thread(char *idstr,
> +                                             uint32_t instance_id,
> +                                             bool *abort_flag,
> +                                             void *opaque)

This lacks an "Error **" argument. I am not sure what was decided
in patch 19 "migration: Add save_live_complete_precopy_thread
handler".

We should do our best to collect and propagate errors and avoid
error_report() calls. With VFIO involved, the reasons why errors
can occur are increasingly numerous, as hardware is exposed and
host drivers are involved.

I understand this is a complex request for code when this code
relies on a framework using callbacks, even more with threads.

> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!migration->multifd_transfer) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */

why would vfio_save_complete_precopy_thread be called then ? Looks
like an error to me, may be not fatal but an error report would be
good to have. no ?

> +        return 0;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  idstr, instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                   VFIO_DEVICE_STATE_STOP, NULL);

Error missing.

> +    if (ret) {
> +        goto ret_finish;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (qatomic_read(abort_flag)) {
> +            ret = -ECANCELED;
> +            goto ret_finish;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            ret = -errno;
> +            goto ret_finish;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(idstr, instance_id,
> +                                        (char *)packet, packet_size)) {
> +            ret = -1;
> +            goto ret_finish;
> +        }
> +
> +        qatomic_add(&bytes_transferred, packet_size);
> +    }
> +
> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
> +                                                               instance_id,
> +                                                               idx);
> +
> +ret_finish:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   static void vfio_save_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
>       Error *local_err = NULL;
>       int ret;
>   
> +    if (migration->multifd_transfer) {
> +        if (vfio_load_config_after_iter(vbasedev)) {
> +            qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY);


Please put the above chunck at the end of the series with the patch
adding ARM support.

> +        } else {
> +            vfio_save_multifd_emit_dummy_eos(vbasedev, f);
> +        }

Please introduce a vfio_multifd_save_state() routine and a
vfio_"normal"_save_state() routine and change vfio_save_state()
to call one or the other.


Thanks,

C.



> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -1372,6 +1530,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 418b378ebd29..039979bdd98f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -168,6 +168,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_start(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
> 



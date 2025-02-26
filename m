Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704F1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 16:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnKW0-0008HJ-6J; Wed, 26 Feb 2025 11:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKVU-0008DK-5c
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnKVQ-0002zT-6K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740588209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HxU5M6vnicZ7Bo7hEnTLbf8/HW87gfzsxev2MeIvj3o=;
 b=Bc1rk8hRmaDqpzWl43OPCpAq1qnQbBNdYkpX995xn1p0D+Rdq4B5Nnm10bjxMxvU1Y+zJA
 Os04gAuMuRiNXgMqPifmLy2Qk/brfew0AWaQuwzseHNJquOLWE10lzLZaqsX7JdUlSkauQ
 eHCOwXhbiaFRjFYeZ40OzImBld0Bt/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-pKmcUxSZMJa9ziQmH4Uu9Q-1; Wed, 26 Feb 2025 11:43:27 -0500
X-MC-Unique: pKmcUxSZMJa9ziQmH4Uu9Q-1
X-Mimecast-MFC-AGG-ID: pKmcUxSZMJa9ziQmH4Uu9Q_1740588206
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394b8bd4e1so189945e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740588206; x=1741193006;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxU5M6vnicZ7Bo7hEnTLbf8/HW87gfzsxev2MeIvj3o=;
 b=J4ipbz28wEoHQMrm4Z7jWyilQZ/zz+ob9EchjRZJGRF1J662fy/eNsm7saJ3omFNRw
 QrfRA/CfAvB9suF0d0vdOZDiQWTcsDRUdS3FKUmxe7Qu9uAC8u9RXWd2HyWR85sQP95Z
 tlu/Xhpfbk9RBK3WZz4AjcwCIO9JQ6w06ZqeZidMrdqR8lXD55/xf2ZaY6qiy7RGdyHA
 7/xbxBU0HMm34H8RffzKIALUO1oP2ldUKKcnA29zhlqKjqOZSwzvFJhJLc/lD6a5qXM7
 fowyDWqRfT2klW6SgQCYpGcc+WXeIOCoX2pC/ztqchMhcZoDpD1wqUTWEDYPaS0QmRzg
 O5AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvfKBiEhg8yEhrNaDNwP/MdcyUf6Xa+z8C8HOfMNvMvOMbW8yOYgujuF+pJgbBaM5uoVCDZIgwHFWS@nongnu.org
X-Gm-Message-State: AOJu0YwRDT4OctFMwoH7Wup3kc5agr+vqRvZ2Z1KrUoQoBicZEowuYP1
 Fimtr2BFRZBKGDhPENR+vSwLu8VS9qV6NrYBfWEr5TKh+ABFJ7sE/UbGD/Dyf2s4MQhEIvzPW50
 pE0HJ1ihnXm4kPfwSWx2qDcbna7ChNvuSHW0RBG+xWiPUHN8I6Fzx
X-Gm-Gg: ASbGnctN0uHfq0SA3kFkScRKUk12ejpjUGk5HQuF6e6arGlKX6yZtObdSYA4sT9sNO5
 dJEdLu2qb4hUP+NzZBI8tbKOBBKc9fLjGuEpTZJuWm8wKPb0G4GQCBq7/KNrgPQhMl4p07FwXC1
 kInqzKWj7/4yQsSsiKjVRmGCxdEsHNptpeDPWz58CkqKHa4A2YrtNyWl0UT/RRx7RZZux+2uNoo
 iHDb0UBF1tQRe4RrbRrSHz2yBVFWs01+ugxLzi3fkVkFZMaMKTdOw/qkoebuBo5N1aLPGIu4ndl
 h1lcCKrMkIhKmYzJpp99/xHgcciBqBOXX3uPsMjVQCWT37ms68rIgGeJMX4=
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr181372205e9.6.1740588205996; 
 Wed, 26 Feb 2025 08:43:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/tJ9RraU9iOfYRO8cdxDS4RBvZgi53AMNKV6f4xYDx8RPH/pCNFJqoz06FgN45ETHyZd/Yw==
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr181371935e9.6.1740588205516; 
 Wed, 26 Feb 2025 08:43:25 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2c50dcfsm45568865e9.0.2025.02.26.08.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:43:24 -0800 (PST)
Message-ID: <59f0710b-fac6-4a37-9e0d-2cddd43eee24@redhat.com>
Date: Wed, 26 Feb 2025 17:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
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
>   hw/vfio/migration-multifd.c   | 139 ++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h   |   5 ++
>   hw/vfio/migration.c           |  26 +++++--
>   hw/vfio/trace-events          |   2 +
>   include/hw/vfio/vfio-common.h |   8 ++
>   5 files changed, 174 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 7200f6f1c2a2..0cfa9d31732a 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -476,6 +476,145 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>   
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    assert(vfio_multifd_transfer_enabled(vbasedev));
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
> +static bool
> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
> +                                               char *idstr,
> +                                               uint32_t instance_id,
> +                                               uint32_t idx,
> +                                               Error **errp)
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
> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
> +        return false;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        error_setg(errp, "save config state flush failed: %d", ret);
> +        return false;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        error_setg(errp, "multifd config data queuing failed");
> +        return false;
> +    }
> +
> +    vfio_add_bytes_transferred(packet_len);
> +
> +    return true;
> +}
> +
> +/*
> + * This thread is spawned by the migration core directly via
> + * .save_live_complete_precopy_thread SaveVMHandler.
> + *
> + * It exits after either:
> + * * completing saving the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by
> + *   multifd_device_state_save_thread_should_exit() returning true.
> + */
> +bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                       Error **errp)

In qemu_savevm_state_complete_precopy_iterable(), this handler is
called :

     ....
     if (multifd_device_state) {
         QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
             SaveLiveCompletePrecopyThreadHandler hdlr;

             if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
                              se->ops->has_postcopy(se->opaque)) ||
                 !se->ops->save_live_complete_precopy_thread) {
                 continue;
             }

             hdlr = se->ops->save_live_complete_precopy_thread;
             multifd_spawn_device_state_save_thread(hdlr,
                                                    se->idstr, se->instance_id,
                                                    se->opaque);
         }
     }


I suggest naming it : vfio_multifd_save_complete_precopy_thread()

> +{
> +    VFIODevice *vbasedev = d->handler_opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    bool ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return true;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  d->idstr, d->instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                 VFIO_DEVICE_STATE_STOP, errp)) {
> +        ret = false;

These "ret = false" can be avoided if the variable is set at the
top of the function.

> +        goto ret_finish;


goto thread_exit ?
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (multifd_device_state_save_thread_should_exit()) {
> +            error_setg(errp, "operation cancelled");
> +            ret = false;
> +            goto ret_finish;
> +        }> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            error_setg(errp, "reading state buffer %" PRIu32 " failed: %d",
> +                       idx, errno);
> +            ret = false;
> +            goto ret_finish;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(d->idstr, d->instance_id,
> +                                        (char *)packet, packet_size)) {
> +            error_setg(errp, "multifd data queuing failed");
> +            ret = false;
> +            goto ret_finish;
> +        }
> +
> +        vfio_add_bytes_transferred(packet_size);
> +    }
> +
> +    ret = vfio_save_complete_precopy_thread_config_state(vbasedev,
> +                                                         d->idstr,
> +                                                         d->instance_id,
> +                                                         idx, errp);
> +
> +ret_finish:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 09cbb437d9d1..79780d7b5392 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -25,6 +25,11 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>   bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>   
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
> +
> +bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                       Error **errp);
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev);
>   
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b962309f7c27..69dcf2dac2fa 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -120,10 +120,10 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>       vfio_migration_send_event(vbasedev);
>   }
>   
> -static int vfio_migration_set_state(VFIODevice *vbasedev,
> -                                    enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state,
> -                                    Error **errp)
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -238,8 +238,7 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> -                                         Error **errp)
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       int ret;
> @@ -453,6 +452,10 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
>   
> +    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
> +        return -EINVAL;
> +    }
> +

please move to another patch with the similar change of patch 25.


>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>   
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -631,6 +634,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>   
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -662,6 +670,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>       Error *local_err = NULL;
>       int ret;
>   
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -819,6 +832,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
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
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ce2bdea8a2c2..ba851917f9fc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,14 @@ void vfio_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>   
> +#ifdef CONFIG_LINUX
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);

please move below with the other declarations under #ifdef CONFIG_LINUX.

> +#endif
> +
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>   int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>   
>   #ifdef CONFIG_LINUX
> 



Thanks,

C.





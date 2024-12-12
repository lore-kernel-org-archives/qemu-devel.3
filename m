Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh63-0005UH-DM; Thu, 12 Dec 2024 06:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLh5y-0005Lx-TU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLh5w-0004gN-C0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734001857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BwsoNpTeC55PQxPd0Kr27cDLJKauCHNLy6rW/xw0ogg=;
 b=KIlWwzNUFm4/Ewj8yOdWnlW4AmOKOF8In25Ncg9qFb/BGgYseg2AhDkvLDUK9d3LQ5Fpm2
 N8dMb3aqdKPdIvj9mGm3kOF/L76McvttuxUcQdQ232RegHHcLM6gFBGvQOWVSsLW1V2fU6
 6WXw1rmWRPo5IFC4gj+rES6lX1BsvD8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-vHdiDDmYN3u7YTcZYO4tpg-1; Thu, 12 Dec 2024 06:10:53 -0500
X-MC-Unique: vHdiDDmYN3u7YTcZYO4tpg-1
X-Mimecast-MFC-AGG-ID: vHdiDDmYN3u7YTcZYO4tpg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so3889605e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 03:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734001852; x=1734606652;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwsoNpTeC55PQxPd0Kr27cDLJKauCHNLy6rW/xw0ogg=;
 b=QqXACxv0gPJ3n2eSiBVWCQOOhBxNHCSOo9aKVhwwkWHkI+BBqYl0ebcTabscemwDjz
 e9vHZZzy9zkB2DAPhhA97tCxZ0kXfJ/AfIU9bLpi/ACSvfQPzVzUG7mH5o61ZOmGjw4F
 vbCG3p+aIGhLhc9hAjh65punXXQEyYQ1okh1j4T6w6Rw1+Dvbxrm3ycTc0q6qOFWhCKc
 lsDK6+X1wrT4LM8WYEIbjAaqwtqfiaC2k/Pfj/z1U6YHS+G8iXujLJU0FcuVc/dYp6Lo
 qvMIY5l/v9yW6UMp3AGFoi2krRCx4NQitT64/HnD9d//uUs5tEG1/WNwWJi/QwTJJ7Y/
 ZFlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8PlEASegeDokx2X6gZ+lzaug0xLPDcOYH10NFAxnW4Cb5iv4NHiZW55wbk49DsRe8O9gl84I9k5TN@nongnu.org
X-Gm-Message-State: AOJu0YyLJcoZCmuBEF6SKKJoB+i+hq0FqiXq1Q2GpnHrJi5G3KS1qCz0
 1/jZxdxNPSNc634k5hrKdb7mZihZOXJLun77P7L5sZKeUvEHlJgPtMopOmNMEM84CLa9YihKRlE
 d6hphKe3JVvSyAczaqMJaJn2YLtdm8W3NIYzTAqA1fhyuODrkoHGo
X-Gm-Gg: ASbGncvqezE/wrxhsNNPid1NDRk0cxJmGIA54X2RP7k9uHSMcIq+hmfDSvcVzx/pPhv
 9YPKXRD4yp4xexjO1oxWirwRXqfuKtkHKT9JFwa95yNmrGgTv4l6+6ZZg61biXEz/wHyVyGX+6K
 UBYEsGv9dyYoLcSDj+/hN99PHZOA5M+Wgii7mD0hKkvIZdP9RupAGFKIDn1X62qZFM8XyBNTjXd
 5FNkYOuvj6rfckDiOgsaHo3AQ8cLF0j1to4ealpUeUKMspZ9rL1I9mQ5GhCQApZkgBGN6nNq+7U
 eFI=
X-Received: by 2002:a05:600c:35cb:b0:434:f9ad:7238 with SMTP id
 5b1f17b1804b1-4362286391fmr21422935e9.22.1734001852589; 
 Thu, 12 Dec 2024 03:10:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVwsD3UW6jAN1TVo2o6RliaCMX6QRFV4GkVhBRtgeRSYOywt2MDXdZVD08G4j3HMGDmrWQug==
X-Received: by 2002:a05:600c:35cb:b0:434:f9ad:7238 with SMTP id
 5b1f17b1804b1-4362286391fmr21422735e9.22.1734001852161; 
 Thu, 12 Dec 2024 03:10:52 -0800 (PST)
Received: from [10.33.192.233] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553358sm13552935e9.6.2024.12.12.03.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 03:10:51 -0800 (PST)
Message-ID: <80c9dfc4-4105-4e48-bcae-4fa9780a43c8@redhat.com>
Date: Thu, 12 Dec 2024 12:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
 <51279885-5229-4c5f-93af-d1214dd65f90@nvidia.com>
 <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <06360868-95e3-46e2-8960-51348025a1b7@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On 12/11/24 00:06, Maciej S. Szmigiero wrote:
> On 9.12.2024 10:28, Avihai Horon wrote:
>>
>> On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Implement the multifd device state transfer via additional per-device
>>> thread inside save_live_complete_precopy_thread handler.
>>>
>>> Switch between doing the data transfer in the new handler and doing it
>>> in the old save_state handler depending on the
>>> x-migration-multifd-transfer device property value.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
>>>   hw/vfio/trace-events |   2 +
>>>   2 files changed, 157 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index b54879fe6209..8709672ada48 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>>       int ret;
>>>
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
>>> +
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>
>>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>> @@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>>       return !migration->precopy_init_size && !migration->precopy_dirty_size;
>>>   }
>>>
>>> +static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +
>>> +    assert(migration->multifd_transfer);
>>> +
>>> +    /*
>>> +     * Emit dummy NOP data on the main migration channel since the actual
>>> +     * device state transfer is done via multifd channels.
>>> +     */
>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>> +}
>>> +
>>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>>       ssize_t data_size;
>>>       int ret;
>>>       Error *local_err = NULL;
>>>
>>> +    if (migration->multifd_transfer) {
>>> +        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
>>> +        return 0;
>>> +    }
>>
>> I wonder whether we should add a .save_live_use_thread SaveVMHandlers through which a device can indicate if it wants to save its data with the async or sync handler.
>> This will allow migration layer (i.e., qemu_savevm_state_complete_precopy_iterable) to know which handler to call instead of calling both of them and letting each device implicitly decide.
>> IMHO it will make the code clearer and will allow us to drop vfio_save_multifd_emit_dummy_eos().
> 
> I think that it's not worth adding a new SaveVMHandler just for this specific
> use case, considering that it's easy to handle it inside driver by emitting that
> FLAG_END_OF_STATE.
> 
> Especially considering that for compatibility with other drivers that do not
> define that hypothetical new SaveVMHandler not having it defined would need to
> have the same effect as it always returning "false".
> 
>>> +
>>>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>>>
>>>       /* We reach here with device state STOP or STOP_COPY only */
>>> @@ -974,12 +1011,129 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>       return ret;
>>>   }
>>>
>>> +static int
>>> +vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
>>> +                                                     char *idstr,
>>> +                                                     uint32_t instance_id,
>>> +                                                     uint32_t idx)
>>> +{
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    g_autoptr(QEMUFile) f = NULL;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    size_t packet_len;
>>> +
>>> +    bioc = qio_channel_buffer_new(0);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>> +
>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +
>>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qemu_fflush(f);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>> +    packet = g_malloc0(packet_len);
>>> +    packet->idx = idx;
>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>>> +
>>> +    if (!multifd_queue_device_state(idstr, instance_id,
>>> +                                    (char *)packet, packet_len)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    qatomic_add(&bytes_transferred, packet_len);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_save_complete_precopy_thread(char *idstr,
>>> +                                             uint32_t instance_id,
>>> +                                             bool *abort_flag,
>>> +                                             void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    uint32_t idx;
>>> +
>>> +    if (!migration->multifd_transfer) {
>>> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
>>> +        return 0;
>>> +    }
>>> +
>>> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
>>> +                                                  idstr, instance_id);
>>> +
>>> +    /* We reach here with device state STOP or STOP_COPY only */
>>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>>> +                                   VFIO_DEVICE_STATE_STOP, NULL);
>>> +    if (ret) {
>>> +        goto ret_finish;
>>> +    }
>>> +
>>> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
>>> +
>>> +    for (idx = 0; ; idx++) {
>>> +        ssize_t data_size;
>>> +        size_t packet_size;
>>> +
>>> +        if (qatomic_read(abort_flag)) {
>>> +            ret = -ECANCELED;
>>> +            goto ret_finish;
>>> +        }
>>> +
>>> +        data_size = read(migration->data_fd, &packet->data,
>>> +                         migration->data_buffer_size);
>>> +        if (data_size < 0) {
>>> +            ret = -errno;
>>> +            goto ret_finish;
>>> +        } else if (data_size == 0) {
>>> +            break;
>>> +        }
>>> +
>>> +        packet->idx = idx;
>>> +        packet_size = sizeof(*packet) + data_size;
>>> +
>>> +        if (!multifd_queue_device_state(idstr, instance_id,
>>> +                                        (char *)packet, packet_size)) {
>>> +            ret = -1;
>>> +            goto ret_finish;
>>> +        }
>>> +
>>> +        qatomic_add(&bytes_transferred, packet_size);
>>> +    }
>>> +
>>> +    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
>>> +                                                               instance_id,
>>> +                                                               idx);
>>
>> I am not sure it's safe to save the config space asyncly in the thread, as it might be dependent on other device's non-iterable state being loaded first.
>> See commit d329f5032e17 ("vfio: Move the saving of the config space to the right place in VFIO migration") which moved config space saving to the non-iterable state saving.
> 
> That's an important information - thanks for pointing this out.
> 
> Since we don't want to lose this config state saving parallelism
> (and the future config state saving parallelism) on unaffected platform
> we'll probably need to disable this functionality for ARM64.
> 
> By the way, this kind of an implicit dependency in VMState between devices
> is really hard to manage, there should be a way to specify it in code somehow..

vmstate has a MigrationPriority field to order loading between
devices. Maybe we could extend but I think it is better to handle
ordering at the device level when there are no external dependencies.
It should be well documented though in the code.



Thanks,

C.


> 
>> Thanks.
> 
> Thanks,
> Maciej
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E30EEEB569
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofeO-0000sL-8z; Thu, 12 Sep 2024 04:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sofeM-0000je-9M
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sofeJ-0001AS-TD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726131478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgVMKgzboGhgR7b+g+q0Ph2ioTae9aXEF30j2+zdgB4=;
 b=OEyDDivdYkcNlfeLMQ9q/pWgv9LQyiCddOkRHzzlXg88pji6yTi58MdtE2tr9nCGbsB/yU
 U9gl6cAB0hOHmuP4Q8CWma7toshfHCtc+IEMEprY/v7SqDYQAWAGlDF83FyZycBrDPHm9Y
 WM0tB/N7Cdok1/1hh8ji0VQQ7lLiSe4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-F2__5F4nM4a1glF08v5zLQ-1; Thu, 12 Sep 2024 04:57:56 -0400
X-MC-Unique: F2__5F4nM4a1glF08v5zLQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb115566eso5859185e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726131475; x=1726736275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UgVMKgzboGhgR7b+g+q0Ph2ioTae9aXEF30j2+zdgB4=;
 b=TPJN5yg1xgepsDFQqAHfq23Hi+4EdDUT0LZSihOFjZXZ1n+a4DAz1yFehyHfto7V4P
 gIfucTGy9G8J+b0vjXNyqFTruM74Pz01+Wsy0Z5g7lk7G6G1jJNOYUjmqgwn2hUJj1wI
 uNQpDuKVeYvwy6o6rujhk9fGuRMn6A+eNMkpFYEE5JuRECT8K+d3KYVekWIk4ITTae6f
 u61DfZ3l3CtGNqQ1l1fBWPZX6tkLqfNce/VJu3u+hIGCLzGxlEeUczTHUrnvVHGdhADw
 1ctKBpPWg4K20Tx/ICQkdFyDA0jrFB950b0hew7RgwS5B0b63V53BFX+O3/6UfHw0Fdd
 UZnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYcrUhbktOhJtZjRS8U1ansygPHUTPVIV9TCW7loNYyAfQ/u+4kUPAg1hi+PwydZWayjYMLEOw70YO@nongnu.org
X-Gm-Message-State: AOJu0Yz3IFtEtdwpNL+Fd6lv1TyUiRQWMLBOMkTyNK+bVR+DsoD8r3vS
 e9OPaVh8xuxLxuaNkpUkTAQExP0sN9mHfURsyaMfqEAuaVfXZgr2LLBZZbE/iaYJ2TS1Yl/bs5A
 nJLnqwSnwkoYaXUcJqhnMd7x5AcK0DzKGOFObqj+K23K66tOrnGuG
X-Received: by 2002:a05:600c:198b:b0:42c:bd5a:9455 with SMTP id
 5b1f17b1804b1-42cdb548dfemr22070625e9.18.1726131474925; 
 Thu, 12 Sep 2024 01:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj1/7yeGci8zkZRkOAmhak4nG2chihnylceC5ZrehklBl2pezMS5FVA4Kh11k9XjzXmEgwYg==
X-Received: by 2002:a05:600c:198b:b0:42c:bd5a:9455 with SMTP id
 5b1f17b1804b1-42cdb548dfemr22070435e9.18.1726131474431; 
 Thu, 12 Sep 2024 01:57:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956655fcsm13708138f8f.38.2024.09.12.01.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 01:57:53 -0700 (PDT)
Message-ID: <d4510e72-9404-4137-a8c0-0136c37bcc92@redhat.com>
Date: Thu, 12 Sep 2024 10:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] vfio/migration: Multifd device state transfer
 support - send side
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
 <d801c59f-60da-4d42-ae0f-c70d99c45990@nvidia.com>
 <a7cd0a2f-6dba-4fec-b63b-b7985e01608b@maciej.szmigiero.name>
 <9d3d7002-a15a-4c24-8ffb-de3de03b65eb@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9d3d7002-a15a-4c24-8ffb-de3de03b65eb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/12/24 10:26, Avihai Horon wrote:
> 
> On 09/09/2024 21:07, Maciej S. Szmigiero wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 9.09.2024 13:41, Avihai Horon wrote:
>>>
>>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Implement the multifd device state transfer via additional per-device
>>>> thread inside save_live_complete_precopy_thread handler.
>>>>
>>>> Switch between doing the data transfer in the new handler and doing it
>>>> in the old save_state handler depending on the
>>>> x-migration-multifd-transfer device property value.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c           | 169 ++++++++++++++++++++++++++++++++++
>>>>   hw/vfio/trace-events          |   2 +
>>>>   include/hw/vfio/vfio-common.h |   1 +
>>>>   3 files changed, 172 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 57c1542528dc..67996aa2df8b 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -655,6 +655,16 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>>>       int ret;
>>>>
>>>> +    /* Make a copy of this setting at the start in case it is changed mid-migration */
>>>> +    migration->multifd_transfer = vbasedev->migration_multifd_transfer;
>>>
>>> Should VFIO multifd be controlled by main migration multifd capability, and let the per VFIO device migration_multifd_transfer property be immutable and enabled by default?
>>> Then we would have a single point of configuration (and an extra one per VFIO device just to disable for backward compatibility).
>>> Unless there are other benefits to have this property configurable?
>>
>> We want multifd device state transfer property to be configurable per-device
>> in case in the future we add another device type (besides VFIO) that supports
>> multifd device state transfer.
>>
>> In this case, we might need to enable the multifd device state transfer just
>> for VFIO devices, but not for this new device type when we are migrating to a
>> QEMU target that supports just the VFIO multifd device state transfer.
> 
> I think for this case we can use hw/core/machine.c:hw_compat_X_Y arrays [1].
> 
> [1] https://www.qemu.org/docs/master/devel/migration/compatibility.html#how-backwards-compatibility-works
> 
>>
>> TBH, I'm not opposed to adding a additional global multifd device state transfer
>> switch (if we keep the per-device ones too) but I am not sure what value it adds.
>>
>>>> +
>>>> +    if (migration->multifd_transfer && !migration_has_device_state_support()) {
>>>> +        error_setg(errp,
>>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>>> +                   vbasedev->name);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>>
>>>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>>> @@ -835,10 +845,20 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>>   {
>>>>       VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>       ssize_t data_size;
>>>>       int ret;
>>>>       Error *local_err = NULL;
>>>>
>>>> +    if (migration->multifd_transfer) {
>>>> +        /*
>>>> +         * Emit dummy NOP data, vfio_save_complete_precopy_thread()
>>>> +         * does the actual transfer.
>>>> +         */
>>>> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>
>>> There are three places where we send this dummy end of state, maybe worth extracting it to a helper? I.e., vfio_send_end_of_state() and then document there the rationale.
>>
>> I'm not totally against it but it's wrapping just a single line of code in
>> a separate function?
> 
> Yes, it's more for self-documentation purpose and for not duplicating comments.
> I guess it's a matter of taste, so we can go either way and let maintainer decide.

I'd prefer an helper too. This comment applies to all additions
in pre-existing code. Ideally new routines should have a
'vfio_{migration,save,load}_multifd' prefix so that the reader
understands what the code is for.


Thanks,

C.


> 
>>
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> trace_vfio_save_complete_precopy_started(vbasedev->name);
>>>>
>>>>       /* We reach here with device state STOP or STOP_COPY only */
>>>> @@ -864,12 +884,159 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>>       return ret;
>>>>   }
>>>>
>>>> +static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
>>>> + char *idstr,
>>>> + uint32_t instance_id,
>>>> + uint32_t idx)
>>>> +{
>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>> +    QEMUFile *f = NULL;
>>>> +    int ret;
>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>> +    size_t packet_len;
>>>> +
>>>> +    bioc = qio_channel_buffer_new(0);
>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>>> +
>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>> +
>>>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>>>> +    if (ret) {
>>>> +        return ret;
>>>
>>> Need to close f in this case.
>>
>> Right - by the way, that's a good example why RAII
>> helps avoid such mistakes.
> 
> Agreed :)
> 
>>
>>>> +    }
>>>> +
>>>> +    ret = qemu_fflush(f);
>>>> +    if (ret) {
>>>> +        goto ret_close_file;
>>>> +    }
>>>> +
>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>> +    packet = g_malloc0(packet_len);
>>>> +    packet->idx = idx;
>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>>>> +
>>>> +    if (!multifd_queue_device_state(idstr, instance_id,
>>>> +                                    (char *)packet, packet_len)) {
>>>> +        ret = -1;
>>>
>>> goto ret_close_file?
>>
>> Right, it would be better not to increment the counter in this case.
>>
>>>> +    }
>>>> +
>>>> +    bytes_transferred += packet_len;
>>>
>>> bytes_transferred is a global variable. Now that we access it from multiple threads it should be protected.
>>
>> Right, this stat needs some concurrent access protection.
>>
>>> Note that now the VFIO device data is reported also in multifd stats (if I am not mistaken), is this the behavior we want? Maybe we should enhance multifd stats to distinguish between RAM data and device data?
>>
>> Multifd stats report total size of data transferred via multifd so
>> they should include device state too.
> 
> Yes I agree. But now we are reporting double the amount of VFIO data that we actually transfer (once in "vfio device transferred" and another in multifd stats) and this may be misleading.
> So maybe we should add a dedicated multifd device state counter and report VFIO multifd bytes there instead of in bytes_transferred?
> We can wait for other people's opinion about that.
> 
>>
>> It may make sense to add a dedicated device state transfer counter
>> at some time though.
>>
>>>> +
>>>> +ret_close_file:
>>>
>>> Rename to "out" as we only have one exit point?
>>>
>>>> +    g_clear_pointer(&f, qemu_fclose);
>>>
>>> f is a local variable, wouldn't qemu_fclose(f) be enough here?
>>
>> Sure, but why leave a dangling pointer?
>>
>> Currently, it is obviously a NOP (probably deleted by dead store
>> elimination anyway) but the code might get refactored at some point
>> and I think it's good practice to always NULL pointers after freeing
>> them where possible and so be on the safe side.
> 
> Ack.
> 
> Thanks.
> 



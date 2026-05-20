Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E8FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkEv-0003xF-7D; Wed, 20 May 2026 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPkEt-0003wo-Fc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPkEr-0003MT-Ao
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779296263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OYqtauFyo/4MgxG71drVMk+aqgxpX+a4AuzwMGsS/Q8=;
 b=F/0JkfkA5cdZVX8FSukmznLZYYKlK8co2m3QFT8SBCVid6y5BywFpXLC8//KqJrRiL9vmk
 nLoGu+NS8c4EjhSC7aaPeyc24tHXrr9tX1K0fz5TZsEuRFxdXYKnsvUsSiMTNJBl3On7Am
 XlJq37lCBLHShRflHZV6Hyvn3vT8HXQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-pxbKfe5YNPmBCm5PjdMo2g-1; Wed, 20 May 2026 12:57:39 -0400
X-MC-Unique: pxbKfe5YNPmBCm5PjdMo2g-1
X-Mimecast-MFC-AGG-ID: pxbKfe5YNPmBCm5PjdMo2g_1779296259
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44a71109b94so3821865f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779296258; x=1779901058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OYqtauFyo/4MgxG71drVMk+aqgxpX+a4AuzwMGsS/Q8=;
 b=LfyNtNLj0zLHryZhoRR9fUq5tLUocQIRm7wzwea8pKm01YZQntd1uh1zmG4+PkXqZz
 /BjXW/uczFcZXL0qG1HZAS4b1c6wWnzhl3HztNhr49hrg+rDMaO9qbH7OYVTyhrrAZE6
 Rt7Its4WzCv6JH4/VAphVhiS9rjufWiQ6VTudQmrKFyZyZ8Kl+TIPk40/Fg9MEft6AFZ
 SGVLMr4j8wqP9o/bpaj1aleP4+KergXivDEOAQB7HuCSV6CkCBvK/39FT7YNj8dvx0df
 A2AUIk37UC/snVpjlihcDbn+G46wbcF9pA8lVAdKXhxxMeHsVunSRPLLVcwChodZsedO
 qPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296258; x=1779901058;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYqtauFyo/4MgxG71drVMk+aqgxpX+a4AuzwMGsS/Q8=;
 b=G33SX/fvQBZTZigSWPmam5inkyyxucYcmgrXNpPENwJcKRh3xIZbVoow6LYNng61jQ
 /af4jv4pZWjqUWcRDkXXDvG2jXaofUznggw33bwfT0VdwTxyXuY444+wM2DMJo3ssXTB
 fepd7NTqQfkTAUWxDHenOGb/60Kk5M23GNr8RzVnlNvqZyYJQUsFqWYoUd1+D3iGGeNP
 TS5CS/eR8WDcW645Ktr0D+UsqO+Ip/epJph/5RK8WREohy7VJbIN/V7L435lKvKdIVNY
 vPpLtTeWTzNWBzL/qscAuHSJ5HAE4mKQALOd39Ce0jLxx29w/LhdoyOjNM9PJP+gm1KV
 V2iA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/I0zqjl/4JQBOrJuBu2BhblldtuyHwnhc5w/y64ZUiRAAq4XM46esfNV5mFp52pkHBiV9B2m8yhvHu@nongnu.org
X-Gm-Message-State: AOJu0YzfzHswA1n9v+sL6irc2+naQTRoQKcexb0OT3EzByiPx+NnCkzg
 VrR7l1/DFCKeefkN6/0U58dlmqtd+iTnr/e7WF2tneUuJbUr8V5INmw/NFbLVBMUIwT0S81r2zc
 QOegRIhBSmpVdUcC70gKpWBMz/r6haHevjeKOI+vgkINl8LlR79xo3SQr
X-Gm-Gg: Acq92OHNfzOzMK5XKWpSqF/AXfi7OdEWaN0QUctKj8gSMeN1sU0CvfWP5+fCV8aB1Mb
 iy689VEgPKOp4lXoRlP4+gzJnUwY8JhaJD6eZbmlkFpWzjioljOwb2Na1AqrdMLAkrEnYT+i4tK
 MVysHIk4vidor/kzL2MsdwhXMAN5sKzDNCjz+zHxKtwEOgrqVDA9y8nN1vo3cB3DFrpR5u7/R4s
 74WKwxELTCUpMziY0H1VNDQ/Ds8Np/U9TvigRwNMWH2fKdePbVkO6RiKdg43cmN9yR6Z8yo4LhD
 0rV4pYsTOkoguNRTW7wE5JvIPgxwAYZnDi9J5BRXglu9YWRGZHsKgKB5uOpXotYzMYME8pNYhF5
 1naY/sujA3/QAIaKK3kDE63pUeaaMJj28JMd7W6i+z7DtWuXAooEam+nFD3tC
X-Received: by 2002:a05:6000:40cc:b0:45a:c0e1:37b with SMTP id
 ffacd0b85a97d-45e5c5ccf6fmr40567515f8f.32.1779296258442; 
 Wed, 20 May 2026 09:57:38 -0700 (PDT)
X-Received: by 2002:a05:6000:40cc:b0:45a:c0e1:37b with SMTP id
 ffacd0b85a97d-45e5c5ccf6fmr40567465f8f.32.1779296257947; 
 Wed, 20 May 2026 09:57:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm51411495f8f.15.2026.05.20.09.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:57:37 -0700 (PDT)
Message-ID: <acba85f5-699f-4abc-a90d-db3b846747ee@redhat.com>
Date: Wed, 20 May 2026 18:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Detect and report overflow in migration
 size queries
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>
References: <20260513094522.346314-1-clg@redhat.com>
 <4cbb3e52-9b4e-477e-bb0e-0588036fa06d@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4cbb3e52-9b4e-477e-bb0e-0588036fa06d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/14/26 14:52, Avihai Horon wrote:
> 
> On 5/13/2026 12:45 PM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> VFIO migration ioctls (VFIO_DEVICE_FEATURE_MIG_DATA_SIZE and
>> VFIO_MIG_GET_PRECOPY_INFO) return device-estimated migration sizes as
>> uint64_t values. A misbehaving kernel driver could return values that
>> are unreasonably large, which would corrupt the size accounting used
>> to decide migration convergence.
>>
>> This misbehavior occurred a few times when testing migration of a VM
>> with an assigned NVIDIA vGPU and an MLX5 VF. In some of the save
>> iterations, the reported precopy and stopcopy sizes were unreasonably
>> large (close to UINT64_MAX):
>>
>>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073708667040 precopy dirty size 0
>>    vfio_save_iterate   (4fbce62c-8ce2-4cc9-b429-41635bc94f24) precopy initial size 18446744073707618464 precopy dirty size 0
>>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 18446744073708503040 precopy initial size 18446744073707618464 precopy dirty size 0
>>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073707618464 precopy dirty size 0
>>    vfio_state_pending  (0000:b1:01.0) stopcopy size 18446744073709543408 precopy initial size 0 precopy dirty size 1008
>>
>> This had the effect of corrupting migration convergence, as reported
>> by the HMP migrate command:
>>
>>    (qemu) info migrate
>>    Status:                 active
>>    Time (ms):              total=21140, setup=86, exp_down=152455434886355
>>    Remaining:              16 EiB
>>    RAM info:
>>      Throughput (Mbps):    967.98
>>      Sizes:                pagesize=4 KiB, total=4 GiB
>>      Transfers:            transferred=2.29 GiB, remain=4.7 MiB
>>        Channels:           precopy=1.91 GiB, multifd=0 B, postcopy=0 B, vfio=387 MiB
>>        Page Types:         normal=499427, zero=559708
>>      Page Rates (pps):     transfer=0, dirty=1892
>>      Others:               dirty_syncs=3
>>
>> Add a helper to detect values that exceed INT64_MAX, which is far
>> beyond any realistic device state size, and report them with an error
>> message. Return -ERANGE from the query functions so callers can abort
>> the migration rather than proceeding with corrupted estimates.
>> However, the callers don't yet check the return value to actually stop
>> the migration.
>>
>> Cc: Avihai Horon <avihaih@nvidia.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++----
>>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
> Can you tell if it was the vGPU or the mlx5 device who reported the overflowed value? Or both?

both. I have seen it far more on the vGPU side when loaded.

> Are we sure the driver is buggy? 

It's in the driver/FW area I would say. I am a bit too busy
currently to dig further but it's on my TODO list.

> E.g., do you see the overflowed values also in trace_vfio_query_precopy_size and trace_vfio_query_stop_copy_size (where we just queried the values and didn't touch them yet)?

yes.

This change is not changing the behavior (yet). It should
help to track the issue hopefully.

Thanks,

C.


> 
> Thanks.
> 
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 150e28656e97c5e8198541e5b6dfc4ed4102d143..fb12b9717f773fdde657911517de9d74c1eb3931 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -320,6 +320,18 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
>>       migration->data_fd = -1;
>>   }
>>
>> +static bool vfio_migration_check_overflow(VFIODevice *vbasedev, uint64_t size,
>> +                                          const char *name)
>> +{
>> +    if (size > INT64_MAX) {
>> +        error_report("%s: Estimated %s size overflow: 0x%"PRIx64,
>> +                     vbasedev->name, name, size);
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>>   {
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>> @@ -329,7 +341,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>>       struct vfio_device_feature_mig_data_size *mig_data_size =
>>           (struct vfio_device_feature_mig_data_size *)feature->data;
>>       VFIOMigration *migration = vbasedev->migration;
>> -    int ret;
>> +    int ret = 0;
>>
>>       feature->argsz = sizeof(buf);
>>       feature->flags =
>> @@ -347,7 +359,10 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>>                            vbasedev->name, ret);
>>       } else {
>>           migration->stopcopy_size = mig_data_size->stop_copy_length;
>> -        ret = 0;
>> +        if (vfio_migration_check_overflow(vbasedev, migration->stopcopy_size,
>> +                                          "stop copy size")) {
>> +            ret = -ERANGE;
>> +        }
>>       }
>>
>>       trace_vfio_query_stop_copy_size(vbasedev->name,
>> @@ -361,7 +376,7 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>>       struct vfio_precopy_info precopy = {
>>           .argsz = sizeof(precopy),
>>       };
>> -    int ret;
>> +    int ret = 0;
>>
>>       if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
>>           migration->precopy_init_size = 0;
>> @@ -370,9 +385,18 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>>           warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
>>                            "failed (%d)", migration->vbasedev->name, ret);
>>       } else {
>> +        bool overflow;
>> +
>>           migration->precopy_init_size = precopy.initial_bytes;
>>           migration->precopy_dirty_size = precopy.dirty_bytes;
>> -        ret = 0;
>> +
>> +        overflow  = vfio_migration_check_overflow(migration->vbasedev,
>> +                         migration->precopy_init_size,  "precopy init size");
>> +        overflow |= vfio_migration_check_overflow(migration->vbasedev,
>> +                         migration->precopy_dirty_size, "precopy dirty size");
>> +        if (overflow) {
>> +            ret = -ERANGE;
>> +        }
>>       }
>>
>>       trace_vfio_query_precopy_size(migration->vbasedev->name,
>> -- 
>> 2.54.0
>>
> 



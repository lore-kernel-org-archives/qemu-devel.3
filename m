Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037CAC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwRV-0005IJ-B1; Wed, 19 Mar 2025 12:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuwRS-00056T-CS
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuwRO-0007AZ-Ae
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742402326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Lpkew5Erp2e2H9mO4Icmytgr7jnJBlYMXErmI2Tq8Y=;
 b=BvAT0FKf5f9BYQKjUOrV+R3cytXzm3Z2MEm6kOPYYgmrFeG/6EOYjAonvZrqpugySgtEkT
 RLOe9Hc18P8kWG2AjbkrM0cCPo4LYcDNQNblwEhAx/Pz1m1U9IfFjIf6q5va1pBfijg2tR
 03fNSxURrRps6DExISVl5G78/3U9f1U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-nlWRGuFcNKWecuRfQo2QHg-1; Wed, 19 Mar 2025 12:38:43 -0400
X-MC-Unique: nlWRGuFcNKWecuRfQo2QHg-1
X-Mimecast-MFC-AGG-ID: nlWRGuFcNKWecuRfQo2QHg_1742402322
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913d8d7c3eso3997238f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402322; x=1743007122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Lpkew5Erp2e2H9mO4Icmytgr7jnJBlYMXErmI2Tq8Y=;
 b=T/7CN9b57TXKkif/mybaaATDC0nMt4vQGn8q+beenrTpF2QzJG27ZVHoXFIFQlc2MQ
 /wgIEfix4QAbt1zqoVD+YevNyyQGDyvvmA+5ZZ1s7LRPpy4A4Q/bOHOti6BXhyi6x7ey
 2mPr+g7+3SzM8QP6biYmnIhzbXorRyWQCZGMBFdwEMmbD7xAp+MRXFM5HR421EEw1FVb
 bkxvhLDwRLnqM8TMRApOOGB7ccq1Z02ujLVyFKPUBkj2CoHYBtbT8nPThIgWAtvASE6q
 l5TO7qVcr+2mVvVwqzhW5O/ygUNFMF6E0ShsJsTrBOo0S+m6kSa+JzSFIS8oaZ6bDTeG
 Oh/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2UbtxKoH1sxXx9PCqh3VMBN61V0DllGOpcVBIPng/OvhQaNfFbpmoiQcumD6O2iOjFU+gEgPHZmxm@nongnu.org
X-Gm-Message-State: AOJu0YyHqIeLX5y6ARyHGhmjGbU1K9lhqHJcRjX3hs/hPndrDnXbdXoz
 dB/0gcsHf0pFSyFg+nKU1aSnuEyqeGnz5bXo7TdhEF6VsK/7rJgSNL5Z/n5sPbLt4q4Ksdv87Ri
 1OPlk7baZF/tMfTSfU+vpqZYynw9m/a1BtTgfXSYUNJDtiZ/u4x5t
X-Gm-Gg: ASbGncv+N3Z8RCPmmbAQMly5sk3l8Ewo/s1r5Om89u9MCFGY9MYP4D94YOJ3uem/BNa
 GHdEMIAeqJnBhhVYkCUCp+zUTsvS82g2xVjhJroByfDtEtQErb4eb4FGMK0BiOGqzC/mWxWZ+hr
 PPy1ExTjXjt6QUYmaDTu/zZbT0e837x8c66wQT1sbY46WEZTLswtfvXSZbfN/6ehmZp+8ss3X6N
 GSv6uP+Jc7AqzZf4wDHRul5EVd+30KDMjiJazTRLEHz5pqMSp//BcWbpdtcTauGwAGhJ1aocy4N
 GL8j+Vy6G2xZExZwxaUVPyresy50rJHFwK9uWsggmhDLyTDEGUfnZw==
X-Received: by 2002:a05:6000:156f:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-399795c3fefmr181808f8f.31.1742402321786; 
 Wed, 19 Mar 2025 09:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyN/6j0sl7TBx6/LGRxIQf6uiIbYeVTbIT+4SfCKEJDkllCxyqwYeQevWOZH6gzNRVpU1FgA==
X-Received: by 2002:a05:6000:156f:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-399795c3fefmr181787f8f.31.1742402321361; 
 Wed, 19 Mar 2025 09:38:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f58ab6sm23371555e9.23.2025.03.19.09.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:38:40 -0700 (PDT)
Message-ID: <2d1d3dfe-2d66-4bf8-995c-a0e5eaf0f738@redhat.com>
Date: Wed, 19 Mar 2025 17:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 01/32] vfio: Move vfio_mig_active() into
 migration.c
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-2-clg@redhat.com>
 <c676f3b7-97cf-4436-a4cd-3a9f0d0dfb99@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c676f3b7-97cf-4436-a4cd-3a9f0d0dfb99@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On 3/19/25 12:54, Avihai Horon wrote:
> 
> On 18/03/2025 11:53, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> vfio_mig_active() is part of the VFIO migration API. Move the
>> definitions where VFIO migration is implemented.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 
> One nit below though.
> 
>> ---
>>   hw/vfio/common.c    | 16 ----------------
>>   hw/vfio/migration.c | 16 ++++++++++++++++
>>   2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 1a0d9290f88c9774a98f65087a36b86922b21a73..4205f4f7ec87e1a2a5e4110eabc8fde835d39c7f 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -66,22 +66,6 @@ int vfio_kvm_device_fd = -1;
>>    * Device state interfaces
>>    */
>>
>> -bool vfio_mig_active(void)
>> -{
>> -    VFIODevice *vbasedev;
>> -
>> -    if (QLIST_EMPTY(&vfio_device_list)) {
>> -        return false;
>> -    }
>> -
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> -        if (vbasedev->migration_blocker) {
>> -            return false;
>> -        }
>> -    }
>> -    return true;
>> -}
>> -
>>   static Error *multiple_devices_migration_blocker;
>>
>>   /*
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index fbff46cfc35e0ee69e9599c9f8efc7437bbe3370..b5fb0d218808d010d8210612d3182dde8f33514b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1062,6 +1062,22 @@ void vfio_mig_add_bytes_transferred(unsigned long val)
>>       qatomic_add(&bytes_transferred, val);
>>   }
>>
>> +bool vfio_mig_active(void)
> 
> We already have vfio_migration_* prefix in this file.
> I'd say let's use it and rename to vfio_migration_is_active?

yeah. I've been lazy there. I will change vfio_mig_ to vfio_migration_.

Thanks,

C.


  
> 
> Thanks.
> 
>> +{
>> +    VFIODevice *vbasedev;
>> +
>> +    if (QLIST_EMPTY(&vfio_device_list)) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> +        if (vbasedev->migration_blocker) {
>> +            return false;
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>>   /*
>>    * Return true when either migration initialized or blocker registered.
>>    * Currently only return false when adding blocker fails which will
>> -- 
>> 2.48.1
>>
> 



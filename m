Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6563C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1nR-0006AF-Cm; Tue, 11 Mar 2025 11:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1nK-00069o-KJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1nH-000333-Hs
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741707921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zguqp+0OjjMKpBjiCtgQ8cMxqSSove1BO4gQ/yWdmrI=;
 b=Y+pybEbbbQbBDFgpIIWbfjacZl7XHxBfcAFg8LiMNLh1fCOMOgoKRTuAuvhcCApNLDsQ2h
 9mLacPKjTvi5DHYXPJc2nA5hzxfrOhYMcVtt3r+EJg8Csp+RdSSLe1Xmy5n0HdD7Pf008C
 Z4XCuueEzxc6uFNpC+sscjMbR0PzbTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-G5vFebfJOjyHJ-dkfmEEjA-1; Tue, 11 Mar 2025 11:45:16 -0400
X-MC-Unique: G5vFebfJOjyHJ-dkfmEEjA-1
X-Mimecast-MFC-AGG-ID: G5vFebfJOjyHJ-dkfmEEjA_1741707915
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso3063424f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741707915; x=1742312715;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zguqp+0OjjMKpBjiCtgQ8cMxqSSove1BO4gQ/yWdmrI=;
 b=CG34Un+vBShq+147MZy9ajr3KE5XkoCu5glJ9lwRmjiUC39rppvZ3aBQyICYGCNlk9
 JoxMmSU4n92iKQMyL5YYd3n9B5732ywK1Umzrg9pCvBr7a9SbdtZrMg/FS1Tg0nejwxh
 F1u5m8OqBq4WTkqYb2apR6/8YPZjzRHX+krvQDTNMy7sEhs1NHTdbWWP6XVFgAQP4hOZ
 PerAy6B5C59OuIx+pHbzpXKGnNLntSzp9XeONlPJ32Zrl2zwoCu88CPICkR2EP1mi2TW
 JeIguYrByQQvOX7IdZzz1kCGd8X5ebeAWojVdgUXAI5KCTH0dl6zX/6sxV72VaFfabNI
 Y06Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEesUMnnVSk+ACt7G4BLnTgMZQlp8svbZxhVkD7YaDOkC3B6fNGf151Y/lAbRwazPw7BFwJW0KfJf3@nongnu.org
X-Gm-Message-State: AOJu0YxiKgpeyZl7dDAcx7/5ooNPDZcHvQYg2sWb3WgffqnrdmC6MvIZ
 pP8yysbLywxg9O9waDh3W/6CH/03tmNhWkvu1oyO6cI+WnO2e8ciqAxNNbYJ+Od29pbp8npbEsc
 0rP2EzKrrGDH4C+nQzy7tP72vgzM1ZIvK0Rh6mf3sQ0IlYxR1ePAC
X-Gm-Gg: ASbGncuF3tBDvZpQ3PpqnbpeOJOsWwsGBvjQMS8nSpmXY4c9dXQgzztn+kKFVQW+Rq6
 cBu+EklqW4eEhQ1wFLp9BTlnUcLh4qL6qgCS++IiYi3NHvCiQwxZaBijVzh4h7K2lndl8ey1ldC
 uN21oFTvqz1T8nyohf6js0gsXQCBK2UXyj6AydXP6b22v1HzUyRYbv3IhLEBVehiuHXorv1ogdd
 8C4oYAr5EQAhznzV24y9dfIFc8ObhoBZ5eFQT8SYATJh6EVJnBeoFgHuH5icvJOFDZTG7B4abqb
 /jBGwt1M0RfttS6MYcDS33LNP2zKdHV26rip0vK/AyUwVxwvgCVKug==
X-Received: by 2002:a05:6000:1789:b0:391:a74:d7e2 with SMTP id
 ffacd0b85a97d-39279e5177emr5254794f8f.26.1741707915065; 
 Tue, 11 Mar 2025 08:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCoxhHW29s4tkdSNpwoNukN2qL6OTLMayar/lpBXuKlhsuI7xB3rNmNJqaGz2Vf0m7oj59bQ==
X-Received: by 2002:a05:6000:1789:b0:391:a74:d7e2 with SMTP id
 ffacd0b85a97d-39279e5177emr5254781f8f.26.1741707914703; 
 Tue, 11 Mar 2025 08:45:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf7c82566sm76009765e9.30.2025.03.11.08.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:45:13 -0700 (PDT)
Message-ID: <fad3dd28-d91e-4add-8258-5918127e9346@redhat.com>
Date: Tue, 11 Mar 2025 16:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: Avihai Horon <avihaih@nvidia.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
 <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
 <3826d47f-d79b-4db2-9719-35f48f582bf0@maciej.szmigiero.name>
 <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
 <bdd69682-3d0f-4687-a8a5-43a6cb4cecc3@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bdd69682-3d0f-4687-a8a5-43a6cb4cecc3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 3/11/25 15:57, Avihai Horon wrote:
> 
> On 11/03/2025 15:04, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 3/7/25 14:45, Maciej S. Szmigiero wrote:
>>> On 7.03.2025 13:03, Cédric Le Goater wrote:
>>>> On 3/7/25 11:57, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> There's already a max in-flight VFIO device state buffers *count* limit,
>>>>
>>>> no. there isn't. Do we need both ?
>>>
>>> This is on a top of the remaining patches (x-migration-load-config-after-iter
>>> and x-migration-max-queued-buffers) - I thought we were supposed to work
>>> on these after the main series was merged as they are relatively non-critical.
>>
>> yes. we don't need both count and size limits though, a size limit is enough.
>>
>>> I would also give x-migration-load-config-after-iter priority over
>>> x-migration-max-queued-buffers{,-size} as the former is correctness fix
>>> while the later are just additional functionalities.
>>
>> ok. I have kept both patches in my tree with the doc updates.
>>
>>> Also, if some setup is truly worried about these buffers consuming too much
>>> memory then roughly the same thing could be achieved by (temporarily) putting
>>> the target QEMU process in a memory-limited cgroup.
>>
>> yes.
>>
>> That said,
>>
>> since QEMU exchanges 1MB VFIODeviceStatePackets when using multifd and that
>> the overall device state is in the order of 100MB :
>>
>>   /*
>>    * This is an arbitrary size based on migration of mlx5 devices, where typically
>>    * total device migration size is on the order of 100s of MB. Testing with
>>    * larger values, e.g. 128MB and 1GB, did not show a performance improvement.
>>    */
>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>
>>
>> Could we define the limit to 1GB ?
>>
>> Avihai, would that make sense  ?
>>
> There can be many use cases, each one with its own requirements and constraints, so it's hard for me to think of a "good" default value.
> 
> IIUC this limit is mostly relevant for the extreme cases where devices have big state + writing the buffers to the device is slow.
> So IMHO let's set it to unlimited by default and let the users decide if they want to set such limit and to what value. (Note also that even when unlimited, it is really limited to 2 * device_state_size).
> 
> Unless you have other reasons why 1GB or other value is preferable?

none but UINT_MAX is not good value either. Let's wait before introducing
a new limiting property.

I will send the last PR for QEMU 10.0 at the end of the day.


Thanks,

C.



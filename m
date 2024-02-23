Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AAAC54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 08:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQxL-000237-Gc; Fri, 23 Feb 2024 03:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQxK-00022r-4b
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQxC-0006as-41
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 03:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708677045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QSKwQC2SjIB9fpzU5eAJmTLEETfW3vtFhXqH1Cf948=;
 b=R41kWyZhRO5zWL/8cFn2SVE7zdFc3FztRFo1ltYLIgA2ZIqWlWdAmTN5gMwf3enBJUZgSj
 5Z6VbnKf9+EglHlpqBrn7cfpjnP2Nx3XsEkqOqhfyr/b1hmSUk3rF8U09GVlmMQqyP/KUN
 u9at4fytKNwELve5xMORdydZEUpnRDg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-6JSMmQrKPha46XciHCWglg-1; Fri, 23 Feb 2024 03:30:43 -0500
X-MC-Unique: 6JSMmQrKPha46XciHCWglg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c1879e491dso351044b6e.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 00:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708677043; x=1709281843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QSKwQC2SjIB9fpzU5eAJmTLEETfW3vtFhXqH1Cf948=;
 b=vpl8NCRh2cGXkLeuqapjYM1c8NZ/62z6ySyjHJmkJpmZbzb/xlFS/Sin/yE9ADIXHn
 dU2fxpiSe2Vhv7JVN8T2XbfDMle7+/owNsJjeaS1giyombDtu4F26PYcMo5uobsABUkA
 nOa4Kqomf6eHrfJZ8ndSXhqdPHRWF4ff7ZuN4iAUzYLH5LecvFSdizZ6jgUzcs0nkMoF
 mPHrCejm8HkUQ8jsSWPSSbRIIz+39Hyw/mq2L8vVy9UJB7eHE8Mm//HBVuVrTJ9IprJq
 mB29LO8qEcdv7SxW64dvQ/ZrkdLhtA9RHQzpOtyFls+FBGSB6tzrf0vRkm9g3zeNx+1C
 0gFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmYLCKB5jwqYJacdKwbrZnacBKM7W9C1mL/dcfaQ8wtGzct4CCzBJO31cY9zHvdvpwlnExp1N9jsQmli7bQK91btf8cZw=
X-Gm-Message-State: AOJu0YyKuaai6SuYHYJjOBq3RfOtD+Hnv3UQDiJAiJCxOET4sityGpds
 fnJgRTRez9j9vSQlf7mKA6cAmw45akuacCax4NnuIqWZnj17xNzcmIrNSsDvtE32oIAfAz/CXAw
 BWoaAZjB/qBTCLkn6a21e33nGJQwA1PFEunEMJJlCGZTbhl0yBXEi
X-Received: by 2002:a05:6808:4485:b0:3c1:83c3:969b with SMTP id
 eq5-20020a056808448500b003c183c3969bmr1742222oib.53.1708677042849; 
 Fri, 23 Feb 2024 00:30:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE31r8vTwESgendQFaSf5UY/e+tmsbkqMpjkqalMWAtTfNEuMJ+Nep6ZnmOFOSmxqo9N8/9nQ==
X-Received: by 2002:a05:6808:4485:b0:3c1:83c3:969b with SMTP id
 eq5-20020a056808448500b003c183c3969bmr1742192oib.53.1708677042360; 
 Fri, 23 Feb 2024 00:30:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 cz2-20020a05620a36c200b0078734c20d45sm6223144qkb.121.2024.02.23.00.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 00:30:41 -0800 (PST)
Message-ID: <fd894834-622f-4d1e-b594-87beb35deebf@redhat.com>
Date: Fri, 23 Feb 2024 09:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] qdev: Add a granule_mode property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com, Markus Armbruster <armbru@redhat.com>
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-2-eric.auger@redhat.com>
 <07d4a2a4-1880-4402-a12a-94eeb649f8b0@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <07d4a2a4-1880-4402-a12a-94eeb649f8b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 2/23/24 08:52, Philippe Mathieu-Daudé wrote:
> Hi Eric,
>
> On 23/2/24 08:27, Eric Auger wrote:
>> Introduce a new enum type property allowing to set an
>> IOMMU granule. Values are 4K, 8K, 16K, 64K and host.
>> This latter indicates the vIOMMU granule will match
>> the host page size.
>>
>> A subsequent patch will add such a property to the
>> virtio-iommu device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - Add 8K
>> ---
>>   include/hw/qdev-properties-system.h |  3 +++
>>   include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
>>   hw/core/qdev-properties-system.c    | 15 +++++++++++++++
>>   hw/virtio/virtio-iommu.c            | 11 +++++++++++
>>   4 files changed, 40 insertions(+)
>
>
>> diff --git a/include/hw/virtio/virtio-iommu.h
>> b/include/hw/virtio/virtio-iommu.h
>> index 5fbe4677c2..e22327548f 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -31,6 +31,17 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
>>     #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>>   +typedef enum GranuleMode {
>> +    GRANULE_MODE_4K,
>> +    GRANULE_MODE_8K,
>> +    GRANULE_MODE_16K,
>> +    GRANULE_MODE_64K,
>> +    GRANULE_MODE_HOST,
>> +    GRANULE_MODE__MAX,
>> +} GranuleMode;
>> +
>> +extern const QEnumLookup GranuleMode_lookup;
>
> Aren't this, ...
>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 2ec5ef3cd1..a9bdc03d12 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -44,6 +44,17 @@
>>   #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>   #define VIOMMU_PROBE_SIZE 512
>>   +const QEnumLookup GranuleMode_lookup = {
>> +    .array = (const char *const[]) {
>> +        [GRANULE_MODE_4K]   = "4K",
>> +        [GRANULE_MODE_8K]   = "8K",
>> +        [GRANULE_MODE_16K]  = "16K",
>> +        [GRANULE_MODE_64K]  = "64K",
>> +        [GRANULE_MODE_HOST] = "host",
>> +    },
>> +    .size = GRANULE_MODE__MAX
>> +};
> ... and this supposed to be QAPI generated?
If I remove both, it does not compile. How do you make it generated?

Thanks

Eric



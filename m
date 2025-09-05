Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FC7CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 09:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuT6C-0005vV-Um; Fri, 05 Sep 2025 05:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuT6B-0005uq-Es
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuT66-0006nk-Ou
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757065866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1vq3EHGQZY9x5nXDExeSo6nYDb33OxxqgtOv3NzN7g=;
 b=PPX13U+HSnIQapT548du7u1cMquPtJuPRvCj1x67lq+/GRs2jFelbs1I5jyisugCVQBGxu
 JMRXymFMXK+2ruPvZUgRdcILyHNk4+f9ipAw9/5+7yCOouY1RxCZPrPsBT+ETpnFGmz5Gy
 o8er9FAvXu7Q8wkrsqkNkeOZU5GvQ8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Z-4WCExeP5KV2F8Bv9paMw-1; Fri, 05 Sep 2025 05:51:04 -0400
X-MC-Unique: Z-4WCExeP5KV2F8Bv9paMw-1
X-Mimecast-MFC-AGG-ID: Z-4WCExeP5KV2F8Bv9paMw_1757065864
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45cb6d8f42bso16267545e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 02:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757065863; x=1757670663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1vq3EHGQZY9x5nXDExeSo6nYDb33OxxqgtOv3NzN7g=;
 b=oTOFUGGIMtx3asXXVP0FCpD908KXLWIxK/qNEPjB8qLEHfpv+BZMsTybx9vQsi4tWD
 nFJNpg17FzQOCkyNiMOwOAwPY9jsDfIyN8fIG6K5xNreUWX1DmIhwTtClvXFHGdgAGbE
 aCpo7GOVj7wCalY7jCppufXVAmCUReG8PElJfL9pFfnvSDAja1FtR1/zIPkuln+BtJzR
 yjXGiXjkiwmTxq2nIi6Qye+MjCJ2uDmUihXy4rDjrTtCINy/9ug7jrrp1I/8zAPkfRrW
 K3e+uUebQvzn0+w/w4lSmI9ZuVChX7zti9HQaewhzC958PNV2sN4KLJPwOKlQfT43w+h
 PXpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtTli1OpcciYK2BZGV9W7yWoWOz91v9wE9QYacwXgOD7P8xehj4qfmKothNLmDP0kEc5gt5w4dLYxj@nongnu.org
X-Gm-Message-State: AOJu0YxBkPSLZG/m2wV5Pq/8Deg4aRWoLVGFjNiVRTfWkcLbM9/8fAzh
 xTkLeQ2QCNDAIEIj+gsCbGhezKYYBwbMQI4VOuWZ7tKFYI6sT4Wv7LH1FvjMzwwmJm+WwVzPW7c
 rUG4xsm9tQzKDuiqU+ktwLsqiynvq0o/XzXfNDUvZzYV7GlvRn7iTLk3V
X-Gm-Gg: ASbGncsrL6qMYXFc4qp6YslD4XEAetCbPFLwXK8vBEbngooInH8ha18VKJ4plL1SLxC
 hQE/gN/cD0oBB1Az78RI5xq1EdFz9wKKdcJ7iE+lCmIa6jUOwojfODFwNqQg8rnTVxZ4S50ovbE
 hSXSzRcfOS9PCFv2TVffLOySvo2Tw4hAw+Hy5GbVjqXKjDI4YsAmgdomre1C8d4lZdZYsMM0m33
 8i3IatwFJXT1iegrFWSijh3OCS6OIPTJQTOnr6kpRb4FD22ASaNdHVXfXGkQsaKsPRIGK61HAUB
 5+ftU5iVOLwaL/+d7grK+9gPmAN3uC/oxx82/6e77ZeJIApCqZGM71NtPRxuRn/NAh7M2CNNnpB
 /kuVdCxM+NcQ=
X-Received: by 2002:a05:600c:3502:b0:45b:9291:320d with SMTP id
 5b1f17b1804b1-45ddbdd6c1emr4396365e9.31.1757065863460; 
 Fri, 05 Sep 2025 02:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlJCfZ37T0pYOnIrkKm1SPfQDFb71IAil+eiY545iqvvc8QDtKUVSTSVKkVbR6UzCgp1CggQ==
X-Received: by 2002:a05:600c:3502:b0:45b:9291:320d with SMTP id
 5b1f17b1804b1-45ddbdd6c1emr4396105e9.31.1757065862907; 
 Fri, 05 Sep 2025 02:51:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm168288405e9.3.2025.09.05.02.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 02:51:02 -0700 (PDT)
Message-ID: <0eb54880-e6b5-4eb8-b07d-21ca80bd00b4@redhat.com>
Date: Fri, 5 Sep 2025 11:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, skolothumtho@nvidia.com
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-10-shameerali.kolothum.thodi@huawei.com>
 <aHbgc8LXuuuJ/cz0@Asurada-Nvidia>
 <6110ab250e844af9982dddb230fb8707@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6110ab250e844af9982dddb230fb8707@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 7/16/25 10:36 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Wednesday, July 16, 2025 12:13 AM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; shameerkolothum@gmail.com
>> Subject: Re: [RFC PATCH v3 09/15] hw/arm/smmuv3-accel: Support nested
>> STE install/uninstall support
>>
>> On Mon, Jul 14, 2025 at 04:59:35PM +0100, Shameer Kolothum wrote:
>>> +static void
>>> +smmuv3_accel_ste_range(gpointer key, gpointer value, gpointer
>> user_data)
>>> +{
>>> +    SMMUDevice *sdev = (SMMUDevice *)key;
>>> +    uint32_t sid = smmu_get_sid(sdev);
>>> +    SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
>>> +
>>> +    if (sid >= sid_range->start && sid <= sid_range->end) {
>>> +        SMMUv3State *s = sdev->smmu;
>>> +        SMMUState *bs = &s->smmu_state;
>>> +
>>> +        smmuv3_accel_install_nested_ste(bs, sdev, sid);
>>> +    }
>>> +}
>>> +
>>> +void
>>> +smmuv3_accel_install_nested_ste_range(SMMUState *bs,
>> SMMUSIDRange *range)
>>> +{
>>> +    if (!bs->accel) {
>>> +        return;
>>> +    }
>>> +
>>> +    g_hash_table_foreach(bs->configs, smmuv3_accel_ste_range, range);
>> This will not work correctly?
>>
>> The bs->configs is a cache that gets an entry inserted to when a
>> config is fetched via smmuv3_get_config(), which gets invoked by
>> smmuv3_notify_iova() and smmuv3_translate() only.
>>
>> But CMDQ_OP_CFGI_ALL can actually happen very early, e.g. Linux
>> driver does that in the probe() right after SMMU CMDQ is enabled,
>> at which point neither smmuv3_notify_iova nor smmuv3_translate
>> could ever get invoked, meaning that the g_hash_table is empty.
>>
>> Without the acceleration, this foreach works because vSMMU does
>> not need to do anything since the cache is indeed empty.
>>
>> But, with accel, it must call smmuv3_accel_install_nested_ste().
> Ok. The only place I can see CMDQ_OP_CFGI_ALL get invoked by Linux
Easy to say but I think we shall rather look at what the spec mandates
and not what the Linux driver does ;-)

Thanks

Eric
> kernel is during arm_smmu_device_reset() and that is to clear all.
> But I am not sure we will have any valid STEs at that time. Just curious,
> are you seeing any issues with this at the moment?
>  
>> So, I think this should foreach the viommu->device_list instead.
> But agree. Using device_list is more appropriate unless we cache the 
> configs during each install_netsed_ste() path.
>
> Thanks,
> Shameer 
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA852C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7aGT-0004cC-KD; Wed, 23 Apr 2025 09:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7aGI-0004Zs-BM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7aGG-0003ol-7d
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745415334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a3n6hJaVlfAPYKpvTZwjyzrTnFaALHegIglT/ZC35/k=;
 b=A1GVsrqIGxafhTHfGuxClbDVip9Moo+AVR+ocLD8pybNDsbBlGwI5kmXNKi4LEPk8s4Biw
 p/z/vQ1jukFZSSr5pJHp8po6xVoKu1VSRmt9rBPFsTfsdodpERIzzH8J/8W+ENZHdH+usN
 Mbv0f5FWAY1DgPEQGh3nHqlhQMQlB2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-qv83WoeoPoaeEpfdvBdC1w-1; Wed, 23 Apr 2025 09:35:31 -0400
X-MC-Unique: qv83WoeoPoaeEpfdvBdC1w-1
X-Mimecast-MFC-AGG-ID: qv83WoeoPoaeEpfdvBdC1w_1745415331
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso2316059f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 06:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745415331; x=1746020131;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3n6hJaVlfAPYKpvTZwjyzrTnFaALHegIglT/ZC35/k=;
 b=CfUBW1BhgR/DdGmQ1towxey0J2baA/qvm9bN3puprquBXZZBYe1aUc395jOgGdcxD7
 MiZWr6XvrenATcvqJ+4pxpZnsVvVzji1/92sL/Ml0wpjd9+qGO8UKk9tyRDmqN2bNb13
 +AHN1RbLlnWDrwldkod/hLMhp36yUFV2ixqpCfnkwClmeYp7b7Kx+rKbxgNNeEI9DhT3
 CYnguhWCMOjKFRLa3UEVYFJMxaEFxv9CEkpXB+LzwVnPVC/cZqstj17QeLJRcC6850ED
 s2eZPgp4aMvzyCUgcQIgSWjMtHlweFf6+izkRKgmNOI7nXld7eSnn0W11f2ftMc7xIpQ
 3z9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQSSgGUUhQFEMuRM8gQr8lIjulW6PRpJ5I5L1bpJJC03qwXLbXyCMjVLcSWS+OkJl/l1+xxiRGKr2N@nongnu.org
X-Gm-Message-State: AOJu0Ywgj7+gpNGMygAMIWt14fi4fsFK3gr+bR3L89vBLQQapzYT6mzM
 5eGAUEINqmS/7Z0ZYm9kJe2Azq2do6JNbihI6dLv0xvjaLM/tC1pvl9x9pi/h/1JbbVGeeM4RKp
 gtYkdTXzU9B+2GvcpGNq4dJdEXywFYZKuJfoNAbOnH5KMSbpnozcO
X-Gm-Gg: ASbGnctgoFyfSg+mG3RrcL9Xt3WfsEqZCz65Cm9bM1hUAs23rCIUxHGmY33zTb9N7jZ
 MzZwO0DuZanuEtRCr9dRIqNfostv8OmkVSmyKcA7BybSDEO3gyuBe4qb+EOkUZljEN9F9r78EvK
 Cuwfxnz7088gi7AUkEuKRndJYxJ7zmfo/3FP34pILM6joEEl88ntl17SAJIUZf6AFgLaSZEBajx
 dPSntY6K0YNAjHpdPJHwrc9N6YY5aIh47TAcUAnqk53IIn4VjsoxXVTOYR3APx/bhM5MGw5M4MF
 iuJX9gVfCY+jnYiJ52BwMKzGn+fIDxLX9GNCmpeNq29Zyzg=
X-Received: by 2002:a05:6000:1889:b0:394:d0c3:da5e with SMTP id
 ffacd0b85a97d-39efbb054b2mr15415063f8f.47.1745415330732; 
 Wed, 23 Apr 2025 06:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPSJ9cMDgX/zMuOuzVJH934QVBwZHuVYsya0emVX4W7ADHrp6ywsPT6Srqq8gt8zwA4fLReg==
X-Received: by 2002:a05:6000:1889:b0:394:d0c3:da5e with SMTP id
 ffacd0b85a97d-39efbb054b2mr15415038f8f.47.1745415330337; 
 Wed, 23 Apr 2025 06:35:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa433104sm18861006f8f.29.2025.04.23.06.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 06:35:29 -0700 (PDT)
Message-ID: <bfa00057-3e92-4042-b1e1-cf1e3dfc48da@redhat.com>
Date: Wed, 23 Apr 2025 15:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] vfio: Move realize after attach_dev
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
 <ec9f9453-bd15-450b-b602-91fdfcc340b1@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ec9f9453-bd15-450b-b602-91fdfcc340b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 4/23/25 15:21, Cédric Le Goater wrote:
> On 4/23/25 09:28, Zhenzhong Duan wrote:
>> Hi,
>>
>> This series addresses Cédric's suggestion[1] and Donald's suggestion[2] to
>> move realize() call after attach_device().
>>
>> This way avoid the need to introduce realize_late() to further complex the
>> interface in nesting series.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01211.html
>> [2] https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00898.html
>>
>> Test:
>> net card passthrough and ping test
>> hotplug/unplug
>>
>> Based on vfio-next(856f36c005).
>>
>> Thanks
>> Zhenzhong
>>
>> Changelog:
>> v2:
>> - drop the idea to save host iommu capabilities in VFIODevice.caps
>> - introduce a new function to create and realize hiod
>> - remove hiod_typename property
>>
>> Zhenzhong Duan (5):
>>    vfio/iommufd: Make a separate call to get IOMMU capabilities
>>    vfio/iommufd: Move realize() after attachment
>>    vfio/container: Move realize() after attachment
>>    vfio: Cleanup host IOMMU device creation
>>    vfio: Remove hiod_typename property
>>
>>   include/hw/vfio/vfio-container-base.h |  3 ---
>>   include/hw/vfio/vfio-device.h         |  3 ++-
>>   hw/vfio/container.c                   | 25 ++++++++++++--------
>>   hw/vfio/device.c                      | 33 ++++++++++++---------------
>>   hw/vfio/iommufd.c                     | 31 +++++++++++++------------
>>   5 files changed, 47 insertions(+), 48 deletions(-)
>>
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Applied to vfio-next.

Thanks,

C.




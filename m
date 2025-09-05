Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4186FCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 10:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTQF-0001Ou-7y; Fri, 05 Sep 2025 06:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuTQC-0001MR-Qn
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuTQ5-000585-DW
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757067104;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G5I9HcOPpmITgGtpGl+Dr3fIub9ASYEQ3OgxpydGEE=;
 b=P1uw2es8FA3xu3MRQP3N84XKNEqPIVD2cYNXoWV2PFQjFg69DgZBLYxRJWyIn69KJ7/clQ
 Z+ipvY8z+8HTEgYoT9OIzk/iHEb2vt3IhBRothOeXaP7YuoLf1jWyzbbhQZyeVTTmTGWCS
 /YuLc7Cmk2leP68IBMJXHUUSkmr6xHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-el7t91CePi25-qK6s3sXZQ-1; Fri, 05 Sep 2025 06:11:43 -0400
X-MC-Unique: el7t91CePi25-qK6s3sXZQ-1
X-Mimecast-MFC-AGG-ID: el7t91CePi25-qK6s3sXZQ_1757067102
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e26b5e3f41so550676f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 03:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757067102; x=1757671902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0G5I9HcOPpmITgGtpGl+Dr3fIub9ASYEQ3OgxpydGEE=;
 b=A0RxCHHihSeqEk+MSz7vmPS9SSkAb6VONdohwArEtQYryeVI7MQjWHIAX5+0PsgGP+
 4wjAmbbrNwtvIyx0k2RisH/KZBjbU1QF7vFrry2cZjWgTBqJERqupCkyCcWkQUBnpaAm
 +0EsM81Um5jv1yJOUKwcJV7+BA+RJC4DGMMNUQVQWafyuGIel9Sr/dcc4rpeq4kINQQQ
 LLTArTtWpETjRYex+39NASoeslFOnH9zcEnPdCu8BObGMfTm2g+hsXs/wFitVR6Mvcet
 i/dIJElEXnBMUgiOXou8E21i91qr9ewj0zJqRnYODA0l9f1HRFxpX9InNGkZ6gQ0kme3
 dUzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPUjK2KbJOi4Ez/5XyJ9uTnW0J9vSaBIlSiMbMiQRyTVhXS4LuPhL0DrfL8Rl6NTdPoqUk/UECDQAN@nongnu.org
X-Gm-Message-State: AOJu0YzTcaf3pUWJNECgabEGc8X0CUUILCSwClzHGlMueeOPNRcTkUte
 hDC8NPuebv4bhYotlli1US95bwxNNNDIky55/rRf/UN+gGj4b4BgN784UQFmXqbsmHzW3N55aSA
 f+lGYPQDnqEum+wCjoFcDkOvcuU9nXW46PfkhoZBrAnAIt8ctAZnfulGj
X-Gm-Gg: ASbGncs7JDv81pKNJxYi/M0OEWdvTTNIUsnuywwcpCssnf683BkvUfGg4CAs5d3sJrG
 olFLaewSW3qWfq9MAPE7H6ZUAy8xPO5DTqiAjgEvo6BbxfQG/F6Vz3vkzRhPnyQXekO65qZxnyA
 a7u8x613mjblUWZhorDwZryqVK/6MKWyvCQslAbc6vculh1yhTnKRp9xSMRnyjGxOrU5k0XyoU+
 9uybTtD3R6p/yypMjMsDy4Dx/SbnUgXQ7mrsWA61Xl9oHcWSkAjN2tFNpjtjiwDyj0L6iqMRSJe
 aqU86zACl5sknYqAQBiKPiJYU5zABci97V2lb7OBdHcHavW8sM6/0ninYjhRg3LtIfQhX5r8XKX
 9/ZUvdmoeRkA=
X-Received: by 2002:a05:6000:200d:b0:3d6:7ae1:aefe with SMTP id
 ffacd0b85a97d-3d67ae1c171mr17821263f8f.12.1757067102211; 
 Fri, 05 Sep 2025 03:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGdj9jQN43C9IFUre2oRoAnE5AWDaFH513aObpSW5LLqYJvztoYEanu7306yr21+Xt/nbUDg==
X-Received: by 2002:a05:6000:200d:b0:3d6:7ae1:aefe with SMTP id
 ffacd0b85a97d-3d67ae1c171mr17821230f8f.12.1757067101790; 
 Fri, 05 Sep 2025 03:11:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e329475a13sm2740992f8f.14.2025.09.05.03.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 03:11:41 -0700 (PDT)
Message-ID: <b3ba5610-13bc-4eea-90be-a9435ddc656d@redhat.com>
Date: Fri, 5 Sep 2025 12:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/15] hw/pci/pci: Introduce optional
 get_msi_address_space() callback.
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, skolothumtho@nvidia.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-12-shameerali.kolothum.thodi@huawei.com>
 <aHVflRCJM+pcsP2S@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aHVflRCJM+pcsP2S@Asurada-Nvidia>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/14/25 9:50 PM, Nicolin Chen wrote:
> On Mon, Jul 14, 2025 at 04:59:37PM +0100, Shameer Kolothum wrote:
>> On ARM, when a device is behind an IOMMU, its MSI doorbell address is
>> subject to translation by the IOMMU. This behavior affects vfio-pci
>> passthrough devices assigned to guests using an accelerated SMMUv3.
>>
>> In this setup, we configure the host SMMUv3 in nested mode, where
>> VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
>> controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
>> we currently return the system address space via the get_address_space()
>> callback for vfio-pci devices.
>>
>> However, QEMU/KVM also uses this same callback path when resolving the
>> address space for MSI doorbells:
>>
>> kvm_irqchip_add_msi_route()
>>   kvm_arch_fixup_msi_route()
>>     pci_device_iommu_address_space()
>>
>> This leads to problems when MSI doorbells need to be translated.
>>
>> To fix this, introduce an optional get_msi_address_space() callback.
>> In the SMMUv3 accelerated case, this callback returns the IOMMU address
>> space if the guest has set up S1 translations for the vfio-pci device.
>> Otherwise, it returns the system address space.
>>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>  hw/arm/smmuv3-accel.c | 25 +++++++++++++++++++++++++
>>  hw/pci/pci.c          | 19 +++++++++++++++++++
>>  include/hw/pci/pci.h  | 16 ++++++++++++++++
>>  target/arm/kvm.c      |  2 +-
> I think we need to separate core changes and smmu changes, like how
> pci_device_set/unset_iommu_device were introduced.
I agree with Nicolin.

Eric
>
> Thanks
> Nicolin
>



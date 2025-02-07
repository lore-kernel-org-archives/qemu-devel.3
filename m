Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35F0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRZ1-00075j-3n; Fri, 07 Feb 2025 11:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tgRYv-00074Z-DO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tgRYt-00039L-AT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738947037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJF17qzTWI8+1y8sNpI/aLlEcWQYEquLiTZ6doqt0p0=;
 b=eMyzeVfNzKM7usJrkxH1iatXIFcLG1uEC+sqcA0RVjnSLYYqoMtMgJZxmWhDkwHowg9wW3
 Mh57zR68yEYwtqdODryXElU36dEoSn7FwcFIXO2hfi7EPVhBYjYnal4ZqXc3UFj6emLHPI
 XoxXg/7qDgtfgyPOfwXGYN9/+Kg9cOU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-4UNPJvAhN7C1BLENnfAung-1; Fri, 07 Feb 2025 11:50:35 -0500
X-MC-Unique: 4UNPJvAhN7C1BLENnfAung-1
X-Mimecast-MFC-AGG-ID: 4UNPJvAhN7C1BLENnfAung
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so12131385e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738947034; x=1739551834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJF17qzTWI8+1y8sNpI/aLlEcWQYEquLiTZ6doqt0p0=;
 b=wkYt19ABXahROKHSX+5g/+WO4aEZJnXb5kmc1wri8u8m3pppqqFXSTmPcZ8NveHEdZ
 o3UIfBc6urBR07IuPuSo0EZCfMOcqvpfuSTJx7hATG/O948utXdeERQuUI8dDrpdae4Z
 H1fyjqtcyoEsoxG2/QUHqvINK9730d7ajtLkxg2WXFcf0QQg89UEdTZjOdoABk80tOOg
 3adsotb4rGiZ+VBaVf0raq5ZCrkZyKjc2ivQFNZRlBx2ZlEX38sc0SNobfQ0oqaHyQ0f
 dwz+sFy4DfYki5huBl5Rl8JR1NaEMzrgRDtiWGOY0vRL3p+r31CkIxW4YW7FYtn8B9fO
 SVNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnvDTCOtITnvlCs3z+e8siXVCMPfVuuMX+ja1k+9fYkyKOVwJGHkSh6MbWYTarzmmpWKFN4QcTLvGM@nongnu.org
X-Gm-Message-State: AOJu0YxsoHrxbtLQ7tglAPYf0LZA9G8/rvzIHWx4Bvm/CXn7of1m+QMJ
 7q9Fuf+TIarw3S/dzWXp2z4wPEgohtujx1MtbaybqBbT8t486meQn0bUwCXSuVAkwXEwoQbRmYB
 adenZeM3NVHQXIcEy6E4RMCsZ0UgMWgCmb48y7I/MkYfwsV9mEqLx
X-Gm-Gg: ASbGncunqKzFqlS8uM77prcEG80OVy3dAdCT9rfs7lK1x+kLnmq4outWValLx/fLS7w
 4QhqdFWgobWfQkJuDS2z5QcdqJ6i8qBMv4N3bfLLg5jScA6ymJiPq4XxyhkCIR7113Z5IXMCYaN
 Ul0yjaw5lT6rRySqO0xR31sRM9ExyWxrmLcfc7QLPzSnh09+vYrGXvLudFAL3MPybxd7n5x+FuX
 jcTC36XGNno+L9Bqb5Rqwv3VMrva/2YkM7DGsLQGuZ1URyu5dtINU71krsyr0lAWZEGSeV5dvbH
 WnVky3mDF4ZtrVij+9YmYefCM8/wceWtjrKPxrKrBm6Y+o1UnfMd
X-Received: by 2002:a05:600c:198a:b0:436:1af3:5b13 with SMTP id
 5b1f17b1804b1-43912d49c3amr67542465e9.15.1738947033634; 
 Fri, 07 Feb 2025 08:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJjPPJ6SdQ+3tXpNgnpnZicccK8o/kVsI1eFDIia1j1TOCbxKyXhtzLQpwhlexQVvOi/iH0A==
X-Received: by 2002:a05:600c:198a:b0:436:1af3:5b13 with SMTP id
 5b1f17b1804b1-43912d49c3amr67542265e9.15.1738947033275; 
 Fri, 07 Feb 2025 08:50:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d966faasm95958615e9.23.2025.02.07.08.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 08:50:32 -0800 (PST)
Message-ID: <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
Date: Fri, 7 Feb 2025 17:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/7/25 5:37 PM, Peter Maydell wrote:
> On Thu, 6 Feb 2025 at 14:23, Eric Auger <eric.auger@redhat.com> wrote:
>> Currently the iommu may be reset before the devices
>> it protects. For example this happens with virtio-scsi-pci.
>> when system_reset is issued from qmp monitor, spurious
>> "virtio: zero sized buffers are not allowed" warnings can
>> be observed.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c     | 9 +++++----
>>  hw/arm/trace-events | 1 +
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index c0cf5df0f6..7522c32b24 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1870,13 +1870,14 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
>>      }
>>  }
>>
>> -static void smmu_reset_hold(Object *obj, ResetType type)
>> +static void smmu_reset_exit(Object *obj, ResetType type)
>>  {
>>      SMMUv3State *s = ARM_SMMUV3(obj);
>>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>>
>> -    if (c->parent_phases.hold) {
>> -        c->parent_phases.hold(obj, type);
>> +    trace_smmu_reset_exit();
>> +    if (c->parent_phases.exit) {
>> +        c->parent_phases.exit(obj, type);
>>      }
> If we need to do something unexpected like reset
> register values in the exit phase rather than the
> hold phase, it's a good idea to have a comment explaining
> why, to avoid somebody coming along afterwards and tidying
> it up into the more usual arrangement.
sure
>
> If I understand correctly we need to keep the whole IOMMU
> config intact until the exit phase? What's the thing the
> device behind the IOMMU is trying to do during its reset
> that triggers the warning?
The virtio-pci-net continues to perform DMA requests and this causes
some weird messages such as:
"virtio: bogus descriptor or out of resources"

Also VFIO devices may continue issuing DMAs causing translation faults

Thanks

Eric

>
> thanks
> -- PMM
>



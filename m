Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2EEC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHAw-0000C4-1r; Tue, 21 Jan 2025 11:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taHAu-0000BX-GI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:32:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1taHAs-0000F3-UG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737477140;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PCuWFp1jsjRfisrPIACOvU2gY98pvzN80nZCkZJdG8=;
 b=aVfKJwyxpKWD5LnUXiv0fFTdsb5+bUSS5JVK1D76JVHRp4obsos3x6VHIeV0Y+ovXweHn3
 5VOdN3msXc2DGhxOJ8PiK1d6FTCHYvyQFozpU0nP9mla7T/YnBPKq+5JogULPv1OK2wHCw
 oC8IWwwfuW/KDRrLRAv66qkL7FMgizY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-xmCDq0UmM9evFfJGQVFsJw-1; Tue, 21 Jan 2025 11:32:17 -0500
X-MC-Unique: xmCDq0UmM9evFfJGQVFsJw-1
X-Mimecast-MFC-AGG-ID: xmCDq0UmM9evFfJGQVFsJw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso2555588f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737477135; x=1738081935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3PCuWFp1jsjRfisrPIACOvU2gY98pvzN80nZCkZJdG8=;
 b=HsmGqv5TgAZMbwdc4Dxivy9C5+EA3+okpEwjwJIu8Rt9GP3WBiz32mBSYtGXal+5C/
 EsNSFad4HQzm3A52xbwVG0NhD+fb/xBx3+ul8s1WryBGKT7NTpFp7lY8atqcGAykz9rd
 Hxu155MmBnFFhWexHmb4zAWCvzIO20sfAW6/ekLG7h0dxwrnGhmbzWXJXzJGx72yaA4W
 qjIp9tE5jelkSKOWpsqmidbZEIq+EsdKRlAMeO4M3m9HCXBc5YW16s7cmrdHb5A9niw9
 pRZ8eclAAtU4RZTHHoDCwo/XZHvfcuULh6XlRT0sIfnrGhPGRhurfln1UIDMVijxJ8JO
 o1eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeRv3+VGz9ra8JRph9qGfPUnfdpOUSBqln4K1gXCJueqPe2gapf9FJ+XM5oZFtvzkajw1yc5XzVLaX@nongnu.org
X-Gm-Message-State: AOJu0Yx1V3F+AQ4F2dWDbz+3oxxr9et+tCirYNAGb4p9AjU7g2DN1M5h
 7+lxm8aXWLh/PDnkC2gyU3GV8yxBEhApMQqB/RuZ34btTj4XJygPqfBcDhEhFRFtjkXF1UnfGHa
 CtGgk3apnzAUAVfL5BH9ezMDxeWW86wjpvp/Lud9KCvSADvoFyVuL
X-Gm-Gg: ASbGnctaE7xUZZehcQl1nShULGda7p4omf3yW33HaZ85PozXZWPMn4c9Njqlf5PMa38
 uoKXJ9gf4TxDt74K0XD0w245pn4o6Ab4p+JAyVfxyKt3BQdhwik6ta18PAclel8PGHDg/01JOBi
 m3A963wOALn5+xdognvRaMMx5Wqnqb9s0AcS5QGPZ0bp8cxbz8HKNIcELYDOZ1VcinBkmVKMOmF
 5gmNHtZbuPa9jLYyumDqbo0sHpepYJiJMMEmhhuBemVgeZaitazzWuMBZwPWDJGZdY6+1UjI2Sg
 0kD1B/fLYnBqR6NyP9E9uHYSfjrIjIfGQPR67vrUig==
X-Received: by 2002:a5d:6d02:0:b0:38b:ece5:5fe3 with SMTP id
 ffacd0b85a97d-38bf565560amr15378702f8f.1.1737477135217; 
 Tue, 21 Jan 2025 08:32:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErtl7JlyYlspi92mjf08aNnPNDbFWxSme/ByTt376DHXXjlLm11OwxOHsK7TLferY6hq5lMw==
X-Received: by 2002:a5d:6d02:0:b0:38b:ece5:5fe3 with SMTP id
 ffacd0b85a97d-38bf565560amr15378672f8f.1.1737477134832; 
 Tue, 21 Jan 2025 08:32:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221bf0sm13667302f8f.28.2025.01.21.08.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:32:14 -0800 (PST)
Message-ID: <b8c604ac-de82-47d3-b0bd-a24ea882a7d0@redhat.com>
Date: Tue, 21 Jan 2025 17:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 sgarzare@redhat.com
Cc: zhenzhong.duan@intel.com
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 1/21/25 9:31 AM, Laurent Vivier wrote:
> On 20/01/2025 18:33, Eric Auger wrote:
>> When a guest exposed with a vhost device and protected by an
>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>
>> Fail to lookup the translated address ffffe000
>>
>> We observe that the IOMMU gets disabled through a write to the global
>> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>> When this warning happens it can be observed an inflight IOTLB
>> miss occurs after the IOMMU disable and before the vhost stop. In
>> that case a flat translation occurs and the check in
>> vhost_memory_region_lookup() fails.
>>
>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>> unregistered.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/virtio/vhost.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6aa72fd434..128c2ab094 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -931,6 +931,10 @@ static void
>> vhost_iommu_region_del(MemoryListener *listener,
>>               break;
>>           }
>>       }
>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>> +    }
>>   }
>>     void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>
> I think you need the counterpart in vhost_iommu_region_del() (for
> instance if we have an add after a del that results in an empty list).
> But you cannot unconditionally enable it (for instance if vhost is not
> started)
if we enter vhost_iommu_region_add(), this means that the iommu_listener
has been registered in vhost_vdev_start() and thus vdev->vhost_started
is set.

>
> Perhaps you should move the vhost_set_iotlb_callback() call from
> vhost_start()/vhost_stop() to
> vhost_iommu_region_add()/vhost_iommu_region_del()?
I currently fail to understand whether we shouldn't keep listening to
iotlb callbacks when the IOMMU gets disabled. In that case shouldn't we
flush the kernel IOTLB and update the hdev->mem->regions to reflect the
IOMMR MR disablement?

Thanks

Eric

>
> Thanks,
> Laurent
>



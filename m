Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7973C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9w1-0005OJ-1L; Tue, 21 Jan 2025 03:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta9w0-0005O5-1m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:48:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta9vy-0004mK-F2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737449308;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5n0qAl4u1Cd48x64E/f9fOPuxuUjY4pBmwGvXC0IJyk=;
 b=dRxQK+TvFp14yuKZC7r9v2rXN68NU+8SDUEIiM9Trwlos+YBPOVM9YjGgFRz2n6yZ6ivkm
 MVQaVxYLcILR2zxoV1VEBdAgAz6lW1BHVCFoslRv5sbynyT/ckWH6ujaBpdFQLkd2omkVh
 AFgLtLn6jndV6A7XuKG/D5laon/ytiU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-63hlOHKsO3iW6QVjcBgaQQ-1; Tue, 21 Jan 2025 03:48:27 -0500
X-MC-Unique: 63hlOHKsO3iW6QVjcBgaQQ-1
X-Mimecast-MFC-AGG-ID: 63hlOHKsO3iW6QVjcBgaQQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so2357129f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449306; x=1738054106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5n0qAl4u1Cd48x64E/f9fOPuxuUjY4pBmwGvXC0IJyk=;
 b=aUAJmyLR8sRfsKqkJsoV3/PF2WtJfilKHt3uuOuTYo5TFtdKujq46m7cZnvq4YGbFP
 zoY2DHmhYk1hlbhc/rCE+zbbEsvY4a6UaJlhP6ETkc1E3wDytWOFVbSwNLWW6SzJm7y3
 Fnd3xiqPk0atrjaWQPVnSKqE8fdjxJVltkmm8tfQeV8Tddly8bVqJTAzMYIakAASak33
 G2vWbLY0YTKt9/FSlVjb/rerTKs/H5Iiq0EPxaQecfWAVlti6s++TadUPyBpHvDX5Ut9
 CRK4nJXVp5GZ8wcGmqsPYYgk5hxMd6snjAe6ZnrFs6zYCcDtGMcPAc65SJY/uDuzEeRS
 Lcrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZiXeC+8ZxFP25+NFpAD/1TVTzaeNv1heDvXiesCU0LmQkwluqMxWa6OhmdTFM5SXva6uvFEFE7gq9@nongnu.org
X-Gm-Message-State: AOJu0YwIAV6wrkotyvH+aZDx3KBPN4r7LpLGXT4UWyHTvlzp18nKJRl1
 48AL0a9jwrvES8KwOLZ7wIIhF/2r5TEwVtxXDjXyLOPZfygqfdkIWI2jytTJEZd8VNZ1wf57aBH
 7EeKALAqMXBPaCter/OxlIovxEf2Z9A18VqiwPDGwiTndEMybng0Z
X-Gm-Gg: ASbGncvUW+uMAL/8dxeikJwexquHunhsjA8iSy3MKQcEqExzVhcOi1/cYlAlvzdIvT3
 e0qxOI1sqREt3R/05vcPIQJLoOegDYSE//NEqEwnxGb/gBh9GnJdF2lW92Ew8dHklIcF/b95dlT
 YP/K9tWtc0NANWgYt5u4aO34RMfqIe9SQKoORzdJKfJRc7IxQkvA/6C5BP6QBo2/87CYDwP7EjR
 zbJBDKOayMzF2cd9i3Fk+ssximiPK7/CE2fvvBWqH5zSEMAgK+xvRAWqmliOvuiSQQ+AFfjsWgq
 QkRFe1TRnwnXc50XsLF0ve3BC1sEcOR3lrrQjStBsQ==
X-Received: by 2002:a5d:6c63:0:b0:385:fdc2:1808 with SMTP id
 ffacd0b85a97d-38bf57a65b6mr16827487f8f.40.1737449305994; 
 Tue, 21 Jan 2025 00:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRMBksuIK0bERQmplsQ8uYIkXoEBFK7x/mKKGEIhbvH1S4aJd9OWdYVGZnNROIqiA6cGnq6g==
X-Received: by 2002:a5d:6c63:0:b0:385:fdc2:1808 with SMTP id
 ffacd0b85a97d-38bf57a65b6mr16827461f8f.40.1737449305674; 
 Tue, 21 Jan 2025 00:48:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275901sm12864379f8f.61.2025.01.21.00.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 00:48:24 -0800 (PST)
Message-ID: <b787ddcc-79f3-4b20-8c13-96569b8df095@redhat.com>
Date: Tue, 21 Jan 2025 09:48:23 +0100
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
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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
I guess you meant vhost_iommu_region_add()
> But you cannot unconditionally enable it (for instance if vhost is not
> started)
agreed. I will further look at the control path.
>
> Perhaps you should move the vhost_set_iotlb_callback() call from
> vhost_start()/vhost_stop() to
> vhost_iommu_region_add()/vhost_iommu_region_del()?
Interesting. I will study that.

Thanks!

Eric
>
> Thanks,
> Laurent
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6A8C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9wi-0005wK-Sy; Tue, 21 Jan 2025 03:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta9wh-0005w9-3q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ta9wf-0004qO-0j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737449351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3E8WZVbI42sE57i6MfXxudvtOsuTq6YBaIygJ4wgNdM=;
 b=gz5z2jHaKuIlHVm4a+092LmTjl2ZrI+a3SePk5DoiU1gm9mt3wuLLyebi+FNFxmUL35oUf
 m9tmc1ebJvraUjNpCwb3aY3wFw92mLQhH7v96m1t0CVYGg3RrydijdCp+IM0K/01Ud4fGE
 UNhWfRBGRYndLP0fYTYtPsjnJG3ObZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-zqKV3gOKOF6PBmJ7z9nLHA-1; Tue, 21 Jan 2025 03:49:09 -0500
X-MC-Unique: zqKV3gOKOF6PBmJ7z9nLHA-1
X-Mimecast-MFC-AGG-ID: zqKV3gOKOF6PBmJ7z9nLHA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436219070b4so26224765e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449348; x=1738054148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3E8WZVbI42sE57i6MfXxudvtOsuTq6YBaIygJ4wgNdM=;
 b=QClejEDlc/Dck8WEyVkKE6wk0gQtp3sDKk06sVk/GWH4eSi4+NH1u821s84i/KphLB
 /NRudYGQlD+Hl0Kmw6YjKk4UVYNFRLvZGx047VYwXQM35zGgq8NoJAQZxXUercnD6BVi
 aHZ6VNuB+TXI1koWW0L8CM2Oc9ePB1M4X1O5au2nmjiGL1GRYCleoGAenvZo2WNmceAS
 2izDd5wezk0MdeWRGcyCXrks8Uvx3wdM89ebsXQZGlEDGC6XSLh5uw8jrg3WS+rrkN4B
 FDckQtIbDzzN8iaaf+PNRgU58xrAc3tYU3Jhf6OYbXM+yQEXPCoIJifM4rW9DJtwzEdJ
 AlEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAu/VX0MDdOdnRvo6eSjRRAEbXAW4maa7k2k8AB0dOX/j1qluA4/15qm4LTDVkWnEKejqN8+fKkTAZ@nongnu.org
X-Gm-Message-State: AOJu0YxAc9issly6W9rsEqyTgmhj0nG0DpzWEjZ7hnyk4gzmM4uknf6o
 ezLsXaDQeLH9AS/Epe2nBUZ6telXb2P0/ZXhhgHCERCC0EqmhYVonRn+A7eYG//qUR7IIb4O/oK
 wjkGb0mlKzziF+WmvLiOlq3I/25y1VKx/wbKo5njw02o84soqSQmo
X-Gm-Gg: ASbGnctqKzMxQlJvr9XsZSADv+alcdvdHMMYPRPDOGdHBVFeSU1WUnn9CA4xHxsrX4K
 iCsvI7ig30MEeUB3vutHqddySBQO9849krANqRlE6Codxd7R+flLPEj6i/AXIp2G1/r+W6jWB+M
 nXHVc3r/UrCb6SBj6mQBSa3k3Blxf5hD5mexfyiThcGBzaBl7CEtEt6QzXmlGp8A28T+HnGgLtf
 gGFbFMJwzYdSlu7Xc2yV6PwTrGwQX8cr9PvShEsRtr2CfKX7FeYcA0yahEu/0lXWURF5sxmDRye
 JKk1JhuBc+0gsaUnIO3e2lSo9otj6sQdWJ/W8BtRYA==
X-Received: by 2002:a05:600c:1f0b:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4389142e1a3mr127177285e9.21.1737449347815; 
 Tue, 21 Jan 2025 00:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5HVKGyNeXNvxaPY+kOpU+L1N/NtyK7s40pQbwLKz/zV59CIKLy9nHpeBMsGABbc55byWVug==
X-Received: by 2002:a05:600c:1f0b:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-4389142e1a3mr127176915e9.21.1737449347191; 
 Tue, 21 Jan 2025 00:49:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74abb27sm226754145e9.9.2025.01.21.00.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 00:49:05 -0800 (PST)
Message-ID: <18571a8d-99d7-40da-8d19-1eb9410befbd@redhat.com>
Date: Tue, 21 Jan 2025 09:49:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, zhenzhong.duan@intel.com
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
 <tuzwgcjnxyz5sw2xjo4nyyl3xw3b7j5xqk67hsi5xk4xj3tv3a@hmmydeoupl35>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <tuzwgcjnxyz5sw2xjo4nyyl3xw3b7j5xqk67hsi5xk4xj3tv3a@hmmydeoupl35>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Stefano,


On 1/21/25 9:45 AM, Stefano Garzarella wrote:
> On Tue, Jan 21, 2025 at 09:31:53AM +0100, Laurent Vivier wrote:
>> On 20/01/2025 18:33, Eric Auger wrote:
>>> When a guest exposed with a vhost device and protected by an
>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>>
>>> Fail to lookup the translated address ffffe000
>>>
>>> We observe that the IOMMU gets disabled through a write to the global
>>> command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>>> When this warning happens it can be observed an inflight IOTLB
>>> miss occurs after the IOMMU disable and before the vhost stop. In
>>> that case a flat translation occurs and the check in
>>> vhost_memory_region_lookup() fails.
>>>
>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>>> unregistered.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>  hw/virtio/vhost.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 6aa72fd434..128c2ab094 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -931,6 +931,10 @@ static void
>>> vhost_iommu_region_del(MemoryListener *listener,
>>>              break;
>>>          }
>>>      }
>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>>> +    }
>>>  }
>>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>>
>> I think you need the counterpart in vhost_iommu_region_del() (for 
>
> I guess you meant vhost_iommu_region_add(). I was going to comment
> exactly on that, I agree here.
>
>> instance if we have an add after a del that results in an empty list).
>> But you cannot unconditionally enable it (for instance if vhost is
>> not started)
>
> Good point.
>
>>
>> Perhaps you should move the vhost_set_iotlb_callback() call from
>> vhost_start()/vhost_stop() to
>> vhost_iommu_region_add()/vhost_iommu_region_del()?
>
> I also like this idea.

OK makes sense. I will go in this direction.

Eric
>
> Stefano
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242E6C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdnkT-0000d4-FZ; Fri, 31 Jan 2025 04:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdnkP-0000ct-MK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdnkM-0005Hh-5U
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738317333;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEVm/py7fZ7YQyjaZIh1LZLDJSumr5L3J8baiimwTzg=;
 b=G45pRT4ROt6LJ1pac9r745m/gkPtdYo56zTARwEgVIL9MLxF+M0xKwV1VAK2gpBRcOFbPS
 JpMSjVwAomkrQY7KGc21vS3DpPMjwwv9t8ddMM2Pb2FDuhpFfmsAhGgf70tZ2Zxb8MWv0k
 NeNkYaTb1qE4Kn3mg+Fu7kl51UfTpF4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-hldwfcDMPj6ZETYmvCE5gQ-1; Fri, 31 Jan 2025 04:55:30 -0500
X-MC-Unique: hldwfcDMPj6ZETYmvCE5gQ-1
X-Mimecast-MFC-AGG-ID: hldwfcDMPj6ZETYmvCE5gQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38634103b0dso1137159f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 01:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738317329; x=1738922129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEVm/py7fZ7YQyjaZIh1LZLDJSumr5L3J8baiimwTzg=;
 b=i8iXFmijfGl6V3PZsB+bSb9nDD6sh05kLuW0CwZu9CHL7nambE8g2woB5YL+tjjv8z
 4eMemW8bIGyd+HQDy8MocWu/9bRzxX83FSzrK5hof1aJB8Ubsk/2EuDgXbTalLE6Tcut
 k4Biw9K2Nuu7wyX5M8b84G5Xa5Ye32gt6wjkFLqfzOnRLqjods9fIkolLV7MEOukfTNQ
 Ev5WYiXraRTslnh3g/HiCSoUKXayfM/NyXcYc8CiHy1x344P4vlAKCmXBwLFGFak8Yy+
 fHNZdkGm9CPkAfk6Ha+0gnSv5uPmLEnxb4U7Hh0uf6nE7qou7BAXsv/dyOQJkYc00lL2
 hpBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXid7v5y7GHwKfSAF6eTEUviZlJ5wiA37hmDP2Nl6+/IMgn+TeA8arD6v+X81qhNN8fq7XZOMWLvbxw@nongnu.org
X-Gm-Message-State: AOJu0Yy1sYHFJD6YSTbasuXE+rJOTjJvBg873X9MpTd3jQVewxTlp2ku
 TJSKcrQis+FK/s0qJ32t2Ewtz/LixEYa7A8rUeizQi/xLtCzMh4e6ryo1bEEBWJiulYp9cLkKD0
 Kggrbdyw/T76w4eV9CdaKesWPfbTO7mhgJw10Sd+LyMY+JTpM5lCx
X-Gm-Gg: ASbGncvVwVbMP9gcMjc7lW0/+F0Km2mhvwwasdBUEnQPeL9fmGXebOZFbWUZu85zkn2
 ZNmXPHU/0LHwguQOpcQIKY3U19pFvw/C1VOG+81tHc3iA6aSyy4p8Qsk9Zgqm5lQrQFpvBvcwB5
 VP2Ed7CqGczzW4h10OMowkXsj0jvzb+YhatsAsUmPoDRJPp212baup7lfqP5Td7PsPBMyvsiZF2
 3mdRH0F8c2GlAA8TLC5LCoLgobbwc9T25DqJQmGmG3MdBb4KHr8DpSYEU0JIpbE9nyzPg+hqWE4
 t8qO6Qmc1QMu/jVa7mIde1xY521jMH93WPOR4LzFMKUH2Xm0sann
X-Received: by 2002:a05:6000:bd0:b0:385:f64e:f163 with SMTP id
 ffacd0b85a97d-38c51967e87mr6304322f8f.32.1738317329574; 
 Fri, 31 Jan 2025 01:55:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbgVVaX/V77GpxBE2lNP3zNhxUbppwjru+s/1vVqGb/vigoVGwn6zxD/ZNu9MmnH/9js+9Pw==
X-Received: by 2002:a05:6000:bd0:b0:385:f64e:f163 with SMTP id
 ffacd0b85a97d-38c51967e87mr6304300f8f.32.1738317329203; 
 Fri, 31 Jan 2025 01:55:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e5e53sm49168405e9.17.2025.01.31.01.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:55:28 -0800 (PST)
Message-ID: <1c073acc-095e-45f0-977c-e22557f180f2@redhat.com>
Date: Fri, 31 Jan 2025 10:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


Hi

On 1/24/25 3:44 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
>> disabled
>>
>> Hi Jason,
>>
>>
>> On 1/23/25 2:34 AM, Jason Wang wrote:
>>> On Wed, Jan 22, 2025 at 3:55 PM Eric Auger <eric.auger@redhat.com> wrote:
>>>> Hi Jason,
>>>>
>>>>
>>>> On 1/22/25 8:17 AM, Jason Wang wrote:
>>>>> On Wed, Jan 22, 2025 at 12:25 AM Eric Auger <eric.auger@redhat.com>
>> wrote:
>>>>>> Hi Jason,
>>>>>>
>>>>>> On 1/21/25 4:27 AM, Jason Wang wrote:
>>>>>>> On Tue, Jan 21, 2025 at 1:33 AM Eric Auger <eric.auger@redhat.com>
>> wrote:
>>>>>>>> When a guest exposed with a vhost device and protected by an
>>>>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>>>>>>>
>>>>>>>> Fail to lookup the translated address ffffe000
>>>>>>>>
>>>>>>>> We observe that the IOMMU gets disabled through a write to the global
>>>>>>>> command register (CMAR_GCMD.TE) before the vhost device gets
>> stopped.
>>>>>>>> When this warning happens it can be observed an inflight IOTLB
>>>>>>>> miss occurs after the IOMMU disable and before the vhost stop. In
>>>>>>>> that case a flat translation occurs and the check in
>>>>>>>> vhost_memory_region_lookup() fails.
>>>>>>>>
>>>>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>>>>>>>> unregistered.
>>>>>>>>
>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>> ---
>>>>>>>>  hw/virtio/vhost.c | 4 ++++
>>>>>>>>  1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>>>> index 6aa72fd434..128c2ab094 100644
>>>>>>>> --- a/hw/virtio/vhost.c
>>>>>>>> +++ b/hw/virtio/vhost.c
>>>>>>>> @@ -931,6 +931,10 @@ static void
>> vhost_iommu_region_del(MemoryListener *listener,
>>>>>>>>              break;
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>>>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>>>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>>>>>>>> +    }
>>>>>>> So the current code assumes:
>>>>>>>
>>>>>>> 1) IOMMU is enabled before vhost starts
>>>>>>> 2) IOMMU is disabled after vhost stops
>>>>>>>
>>>>>>> This patch seems to fix 2) but not 1). Do we need to deal with the
>>>>>>> IOMMU enabled after vhost starts?
>>>>>> sorry I initially misunderstood the above comment. Indeed in the reboot
>>>>>> case assumption 2) happens to be wrong. However what I currently do is:
>>>>>> stop listening to iotlb miss requests from the kernel because my
>>>>>> understanding is those requests are just spurious ones, generate
>>>>>> warnings and we do not care since we are rebooting the system.
>>>>>>
>>>>>> However I do not claim this could handle the case where the IOMMU MR
>>>>>> would be turned off and then turned on. I think in that case we should
>>>>>> also flush the kernel IOTLB and this is not taken care of in this patch.
>>>>>> Is it a relevant use case?
>>>>> Not sure.
>>>>>
>>>>>> wrt removing assumption 1) and allow IOMMU enabled after vhost start. Is
>>>>>> that a valid use case as the virtio driver is using the dma api?
>>>>> It should not be but we can't assume the behaviour of the guest. It
>>>>> could be buggy or even malicious.
>>>> agreed
>>>>> Btw, we had the following codes while handling te:
>>>>>
>>>>> /* Handle Translation Enable/Disable */
>>>>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>>>>> {
>>>>>     if (s->dmar_enabled == en) {
>>>>>         return;
>>>>>     }
>>>>>
>>>>>     trace_vtd_dmar_enable(en);
>>>>>
>>>>> ...
>>>>>
>>>>>     vtd_reset_caches(s);
>>>>>     vtd_address_space_refresh_all(s);
>>>>> }
>>>>>
>>>>> vtd_address_space_refresh_all() will basically disable the iommu
>>>>> memory region. It looks not sufficient to trigger the region_del
>>>>> callback, maybe we should delete the region or introduce listener
>>>>> callback?
>>>> This is exactly the code path which is entered in my use case.
>>>>
>>>> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. But
>> given the current implement of this latter the IOTLB callback is not unset and the
>> kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem->regions are
>> not updated? shouldn't they. Can you explain what they correspond to?
>>> Adding Peter for more ideas.
>>>
>>> I think it's better to find a way to trigger the listener here, probably:
>>>
>>> 1) add/delete the memory regions instead of enable/disable
>> sorry I don't understand what you mean. The vhost_iommu_region_del call
>> stack is provided below [1]. Write to the intel iommu GCMD TE bit
>> induces a call to vhost_iommu_region_del. This happens before the
>> vhost_dev_stop whose call stack is provided below [2] and originates
> >from a bus reset.
>> We may have inflight IOTLB miss requests happening between both.
>>
>> If this happens, vhost_device_iotlb_miss() fails because the IOVA is not
>> translated anymore by the IOMMU and the iotlb.translated_addr returned
>> by address_space_get_iotlb_entry() is not within the registered
>> vhost_memory_regions looked up in vhost_memory_region_lookup(), hence
>> the "Fail to lookup the translated address" message.
>>
>> It sounds wrong that vhost keeps on using IOVAs that are not translated
>> anymore. It looks we have a reset ordering issue and this patch is just
>> removing the sympton and not the cause.
>>
>> At the moment I don't really get what is initiating the intel iommu TE
>> bit write. This is a guest action but is it initiated from a misordered
>> qemu event?
> During reboot, native_machine_shutdown() calls x86_platform.iommu_shutdown()
> to disable iommu before reset. So Peter's patch will not address your issue.
>
> Before iommu shutdown, device_shutdown() is called to shutdown all devices.
> Not clear why vhost is still active.

I tested [PATCH] virtio: Remove virtio devices on device_shutdown()
https://lore.kernel.org/all/20240808075141.3433253-1-kirill.shutemov@linux.intel.com/

and it fixes my issue

Eric
>
> Thanks
> Zhenzhong
>
>> It could also relate to
>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>> https://lore.kernel.org/all/?q=s%3Aintel_iommu%3A+Reset+vIOMMU+after+all+
>> the+rest+of+devices



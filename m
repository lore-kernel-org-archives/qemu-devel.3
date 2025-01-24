Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F83C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNuv-0006ZF-De; Fri, 24 Jan 2025 12:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tbNuu-0006Z7-Ed
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tbNur-0005IB-RU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737741384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yU6qf0jMuQjXSz+keIhxflSRXtL4uK9t/t/bAWYiY70=;
 b=Ljc7mLIRtb3xmq37HB1JI/apbVGHzB4+gue3EGInYnagm2UX4sVkNLwvRzGqQxeI/zV6DX
 xgU9klDVdHRyuktjDbxaEyajIb6IhY78HUPxEtPMIsb/IhLQDxV/+LMkFu+e20RW2iGNZk
 TWNXwo+yy6ozt1LZcd2yE0HHHkKI7FQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-iO1E4T0xM46ln4r-I4rCYg-1; Fri, 24 Jan 2025 12:56:20 -0500
X-MC-Unique: iO1E4T0xM46ln4r-I4rCYg-1
X-Mimecast-MFC-AGG-ID: iO1E4T0xM46ln4r-I4rCYg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e00ebb16so900887f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737741378; x=1738346178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yU6qf0jMuQjXSz+keIhxflSRXtL4uK9t/t/bAWYiY70=;
 b=wNjiaGaNC90aqkp6fLG1yKEYqC7FT7cgre2+7nX+j1gBwBYPmC6PelMldULfv7b11K
 TL1CXRdtgj4T7LYV8V0jK9VYO35z5V39VJ2mLbC1tpXggFNbwz/lByX4aFUJ0EQ29HwD
 mbStfEPgFrdFeQZqJwzvEKMNkN2bA9/yGS4xn8NdBYAlSolvY7oLf4enPRVOe1aSHuci
 4K6+t3V58s3cZI7hAQC0rIbXsU+s5ZQeUvK/WivpYqyd0DLX51AtGtUP91YBguHydO5N
 q62FlEAD7ClZU7+SIMgp3ngCz4XbVDkZGXQerbWEZqHskSiQf4YVOyzzE2BnJWS4XHUr
 htKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSKAjiiqE1uK6Wkq7UqB0jHhNeQj7y5vQiAsB5Z7ZEUnybZpmMg82SDPY0Hs8H6ENM2F8RrZTp8m9c@nongnu.org
X-Gm-Message-State: AOJu0YyDCtjaqcRadeIUTk8v9L5+bI9oPDbJOR/xgvhy6onYzOjrBIyN
 ZlQelYueHCgTCJHAAFFWbesYbglOoXxyS/xz7N/RmC2ruOZKg3u9gifG/pSDgXA5NUi1q3uJCZm
 LcdC3O+2viNulxqh1sFrYSUeZiTcyBub+GeTT77+lTihC/KrnHs+r
X-Gm-Gg: ASbGnctccTX52lxz6/Lhk+FPMIvgX4r4fPKNNASy6jOfGTXqKAhYEm7otgaPZq6h2Rz
 +oo21Vcswi6nwy0r0HMlxtO36n7Hokrl0EFThMl2dQHC7tMdUBXVK/Ts4jHwHcJwLEb6DEFTZLT
 P3TNqJ4fR4B5T+PQCq9QkLAd7xb0TvriPtQ3mgRqFLP20bEwBqwUqu6a4I+XJ8IjK+8PuWayjGW
 LRcfj4Nl/riyZQMnNVT2d/stdSb4SK98MPhXJtBb8aBKpB/EklXJTw0vgsOcHSSCGhAUfcXTy8D
 CQGNr3lIY7ss9OO8hiloza9IxJqTjy4gB8QjAfczDw==
X-Received: by 2002:a05:6000:18a8:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-38bf57a9a86mr37359020f8f.38.1737741378513; 
 Fri, 24 Jan 2025 09:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoHOGhhqrTv4HqwOfMTYw72b6Av0kAMwBSHyOKd5fI6rlUWuvTlBpaqx/q7y/Jfum02GdVvg==
X-Received: by 2002:a05:6000:18a8:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-38bf57a9a86mr37358998f8f.38.1737741378129; 
 Fri, 24 Jan 2025 09:56:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6d7sm3408243f8f.31.2025.01.24.09.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:56:17 -0800 (PST)
Message-ID: <58648d19-a66e-4035-bb86-7df65634596f@redhat.com>
Date: Fri, 24 Jan 2025 18:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 1/24/25 4:41 AM, Jason Wang wrote:
> On Fri, Jan 24, 2025 at 11:30 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Jan 24, 2025 at 10:44 AM Duan, Zhenzhong
>> <zhenzhong.duan@intel.com> wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
>>>> disabled
>>>>
>>>> Hi Jason,
>>>>
>>>>
>>>> On 1/23/25 2:34 AM, Jason Wang wrote:
>>>>> On Wed, Jan 22, 2025 at 3:55 PM Eric Auger <eric.auger@redhat.com> wrote:
>>>>>> Hi Jason,
>>>>>>
>>>>>>
>>>>>> On 1/22/25 8:17 AM, Jason Wang wrote:
>>>>>>> On Wed, Jan 22, 2025 at 12:25 AM Eric Auger <eric.auger@redhat.com>
>>>> wrote:
>>>>>>>> Hi Jason,
>>>>>>>>
>>>>>>>> On 1/21/25 4:27 AM, Jason Wang wrote:
>>>>>>>>> On Tue, Jan 21, 2025 at 1:33 AM Eric Auger <eric.auger@redhat.com>
>>>> wrote:
>>>>>>>>>> When a guest exposed with a vhost device and protected by an
>>>>>>>>>> intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>>>>>>>>>
>>>>>>>>>> Fail to lookup the translated address ffffe000
>>>>>>>>>>
>>>>>>>>>> We observe that the IOMMU gets disabled through a write to the global
>>>>>>>>>> command register (CMAR_GCMD.TE) before the vhost device gets
>>>> stopped.
>>>>>>>>>> When this warning happens it can be observed an inflight IOTLB
>>>>>>>>>> miss occurs after the IOMMU disable and before the vhost stop. In
>>>>>>>>>> that case a flat translation occurs and the check in
>>>>>>>>>> vhost_memory_region_lookup() fails.
>>>>>>>>>>
>>>>>>>>>> Let's disable the IOTLB callbacks when all IOMMU MRs have been
>>>>>>>>>> unregistered.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>  hw/virtio/vhost.c | 4 ++++
>>>>>>>>>>  1 file changed, 4 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>>>>>> index 6aa72fd434..128c2ab094 100644
>>>>>>>>>> --- a/hw/virtio/vhost.c
>>>>>>>>>> +++ b/hw/virtio/vhost.c
>>>>>>>>>> @@ -931,6 +931,10 @@ static void
>>>> vhost_iommu_region_del(MemoryListener *listener,
>>>>>>>>>>              break;
>>>>>>>>>>          }
>>>>>>>>>>      }
>>>>>>>>>> +    if (QLIST_EMPTY(&dev->iommu_list) &&
>>>>>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback) {
>>>>>>>>>> +        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>>>>>>>>>> +    }
>>>>>>>>> So the current code assumes:
>>>>>>>>>
>>>>>>>>> 1) IOMMU is enabled before vhost starts
>>>>>>>>> 2) IOMMU is disabled after vhost stops
>>>>>>>>>
>>>>>>>>> This patch seems to fix 2) but not 1). Do we need to deal with the
>>>>>>>>> IOMMU enabled after vhost starts?
>>>>>>>> sorry I initially misunderstood the above comment. Indeed in the reboot
>>>>>>>> case assumption 2) happens to be wrong. However what I currently do is:
>>>>>>>> stop listening to iotlb miss requests from the kernel because my
>>>>>>>> understanding is those requests are just spurious ones, generate
>>>>>>>> warnings and we do not care since we are rebooting the system.
>>>>>>>>
>>>>>>>> However I do not claim this could handle the case where the IOMMU MR
>>>>>>>> would be turned off and then turned on. I think in that case we should
>>>>>>>> also flush the kernel IOTLB and this is not taken care of in this patch.
>>>>>>>> Is it a relevant use case?
>>>>>>> Not sure.
>>>>>>>
>>>>>>>> wrt removing assumption 1) and allow IOMMU enabled after vhost start. Is
>>>>>>>> that a valid use case as the virtio driver is using the dma api?
>>>>>>> It should not be but we can't assume the behaviour of the guest. It
>>>>>>> could be buggy or even malicious.
>>>>>> agreed
>>>>>>> Btw, we had the following codes while handling te:
>>>>>>>
>>>>>>> /* Handle Translation Enable/Disable */
>>>>>>> static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>>>>>>> {
>>>>>>>     if (s->dmar_enabled == en) {
>>>>>>>         return;
>>>>>>>     }
>>>>>>>
>>>>>>>     trace_vtd_dmar_enable(en);
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>     vtd_reset_caches(s);
>>>>>>>     vtd_address_space_refresh_all(s);
>>>>>>> }
>>>>>>>
>>>>>>> vtd_address_space_refresh_all() will basically disable the iommu
>>>>>>> memory region. It looks not sufficient to trigger the region_del
>>>>>>> callback, maybe we should delete the region or introduce listener
>>>>>>> callback?
>>>>>> This is exactly the code path which is entered in my use case.
>>>>>>
>>>>>> vtd_address_space_refresh_all(s) induces the vhost_iommu_region_del. But
>>>> given the current implement of this latter the IOTLB callback is not unset and the
>>>> kernel IOTLB is not refreshed. Also as I pointed out the  hdev->mem->regions are
>>>> not updated? shouldn't they. Can you explain what they correspond to?
>>>>> Adding Peter for more ideas.
>>>>>
>>>>> I think it's better to find a way to trigger the listener here, probably:
>>>>>
>>>>> 1) add/delete the memory regions instead of enable/disable
>>>> sorry I don't understand what you mean. The vhost_iommu_region_del call
>>>> stack is provided below [1]. Write to the intel iommu GCMD TE bit
>>>> induces a call to vhost_iommu_region_del. This happens before the
>>>> vhost_dev_stop whose call stack is provided below [2] and originates
>>> >from a bus reset.
>>>> We may have inflight IOTLB miss requests happening between both.
>>>>
>>>> If this happens, vhost_device_iotlb_miss() fails because the IOVA is not
>>>> translated anymore by the IOMMU and the iotlb.translated_addr returned
>>>> by address_space_get_iotlb_entry() is not within the registered
>>>> vhost_memory_regions looked up in vhost_memory_region_lookup(), hence
>>>> the "Fail to lookup the translated address" message.
>>>>
>>>> It sounds wrong that vhost keeps on using IOVAs that are not translated
>>>> anymore. It looks we have a reset ordering issue and this patch is just
>>>> removing the sympton and not the cause.
>>>>
>>>> At the moment I don't really get what is initiating the intel iommu TE
>>>> bit write. This is a guest action but is it initiated from a misordered
>>>> qemu event?
>>> During reboot, native_machine_shutdown() calls x86_platform.iommu_shutdown()
>>> to disable iommu before reset. So Peter's patch will not address your issue.
>>>
>>> Before iommu shutdown, device_shutdown() is called to shutdown all devices.
>>> Not clear why vhost is still active.
>> It might be because neither virtio bus nor virtio-net provides a
>> shutdown method.
>>
>> There used to be requests to provide those to unbreak the kexec.
> More could be seen at https://issues.redhat.com/browse/RHEL-331

Cool, we have a culprit now :-) I see the ticket is closed, I will
reopen it. Are there known implementation challenges that caused the fix
postponing or do we "just" need someone with free cycles to carry out
the task. By the way FYI, we have other tickets opened related to vSMMU
and virtio devices also happening during reboot.

Thanks

Eric
> This looks exactly the same issue.
>
> Thanks
>
>> A quick try might be to provide a .driver.shutdown to
>> virtio_net_driver structure and reset the device there as a start.
>>
>> Thanks
>>
>>> Thanks
>>> Zhenzhong
>>>
>>>> It could also relate to
>>>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>>>> https://lore.kernel.org/all/?q=s%3Aintel_iommu%3A+Reset+vIOMMU+after+all+
>>>> the+rest+of+devices



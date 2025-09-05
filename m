Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6452CA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRpr-0004Un-9e; Fri, 05 Sep 2025 04:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuRpX-0004Of-Rj
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuRpO-0003KJ-GC
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757060985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANz24xGTmMw8EbUDpPAhuSYFUDV4bq3DLZrSflrKfAk=;
 b=hz2Y1QkQdvD+Z16dXbgGeKeJaAjO2RczKgsidpEaerXTdeMOcZUqIAjazAjSw6xk11wvuM
 X77PQVt6LjI4C9P1NBVdlnSn8ntlvHO8EJywNrYjeNbG6Afl1PmbFfbzPXxUu6CEfvlgKr
 pb/ir/ZkRyzG2eqYVByOhZmmDLVntN8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-X2P-fR54PsW5h0FytfrBIw-1; Fri, 05 Sep 2025 04:29:43 -0400
X-MC-Unique: X2P-fR54PsW5h0FytfrBIw-1
X-Mimecast-MFC-AGG-ID: X2P-fR54PsW5h0FytfrBIw_1757060983
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ce3e098c48so900372f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757060982; x=1757665782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANz24xGTmMw8EbUDpPAhuSYFUDV4bq3DLZrSflrKfAk=;
 b=YN/hIYCPEPeuAds/yCNeLcpTNuEh3AtvK0S/tLlJyD4H0lbS7ikGr7X4I30BpvMt8p
 x+jT0N2GIDMufArYJirSxLWhnJY9W0lBxCYSWq9NJUmESa0z/uqfryFWkR1osyRudv3w
 Uv8kHAp9HEPocSZEewKuN6rSm4iSL8+pU4t4b0nxlxe43+v7rRCUEENaZLm8bhqS2JGb
 bQZibuzHDYkJL9EPkIsd9V/VOfNJgcKv6VMauOKumLKjCPM86pr+EEe+uc5innSW4CxO
 nhvThW63Vr0JOF+Pyjk4ibUD7IzxIbzrmgEBeu/8Rzp9J3r6MK/crzwbgWoIp+ahFiNC
 FY/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK/5jWQP/KktqxTvqaSRAR+LH/9Fu8Vw9an37B+7IltIH4X2sJT099cyAoCihSY5ecLMhJqw4GGuLh@nongnu.org
X-Gm-Message-State: AOJu0YyMGqLF6PNjyioGNrcmgFbmaJwE0yGHM9h7mBh6Gee4xm8R+Ic5
 FaK9DCjVCaxVb/riRtaKxObRTRUHOIZVkPSYZWaMkwnfqOAHD3QmqHvg3l4RZtv05vGayPtVCCC
 S7dyxF4+ZFG8zQ3eIMiRMu3dez2xQ4w5uvIE8y9olOzWAyI985iACdULH
X-Gm-Gg: ASbGncvq5ObE58+4K7VSodn1qArz+wCilytKKSwOvlO56UUOdDLai0jEd4FSYCy3NoI
 pCJMmBsUohZrbGf6RbNlq9jSFAxBxQVKNi5ilHqASTn5+6Id6uQhiocnrC6smGtCMwvERIDwPz2
 xTwxgv855e6Z1O9dGLOBjG7nTbtcg1DlYlzYMzWUaKFqR2C/19hEGT+B0EIINkwcFG9Osjmwtjc
 MO41533btxvwUrL2NWfXLQWXJm/ZExOWJIddRJrYEH0X3Vzxe+V3Ad2tFPM8JPM2z9tSKAihQvp
 TD7RM4oezf+/m8Jc0I+K+vgxLIY1HGNRfZTRDfkjXjd74pIeFDUOus3WJDLZzsDmEyZAZcYOuuD
 Azpt7FfbDYME=
X-Received: by 2002:adf:a15b:0:b0:3e1:6b:bb27 with SMTP id
 ffacd0b85a97d-3e1006bbe0bmr2308997f8f.4.1757060982513; 
 Fri, 05 Sep 2025 01:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/c/9inFXKtY1A0tOkt5IyweE6DaANYzxUR2ry6IWMBP8cStuPMZ/UVxnBn2fcEjufW+cRnQ==
X-Received: by 2002:adf:a15b:0:b0:3e1:6b:bb27 with SMTP id
 ffacd0b85a97d-3e1006bbe0bmr2308986f8f.4.1757060982058; 
 Fri, 05 Sep 2025 01:29:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45d468dbf48sm81911265e9.11.2025.09.05.01.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 01:29:41 -0700 (PDT)
Message-ID: <27f2cf53-cfe8-45ea-8df9-d5afccbc43e4@redhat.com>
Date: Fri, 5 Sep 2025 10:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, skolothumtho@nvidia.com
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
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <756cf804fbd14d66ba8f23358524fe96@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <756cf804fbd14d66ba8f23358524fe96@huawei.com>
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

Hi Shameer,

On 7/16/25 10:06 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Tuesday, July 15, 2025 6:59 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; eric.auger@redhat.com;
>> peter.maydell@linaro.org; jgg@nvidia.com; ddutile@redhat.com;
>> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
>> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>> accelerated SMMUv3 to vfio-pci endpoints with iommufd
> ...
>
>>>> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
>>>> +        error_report("Device(%s) not allowed. Only PCIe root complex
>>>> devices "
>>>> +                     "or PCI bridge devices or vfio-pci endpoint devices
>>>> with "
>>>> +                     "iommufd as backend is allowed with
>>>> arm-smmuv3,accel=on",
>>>> +                     pdev->name);
>>>> +        exit(1);
>>> Seems aggressive for a hotplug, could we fail hotplug instead of kill
>> QEMU?
> That's right. I will try to see whether it is possible to do a dev->hotplugged
> check here.
>  
>> Hotplug will unlikely be supported well, as it would introduce
>> too much complication.
>>
>> With iommufd, a vIOMMU object is allocated per device (vfio). If
>> the device fd (cdev) is not yet given to the QEMU. It isn't able
>> to allocate a vIOMMU object when creating a VM.
>>
>> While a vIOMMU object can be allocated at a later stage once the
>> device is hotplugged. But things like IORT mappings aren't able
>> to get refreshed since the OS is likely already booted.
> Why do we need IORT mappings to be refreshed during hotplug?
> AFAICS, the mappings are created per host bridge Ids. And how is this
> different from a host machine doing hotplug?
>
>  Even an
>> IOMMU capability sync via the hw_info ioctl will be difficult to
>> do at the runtime post the guest iommu driver's initialization.
> We had some discussion on this "at least one vfio-pci" restriction
> for accelerated mode previously here.
> https://lore.kernel.org/qemu-devel/Z6TtCLQ35UI12T77@redhat.com/#t
>
> I am not sure we reached any consensus on that. The 3 different approaches
> discussed were,
>
> 1. The current one used here. At least one cold plugged vfio-pci device
>    so that  we can retrieve the host SMMUV3 HW_INFO as per current
>   IOMMUFD APIs.

I do not get why you can't wait for the 1st device to be attached to
"freeze" the settings. Is it because you may also have some bridges /
root ports also attached to the same viommu. As those latter do not have
any adherence to the host SMMU, is that a problem?
>
> 2. A new IOMMUFD API to retrieve HW_INFO without a device. 
this can only be possible if, on the command line you connect the vsmmu
to a sysfs path to the host iommu (or maybe this is what you meant in
3). This would be another option we also evoked in the past. But this is
not very user friendly for the guy who launches the VM to care both the
device and the associated physical SMMU. Logically we could build that
relationship automatically.
>
> 3. A fully specified vSMMUv3 through Qemu command line so that we
>    don't need HW_INFO from kernel.

I don't think this is sensible as there may be plenty of those, each
requirement a libvirt adaptation

Eric
>
> We're going with option one for now, but completely blocking hotplug
> because of it  feels a bit too restrictive to me.
>
> The real issue (for now), as I see it, is that we need some way to remember
> the Guest SMMUv3 <-> Host SMMUv3 mapping after the guest has booted.
> That way, even if all devices tied to a Guest SMMUv3 get hot-unplugged,
> QEMU can still block attaching a device that belongs to a different Host
> SMMUv3.
>
> Thanks,
> Shameer
>
>> I am not 100% sure. But I think Intel model could have a similar
>> problem if the guest boots with zero cold-plugged device and then
>> hot-plugs a PASID-capable device at the runtime, when the guest-
>> level IOMMU driver is already inited?
>>
>> FWIW, Shameer's cover-letter has the following line:
>>  "At least one vfio-pci device must currently be cold-plugged to
>>   a PCIe root complex associated with arm-smmuv3,accel=on."
>>
>> Perhaps there should be a similar highlight in this smmuv3-accel
>> file as well (@Shameer).
>>
>> Nicolin



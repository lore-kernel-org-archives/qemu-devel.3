Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D53CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYge-00019p-VG; Wed, 20 May 2026 00:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPYgd-000191-Fd
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wPYgZ-0003nj-1V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779251851;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx5elmJ0/YW5NJGNx916OPYDqI0bw0993vlbxSoa/pE=;
 b=Z0QOforH/0McjhUn67/be5qwORcWOWdocbb2K6PFJKcAS6UzWNIrsQ/j86rOEmEcTQqn2G
 I/fxc/cYdEbr94JYgvUT+uqhXVcLfsQX9GChesUv3MYERfKZSgEOhCThfFIhW04hDPGPDA
 zf8JXlzGlX6BDGsdp5qXcnMYndGXxcg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-ZOwQTup8OOaWnnkEV4URMw-1; Wed, 20 May 2026 00:37:29 -0400
X-MC-Unique: ZOwQTup8OOaWnnkEV4URMw-1
X-Mimecast-MFC-AGG-ID: ZOwQTup8OOaWnnkEV4URMw_1779251849
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fdad6cce4so17787165e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251849; x=1779856649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx5elmJ0/YW5NJGNx916OPYDqI0bw0993vlbxSoa/pE=;
 b=Ym6gStNL0qBwANGDSm7R2c3cDxtsOVisidXllAaXRKlIkJkC+7MKv9PQAdym671DGL
 I9XQrVEE2mH2WNQYUEcy40YhL6hE6FEt6UYJd4BC+3Hcq/E05+Y2X74+zNUJSKzGFSuQ
 msXZ8Idx+D8JLZP/1cM93LZ5fQoJJW6mKm4AwBzO9hwIt8BXa6L3WPH64jw1FCAKw7de
 gYfU5JfIJVnKHiegEqWt6VM9xgso8GeXlvmKoP/L0nfd1pZWtfXNVf9/EwMdnt6MxL+k
 9dzYpcIRE1ogQn6LVFjbMZbAvDJLRfLPfXJ367o45kxIFcLayWgzvE0exhlLtFVdD8O6
 pZ5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QksYnOOOoELp1hIZ7APH41BAUZLYVLuCFctvINea8SnO43nfHbMEnX81TO3mM8xBI0wMumQ0O3EQD@nongnu.org
X-Gm-Message-State: AOJu0YxhV0mAEuAZZIhJGPt5Ev5Ai24NjgBFuKSsx64+acfSMuM5qHSI
 g3Ym89jlXAmRgOe18PPsgFWx+6QCPoN0BtObHrshyn+5w0Tpk1zvhueQ7pe4U1+TaljrBARCD7w
 79nUesfQVPiG7P9xS3i0yT/yTNbUEVE2SqBhaC1dL3WSvuLeyRs5ouDcU
X-Gm-Gg: Acq92OGVouD8SuuyfKW3ixDPWoZ5sr5i9SAk4SEql9tHSl+YKtuJ8hHNWiPpLZhImUU
 wo7kGwZCiKdRBZNFkQ5I18GEY9ABpfjqg3sy0Dmzpiw56c4BZRQJlwtHBXHBiPfpmVjZBpmLOr2
 laQn18jdlGw6uXJaQvZ+rr0xVfbtgHZA28HHcLGFxy6x+iz2fst9zy9GDaIO9mVRsnVCgqtglOC
 wwltZn9BqzaCe3ovEcjuRr1KZzUKvsnr7e4a/kC95F4RxzddIne1x7W907qeIEduplayhxp6OUq
 KbrafgjTLTnlq8TkYzZt6VhyzMBVsYx27q0lGqdYOl8ZoKfZthJyIoB3wMjcvpUCshFZq0AuPnV
 DNN22xLGaLSM5590RzC9zrYnAp5EL7HrwpIyhBsEDpIoymX0mWQo1eFCotEWbgCLRL80YKw==
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-48fe53a8eccmr336394325e9.16.1779251848676; 
 Tue, 19 May 2026 21:37:28 -0700 (PDT)
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-48fe53a8eccmr336393875e9.16.1779251848267; 
 Tue, 19 May 2026 21:37:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm362214585e9.4.2026.05.19.21.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 21:37:27 -0700 (PDT)
Message-ID: <f74464a4-ca5c-42ae-9dd2-16a24a568b8a@redhat.com>
Date: Wed, 20 May 2026 06:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-7-nathanc@nvidia.com>
 <acd61fd5-a0f8-41f9-9144-d6889d6deaf0@redhat.com>
 <bdc232c5-4409-4828-826d-988a620a5d21@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <bdc232c5-4409-4828-826d-988a620a5d21@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Nathan,

On 5/19/26 11:04 PM, Nathan Chen wrote:
>
>
> On 5/19/2026 8:59 AM, Eric Auger wrote:
>>
>> On 5/12/26 9:35 PM, Nathan Chen wrote:
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
>>> to match the host IOMMU properties when accel=on.
>>>
>>> If accel=off and these property values are set to auto, the default
>>> property values defined in smmuv3_init_id_regs() for OAS and RIL will
>>> remain unchanged, while SSIDSIZE and ATS values will remain initialized
>>> at 0.
>>>
>>> Introduce a new compat for the changed defaults.
>>>
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>>>   hw/core/machine.c |  5 +++++
>>>   2 files changed, 20 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 31c2eec2f4..665e6a2538 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
>>>       DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>>>       /* GPA of MSI doorbell, for SMMUv3 accel use. */
>>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>> +    /*
>>> +     * AUTO values for accel=off will resolve to:
>>> +     * ril: on
>>> +     * ats: off
>>> +     * oas: 44
>>> +     * ssidsize: 0
>>> +     */
>>>       /* RIL can be turned off for accel cases */
>>> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>>> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>>> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>>> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril,
>>> ON_OFF_AUTO_AUTO),
>>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
>>> ON_OFF_AUTO_AUTO),
>>> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>>>       DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>>> -                              SSID_SIZE_MODE_0),
>>> +                              SSID_SIZE_MODE_AUTO),
>>>   };
>>>     static void smmuv3_instance_init(Object *obj)
>>> @@ -2162,20 +2169,20 @@ static void smmuv3_class_init(ObjectClass
>>> *klass, const void *data)
>>>           "configured in nested mode for vfio-pci dev assignment");
>>>       object_class_property_set_description(klass, "ril",
>>>           "Enable/disable range invalidation support (for accel=on). "
>>> -        "Valid values are on, off, and auto. Defaults to on. "
>>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>>           "Any attempt to turn it 'on' while the host does not
>>> support "
>>>           "it would fail.");
>>>       object_class_property_set_description(klass, "ats",
>>>           "Enable/disable ATS support (for accel=on). "
>>> -        "Valid values are on, off, and auto. Defaults to off. "
>>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>>           "Please ensure host platform supports ATS before setting it "
>>>           "to on.");
>>>       object_class_property_set_description(klass, "oas",
>>>           "Set Output Address Size in bits (for accel=on). "
>>> -        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
>>> +        "Valid values are 44, 48, and auto. Defaults to auto.");
>> not really related to this patch but I notice that we do not have any
>> "Please ensure host platform supports..." statement as opposed to
>> previous props.
>> While some host requirements are needed to be statistied too.
>>
>> smmuv3-accel.c:    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
>> smmuv3-accel.c:                FIELD_EX32(s->idr[5], IDR5, OAS)) {
>>
>>>       object_class_property_set_description(klass, "ssidsize",
>>>           "Set number of bits used to represent SubstreamIDs (SSIDs). "
>>> -        "Valid values are 0-20 and auto. Defaults to 0. "
>>> +        "Valid values are 0-20 and auto. Defaults to auto. "
>>>           "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>>>           "A value of 0 disables SubstreamID support. A value greater "
>>>           "than 0 is required to enable PASID support.");
>> same here.
>>
> Got it, I will update with host requirement guidance for OAS and
> SSIDSIZE on the next refresh.
>
>> smmuv3-accel.c:        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> smmuv3-accel.c:                               FIELD_EX32(info->idr[1],
>> IDR1, SSIDSIZE));
>>
>> Also it is not written (for accel=on)
> I can reword the accel section to something like:
> "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be
> configured in nested mode for vfio-pci dev assignment. Please ensure
> the host SMMUv3 supports hardware-accelerated VFIO-PCI device
> assignment before enabling."
>
> Should I create a new patch for this update to the accel guidance or
> consolidate into the next refresh of this current patch? 
Yes maybe add another patch that improves the existing doc

Eric
>
> Thanks,
> Nathan
>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 63baff859f..3339da99ee 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -38,9 +38,14 @@
>>>   #include "hw/virtio/virtio-iommu.h"
>>>   #include "hw/acpi/generic_event_device.h"
>>>   #include "qemu/audio.h"
>>> +#include "hw/arm/smmuv3.h"
>>>     GlobalProperty hw_compat_11_0[] = {
>>>       { "chardev-vc", "encoding", "cp437" },
>>> +    { TYPE_ARM_SMMUV3, "ats", "off" },
>>> +    { TYPE_ARM_SMMUV3, "ril", "on" },
>>> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>>> +    { TYPE_ARM_SMMUV3, "oas", "44" },
>>>   };
>>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>>   
>



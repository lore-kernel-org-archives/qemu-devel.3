Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19682112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LYX-0000hs-L6; Wed, 11 Mar 2026 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0LXa-0000RC-1V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0LXX-0005Lk-6L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773243121;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2b3GZltXFdn6xFiAR7dOt8/API6hRLtuVAP6yhW/CEo=;
 b=Euz2kbn+LfS3lwTDhdOfTvD0u0y6dlG7M/fVDMstg+KzcyfPKmqcYsPwsas3V/QqBCrcyp
 J/G9GVsyNo4Iz9b/dm8jJXfeV7ggYz8TqJy6z4aMBqTItNqfY7jnXU3Rkjs+DaHJXsGVGZ
 qmJLraRnyzR1hZgpuilAW2OOidMCTvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-a6G1zmeVPTGIMdKFHct41Q-1; Wed, 11 Mar 2026 11:32:00 -0400
X-MC-Unique: a6G1zmeVPTGIMdKFHct41Q-1
X-Mimecast-MFC-AGG-ID: a6G1zmeVPTGIMdKFHct41Q_1773243119
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so30004115e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 08:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773243119; x=1773847919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b3GZltXFdn6xFiAR7dOt8/API6hRLtuVAP6yhW/CEo=;
 b=NxU4/d9mcCH5B9iCsoqvKKbRHZWCx8TTPEqcG5jsmXVwnLgsDgPXkTEvxK6ekQN3TZ
 w0NMZelgMqHYOks2IVKpQA//wrz8d/B09lfkmc9HS+hn2A/dRXfSpsOY/u12A4d0BdRs
 Gpcjju4r9koSGEtKN6Li22s3rTcHRKWgZa8MO8JFWYzTpsWleGf2on6ncyc8XnuE9WA0
 iKL6r1/yW7Jcvy1Fbi/m7Uj9J2jnRnECDtr6uAV0LHNfcxhi9YjZZ4f+puLYVt55XE8X
 EdFHUJfPlvixn4eJJOcc1T7zddjyUxemT2SqDZrZZdbEkmgEYtDDfp8r39WrethDWv54
 1pFw==
X-Gm-Message-State: AOJu0YzMx0SWX95w4qsBXoWvmGDnnmE8L4tINw4TaOQqc/vcWoDfF++1
 SrtdWHXsWwAAmMNH6vMH7+cR/qq+bO1YcmFAuU9ESup4O9wv6shjN1W4qyO9ty4N3iTVEx2odrM
 2VzhpITCynEXcCtRX6pSnBXcMCvRLx2aUoRtBsosGBgSx/YRGg+DtxHAG
X-Gm-Gg: ATEYQzz+KvQRxaIXyPKGAm916hngB/2XF1spN4PgBL0boGkwAJhNAw5DPhhCWY1poRH
 9cPAsEw3gI5ryPIu+x0jdn+SR48A68T+AEeKnAXDzdtjJ/Vpp4dINvLlePrRcCvB8ASvXfv1PYw
 ZDVt65qdj1d+e2JcpueadcLt5OUJe+zLfJwU1zxKuEiavJl8MkRLLCZc+RVe0Fa9eIuMIS8mMbs
 QQAmsNFw91N41GxWEaujBmWDwn8B7MKo7RNrDr2txFNErHqmILrXyZLGyJLRzCJ7vVEL6dL0ips
 r1hqgM/eRCSBskYz7UlP/mtR1NAjL7dxe9bKqqPqv2XCVbYTMUqeHXwvM1qVKd4739n1ElFfVPb
 2PSd7HI7VZC5yeU3bXzP+HX4wJY/oVJOJmXinm6zQwS67ZfRsRRSnPklbtS1zZ+tLd/w7JQ==
X-Received: by 2002:a05:600c:46d2:b0:485:3a22:69b9 with SMTP id
 5b1f17b1804b1-4854b10ec44mr48679615e9.29.1773243119020; 
 Wed, 11 Mar 2026 08:31:59 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:3a22:69b9 with SMTP id
 5b1f17b1804b1-4854b10ec44mr48678765e9.29.1773243118442; 
 Wed, 11 Mar 2026 08:31:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ad1e4esm162722265e9.8.2026.03.11.08.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 08:31:57 -0700 (PDT)
Message-ID: <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
Date: Wed, 11 Mar 2026 16:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com> <87pl5cnp06.fsf@pond.sub.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87pl5cnp06.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/10/26 8:05 AM, Markus Armbruster wrote:
> Nathan Chen <nathanc@nvidia.com> writes:
>
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Set the default value of ATS to auto. The default for ATS support used
>> to be set to off, but we change it to match what the host IOMMU
>> properties report.
>>
>> Add a "ats-enabled" read-only property for smmuv3 to address an
>> expected bool for the "ats" property in iort_smmuv3_devices().
>>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>  hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>  hw/arm/smmuv3.c          | 12 ++++++++++--
>>  hw/arm/virt-acpi-build.c |  2 +-
>>  include/hw/arm/smmuv3.h  |  2 +-
>>  4 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 617629bacd..8fec335557 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>          return;
>>      }
>>  
>> +    /* Update ATS if auto from info */
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>> +    }
>> +
>>      accel->auto_finalised = true;
>>  }
>>  
>> @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                     smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>          return false;
>>      }
>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>> +                   " Services");
>> +        return false;
>> +    }
>>  
>>      /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>      if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>      /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>  
>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>> +    /* Only override ATS if user explicitly set ON or OFF */
>> +    if (s->ats == ON_OFF_AUTO_ON) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>> +    }
>>  
>>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>      if (s->oas == SMMU_OAS_48BIT) {
>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>      s->s_accel = g_new0(SMMUv3AccelState, 1);
>>      bs->iommu_ops = &smmuv3_accel_ops;
>>      smmuv3_accel_as_init(s);
>> +
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>>  }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 068108e49b..197ba7c77b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>      smmuv3_accel_idr_override(s);
>>  }
>>  
>> +static bool get_ats_enabled(Object *obj, Error **errp)
>> +{
>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>> +}
>> +
>>  static void smmuv3_reset(SMMUv3State *s)
>>  {
>>      s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>> @@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>              error_setg(errp, "ril can only be disabled if accel=on");
>>              return false;
>>          }
>> -        if (s->ats) {
>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>              error_setg(errp, "ats can only be enabled if accel=on");
>>              return false;
>>          }
>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>      /* RIL can be turned off for accel cases */
>>      DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> Is property "ats" accessible via QMP or JSON command line?  If yes, this
> is an incompatible change: JSON values false and true no longer work.
So what do you recommend to extend the property values. I guess we had
some existing scenarios happening in the past. What is the best way to
proceed?

Eric
>
>>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>>  };
>> @@ -2153,6 +2159,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>      dc->hotpluggable = false;
>>      dc->user_creatable = true;
>>  
>> +    object_class_property_add_bool(klass, "ats-enabled", get_ats_enabled, NULL);
>> +
>>      object_class_property_set_description(klass, "accel",
>>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>>          "configured in nested mode for vfio-pci dev assignment");
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 719d2f994e..6c77fc5f6a 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>>  
>>      bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>>      sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
>> -    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
>> +    sdev.ats = object_property_get_bool(obj, "ats-enabled", &error_abort);
>>      pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>>      sbdev = SYS_BUS_DEVICE(obj);
>>      sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index 26b2fc42fd..2ca49ded36 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -70,7 +70,7 @@ struct SMMUv3State {
>>      uint64_t msi_gpa;
>>      Error *migration_blocker;
>>      bool ril;
>> -    bool ats;
>> +    OnOffAuto ats;
>>      uint8_t oas;
>>      uint8_t ssidsize;
>>  };



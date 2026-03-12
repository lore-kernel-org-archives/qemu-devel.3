Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC712FED2F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cMQ-0002ci-Kk; Thu, 12 Mar 2026 05:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0cMP-0002ca-Hu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0cMN-0003qD-P7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773307778;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qpdfgt3hdiomCm9mvelVhDEkWVBXugr6tX8/EJTTHeQ=;
 b=gN2SRTOTmLYbsHXeafCOIP7AUa2Z0cWmipCn2t/AunyGWhP3mGerUnKe6GdNDMKjjB4aoa
 FGoQEfykImt/UU+VR4zX1KcUzdMZ+s4lVp4FhtJexMzW8fCW4OouXMVu2R6Xo1vn/QjKmD
 9hmyCq5ngEMGbRZXgVBjvajLsC2X2Qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-4TOg9GcMNwuyf8iDbjv6dg-1; Thu, 12 Mar 2026 05:29:37 -0400
X-MC-Unique: 4TOg9GcMNwuyf8iDbjv6dg-1
X-Mimecast-MFC-AGG-ID: 4TOg9GcMNwuyf8iDbjv6dg_1773307776
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485389bf0daso5228685e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773307775; x=1773912575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qpdfgt3hdiomCm9mvelVhDEkWVBXugr6tX8/EJTTHeQ=;
 b=lha/MY73XWl95wNp3L3O3Rd5v0SiVex/09d9ctdFXmNOTxCPH+1N25Lb5VzpZs0a7p
 IQkcn+5w4gQPkeJeizsDw6gAu5R0ojLlNqwZqe2b8jiibCBeS2BorfbSQuh0RqsjM2dr
 sk5ULcEt/DSvrV34ID3+hOq4woa7QFJJn5dhv9qN8j3kLALsbL8Zw1O6dmb6Njj8KDlD
 3yFG7z5wNxtKRXDU+qgCUw3ENJkuJI6CQ5SP/LAolHzZKzII4zceCuqCjKwfJ1nv13K9
 z/L6A0RGoQ55Hoe00FLlmhiDDmcd+nY+EfR5vkXX58h6hHyAhxxziV+aRA0zQ/pxDhIx
 9WMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDbD2oHQftuUd0oOsLjwu04OskytN/1wW4gPkCmY2jzgLxAW09uJhJsqu50Dy34Jwt1l0LSWa6xbP7@nongnu.org
X-Gm-Message-State: AOJu0YzsB5MUfTaNIYcbpfvo6/+oz2OSaD5pR+dVHWQD6VovnF6xO864
 5PDdCnq/mttXNvAAL6x6Ac1GaFXdogY/SwOXfNvYDcA6M172qJ6I0KVlQ/6lZoZ4MPZJr639mnS
 sT+xNt5Uc/JST6SQOHcE/tRvBx7WZCBKFj80/KihyR4TXOXnyndzsgNwo
X-Gm-Gg: ATEYQzz6wAEtfEG41XiE5SeUOvMDIGKI4sdvw1I08ybMJWntoq0WFXteQy05uUu7q1B
 PRMfkZ4plPjoWleh1lUF/EuLQmbiucpTrx0zLGeUnrFT0ZM78NPHgy89qxgbJLzwFxiKdGKLjIM
 5ortVZHeERt8JbF04pDXRLa4lb0pDlP7c/5O2h2jAkBti1OCXIB+jlabTKYwnNIvH9ONoNZhZRB
 w49QfIo6Onu/8OtSxIcDXdvPXVD7upfNaZZxvbZ71f4wZovJuf+kREYdeG0sSzqusFWZA/sRuBQ
 Q1OnK/M0gubFYoBE+vae2HSDe8q/svSagXc6FWEqx6i5DZv/gXtAf2BlBS62CvveA2nee02FMrL
 80YDVN4jSstFFmz40WhJftCAwKMBrwDol6MMiQQDbS1UIAss/Sv1rwuU1nuzfLmivBmqBAg==
X-Received: by 2002:a05:600c:1f0e:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-4854b12cee4mr93627505e9.21.1773307775454; 
 Thu, 12 Mar 2026 02:29:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1f0e:b0:485:35ba:1d81 with SMTP id
 5b1f17b1804b1-4854b12cee4mr93627125e9.21.1773307774954; 
 Thu, 12 Mar 2026 02:29:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0febd2sm40646665e9.32.2026.03.12.02.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 02:29:34 -0700 (PDT)
Message-ID: <96fe828c-bd2f-4f84-a9db-71dfcc5d1756@redhat.com>
Date: Thu, 12 Mar 2026 10:29:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] qdev: Add an OasMode property
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-8-nathanc@nvidia.com>
 <793c6796-177a-4e31-bda7-60bf2b9e1574@redhat.com>
 <480e5ab4-1574-4ef7-bfca-982bb0700423@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <480e5ab4-1574-4ef7-bfca-982bb0700423@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 3/11/26 7:24 PM, Nathan Chen wrote:
> Hi Eric,
>
> On 3/11/2026 11:20 AM, Eric Auger wrote:
>> Hi Nathan,
>>
>> On 3/9/26 8:21 PM, Nathan Chen wrote:
>>> From: Nathan Chen<nathanc@nvidia.com>
>>>
>>> Introduce a new enum type property allowing to set an Output Address
>>> Size. Values are auto, 44, and 48, where a value of N specifies an
>>> N-bit OAS.
>>>
>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>> ---
>>>   hw/core/qdev-properties-system.c         | 13 +++++++++++++
>>>   include/hw/core/qdev-properties-system.h |  3 +++
>>>   qapi/misc-arm.json                       | 16 ++++++++++++++++
>>>   3 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/core/qdev-properties-system.c
>>> b/hw/core/qdev-properties-system.c
>>> index 4aca1d4326..a805ee2e1f 100644
>>> --- a/hw/core/qdev-properties-system.c
>>> +++ b/hw/core/qdev-properties-system.c
>>> @@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
>>>       .set_default_value = qdev_propinfo_set_default_value_enum,
>>>   };
>>>   +/* --- OasMode --- */
>>> +
>>> +QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
>>> +
>>> +const PropertyInfo qdev_prop_oas_mode = {
>>> +    .type = "OasMode",
>>> +    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
>>> +    .enum_table = &OasMode_lookup,
>>> +    .get = qdev_propinfo_get_enum,
>>> +    .set = qdev_propinfo_set_enum,
>>> +    .set_default_value = qdev_propinfo_set_default_value_enum,
>>> +};
>>> +
>>>   /* --- Reserved Region --- */
>>>     /*
>>> diff --git a/include/hw/core/qdev-properties-system.h
>>> b/include/hw/core/qdev-properties-system.h
>>> index 4708885164..2cbea16d61 100644
>>> --- a/include/hw/core/qdev-properties-system.h
>>> +++ b/include/hw/core/qdev-properties-system.h
>>> @@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
>>>   extern const PropertyInfo qdev_prop_granule_mode;
>>>   extern const PropertyInfo qdev_prop_zero_page_detection;
>>>   extern const PropertyInfo qdev_prop_ssidsize_mode;
>>> +extern const PropertyInfo qdev_prop_oas_mode;
>>>   extern const PropertyInfo qdev_prop_losttickpolicy;
>>>   extern const PropertyInfo qdev_prop_blockdev_on_error;
>>>   extern const PropertyInfo qdev_prop_bios_chs_trans;
>>> @@ -64,6 +65,8 @@ extern const PropertyInfo
>>> qdev_prop_virtio_gpu_output_list;
>>>                          ZeroPageDetection)
>>>   #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
>>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode,
>>> SsidSizeMode)
>>> +#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
>>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
>>>   #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>>>                           LostTickPolicy)
>>> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
>>> index b372a3661b..76b6965502 100644
>>> --- a/qapi/misc-arm.json
>>> +++ b/qapi/misc-arm.json
>>> @@ -60,3 +60,19 @@
>>>   { 'enum': 'SsidSizeMode',
>>>     'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>>>               '10', '11', '12', '13', '14', '15', '16', '17', '18',
>>> '19', '20' ] }
>>> +
>>> +##
>>> +# @OasMode:
>>> +#
>>> +# SMMUv3 Output Address Size configuration mode.
>>> +#
>>> +# @auto: derive from host IOMMU capabilities
>>> +#
>>> +# @44: 44-bit output address size
>>> +#
>>> +# @48: 48-bit output address size
>>> +#
>>> +# Since: 11.0
>>> +##
>>> +{ 'enum': 'OasMode',
>>> +  'data': [ 'auto', '44', '48' ] }
>> you also miss other enum values
>
> I left out the other possible OAS values because only 44 and 48 are
> supported per the previous accel SMMUv3 series. Should we still
> include the other possible OAS values according to the SMMUv3 spec? If
> we do, we would end up hitting that check for 44 or 48 bit OAS when a
> different value is specified. 
I think we want to want to provision for all values supported by the
SMMUv3 spec

Eric
>
> Thanks,
> Nathan
>



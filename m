Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1765C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht8C-0004Qf-Cd; Tue, 11 Feb 2025 11:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tht7W-0002ln-Vr
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:28:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tht7U-0004XC-LV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739291299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HuV/HJ7wkcYMaQZpGBHWar3GOnq8n35Wn2g5vFUzl0A=;
 b=DplDRPJ4QMa/C3ar1pIytTyQll+gB/iC+hjeElKx0SN8jzoGhetoi+xtONx8GbpIZ7ilq/
 hw9wNDAogY0u5rx5rSzWbEo+ZINioz5kS6PvBnkuo2utO3BZf2kSWZSQNUDOsLvqfK6pMw
 Ct8V0DoDrsqR/JBrWD6fhu+G+YPKcrQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Bq6ZxieRN9ae27Ex1eoc5g-1; Tue, 11 Feb 2025 11:28:16 -0500
X-MC-Unique: Bq6ZxieRN9ae27Ex1eoc5g-1
X-Mimecast-MFC-AGG-ID: Bq6ZxieRN9ae27Ex1eoc5g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38dd533dad0so2029447f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291295; x=1739896095;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuV/HJ7wkcYMaQZpGBHWar3GOnq8n35Wn2g5vFUzl0A=;
 b=jy/gavwvpjOiQY2YCVdHNjKSgIiWXAxXMP7PnsPjpNSwAvO2rTjqjK+cVu8ezvIZGt
 yVLdAq2MggOCj01hB2jMV/8aY/tJoT8fLsm4YnaAALMkfYKMv6mvWaDDKffeRt0oIFAn
 cVQNyS77Yf9p/KMtlBGyog9t60HVTMGEuPM4IRsCD+x2rz8rNWlMuHgEPQvblqvmuZIC
 E8hjbesHb0KlLVrrFzQs0WHFJ8jOLLaGgjHm14PLeSVV4IuicK9FEjwpOq+XLVl0tTOR
 WIAZZKUF4td6zNImB7mg51DmO6g/xU1jGHSe+hCYd4Kf01V2UdtrXHIKrIrT7gzBon07
 youg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzQQx74Jfvg4ZVpj7CFvZr7BSQzAHN0F4DR0x3pAwUD9eBgzX4HH9lockbYrf4Z6Na+eXKzH9gPLY@nongnu.org
X-Gm-Message-State: AOJu0Yxb+OIJTdxujl2PuC4X+PlY4RjevzSSEIraSEKB4oLBzikJhLCS
 5eDTjsZ8WGcTBszcxssRMkTRJn46BpRBGttsGxwzuTUL7ZoIfmWxWxnbb/LkrWKhg7zkC4W9ahk
 UaruCZPeOyNjMBHVAKyNoZCMkQ51cM1q6QCblJnRiB2RPmMoZrHJ8
X-Gm-Gg: ASbGncvutfNfg5vqu36gAFLfUU+81+MwzqIARmZZzKj/zTAynRl0KnB8Ce+NwuaIAQG
 c56NQqomo9VNrMvINMJviRx0wkcEelqFKWLQFkTb1mhpv5+98RwybqoV/n8hefdPBmOnBmNavl7
 zHL8jIZ9g2aCgtTGW7xhjnFv4XVMJ54RLZan/Ywsb0ZRJlR/ZLBbEfRprpSIpIkkpbeaTbgxhly
 CEn3LjvBOapCkN8Uz3B4PBzJoC2Pr507Zh9GPt+kdXvjqWKHNhhm+ONoq1b9iiz0Q+qvQrkZQOa
 bApf/VYKyRx5X6DvW5jNE+jQMIVpLGUUBfo8/wUsVoM=
X-Received: by 2002:adf:e38b:0:b0:38d:e3da:8b50 with SMTP id
 ffacd0b85a97d-38de949cc74mr324395f8f.39.1739291295418; 
 Tue, 11 Feb 2025 08:28:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcps5YAXGG4vvP2lI222tfJ9UdeIVVtkV9NGPMKqm/orDfQUMX8gPZk9WvOt1bG4JzLlubjg==
X-Received: by 2002:adf:e38b:0:b0:38d:e3da:8b50 with SMTP id
 ffacd0b85a97d-38de949cc74mr324373f8f.39.1739291294964; 
 Tue, 11 Feb 2025 08:28:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1dfaesm15427403f8f.90.2025.02.11.08.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 08:28:14 -0800 (PST)
Message-ID: <c08a449c-3bfd-4656-805f-8cd83f3580f4@redhat.com>
Date: Tue, 11 Feb 2025 17:28:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/33] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
 <36beb97e-ab1e-41f4-b9d0-75238d5faaa9@redhat.com>
 <afcec18d-094f-49ea-a4f9-3b868b58e60a@maciej.szmigiero.name>
 <ab34a907-7e88-463e-9924-d8fdd771bfd8@redhat.com>
 <e7e367b0-4299-4998-b981-ca58d385db02@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e7e367b0-4299-4998-b981-ca58d385db02@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/11/25 16:57, Maciej S. Szmigiero wrote:
> On 11.02.2025 16:00, Cédric Le Goater wrote:
>> On 2/11/25 15:37, Maciej S. Szmigiero wrote:
>>> On 10.02.2025 18:24, Cédric Le Goater wrote:
>>>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> This property allows configuring whether to start the config load only
>>>>> after all iterables were loaded.
>>>>> Such interlocking is required for ARM64 due to this platform VFIO
>>>>> dependency on interrupt controller being loaded first.
>>>>>
>>>>> The property defaults to AUTO, which means ON for ARM, OFF for other
>>>>> platforms.>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>   hw/vfio/migration.c           | 25 +++++++++++++++++++++++++
>>>>>   hw/vfio/pci.c                 |  3 +++
>>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>>   3 files changed, 29 insertions(+)
>>>>>
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index adfa752db527..d801c861d202 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -254,6 +254,31 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>>>>       return ret;
>>>>>   }
>>>>> +static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>>>>> +{
>>>>> +    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
>>>>> +        return true;
>>>>> +    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
>>>>> +
>>>>> +    /*
>>>>> +     * Starting the config load only after all iterables were loaded is required
>>>>> +     * for ARM64 due to this platform VFIO dependency on interrupt controller
>>>>> +     * being loaded first.
>>>>> +     *
>>>>> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
>>>>> +     * the right place in VFIO migration").
>>>>> +     */
>>>>> +#if defined(TARGET_ARM)
>>>>> +    return true;
>>>>> +#else
>>>>> +    return false;
>>>>> +#endif
>>>>
>>>> I would rather deactivate support on ARM and avoid workarounds.
>>>>
>>>> This can be done in routine vfio_multifd_transfer_supported() I believe,
>>>> at the end of this series. A warning can be added to inform the user.
>>>
>>> The reason why this interlocking support (x-migration-load-config-after-iter)
>>> was added because you said during the review of the previous version of
>>> this patch set that "regarding ARM64, it would be unfortunate to deactivate
>>> the feature since migration works correctly today [..] and this series should
>>> improve also downtime":
>>> https://lore.kernel.org/qemu-devel/59897119-25d7-4a8b-9616-f8ab54e03f65@redhat.com/
>>
>> So much happened since ... my bad. I think this patch is not well
>> placed in the series, it should be at the end.
>>
>> The series should present first the feature in a perfect world
>> and introduce at the end the toggles to handle the corner cases.
>> It helps the reader to focus on the good side of the proposal
>> and better understand the more unpleasant/ugly part.
>>
>>> My point is that after spending time developing and testing that feature> (or "workaround") it would be a shame to throw it away (with all the benefits
>>> it brings) and completely disable multifd VFIO device state transfer on ARM.
>>
>> Well, if you take the approach described above, this patch would
>> be proposed after merge as a fix/workaround for ARM or we would
>> fix the ARM platform.
> 
> Looks like there should be no problems moving this x-migration-load-config-after-iter
> feature to a separate patch near the end of the series - I will try
> to do this.

Thanks, The patch is broken anyhow, since vfio_load_config_after_iter
is unused.
  
>>> Or am I misunderstanding you right now and you only mean here to make
>>> x-migration-load-config-after-iter forcefully enabled on ARM?
>>
>> If we only need this toggle for ARM, and this seems to be the case,
>> let's take a more direct path and avoid a property.
> 
> The reason why we likely want a some kind of switch even on
> a non-ARM platform is ability to test this functionality there.
> 
> Most VFIO setups are probably x86 so people working on this code
> will benefit from easy ability to check if they haven't accidentally
> broke this interlocking.

it's a valid request. We might want to find a better name for the
property.
  
>> I haven't read all your series and the comments yet.
> 
> I keep the series updated with received review comments and re-based
> on top of the latest Fabiano's TLS session termination patches here:
> https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio
> 
> The changes up to this point has been mostly limited to migration
> core code but it would be nice to get review comments for the VFIO
> parts soon too so I can post a complete new version.

yes. Please introduce vfio/migration-multifd.{c,h} files. I would like
the interface to be clear and avoid bits and pieces of multifd support
slipping into the VFIO migration component.

Also, please provide documentation on :

  - the design principles and its limitations (the mlx5 kernel driver
    has some outcomes)
  - a guide on how to use VFIO migration with multifd
  - how the properties (migration and VFIO) can be set to improve
    performance.

It's not trivial, we will need some guidance for the people wanting
to use it.

I have asked our QE to rerun benchmarks on RHEL. I think we could
run it on ARM too if needed.

Thanks,

C.



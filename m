Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC38EE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCya-0002GP-Gg; Thu, 19 Dec 2024 04:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCyZ-0002G3-DZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tOCyX-0002XU-RH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734601064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1LwaHJbbEEOoeZIWEa4V9Ajcpv+aRHj1LtQQhHBmHkw=;
 b=ZpDHHmFbOMB5dLKtTvEtKaiuuCdPD4wq6fY0X0WhUKBGatOOzI+gVJZJhLWGKxuvopdW1F
 fodl5xXGZttxtkL2OzmbFNdJUA6g0+9I1A72055ULpDrSsrOFFoLn8afP5Jt5s5jE0cym+
 JKj8O+K0HyGOJm3DsGEtKIE+xY+gOfs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-iK1TWz2ZMEC2M1UGQPhZRQ-1; Thu, 19 Dec 2024 04:37:40 -0500
X-MC-Unique: iK1TWz2ZMEC2M1UGQPhZRQ-1
X-Mimecast-MFC-AGG-ID: iK1TWz2ZMEC2M1UGQPhZRQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88c987fc7so12861896d6.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734601060; x=1735205860;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LwaHJbbEEOoeZIWEa4V9Ajcpv+aRHj1LtQQhHBmHkw=;
 b=Q5CDsFhhvoWLTnV5RNkVLUW2XpUU7WYpZqcuwuT4BRlGIngGarZxmqsypwHzl7L4Jr
 ccefNYMC1YeHfRyTRFdIEoW+R5KRGSH+eDEoC+EuUF58EoCMoMcTLra0ndj7gAYTriSl
 z9blMi/Jy4BDA3CNZ+9H9Xx5bh6INBaTGmpV5oFn4oyDpDoG2G9Pvsy6+Kzm8DNjziM4
 o+rHay7CaxOVVEzxbD103PYYUnf7sSq061gwMkFShP4gO+LXmGg3D7d8jNumvb94sUoa
 O0siPDE/cstQLLVuym20kn3VnveCJlZPLoZDhJSzMum5e47gZJFj2KMpKOElKwjxwaHW
 YE8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF3VsL7IERD+U2+MT8w1p1/DAFYFTQ+Exbhkg3E7l+njaGt0XV7hiKOjdtmLnNV9dGSj79rDoVS25a@nongnu.org
X-Gm-Message-State: AOJu0YzCtyCotw4d09EQT/MLYRgw3g3czethfCn74TBcY+C3nPN3+g+L
 9l62Ojl6SqSi5BF0nF4gPL4Njs5g7TKryXYEgo3/UAv5gaa7+v+BV2/KY7L9pC2aX1nlfmM7mqm
 93Wr9jrYOx9EvIaZWViutklr3vOrAP6Uc/yE8v2wg6XJAUA1FQJJX
X-Gm-Gg: ASbGncslEcAObOBR7NWzBxzJn0gWDmsx5IpsjvB6OhHJXkan09aQgMUK74ab8X2/dV1
 q0UpMu3uXEkLlhYDnoozrOUfbBhvqSz4Xa0DvKp4JWc200u9rm5Qz+ro7nxS82l+z3mD5kA5boS
 ShVssOOpZyg600HJ7rGlDfZQJ8fYSrreAN3TEvu05OAjMWuFsuOnBTMXkMf9PosCAZaNV3SJAgT
 oJs/RYtNA3cFyEijVRU4w2LibbBTh/UhtaAYLX6ENlTTYWMOmb06KQmCbyQtj1UjzmmWke4jb2N
 B09oWJ4LwdB6qwWOQq4=
X-Received: by 2002:a05:6214:242f:b0:6d8:8cb0:b40d with SMTP id
 6a1803df08f44-6dd0923c98amr117416616d6.39.1734601060215; 
 Thu, 19 Dec 2024 01:37:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+bOZ3Aff3U8/RJgWLpPqf7h5+TmWKfElPKLp/V1Zfc4BPuZ+5abmqiJGT93Qasbvfrqkvaw==
X-Received: by 2002:a05:6214:242f:b0:6d8:8cb0:b40d with SMTP id
 6a1803df08f44-6dd0923c98amr117416356d6.39.1734601059883; 
 Thu, 19 Dec 2024 01:37:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810d4e1sm4715726d6.42.2024.12.19.01.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:37:39 -0800 (PST)
Message-ID: <7660d665-96aa-44be-980f-c89dce3645fa@redhat.com>
Date: Thu, 19 Dec 2024 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/24] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <b34680f99e294532a5d095b34b5ef0e4f778b1f2.1731773021.git.maciej.szmigiero@oracle.com>
 <f0e0dd0d-17be-477d-9243-be1b068cb81f@redhat.com>
 <3ba62755-6f36-4707-8c18-8803dbd4f55b@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3ba62755-6f36-4707-8c18-8803dbd4f55b@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/29/24 18:15, Maciej S. Szmigiero wrote:
> On 29.11.2024 15:11, Cédric Le Goater wrote:
>> On 11/17/24 20:20, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This property allows configuring at runtime whether to transfer the
>>> particular device state via multifd channels when live migrating that
>>> device.
>>>
>>> It defaults to AUTO, which means that VFIO device state transfer via
>>> multifd channels is attempted in configurations that otherwise support it.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/core/machine.c             | 1 +
>>>   hw/vfio/pci.c                 | 9 +++++++++
>>>   include/hw/vfio/vfio-common.h | 1 +
>>>   3 files changed, 11 insertions(+)
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index ed8d39fd769f..fda0f8280edd 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -39,6 +39,7 @@
>>>   GlobalProperty hw_compat_9_1[] = {
>>>       { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
>>>       { "migration", "send-switchover-start", "off"},
>>> +    { "vfio-pci", "x-migration-multifd-transfer", "off" },
>>
>> Could you please move the compat changes into their own patch ?
>> It's easier for backports
>>
>>>   };
>>>   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 14bcc725c301..9d547cb5cdff 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3354,6 +3354,8 @@ static void vfio_instance_init(Object *obj)
>>>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>>>   }
>>> +static PropertyInfo qdev_prop_on_off_auto_mutable;
>>> +
>>>   static Property vfio_pci_dev_properties[] = {
>>>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>>>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
>>> @@ -3378,6 +3380,10 @@ static Property vfio_pci_dev_properties[] = {
>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>> +    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
>>> +                vbasedev.migration_multifd_transfer,
>>> +                qdev_prop_on_off_auto_mutable, OnOffAuto,
>>> +                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
>>
>> What are you trying to do that DEFINE_PROP_ON_OFF_AUTO() can not satisfy ?
>>
> 
> DEFINE_PROP_ON_OFF_AUTO() property isn't runtime-mutable so using it
> would mean that the source VM would need to already decide at startup
> time whether it wants to do a multifd device state transfer.
>
> Source VM can run for a long time before being migrated so it is
> desirable to have a fallback mechanism to the old way of transferring
> VFIO device state if it turns to be necessary for some reason.
>
> After all, ordinary migration parameters can be adjusted at the run time
> too.

I see. I don't think it works this way. Anyhow, it won't compile anymore
with upstream so this part needs to be reworked. Let's keep it in mind
and make it simpler first. That is to rely on values of
vfio_multifd_transfer_supported() and "x-migration-multifd-transfer"

Thanks,

C.




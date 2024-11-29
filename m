Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562A4D6EC0E
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1iN-0006ck-KV; Fri, 29 Nov 2024 09:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1iL-0006cO-CP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1iJ-0003MD-JB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732889478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nNT9Ub3zeAtXiKDmqBEeaIqbadfHLNHqU4RgC0TJbN4=;
 b=e4sLsuy4b9uZhF8dwjTkVRbvJ7NPUAV1yCCnHwYZw79J4NJD5pBOX/90tSZtRvEf6SCUnn
 79fp6v7XIElvrkP8vALVetCELCd6WiqeBsYRDgNvojnhdNbI4zsvAyBJdyaBH3Etsug3Y3
 RcA/3ZzBWR9N66YKnpMZidrsLvKJaTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-7gw8NXmZPgi-LXOOKfbhTQ-1; Fri, 29 Nov 2024 09:11:15 -0500
X-MC-Unique: 7gw8NXmZPgi-LXOOKfbhTQ-1
X-Mimecast-MFC-AGG-ID: 7gw8NXmZPgi-LXOOKfbhTQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349d895ef8so17470865e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732889475; x=1733494275;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNT9Ub3zeAtXiKDmqBEeaIqbadfHLNHqU4RgC0TJbN4=;
 b=MxLaTxJzyOHf7Iw3YGDB0Kgqj+fF6t5CL81EATGJ+Gn6B1suCgS4PmteIoqTwSWNWa
 CTBu5WW8+24UOFAY2Jm8t7w6I/SzHIAne+L9YIxC0z0WUT7tDryHcJULMzeSlJFvxHku
 a5dGg+qY8vRw59abUYn1PiI1CDzrhjnkx7ravkhspjzcUBN6vcHx4rRFMTscYq2r/Stc
 8jTRa4Hm5n4FdWqLT2wiDVAZxuBg3llFx+3kWjdwbMlfT0HV1RI5fTcQ2af1UWpck92O
 K2WMQ7fDw98Erv/ePFmluUeSK2/G/uIO0iEKh92y/F3b9EM22X1O5vfzlwBMNFCTjMVD
 kxKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlWeJwjnfyhjHqhWljATyOGoVsaaTLdU66xnCgLadtEvzHrBzUTLCVrRurP8rZxWS7KBC+qOkfk0Yg@nongnu.org
X-Gm-Message-State: AOJu0Yze1uTegwDulxbNrb/ec4wVPh1MhvLMTZMVDwME2K/oquEaeBZO
 2AjRJWpjPMvKtghAMtZw5y+gk2bMJwUmPjyChHpQ/4Zm1517a2UKZ9Qkph8bJwArikH8/U8OV1W
 anw6jPEeQKd6VYcSSWkukikBP43jUwx4RAarf0lMnE373NVytUjPf
X-Gm-Gg: ASbGncu8EtD5eWuF2xjeZ/T7Dfm8yEnISSBkFaVx1++ZIBztGM0/E6H0Reprve8jHRu
 ts6liwIlnzOL4r2Zs9I+7p0VfVaJ7mP9YIVirn5e2RbgrECDwXRs7mbWRc3c6TNHSR+3EJYWXWP
 AyHuYNTiI6zrZvof790BmbvF8ug/b2soWbJUu4EwR99YQDL5ucqkfdplgOqggVAN3cd2BddMmEC
 qn697L9l5q+H0W+nd6GlX343Gaxo1SLfm8kslYYKz53Go0Davec8cy1e00emuiCTY8stDnv6Vt1
 U3CILuWlAFdB
X-Received: by 2002:a05:600c:5021:b0:434:9fac:b157 with SMTP id
 5b1f17b1804b1-434a9dc37aamr123257485e9.13.1732889474603; 
 Fri, 29 Nov 2024 06:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNgTaU5+6AzFhbgLzSYH+ek8J2jaNjUuNgQjCGHlKkUSiXRjtx+oF8uTcqM9dSIeqq+s/FZQ==
X-Received: by 2002:a05:600c:5021:b0:434:9fac:b157 with SMTP id
 5b1f17b1804b1-434a9dc37aamr123249555e9.13.1732889466761; 
 Fri, 29 Nov 2024 06:11:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc9707sm54638285e9.25.2024.11.29.06.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 06:11:04 -0800 (PST)
Message-ID: <f0e0dd0d-17be-477d-9243-be1b068cb81f@redhat.com>
Date: Fri, 29 Nov 2024 15:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/24] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <b34680f99e294532a5d095b34b5ef0e4f778b1f2.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b34680f99e294532a5d095b34b5ef0e4f778b1f2.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring at runtime whether to transfer the
> particular device state via multifd channels when live migrating that
> device.
> 
> It defaults to AUTO, which means that VFIO device state transfer via
> multifd channels is attempted in configurations that otherwise support it.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/core/machine.c             | 1 +
>   hw/vfio/pci.c                 | 9 +++++++++
>   include/hw/vfio/vfio-common.h | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed8d39fd769f..fda0f8280edd 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@
>   GlobalProperty hw_compat_9_1[] = {
>       { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
>       { "migration", "send-switchover-start", "off"},
> +    { "vfio-pci", "x-migration-multifd-transfer", "off" },

Could you please move the compat changes into their own patch ?
It's easier for backports

>   };
>   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 14bcc725c301..9d547cb5cdff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3354,6 +3354,8 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> +static PropertyInfo qdev_prop_on_off_auto_mutable;
> +
>   static Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> @@ -3378,6 +3380,10 @@ static Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
> +                vbasedev.migration_multifd_transfer,
> +                qdev_prop_on_off_auto_mutable, OnOffAuto,
> +                .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),

What are you trying to do that DEFINE_PROP_ON_OFF_AUTO() can not satisfy ?


Thanks,

C.



>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3475,6 +3481,9 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
>   
>   static void register_vfio_pci_dev_type(void)
>   {
> +    qdev_prop_on_off_auto_mutable = qdev_prop_on_off_auto;
> +    qdev_prop_on_off_auto_mutable.realized_set_allowed = true;
> +
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 246250ed8b75..b1c03a82eec8 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -134,6 +134,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 



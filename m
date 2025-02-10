Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C8C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXWh-0007cv-Ir; Mon, 10 Feb 2025 12:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thXWe-0007ZG-NB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thXWc-0007v3-Fg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739208288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUI5zq619vWRI2CRs8FEGxGPSIMHfbnM9XVHX/eUdUU=;
 b=D9g20GEvXLNLSfIUgkMpLJNW//7PdyL5M6iKX1VDgLGkPawj6KSYSUMXKCKdN051pUS/td
 9b5FTtGxn5HXq9Wih8K8zGn/XXwwVmy2OcMauuRVAVaN3b/+MFPOTsXi5tufdo4xOTP4DU
 AEUf6APfTBt84IDrW+DjNGmYGu27UME=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-CruiPQqlOGi3_xerl44X6Q-1; Mon, 10 Feb 2025 12:24:46 -0500
X-MC-Unique: CruiPQqlOGi3_xerl44X6Q-1
X-Mimecast-MFC-AGG-ID: CruiPQqlOGi3_xerl44X6Q
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso34694175e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739208285; x=1739813085;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUI5zq619vWRI2CRs8FEGxGPSIMHfbnM9XVHX/eUdUU=;
 b=XC8EzbEPy9PLZsaT95jetd86+NVcDhTxLW4v2/oRuqWAVoJ8Oo7QBOGZp5BtiTjmPd
 PCU7V6/KpcJZYeemIyPaeUoRo/kmueitE9hMKI1aSZZYhAH3s/T7ky0g8xcuWD2FmkRd
 g1uX+mLxszoeOlZgX2RglBn9bGp/UtnW4YKG5PFhbB0RtNcYY74k/AFXzt7neuPBswtV
 pC9GZ7AtXzGveOlSu4AbH57eBZ2E2AhzDIu+bR4AojYvX2qmu0j5ke917rUr3NXP7dLv
 fBw+kiV9OZ2OXwl3F4pYNMrQ28Yr+/DhWQmI2FKeohz1CwYQxHh4Pd83zLpPJZ5J6uBk
 ODYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbm5WZZmA5KrRwwO5aNrOohfjzuoF09JegQ7EhtupiH4KeSL9DlF5JcKl3JyVx7drRCRgbBxqO2ev@nongnu.org
X-Gm-Message-State: AOJu0YxP8WwqVuUpp4uVh0bOPqVQ+jDJwSLmSJI4oaDtejLxZxERG70Y
 TYwz9bO72iV0AJXTFpS9xwH1eYccOSQbQz61q+1meBCM0GbIbuIv+VKUugqrQr2XlFNK/TtDr0N
 hBTjk0EIeJFTwrZFfmLkLuGlR+15b74aTPYT7WNIWDtROjGPV7dXP
X-Gm-Gg: ASbGncubP7BHYtCwZbl81zCXHjwlPsPttOtgONtxUgdbgMCh5kzS6fH5gW1C9GDYl5O
 aJpWW7QpD2r1fzoqqmDaoX91MCS/UFEQ4Q41XBEbGHDiU7GrJTTgYq76ZBeIGvigb7U3BNYwRwK
 k/TSiB0OprrchjpQYSxpsoSw7Ka6p+Q7LdOONcrl1gBWwd9CQV13KZprsIc/4/vUc0f0ztrkPBr
 SJGVThmJpdmFKQdre8ipyqm0gTs+5Oj4J8QUSW4i/A2Ys5hIleC53tlwvVx/tnltK1d1zXsqkjU
 JwzkDSnRIQkTJR1TShUzxwoa1TkIEKnpJwe7+wv8mVQ=
X-Received: by 2002:a05:600c:3c9b:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-439249c6e17mr132511945e9.29.1739208285290; 
 Mon, 10 Feb 2025 09:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYPqTm8YPRt5t5/GLix3H6SZHmbn6t6fiaAZlkr1eKC+W0HrfcvM1fXhA4DKz4NrXQ7atXDQ==
X-Received: by 2002:a05:600c:3c9b:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-439249c6e17mr132511715e9.29.1739208284885; 
 Mon, 10 Feb 2025 09:24:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43946bff4d4sm28156075e9.3.2025.02.10.09.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 09:24:44 -0800 (PST)
Message-ID: <36beb97e-ab1e-41f4-b9d0-75238d5faaa9@redhat.com>
Date: Mon, 10 Feb 2025 18:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/33] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/30/25 11:08, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring whether to start the config load only
> after all iterables were loaded.
> Such interlocking is required for ARM64 due to this platform VFIO
> dependency on interrupt controller being loaded first.
> 
> The property defaults to AUTO, which means ON for ARM, OFF for other
> platforms.>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 25 +++++++++++++++++++++++++
>   hw/vfio/pci.c                 |  3 +++
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 29 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index adfa752db527..d801c861d202 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -254,6 +254,31 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>   
> +static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
> +{
> +    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
> +        return true;
> +    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
> +        return false;
> +    }
> +
> +    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
> +
> +    /*
> +     * Starting the config load only after all iterables were loaded is required
> +     * for ARM64 due to this platform VFIO dependency on interrupt controller
> +     * being loaded first.
> +     *
> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> +     * the right place in VFIO migration").
> +     */
> +#if defined(TARGET_ARM)
> +    return true;
> +#else
> +    return false;
> +#endif

I would rather deactivate support on ARM and avoid workarounds.

This can be done in routine vfio_multifd_transfer_supported() I believe,
at the end of this series. A warning can be added to inform the user.

Thanks,

C.



> +}
> +
>   static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>                                            Error **errp)
>   {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab17a98ee5b6..83090c544d95 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
> +                            vbasedev.migration_load_config_after_iter,
> +                            ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 0c60be5b15c7..153d03745dc7 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,6 +133,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_load_config_after_iter;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 



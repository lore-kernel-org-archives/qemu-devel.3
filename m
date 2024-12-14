Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7816E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 11:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMQnT-0005YV-Gy; Sat, 14 Dec 2024 06:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tMQnR-0005Xb-9s
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 06:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tMQnP-000410-7h
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 06:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734177532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pcHRXahOde/jATq9WR7Jk6nEpCCp4AAVVueKATLWIbY=;
 b=TRd+i0/zO4k9petV5yxMsYmsDtNFhcN6cdiEroKJ7coWW4Bn/SSqc69LFlW+Oj1EZbQwL+
 9YIBM1D38+aHQ4qV2hJEjAMVIUDKOivmFUBI7R7JH/CJPRMQnp27tR1x8qE46TOvtnPW7f
 sjhk1+q6tAFCm9NhyGxJGtllfXdbzcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-3Oo0fYXsOkm4FD_4tjABUw-1; Sat, 14 Dec 2024 06:58:48 -0500
X-MC-Unique: 3Oo0fYXsOkm4FD_4tjABUw-1
X-Mimecast-MFC-AGG-ID: 3Oo0fYXsOkm4FD_4tjABUw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so7145165e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 03:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734177527; x=1734782327;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcHRXahOde/jATq9WR7Jk6nEpCCp4AAVVueKATLWIbY=;
 b=cTRMVb2eJ1gNF14V8mGEyV4z1oTUUa0dqSnsaw7COAlhgZw3UkQZiIYGuL51UzjVq8
 a+fIMpxDkOHbhj3/b2fTChzpJJNLUXb8wL53d/kLuKsudFX5A35lWLTwB/lIciU9xSAb
 RgfmnqAic3Ktanp28cQDO27KvjHUWeBTa3Is9GwThR2f45N0WYZYGbMoLYUV+KLfeNab
 1mynJPNOKAGkYEeOpi9hCxlVV5dL6Rh2mfp+6SxEWqsI+tB2wx2tFG9NRxpmKHQGw1+o
 32L9UCqVMnr0+IR6+aYjJmyjpDdEhcujeuj89G0wvpnmlBCczvdA8qojhcFkA1OL13BK
 LX8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkQDPPxMsR4z1Dh+oImtTX6A0ys59aTCPvZFFnuVhappl3/++rRvVqbEJEO3bWBmDm4RKlNjYs1Mtm@nongnu.org
X-Gm-Message-State: AOJu0YzkrIdVRKba1o7TEqIiOkppcovWmBx0LT2xBb5m8AXBn8Kgh5qI
 HUie+IBOO2JpgEqVuyRaEE/bnp5G2ZLKJXIZo9P5jSxI+5UMZn6JBAhOxXOJyuu6VC0U0HnzwMr
 JfzFj7wpU+MNMNaV4PqhJAB9DrCQ6huXXkF7+QMAd/zvvTQnTUSW+
X-Gm-Gg: ASbGnctGVMm20BTzJ9yT+GWhSxMRy6dLxJltZBI4apEA1e6WlCCwGAwrioWh/PpPbsj
 Df08DrfhKIC7fg4IuKaBNvA1jdG2LfV5+CL+2vRkaWbJ+KMSEgQ90GCxKGMifQZENZGKMQ0pGAp
 Cq+63xRqOjSQIT9+9e2NSwTav1b8p8tmYuXYlasMwdgty8XtFnmx8WZHXlwttwRurr6BUOz/Z8D
 2OU+xmS+tdRBgMTL5q6lgMH+2kdgIM3fCa+b2E3aybgygO1JLX3K0kzauVY3ukS/vCJLx8TUxBE
 JwBwLQd8yu4XkJnsGUllkUugFqde/i0HoX0Ga61KEGjrW4bXUYJau6HPV4fww9J4DnG2KuvWPmn
 actOmNWQ=
X-Received: by 2002:a05:600c:26cc:b0:434:e963:6ad9 with SMTP id
 5b1f17b1804b1-436230ac4ebmr81041895e9.5.1734177527559; 
 Sat, 14 Dec 2024 03:58:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9UeOh9CO+1enbU3sOaFlgdC9TAyYNOoohYXn1NEP9rNMc3fd2vc8o3X+GKSYxLHHkqGFAGQ==
X-Received: by 2002:a05:600c:26cc:b0:434:e963:6ad9 with SMTP id
 5b1f17b1804b1-436230ac4ebmr81041715e9.5.1734177527211; 
 Sat, 14 Dec 2024 03:58:47 -0800 (PST)
Received: from ?IPV6:2a01:cb01:3041:bf20:c6cb:b70:e05a:edd3?
 (2a01cb013041bf20c6cb0b70e05aedd3.ipv6.abo.wanadoo.fr.
 [2a01:cb01:3041:bf20:c6cb:b70:e05a:edd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625716d4dsm77434595e9.37.2024.12.14.03.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 03:58:46 -0800 (PST)
Message-ID: <c8bade56-2fd3-4069-b2a3-f1ef53b327ce@redhat.com>
Date: Sat, 14 Dec 2024 12:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/71] hw/vfio: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
 <20241213193004.2515684-3-richard.henderson@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241213193004.2515684-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/13/24 20:29, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/ap.c       | 2 +-
>   hw/vfio/ccw.c      | 2 +-
>   hw/vfio/pci.c      | 4 ++--
>   hw/vfio/platform.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 4013e7b436..2e6ea2dd93 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -191,7 +191,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
>       g_free(vapdev->vdev.name);
>   }
>   
> -static Property vfio_ap_properties[] = {
> +static const Property vfio_ap_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>   #ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index c1cd7736cd..b96ab27e12 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -655,7 +655,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>       }
>   }
>   
> -static Property vfio_ccw_properties[] = {
> +static const Property vfio_ccw_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>       DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
>   #ifdef CONFIG_IOMMUFD
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 14bcc725c3..93aca850e3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3354,7 +3354,7 @@ static void vfio_instance_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> -static Property vfio_pci_dev_properties[] = {
> +static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>       DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
>       DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> @@ -3451,7 +3451,7 @@ static const TypeInfo vfio_pci_dev_info = {
>       },
>   };
>   
> -static Property vfio_pci_dev_nohotplug_properties[] = {
> +static const Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                               ON_OFF_AUTO_AUTO),
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index a85c199c76..766e8a86ef 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -629,7 +629,7 @@ static const VMStateDescription vfio_platform_vmstate = {
>       .unmigratable = 1,
>   };
>   
> -static Property vfio_platform_dev_properties[] = {
> +static const Property vfio_platform_dev_properties[] = {
>       DEFINE_PROP_STRING("host", VFIOPlatformDevice, vbasedev.name),
>       DEFINE_PROP_STRING("sysfsdev", VFIOPlatformDevice, vbasedev.sysfsdev),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPlatformDevice, vbasedev.no_mmap, false),



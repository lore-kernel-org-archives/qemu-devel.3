Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A761C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 19:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJzxU-0008PU-C1; Tue, 27 May 2025 15:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uJzxO-0008Ow-WA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uJzxJ-0000Gc-Ot
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748374040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXx3v+DXIAcyYjVSFCYdDn1uiGz1UHLHgy10KqHuS28=;
 b=KVg9EhLuo83UBmrJDe9TXhl4ItbscFw+XZEc/hBTNrbE3mU0LA737B0tiAa3j+qhbu3d/b
 pTICokP1KEIN8l4v6sTWnB+LIUG3JUBgbUhuLKT0vKeoN3cmTWNzfoaFqestsXFnK3w6L9
 j6HsalvCT6vXHIZkZizxqPL194rXvUg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-nc-qqhxtPRyHu5ytQ5k75Q-1; Tue, 27 May 2025 15:27:18 -0400
X-MC-Unique: nc-qqhxtPRyHu5ytQ5k75Q-1
X-Mimecast-MFC-AGG-ID: nc-qqhxtPRyHu5ytQ5k75Q_1748374038
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3da7648c031so4382935ab.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 12:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748374038; x=1748978838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXx3v+DXIAcyYjVSFCYdDn1uiGz1UHLHgy10KqHuS28=;
 b=n6D10dQvHO8n3J1F/LNzG4YM/OBTSETdzud+5qQYT55+dpaRNZRRePY3+W/UKfqTBo
 DTl7obz8rpXzMEwyOOOUG4wT/zoJ68kJh+zlcu6TDREZCWOmw19xZXmRbPl8b+fSBYLm
 rx1AXg4xW+uP3K7+L8lQXgWLj/Vu6QBlhBGPiAQ7eQm8IuOw3oMXVaKuZoqGt+QoasCh
 okWdHZN/0RuxxmCx+UXHZA5P1AFnLBARQjpbKvCxtV0bI4KoW76OWp/le2wNZbGX+a+B
 AfyTcl29qPuKIhmhomz7Qoum6uxUnqPh6OjfhIZxRW2KLPFHynkllp7vOCAQXX7Nykfw
 VKfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrP1CWx+LPjPanPNgRtHrCRWC9QJDI7z5A+8QpU6GNldUJeAmsubcrukOWb3aqw2MOoWYLvdeXHZOv@nongnu.org
X-Gm-Message-State: AOJu0Yxgumj5Ss79oXx8Xk+QuaNpbNsz26rbK/P8yqCjHdaAGKqJsUJw
 OdPOmj9R3DHc92foYfA7Nb9mOiaDDDjLzLx0O+allUnXl1SRpzZtApb/t1kz3TOVjyotTLRMN1O
 8aXUbgGz2x916TBFb3eAvftmZ96mjP0JTO/Zvhr2Bcy3c/OrHP0umA9/f
X-Gm-Gg: ASbGncv1rc7dd1VmmomfjJbtTJKr8NXmi/111RXg5mlZ6MHrhGXT7P9BacbptgG7lJA
 FngO03oe5dPEAEQ+EPCK5OCp4H8tJAiaf1Sm85oueLJwHcVfP4daGZUk7uwr6IbXlFGKuGLldWl
 W7ksXTZT/sftNQUgWseyBokpC1cn2dyT3SQgqcFTHE9JjXtjaPtKZLLoMYaQo4jM6H59a9l6i7R
 npV3vWB6T014ja4DshVQPeu4WISJjw18wAX0aUdEREUcMyB4GN9TMCb9D/vDz0zdTYnYQWwt7n4
 ME3CoFSD+qSRKN4=
X-Received: by 2002:a05:6e02:160b:b0:3dc:7fa4:81f with SMTP id
 e9e14a558f8ab-3dc9b6db3ffmr35262945ab.4.1748374037837; 
 Tue, 27 May 2025 12:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzKn/KPNZy5ECQyv9yRwqSX9hkGnn2GHFVu/31GniN0rx9/HmcJu/J2ehDmsdvbeGV9VZIxg==
X-Received: by 2002:a05:6e02:160b:b0:3dc:7fa4:81f with SMTP id
 e9e14a558f8ab-3dc9b6db3ffmr35262855ab.4.1748374037357; 
 Tue, 27 May 2025 12:27:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc83f3d0f3sm38016475ab.22.2025.05.27.12.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 12:27:16 -0700 (PDT)
Date: Tue, 27 May 2025 13:27:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>,
 edmund.raile@proton.me, Edmund Raile <edmund.raile@protonmail.com>
Subject: Re: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Message-ID: <20250527132714.45a9d6b4.alex.williamson@redhat.com>
In-Reply-To: <20250522151636.20001-1-tomitamoeko@gmail.com>
References: <20250522151636.20001-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 22 May 2025 23:16:36 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> In vfio_pci_igd_opregion_detect(), errp will be set when the device does
> not have OpRegion or is hotplugged. This errp will be propagated to
> pci_qdev_realize(), which interprets it as failure, causing unexpected
> termination on devices without OpRegion like SR-IOV VFs or discrete
> GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().
> 
> This patch also checks if the device has OpRegion before hotplug status
> to prevent unwanted warning messages on non-IGD devices.
> 
> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Reported-by: Edmund Raile <edmund.raile@protonmail.com>
> Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
> Tested-by: Edmund Raile <edmund.raile@protonmail.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v2:
> * Add Tested-by from Edmund Raile. Thanks for the contribution.
> * Rebased on vfio-next
> * Fix typos.
> 
>  hw/vfio/igd.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 5b6341c5bf..e7a9d1ffc1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>  }
>  
>  static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
> -                                         struct vfio_region_info **opregion,
> -                                         Error **errp)
> +                                         struct vfio_region_info **opregion)
>  {
>      int ret;
>  
> -    /* Hotplugging is not supported for opregion access */
> -    if (vdev->pdev.qdev.hotplugged) {
> -        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
> -        return false;
> -    }
> -
>      ret = vfio_device_get_region_info_type(&vdev->vbasedev,
>                      VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>                      VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>      if (ret) {
> -        error_setg_errno(errp, -ret,
> -                         "Device does not support IGD OpRegion feature");
> +        return false;
> +    }
> +
> +    /* Hotplugging is not supported for opregion access */
> +    if (vdev->pdev.qdev.hotplugged) {
> +        warn_report("IGD device detected, but OpRegion is not supported "
> +                    "on hotplugged device.");
>          return false;
>      }
>  
> @@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      }
>  
>      /* IGD device always comes with OpRegion */
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          return true;
>      }
>      info_report("OpRegion detected on Intel display %x.", vdev->device_id);
> @@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> -    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
> +    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
>          /* Should never reach here, KVMGT always emulates OpRegion */
>          return false;
>      }

LGTM

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>



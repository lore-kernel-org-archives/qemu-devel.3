Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E01C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dys-0004Op-1W; Thu, 16 May 2024 12:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dyp-0004NI-TB
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dyo-0004SW-85
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715876957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vhi2RJebXZNQWiSz2qczyw3x7Kdto7QGyk0fWFzRDpI=;
 b=cUX7VbGARcXOJRM1QRjp/9pmLhKwve0yV8EXvQuSS4HpyeFH1fx3VMawyPt9L0k9RZI1cJ
 YOTlOMx2nqJBmOGc3fZNzU7QLiryk3fzbFNQ2DECgPME1OWfissolcUpvBDeCJVC/yTA5S
 O6RSI37LsTDGUxMcd2yVM5KZG/jlkVw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-tgFsmM7LMceSi1aqo9w-yA-1; Thu, 16 May 2024 12:29:15 -0400
X-MC-Unique: tgFsmM7LMceSi1aqo9w-yA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792c707ca4aso617852685a.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 09:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715876955; x=1716481755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vhi2RJebXZNQWiSz2qczyw3x7Kdto7QGyk0fWFzRDpI=;
 b=tIhBLBeJumvboUnYxB53685nruS/OwcAAxKU2ELyv/Fjel11pKCC5c9thRYh9sNgTG
 p0OZCtlNjTIQEsrmcC+D/C4ykSWSdnWvo2TXYx71HRUmjbrVWoYx26UaMnyE3q9u6uY+
 AP5EFIpKLhlC9Z9JMIr1YsC29fqsC+dbxHDc/WfHo1KNM92yM+ih0pu0kPHEX9JKeGvI
 BlERuE5MNKOi/RT7K7mvaH3bvF1q3woIK+4GvdFcPMOQZx766ea34bkA5wSzK3JecHBu
 Zh72OraZhBgjG8++5YYGM1uxszBNg984mjrzWqAEDugh8o5In3JOIz7GpyQDLhfUcTLs
 RZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNnURjGeJRrqlLINsb7nF8/7gTm97SUGJ6PZomghe5WbgqnwS8jVyJ/Mt0EURlH5g+vSHersFRfKp+MLM0ig5f1BhOO+4=
X-Gm-Message-State: AOJu0Yy50FsExw4Yis/geBhA3bVCrRPjq8d+amPCQv316p02AgEtH6pn
 pQnPEKeZ0X/hQDgL+qjqGu6ntwLYAGTvcPu0UU+J8U7OWeT/7x+sE2xJI7R2M8WTYe2C4q4t5WB
 5kMhNtga6PtjIdsITwv1iUuBbP110blpY4ulH/X0TaZ/m+8IBMWsD
X-Received: by 2002:a05:620a:4494:b0:790:a8ca:c69d with SMTP id
 af79cd13be357-792c75ab7fcmr2526635885a.33.1715876954873; 
 Thu, 16 May 2024 09:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxxbFo30AOLf/XW3onhYPuk8WsaWNhKlGTyPoHxcar8qPt81UX8pYbNbNzK//5+vE1eH0aEA==
X-Received: by 2002:a05:620a:4494:b0:790:a8ca:c69d with SMTP id
 af79cd13be357-792c75ab7fcmr2526633285a.33.1715876954547; 
 Thu, 16 May 2024 09:29:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792e564e4dbsm407930385a.82.2024.05.16.09.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 09:29:14 -0700 (PDT)
Message-ID: <97c8641e-8839-4711-947c-692a62af93f3@redhat.com>
Date: Thu, 16 May 2024 18:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
To: Vinayak Kale <vkale@nvidia.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 avihaih@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, zhiw@nvidia.com,
 targupta@nvidia.com, kvm@vger.kernel.org
References: <20240503145142.2806030-1-vkale@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240503145142.2806030-1-vkale@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/3/24 16:51, Vinayak Kale wrote:
> In case of migration, during restore operation, qemu checks config space of the
> pci device with the config space in the migration stream captured during save
> operation. In case of config space data mismatch, restore operation is failed.
> 
> config space check is done in function get_pci_config_device(). By default VSC
> (vendor-specific-capability) in config space is checked.
> 
> Due to qemu's config space check for VSC, live migration is broken across NVIDIA
> vGPU devices in situation where source and destination host driver is different.
> In this situation, Vendor Specific Information in VSC varies on the destination
> to ensure vGPU feature capabilities exposed to the guest driver are compatible
> with destination host.
> 
> If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
> volatile Vendor Specific Info in VSC then qemu should exempt config space check
> for Vendor Specific Info. It is vendor driver's responsibility to ensure that
> VSC is consistent across migration. Here consistency could mean that VSC format
> should be same on source and destination, however actual Vendor Specific Info
> may not be byte-to-byte identical.
> 
> This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
> device by clearing pdev->cmask[] offsets. Config space check is still enforced
> for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
> config space check for that offset.
> 
> VSC check is skipped for machine types >= 9.1. The check would be enforced on
> older machine types (<= 9.0).
> 
> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>



Applied to vfio-next.

Thanks,

C.


> ---
> Version History
> v3->v4:
>      - VSC check is skipped for machine types >= 9.1. The check would be enforced
>        on older machine types (<= 9.0).
> v2->v3:
>      - Config space check skipped only for Vendor Specific Info in VSC, check is
>        still enforced for 3 byte VSC header.
>      - Updated commit description with live migration failure scenario.
> v1->v2:
>      - Limited scope of change to vfio-pci devices instead of all pci devices.
> 
>   hw/core/machine.c |  1 +
>   hw/vfio/pci.c     | 26 ++++++++++++++++++++++++++
>   hw/vfio/pci.h     |  1 +
>   3 files changed, 28 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4ff60911e7..fc3eb5115f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -35,6 +35,7 @@
>   
>   GlobalProperty hw_compat_9_0[] = {
>       {"arm-cpu", "backcompat-cntfrq", "true" },
> +    {"vfio-pci", "skip-vsc-check", "false" },
>   };
>   const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..2ece9407cc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2134,6 +2134,28 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>       }
>   }
>   
> +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> +                                        uint8_t size, Error **errp)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
> +    if (pos < 0) {
> +        return pos;
> +    }
> +
> +    /*
> +     * Exempt config space check for Vendor Specific Information during
> +     * restore/load.
> +     * Config space check is still enforced for 3 byte VSC header.
> +     */
> +    if (vdev->skip_vsc_check && size > 3) {
> +        memset(pdev->cmask + pos + 3, 0, size - 3);
> +    }
> +
> +    return pos;
> +}
> +
>   static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -2202,6 +2224,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>           vfio_check_af_flr(vdev, pos);
>           ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>           break;
> +    case PCI_CAP_ID_VNDR:
> +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> +        break;
>       default:
>           ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>           break;
> @@ -3390,6 +3415,7 @@ static Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>   #endif
> +    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 6e64a2654e..92cd62d115 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>       OnOffAuto ramfb_migrate;
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
> +    bool skip_vsc_check;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>   };



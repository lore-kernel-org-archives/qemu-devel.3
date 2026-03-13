Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5277106FD98
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xCo-0006w1-5V; Fri, 13 Mar 2026 03:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xCf-0006vP-RF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xCe-0007WY-08
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773387896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jmrBeN9M4iPqsxv+sBJax8jRvUx86LAdnh4W6jSgYDE=;
 b=BJepWa/vYwPZs3vI3zIhzVcdhMPPFw/KzNPuPn0n1+/LKipM8K2dGRQ8axYWIly1HNQ5Lf
 bhcM4DL6k4HS5IREzk1yBqy46h8W2zejZL/v6G4Ics2FMg1H6ht8on0pfRQgCOyp1mQIsM
 qoCaEYpL9goA46ULnFIfhHYrgb8sOX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-4-aYzkccPR2I6-I7CutAhQ-1; Fri, 13 Mar 2026 03:44:49 -0400
X-MC-Unique: 4-aYzkccPR2I6-I7CutAhQ-1
X-Mimecast-MFC-AGG-ID: 4-aYzkccPR2I6-I7CutAhQ_1773387886
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso21123645e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773387885; x=1773992685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jmrBeN9M4iPqsxv+sBJax8jRvUx86LAdnh4W6jSgYDE=;
 b=l+xyeyqMRpdPdVjPLPy0FzkMH03VTL5GdppHlwX/49AXlWI3Jdbn1QDCw1ft1Zpmhd
 IyPgtaneT1qoQM/czPZu5YMEl7e/PcW0NoWOHmNNq689yUSodJ8ombxzkAVWzW1VR7z5
 WPa5OgpWfy3OWXkrWw0Zw1VszHF+3/mKbgnGzU6vHGcAS36KheDbcsfbr8ZQ9Dl7V+H5
 EBRjuWWlIIuyQpmF7dECb0aMxuj7neJeQgKktxSP9INKqvLpbDsiNCQFRrCMM19ZNt2t
 L4sSCGVBzBkmqfWTVGnr8Mj8v++EpmZoeU+L9yVt+ZLoQa7LDGr7vDgnuSt1gkxWsy71
 uYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773387885; x=1773992685;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmrBeN9M4iPqsxv+sBJax8jRvUx86LAdnh4W6jSgYDE=;
 b=qEc9xJBW6onZcUkzfaqxSmlJTTm8Lvk6bYUWxXXqEJmq/JB4Rz4QsaMrJZcGCBXb9w
 kONQFzmKqbXe/q+Zjzu4zI2p8RtjX1IrHpLYu6jTn1Tl4+hFkPJerSzPCGZdV5vMWB4i
 sFLVIoqlOyjksUtve4duH7aSAED8xE6AWsC415OJ2ZtD3kNeHwrc/3BYOT4+k6JZDgKU
 oSNJR5UmbI3XZ2mxUAT2abpr47qJgGsnDcB8Ro2R7QGhrATss80OfP9xDJXhF2R7f8La
 IWoAbRfoixGaa+8KVbzaYktFNZGK8UOnMeUWyg3bO+u8JJ7M4rFWHDI5CtGI8pHR0XaB
 iLhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmwJ/o23Ix6IkgvMcxmbjiutmfkpDP+HMkcltTsMK6MHyIxNOhshciiYEg7GK3HmZ7hWLSRbiKhCvc@nongnu.org
X-Gm-Message-State: AOJu0YwroaRwfR+rYrMjVykizpNvK7Uz0dGa/H5Dt6JujU+moDRtEaJZ
 v219SllBNXoEyekv8lgDGqbOB9pVwjpD3niMXpcnD5fHj7y984ElwzGHBJAbjDAjGoYxgnMHS9T
 HOJNuBxzePSOEsDwCNxAYlbF56RLQ6EltWbtL81d3oIu+OhZbZcFBmFIc7hrxZ5UY
X-Gm-Gg: ATEYQzzWxDQMr9M/ZfYW/OdrBdpsDVDru+dwISt28gZy/tJ82fefiPT4gC9cHDy2L/x
 GJenRaMMswWmvmsknaL4VNCJ37H+1mFvrZWIxOsgSI56X5Gdz0kf3XT+YJ0tQWBSz5dPWFjF/wS
 5bSUw+sPkpJMykV2jVp3TIdoqw0KWsuzQR2IiJNb+TErr4lsfxhIirNbdN8lQ6xPwTsoU+j3T+K
 1kmGXHxcMv2Oqs1ZZ07UDS8GUZU1Fx1iiCC59nvqJ80igUa2st8PkE8gZtsKdewU5jTx2pt10ZK
 NiWnSTSIgETFlAiF98P5H4OSTx56lv82eSjV0bHfYDoV10LA5yiKqiEhZQPgw7k1OY3uGygaVSA
 TPblXc8AiDKOigpS4B/K+I/0KEKtS8k5vbSjbCBYor43ol5qP0If/M6cnGOA2
X-Received: by 2002:a05:600c:1c21:b0:485:5981:1423 with SMTP id
 5b1f17b1804b1-485598116femr17683905e9.3.1773387885510; 
 Fri, 13 Mar 2026 00:44:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1c21:b0:485:5981:1423 with SMTP id
 5b1f17b1804b1-485598116femr17683565e9.3.1773387885014; 
 Fri, 13 Mar 2026 00:44:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm513756675e9.10.2026.03.13.00.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:44:44 -0700 (PDT)
Message-ID: <b88457f8-1d85-497f-8d9a-5cd55b8b2dce@redhat.com>
Date: Fri, 13 Mar 2026 08:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-5-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312224449.1605071-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/26 23:44, Pierrick Bouvier wrote:
> As pointed in c1139fa4 "vfio/iommufd: Remove CONFIG_IOMMUFD usage",
> iommufd presence can be detected at runtime (through /dev/iommufd) and
> we don't need to isolate this at build time.
> 
> It's much (much) more simple to expose this inconditionally compared to
> build dynamically properties arrays.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/ap.c  |  9 ---------
>   hw/vfio/ccw.c |  9 ---------
>   hw/vfio/pci.c | 11 -----------

Commit c1139fa4 ("vfio/iommufd: Remove CONFIG_IOMMUFD usage") changed
the internal routine vfio_attach_device() where relying on the
vbasedev->iommufd pointer value to determine IOMMUFD support is OK.

What bothers me with this change (which I like OTOH) is that it is
exposing IOMMUFD support at the UAPI level. But only i386, s390x and
arm have IOMMUFD support. Not PPC for instance.

C.


>   3 files changed, 29 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index e58a0169af9..856fa2678cd 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
> @@ -279,10 +278,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
>   
>   static const Property vfio_ap_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
> -#ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> -#endif
>   };
>   
>   static void vfio_ap_reset(DeviceState *dev)
> @@ -320,21 +317,17 @@ static void vfio_ap_instance_init(Object *obj)
>       vbasedev->mdev = true;
>   }
>   
> -#ifdef CONFIG_IOMMUFD
>   static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
>   {
>       vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
>   }
> -#endif
>   
>   static void vfio_ap_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       device_class_set_props(dc, vfio_ap_properties);
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
> -#endif
>       dc->vmsd = &vfio_ap_vmstate;
>       dc->desc = "VFIO-based AP device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -347,11 +340,9 @@ static void vfio_ap_class_init(ObjectClass *klass, const void *data)
>       object_class_property_set_description(klass, /* 3.1 */
>                                             "sysfsdev",
>                                             "Host sysfs path of assigned device");
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_set_description(klass, /* 9.0 */
>                                             "iommufd",
>                                             "Set host IOMMUFD backend device");
> -#endif
>   }
>   
>   static const TypeInfo vfio_ap_info = {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2251facb356..c66f42a13c2 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -15,7 +15,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <linux/vfio_ccw.h>
>   #include <sys/ioctl.h>
> @@ -647,10 +646,8 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>   static const Property vfio_ccw_properties[] = {
>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>       DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
> -#ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> -#endif
>       DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
>   };
>   
> @@ -679,12 +676,10 @@ static void vfio_ccw_instance_init(Object *obj)
>                        DEVICE(vcdev), true);
>   }
>   
> -#ifdef CONFIG_IOMMUFD
>   static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
>   {
>       vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
>   }
> -#endif
>   
>   static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
>   {
> @@ -692,9 +687,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
>   
>       device_class_set_props(dc, vfio_ccw_properties);
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
> -#endif
>       dc->vmsd = &vfio_ccw_vmstate;
>       dc->desc = "VFIO-based subchannel assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> @@ -713,11 +706,9 @@ static void vfio_ccw_class_init(ObjectClass *klass, const void *data)
>       object_class_property_set_description(klass, /* 3.0 */
>                                             "force-orb-pfch",
>                                             "Force unlimited prefetch");
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_set_description(klass, /* 9.0 */
>                                             "iommufd",
>                                             "Set host IOMMUFD backend device");
> -#endif
>       object_class_property_set_description(klass, /* 9.2 */
>                                             "loadparm",
>                                             "Define which devices that can be used for booting");
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 94c174a773f..df617f1fe46 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -19,7 +19,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   
> @@ -3471,9 +3470,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
>                 ~vdev->host.slot || ~vdev->host.function)) {
>               error_setg(errp, "No provided host device");
>               error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
> -#ifdef CONFIG_IOMMUFD
>                                 "or -device vfio-pci,fd=DEVICE_FD "
> -#endif
>                                 "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>               return;
>           }
> @@ -3816,22 +3813,18 @@ static const Property vfio_pci_properties[] = {
>                                      qdev_prop_nv_gpudirect_clique, uint8_t),
>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>                                   OFF_AUTO_PCIBAR_OFF),
> -#ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> -#endif
>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>                          vpasid_cap_offset, 0),
>   };
>   
> -#ifdef CONFIG_IOMMUFD
>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       vfio_device_set_fd(&vdev->vbasedev, str, errp);
>   }
> -#endif
>   
>   static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>   {
> @@ -3840,9 +3833,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>   
>       device_class_set_legacy_reset(dc, vfio_pci_reset);
>       device_class_set_props(dc, vfio_pci_properties);
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> -#endif
>       dc->vmsd = &vfio_cpr_pci_vmstate;
>       dc->desc = "VFIO-based PCI device assignment";
>       pdc->realize = vfio_pci_realize;
> @@ -3944,11 +3935,9 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "vf-token",
>                                             "Specify UUID VF token. Required for VF when PF is owned "
>                                             "by another VFIO driver");
> -#ifdef CONFIG_IOMMUFD
>       object_class_property_set_description(klass, /* 9.0 */
>                                             "iommufd",
>                                             "Set host IOMMUFD backend device");
> -#endif
>       object_class_property_set_description(klass, /* 9.1 */
>                                             "x-device-dirty-page-tracking",
>                                             "Disable device dirty page tracking and use "



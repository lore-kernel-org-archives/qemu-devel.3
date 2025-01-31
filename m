Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB83C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdn7L-0006TL-2H; Fri, 31 Jan 2025 04:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdn7G-0006Sk-GD
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdn7E-0001Gp-GU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738314905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=32JcsiO2pZwtzx2w59V5DYqgfN1PC9fg8Y3prnOu/uM=;
 b=QPy+bB82V4Wm++poEPG+ETI0v7+Cay+Zcu7+RYgffoGNpdMv/rJAq+ZTZZrFzKPRcCe5pa
 0Ki95jgBgzFBUDXc/JTWf16ajrY6S/bCUZDSR3cL7xeqI5cPLK//nTG5PFyRtvn2Kwm1Ji
 Pb4kIUHIaoo0WuykYMtu+w8XI5k1BEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-MOJp3eH6MGauvEaDbB9mYA-1; Fri, 31 Jan 2025 04:15:02 -0500
X-MC-Unique: MOJp3eH6MGauvEaDbB9mYA-1
X-Mimecast-MFC-AGG-ID: MOJp3eH6MGauvEaDbB9mYA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso8269155e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 01:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738314901; x=1738919701;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32JcsiO2pZwtzx2w59V5DYqgfN1PC9fg8Y3prnOu/uM=;
 b=nX4ypvaEESwSHsdf8yKNF47tsKn3JhWv7ny+K0AgsNCRj19pRxyFBDVinnDsaj4nt/
 gt1uV0/lUTLxPr59NeitDl1vvVM8e0QuJkCU/zFgmM3vzQfhLrj/T8WWje864yjM6VP0
 8xdtFMfwSN0eKs4/ZDAjOyI7h8J3jovxLhwUI5x0N4KYZTCfeQS+5TCPHf5S/T17t9Cd
 6t7WZwuuNHvDft1GjUjMNFuIY/yNzM9E0IlyUfpeoojW4RlvBD4rM+AKO742mP49iSXT
 4TNtv2Q0qN4iLaZ9GDzGPFXcYINwq0Pij/uLk1gsRVdGRsDw0hvbGVWxkTsPMAE/qyLq
 NHIw==
X-Gm-Message-State: AOJu0YzZahWJTGSPGXKCdxfo37mZo0vHq79zQ9Gp5irePpgZNyHGcV8l
 1cLZA4OAyxpN7fMTxd+Oh01YaBnyvyYdIPvocYhmxjnxIOfrjKlXSVOqIHwGUbwbqAQowObwS27
 QZOr4oFiRrQ8yOpvD81stGPsMYoTrDNYdSKiO7eBx13en1Pe5hd5K1SH1OoQ8
X-Gm-Gg: ASbGncsyU1Y9tIshQVHlPm2ElFks3RFXC4dFSTpXtgKPPfUrWpgNdnyr+4vwFvYvhzE
 Zx7L78kYHoTP5gPaMJiZ6TRZRuJypiLFlrbn06+iZGsmKnfLaYZDzr3n4AaYhHmEeAy7wZDwuhz
 CwMvQDsmUmwTO11FN/g/JOMbABYSLcf1SK2IR2yPMr3hdbbdFeHosssA3sNJJSf5dicCedSaEtd
 2pYqttcRFN548tXTnfZZmjegNPyTPhh3OVXUTPdAWNC8WQNUzK4rRrwdwNlfvcZuHB4UvhV/OBN
 xCLNGVLcfLrTkF4aFlWD9jthy115nuaGMN5MiURrmzc=
X-Received: by 2002:a05:600c:154a:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-438dc42bd08mr104659165e9.30.1738314900886; 
 Fri, 31 Jan 2025 01:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHKkDZtdsXWGEydmb5TaX8iuKKUJvzjkDE+oWURdItqkWdqMsA9qIgUlCF6hEJIiO7lKpvMg==
X-Received: by 2002:a05:600c:154a:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-438dc42bd08mr104658875e9.30.1738314900431; 
 Fri, 31 Jan 2025 01:15:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81941sm84141775e9.36.2025.01.31.01.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:14:59 -0800 (PST)
Message-ID: <009cbf4b-ae21-4bdc-a288-251a6167ff34@redhat.com>
Date: Fri, 31 Jan 2025 10:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] vfio/igd: refactor vfio_probe_igd_bar4_quirk()
 into pci config quirk
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-4-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250124191245.12464-4-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hello Tomita,

On 1/24/25 20:12, Tomita Moeko wrote:
> The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk() was
> removed in previous change, leaving the function not matching its name,
> so move it into the newly introduced vfio_config_quirk_setup(). There
> is no functional change in this commit. If any failure occurs, the
> function simply returns and proceeds.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>   hw/vfio/igd.c        | 31 +++++++++++++++++--------------
>   hw/vfio/pci-quirks.c |  6 +++++-
>   hw/vfio/pci.h        |  2 +-
>   3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index ca3a32f4f2..376a26fbae 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -359,7 +359,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>   }
>   
> -void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> +                                 Error **errp G_GNUC_UNUSED)

Adding an 'Error **' parameter is in improvement indeed. All the error_report
of this routine need to be converted too.

>   {
>       g_autofree struct vfio_region_info *rom = NULL;
>       g_autofree struct vfio_region_info *opregion = NULL;
> @@ -378,10 +379,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>        * PCI bus address.
>        */
>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        !vfio_is_vga(vdev) || nr != 4 ||
> +        !vfio_is_vga(vdev) ||
>           &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>                                          0, PCI_DEVFN(0x2, 0))) {
> -        return;
> +        return true;
>       }
>   
>       /*
> @@ -395,7 +396,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>                                              "vfio-pci-igd-lpc-bridge")) {
>           error_report("IGD device %s cannot support legacy mode due to existing "
>                        "devices at address 1f.0", vdev->vbasedev.name);
> -        return;
> +        return true;

if there is an error_report, why is this returning true ? It should be false.
  
>       }
>   
>       /*
> @@ -407,7 +408,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (gen == -1) {
>           error_report("IGD device %s is unsupported in legacy mode, "
>                        "try SandyBridge or newer", vdev->vbasedev.name);
> -        return;
> +        return true;

same here and else where.

>       }
>   
>       /*
> @@ -420,7 +421,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if ((ret || !rom->size) && !vdev->pdev.romfile) {
>           error_report("IGD device %s has no ROM, legacy mode disabled",
>                        vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       /*
> @@ -431,7 +432,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>           error_report("IGD device %s hotplugged, ROM disabled, "
>                        "legacy mode disabled", vdev->vbasedev.name);
>           vdev->rom_read_failed = true;
> -        return;
> +        return true;
>       }
>   
>       /*
> @@ -444,7 +445,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support OpRegion access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -453,7 +454,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support host bridge access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -462,7 +463,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support LPC bridge access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> @@ -476,7 +477,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           error_report("IGD device %s failed to enable VGA access, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       /* Create our LPC/ISA bridge */
> @@ -484,7 +485,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s failed to create LPC bridge, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       /* Stuff some host values into the VM PCI host bridge */
> @@ -492,14 +493,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s failed to modify host bridge, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       /* Setup OpRegion access */
>       if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>           error_append_hint(&err, "IGD legacy mode disabled\n");
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -        return;
> +        return true;
>       }
>   
>       /*
> @@ -561,4 +562,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>   
>       trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
>                                       (ggms_size + gms_size) / MiB);
> +
> +    return true;
>   }
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c40e3ca88f..b8379cb512 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1169,6 +1169,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>    */
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> +#ifdef CONFIG_VFIO_IGD

oh. We try to avoid such ifdef in QEMU. Only very specific and high level
configs are discarded at compile time (KVM, LINUX, etc).

One way to adress this case, would be to use QOM. Example below :

  
Declare a base class :
     
     #define TYPE_VFIO_PCI_QUIRK_PROVIDER "vfio-pci-quirk-provider"
     
     OBJECT_DECLARE_TYPE(VFIOPCIQuirkProvider, VFIOPCIQuirkProviderClass,
                         VFIO_PCI_QUIRK_PROVIDER)
     
     struct VFIOPCIQuirkProviderClass {
         ObjectClass parent;
     
         bool (*probe)(VFIOPCIDevice *vdev, Error **errp);
         bool (*setup)(VFIOPCIDevice *vdev, Error **errp);
     };
     
     static const TypeInfo vfio_pci_quirk_info = {
         .name = TYPE_VFIO_PCI_QUIRK_PROVIDER,
         .parent = TYPE_OBJECT,
         .class_size = sizeof(VFIOPCIQuirkClass),
         .abstract = true,
     };
     
     static void register_vfio_pci_quirk_type(void)
     {
         type_register_static(&vfio_pci_quirk_info);
     }
     
     type_init(register_vfio_pci_quirk_type)


Declare one for IGD
     
     static void vfio_pci_quirk_igd_class_init(ObjectClass *klass, void *data)
     {
         VFIOPCIQuirkClass* vpqc = VFIO_PCI_QUIRK_PROVIDER_CLASS(klass);
     
         vpqc->setup = vfio_probe_igd_quirk_probe;
         vpqc->probe = vfio_probe_igd_quirk_probe;
     }
     
     static const TypeInfo vfio_pci_quirk_igd_info = {
         .name = TYPE_VFIO_PCI_QUIRK_PROVIDER "-igd",
         .parent = TYPE_VFIO_PCI_QUIRK_PROVIDER,
         .class_init = vfio_pci_quirk_igd_class_init,
         .class_size = sizeof(VFIOPCIQuirkClass),
     };
     
     static void vfio_pci_quirk_igd_register_types(void)
     {
         type_register_static(&vfio_pci_quirk_igd_info);
     }
     
     type_init(vfio_pci_quirk_igd_register_types)


and in the common part, loop on all the classes to probe and setup :


     static void vfio_pci_quirk_class_foreach(ObjectClass *klass, void *opaque)
     {
         VFIOPCIQuirkProviderClass* vpqc = VFIO_PCI_QUIRK_PROVIDER_CLASS(klass);
         Error *local_err = NULL;
     
         vpqc->setup(opaque, &local_err);
     }
     
     bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
     {
         object_class_foreach(vfio_pci_quirk_class_foreach,
                              TYPE_VFIO_PCI_QUIRK_PROVIDER, false, vdev);
        ...




Thanks,

C.




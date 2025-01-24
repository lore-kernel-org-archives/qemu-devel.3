Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F841C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMVs-0001GR-D9; Fri, 24 Jan 2025 11:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tbMVh-0001Ex-4E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tbMVQ-0005A0-9g
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737735959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzClnTOVV3sLFfzs70bfLmFfGXfwemAQTtKvUxHw2mA=;
 b=BqInbPMAMmPFnomCwbFjESIhauZZ633eIWoGBXrK4WwM30RJJKpu9jtKPFf2vbRFUMkI1D
 G1RvTvSiJJLNFJox70P2B9RAR+ATjBdB9Pyh/vzjbVMIDzfNuJE3VWIPOXP3CDBBRdFmsf
 yTOqVHGnOdP27xHohixT7dJLSzjphnw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-vTLtcP-3NAaP2r6qH6zmEQ-1; Fri, 24 Jan 2025 11:25:58 -0500
X-MC-Unique: vTLtcP-3NAaP2r6qH6zmEQ-1
X-Mimecast-MFC-AGG-ID: vTLtcP-3NAaP2r6qH6zmEQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467bb3eeb04so1963891cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735647; x=1738340447;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzClnTOVV3sLFfzs70bfLmFfGXfwemAQTtKvUxHw2mA=;
 b=RIR83yVQo18z7e7oQhcVS7NfPJum3Vj55HxDZQriB2Txbc+aJs6hZPOLK1NmJssmgQ
 ZrghR8Hky7r8rl/M3zNyp+gHQ6rsh9LTRxEbx+VRdzvFz/yG+9ycStt8KXRDHt6zVr/y
 Z23/9Ewt+X9H5C+zq/v0vapYtFZ8OPw6Ov6TQoE5KURYPX4J1eF9wV82X5ZxIg436Kj9
 y5OXhZToZBih2kYkxNkD2LTEo+AqJAKKUWSfd7i6I9rMRsOmYlsYxdaWiBtymbYhAmq5
 8RDD9TBlmVLZX4SaAlkgv2A3Q8m9s40H6LUPLFtsWvEF8Z3i77GWSHTqEBFRXLKi0ulv
 i3hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTqmSJErglRzqZv2YIzjfQEDcKmZPYacmUbZEivTW1LAUNusrGxQPz21lNs9kUpgAe0Qbhs0wG2Q1L@nongnu.org
X-Gm-Message-State: AOJu0YyffCnbtuVSValF+/G50bcqUTOsUC6aeTD+NRD15nMpC2J//4Kj
 6MrPIe2HdIPUiPqH6PXkxrP+2AWekXYFhWMskmbR1JOcQ93N1tF6pndHBJbWaAu9/fMGolWaiOe
 SC9oAcw9cAESuL00nLsjrYVp+p7OuKzEtKZyLvEYaXfHwmQ7jozDd
X-Gm-Gg: ASbGncvIgvMLaCENUBUP+PhLg8n6XNA3YijDbpCOjD1VdljsaaJKmm1AH42XHvayNRj
 3fVnKeTy2KJXekDWAj83Op5gSqk6KcJ9CsmgVFJTsIZHyNnje/5S7t9DW8LxIshtJjIoeajZD3o
 RaW3QR9qL0ArV0Ag+adRBT2zZ9rK47SzeeV1S0WCwKsc4r7DG/AnJsy9RE42EaeVTPS7ONb490v
 QmEu/7ShHfeZ0unSMbh7nahtu0djPR8tR3rld2uJxnt3UBxGfRk+pJkA8cV7v0rHdTlVpX45g==
X-Received: by 2002:a05:6e02:194c:b0:3cf:6c0e:bd with SMTP id
 e9e14a558f8ab-3cfb193d01cmr30970475ab.6.1737733798432; 
 Fri, 24 Jan 2025 07:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPGiuaf/ThLT2SirJ0H+hCoi8vnqe9x1Y90uYVYxXGcuLaIkSMKD3gd3PuYjj1QLcrAn/BjQ==
X-Received: by 2002:a05:6e02:194c:b0:3cf:6c0e:bd with SMTP id
 e9e14a558f8ab-3cfb193d01cmr30970345ab.6.1737733797992; 
 Fri, 24 Jan 2025 07:49:57 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1db6d8e2sm673156173.95.2025.01.24.07.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:49:57 -0800 (PST)
Date: Fri, 24 Jan 2025 08:49:54 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] vfio/igd: refactor vfio_probe_igd_bar4_quirk() into
 pci config quirk
Message-ID: <20250124084954.46cdf647.alex.williamson@redhat.com>
In-Reply-To: <20250122171731.40444-4-tomitamoeko@gmail.com>
References: <20250122171731.40444-1-tomitamoeko@gmail.com>
 <20250122171731.40444-4-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 23 Jan 2025 01:17:30 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk() was
> removed in previous change, leaving the function not matching its name,
> so move it into the newly introduced vfio_config_quirk_setup(). There
> is no functional change in this commit. If any failure occurs, the
> function simply returns and proceeds.

I don't understand why vfio_config_quirk_setup() returns bool rather
than void given that it can never fail based on this series.
Otherwise, while I'm surprised that the GTT re-writing is unnecessary
(seems I wouldn't have invented such a need), removing it is really the
only way to fully validate that, and we can always revisit if we start
getting regression reports.  Thanks,

Alex

> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c        | 30 ++++++++++++++++--------------
>  hw/vfio/pci-quirks.c |  6 +++++-
>  hw/vfio/pci.h        |  2 +-
>  3 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 4f9a90f36f..33e5202052 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -359,7 +359,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>  }
>  
> -void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> +                                 Error **errp G_GNUC_UNUSED)
>  {
>      g_autofree struct vfio_region_info *rom = NULL;
>      g_autofree struct vfio_region_info *opregion = NULL;
> @@ -378,10 +379,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       * PCI bus address.
>       */
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> -        nr != 4 ||
>          &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>                                         0, PCI_DEVFN(0x2, 0))) {
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -395,7 +395,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>                                             "vfio-pci-igd-lpc-bridge")) {
>          error_report("IGD device %s cannot support legacy mode due to existing "
>                       "devices at address 1f.0", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -407,7 +407,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (gen == -1) {
>          error_report("IGD device %s is unsupported in legacy mode, "
>                       "try SandyBridge or newer", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -420,7 +420,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if ((ret || !rom->size) && !vdev->pdev.romfile) {
>          error_report("IGD device %s has no ROM, legacy mode disabled",
>                       vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -431,7 +431,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>          error_report("IGD device %s hotplugged, ROM disabled, "
>                       "legacy mode disabled", vdev->vbasedev.name);
>          vdev->rom_read_failed = true;
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -444,7 +444,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (ret) {
>          error_report("IGD device %s does not support OpRegion access,"
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -453,7 +453,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (ret) {
>          error_report("IGD device %s does not support host bridge access,"
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -462,7 +462,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (ret) {
>          error_report("IGD device %s does not support LPC bridge access,"
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> @@ -476,7 +476,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>          error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>          error_report("IGD device %s failed to enable VGA access, "
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /* Create our LPC/ISA bridge */
> @@ -484,7 +484,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (ret) {
>          error_report("IGD device %s failed to create LPC bridge, "
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /* Stuff some host values into the VM PCI host bridge */
> @@ -492,14 +492,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      if (ret) {
>          error_report("IGD device %s failed to modify host bridge, "
>                       "legacy mode disabled", vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /* Setup OpRegion access */
>      if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>          error_append_hint(&err, "IGD legacy mode disabled\n");
>          error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -        return;
> +        return true;
>      }
>  
>      /*
> @@ -561,4 +561,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
>                                      (ggms_size + gms_size) / MiB);
> +
> +    return true;
>  }
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c40e3ca88f..b8379cb512 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1169,6 +1169,11 @@ bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>   */
>  bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>  {
> +#ifdef CONFIG_VFIO_IGD
> +    if (!vfio_probe_igd_config_quirk(vdev, errp)) {
> +        return false;
> +    }
> +#endif
>      return true;
>  }
>  
> @@ -1220,7 +1225,6 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
>      vfio_probe_rtl8168_bar2_quirk(vdev, nr);
>  #ifdef CONFIG_VFIO_IGD
>      vfio_probe_igd_bar0_quirk(vdev, nr);
> -    vfio_probe_igd_bar4_quirk(vdev, nr);
>  #endif
>  }
>  
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5359e94f18..5c64de0270 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -217,7 +217,7 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
>  void vfio_quirk_reset(VFIOPCIDevice *vdev);
>  VFIOQuirk *vfio_quirk_alloc(int nr_mem);
>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
> -void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
>  
>  extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>  



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB403C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucn5q-0007Sj-Bo; Fri, 18 Jul 2025 11:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1ucmzP-0007Rr-0Q; Fri, 18 Jul 2025 11:27:11 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1ucmzM-0008O8-LK; Fri, 18 Jul 2025 11:27:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-235d6de331fso25153195ad.3; 
 Fri, 18 Jul 2025 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752852426; x=1753457226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHs/ZpV5VF+uPAwNF4WxC+69ynbzP1chLJuN5FmdjsQ=;
 b=N9C1NcLfJlz09YlihIUVZXQ0wQ/UUl0tN3Dbpw1/tVmHBHw3c8wiNUi+SkZ68nxI8T
 AsRM7OmUREXAm6hLltUy/LI0ta7dBcve8qSl0ckhl3hYCjmtQY8h9OkZARg7HVlz/cSB
 acAw99GK0dWf07RqfyycLBM7lXCO1rSHEtooAUHQRQsTOYMUadYBtFMFSqI2cA6xpdmx
 WBcLiNSfaP51hy/1lcmCZqcJUiZBDeKTeETFqlHf2ovIIzQaFDdSoaJzMcRPnn0CY+Rj
 K3hHO2uegIZC6LFDoLwzgUO4nCBxhN4wrZi4u4ZjfFV9PseWmSw+ohJY0sGWeWOz+HCx
 bgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752852426; x=1753457226;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zHs/ZpV5VF+uPAwNF4WxC+69ynbzP1chLJuN5FmdjsQ=;
 b=BtWn9WXhVpxK43kxyUnvyFtv0GLfgQIZGgEfCLGUzZn7Oi/k/e9SaNHAA4LBBbZdcm
 WBWnKv5XH5ZqvBZvp010tc+8YshRURKLfmceQ2YjAPrpFyhF2DF+Ob+fV1cN/mpWOzQI
 3jZ5vnL84W234GfvcaZcxc9QN8q7n9sIVvnuc9ztzP3XjROxW6qHiMcpNCzNB+XpnXPN
 BtRrEvrsuYTSG4AaPE5sc2gkfmpJxeAi8YAtaIqHJfBri+ZAPFP9+vT0ErenkqQBFuqV
 eAfqpmd6xv19FsRAEc7eU3Y3KRJ9yKBuoJo5VA1LoYj9z9l1VTnro/XdgCUxLDnx3fP0
 5q+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCyf7jbaIcmK0cLzKVsei4dkkFPqwXoW6vepYJ4A2uIipGoCBbX1u286NaVRaTP/L9kvYtlCRjvxADOg==@nongnu.org,
 AJvYcCX59uHGBhhuCLSmZdSyQ3hSg6dMs45lA0Rq+UuewbY1+X7NMRSofMY+qPTsM9eKDeb/GOibqxoQ1q6W@nongnu.org,
 AJvYcCX9zQxbp0qKKz9pd0XuaCE1nKdmIyXIv1Uh5+xD9fjg82B+6b2Zit+K5la+sGzKBEv9LjHhw8Lb/Nc=@nongnu.org
X-Gm-Message-State: AOJu0YyGYt5kwmI7W8bM4P9ulnlHH2oBaq5eNs0Z+b/aQb3v2qKish2c
 bMQSPcWCgnzXh09x+iiKYVjqf6HAehiqvut4ipLS0r95pTERHUODYuI=
X-Gm-Gg: ASbGnctfldHTlh9SvWSLqWMXrhjSa1jIEiLIJH+7rRbUMbN7AyzlacPZ+wKOD0cqt23
 /7icqQ1xJtL12UZszjr8HUrJMJGt1k0pkC8u/K9MU9c4r8+HzXWwFDvQwgK1PqCxrEND3LsHz77
 aSOD4qOUPO22TDdT6Fa0ZnxgLjuTeD+wSRWqcYe8S/tQOJV+zAw3qEDmE6FmCKAu1tWT2Z2NYOP
 0rSRQHRhaOS8X5yocUYOo096H+FyGIqWU1ceo33D1JL7Olsf+BjoI1lUa2mgXXT6osQQRcbXI+4
 bI75Co5ZaFtmUWtyR+vSfriJhDPRqgW5k5mZUZpWGzjCM3GcfbCRNmTrOeaj+gJRAmcvIpAI7TH
 r8z6LTU9ryw9NxlEOYRetO7OBCeO8OTvu8LgRB0xb2Q==
X-Google-Smtp-Source: AGHT+IHQ7fwE1NbZhxatBQlFWB2Fj1U4buMyEGGA0Le5b+v2JK5U8vqoh0bFWZXpnOLhAtNpVgzmNA==
X-Received: by 2002:a17:903:1a8d:b0:234:9092:9dda with SMTP id
 d9443c01a7336-23e2572ab0bmr191981545ad.24.1752852425927; 
 Fri, 18 Jul 2025 08:27:05 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b60f426sm14981165ad.67.2025.07.18.08.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 08:27:05 -0700 (PDT)
Message-ID: <6bb92825-a9f6-4c08-8beb-8af490291378@gmail.com>
Date: Fri, 18 Jul 2025 23:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] vfio/igd.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-20-mark.caveayland@nutanix.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250715093110.107317-20-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/15/2025 5:25 PM, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
> accessing pdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio/igd.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7a9d1ffc1..d3ffbe7db6 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -199,7 +199,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
>      }
>  
>      /* Hotplugging is not supported for opregion access */
> -    if (vdev->pdev.qdev.hotplugged) {
> +    if (DEVICE(vdev)->hotplugged) {
>          warn_report("IGD device detected, but OpRegion is not supported "
>                      "on hotplugged device.");
>          return false;
> @@ -259,11 +259,12 @@ static int vfio_pci_igd_copy(VFIOPCIDevice *vdev, PCIDevice *pdev,
>  static int vfio_pci_igd_host_init(VFIOPCIDevice *vdev,
>                                    struct vfio_region_info *info)
>  {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      PCIBus *bus;
>      PCIDevice *host_bridge;
>      int ret;
>  
> -    bus = pci_device_root_bus(&vdev->pdev);
> +    bus = pci_device_root_bus(pdev);
>      host_bridge = pci_find_device(bus, 0, PCI_DEVFN(0, 0));
>  
>      if (!host_bridge) {
> @@ -326,13 +327,14 @@ type_init(vfio_pci_igd_register_types)
>  static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>                                   struct vfio_region_info *info)
>  {
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      PCIDevice *lpc_bridge;
>      int ret;
>  
> -    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
> +    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
>                                   0, PCI_DEVFN(0x1f, 0));
>      if (!lpc_bridge) {
> -        lpc_bridge = pci_create_simple(pci_device_root_bus(&vdev->pdev),
> +        lpc_bridge = pci_create_simple(pci_device_root_bus(pdev),
>                                   PCI_DEVFN(0x1f, 0), "vfio-pci-igd-lpc-bridge");
>      }
>  
> @@ -349,13 +351,14 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
>  {
>      struct vfio_region_info *host = NULL;
>      struct vfio_region_info *lpc = NULL;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      PCIDevice *lpc_bridge;
>      int ret;
>  
>      /*
>       * Copying IDs or creating new devices are not supported on hotplug
>       */
> -    if (vdev->pdev.qdev.hotplugged) {
> +    if (DEVICE(vdev)->hotplugged) {
>          error_setg(errp, "IGD LPC is not supported on hotplugged device");
>          return false;
>      }
> @@ -365,7 +368,7 @@ static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
>       * can stuff host values into, so if there's already one there and it's not
>       * one we can hack on, this quirk is no-go.  Sorry Q35.
>       */
> -    lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
> +    lpc_bridge = pci_find_device(pci_device_root_bus(pdev),
>                                   0, PCI_DEVFN(0x1f, 0));
>      if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
>                                             "vfio-pci-igd-lpc-bridge")) {
> @@ -509,6 +512,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  {
>      struct vfio_region_info *opregion = NULL;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      int ret, gen;
>      uint64_t gms_size = 0;
>      uint64_t *bdsm_size;
> @@ -528,7 +532,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      info_report("OpRegion detected on Intel display %x.", vdev->device_id);
>  
>      gen = igd_gen(vdev);
> -    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> +    gmch = vfio_pci_read_config(pdev, IGD_GMCH, 4);
>  
>      /*
>       * For backward compatibility, enable legacy mode when
> @@ -540,7 +544,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
>          (gen >= 6 && gen <= 9) &&
>          !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
> -        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
> +        (pdev == pci_find_device(pci_device_root_bus(pdev),
>          0, PCI_DEVFN(0x2, 0)))) {
>          /*
>           * IGD legacy mode requires:
> @@ -562,7 +566,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>           */
>          ret = vfio_device_get_region_info(&vdev->vbasedev,
>                                            VFIO_PCI_ROM_REGION_INDEX, &rom);
> -        if ((ret || !rom->size) && !vdev->pdev.romfile) {
> +        if ((ret || !rom->size) && !pdev->romfile) {
>              error_setg(&err, "Device has no ROM");
>              goto error;
>          }
> @@ -605,8 +609,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>       * ASLS (OpRegion address) is read-only, emulated
>       * It contains HPA, guest firmware need to reprogram it with GPA.
>       */
> -    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> -    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> +    pci_set_long(pdev->config + IGD_ASLS, 0);
> +    pci_set_long(pdev->wmask + IGD_ASLS, ~0);
>      pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>  
>      /*
> @@ -620,8 +624,8 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          }
>  
>          /* GMCH is read-only, emulated */
> -        pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
> -        pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
> +        pci_set_long(pdev->config + IGD_GMCH, gmch);
> +        pci_set_long(pdev->wmask + IGD_GMCH, 0);
>          pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
>      }
>  
> @@ -630,12 +634,12 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  
>          /* BDSM is read-write, emulated. BIOS needs to be able to write it */
>          if (gen < 11) {
> -            pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
> -            pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
> +            pci_set_long(pdev->config + IGD_BDSM, 0);
> +            pci_set_long(pdev->wmask + IGD_BDSM, ~0);
>              pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
>          } else {
> -            pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
> -            pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
> +            pci_set_quad(pdev->config + IGD_BDSM_GEN11, 0);
> +            pci_set_quad(pdev->wmask + IGD_BDSM_GEN11, ~0);
>              pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
>          }
>      }

Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>



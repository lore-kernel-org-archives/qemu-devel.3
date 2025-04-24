Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF66C369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85Vi-0003n4-Kp; Thu, 24 Apr 2025 18:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85Vd-0003mN-AI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85VY-0004oS-N9
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745535447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SoQstIYJmlCoOXd/q2JXYXca9H+Mk19gwQljHW8akdM=;
 b=CQIjb4YQ3FHwH8c/2XPc6hc53nL7ERmY/GtAel1Ci2Vx7a0v0PLXN8Zyr+gmBb8ybPP1Xe
 MmsYQW9X+RdTobD8v40b3njIl8qptZZwci5cEnL7jtkn0Wmha6FCljNWtiVp6ApfKbHf0Y
 NkoyAddcAsz93LUtbsBbFtlzaqJY8Sw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-N3tnH2HUPuS8Xs593mAUbg-1; Thu, 24 Apr 2025 18:57:25 -0400
X-MC-Unique: N3tnH2HUPuS8Xs593mAUbg-1
X-Mimecast-MFC-AGG-ID: N3tnH2HUPuS8Xs593mAUbg_1745535445
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8643da7eba4so31134139f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745535445; x=1746140245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoQstIYJmlCoOXd/q2JXYXca9H+Mk19gwQljHW8akdM=;
 b=PZvJM6MfwSsLa//SyVwK2xMIrhtpxYs5HCywT4jZfFQI4NvHw4PjFO6nn0rIIJM/dM
 9y2rlTwxDrL3ZXALR5FAsdLDMP4KkztkSBzp2vcvF//FQykbjPN1bcG494E9JwR3jYP1
 UtXdQmElkT2F+xpvIuHwFn1L+rKfgXK9EFQVRLCRd/6o4oL32hb+ElqEJjKtIukEl7Rd
 eKyheEFp3tgTAA+0K74Sxe5NSQ5RopeLIQT5ggwlFfWViMdlrZ2qfjCJPYEJnB1jyre6
 9cCEivdIbISr3bngd7zvC+tYoXQbhr3rr7t2YlnRivAK13c6QpNWrllZoPiOxisHzEHE
 a0Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnLf3F5P4iWtEoK33EC7HNTRgKaF827C3jpGPhGNeKZMSkch2wA+k1LMMzdw+0QjpVgTwTEpmno+ah@nongnu.org
X-Gm-Message-State: AOJu0Yxy9dqJrztBf1DPBSNJdw1p/NSdU8hiheKAgqxFQk7pJ2p4a0ar
 L41FrfZ/st16ZObhEU4EMuEvHgl2NoH4EA0XJJjSbEWa+vmGVUKbWahmonI1kAn/418t0sv+Ybf
 HN1QixtX1iHoiCXvY3df3MNMOLfAxgcTxf0SK/xvs2wr+9lEGi9zC
X-Gm-Gg: ASbGncvabt6Esjr+v/P2ulCURzxLhZOzDb1tZyln6zXugmh5hnrCVSYVPRaGNmsDIEl
 x1h8QoSea7IP0aFKEAFfin3gVpoXYH4K8P3y36zdx+PEbpk6Xd6IwUQ2mOEzObTzYGYaY6oS2Sl
 3o7MxVYWMcJL2TE1zHzJaWVuHTho91fFqGJLHuMKKfEOiOAwCbVAP9u04ltQmh5KtUK8a07BbdH
 pIKhVskXbK1LLh5kwjsPA3bCQPMs1P/g/L1TldeeKN607z9Sm6M0WMdbl1RNTVPg8ngGL0XIoo7
 NT+GSxhWQ8tQwyI=
X-Received: by 2002:a05:6602:29ce:b0:855:d60d:1104 with SMTP id
 ca18e2360f4ac-8645cca3116mr7360739f.2.1745535444721; 
 Thu, 24 Apr 2025 15:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8x2wwnlMJwDtbJrRzN1MXdCyNnrTcyfc56ho2RtoFbNwb4S+cW75a53MRQpqMTHxsF2y72w==
X-Received: by 2002:a05:6602:29ce:b0:855:d60d:1104 with SMTP id
 ca18e2360f4ac-8645cca3116mr7360439f.2.1745535444341; 
 Thu, 24 Apr 2025 15:57:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864519d2370sm36841639f.30.2025.04.24.15.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 15:57:22 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:57:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH 03/11] vfio/igd: Detect IGD device by OpRegion
Message-ID: <20250424165720.6265e113.alex.williamson@redhat.com>
In-Reply-To: <20250421163112.21316-4-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-4-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Tue, 22 Apr 2025 00:31:03 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> There is currently no straightforward way to distinguish if a Intel
> graphics device is IGD or discrete GPU. However, only IGD devices expose
> OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
> to identify IGD devices.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 36316e50ea..7a7c7735c1 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -479,6 +479,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  
>  static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  {
> +    g_autofree struct vfio_region_info *opregion = NULL;
>      int ret, gen;
>      uint64_t gms_size;
>      uint64_t *bdsm_size;
> @@ -486,16 +487,20 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      bool legacy_mode_enabled = false;
>      Error *err = NULL;
>  
> -    /*
> -     * This must be an Intel VGA device at address 00:02.0 for us to even
> -     * consider enabling legacy mode.  The vBIOS has dependencies on the
> -     * PCI bus address.
> -     */
>      if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>          !vfio_is_vga(vdev)) {
>          return true;
>      }
>  
> +    /* IGD device always comes with OpRegion */
> +    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
> +    if (ret) {
> +        return true;
> +    }
> +    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
> +
>      /*
>       * IGD is not a standard, they like to change their specs often.  We
>       * only attempt to support back to SandBridge and we hope that newer
> @@ -570,9 +575,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>      }
>  
>      /* Setup OpRegion access */
> -    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
> -        !vfio_pci_igd_setup_opregion(vdev, errp)) {
> -        goto error;
> +    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION)) {
> +        if (vdev->pdev.qdev.hotplugged) {
> +            error_setg(errp, "OpRegion is not supported on hotplugged device");
> +            goto error;
> +        }
> +        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
> +            goto error;
> +        }
>      }
>  
>      /* Setup LPC bridge / Host bridge PCI IDs */

I think this still needs some refactoring work.  The setup function
currently does:
 a) test hotplugged
 b) get opregion
 c) call init

We implemented b) above and therefore do a) and c) here, duplicating
them from the setup function.  It would be valid to test a) as we're
getting the opregion, so wouldn't it make sense to turn setup into a
function that does a) and b), returning an opregion, called by both
this path and GVT-g path, and each would call the init function
themselves?  The latter is already implemented in the next patch, but
a) and b) are still duplicated in GVT-g specific code.  Thanks,

Alex



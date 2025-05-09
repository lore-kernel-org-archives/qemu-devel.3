Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E67C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKgC-0004mY-UO; Fri, 09 May 2025 06:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKfx-0004To-NS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDKfu-0001Ih-QB
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746785390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GQ0ByGRVIs3Uu5drgiGclKQSySRqiRbl9YdSGEBm5MI=;
 b=fO/qR5awKfzaUPrgs50tbOGToinSROJFgpoNKdBT6ANjeWwTx3nRn3sEl26jsu8yy8nETb
 zlkG2Dpo8j0GshQoTrcDJjMhFCCc17Rc9y/oDytz69BzPQBFQu7qYNL/ZL7P26QsYutGvb
 spaZSw2J0N3Wotx9US/lfz7Kyq1QTlk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-CLVhcWeDPJa_y19GtiHMSQ-1; Fri, 09 May 2025 06:09:48 -0400
X-MC-Unique: CLVhcWeDPJa_y19GtiHMSQ-1
X-Mimecast-MFC-AGG-ID: CLVhcWeDPJa_y19GtiHMSQ_1746785388
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so1160981f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746785387; x=1747390187;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQ0ByGRVIs3Uu5drgiGclKQSySRqiRbl9YdSGEBm5MI=;
 b=OffAf2YDwJcj4fDOhmn2JBJc3G8oPyEL3d04tfxRrw1zS53UIJDdetUJ4gBOpepZoh
 T7jP/faeI0pr+12Q07KmS0D31N5l9kBuXG+toelmaBtUOODVlRC4vwlQOms4L8UrF8+y
 YojJa12RiwELW+rh95Q3fbb1CTLG+CbZRVf3X0x1U3BrabxnN/AMmRxG+8D0ZcoM8Hci
 +XTT3Oh+Qgmi7gv6NgP+oWuW2RRCE6Pux9jOZgO8cckUfZbRX8RgJGMWcRhjtuIzOyWa
 nEbHf2hxG9QMJoS+N3qCrsstToJFHCLKjX+bx+NhaXhHwFnk3LUJFiC9g3vvPowDrTlj
 fIkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4m6zuFmpKBGbuwu4wsgWlUF8X+lmHUKF7V1SxQHKvK0KiokPYgOhsX7ywrDQM0em58ApKItDFJzTn@nongnu.org
X-Gm-Message-State: AOJu0YxjT29jnGFI6ilLYbBPZx9l4k5G+sgtSnts8gTP0ncO9yZTMHVU
 /kKAZLq65QUtfo6oVt3CaL7KcmNtlmSLfDv1m/Hjp8nfUYVIMozOmp/uIASwc52ZMqKqjdFHD+5
 4SV+7Hlz6CixJWX0bfHae1E7EG5Gl3tOCmPXaRrLg+QzqChfXRHZM
X-Gm-Gg: ASbGnctjYMB8EZ0iVFJvJaPezlL28OonRdBSMp5kd7Nl87HmxXtcLAsvGWrc8R9/h3j
 jyzYFdBZul1v9UaA/fBFSJKUuPfKxKMKQGmW7CnH1ZJg5ujbwidRw6MBY0zDWej9dQSikXr/sJ7
 0z+fMztdJVdaL9vC1edlag3dp4yOYQMqxUnczxKcBTlLZFaaFrVysCjPOuqUIat79sIJ8Pw4Vlg
 aEIV7E0U1QOOIvrXWgoTIpVao1Da8Jleims8+KQSIZgfhq73xE7qcsouXvOWmw2VcdgkUqQNx0z
 gVe2Mc/pDhEOspJQmsKCraAvNo022aBetBqxE2SmgEO5B5fa73UmOC8=
X-Received: by 2002:a5d:64ad:0:b0:3a0:b4f1:8bda with SMTP id
 ffacd0b85a97d-3a1f643ac2fmr2203650f8f.1.1746785387485; 
 Fri, 09 May 2025 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG31eVAytydBLjtyK25YqW/kHa6vXq2+PQ8SOmZiBUfoSt52Yja2LyG6KBaM9tIqIJ9hKRXvQ==
X-Received: by 2002:a5d:64ad:0:b0:3a0:b4f1:8bda with SMTP id
 ffacd0b85a97d-3a1f643ac2fmr2203614f8f.1.1746785386986; 
 Fri, 09 May 2025 03:09:46 -0700 (PDT)
Received: from ?IPV6:2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f?
 ([2a01:cb1d:89d7:6e00:da58:edc2:d8ef:4b9f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2f4sm2748924f8f.78.2025.05.09.03.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 03:09:46 -0700 (PDT)
Message-ID: <c2e7ed7c-11f9-46c1-89dc-d8e179b16c04@redhat.com>
Date: Fri, 9 May 2025 12:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] vfio: add region info cache
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
 <20250507152020.1254632-12-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250507152020.1254632-12-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/25 17:20, John Levon wrote:
> Instead of requesting region information on demand with
> VFIO_DEVICE_GET_REGION_INFO, maintain a cache: this will become
> necessary for performance for vfio-user, where this call becomes a
> message over the control socket, so is of higher overhead than the
> traditional path.
> 
> We will also need it to generalize region accesses, as that means we
> can't use ->config_offset for configuration space accesses, but must
> look up the region offset (if relevant) each time.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/ccw.c                 |  5 -----
>   hw/vfio/device.c              | 25 +++++++++++++++++++++----
>   hw/vfio/igd.c                 | 10 +++++-----
>   hw/vfio/pci.c                 |  6 +++---
>   hw/vfio/region.c              |  2 +-
>   6 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 7e1e81e76b..4fff3dcee3 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -83,6 +83,7 @@ typedef struct VFIODevice {
>       IOMMUFDBackend *iommufd;
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
> +    struct vfio_region_info **reginfo;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index ab3fabf991..cea9d6e005 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -504,7 +504,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>   
>       vcdev->io_region_offset = info->offset;
>       vcdev->io_region = g_malloc0(info->size);
> -    g_free(info);
>   
>       /* check for the optional async command region */
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -517,7 +516,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->async_cmd_region_offset = info->offset;
>           vcdev->async_cmd_region = g_malloc0(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -530,7 +528,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->schib_region_offset = info->offset;
>           vcdev->schib_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       ret = vfio_device_get_region_info_type(vdev, VFIO_REGION_TYPE_CCW,
> @@ -544,7 +541,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>           }
>           vcdev->crw_region_offset = info->offset;
>           vcdev->crw_region = g_malloc(info->size);
> -        g_free(info);
>       }
>   
>       return true;
> @@ -554,7 +550,6 @@ out_err:
>       g_free(vcdev->schib_region);
>       g_free(vcdev->async_cmd_region);
>       g_free(vcdev->io_region);
> -    g_free(info);
>       return false;
>   }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 40a196bfb9..77b0675abe 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -202,6 +202,12 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>       size_t argsz = sizeof(struct vfio_region_info);
>       int ret;
>   
> +    /* check cache */
> +    if (vbasedev->reginfo[index] != NULL) {
> +        *info = vbasedev->reginfo[index];
> +        return 0;
> +    }
> +
>       *info = g_malloc0(argsz);
>   
>       (*info)->index = index;
> @@ -222,6 +228,9 @@ retry:
>           goto retry;
>       }
>   
> +    /* fill cache */
> +    vbasedev->reginfo[index] = *info;
> +
>       return 0;
>   }
>   
> @@ -240,7 +249,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>           hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
>           if (!hdr) {
> -            g_free(*info);
>               continue;
>           }
>   
> @@ -252,8 +260,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>           if (cap_type->type == type && cap_type->subtype == subtype) {
>               return 0;
>           }
> -
> -        g_free(*info);
>       }
>   
>       *info = NULL;
> @@ -262,7 +268,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       bool ret = false;
>   
>       if (!vfio_device_get_region_info(vbasedev, region, &info)) {
> @@ -435,10 +441,21 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>   
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +
> +    vbasedev->reginfo = g_new0(struct vfio_region_info *,
> +                               vbasedev->num_regions);
>   }
>   
>   void vfio_device_unprepare(VFIODevice *vbasedev)
>   {
> +    int i;
> +
> +    for (i = 0; i < vbasedev->num_regions; i++) {
> +        g_free(vbasedev->reginfo[i]);
> +    }
> +    g_free(vbasedev->reginfo);
> +    vbasedev->reginfo = NULL;
> +
>       QLIST_REMOVE(vbasedev, container_next);
>       QLIST_REMOVE(vbasedev, global_next);
>       vbasedev->bcontainer = NULL;
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 3ee1a73b57..e7952d15a0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -349,8 +349,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
>   
>   static bool vfio_pci_igd_setup_lpc_bridge(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *host = NULL;
> -    g_autofree struct vfio_region_info *lpc = NULL;
> +    struct vfio_region_info *host = NULL;
> +    struct vfio_region_info *lpc = NULL;
>       PCIDevice *lpc_bridge;
>       int ret;
>   
> @@ -510,7 +510,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>   
>   static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *opregion = NULL;
>       int ret, gen;
>       uint64_t gms_size = 0;
>       uint64_t *bdsm_size;
> @@ -551,7 +551,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>            * - OpRegion
>            * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>            */
> -        g_autofree struct vfio_region_info *rom = NULL;
> +        struct vfio_region_info *rom = NULL;
>   
>           legacy_mode_enabled = true;
>           info_report("IGD legacy mode enabled, "
> @@ -681,7 +681,7 @@ error:
>    */
>   static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *opregion = NULL;
>       int gen;
>   
>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index da2ffc9bf3..9136cf52c8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -883,8 +883,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> -    g_autofree struct vfio_region_info *reg_info = NULL;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> +    struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> @@ -2710,7 +2710,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
> @@ -2775,7 +2775,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       struct vfio_irq_info irq_info;
>       int i, ret = -1;
>   
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 04bf9eb098..ef2630cac3 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -182,7 +182,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, index, &info);



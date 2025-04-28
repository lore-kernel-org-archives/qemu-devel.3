Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8749DC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QaM-0005kq-V9; Mon, 28 Apr 2025 11:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9QaK-0005hs-51
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9QaH-0002bv-Qo
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745854791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/gTNMXaHWMrAazHdNLO/mQhMYGW8pd5Kw3U9bA6vDq8=;
 b=XZHIASOBZP7J7BUZ5rg4IVR9RSwiyr5L0p3IY1c/Jrfz6JwMI1EMXd0zB233+UzpAzJD4P
 IzVDrFvZrf4+IHe4bAkPzyAwKiF7eocSqfIEOHfb0vHZSy/k/ysfSHXkujhRoeKx6yRbod
 SbzFDGJ7zW+VhQTDgiYAlFIs2tjkwkc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-qOpwTuf3OSqan2gX04qI8Q-1; Mon, 28 Apr 2025 11:39:50 -0400
X-MC-Unique: qOpwTuf3OSqan2gX04qI8Q-1
X-Mimecast-MFC-AGG-ID: qOpwTuf3OSqan2gX04qI8Q_1745854789
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so1660831f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745854789; x=1746459589;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gTNMXaHWMrAazHdNLO/mQhMYGW8pd5Kw3U9bA6vDq8=;
 b=ebXOLLGa5R8TZsU2OWdzMG5/S4VrpsiGnMiGkQOKnupJyDNPUe3B7BQp/S/IyvTHjY
 Z3GboOR7w1h7MVhY1g7/Rtp/ibj47kvYnd54vxh/s5g/N08VXfi0mWFv0OsRxDm7PD8H
 cVPxNFUupLcYf/lzQP62mQzTWVVphVsycWc5nAqKoPAyNpHAX3rYagkTw4kXMTzTjB9O
 wPBdaOEbP1735iD9V4MucV57t/M1jIV7vhFZDe6Iks2q0Q1KlSEQIFmNiwHR9jQQkZHd
 jm836pXrTonTz+vSneeorClbVrawdKE2aMOsF+fTo1tuhBB32Hu3hgmIyPKJpaprshCZ
 PAcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQLIIjdBpdsSLAwsGyK/8Dg9ZzcJXjnrg7ekioyW3IxVBz2B2ds9eMc3WEx3yCOe5kZAxbsw/2yo3X@nongnu.org
X-Gm-Message-State: AOJu0YzmLCDqrAcxqMAMyH91GCoFdwIaftghBQdJLKYsj/8khRQsybhv
 2usvHNsOJ+NtDc+X0KHcyWAS8mztUcnbPrrN1i7n5V7m1s5Br6YM4PyrfwW08DyrOGyc35FTVRJ
 Chk0OnXW8crJnrffw7tez5Uv7xd4xyUJhBSSmFQA+B1G0vQRn7Xhd
X-Gm-Gg: ASbGncveYgwSmuu23mj3TW7AKducRwVhDuOLhA3fk4Vw3TrE+7Rrh2GVY+LYQgKx/4A
 sm7iebrymrxK+xCUJ8QHn3KDWz5bt4dBB0zen2WYITmX1BpRRUkjVchooDHNf0u1yNLLHH41y+C
 XrFjoMguUq4ltMrKujYrsi8gpSS9RHEPec4LdxnK7RuYxg/KJy8CRcmtt/QLR5VxEQ5xzCAhhiJ
 0vOBBalRLU+PB7YR6k1bbxu4QlidW5V9CQ5IfogHhuqbjZB9xClbSbIK1WEHK/yYI2v/fsnyz90
 sTikDA4effRS7RqTCxA09JcIHyg0zoxtDRHxsnuYHYhzA0gh1Q==
X-Received: by 2002:a5d:64c5:0:b0:39c:1ef6:4364 with SMTP id
 ffacd0b85a97d-3a074e23345mr10072008f8f.14.1745854788860; 
 Mon, 28 Apr 2025 08:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lG/89UMygGWxpi5I31po224jwWhBsezo4RApLIrI3aiGnI96EkCMdaGCcwlGCjLCt+EJqQ==
X-Received: by 2002:a5d:64c5:0:b0:39c:1ef6:4364 with SMTP id
 ffacd0b85a97d-3a074e23345mr10071982f8f.14.1745854788414; 
 Mon, 28 Apr 2025 08:39:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4698csm11531429f8f.62.2025.04.28.08.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:39:47 -0700 (PDT)
Message-ID: <fd6fa8cc-8e11-47a5-881a-1f0205aac742@redhat.com>
Date: Mon, 28 Apr 2025 17:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] vfio: add region info cache
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-13-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On 4/9/25 15:48, John Levon wrote:
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
> ---
>   hw/vfio/ccw.c                 |  5 -----
>   hw/vfio/container.c           | 10 ++++++++++
>   hw/vfio/device.c              | 31 +++++++++++++++++++++++++++----
>   hw/vfio/igd.c                 |  8 ++++----
>   hw/vfio/pci.c                 |  6 +++---
>   hw/vfio/region.c              |  2 +-
>   include/hw/vfio/vfio-device.h |  1 +
>   7 files changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index dac8769925..14dee7cd19 100644
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
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 37b1217fd8..61333d7fc4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -857,6 +857,16 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>   
>   static void vfio_device_put(VFIODevice *vbasedev)
>   {
> +    if (vbasedev->reginfo != NULL) {
> +        int i;
> +
> +        for (i = 0; i < vbasedev->num_regions; i++) {
> +            g_free(vbasedev->reginfo[i]);
> +        }
> +        g_free(vbasedev->reginfo);
> +        vbasedev->reginfo = NULL;
> +    }
> +

Can we have a vfio_device_unprepare() routine for symmetry with
routine vfio_device_get_all_region_info() ? Naming should be
improved too.

>       if (!vbasedev->group) {>           return;
>       }
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 2966171118..102fa5a9b4 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -205,6 +205,17 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>   {
>       size_t argsz = sizeof(struct vfio_region_info);
>   
> +    /* create region info cache */
> +    if (vbasedev->reginfo == NULL) {
> +        vbasedev->reginfo = g_new0(struct vfio_region_info *,
> +                                   vbasedev->num_regions);
> +    }

I guess we could allocate ->reginfo[] array sooner in the VFIODevice
object life cycle. Since we lack a realize handler, may be in
vfio_device_prepare() ?


> +    /* check cache */
> +    if (vbasedev->reginfo[index] != NULL) {
> +        *info = vbasedev->reginfo[index];
> +        return 0;
> +    }
> +
>       *info = g_malloc0(argsz);
>   
>       (*info)->index = index;
> @@ -224,6 +235,9 @@ retry:
>           goto retry;
>       }
>   
> +    /* fill cache */
> +    vbasedev->reginfo[index] = *info;
> +
>       return 0;
>   }
>   
> @@ -242,7 +256,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>           hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
>           if (!hdr) {
> -            g_free(*info);
>               continue;
>           }
>   
> @@ -254,8 +267,6 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>           if (cap_type->type == type && cap_type->subtype == subtype) {
>               return 0;
>           }
> -
> -        g_free(*info);
>       }
>   
>       *info = NULL;
> @@ -264,7 +275,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   
>   bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   {
> -    g_autofree struct vfio_region_info *info = NULL;
> +    struct vfio_region_info *info = NULL;
>       bool ret = false;
>   
>       if (!vfio_device_get_region_info(vbasedev, region, &info)) {
> @@ -427,6 +438,16 @@ void vfio_device_detach(VFIODevice *vbasedev)
>       VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
>   }
>   
> +static void vfio_device_get_all_region_info(VFIODevice *vbasedev)
> +{
> +    struct vfio_region_info *info;
> +    int i;
> +
> +    for (i = 0; i < vbasedev->num_regions; i++) {
> +        vfio_device_get_region_info(vbasedev, i, &info);
> +    }
> +}
> +

if the vfio_device_get_all_region_info() routine queries *all* region
infos to fill the ->reginfo[] cache array, why do we also need the
lazy cache filling method in vfio_device_get_region_info() ? This looks
redundant to me. I would rather have vfio_device_get_region_info()
operate on the cache only.


Thanks,

C.


>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                            struct vfio_device_info *info)
>   {
> @@ -439,4 +460,6 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>   
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +
> +    vfio_device_get_all_region_info(vbasedev);
>   }
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e1cba16399..d70da1ce38 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -198,7 +198,7 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>   
>   static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
>   {
> -    g_autofree struct vfio_region_info *opregion = NULL;
> +    struct vfio_region_info *opregion = NULL;
>       int ret;
>   
>       /* Hotplugging is not supported for opregion access */
> @@ -361,8 +361,8 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
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
> @@ -526,7 +526,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>            * - OpRegion
>            * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>            */
> -        g_autofree struct vfio_region_info *rom = NULL;
> +        struct vfio_region_info *rom = NULL;
>   
>           legacy_mode_enabled = true;
>           info_report("IGD legacy mode enabled, "
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c3842d2f8d..b40d5abdfd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -882,8 +882,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
> -    g_autofree struct vfio_region_info *reg_info = NULL;
>       VFIODevice *vbasedev = &vdev->vbasedev;
> +    struct vfio_region_info *reg_info = NULL;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> @@ -2721,7 +2721,7 @@ static VFIODeviceOps vfio_pci_ops = {
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    g_autofree struct vfio_region_info *reg_info = NULL;
> +    struct vfio_region_info *reg_info = NULL;
>       int ret;
>   
>       ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
> @@ -2786,7 +2786,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
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
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 9522a09c48..967b07cd89 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -81,6 +81,7 @@ typedef struct VFIODevice {
>       IOMMUFDBackend *iommufd;
>       VFIOIOASHwpt *hwpt;
>       QLIST_ENTRY(VFIODevice) hwpt_next;
> +    struct vfio_region_info **reginfo;
>   } VFIODevice;
>   
>   struct VFIODeviceOps {



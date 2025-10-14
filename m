Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58431CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kXL-0005X1-HW; Tue, 14 Oct 2025 15:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kXF-0005W3-LC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kXC-0007NM-6o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vvMwMAmyhRUrtehTUF0szqO3/q+p+aYypOFhNDW0YJs=;
 b=UwhwkunVmWwseOZ9KEyZyKsmg/zUbqVE8jsNoAeKpsK/Ej6uZ9xpZeY9dwdBu2dEYSyizs
 MArMBglWJ2JzDUqQA98ATFpoG/2z6LJ/oN4MyDc/6otKjtN+nsNLaFb5sUoCMKxgA55jev
 NiORqQkmXImdGBiFN4mlWftFdbOzD0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-TaKQEC9lMqaLsu2ERgI69g-1; Tue, 14 Oct 2025 15:18:02 -0400
X-MC-Unique: TaKQEC9lMqaLsu2ERgI69g-1
X-Mimecast-MFC-AGG-ID: TaKQEC9lMqaLsu2ERgI69g_1760469481
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e509374dcso25462895e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469481; x=1761074281;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvMwMAmyhRUrtehTUF0szqO3/q+p+aYypOFhNDW0YJs=;
 b=N9VrsD5rq5By/GqI+760Sr8yoNXVazE2B9e841TY7t5cMxkbJ7gS0u8yEo/+kA1bj6
 C/xMspIF4rFfOkSGCef6b5E37CYMdC9VmcV491gaDOAEjE1Vto/n1eHXoleWwtYaCqEl
 zzW+8tCpzm2TzWF/0KLlTlTO5aQUUkLAPjzDwCfXQdBR4oaH/QArKbl9QtMPIj+vt8jb
 TV4agu8gKsoqYMZhaJfLZGCRKvvP6CrBUq/oCgmAHD/CdV3Fvm6W25lWia2sg+Vcip3M
 aPS1UFhaLXYU6TRmyPFRrulqTowa34ggoFbLQl88K2F7OmXZ/qlqa1Tg4fYS7zuIChUr
 Apng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqWzRCtrDCcikybD9TDjyGGKuHCaMnfc+Jh6lTW2bxqSkhO0ltI5oVe08h4gxOLryPEbrGY3nfuba@nongnu.org
X-Gm-Message-State: AOJu0Yw9fSDKJKlDaWBA9OcL3bOYXidF4W8OriN9tZMq9lMYLGqVXB6K
 jQaod/VHmsVIZkZyrhrQZ64Q87CUEX3unHjzGsNvU+hhCd+zGcazwFyDU4xkQnC4pF5CwSNtqMd
 2EpEjxaBfRS8PquPY/JR6DP+psMLPxmEqdCMpV7rL13xquPsBdhE7DKY3
X-Gm-Gg: ASbGncs6itccmhqBU9vTPlefbo4KerxpJF9Vx0kJS7aGScF9MA49M/0703NmHMq7q0k
 yrUFiIMtj5pVBVxFOoSn+sZci5QkqY5Ed6isWw67eXM//X7pRPIgMVVIOev4NBBIS9nq0xg+Ps+
 Az+FL3myMXvYMaLcpE0eFyn31MxsrxQdMflqThKrKCy5Hcziih/L30mI44TzznHWXC6boxIQB9Q
 jer519R+9DdlFOLn5fKcLM6d7esyRKunNUg4A8R863PxrUCGXKbEJ1VNkwManoufaOycXJGoXvK
 3RITfLrDdz5+fTIpK2osaDnMgL1GUHlu/McXUi0gGagY1o+ynK/s2l/tpR7zqkyFGet6DQwVju4
 F+cE=
X-Received: by 2002:a05:600c:1f8e:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-46fbbeb30a2mr90594125e9.39.1760469481004; 
 Tue, 14 Oct 2025 12:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk1F5tgxsBpOKnSPu3wNLL9gO6D6y9/QvSlOThTE8YqBxthqB38W2u6UDufG23sI5K+5bA6g==
X-Received: by 2002:a05:600c:1f8e:b0:46f:b42e:e392 with SMTP id
 5b1f17b1804b1-46fbbeb30a2mr90594005e9.39.1760469480592; 
 Tue, 14 Oct 2025 12:18:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fc155143fsm209339275e9.11.2025.10.14.12.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:17:59 -0700 (PDT)
Message-ID: <06010021-2170-44e0-a186-6c69a075da49@redhat.com>
Date: Tue, 14 Oct 2025 21:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: rename field to "num_initial_regions"
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, qemu-s390x@nongnu.org
References: <20251014151227.2298892-1-john.levon@nutanix.com>
 <20251014151227.2298892-2-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251014151227.2298892-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/14/25 17:12, John Levon wrote:
> We set VFIODevice::num_regions at initialization time, and do not
> otherwise refresh it. As it is valid in theory for a VFIO device to
> later increase the number of supported regions, rename the field to
> "num_initial_regions" to better reflect its semantics.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h |  2 +-
>   hw/vfio-user/device.c         |  2 +-
>   hw/vfio/ccw.c                 |  4 ++--
>   hw/vfio/device.c              | 12 ++++++------
>   hw/vfio/iommufd.c             |  3 ++-
>   hw/vfio/pci.c                 |  4 ++--
>   6 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 7e9aed6d3c..0fe6c60ba2 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -74,7 +74,7 @@ typedef struct VFIODevice {
>       VFIODeviceOps *ops;
>       VFIODeviceIOOps *io_ops;
>       unsigned int num_irqs;
> -    unsigned int num_regions;
> +    unsigned int num_initial_regions;
>       unsigned int flags;
>       VFIOMigration *migration;
>       Error *migration_blocker;
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 0609a7dc25..64ef35b320 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -134,7 +134,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
>       VFIOUserFDs fds = { 0, 1, fd};
>       int ret;
>   
> -    if (info->index > vbasedev->num_regions) {
> +    if (info->index > vbasedev->num_initial_regions) {
>           return -EINVAL;
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9560b8d851..4d9588e7aa 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -484,9 +484,9 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>        * We always expect at least the I/O region to be present. We also
>        * may have a variable number of regions governed by capabilities.
>        */
> -    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
> +    if (vdev->num_initial_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
>           error_setg(errp, "vfio: too few regions (%u), expected at least %u",
> -                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
> +                   vdev->num_initial_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
>           return false;
>       }
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 64f8750389..52079f4cf5 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -257,7 +257,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
>   {
>       int i;
>   
> -    for (i = 0; i < vbasedev->num_regions; i++) {
> +    for (i = 0; i < vbasedev->num_initial_regions; i++) {
>           struct vfio_info_cap_header *hdr;
>           struct vfio_region_info_cap_type *cap_type;
>   
> @@ -466,7 +466,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>       int i;
>   
>       vbasedev->num_irqs = info->num_irqs;
> -    vbasedev->num_regions = info->num_regions;
> +    vbasedev->num_initial_regions = info->num_regions;
>       vbasedev->flags = info->flags;
>       vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
>   
> @@ -476,10 +476,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
>       vbasedev->reginfo = g_new0(struct vfio_region_info *,
> -                               vbasedev->num_regions);
> +                               vbasedev->num_initial_regions);
>       if (vbasedev->use_region_fds) {
> -        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> -        for (i = 0; i < vbasedev->num_regions; i++) {
> +        vbasedev->region_fds = g_new0(int, vbasedev->num_initial_regions);
> +        for (i = 0; i < vbasedev->num_initial_regions; i++) {
>               vbasedev->region_fds[i] = -1;
>           }
>       }
> @@ -489,7 +489,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>   {
>       int i;
>   
> -    for (i = 0; i < vbasedev->num_regions; i++) {
> +    for (i = 0; i < vbasedev->num_initial_regions; i++) {
>           g_free(vbasedev->reginfo[i]);
>           if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
>               close(vbasedev->region_fds[i]);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 68470d552e..10fc065d20 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -663,7 +663,8 @@ found_container:
>       vfio_iommufd_cpr_register_device(vbasedev);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
> -                                   vbasedev->num_regions, vbasedev->flags);
> +                                   vbasedev->num_initial_regions,
> +                                   vbasedev->flags);
>       return true;
>   
>   err_listener_register:
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 06b06afc2b..8b8bc5a421 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2975,9 +2975,9 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
> +    if (vbasedev->num_initial_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
>           error_setg(errp, "unexpected number of io regions %u",
> -                   vbasedev->num_regions);
> +                   vbasedev->num_initial_regions);
>           return false;
>       }
>   



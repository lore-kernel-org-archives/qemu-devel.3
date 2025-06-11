Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FD7C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPFpR-0003ps-Tr; Wed, 11 Jun 2025 03:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFpQ-0003pf-2L
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPFpM-0001ns-VH
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 03:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749626691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C5UELCF2wa/s8jBIKgz25oUcJxn88rz5B14tFSDSxYM=;
 b=IvRbIqlSgNtNHNiPtGzOG+4uSwCnbAvPtUamAu+BjRb5eICbt+8nDKf2NnA70xyq5kMH2a
 +uMinO9y2oMT381N2r5A9Vw2wQy/GKEWwV3RtCV1EYn+P7swzZ3I00Cb5XEmWG1Dv7m935
 mc5Ih6qmui9S5MbknbNhGEKsZ9P52dw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Eez2lK7OOQWhpR5L1YZ8RA-1; Wed, 11 Jun 2025 03:24:50 -0400
X-MC-Unique: Eez2lK7OOQWhpR5L1YZ8RA-1
X-Mimecast-MFC-AGG-ID: Eez2lK7OOQWhpR5L1YZ8RA_1749626689
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so32329955e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 00:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749626689; x=1750231489;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5UELCF2wa/s8jBIKgz25oUcJxn88rz5B14tFSDSxYM=;
 b=co2XpDcP1RAV936uhH0Dex+CIq+MM2GkwXOL5QOjZLRgE2uYZvsyHwnBsVm+NVo6aR
 HCIgWR6Q7wKv1yp5aFbKl81nOdNPHAPJ0IotPpDvqicrpQKNJ14qQk6l50l+W9BoCNmP
 YHzs7NcwqDpKV2byOxZ1zHh0UA0zN3axdWe/9UtPCv4V2WPbau7n0xnbAHcH+yJqOl+W
 JM8DXkzXsZPGM+BXnm+RRxHr3E735sPo0suXasbEC5VxiapQl86XONYNNslSZqTCCyhQ
 Qjc6TJB1uRpZaF3CZ6cwpATT6qZpx8TPR8yxOdxZjibjRTmd83vWob9USiNsLFTjzhmW
 /wbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1i3w1AscLvwlW9amBf7vzKSJgT/7bY37Ei+fMFTNO2bTgV+cDi0/skHlVkVw6rBtjBr+NK2TczuG3@nongnu.org
X-Gm-Message-State: AOJu0YymGG6pb1f2TBWbd+jFJoueYS0CMP++nimvJU1hLftUA/eIr4co
 NBUvwp/XKfkiSgodyz12tqJzHCBZX+6xzDWnAdDCNEc7lFH80Jjiv2c8EemkjIcKI62H5EzV9V7
 7uoh6SAA3tm4rgT+ONmH4jEwzxKog3epnAp58hdd4yFU0zsDkhdc8BsuF
X-Gm-Gg: ASbGncuExYMva3aA8NpgLdI6Vn1Tx+qj2QAn1GoclVdXPtnoEQG//XSDKTte+JuYT4S
 hxgyAuC2Vj2BU2G+bFmEt/vp7JXwfihUnLTcQJ0qAqNESVxld/QQLnsmsm1gIparI5xZY5QEzP6
 qYFFz9j+z3mQeXAoaw7LaTsFuQAfoRaPUvBV9pkwruBWo7JgZiUYhL6FnvpPs3STLhyifq8qVtX
 GH97q46a1uwqn+Mdpy7qz9SGGvBWRYhQ5kVItbMD9f7ZGNUUID5hiayDg9s8Qpm6Rw9RNTO5+kQ
 2DRwosOYcQzY82Byrp2efYNEps7PrgDDSIqyETX+Qy+lw6SmohRtg4HYHnTO
X-Received: by 2002:a05:600d:f:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-453253e40c0mr10743155e9.6.1749626689206; 
 Wed, 11 Jun 2025 00:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRTN+w0xB4+b0TNOoF2umoLWK7y0M3jAXzQ7bypS5TBd2iXxd5Zk329R01CGfyX84m443XOQ==
X-Received: by 2002:a05:600d:f:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-453253e40c0mr10742845e9.6.1749626688819; 
 Wed, 11 Jun 2025 00:24:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532513e93asm12482695e9.6.2025.06.11.00.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 00:24:47 -0700 (PDT)
Message-ID: <ee30689d-a881-49f5-8d70-735f0a84ee80@redhat.com>
Date: Wed, 11 Jun 2025 09:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/23] vfio: mark posted writes in region write
 callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-5-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250607001056.335310-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/7/25 02:10, John Levon wrote:
> For vfio-user, the region write implementation needs to know if the
> write is posted; add the necessary plumbing to support this.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>


Applied to vfio-next.

Thanks,

C.


> ---
>   include/hw/vfio/vfio-device.h | 4 ++--
>   include/hw/vfio/vfio-region.h | 1 +
>   hw/vfio/device.c              | 3 ++-
>   hw/vfio/pci.c                 | 5 ++++-
>   hw/vfio/region.c              | 3 ++-
>   5 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 5cb817fd6a..a23ef4ea13 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -207,10 +207,10 @@ struct VFIODeviceIOOps {
>        * @region_write
>        *
>        * Write @size bytes to the region @nr at offset @off from the buffer
> -     * @data.
> +     * @data; if @post, the write is posted.
>        */
>       int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
> -                        void *data);
> +                        void *data, bool post);
>   };
>   
>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
> index cbffb26962..ede6e0c8f9 100644
> --- a/include/hw/vfio/vfio-region.h
> +++ b/include/hw/vfio/vfio-region.h
> @@ -29,6 +29,7 @@ typedef struct VFIORegion {
>       uint32_t nr_mmaps;
>       VFIOMmap *mmaps;
>       uint8_t nr; /* cache the region number for debug */
> +    bool post_wr; /* writes can be posted */
>   } VFIORegion;
>   
>   
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 29a8d72deb..ad0bac9765 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -569,7 +569,8 @@ static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
>   }
>   
>   static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
> -                                       off_t off, uint32_t size, void *data)
> +                                       off_t off, uint32_t size, void *data,
> +                                       bool post)
>   {
>       struct vfio_region_info *info;
>       int ret;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 714d37e227..d68c1412d2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1015,7 +1015,7 @@ static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
>   {
>       return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
>                                                  VFIO_PCI_CONFIG_REGION_INDEX,
> -                                               offset, size, data);
> +                                               offset, size, data, false);
>   }
>   
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
> @@ -1819,6 +1819,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>       bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
>                                            ~PCI_BASE_ADDRESS_MEM_MASK);
>       bar->size = bar->region.size;
> +
> +    /* IO regions are sync, memory can be async */
> +    bar->region.post_wr = (bar->ioport == 0);
>   }
>   
>   static void vfio_bars_prepare(VFIOPCIDevice *vdev)
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index cb172f2136..f5b8e3cbf1 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -66,7 +66,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
>       }
>   
>       ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
> -                                         addr, size, &buf);
> +                                         addr, size, &buf, region->post_wr);
>       if (ret != size) {
>           error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
>                        ",%d) failed: %s",
> @@ -200,6 +200,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>       region->size = info->size;
>       region->fd_offset = info->offset;
>       region->nr = index;
> +    region->post_wr = false;
>   
>       if (region->size) {
>           region->mem = g_new0(MemoryRegion, 1);



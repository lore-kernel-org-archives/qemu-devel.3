Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BE8CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvAP-0002n7-SU; Mon, 17 Nov 2025 04:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vKvAN-0002mL-V3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vKvAL-0000bm-Pq
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763370292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lSAZhGka/ADHGXgsF/NPblgcCWDEU4pVAQbLZ/vDnS0=;
 b=TXLYZFvQ+3Q+3bZN9gOBzGnSYSQKsdrZMPkkpZ9Z/9iGjdSTRa7rcbFJPMWsAZdAf1fhlv
 k59U+ryugysfIyTG3dbob4+TRt7/RCn+SRR0kOBL+n9jCrYifpZ5ILPSsJiZEowSMZSnyD
 SxbeBb7hF7oYxiVx4Gc83ZJHfxL6d04=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-VTpnx933NBSE1JnFA2Q1ag-1; Mon, 17 Nov 2025 04:04:48 -0500
X-MC-Unique: VTpnx933NBSE1JnFA2Q1ag-1
X-Mimecast-MFC-AGG-ID: VTpnx933NBSE1JnFA2Q1ag_1763370287
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a60a23adso2279335e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763370287; x=1763975087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lSAZhGka/ADHGXgsF/NPblgcCWDEU4pVAQbLZ/vDnS0=;
 b=tAzNAVxcLukpHw0sNvP1D3ggPMBsvZ5jXbZNdXEh0PKKeYQWKGq5SOanHdAjDIKYUv
 wuCehdbqiz2rKC/XSdFysoGJSD1ZhO/hDT9kEJTLUq047N4aS15CfEgnbrB7pQL4JN5g
 cMQ3DHG8kYq+f/io4dQiwQcWpEsDxnNtHC/1vK9a9rFkwTHMvaHdAi6XxHHfe2kLGGwJ
 Aw0QwU/MMDU8poLqF/f2wbKzEhdUCJ9Zn5Gq0szhgAmeHNibdsvMRVEaYCsVTlg9X99t
 BCu0Z0hU2TLocp4oikhpiTH0XN6ThiLY6J98HmaLiOtfMRfgKY9wt4TobaJtuP2POVmP
 h8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763370287; x=1763975087;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSAZhGka/ADHGXgsF/NPblgcCWDEU4pVAQbLZ/vDnS0=;
 b=bOZvBUmyZtDCw/Sw8dSxZjNTw4I3CfxSkuN6MXUoYXLrE5LAloJHw2rzP/UaDdAEUs
 6UgyprSBa52BYyjSGSkv7o/YALlvmBaF+hVJiBAIhNSOFLktYeC56gq9vQL6yCc4PcbO
 Jyv/w2b1jHqinPWMp+/MZaA/aL3274wurQIfeF/1R9KfLwi+B/cp95naCok3l5Z705Pc
 /EnpEE+UfPBeSY8hAMllDM7VQkoSE3IonoenqtQrYx7zHYDUMRdcsVBs9CzG7W5Z05RY
 two0AeuETIeC9t5UmYIRQSTguVAX8+NjoG5APPxLrxD0ivWwfokxHD8wvA/wSX9GI4Ef
 cPww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBlHQuG1vKddIQSKO451Of8l6rh1B9jbiDabq12xklEgmnD7HKohb+laIEbamUgPyN2kzxGwTqDlWK@nongnu.org
X-Gm-Message-State: AOJu0YzjsYFVHqGm3ygnJtQaCOTfd3yUdd+PCiVQ7nuGpK1yzy+vEtD8
 MvV9i6PspNa67PEOkzVLMUZEFMo5WtsohPUqvtw2hoZVVi4hOsNunsXIZRTRt99rr5eMUZIetZW
 lV3wZNr744VOjVWfYfn5rgEx6X8HMhNsrzMLrtx3N1D+GeF5osN6Xvvtt
X-Gm-Gg: ASbGnctnXKovAANKN5Gg9ABVg0i9wS9+75YE7wa8F08dW0qGhJcStWlxHNFOt7iC8JP
 zKjDF8J0R+yLwf3nCVBRiJptU0p3hie0ziTcQFDitVOM2tJOM/Gs5NpbXvQeFqkdr1gYvh/bKO6
 tIDVdM5EcPShSGXWCyTzB/ILijqElLhWoBmVDDjzwfDlqsJayMLyuHYJkOy+q/S1LoJwUw8QZwl
 GFPL/byjuvjTVSe4rNyrweE7budPqlV3MZGXaYzRSdS0jCh8tJ5cPG3E3UQlCZZ0wAQ30SYTIPq
 JxiA1T4VE3UyK3rRY7c2z0tRzIYFCdZ2l8/J7mC5e109ziY99cgAfDRrFjWSsIRdsaUTUpbPPWM
 phligDfTIGMtjuuPpN9Qh1iCL50UAoyC4U9meBg==
X-Received: by 2002:a05:600c:3b23:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-4778fea0d32mr97799715e9.29.1763370287167; 
 Mon, 17 Nov 2025 01:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECFndihMrB5eDj0QKn/SMLHYwJJsyqUBKzrBgFbFj37eO+JKiGgdoDoozTkUJjzBZ9TSDzRw==
X-Received: by 2002:a05:600c:3b23:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-4778fea0d32mr97799345e9.29.1763370286672; 
 Mon, 17 Nov 2025 01:04:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae5bsm25027921f8f.8.2025.11.17.01.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:04:46 -0800 (PST)
Message-ID: <c719ac1b-6824-4952-b423-5e548fcb6f89@redhat.com>
Date: Mon, 17 Nov 2025 10:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and
 use it in virtio-gpu
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vivek,

On 11/9/25 06:33, Vivek Kasireddy wrote:
> The virtio-gpu driver running in the Guest VM can create Guest blob
> resources (by importing dmabufs) that are backed by System RAM. This
> is made possible by making use of memfd memory backend and udmabuf
> driver on the Host side. However, in order to create Guest blobs
> that are backed by vfio-pci device regions (which happens when
> virtio-gpu imports dmabufs from devices that have local memory such
> as dGPU VFs), we have to implement VFIO_DEVICE_FEATURE_DMA_BUF and
> leverage it in virtio-gpu.
> 
> So, while creating the blobs we use memory_region_is_ram_device() to
> figure out if the blob is backed by memfd or a vfio-pci device. If
> it is determined that the blob is backed by vfio-pci device region,
> instead of calling into udmabuf driver to create a dmabuf fd we would
> now call into vfio-pci driver to have a dmabuf fd created on the Host.
> 
> Changelog:
> v1 -> v2:
> - Drop the patch that uses res->blob_size instead of res->blob to
>    identify blob resources (Akihiko)
> - Remove the res->dmabuf_fd < 0 check while attaching backing to a
>    resource (Akihiko)
> - Remove cmd->cmd_hdr.type != VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB
>    check while attaching backing (Akihiko)
> - Improve vfio_get_region_index_from_mr() and add documentation (Cedric)
> - Remove rcu_read_lock/unlock around qemu_ram_block_from_host()
>    (Akihiko, Cedric)
> - Improve, document and rename vfio_device_create_dmabuf() to
>    vfio_device_create_dmabuf_fd() (Cedric)
> - Add a new helper to lookup VFIO device from memory region (Cedric)
> - Document vfio_device_get_region_info() (Cedric)
> - Ensure that info variable (in vfio_dmabuf_mmap()) is initialized
>    before use (Cedric)
> - Rename udmabuf files and helpers to dmabuf (Akihiko)
> - Remove the redundant check for virtio_gpu_have_udmabuf() in
>    virtio_gpu_init_dmabuf() (Akihiko)
> - Add a helper to check whether all the entries of a dmabuf belong
>    to a single memory region or not (Akihiko)
> 
> RFC -> v1:
> - Create the CPU mapping using vfio device fd if the dmabuf exporter
>    (vfio-pci) does not provide mmap() support (Akihiko)
> - Log a warning with LOG_GUEST_ERROR instead of warn_report() when
>    dmabuf cannot be created using Guest provided addresses (Akihiko)
> - Use address_space_translate() instead of gpa2hva() to obtain the
>    Host addresses (Akihiko)
> - Rearrange the patches and improve the commit messages (Akihiko)
> - Fix compilation error when VFIO is not enabled (Alex)
> - Add a new helper to obtain VFIO region index from memory region
> - Move vfio_device_create_dmabuf() to hw/vfio/device.c
> 
> Tested with an SRIOV enabled Intel dGPU (B60) by running Gnome Wayland
> (in the VM) and Qemu with the following (relevant) parameters:
> -device vfio-pci,host=0000:03:00.1
> -device virtio-vga,max_outputs=1,xres=1920,yres=1080,blob=true
> -display gtk,gl=on
> 
> Associated vfio-pci kernel driver series:
> https://lore.kernel.org/dri-devel/cover.1754311439.git.leon@kernel.org/
> Associated virtio-gpu kernel driver series (merged):
> https://lore.kernel.org/dri-devel/20241126031643.3490496-1-vivek.kasireddy@intel.com/
> 
> ---
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>

Please adjust Alex's email :

   Alex Williamson <alex@shazbot.org>

Thanks,

C.



> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> 
> Vivek Kasireddy (10):
>    virtio-gpu: Recreate the resource's dmabuf if new backing is attached
>    virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
>    vfio: Document vfio_device_get_region_info()
>    vfio/region: Add a helper to get region index from memory region
>    vfio/device: Add a helper to lookup VFIODevice from memory region
>    linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
>    vfio/device: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
>    virtio-gpu: Rename udmabuf files and helpers to dmabuf
>    virtio-gpu-dmabuf: Introduce qemu_iovec_same_memory_regions()
>    virtio-gpu-dmabuf: Create dmabuf for blobs associated with VFIO
>      devices
> 
>   hw/display/Kconfig                            |   5 +
>   hw/display/meson.build                        |   4 +-
>   ...abuf-stubs.c => virtio-gpu-dmabuf-stubs.c} |   4 +-
>   ...rtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} | 149 ++++++++++++++++--
>   hw/display/virtio-gpu.c                       |  34 +++-
>   hw/vfio/device.c                              |  52 ++++++
>   hw/vfio/region.c                              |  14 ++
>   include/hw/vfio/vfio-device.h                 |  46 ++++++
>   include/hw/virtio/virtio-gpu.h                |   6 +-
>   linux-headers/linux/vfio.h                    |  25 +++
>   10 files changed, 316 insertions(+), 23 deletions(-)
>   rename hw/display/{virtio-gpu-udmabuf-stubs.c => virtio-gpu-dmabuf-stubs.c} (79%)
>   rename hw/display/{virtio-gpu-udmabuf.c => virtio-gpu-dmabuf.c} (56%)
> 



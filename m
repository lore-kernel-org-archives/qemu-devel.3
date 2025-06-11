Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2CC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGiO-0002s3-VO; Wed, 11 Jun 2025 04:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPGiC-0002rX-8f
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPGi9-0002HL-Ul
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749630085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFLbNgPr14QB1K1rm2mgyESuYRoNSzRbZZSZ2DTQGgU=;
 b=a6Knwf3MhlzXOzLz5WSMlFXGxhFs1zF5XckXnhkpaT4RRmScGgQQLC+cK/Asj/0Y/eKhCt
 AFYOAG8TJncr7NBFeKR3cBC7MtDcgCZ7a6Pca92WmAcG8+/UrbPkUF/Cba+Jg50JTflrC6
 PExG+4x104ayV09HXK+rW+EPsFg1E5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-jdNbdqZ8O-2qGWQzfzj58A-1; Wed, 11 Jun 2025 04:21:23 -0400
X-MC-Unique: jdNbdqZ8O-2qGWQzfzj58A-1
X-Mimecast-MFC-AGG-ID: jdNbdqZ8O-2qGWQzfzj58A_1749630083
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4530623eb8fso25840715e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 01:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749630082; x=1750234882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFLbNgPr14QB1K1rm2mgyESuYRoNSzRbZZSZ2DTQGgU=;
 b=Yl/0Ne5d4UdKjNSFJ+p4x6CkuCW2KRJcjbxF1GCJVaK3d4cJoF9tuVY4ll/y/SbzU8
 Kzf/dMYekJw0N2A0LCbHQukTuHM8PRgTvDMn6rNk8nLhmKTr+msRtlddLZh88Q6x+kO7
 em82Rdy7rQzn3kj9jL3FHMRXglngT4jeORSMbPU3dPqwaD5UT93Xo4WXHdW2P+mQdTys
 2VjNegagkU7OD7U1ymq5WqkLak8qFMNWIpB0wdMZr8g1HQfMO4et34aC/1w4E8JtDxNJ
 VCwO1etbdw4U3V26b7lbdYgKVgEIfW83sJtYsWa0pUpOVJ5DbiBnvKvRyUs3469hgY+2
 wezA==
X-Gm-Message-State: AOJu0YwQ1fOC0MW/uTauS/vXIUUGziw48P3/Abqzm2pST/Wxx54RhdeM
 n5/r5+XKNopaIpt4HmuZDUBos/BSnH4DBKYiQT5aYRYsXBmG9Iag9OXa/rfcVWWd/zgmBkvKG4i
 sr13l4ZPLMd3QPDc3Roddy8Dcxk6/QY2eiWJr9vlTdBZtZi5xqZZzgj8n
X-Gm-Gg: ASbGncu/qP25/UErtfPXfyKNYft2nUsQH4Ae2kbkhcSbghrDyroM08+susa6tAOLViY
 7aIlO37vPQednA02PRO+pUKp+VeFkU56PHqWMdgD9gTo4mc/ReaQeUx3Xd2734M+BfHeAD9lZR1
 p8AGuvx5DeVxxWMojDN1X9LYHnNIgGQsiHPXTiaGu7KeXew+QOT6Cdc0dT1iESVNFGjeJ5sOHf6
 tMPlBJ1mgwmmsLhufJBwW/51hN/YXMN1f5TXAo/81NU9FcJHK/yxzMOKKLXAuYIS0RKr71pHvZw
 y6tqCKpYDXprALvQM7PhlnULXzCHrvjcO5ehnZqccFM=
X-Received: by 2002:a05:600c:621b:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4532487a7cdmr18628245e9.11.1749630082623; 
 Wed, 11 Jun 2025 01:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhIVYkeAK65AlKPTnhEhiY8fYbHRMkcdn3mW1c+u4/sf1tW1Vhr5diMqnNNL//dKyHjMNH3w==
X-Received: by 2002:a05:600c:621b:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-4532487a7cdmr18627895e9.11.1749630082154; 
 Wed, 11 Jun 2025 01:21:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532516b934sm13548635e9.15.2025.06.11.01.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 01:21:20 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:21:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, yuanminghao <yuanmh12@chinatelecom.cn>, "Michael
 S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vhost: Fix used memslot tracking when destroying a
 vhost device
Message-ID: <20250611102119.02f3ebfa@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250603111336.1858888-1-david@redhat.com>
References: <20250603111336.1858888-1-david@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue,  3 Jun 2025 13:13:36 +0200
David Hildenbrand <david@redhat.com> wrote:

> When we unplug a vhost device, we end up calling vhost_dev_cleanup()
> where we do a memory_listener_unregister().
> 
> This memory_listener_unregister() call will end up disconnecting the
> listener from the address space through listener_del_address_space().
> 
> In that process, we effectively communicate the removal of all memory
> regions from that listener, resulting in region_del() + commit()
> callbacks getting triggered.
> 
> So in case of vhost, we end up calling vhost_commit() with no remaining
> memory slots (0).
> 
> In vhost_commit() we end up overwriting the global variables
> used_memslots / used_shared_memslots, used for detecting the number
> of free memslots. With used_memslots / used_shared_memslots set to 0
> by vhost_commit() during device removal, we'll later assume that the
> other vhost devices still have plenty of memslots left when calling
> vhost_get_free_memslots().
> 
> Let's fix it by simply removing the global variables and depending
> only on the actual per-device count.
> 
> Easy to reproduce by adding two vhost-user devices to a VM and then
> hot-unplugging one of them.
> 
> While at it, detect unexpected underflows in vhost_get_free_memslots()
> and issue a warning.
> 
> Reported-by: yuanminghao <yuanmh12@chinatelecom.cn>
> Link: https://lore.kernel.org/qemu-devel/20241121060755.164310-1-yuanmh12@chinatelecom.cn/
> Fixes: 2ce68e4cf5be ("vhost: add vhost_has_free_slot() interface")
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> I assume the problem existed in some form when used_memslots was
> introduced. However, I did not check the old behavior of memory listener
> unregistration etc.
> 
> ---
>  hw/virtio/vhost.c | 37 ++++++++++---------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index fc43853704..c87861b31f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -47,12 +47,6 @@ static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>  static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>  static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>  
> -/* Memslots used by backends that support private memslots (without an fd). */
> -static unsigned int used_memslots;
> -
> -/* Memslots used by backends that only support shared memslots (with an fd). */
> -static unsigned int used_shared_memslots;
> -
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>  
> @@ -74,15 +68,15 @@ unsigned int vhost_get_free_memslots(void)
>  
>      QLIST_FOREACH(hdev, &vhost_devices, entry) {
>          unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -        unsigned int cur_free;
> +        unsigned int cur_free = r - hdev->mem->nregions;
>  
> -        if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
> -            hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
> -            cur_free = r - used_shared_memslots;
> +        if (unlikely(r < hdev->mem->nregions)) {
> +            warn_report_once("used (%u) vhost backend memory slots exceed"
> +                             " the device limit (%u).", hdev->mem->nregions, r);
> +            free = 0;
>          } else {
> -            cur_free = r - used_memslots;
> +            free = MIN(free, cur_free);
>          }
> -        free = MIN(free, cur_free);
>      }
>      return free;
>  }
> @@ -666,13 +660,6 @@ static void vhost_commit(MemoryListener *listener)
>      dev->mem = g_realloc(dev->mem, regions_size);
>      dev->mem->nregions = dev->n_mem_sections;
>  
> -    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> -        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> -        used_shared_memslots = dev->mem->nregions;
> -    } else {
> -        used_memslots = dev->mem->nregions;
> -    }
> -
>      for (i = 0; i < dev->n_mem_sections; i++) {
>          struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
>          struct MemoryRegionSection *mrs = dev->mem_sections + i;
> @@ -1619,15 +1606,11 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>  
>      /*
> -     * The listener we registered properly updated the corresponding counter.
> -     * So we can trust that these values are accurate.
> +     * The listener we registered properly setup the number of required
> +     * memslots in vhost_commit().
>       */
> -    if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
> -        hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
> -        used = used_shared_memslots;
> -    } else {
> -        used = used_memslots;
> -    }
> +    used = hdev->mem->nregions;
> +
>      /*
>       * We assume that all reserved memslots actually require a real memslot
>       * in our vhost backend. This might not be true, for example, if the



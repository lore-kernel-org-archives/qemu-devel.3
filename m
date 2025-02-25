Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167C3C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvDF-00028R-OM; Tue, 25 Feb 2025 08:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmvDB-00025t-4F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmvD7-0002Xq-Py
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740490975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5+jKuWNA/J8y9ks8bF3Mz2TEJqTYwy+giScBaxw7JM=;
 b=fIjv1poieDnQQ4+w2D0ORaJCuqBA2xAbRgeHWs/CzLcHyrxSF9uBvF6Rvpb+Ta3hNQpPmY
 Vs16qTwfEOlMw7DBjIUjgGFms9zfFLSYHjn6pbths6Z1/LEJcb3Vd/hJq0Fm/4LXW8E02+
 trcR/48PE4S6JtVzj7K1QiWino2fWcc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-Lx8P_OwwOlCE0xKNYpKKqA-1; Tue, 25 Feb 2025 08:42:54 -0500
X-MC-Unique: Lx8P_OwwOlCE0xKNYpKKqA-1
X-Mimecast-MFC-AGG-ID: Lx8P_OwwOlCE0xKNYpKKqA_1740490973
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ab4563323so3381665e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740490973; x=1741095773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5+jKuWNA/J8y9ks8bF3Mz2TEJqTYwy+giScBaxw7JM=;
 b=T9+BBD/C84edd7b5FmlZAXn+qUKOWlUItva2UUJjAVnOV/AzMd6AGHfNTqZQW06+27
 t59jRaK+vfW06SJsaolPe+W01NEdk11AQLMg8P1K5ghCUaDg27xAxJlPVNPb1qq1yqZ+
 ZpJjsdXbaru7xOvj447DJjKAd0Q9dEiRhLbAugaEZggWuO4clAzpd1Ub21EU7/Pu5UeC
 /zhySc8bSxwNPcSN1ZXmESsaF80siQ5Z/g64AIXySTVXhy1zSOl82YjlfrUrm+nWdHRt
 uhsU1xhHTLmRcUgqmIzkXhZ1k3FSjeJZtmCubSd4RAuUzqgfowhAgv5HQGegey51LU/2
 Fymw==
X-Gm-Message-State: AOJu0YwNSHYsjE4s67FmIuwOEFo+TT/opg0R9a7kSGz1csOR5Nkp/tTJ
 X7eiWwXmPxLu0p/iBjZ6kBZ2HnmKtLYnHiZwu0ZIInambcciXT8p+JsNCdnTSShh+R9bCc3GZnm
 yXQF6MpmjnKjeYoDASQyacetv2sfE+sqVO+PawVj0sNv9opzX/5F7
X-Gm-Gg: ASbGncvfSGBsb8esfRvs5AyEzR+aAKUZ2uPvwAAzhuDbszkBzsNfJHBTVo2eqqeCgKa
 BOPDF1NoM29HlTuoZfZGzvS5j8oKQwJIw7Dy1ujM+6GIpd5/FwdlH1wBM6ZXXdZn6D+ZTkwx/dS
 IKLP7tYL6cRt6g6T/a5HS/eqb68NnNKV7n7l4ECGBtGErdqn7UoXaMZjEpYL92VkLDQl1l53cIC
 tKFpW72FXaaB/K+BRF/5nd3hUQqQajIvKA3cAol+HZgmAG5I67WWLOUDCwqdsa6fuODGLTHuRX6
 k58eLLZLMmrSvduxe3TOzorwX7GX5ZlPXi75bvzZ5240Aj0l3l80p+9QXeZZ+BI=
X-Received: by 2002:a05:600c:a01:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-43ab0f65f98mr22865415e9.24.1740490973275; 
 Tue, 25 Feb 2025 05:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9l8gUR4pHvm+DROjn9GMcAEv52Mqd84Fm32XboCnYQu6ZG0q1eRWjFd0OUYQz2UlOBO6k6A==
X-Received: by 2002:a05:600c:a01:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-43ab0f65f98mr22865235e9.24.1740490972803; 
 Tue, 25 Feb 2025 05:42:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882db7sm2370886f8f.53.2025.02.25.05.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 05:42:52 -0800 (PST)
Date: Tue, 25 Feb 2025 14:42:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: yuanminghao <yuanmh12@chinatelecom.cn>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250225144250.7f5b7243@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241121060755.164310-1-yuanmh12@chinatelecom.cn>
References: <20241121060755.164310-1-yuanmh12@chinatelecom.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On Thu, 21 Nov 2024 14:07:55 +0800
yuanminghao <yuanmh12@chinatelecom.cn> wrote:

> The global used_memslots or used_shared_memslots is updated to 0 unexpectly

it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
It's likely a bug somewhere else.

Please describe a way to reproduce the issue.

> when a vhost device destroyed. This can occur during scenarios such as live
> detaching a vhost device or restarting a vhost-user net backend (e.g., OVS-DPDK):
>  #0  vhost_commit(listener) at hw/virtio/vhost.c:439
>  #1  listener_del_address_space(as, listener) at memory.c:2777
>  #2  memory_listener_unregister(listener) at memory.c:2823
>  #3  vhost_dev_cleanup(hdev) at hw/virtio/vhost.c:1406
>  #4  vhost_net_cleanup(net) at hw/net/vhost_net.c:402
>  #5  vhost_user_start(be, ncs, queues) at net/vhost-user.c:113
>  #6  net_vhost_user_event(opaque, event) at net/vhost-user.c:281
>  #7  tcp_chr_new_client(chr, sioc) at chardev/char-socket.c:924
>  #8  tcp_chr_accept(listener, cioc, opaque) at chardev/char-socket.c:961
> 
> So we skip the update of used_memslots and used_shared_memslots when destroying
> vhost devices, and it should work event if all vhost devices are removed.
> 
> Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
> ---
>  hw/virtio/vhost.c         | 14 +++++++++-----
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..2258a12066 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -666,11 +666,13 @@ static void vhost_commit(MemoryListener *listener)
>      dev->mem = g_realloc(dev->mem, regions_size);
>      dev->mem->nregions = dev->n_mem_sections;
>  
> -    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> -        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> -        used_shared_memslots = dev->mem->nregions;
> -    } else {
> -        used_memslots = dev->mem->nregions;
> +    if (!dev->listener_removing) {
> +        if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> +            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> +            used_shared_memslots = dev->mem->nregions;
> +        } else {
> +            used_memslots = dev->mem->nregions;
> +        }
>      }
>  
>      for (i = 0; i < dev->n_mem_sections; i++) {
> @@ -1668,7 +1670,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>      }
>      if (hdev->mem) {
>          /* those are only safe after successful init */
> +        hdev->listener_removing = true;
>          memory_listener_unregister(&hdev->memory_listener);
> +        hdev->listener_removing = false;
>          QLIST_REMOVE(hdev, entry);
>      }
>      migrate_del_blocker(&hdev->migration_blocker);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index a9469d50bc..037f85b642 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -133,6 +133,7 @@ struct vhost_dev {
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
>      const VhostDevConfigOps *config_ops;
> +    bool listener_removing;
>  };
>  
>  extern const VhostOps kernel_ops;



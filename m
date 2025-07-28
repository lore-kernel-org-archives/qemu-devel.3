Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80588C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRbr-0008P8-8W; Mon, 28 Jul 2025 13:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRbo-0008CM-Mf
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugRbm-0005Z0-H4
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753723553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PaZKqUMPwkzmTmwT+zgtrdL2Uug8KN9TkmKbSch4LQE=;
 b=VY+bxrwtB6qzHX5B0mhW1uL1dDS6wq76Im/Wj0IWCVDcNTbMy+ZiCcJqWB9kQnkMrqVBwV
 p9S2RKrD3LMmlz+L/p7tvV701OHmmqG+CErAq6kCNt0OXBQTjqg3L7Ljlty+/G2MuhI69n
 vEFHHkJQjH1olq67Ts1BcjoqoRFrKIM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-TRAuO21bOBe7oeqPqevWFg-1; Mon, 28 Jul 2025 13:25:52 -0400
X-MC-Unique: TRAuO21bOBe7oeqPqevWFg-1
X-Mimecast-MFC-AGG-ID: TRAuO21bOBe7oeqPqevWFg_1753723551
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so25132615e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753723551; x=1754328351;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaZKqUMPwkzmTmwT+zgtrdL2Uug8KN9TkmKbSch4LQE=;
 b=D/3n649pWW6vwetfV+KpgfQnwqyW9bEiGoTWmu8vdcNkPMdYJfEdvCq9E9A0s604mT
 NDSWi7Qt6BoWf6WQRpFt2qqPiWAhFaxumEJjL7+WdOGOel1UCffD/ovcZzcg4RhX8PR9
 T6VGhOeN3SxAQ0gwwgXN94j48lS9KyAGKq2GY6GNzQcNOSxms4t1lj6xAh3F1Xk5fvrh
 LKQZCulRIXoIB8euWz7ooO+Vh6LBVKCmUTvF3reDjf6ZzKFdF2D4ZX/2QuuynDahox8o
 ulX7iSh1jk/0pfQiF1Al6Guf21CQFA8TfZ3Jq6pEXly1FwF9D87xTzt7sjDjeQDs/RX4
 27cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP1JeYnKlQKa0nikTTNRkjRR1KQPlWdpMyenzK31XC+QX/++sOTPoJ2zf69vwkxH/n3da1Ad1BR6g7@nongnu.org
X-Gm-Message-State: AOJu0Yxn9XmdQU0kKgR+TEqzXUc2Df2rPOHMK4iexkwhGScRImB6GG5r
 xgZUxo+WAmDM6WENpKw3N23d1TxQ88ZkgxXpGovECn0h7jkRU9Ssjoir2HtqD5f+uchOJX/WDLO
 fZZMEnBDH4leHmIk7e71POi4EHqfREYzMLuhpwfh4+Ktw7jokfq/eVXfU
X-Gm-Gg: ASbGncuaDP43kn8AskATeAGfo3STC7//7E7syOtnEF+FdNtRu+SV4eoHu55VXCB63PW
 oJoZbyEOUoVKVPsJG4ZrutZP07e2RVSHEbkoC7kx1Lkfj/dsvnRjXOPd3rJNNsJA3zlrl+Bfa4e
 +dngTu+Ca6Syuy9lHfZUaHLUHRywnmnKd9F3KRAWJ8/rkDbg+2eqKg8lBjIAAZn3OikObZdjcs8
 dX/qBVtuWSS8jTBCi+bP9NDWn3OHnAR8GC9Ooz8SQ6LhQ5EvZuQyzKkKs7AI46EpfRS9Cwcb0OH
 2Sp4YgZNKNolSHx4wsICOOPbzdUCTU5jKQGQQyq0ulEVJh7LaRrLgtqbVSS9i98YSVYuCzrLx23
 xkg==
X-Received: by 2002:a05:6000:2f87:b0:3b7:8af8:b922 with SMTP id
 ffacd0b85a97d-3b78af8bfcbmr1871811f8f.34.1753723550788; 
 Mon, 28 Jul 2025 10:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqcIA+UAO5gbAkzS63jeiFb8oYXIo7cOHl9JmGcK5Ashf10OujWcbMBVMs5hMlAOVgBFCStA==
X-Received: by 2002:a05:6000:2f87:b0:3b7:8af8:b922 with SMTP id
 ffacd0b85a97d-3b78af8bfcbmr1871787f8f.34.1753723550291; 
 Mon, 28 Jul 2025 10:25:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac662b2sm103528055e9.26.2025.07.28.10.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 10:25:49 -0700 (PDT)
Message-ID: <50ae7843-c9e1-464a-a320-f7f087ab132f@redhat.com>
Date: Mon, 28 Jul 2025 19:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] vfio: fix sub-page bar after cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1752520890-223356-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/14/25 21:21, Steve Sistare wrote:
> Regions for sub-page BARs are normally mapped here, in response to the
> guest writing to PCI config space:
> 
>    vfio_pci_write_config()
>      pci_default_write_config()
>        pci_update_mappings()
>          memory_region_add_subregion()
>      vfio_sub_page_bar_update_mapping()
>        ... vfio_dma_map()
> 
> However, after CPR, the guest does not reconfigure the device and the
> code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
> vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
> address.
> 
> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.h |  1 +
>   hw/vfio/cpr.c |  2 ++
>   hw/vfio/pci.c | 14 ++++++++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 495fae7..cb1310d 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -228,6 +228,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
>   uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>   void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>   
> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>   bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
>   void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index af0f12a..384b56c 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>       PCIDevice *pdev = &vdev->pdev;
>       int nr_vectors;
>   
> +    vfio_sub_page_bar_update_mappings(vdev);
> +
>       if (msix_enabled(pdev)) {
>           vfio_pci_msix_set_notifiers(vdev);
>           nr_vectors = vdev->msix->entries;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28..9c616bd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2826,6 +2826,20 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>       return ret;
>   }
>   
> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +    int page_size = qemu_real_host_page_size();
> +    int bar;
> +
> +    for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
> +        PCIIORegion *r = &pdev->io_regions[bar];
> +        if (r->addr != PCI_BAR_UNMAPPED && r->size > 0 && r->size < page_size) {
> +            vfio_sub_page_bar_update_mapping(pdev, bar);
> +        }
> +    }
> +}
> +
>   static VFIODeviceOps vfio_pci_ops = {
>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,


Applied to vfio-next.

Thanks,

C.




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DCCD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSck-0003BN-2T; Tue, 03 Sep 2024 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slScj-0003Au-Fe
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1slScg-0005h6-1y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725366420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GF1AvVkZJ/yxNG73qXOy8cgo6Vg+HB1+fH5AqyVbd8E=;
 b=CTb8UDFprKvgxMkqlppSouxJctFYm2n2HrCDp4r8B+OxYZybM8lsKCP9cFaqogHvm5aTrp
 aVHyzaAtF5QI0RQ/KtvGoQDo0AzInjO36eHxLWSz/d3gM/5JRF8r81Wa3BqUHvmGOau2ts
 AqEqE6GUKMYR0RjqUgN9KrGIbbGrlkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-uX-Hp9XYPBOZAvoT56eB6g-1; Tue, 03 Sep 2024 06:19:20 -0400
X-MC-Unique: uX-Hp9XYPBOZAvoT56eB6g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c3a31ebcso1556269f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 03:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725358759; x=1725963559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF1AvVkZJ/yxNG73qXOy8cgo6Vg+HB1+fH5AqyVbd8E=;
 b=QX9x+jLZPFNYeR+3aj5Q5FyZ5O8qh8a2iGTHW8DUUzLlW/a6a7FegClviM9bg43/sA
 GwVCmt0f+e4gPk1Fq52sOzKCSJdcLEZdQAaLQvPmjKON5BrT/GiJngsfs5Ys033CzlUI
 R37fuFYSHXs/Inv2DU9cQK5ha0llSyTADo2c2vIPWdDznCkI8+qYIHAE4c/N3FPe72lJ
 GU7wO6NhRiOyoWkv5HEscrpM6KZrBUPxIfc4vGMOUDDgOFUImkrRhwbnKSbAFArytVwV
 S8twY1ulF2J3QgEyHXgjepCjV9ApjCI+bfWoDCUZMTfRIyK9QxWWl5juVbN6DxOpn9HW
 MjMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZovO3Lz3OQ19Ote04qTcQXMlPrcyikFC736dhMs9wWwpce8jyxQydimHRGZzkvcUQg4SNOmmFTYGT@nongnu.org
X-Gm-Message-State: AOJu0YwpBBdhmJQoCmEn8U5+86NxIZLEA/5OeascuO1TTPqHOmGOzo5o
 lXmuumYPBbVC/b6//Zy1fwBoQYUJBAXssQDyIznvnfsSvL+SZnrA82xxXsAKEnioQtIp4YcZnC3
 6wzdhIg+q31+x1Mqq7aBQ04/ggZmgo5/f0GaiZV1rwo2zgW4yRlZY
X-Received: by 2002:adf:9b02:0:b0:374:c0f5:79f4 with SMTP id
 ffacd0b85a97d-376dcc8b82dmr186919f8f.7.1725358759372; 
 Tue, 03 Sep 2024 03:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNdrXkMxrzzTevbRReSfq7f2AUvnATqt+U6xVFSDTFfd5Z9cN5M9vTcLKJLcLQNX2/v0fnMg==
X-Received: by 2002:adf:9b02:0:b0:374:c0f5:79f4 with SMTP id
 ffacd0b85a97d-376dcc8b82dmr186897f8f.7.1725358758493; 
 Tue, 03 Sep 2024 03:19:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bdcbe0f0sm9345802f8f.117.2024.09.03.03.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 03:19:17 -0700 (PDT)
Date: Tue, 3 Sep 2024 06:19:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, zuoboqun@baidu.com, qemu-devel@nongnu.org
Subject: Re: [PATCH V2 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Message-ID: <20240903061829-mutt-send-email-mst@kernel.org>
References: <20240820115631.52522-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820115631.52522-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 20, 2024 at 07:56:31PM +0800, Gao Shiyuan wrote:
> When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER feature negotiated and
> virtio_queue_set_host_notifier_mr success on system blk
> device's queue, the VM can't load MBR if the notify region's
> address above 4GB.
> 
> Assign the address of notify region in the modern bar above 4G, the vp_notify
> in SeaBIOS will use PCI Cfg Capability to write notify region. This will trap
> into QEMU and be handled by the host bridge when we don't enable mmconfig.
> QEMU will call virtio_write_config and since it writes to the BAR region
> through the PCI Cfg Capability, it will call virtio_address_space_write.
> 
> virtio_queue_set_host_notifier_mr add host notifier subregion of notify region
> MR, QEMU need write the mmap address instead of eventfd notify the hardware
> accelerator at the vhost-user backend. So virtio_address_space_lookup in
> virtio_address_space_write need return a host-notifier subregion of notify MR
> instead of notify MR.
> 
> Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.
> 
> Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")
> 
> Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> ---
>  hw/virtio/virtio-pci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> ---
> v1 -> v2:
> * modify commit message
> * replace direct iteration over subregions with memory_region_find.
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 9534730bba..5d2d27a6a3 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -610,19 +610,29 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
>  {
>      int i;
>      VirtIOPCIRegion *reg;
> +    MemoryRegion *mr = NULL;
> +    MemoryRegionSection mrs;
>  
>      for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
>          reg = &proxy->regs[i];
>          if (*off >= reg->offset &&
>              *off + len <= reg->offset + reg->size) {
> -            *off -= reg->offset;
> -            return &reg->mr;
> +            mrs = memory_region_find(&reg->mr, *off - reg->offset, len);
> +            if (!mrs.mr) {
> +                error_report("Failed to find memory region for address"
> +                             "0x%" PRIx64 "", *off);
> +                return NULL;
> +            }


I'm not sure when can this happen. If it can't assert will do.


> +            *off = mrs.offset_within_region;
> +            memory_region_unref(mrs.mr);
> +            return mrs.mr;
>          }
>      }
>  
>      return NULL;
>  }
>  
> +
>  /* Below are generic functions to do memcpy from/to an address space,
>   * without byteswaps, with input validation.
>   *
> -- 
> 2.39.3 (Apple Git-146)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A1DC021BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdNz-0003EB-K7; Mon, 24 Feb 2025 13:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdNN-0002a1-9R
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:40:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmdNG-0006RV-IL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740422411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/liqqKmACU8MqcGrUp4Whqy71KhTqU3CIlXOYbq4IZ0=;
 b=UzrMwr/pRZxkCNcnM4AVDriB+OXVxeJ/kDclLfLKUo5XBLKEJ1rzZhuQXlshGlxVVq6nKo
 Q+8SMGtg9y5kZlDG7KPfblJ5TQsb3vdIHmlyPjkF1iuJxox1UDBvHyAjA4lpi1DtwHgldh
 auUdnH/ELecmVub3/rKM8j6SNDqVYcQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-EELpkdpNMgicCOXHRB623w-1; Mon, 24 Feb 2025 13:40:10 -0500
X-MC-Unique: EELpkdpNMgicCOXHRB623w-1
X-Mimecast-MFC-AGG-ID: EELpkdpNMgicCOXHRB623w_1740422409
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2f438fb6so5634388f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740422409; x=1741027209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/liqqKmACU8MqcGrUp4Whqy71KhTqU3CIlXOYbq4IZ0=;
 b=e2awgZTctVjAr1uLaMbK2C8doeDaIdR+I6iQ9NWVZJU3GFoe2qoKuFJDVD0tq7lV79
 2EMmTwnrx6kMhf9c3gALEAjxh5n5qqnqa6fhFt0dpx+2n5Zh0DmKdoH7ZwIQMTiJwpRQ
 h6nwRutuL/3ezRc3t4mHI+YSYzbchaCN/cXA3mAwd4R2u4oFXbnF6UcJTefSJTVH6dPl
 r13x3Iqe+F8p1wQMUPzX6mossG8uemcWD11u9AYTXyN9W32L8Xts6gLBejE6nHO0eXeK
 zB/B+nFuJbYrINZZfyHrONAFtKaJvrgGngOdnfUJirH+e4hFnYRJgBdS+nPGldZfn2ZF
 VcfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh5KGJdStWMo8HRxOoNdV1RqJyKP+nC/Ic3oWueDUsRndpyWw4qJYRep3BinKelP0e/TbwbkdAvXW2@nongnu.org
X-Gm-Message-State: AOJu0YynUNlA1aVc1dvhPL3tO1XTMK7lkx0csubFV7bjaaB83hOht1Js
 A2+EbgHqpDOYFy8C8wZBdFaVWcC0FKgfeJQOi8byau0bQXkkUn/d8Lr3m2/bgKrNYGSv59Aifdg
 OGYnnN+ST/SE9GT5G7IYvNI0kdUGIT31kgMM91orw8C2h7Myc5t9r
X-Gm-Gg: ASbGnct//KGXRCA0GeKu77MJANJTnPGqFaJkagd/yridDRIEYi/8q24h+/wL78tMwxB
 zhhrkPVe48uzRot6SJFYIfOzLUpU/n7oXq7DmAv4ipUxLnKan0rUqz4Qp2ebWb8Ml45SqZMrxxb
 pQvTo+qbedju4JVwvEhFHxoZ7NgHFJ6bRR1/yeDR/Sxz4H2+TbkCMFAq8SoiSkgOmY7TrHr7CrV
 zqw1KmCCRJtkVffrFvPEVVV2a7qaw0yW9WsY1qSnyzSMcHdwUzihzFlvM1r8SZ+YHytIzz+22MS
 WvQkm/HNA3Z9E+xls6iNvWIRR5N1pxGNvfnvyvJAo4hcLsCk58rqzj3jPpsnrI4=
X-Received: by 2002:a5d:5109:0:b0:38f:2073:14a7 with SMTP id
 ffacd0b85a97d-390cc63bf61mr91605f8f.47.1740422408890; 
 Mon, 24 Feb 2025 10:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdc7WfzmmeHkAkHes9aksHDflkdOltYevIVGz4KXnawc2QxBT06HXgEWKFoTou8znuDtTkXQ==
X-Received: by 2002:a5d:5109:0:b0:38f:2073:14a7 with SMTP id
 ffacd0b85a97d-390cc63bf61mr91590f8f.47.1740422408559; 
 Mon, 24 Feb 2025 10:40:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fdb19sm33114754f8f.95.2025.02.24.10.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 10:40:07 -0800 (PST)
Message-ID: <499dd251-baf0-42ee-8400-e968d8a96f4f@redhat.com>
Date: Mon, 24 Feb 2025 19:40:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-5-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220224918.2520417-5-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/20/25 11:48 PM, Alex Williamson wrote:
> The pm_cap on the PCIExpressDevice object can be distilled down
> to the new instance on the PCIDevice object.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci-bridge/pcie_pci_bridge.c | 1 -
>  hw/virtio/virtio-pci.c          | 8 +++-----
>  include/hw/pci/pcie.h           | 2 --
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index 9fa656b43b42..2429503cfbbf 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -56,7 +56,6 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
>      if (pos < 0) {
>          goto pm_error;
>      }
> -    d->exp.pm_cap = pos;
>      pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
>  
>      pcie_cap_arifwd_init(d);
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index afe8b5551c5c..3ca3f849d391 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2209,8 +2209,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>              return;
>          }
>  
> -        pci_dev->exp.pm_cap = pos;
> -
>          /*
>           * Indicates that this function complies with revision 1.2 of the
>           * PCI Power Management Interface Specification.
> @@ -2309,11 +2307,11 @@ static bool virtio_pci_no_soft_reset(PCIDevice *dev)
>  {
>      uint16_t pmcsr;
>  
> -    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
> +    if (!pci_is_express(dev) || !(dev->cap_present & QEMU_PCI_CAP_PM)) {
>          return false;
>      }
>  
> -    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> +    pmcsr = pci_get_word(dev->config + dev->pm_cap + PCI_PM_CTRL);
>  
>      /*
>       * When No_Soft_Reset bit is set and the device
> @@ -2342,7 +2340,7 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
>  
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>              pci_word_test_and_clear_mask(
> -                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
> +                dev->config + dev->pm_cap + PCI_PM_CTRL,
>                  PCI_PM_CTRL_STATE_MASK);
>          }
>      }
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index b8d59732bc63..70a5de09de39 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -58,8 +58,6 @@ typedef enum {
>  struct PCIExpressDevice {
>      /* Offset of express capability in config space */
>      uint8_t exp_cap;
> -    /* Offset of Power Management capability in config space */
> -    uint8_t pm_cap;
>  
>      /* SLOT */
>      bool hpev_notified; /* Logical AND of conditions for hot plug event.



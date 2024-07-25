Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F19C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 22:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX6nN-0001Wb-88; Thu, 25 Jul 2024 18:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sX6nM-0001W6-K1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 18:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sX6nK-00074i-EE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 18:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721945918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HwJxYl9HwQAgidt1DiQRgQtKQdwECr8kF+9Zm1O0SpM=;
 b=IgC9mMhDmPjoVCeGB/gmmKlu7ce+Rj7OEBcWydd+4ub52ZiT4GbIIh360nD54NNjy1jHIF
 EyVkew4Ph4YWEHyLm+TdQpu0PkPelyFp2PaUw0GRfQ+TZN7LN7vqAbT5p23T9h6s6iKiZR
 MzLlISTY1O8yEXnQwIOysstKpsYKbls=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-qvHwi5WMN_yP4xJahOvSdQ-1; Thu, 25 Jul 2024 18:18:35 -0400
X-MC-Unique: qvHwi5WMN_yP4xJahOvSdQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e0b3e3b912aso61750276.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 15:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721945914; x=1722550714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwJxYl9HwQAgidt1DiQRgQtKQdwECr8kF+9Zm1O0SpM=;
 b=YcEROHOU6L+wGtcbuVn+0FeRDzLM5x2fKycJry0QDcoVBZuMIIeiyc+tilQLrHoiQ9
 9SVqGvt2NzvRpdRk6DRWRk0CoEo1sLO2nGKGGGmhI4+QzqU1a3so2iFYCKFUJ/bQbXwB
 nMfQsdSJ3AXeOjMYfGyDHp50xa+GIoJev6bfUjUwWjxIiZqL0XKIRFN1JxZRZpgF9Vkt
 pfunb6TVA89XtRQbGjf6KgfCN9zTXaEiXMP6S14TG9QZe1Ij2YBiiDctad4YXBev7bfS
 kVBfqg+BGsF5fHr1iu3wwKL9l1WutKLDs/GbvZ+w4L6gxYnDzU3kxySCvHy4ovXCA4xb
 XA7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIfHKr9uOe4i9N9DJgWwpsF7xVSqM8elhWBx4uzS2XwRHQqPmhbprSVDKOwDVw8oxIkuk57VcIqRBz@nongnu.org
X-Gm-Message-State: AOJu0YxHRSKJfMhjCHQmyqVD2c3N4T8y2qvKLDvcKm5K+mcMZbdalVU6
 XuGs+WSVRNnxfv4CSWLiy44tlkQVQ4opwwc5p5O2C5fLj2OGxpd0l3ahCgQ2F7N0xAyRPQ5EEbX
 H+PO4wkM2XHY6B6HIZZfOgjjv901yGbmC7ieSzzmuLbd9xwZoBylS
X-Received: by 2002:a05:6902:1b03:b0:e0b:3a7d:928d with SMTP id
 3f1490d57ef6-e0b3a7d9399mr1029193276.1.1721945914478; 
 Thu, 25 Jul 2024 15:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl+0a3VjKP4iKm2+LuK31w3Tw8MtzeRmD01GaAHnm/htF7y18oofb9uZZIl3/Up6mSI/PuIA==
X-Received: by 2002:a05:6902:1b03:b0:e0b:3a7d:928d with SMTP id
 3f1490d57ef6-e0b3a7d9399mr1029172276.1.1721945914050; 
 Thu, 25 Jul 2024 15:18:34 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3fae79d9sm11003666d6.125.2024.07.25.15.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 15:18:33 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:18:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, mst@redhat.com, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqLPLBnbfD5r6z7D@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731223148.1002258-5-yuri.benditovich@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> USO features of virtio-net device depend on kernel ability
> to support them, for backward compatibility by default the
> features are disabled on 8.0 and earlier.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>

Looks like this patch broke migration when the VM starts on a host that has
USO supported, to another host that doesn't..

Yuri, would it be possible we always keep all the USO* features off by
default (so this feature bit never affects migration ABI), but then:

  - only enable them when the user specified ON

  - meanwhile, if detecting host feature doesn't support USO*, it could
    fail qemu from boot, rather than silently turning it from ON->OFF

?

Silently flipping the bit may cause migration issues like this.

Or any suggestion on how to fix migration?

Thanks,

> ---
>  hw/core/machine.c   |  4 ++++
>  hw/net/virtio-net.c | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..a725e76738 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,10 +38,14 @@
>  #include "exec/confidential-guest-support.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-net.h"
>  
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
>      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
>  };
>  const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>  
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index d2311e7d6e..bd0ead94fe 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -659,6 +659,15 @@ static int peer_has_ufo(VirtIONet *n)
>      return n->has_ufo;
>  }
>  
> +static int peer_has_uso(VirtIONet *n)
> +{
> +    if (!peer_has_vnet_hdr(n)) {
> +        return 0;
> +    }
> +
> +    return qemu_has_uso(qemu_get_queue(n->nic)->peer);
> +}
> +
>  static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                         int version_1, int hash_report)
>  {
> @@ -796,6 +805,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
>  
> +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +
>          virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
>      }
>  
> @@ -804,6 +817,12 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
>      }
>  
> +    if (!peer_has_uso(n)) {
> +        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> +        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +    }
> +
>      if (!get_vhost_net(nc->peer)) {
>          return features;
>      }
> @@ -864,14 +883,16 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>              !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)));
>  }
>  
> -static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
> +static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
>  {
>      static const uint64_t guest_offloads_mask =
>          (1ULL << VIRTIO_NET_F_GUEST_CSUM) |
>          (1ULL << VIRTIO_NET_F_GUEST_TSO4) |
>          (1ULL << VIRTIO_NET_F_GUEST_TSO6) |
>          (1ULL << VIRTIO_NET_F_GUEST_ECN)  |
> -        (1ULL << VIRTIO_NET_F_GUEST_UFO);
> +        (1ULL << VIRTIO_NET_F_GUEST_UFO)  |
> +        (1ULL << VIRTIO_NET_F_GUEST_USO4) |
> +        (1ULL << VIRTIO_NET_F_GUEST_USO6);
>  
>      return guest_offloads_mask & features;
>  }
> @@ -3924,6 +3945,12 @@ static Property virtio_net_properties[] = {
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> +    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO4, true),
> +    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> +                      VIRTIO_NET_F_GUEST_USO6, true),
> +    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> +                      VIRTIO_NET_F_HOST_USO, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.34.3
> 
> 

-- 
Peter Xu



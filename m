Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C060CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 07:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR3VH-0001mD-Mw; Sun, 24 May 2026 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR3V9-0001kW-DJ
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wR3V7-0005E3-3r
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779608634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d31P/47NSDwQAWFSW6gul/ImIejpiWKEwkFsv0GPKu4=;
 b=diNJKyzYDDaWkddZ5FL0ZC/01IpXKGoVX4Ae20hxLSHR7ywrJbMHXgwtG5eW4EtuaRw5nn
 kWNOc5LzOUsExo/LHM3PAbUaf7j1eVleMe3k3l9qVpKUXaqfawq4pGNWDgsPRLSpSl8jp6
 y3sKZFyXvBNip4cDuoNggmieSVld0P8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-YoUY8Q9dOhKBOUO2CZ9N3A-1; Sun, 24 May 2026 03:43:52 -0400
X-MC-Unique: YoUY8Q9dOhKBOUO2CZ9N3A-1
X-Mimecast-MFC-AGG-ID: YoUY8Q9dOhKBOUO2CZ9N3A_1779608631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49041d39887so15178965e9.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779608631; x=1780213431; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d31P/47NSDwQAWFSW6gul/ImIejpiWKEwkFsv0GPKu4=;
 b=PrJJJyGcR1D+R+aK+XWi4SJOa6tNkuL070c+TA6Ejjg8VjIcc6ATBfLcljAAR+Xb8g
 WwSewrIRkysYvlzf2WlRllsU7ZvUtdwwu51TP7bZJ0GAag/Afjrza5N2o9zS536bSyGH
 xXctr9LPj64VfRL4ZYW7Nc4Sgb46KJJkjjCQHJDYAE3uhGK2GnfgMBeaE6LgYHJhJ3NI
 AfiEUIDUgOju00I5+91t2zfIoEwZsplhHoxAQeZfkHl8Du9P9KhdW5Gxsvnba5RS01+J
 SqgdroFjOxWnZMy4apEKeuQhPbmHplf0lZjJZpNSfA4RyYD+q7rQq7p2tKbdwVQYKO7x
 iG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779608631; x=1780213431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d31P/47NSDwQAWFSW6gul/ImIejpiWKEwkFsv0GPKu4=;
 b=UPeFs8+4DkcQ06egO4yHcFNbWsbeA2iJjNrPUoRKFcmaNcBPbwxPQg3OYhhC423LE4
 Ou0UlSNlD7DLNBT+za239DMPq5XP8OYrYVqHo2z4SMhDcivXAcKTwtXts67V5k3ZGvp4
 WseTB3ir7FEcUG4DmhFl/i8xFt8V+59xefpM5ty9TG7kXxYw7TR8Sho5/tr8PzZGoR2k
 cZ+xtjq7KLIPl95TxoW1t7oHRJWYwEhs4+9UjHvM78GHrTk9dnfpjtaZ0DTUZdhZ42ao
 8Km58HHxY+yXmqaS5EWFuOiOHQMhmcfbrqkiIa+G7rxoy3l+25DcLvtFikud9bOLb4/w
 Nu0w==
X-Gm-Message-State: AOJu0YyWYL6j6iQ2wqZNVgeAd9lq4sSWA/MyKxYjfCk1tiaaPxIROJwY
 4N9tB353b34vJ+uNvJiSedQBD0lot/BuLsrXPrJ8gM68H3PqDweq4A3bf+jJPsjJxxFJtLdIwK1
 oHvVjFvE5vDjoNZpSZOw8yhV3V6/hH6Sq8Uw0cfuPpaKoVEwXNnyhoppZ
X-Gm-Gg: Acq92OHVwPAhwdINCT7par8+K+NkfuTdIT3YWhFutZUNO0t/BswIX7WpvkwyiKUb0pF
 ZtNJsmSOmFqpAyGvLvc6+8gZuanemxPbXIHdlHkA4eILjsnwF22sQp2qx5xiFpw8IteF1Ucx5xp
 jNxdA4l9LgXqaW8rZ8vSdwLUFRwQoclUNDfQeDAW6zpZ7d0B642fGGkseA8f09mbV90y56en9Dt
 DDECqgtENhcOD+zFd6HuuXWBxyW1wGOrn1EJZ36dgU/k2RwYzumjtmAmzyHqvyt5Hnk6CYPOxer
 snxpecVp3PZwzhDmF0JqfiFBBRRV/oloqBiyqfmKtY3wY9XwKPExH8ArA5Xb1W/zXIWLsB4hDgf
 nzmHxoU2XFNvdkq+swJiWPZFUVcwsyyPnXS6dUnxVods=
X-Received: by 2002:a05:600c:1393:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-490428e15e9mr155921945e9.29.1779608630976; 
 Sun, 24 May 2026 00:43:50 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-490428e15e9mr155921545e9.29.1779608630486; 
 Sun, 24 May 2026 00:43:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ec7fcd7f9sm4733435f8f.37.2026.05.24.00.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 00:43:49 -0700 (PDT)
Date: Sun, 24 May 2026 03:43:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, Alexey Gerasimenko <x1917x@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 3/4] q35: Fix incorrect values for PCIEXBAR masks
Message-ID: <20260524034330-mutt-send-email-mst@kernel.org>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <20260313164649.794591-4-thierry.escande@vates.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313164649.794591-4-thierry.escande@vates.tech>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 13, 2026 at 04:47:16PM +0000, Thierry Escande wrote:
> From: Alexey Gerasimenko <x1917x@gmail.com>
> 
> There are two small issues in PCIEXBAR address mask handling:
> - wrong bit positions for address mask bits (see PCIEXBAR description
>   in Q35 datasheet)
> - incorrect usage of 64ADR_MASK
> 
> Due to this, attempting to write a valid PCIEXBAR address may cause it
> to shift to another address, causing memory layout corruption where
> emulated MMIO regions may overlap real (passed through) MMIO ranges. Fix
> this by providing correct values.
> 
> Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci-host/q35.c         | 6 +++---
>  include/hw/pci-host/q35.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index e85e4227b3..7368e3c598 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -306,12 +306,12 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
>          length = 128 * 1024 * 1024;
> -        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
> -            MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
> +        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
>          length = 64 * 1024 * 1024;
> -        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
> +        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK |
> +            MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
>          qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index ddafc3f2e3..f31a71010b 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -100,8 +100,8 @@ struct Q35PCIHost {
>  #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
>  #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
>  #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
> -#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
> -#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
> +#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 27))
> +#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 26))
>  #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK   ((uint64_t)(0x3 << 1))
>  #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M   ((uint64_t)(0x0 << 1))
>  #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M   ((uint64_t)(0x1 << 1))
> -- 
> 2.51.0
> 
> 
> 
> --
> Thierry Escande | Vates XCP-ng Developer
> 
> XCP-ng & Xen Orchestra - Vates solutions
> 
> web: https://vates.tech



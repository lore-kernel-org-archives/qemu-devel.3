Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A4D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFPA-0005Xl-O7; Wed, 13 Nov 2024 10:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFP0-0005NI-Pq; Wed, 13 Nov 2024 10:35:34 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFOy-00008O-Vb; Wed, 13 Nov 2024 10:35:30 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso65789871fa.0; 
 Wed, 13 Nov 2024 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731512126; x=1732116926; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vZBLAStm8FCTgPNyHu7pl00RWgvkCF3+cQtxGJUqTMs=;
 b=H8ZADC8U/0huyI7tPmW9cRklilOvnspfE6vbGd1IsPmBYljISpkDYQoVjolP3DUMXu
 hboyQAfEaJFjxORxeYL5vG9EuIK/yCsNz019oaSJu+1+sahkckvZ9Ao/TX1KPPAikwdb
 Sa4Ixdy/8/GjOCktBnBcMX8l2u0Z9ZIEcolKNo7YTU2hxXk8kHGQdGRui7uTgPHw8xKO
 eoOQjDrguP+Xr3N3Zdp14hcsZgNvoD6Zd0LVyuChXVvM6QDifoSFh3vS+BLZIh2fTrOS
 iYyCeVp1D1QDOt639R2Y863lkKI5HC1jqbSOoL6rgKHRAf/rOMC/H4MJufR1vI05z1fm
 O7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731512126; x=1732116926;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZBLAStm8FCTgPNyHu7pl00RWgvkCF3+cQtxGJUqTMs=;
 b=U3OhDKuuntHSZyaIyAsUCFg/CIVY0e8galbcX/0cGeP1gp1aMeck+vFZz7BPn4sJRU
 yjfKRldJXW1brrp1i0EgyWXvA9y9Kauk9I1fwWIyVEYt/LJAbwxbt3MEFsSD6LtnX+H2
 YR1mIyBojUK49nJV8eUg9Yw9TfY6LI0SIXbHtBr3QRkqNidUwf4nhATVmYwsNQWci7iQ
 +oZdkPmk0T4JDQKDKNqPaaEy+msNDOEz2/hr6y6fPZgVMXb12raSpx1oNwKMZ5i7u9Zw
 jsVcCv0VFEp6AXHadutB/xL/7KustLaKNIYVuuz19FsHE3XO5ezchQlq1BJBJc1y/3mr
 /1lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlTh+VAkM3tnQS2oYXrkEAw+vssw/nnlTkF4MOiowyiaK3vQtsA8xDLwSvMVwZ41tWdyhVrETAAA==@nongnu.org
X-Gm-Message-State: AOJu0YwDHXaLAfZKldxfQKpQpxwE8D8CSYXyEEWHdfrjTjXQkfOE5fMp
 SKmx8QOal9CinmVmNceGKcKrvlQ0vQ8eqFoBNHNc/EoESIRVlfr7
X-Google-Smtp-Source: AGHT+IFuVh0DGoFFAghSy4ADlqqkXUnJDJP5ptX9RLR51LU07IMkpQxj8kU9zjwye0Ed4EB9oa0lVw==
X-Received: by 2002:a2e:a994:0:b0:2fb:4b40:1e1c with SMTP id
 38308e7fff4ca-2ff4c655fa7mr18856901fa.36.1731512126352; 
 Wed, 13 Nov 2024 07:35:26 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff17991d06sm24091761fa.71.2024.11.13.07.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:35:25 -0800 (PST)
Date: Wed, 13 Nov 2024 16:35:25 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 20/20] hw/net/xilinx_ethlite: Rename 'mmio' MR as
 'container'
Message-ID: <ZzTHPQp5SgjBXUN0@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-21-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 12, 2024 at 07:10:44PM +0100, Philippe Mathieu-Daudé wrote:
> Having all its address range mapped by subregions,
> s->mmio MemoryRegion effectively became a container.
> Rename it as 'container' for clarity.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index da453465ca..c65001cf46 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -93,7 +93,7 @@ struct XlnxXpsEthLite
>  {
>      SysBusDevice parent_obj;
>  
> -    MemoryRegion mmio;
> +    MemoryRegion container;
>      qemu_irq irq;
>      NICState *nic;
>      NICConf conf;
> @@ -306,7 +306,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>  {
>      XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
>  
> -    memory_region_init(&s->mmio, OBJECT(dev),
> +    memory_region_init(&s->container, OBJECT(dev),
>                         "xlnx.xps-ethernetlite", 0x2000);
>  
>      object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
> @@ -314,31 +314,31 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>      qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
>      qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
>      sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
> -    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
> +    memory_region_add_subregion(&s->container, A_MDIO_BASE,
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
>  
>      for (unsigned i = 0; i < 2; i++) {
>          memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
>                                 i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
>                                 0x07f4, &error_abort);
> -        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
> +        memory_region_add_subregion(&s->container, 0x0800 * i, &s->port[i].txbuf);
>          memory_region_init_io(&s->port[i].txio, OBJECT(dev),
>                                &eth_porttx_ops, s,
>                                i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
>                                4 * TX_MAX);
> -        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
> +        memory_region_add_subregion(&s->container, i ? A_TX_BASE1 : A_TX_BASE0,
>                                      &s->port[i].txio);
>  
>          memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
>                                 i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
>                                 0x07f4, &error_abort);
> -        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
> +        memory_region_add_subregion(&s->container, 0x1000 + 0x0800 * i,
>                                      &s->port[i].rxbuf);
>          memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
>                                &eth_portrx_ops, s,
>                                i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
>                                4 * RX_MAX);
> -        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
> +        memory_region_add_subregion(&s->container, i ? A_RX_BASE1 : A_RX_BASE0,
>                                      &s->port[i].rxio);
>      }
>  
> @@ -354,7 +354,7 @@ static void xilinx_ethlite_init(Object *obj)
>      XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
>  
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
>  }
>  
>  static Property xilinx_ethlite_properties[] = {
> -- 
> 2.45.2
> 


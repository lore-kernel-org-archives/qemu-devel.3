Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2C9D462C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFKi-0002tE-79; Wed, 13 Nov 2024 10:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFKe-0002sf-CW; Wed, 13 Nov 2024 10:31:02 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFKc-000823-OK; Wed, 13 Nov 2024 10:31:00 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53a007743e7so8113125e87.1; 
 Wed, 13 Nov 2024 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511856; x=1732116656; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yQvFerOL6cPKGINQjKEXB7yivuE7JUj9TjmPYbd3ygI=;
 b=igkb4cH7CID16zp26gzf446BhRL0UpbV25wjlOOfPmfLjx00h52RM/DievNwoifrPR
 bftPxZVvXrRQVmlCPe5wC18sUSO6CwuVPfNMWiSBEm0B57uCVIMrN3wCBlLQTcmcriiV
 WwTHWqH7SaVj1WLgQ1l27WIOyKKZ2GyTBcvPQVh9AZDn2i6j3stPbkgiNuS/PSESkV+p
 vrAMrivQDYLSdrzu47P9YrY9U4xi1D3LDoopADl7DsFPvLXO9SMtmLIlsJKMvD4gVTBU
 K64rfSFuDdTWYWspnTko3B6UXr3m9LDftI7juNdnLqOgvGt8vliKZBs7yTxXTIVe7+Rk
 Ya5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511856; x=1732116656;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQvFerOL6cPKGINQjKEXB7yivuE7JUj9TjmPYbd3ygI=;
 b=IeYgxvxy0ePtLsPcO0+WyF689uWMyiikYrzMLQnZPe89I9HtlaaOz0A9J3aSAjFvKw
 S8TQrYMq3zd6AviD5Id3klfBkb/1kLpUsoje1EOjlufSLqaVDLi63yS8jeT9j3H0UYE7
 hm84vJxzf+fEPY+On0qD7JCVu+zl0kuj/QdmevKeAaGGfGnGBwTboMLWk/xyu3Z9gBE0
 wr7lsCveDDe7m/oZPGqRDloSzdxGDHe5msUJw3SmjH2CgOZI1PP2HVMCiV4L/2ShZ5lD
 z+NxmOHVNmnDnraLQfbp09CRtns0PGWuWtGJffIU87zUyxTMrgf87t1nnOFtms9Uwa9c
 M8jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsIvS6ZsZAPrYJDGJ6J95XdEyp6uu90DbhKk9UStMTqO6C4I2EfM0Sr+U2JXkveL9tn94rJ1hCsQ==@nongnu.org
X-Gm-Message-State: AOJu0YygYtfVfbrs3viGYb6m4S8QhIbp0SjWKzvjm3GJELbM9lRYoCVn
 gU64n2ViawVfv6y6DkLYyWB3YyYOTzKckBNcClt/ATy0ltwb1EOG
X-Google-Smtp-Source: AGHT+IHhVWOvfiNAxIV+xmpQibV5IBgVpiHqEz8lz1tEKtT1bUwd5xcdWhM/IWEwOUm0i2/kR+QWAg==
X-Received: by 2002:a05:6512:318b:b0:53d:a299:6d32 with SMTP id
 2adb3069b0e04-53da2996ddfmr1146516e87.6.1731511855883; 
 Wed, 13 Nov 2024 07:30:55 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d82685f7csm2214642e87.93.2024.11.13.07.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:30:55 -0800 (PST)
Date: Wed, 13 Nov 2024 16:30:54 +0100
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
Subject: Re: [PATCH 16/20] hw/net/xilinx_ethlite: Map TX_LEN as MMIO
Message-ID: <ZzTGLj0RHr2MgAe8@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-17-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-17-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
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

On Tue, Nov 12, 2024 at 07:10:40PM +0100, Philippe Mathieu-Daudé wrote:
> Declare TX registers as MMIO region, split it out
> of the current mixed RAM/MMIO region.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/net/xilinx_ethlite.c | 71 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 161fd97f06..159b2b0c64 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -38,11 +38,11 @@
>  #define A_MDIO_BASE   0x07e4
>  
>  #define R_TX_BUF0     0
> -#define R_TX_LEN0     (0x07f4 / 4)
> +#define A_TX_BASE0    0x07f4
>  #define R_TX_GIE0     (0x07f8 / 4)
>  #define R_TX_CTRL0    (0x07fc / 4)
>  #define R_TX_BUF1     (0x0800 / 4)
> -#define R_TX_LEN1     (0x0ff4 / 4)
> +#define A_TX_BASE1    0x0ff4
>  #define R_TX_CTRL1    (0x0ffc / 4)
>  
>  #define R_RX_BUF0     (0x1000 / 4)
> @@ -53,6 +53,11 @@
>  
>  #define RX_BUFSZ_MAX  0x07e0
>  
> +enum {
> +    TX_LEN =  0,
> +    TX_MAX
> +};
> +
>  enum {
>      RX_CTRL = 0,
>      RX_MAX
> @@ -125,6 +130,51 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
>      return &s->regs[rxbase + R_RX_BUF0];
>  }
>  
> +static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    XlnxXpsEthLite *s = opaque;
> +    unsigned port_index = addr_to_port_index(addr);
> +    uint32_t r = 0;
> +
> +    switch (addr >> 2) {
> +        case TX_LEN:
> +            r = s->port[port_index].reg.tx_len;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +    }
> +
> +    return r;
> +}
> +
> +static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
> +                          unsigned int size)
> +{
> +    XlnxXpsEthLite *s = opaque;
> +
> +    switch (addr >> 2) {
> +        case TX_LEN:
> +            s->port[port_index].reg.tx_len = value;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +    }
> +}
> +
> +static const MemoryRegionOps eth_porttx_ops = {
> +        .read = port_tx_read,
> +        .write = port_tx_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +};
> +
>  static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> @@ -187,11 +237,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>              r = s->port[port_index].reg.tx_gie;
>              break;
>  
> -        case R_TX_LEN0:
> -        case R_TX_LEN1:
> -            r = s->port[port_index].reg.tx_len;
> -            break;
> -
>          case R_TX_CTRL1:
>          case R_TX_CTRL0:
>              r = s->port[port_index].reg.tx_ctrl;
> @@ -237,11 +282,6 @@ eth_write(void *opaque, hwaddr addr,
>              break;
>  
>          /* Keep these native.  */
> -        case R_TX_LEN0:
> -        case R_TX_LEN1:
> -            s->port[port_index].reg.tx_len = value;
> -            break;
> -
>          case R_TX_GIE0:
>              s->port[port_index].reg.tx_gie = value;
>              break;
> @@ -330,6 +370,13 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
>  
>      for (unsigned i = 0; i < 2; i++) {
> +        memory_region_init_io(&s->port[i].txio, OBJECT(dev),
> +                              &eth_porttx_ops, s,
> +                              i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
> +                              4 * TX_MAX);
> +        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
> +                                    &s->port[i].txio);
> +
>          memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
>                                &eth_portrx_ops, s,
>                                i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
> -- 
> 2.45.2
> 


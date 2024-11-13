Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B39ED462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFOC-0004AT-3B; Wed, 13 Nov 2024 10:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFOA-00049h-4Q; Wed, 13 Nov 2024 10:34:38 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFO8-0008I3-Ha; Wed, 13 Nov 2024 10:34:37 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e59dadebso8282853e87.0; 
 Wed, 13 Nov 2024 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731512074; x=1732116874; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i44MD6NG7ycBtGvUughFRFLgbFB/B4GJxfbb6ZajAmo=;
 b=Do+fveBVKAsTwM1P4z19wJG+lwL1iTFFVvZhfKBrJtHOIcwbzCiT6GNERiGYbNTvAY
 Elklngl8PiamNhU/n1Q/GJ1oGUk6UZWpDvUiLUqykbS5FLP68gFGsx4wAhCmWGGvWjss
 WqBKOH/RPsD6c7M1CUbLXyEisrHT8ulqQs4huLaofKbwtb+jk3UrPl/J0oYog6ZZoLsw
 6w6RbEQtZWq4oCbB8d5RD+LLwQTex1cE4K7FOYzAh5+5+siLJazb/XtrnoClGjbizLCk
 gz3zrqzJC3d2pywiTq6xXLXeKboEUfiAbKz4+4/urVbjswCk+BQp3R9TszpEjshP6E7R
 XUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731512074; x=1732116874;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i44MD6NG7ycBtGvUughFRFLgbFB/B4GJxfbb6ZajAmo=;
 b=BWuAVet1m2m4ocd7B6L15gXIIUzi/xK96x+vVFUZyCXIgI8xAx3+4E4O4ggrJhi/EA
 kKByWuLprU52YTyir62DIPibXz2eE6pcMV1hEyrSVwJnxdT0pkXuPm5j0TD1FRXa3IGe
 /FlkupAuglYjo9XZn17UexYm7DWfu0t1ynpgSRa+R+7BNZdNcneHD6vp7l8aZwvl9cDf
 QGFCf0K2QqGtzgqlbH/bKV4JZ9MznbehGi2+i743hj41zqARIcYznuiz8Jgvx3fljxcK
 hbXMpivSkLFITKOXHA09c8aMaECOgp5o1WvBIKiqT6CoTsufNtlOj8hokc1FtFRQlX9R
 8BnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcYt9DWC3cVfR4nw/gKvKM19BhZQj5nOLNwktwdj3Y4OKo9sU8R9gvZgMP0UvLhI5Qg7ioluoHJw==@nongnu.org
X-Gm-Message-State: AOJu0YwklGBYSXftKFesjfoUydoaO9lw+3bYnAmbDKIpJVFW40QOxYYO
 PWsnbvLsR2H0mJaNAEs5DE1nqjIY6lX4lxCcJCLGGdxuC00FNpHjfOlSBOeq
X-Google-Smtp-Source: AGHT+IEvn/k/1AaZCFThY2GJPUTJnP9M1fo2urUHJ2qBBfOnGgSwqCD/6QjmNLVR/XEiIl1t8+NnVA==
X-Received: by 2002:a05:6512:3d19:b0:539:eb2f:a026 with SMTP id
 2adb3069b0e04-53d862cb488mr10439973e87.33.1731512074148; 
 Wed, 13 Nov 2024 07:34:34 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826af003sm2225079e87.265.2024.11.13.07.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:34:33 -0800 (PST)
Date: Wed, 13 Nov 2024 16:34:33 +0100
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
Subject: Re: [PATCH 18/20] hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
Message-ID: <ZzTHCYrrett8KfoB@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-19-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-19-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
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

On Tue, Nov 12, 2024 at 07:10:42PM +0100, Philippe Mathieu-Daudé wrote:
> Add TX_CTRL to the TX registers MMIO region.
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 56 +++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index f7a5b1620a..f681b91769 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -39,10 +39,8 @@
>  
>  #define R_TX_BUF0     0
>  #define A_TX_BASE0    0x07f4
> -#define R_TX_CTRL0    (0x07fc / 4)
>  #define R_TX_BUF1     (0x0800 / 4)
>  #define A_TX_BASE1    0x0ff4
> -#define R_TX_CTRL1    (0x0ffc / 4)
>  
>  #define R_RX_BUF0     (0x1000 / 4)
>  #define A_RX_BASE0    0x17fc
> @@ -55,6 +53,7 @@
>  enum {
>      TX_LEN =  0,
>      TX_GIE =  1,
> +    TX_CTRL = 2,
>      TX_MAX
>  };
>  
> @@ -71,6 +70,7 @@ enum {
>  
>  typedef struct XlnxXpsEthLitePort
>  {
> +    MemoryRegion txio;
>      MemoryRegion rxio;
>  
>      struct {
> @@ -143,6 +143,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
>          case TX_GIE:
>              r = s->port[port_index].reg.tx_gie;
>              break;
> +        case TX_CTRL:
> +            r = s->port[port_index].reg.tx_ctrl;
> +            break;
>          default:
>              g_assert_not_reached();
>      }
> @@ -154,6 +157,7 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
>                            unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> +    unsigned port_index = addr_to_port_index(addr);
>  
>      switch (addr >> 2) {
>          case TX_LEN:
> @@ -162,6 +166,26 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
>          case TX_GIE:
>              s->port[port_index].reg.tx_gie = value;
>              break;
> +        case TX_CTRL:
> +            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
> +                qemu_send_packet(qemu_get_queue(s->nic),
> +                                 txbuf_ptr(s, port_index),
> +                                 s->port[port_index].reg.tx_len);
> +                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
> +                    eth_pulse_irq(s);
> +                }
> +            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
> +                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
> +                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
> +                    eth_pulse_irq(s);
> +                }
> +            }
> +            /*
> +             * We are fast and get ready pretty much immediately
> +             * so we actually never flip the S nor P bits to one.
> +             */
> +            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
> +            break;
>          default:
>              g_assert_not_reached();
>      }
> @@ -232,18 +256,12 @@ static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> -    unsigned port_index = addr_to_port_index(addr);
>      uint32_t r = 0;
>  
>      addr >>= 2;
>  
>      switch (addr)
>      {
> -        case R_TX_CTRL1:
> -        case R_TX_CTRL0:
> -            r = s->port[port_index].reg.tx_ctrl;
> -            break;
> -
>          default:
>              r = tswap32(s->regs[addr]);
>              break;
> @@ -256,33 +274,11 @@ eth_write(void *opaque, hwaddr addr,
>            uint64_t val64, unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> -    unsigned int port_index = addr_to_port_index(addr);
>      uint32_t value = val64;
>  
>      addr >>= 2;
>      switch (addr) 
>      {
> -        case R_TX_CTRL0:
> -        case R_TX_CTRL1:
> -            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
> -                qemu_send_packet(qemu_get_queue(s->nic),
> -                                 txbuf_ptr(s, port_index),
> -                                 s->port[port_index].reg.tx_len);
> -                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
> -                    eth_pulse_irq(s);
> -                }
> -            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
> -                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
> -                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
> -                    eth_pulse_irq(s);
> -                }
> -            }
> -
> -            /* We are fast and get ready pretty much immediately so
> -               we actually never flip the S nor P bits to one.  */
> -            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
> -            break;
> -
>          default:
>              s->regs[addr] = tswap32(value);
>              break;
> -- 
> 2.45.2
> 


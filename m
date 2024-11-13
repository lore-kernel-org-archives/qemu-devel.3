Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6E2D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBF2K-0000RX-LR; Wed, 13 Nov 2024 10:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF2I-0000RF-8J; Wed, 13 Nov 2024 10:12:02 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF2F-0005z3-9I; Wed, 13 Nov 2024 10:12:01 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53d8c08cfc4so4433130e87.3; 
 Wed, 13 Nov 2024 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731510717; x=1732115517; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kJdRgxForAU7cG0AaP0orkOalMLhmklSvV/NZ7qeIwI=;
 b=Hokyv0VgfE4qdSN0NJ/RT8Q4sRnMcDX9/3CjBlCpgIrDTXGMUuy383drlhxF9p7PkZ
 N5kkpD5f+F7JVRF0s/iMGo8ZN/Ga9Am94Wbo7RW06pIDMdtqboR17wfIG9o3Py2KkEPa
 Z45cfYM33v34k5pBthVAflTifOmMfOWVgH0+gcBcLT1Zl/Y+gsduPRcIt9zvMHjscynU
 uFhZkKSHxvWGPDvgTK/j4JgtJU4L5z3GjNM86ai+37r7s5iiG0LERl5mV8BkdNd7IWaG
 y7s2KneE+tTYyRqI3wf3CxNYghv3Ciq4z0ylVOGCVdtLuFLEWmUQRK0ZdTlFLBsaXuIk
 S58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510717; x=1732115517;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJdRgxForAU7cG0AaP0orkOalMLhmklSvV/NZ7qeIwI=;
 b=O8BiexMw2G5JS5TBWOAr/s+iU2gIhj4OKSAhhR9kULY4SvYvBXm+B3hnM1aCD9SZf7
 DNsS4A2rnLyG/NjtiMU1lH45diQ5ediJ0ZeibiAw3BBA/qHkMp2aONGgqX6m9nT3NvRu
 YbdZd73B1NXFHU7hdCMxo0tz0sWKyvYn/n8mZP9L6MHuI9thqKAX95f09PHFTj2q+qgi
 k9ktyJJKRYdnFFN5ZQO3Q/iO8ob+etaf/TWSXvFk4XJNRFJCjeUfgiYjURvgWIlTAqTs
 uothZrHpThLaI9Uvd1NqCz0KKbBQJQCkv2BEU3xTRHTkYjP/FRBbOITzXLct5XI8kFVr
 6bnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyUJX0d1NN85Cm0F17OUIVr9ftBn/NAfecU6gmavdP5aJGmOJ2cXvKfd7VhgoOgyME+5HYF56/KQ==@nongnu.org
X-Gm-Message-State: AOJu0YwhqJWtdBXWXkK+bolYQfkh6y3rsOFbDfBI9XFKlUVfEjh97HzT
 ntGgXhv7d8c0CJbOxQNqZ/2HDFxzLGQIbqpjo469M7gAQSHXf7iL
X-Google-Smtp-Source: AGHT+IETjslZNW22Njt4tnW1R491TAMdfDhZ2ixjD6edhAZUCT1IT5iHtfZh7xye+e+DGfRcLbQQIw==
X-Received: by 2002:a05:6512:3d8f:b0:539:dca9:19cc with SMTP id
 2adb3069b0e04-53d862cd106mr10230219e87.4.1731510716453; 
 Wed, 13 Nov 2024 07:11:56 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a725esm2234226e87.156.2024.11.13.07.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:11:55 -0800 (PST)
Date: Wed, 13 Nov 2024 16:11:55 +0100
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
Subject: Re: [PATCH 03/20] hw/net/xilinx_ethlite: Remove unuseful debug logs
Message-ID: <ZzTButbXqWgqgZ8q@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-4-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

On Tue, Nov 12, 2024 at 07:10:27PM +0100, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/net/xilinx_ethlite.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index bb330a233f..2b52597f03 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -32,7 +32,6 @@
>  #include "net/net.h"
>  #include "trace.h"
>  
> -#define D(x)
>  #define R_TX_BUF0     0
>  #define R_TX_LEN0     (0x07f4 / 4)
>  #define R_TX_GIE0     (0x07f8 / 4)
> @@ -100,7 +99,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>          case R_RX_CTRL1:
>          case R_RX_CTRL0:
>              r = s->regs[addr];
> -            D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr * 4, r));
>              break;
>  
>          default:
> @@ -126,13 +124,10 @@ eth_write(void *opaque, hwaddr addr,
>              if (addr == R_TX_CTRL1)
>                  base = 0x800 / 4;
>  
> -            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
> -                       __func__, addr * 4, value));
>              if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
>                  qemu_send_packet(qemu_get_queue(s->nic),
>                                   (void *) &s->regs[base],
>                                   s->regs[base + R_TX_LEN0]);
> -                D(qemu_log("eth_tx %d\n", s->regs[base + R_TX_LEN0]));
>                  if (s->regs[base + R_TX_CTRL0] & CTRL_I)
>                      eth_pulse_irq(s);
>              } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
> @@ -156,8 +151,6 @@ eth_write(void *opaque, hwaddr addr,
>          case R_TX_LEN0:
>          case R_TX_LEN1:
>          case R_TX_GIE0:
> -            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
> -                       __func__, addr * 4, value));
>              s->regs[addr] = value;
>              break;
>  
> @@ -203,7 +196,6 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>          return -1;
>      }
>  
> -    D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
>      if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
>          trace_ethlite_pkt_size_too_big(size);
>          return -1;
> -- 
> 2.45.2
> 


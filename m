Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF1D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFIZ-00016A-G7; Wed, 13 Nov 2024 10:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFIW-00015e-Of; Wed, 13 Nov 2024 10:28:48 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFIU-0007gQ-J9; Wed, 13 Nov 2024 10:28:48 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539fe02c386so806290e87.0; 
 Wed, 13 Nov 2024 07:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511724; x=1732116524; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nhKPxld9b8QXJGZ23DGMD/hzGozfqQxdhndePbAYup8=;
 b=Xy5x7wU7nNkycfFyWf6ETMAJK59xb8dWRsiVmmPbYoMH9AXc3Ku8nDWhMFtqUV7RsA
 X5TbiMLh4abE4T+oLLlviCKM2uw41yvD7R5rUD8uRnX5Otn7cLLumclNY18NYDpphiKj
 n+7I0Iy6l/x6guYFIg4RG6kDV9q9rm0Rz5eaJKUXqz10AsJoa3dQWr60sGS8F/t0GPOA
 nOfaCI3KPEgyTH+gOZoSjfBci9RyNSahVXk7sxdKCAfA5BDi1cKR4U+hGbTD7TbWJykj
 wu+lZ4vTp00tR/oi2k6QE30QMOALpsAkkhmrUKtZdd6o/6irF2yUctXPbv0LXlWwQDX+
 VVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511724; x=1732116524;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhKPxld9b8QXJGZ23DGMD/hzGozfqQxdhndePbAYup8=;
 b=pbYVHSF7wNfOhO8+rqeePDcVmROmG778fpF4p7OLZ2XTNb0+4FbZo+x5YdYlOuUrZx
 ukLdIl15p2EOHRsaNT0pZ8kv2skoDl+jzZXek6ydP0ziQrYItoKH5MOU3D/M3CLDchDa
 qPjUEmmyPf3dDV5ez8jfDyQmRfyuVY6TCxdmn+CiNAUxRBH63Nt0iOsnZJNWJKUys9Bp
 ikYmXXTjgf1+uNh5wgiBOQr2LKkaN+u0Wrk1igb9o262qrIykSLbKHlMLERNRN9HP3Mz
 jTkkheSrEH0cXsdWAxjE98JjtW5EQzZAjQdWeTHCmEbKcR4f/XFRsKZ0vI3b+HEz9jCq
 lVyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUewW1jp+tolVX3Ifh8wqmWk7mcH35ob6/AyXRRwSYm9vkNjFn065BZINFLAml1CEGk8ryutlrD1g==@nongnu.org
X-Gm-Message-State: AOJu0YxL2+OPaGsmnE/bKy+FRwN6ZKZSx1/+TEusQ/+PzvOqlXfVBir8
 /5g2TSPJmoOmeHv3FOYx2vkOXsHWqCshU8KYghD+noHtjuqa3hSz
X-Google-Smtp-Source: AGHT+IE7Zdu7n8Dbrt+3LHm0VavMPdtaERmn5bYzwa4i9yrlRRD2COvlagZI2NbcKHIPZdsUqcMYjA==
X-Received: by 2002:a05:6512:159c:b0:53d:a245:2936 with SMTP id
 2adb3069b0e04-53da24529f6mr755214e87.12.1731511724296; 
 Wed, 13 Nov 2024 07:28:44 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d8268577esm2225950e87.70.2024.11.13.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:28:43 -0800 (PST)
Date: Wed, 13 Nov 2024 16:28:42 +0100
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
Subject: Re: [PATCH 14/20] hw/net/xilinx_ethlite: Access TX_CTRL register for
 each port
Message-ID: <ZzTFqk2iq3IYeyUF@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-15-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
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

On Tue, Nov 12, 2024 at 07:10:38PM +0100, Philippe Mathieu-Daudé wrote:
> Rather than accessing the registers within the mixed RAM/MMIO
> region as indexed register, declare a per-port TX_CTRL. This
> will help to map the RAM as RAM (keeping MMIO as MMIO) in few
> commits.
> 
> Previous s->regs[R_TX_CTRL0] and s->regs[R_TX_CTRL1] are now
> unused. Not a concern, this array will soon disappear.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 1a3b295b4b..4d86851f38 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -64,6 +64,7 @@ typedef struct XlnxXpsEthLitePort
>      struct {
>          uint32_t tx_len;
>          uint32_t tx_gie;
> +        uint32_t tx_ctrl;
>  
>          uint32_t rx_ctrl;
>      } reg;
> @@ -139,7 +140,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>  
>          case R_TX_CTRL1:
>          case R_TX_CTRL0:
> -            r = s->regs[addr];
> +            r = s->port[port_index].reg.tx_ctrl;
>              break;
>  
>          case R_RX_CTRL1:
> @@ -159,7 +160,6 @@ eth_write(void *opaque, hwaddr addr,
>  {
>      XlnxXpsEthLite *s = opaque;
>      unsigned int port_index = addr_to_port_index(addr);
> -    unsigned int base = 0;
>      uint32_t value = val64;
>  
>      addr >>= 2;
> @@ -167,24 +167,23 @@ eth_write(void *opaque, hwaddr addr,
>      {
>          case R_TX_CTRL0:
>          case R_TX_CTRL1:
> -            if (addr == R_TX_CTRL1)
> -                base = 0x800 / 4;
> -
>              if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
>                  qemu_send_packet(qemu_get_queue(s->nic),
>                                   txbuf_ptr(s, port_index),
>                                   s->port[port_index].reg.tx_len);
> -                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
> +                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
>                      eth_pulse_irq(s);
> +                }
>              } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
>                  memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
> -                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
> +                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
>                      eth_pulse_irq(s);
> +                }
>              }
>  
>              /* We are fast and get ready pretty much immediately so
>                 we actually never flip the S nor P bits to one.  */
> -            s->regs[addr] = value & ~(CTRL_P | CTRL_S);
> +            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
>              break;
>  
>          /* Keep these native.  */
> -- 
> 2.45.2
> 


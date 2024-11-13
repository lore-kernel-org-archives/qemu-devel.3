Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB270D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFGJ-0006K4-Er; Wed, 13 Nov 2024 10:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFGI-0006Jp-D2; Wed, 13 Nov 2024 10:26:30 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFGH-0007Wl-1v; Wed, 13 Nov 2024 10:26:30 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso7764971e87.3; 
 Wed, 13 Nov 2024 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511587; x=1732116387; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GnB2qEYULg2Mp4+MvTgjS988yXpmGQZuUVsmW3vpIXU=;
 b=kRX0veO9eKQlYca8xDwokCojBoQ43UsOWMILWQks1chWN3a4nsY+hKZEU+xpJpSIWc
 KOIKuo6IohlQV89iq2/0kE1KjVFPDL2+kS58TXA+74Ws6QoWYmZ63D2IcLwXpew/V3tC
 QcjNIzhWGFy2GXtSObCLp+P/kuXbJn4XkIgIZArCvt/+6TW5y/ymEcGRAS8UN5r/ZMZ+
 c+ztlWMa4W2iTn76AZQ3TmO6I6m3RM0dD0ADJPqZChPhrrMGCxg3nBio9cv4DaovSZdT
 v3SX2x7kyZLeWJ5v2747qiEzFy/CJ52KF75PHsEXDfqUtcajH3Tufm7WcVfb8+4j4/Kk
 xJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511587; x=1732116387;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GnB2qEYULg2Mp4+MvTgjS988yXpmGQZuUVsmW3vpIXU=;
 b=PMEXGu+12iH13wE0fpc5bxqhN3pSY+0e4JJow1TfiEZ8lQug5mFX5co4MqGaoJttVE
 3ZTXisjByEqHG7UmpoTKShLsFG7qWUejyp6YdfH6OKLHsFMjVzbaOembazbrrpVbYB+F
 iUfgUvYxEJR2/ZkclZKuZiZ3ZGc3HPN4tFKVRuHBoFI/cYRHcRnr8w0jpBxt8LuP2kHG
 PwoNugArDvzytdTzSNnnUJ22N8T0VfDR8GM7kxTCT7AnhCbj2AwlcpX9fbsyvk9Fq+uy
 yu05gPhZ+vSs5x1LZMaTSsd32JACpZP6kcypwkabTjeOpLy/2pqTjKGC8imLJwxJqfR9
 kkjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVywA2qkyt3CA5h3Bcy+eRUazziOQTDvCqMFtEMI1tvYYpPBzZrLWZ/z7MCNBqdPaYRLwnXHqlSXA==@nongnu.org
X-Gm-Message-State: AOJu0YwI6sFEq/HAD/FEZG3pXcjXwsEC3y1n7JRFL/vfN6ffa8poVCFk
 YTvkovzuWDQJxFNgO3Dbnr1d8avJuRsAIB9aY3BaL38loIKPK75V
X-Google-Smtp-Source: AGHT+IFeNcv7GX79VMbi2loOEwxHFztXeJvVC3gkZstSj5+dH2f4H3TbC5Ap7CJDePNE7OYV43R2aQ==
X-Received: by 2002:a05:6512:3a87:b0:52c:9383:4c16 with SMTP id
 2adb3069b0e04-53d862bd8b4mr8594243e87.22.1731511586655; 
 Wed, 13 Nov 2024 07:26:26 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d82685da9sm2228527e87.84.2024.11.13.07.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:26:25 -0800 (PST)
Date: Wed, 13 Nov 2024 16:26:25 +0100
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
Subject: Re: [PATCH 09/20] hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
Message-ID: <ZzTFIV9ZS-HFwIUP@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-10-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x131.google.com
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

On Tue, Nov 12, 2024 at 07:10:33PM +0100, Philippe Mathieu-Daudé wrote:
> txbuf_ptr() points to the beginning of a (RAM) TX buffer
> within the device state.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/net/xilinx_ethlite.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index fe91891310..d4882f43f7 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -87,12 +87,18 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
>      }
>  }
>  
> -__attribute__((unused))
>  static unsigned addr_to_port_index(hwaddr addr)
>  {
>      return extract64(addr, 11, 1);
>  }
>  
> +static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
> +{
> +    unsigned int rxbase = port_index * (0x800 / 4);
> +
> +    return &s->regs[rxbase + R_TX_BUF0];
> +}
> +
>  static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -125,6 +131,7 @@ eth_write(void *opaque, hwaddr addr,
>            uint64_t val64, unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> +    unsigned int port_index = addr_to_port_index(addr);
>      unsigned int base = 0;
>      uint32_t value = val64;
>  
> @@ -138,12 +145,12 @@ eth_write(void *opaque, hwaddr addr,
>  
>              if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
>                  qemu_send_packet(qemu_get_queue(s->nic),
> -                                 (void *) &s->regs[base],
> +                                 txbuf_ptr(s, port_index),
>                                   s->regs[base + R_TX_LEN0]);
>                  if (s->regs[base + R_TX_CTRL0] & CTRL_I)
>                      eth_pulse_irq(s);
>              } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
> -                memcpy(&s->conf.macaddr.a[0], &s->regs[base], 6);
> +                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
>                  if (s->regs[base + R_TX_CTRL0] & CTRL_I)
>                      eth_pulse_irq(s);
>              }
> -- 
> 2.45.2
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DBD462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFNs-00048e-Ay; Wed, 13 Nov 2024 10:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFNq-00048K-MT; Wed, 13 Nov 2024 10:34:18 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFNp-0008He-5G; Wed, 13 Nov 2024 10:34:18 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53a097aa3daso6854924e87.1; 
 Wed, 13 Nov 2024 07:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731512055; x=1732116855; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UOrdoZztSNOE+QP/iohOmeDqo5ydejMV6CN2d0p7E0g=;
 b=Arh8hkhE1sPf0DxpcjrZ79xsbVJQPVkaEdsJSVvbiGpycAXurrzV1BcBsyFDZIY/hm
 iTjyQbhKkl3jdgFw+5Pn9OGgAG7EJvffMtrwYGtQ5LiCvp3hu3l+bkI9qAUyIhZ6noYQ
 4RrRER5jRAQ6FVorC9a5rrN/cDh+cioAn/hwG86PI819Ai8UTAREV+JUX/xw9p8zjSsu
 QlN+A+VAZPwU7tF4PpLDEhHnrJB3rkkS9uHqSdaKen931t59Uro+w96ZP/l88oxQwvRf
 G0jslvWP9WaNmKKi7LophSrASPZ5qTbulL/IpNInJUlHWpy+lO2fKUua+A/BX8z2V9qo
 To/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731512055; x=1732116855;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOrdoZztSNOE+QP/iohOmeDqo5ydejMV6CN2d0p7E0g=;
 b=wyC6HyLfSs4VlSoEvzYP7DoMLJGk/syaq/LYz1+AbkQGgXkhekBuqMqAI1Rx0pl3Ga
 FihCZiC6b0c8JXRFaw8QHI0FG4oogWak1gzPa5dsCe5OSU5u+q8VCnZEL5bXHhi9fFIL
 sCQSxJJJTi4jm3CblTcd6nUdg8m0ODGSjw/8sxq0faeK/QbLKX+7XdIZO5KloEdF11ot
 eH3iKC5ilHKmRJzrEKJ2SS6q8psUZnFQYgTAgkcwSP/UNAlkdWCNlr7BXTR6i4To5Xh6
 zu+V5IjlG8n8CNQyGD6VIRCJ2+Uos8U1QSIhnX6Ss+HsY6REAgB/yOSDZyb7abPSRhGB
 59XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8A1HFtMLgxTUP+6yUYBKPlOWot7PTYioN5LlNXj8Ur1+EsFvHDYW3APQvutYm72r8ajzZfTTNug==@nongnu.org
X-Gm-Message-State: AOJu0YwFt2RSJ4YGJSbjJwRkoOkwMb46F4Qi14qQoOsKth+FRJAsynTd
 iaGz4A3dt0QPeLbog4bcilezeoLAmGODHCakx1Q9aBhVyeqcsgmY3cA7YrMO
X-Google-Smtp-Source: AGHT+IEdiaBUNv5pwKeoQSlJ1x2JF0qG7gMORUVcVtbZqE3xnIxBdoRgUHasOWjKzodz49gRvVRY9w==
X-Received: by 2002:a05:6512:3e0b:b0:52e:987f:cfc6 with SMTP id
 2adb3069b0e04-53d862ebfadmr8711992e87.51.1731512054498; 
 Wed, 13 Nov 2024 07:34:14 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a9ce6sm2164235e87.200.2024.11.13.07.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:34:13 -0800 (PST)
Date: Wed, 13 Nov 2024 16:34:13 +0100
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
Subject: Re: [PATCH 17/20] hw/net/xilinx_ethlite: Map TX_GIE as MMIO
Message-ID: <ZzTG9TMlpGDvKhgq@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-18-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-18-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
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

On Tue, Nov 12, 2024 at 07:10:41PM +0100, Philippe Mathieu-Daudé wrote:
> Add TX_GIE to the TX registers MMIO region.
> 
> Before TX_GIE1 was accessed as RAM, with no effect.
> Now it is accessed as MMIO, also without any effect.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/net/xilinx_ethlite.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 159b2b0c64..f7a5b1620a 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -39,7 +39,6 @@
>  
>  #define R_TX_BUF0     0
>  #define A_TX_BASE0    0x07f4
> -#define R_TX_GIE0     (0x07f8 / 4)
>  #define R_TX_CTRL0    (0x07fc / 4)
>  #define R_TX_BUF1     (0x0800 / 4)
>  #define A_TX_BASE1    0x0ff4
> @@ -55,6 +54,7 @@
>  
>  enum {
>      TX_LEN =  0,
> +    TX_GIE =  1,
>      TX_MAX
>  };
>  
> @@ -140,6 +140,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
>          case TX_LEN:
>              r = s->port[port_index].reg.tx_len;
>              break;
> +        case TX_GIE:
> +            r = s->port[port_index].reg.tx_gie;
> +            break;
>          default:
>              g_assert_not_reached();
>      }
> @@ -156,6 +159,9 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
>          case TX_LEN:
>              s->port[port_index].reg.tx_len = value;
>              break;
> +        case TX_GIE:
> +            s->port[port_index].reg.tx_gie = value;
> +            break;
>          default:
>              g_assert_not_reached();
>      }
> @@ -233,10 +239,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>  
>      switch (addr)
>      {
> -        case R_TX_GIE0:
> -            r = s->port[port_index].reg.tx_gie;
> -            break;
> -
>          case R_TX_CTRL1:
>          case R_TX_CTRL0:
>              r = s->port[port_index].reg.tx_ctrl;
> @@ -281,11 +283,6 @@ eth_write(void *opaque, hwaddr addr,
>              s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
>              break;
>  
> -        /* Keep these native.  */
> -        case R_TX_GIE0:
> -            s->port[port_index].reg.tx_gie = value;
> -            break;
> -
>          default:
>              s->regs[addr] = tswap32(value);
>              break;
> -- 
> 2.45.2
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD1ED462C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFI6-0008EE-Ix; Wed, 13 Nov 2024 10:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFI4-0008D1-It; Wed, 13 Nov 2024 10:28:20 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFI3-0007f5-4g; Wed, 13 Nov 2024 10:28:20 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso8571340e87.2; 
 Wed, 13 Nov 2024 07:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511697; x=1732116497; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GGdn2TTVFPE/jTWM8nSbg/VN+KpO6eMsaibPhid0twA=;
 b=ZSVLy+k2ig/ui/M/bJErXRAg9NiMr6HIwqSicJl6VoubDLicSAgSAkUWJ5+ZqHzILA
 u49CTyWyVTDI79pnqzjL+9+EIARu+pZ1PfAzUQDh5fgEcxbhRVZ76QFhTNz1hRqDlYwB
 iSTFi/OTG//e/EhMW5C87/JtpNMZ2mgzZhJ5nnctOVrYrQThbscQL/Fe5VM2vQoctbc+
 Y9Ab/JmNRW3J3JeBrmoSXNIbQkavkzgFXeo/EcDJ/ocgWtQMxtDfrOKkhFPB3GBJSIZW
 V42k5Z+QE3aen5EWkWqRtP7apQkJzAAqO+Z0xNFotL8nxYWCkW4kSQOuGXBDRw9+5fG6
 8wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511697; x=1732116497;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGdn2TTVFPE/jTWM8nSbg/VN+KpO6eMsaibPhid0twA=;
 b=O0W/vxV65UWayawU5WRGPvIS5Lib5x8BNdIusqCrc7gDLQNrWvWF5PDZSBgdx5o4v+
 g0g5GVuKvn+2oQulbx2J3NVonkhZDj+LNP4L8YAQLvp612sFLFYpQiFG83IwrZXDv+i+
 dkM/q+q3e5pJ5b7FeaHNhkedZ5gArvaylIouCVOviLtzjxHEyIM7e9Fy6BHXuduuSmIo
 LvhYVaVBVmaSnGmxOSjbu88beXlAQZux/T4vvGZiJh7Gg3MS4Hhgp7jK25oocEKzeU/q
 Tx2V2TV6TaKqRN6OybgBe2EJrhxjEehDAvuTug91MmKOeshtKRUOIyIxwqnWI2GXQtEp
 SKgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMjFl8DeLLvG//pbQ/yxLdVc26rnK2VgIyga2XkTrG+nf0ln8Ujsv9MNA9gE8iFuD5iUzgpsXrxg==@nongnu.org
X-Gm-Message-State: AOJu0YwOEdDJdA2fgC6dMMdh07zVzr/QaINoNR3QvJ7wirHjU70TmkmS
 11I9rpEXr198yKy4ZOwSC9d6M9T+5xBQuVr5xEjNvY3njacfl+dC
X-Google-Smtp-Source: AGHT+IEJbMRLuHPSlMU9PPFHXYpYtJv/3HWPkMmY6Iqze8mpOkD/ATNr6tb3AN3fwTtRae6HG0rKLg==
X-Received: by 2002:a05:6512:230d:b0:53d:6b50:f613 with SMTP id
 2adb3069b0e04-53d862b4627mr9151264e87.3.1731511696724; 
 Wed, 13 Nov 2024 07:28:16 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a9c2csm2205674e87.171.2024.11.13.07.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:28:16 -0800 (PST)
Date: Wed, 13 Nov 2024 16:28:15 +0100
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
Subject: Re: [PATCH 13/20] hw/net/xilinx_ethlite: Access TX_LEN register for
 each port
Message-ID: <ZzTFj3G7zJpZSFob@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-14-philmd@linaro.org>
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

On Tue, Nov 12, 2024 at 07:10:37PM +0100, Philippe Mathieu-Daudé wrote:
> Rather than accessing the registers within the mixed RAM/MMIO
> region as indexed register, declare a per-port TX_LEN. This
> will help to map the RAM as RAM (keeping MMIO as MMIO) in few
> commits.
> 
> Previous s->regs[R_TX_LEN0] and s->regs[R_TX_LEN1] are now
> unused. Not a concern, this array will soon disappear.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 4cb4781e70..1a3b295b4b 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -62,6 +62,7 @@
>  typedef struct XlnxXpsEthLitePort
>  {
>      struct {
> +        uint32_t tx_len;
>          uint32_t tx_gie;
>  
>          uint32_t rx_ctrl;
> @@ -133,6 +134,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>  
>          case R_TX_LEN0:
>          case R_TX_LEN1:
> +            r = s->port[port_index].reg.tx_len;
> +            break;
> +
>          case R_TX_CTRL1:
>          case R_TX_CTRL0:
>              r = s->regs[addr];
> @@ -169,7 +173,7 @@ eth_write(void *opaque, hwaddr addr,
>              if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
>                  qemu_send_packet(qemu_get_queue(s->nic),
>                                   txbuf_ptr(s, port_index),
> -                                 s->regs[base + R_TX_LEN0]);
> +                                 s->port[port_index].reg.tx_len);
>                  if (s->regs[base + R_TX_CTRL0] & CTRL_I)
>                      eth_pulse_irq(s);
>              } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
> @@ -194,7 +198,7 @@ eth_write(void *opaque, hwaddr addr,
>  
>          case R_TX_LEN0:
>          case R_TX_LEN1:
> -            s->regs[addr] = value;
> +            s->port[port_index].reg.tx_len = value;
>              break;
>  
>          case R_TX_GIE0:
> -- 
> 2.45.2
> 


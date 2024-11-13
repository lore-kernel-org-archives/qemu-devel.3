Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A84BD462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFAT-0004Se-Av; Wed, 13 Nov 2024 10:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFAQ-0004Ry-Cp; Wed, 13 Nov 2024 10:20:28 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFAM-00070V-NL; Wed, 13 Nov 2024 10:20:25 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53da353eb35so497446e87.0; 
 Wed, 13 Nov 2024 07:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511218; x=1732116018; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8GNF03oKAKUI+7+/bNF6EtqxSHPkFA+gQFmHmM+BjY=;
 b=IBE8kzeAMAFT5fyTPqN48h1zYYNX1VI7tDY1V+VRAbyH9Xx8PPNdjQACl965VO+Hqk
 mmZvPdQ59TE4qBsSDZKLOkEpMKyeSzMJHJI+HEtFym2tzkZia5lZdy25OCXYQ8hxnntR
 /HBh300bRx+CyRL4Hqm6eEop7Jd9fYwVoKAey9Bnver58rTEOvAWXeVhDh5B4ONWGaF+
 5dehDIpgtLWCHbqSAzvEJo3FCQAttmnZkFGV1hZYcD/g3ZV3C/DWSx+xZ40rshbEm5Yo
 8TWuMHPYP54NZF7UgecLc6AJUvo6x/pMh3lr3vKiA6c0hFA1/0ueNqJKGjA4IBKJpBFT
 Wzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511218; x=1732116018;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8GNF03oKAKUI+7+/bNF6EtqxSHPkFA+gQFmHmM+BjY=;
 b=HPdVOWGN7KL6lDxhCILw6jth//+aGak/6MbQG/DCU9jFjNZCy8SKhOeAF34Nho0u9G
 4YxkEVbZ3HUGYFD+0KBnEMG1/fmtFIz8bTw0o4bYJc3CB/DZpi5NGXhcqspmiAswMS3a
 gOTaKQMUPi7TpA7H/1jisvKV7BrI3JAuVrHAfNnBStBXZ4Ua90xFagtjg5ZIDqjoWr7/
 bmgZ2WmyjGgDbLMzH6Rja0zAa3FQzuAGbr1LIzblE+smoJbP4uW1eBifkbQDINY6+L13
 ODirsHvmLs8Z1rujuecFdaRMs6H/9sO07t2pF7uBSjC/xmp8YPuszYJvgj/skMrJJGJo
 LHtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUknpdWyZ7KWQDinIrwhu1f0TGN29UtgrosHLTND34Rjv/wp+dqK54KBWSgVZ52lbybGSW30zzzgA==@nongnu.org
X-Gm-Message-State: AOJu0YydfFBDvMKGCznSOV95TlUSbWGXKOrYkOYkOaofbAat1Xrlqw3J
 cd/wik3U/Mw1NrDzTFyRmtp1vICOrclymm/tZLavBvS0Nd5ozYAq
X-Google-Smtp-Source: AGHT+IFUQs/E2HIGZIpPXkkvyo5mFdr7lQt0bmLpWaxCGNnnDmhWbWMLs4UQDdolqLPNrCNOA4KDJQ==
X-Received: by 2002:a05:6512:3da0:b0:539:8fcd:524 with SMTP id
 2adb3069b0e04-53d9fe8ad7cmr1558002e87.30.1731511217864; 
 Wed, 13 Nov 2024 07:20:17 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a71b7sm2215893e87.153.2024.11.13.07.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:20:17 -0800 (PST)
Date: Wed, 13 Nov 2024 16:20:16 +0100
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
Subject: Re: [PATCH 07/20] hw/net/xilinx_ethlite: Rename rxbuf -> port_index
Message-ID: <ZzTDsHamYMaZ-bZa@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-8-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 12, 2024 at 07:10:31PM +0100, Philippe Mathieu-Daudé wrote:
> 'rxbuf' is the index of the port used. Rename it as 'port_index'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 76b1e7d826..20919b4f54 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -72,8 +72,7 @@ struct XlnxXpsEthLite
>  
>      uint32_t c_tx_pingpong;
>      uint32_t c_rx_pingpong;
> -    unsigned int txbuf;
> -    unsigned int rxbuf;
> +    unsigned int port_index;


May want to add a comment that you're refering to the dual port RAM
index and not some other port...

Either way:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>





>  
>      UnimplementedDeviceState mdio;
>      uint32_t regs[R_MAX];
> @@ -183,7 +182,7 @@ static const MemoryRegionOps eth_ops = {
>  static bool eth_can_rx(NetClientState *nc)
>  {
>      XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
> -    unsigned int rxbase = s->rxbuf * (0x800 / 4);
> +    unsigned int rxbase = s->port_index * (0x800 / 4);
>  
>      return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
>  }
> @@ -191,7 +190,7 @@ static bool eth_can_rx(NetClientState *nc)
>  static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>  {
>      XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
> -    unsigned int rxbase = s->rxbuf * (0x800 / 4);
> +    unsigned int rxbase = s->port_index * (0x800 / 4);
>  
>      /* DA filter.  */
>      if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
> @@ -214,7 +213,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>      }
>  
>      /* If c_rx_pingpong was set flip buffers.  */
> -    s->rxbuf ^= s->c_rx_pingpong;
> +    s->port_index ^= s->c_rx_pingpong;
>      return size;
>  }
>  
> @@ -222,7 +221,7 @@ static void xilinx_ethlite_reset(DeviceState *dev)
>  {
>      XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
>  
> -    s->rxbuf = 0;
> +    s->port_index = 0;
>  }
>  
>  static NetClientInfo net_xilinx_ethlite_info = {
> -- 
> 2.45.2
> 


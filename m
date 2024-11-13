Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B002ED462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFHX-0007c8-FJ; Wed, 13 Nov 2024 10:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFHT-0007at-H5; Wed, 13 Nov 2024 10:27:43 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFHR-0007dV-Tg; Wed, 13 Nov 2024 10:27:43 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53da3545908so520222e87.1; 
 Wed, 13 Nov 2024 07:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511660; x=1732116460; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c8AqL9LrCs4we89GKuuBV//k6qE6V7we9akKR2B4QXQ=;
 b=VA0JjH7EDykFcg1aLuqhS5M3AZc4gNR/NAaVejMWmd2hOd7i4r/Aii2xSmo9DIvLpv
 hdTB1q4C36v1u74y+3SYGeRThPQrh+r/LGiv3kyipeOVg9BEbqzAcvvHwp/KpOcB0HAU
 GbaaFVoEphTzu9TTNssfIZtVz6UD0W73v+QTmTD9C0atAs4UqnpsgQVmFmImO093Ju9C
 zbUuwPHvdK8qVykpd1WeaOjrspN1QbeB+Q/i8CyDnt5iX7zn812ZlaGvMfTnUItlzku4
 uPtQyB4BaTSL5jhuhJtiiJj1wfpofN306FmgRHSu+o+eLMtlhi+SoqBIZH3lfetjvye7
 SxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511660; x=1732116460;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8AqL9LrCs4we89GKuuBV//k6qE6V7we9akKR2B4QXQ=;
 b=Xcmyc2QsFolzFLV8CgqJ2YrK9f9fepWPFrq9x1UoEeLT2oWJqdUWP00TOG26LuB6qE
 v5iD7SN+JwZ54XdssGJ6l/LYzpCnWqvfJVF2aD8yfor/76aYxOnGFUauphKeIt8XISi3
 XGWC8nzWReE7m/X0FRLrbCNh/J8VqANjpHuEqFyGs3YJdRHSEw0DVjNEkw0ZpIEKSlf/
 Z44o5QjPiniTDUA6+P3G0zlOg7DTWjnFtOAvuncJ3ZiffT9vVgfT8/LFQ790xwffNcc6
 q4baPD9jk4qyeRyOVzQ3j7vjqvVxdWFl+nQRgX96Yud9J1mUYkrzukOs9P5ZlnXCl1vk
 lo+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsNKQaqeKUoPr5KGMpqovysL66zA0K9kukrEJMcue22e5r+UHfLwNyK31kMz7biv9N7gs+ZuOTVA==@nongnu.org
X-Gm-Message-State: AOJu0YzI1GJqaRgYlj7qpEni1Lmlm4/rD5IXa2Qm0Hq62mqCJSRFJk0/
 C0TNY73xH1XJjSjy5C3hCtVMp4MBHZQtJ5l6bg8d3ze5AX98Xgg/
X-Google-Smtp-Source: AGHT+IFW057e2VfgG8ARptoKHKp4S3q98RmkgNToMuFYWPAANAsVCjWzJCKO34KfUZfkeyunaiOQHQ==
X-Received: by 2002:a05:6512:2256:b0:539:905c:15ab with SMTP id
 2adb3069b0e04-53d862e3e86mr10629139e87.32.1731511659622; 
 Wed, 13 Nov 2024 07:27:39 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da077c4a6sm232553e87.140.2024.11.13.07.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:27:38 -0800 (PST)
Date: Wed, 13 Nov 2024 16:27:38 +0100
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
Subject: Re: [PATCH 11/20] hw/net/xilinx_ethlite: Access RX_CTRL register for
 each port
Message-ID: <ZzTFah0QJed6jvBd@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-12-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

On Tue, Nov 12, 2024 at 07:10:35PM +0100, Philippe Mathieu-Daudé wrote:
> Rather than accessing the registers within the mixed RAM/MMIO
> region as indexed register, declare a per-port RX_CTRL. This
> will help to map the RAM as RAM (keeping MMIO as MMIO) in few
> commits.
> 
> Previous s->regs[R_RX_CTRL0] and s->regs[R_RX_CTRL1] are now
> unused. Not a concern, this array will soon disappear.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index fdbf25fd91..605451a522 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -59,6 +59,13 @@
>  #define CTRL_P     0x2
>  #define CTRL_S     0x1
>  
> +typedef struct XlnxXpsEthLitePort
> +{
> +    struct {
> +        uint32_t rx_ctrl;
> +    } reg;
> +} XlnxXpsEthLitePort;
> +
>  #define TYPE_XILINX_ETHLITE "xlnx.xps-ethernetlite"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxXpsEthLite, XILINX_ETHLITE)
>  
> @@ -76,6 +83,7 @@ struct XlnxXpsEthLite
>      unsigned int port_index;
>  
>      UnimplementedDeviceState mdio;
> +    XlnxXpsEthLitePort port[2];
>      uint32_t regs[R_MAX];
>  };
>  
> @@ -110,6 +118,7 @@ static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      XlnxXpsEthLite *s = opaque;
> +    unsigned port_index = addr_to_port_index(addr);
>      uint32_t r = 0;
>  
>      addr >>= 2;
> @@ -121,11 +130,13 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>          case R_TX_LEN1:
>          case R_TX_CTRL1:
>          case R_TX_CTRL0:
> -        case R_RX_CTRL1:
> -        case R_RX_CTRL0:
>              r = s->regs[addr];
>              break;
>  
> +        case R_RX_CTRL1:
> +        case R_RX_CTRL0:
> +            r = s->port[port_index].reg.rx_ctrl;
> +
>          default:
>              r = tswap32(s->regs[addr]);
>              break;
> @@ -173,7 +184,9 @@ eth_write(void *opaque, hwaddr addr,
>              if (!(value & CTRL_S)) {
>                  qemu_flush_queued_packets(qemu_get_queue(s->nic));
>              }
> -            /* fall through */
> +            s->port[port_index].reg.rx_ctrl = value;
> +            break;
> +
>          case R_TX_LEN0:
>          case R_TX_LEN1:
>          case R_TX_GIE0:
> @@ -203,23 +216,21 @@ static const MemoryRegionOps eth_ops = {
>  static bool eth_can_rx(NetClientState *nc)
>  {
>      XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
> -    unsigned int rxbase = s->port_index * (0x800 / 4);
>  
> -    return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
> +    return !(s->port[s->port_index].reg.rx_ctrl & CTRL_S);
>  }
>  
>  static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>  {
>      XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
>      unsigned int port_index = s->port_index;
> -    unsigned int rxbase = port_index * (0x800 / 4);
>  
>      /* DA filter.  */
>      if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
>          return size;
>  
> -    if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
> -        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
> +    if (s->port[port_index].reg.rx_ctrl & CTRL_S) {
> +        trace_ethlite_pkt_lost(s->port[port_index].reg.rx_ctrl);
>          return -1;
>      }
>  
> @@ -229,8 +240,8 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>      }
>      memcpy(rxbuf_ptr(s, port_index), buf, size);
>  
> -    s->regs[rxbase + R_RX_CTRL0] |= CTRL_S;
> -    if (s->regs[R_RX_CTRL0] & CTRL_I) {
> +    s->port[port_index].reg.rx_ctrl |= CTRL_S;
> +    if (s->port[port_index].reg.rx_ctrl & CTRL_I) {
>          eth_pulse_irq(s);
>      }
>  
> -- 
> 2.45.2
> 


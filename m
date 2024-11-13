Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A05ED462B9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBF25-0000QW-Ce; Wed, 13 Nov 2024 10:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF23-0000Px-BI; Wed, 13 Nov 2024 10:11:47 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBF21-0005xp-1L; Wed, 13 Nov 2024 10:11:46 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53da24e9673so622938e87.2; 
 Wed, 13 Nov 2024 07:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731510702; x=1732115502; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu8vAtDyx0cTAVjc4mfmckt3I4l8nZ76x4Flog8u25I=;
 b=gh2oyLEzHDQmlfopp9awDvj/uYYnJFw3ZeEw039NBzzGMZuqZZuEUkpnfa2SB/CfrC
 XivHylpzorvlwkb4N2oKTjZQUySMxmbaKfmEpCmg4rndWh+veS3EartJnX5/RCbQ/q8I
 x0gCGa65zrzC8apJYZuCQQoEAP4XPObH4NmxqTgslDnZvTOZUd3fu6tREQJVon3ZQFwN
 ELEXI9KxzQaR19WdXrWt9Qta+MuwPg9g/rFjYGhBhAkjWw1c+I03Y2aAGJ4Y2n6D/3D8
 YUGhy8qVBHbvn5LPb0crJWArk84TxT2urG9BjT9T57Doz2lw8aEo7CSYx8jP7DLW3vWW
 JmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510702; x=1732115502;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pu8vAtDyx0cTAVjc4mfmckt3I4l8nZ76x4Flog8u25I=;
 b=wFdkHoJK6zq6apmiCO8vMGP25jyeuaNwNjDau+STavYW1YXMl3C9po1itacza2c6hA
 jOx+YPNo6Gxq1xio4a2Bg35lWbjFCGOsLIc0mPdQD2iobs0jLznV8XQUAn7tWuW8XnPL
 L9/jNKCt8wPUOSGqv6CLrgZ6ptMwXFdswH1o7zmMa61KKmGbhb7AW6r5/hVaWg9E4mCC
 AvMEa0tGo8zBMLf3zGg3P0/UoGvnNZhvrpZqMvi8MO9u16dN9H7AWk/7drCOR68ac4QL
 7ovs12zlcrRAOOXvLofnULPzHqv1lU5IwZtQVaYGRXPDovub3xZ+DyPjXMBr8bBoQXsk
 ++0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5pBDNv1tE+qe9Fq8MSFHbxfCi98wO1WtfN2RN/b3xKWwL/K5uKsb8f7rGYPniJuGe+17ivQepig==@nongnu.org
X-Gm-Message-State: AOJu0YwYjsK94XCNs77een8UiJO86WjwU6HV5kVY/t5Umo6pf7ET9huG
 kSleLHwx1cALN+RzebeTOf80rEL7ZtIM7DSsWfVvAS8X6SleMN9K
X-Google-Smtp-Source: AGHT+IElWqAoa8AIv6szDIA/8ZA8faGrT2DOhbq2xxsEB/8egqPQcgBfjBi7Q8eKVtfkF2oTSBkPlA==
X-Received: by 2002:a05:6512:b17:b0:539:fc75:99c4 with SMTP id
 2adb3069b0e04-53d862c6fbfmr9912727e87.20.1731510702022; 
 Wed, 13 Nov 2024 07:11:42 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a71acsm2181224e87.126.2024.11.13.07.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:11:40 -0800 (PST)
Date: Wed, 13 Nov 2024 16:11:40 +0100
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
Subject: Re: [PATCH 02/20] hw/net/xilinx_ethlite: Convert some debug logs to
 trace events
Message-ID: <ZzTBrP1tZYaFzbN-@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-3-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
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

On Tue, Nov 12, 2024 at 07:10:26PM +0100, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/net/xilinx_ethlite.c | 5 +++--
>  hw/net/trace-events     | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index e84b4cdd35..bb330a233f 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -30,6 +30,7 @@
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>  #include "net/net.h"
> +#include "trace.h"
>  
>  #define D(x)
>  #define R_TX_BUF0     0
> @@ -198,13 +199,13 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>          return size;
>  
>      if (s->regs[rxbase + R_RX_CTRL0] & CTRL_S) {
> -        D(qemu_log("ethlite lost packet %x\n", s->regs[R_RX_CTRL0]));
> +        trace_ethlite_pkt_lost(s->regs[R_RX_CTRL0]);
>          return -1;
>      }
>  
>      D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
>      if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
> -        D(qemu_log("ethlite packet is too big, size=%x\n", size));
> +        trace_ethlite_pkt_size_too_big(size);
>          return -1;
>      }
>      memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index d0f1d8c0fb..2b36cd967e 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -511,3 +511,7 @@ xen_netdev_connect(int dev, unsigned int tx, unsigned int rx, int port) "vif%u t
>  xen_netdev_frontend_changed(const char *dev, int state) "vif%s state %d"
>  xen_netdev_tx(int dev, int ref, int off, int len, unsigned int flags, const char *c, const char *d, const char *m, const char *e) "vif%u ref %u off %u len %u flags 0x%x%s%s%s%s"
>  xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d flags 0x%x"
> +
> +# xilinx_ethlite.c
> +ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
> +ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
> -- 
> 2.45.2
> 


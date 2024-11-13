Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FBAD462B9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFE0-0005Jl-RV; Wed, 13 Nov 2024 10:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFDy-0005JS-3z; Wed, 13 Nov 2024 10:24:06 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFDu-0007Cq-Hi; Wed, 13 Nov 2024 10:24:04 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53c78ebe580so947014e87.1; 
 Wed, 13 Nov 2024 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511440; x=1732116240; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3mlrQINo70fJUvCp3E2to0cyk3dygkBiCxz57FeRoCc=;
 b=ISBjj33lsZFvV1SadtjzL5RZRU/SzAGRIKX5mpz8cEPA8Cs1iTZjY/roRd/qvzs1H2
 ifgpo08S2/rw0ttKgmx0cHe6rbRlAKYLL75nHOt0ZuXmw3pBfwJII32mUD61A8c97jp/
 KFsqIaLucpEon4/07nSWLQQIst6NjQ+/7Hd6kXXVIngLj2/syL+XQ4xdXOI5t5CJANqW
 B/WzNNN98rm0Y7o8gaih5REqhibyjhPYNkrMJaBhecpv2T1yD14hM14kvtOo5jsZVcmB
 O/aBxKimFO+fup+6W19YYPP41VldSBXRkDOiMpAfNodpEWmlAVfyUui6Bwr2Os1WU4Ob
 gb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511440; x=1732116240;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mlrQINo70fJUvCp3E2to0cyk3dygkBiCxz57FeRoCc=;
 b=wEX7ijfFbKF5JKBwfVigz376JxQJEayU0/bKomLcgG1JMGWUEYGeK5sgeTn0Yr3CBD
 opoA+D2Az9SVBYfQIFZCl+1g9roz+vxDmJaUNiCaiKkN3fORdHn+V2kQSleJ/sJPmNfK
 NeKJNjNnCOoe8QS9Lg4Nx2HU4jYP7H+i3P2mIXUot//Gg8sFth8BDhTp8+nZMfwOVHjq
 RoG+p0BuIH8zzlcnxhuWqaFa3LZ2MPylr8zevJmX60H7vKpvXnBem2+2M89BvfHMQqE8
 jh6BvVb0RSnWFpfekV7y2/vs0gDuU+rUedxIziG8wgTqBWKF5gP1Sx2se7pH2QZQdeYx
 Ae1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmf2XI2/dRvFr4RidaqA2vUHZIz9kl9mB4RRt5YhS+S0tNf0r4oehMdTjm41sJTfGKeGsRbRQX6A==@nongnu.org
X-Gm-Message-State: AOJu0YzpMCV8yGk55p2MxQSY3ddqxfA/3JuRQOH+HVdQ+LI3SlSwVfdK
 1sXc+fBijz5gURJve6TKP8ygR+eBwv1Q0v+qDmn1uTk4gPcSoyPn
X-Google-Smtp-Source: AGHT+IFRZ3S/kuxOnud/ts9Gi1SyuYMaPx1Yc6dra7zbK8GtsgTqAuHvGymCQ5z42jcw0NR3X28OEg==
X-Received: by 2002:a05:6512:31c9:b0:53d:a22b:fe7c with SMTP id
 2adb3069b0e04-53da22bfff7mr869710e87.0.1731511439886; 
 Wed, 13 Nov 2024 07:23:59 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826a7248sm2176169e87.127.2024.11.13.07.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:23:59 -0800 (PST)
Date: Wed, 13 Nov 2024 16:23:58 +0100
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
Subject: Re: [PATCH 08/20] hw/net/xilinx_ethlite: Add addr_to_port_index()
 helper
Message-ID: <ZzTEjun3kd5_wckb@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-9-philmd@linaro.org>
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

On Tue, Nov 12, 2024 at 07:10:32PM +0100, Philippe Mathieu-Daudé wrote:
> For a particular physical address within the EthLite MMIO range,
> addr_to_port_index() returns which port is accessed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 20919b4f54..fe91891310 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
> +#include "qemu/bitops.h"
>  #include "qom/object.h"
>  #include "qapi/error.h"
>  #include "exec/tswap.h"
> @@ -86,6 +87,12 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
>      }
>  }
>  
> +__attribute__((unused))
> +static unsigned addr_to_port_index(hwaddr addr)
> +{
> +    return extract64(addr, 11, 1);
> +}
> +

Shouldn't you add addr_to_port_index in the following patch and avoid
the temporary unused attribute?


>  static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -190,7 +197,8 @@ static bool eth_can_rx(NetClientState *nc)
>  static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>  {
>      XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
> -    unsigned int rxbase = s->port_index * (0x800 / 4);
> +    unsigned int port_index = s->port_index;
> +    unsigned int rxbase = port_index * (0x800 / 4);


Hmm, AFAICT s->port_index is an unsigned int, what is the purpose of this change?



>  
>      /* DA filter.  */
>      if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
> -- 
> 2.45.2
> 


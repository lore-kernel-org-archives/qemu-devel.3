Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5146D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFGc-0006Pc-Cr; Wed, 13 Nov 2024 10:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFGb-0006P8-1I; Wed, 13 Nov 2024 10:26:49 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFGZ-0007Xg-Lm; Wed, 13 Nov 2024 10:26:48 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so1199952e87.1; 
 Wed, 13 Nov 2024 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511605; x=1732116405; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7B7nnTBg+kU3c6AJkz3NJDJbDjfYpz06LC7stk3W3pk=;
 b=XJLE+dqaTCXbB5CCMTQLG4pg07Dzfd2+r3OO18L9OmBTTRpZa2dp9rmwXTwOGES8Ac
 6Gs1yC/Up9kS1+JJ48m3zGX/5PUd7UofdYX3r3EvC7qsWAeYeeSGzF0cSsLUXrKG1WdA
 42b/eakOZOM1X6vQ4NM4FF9gbYVT26VjHrv0rcx2GuZ07egf+U64ZPLQO/3MrmBY33Jm
 VE044Rw30Ouwd8Z4NYWZm4D/HtuJOSAhRR972pwfTG8LmPtzB6QCWk4IC3EEoSK2G17F
 B57wM9MVKFG8Pw4iVPiVl8BSc/HqF9SCVtH3AnRxB6/MbbVotL97szAeedDjkg40hzAw
 6wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511605; x=1732116405;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7B7nnTBg+kU3c6AJkz3NJDJbDjfYpz06LC7stk3W3pk=;
 b=BGoVXD17H/iGoLd5ue24jqCsXQY0ZIUgAsXJcj+EF+c44F4T1EyuZJwhcirCvIZukO
 UgnwaE67ed3nXOsyW5anlF0tvS9MVwoEYACj4HaCbhK8cOjcmSRM0Nm9CyaPHKkfEjxE
 HFkyYljxGKuoAX0HI2537rlq6utJk00AHwOZLq5K+4fBmepGF7MwbhpmHGjwLKlnLAOU
 L1lR9b+ITwGhaoVF1WRYQCebS8UbKwo0QPjnag6MPLJ2wh6SSD/JW7W0J6VIftDHeohD
 AD3HHH79JmAlgCdYQ0uvjqqbpjSn65tJAU+To97GlWphEWvtbODt0cR3VFL9qFuS9CT+
 jSYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXROr5FWviMbgiP4enbZ/1WjoAlEFXJ1ZLapguiWAfVFdQrY2f0Ifpl32fNQtLm+o5LlhqXEuynyA==@nongnu.org
X-Gm-Message-State: AOJu0YwrZK9nL77WNpnWwxT5ogaE0T46YFn5xfrDHOLNlH8T5zbvS9sI
 CwAb7kc+Rm0C9NYui9LMfJh3O2osrWUWMzPfrI38jvHgL0awiSMR
X-Google-Smtp-Source: AGHT+IGGQRAtU+qCtAe2uKx6woA8IvHilCMSiz/tQjhVubrTc3F/bUmvYXnf7FNdJQ4eUXeoEMiecQ==
X-Received: by 2002:ac2:4c56:0:b0:53b:1f14:e11a with SMTP id
 2adb3069b0e04-53d862c6c3amr9564654e87.15.1731511605178; 
 Wed, 13 Nov 2024 07:26:45 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53da283bc7csm144610e87.233.2024.11.13.07.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:26:44 -0800 (PST)
Date: Wed, 13 Nov 2024 16:26:43 +0100
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
Subject: Re: [PATCH 10/20] hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
Message-ID: <ZzTFM3cb0ovHpX4B@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-11-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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

On Tue, Nov 12, 2024 at 07:10:34PM +0100, Philippe Mathieu-Daudé wrote:
> rxbuf_ptr() points to the beginning of a (RAM) RX buffer
> within the device state.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/net/xilinx_ethlite.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index d4882f43f7..fdbf25fd91 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -99,6 +99,13 @@ static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
>      return &s->regs[rxbase + R_TX_BUF0];
>  }
>  
> +static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
> +{
> +    unsigned int rxbase = port_index * (0x800 / 4);
> +
> +    return &s->regs[rxbase + R_RX_BUF0];
> +}
> +
>  static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -220,7 +227,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>          trace_ethlite_pkt_size_too_big(size);
>          return -1;
>      }
> -    memcpy(&s->regs[rxbase + R_RX_BUF0], buf, size);
> +    memcpy(rxbuf_ptr(s, port_index), buf, size);
>  
>      s->regs[rxbase + R_RX_CTRL0] |= CTRL_S;
>      if (s->regs[R_RX_CTRL0] & CTRL_I) {
> -- 
> 2.45.2
> 


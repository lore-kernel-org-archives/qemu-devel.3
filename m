Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9B1D462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFQQ-00074j-Db; Wed, 13 Nov 2024 10:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFQL-00073a-HY; Wed, 13 Nov 2024 10:36:54 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFQJ-0000Cb-Os; Wed, 13 Nov 2024 10:36:53 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53da2140769so815083e87.3; 
 Wed, 13 Nov 2024 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731512210; x=1732117010; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9zABEvykCk3bAaRacuppjP2RMFe/7YKNtu2Qc7RGXNE=;
 b=lHyXlvJUkXDqUiE5eEDRXgj/C5oS3c2J1jN6Sxvc2YBRED1PBwWhIH4zcXTE8+BgnJ
 KWtFR08kFDnx1ehMGSWaVsnGh9t28GrJTpTc/bqha7b9QVqPhrgWfAWH9zVD+EkkIcjz
 X8jY/m5SJ4w9fG5ylIu/VdGCQXC40StqXz2KkXsX24eIH8gbYNB2s0xUESKGbTUqgUJK
 CgG5B6g1NMg4kEw6EbWBoBtjx1h98NE2PJv6bP9aXK03TE8ya4PhG5sI6Rbn6M5XtYjs
 SkPfGWA0vJ816CAvJJWNbgd1CdHK4G0Y9TPltY3njBadqpRkrDKkw62kbBUBYPGpSHxT
 G/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731512210; x=1732117010;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9zABEvykCk3bAaRacuppjP2RMFe/7YKNtu2Qc7RGXNE=;
 b=mWNUNZCx12eFwH7m9q4yeoXr0gBbTlRvYRgid++BFuW7KIrSBn888wCkPq/mi5r9fp
 vYstnFCZyEX0eLAd6aMKOZU1l8FJMxp7nAPjFZfS8BU+vSJ5M7a8YqTBhp870c/FVu8p
 hYojBXeS+sRaC0qw2OF++MupqfdK1b+FqA9mLrbVDiLevVwdnNIuUGi/8koqiPVQcMP2
 edOOkzIs3aECCLSCEc7UTf/VfCbNiYjidxm3pH9tC5r2pOhS8hUe+QvvH5SCc8Td/MPl
 QC5hY8UEEOYwnfJm9DtUHkTyHo8AdCpwcYUmvyciaTf1GcyFbdqDKiNcGzNkA4s7YOLh
 17ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw3Ek6hvNdPWhAl5Nf5FDcfxtDmGcYh9bPY7CNpewgykqZWZhyxJTtNS8En4yb9zNUCn/J4rFrvA==@nongnu.org
X-Gm-Message-State: AOJu0YzFmQEl2J7Id3HE2Rk0CQ66GOnXwlTGzgBmKJSnZ1yhDmmDGFyn
 NcAPWvShAc0MM/pthmkuqt1UwKDTw+0p5Sdz2Wlc1QogllNp1tDf
X-Google-Smtp-Source: AGHT+IHs3S25Vl4474sDqpIBGJ4IjtwErkHX23eGmNc/IKj0NEu53+s6cW9CHwfaa2c0KhbE/WyAgA==
X-Received: by 2002:a05:6512:3ca5:b0:52e:9e70:d068 with SMTP id
 2adb3069b0e04-53d862b36b4mr10973117e87.4.1731512209443; 
 Wed, 13 Nov 2024 07:36:49 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d826af0c6sm2222824e87.277.2024.11.13.07.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:36:48 -0800 (PST)
Date: Wed, 13 Nov 2024 16:36:47 +0100
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
Subject: Re: [PATCH 00/20] hw/net/xilinx_ethlite: Map RAM buffers as RAM and
 remove tswap() calls
Message-ID: <ZzTHj3uHGfc2Z8Dd@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
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

On Tue, Nov 12, 2024 at 07:10:24PM +0100, Philippe Mathieu-Daudé wrote:
> This is the result of a long discussion with Edgar (started few
> years ago!) and Paolo:
> https://lore.kernel.org/qemu-devel/34f6fe2f-06e0-4e2a-a361-2d662f6814b5@redhat.com/
> After clarification from Richard on MMIO/RAM accesses, I figured
> strengthening the model regions would make things obvious,
> eventually allowing to remove the tswap() calls for good.
> 
> This costly series mostly plays around with MemoryRegions.
> 
> The model has a mix of RAM/MMIO in its address range. Currently
> they are implemented as a MMIO array of u32. Since the core
> memory layer swaps accesses for MMIO, the device implementation
> has to swap them back.
> In order to avoid that, we'll map the RAM regions as RAM MRs.
> First we move each MMIO register to new MMIO regions (RX and TX).
> Then what is left are the RAM buffers; we convert them to RAM MRs,
> removing the need for tswap() at all.
> 
> Once reviewed, I'll respin my "hw/microblaze: Allow running
> cross-endian vCPUs" series based on this.


Thanks Phil,

This looks good to me. Have you tested this with the Images I provied
a while back or some other way?

Cheers,
Edgar




> 
> Please review,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (20):
>   hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
>   hw/net/xilinx_ethlite: Convert some debug logs to trace events
>   hw/net/xilinx_ethlite: Remove unuseful debug logs
>   hw/net/xilinx_ethlite: Update QOM style
>   hw/net/xilinx_ethlite: Correct maximum RX buffer size
>   hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
>   hw/net/xilinx_ethlite: Rename rxbuf -> port_index
>   hw/net/xilinx_ethlite: Add addr_to_port_index() helper
>   hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
>   hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
>   hw/net/xilinx_ethlite: Access RX_CTRL register for each port
>   hw/net/xilinx_ethlite: Access TX_GIE register for each port
>   hw/net/xilinx_ethlite: Access TX_LEN register for each port
>   hw/net/xilinx_ethlite: Access TX_CTRL register for each port
>   hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
>   hw/net/xilinx_ethlite: Map TX_LEN as MMIO
>   hw/net/xilinx_ethlite: Map TX_GIE as MMIO
>   hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
>   hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
>   hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
> 
>  hw/char/xilinx_uartlite.c |   4 +
>  hw/intc/xilinx_intc.c     |   4 +
>  hw/net/xilinx_ethlite.c   | 357 ++++++++++++++++++++++++--------------
>  hw/timer/xilinx_timer.c   |   4 +
>  hw/net/trace-events       |   4 +
>  5 files changed, 246 insertions(+), 127 deletions(-)
> 
> -- 
> 2.45.2
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378BFC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8PD3-0004Ni-HC; Fri, 25 Apr 2025 15:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8PCk-0004KN-Ht; Fri, 25 Apr 2025 15:59:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u8PCg-0001Ux-1k; Fri, 25 Apr 2025 15:59:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso17820975e9.0; 
 Fri, 25 Apr 2025 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745611155; x=1746215955; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yweKDTzZHfMStYqASqNPpklMtZspKfWLJrLsjOL9QlI=;
 b=NNS7kOe/Ix+qQ+KfDO4BNd0zL+/ZvCUV4AIA2tMufBEsuO1WRaokfDEcIVwpw6sWWr
 RW122Hpg1DSHyx4wCEHnGxvYZWaQ59EM1V2EhuStRxo9+0Y7r7R4bUGhnBvUIEw8aHW3
 MxYA2B1wyNvb1yZqrGin9Wdtg0EJt//cKHekmyos3iHhUAk+Adc5C5TqXQmPkTTEIbXY
 7vU7zPgKT0KfxoZNnXHHYOJIRNh7HNcn1KW6IK2lQ8S+njWgWVoG/AovPlQG7UdoNtnJ
 RReY4Dv8H7EGe7IoTazA4lEZRh8FERstcTYliXi7sisdqGn5yUk9u6tkxpMfCHiWWEuz
 8PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745611155; x=1746215955;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yweKDTzZHfMStYqASqNPpklMtZspKfWLJrLsjOL9QlI=;
 b=NwLN6/Z/xCZQH1TSGFIx+s6yTVTY3u0N0hYSBpGxtMCQMZmd+CO3iOAgoOMyVRPccR
 sdLFB6Pg2KXeCPyDRu6KYVBjnwMGNtgJ4PXAKHPD7jCcav//PrXo9UKWFbMIQtqynOHG
 22m0ccgUOyUt7E1yntAbYCmgiRlBJsGn2GNLjSD/58dug2/nXdZ8Gep5uVPBxO2RasLG
 QdWTGON9N4xpQdrgovfw+rLrTCI1MPwI95QuPAPvy24G2wiNfTgkhGr4Gal8/OS5qvSY
 KCS4JiL7mGmlXLBwYJQojQ2ryv5LwpPhu36oLD+37cGXzkMzYZuF+39Op5r1YP/BhsT8
 /3Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7JC/krEs6lhhXJfqhxh9Hq244HxiJ5QqHW9w/+sWzHTIB1T9abL7LBcp+t/94YvjqsuvCTcPxw==@nongnu.org
X-Gm-Message-State: AOJu0YylmshK1xlYB6zbisbJxm51ISVCYdRRFpmJfWQv77Xk+UXyVhwR
 UnmkmAY/CiYbuaSVHWWP2E7Wtqtq+9e6jTv/u9yeIAkIOt3ko0Sv
X-Gm-Gg: ASbGncuc2zZ3qvpRExHG6f5AWC8xQVHoxTfACjixV782iNZ6EvgmYFv4TIPlvcoekn3
 /+smLzptmBCFwys12tIQhtwhSXiJwPiGIMzv4EHt4KMqjVzyoEkuObk3TJCgamKCzsTZo4I/GVc
 xUIqIn6ycSXMOk1YYo+EKRXSsowV34aUUM08xWaUznSfYmT7q3MZy52QsX2l2ySTaOwQQ7wldxk
 laSrBPJRyXSjyWK2homwx0VV1KjnbnzPYQI5xSBI7Vuy9e71AfQIGMrDFYGfI1sK9Tgb1hC1zoW
 aZ2g/XJHMtEuIyxMAZwzhrAAe6AnGuWgKjqSy4vWj5fGZg9G0uCYuVQOqOat5I8CM5C+HiItdTf
 NQYV8KAHgf/rC
X-Google-Smtp-Source: AGHT+IEVPUhwLmv8riv8/fDAe4xeHMfwpRY3f+z1CPFugWvVDtdP4qQBzqD6o7VZHGNqMGQF6T8d9Q==
X-Received: by 2002:a05:600c:1c23:b0:43c:ec72:3daf with SMTP id
 5b1f17b1804b1-4409c513fa7mr79424265e9.14.1745611154876; 
 Fri, 25 Apr 2025 12:59:14 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc180bsm3295318f8f.53.2025.04.25.12.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 12:59:14 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:59:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Corvin =?iso-8859-1?Q?K=F6hne?= <C.Koehne@beckhoff.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <Y.Vossen@beckhoff.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>
Subject: Re: [PATCH 00/21] hw/arm: add CX7200 board emulation
Message-ID: <aAvpkV1ExuLthoH9@zapote>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
 <b4a0daac7b200e4ffc08879977dbde120a8d5f73.camel@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4a0daac7b200e4ffc08879977dbde120a8d5f73.camel@beckhoff.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32b.google.com
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

On Thu, Apr 24, 2025 at 10:48:17AM +0000, Corvin Köhne wrote:
> On Tue, 2025-03-18 at 14:07 +0100, Corvin Köhne wrote:
> > CAUTION: External Email!!
> > From: Corvin Köhne <c.koehne@beckhoff.com>
> > 
> > Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> > platform. This commit series adds the Beckhoff CX7200 as new board variant to
> > QEMU.
> > 
> > The emulation is able to successfully boot an CX7200 image. The image includes
> > some self tests executed on every boot. Only the cache self test fails due to
> > QEMU emulating the cache as always being coherent. The self tests include
> > f.e.:
> > 
> > * Network
> > * Flash
> > * CCAT DMA + EEPROM [1]
> > * TwinCAT (Beckhoff's automation control software [2])
> > 
> > [1] https://github.com/beckhoff/ccat
> > [2] https://www.beckhoff.com/en-us/products/automation/
> > 
> > Corvin Köhne (1):
> >   MAINTAINERS: add myself as reviewer for Beckhoff devices
> > 
> > YannickV (20):
> >   hw/timer: Make frequency configurable
> >   hw/timer: Make PERIPHCLK period configurable
> >   hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
> >   hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
> >   hw/dma/zynq: Notify devcfg on FPGA reset via SLCR control
> >   hw/dma/zynq-devcfg: Simulate dummy PL reset
> >   hw/dma/zynq-devcfg: Indicate power-up status of PL
> >   hw/dma/zynq-devcfg: Fix register memory
> >   hw/misc: Add dummy ZYNQ DDR controller
> >   hw/misc/zynq_slcr: Add logic for DCI configuration
> >   hw/misc: Add Beckhoff CCAT device
> >   hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
> >   hw/arm/beckhoff_CX7200: Remove second SD controller
> >   hw/arm/beckhoff_CX7200: Remove second GEM
> >   hw/arm/beckhoff_CX7200: Adjust Flashes and Busses
> >   hw/arm/beckhoff_CX7200: Remove usb interfaces
> >   hw/arm/beckhoff_CX7200: Remove unimplemented devices
> >   hw/arm/beckhoff_CX7200: Set CPU frequency and PERIPHCLK period
> >   hw/arm/beckhoff_CX7200: Add CCAT to CX7200
> >   hw/arm/beckhoff_CX7200: Add dummy DDR CTRL to CX7200
> > 
> >  MAINTAINERS                       |   7 +
> >  hw/arm/Kconfig                    |  18 ++
> >  hw/arm/beckhoff_CX7200.c          | 440 ++++++++++++++++++++++++++++++
> >  hw/arm/
> > https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAACF1PqAcgZXNGoAAACSdE
> > 7DUYKKiipqQsJl32BC_vIVe3kQ23Cr-DKSrQn5Y_I0ZnsAu8qZHVUsGVmYwKL0amQboD-LYv9rWN-
> > mvEPUf2y-CZ1qrggzKI9xgbKnOi8XSPZVd2G0Lro-8fGR9tAuNB-3CWjEaKli0                
> > |   1 +
> >  hw/dma/xlnx-zynq-devcfg.c         |  36 ++-
> >  hw/misc/Kconfig                   |   6 +
> >  hw/misc/beckhoff_ccat.c           | 365 +++++++++++++++++++++++++
> >  hw/misc/
> > https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAACF1PqAcgZXNGoAAACSdE
> > 7DUYKKiipqQsJl32BC_vIVe3kQ23Cr-DKSrQn5Y_I0ZnsAu8qZHVUsGVmYwKL0amQboD-LYv9rWN-
> > mvEPUf2y-CZ1qrggzKI9xgbKnOi8XSPZVd2G0Lro-8fGR9tAuNB-3CWjEaKli0               
> > |   2 +
> >  hw/misc/zynq_ddr-ctrl.c           | 331 ++++++++++++++++++++++
> >  hw/misc/zynq_slcr.c               |  47 ++++
> >  hw/timer/a9gtimer.c               |  25 +-
> >  hw/timer/arm_mptimer.c            |  33 ++-
> >  include/hw/dma/xlnx-zynq-devcfg.h |   3 +
> >  include/hw/timer/a9gtimer.h       |   2 +
> >  include/hw/timer/arm_mptimer.h    |   4 +
> >  15 files changed, 1309 insertions(+), 11 deletions(-)
> >  create mode 100644 hw/arm/beckhoff_CX7200.c
> >  create mode 100644 hw/misc/beckhoff_ccat.c
> >  create mode 100644 hw/misc/zynq_ddr-ctrl.c
> 
> Hi,
> 
> any feedback for those commits?
>

Hi Corvin,

Thanks for the reminder and sorry for the delay! I started reviewing and
sending comments today. Cool work!

It would be great if you could include a patch to docs/system/arm/
describing how to test this machine.

Cheers,
Edgar


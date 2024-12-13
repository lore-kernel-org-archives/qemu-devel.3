Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509EAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBXH-0008O1-Sg; Fri, 13 Dec 2024 14:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tMBXB-0008KN-Ig
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:41:11 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tMBX5-0005uk-93
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:41:08 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso1529040a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1734118860; x=1734723660;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSiWKN+kCNpnqW7BHZfE2kBExQhRyMzULnhv8eAuOGE=;
 b=CdrraH/8pfpVp8OXxZNoOyAgtYU/q6vcGzLF0fVjGx2eAs+t3oT7i80k/N5ho53/Ov
 nBqaaicXIemG+HbN+w6crgmoMQOXxojND1/6RGOtPYH0s5gPD//CpiIGHMzk1iI4fUnq
 3tLAu9LjxSF6yug9NG11e7PC8Umit4ZJM4RjoQJO7haMNzQPWeLpbEdk9aAC1Ekqp2GT
 XZVR3BmPftmmhKqWFc0nGJjYFIb28EYfjXn3HIIisdOf/UOL2xPdIuZh9rP70IOoq0Ig
 5nAekOOTivsTVWXPrS1H0l2BPxlrnWn8oHjBvlhyEW8dc3/aOY9a9xW57ZlUJ1KoUmA0
 KWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118860; x=1734723660;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSiWKN+kCNpnqW7BHZfE2kBExQhRyMzULnhv8eAuOGE=;
 b=R0gKviX0TtA/nI6+Ebv374Ez/8FYG6xHq6gcbmPJu7Vc8TE5s5b4OD+XHYAK3i4Egl
 /dSbK1yKBqH2ajcsWKOvKeap3xAZx9jFtL1c4l9h5gzBNePE9agMkjYM1l/nfnuCaGx6
 4Uo4hLd1IIZrAoebq0CFc96BHraWEZ0vcffyUU7vgrv1tVEFhkBldvDBvBMQ+FkmDqXh
 VT9VT7kTRmWVA4BO1KWZrA/rBtCbfvWOxEGGdamOHC/aLPGNsxlgk3XkzquWheN82TMK
 fboJL+A9UlAxRqB8YKedwVdWtLY0gRcXhtAi8exSH/znoJM3BLVvq1MABPGj1vIfQT57
 Gc8g==
X-Gm-Message-State: AOJu0Yxx8Yo+jWbuqzUvGYW1PF/ENPIGele879tQFveHKHWJBVIm5qPK
 LZJeEP/idhCVnG0qGXeiz4iXiVjhgTSUa11LvQn5fBRpRP4tQT5IfoeQCrhmY5c=
X-Gm-Gg: ASbGncvsU2YlwjvwPw1BhqITpe+vYeKTy2wIy6dMJLMdvGZ2fgQspgSh826ZNg6SC+I
 6A+IajoMpFXYiy5dnkcf03kQUUUUjuUF9f4Gn3u9kdZHjZD6WYLoLg0NV5h/psSpoQNdRmqOeIP
 PrKjStr3SwiMzb4RpVy5L9H0bcLZH6pBfnY4knj3gJLwZXUwGvFooxvHIQZBr7rOBDRQkTdfFew
 mTAycO+mePC/slH+nsZSZw25YTpSW2fvZDfdFJn1+PHPC8Y4M7E3D7TfwIS
X-Google-Smtp-Source: AGHT+IGdcgl5KBSwf2/wlAC2BfeJcZBBj2noupbRvIRXOp18b/m164BCtQLXBF5b/c5xcMkktzXQ2Q==
X-Received: by 2002:a17:902:da84:b0:216:6a4a:9a39 with SMTP id
 d9443c01a7336-21892a86816mr62937595ad.56.1734118860277; 
 Fri, 13 Dec 2024 11:41:00 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8995:3830:b502:80f0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db58a8sm1380675ad.24.2024.12.13.11.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:40:59 -0800 (PST)
Date: Fri, 13 Dec 2024 13:40:54 -0600
From: Corey Minyard <corey@minyard.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 34/71] hw/ipmi: Constify all Property
Message-ID: <Z1yNxiQNsb4bMNCu@mail.minyard.net>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-39-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213190750.2513964-39-richard.henderson@linaro.org>
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=corey@minyard.net; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Acked-by: Corey Minyard <cminyard@mvista.com>

On Fri, Dec 13, 2024 at 01:07:08PM -0600, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/ipmi/ipmi.c            | 2 +-
>  hw/ipmi/ipmi_bmc_extern.c | 2 +-
>  hw/ipmi/ipmi_bmc_sim.c    | 2 +-
>  hw/ipmi/isa_ipmi_bt.c     | 2 +-
>  hw/ipmi/isa_ipmi_kcs.c    | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index bbb07b151e..850b3bc463 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -108,7 +108,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
>                               OBJ_PROP_LINK_STRONG);
>  }
>  
> -static Property ipmi_bmc_properties[] = {
> +static const Property ipmi_bmc_properties[] = {
>      DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index 29c5af3cc3..cfec1da87c 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -515,7 +515,7 @@ static void ipmi_bmc_extern_finalize(Object *obj)
>      timer_free(ibe->extern_timer);
>  }
>  
> -static Property ipmi_bmc_extern_properties[] = {
> +static const Property ipmi_bmc_extern_properties[] = {
>      DEFINE_PROP_CHR("chardev", IPMIBmcExtern, chr),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 33c839c65a..8a55893e89 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2191,7 +2191,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>      vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
>  }
>  
> -static Property ipmi_sim_properties[] = {
> +static const Property ipmi_sim_properties[] = {
>      DEFINE_PROP_UINT16("fruareasize", IPMIBmcSim, fru.areasize, 1024),
>      DEFINE_PROP_STRING("frudatafile", IPMIBmcSim, fru.filename),
>      DEFINE_PROP_STRING("sdrfile", IPMIBmcSim, sdr_filename),
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index 7b36d51494..16062abb31 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -135,7 +135,7 @@ static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
>      return &iib->bt;
>  }
>  
> -static Property ipmi_isa_properties[] = {
> +static const Property ipmi_isa_properties[] = {
>      DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
>      DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index f52b32e590..7e7a37659e 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -142,7 +142,7 @@ static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
>      return &iik->kcs;
>  }
>  
> -static Property ipmi_isa_properties[] = {
> +static const Property ipmi_isa_properties[] = {
>      DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  0xca2),
>      DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
>      DEFINE_PROP_END_OF_LIST(),
> -- 
> 2.43.0
> 


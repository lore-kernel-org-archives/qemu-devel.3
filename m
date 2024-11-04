Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A5D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vy6-0004YV-FZ; Mon, 04 Nov 2024 07:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7vy1-0004Lm-Es
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:13:59 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7vxx-0006Si-UT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:13:56 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-715716974baso2377182a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730722432; x=1731327232;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T8+iUW4Mq7BCALY550d+Q6CBglZ8UVI/03ElWqxZKhM=;
 b=SjaKssofqv9hFIzmeuTSOlMu6kJ+E5IrF89f4bNt3ErWfHbWugw+lLIqvWWKLlDL/A
 zeuyMJ/Sa28++SGJfsQ50UOVlADdu6x2on1nl3U1sYsghmmB8nLD+Vrj1zDGGHWs/IIT
 adWmVzHi4epTcjw/PCMBXYsIqxPqIwa9uUGGQesnODk94wAMkVijpEm9NMULe/uBBacM
 XoKa9LTb4usFfyocFxYR3Pn386VSAC9F/QrqNLDrypPtucvRd8nszGdjmf/2RLtSQ2Nl
 WI7/vhlj0btco/XAPEWn/+W2QAt1NopnMl0FG9Tt5B9slhG0xyR6Ggwn5DsyD8Z2c2Qz
 Ayeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730722432; x=1731327232;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T8+iUW4Mq7BCALY550d+Q6CBglZ8UVI/03ElWqxZKhM=;
 b=OrGmfUXsBsXitpMffhP8vUcRIniO5090BZY1Je41r9Mv9rhR7NBwqRkqaqKSvLXGlZ
 7XMWecj6C3FY54ITItg+WclWUnD4u64a1NZflD8HpfrsL7BWiaZ9+2vVoZgGF+N5/gNP
 daY+5501lE5/q8VDvOI8HjCexRvibq/IO2gIvdLa9R6GZ1qByOoS1aqPjXQCRhMOF9as
 nktXFsstcfowMgvmgKC76OWOCuZt/DU3oL06J3yVSic4lkDYfW3HOFNrEE/KQfnBSLiL
 pYb6tGIJPFCp6zQq+DGX7AaqWWqqv5bQfzYGhXXPACs9LGvGmwoo5utDFoM44d0CSbu2
 hLXw==
X-Gm-Message-State: AOJu0YzgX7ZiIJIc2Ko+ALkCenrDU1qTXAtRX40AP0sU3nHNmmeQ7XiJ
 vkukmeHXelXVuJaHRVcAE6GBJvucOMb7UO70Lzw4+kH9ruUWvT1NMm39JTQAAwY=
X-Google-Smtp-Source: AGHT+IHRWMkGt9pA1xJkzq/tlvvWHW6vsgOdWcd4PSR8PNbNEzUh9w1iPWzdDXtO/qd/eA4WePAF+g==
X-Received: by 2002:a05:6830:438d:b0:717:d5c6:d593 with SMTP id
 46e09a7af769-719ca23f4a2mr10140312a34.21.1730722432694; 
 Mon, 04 Nov 2024 04:13:52 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8f65:c09a:8672:74e8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7189cc69c51sm1943590a34.21.2024.11.04.04.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 04:13:50 -0800 (PST)
Date: Mon, 4 Nov 2024 06:13:44 -0600
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Kevin Wolf <kwolf@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 12/26] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Message-ID: <Zyi6eKPFGiEuguuZ@mail.minyard.net>
References: <20241103133412.73536-1-shentey@gmail.com>
 <20241103133412.73536-13-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241103133412.73536-13-shentey@gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=corey@minyard.net; helo=mail-ot1-x32b.google.com
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

On Sun, Nov 03, 2024 at 02:33:58PM +0100, Bernhard Beschow wrote:
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/mpc_i2c.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 3d79c15653..913d044ac1 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -20,7 +20,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/irq.h"
> -#include "qemu/module.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "qom/object.h"
> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
>      dc->desc = "MPC I2C Controller";
>  }
>  
> -static const TypeInfo mpc_i2c_type_info = {
> -    .name          = TYPE_MPC_I2C,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(MPCI2CState),
> -    .class_init    = mpc_i2c_class_init,
> +static const TypeInfo mpc_i2c_types[] = {
> +    {
> +        .name          = TYPE_MPC_I2C,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(MPCI2CState),
> +        .class_init    = mpc_i2c_class_init,
> +    },
>  };
>  
> -static void mpc_i2c_register_types(void)
> -{
> -    type_register_static(&mpc_i2c_type_info);
> -}
> -
> -type_init(mpc_i2c_register_types)
> +DEFINE_TYPES(mpc_i2c_types)
> -- 
> 2.47.0
> 
> 


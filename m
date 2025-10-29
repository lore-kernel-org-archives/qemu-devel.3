Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1kP-00045h-3D; Wed, 29 Oct 2025 04:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1kI-00043t-VP
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:41:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1kF-0000D9-UF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:41:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so6610363f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727285; x=1762332085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vgl0Yt4ZV8NkBUtU3DzClsvavleBD6rKJ6k51EvvKK0=;
 b=WcHcsMr8oJZ7Xc5gb3P1XdPYfawY6sCFWIO7KwK7KRsaf3/bLsJ+Hr3JbUKkibvJRx
 Z4zky3TSm91Gl77En9X/sWFP6SF2fsA8gGuE0o09dptFvdObWx+ORMmp7PhiPe29mk9r
 a3n3dvr9Unur8IoO40oM5TzEpHMY3sTDPutkME7IWZIFjdq1eVfq8FkPfiS864PpsWSX
 gm/jqyZ8dqyguy0sI5JwI/H+BAQie37akDBomgDQE0bxBPOLKolRQkpdH4ipA7flGWSS
 Osi6jE4Zw+17iMKFvucCWiKAd92NPHEZywoc+83Te22iNEKe/wAJar6/RO5jLTYMkx9q
 dbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727285; x=1762332085;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vgl0Yt4ZV8NkBUtU3DzClsvavleBD6rKJ6k51EvvKK0=;
 b=O1EDbuF1kYRAmK9dVV999fwS2oPUOGTCG5iwJBs+PbpZ1jv/FtRMVOsmJ8I+H4Vvv9
 LC2U7Z64xsF3qxtprRZVXiCb8UmrRFKQziJRuKv5A9A1yBK6NqM1rpgWr+p0oHZYFylZ
 mwVA+gPsB9Y5iw0axhXRvsHFbLFWzDXEQAx7/4NMz/Wak+jUBkBG/ChPA3QS9iwaEtWO
 ZAShp/dCTwpl2Ex1XFOiUYaKbrJZzb64PrhnGBFR0Tpg0laSFhg5z+KQoAqNr2kKo/Yl
 GD0oeOZcxFcYOfw16qgaTA+Ik9gO/6nVKivMYxQI5Vh4FjI4lmxxz0iHxYJ63+1510g3
 0h1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzV41SBZgSietWzcTOlFC9NTmFiVdmFRMR2E8y40bd0ptidv5gxoaL4FJ+6llQNwTKIpUfE4QxizI@nongnu.org
X-Gm-Message-State: AOJu0Yx2Z8a0o0sjDSNQGSWV0kyXO18jvFowtjcItRCWaPhDQBESXNiT
 ZRbWKFRSwTI1aeL0qIAuVJTzjakf+DxwXVf1TCfGktzMc7douwwnnncUQ5fYomLVvANlLYOmsrA
 pG3CimyA=
X-Gm-Gg: ASbGncvsS4cIBGaG9rsxQEFjbgpVXFkDBvNIHtdfM8kFzB2tLZRP35FKqjQ09emo96+
 U4Soz+eILLMaKQ05iqO5c3HesNaetRHM/cdDxoRLgdM/ElZTcRiBGbU1JQ5H1VvwC421AzQEuJ8
 VLYKv3GYoxMrv2Pwr2UaUq/7BrHKzTOi/znro5IyfKsBbR/wC4/gJORregUEFAuK2NgF/4/VcC6
 bmDbsCrKiUj/tiA11za6GVbjlfsGZAUzkWgZEYSuLy1aZh4Qow5UsJvLziBJPkfgz9lSX8p+OyE
 zbtKpghYNZud9yC3dYAF2lm3c9sDSQPq1/g6o4bcutlcp8PYMOboACA+27shAWqbdY/Oh4vhGLJ
 7ojtKBFQvtSyjwiT+OGmgUrV3bseXUnpO9mebF1d7cOfpEQEVSNyoIO9VNZxwGvjHJL9oFoRLB+
 GHeZ1i8G7RbikUqgay
X-Google-Smtp-Source: AGHT+IE6EaKSt/5v29pWj5THsFdk4bnk3iydTf783kKIRWjLeEVgk2pec9gwCELqt4pKzufnuHzYrQ==
X-Received: by 2002:a05:6000:40e0:b0:3eb:c276:a347 with SMTP id
 ffacd0b85a97d-429aed377ccmr1242297f8f.0.1761727284779; 
 Wed, 29 Oct 2025 01:41:24 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e22280fsm36961355e9.14.2025.10.29.01.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:41:24 -0700 (PDT)
Message-ID: <22e5a655-75fa-4716-80ed-a455116c32ac@linaro.org>
Date: Wed, 29 Oct 2025 09:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/25] hw/acpi: Use memory_region_get_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> +++ b/hw/acpi/cxl.c
> @@ -105,6 +105,7 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>       PXBDev *pxb = PXB_DEV(cxl);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl_host_bridge);
>       MemoryRegion *mr = sysbus_mmio_get_region(sbd, 0);
> +    hwaddr container_base_addr = memory_region_get_address(mr->container);
>   
>       /* Type */
>       build_append_int_noprefix(table_data, 0, 1);
> @@ -125,7 +126,9 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>       build_append_int_noprefix(table_data, 0, 4);
>   
>       /* Base - subregion within a container that is in PA space */
> -    build_append_int_noprefix(table_data, mr->container->addr + mr->addr, 8);
> +    build_append_int_noprefix(table_data,
> +                              container_base_addr
> +                              + memory_region_get_address(mr), 8);

Why the single-use variable, instead of expanding here, like what you're replacing?


r~


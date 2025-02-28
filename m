Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEFFC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwbq-0007NF-6R; Fri, 28 Feb 2025 04:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnwbh-0007Mk-PZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:24:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnwbg-0000ab-26
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:24:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390edaee0cfso354491f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 01:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740734670; x=1741339470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iaMHiEb05oyt2mCp0viJbid/xM4tvGxDqdg5qDh17i8=;
 b=Q1oCBaSiDCPUYpHWyl0r7M/k6suLY64rVcYOHakBB0uQKwAEM2ikhMKAESiZaA00LQ
 k7sd42fUJHk4Ew46ZNChuxS+70rPV1BepTi4v7+8e9wLQM5zOnLDS8YFyX/vApseK+RJ
 v2E9pjYX7YBwRXFG057dyR/QPn2tzsjnBWVAgwY++OHVtcoyhfFJDpjbG7zp7bGL/Q76
 4ET96INQp6i3WraC6yFLWdha09K4T8il0NSIoFJvD2DcNavqxErhQAE+IZiLiu+wlgyZ
 B6aSSnjxBhh3R6cT+Oc/UfRIaj3era11liAMy3Rc5uZsxHe/hY6KKI4/Pj7V3bGWTvYP
 Gdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740734670; x=1741339470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iaMHiEb05oyt2mCp0viJbid/xM4tvGxDqdg5qDh17i8=;
 b=WgjniWadnCIYdholL4PSr7s4t+hj67d6b1fPE/wyGvro8lOTNVUb6z1sR+PCo0qLJH
 dFS/2nPEiA1oJWMv1fNy5kEJAiDkkEjqYJT4dcz+uKnGAgybtd2Zhws40bGqgGNVPPVw
 FaswFnGQH+3H3XdMm9U9IsZC2/MPprxWym8PkQy5d49O8Mn+W4UGG89h6CRuRgUZjV3x
 LYBkaCp3YzSDmeFQ3qOYGJPfSyFtRCgv8+P+a5K80xA966660CEKRDGfpoVD0iyMNh6J
 UBlwCceHmxKmCmj1NgEQnoNylmIS3Ece0XKS4wY1Le6Sq50E4bvV3wV5emTHi/a2GUPr
 9ssw==
X-Gm-Message-State: AOJu0YycXKT3cxzMZ7m2GVbONLS1KHWF8cp5K+XcXx2/NNa2RwGpCdEZ
 FW1oSrWhhp45gNSXwpgkRjLPlHiwpePUicrxzfQf1h2A/wDNXngYe2d44m6+8GY=
X-Gm-Gg: ASbGncsR1+3nrMQqpt2C24zsDD1tkm7mTgHIzU2PKzFmxEr8HPkOSrP0MKWi5otbSyF
 xjAbiuAcmknhIBMC+em5MX3Qlb/IBfYAQyyLoFJWsyrwjQKIRXJEoWmYQertYnzdNByFFX+NCse
 /cUHlpgy3tWfdTvWxi1PnC29MrmnTHKr2Hx/YYRZM8Awlk7uxxl5k+jZrPQP/Pe3LNGdIUktLde
 taFcRcwLrmYa63IF8wctp/+01bIvnxBbeRWX8juwKg1BVunkML25YM/chPdS9T7o70JKhhY9kRV
 AsNX2+O7wEUB5dcqQsLwOZHyNU7Q4N5oR/Mpl4i8wx7Z9jAVsVxOuUN9QqXVPdjgNWKw2A==
X-Google-Smtp-Source: AGHT+IE9RVJVeW0Xk82kNvLWrfrAcQl1MwjoonvKmHM3s8iu/7yLZMNipYC0LLCp8I5ofl5PsoSbpg==
X-Received: by 2002:a5d:5c84:0:b0:390:f1b5:e619 with SMTP id
 ffacd0b85a97d-390f1b5e6dfmr758158f8f.31.1740734669951; 
 Fri, 28 Feb 2025 01:24:29 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f75c6sm50182935e9.1.2025.02.28.01.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 01:24:29 -0800 (PST)
Message-ID: <c6bf97bf-df26-495d-9886-dfda55cc99db@linaro.org>
Date: Fri, 28 Feb 2025 10:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-pci: fix memory leak from device realization
 failure
To: Zheng Huang <hz1624917200@gmail.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org
References: <7702b335-6e92-47c7-baf9-a384f75a0db3@gmail.com>
 <69cb6f19-d87a-4ddf-9fca-612b30828679@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <69cb6f19-d87a-4ddf-9fca-612b30828679@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Zheng,

On 28/2/25 06:03, Zheng Huang wrote:
> This commit adds failback routine for `virtio_pci_realize` to
> fix the memory leak of an address space and the virtio-net device object.
> If the realization of the device failed, the address space should be
> destroyed too.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2845
> 
> Signed-off-by: Zheng Huang <hz1624917200@outlook.com>
> 
> ---
>   hw/virtio/virtio-pci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c773a9130c..4b0d8cd90a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2266,6 +2266,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>       virtio_pci_bus_new(&proxy->bus, sizeof(proxy->bus), proxy);
>       if (k->realize) {
>           k->realize(proxy, errp);
> +        if (*errp) {
> +            address_space_destroy(&proxy->modern_cfg_mem_as);
> +        }
>       }
>   }
>   

I think instead we want to add an instance_init in virtio_pci_class_init
and move the address_space_init call from virtio_pci_realize there.

Regards,

Phil.


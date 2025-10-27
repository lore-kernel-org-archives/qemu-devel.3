Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F32CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDT5L-000273-VD; Mon, 27 Oct 2025 15:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT56-00025T-R0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:40:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT4y-0000Dp-BH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:40:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475dd54d7cdso8727185e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761594025; x=1762198825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5brc5qyLbooxSabCjlWZku5y1ceMf1JYxwGzirNblyg=;
 b=WieTEGPGK+A91sSSN+DHuRx2qFb1QvhXtdzYeUeA8Ke2TKXo5iw4XGzM/BBhujrj7T
 aVXUdvVkU4YGiacIumCl4P2qyRIOpyPvtnffySlKPTxC5Mypm8wYW0iNnSLORPHsv955
 XwRtUH0Wuj8evd52fQ5n/OI8jofvJukBDV+odqMnmVuuegIsgoTLM+X4Ak9giA2btAJF
 vtJ18EYfTmmVgT/sU0SpQPA+lTqGOxu43y6qodcsPtVxdK0Oz8NSB4eEwEGCX1BlEy1I
 wjPKokmxmeaQ0MW0H5VgLr3s/CJyzmvemsEqH33Jkan6ZpeVCErAULy/dO6Bl6+0ONAD
 Dqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761594025; x=1762198825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5brc5qyLbooxSabCjlWZku5y1ceMf1JYxwGzirNblyg=;
 b=mHaYO6E748DNUrkO8tNebMrZMomZvJeG78G2jaKXLehURZNz+vEf8zAAr87+LWDk5m
 SnCTGwsTkK/kpl00x/JKCN60mGBVhHn2liWwC05rZZ1Jt6EcTVi7nJGpIDx92yl4SHDa
 l31Wm2Bm/GuL4Me40tkuGLCgO6OfORZ23eXw7GPVK7NlJrtq7D3iedcMcfSyXYc1vFr3
 AfRU2eOe5ct0BbM9KsEdI5mhTfT54NejGehlH5Lu7iI+5JknurU0hqQ+PWVf0mK4bb3g
 JOtLWsy2hN/nhXYcFhj37tOTdnfdDSD92DAR21Bt1m4C9ZY3XTzwRBpYmNkQjIkt/JLw
 Tb+w==
X-Gm-Message-State: AOJu0YxjjYUixn+ezG+Op2IZPdZVNX/YRwq9lOSxw2GgPDTPbMk2whuU
 WCbfqLYvfOlgFYUSu6VzAJVNlIK1PcMUom2S0eu8Sst9NxymGnPnj2idFD8X+3dmfqZQgEPX/8e
 lzIvOhlc=
X-Gm-Gg: ASbGncsfMvG/u0LUhX1Ez1L96qu7iV+lJQxlpn4xhAzBW6Sb6Ipc3Qon1eSizpEg95d
 HAwmktxcXnHTdZ2cGsnPBjDqGgHyYSUZ1wHp/8gERiIHWn9spzqo3HpW70Q2ox0hnsDJ1FoumvN
 RKy50pJCFySEut6Ao71ognzAl/TOjEZtt6thCc54B1pjtMZKCoYliintmIIdZE76ckVXZzLp8Ks
 HIOQZcQDmVMksfymxRKsO1Y8HqrDB9iq2d4G/ephaKfzbojOeAKQThxtB1cBUSmEh34gCIrgPrc
 KzYgQg+UGchcGmHOYqb3LCCI9Kx2UxoTdJjPuOTv8/hStQBSqqhfNNeh3H9MZ736B3KshF/DZZT
 nUKVNSuiCdtK0IGohaA3wj3Stoj+trD+TxguidZi0oaEAYkOqEKde6h1H5c/6qH0DJ7/oDBbZBg
 59WvXe/41GCzLthlx72+KUFYJWp+QXn7v39b6JZEkBKTo=
X-Google-Smtp-Source: AGHT+IEcN/DKny5fmLBPSD6ormwN6HPLeG4cZiM9KGf3kCN1b/B39lDV0CG8A9Fjn7kkoY7J2kuQmA==
X-Received: by 2002:a05:600c:524a:b0:471:ff3:a877 with SMTP id
 5b1f17b1804b1-47717e414afmr6557625e9.20.1761594024656; 
 Mon, 27 Oct 2025 12:40:24 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da12dsm16121824f8f.29.2025.10.27.12.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:40:24 -0700 (PDT)
Message-ID: <6106f968-4a4c-4fc1-a7e5-ab3955adf259@linaro.org>
Date: Mon, 27 Oct 2025 20:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/arm/virt: Remove virt-4.1 and virt-4.2 machines
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>
References: <20251020094022.68768-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020094022.68768-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/10/25 11:40, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Do not remove virt-6.0 -> virt-7.2 (danpb)
> 
> Remove the deprecated virt-4.1 and virt-4.2 machines,
> which are older than 6 years. Remove resulting dead code.
> 
> Philippe Mathieu-Daudé (4):
>    hw/arm/virt: Remove deprecated virt-4.1 machine
>    hw/arm/virt: Remove VirtMachineClass::no_ged field
>    hw/arm/virt: Remove deprecated virt-4.2 machine
>    hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime field

Ping?


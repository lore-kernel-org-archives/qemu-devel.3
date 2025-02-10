Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C77C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thREJ-0005yC-D8; Mon, 10 Feb 2025 05:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRED-0005xr-P9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:41:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRE4-0005ji-Pw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:41:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so28035225e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739184074; x=1739788874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5vV/pedvfnOn86zLj2OiqLzvsqlX7k0iGoIW3Axn/Y=;
 b=JN8kQrgiMwVg4ccOE1kj9k4wQpygYoyPCu4ZYD08dD+P4q2pM5eLtiWCY9Q48aDnYj
 tmcAeJUbwH+2qxhNzvBkw8xjVDQ5w8t0QEuRLEK6HsLGKBKJ0jscWK0oQreqhFIhr+cF
 9ze53F6OU0+uu/HbayOQxNeE3CkDOW4I5X63DCOtsWp87QKPTAejmp/mtacO8sbLtk1g
 auNCQYvYZ1z30QJcXv4JSi8qFuwnrJyI4Te/qKKCy4NQ3nLEWa3j+UAQc/N1IE1q2+Us
 xYuamX01FeqweVIDRnE4rtKrofvctXS9S++k3f+AeN/FYn/9QDtQEVm5cIpXPgpo1Qgx
 kwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739184074; x=1739788874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5vV/pedvfnOn86zLj2OiqLzvsqlX7k0iGoIW3Axn/Y=;
 b=ZiPKv4JXiIACooC2CK8e9yVa/ABBhnJgK3yE66gAuO88+g8DYTaAlOmbx7Tzwj4AXS
 Hgga2z4km/KtHdRlhJgceYODrqj6BtpcdsroMsXbYcX92ahXVM50lNgpanOE/vgOxHCw
 1R3apFGekjjvIhuAo9VnfaJ4RpyhZL7Z+A70SGDVINHCZJHA5MFJ+9bbLR5MmxhPYA8e
 rCAaCpdDfGSdknoMn0HcQiLBaH4L2zLs1B1RMvbvY+OM1GxspKJu6M9CkHLWjkP4mI5r
 i8uk9dzd0V2nufHvZF+x/2EvwzMiRu5RHSfEiZ9szgTeJVbRysUkpDVrg3FkUd9A1/om
 529Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX085v17KTVcoLBgFpkFiImQb/TbUKo15LUqPfqKE0Z0qaB5vwclVs7zfyM1Ect4I1i9t93vqT75ACv@nongnu.org
X-Gm-Message-State: AOJu0YzYuzWDzzAFr60oWJTd00NGELkP3dLAWjzrZ38Y30bvgABE2W7H
 nYMs2rdwIr25Qxh/1DdyYyihYq6bbSzeQ8EEeJyR+twn1s0q7uVSD8HmYa1Feu4=
X-Gm-Gg: ASbGncuOx95/JKx4Atnqp5NQLsUm/dpS7odUVMWpZoPBzUw4gb3MpVRac144WCgiUDw
 ki9HVixYdju/PFR8FYVD9bpFO0Ap/IPS0oA/qPtd+B7IRoY8ufm4HMxGE/0u2Hz6hSNVx90cM7C
 oGauJOGYj1b/iBL43DvUaqIUxpCaoAY3o+GfnmidiwVoqdvx/32dg9LXqVz5WTtNtUtM+gdAkdZ
 07n09lieRO/FSYaw9d1aiBxltJgmAI9z7ZWs207qgCg3KPXauDiON+Za5kJvJDgi943NGSmVZen
 BZ2tC6XCCyTnPq2SSxdIanLWbexdqqtXYgLhIniY00Gb+NSF5ezToRgC1CPlcJxF
X-Google-Smtp-Source: AGHT+IErQh+eoDkNcSK23ifuVK1WXIttMgeBAaMbwgo98CN7Jb/6ibyb81nKXdjUuxhA8YrkOpVYuA==
X-Received: by 2002:a5d:5888:0:b0:38d:adc2:110a with SMTP id
 ffacd0b85a97d-38dc935f09emr10928127f8f.43.1739184074127; 
 Mon, 10 Feb 2025 02:41:14 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc3a10fffsm11032418f8f.12.2025.02.10.02.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:41:13 -0800 (PST)
Message-ID: <0d920309-c7ba-48d8-b46d-04ac1e38efc7@linaro.org>
Date: Mon, 10 Feb 2025 11:41:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] hw/loongarch/virt: CPU irq routing enhancement
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
References: <20250210093632.3274012-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210093632.3274012-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Cc'ing Igor for vCPU hotplugging expertise.

On 10/2/25 10:36, Bibo Mao wrote:
> Interrupt controller ipi and extioi on LoongArch system can send
> intterrupt to multiple CPUs, physical cpu id is used to route interrupt
> for CPUs.
> 
> With cpu hotplug feature in future, notification with ipi and extioi
> interrupt controller is required. Since there is common Notifier API for
> CPU hotplug, cpu hotplug interface is added on ipi and extioi class for
> notification usage.
> 
> With CPU hotplug event notfication, gpio irq line is connected to cpu irq
> line, and irq routing for irqchip is setup.
> 
> ---
>    v1 .. v2:
>      1. Combine patchset ipi and extioi irq routing enhancement together
>      2. Rebase patch based on latest version
> ---
> Bibo Mao (7):
>    hw/intc/loongarch_ipi: Add basic hotplug framework
>    hw/intc/loongarch_ipi: Implment cpu hotplug interface
>    hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged
>    hw/intc/loongarch_extioi: Move gpio irq initial to common code
>    hw/intc/loongarch_extioi: Add basic hotplug framework
>    hw/intc/loongarch_extioi: Implment cpu hotplug interface
>    hw/intc/loongarch_extioi: Use cpu plug notification
> 
>   hw/intc/loongarch_extioi.c        |  8 +--
>   hw/intc/loongarch_extioi_common.c | 84 ++++++++++++++++++++++++++++++-
>   hw/intc/loongarch_ipi.c           | 71 ++++++++++++++++++++++++++
>   hw/loongarch/virt.c               | 17 ++-----
>   4 files changed, 159 insertions(+), 21 deletions(-)
> 



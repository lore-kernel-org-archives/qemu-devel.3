Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F82C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 18:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyE8c-0002wi-Gp; Fri, 28 Mar 2025 14:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyE8V-0002wD-Gq
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:08:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyE8T-0005y4-T3
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:08:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1203257f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743185332; x=1743790132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0oIoA4q7TaRpyS5DbnNoYDXiuomcmhh0mVNt1Wg3Oo8=;
 b=swVPbC4KAfYnYgylXqABXmraEoqYfxvtOO3Zmkv1InbFKdT64pL/9X0LugYmWYg1xO
 4YellYRO3y+TcPFcW+zd+5n5BvLCUPIAHUteBKQJm1AwbVFi1ugJwNl8HtwhAoPQOk05
 iK6UUJ1BrWJXelirqW8AbApJiPoNkfu5Beuktt/hIFKbd+ym2pxBtrD+vEDCGMnfHURM
 a+5N9uP8rkcQye+haZKG3slRkiix4KLViCheRT1A7A48tVaM1TXk4C3mAAr++MMXboDG
 h2yi/vqJgd/By7Hi+YV367GfPmGtIbYXRluQnZBEWZA9QUkEXAABYpG23ndHHUeH9aHk
 wuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743185332; x=1743790132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0oIoA4q7TaRpyS5DbnNoYDXiuomcmhh0mVNt1Wg3Oo8=;
 b=AjawLb1i1ifMOjGuDwjr0ff+IRjHsfzQo4dc3csBX0IOTw8u3zijsmW+6tTpJdb96N
 t7vBctusSiUwP/qrcqDu5/zYxVLWo0Yf1xj9SytjGy3lqKR+spDkCRU3/B1aGxHtFJ4u
 gRamFnbho3QUWUkaEwNiyFJ+zDLeksVxokFvxWqFhQMorsbfshLgA4uRFXQ3sBH6m6at
 qTN3EQ5WXw0h18c73AaTajwfmzBte5pnBfU/eux3yWe3iTQd6I+wFRvPNDJCFPGjieNT
 5/ATG071F0ULw28Z/XEPLjWO39kd6j2IgZ2aivXezj2Nk3dcPeQ4qNqwQgVwNmX8nuWr
 Yyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtvmGkVGv3uWBujfS/7lNd+V899Xdj4if6vphbHqjDaNkec+Ls/2dx/adK/w4M/QO5Y2id91bfyWHF@nongnu.org
X-Gm-Message-State: AOJu0YzG3T6ufJVpzdwyL+BybQzKNu+YQgPZRiEPHzLYydCf8p2W88k3
 cVxE6X9y4UYHS6sxFw/C5H3Wm4/Be3KzMJIxb6/5Igis5ZF18ZwbD6VPBKtFoks=
X-Gm-Gg: ASbGnctiYoNWL7ryIPLRcPqih/u4Fq2Q55a0E/tVn51CgJSgfatTCwNbM2+xgq9FOHk
 OYlwbGmld24pq6qO3xu80VmI3W+4YQ2btZQkeOe4fEDxRmzgdbtwg3HcezNjKX5pzkIocbt7nnd
 az8rRsrxmCOi4AN34lvG26VHPhM8IKjO+AnJk0PSHZI3yIyxPbu17UV5PycoaNCTJ1oMYpJHcjs
 CxQrwQBUI4ppsr2V/aengASGtZLN6rRsR8ZbPxZ9M9/lSR+F6uF8oRN580vkF0JIjU1D+MkkWqz
 JGbEkyIXrTIl7skuZbhCyi+z2/VXaiYdCFJuZis59Csswb5qkkA9Bcpk3TNDWHDHNdLfeuD/ASp
 UuNJNkW/Aeyf9
X-Google-Smtp-Source: AGHT+IELU16a89VX506ASgvuEpNdV/KDlZEFwanBrNj3WsJUN9EhhkbBGqiGz3SyCR4x8f+Rhb66Aw==
X-Received: by 2002:a05:6000:1849:b0:38f:28a1:501e with SMTP id
 ffacd0b85a97d-39c120cbb75mr106964f8f.8.1743185332102; 
 Fri, 28 Mar 2025 11:08:52 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d0dbsm3319973f8f.58.2025.03.28.11.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 11:08:51 -0700 (PDT)
Message-ID: <1d793241-f047-43d6-a1c2-1de5af954910@linaro.org>
Date: Fri, 28 Mar 2025 19:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdhci: free irq on exit
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 28/3/25 10:49, Zheng Huang wrote:
> Hi,
> 
> This patch fixes a memory leak bug in `sdhci_pci_realize()`. `s->irq` is
> not freed in `sdhci_pci_exit()`.
> 
> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> 
> ---
>   hw/sd/sdhci-pci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
> index 5268c0dee5..f5296d58ca 100644
> --- a/hw/sd/sdhci-pci.c
> +++ b/hw/sd/sdhci-pci.c
> @@ -18,6 +18,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> +#include "hw/irq.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/sd/sdhci.h"
>   #include "sdhci-internal.h"
> @@ -50,6 +51,7 @@ static void sdhci_pci_exit(PCIDevice *dev)
>   

Better move the call here, do release in opposite order of alloc.

>       sdhci_common_unrealize(s);
>       sdhci_uninitfn(s);
> +    qemu_free_irq(s->irq);
>   }

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D7C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvkz-0002hS-Si; Mon, 17 Feb 2025 02:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvkw-0002h1-5d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:41:30 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvkt-0005Ro-Gv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:41:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so26060025e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778086; x=1740382886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dkTo0pfmOHp3OJMdzD9AhPWcvu/zBhM18egGaYBoM9I=;
 b=QaPnc4L41hgisXVTCrlC5kakl0vCOcSpA8daEvWt97glYjRd4wwqjI3i10b09qmPIA
 +2B61EfZVIiDOGVFS+EDQEz1ardyXuMZFtx3ZaCtKf9dltUVzXuqExKHUTcn1QUxddRP
 gTw3U++Yj/DRZpFxp1tld3iQY0YapPdBsX6nDnWC89yhuxsYA1+OOY6S2Faj1nzwD18/
 P/qdDN0H72a3omL1K6E/a16zPKFzAHSo0bgEYt6lt9zlTJDoRjkTZpzZ3Vpfr9BZpgLU
 /bzNsKgONzcQ9Z5/pI5ZyZhDOip1H3bLjHEu22zCl2ucXj4sv9ihJ4ehzUGQVBO0J6SU
 efpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778086; x=1740382886;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkTo0pfmOHp3OJMdzD9AhPWcvu/zBhM18egGaYBoM9I=;
 b=i4lvuyfhW9H0ffuL4fHCzy4yONXjfAkjwa/prmFTFlMBy5z1QaJCdpUmIuJ7EUp/eh
 1aE8vamq8EWnFHsBMKYfVdoDArhArMyU/7AbHL9TyKDFkyVDYpqOt7e3JFH3zmSXEzM/
 rEA5oKuZ5Yjm2jmpKeFxA6ywQHp/3RFc0kuEQrqFHb2vmxUChsN8jVWyPfGGw5j0u7eg
 OyL8Kja4TqgC/QJx8n52dErAcKYVjad1T7vB7mxE4s7DCoMjVht9GKnwxcE/6fjz2T0+
 AmQ9qovVT/+hlxKutBlGb7A5zahUwqUlVKwB3zmv8ce9z5SxvuH/foc874w0uuqCiJrh
 QiBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6m0193ccdRaPOXWO5PxYyziY1OHKrKVByJwLjVyZSuEGmiT6UjbfCroLJ1lctMy/MzbG7kmksP9Xo@nongnu.org
X-Gm-Message-State: AOJu0Yx3m4Dv2MPB0LlF/cbxOKQbRfGc1NPMMZ1vwoS2nRNBSHKUrh9s
 TGI2HNcLV6ZrRg0598LmugF6hCFtfFlaa4M6DjYcm65HzIqndbNxBHgnYqVe7nPvJ03KjIbwUy+
 j
X-Gm-Gg: ASbGncvl9i9Z8/UDWJjldnI+NOecq+emdQ3QkrJ6bQAcAp9wl7I+EIw47TDZ/l6XADo
 iuCFKB7ig8/EBd1vZSbWvihZPTSKIEpTDZmzNoGxK3imSgjl0yeyVpPUXp5Hyaw9Lx6d9DVq1kf
 okP1N313Qeuyhk5f4oF06E9P5QH63dc3+9FY+DpW1OyeHhby7CCEt/3BVHK76Rt3EMgYxFIMvsh
 doysc5+Oj0jGOdXeZP7Yxhctyn7EurYse30SRwrCkySShcPpOHp6pnKkFAbk1h3Ik6vV5jghsya
 jbH7tovkL/2cfLzTH+k3c3wBQD2y/nPskUg=
X-Google-Smtp-Source: AGHT+IHk1Px5zBltEq0Ecmjm1zqFD/spoE/OMdZhPSckfJkTpd3GQQf4nccfLDXVbmrcUfTvNb9xcw==
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d017 with SMTP id
 5b1f17b1804b1-43988bbd458mr8724425e9.6.1739778085620; 
 Sun, 16 Feb 2025 23:41:25 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7c7sm145994245e9.27.2025.02.16.23.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:41:25 -0800 (PST)
Message-ID: <03b45083-6dbe-4ef9-a31d-6a2deccc8e22@linaro.org>
Date: Mon, 17 Feb 2025 08:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/rx: Reset the CPU at qemu reset time
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-4-keithp@keithp.com>
Content-Language: en-US
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250215021654.1786679-4-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

+Peter/Igor

On 15/2/25 03:16, Keith Packard via wrote:
> This ensure that the CPU gets reset every time QEMU resets.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/rx/cpu.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 37a6fdd569..04dd34b310 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -27,6 +27,7 @@
>   #include "hw/loader.h"
>   #include "fpu/softfloat.h"
>   #include "tcg/debug-assert.h"
> +#include "system/reset.h"
>   
>   static void rx_cpu_set_pc(CPUState *cs, vaddr value)
>   {
> @@ -129,6 +130,13 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>       return oc;
>   }
>   
> +static void rx_cpu_reset(void *opaque)
> +{
> +    RXCPU *cpu = opaque;
> +
> +    cpu_reset(CPU(cpu));
> +}
> +
>   static void rx_cpu_realize(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> @@ -142,9 +150,10 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
>       }
>   
>       qemu_init_vcpu(cs);
> -    cpu_reset(cs);
>   
>       rcc->parent_realize(dev, errp);
> +
> +    qemu_register_reset(rx_cpu_reset, RX_CPU(cs));

Yeah. I guess this is part of some generic effort to generalize
CPU reset, previously started here
https://lore.kernel.org/qemu-devel/20230918160257.30127-1-philmd@linaro.org/
which led to another issue Igor is trying to solves:
https://lore.kernel.org/qemu-devel/20250207162048.1890669-1-imammedo@redhat.com/

>   }
>   
>   static void rx_cpu_set_irq(void *opaque, int no, int request)



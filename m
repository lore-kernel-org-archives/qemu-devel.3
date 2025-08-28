Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO7J-0006dm-I5; Sat, 30 Aug 2025 12:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkvF-0007us-Sb
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:16:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkvB-0007gQ-Qw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:16:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso7802475e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756419399; x=1757024199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z72tKFweJRb7XkCpknvHl5t2yNXAYpWjnXkbNnxdkPM=;
 b=OsHA0K/7E271dGxjmFevJ5iqCtY2bM0IX/IDzTxj1Tow/ERw/1NuXHerrzYgzrbEL/
 gsojUTicYtynJRJxPzmc6j5laZchZ2S/+z1XjlSNgXYXPXeWSuNSsIrr/wSO7SqYLyQw
 LBy6FN7npa3z/eeK3BdSPA8Xi2DMctSKIR2fMl9X1xwQljOmYYz9gyp84hOfec0oOAWc
 0244jc9k1tguZrEa63n6XTQGZUxsQpL7e2fzQTHMzRWZOMO0MxKYB56SlPqVLDEIGaOL
 t4xsLvrhMiJeojaTXUG7HrrMQAqzoryH1nkIwHDsEc8pMIq7tpnqNzxOQdr6SueU59A3
 JU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756419399; x=1757024199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z72tKFweJRb7XkCpknvHl5t2yNXAYpWjnXkbNnxdkPM=;
 b=B/8cCzriCCzyNgql/LL2MgNLEWS+YBbTkqV5VnukNiaovRcwPmeNy0AtMrjNFxJxVT
 wH2aKir3f0XGwGTYnvYCbGDD+x7RS/6kR5lcrFD3yy2Flu8uFKo4khdcdvfuPy3h7wkQ
 5N+Q6+hZMSEgPc6RBWwnWhhnnx5/7BDOwC8x6NzmXp4aRP/JdmAs8lbZ0frWD9Cp3lPu
 YkcJEDy9CEyryNHqM/A879AllASLiVqe+yeXxql3XJ2YZxgfC47PPnvEparVXGHSATAA
 xZ0FXx9dja9szDIconP2JhAzuEP8tQedGihVTdBMx6RvsMminwG8Fu8L7VGP/eOcYRj4
 nPiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFNWlVvYtE6fNCiRMqA5Is0N3yDc6nFyIvM47xl1SbyH8uEajOP4bEGlZdT4UkFT6iLw9YAtTbf9kl@nongnu.org
X-Gm-Message-State: AOJu0Yz+fXA1gMp/IuAhkewUTmUtReRis4zdW+S/wTYPSrnhsnNcVTmP
 iX9Z54k7ckrBLZJCV/WFQ+Ra05ZQ2Op0PYUOSpvk+8vA3n7x/LC0P46F6Qtt3jPYqK0=
X-Gm-Gg: ASbGncslYDimiOtFYeJ7LZGGUFK7K3Gqd0jGAZsZ9+6YWjTZ+iPhO00aUok8LR3tZge
 FCv33tNpXpnJKwsCSbhmDgS7JOE9VQ89APMeQZw+yi+YYTZg1s/oH96Za1wSGwd6McOTMb+JFoj
 gRAb2m5+IWEDu4TzfubbuNJPgSR4AUcIe1rLYfulBk9CavUNGjatrJDbBbjbbuMdIX3QfQwlI3Y
 R9XNiKJKAMCcRz7oriSW7YD6nKTvzMOL02cpect/PTlreaNY+4ryCv7MStFbRmnWofo07jN8CRa
 9gT1j4/uhZQxd/8t5F5rhrAoxAlDxcjWYfmYhtuTQKAy7F+8qTwlm3xiuMQBljWW1GAf1oC2HZ9
 jGKAaGKxE6EJ4Fmlr3DqeM/Xau4FOyAUtmo4EbJIRc381VpJFO+TKA/nXFtZGS2OXPw==
X-Google-Smtp-Source: AGHT+IE9PHzRmrjZCiBc6JvuPWelSPwE+dERNowkWNcV6U6qGISzVTZSL6pkRQnBjVm7IciAPM8B4A==
X-Received: by 2002:a05:600c:4f12:b0:459:dde3:1a37 with SMTP id
 5b1f17b1804b1-45b66343ea2mr101661815e9.25.1756419398733; 
 Thu, 28 Aug 2025 15:16:38 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a65sm778717f8f.56.2025.08.28.15.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:16:38 -0700 (PDT)
Message-ID: <dd70c16b-9b46-407a-af8b-b6dcb7608def@linaro.org>
Date: Fri, 29 Aug 2025 00:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-21-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-21-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/8/25 17:15, Luc Michel wrote:
> Refactor the CPU cluster creation using the VersalMap structure. There
> is no functional change. The clusters properties are now described in
> the VersalMap structure. For now only the APU is converted. The RPU will
> be taken care of by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal.h |  12 +-
>   hw/arm/xlnx-versal-virt.c    |  80 +-------
>   hw/arm/xlnx-versal.c         | 352 ++++++++++++++++++++++++++---------
>   3 files changed, 275 insertions(+), 169 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index b981d012558..27594f78c8f 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c


> @@ -394,20 +328,18 @@ static void versal_virt_init(MachineState *machine)
>       fdt_create(s);
>       versal_set_fdt(&s->soc, s->fdt);
>       sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>       create_virtio_regions(s);
>   
> -    fdt_add_gic_nodes(s);
> -    fdt_add_timer_nodes(s);
> -    fdt_add_cpu_nodes(s, psci_conduit);
>       fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
>       fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>   
> -    /* Make the APU cpu address space visible to virtio and other
> -     * modules unaware of multiple address-spaces.  */
> -    memory_region_add_subregion_overlap(get_system_memory(),
> -                                        0, &s->soc.fpd.apu.mr, 0);
> +    /*
> +     * Map the SoC address space onto system memory. This will allow virtio and
> +     * other modules unaware of multiple address-spaces to work.
> +     */
> +    memory_region_add_subregion(get_system_memory(), 0, &s->soc.mr_ps);

I was not aware of that shortcoming (Cc'ing Manos & Alex).



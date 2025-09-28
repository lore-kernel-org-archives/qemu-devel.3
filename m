Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605D9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x2N-0002IN-GM; Sun, 28 Sep 2025 15:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x2L-0002H5-Kr
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:21 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x2A-0003hy-GP
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:21 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-330631e534eso3980154a91.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759087559; x=1759692359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lzn2iwmYvBx9U0nSYevjO2zcQ7Tx5T3nqSzNMhIyKBI=;
 b=dz+vsGORcRSLVmzCwAeclBhvOd9O+2jtkz+Mfc9ijrVXzKk6mItxaCi63S2O+1yem2
 V/cLCcACRe+WUC0qFwd6gy6BnrkmdEALx1jnXAmNfaAWoHZBOfT/BsHTJJAhaj2OVocn
 EVWyaLIgMw5+uHgwyA/JyZHqpw019rAKl4/xssYaHc+BGDDhTirRp+GPOwElb07B4W0m
 NsUtXoWAe56w4J+8XuVVwRP2fkU8PXUl2nYacW8xydo6r1bm1HtfxRrv+UcxxyfTqKwG
 7o0UnOQ4TVbli7VeZ/wXYMgr+heuTKdGUyCjFkTfeWt2cpIWNtcv5G9OychbOzAB41ND
 683g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759087559; x=1759692359;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lzn2iwmYvBx9U0nSYevjO2zcQ7Tx5T3nqSzNMhIyKBI=;
 b=OEFj5O0WnvPT1nvHZjlJS7kPxtIzv693WCLBrk5+s7E/YGYzV4PWg50nSD5tFBMQ1v
 RgWobxVnw2eUpLZdd2ZjX3InNB7eS+1G6hFOD1ScCcBD7Wwe90Ic1qmiamSUwT5FI4Xo
 jsuH0aNPG5ZTYtpsxACDH5HSqrcCY69X5LmQEZtd4/d92+ZcNY6NGDDSjWrKapA4Uc0X
 Bmq6FVhxPEGVgApSwbPfi7pLsvXE7W6p/VyI8KJq2iz6T2mwCBdkK8Gic8Zod03b5A7L
 zmmev1zSTW9M1TjxIwtKpUxI2G127yjRf6aEp6WlFiYfE6O6Ui71/+5b7Tmi/m/gsduT
 yUfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKC49wLivBcew0jNOHqm6o5zjp92kpM/uYrEZGxfB/Sbot+24RqyOpshztqCRYXTzr4Cs0EzlYLohi@nongnu.org
X-Gm-Message-State: AOJu0YwD5d3eXsTmSEZ//m+RZnWNiqxG5mQ7A6nZ/ueJ0xcpxSGjrMOX
 JjZhBG8R/ugIsZri8bmpxtEaPTv5SlMHEEudtA8lJJxiFPZUqV4zVB5VRW14cvngnYUt0zDhRao
 /t0vLA+g=
X-Gm-Gg: ASbGnctX/CZSflcLTSJ2o7cYMH2v4iPiYNfX3xOAcSK48M/3MREVSiTy3WJJXokEFAP
 EzF9K6/jTvjaMG/KAxEZely6tAEHj5H9Z4GfT9DclVXLtyYAXAOCr5e5ZAy1ZgEktnfLeXiySpI
 QoIIYLcBaz3FctviTBr8CywMDtKEBH+tBMgXc3L14uUxAZl6KvfGek4/b42m77zv7DshFUJTetY
 bprnfeM9vBFnJ5DIXPRjSvXew+loOTgmzCNR9I8AaY7peHe2DDO0IMCzPdFJR3sTZk1d/Z6Bhha
 Z9QcaGRx5qIBjscyDyj41VQtQJ02IoxqMyWJD08h9zG5bgSo7O4bt3Xkc14rwb2/Ax7zVRtWQCS
 SUB4est/4HkHv7Z56E77DaXKQC/mfKZJwlDku
X-Google-Smtp-Source: AGHT+IHdBYQG6KpmmQdXm7kbkxQBM7A7yqBC24hmQLqSJAX73JBdF54xBIYpnvv65L21p96j8wz1mQ==
X-Received: by 2002:a17:90b:3e85:b0:32e:9281:7c7b with SMTP id
 98e67ed59e1d1-3342a20bdebmr15897240a91.3.1759087558977; 
 Sun, 28 Sep 2025 12:25:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33471d735d4sm11468386a91.2.2025.09.28.12.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 12:25:58 -0700 (PDT)
Message-ID: <d46c9974-e1e2-4d68-9a80-2cd8db76fc5c@linaro.org>
Date: Sun, 28 Sep 2025 12:25:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/11] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20250928092408.948035-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250928092408.948035-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/28/25 02:23, Song Gao wrote:
> The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:
> 
>    Merge tag 'pull-target-arm-20250926' of https://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250928
> 
> for you to fetch changes up to 7470657ec157d4526752147165b2d368e2c7002e:
> 
>    hw/loongarch: Implement DINTC plug/unplug interfaces (2025-09-28 17:31:04 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20250928
> 
> v2: fix build win64 errors.
> 
> ----------------------------------------------------------------
> Song Gao (11):
>        target/loongarch: move some machine define to virt.h
>        hw/loongarch: add virt feature dmsi support
>        hw/loongarch: add misc register support dmsi
>        loongarch: add a direct interrupt controller device
>        target/loongarch: add msg interrupt CSR registers
>        hw/loongarch: DINTC add a MemoryRegion
>        hw/loongarch: Implement dintc realize and unrealize
>        hw/loongarch: Implement dintc set irq
>        target/loongarch: Add CSR_ESTAT.bit15 and CSR_ECFG.bit15 for msg interrupts.
>        target/loongarch:Implement csrrd CSR_MSGIR register
>        hw/loongarch: Implement DINTC plug/unplug interfaces
> 
>   hw/intc/Kconfig                                    |   3 +
>   hw/intc/loongarch_dintc.c                          | 212 +++++++++++++++++++++
>   hw/intc/meson.build                                |   1 +
>   hw/loongarch/Kconfig                               |   1 +
>   hw/loongarch/virt.c                                | 110 ++++++++++-
>   include/hw/intc/loongarch_dintc.h                  |  36 ++++
>   include/hw/loongarch/virt.h                        |  34 ++++
>   include/hw/pci-host/ls7a.h                         |   2 +
>   target/loongarch/cpu-csr.h                         |   9 +-
>   target/loongarch/cpu.c                             |  29 +++
>   target/loongarch/cpu.h                             |  36 ++--
>   target/loongarch/csr.c                             |   5 +
>   target/loongarch/machine.c                         |  25 ++-
>   target/loongarch/tcg/csr_helper.c                  |  21 ++
>   target/loongarch/tcg/helper.h                      |   1 +
>   .../tcg/insn_trans/trans_privileged.c.inc          |   1 +
>   16 files changed, 499 insertions(+), 27 deletions(-)
>   create mode 100644 hw/intc/loongarch_dintc.c
>   create mode 100644 include/hw/intc/loongarch_dintc.h
> 
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


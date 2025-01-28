Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0413FC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgLz-00073m-5H; Tue, 28 Jan 2025 02:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcgLq-00072Y-VN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 02:49:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcgLp-0006pv-9v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 02:49:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so54370515e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738050574; x=1738655374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUmyIiDaNrOoEKJwvjuDpM2uOTfEtcf4KoYX4nbPq+8=;
 b=NEfqDIZs1SWok+HR0z44M2/cUEVbJ+ydfFwIE7qFVqRYkJNOzFP++xkQmvS2Me/7K0
 zSkrot2J3+quNMIhQ4FPC8l9nNoxzra+10MXo3gW3PsFkQFtqiebNDb7UsRl5jMU3YqB
 J1LSVmJfRk2uX30f6cRPxUCFxJiWgnoChm9+6byP+hCaTVHyc8Z0r5nIavx7cCcpOsHD
 7lU82OoX3Ryk3uEkXwy5X0Utm+89GH5CszrWUYWSzEkN1a7vkJcHi3lPE8tnhQvuc3nE
 f7LMxMrjWP7RO3rUJOZpcQsl4qziAd/fWAxflCoHbpA52M7OkrW4Q2++vQ1dsA6kODEs
 AbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738050574; x=1738655374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUmyIiDaNrOoEKJwvjuDpM2uOTfEtcf4KoYX4nbPq+8=;
 b=lEny4tOHJb7Lh0278SsNy4/EDU6SO+qU+QXaFgFwrq9hudzb59R30L5S4tGWDbGQiq
 TYohUtsw22UrW699icwRRiOaKNgrVz4n0yomJflYSBXa7BDkit4A4HmQm72lHUuZb+nd
 RD/5BOC8r/Lk5qrz1JWx4SlyTE71yRB3Rp1ieTzDfNDwsk4vRy8PLpPXyk6BcsLb88zK
 V8UxqTuaZpYRdxvQgWGGJ4XMe4iP/ZOvGPW15vmBUC9bl9jdh/mIZEA3/v0PtVybLgWe
 Rk6zbPsbc1ZiKirNpW0gMoKUAS0F3Y5/+DLRgPXN0C5eGJjZBaFAtGALMzTcuk2KE6g6
 gh0A==
X-Gm-Message-State: AOJu0YwnE4c30nwHgPUzLEZMgoO+SFGytg/f7DaDYXiL1zo15uahLvBN
 KQ/+6iLpye2OdUvqa413tg29XYwL25PYJpLEuSYnJt6TEH0yWyv88UClhqFuu4w=
X-Gm-Gg: ASbGnct5PyBeDUpXED0yHGvNxWlSWlIYEsmjwnWU+E9HApBE8ezL6FTKYl1TALCHAUB
 UM4AJYFFrx83bJYHksrp7oRpBP06t9zJzIm+dRRwi40E8MxM7q4Wn+AWHmiGPgRGZEQERaTdDfq
 gCwTVpM4TK6Uvff1j0S/bg78CeTwrNrsd+JYsJFc7AlP+5SqODmD4LkuanpYJqsTlVVwXzHm42/
 m1o+MII3maUL2ft+taZgr6axAgfAlKX74azLZFMbFyjDRnz9JDiAJO6ScQ8QiUOnq+vF4YGjt4B
 HjbHBAcpezF3XBi+j5LVzOU+z+cUpyCDNNRVrLvpg1AuI7HyQEfkBs7JkeI=
X-Google-Smtp-Source: AGHT+IFpa8pZHjhc4X3Ns7uaW6VRofGWCMk742fvNeAaBwh7piprIE6mfhLNCfGJUSrS1VzDc8S1fg==
X-Received: by 2002:adf:fec5:0:b0:38a:88d0:18d6 with SMTP id
 ffacd0b85a97d-38bf58e8fa8mr27202453f8f.42.1738050574101; 
 Mon, 27 Jan 2025 23:49:34 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1766d8sm13732792f8f.14.2025.01.27.23.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 23:49:33 -0800 (PST)
Message-ID: <df5c23f8-f8a4-40c3-9117-82af31e122f4@linaro.org>
Date: Tue, 28 Jan 2025 08:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Bin Meng from RISC-V maintainers
To: Alistair Francis <alistair23@gmail.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
References: <20250128060546.1374394-1-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128060546.1374394-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc'ing work email

On 28/1/25 07:05, Alistair Francis wrote:
> Bin Meng has been a long time contributor and maintainer for QEMU RISC-V
> and has been very beneficial to the RISC-V ecosystem.
> 
> Unfortunately his email has started to bounce so this patch is removing
> them from MAINTAINERS. If in the future Bin Meng wants to return we will
> happily re-add them.
> 
> Note that I'm not removing Bin Meng as a "SD (Secure Card)" maintainer.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be3d8f431..a0e305aa99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -318,7 +318,6 @@ F: tests/functional/test_ppc_74xx.py
>   RISC-V TCG CPUs
>   M: Palmer Dabbelt <palmer@dabbelt.com>
>   M: Alistair Francis <alistair.francis@wdc.com>
> -M: Bin Meng <bmeng.cn@gmail.com>
>   R: Weiwei Li <liwei1518@gmail.com>
>   R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>   R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> @@ -1599,7 +1598,6 @@ F: include/hw/riscv/opentitan.h
>   F: include/hw/*/ibex_*.h
>   
>   Microchip PolarFire SoC Icicle Kit
> -M: Bin Meng <bmeng.cn@gmail.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: docs/system/riscv/microchip-icicle-kit.rst
> @@ -1626,7 +1624,6 @@ F: include/hw/char/shakti_uart.h
>   
>   SiFive Machines
>   M: Alistair Francis <Alistair.Francis@wdc.com>
> -M: Bin Meng <bmeng.cn@gmail.com>
>   M: Palmer Dabbelt <palmer@dabbelt.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
> @@ -3721,7 +3718,7 @@ S: Orphan
>   F: hw/i386/amd_iommu.?
>   
>   OpenSBI Firmware
> -M: Bin Meng <bmeng.cn@gmail.com>
> +L: qemu-riscv@nongnu.org
>   S: Supported
>   F: pc-bios/opensbi-*
>   F: .gitlab-ci.d/opensbi.yml



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD152E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 11:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQPaI-0006OB-LT; Wed, 25 Dec 2024 06:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPaG-0006Nu-LO
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:29:48 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPaD-0008HK-P8
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:29:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso57174105e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2024 03:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735126184; x=1735730984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NxkE2UA0S3kcUAW1+kUEvg3K6wLT3eoLpL9D8Ygd1iY=;
 b=WhD3UGZ0XRNtaOJhP7XGeqJtcqn4OyRAI7shsn4NdwjnSwektbHr5c2I64GVDLU3FT
 zU6MI0A6FiFKFsm+uIQT4Tc8QAPMWr3nJQJEblcBYm8rtuDfQO0GN50pcv3t8HyOi+rH
 iGyKQSU0XVcO9ABYVfGVOs1NKhx3+3loyAYft5zsllYEiuE9/TPpAScKNuiS1c2UrNye
 EUFdTKhXCrkEAYJJKZMjpMDXcv1VCCVCukGxywrQZeWA1H2oZIkjrZ/IeoGKWmnKP622
 qRk4jidAdDe2Rznr/13v+rbp8SkKj3M2vjAP7vT6YW/1e3r8b17WIjnvvYeme4mFF90l
 kpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735126184; x=1735730984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NxkE2UA0S3kcUAW1+kUEvg3K6wLT3eoLpL9D8Ygd1iY=;
 b=eRjLEKYQ0Y2eSkggL7u8ygvvHLK1ttLJ/pk3pFhju49vnFBxOVlUF3krD60suNW04Z
 35V5KPyBJBGjnpgwQc8Al3A6BWK57NcfqBy1OKWxAwIQvQ9XRIG836d6AC83uF6HzDQp
 B8q0LUfw7c4K3kVNCGeUoD9wRlWRWs9A3Ruj4tNxlc1wSzhG/XCNCMhlqRXWdmM0DoQo
 NhKS+O9MDbCmMmQb9BFa4syl7skOXv5G2PAv+wewRdtgO3gBmWi6kyHYwv9p6T6Jz7c/
 BjZtJj9AHO0HES5UAZdlqxKrTWSjqX9Sd5K+IDYfM7sH8Wqm/yFehOQ580LsJ7jxIdKn
 jsng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJb7FQBvUf3tuA5yxXXNEwThIB8lwShmZGGlp7ycSdIeQQRAo1TR9UyzKe3kBIAsCKNLq2ydmIstA5@nongnu.org
X-Gm-Message-State: AOJu0YwI4YvppgBSOta7G5kFKpMQJQ9xiu1UlkMQgY2Gn0Toaa4XyJRF
 yBRNcm55H71xEc5M7jczGlJxSryd3B04i0A/uD90M1VDnmgTGo3RJvz5aSgKHQY=
X-Gm-Gg: ASbGncvHoyDxA+swnFRNGjHR0gagAhS/3cK++q8dIRfMehqmlaLnDrdIXAQ2YxQlTY7
 WbTmuyL79M0TD8QUPIgoFdMAT+Qmbt2vpYZeYEcK8pnPZ+tsxOTO582+EuLW8llw2Vd4nFsdhod
 zMVAcZSV6Ag9ldXH3WH70ZiG7KyAK1YBtsEU/XDKHFo2vgizaB0bKIw31eBHYbBlcQ4lrmVypue
 pNu3E/rnVFk66xzfhxQvPG93vog/qFYTpdc24zbCgGVVmqlDtDH09alswUOCiCd1Hc=
X-Google-Smtp-Source: AGHT+IH9tJhl+QQYye6OVgkE8MCThHwpMKqxpfyhQVIB+0WgdAZhrab8cRlI0638K+ke7+T57asX0g==
X-Received: by 2002:a5d:59af:0:b0:382:4ab4:b428 with SMTP id
 ffacd0b85a97d-38a221ed38cmr16263834f8f.8.1735126184046; 
 Wed, 25 Dec 2024 03:29:44 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474b6sm16735133f8f.51.2024.12.25.03.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Dec 2024 03:29:43 -0800 (PST)
Message-ID: <3a4545ab-d9e7-47d2-b89a-5dd1263de91e@linaro.org>
Date: Wed, 25 Dec 2024 12:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] aspeed: Introduce ast2700-fc machine
To: Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-5-steven_lee@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241225020311.3718080-5-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Steven,

On 25/12/24 03:03, Steven Lee via wrote:
> This patch introduces a new machine, ast2700-fc, which supports all cores
> available in the AST27x0 SoC. In this machine
> - The first 4 cores are Cortex-A35 cores.
> - CPU 4 is designated as the SSP core.
> - CPU 5 is designated as the TSP core.
> 
> Test Step:
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-ssp.elf
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-tsp.elf
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/bl31.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/tee-raw.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot-nodtb.bin
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot.dtb
>      wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/image-bmc.tar.zst
>      tar --zstd -xvf image-bmc.tar.zst
> 
>      qemu-system-aarch64 -machine ast2700fc \
>        -device loader,force-raw=on,addr=0x400000000,file=u-boot-nodtb.bin \
>        -device loader,force-raw=on,addr=$((0x400000000 + 748896)),file=u-boot.dtb\
>        -device loader,force-raw=on,addr=0x430000000,file=bl31.bin\
>        -device loader,force-raw=on,addr=0x430080000,file=tee-raw.bin\
>        -device loader,file=ast2700-ssp.elf,cpu-num=4 \
>        -device loader,file=ast2700-tsp.elf,cpu-num=5 \
>        -device loader,cpu-num=0,addr=0x430000000 \
>        -device loader,cpu-num=1,addr=0x430000000 \
>        -device loader,cpu-num=2,addr=0x430000000 \
>        -device loader,cpu-num=3,addr=0x430000000 \
>        -m 1G \
>        -drive file=image-bmc,if=mtd,format=raw \
>        -serial pty -serial pty -serial pty \
>        -S -nographic
>      char device redirected to /dev/pts/51 (label serial0)
>      char device redirected to /dev/pts/52 (label serial1)
>      char device redirected to /dev/pts/53 (label serial2)
> 
>      tio /dev/pts/51
>      tio /dev/pts/52
>      tio /dev/pts/53
>      (qemu) c

Could we have a functional test included in this series please?

> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c  | 211 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   4 +-
>   include/hw/arm/aspeed_soc.h |  12 ++
>   3 files changed, 226 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/aspeed_ast27x0-fc.c



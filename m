Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139B2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3B61-0005Ni-UW; Mon, 29 Sep 2025 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3B5z-0005NL-JC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:27:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3B5p-000080-In
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:27:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-421851bca51so391823f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759141604; x=1759746404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYTAV9zE56S/egR+ACWy8ich8evJQkYP4VGR3uTOsHY=;
 b=s5jSoROakjmL2kVCZpNAqyCYHmXNrYSAq2dLlbHhHgLKRbo2ssqLhwTs1HKC1HSXKa
 SUV1hPdw1f0K40nKVNAGNnZ68MtwLK7ksWv5hd7/J4MPCwZl5F34RdSd2tktHIwZTLF6
 4q8SlRMyzK9u/6/fyxEwvfmE+yXGqn6l2J1oFfuQkIrAFJHXVDefd9fjoS4sro9WNsKf
 R+xCR90dN8X3QN4dhbDdOXO6hQSpfMF+0jTQxW1zZx8mEJMddSn706s1Vod3fK/GNpuj
 DDq2LueCjioUX18IjFz34OHOETslkyyr8LnNhf7xr7SM/sdxhFfnzBYaA4kFQ/xa1CZv
 GM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759141604; x=1759746404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYTAV9zE56S/egR+ACWy8ich8evJQkYP4VGR3uTOsHY=;
 b=hm8RaKjx76bm2jBylQkJuEuhtKrj8WZ0ciIR7Xf7gsZf6KqOdg/2UY0dNx6pY5ESLX
 qd1/UOCdXMVTBs6Ai9U8Gjibb6VaOgJKqQHDBx8u9QDVi+QZLJTOlXfFwgUsdM3QMwXx
 XEExZnfKQvlvxf/aPNLDrvx4t8s7/aBtvkyuTJ6WUTI70pwziEulDWF+1OaFx0PtrLKi
 oJmNvBjT5MnSAOXg7cu+oG5ye72kmWWVxmmpJ6LGyslbX3/HhWkCUqDlti50VhrOQ+H5
 tib2QEfj58isJn6R5EZsQl2otSclq1j9sgFFyK0E0Hr2YwfAqEPaI0USAB05Q8Ie2/dH
 Au7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG00Tdz3AY9LkABCqPJZ3gI3rCQFvw5tzPcUpZ8tQ6i4iEOIZ8L0wMdcsrdQnU/yrln5htiu0usraX@nongnu.org
X-Gm-Message-State: AOJu0YziKJ94V7fQd1RzigWnD2ZT61oHLPHi7G2IzQ5/aX4VJrb4UYn6
 +U1qgzs90m7iMBUfB8BRWfPyo9RDQrcQ5fNUj+w+WJO4QJlt0aKjzkWJE8eqsy22df4=
X-Gm-Gg: ASbGnctloXrFh9r3WIRqtZK7kmyFIs6eXJP8P7+ViBVRHpFwmFbrqB6L1ms7ncYbuzm
 GtycKyx5vM3Q9W5h6m2FHzxxpa/JILENhManyzLK+jHO8480hmBcpA81l31en/qYd6QFlN+8gZs
 zlekDg/PtkujcvjBcAUcpwFY4WEEfG9SwFx/Ax46XSaRPU+Pxke7xYJLOGFLAGFDjx8ugb0oCl9
 ia+q7uW/RXOMIic0jIBVZ7xN/cMX/yztzkn8vQXB64mX1cZj4EYuXDoLGfHBYaFwAYqPaDr2Bao
 PQvGfwn7z913ylgXG8Y3mHZvzYZajboEJcNJtS9rGAb/1G03gDQGIHQ9wm60tse3EMSv/b52cv8
 X0ZU14vajWScKrdBo5QW/1qPIN9BIhjt6YfxoWRBvnIFkxBJIn0HoVnRKLCUUiMYuvZOnZbWOGR
 n8
X-Google-Smtp-Source: AGHT+IFfD9HsF7FqbaESN2pnc246EJv3rXr5HhEjF+jNN29SEyjNSNwTIPXIbDCmq6PWwXOGmfsr2g==
X-Received: by 2002:a5d:5489:0:b0:400:818:bae9 with SMTP id
 ffacd0b85a97d-41358a344d7mr7300210f8f.32.1759141604137; 
 Mon, 29 Sep 2025 03:26:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921b7dsm17448312f8f.42.2025.09.29.03.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:26:43 -0700 (PDT)
Message-ID: <dd509e6e-b3ff-4b8a-a2f8-d3991066405b@linaro.org>
Date: Mon, 29 Sep 2025 12:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/47] AMD Versal Gen 2 support
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 26/9/25 09:07, Luc Michel wrote:

> Francisco Iglesias (1):
>    hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property
> 
> Luc Michel (46):
>    hw/arm/xlnx-versal: split the xlnx-versal type
>    hw/arm/xlnx-versal: prepare for FDT creation
>    hw/arm/xlnx-versal: uart: refactor creation
>    hw/arm/xlnx-versal: canfd: refactor creation
>    hw/arm/xlnx-versal: sdhci: refactor creation
>    hw/arm/xlnx-versal: gem: refactor creation
>    hw/arm/xlnx-versal: adma: refactor creation
>    hw/arm/xlnx-versal: xram: refactor creation
>    hw/arm/xlnx-versal: usb: refactor creation
>    hw/arm/xlnx-versal: efuse: refactor creation
>    hw/arm/xlnx-versal: ospi: refactor creation
>    hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
>    hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
>    hw/arm/xlnx-versal: bbram: refactor creation
>    hw/arm/xlnx-versal: trng: refactor creation
>    hw/arm/xlnx-versal: rtc: refactor creation
>    hw/arm/xlnx-versal: cfu: refactor creation
>    hw/arm/xlnx-versal: crl: refactor creation
>    hw/arm/xlnx-versal-virt: virtio: refactor creation
>    hw/arm/xlnx-versal: refactor CPU cluster creation
>    hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
>    hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
>    hw/arm/xlnx-versal: add support for multiple GICs
>    hw/arm/xlnx-versal: add support for GICv2
>    hw/arm/xlnx-versal: rpu: refactor creation
>    hw/arm/xlnx-versal: ocm: refactor creation
>    hw/arm/xlnx-versal: ddr: refactor creation
>    hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
>    hw/misc/xlnx-versal-crl: remove unnecessary include directives
>    hw/misc/xlnx-versal-crl: split into base/concrete classes
>    hw/misc/xlnx-versal-crl: refactor device reset logic
>    hw/arm/xlnx-versal: reconnect the CRL to the other devices
>    hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
>    hw/arm/xlnx-versal: tidy up
>    hw/misc/xlnx-versal-crl: add the versal2 version
>    hw/arm/xlnx-versal: add a per_cluster_gic switch to
>      VersalCpuClusterMap
>    hw/arm/xlnx-versal: add the target field in IRQ descriptor
>    target/arm/tcg/cpu64: add the cortex-a78ae CPU
>    hw/arm/xlnx-versal: add versal2 SoC
>    hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
>    hw/arm/xlnx-versal-virt: split into base/concrete classes
>    hw/arm/xlnx-versal-virt: tidy up
>    docs/system/arm/xlnx-versal-virt: update supported devices
>    docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
>    hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
>    tests/functional/test_aarch64_xlnx_versal: test the versal2 machine

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14CAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBa3-0002mB-U9; Fri, 13 Dec 2024 14:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMBa2-0002lx-6a
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:44:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMBZw-0007Vs-HS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:44:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso15192555e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734119038; x=1734723838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9gNXJcmQCHIrAo8+4s0W5awkESMTIQ5Z7OjnDJ8fjj8=;
 b=ZB4xBsdQC/uPHd0oeD+DkM7R98SvuwsdESiCyKkqsjSKP+4tm6d2E088C7LjzaxzWE
 EBUFEqgSryGTFRoP9yIKSodFEQg8Tsq+qASvEgzl98AGNfdfPTmKzCoUMwR/W6kTt4OS
 HFkQ6t3pu8K6xVJ6u+k2nSM97S5KN5leaApKiHreLjTULOjdNlsRyLRrZ7SXdFrarxi8
 j+Qn581n7WE5Ht3FiD/HDMARRESknTl5+h33tdoJRMwD2I4kSOs94w0mvu45/2aSOcHN
 uC0tsDWvTOBuUuBLxYrbXOGO5NMuhHLhzxaqfCuGvZEosDvZzSpLF0K/py4jwVDrsKJZ
 TbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734119038; x=1734723838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gNXJcmQCHIrAo8+4s0W5awkESMTIQ5Z7OjnDJ8fjj8=;
 b=i1bB3EUVPzZu7q7yqc8bgTCdwNQBBQrgrtTGhAEIMPqXKlYzPlvccV9NO1pMq4Qak0
 V9WPFgeRneIX5BauxdveARw3rh9/Y4rFx9CluyCIFLhVCDSO50NzbtfjKiH6yPsLkjrI
 wcStBx3ymWBia4B+h9ppVentS2Z4BiTaigJfWuA+0K5Jt4WFxnj3txzXtbS10yGKwwHf
 SepNEpVccfDW++HDGyfIdopPyE80GarBl/8Ri21gc6027NeBwePIpQKChSA+yGUbNhoG
 4DVxWy/TevkR7w/rQjLqdQdu6HGrCSwXT0hj3GS8jlcCMSq+d1w2qYI78TDopQ2CFhgl
 VIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUkw+PWiLz6qXtMdgffdqWVQmiO300TqF5F/9HjxaQ7+4gl73u7vh+jUUWafge7ZxCFJDvP6xmnv/z@nongnu.org
X-Gm-Message-State: AOJu0YwX6QcO67ueFaA7cpjjufqf4cFOX6OQ6xCwG8FiUbAAn+MOmgYH
 9Aa4zukzX3QnHxmZDbVqKJXTOGe85AJqcJP0UmPpPngIWxqJNFwPGx0Dxpb4rGdNaythjcjQV/t
 IKSA=
X-Gm-Gg: ASbGncvb73I1PLOEKc9Czux0qgQZQNgYhd8nSJRttVXT+TQLFZYYfJvdx8WVqtKL+yk
 wzutxmg+NBiD0NGpOP3ggYcykJlcjx90lRlbyGrlsTPbrNTmhuty6PKuOFUI5uizYqL/HIGGPkk
 WzeD/5sTm5NZuk93BeWRDShGLkCz6slsMIcLoKJuIoTDbyjhaJDzUfv6+lQ8+fYKYCKAq6vGX6M
 TwEGMXLysof75t0w1ya0w8qXVuX8A5qUKGM8bX8VHZYP5XgXZVemxswWteG80L40bMZ3A6WKxzm
 uK13XNHd8mtp4LYL2Q2cPFh8XOpQiLjGejsMKN93/N/S2A==
X-Google-Smtp-Source: AGHT+IFNXcrV54y5fdmnwb218hKFXph2Jnpv6RfEjNOmPptx0U0HdpU6j85KrcSv/Qnc6AbNVVAOkQ==
X-Received: by 2002:a05:600c:3c8d:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-4362aab939bmr35628035e9.31.1734119037179; 
 Fri, 13 Dec 2024 11:43:57 -0800 (PST)
Received: from [192.168.224.213] (183.red-95-127-61.dynamicip.rima-tde.net.
 [95.127.61.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80470afsm356393f8f.75.2024.12.13.11.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:43:55 -0800 (PST)
Message-ID: <67b7a33b-2bf6-41ba-b421-058875e3c0ff@linaro.org>
Date: Fri, 13 Dec 2024 20:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/71] whole-tree: Constify Property structures
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/12/24 20:06, Richard Henderson wrote:
> Since d36f165d952 (qdev: make properties array "const"), we can
> define our Property structure const.  Do this across the entire tree.
> 
> There are a few other minor changes:
>    - Two instances where it was obvious that an empty property list
>      could be removed entirely.  There are other empty lists that
>      probably should be removed, but I didn't look further into usage.
>    - In hw/misc/xlnx-versal-trng.c, adjust a Property to use the
>      correct PropertyInfo in the definition, rather than setting
>      it at runtime.
>    - One instance where { } was used instead of DEFINE_PROP_END_OF_LIST.
>      Not a bug, but wrong style.
> 
> 
> r~
> 
> 
> Richard Henderson (71):
>    target/arm: Constify all Property
>    target/avr: Constify all Property
>    target/hexagon: Constify all Property
>    target/i386: Constify all Property
>    target/microblaze: Constify all Property
>    target/mips: Constify all Property
>    target/ppc: Remove empty property list
>    target/riscv: Constify all Property
>    target/s390x: Constify all Property
>    target/sparc: Constify all Property and PropertyInfo
>    cpu-target: Constify all Property
>    hw/9pfs: Constify all Property
>    hw/acpi: Constify all Property
>    hw/adc: Constify all Property
>    hw/arm: Constify all Property
>    hw/audio: Constify all Property
>    hw/avr: Constify all Property
>    hw/block/xen-block: Unexport PropertyInfo
>    hw/block: Constify all Property
>    hw/char: Constify all Property
>    hw/core: Constify all Property
>    hw/cpu: Constify all Property
>    hw/cxl: Constify all Property
>    hw/display: Constify all Property
>    hw/dma: Constify all Property
>    hw/gpio: Constify all Property
>    hw/hyperv: Constify all Property
>    hw/i2c: Constify all Property
>    hw/i386: Constify all Property
>    hw/ide: Constify all Property
>    hw/input: Constify all Property
>    hw/intc: Constify all Property
>    hw/ipack: Constify all Property
>    hw/ipmi: Constify all Property
>    hw/isa: Constify all Property
>    hw/m68k: Constify all Property
>    hw/mem: Constify all Property
>    hw/mips: Constify all Property
>    hw/misc/xlnx-versal-trng: Constify trng_props
>    hw/misc: Constify all Property
>    hw/net: Constify all Property
>    hw/nubus: Constify all Property
>    hw/nvme: Constify all Property
>    hw/nvram: Constify all Property
>    hw/pci-bridge: Constify all Property
>    hw/pci-host/astro: Remove empty Property list
>    hw/pci-host: Constify all Property
>    hw/pci: Constify all Property
>    hw/ppc: Constify all Property
>    hw/remote: Constify all Property
>    hw/riscv: Constify all Property
>    hw/rtc: Constify all Property
>    hw/rx: Constify all Property
>    hw/s390x: Constify all Property
>    hw/scsi: Constify all Property
>    hw/sd: Constify all Property
>    hw/sparc: Constify all Property
>    hw/sparc64: Constify all Property
>    hw/ssi: Constify all Property
>    hw/timer: Constify all Property
>    hw/tpm: Constify all Property
>    hw/tricore: Constify all Property
>    hw/ufs: Constify all Property
>    hw/usb: Constify all Property
>    hw/vfio: Constify all Property
>    hw/virtio: Constify all Property
>    hw/watchdog: Constify all Property
>    hw/xen: Constify all Property
>    hw/xen: Use DEFINE_PROP_END_OF_LIST in xen_sysdev_properties
>    tests/unit: Constify all Property
>    docs: Constify all Property in examples

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



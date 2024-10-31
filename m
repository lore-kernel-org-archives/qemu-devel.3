Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152A4E6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MGJ-0007Ma-Oe; Wed, 30 Oct 2024 23:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MGI-0007MM-Sc
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MGG-0003wU-Je
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f72c913aso785961e87.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730346854; x=1730951654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNSOgPK/LUOornui0xSrRZ2dvpsKphrF5tK8UB5/hEY=;
 b=jFxBtlx2ocJdGw88JuXgu9hak8rEksHU8BeeshwhP22FA8pyih/wdJALRAG8fnrnzN
 MfN36MiyeHHj8XU1zNPx54EiwZTP0SnGqNtpXYe1PXn+MiZiPMB31/FBki9W2X61BQpx
 EL4e0slcs05sytkANyCXm5qkZz3mUekZYa9+DVBsksLhaN5t6yAK4uAGIMHQ0okkjcyK
 Da56L1YdvjHqcAM9bHg0qglr+SmDPDX2gaQ4K+GOXdAF2tws4v16SFyJAv+hruaOGl2A
 Hz1MeTWL/n6+6BRb4i2rmWQAijrDGJQFuTva3eo4MWWO/17lzh+x0xcTjC4x0HP2iAZc
 VGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346854; x=1730951654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNSOgPK/LUOornui0xSrRZ2dvpsKphrF5tK8UB5/hEY=;
 b=OkAyjasMhbgUEa1Dwue5it+4B5n8ZNSp9OYw6VLWmMtXd4AxwiRabRnfbilseSDZLM
 fxP2APbIfKCqyVvJ9o8qqoxeZsJDkmSQiEVyUyKW4J083ZwUC9boiuFFrVLuPgVPlsrb
 W159V0aDAU8K3IH/QUYLyOm7Lg0RCCyjhp/nJpjktnwcptLIjlAxPAXSWnI3FvOj1tlI
 mmXfVhs17PhkbDo2ekJ3JDpJYOkpe28aJ8nxwaH4g2wqDjOr3hUEnbt+MU2QxjWVVskk
 3ZiGX3BLY4RN7V0IBJ7dOaCSuwbg+LO4W/TqbNtgnnHxcJ8OFocj6tR/q8pY5H5BMDrp
 GUcg==
X-Gm-Message-State: AOJu0Yyk7FTC/MJspNZ06F3wYkOEAqLtGiRMIEU2os8YvF1Cz5hosZPU
 gK03gZl8oKM1COVXpTlBnJ4n9iDK9ljE1FFZRo+q/OzfzqrJ5zg50J7RfgqZaWggIFiXRC7Pn0T
 W
X-Google-Smtp-Source: AGHT+IEUAe7DSdkllbC9uM0SBKBzVKpcvUAX5zSFXs9WsHupPUQWRPwY3mJX1Bfq0sjFbZJx26Ztkg==
X-Received: by 2002:a05:6512:1324:b0:539:f807:ada1 with SMTP id
 2adb3069b0e04-53b34c463c1mr7155464e87.58.1730346854187; 
 Wed, 30 Oct 2024 20:54:14 -0700 (PDT)
Received: from [192.168.21.226] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc95998sm73215e87.24.2024.10.30.20.54.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 20:54:13 -0700 (PDT)
Message-ID: <eeed4a8d-d0e1-491a-8c24-665f5e531ab3@linaro.org>
Date: Thu, 31 Oct 2024 00:54:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] target/mips: Convert Loongson LEXT opcodes to
 decodetree
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20241026175349.84523-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 26/10/24 14:53, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (9):
>    target/mips: Extract decode_64bit_enabled() helper
>    target/mips: Simplify Loongson MULTU.G opcode
>    target/mips: Re-introduce OPC_ADDUH_QB_DSP and OPC_MUL_PH_DSP
>    target/mips: Convert Loongson DDIV.G opcodes to decodetree
>    target/mips: Convert Loongson DIV.G opcodes to decodetree
>    target/mips: Convert Loongson [D]DIVU.G opcodes to decodetree
>    target/mips: Convert Loongson [D]MOD[U].G opcodes to decodetree
>    target/mips: Convert Loongson [D]MULT[U].G opcodes to decodetree
>    target/mips: Remove unreachable 32-bit code on 64-bit Loongson Ext

Series queued.


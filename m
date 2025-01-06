Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE815E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvGJ-0007H7-B9; Mon, 06 Jan 2025 17:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvGF-0007Gn-KW
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:07:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvGD-0007qE-Ha
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:07:47 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so5488954f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736201264; x=1736806064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fz9olzsjCLCGXWr5xhqO1G5fYma5lcQ4CUiGonib42Q=;
 b=qU8tdWBxSI9TrmwZhf7U0nhAmImDIHnvpUSUZV/KAwN8hsoFWWZTyVIeE0CwinMCWj
 u2vQK8/Tqcv5jIdODYffgpA6mdkrd4tfNBlTwHPA92y3oLlKBtBSGYMnoqaOhPw1zm+Z
 orkVnLGX/ced6AcPQ3K8ly4Z38/7kkKHnuW3mmqqzMf1LeWLTmt1m2ygMDg/Ad8CyQXb
 9V2ZuARx775P+B60P2yJOvMdYlxHqfLZSK67qTczhHHxkrD1YusTjR4+pZ7Hjnbhu3RK
 Lm7nvhgcHmN15pfSO4INcKMQvw55Ks0ir2dzGi/9tMm/RuujtEc1ph57vnHCzsW5IsA5
 9n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736201264; x=1736806064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fz9olzsjCLCGXWr5xhqO1G5fYma5lcQ4CUiGonib42Q=;
 b=PKX4Y5tjk1WMeRyYsFdI9tgWnTAu2A4RtShSjKPZ43XKPcDtmCkaCZAk/Vcb2PI/AR
 ZXTjajPxvd71o0iph/NvMWgBKWveFe5XfOKhssJF2LIc8+suRxHzhTroby6PoR9V2JXC
 r2wItZkvIfgAO8ggOTHqm1PaEvnROAothyjyPWevzVY/PxwacqNBRSHDOxpoJMG7SKmZ
 iiCxBbG0nghyeSNFU+93Lfmc+/0gmU+sI9BSesf/+NL9mQy8GyGc7ueQrpfKA/0SxnMQ
 VuEqIpb01QMXuRFkMJ41s33rJMFanwuZcWzws9n9n5y+aq/IBHsIMr5mUtYj8YCAXLMo
 IXvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV51oyCdffKazGJ0Ulz7En8xpAGtL4QmQ0CoL0vwciD8gjgIycj7P7sDfhfP1s8MUd4UBfYidNAei+T@nongnu.org
X-Gm-Message-State: AOJu0Yw1vdX9e6agEiS4ClpQTVcicTP318m+ZHM18IVjRbUVt72xGUUY
 0Rt8uew7pQi34ktyHy5m8mpSKgmMRg40wGOJsedOMym11tRpQvrb5CYQvU2BH6Qv5F0edId1sMr
 75lI=
X-Gm-Gg: ASbGncvp97Ea1BafmxwuByR2RDftsgwfpTzu6C7OzigGnHK54xo3NUO8HuLS87iThfs
 5o9B00ah/Idtbb5dVYwxgiG3C7oxpXEgKhtcln5Tr3NlY2woYHWqg6vLvZhGBMniTFo9ecDTHRj
 XTcDiAkkVROJK+3348x8hcGdV9aRJGq5D7a2SbJNwwzJ/7XxPU4iIfR2xOd6EficbTEMDv5qIOU
 0jPnp+61KtzFitNvQEoVFrI7uAbDowyH4DuT3cPNFYka4hfk2lz0OaWtsNGsLyV2vbob1vk+QEv
 KOXcOLgnx1F+WeM5W8k2Ahsx
X-Google-Smtp-Source: AGHT+IEMoPcKoZSSdnS1xojY0mjO9j//FiLm2+U7ESO8HGtDaDErRn0goSbKHLDgILIJY7JEBmKJgQ==
X-Received: by 2002:adf:a19b:0:b0:38a:418e:21c7 with SMTP id
 ffacd0b85a97d-38a418e22c3mr29821499f8f.53.1736201263599; 
 Mon, 06 Jan 2025 14:07:43 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d3dsm48373097f8f.94.2025.01.06.14.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:07:43 -0800 (PST)
Message-ID: <d93e2e6f-4d72-4e47-bae2-b952334df52d@linaro.org>
Date: Mon, 6 Jan 2025 23:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 72/73] tcg: Merge bswap operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-73-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-73-richard.henderson@linaro.org>
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

On 2/1/25 19:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  9 ++++-----
>   tcg/optimize.c                   | 20 +++++++++-----------
>   tcg/tcg-op.c                     | 10 +++++-----
>   tcg/tcg.c                        | 19 +++++++------------
>   tcg/tci.c                        | 14 ++++++--------
>   tcg/aarch64/tcg-target.c.inc     | 18 ++++++------------
>   tcg/arm/tcg-target.c.inc         |  8 ++++----
>   tcg/i386/tcg-target.c.inc        | 14 ++++++--------
>   tcg/loongarch64/tcg-target.c.inc | 22 ++++++++--------------
>   tcg/mips/tcg-target.c.inc        | 18 ++++++------------
>   tcg/ppc/tcg-target.c.inc         | 18 ++++++------------
>   tcg/riscv/tcg-target.c.inc       | 18 ++++++------------
>   tcg/s390x/tcg-target.c.inc       | 32 +++++++++-----------------------
>   tcg/tci/tcg-target.c.inc         | 18 ++++++------------
>   14 files changed, 88 insertions(+), 150 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61DD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzMY-0007sq-DZ; Sun, 28 Dec 2025 17:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzMX-0007sX-5y
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:35:45 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzMV-0008U7-OX
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:35:44 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78f99901ed5so74408167b3.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961342; x=1767566142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICkN6IUeVv6qtpaRDe9AckfracKjOt8veInj2PosoIo=;
 b=vvVKVElGTSL9P2Pti9mjxCnkDK+mg7QB3vnY68QgdIP4DCPtnl/Wfz1ywHCRS3n15z
 RS/xzhFNzq0MG59K5ep/LpVSSgq6ubDQUka8lb4bjHWaZkSnI8w0qw+JHVzrZvnt/KAC
 JPp31LUky358e0NAveCAxLd874dmZ2w5a0L2qKTS93c+k/FVRARMN6bdHNgNxxKxLd+9
 lYojql1LFiFYk9njh+M2LYQx4zM8j44DJS7cObiPvuaP3wsl8pwZ7KLdaOy7QU2xoB9D
 YDK9O6JgYUC06dAoxD7Obdi+Wz5tiD1gAJQtBg6Q6W6aM3+T27dnqNvqv0BpYSuIYadT
 ptoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961342; x=1767566142;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ICkN6IUeVv6qtpaRDe9AckfracKjOt8veInj2PosoIo=;
 b=UBh1R6DuiduJpGqJnNuplYshA5+jp9FP98eSHZYLr7ZMXffeRN7j01tWgzmhLCWor3
 wEH7uujYxnH2BADUouLbFBsgfL+jHy4sfURNpQzZ+v/AWKvJv7xl6L6Uo9CQvp5G+iFd
 ihEiFXRfbrMJg7CIEF/p2CAyb6rzldVJrTBub8L0KN+55ajYxz9eol39J5HzmngDzECj
 m6gsj26JYoNG9Wb1+k6viUKqjdDIxexqsdVPRBMeZgGQ23akINWus5toQH5lwx8DY65/
 PL57r0p7CMK6Gb3ca2mbm9pAMR6WvP1GPkPHSEO9fD5HmUxGF7Umo4ymGN/cq2vvLDBn
 f8ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOpxp0EG2NqsnVP+IlIgpXJ4I2Qa9wLCuxJ03aiQb8QCvzBybx8qo7o20uY6FwBrcAb+O4a0U0iyR2@nongnu.org
X-Gm-Message-State: AOJu0Yw5BuUhVlvnRbNpLjpEuIMyPk+avHRLaPPws+JUy7ea52ftreUp
 Zq2VTdjnkSaXqPKEwSr69D5y2aKN0uP8aByrfIlcn9/2eym4CSE3A0YUsTn3UHKHhkU=
X-Gm-Gg: AY/fxX6BW3coW9Bo5gYk3tu8CY8WyG+bNRFt0YpZfvjUyqkTsA5Pb2Q1ORQ2IFcdVcI
 U4qI2014pJQ0wzwG+DrEIlMOdTVvOwqiNJXiBF6AOIjYDh8nW6v6P1fcQrKdGRU1W1p0+Zj0HrA
 RAZzXZOgGsou4IhB2bQPFEBbxpCE8hNBcctM5Vo2jPVaVdolHK+Nsjz+RtNMjYhoqf32gHfP7r0
 s4MfATAjFiQIt3V5D8tANfSmvOyxTrngBYH9IGnBzIBnfu1CLULWLRKnoEWfAinq6blGN0GIvd/
 7pmQTalmeCCokDMMgAbA7R7h8VU63FnpVQY6KJsdOS29WaiSsT8EpXMbIEwawuNXcCQxHfmjmLe
 xqTd9ZlEVW+a7rxtNPXmNQjCzn/0awYkQ4YczSy5zFOpftc7phWeO67P/44sWIL1JFKvsHb5CNr
 hf0V1E9bgjAblFjp07lDY5a7CW4ZnT/A3mO+bICN8P/cKxxv4HVz6t
X-Google-Smtp-Source: AGHT+IGllhB8OL46nneu57GzMoEYZdgkLLqWqQcMjnMnYz8Ypk/xWe3ClAWT+lHFIjaPDZxF5owgjg==
X-Received: by 2002:a05:690e:13cb:b0:63f:abf6:1c9 with SMTP id
 956f58d0204a3-6466a898fa5mr21612182d50.25.1766961342497; 
 Sun, 28 Dec 2025 14:35:42 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb44f0d4csm108739397b3.37.2025.12.28.14.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:35:42 -0800 (PST)
Message-ID: <30e63561-fe62-46a6-bf1d-aeffaa176fc9@linaro.org>
Date: Mon, 29 Dec 2025 09:35:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs/targets: Introduce
 TARGET_USE_LEGACY_NATIVE_ENDIAN_API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20251218212814.61445-1-philmd@linaro.org>
 <20251218212814.61445-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218212814.61445-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 12/19/25 08:28, Philippe Mathieu-Daudé wrote:
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API is a definition that will
> let us gradually remove legacy APIs related to "native" endianness.
> 
> Set it to all our system emulation targets, taking care to not
> poison it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/aarch64-softmmu.mak      | 1 +
>   configs/targets/alpha-softmmu.mak        | 1 +
>   configs/targets/arm-softmmu.mak          | 1 +
>   configs/targets/avr-softmmu.mak          | 1 +
>   configs/targets/hppa-softmmu.mak         | 1 +
>   configs/targets/i386-softmmu.mak         | 1 +
>   configs/targets/loongarch64-softmmu.mak  | 1 +
>   configs/targets/m68k-softmmu.mak         | 1 +
>   configs/targets/microblaze-softmmu.mak   | 1 +
>   configs/targets/microblazeel-softmmu.mak | 1 +
>   configs/targets/mips-softmmu.mak         | 1 +
>   configs/targets/mips64-softmmu.mak       | 1 +
>   configs/targets/mips64el-softmmu.mak     | 1 +
>   configs/targets/mipsel-softmmu.mak       | 1 +
>   configs/targets/or1k-softmmu.mak         | 1 +
>   configs/targets/ppc-softmmu.mak          | 1 +
>   configs/targets/ppc64-softmmu.mak        | 1 +
>   configs/targets/riscv32-softmmu.mak      | 1 +
>   configs/targets/riscv64-softmmu.mak      | 1 +
>   configs/targets/rx-softmmu.mak           | 1 +
>   configs/targets/s390x-softmmu.mak        | 1 +
>   configs/targets/sh4-softmmu.mak          | 1 +
>   configs/targets/sh4eb-softmmu.mak        | 1 +
>   configs/targets/sparc-softmmu.mak        | 1 +
>   configs/targets/sparc64-softmmu.mak      | 1 +
>   configs/targets/tricore-softmmu.mak      | 1 +
>   configs/targets/x86_64-softmmu.mak       | 1 +
>   configs/targets/xtensa-softmmu.mak       | 1 +
>   configs/targets/xtensaeb-softmmu.mak     | 1 +
>   scripts/make-config-poison.sh            | 1 +
>   30 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


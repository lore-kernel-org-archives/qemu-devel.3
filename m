Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12833C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 16:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgo3B-0001Yj-75; Sat, 08 Feb 2025 11:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgo38-0001YQ-Dm
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:51:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tgo36-0003Ar-Qm
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 11:51:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dcb7d6b69so761390f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739033479; x=1739638279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6RofgilQ6tQmm/vVGWNYbOM2enW4oTJViB+7fplcn5w=;
 b=cUvNX39y7Zf5f1xCEeHA7p7Vu1v36bmXUhn8NTvTsDpkdxTEwQ5P8pqT9W5XzXnagx
 hsdb2lk2W/w9WetY4nX0swmPSkB3gLu4m77tJoAVYGzx3FNEz+X+GmQ/BaWAOgfWsXhS
 TBgusMvCi2rVwzUpoELM/Yj+BLPmb2rneIbuVyfks7D0LpakGGV81sF3KxdL5hHMRRD1
 elyd6ZyohGj+9Qd7vroL5acwfFGbU4YAtDCbEtQe9S7O19hjrMJL8ZlUxly5kJZBEunC
 TLXEO7f62wjnkp46I657fEH8iZVwO/cX/TK48LRhXYDVxTLreatXNU6b7bLbE9nF3HTA
 a+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739033479; x=1739638279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6RofgilQ6tQmm/vVGWNYbOM2enW4oTJViB+7fplcn5w=;
 b=Yt42r7nYlOZ7m/7/QJ35GMqZry7yeAG+pjc/mKcnimJ+Dg1aqexX/q6kh23y13BgqW
 Tq4QXJl0EGuCFzG8YBIlUO7E/RATD26bhAxzvLo/E0Ksobo8aOZQ3cv/GUPf8CTZyzu+
 hIL/r4gvS/qfmWRZ3vQ/+RUFhD0cNsIHp3I7FmNzkkenQa1VSZ3t1Ave0a2+uqUFpoub
 bZ1QlaIxw1veksbfdAP35mRzbkhUTXrDb+evbcgleLCWAN+Fi0MC6KY6krI07lZ1NE6P
 upmGPJ+lbBq71M9p1AFrbu2GbKzKmnWlLwIAgQOEdLRUNVjbTm2qDQDdTp3D7wUXjhne
 /2WA==
X-Gm-Message-State: AOJu0Yyi59/DYAyIS9hFvjuvNbeQrofJS0/7Kqg+TGmmvkg+ByozbAo6
 YiTMeEch1HxapdWJNmFlyHerp4BbCzGVXsEHOXoCwghw39NU70xTgwWJ+yrwLtHUPeiOUWiLBA1
 PU4A=
X-Gm-Gg: ASbGncsSpvXWJPfc0NAG95w1d6OCOuDkmt3cxf508ZK7fqz5q4FuBcZrC0AVUvE6wSD
 joWtieUWYFOjMre9A270+m1oUG3rIqjwTfqys2GPHA4mNh17oDbqAMMBPJPuGokx4OvTe7WjJBJ
 fUZwsWfObzlang2IViW78lU3te+T8Wvq5XEUF+hyp8wO+Yf+OT6i7yeAUZ3FZ3TX1e4ZiidaJsB
 Q7k6FAB1WD6ZXVxmOFiIkaCWWBkuVTV6UOMQivWLKMSzmcrW/aGBjBFGrXn0ymSyCdgO4Sunca4
 bCkT1TeiJJP3slJY0x1FQ9pLuzvqfJ5e2pHNGlRpCxiVr+fT7QjXi6ybcN4=
X-Google-Smtp-Source: AGHT+IHjOZtStL0Kj0M7/As6GOO4yIT3Np1FIQpqyWloBDyFwGJHzkM6BCLgZzsxiMDMvfK0XoNQAQ==
X-Received: by 2002:a05:6000:2a7:b0:38d:b448:65c4 with SMTP id
 ffacd0b85a97d-38dc959fec4mr5203484f8f.55.1739033478781; 
 Sat, 08 Feb 2025 08:51:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf44f3sm128738945e9.29.2025.02.08.08.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Feb 2025 08:51:18 -0800 (PST)
Message-ID: <1d2986d2-4364-491f-a2df-331115edb23a@linaro.org>
Date: Sat, 8 Feb 2025 17:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/riscv: Move target-agnostic definitions to
 'cpu-qom.h'
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206181827.41557-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 6/2/25 19:18, Philippe Mathieu-Daudé wrote:
> "cpu.h" is target-specific. Definitions which can be used
> by hw/ code when building QOM blocks can be in "cpu-qom.h",
> which is target-agnostic.

What I'm trying to allow here are QOM uses such:

../../hw/riscv/opentitan.c:199:61: error: use of undeclared identifier 
'IRQ_M_EXT'
   199 |                               qdev_get_gpio_in(DEVICE(cpu), 
IRQ_M_EXT));
       |                                                             ^
../../hw/riscv/opentitan.c:230:44: error: use of undeclared identifier 
'IRQ_M_TIMER'; did you mean 'IBEX_TIMER'?
   230 |                                            IRQ_M_TIMER));
       |                                            ^~~~~~~~~~~

> Move the MISA bits (removing the pointless target_ulong cast)
> and the IRQ index definitions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu-qom.h  | 40 ++++++++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.h      | 24 ------------------------
>   target/riscv/cpu_bits.h | 15 ---------------
>   3 files changed, 40 insertions(+), 39 deletions(-)



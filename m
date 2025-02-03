Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8BAC02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0Yu-0005jw-HX; Mon, 03 Feb 2025 12:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf0Ys-0005jN-ER
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:48:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf0Yq-0007Ou-3C
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:48:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4368a293339so55053175e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738604918; x=1739209718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SuiXt82jmg07KF4QARlJ6lRA6PyjX9pCZ9OzLu38v+4=;
 b=W4Bz/3R5/MCwEQCzCCvUUGsQn6dMr6ktyewNP6I3qAce6p13kcsLa+9r7OREgf/XTN
 5LJJ7OdSuqZ0xnfp8yG7hk91QEs2YAGakZEB4aNauxNBcAFiaY4Zudi861gRIF7PM3tP
 QGKydGvikQRvurewUlwnVvR1AFQeuZRrDw0DdVUy7WrCZgHETx5rEl7oz7o8aepEpwk1
 BTn0TxCcQSQNu6rJmqdbSCacGN/6b0uqwtyj60yUQO0468GhmLwLl1CK+aLYJ9eKJEoO
 rUgX4DvhKyezVGCr+waaTViG94LKKmoj+SPmzMhrclCM+ZJGNC0fBj5TmFZ9AI/GtFNv
 /98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604918; x=1739209718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SuiXt82jmg07KF4QARlJ6lRA6PyjX9pCZ9OzLu38v+4=;
 b=f7tdVHB2FBJLm5IKccZIFazQRGuuASopOBL0W8ATSc32oj5+t41zcVjmTlB0dkS1y5
 eUuHZ7YGd3iBJkDZIQSP8wDJ888R8EYefVXWZYYWU5sOdZwX910d6ne6r99UDxCQT+/a
 2i9WwsXfiNM+dqhXJ6mtPFERQ6VKBf9vvr4dm/i+oARTCAGu/elWXWDub5F59c5Qeslm
 VVsYaMlFxS+S70R7tIf5p31bCQSbEKZyrLkeOd/M51AkydoVs206ugFR43irEpWbWrhS
 ktzT6Gi1gGqiIoWaZmN3+XSwiFmzqVOZDbRwE5xAMjNnTKbgGffuXYcfR8BY1JXEjP2O
 hvKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhBCSqQP7702SYzc6EsRp3x26THfaOiKADsyJP+ev5ZKti7KlM2+iMyF5InwVq467wegQrB0zSYEzR@nongnu.org
X-Gm-Message-State: AOJu0YxUTQIXCyCX6pld74q4+L7QqicmCoTNspJUQwWyhoME2Xw/Us4X
 YiTn4BKjSvSWE86TsVz8YJwMg7W7+I3LEl7YUlQxqCurNdW8jvmFWfdHiU7Ps2A=
X-Gm-Gg: ASbGncsd46wLc90yRJUgNP5GBawU5FfE/PkqZu+G1yblFrgfCzee5Y/2z15DZen95yL
 r+0VbpWNXQvBRiHK/wBHOmenGMLPQ0Qgj969Jfjzl+d9EBveJ4MC5YlOkZ2YpXFWNToT4mj7nxQ
 AIs/uwhTvEfrDaQMkMU86pEoHjmT3Gz3z5tJL7lWIFWpPhSWosDLB5qUL8/ojP2QoVvJDQAI/Ql
 I2dhYa6gG7/WHs5ACeUsY+QhQxPst4B4BlI8ELSM9cLwU62lNUVdFqczhEi0CDMf15fgfkJqlF6
 UIwXB/fsN+xPSSa/dmOGU+f3Q4q1qf4dXIEslEtBgXnTbSIiJydUBb4NWlE=
X-Google-Smtp-Source: AGHT+IEZlbWTwOwQWMvh6an2g8qjzbXkzCf0HVAilBdTQ/GYkaZYioCKFV/Y5dwa6WZSCSR3v8U0gw==
X-Received: by 2002:a05:600c:1e20:b0:438:a1f4:3e9d with SMTP id
 5b1f17b1804b1-438dc3c405dmr180653705e9.9.1738604917776; 
 Mon, 03 Feb 2025 09:48:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b547csm13547569f8f.62.2025.02.03.09.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:48:37 -0800 (PST)
Message-ID: <840c162c-b949-436b-8929-15cfdd0f94e7@linaro.org>
Date: Mon, 3 Feb 2025 18:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250203031821.741477-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/2/25 04:18, Richard Henderson wrote:
> Define TARGET_LONG_BITS in each target's configure fragment.
> Do this without removing the define in target/*/cpu-param.h
> so that errors are caught like so:
> 
> In file included from .../src/include/exec/cpu-defs.h:26,
>                   from ../src/target/hppa/cpu.h:24,
>                   from ../src/linux-user/qemu.h:4,
>                   from ../src/linux-user/hppa/cpu_loop.c:21:
> ../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [-Werror]
>     11 | #define TARGET_LONG_BITS              64
>        |
> In file included from .../src/include/qemu/osdep.h:36,
>                   from ../src/linux-user/hppa/cpu_loop.c:20:
> ./hppa-linux-user-config-target.h:32: note: this is the location of the previous definition
>     32 | #define TARGET_LONG_BITS 32
>        |
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configs/targets/aarch64-bsd-user.mak        | 1 +
>   configs/targets/aarch64-linux-user.mak      | 1 +
>   configs/targets/aarch64-softmmu.mak         | 1 +
>   configs/targets/aarch64_be-linux-user.mak   | 1 +
>   configs/targets/alpha-linux-user.mak        | 1 +
>   configs/targets/alpha-softmmu.mak           | 1 +
>   configs/targets/arm-bsd-user.mak            | 1 +
>   configs/targets/arm-linux-user.mak          | 1 +
>   configs/targets/arm-softmmu.mak             | 1 +
>   configs/targets/armeb-linux-user.mak        | 1 +
>   configs/targets/avr-softmmu.mak             | 1 +
>   configs/targets/hexagon-linux-user.mak      | 1 +
>   configs/targets/hppa-linux-user.mak         | 2 ++
>   configs/targets/hppa-softmmu.mak            | 1 +
>   configs/targets/i386-bsd-user.mak           | 1 +
>   configs/targets/i386-linux-user.mak         | 1 +
>   configs/targets/i386-softmmu.mak            | 1 +
>   configs/targets/loongarch64-linux-user.mak  | 1 +
>   configs/targets/loongarch64-softmmu.mak     | 1 +
>   configs/targets/m68k-linux-user.mak         | 1 +
>   configs/targets/m68k-softmmu.mak            | 1 +
>   configs/targets/microblaze-linux-user.mak   | 1 +
>   configs/targets/microblaze-softmmu.mak      | 3 +++
>   configs/targets/microblazeel-linux-user.mak | 1 +
>   configs/targets/microblazeel-softmmu.mak    | 3 +++
>   configs/targets/mips-linux-user.mak         | 1 +
>   configs/targets/mips-softmmu.mak            | 1 +
>   configs/targets/mips64-linux-user.mak       | 1 +
>   configs/targets/mips64-softmmu.mak          | 1 +
>   configs/targets/mips64el-linux-user.mak     | 1 +
>   configs/targets/mips64el-softmmu.mak        | 1 +
>   configs/targets/mipsel-linux-user.mak       | 1 +
>   configs/targets/mipsel-softmmu.mak          | 1 +
>   configs/targets/mipsn32-linux-user.mak      | 1 +
>   configs/targets/mipsn32el-linux-user.mak    | 1 +
>   configs/targets/or1k-linux-user.mak         | 1 +
>   configs/targets/or1k-softmmu.mak            | 1 +
>   configs/targets/ppc-linux-user.mak          | 1 +
>   configs/targets/ppc-softmmu.mak             | 1 +
>   configs/targets/ppc64-linux-user.mak        | 1 +
>   configs/targets/ppc64-softmmu.mak           | 1 +
>   configs/targets/ppc64le-linux-user.mak      | 1 +
>   configs/targets/riscv32-linux-user.mak      | 1 +
>   configs/targets/riscv32-softmmu.mak         | 1 +
>   configs/targets/riscv64-bsd-user.mak        | 1 +
>   configs/targets/riscv64-linux-user.mak      | 1 +
>   configs/targets/riscv64-softmmu.mak         | 1 +
>   configs/targets/rx-softmmu.mak              | 1 +
>   configs/targets/s390x-linux-user.mak        | 1 +
>   configs/targets/s390x-softmmu.mak           | 1 +
>   configs/targets/sh4-linux-user.mak          | 1 +
>   configs/targets/sh4-softmmu.mak             | 1 +
>   configs/targets/sh4eb-linux-user.mak        | 1 +
>   configs/targets/sh4eb-softmmu.mak           | 1 +
>   configs/targets/sparc-linux-user.mak        | 1 +
>   configs/targets/sparc-softmmu.mak           | 1 +
>   configs/targets/sparc32plus-linux-user.mak  | 1 +
>   configs/targets/sparc64-linux-user.mak      | 1 +
>   configs/targets/sparc64-softmmu.mak         | 1 +
>   configs/targets/tricore-softmmu.mak         | 1 +
>   configs/targets/x86_64-bsd-user.mak         | 1 +
>   configs/targets/x86_64-linux-user.mak       | 1 +
>   configs/targets/x86_64-softmmu.mak          | 1 +
>   configs/targets/xtensa-linux-user.mak       | 1 +
>   configs/targets/xtensa-softmmu.mak          | 1 +
>   configs/targets/xtensaeb-linux-user.mak     | 1 +
>   configs/targets/xtensaeb-softmmu.mak        | 1 +
>   67 files changed, 72 insertions(+)

Simpler to review split in 2 (32, 64).

$ git grep -l TARGET_LONG_BITS=32 configs/targets/
configs/targets/arm-bsd-user.mak
configs/targets/arm-linux-user.mak
configs/targets/arm-softmmu.mak
configs/targets/armeb-linux-user.mak
configs/targets/avr-softmmu.mak
configs/targets/hexagon-linux-user.mak
configs/targets/i386-bsd-user.mak
configs/targets/i386-linux-user.mak
configs/targets/i386-softmmu.mak
configs/targets/m68k-linux-user.mak
configs/targets/m68k-softmmu.mak
configs/targets/microblaze-linux-user.mak
configs/targets/microblazeel-linux-user.mak
configs/targets/mips-linux-user.mak
configs/targets/mips-softmmu.mak
configs/targets/mipsel-linux-user.mak
configs/targets/mipsel-softmmu.mak
configs/targets/or1k-linux-user.mak
configs/targets/or1k-softmmu.mak
configs/targets/ppc-linux-user.mak
configs/targets/ppc-softmmu.mak
configs/targets/riscv32-linux-user.mak
configs/targets/riscv32-softmmu.mak
configs/targets/rx-softmmu.mak
configs/targets/sh4-linux-user.mak
configs/targets/sh4-softmmu.mak
configs/targets/sh4eb-linux-user.mak
configs/targets/sh4eb-softmmu.mak
configs/targets/sparc-linux-user.mak
configs/targets/sparc-softmmu.mak
configs/targets/tricore-softmmu.mak
configs/targets/xtensa-linux-user.mak
configs/targets/xtensa-softmmu.mak
configs/targets/xtensaeb-linux-user.mak
configs/targets/xtensaeb-softmmu.mak

OK.

$ git grep -l TARGET_LONG_BITS=64 configs/targets/
configs/targets/aarch64-bsd-user.mak
configs/targets/aarch64-linux-user.mak
configs/targets/aarch64-softmmu.mak
configs/targets/aarch64_be-linux-user.mak
configs/targets/alpha-linux-user.mak
configs/targets/alpha-softmmu.mak
configs/targets/hppa-linux-user.mak
configs/targets/hppa-softmmu.mak
configs/targets/loongarch64-linux-user.mak
configs/targets/loongarch64-softmmu.mak
configs/targets/microblaze-softmmu.mak
configs/targets/microblazeel-softmmu.mak

Surprising, only 32-bit ISA is implemented.

Looking at the patch context I see:

+# System mode can address up to 64 bits via lea/sea instructions.
+# TODO: These bypass the mmu, so we could emulate these differently.

configs/targets/mips64-linux-user.mak
configs/targets/mips64-softmmu.mak
configs/targets/mips64el-linux-user.mak
configs/targets/mips64el-softmmu.mak
configs/targets/mipsn32-linux-user.mak
configs/targets/mipsn32el-linux-user.mak
configs/targets/ppc64-linux-user.mak
configs/targets/ppc64-softmmu.mak
configs/targets/ppc64le-linux-user.mak
configs/targets/riscv64-bsd-user.mak
configs/targets/riscv64-linux-user.mak
configs/targets/riscv64-softmmu.mak
configs/targets/s390x-linux-user.mak
configs/targets/s390x-softmmu.mak
configs/targets/sparc32plus-linux-user.mak
configs/targets/sparc64-linux-user.mak
configs/targets/sparc64-softmmu.mak
configs/targets/x86_64-bsd-user.mak
configs/targets/x86_64-linux-user.mak
configs/targets/x86_64-softmmu.mak

OK.

Preferably splitting 32/64:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



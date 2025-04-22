Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B2C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KTF-0001zl-S4; Tue, 22 Apr 2025 16:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KTB-0001qG-5M
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:43:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KT9-0005xT-AI
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:43:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so79073305ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354629; x=1745959429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sorQ2GMXeBLgFNu6I6UY8uBZaJDy7hszHh47QFAZoeY=;
 b=DwJyFNZgXJ4IYa6LWxpdbv2wdS0pnkWdw1IulkzH679PtJkPQJTzcI2ivpjGS4p1yD
 foIMAG3JF8OHhGwEcY+Rb8CDVQ+NkuQcstYLQvADy6sakX/vsnDhNP+vXgrvYdAu1ham
 HCE/EbihvGLd3L91HYj9wQh4NUHVIX6u5SmYPZG7Hqn0k7WjJ1LTHLKPaOkoYpa/ioIE
 Ff5kVZrrvJEZxveq4jtD7mWehTDD8KtHOVf176b9FSUneL2Rw0oO9bZmngNna5tiOvag
 QFlkbgFD7KBnygTKeQbgVXalgJ22hYIpShNtxXs4Go1Fmj2Q2r1K0nI8fHTWbevXrTV5
 zKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354629; x=1745959429;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sorQ2GMXeBLgFNu6I6UY8uBZaJDy7hszHh47QFAZoeY=;
 b=u+e/pNFg4S4QDprqFG6h8u98Spth0YS85AnDJrtjGvQEorOzMxzi52B5T60Wtkdsp1
 V3q8Pbyr/T41OvWCIyhbSNV1JH8RgCVL4Ft4R52oQ7QqjdQVR1ABDq4kcLlxa23OedPl
 +r3isPYpVPM9hP3Fr0Y8vUK26nhbyxWigWX7TXN1nExccYcS1IcJrQ2D1c/w3rTwD818
 z8/9YiqsKinO4I7aXwE1Dt8m8AbBTGFAeFWfjOILKACr8ngMLT5FpmWZOMr/4i98Z0IZ
 tn37ezNpFF7kHnMjXeXhNEOPfSlj9Yx5hKLA5TqAWWCPR/cHooZQz8nn0bDSTXuh5CfK
 lPAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh01prQINz1NOY6gzK/qlKs7phCiQr6Vb8h3JKwLTNgAzD0hz7xo1tvhSlj2657SIjPWZT1AAGc9tm@nongnu.org
X-Gm-Message-State: AOJu0YzLWHtythpw+8vYKlcAl47/DweSIHU+WDMt4VsG3J5P2np6XybC
 tb6AuD5P/gJLhHYDNImy+IvH0KqZEL+yHOnj3rfxwMgpcm4O4Wwgx8jda9YxRdKHk1jIZK9jCHl
 z
X-Gm-Gg: ASbGncthuIbgm2N9D/fI1Z2QD8n7WK76uTHm7To159U6jnxl4G9l1mx5gEhFgxDcB4z
 yTvHgFJNc1CqJFsbXiFkOC2yQs3vYivqhbDZuQ6VEStabILqppYKu9psCo3W5yRnDxQdzB7TQrY
 o4mLfHPKSOgd7fvEN3n+qSARZUOJfTBjVurPHl5ukR+Y7+NAwoFYnBx3ujqSYzNkgR0PXvwbDQk
 Ic7YW2M6frl+TJRjRXGkNCNTkHarRqnr1cBpN1BKvR5Mmlaak9bHj3scn3AfxYUyb5rrMZLZmgd
 rDuExSmfJogBb4Dz+QmCywwrxpOousjwdwLtG51xmUPEFLxiidZLIA==
X-Google-Smtp-Source: AGHT+IGaTT5Do5JuqF/IrGRdrcEFVB8cURqkEI8LrziCx/qjoysrzv/q5umuy+iKeAVe1m+uUwPX1g==
X-Received: by 2002:a17:903:41c9:b0:223:52fc:a15a with SMTP id
 d9443c01a7336-22c536075c2mr246465325ad.33.1745354629488; 
 Tue, 22 Apr 2025 13:43:49 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c5d601305sm75001075ad.17.2025.04.22.13.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:43:49 -0700 (PDT)
Message-ID: <94248c48-9408-4b45-a21b-aaf99308140d@linaro.org>
Date: Tue, 22 Apr 2025 13:43:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 048/147] include/exec: Split out watchpoint.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-49-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> Relatively few objects in qemu care about watchpoints, so split
> out to a new header.  Removes an instance of CONFIG_USER_ONLY
> from hw/core/cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
>   include/hw/core/cpu.h               | 30 ---------------------
>   accel/tcg/tcg-accel-ops.c           |  1 +
>   system/watchpoint.c                 |  1 +
>   target/arm/debug_helper.c           |  1 +
>   target/i386/cpu.c                   |  1 +
>   target/i386/machine.c               |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  1 +
>   target/ppc/cpu.c                    |  1 +
>   target/ppc/cpu_init.c               |  2 +-
>   target/riscv/debug.c                |  1 +
>   target/s390x/helper.c               |  1 +
>   target/s390x/tcg/excp_helper.c      |  1 +
>   target/xtensa/dbg_helper.c          |  1 +
>   14 files changed, 53 insertions(+), 32 deletions(-)
>   create mode 100644 include/exec/watchpoint.h
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



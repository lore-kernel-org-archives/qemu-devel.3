Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3363ED58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZHL-00022P-Af; Mon, 25 Nov 2024 08:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tFZHJ-0001zE-FH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:37:25 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tFZHH-0000lo-Gz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 08:37:25 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7248c1849bdso4404242b3a.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 05:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732541841; x=1733146641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30sNnKLjIG+X0DddhDYNVvgCWDY8gxVcKu0ojUEV0Ic=;
 b=n0upVOuy6qjGQWkO6m7fO+VSABhJN5wb3vfy7EvcxOEl2Gzmhaje+PnGAWitkKRgCZ
 DNhheqjb0NL9fz20w2GjZ9Nh7awiE0NcUUj0gK93dHGy2sXkAoPeH40R4N58qQxhNgbM
 G8fM0W1PSiuiaTX6KO4gftM9J5HfWnznpwl5cVhc/AA6X/A52Kw6wUDYtxEJ6hrfeOh0
 yLVfZq4aRxrhDJ7bWpvD5iiDQejacNlPE/6enpUZJqf9kFl7jLgRJ4VztHNO1Df2x1R/
 PrLwyKIOOUZKs+E7e7hZKCUoqefTnJ2DnPpsLuKOhyO02WpC4SOAykCYawVQjwrqCTAh
 pGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732541841; x=1733146641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30sNnKLjIG+X0DddhDYNVvgCWDY8gxVcKu0ojUEV0Ic=;
 b=ac572MfKEzEuc7W2XD76IQdlEth0LIOSSGQZYSop87/D+vtfdm5RASEcFhkSEYXu0O
 y4NBwUgpGWfacVvu7mIouQeaAe0Hi1MKZe98ijtyNBsHSDsLpb5X3UbTBM7ThJfB805H
 l3Js6gCgJdGrvLWcaZ1b5/6Ifky9X9t0jBP/1Z/YPpQ7MeN/XwDIlM++/UQb9Ii83MeH
 jXSStviXimR3FPpcBIlknKLwxeuTNzyfhe33Gye65/idwCuvIKOxz2WZjGwQ5p+SIKYB
 QJOJiBLXLpkcyYmLphYnUgAnuCwz+xpwLloL2CC6Js8I31O/ejmjfJzA+wKBzqVe5+6u
 bgVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk/GUtB61uhkXBb76YpXgtQbO2CsbyenuQVc2KWrQshnSX5IWkoJmIXxCh4puC9WqyXGJihtSn+ZOw@nongnu.org
X-Gm-Message-State: AOJu0YwhOxYqPO7R+lx1yjsn/LUqiDn77cPwOBKeVRxR/m2jnmupx6XR
 TqFekoGdRyOAfGSMl39pcE30cv+Ww0r+uzQ2vWGZ/m1WpfaJ8+ppPMHUrRHj6OE=
X-Gm-Gg: ASbGnct/NCzyCu6bnG6ROrtVWOlWGIuUeKt78bO18YLkqVPoYrjD4kdSMqd8owMUVaD
 YJn9aI94zi9nk+X1Gn98Uy/wlX2RLxht0diQp5yxQsFxbheBP/K+TXlczgQcL0K8LgN31Bg7G8X
 +hcSGHXWImj3lyhAXjNmhjc810aJyY6HCEW53uGcDGhBqoh6j96vlz2hCvEFs8gaBezdAP3zVoB
 LVMaO5M59kcUF6ooItTrhu1mvK3+sXc6MavKYlbZ3Cg/jVjmJjRo878eUtCheU=
X-Google-Smtp-Source: AGHT+IF0ORFvsoXHhr245DHOFUfCRQ5+JqW4V/UPXsmPoVch6cWd4xk9e7Iy5HRpFc99b8rO2gyrzA==
X-Received: by 2002:a05:6a20:c91c:b0:1dc:5023:e8d9 with SMTP id
 adf61e73a8af0-1e09e4af483mr19642573637.25.1732541841557; 
 Mon, 25 Nov 2024 05:37:21 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc3de284sm6606468a12.55.2024.11.25.05.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 05:37:21 -0800 (PST)
Message-ID: <f4aa9779-8d69-46ac-9923-3beecf760770@ventanamicro.com>
Date: Mon, 25 Nov 2024 10:37:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Pointer Masking update for Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alexey,


I believe this is not the second version of this work. When I asked about the
next versions this was already in v9:

https://lore.kernel.org/qemu-riscv/d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.com/

And it had most of the patches already reviewed by Alistair and Richard. So this
would be in fact v11, with a lot of patches already reviewed.

If you could re-send this series as v11, keeping reviewed-by tags from code that you
didn't change from one version to the other, the review will go faster.


Thanks,

Daniel

On 11/21/24 3:12 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Hi,
> 
> I've rebased this patch series and addressed Richard's and Daniel's comments.
> Thanks
> 
> *** BLURB HERE ***
> [v0]:
> As Pointer Masking is finally ratified, these patches intend to update the existing code to the final version.
> These patches have been submitted previously and I tried to address all the suggestions, but I'd suggest to review them from the clean slate and then finally push them to the repo.
> Thanks.
> 
> Alexey Baturo (7):
>    target/riscv: Remove obsolete pointer masking extension code.
>    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>      of Zjpm v1.0
>    target/riscv: Add helper functions to calculate current number of
>      masked bits for pointer masking
>    target/riscv: Add pointer masking tb flags
>    target/riscv: Update address modify functions to take into account
>      pointer masking
>    target/riscv: Apply pointer masking for virtualized memory accesses
>    target/riscv: Enable updates for pointer masking variables and thus
>      enable pointer masking extension
> 
>   target/riscv/cpu.c                      |  19 +-
>   target/riscv/cpu.h                      |  51 ++--
>   target/riscv/cpu_bits.h                 |  91 +-----
>   target/riscv/cpu_cfg.h                  |   3 +
>   target/riscv/cpu_helper.c               | 124 +++++---
>   target/riscv/csr.c                      | 357 ++----------------------
>   target/riscv/insn_trans/trans_rvh.c.inc |  11 +
>   target/riscv/machine.c                  |  17 +-
>   target/riscv/pmp.c                      |  14 +-
>   target/riscv/pmp.h                      |   1 +
>   target/riscv/tcg/tcg-cpu.c              |   5 +-
>   target/riscv/translate.c                |  51 ++--
>   target/riscv/vector_helper.c            |  18 +-
>   13 files changed, 224 insertions(+), 538 deletions(-)
> 



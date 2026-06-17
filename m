Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EA4CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZthZ-000714-1T; Wed, 17 Jun 2026 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZthR-0006y0-CT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:05:14 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZthP-0003rC-MR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:05:13 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36c68964315so3430506a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781715910; x=1782320710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gTEmAIBu0NGxTjinfJpj06fXpHghOBR+zCjg3Uxb+Lw=;
 b=xcWxIWJaipEPIv3MHgF2HrOPrtSh8+dW9QHGIhWLnYsBT3MJbTMNt/QEvdhbZKDVdg
 8ed2PcG1WP8veaEZFe5iZQ0gx96XP7hNuuSt3F5h25iK6pWuJtSvvgmUaByoD3aEstD7
 PXHYj4LZ0zHPKopLwdtRRxLMvEDvh+6e+jnFAV7KzDwr77l6ztiOYYl7zjQrXhXMuLvn
 pPS/C1pZa1cMYQUV/Vj4+jyNhCwDc3E0IX4w/1S17QVzJ0zKld0nO/VbPWFSptxBLtyv
 rJbdV002ZwJwgsVkUvc5ws8yVZ4x0SP1QidqLQiyvEBW93qbOV0AvJgQJEeBgCK70+XY
 LanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781715910; x=1782320710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTEmAIBu0NGxTjinfJpj06fXpHghOBR+zCjg3Uxb+Lw=;
 b=qvIfKwy2o0bgScv9p8RQccL4G1v/nvY0OewnL+W2ILJypCBu7FiVTvAZM1QkCbhvRh
 ctUiXNio0FVWXnaweyuN1C3J5da39tAAvbOq+BIy3839Ap4gxXz6iVdP1TCufUbh86tn
 743GF2BeentMMYmVHrgafCAT9olivrKRy+nLPsZUCT+13JgkGy8WJWw3N93/bIjpJjXN
 YFRcHx0QwEoCu6LML+tupucy0nelVkMcQWmygQ4xXapnUUnr1jsq2f94lpK0PhzPqiF2
 Y8aNONEmRrbsXwCYXSOI/bsTPWT9PYetl4rUdQK1oUsU+iRi7oRNpCzD8/BvYYNxL7Tt
 XLKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hrEw8vfWIMj3zgMVqavd5Vp29HpXqwr47if6XWwYk61xjvbr7cm/usyJE949yoq29juQYg6c8eBPE@nongnu.org
X-Gm-Message-State: AOJu0YyLo+98Rt3FoXeGcBgKT2Itu1JENtfclfLtqHK6tBet+b/CcyvK
 bFS/PTU3ZqsLIMqn8IVx659XtAMbMcdt8HiaQsU51x7LgQxpLpViy/6k3DGBeqzvAIukJresI8W
 tAu5a
X-Gm-Gg: AfdE7ckXGEMX+gOTp7W+piipPyTfK8KreMWjQCVpoI4TUVJy2W1v8veSeOfK5xk2jXv
 wt/SO/hMrWFhIOpXBf3BZ7K2FvdoqWjeuJpQmMdLcBYzSrGcknCDM3G+0WYp5YoESnN//4rQJCE
 BYbVvQHI9VNL4CQe3bgVOfNAxH8TbAF78dAAW+HWpkEr5nN6dMCJjtrb5uckCWJHe13cwK8A8VB
 hQ3RDbn9Z5Ws1Fgc8LQDq+4lgWIRs+/kypdRxuqfM8M9+mcgfTZatDRSAM1OEzs95qnDa9e3bXR
 SegRGdlK/kGVHSpMybK7arZWluuxq1+AXWTtVxzD7f61Cw8rjOjoy+Q+Q5ohtd6Djgui6V1fKXL
 8FNxHNn4JqEZq9Bb4iN9enXfAXFZRpwkiyPrt0AzZP7k7x5wudY8cFJsMVaVaoK8PcURJV7HHgN
 UW/YXq862axIcX1W+0tBTNxYw9iIxMWL/JUuMokml+fEUkubyv5IJ44NMtdQ==
X-Received: by 2002:a17:90b:5390:b0:36d:b12f:6143 with SMTP id
 98e67ed59e1d1-37c94241679mr4605414a91.25.1781715910011; 
 Wed, 17 Jun 2026 10:05:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86651af0edsm14342485a12.32.2026.06.17.10.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:05:09 -0700 (PDT)
Message-ID: <6527204a-a6de-4980-9f13-6f04e10fea9a@linaro.org>
Date: Wed, 17 Jun 2026 10:05:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] exec/cpu-common.h: Avoid including unused
 exec/page-protection.h header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260617160426.64461-1-philmd@oss.qualcomm.com>
 <20260617160426.64461-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260617160426.64461-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/17/26 09:04, Philippe Mathieu-Daudé wrote:
> Since commit e74781c0888e ("exec/cpu: Extract page-protection
> definitions to page-protection.h") the "exec/cpu-common.h" isn't
> using anything defined in "exec/page-protection.h"; remove it.
> 
> Include it in few files where it is currently pulled in indirectly,
> otherwise we'd get:
> 
>    linux-user/qemu.h:182:22: error: ‘PAGE_READ’ undeclared
>      182 | #define VERIFY_READ  PAGE_READ
>          |                      ^~~~~~~~~
>    target/loongarch/cpu_helper.c:329:25: error: use of undeclared identifier 'PAGE_READ'
>      329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          |                         ^
>    target/loongarch/cpu_helper.c:329:37: error: use of undeclared identifier 'PAGE_WRITE'
>      329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          |                                     ^
>    target/loongarch/cpu_helper.c:329:50: error: use of undeclared identifier 'PAGE_EXEC'
>      329 |         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>          |                                                  ^
>    target/ppc/mmu-hash32.h:98:20: error: use of undeclared identifier 'PAGE_READ'
>       98 |             prot = PAGE_READ | PAGE_WRITE;
>          |                    ^
>    target/ppc/mmu-hash32.h:98:32: error: use of undeclared identifier 'PAGE_WRITE'
>       98 |             prot = PAGE_READ | PAGE_WRITE;
>          |                                ^
>    hw/ppc/ppc_booke.c:39:17: error: use of undeclared identifier 'PAGE_RWX'
>       39 |     tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
>          |                 ^
>    hw/ppc/ppc_booke.c:39:33: error: use of undeclared identifier 'PAGE_VALID'
>       39 |     tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
>          |                                 ^
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/exec/cpu-common.h     | 1 -
>   linux-user/qemu.h             | 1 +
>   target/ppc/mmu-hash32.h       | 1 +
>   hw/ppc/ppc_booke.c            | 1 +
>   linux-user/arm/elfload.c      | 1 +
>   linux-user/hppa/elfload.c     | 1 +
>   linux-user/x86_64/elfload.c   | 1 +
>   target/arm/tcg/cpregs-at.c    | 1 +
>   target/loongarch/cpu_helper.c | 1 +
>   target/ppc/cpu_init.c         | 1 +
>   10 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


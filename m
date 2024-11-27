Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF52BD6ACF4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGKaR-0001lu-RK; Wed, 27 Nov 2024 11:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGKaI-0001jA-D2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:08:10 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGKaG-0004u8-Qa
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:08:10 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ffc80318c9so33896961fa.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732723686; x=1733328486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIkCk7y38vWyW+8Cbf3UeBCVXSKBTT0KIxuchZyj8YM=;
 b=eP8qUHEWBaoMEjR/+MgXommPkHKp4QsRg04RodDqpIXijyAKKxXy0cqZkAw02EqGQX
 zwfu58oqv9G3w7ETn26FuTe2ejMH1h8mCkAZMIUEilwl279pyTmqoVoq8gP+jsGCQzZR
 wa5riCJD8/hS/VdyzB16WkGx0uRvSpmizECXUABQOtcWAp7a84F7uhHffGhWJdb0wMA3
 phRUyzQjEjzHzEM2zPCIjKoeXgIxtt2lkWjnx415pkOW7glpY03YM6gxk2J8Zse2hByQ
 izb0M/JbQpOu2iou2d9DB/FyIJuSifBlJzK288t80CHQOMf/xEJLlWkeztchD1T4h0dq
 KrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732723686; x=1733328486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIkCk7y38vWyW+8Cbf3UeBCVXSKBTT0KIxuchZyj8YM=;
 b=S8dPzfNsChxjYI78m1rwaLICLCLutXOMoVDWxskCyj+YjdGw3v5V0cBQsGDu/BDx32
 ean6sDGto6guDubx9/FrDKBTDhTo9B2DFHLLmsfYyNWemehTf+3aEqxCQj2QN7LO65m8
 ZrKdtfgQ2FV/KavQrDA2dXolSwyUl2eHeRVxVq/IontRUXnaT7qSunkUCh6+4HhgAUyt
 x8r8opAQ+f8jr38tDrIzGMthI11Hc2/q8aYThn2LsBVbwzlvCzbjfGVM42fj8dffMA+A
 NUqW4zyQJboycbudG+guCcmSyk1c5NKmXvKZJ5KOSU41TM+qY/J5gUq3lv/9BGxDJ1W3
 aI2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMaZvwf29Ie9kr0o6qwIUZP2xzAwFSsA052ItmRK8musOOdX+w7sSlPyA4WctdM6r6QyFZtDhuKpZh@nongnu.org
X-Gm-Message-State: AOJu0YwgWEhOrZILgPLBfe1XW8aVd6WhiELueeQ/M6yKRc2VzAYa2j6I
 z/muVqgVfxOfqdNCdgZQODULOAUhJ7bGeoNBIz4gfBEVvI/J4zi6BblpyT1Q98ibk5FXDKCoZZC
 aINQ=
X-Gm-Gg: ASbGnctCsrvJYantfsvm1jMqLqPioZ1tst4etJYV6n21LkQ5XsJy4x66sikc9raetey
 R/1MozAjB/ThXQNh1SPipXcdb1ACbN7zIu2R2d70RCpmeeNiP3lTZTaY3I5ye+CO69jkwALeDzH
 Cdk27m2cYdQwva1jm/QiIgwOoe6u07AyFg2lSeK7NF48U27W/68RLXUvy3pyzuLT4Tscjq5fLiW
 6u0NSLx0eaFencuHQG81p06OKAVgQEBMJjbZtVazSwpAUZfYgKlS76f89Yx34rIl0xy
X-Google-Smtp-Source: AGHT+IHjzom4tD3W7my2+NkDuaeQrpr8SABG5FHCVHO9bgCI1vrCiQs2kLNvVdRgb0zPo/X9XqZnSw==
X-Received: by 2002:a2e:b8c3:0:b0:2ff:b822:ec4c with SMTP id
 38308e7fff4ca-2ffd6130847mr21178021fa.35.1732723686512; 
 Wed, 27 Nov 2024 08:08:06 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffa4d57ad4sm21826811fa.60.2024.11.27.08.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:08:06 -0800 (PST)
Message-ID: <33ee1415-7f72-488d-bbf6-cf55e6d0a601@linaro.org>
Date: Wed, 27 Nov 2024 10:07:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/7] target/riscv: Apply pointer masking for
 virtualized memory accesses
To: baturo.alexey@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
 <20241127053523.397378-7-baturo.alexey@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127053523.397378-7-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
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

On 11/26/24 23:35, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>   target/riscv/cpu.h                      |  2 ++
>   target/riscv/cpu_helper.c               | 19 +++++++++++++++++++
>   target/riscv/insn_trans/trans_rvh.c.inc | 11 +++++++++++
>   target/riscv/translate.c                |  4 ++++
>   4 files changed, 36 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 11e3a6d647..6bbd9c6c25 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -634,6 +634,7 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>   /* If pointer masking should be applied and address sign extended */
>   FIELD(TB_FLAGS, PM_PMM, 29, 2)
>   FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
> +FIELD(TB_FLAGS, PM_VPMM, 32, 2)

(1) tb_flags is only 32 bits wide, and this overflows.

(2) All of the logic for HSV/HLV is in op_helper.c, so there's no point in doing this 
masking inline.  Do it in helper_hyp_* instead, possibly reusing pieces of adjust_addr 
from vector_helper.c.


r~


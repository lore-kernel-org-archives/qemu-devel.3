Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA838C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9xV-0005YP-3f; Mon, 03 Jun 2024 11:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sE9xT-0005Xi-IC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:50:51 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sE9xS-0004Kw-0D
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:50:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c1a5913777so3712186a91.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717429848; x=1718034648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QoW/nxIl4dcOnHCwat6JlRacAMOvrHIs2V+96TGk/MM=;
 b=dclHzgQfN/88f9F3RiBt+65Mv2Rw2O8cPY+qMO3khsmjWuR485SX18W3c8amLj5noR
 jUttZq/L49Kw+g2wWNiLGDWsyiPQyLuYVBxznGa+YzukwcAUwCvvt02o2QTxmsJ+btyM
 f0OKzJu7bJ01bYI/Q6f9/SLU9UfR6GSPqx/sqMOqG2xnAL4W8hy3WFI96yuR7AKJ1MoH
 19+POUKNTxOKjWZRXXDz/3MlNMxacdjHQbfq9FMPOwp84WPVbKz70jNkGjZHfT/843H2
 DdmuZgW6sKV5sND5ceQIsy1jVlgs4GPFbsPzlreWZbMYe4S/atiYSo1GPLZw8BCJEwAM
 xxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717429848; x=1718034648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QoW/nxIl4dcOnHCwat6JlRacAMOvrHIs2V+96TGk/MM=;
 b=KHqVMzb97GVVvu0X4kOhpjjWwvJ94mhPktsjFyFSm6HAwv+hy3Q2UTzOeXVlaDRHDs
 +L37R8jeBHJafnBEO7RKo4eKToxdaPNUGNDqW2dLBd62yNuW0VK0+u2M9SixUg8F5bxF
 ptD69mSpuGRI4p1CjjHIsVkk219RL6YlAtdT+BAyzA+FIGLGLCoxKW41cSUvSTb0MkFi
 8pkS/6Ec1Kf8M8CBuw4uMWEDU4ByIyiJo1hsWc70zDeqb7M+I6tpVqAqRR8/yQJgb+ZD
 CO37++Lk0Ix+Zksx4/mTAa69/RncOKMpg9Pr3nDijhPXZIpnXMl3Yf9Qb9AQqc3FNJGG
 p6jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqojOToCjGUzR0EaNSYQ4YhZPVu8FLsi3XSfdu0nsREWK7pm3JpmWUUE4LaJ6AMOTkJyc4StkFT8bRq6mw42Bwe7vxCho=
X-Gm-Message-State: AOJu0YwTtOew8nenpi/gHk4cGVJDmcDfDfzCfK4u+tj5R3Tuv/bdGkRN
 1/AaQaorsguNlRW5H5m7lrygQHAGEHCQbOouPoWVc0rk8/tEQW+dXoR2orl4WLU=
X-Google-Smtp-Source: AGHT+IHq4fpvclaUiYntHQa5JbuzYJ7+JQwgSlAWfZtaoz+aPENDBGnfLtLmVIk/W+AW2D1GxQdwUA==
X-Received: by 2002:a17:90b:1918:b0:2a2:c16:d673 with SMTP id
 98e67ed59e1d1-2c1dc5cce83mr8933619a91.36.1717429848065; 
 Mon, 03 Jun 2024 08:50:48 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c28425ecsm6446943a91.53.2024.06.03.08.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:50:47 -0700 (PDT)
Message-ID: <595c3be7-7a33-4812-a80c-975b2eaaf5a6@sifive.com>
Date: Mon, 3 Jun 2024 23:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/6] target/riscv: rvv: Optimize v[l|s]e8.v with
 limitations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
 <20240531174504.281461-6-max.chou@sifive.com>
 <1016c817-d1e0-4dbd-8fd9-921bcdc23a0a@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <1016c817-d1e0-4dbd-8fd9-921bcdc23a0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Richart,

Thank you for your feedback.
This version is created by referencing the gen_sve_ldr translation 
function with the similar assumptions that no mask(predication)/no tail 
agnostic/continuous load & store.
You are right, the expansion is large in this version (over 20 TCG 
instructions that suggested in tcg-op doc).
I will provide next version with the helper function implementation like 
sve_ldN_r in ARM target.

Thank you,
Max

On 2024/6/3 1:45 AM, Richard Henderson wrote:
> On 5/31/24 12:44, Max Chou wrote:
>> The vector unit-stride load/store instructions (e.g. vle8.v/vse8.v)
>> perform continuous load/store. We can replace the corresponding helper
>> functions by TCG ops to copy more data at a time with following
>> assumptions:
>>
>> * Perform virtual address resolution once for entire vector at beginning
>> * Without mask
>> * Without tail agnostic
>> * Both host and target are little endian
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>
> Why are you generating all of this inline?  This expansion is very 
> large.  I would expect you to get better performance with a helper 
> function.
>
> AGAIN, please see the Arm implementation.
>
>
> r~


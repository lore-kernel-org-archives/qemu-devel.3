Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E53E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBoo-0001hI-K0; Mon, 16 Dec 2024 09:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBoi-0001gx-K5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:11:26 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBoc-0007fn-Se
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:11:20 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-29fc424237bso1889714fac.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358277; x=1734963077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dl7va4bMEy4UsAhgaxe/RmvDU+0cIOOibLwaTU5mkuQ=;
 b=ELGbGRMDcW71p/Mf287zRKznnL8+/C2Ym6X8O2uj4lf1MBFO6RRxu2gY9htZfklTWX
 Ei5+becVzLWIPDCXdbNXN3EMmyNxF9J1xTDgOjK584cVCXSoBt+vMCpW7N5zRl1V3zgA
 fQAxkbQjZhvDR6gRxxyEzVOhZMlHtfAXITUBKas0C7GwM+nabxdDHN2raBIHwAZplCZX
 dLH2yrVuE3gXdis1UocMRnnTV36RX6pEkfaUa0WhsmaX2ReKL7Jgb5W1A80eWHJmkI5N
 htqi+t46BjzV/u4zFDXhe+1uN+VwZhlSDYk3CjE3MUJp/dxT26rbFIR+NLnJpsSIxypa
 HS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358277; x=1734963077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dl7va4bMEy4UsAhgaxe/RmvDU+0cIOOibLwaTU5mkuQ=;
 b=QLMh1aHEMnFteetgH+7z6tXQoY7Mesk5ue9IsoohEEUE8XmT/I8OP7LmarOAIGcY9G
 9wqazXqZzmvzkD2GVWEGg3XCoIwBjdlnyjYvcCgBVtoQbPJCiV3q5G9duRbbW0kg5aZm
 ryYwK3tihZpe/4RBGxzManC7T9RDH+tcwzzLIh6MSf+OTUW5rqzLTYZLsVx0KEdYGOQn
 nXRZ6Rna4pMGQKActe9A0zPbyBQPepZV0/C18TF5XWwhog8eVW/Cvmc9iyGTZx56dXfe
 ZbRhW0sv0D3+xVfdlWBJ6FvYV6ZtSr8z9Y+fm8hh+2SUsilmUKL+KB9puVq6WEG+axjd
 jgjg==
X-Gm-Message-State: AOJu0YxaljpnUJx60qasw23SEgoRPiI7EuCygJZblPqOwG13GiH+2m77
 4I+A0NR1aOqMnlvvvp08dq1wDgfWCxOaGJ4PrbTvLqLZC15RZhiLbWwfXgFFcec=
X-Gm-Gg: ASbGnctIbNJzaDEbWy2zxlQxsSUUlfFiE8zgHm4EJjr7g6ngXVAznXgJzdBcrGAIUGa
 OOpJb+VgNwMEw8r53LqzF7J2vukVlmYvHvYP7V1cSbdFNZyyxTO4WIoelnAXSgnHxwmzH/rd1cR
 newr5uRH9HCy9rZrCQzN8XikjELDN8atH57iudkfW7hyKXzdUrOhaEXu4CWqoN+yH99S5ZDCyWi
 UzFbtOcLwDyJd4V9xQ6baPhQu7NHP8LgX8Za4pTtXfyE9Oj9uAXN4XxGXYhi47Q0u/OcFF8nuQc
 DEwhNjNY4ZfOIfhavFPUTgruASMtjpVjf9I=
X-Google-Smtp-Source: AGHT+IFRa+SQHheE6SwPVdutuDmvYg9eBmlZKv+/kFmTI2Z7Dsdn18iwnggJHFVxL54ftoeNgCbRlg==
X-Received: by 2002:a05:6870:207:b0:29d:c709:a76c with SMTP id
 586e51a60fabf-2a3ac4a4ceemr5522285fac.4.1734358276846; 
 Mon, 16 Dec 2024 06:11:16 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d29cd6dbsm1904042fac.45.2024.12.16.06.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 06:11:16 -0800 (PST)
Message-ID: <038d99ca-65f4-4a76-bb2b-409108b47ad7@linaro.org>
Date: Mon, 16 Dec 2024 08:11:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/arm: Helper type cleanups
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <CAFEAcA8-P=cmov6FNP1uhD3YRpZk8BB0tdrS_yx-5L18SX5y4g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8-P=cmov6FNP1uhD3YRpZk8BB0tdrS_yx-5L18SX5y4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 12/16/24 08:01, Peter Maydell wrote:
> On Fri, 6 Dec 2024 at 03:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Add macros such that "fpst" can be used with DEF_HELPER to
>> indicate float_status* instead of "ptr" for void*.
>> In addition, fix a few uses of "ptr" that should be "env".
>>
>> r~
>>
>> Richard Henderson (9):
>>    target/arm: Introduce fpst alias for helper.h
>>    target/arm: Convert vfp_helper.c to fpst alias
>>    target/arm: Convert helper-a64.c to fpst alias
>>    target/arm: Convert vec_helper.c to fpst alias
>>    target/arm: Convert neon_helper.c to fpst alias
>>    target/arm: Convert sve_helper.c to fpst alias
>>    target/arm: Convert sme_helper.c to fpst alias
>>    target/arm: Convert vec_helper.c to use env alias
>>    target/arm: Convert neon_helper.c to use env alias
> 
> I see that commit a9af119f3d to put the fpst alias into
> helper-head.h.inc is already upstream, superseding patch
> 1 from this series, so I've queued the remaining patches
> 2..9 to target-arm.next.

Thanks!

r~


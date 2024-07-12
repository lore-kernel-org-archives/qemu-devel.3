Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8BCC3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHp0-00059c-Tp; Fri, 12 Jul 2024 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSHoz-00058o-Fn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:04:29 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSHox-0000Gm-S5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:04:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fbd1c26f65so13157145ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720796666; x=1721401466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oS1RRwgo0IS24aYQ/qVlIWHCO8mU3ADih+NTpk0WKz0=;
 b=gkl+E41HyyGkpYP/tzDhXZm90OgyOlt6ZqusD84mBPLYLk5PTlTIiTbs87Nz3roFTt
 RCjv0s7rpQX0bMICq8/o6LONQukacSeedknnJz92WTbrmIDhaGDpxmn9VwDNYslsAWr/
 n0ySKv04KrgUwElr4srtYNs2crg1J2yl6xmbTPx2YOS/1tdpj0jbdX8LXu0AvGn9E1KJ
 ZQSm3VevlpQ88sX4+Hg8kTq4I4OyyBMUpdsEKqoP89nzEid/CdqTbMpJeooDUbhSQjrY
 HaqOrX99M0LrdfKTP6MnbPXYj65BOfZ5y4C1Z22GaPZrIzk0nvionGiWN+T8aOOLemLr
 y5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720796666; x=1721401466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oS1RRwgo0IS24aYQ/qVlIWHCO8mU3ADih+NTpk0WKz0=;
 b=FrqS85w2OPQ7fjcAO2A3M4shUkgtqnrST3sR4k92XjtAQVs5Nw0l0V1iByKetSMBGJ
 MuOU1lXrQmqN18UutmF6JAHPtmxiKCZ2cCy7a69PIFrr5DjJga5bx0szk2tiL6XaMDac
 6mWdgitnjiTQ6NuA2BluSMufpXWYCRmQnaR8Rrf2MM8lMFaKmo+s1OADWBuAMu9ZOcOp
 g8dxGwL5nCmrbnJ/TcO3vobeFZfZ382K4IInvevnCSIW3Zx6agbv+UWd28fxenbriGRL
 yIg0V2Ha6YFm3gcr6g/HT07XD7F9TLUlyYO4mu/Lbd6ywEAoXC73EM3Rqr17N000UK3A
 FTfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKQ3djSncKEoa3n14Ge8JB6zopwX6Dt+MyP03k6+thsYy5QX5zGw3TuKBvBClgogaIyX1LOXv5UhgaLY2VGlHoqceTRU=
X-Gm-Message-State: AOJu0YynAHEDBjzbmIFamzGb4nJgJ6Vwl+r4EtLih05twQ1hCJcCAplS
 1zhm8aMwgvmVE3Tu/1wwKaPXWM9Oa3FbRjUR865T1j3NoHaVUBUmsH58jclpZJs=
X-Google-Smtp-Source: AGHT+IHKrd8VeqJ2WnLgFV05diDJN8DrPh9Lj1ZbPquUiRgnZAu8zuxDyGIVOKzNAxSJ5xMndhpwPQ==
X-Received: by 2002:a17:902:cec4:b0:1f9:8f78:554c with SMTP id
 d9443c01a7336-1fbb6d4df62mr100091975ad.33.1720796665344; 
 Fri, 12 Jul 2024 08:04:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac0e38sm68012695ad.214.2024.07.12.08.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 08:04:24 -0700 (PDT)
Message-ID: <27b82b27-c165-45aa-ad0c-39f8b2bb935f@linaro.org>
Date: Fri, 12 Jul 2024 08:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Make cpu_exec_interrupt hook mandatory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/12/24 04:39, Peter Maydell wrote:
> TheTCGCPUOps::cpu_exec_interrupt  hook is currently not mandatory; if
> it is left NULL then we treat it as if it had returned false. However
> since pretty much every architecture needs to handle interrupts,
> almost every target we have provides the hook. The one exception is
> Tricore, which doesn't currently implement the architectural
> interrupt handling.
> 
> Add a "do nothing" implementation of cpu_exec_hook for Tricore,
> assert on startup that the CPU does provide the hook, and remove
> the runtime NULL check before calling it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 4 ++--
>   target/tricore/cpu.c | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


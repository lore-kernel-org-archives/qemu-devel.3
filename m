Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAF5C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBs5r-00029V-Vv; Mon, 05 May 2025 05:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs5o-00028l-A9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBs5m-0001GM-8c
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:26:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso2805490f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437188; x=1747041988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyaWCjCMUqOY3aaW2CLqhwEdsLDMRK4/9Jbz+iER+Kg=;
 b=wu+kOXvk4OzO6Q+InE+RxqInC4gjHCKCL7FWTzHQ5QRkF8B4wAVOPFVbY3p9cOEMsj
 PBo2Gag5vEYZFwEoN8z7DeGSOYcalj5OUmLXXME+cIghD/knnb4EPENXnzHdttZYYQLm
 fw20lwhq9PgHTNc4FuVTc8FHJgmNV0USi6b8j66liF5kvoXhzn09MNp/tjZLIXx0Dw8C
 mWtTHSPrThLV/kRdB9RhfallkaaqbtN4ppdkmGpoAA19mG4rFKDVO4/lwymBiGz8P3D+
 FD3nhgE4F5/nbE6HL/AaU2F76cMb4gJE5z1uyPdg1UO7bX3AhOxm295IXHeEwDB73zHS
 qkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437188; x=1747041988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyaWCjCMUqOY3aaW2CLqhwEdsLDMRK4/9Jbz+iER+Kg=;
 b=QV5NWwi8faI96WPy1QZMb+4Lba0wwArgOxG1aiLhnRnzWpBNaLMQXUoRQmXtjnPAgA
 9tXq41HHLi/48tiMEYKiXCTvHI/mnjRmOb5oTgeLoSX/2L8nTkOkJt0YqvduYPjctFk/
 VURmqM1byTOyWoDBCk2Cu+EycHFY7QyVlmBrYoNr5KrNMPQyw9Faudlq7NC1SIf7A0oA
 hDgSetyrpD3FHDQFR/mMXwpPTRhi/smiY6N9XRc8RlfI/eUGfR57wMxlpDLmbKr9QH8/
 veeBad4xV0Wq+O+6N0Ql0Vx2ztqDaaG18b60+5lgzlUq4ZFBv9quO9APmy8pZam1K6Ip
 y3ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU45j/J96wZxOrQ9bPDJH4Lw6dvVen65EanrBPL7ncMkg+1CJ3uhBpbBbX9G/mkVOXLqSgmp5njhTQc@nongnu.org
X-Gm-Message-State: AOJu0YyJqmxHOCAb+fxYzRqW2DGvvycG8Zxucr+ERYX1FC/wNvZP0xXP
 51EuLI3FVdOUOlBzMGImIYBel9sw5W9AmcZ+BPJxWg38841Z+QjEOXQhPJzXWsM=
X-Gm-Gg: ASbGncuk4Nc6KJ7UvOHvdCM/ITnV5oqHm3ICUlvP2FUyc/oDSjAfbBtSp2mE1e74Ogm
 mIfTZC4I5s+IGy0lsbHp1jPCPC2tNIR2fLRPcKR8SKDwbq4q+lUDwHsAmDB/YrydarZk4lT9tWe
 Ds8ofbZvdlDoZBhfeiVnRW81uxnRQ3ShiUZnlFp72oB+tkZdLIAjQBBPpe3IoNG3g9usjJWPkZ+
 j4rkP81XEzt4xG8rUFly7xYJhtH+KY1xW5+wgAK3siBwy1kgKG+gWCrA3Lgn6tf54RmzzraZF7d
 TtjPkXSnH4DVgHaoi5NZtsD4vrGry1Q9a6ueRuP5ddXiRkpOHZzJWaH6kexyK9QyV/tF2QmzEou
 Uw86AYz1NBnnQlpcnvqoK+g2XR/dN
X-Google-Smtp-Source: AGHT+IHGJfh8GHRQj+wmWR3DmtgK1qxtcR+Dhg4Yh0ZNSz+R0+pWlrlsq6lQTg/MjASN8T7VdFy54w==
X-Received: by 2002:a5d:588d:0:b0:3a0:90bf:b9b with SMTP id
 ffacd0b85a97d-3a09cea72e3mr5341509f8f.8.1746437188006; 
 Mon, 05 May 2025 02:26:28 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17260sm10077743f8f.98.2025.05.05.02.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:26:27 -0700 (PDT)
Message-ID: <11a3bbac-514b-4446-bf24-4111d9b5ea2f@linaro.org>
Date: Mon, 5 May 2025 11:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] target: Use cpu_pointer_wrap_notreached for strict
 align targets
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Alpha, HPPA, and SH4 always use aligned addresses,
> and therefore never produce accesses that cross pages.
> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h |  5 +++++
>   accel/tcg/cputlb.c          | 13 +++++++++++++
>   target/alpha/cpu.c          |  1 +
>   target/hppa/cpu.c           |  1 +
>   target/sh4/cpu.c            |  1 +
>   5 files changed, 21 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



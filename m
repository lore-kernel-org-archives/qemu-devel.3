Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4E7D66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwkn-0008VB-OL; Wed, 17 Dec 2025 14:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwkh-0008Uk-EB
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:59:59 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwkg-0006ix-0i
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:59:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-29efd139227so75598985ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765997996; x=1766602796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPxnL1hILVAseREtLMBPs3ZiU0XdIuyPR4PAfuguluI=;
 b=hCGdRzJR9mjwFLtnbWNWIs55fs6kRFnGs6PR66OFgh3UDYh0rIvqHsnLGzhKKy8/xi
 uMtHjYCBm292wOLE6072dpLrFouEV+iiAT7Rcp7jphwvUcMxv9WFSWjkpQR3YOKyMpcs
 cY/efBVtk8lgUVdMzh0gmjX3IZqegIlGiDCxQqJbQMBLw5c89F59ptv1Ej0iHdqqpGaV
 4o0CF1OZYv70t7B7Mx3ordDpgiCpFNbPeQEBQMycz17gEySiOFGEQECjytr/NaDUEd22
 AGXlptUTPlPItTkMcQQPdEbL5okTovU1kvmYMF1fToj59hqL4zNdWyagbAYwldIYyTIU
 xMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765997996; x=1766602796;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPxnL1hILVAseREtLMBPs3ZiU0XdIuyPR4PAfuguluI=;
 b=v3VeKO8GwF0eP/XKXt5vVLv9lMW9522+XjpVH3yWd7kQQdY8HZN4HuVN3mHG4d5HRd
 PZzVQmRlmrcc8C3m2YAnpFvqtXPCFrtjRRxcU/hmQcA2XIr5rF0G9yDFj1jcTDpWwrUf
 ItjrR+15vgYdsjtSguKlSoiNRcJT15h6TaFIWNG1ZU6PQhWpwT85MTQs+9bx3fetAW0u
 olvZvPKT+wNkHpP5g0A7JcYiMtxsEfpFC2/oMeN+7n6O1lFZe2sFuRF82S32iV6i6dW7
 S0pXFnLmLpw+lOxebG6mAHcKO5yYdEYp50rpEWjSFvFyJuSM7Wjl2oEE4AlNs7fhrLLS
 GE5w==
X-Gm-Message-State: AOJu0Yz4vguTh7/srdYrfxzDGCY19QAYL4nx90cmvcM2vaiScxsMcys6
 YCGciWxOfAbATXlyNNCTWUts/LkRMWNB/MhTGbc+pxFYZlSjVJygidqedFrle3KJGnxhuYoDAY0
 tXIMuFQU=
X-Gm-Gg: AY/fxX4FBes6rHtd1cZcYF6jF8PqIxPhcaIuK3/vk1QLYLTz276yZyuC4qqQZ+kfF5J
 HqMx7U7hKgH37vUyZnPEHrCpzovRvnfoVThC4wG65/ZZWNI6MvycxacSzBfe/04InnzaMrvlP2X
 /O+XIT9Xuwczn3Iqcht4A3iA7pDQxEB1eCMVvswh5dcj/eajQnwbke5UmacOCPdvXhUcnwWaksb
 Mf96APJCjj1F2pRetPyeB4STdf6CvEtFhYB+/BfqEtXOrCrk3dFlN9zRT51yhR8ZeF7rdLw6skY
 XR+oBjhCjiLCqFz8mkK4t0vkAgBGqJazjO6y2cYvyJHjhc73HvqkLF5LajZllQUYUxbOvpNyUKU
 +uE2BEsYkZojo0PLPFJSrzmFfUhYJO0Y7yaUwUCvwNGyRj9waivzFj7bPwC/TS2KxemjsOWc+T6
 wXu+5+drozqy8ZsDQ98ufuRia6c5ZqCg==
X-Google-Smtp-Source: AGHT+IHaBp3zEeEPUaeFDBN5bb1F5tu/ka4Ue1MGeZB6ORr91bk121p+4M0nC8h2+bcY2IyOU3rzxw==
X-Received: by 2002:a17:90b:3a47:b0:340:d511:e167 with SMTP id
 98e67ed59e1d1-34abd5d38e2mr18256813a91.0.1765997996249; 
 Wed, 17 Dec 2025 10:59:56 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70dcc4dcsm290785a91.14.2025.12.17.10.59.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:59:55 -0800 (PST)
Message-ID: <3d66a681-1811-431a-9549-28ad985d0699@linaro.org>
Date: Thu, 18 Dec 2025 05:59:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/i386: Remove x86_stl_phys_notdirty() leftover
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
> ("target/i386: Use atomic operations for pte updates"), let's remove.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu.h    |  1 -
>   target/i386/helper.c | 10 ----------
>   2 files changed, 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


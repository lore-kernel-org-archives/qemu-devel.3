Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB011C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 18:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjMpq-0003cx-EU; Sat, 15 Feb 2025 13:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMpn-0003cf-Cz
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:24:11 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMpl-0001pu-Ch
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:24:11 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-221050f3f00so12356855ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739643847; x=1740248647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00MwxISFON973UfmPErVkRmXf6tS6H7O803nfq6hrZ8=;
 b=FdczA5eF7PNE1WHg4ZGmlsuoP/74AzvGeDjnNcH9twSXaSnuJ1MQPwXvFRdo6Tla4t
 +wWAwgu/7eC4HXPKlltlZMueSBGmJnx4ooSg70hx0801A82M8GN2PCfrircP7tjcESZ8
 Hq1IkiRZBYYU0DE+pcWRaF/SBkfTmOiJNl6I57i22qDP0IkxFIIY6Z1ha+Fh/A6KGfNU
 48w1ms/33fd0JKPEILYvciTGRmw0+9KwjmdyQc6Tv7bxWyAMz+IHyuab18a+ubom3bj1
 IYSOBKC+f8LuuHNJnmbtSvz0y8BjZjVCeHvkQnIl3+Z3YXsPeRNE7GgcybdV2F3Ae57Z
 2uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643847; x=1740248647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00MwxISFON973UfmPErVkRmXf6tS6H7O803nfq6hrZ8=;
 b=SHQOvtSoWaYKvQe3C2HR843hsx+Ods31IkJK6DxlTRpPILh86v1HFYAxt061jp3tLj
 e/yi+otBT5I2Ep/2HbAwn7DICobMPBJnxdFmGO0sejYTEWXTmVmNnWtk1ldSbgHMv+RG
 97Cq2+sI4T+XhetoLgBQBwI2Rbi9aK8LMbFq/hnD5Uch20fF+Yb4ZWKK/pNBFTvigG9F
 9SbxQ3rugCNyRyFQvAlBTOJQnnoety/UrvkozqtRh1zHJIK/4QYUHtTxNOEi3Zkci6BF
 16Bwub5wtsb2CbbUvOFdGfGWYeFvZqLPOCGRUhv+2WqGWmaL6tU5fOjcVuOvpt60lJw+
 k3rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVOPQmn4PGrQ5nhMh00BHJPzieUxfd71M4omfe+d2D7e4ZWpRgPwQ62vpQUJJGRU/Qs0kVCjE9A4ug@nongnu.org
X-Gm-Message-State: AOJu0Yzp2s48VGmz6B6oUELBzSNvVaxpGOzgPW/tUpabfFNsB3/+JxbD
 z1Sm1/vTvzpv7B2OUilMjtMgsp51ji2eKWPULv+f+lD7qNXgUt9WA1y5dbmG7pc=
X-Gm-Gg: ASbGncsRYbgtvCVDK+SPQVr1e99+HrhBuxrPn/k/2NtENkYyx0pnljnA23o1bph3IAd
 pE4A+8GFMCyBQuus5MJfX3Kh38yFOixj1bJ6nJeUOmMbfETJmQtO+t3O1I1vECcGwlmk1uuHL1Z
 Cy5+yUG33EfYhxsRhAHcqyJe+GtXa+4UI4D4nuj+f1+51cjtBs8Tp8R12yRiQxv0tQZwVlih70M
 tMFzuRqBJ4cWiJHadmWGn2eoy/NrZEbeztYFvqBQ2GtQ5qGvVnTnLQ9VT54U9QI+80q1ZV2scx1
 GMGSG0ZBSp4+ybb6py2MOYWX0CbwDslEaErFotzAw7WQE/Ww2RdghY8=
X-Google-Smtp-Source: AGHT+IHe95YDOmvpzFVDtzCQhiWxRvC5dTdphkqcfNSYSXyuMfCjg3yYD67ZK9ag2O09+jfl9hpgpg==
X-Received: by 2002:a17:903:283:b0:215:ae3d:1dd7 with SMTP id
 d9443c01a7336-221040269bbmr60175705ad.19.1739643847099; 
 Sat, 15 Feb 2025 10:24:07 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5584dccsm46215905ad.205.2025.02.15.10.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 10:24:06 -0800 (PST)
Message-ID: <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
Date: Sat, 15 Feb 2025 10:24:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/rx: Load reset vector from memory after first
 run
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-5-keithp@keithp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250215021654.1786679-5-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/14/25 18:16, Keith Packard via wrote:
> The ROM images all get deleted as they've been loaded to memory, so we
> can't go fetch the reset vector from there. Instead, fetch it from
> memory. To make that work, we need to execute the delayed mmu setup
> function tcg_commit_cpu as that wires up memory dispatching.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/rx/cpu.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)

IIRC this is where the cpu needs to be part of the 3-phase reset process.
ROM gets reset too, but with unspecified ordering wrt the cpu itself.
By delaying the load of the reset vector to the reset_exit phase,
you can always load from rom.

I believe Peter most recently handled a very similar situation with armv7m.


r~


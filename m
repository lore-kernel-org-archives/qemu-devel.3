Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9BEC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twQzZ-0005FF-NM; Sun, 23 Mar 2025 15:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQzV-0005EF-Bv
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:28:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twQzT-0007iO-Ke
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:28:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2255003f4c6so67572825ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758090; x=1743362890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k874A7awCV0W2Ydj0mIjddbFKT8kiobQ9PZe2gafaio=;
 b=FjpV4/axLEP4nhlYXpWEDKyyaljIUbxX6aYGX1MS8WmyDWZL42BqhR4EDpKXkt9mjG
 Az2hTkYfI4N5ocGKyvRcTrcvopHAhjxmcXwmt3DpQKru1S5C8lSdPXv4KjdBzJmGBYRG
 6qrLJzNrdA92EC7b/AIf2H+5T6tQo1cAaqmFBKEd5GLDsPaEb2UKKEVs4MyLXZL998qo
 WmxmC2msLe4HAb7ghdzez33qmbksEvSCtnn/DQN/PwKElU0iLCTMOZqdVU9q81UNq+1N
 5Vh3d1s1kqASO0Hd/mt9b1ddnAoTsMEy20a3rZfx9RIB9iWsQ01nL3khiFaVnnn//3Dr
 Jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758090; x=1743362890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k874A7awCV0W2Ydj0mIjddbFKT8kiobQ9PZe2gafaio=;
 b=u4rjjFM0J1tKbz5GOgY1QxbxIehyaiYnI5hBpG0JZtHOXXTMPmlJsHFlEpgvqQU/xU
 DJKbuy2n9zuPJdiAwMRBxzLBeB+LyVo1Kkdj1821mPQWyVShirEgVLv59FaUIUwaOuOD
 416mLFtBySuc5F5wnCUfUdQtIk9X6N3BkaW84ChfIdyQmJaNimEFvYkOt9Mq/WJyh2cD
 HbL94kKEUg94UUxXCklyKvha78kddoPqaGCZI2T4UtV82dca5DiAYZcwYouZggChj45I
 B9r5PpcIrsemSa5z4eX/RbowB374mcPMthGq0mB6m5c1sa7CV4pP4/8jP/KwFDsuOWvE
 N1pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX35wQn2UmRxnHB53Di+N1N32256JlbkClZzl16YwWppzJPuX/5vnaT23A6O2HztcnGIsojHVUNjOj4@nongnu.org
X-Gm-Message-State: AOJu0Yypf8N4tRM0GoYJp5J3rK5jx7mWcCUkaI+cDYyRVml7QQ60twrv
 qn5nIDGi5t+yNgi9CG0qh6bKQwgO44oK4vRjyDv4yPnZjWvv6VenJdtD4Gv1ubg=
X-Gm-Gg: ASbGncsfnOh8Ibw5Rz7hB3v/T84J7Cb3EAbEv29va4tWs0dIw390aUT5YzoRz0Bh+BX
 jxkv9gPrcXOqK4nkEKL2/PQr5MoewSpQeGIjs/DEROJhP/RSZ+x9BQIyy1Uqz5DaZIdHbQ88ytd
 PNtFFJxE5BOY0ZDpQBeSiW38v51ZYziYUOYrzxgRsfN/ej/tUlhvl/vdsvx8rQgq8naIKM7mAqK
 ubFPAmSFrpQpk5SSYWpUDQtVvgDtSoINJpy9aC0PrhEWnBr0RwOUYz2nr2VTcrzs1n2gKKmad4K
 yb6VUR6O6FYcQGaV5U2VNi1DiqYH90Lh2BDzt1abwZ+nduz9cxXoCaBnb4bvhKe5k34GQadD2tZ
 zpb7Hv78P
X-Google-Smtp-Source: AGHT+IGcnxhYb5NggH77kYiJNWz2MXC3uuzdnoOzrp4gOG0fkOpqkEDKVm3D3Tgc9B5jqbrgiwVAbQ==
X-Received: by 2002:a17:90b:2647:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-3030fe6a058mr13981930a91.6.1742758090161; 
 Sun, 23 Mar 2025 12:28:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf64aca3sm10427246a91.49.2025.03.23.12.28.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:28:09 -0700 (PDT)
Message-ID: <7296aa89-95d2-449c-b2ae-a9281d760fde@linaro.org>
Date: Sun, 23 Mar 2025 12:28:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/30] exec/cpu-all: extract tlb flags defines to
 exec/tlb-flags.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h               | 63 --------------------
>   include/exec/tlb-flags.h             | 87 ++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c                   |  1 +
>   accel/tcg/user-exec.c                |  1 +
>   semihosting/uaccess.c                |  1 +
>   target/arm/ptw.c                     |  1 +
>   target/arm/tcg/helper-a64.c          |  1 +
>   target/arm/tcg/mte_helper.c          |  1 +
>   target/arm/tcg/sve_helper.c          |  1 +
>   target/i386/tcg/system/excp_helper.c |  1 +
>   target/riscv/op_helper.c             |  1 +
>   target/riscv/vector_helper.c         |  1 +
>   target/s390x/tcg/mem_helper.c        |  1 +
>   target/sparc/mmu_helper.c            |  1 +
>   14 files changed, 99 insertions(+), 63 deletions(-)
>   create mode 100644 include/exec/tlb-flags.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


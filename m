Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD289C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGcq-0005nw-GA; Tue, 21 Jan 2025 10:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGcY-0005W7-6B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:56:54 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGcW-00026v-1k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:56:53 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so10022664a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475010; x=1738079810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qg+eMyl81WrVGGIzyuSGBmLQWgX+/+QpXEAprIteRMM=;
 b=mbw229uMVAVH2+Ds1TglhRkro7knGeI+QfjBYLIqLqElkJ1obzZ1NfiWLkXamGK9Ve
 T9DDvulg5RqB9FVqWLcJKTy8JQqzFEAHnqpv2RjfF2QcCVPzkM4vazlN1ij5KhUuAz3C
 be5pe94IhB/cfZCuQpkGktV7lWxPFWQ2EPoPhJ/P9qie07fi944sDMvYwP0U2xxjAV6U
 nlT4mzssiQBhO/L9g27Njtwm/4HhK9cFTlT5aoDOlN7qOxX4hRiPTXVzu8aMOMWDb9IZ
 uwD5n0V7Blh1haEo3koF+z2Pvce0TRKfqRVE4yRWZlap+gcBfxGLSgG7sRehMMs/VGB9
 ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475010; x=1738079810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qg+eMyl81WrVGGIzyuSGBmLQWgX+/+QpXEAprIteRMM=;
 b=Q59Rd9C4/WxkevvR89TTMpbvdjPUVUlbvPE7NBjoxHjTcFB5K2sqYzgm6DqfbrgbwY
 df9qQODGLau1TSDrQBMzI1JTSS8F4QGM9F528qNvq2/JWQ3sx6NnXacGrpVxnaExbfEg
 KCif1Eb10WsDl1MfWNNMbHdDtFuPjvKSFNwNiJa131aD5uvx67W8Cl44GKmzrXfRn12P
 6ra3Ha6Pyc328A8OqaevfbrgVNoUq5n1Y/IeTLbURkr0Mr1KMDQnc/CVQnrNEAY7Y9fF
 HTvWdu1Qbw05PjA6Xsq+TWn4aWdbdiAitHJ5DOT25y315j0NcMLUP54QGbxnX80Mw/xy
 yDnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrm58Phuy0cmhY008cGoePxTF2TRBHXLcCjjPLOHdhIJmxx4OSHBD5vpxKbwCO/ZcYBU35mzdGvNSD@nongnu.org
X-Gm-Message-State: AOJu0Yw8JonB0z7mjqUaH28X12/2uHr2/PF+4SFjMGWhcp31+ZTN3IwA
 s4Ou38AV/SNSCqPrRMSX9+/ToV30hLLgf6nlQfo4rQmBzR9y4oLF9tQZQhesj0g=
X-Gm-Gg: ASbGncvKEvcDQz7SiihTQ85ArSEOVBALdJqrvyOPBQsxk+dJ9OxrBRJxpB+IZjXAesT
 ZoDI5nI1lfRV8zi4nmGx+ECxBaP5NCo0NNAPz7EcrVLtb2Rg4siSnEN5L2yDTrEwEg65Lsdkuck
 WpCu5PUm6nJI3tJswGeDGUoNzqEpFT/rzgD5tjIKWFD04ElLesYDcL33OWVrcqpmZv1bBSQUez1
 Ge4M9lDA+gTjHAgWGYyNZi8Njgm+IAaqXMPf9rKaBbKfmdrmH/mn0vESAvKfRv9RWsSh2FyMU85
 Ck2d2Z+4pUCjBfIYhQAo6J35jCQA9lEugwGS
X-Google-Smtp-Source: AGHT+IH6J4jHo/2DuR1/IaLNHQEiJ+NFzD7gbhJO/IkSgTXbrsxE6zy+uKqW9eJTYUVAjWxRpL2UIg==
X-Received: by 2002:a05:6a00:2443:b0:726:c23f:4e5c with SMTP id
 d2e1a72fcca58-72daf9be6a8mr22642936b3a.1.1737475010374; 
 Tue, 21 Jan 2025 07:56:50 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bcbd5daa5sm9085935a12.18.2025.01.21.07.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:56:50 -0800 (PST)
Message-ID: <0404f7c8-c50b-4dc0-b65f-c00a95424334@linaro.org>
Date: Tue, 21 Jan 2025 07:56:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] accel: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/accel-target.c      | 12 +++++-------
>   accel/tcg/tcg-accel-ops.c |  3 +--
>   accel/tcg/translate-all.c |  2 +-
>   accel/tcg/watchpoint.c    |  9 ++++-----
>   4 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


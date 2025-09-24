Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1XBW-0006D5-M3; Wed, 24 Sep 2025 17:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1XBU-0006Ce-O2
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:37:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1XBN-0001NJ-Hn
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:37:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b55640a2e33so242102a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758749865; x=1759354665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QpJKYrqpl5/ULp5yHG2rA1X3a4wp6apvg1slx4xWAE=;
 b=vngny1NWofIr87Non9jzmg8Kn8YMxcUJ6OEL2KT1+x96buHW7kf/QsBBYUU5YdU4Og
 IrDK41zML/Ohexox4BtkAAPUKPYHPo5TIUtKNwZf5fr3wX+kDQewtSgwtu4wW8TAkig2
 UaYs0Wolxg4R2wN/noTNMHNTCNAgEVgt13Xy3JOjN8KEgV1T0SpYzwamhg5ES1bmFLzJ
 4E0mX0eK6EfClkxcm3oTq7/NGydfS8Nj+VUe19w6fYSqGTS8cJiqEWqp2qFx1Skg2FQq
 nM8UxmNYmAb9ArtYiZPni4xICI5J8GS/Yk1ApT5caR30oqrA4vsKrdwPin3/XtoNcFoY
 Iw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758749865; x=1759354665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QpJKYrqpl5/ULp5yHG2rA1X3a4wp6apvg1slx4xWAE=;
 b=j+setL1fQmhll7CVpSXr7hMjrgaUcD3KUDwNw+JKsmcxcppQUEfDjYBsPmLUxMYJhm
 Mrq0N8ZHpVupsOjttEPhNNPp8OAbizcLpC/ZvTx5SWhO2U0TsoxaNTZgC/oDYw2/l0d1
 tb0Vbs5R6Ziyg85sWIiVZpHPy4So52z+dFw/41R00PUzeVUd3zKUKDYCJUX1w3GLHeTu
 vmpl6MIaW3aPGkGdnf5nMSpdp/53GsdjB2GneKdRWY0NGD/MOba2uRG1tBF3rY5UITub
 jIsxy9sj+q817JE40IF3Pf8EN51Ckb8igew2vGuMXgKmsFwXbgdLHw2gxzBX7UqBn+m6
 RocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGAJ4RYSjbO+/W8PUFePNr/lxP2PsOlu9yTet4GSeijCapcrkraLJRV6osyeGdknoqys/rAUs3C5aq@nongnu.org
X-Gm-Message-State: AOJu0Yyy5Fho9GU3DVFEHNKtRoRCCZPJsFz0yhasqEiuan9rwoAU5znB
 oiLmHbvy5OjKj56Ewzl8y5y2mtEDZnkDCYpSS0PZ0mq4XxvpxMMzjxNY9tSWu5Z4/Kv7HX4Wvtj
 6jpMJ
X-Gm-Gg: ASbGncucwkY98w3JA4ndYDoVlIwRscOlrABJhdMPjwnin51/P+TMb1eAFaAsywlnIMd
 4s6yJgwR34yXNNDtvcmHx2bAslgJySsRdMjtNhIx0CdruWWjPzhTImVqGAcp1DNZe+hWo79KJ1y
 24oMXGkNU7RpQAztjB9kSIp9fvfCDsEnuTmtVBI2pwHF4HNRbfQcpLF++79McKzzqYDx/G1nRlb
 JaZNkTL23Fbt3zvMdUTC/rm9W3CLCQI3zEcgMTsR+wBFA+MmMOFUhMl1XYgfv7wBUc99UOjc9qk
 VgUhvC8/k1VF9V0t2gGPkMhgHkNh+aOMykBnimEGyI1tyakFmfza5IBfnSn37uwCeE+xRoHTa7/
 8S17OzhD7q6PisY2MpyPmQflT9xwjXlI5uzcC
X-Google-Smtp-Source: AGHT+IH2KhBiv36whfTwEx//GX2ZV3PPqbitpCOtZFXmx0zxJQff5XWuGjya5pr1P8G/t9EuX8NasA==
X-Received: by 2002:a17:902:ebc8:b0:271:6af4:15c with SMTP id
 d9443c01a7336-27ed4a91a97mr13813075ad.36.1758749865110; 
 Wed, 24 Sep 2025 14:37:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be148e8sm3425602a91.16.2025.09.24.14.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:37:44 -0700 (PDT)
Message-ID: <d78f6956-0800-4a7f-9cc0-7c2d9935dc3e@linaro.org>
Date: Wed, 24 Sep 2025 14:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/34] target/riscv: Fix size of mcause
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924072124.6493-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 9/24/25 00:20, Anton Johansson via wrote:
> and update formatting in logs.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     | 2 +-
>   target/riscv/machine.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

There is no updating of logs.  Incorrectly split patch?
Cut and paste error on the commit message?

r~

> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c8d34f3ac..32e30a36ac 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -323,7 +323,7 @@ struct CPUArchState {
>   
>       uint64_t mtvec;
>       uint64_t mepc;
> -    target_ulong mcause;
> +    uint64_t mcause;
>       uint64_t mtval;  /* since: priv-1.10.0 */
>   
>       uint64_t mctrctl;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index f42be027e3..438c44dbb0 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -442,7 +442,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINT64(env.scause, RISCVCPU),
>           VMSTATE_UINT64(env.mtvec, RISCVCPU),
>           VMSTATE_UINT64(env.mepc, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcause, RISCVCPU),
> +        VMSTATE_UINT64(env.mcause, RISCVCPU),
>           VMSTATE_UINT64(env.mtval, RISCVCPU),
>           VMSTATE_UINTTL(env.miselect, RISCVCPU),
>           VMSTATE_UINTTL(env.siselect, RISCVCPU),



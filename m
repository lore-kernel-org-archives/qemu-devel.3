Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F74FC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 22:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnPfs-00032W-RO; Wed, 26 Feb 2025 17:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPfq-00032I-EZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:14:39 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnPfo-0004C2-DM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 17:14:38 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f3ee8a119so123871f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740608074; x=1741212874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=evuguMRLWNJd2muB8mtwVlZ9rx/rullpOMd47lDJqkM=;
 b=jKOZe7QBGPzk5nam7aYRNAWRC255fq9bHZdbJZK9jHfThHJxMDaDMHx1UD+CwbbyIO
 8Hnx9NOY7sXEnyKf8gfuI8zNvHCUbU78ZE19MEPov7uAZnoJSWb8E/F/skAkNnbuOx0U
 0rK/J5Q4ororoY0rbbsbk7os1sariGNgoI0++dzbiwHb2SwcQgvpjUhsngO2Ym2d9m8S
 sNu3pOwwewlURU9NF5bHv+1nvC9NGSlIVnhe1F2FLhSR6SXC5TGI5i95Ai8S647VoDMd
 UKSSO6Gv76Kee9s5NRKxpNDOckDEfp/GJGfqcWWFiTge0akXrVg45IviW+S3cwe4DBDm
 Bx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608074; x=1741212874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evuguMRLWNJd2muB8mtwVlZ9rx/rullpOMd47lDJqkM=;
 b=LUqr7Zgpcy+JcCJ3i7ZKp9aqxXhuSavc0a2sCnTjk7Ih5Pcqg4MZX2jm1oLQryWVjl
 pfl7txLfRK2j47LKLIhkxF3x3OekGjk/J7ZbPrD43ggi2EboggXGHyBGuQqkZKTodCys
 cUW9PcmiEAwdgBuimq/Wfh0Br5NtrosYgWtDEV1EUg/hl+Y2dlRpZpIuQvyEZcoOLfeF
 y6RUiuV800peUkbKSJ/A9WuQhPJTfAWGHuxTlJf7rxqsXqSX+9Bjoj8eIXRmRqrYS465
 LoFXQofzPRQbYoWMUSOKmujrC+QSQI0XN2i7eswYPTxABH9XE1xNS3m4ybAGh5dtXGN2
 PPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrhIx2/InbAq7065VaQFXNHdG3/exceDo6lLonD2SoXFf2L2NpjjRFJ0+yQFfedZ8jQjz22Gqcdgej@nongnu.org
X-Gm-Message-State: AOJu0Yxj8BP5zFt0XsqPD/rMhREHhENvPX4omTKFGTQXrqIzFC+RDDrj
 wFahpcncQte6mnhI+JU5Cf41ojyLI1zHTySpq21uq+N7fONPmJvIGO4BsxgrBaY=
X-Gm-Gg: ASbGnctlLm1u2JKaHwu9a5M8qOrR9SssKsRe08YVoniRxqsTCti4AP8xEiW59fx3IC8
 52k0/PKu0QXX3PLAOoWYjWVp5oHNMmmY8XjR6wqat4vvuxKp/WdhoPvFtVG9aHs+iAkPiF8m4u3
 m6fDV6qu70eOap1UbtXO8gXM82HqjliVM/PwIUh/QCWYESgBNhaTCqKDpgWBirpoBvU9iIbNaj2
 gnPnCFSPU5XxoiaCyr6/aQu6xsi9Ds/+hmnpopj0nC/jK6A2szxolVW0lsd98rcVLAssAEsAJyN
 cbmA8Aq9RVWzORlml6Ass0QMH8HP3zg5SADCbhJvROBr3Flfbwge8P9G8LBnMx+gXCnJwg==
X-Google-Smtp-Source: AGHT+IE8NjTpZ1+Pb3O6HgCpKWt1LEt5WCadMg8kiDJlsshYkq1oI/R4LRvgdoK5vw3ngeOoUDU2DQ==
X-Received: by 2002:a05:6000:884:b0:38b:da31:3e3e with SMTP id
 ffacd0b85a97d-38f707a9cefmr16067883f8f.28.1740608074033; 
 Wed, 26 Feb 2025 14:14:34 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484451fsm111235f8f.63.2025.02.26.14.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:14:33 -0800 (PST)
Message-ID: <0b054b48-dd37-4b43-8e1d-e25006f021d7@linaro.org>
Date: Wed, 26 Feb 2025 23:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 025/162] tcg: Convert nor to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     |  4 ++--
>   tcg/tcg.c                        |  8 ++++----
>   tcg/tci.c                        |  2 --
>   tcg/aarch64/tcg-target.c.inc     |  4 ++++
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc | 20 +++++++++++---------
>   tcg/mips/tcg-target.c.inc        | 17 +++++++++++------
>   tcg/ppc/tcg-target.c.inc         | 18 +++++++++++-------
>   tcg/riscv/tcg-target.c.inc       |  4 ++++
>   tcg/s390x/tcg-target.c.inc       | 28 ++++++++++++++++------------
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target.c.inc         | 14 +++++++++++---
>   24 files changed, 86 insertions(+), 65 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



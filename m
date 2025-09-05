Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BEECA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQiE-00078u-OK; Fri, 05 Sep 2025 03:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuQiD-00078W-B3
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:18:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuQiA-0004k0-ED
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:18:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b87bc67a4so12821615e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757056695; x=1757661495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1rZnXyYQeXsor6QbFERTM6stkUtc/K583rwP288en0=;
 b=cSfvPqURcJ94X6CG9lQR2qJKF6s+sbQaZhZ/Y1wBoQMcYDmtlmFQGkeBJKMWsbZInC
 JftMrYaLh9uTx3ZHgo+dUmHlodq0T9OQwHZsigrc0NRRAlJCpwVKKDsX6FnnaSlLM6Co
 2u19LzbolxZxu2hR3Yje8T+ue0Qh2gbBO5ruV2iP8u0+sBbxtAobIIp6T4R8cKvyh98r
 DOOhmnRHtZ7pEtwHUrz5rkayUA4MID58hGdcU6SBZ77xp/zetRn9YLaANL2AyYK9ZOHq
 5bwT6veRzzwh7+Ue8Wq+tmBABqgxaPCEoxZjUL0hZi1iuRu2dx20J7uIDlrH619YPLNL
 qLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757056695; x=1757661495;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1rZnXyYQeXsor6QbFERTM6stkUtc/K583rwP288en0=;
 b=V7dDOP+oB+9tm6nIE9sqX0WqPrrmnWYVTfjtVrwcZ6qmg1ZWADWyDOOwtlikBW3CNV
 DhZVu2Lf8VxNtpckSJ12tE6YuDlm/nbs/h4YwYS+Dd70+B1v4HqYMyDplSAN8zwUbZGJ
 0S5N5e1yuAky9FapxZtwrAyctSn1gQWh0WO6T0DEHH2vR8wU6uIIzpqa/YiP9/sUEKj4
 htQ492VrmVFgDndfFfmIRjNmi3etNTSyie3+lh9ZgNMRDkbcdzdnTaixrP604f10nLep
 9PqVleT2kSN7e7Ok6wSOe2kI1UckSiFL0JkFsp9bB6XOhomCu7bsqpG0hqAFqAnph4o5
 k+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgt+Q9uu1bGRecLhuPVA0HyexARcD2EFjalEcaeAINMtBrPpmdnJ6HoHsv35I1uF9cH4VNhhx2aL46@nongnu.org
X-Gm-Message-State: AOJu0YyMsUqudCy1oLb2UGzBJ1pFoWEULWQri0TDFbBwp8bWgTIQC99T
 2/3HiuSGox4bbHqyb0SqRaep+SKW0aAN34WD+/paBub+v/Bb8Op+SkBQEeg/EJjHuhE=
X-Gm-Gg: ASbGncur+FrJalwTHdoU6nd1Onded/zYu+98dPgLMKm0qrdcOWiG1jjzKImAIqaYiKj
 yh+UEBUbCnKukmuO7B+lneB3iIjEjieb+N5gRGx5PC4ren3KZYVI3VSh7Qpp0oDekAWknfa9uws
 WY5CTG/zBctZB0Einso4eejGnjkdKzErzmN6sFGhmsgfxdhrJUQ9vec9bsaMG/ckwabMCJysXJA
 35ZK57d8//p24CRvnF35gdmeJ2yedLYlA3MqE8xizJ3D5+cUnu6/58Flrpb94tc7CgncfLic9dF
 MGa1o4VF3Wu2lUSt6Ix1qlqdEPqXIOqCGbGGPxQYshubdyuPFfgm4riZ3Vb412Tway7XOhWPqFs
 hGqlFr7dhcQJruz+0z05TQFgfGZ64alwffKJPKSG+sxcvjg4=
X-Google-Smtp-Source: AGHT+IFsiNRYrUhXGkqlIeuwPRqxCctEpllByJe1vtxFe3OqCQbWssqiIs5M2dDWZ0VKwoG25ez3ZA==
X-Received: by 2002:a05:600c:a44:b0:45b:72a9:28b0 with SMTP id
 5b1f17b1804b1-45b8557d227mr184174905e9.28.1757056695580; 
 Fri, 05 Sep 2025 00:18:15 -0700 (PDT)
Received: from [10.175.133.6] ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd07480d5sm32393185e9.8.2025.09.05.00.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 00:18:15 -0700 (PDT)
Message-ID: <188f0525-154e-4d08-a155-68e8800e302d@linaro.org>
Date: Fri, 5 Sep 2025 09:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250903030114.274535-1-npiggin@gmail.com>
 <20250903030114.274535-3-npiggin@gmail.com>
 <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
 <qyikdqxxiewb7tqykt74gpx5oereckbepyptd3vr4flptmrvoc@midnt5c7agnc>
 <3dd9888f-be16-48f8-a858-f58a5b57825d@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <3dd9888f-be16-48f8-a858-f58a5b57825d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/4/25 13:06, Daniel Henrique Barboza wrote:
> How hard it is to update the GCC version we're running in the docker images for
> "check-tcg"? We would like to use a RISC-V vector header that isn't supported
> ATM.
If debian packages the gcc version, then it's easy: change

   gcc-riscv-linux-gnu

to

   gcc-NN-riscv-linux-gnu

If the version isn't packaged, then it's harder, and we would need to either build our own 
gcc within the container (see dockerfiles/debian-microblaze-cross.d/build-toolchain.sh), 
or you can host a pre-built version somewhere (see dockerfiles/debian-loongarch-cross.docker).


r~

